defmodule App.CLI do
  @moduledoc """
  CLI Interface for running app.
  Gets hosts from command line.
  Secrets should be passed throu ENV or like ssh key.

  ## Example
  HOST="home@192.168.0.10://shared_dir" DEST="storage@192.168.0.11://dest_dir" NOTIFY="my@my.me"
  """
  require App.Scripts.Logger
  alias App.Scripts.{
    ReadConfig,
    Validation
  }
  alias App.Structs.FileSystem
  # alias App.Monitor.Protocol

  @doc """
  Main App.CLI runner.
  Parse command line args and run app.
  """
  def main(args \\ []) do
    args
    |> parse_args
    |> process
    |> validate
    |> run
  end

  @args """
  usage:
  app --help
  app --src --dest
  """
  defp parse_args(args) do
    switches = [
      help: :boolean,
      src: :string,
      dest: :string
    ]
    aliases = [h: :help]
    cmd_opts =
      args
      |> OptionParser.parse(switches: switches, aliases: aliases)
    case cmd_opts do
      { [ help: true], _, _ }
          -> :help

      { [src: src, dest: dest], _, _}
        -> {src, dest}

      {[], [], []}
        -> []

      _ ->
        :error
    end
  end

  @doc """
  Parse args from command line or|and env and run app.
  """
  def process([]) do
    src = ReadConfig.read_config(Application.get_env(:app, :src))
    dest = ReadConfig.read_config(Application.get_env(:app, :dest))
    {src, dest}
  end

  def process(:help) do
    IO.puts """
    Usage:
    ./app --src <src@host:/dir> --dest <dest@host:/dir>
    Options:
    --help or -h     Show this help message.
    --src  Host and dir where to get data
    --dest  Host and dir where to put data

    Also you can pass all arg as environment variables.
    """
  end

  def process({src, dest}) do
    {src, dest}
  end

  @doc """
  Validate provided source and destination hosts
  Check (for now) ssh keys
  """
  def validate({src, dest}) do
    host_list = Tuple.to_list({src, dest})
    parced_hosts = Enum.map(host_list, fn x -> Validation.validate_input_host(x) end)
    parced_hosts
  end

  def run({options,args}) do
    Logger.info("Starting with Host: #{src} Directory: #{dest}")
    SyncFiles.start
  end

end
