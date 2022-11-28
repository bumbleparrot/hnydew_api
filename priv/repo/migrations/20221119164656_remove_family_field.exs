defmodule HnydewApi.Repo.Migrations.RemoveFamilyField do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    alter table(:tasks) do
      remove :family
    end
  end
end
