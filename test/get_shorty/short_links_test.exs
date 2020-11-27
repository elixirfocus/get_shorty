defmodule GetShorty.ShortLinksTest do
  use GetShorty.DataCase

  alias GetShorty.ShortLinks

  describe "short_links" do
    alias GetShorty.ShortLinks.ShortLink

    @valid_attrs %{long_link: "some long_link", token: "some token"}
    @update_attrs %{long_link: "some updated long_link", token: "some updated token"}
    @invalid_attrs %{long_link: nil, token: nil}

    def short_link_fixture(attrs \\ %{}) do
      {:ok, short_link} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ShortLinks.create_short_link()

      short_link
    end

    test "list_short_links/0 returns all short_links" do
      short_link = short_link_fixture()
      assert ShortLinks.list_short_links() == [short_link]
    end

    test "get_short_link!/1 returns the short_link with given id" do
      short_link = short_link_fixture()
      assert ShortLinks.get_short_link!(short_link.id) == short_link
    end

    test "create_short_link/1 with valid data creates a short_link" do
      assert {:ok, %ShortLink{} = short_link} = ShortLinks.create_short_link(@valid_attrs)
      assert short_link.long_link == "some long_link"
      assert short_link.token == "some token"
    end

    test "create_short_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ShortLinks.create_short_link(@invalid_attrs)
    end

    test "update_short_link/2 with valid data updates the short_link" do
      short_link = short_link_fixture()
      assert {:ok, %ShortLink{} = short_link} = ShortLinks.update_short_link(short_link, @update_attrs)
      assert short_link.long_link == "some updated long_link"
      assert short_link.token == "some updated token"
    end

    test "update_short_link/2 with invalid data returns error changeset" do
      short_link = short_link_fixture()
      assert {:error, %Ecto.Changeset{}} = ShortLinks.update_short_link(short_link, @invalid_attrs)
      assert short_link == ShortLinks.get_short_link!(short_link.id)
    end

    test "delete_short_link/1 deletes the short_link" do
      short_link = short_link_fixture()
      assert {:ok, %ShortLink{}} = ShortLinks.delete_short_link(short_link)
      assert_raise Ecto.NoResultsError, fn -> ShortLinks.get_short_link!(short_link.id) end
    end

    test "change_short_link/1 returns a short_link changeset" do
      short_link = short_link_fixture()
      assert %Ecto.Changeset{} = ShortLinks.change_short_link(short_link)
    end
  end
end
