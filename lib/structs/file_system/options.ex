defmodule App.Structs.FileSystem.Options do
  @moduledoc """
  Define Struct for filesystem type
  """

  @doc """
  Struct for filesystem
  :params:
    directory - Base path of source's directory
    io - IO module
    file_system - File module
  """
  defstruct [
    :directory,
    io: IO,
    file_system: File,
  ]
end
