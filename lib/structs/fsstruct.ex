defmodule App.Structs.FSStruct do
  @enforce_keys [:user, :host, :port, :dir]

  defstruct @enforce_keys
end
