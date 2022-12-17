defmodule HnydewApiWeb.TaskController do
  use HnydewApiWeb, :controller

  alias HnydewApi.Tasks
  alias HnydewApiWeb.Error

  def index(conn, _params) do
    tasks = Tasks.list_tasks()
    render(conn, "index.json", tasks: tasks)
  end

  def create(conn, %{"task" => task_params}) do
    case Tasks.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_view(HnydewApiWeb.TaskView)
        |> render("show.json", task: task)

      {:error, changeset} ->
        errors = Error.translate_error(changeset)
        conn
        |> put_view(HnydewApiWeb.ErrorView)
        |> render("index.json", errors: errors)
    end

    # with {:ok, %Task{} = task} <- Tasks.create_task(task_params) do
    #   conn
    #   |> put_status(:created)
    #   |> put_resp_header("location", Routes.task_path(conn, :show, task))
    #   |> render("show.json", task: task)
    # end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task(id)
    render(conn, "show.json", task: task)
  end
end
