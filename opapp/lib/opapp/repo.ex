defmodule Opapp.Repo do
  use Ecto.Repo,
    otp_app: :opapp,
    adapter: Ecto.Adapters.Postgres
end
