defmodule TaskAgentTest do
  use ExUnit.Case, async: true
  doctest TaskAgent

  setup do
    {:ok, agent} = TaskAgent.start_link
    {:ok, agent: agent}
  end

  test "stores new task" do
    assert TaskAgent.users() == []
    user = "alice"
    date = "2016-09-25"
    task = "Buy milk"

    TaskAgent.add_task(user, date, task)

    assert TaskAgent.users() == [user]
    assert Map.has_key? TaskAgent.user_tasks(user), date
    assert Enum.member? TaskAgent.tasks_by_date(user, date), task
  end

  test "doesn't add duplicate tasks" do
    assert TaskAgent.users() == []
    user = "alice"
    date = "2016-09-25"
    task = "Buy milk"

    TaskAgent.add_task(user, date, task)
    TaskAgent.add_task(user, date, task)

    assert Enum.count(TaskAgent.tasks_by_date(user, date)) == 1
  end

  test "appends to existing list for same date" do
    assert TaskAgent.users() == []
    user = "alice"
    date = "2016-09-25"
    task_1 = "Buy milk"
    task_2 = "Change lightbulb"

    TaskAgent.add_task(user, date, task_1)
    TaskAgent.add_task(user, date, task_2)

    tasks = TaskAgent.tasks_by_date(user, date)
    assert Enum.count(tasks) == 2
    assert Enum.member? tasks, task_1
    assert Enum.member? tasks, task_2
  end

  test "different dates can be added" do
    assert TaskAgent.users() == []
    user = "alice"
    date_1 = "2016-09-25"
    date_2 = "2016-09-26"
    task = "Buy milk"

    TaskAgent.add_task(user, date_1, task)
    TaskAgent.add_task(user, date_2, task)

    tasks = TaskAgent.user_tasks(user)
    assert Enum.count(tasks) == 2
    assert Map.has_key? tasks, date_1
    assert Map.has_key? tasks, date_2
  end

  test "multiple users can store tasks" do
    assert TaskAgent.users() == []
    user_1 = "alice"
    user_2 = "claire"
    date = "2016-09-25"
    task = "Buy milk"

    TaskAgent.add_task(user_1, date, task)
    TaskAgent.add_task(user_2, date, task)

    users = TaskAgent.users()
    assert Enum.count(users) == 2
    assert Enum.member? users, user_1
    assert Enum.member? users, user_2
  end
end
