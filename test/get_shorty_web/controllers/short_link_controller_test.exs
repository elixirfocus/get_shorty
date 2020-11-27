defmodule GetShortyWeb.ShortLinkControllerTest do
  use GetShortyWeb.ConnCase

  alias GetShorty.ShortLinks

  @create_attrs %{long_link: "some long_link", token: "some token"}
  @update_attrs %{long_link: "some updated long_link", token: "some updated token"}
  @invalid_attrs %{long_link: nil, token: nil}

  def fixture(:short_link) do
    {:ok, short_link} = ShortLinks.create_short_link(@create_attrs)
    short_link
  end

  describe "index" do
    test "lists all short_links", %{conn: conn} do
      conn = get(conn, Routes.short_link_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Short links"
    end
  end

  describe "new short_link" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.short_link_path(conn, :new))
      assert html_response(conn, 200) =~ "New Short link"
    end
  end

  describe "create short_link" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.short_link_path(conn, :create), short_link: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.short_link_path(conn, :show, id)

      conn = get(conn, Routes.short_link_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Short link"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.short_link_path(conn, :create), short_link: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Short link"
    end
  end

  describe "edit short_link" do
    setup [:create_short_link]

    test "renders form for editing chosen short_link", %{conn: conn, short_link: short_link} do
      conn = get(conn, Routes.short_link_path(conn, :edit, short_link))
      assert html_response(conn, 200) =~ "Edit Short link"
    end
  end

  describe "update short_link" do
    setup [:create_short_link]

    test "redirects when data is valid", %{conn: conn, short_link: short_link} do
      conn = put(conn, Routes.short_link_path(conn, :update, short_link), short_link: @update_attrs)
      assert redirected_to(conn) == Routes.short_link_path(conn, :show, short_link)

      conn = get(conn, Routes.short_link_path(conn, :show, short_link))
      assert html_response(conn, 200) =~ "some updated long_link"
    end

    test "renders errors when data is invalid", %{conn: conn, short_link: short_link} do
      conn = put(conn, Routes.short_link_path(conn, :update, short_link), short_link: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Short link"
    end
  end

  describe "delete short_link" do
    setup [:create_short_link]

    test "deletes chosen short_link", %{conn: conn, short_link: short_link} do
      conn = delete(conn, Routes.short_link_path(conn, :delete, short_link))
      assert redirected_to(conn) == Routes.short_link_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.short_link_path(conn, :show, short_link))
      end
    end
  end

  defp create_short_link(_) do
    short_link = fixture(:short_link)
    %{short_link: short_link}
  end
end
