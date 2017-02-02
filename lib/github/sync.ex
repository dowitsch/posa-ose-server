defmodule Github.Sync do
  require Logger

  alias Posa.Repo
  alias Posa.Event
  alias Posa.Organization
  alias Posa.User
  alias Posa.OrganizationUser

  def run do
    members = fetch_organization("puzzle") |> fetch_org_members
    for member <- members, do: member |> fetch_user_events
  end

  def fetch_organization(name) do
    Logger.debug("Fetching organization data of @#{name}")

    org = Github.API.get("orgs/#{name}").body

    Logger.debug("Fetched organization data of @#{name}")

    org = org
          |> Map.put(:github_id, org[:id])
          |> Map.drop([:company, :id])

    changeset =
      case Repo.get_by(Organization, login: org.login) do
        nil -> %Organization{}
        post -> post
      end
      |> Organization.changeset(org)

    case Repo.insert_or_update(changeset) do
      {:ok, org} -> org
    end
  end

  def fetch_org_members(organization) do
    Logger.debug("Fetching members of @#{organization.login}")

    members = Github.API.get("orgs/#{organization.login}/public_members").body

    Logger.debug("Fetched members of @#{organization.login}")

    members = for member <- members, do: member
              |> Map.put(:github_id, member[:id])
              |> Map.delete(:id)

    transaction = Repo.transaction fn ->
      Repo.delete_all(OrganizationUser, organization_id: organization.id)
      members = case insert_all(User, members) do
        {:ok, members} -> members
      end
      organization_users = for member <- members, do: [
        organization_id: organization.id,
        user_id: member.id
      ]
      Repo.insert_all(OrganizationUser, organization_users)
      members
    end

    case transaction do
      {:ok, members} -> members
    end
  end

  def fetch_user_events(user) do
    Logger.debug("Fetching events of @#{user.login}")

    events = Github.API.get("users/#{user.login}/events/public?per_page=50").body

    Logger.debug("Fetched events of @#{user.login}")

    events = for event <- events, do: event
             |> Map.put(:user_id, user.id)
             |> Map.put(:github_id, event[:id])
             |> Map.delete(:id)

    case insert_all(Event, events) do
      {:ok, events} -> events
    end
  end

  def insert_all(model, data) do
    Repo.transaction fn ->
      Enum.map(data, fn data ->
        case Repo.get_by(model, github_id: data.github_id) do
          nil -> struct(model)
          data -> data
        end
        |> model.changeset(data)
      end)
      |> Enum.map(fn changeset ->
        Repo.insert_or_update!(changeset)
      end)
    end
  end
end
