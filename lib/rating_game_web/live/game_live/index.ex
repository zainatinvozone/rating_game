defmodule RatingGameWeb.GameLive.Index do
  use RatingGameWeb, :live_view

  alias RatingGame.Catalog
  alias RatingGame.Catalog.Game
  # on_mount RatingGameWeb.UserLiveAuth

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :games, list_games())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Game")
    |> assign(:game, Catalog.get_game!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Game")
    |> assign(:game, %Game{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Games")
    |> assign(:game, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    game = Catalog.get_game!(id)
    {:ok, _} = Catalog.delete_game(game)

    {:noreply, assign(socket, :games, list_games())}
  end

  defp list_games do
    Catalog.list_games()
  end
end
