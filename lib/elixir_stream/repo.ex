defmodule ElixirStream.Repo do
  use Ecto.Repo,
    otp_app: :elixir_stream,
    adapter: Ecto.Adapters.Postgres
end
