defmodule App.Structs.FileSystem do
  @moduledoc """
  FileSystem struct module
  """
  alias App.Structs.{
    FSStruct,
    Logger,
    SSHConn
  }

  @doc "Return a new struct for given params"
  def new(user, host, port, dir) do
    validate_param!(user)
    validate_param!(host)
    validate_param!(dir)
    validate_port!(port)
    validate_conn!(user, host, port, dir)

    %FSStruct{user: user, host: host, port: port, dir: dir}
  end

  defp validate_port!(port) do
    port = String.to_integer(port)
    case is_number(port) && (port in 1..64738) do
      true -> :ok
      false ->
        port = 22
    end
  end

  defp validate_param!(param) do
    case param do
      true -> :ok
      false ->
        raise FileSystem.InvalidData, message: "Invalid #{param} for FileSystem"
    end
  end

  defp validate_conn!(user, host, port, dir) do
    case SSHConn.validate_conn(user, host, port, dir) do
      true -> :ok
      false ->
        raise FileSystem.InvalidData, message: "Error while trying to connect to provided host"
    end
  end

end
