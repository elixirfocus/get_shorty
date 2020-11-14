defmodule GetShorty.LinkRecords.LinkRecord do
  use Ecto.Schema
  import Ecto.Changeset

  schema "link_records" do
    field :target_url, :string
    field :token, :string

    timestamps()
  end

  @doc false
  def changeset(link_record, attrs) do
    link_record
    |> cast(attrs, [:target_url, :token])
    |> validate_required([:target_url, :token])
    |> unique_constraint(:token)
  end
end
