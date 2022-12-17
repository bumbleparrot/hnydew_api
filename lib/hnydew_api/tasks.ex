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
end
