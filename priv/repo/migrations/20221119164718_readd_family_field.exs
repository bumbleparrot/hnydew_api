defmodule HnydewApi.Repo.Migrations.ReaddFamilyField do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    alter table(:tasks) do
      add :family, :uuid, null: false
    end

  end
end
