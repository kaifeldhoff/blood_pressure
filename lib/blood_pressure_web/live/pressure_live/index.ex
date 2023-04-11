defmodule BloodPressureWeb.PressureLive.Index do
  use BloodPressureWeb, :live_view

  alias BloodPressure.Metrics

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :pressures, Metrics.list_pressures())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Pressure")
    |> assign(:pressure, Metrics.get_pressure!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Pressure")
    |> assign(:pressure, Metrics.prefilled_pressure())
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Pressures")
    |> assign(:pressure, nil)
  end

  @impl true
  def handle_info({BloodPressureWeb.PressureLive.FormComponent, {:saved, pressure}}, socket) do
    {:noreply, stream_insert(socket, :pressures, pressure, at: 0)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    pressure = Metrics.get_pressure!(id)
    {:ok, _} = Metrics.delete_pressure(pressure)

    {:noreply, stream_delete(socket, :pressures, pressure)}
  end
end
