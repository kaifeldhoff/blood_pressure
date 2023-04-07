defmodule BloodPressure.Metrics.Pressure do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pressures" do
    field :high, :integer
    field :low, :integer
    field :timestemp, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(pressure, attrs) do
    pressure
    |> cast(attrs, [:high, :low, :timestemp])
    |> validate_required([:high, :low, :timestemp])
  end
end
