defmodule GetShortyWeb.ShortLinkController do
  use GetShortyWeb, :controller

  alias GetShorty.ShortLinks
  alias GetShorty.ShortLinks.ShortLink

  def new(conn, _params) do
    changeset = ShortLinks.change_short_link(%ShortLink{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"short_link" => %{"long_link" => long_link}}) do
    token = ShortLinks.get_available_random_token()

    short_link_params = %{
      "long_link" => long_link,
      "token" => token
    }

    case ShortLinks.create_short_link(short_link_params) do
      {:ok, short_link} ->
        conn
        |> put_flash(:info, "Short link created successfully.")
        |> redirect(to: Routes.short_link_path(conn, :show, short_link.token))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def send(conn, %{"token" => token}) do
    case ShortLinks.get_short_link_by_token(token) do
      {:ok, short_link} ->
        redirect(conn, external: short_link.long_link)

      {:error, :not_found} ->
        conn
        |> put_status(404)
        |> put_view(GetShortyWeb.ErrorView)
        |> render("404.html")
    end
  end

  def show(conn, %{"token" => token}) do
    case ShortLinks.get_short_link_by_token(token) do
      {:ok, short_link} ->
        conn
        |> assign(:short_link_url, build_short_link_url(conn, short_link))
        |> assign(:short_link, short_link)
        |> render("show.html")

      {:error, :not_found} ->
        conn
        |> put_status(404)
        |> put_view(GetShortyWeb.ErrorView)
        |> render("404.html")
    end
  end

  defp build_short_link_url(conn, %ShortLink{} = short_link) do
    Routes.url(conn) <> "/#{short_link.token}"
  end
end
