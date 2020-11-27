defmodule GetShorty.ShortLinks.ShortLink do
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          __meta__: Ecto.Schema.Metadata.t(),
          id: integer(),
          inserted_at: DateTime.t(),
          long_link: String.t(),
          token: String.t(),
          updated_at: DateTime.t()
        }

  schema "short_links" do
    field :long_link, :string
    field :token, :string

    timestamps()
  end

  @doc false
  def changeset(short_link, attrs) do
    short_link
    |> cast(attrs, [:long_link, :token])
    |> validate_required([:long_link, :token])
    |> unique_constraint(:token)
  end
end
