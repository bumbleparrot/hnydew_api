defmodule HnydewApi.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "tasks" do
    field :family, :string
    field :description, :string

    timestamps()
  end

  @doc """
  Some documentation about task chamgesets.
  Tasks should be family wide with no individual owner. This is becuase everyone
  in a family can do a tasks
  """

  def create_task_changeset(task, attrs) do
    task
    |> cast(attrs, [:family, :description])
    |> validate_required([:family, :description])
    |> validate_length(:description, max: 256, min: 3, count: :bytes)
  end


end
