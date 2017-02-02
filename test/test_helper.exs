ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Posa.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Posa.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Posa.Repo)

