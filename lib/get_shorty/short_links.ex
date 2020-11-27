defmodule GetShorty.ShortLinks do
  @moduledoc """
  Provides functions related to managing `ShortLink` entities.
  """

  import Ecto.Query, warn: false
  import Ecto.Changeset

  alias GetShorty.Repo
  alias GetShorty.ShortLinks.ShortLink

  @doc """
  Returns the list of `ShortLink`s.
  """
  @spec list_short_links() :: list(ShortLink.t())
  def list_short_links do
    Repo.all(ShortLink)
  end

  @doc """
  Attempts to find and return a single `ShortLink`.
  Raises `Ecto.NoResultsError` if the `ShortLink` does not exist.
  """
  @spec get_short_link!(integer()) :: ShortLink.t()
  def get_short_link!(id) do
    Repo.get!(ShortLink, id)
  end

  @doc """
  Attempts to create a `ShortLink` given a map of attributes.
  """
  @spec create_short_link(map() | nil) :: {:ok, ShortLink.t()} | {:error, Ecto.Changeset.t()}
  def create_short_link(attrs \\ %{}) do
    %ShortLink{}
    |> change_short_link(attrs)
    |> Repo.insert()
  end

  @doc """
  Attempts to updates a `ShortLink` with a given map of attributes.
  """
  @spec update_short_link(ShortLink.t(), map()) ::
          {:ok, ShortLink.t()} | {:error, Ecto.Changeset.t()}
  def update_short_link(%ShortLink{} = short_link, attrs) do
    short_link
    |> change_short_link(attrs)
    |> Repo.update()
  end

  @doc """
  Attempts to delete a `ShortLink`.

  If the incoming `ShortLink` has no primary key, Ecto.NoPrimaryKeyValueError will be raised. If the `ShortLink` has been removed from db prior to call, Ecto.StaleEntryError will be raised.

  Returns {:ok, %ShortLink{}} if the `ShortLink` has been successfully deleted or {:error, changeset} if there was a validation or a known constraint error.
  """
  @spec delete_short_link(ShortLink.t()) :: {:ok, ShortLink.t()} | {:error, Ecto.Changeset.t()}
  def delete_short_link(%ShortLink{} = short_link) do
    Repo.delete(short_link)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking `ShortLink` changes.
  """
  @spec change_short_link(%ShortLink{}, any() | nil) :: Ecto.Changeset.t(%ShortLink{})
  def change_short_link(%ShortLink{} = short_link, attrs \\ %{}) do
    changeset(short_link, attrs)
  end

  @spec changeset(%ShortLink{}, map()) :: Ecto.Changeset.t(%ShortLink{})
  defp changeset(short_link, attrs) do
    short_link
    |> cast(attrs, [:long_link, :token])
    |> validate_required([:long_link, :token])
    |> unique_constraint(:token)
  end
end
