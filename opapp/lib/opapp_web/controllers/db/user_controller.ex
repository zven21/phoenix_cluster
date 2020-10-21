defmodule OpappWeb.DB.UserController do
  use OpappWeb, :controller

  alias Opapp.Users

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.html", users: users)
  end
end
