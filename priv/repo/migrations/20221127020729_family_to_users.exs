defmodule HnydewApi.Repo.Migrations.FamilyToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :family_id, references(:families, foreign_key: :family_id, type: :uuid)
    end
  end
end
