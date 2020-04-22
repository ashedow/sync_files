defmodule App.FlatFiles do
  @moduledoc """
  Module for get all files
  Copied from http://www.thegreatcodeadventure.com/elixir-tricks-building-a-recursive-function-to-list-all-files-in-a-directory/
  """

  def list_all(filepath) do
      _list_all(filepath)
  end

  defp _list_all(filepath) do
      cond do
      String.contains?(filepath, ".git") -> []
      true -> expand(File.ls(filepath), filepath)
      end
  end

  defp expand({:ok, files}, path) do
      files
      |> Enum.flat_map(&_list_all("#{path}/#{&1}"))
  end

  defp expand({:error, _}, path) do
      [path]
  end
end
