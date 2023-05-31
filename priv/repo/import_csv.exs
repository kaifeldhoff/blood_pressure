alias BloodPressure.Metrics

File.stream!("export.csv", [:read, :utf8])
|> CSV.decode!(separator: ?;)
|> Enum.map(&IO.inspect/1)
