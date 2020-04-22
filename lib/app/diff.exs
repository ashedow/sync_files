defmodule App.Diff do
  @moduledoc """
  Temporary implementation.
  Should work like rsync's keys --itemize-changes --checksum
  """

  # @doc """
  # Compares two dirs to match difference.
  # """
  # def calculate_diff(source_data, target_data) do
  #   get_matched_pairs(source_data,target_data)
  #   |> warn_on_unmached_contacts(source_data)
  #   |> get_diffs
  # end
  # efp get_matched_pairs(source_data, target_data) do
  #   target_data
  #   |> Enum.map(&match_source_item(&1, source_data))
  #     #filter out :no_match and get rid of :ok tuple element
  #   |> Enum.filter_map(&(elem(&1,0)==:ok),&(elem(&1,1)))
  # end

  # defp match_source_item(target_item, source_data) do
  #   source_item = Enum.find(source_data, &User.match?(&1, target_item))
  #   case source_item do
  #     nil ->
  #       Logger.error("AD user #{target_item.email}: no matching public folder contact found.")
  #       {:no_match, target_item.email}
  #     item ->
  #       Logger.debug("AD user #{target_item.email}: found match in public folder.")
  #       {:ok, {source_item, target_item}}
  #   end
  # end

  # defp get_diffs(pairs) do
  #   pairs
  #   |> Enum.map(&User.check_pair_for_diffs/1)
  #   |> Enum.filter(&(elem(&1,0) == :diff))
  # end

  # defp warn_on_unmached_contacts(pairs, source_data) do
  #   Enum.each(source_data, &warn_if_unmatched(pairs, &1))
  #   pairs
  # end

  # defp warn_if_unmatched(pairs, contact) do
  #   case Enum.any?(pairs, &User.match?(elem(&1,0), contact)) do
  #     true -> pairs
  #     false ->
  #       Logger.warn("Contact #{contact.email} does not exist in AD")
  #       pairs
  #   end

  # end

end
