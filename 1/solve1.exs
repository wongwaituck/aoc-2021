raw_data = File.read!("solve1.txt")
measurements = raw_data |> String.split("\n", trim: true) |> Enum.map(&String.to_integer/1)

increments = Enum.filter(Enum.zip(measurements, [0]++measurements), fn {aft, bef} -> aft > bef end)

# ignore the first increment, hence - 1
IO.puts("Solution: #{length(increments) - 1}")
