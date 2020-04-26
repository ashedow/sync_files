defmodule App.Monitor.Protocol do
  @moduledoc """
  Use SSH (for now) to connect to hosts
  """
  require App.Scripts.Logger

  def connect(host) do
    Logger.info("Trying to connect to #{host}")
  end

end
