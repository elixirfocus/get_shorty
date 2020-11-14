defmodule GetShorty.LinkRecords do
  @moduledoc """
  The LinkRecords context.
  """

  import Ecto.Query, warn: false
  alias GetShorty.Repo

  alias GetShorty.LinkRecords.LinkRecord

  @doc """
  Returns the list of link_records.

  ## Examples

      iex> list_link_records()
      [%LinkRecord{}, ...]

  """
  def list_link_records do
    Repo.all(LinkRecord)
  end

  @doc """
  Gets a single link_record.

  Raises `Ecto.NoResultsError` if the Link record does not exist.

  ## Examples

      iex> get_link_record!(123)
      %LinkRecord{}

      iex> get_link_record!(456)
      ** (Ecto.NoResultsError)

  """
  def get_link_record!(id), do: Repo.get!(LinkRecord, id)

  @doc """
  Creates a link_record.

  ## Examples

      iex> create_link_record(%{field: value})
      {:ok, %LinkRecord{}}

      iex> create_link_record(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_link_record(attrs \\ %{}) do
    %LinkRecord{}
    |> LinkRecord.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a link_record.

  ## Examples

      iex> update_link_record(link_record, %{field: new_value})
      {:ok, %LinkRecord{}}

      iex> update_link_record(link_record, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_link_record(%LinkRecord{} = link_record, attrs) do
    link_record
    |> LinkRecord.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a link_record.

  ## Examples

      iex> delete_link_record(link_record)
      {:ok, %LinkRecord{}}

      iex> delete_link_record(link_record)
      {:error, %Ecto.Changeset{}}

  """
  def delete_link_record(%LinkRecord{} = link_record) do
    Repo.delete(link_record)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking link_record changes.

  ## Examples

      iex> change_link_record(link_record)
      %Ecto.Changeset{data: %LinkRecord{}}

  """
  def change_link_record(%LinkRecord{} = link_record, attrs \\ %{}) do
    LinkRecord.changeset(link_record, attrs)
  end
end
