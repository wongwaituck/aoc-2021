raw_data = File.read!("puzzle.txt")
diagnostics = raw_data |> String.split("\n", trim: true)

# get ratings
oxygen_rating = Library.get_rating(diagnostics, &Library.max_function/1)
  |> Library.bitstr_to_int

co2_rating = Library.get_rating(diagnostics, &Library.min_function/1)
  |> Library.bitstr_to_int

IO.puts("Solution #{oxygen_rating * co2_rating}")
