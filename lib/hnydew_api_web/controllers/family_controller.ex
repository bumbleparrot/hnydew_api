defmodule HnydewApiWeb.FamilyController do
  use HnydewApiWeb, :controller

  alias HnydewApi.Families
  alias HnydewApi.Families.Family

  action_fallback HnydewApiWeb.FallbackController

  def index(conn, _params) do
    families = Families.list_families()
    render(conn, "index.json", families: families)
  end

  def create(conn, %{"family" => family_params}) do
    with {:ok, %Family{} = family} <- Families.create_family(family_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.family_path(conn, :show, family))
      |> render("show.json", family: family)
    end
  end

  def show(conn, %{"id" => id}) do
    family = Families.get_family(id)
    render(conn, "show.json", family: family)
  end

  def get_family_and_users(conn, %{"id" => id}) do
    family = Families.get_family_and_users(id)
    render(conn, "show_with_users.json", family: family)
  end

  def update(conn, %{"id" => id, "family" => family_params}) do
    family = Families.get_family(id)

    with {:ok, %Family{} = family} <- Families.update_family_name(family, family_params) do
      render(conn, "show.json", family: family)
    end
  end

  def generate_new_unique_code(conn, %{"id" => id}) do
    family = Families.get_family(id)
5
    with {:ok, %Family{} = family} <- Families.generate_new_unique_code(family) do
      render(conn, "show.json", family: family)
    end
  end

  def delete(conn, %{"id" => id}) do
    # Case statement handling if we can get the family record we want to delete.
    case Families.get_family(id) do
      # Check if the get_family response is a Family struct. If so, assign it and keep going.
      family = %Family{} ->
        Families.delete_family(family)
        send_resp(conn, :no_content, "")
        |> halt()
      # When get_family doesn't find the record, it returns nil.
      nil ->
        send_resp(conn, :not_found, "")
      # This is the default response, we should never get here.
      _ ->
        send_resp(conn, :error, "")
    end
  end
end
