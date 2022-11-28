defmodule HnydewApiWeb.FamilyView do
  use HnydewApiWeb, :view
  alias HnydewApiWeb.FamilyView

  def render("index.json", %{families: families}) do
    %{data: render_many(families, FamilyView, "family.json")}
  end

  def render("show.json", %{family: family}) do
    %{data: render_one(family, FamilyView, "family.json")}
  end

  def render("show_with_users.json", %{family: family}) do
    render("family.json", %{family: family})
    |> Map.put_new(:users, render_many(family.users, HnydewApiWeb.UserView, "user.json", as: :user))
  end

  def render("family.json", %{family: family}) do
    %{
      id: family.id,
      name: family.name,
      uniqueCode: family.uniqueCode
    }
  end
end
