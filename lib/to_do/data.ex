defmodule ToDo.Data do
  @moduledoc """
  Utilities for extracting tasks from a "CSV" file.
  """

  ##
  # External API

  @doc """
  Convert file into a list of maps containing task data.
  """
  def parse_data(file, separator) do
    File.stream!(file)
    |> CSV.decode(separator: separator, headers: true)
    |> Enum.to_list()
  end
end
