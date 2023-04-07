defmodule BloodPressureWeb.PressureLive.FormComponent do
  use BloodPressureWeb, :live_component

  alias BloodPressure.Metrics

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage pressure records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="pressure-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:high]} type="number" label="High" />
        <.input field={@form[:low]} type="number" label="Low" />
        <.input field={@form[:timestemp]} type="datetime-local" label="Timestemp" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Pressure</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{pressure: pressure} = assigns, socket) do
    changeset = Metrics.change_pressure(pressure)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"pressure" => pressure_params}, socket) do
    changeset =
      socket.assigns.pressure
      |> Metrics.change_pressure(pressure_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"pressure" => pressure_params}, socket) do
    save_pressure(socket, socket.assigns.action, pressure_params)
  end

  defp save_pressure(socket, :edit, pressure_params) do
    case Metrics.update_pressure(socket.assigns.pressure, pressure_params) do
      {:ok, pressure} ->
        notify_parent({:saved, pressure})

        {:noreply,
         socket
         |> put_flash(:info, "Pressure updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_pressure(socket, :new, pressure_params) do
    case Metrics.create_pressure(pressure_params) do
      {:ok, pressure} ->
        notify_parent({:saved, pressure})

        {:noreply,
         socket
         |> put_flash(:info, "Pressure created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
