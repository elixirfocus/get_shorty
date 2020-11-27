defmodule GetShorty.ShortLinksTest do
  use GetShorty.DataCase

  alias GetShorty.ShortLinks
  alias GetShorty.ShortLinks.ShortLink

  describe "list_short_links/1" do
    test "returns an empty list when there are no short links" do
      assert [] == ShortLinks.list_short_links()
    end

    test "returns three items in list when there are three short links" do
      insert_list(3, :short_link)
      list = ShortLinks.list_short_links()
      assert Enum.count(list) == 3
    end
  end

  describe "get_short_link!/1" do
    test "returns a short link when given a valid id" do
      %ShortLink{id: id} = insert(:short_link)
      assert %ShortLink{id: ^id} = ShortLinks.get_short_link!(id)
    end

    test "raises `Ecto.NoResultsError` when given an invalid id" do
      assert_raise Ecto.NoResultsError, fn ->
        assert _this_will_fail = ShortLinks.get_short_link!(987)
      end
    end
  end

  describe "create_short_link/1" do
    test "works with valid attributes" do
      assert {:ok, _short_link} = ShortLinks.create_short_link(params_for(:short_link))
    end

    test "fails when missing long_link" do
      assert {:error, changeset} = ShortLinks.create_short_link(%{})
      assert %{long_link: ["can't be blank"]} = errors_on(changeset)
    end

    test "fails when missing token" do
      assert {:error, changeset} = ShortLinks.create_short_link(%{})
      assert %{token: ["can't be blank"]} = errors_on(changeset)
    end

    test "fails with a non-unique token" do
      %ShortLink{token: token} = insert(:short_link)
      params = params_for(:short_link)
      params = %{params | token: token}
      assert {:error, changeset} = ShortLinks.create_short_link(params)
      assert %{token: ["has already been taken"]} = errors_on(changeset)
    end
  end

  describe "update_short_link/2" do
    test "works with valid attributes" do
      short_link = insert(:short_link)
      new_params = %{long_link: long_link, token: token} = params_for(:short_link)

      assert {:ok, %ShortLink{long_link: ^long_link, token: ^token}} =
               ShortLinks.update_short_link(short_link, new_params)
    end

    test "fails when missing long_link" do
      assert {:error, changeset} =
               ShortLinks.update_short_link(insert(:short_link), %{long_link: nil})

      assert %{long_link: ["can't be blank"]} = errors_on(changeset)
    end

    test "fails when missing token" do
      assert {:error, changeset} =
               ShortLinks.update_short_link(insert(:short_link), %{token: nil})

      assert %{token: ["can't be blank"]} = errors_on(changeset)
    end

    test "fails with a non-unique token" do
      short_link_a = insert(:short_link)
      short_link_b = insert(:short_link)

      assert {:error, changeset} =
               ShortLinks.update_short_link(short_link_b, %{token: short_link_a.token})

      assert %{token: ["has already been taken"]} = errors_on(changeset)
    end
  end

  describe "delete_short_link/1" do
    test "works with a previously stored short link" do
      %ShortLink{id: id} = short_link = insert(:short_link)
      assert {:ok, %ShortLink{id: ^id}} = ShortLinks.delete_short_link(short_link)
    end

    test "fails when attempting to delete non-persisted id" do
      short_link = build(:short_link)

      assert_raise Ecto.NoPrimaryKeyValueError, fn ->
        assert _this_will_fail = ShortLinks.delete_short_link(short_link)
      end
    end

    test "fails when attempting to delete an already deleted id" do
      short_link = insert(:short_link)

      assert {:ok, _} = ShortLinks.delete_short_link(short_link)

      assert_raise Ecto.StaleEntryError, fn ->
        assert _this_will_fail = ShortLinks.delete_short_link(short_link)
      end
    end
  end

  describe "change_short_link/2" do
    test "returns valid changeset when accepting valid attributes" do
      assert %Ecto.Changeset{valid?: true} = ShortLinks.change_short_link(build(:short_link), %{})
    end

    test "returns invalid changeset when accepting valid attributes" do
      assert %Ecto.Changeset{valid?: false} = ShortLinks.change_short_link(%ShortLink{}, %{})
    end
  end
end
