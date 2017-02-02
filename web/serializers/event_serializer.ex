defmodule Posa.EventSerializer do
  use JaSerializer

  location "/events/:id"

  attributes [
    :github_id,
    :type,
    :actor,
    :repo,
    :payload,
    :public,
    :created_at
  ]

  has_one :user,
    serializer: Posa.UserView,
    include: true,
    field: :user,
    links: [
      self: "/users/:id"
    ]

  def user(struct, _conn) do
    case struct.user do
      %Ecto.Association.NotLoaded{} ->
        struct
        |> Ecto.assoc(:user)
        |> Posa.Repo.all
      other -> other
    end
  end
end
