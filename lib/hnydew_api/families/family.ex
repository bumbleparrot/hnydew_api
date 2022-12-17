defmodule HnydewApi.Families.Family do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "families" do
    field :name, :string
    field :uniqueCode, :string

    has_many :users, HnydewApi.Accounts.User
    has_many :tasks, HnydewApi.Tasks.Task
    timestamps()
  end

  @spec create_changeset(
          {map, map}
          | %{
              :__struct__ => atom | %{:__changeset__ => map, optional(any) => any},
              optional(atom) => any
            },
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  @doc false
  def create_changeset(family, attrs) do
    family = %{family | :uniqueCode => generate_family_uniqueCode()}
    family
    |> cast(attrs, [:name])
    |> validate_required([:name, :uniqueCode])
    |> validate_name()
  end

  @spec validate_name(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  def validate_name(attrs) do
    attrs
    |> validate_length(:name, min: 2, max: 256)
  end

  def name_changeset(family, attrs) do
    family
    |> cast(attrs, [:name])
    |> validate_required([:name, :uniqueCode])
    |> validate_name()
    |> case do
      %{changes: %{name: _}} = changeset -> changeset
      %{} = changeset -> add_error(changeset, :name, "did not change")
    end
  end

  def unique_code_changeset(family) do
    attrs = %{:uniqueCode => generate_family_uniqueCode()}
    family
    |> cast(attrs, [:uniqueCode])
  end

  defp generate_family_uniqueCode() do
    Enum.random(0..999999)
    |> Integer.to_string
    |> String.pad_leading(6, "0")
  end
end
