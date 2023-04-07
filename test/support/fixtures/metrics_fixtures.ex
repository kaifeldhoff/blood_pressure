defmodule BloodPressure.MetricsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BloodPressure.Metrics` context.
  """

  @doc """
  Generate a pressure.
  """
  def pressure_fixture(attrs \\ %{}) do
    {:ok, pressure} =
      attrs
      |> Enum.into(%{
        high: 42,
        low: 42,
        timestemp: ~N[2023-04-06 13:06:00]
      })
      |> BloodPressure.Metrics.create_pressure()

    pressure
  end
end
