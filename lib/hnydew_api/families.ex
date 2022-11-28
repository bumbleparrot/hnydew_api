defmodule HnydewApi.Families do
  @moduledoc """
  The Families context.
  """

  import Ecto.Query, warn: false
  alias HnydewApi.Repo
  alias HnydewApi.Families.{Family}

  ## Family creation

  @spec create_family(any) :: any
  @doc """
  Create a family.

  ## Examples

      iex> create_family(%{field: value})
      {:ok, %Family{}}

      iex> create_family(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_family(attrs) do
    %Family{}
    |> Family.create_changeset(attrs)
    |> Repo.insert()
  end

  def list_families() do
    query = from u in Family
    Repo.all(query)
  end

  def get_family(id) do
    Repo.get(Family, id)
  end

  def get_family_and_users(id) do
    Repo.get(Family, id)
    |> Repo.preload([:users])
  end

  def update_family_name(family, attrs) do
    family
    |> Family.name_changeset(attrs)
    |> Repo.update()
  end

  def generate_new_unique_code(family) do
    family
    |> Family.unique_code_changeset()
    |> Repo.update()
  end
end
