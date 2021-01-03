defmodule GetShortyWeb.ShortLinkControllerTest do
  use GetShortyWeb.ConnCase

  alias GetShorty.ShortLinks.ShortLink

  describe "new/2" do
    test "renders form as expected", %{conn: conn} do
      {:ok, html} =
        conn
        |> get(Routes.short_link_path(conn, :new))
        |> html_response(200)
        |> Floki.parse_document()

      assert [{"input", _, _}] = Floki.find(html, "#short_link_long_link")
      assert html |> Floki.find("button[type=submit]") |> Floki.text() == "Create Short Link"
    end
  end

  describe "create/2" do
    test "works when valid long link is submitted", %{conn: conn} do
      payload = %{"short_link" => %{"long_link" => "https://example.com/test?abc=123"}}
      conn = post(conn, Routes.short_link_path(conn, :new), payload)
      assert html_response(conn, 302) =~ "redirected</a>"
      assert get_flash(conn, "info") == "Short link created successfully."
    end

    test "fails when empty long link is submitted", %{conn: conn} do
      payload = %{"short_link" => %{"long_link" => ""}}

      {:ok, html} =
        conn
        |> post(Routes.short_link_path(conn, :new), payload)
        |> html_response(200)
        |> Floki.parse_document()

      assert html |> Floki.find(".alert") |> Floki.text() ==
               "Could not create short link. See errors below."

      assert html |> Floki.find("span[phx-feedback-for=short_link_long_link]") |> Floki.text() ==
               "can't be blank"
    end

    test "fails when url does not begin with http:// or https://", %{conn: conn} do
      payload = %{"short_link" => %{"long_link" => "example.com"}}

      {:ok, html} =
        conn
        |> post(Routes.short_link_path(conn, :new), payload)
        |> html_response(200)
        |> Floki.parse_document()

      assert html |> Floki.find(".alert") |> Floki.text() ==
               "Could not create short link. See errors below."

      assert html |> Floki.find("span[phx-feedback-for=short_link_long_link]") |> Floki.text() ==
               "is not a valid url"
    end
  end

  describe "send/2" do
    test "redirects to long link when given a stored token", %{conn: conn} do
      short_link = insert(:short_link, long_link: "https://test.com")
      conn = get(conn, Routes.short_link_path(conn, :send, short_link.token))

      assert html_response(conn, 302) =~
               "You are being <a href=\"https://test.com\">redirected</a>"
    end

    test "renders 404 when given a unknown token", %{conn: conn} do
      conn = get(conn, Routes.short_link_path(conn, :send, "bogus123"))

      assert html_response(conn, 404) =~ "Not Found"
    end
  end

  describe "show/2" do
    test "render details when given a stored token", %{conn: conn} do
      %ShortLink{long_link: long_link, token: token} =
        insert(:short_link, long_link: "https://test.com")

      {:ok, html} =
        conn
        |> get(Routes.short_link_path(conn, :show, token))
        |> html_response(200)
        |> Floki.parse_document()

      assert html |> Floki.find(".floki-short-link-url") |> Floki.text() ==
               "http://localhost:4002/#{token}"

      assert html |> Floki.find(".floki-test-long-link") |> Floki.text() ==
               "It will redirect to: #{long_link}"
    end

    test "renders 404 when given a unknown token", %{conn: conn} do
      conn = get(conn, Routes.short_link_path(conn, :show, "bogus123"))

      assert html_response(conn, 404) =~ "Not Found"
    end
  end
end
