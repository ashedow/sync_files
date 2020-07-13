alias App.Structs.FileSystem

defmodule App.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @doc """
  Start app endpoint
  """
  def start(_type, _args) do
    {src, dest}
    opts = [
      source: FileSystem(source, src),
      destination: FileSystem(destination, dest)
    ]
    # children = [
    # Starts a worker by calling: App.Worker.start_link(arg)
      # {App.Worker, arg}
    # ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: App.Supervisor]
    worker(App.Monitor.Worker, [])
    Supervisor.start_link(children, opts)
  end

end
