defmodule BloodPressure.Metrics.Pressure do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pressures" do
    field :high, :integer
    field :low, :integer
    field :timestamp, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(pressure, attrs) do
    pressure
    |> cast(attrs, [:high, :low, :timestamp])
    |> validate_required([:high, :low, :timestamp])
  end
end
