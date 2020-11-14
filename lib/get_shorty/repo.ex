defmodule GetShorty.Repo do
  use Ecto.Repo,
    otp_app: :get_shorty,
    adapter: Ecto.Adapters.Postgres
end
