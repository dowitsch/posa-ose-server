defmodule Posa.UserSerializer do
  use JaSerializer

  location "/users/:id"

  attributes [
    :login,
    :github_id,
    :avatar_url,
    :gravatar_id,
    :url,
    :html_url,
    :followers_url,
    :following_url,
    :gists_url,
    :starred_url,
    :subscriptions_url,
    :organizations_url,
    :repos_url,
    :events_url,
    :received_events_url,
    :type,
    :site_admin
  ]

  has_many :events,
    serializer: Posa.EventView,
    links: [
      related: "/users/:id/events",
      self: "/users/:id/relationships/events"
    ]
end
