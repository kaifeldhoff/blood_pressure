defmodule BloodPressure.Metrics.Pressure do
  use Ecto.Schema
  import Ecto.Changeset

  alias BloodPressure.Metrics.Pressure

  schema "pressures" do
    field :high, :integer
    field :low, :integer
    field :timestamp, :naive_datetime  # , autogenerate: NaiveDateTime.from_erl(:erlang.localtime)

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
  end
end
