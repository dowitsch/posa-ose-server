defmodule Posa.EventView do
  use Posa.Web, :view

  attributes [
    :github_id,
    :type,
    :repo,
    :payload,
    :public,
    :created_at
  ]

  has_one :actor,
    serializer: Posa.UserSerializer,
    include: true,
    field: :user,
    links: [
      #self: "/api/v1/events/:id/relationships/user",
      #related: "/api/v1/events/:id/user",
      related: "/api/v1/user/:user_id"
    ]

  def user_id(struct, _conn) do
    struct.user.id
  end
#
#  def user(struct, _conn) do
#    case struct.user do
#      %Ecto.Association.NotLoaded{} ->
#        struct
#        |> Ecto.assoc(:user)
#        |> Posa.Repo.all
#      other -> other
#    end
#  end
end
