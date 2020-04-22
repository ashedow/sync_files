alias App.Structs.{
  FileSystem,
  DestFileSystem
}

defmodule App.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    ## TODO move trying getting param from env into cli module
    source = Application.fetch_env!(:app, :source)
    destination = Application.fetch_env!(:app, :destination)

    opts = [
      source: build_host(source),
      destination: build_host(destination)
    ]

    # link = App.start_link(opts)
    children = [
    # Starts a worker by calling: App.Worker.start_link(arg)
    # {App.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: App.Supervisor]
    Supervisor.start_link(children, opts)
  end


  defp build_host(host) do
    source_map[host[:host]].build_source(host)
  end

  defp source_map do
    %{
      src: FileSystem,
      dest: FileSystem
    }
  end

end
