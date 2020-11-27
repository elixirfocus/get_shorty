defmodule GetShorty.Repo.Migrations.CreateShortLinks do
  use Ecto.Migration

  def change do
    create table(:short_links) do
      add :long_link, :string
      add :token, :string

      timestamps()
    end

    create unique_index(:short_links, [:token])
  end
end
