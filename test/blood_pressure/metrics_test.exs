defmodule BloodPressure.MetricsTest do
  use BloodPressure.DataCase

  alias BloodPressure.Metrics

  describe "pressures" do
    alias BloodPressure.Metrics.Pressure

    import BloodPressure.MetricsFixtures

    @invalid_attrs %{high: nil, low: nil, timestamp: nil}

    test "list_pressures/0 returns all pressures" do
      pressure = pressure_fixture()
      assert Metrics.list_pressures() == [pressure]
    end

    test "get_pressure!/1 returns the pressure with given id" do
      pressure = pressure_fixture()
      assert Metrics.get_pressure!(pressure.id) == pressure
    end

    test "create_pressure/1 with valid data creates a pressure" do
      valid_attrs = %{high: 42, low: 42, timestamp: ~N[2023-04-06 13:06:00]}

      assert {:ok, %Pressure{} = pressure} = Metrics.create_pressure(valid_attrs)
      assert pressure.high == 42
      assert pressure.low == 42
      assert pressure.timestamp == ~N[2023-04-06 13:06:00]
    end

    test "create_pressure/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Metrics.create_pressure(@invalid_attrs)
    end

    test "update_pressure/2 with valid data updates the pressure" do
      pressure = pressure_fixture()
      update_attrs = %{high: 43, low: 43, timestamp: ~N[2023-04-07 13:06:00]}

      assert {:ok, %Pressure{} = pressure} = Metrics.update_pressure(pressure, update_attrs)
      assert pressure.high == 43
      assert pressure.low == 43
      assert pressure.timestamp == ~N[2023-04-07 13:06:00]
    end

    test "update_pressure/2 with invalid data returns error changeset" do
      pressure = pressure_fixture()
      assert {:error, %Ecto.Changeset{}} = Metrics.update_pressure(pressure, @invalid_attrs)
      assert pressure == Metrics.get_pressure!(pressure.id)
    end

    test "delete_pressure/1 deletes the pressure" do
      pressure = pressure_fixture()
      assert {:ok, %Pressure{}} = Metrics.delete_pressure(pressure)
      assert_raise Ecto.NoResultsError, fn -> Metrics.get_pressure!(pressure.id) end
    end

    test "change_pressure/1 returns a pressure changeset" do
      pressure = pressure_fixture()
      assert %Ecto.Changeset{} = Metrics.change_pressure(pressure)
    end

    test "prefilled pressure should contain timestamp" do
      new = Pressure.new()
      assert new.timestamp != nil
    end
  end
end
