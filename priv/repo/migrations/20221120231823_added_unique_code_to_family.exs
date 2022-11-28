defmodule HnydewApi.Repo.Migrations.AddedUniqueCodeToFamily do
  use Ecto.Migration

  def change do
    alter table(:families) do
      add :uniqueCode, :string, null: false
    end
  end
end
