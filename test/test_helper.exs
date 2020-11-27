# Must be above `ExUnit.start()`.
{:ok, _} = Application.ensure_all_started(:ex_machina)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(GetShorty.Repo, :manual)
