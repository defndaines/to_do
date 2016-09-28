defmodule ToDo.API do
  use Maru.Router # alias ToDo.TaskAgent, as: Store

  namespace :users do
    get do
      json(conn, ToDo.TaskAgent.users())
    end

    route_param :id do
      get do
        json(conn, ToDo.TaskAgent.user_tasks(params[:id]))
      end
    end
  end

  def error(conn, e) do
    json(conn, %{error: e})
  end
end
