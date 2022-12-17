defmodule HnydewApi.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "tasks" do
    field :description, :string

    belongs_to :user, HnydewApi.Accounts.User
    belongs_to :family, HnydewApi.Families.Family

    timestamps()
  end

  @doc """
  Some documentation about task chamgesets.
  Tasks should be family wide with no individual owner. This is becuase everyone
  in a family can do a tasks
  """

  def create_task_changeset(task, attrs) do
    task
    |> cast(attrs, [:user_id, :family_id, :description])
    |> validate_required([:user_id, :family_id, :description])
    |> validate_length(:description, max: 256, min: 3, count: :bytes)
  end


end
