defmodule BloodPressure.Repo do
  use Ecto.Repo,
    otp_app: :blood_pressure,
    adapter: Ecto.Adapters.SQLite3
end
