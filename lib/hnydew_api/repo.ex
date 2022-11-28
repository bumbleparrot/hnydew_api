defmodule HnydewApi.Repo do
  use Ecto.Repo,
    otp_app: :hnydew_api,
    adapter: Ecto.Adapters.Postgres
end
