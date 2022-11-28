defmodule HnydewApi.Repo.Migrations.CreateFamilies do
  use Ecto.Migration

  def change do
    create table(:families, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :name, :string

      timestamps()
    end
  end
end
