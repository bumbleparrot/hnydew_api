defmodule HnydewApi.Tasks do
    @moduledoc """
    The Tasks context.
    """

    import Ecto.Query, warn: false
    alias HnydewApi.Repo
    alias HnydewApi.Tasks.{Task}

    def list_tasks() do
      Repo.all(Task)
    end

    def create_task(attrs) do
      %Task{}
      |> Task.create_task_changeset(attrs)
      |> Ecto.Changeset.foreign_key_constraint(:user_id)
      |> Ecto.Changeset.foreign_key_constraint(:family_id)
      |> Repo.insert()
    end

    def get_task(id) do
      Repo.get(Task, id)
    end

    def get_tasks_by_user_id(user_id) do
      q = from s in Task, where: s.user_id == ^user_id, select: s
      Repo.all(q)
    end

    def get_tasks_by_family_id(family_id) do
      Task
      |> where(family_id: ^family_id)
      |> Repo.all()
    end
end
