defmodule WebappWeb.Live.User do
  use WebappWeb, :live_view

  alias Webapp.Users

  @impl true
  def mount(_params, _session, socket) do
    users = Users.list_users()
    {:ok, assign(socket, users: users)}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <table>
      <thead>
        <tr>
          <th>id</th>
          <th>email</th>
          <th>onlone?</th>
        </tr>
      </thead>
      <tbody>
        <%= for user <- @users do %>
            <tr>
              <td><%= user.id %></td>
              <td><%= user.email %></td>
              <td>false</td>
            </tr>
        <% end %>
      </tbody>
    </table>
    """
  end
end
