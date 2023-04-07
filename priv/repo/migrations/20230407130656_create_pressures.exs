defmodule BloodPressure.Repo.Migrations.CreatePressures do
  use Ecto.Migration

  def change do
    create table(:pressures) do
      add :high, :integer
      add :low, :integer
      add :timestemp, :naive_datetime

      timestamps()
    end
  end
end
