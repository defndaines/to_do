defmodule ToDo.DataTest do
  use ExUnit.Case, async: true
  doctest ToDo.Data

  test "reads provided file" do
    filename = "test/data.csv"

    data = ToDo.Data.parse_data(filename, ?|)

    assert length(data) == 7
    first_task = List.first(data)
    assert first_task["user"] == "alice"
    assert first_task["date"] == "2016-09-08"
    assert first_task["task"] == "Buy some milk"

    last_task = List.last(data)
    assert last_task["user"] == "claire"
    assert last_task["date"] == "2016-09-11"
    assert last_task["task"] == "Call mom"
  end
end

