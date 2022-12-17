defmodule HnydewApi.Repo.Migrations.AddFamilyAndUserToTask do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      add :user_id, references(:users, foreign_key: :user_id, type: :uuid)
      add :family_id, references(:families, foreign_key: :family_id, type: :uuid)
    end
  end
end
