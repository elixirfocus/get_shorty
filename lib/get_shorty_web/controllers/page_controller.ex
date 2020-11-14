defmodule GetShortyWeb.PageController do
  use GetShortyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
