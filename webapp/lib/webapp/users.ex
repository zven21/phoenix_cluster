defmodule Webapp.Users do
  @moduledoc """
  The Topics context.
  """

  import Ecto.Query, warn: false
  alias Webapp.Repo

  alias Webapp.Users.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%user{}, ...]

  """
  def list_users do
    Repo.all(User)
  end
end
