defmodule App.Struct.FileSystem.FileSizeValidator do

  alias App.Data.FileData
  alias App.Struct.FileSystem.Options
  alias App.Interactions.Source

  @doc """
  validate file data
  """
  def valid?(file_data = %FileData{}, %Source{ opts: opts = %Options{}}) do
    file_data
    |> find_full_path(opts)
    |> opts.file_system.stat
    |> compare(file_data)
  end

  @doc """
  Find full path to file in the file system
  """
  defp find_full_path(file_data, opts) do
    Path.join(opts.directory, file_data.name)
  end

  @doc """
  check file size
  """
  defp compare({:ok, %{size: size}}, file_data) do
    case file_data.size == size do
      true -> {:ok, file_data}
      _ -> {:error, "#{file_data.name} failed file size validator: " <>
                    "expected #{file_data.size} but found as #{size}"}
    end
  end

  defp compare({:error, reason}, file_data) do
    {:error, "#{file_data.name} failed file size validator: received #{reason}"}
  end
end
