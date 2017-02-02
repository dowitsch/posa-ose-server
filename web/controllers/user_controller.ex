defmodule Posa.UserController do
  use Posa.Web, :controller

  import Ecto.Query

  alias Posa.User
  alias Posa.OrganizationUser

  plug :scrub_params, "user" when action in [:create, :update]

  plug :assigns

  def index(conn, params) do
    users = get_users(params, conn.assigns)
            |> Repo.paginate(params["page"])

    render(conn, data: users, opts: [
      meta: Repo.get_page_meta(users)
    ])
  end

  defp get_users(params, %{organization_id: organization_id}) do
    get_users(params)
    |> join(
      :inner,
      [u],
      ou in OrganizationUser,
      ou.organization_id == ^organization_id
    )
  end

  defp get_users(params, _assigns \\ :empty) do
    from u in User, order_by: [desc: u.github_id]
  end

  def show(conn, %{"id" => id}) do
    user =
      case Integer.parse(id) do
        {id, _} ->
          Repo.get!(User, id)
        :error ->
          Repo.get_by!(User, login: id)
      end

    render(conn, data: user)
  end

  defp assigns(conn, _opts) do
    case conn.params do
      %{"organization_id" => organization_id} ->
        assign(conn, :organization_id, organization_id)
      _ ->
        conn
    end
  end
end
