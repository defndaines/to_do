defmodule ToDo.API do
  use Maru.Router # alias ToDo.TaskAgent, as: Store

  @moduledoc """
  Defines the routes supported by this application.
  """

  namespace :users do
    get do
      json(conn, ToDo.TaskAgent.users())
    end

    route_param :id do
      get do
        json(conn, ToDo.TaskAgent.user_tasks(params[:id]))
      end

      namespace :tasks do
        route_param :date do
          get do
            json(conn, ToDo.TaskAgent.tasks_by_date(params[:id], params[:date]))
          end
        end
      end
    end
  end

  def error(conn, e) do
    json(conn, %{error: e})
  end
end
