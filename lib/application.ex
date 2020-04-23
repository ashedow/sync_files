alias App.Structs.{
  FileSystem,
  TypedFileSystem
}

defmodule App.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @doc """
  Start app endpoint
  """
  def start(_type, _args) do
    opts = [
      source: build_source(src),
      destination: build_target(dest)
    ]

    # link = App.start_link(opts)
    children = [
    # Starts a worker by calling: App.Worker.start_link(arg)
      {App.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: App.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp build_source(source) do
    source_map[source[:source]].build_source(source)
  end

  defp build_target(target) do
    source_map[target[:source]].build_target(target)
  end

  defp source_map do
    %{
      source: FileSystem,
      destination: FileSystem
    }
  end

end
