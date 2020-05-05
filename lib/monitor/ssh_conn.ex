defmodule App.Monitor.SSHConn do
  @moduledoc """
  Ssh connector
  """

  @doc """
  Check that ssh connection avaliable
  """
  def validate_conn(host, user, port, dir) do
    with {:ok, conn} = SSH.connect!(host, port,
        user: user |> to_charlist(),
        # user_dir: Path.join(System.user_home!(), ".ssh") |> to_charlist(),
        :this_task
      ),
         {:ok, _result1, 0} <- SSH.run(conn, "cd #{dir} && touch tmp"),
         {:ok, result2, 0} <- SSH.run(conn, "rm tmp") do
      {:ok, result1}
    end
  after
    SSH.close(:this_task)
  end

end
