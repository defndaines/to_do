defmodule ToDo.Data do
  @moduledoc """
  Utilities for extracting tasks from a "CSV" file.
  """

  ##
  # External API

  @doc """
  Load tasks into the TaskAgent from a `file` with records separated by `separator`.
  """
  def load_from_file(file, separator) do
    File.stream!(file)
    |> CSV.decode(separator: separator, headers: true)
    |> Enum.each(&load_task/1)
  end

  ##
  # Internal implementations

  defp load_task(%{"user" => user, "date" => date, "task" => task}) do
    ToDo.TaskAgent.add_task(user, date, task)
  end
end
