defmodule GetShortyWeb.LinkRecordController do
  use GetShortyWeb, :controller

  alias GetShorty.LinkRecords
  alias GetShorty.LinkRecords.LinkRecord

  def index(conn, _params) do
    link_records = LinkRecords.list_link_records()
    render(conn, "index.html", link_records: link_records)
  end

  def new(conn, _params) do
    changeset = LinkRecords.change_link_record(%LinkRecord{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"link_record" => link_record_params}) do
    case LinkRecords.create_link_record(link_record_params) do
      {:ok, link_record} ->
        conn
        |> put_flash(:info, "Link record created successfully.")
        |> redirect(to: Routes.link_record_path(conn, :show, link_record))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    link_record = LinkRecords.get_link_record!(id)
    render(conn, "show.html", link_record: link_record)
  end

  def edit(conn, %{"id" => id}) do
    link_record = LinkRecords.get_link_record!(id)
    changeset = LinkRecords.change_link_record(link_record)
    render(conn, "edit.html", link_record: link_record, changeset: changeset)
  end

  def update(conn, %{"id" => id, "link_record" => link_record_params}) do
    link_record = LinkRecords.get_link_record!(id)

    case LinkRecords.update_link_record(link_record, link_record_params) do
      {:ok, link_record} ->
        conn
        |> put_flash(:info, "Link record updated successfully.")
        |> redirect(to: Routes.link_record_path(conn, :show, link_record))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", link_record: link_record, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    link_record = LinkRecords.get_link_record!(id)
    {:ok, _link_record} = LinkRecords.delete_link_record(link_record)

    conn
    |> put_flash(:info, "Link record deleted successfully.")
    |> redirect(to: Routes.link_record_path(conn, :index))
  end
end
