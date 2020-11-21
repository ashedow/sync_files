defmodule App.Scripts.Validation do
  @moduledoc """
  Validate fuction
  """

  alias App.Monitor.SSHConn
  require App.Scripts.Logger

  @doc """
  Validate that iput host are correct and avaliable
  """
  def validate_input_host(host) do
    host
    |> to_sruct
    |> SSHConn.validate_conn
    host
  end

  defp to_sruct(host) do
    port = SyncFiles.fetch_env!(:app, :ssh_port)
    parced_host_map = Regex.named_captures(~r/(?<name>[-\w\d_]*)@(?<host>[-\w\d.]*):(?<port>[\d]*):(?<dir>[-\w\d.\/]+)/, host)
  end

end
