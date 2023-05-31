alias BloodPressure.Metrics

file = File.open!("export.csv", [:write, :utf8])
Metrics.list_pressures_as_csv()
|> Enum.each(&IO.write(file, &1))
