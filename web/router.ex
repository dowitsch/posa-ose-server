defmodule Posa.Router do
  use Posa.Web, :router

  pipeline :api do
    plug :accepts, ["json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  scope "/api/v1", Posa do
    pipe_through :api

    resources "/organizations", OrganizationController, except: [:new, :edit] do
      resources "/users", UserController, only: [:index]
      resources "/events", EventController, only: [:index]
    end
    resources "/users", UserController, except: [:new, :edit] do
      resources "/events", EventController, only: [:index]
    end
    resources "/events", EventController, except: [:new, :edit]
  end
end
