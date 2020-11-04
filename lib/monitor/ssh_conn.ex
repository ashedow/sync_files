defmodule App.Monitor.SSHConn do
  @moduledoc """
  Ssh connector
  """

  @doc """
  Check that ssh connection avaliable
  """
  def validate_conn(host, user, port, dir) do
    :ssh.start()
    {:ok, conn} = :ssh.connect(host, port,
      silently_accept_hosts: true,
      user: user |> to_charlist(),
      user_dir: Path.join(System.user_home!(), ".ssh") |> to_charlist(),
      user_interaction: false
    )
    {:ok, chan} = :ssh_connection.session_channel(conn, :infinity)
    :success = :ssh_connection.exec(conn, chan, "cd #{dir} && touch tmp", :infinity)
    for _ <- 0..3 do
      receive do
        {:ssh_cm, ^conn, value} -> IO.inspect(value)
      end
    end
    :ok = :ssh.close(conn)
  end

end
