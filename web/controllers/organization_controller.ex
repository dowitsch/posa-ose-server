defmodule Posa.OrganizationController do
  use Posa.Web, :controller

  alias Posa.Organization

  plug :scrub_params, "organization" when action in [:create, :update]

  def index(conn, _params) do
    organizations = Repo.all(Organization)
    render(conn, data: organizations)
  end

  def show(conn, %{"id" => id}) do
    organization =
      case Integer.parse(id) do
        {id, _} ->
          Repo.get!(Organization, id)
        :error ->
          Repo.get_by!(Organization, login: id)
      end

    render(conn, data: organization)
  end
end
