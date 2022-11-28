defmodule HnydewApiWeb.FamilyControllerTest do
  use HnydewApiWeb.ConnCase

  import HnydewApi.FamiliesFixtures

  alias HnydewApi.Families.Family

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all families", %{conn: conn} do
      conn = get(conn, Routes.family_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create family" do
    test "renders family when data is valid", %{conn: conn} do
      conn = post(conn, Routes.family_path(conn, :create), family: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.family_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.family_path(conn, :create), family: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update family" do
    setup [:create_family]

    test "renders family when data is valid", %{conn: conn, family: %Family{id: id} = family} do
      conn = put(conn, Routes.family_path(conn, :update, family), family: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.family_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, family: family} do
      conn = put(conn, Routes.family_path(conn, :update, family), family: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete family" do
    setup [:create_family]

    test "deletes chosen family", %{conn: conn, family: family} do
      conn = delete(conn, Routes.family_path(conn, :delete, family))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.family_path(conn, :show, family))
      end
    end
  end

  defp create_family(_) do
    family = family_fixture()
    %{family: family}
  end
end
