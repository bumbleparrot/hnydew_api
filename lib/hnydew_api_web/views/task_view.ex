defmodule HnydewApiWeb.TaskView do
  use HnydewApiWeb, :view
  alias HnydewApiWeb.TaskView

  def render("index.json", %{tasks: tasks}) do
    %{data: render_many(tasks, TaskView, "task.json")}
  end

  def render("show.json", %{task: task}) do
    %{data: render_one(task, TaskView, "task.json")}
  end

  def render("task.json", %{task: task}) do
    %{
      id: task.id,
      description: task.description,
      family_id: task.family_id,
      user_id: task.user_id
    }
  end

end
