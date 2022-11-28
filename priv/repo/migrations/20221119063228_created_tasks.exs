defmodule HnydewApi.Repo.Migrations.CreatedTasks do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    create table(:tasks, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :family, :string, null: false
      add :description, :string, null: false
      timestamps()
    end
  end
end
