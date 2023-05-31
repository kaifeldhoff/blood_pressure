defmodule BloodPressure.Metrics.Pressure do
  use Ecto.Schema
  import Ecto.Changeset

  alias BloodPressure.Metrics.Pressure

  schema "pressures" do
    field :high, :integer
    field :low, :integer
    field :timestamp, :naive_datetime  # , autogenerate: NaiveDateTime.from_erl(:erlang.localtime)
    field :pretty_datetime, :string, virtual: true

    timestamps()
  end

  def new() do
    {:ok, now} = NaiveDateTime.from_erl(:erlang.localtime)
    Map.put(%Pressure{}, :timestamp, now)
  end

  @doc false
  def changeset(pressure, attrs) do
    pressure
    |> cast(attrs, [:high, :low, :timestamp])
    |> validate_required([:high, :low, :timestamp])
    |> put_pretty_datetime()
  end

  def put_pretty_datetime(%Pressure{} = struct) do
    Map.put(struct, :pretty_datetime, to_pretty_datetime(struct.timestamp))
  end
  def put_pretty_datetime(%Ecto.Changeset{} = changeset) do
    timestamp = get_change(changeset, :timestamp)
    if timestamp do
      put_change(changeset, :pretty_datetime, to_pretty_datetime(timestamp))
    else
      changeset
    end
  end

  def to_plain_map(%Pressure{high: high, low: low, timestamp: timestamp}) do
    %{
      high: high,
      low: low,
      timestamp: timestamp
    }
  end

  defp to_pretty_datetime(timestamp) do
    Calendar.strftime(timestamp, "%a, %d %b %Y, %H:%M")
  end

end
