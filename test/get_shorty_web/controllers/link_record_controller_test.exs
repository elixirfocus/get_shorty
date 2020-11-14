defmodule GetShortyWeb.LinkRecordControllerTest do
  use GetShortyWeb.ConnCase

  alias GetShorty.LinkRecords

  @create_attrs %{target_url: "some target_url", token: "some token"}
  @update_attrs %{target_url: "some updated target_url", token: "some updated token"}
  @invalid_attrs %{target_url: nil, token: nil}

  def fixture(:link_record) do
    {:ok, link_record} = LinkRecords.create_link_record(@create_attrs)
    link_record
  end

  describe "index" do
    test "lists all link_records", %{conn: conn} do
      conn = get(conn, Routes.link_record_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Link records"
    end
  end

  describe "new link_record" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.link_record_path(conn, :new))
      assert html_response(conn, 200) =~ "New Link record"
    end
  end

  describe "create link_record" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.link_record_path(conn, :create), link_record: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.link_record_path(conn, :show, id)

      conn = get(conn, Routes.link_record_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Link record"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.link_record_path(conn, :create), link_record: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Link record"
    end
  end

  describe "edit link_record" do
    setup [:create_link_record]

    test "renders form for editing chosen link_record", %{conn: conn, link_record: link_record} do
      conn = get(conn, Routes.link_record_path(conn, :edit, link_record))
      assert html_response(conn, 200) =~ "Edit Link record"
    end
  end

  describe "update link_record" do
    setup [:create_link_record]

    test "redirects when data is valid", %{conn: conn, link_record: link_record} do
      conn = put(conn, Routes.link_record_path(conn, :update, link_record), link_record: @update_attrs)
      assert redirected_to(conn) == Routes.link_record_path(conn, :show, link_record)

      conn = get(conn, Routes.link_record_path(conn, :show, link_record))
      assert html_response(conn, 200) =~ "some updated target_url"
    end

    test "renders errors when data is invalid", %{conn: conn, link_record: link_record} do
      conn = put(conn, Routes.link_record_path(conn, :update, link_record), link_record: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Link record"
    end
  end

  describe "delete link_record" do
    setup [:create_link_record]

    test "deletes chosen link_record", %{conn: conn, link_record: link_record} do
      conn = delete(conn, Routes.link_record_path(conn, :delete, link_record))
      assert redirected_to(conn) == Routes.link_record_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.link_record_path(conn, :show, link_record))
      end
    end
  end

  defp create_link_record(_) do
    link_record = fixture(:link_record)
    %{link_record: link_record}
  end
end
