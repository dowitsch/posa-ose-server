defmodule Posa.UserView do
  use Posa.Web, :view

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
    links: [
      #self: "/api/v1/user/:id/relationships/events",
      related: "/api/v1/user/:id/events"
    ]
end
