defmodule WebappWeb.DB.UserController do
  use WebappWeb, :controller

  alias Webapp.Users

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.html", users: users)
  end
end
