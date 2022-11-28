defmodule HnydewApiWeb.LoginController do
  use HnydewApiWeb, :controller

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
   render(conn, "index.html")
  end

  @spec name(Plug.Conn.t(), any) :: Plug.Conn.t()
  def name(conn, %{"name" => name}) do
    render(conn, "name.html", name: name)
  end

end
