defmodule GetShorty.ShortLinks.ShortLink do
  use Ecto.Schema

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
end
