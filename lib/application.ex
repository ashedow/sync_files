alias App.Structs.FileSystem

defmodule SyncFiles do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @doc """
  Start app endpoint
  """
  def start(_type, _args) do

    src = Application.get_env(:sync_files, :src)
    dest = Application.get_env(:sync_files, :dest)

    opts = [
      source: build_path(src),
      destination: build_path(dest)
    ]
    # children = [
    # Starts a worker by calling: App.Worker.start_link(arg)
      # {App.Worker, arg}
    # ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    # opts = [strategy: :one_for_one, name: App.Supervisor]
    # worker(App.Monitor.Worker, [])
    Supervisor.start_link(children, opts)
  end

  defp build_path(path) do
    FileSystem.new(path)
  end

end
