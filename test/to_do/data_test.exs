defmodule ToDo.DataTest do
  use ExUnit.Case, async: true
  doctest ToDo.Data

  setup do
    {:ok, agent} = TaskAgent.start_link
    {:ok, agent: agent}
  end

  test "reads data from provided file into the TaskAgent" do
    filename = "test/data.csv"

    ToDo.Data.load_from_file(filename, ?|)

    users = ToDo.TaskAgent.users()
    assert length(users) == 3
    assert Enum.member? users, "alice"
    assert Enum.member? users, "bob"
    assert Enum.member? users, "claire"

    claire_dates = ToDo.TaskAgent.user_tasks("claire")
    assert length(Map.keys(claire_dates)) == 2
    assert Map.has_key? claire_dates, "2016-09-10"
    assert Map.has_key? claire_dates, "2016-09-11"

    tenth_tasks = ToDo.TaskAgent.tasks_by_date("claire", "2016-09-10")
    assert Set.size(tenth_tasks) == 2
    assert Set.member? tenth_tasks, "Go to the movies"
    assert Set.member? tenth_tasks, "Clean room"
  end
end

