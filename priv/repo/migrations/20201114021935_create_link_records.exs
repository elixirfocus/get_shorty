defmodule GetShorty.Repo.Migrations.CreateLinkRecords do
  use Ecto.Migration

  def change do
    create table(:link_records) do
      add :target_url, :string
      add :token, :string

      timestamps()
    end

    create unique_index(:link_records, [:token])
  end
end
