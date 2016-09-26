defmodule TaskAgent do
  @moduledoc """
  Asynchronous store of all user tasks.
  """

  @name __MODULE__

  ##
  # External API

  def start_link(),
  do: Agent.start_link(fn -> %{} end, name: @name)

  @doc """
  Gets a list of all known users currently in the system.
  """
  @spec users() :: [String.t]
  def users(),
  do: Agent.get(@name, &Map.keys/1)

  @doc """
  Gets a map of all tasks for a given `user`.
  """
  @spec user_tasks(String.t) :: %{String.t => MapSet.t}
  def user_tasks(user),
  do: Agent.get(@name, fn map -> get_in(map, [user]) end)

  @doc """
  Gets a list of all tasks for a given `user` on the provided `date`.
  """
  @spec tasks_by_date(String.t, String.t) :: MapSet.t | nil
  def tasks_by_date(user, date),
  do: Agent.get(@name, fn map -> get_in(map, [user, date]) end)

  @doc """
  Adds a new task.
  """
  @spec add_task(String.t, String.t, String.t) :: :ok
  def add_task(user, date, task),
  do: Agent.update(@name, &do_add_task(&1, user, date, task))

  ##
  # Internal implementations

  defp do_add_task(map, user, date, task) do
    cond do
      _tasks = get_in(map, [user, date]) ->
        update_in(map, [user, date], &(MapSet.put(&1, task)))
      _dates = get_in(map, [user]) ->
        update_in(map, [user], &(Map.put_new(&1, date, MapSet.new([task]))))
      true ->
        Map.put_new(map, user, %{date => MapSet.new([task])})
    end
  end
end
