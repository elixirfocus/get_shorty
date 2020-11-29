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
      assert Floki.find(html, "button[type=submit]") |> Floki.text() == "Create Short Link"
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

      assert Floki.find(html, ".alert") |> Floki.text() ==
               "Could not create short link. See errors below."

      assert Floki.find(html, "span[phx-feedback-for=short_link_long_link]") |> Floki.text() ==
               "can't be blank"
    end

    test "fails when url does not begin with http:// or https://", %{conn: conn} do
      payload = %{"short_link" => %{"long_link" => "example.com"}}

      {:ok, html} =
        conn
        |> post(Routes.short_link_path(conn, :new), payload)
        |> html_response(200)
        |> Floki.parse_document()

      assert Floki.find(html, ".alert") |> Floki.text() ==
               "Could not create short link. See errors below."

      assert Floki.find(html, "span[phx-feedback-for=short_link_long_link]") |> Floki.text() ==
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

      assert Floki.find(html, ".test_short_link_url") |> Floki.text() ==
               "http://localhost:4002/#{token}"

      assert Floki.find(html, ".test_long_link") |> Floki.text() ==
               "It will redirect to: #{long_link}"
    end

    test "renders 404 when given a unknown token", %{conn: conn} do
      conn = get(conn, Routes.short_link_path(conn, :show, "bogus123"))

      assert html_response(conn, 404) =~ "Not Found"
    end
  end

  # @create_attrs %{long_link: "some long_link", token: "some token"}
  # @update_attrs %{long_link: "some updated long_link", token: "some updated token"}
  # @invalid_attrs %{long_link: nil, token: nil}

  # def fixture(:short_link) do
  #   {:ok, short_link} = ShortLinks.create_short_link(@create_attrs)
  #   short_link
  # end

  # describe "index" do
  #   test "lists all short_links", %{conn: conn} do
  #     conn = get(conn, Routes.short_link_path(conn, :index))
  #     assert html_response(conn, 200) =~ "Listing Short links"
  #   end
  # end

  # describe "new short_link" do
  #   test "renders form", %{conn: conn} do
  #     conn = get(conn, Routes.short_link_path(conn, :new))
  #     assert html_response(conn, 200) =~ "New Short link"
  #   end
  # end

  # describe "create short_link" do
  #   test "redirects to show when data is valid", %{conn: conn} do
  #     conn = post(conn, Routes.short_link_path(conn, :create), short_link: @create_attrs)

  #     assert %{id: id} = redirected_params(conn)
  #     assert redirected_to(conn) == Routes.short_link_path(conn, :show, id)

  #     conn = get(conn, Routes.short_link_path(conn, :show, id))
  #     assert html_response(conn, 200) =~ "Show Short link"
  #   end

  #   test "renders errors when data is invalid", %{conn: conn} do
  #     conn = post(conn, Routes.short_link_path(conn, :create), short_link: @invalid_attrs)
  #     assert html_response(conn, 200) =~ "New Short link"
  #   end
  # end

  # describe "edit short_link" do
  #   setup [:create_short_link]

  #   test "renders form for editing chosen short_link", %{conn: conn, short_link: short_link} do
  #     conn = get(conn, Routes.short_link_path(conn, :edit, short_link))
  #     assert html_response(conn, 200) =~ "Edit Short link"
  #   end
  # end

  # describe "update short_link" do
  #   setup [:create_short_link]

  #   test "redirects when data is valid", %{conn: conn, short_link: short_link} do
  #     conn = put(conn, Routes.short_link_path(conn, :update, short_link), short_link: @update_attrs)
  #     assert redirected_to(conn) == Routes.short_link_path(conn, :show, short_link)

  #     conn = get(conn, Routes.short_link_path(conn, :show, short_link))
  #     assert html_response(conn, 200) =~ "some updated long_link"
  #   end

  #   test "renders errors when data is invalid", %{conn: conn, short_link: short_link} do
  #     conn = put(conn, Routes.short_link_path(conn, :update, short_link), short_link: @invalid_attrs)
  #     assert html_response(conn, 200) =~ "Edit Short link"
  #   end
  # end

  # describe "delete short_link" do
  #   setup [:create_short_link]

  #   test "deletes chosen short_link", %{conn: conn, short_link: short_link} do
  #     conn = delete(conn, Routes.short_link_path(conn, :delete, short_link))
  #     assert redirected_to(conn) == Routes.short_link_path(conn, :index)
  #     assert_error_sent 404, fn ->
  #       get(conn, Routes.short_link_path(conn, :show, short_link))
  #     end
  #   end
  # end

  # defp create_short_link(_) do
  #   short_link = fixture(:short_link)
  #   %{short_link: short_link}
  # end
end
