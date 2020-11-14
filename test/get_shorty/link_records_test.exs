defmodule GetShorty.LinkRecordsTest do
  use GetShorty.DataCase

  alias GetShorty.LinkRecords

  describe "link_records" do
    alias GetShorty.LinkRecords.LinkRecord

    @valid_attrs %{target_url: "some target_url", token: "some token"}
    @update_attrs %{target_url: "some updated target_url", token: "some updated token"}
    @invalid_attrs %{target_url: nil, token: nil}

    def link_record_fixture(attrs \\ %{}) do
      {:ok, link_record} =
        attrs
        |> Enum.into(@valid_attrs)
        |> LinkRecords.create_link_record()

      link_record
    end

    test "list_link_records/0 returns all link_records" do
      link_record = link_record_fixture()
      assert LinkRecords.list_link_records() == [link_record]
    end

    test "get_link_record!/1 returns the link_record with given id" do
      link_record = link_record_fixture()
      assert LinkRecords.get_link_record!(link_record.id) == link_record
    end

    test "create_link_record/1 with valid data creates a link_record" do
      assert {:ok, %LinkRecord{} = link_record} = LinkRecords.create_link_record(@valid_attrs)
      assert link_record.target_url == "some target_url"
      assert link_record.token == "some token"
    end

    test "create_link_record/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = LinkRecords.create_link_record(@invalid_attrs)
    end

    test "update_link_record/2 with valid data updates the link_record" do
      link_record = link_record_fixture()
      assert {:ok, %LinkRecord{} = link_record} = LinkRecords.update_link_record(link_record, @update_attrs)
      assert link_record.target_url == "some updated target_url"
      assert link_record.token == "some updated token"
    end

    test "update_link_record/2 with invalid data returns error changeset" do
      link_record = link_record_fixture()
      assert {:error, %Ecto.Changeset{}} = LinkRecords.update_link_record(link_record, @invalid_attrs)
      assert link_record == LinkRecords.get_link_record!(link_record.id)
    end

    test "delete_link_record/1 deletes the link_record" do
      link_record = link_record_fixture()
      assert {:ok, %LinkRecord{}} = LinkRecords.delete_link_record(link_record)
      assert_raise Ecto.NoResultsError, fn -> LinkRecords.get_link_record!(link_record.id) end
    end

    test "change_link_record/1 returns a link_record changeset" do
      link_record = link_record_fixture()
      assert %Ecto.Changeset{} = LinkRecords.change_link_record(link_record)
    end
  end
end
