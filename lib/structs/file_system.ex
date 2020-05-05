defmodule App.Structs.FileSystem do
  @moduledoc """
  FileSystem struct module
  """

  require App.Scripts.Logger
  require App.Monitor.SSHConn

  @enforce_keys [:user, :host, :port, :dir]

  defstruct @enforce_keys

  @doc "Return a new struct for given params"
  def new(user, host, port, dir) do
    validate_param!(user)
    validate_param!(host)
    validate_param!(dir)
    validate_port!(port)
    validate_conn!(user, host, port, dir)

    %FileSystem{user: user, host: host, port: port, dir: dir}
  end

  @doc """
  Check port and set default otherwise
  """
  defp validate_port!(port) do
    port = String.to_integer(port)
    case is_number(port) && (port n in 1..64738) do
      true -> :ok
      false ->
        port = 22
    end
  end

  @doc """
  Check param and raise if not
  """
  defp validate_param!(param) do
    case param do
      true -> :ok
      false ->
        raise FileSystem.InvalidData, message: "Invalid #{param} for FileSystem"
    end
  end

  @doc """
  Raise error if can't connect with params
  """
  defp validate_conn!(user, host, port, dir) do
    case SSHConn.validate_conn(user, host, port, dir) do
      true -> :ok
      false ->
        raise FileSystem.InvalidData, message: "Error while trying to connect to provided host"
    end
  end

end
