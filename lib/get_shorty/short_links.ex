defmodule GetShorty.ShortLinks do
  @moduledoc """
  The ShortLinks context.
  """

  import Ecto.Query, warn: false
  alias GetShorty.Repo

  alias GetShorty.ShortLinks.ShortLink

  @doc """
  Returns the list of short_links.

  ## Examples

      iex> list_short_links()
      [%ShortLink{}, ...]

  """
  def list_short_links do
    Repo.all(ShortLink)
  end

  @doc """
  Gets a single short_link.

  Raises `Ecto.NoResultsError` if the Short link does not exist.

  ## Examples

      iex> get_short_link!(123)
      %ShortLink{}

      iex> get_short_link!(456)
      ** (Ecto.NoResultsError)

  """
  def get_short_link!(id), do: Repo.get!(ShortLink, id)

  @doc """
  Creates a short_link.

  ## Examples

      iex> create_short_link(%{field: value})
      {:ok, %ShortLink{}}

      iex> create_short_link(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_short_link(attrs \\ %{}) do
    %ShortLink{}
    |> ShortLink.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a short_link.

  ## Examples

      iex> update_short_link(short_link, %{field: new_value})
      {:ok, %ShortLink{}}

      iex> update_short_link(short_link, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_short_link(%ShortLink{} = short_link, attrs) do
    short_link
    |> ShortLink.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a short_link.

  ## Examples

      iex> delete_short_link(short_link)
      {:ok, %ShortLink{}}

      iex> delete_short_link(short_link)
      {:error, %Ecto.Changeset{}}

  """
  def delete_short_link(%ShortLink{} = short_link) do
    Repo.delete(short_link)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking short_link changes.

  ## Examples

      iex> change_short_link(short_link)
      %Ecto.Changeset{data: %ShortLink{}}

  """
  def change_short_link(%ShortLink{} = short_link, attrs \\ %{}) do
    ShortLink.changeset(short_link, attrs)
  end
end
