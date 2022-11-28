defmodule HnydewApiWeb.UserRegistrationView do
  use HnydewApiWeb, :view
  alias HnydewApiWeb.UserRegistrationView

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserRegistrationView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.email
    }
  end

end
