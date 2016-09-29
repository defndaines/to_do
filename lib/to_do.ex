defmodule ToDo do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      worker(ToDo.TaskAgent, [])
    ]

    opts = [strategy: :one_for_one, name: ToDo.Supervisor]
    state = Supervisor.start_link(children, opts)

    ToDo.Data.load_from_file("test/data.csv", ?|)

    state
  end
end
