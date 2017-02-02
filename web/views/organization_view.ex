defmodule Posa.OrganizationView do
  use Posa.Web, :view

  attributes [
    :id,
    :login,
    :github_id,
    :url,
    :repos_url,
    :events_url,
    :hooks_url,
    :issues_url,
    :members_url,
    :public_members_url,
    :avatar_url,
    :description,
    :name,
    :blog,
    :location,
    :email,
    :public_repos,
    :public_gists,
    :followers,
    :following,
    :html_url,
    :created_at,
    :updated_at,
    :type
  ]

  has_many :user,
    serializer: Posa.UserSerializer,
    include: false,
    field: :members,
    links: [
      #self: "/api/v1/organizations/:id/relationships/users",
      related: "/api/v1/organizations/:id/users"
    ]

  has_many :events,
    serializer: Posa.EventSerializer,
    include: false,
    field: :events,
    links: [
      #self: "/api/v1/organizations/:id/relationships/events",
      related: "/api/v1/organizations/:id/events"
    ]
end
