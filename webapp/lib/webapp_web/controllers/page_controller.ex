defmodule WebappWeb.PageController do
  use WebappWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", user_token: conn.assigns.user_token)
  end
end
