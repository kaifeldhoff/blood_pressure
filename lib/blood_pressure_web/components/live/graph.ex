defmodule BloodPressureWeb.Live.Graph do
  use BloodPressureWeb, :live_component

  alias BloodPressure.Metrics

  @impl true
  def update(_, socket) do
    spec =
      VegaLite.new(title: "Demo", width: :container, height: :container, padding: 5)
      # Load values. Values are a map with the attributes to be used by Vegalite
      |> VegaLite.data_from_values(pressure_data())
      # Defines the type of mark to be used
      |> VegaLite.mark(:point)
      # Sets the axis, the key for the data and the type of data
      |> VegaLite.encode_field(:x, "date", type: :temporal)
      |> VegaLite.encode_field(:y, "pressure", type: :quantitative, scale: [domain: [70, 150]])
      |> VegaLite.encode_field(:color ,"name")
      # Output the specifcation
      |> VegaLite.to_spec()

    socket = assign(socket, id: socket.id)
    {:ok, push_event(socket, "vega_lite:#{socket.id}:init", %{"spec" => spec})}
  end

  @impl true
  def render(assigns) do
    # Here we have the element that will load the embedded view. Special note to data-id which is the
    # identifier that will be used by the hooks to understand which socket sent want.

    # We also identify the hook that will use this component using phx-hook.
    # Refer again to https://hexdocs.pm/phoenix_live_view/js-interop.html#client-hooks-via-phx-hook
    ~H"""
    <div style="width:100%; height: 500px" id="graph" phx-hook="VegaLite" phx-update="ignore" data-id={@id}/>
    """
  end

  defp pressure_data do
    Metrics.list_pressures()
    |> Enum.map(fn pressure ->
      [
        %{pressure: pressure.high, date: NaiveDateTime.to_iso8601(pressure.timestamp), name: "high"},
        %{pressure: pressure.low, date: NaiveDateTime.to_iso8601(pressure.timestamp), name: "low"}
      ]
    end)
    |> List.flatten()
  end

end
