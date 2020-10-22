defmodule WebappWeb.Auth do
  @moduledoc """
  用户校验，对于已登录用户生成校验 auth_token
  """
  import Plug.Conn

  # import Phoenix.Token, only: [sign: 3]

  def init(options), do: options

  def call(conn, _) do
    conn
    |> assign(:user_token, user_token(conn))
  end

  # def user_logged_in?(conn), do: current_user(conn)

  # def current_user(%{assigns: %{current_user: u}}), do: u
  # def current_user(_), do: nil

  def user_token(conn) do
    case get_current_user(conn) do
      nil -> nil
      %{id: id} -> Phoenix.Token.sign(conn, "user socket", id)
    end
  end

  def get_current_user(conn), do: conn.assigns.current_user
end
