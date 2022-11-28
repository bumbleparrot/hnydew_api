defmodule HnydewApiWeb.UserController do
  use HnydewApiWeb, :controller

  alias HnydewApi.Accounts
  alias HnydewApi.Accounts.User

  action_fallback HnydewApiWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end
end
