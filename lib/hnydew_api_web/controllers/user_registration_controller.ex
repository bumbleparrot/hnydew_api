defmodule HnydewApiWeb.UserRegistrationController do
  use HnydewApiWeb, :controller

  alias HnydewApi.Accounts
  alias HnydewApi.Accounts.User
  alias HnydewApiWeb.UserAuth
  alias HnydewApiWeb.Error

  def new(conn, _params) do
    changeset = Accounts.change_user_registration(%User{})
    render(conn, "new.html", changeset: changeset)
  end


  def create(conn, %{"user" => user_params}) when conn.request_path == "/api/v1/users/register" do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        conn
        |> put_view(HnydewApiWeb.UserView)
        |> render("show.json", user: user)

      {:error, changeset} ->
        errors = Error.translate_error(changeset)

        conn
        |> put_view(HnydewApiWeb.ErrorView)
        |> render("index.json", errors: errors)
    end
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &Routes.user_confirmation_url(conn, :edit, &1)
          )

        conn
        |> put_flash(:info, "User created successfully.")
        |> UserAuth.log_in_user(user)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
