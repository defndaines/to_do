defmodule ToDo do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      worker(ToDo.TaskAgent, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ToDo.Supervisor]
    state = Supervisor.start_link(children, opts)

    data = ToDo.Data.parse_data("test/data.csv", ?|)
    for task <- data,
      do: ToDo.TaskAgent.add_task(task["user"], task["date"], task["task"])

    state
  end
end
