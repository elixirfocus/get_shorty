defmodule GetShortyWeb.ShortLinkController do
  use GetShortyWeb, :controller

  alias GetShorty.ShortLinks
  alias GetShorty.ShortLinks.ShortLink

  def index(conn, _params) do
    short_links = ShortLinks.list_short_links()
    render(conn, "index.html", short_links: short_links)
  end

  def new(conn, _params) do
    changeset = ShortLinks.change_short_link(%ShortLink{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"short_link" => short_link_params}) do
    case ShortLinks.create_short_link(short_link_params) do
      {:ok, short_link} ->
        conn
        |> put_flash(:info, "Short link created successfully.")
        |> redirect(to: Routes.short_link_path(conn, :show, short_link))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    short_link = ShortLinks.get_short_link!(id)
    render(conn, "show.html", short_link: short_link)
  end

  def edit(conn, %{"id" => id}) do
    short_link = ShortLinks.get_short_link!(id)
    changeset = ShortLinks.change_short_link(short_link)
    render(conn, "edit.html", short_link: short_link, changeset: changeset)
  end

  def update(conn, %{"id" => id, "short_link" => short_link_params}) do
    short_link = ShortLinks.get_short_link!(id)

    case ShortLinks.update_short_link(short_link, short_link_params) do
      {:ok, short_link} ->
        conn
        |> put_flash(:info, "Short link updated successfully.")
        |> redirect(to: Routes.short_link_path(conn, :show, short_link))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", short_link: short_link, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    short_link = ShortLinks.get_short_link!(id)
    {:ok, _short_link} = ShortLinks.delete_short_link(short_link)

    conn
    |> put_flash(:info, "Short link deleted successfully.")
    |> redirect(to: Routes.short_link_path(conn, :index))
  end
end
