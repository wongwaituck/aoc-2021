defmodule Library do
  def bitstrl_to_int(x) do
    x
    |> Enum.reverse()
    |> Enum.reduce(&Kernel.<>/2)
    |> Integer.parse(2)
    |> elem(0)
  end

  def bitstr_to_int(x) do
    x
    |> Integer.parse(2)
    |> elem(0)
  end

  def diag_criterion(diagnostics, idx, min_max_fn) do
    min_max_fn.(
      Enum.frequencies(Enum.map(diagnostics, fn diag ->
        String.at(diag, idx)
      end))
        |> Map.to_list
    )
    |> elem(0)
  end

  # gets min of a frequency map
  def min_function(enumerable) do
    # this is a hack to get it to return the first element "0",
    # see https://hexdocs.pm/elixir/1.12/Enum.html#min_by/4
    Enum.min_by(enumerable, fn {_, v} -> v end, &<=/2)
  end

  # gets max of a frequency map
  def max_function(enumerable) do
    # this is a hack to get it to return the first element "1",
    # see https://hexdocs.pm/elixir/1.12/Enum.html#max_by/4
    Enum.max_by(enumerable, fn {_, v} -> v end, &>/2)
  end

  def get_rating(diagnostics, min_max_fn) do
    _get_rating(diagnostics, 0, min_max_fn)
  end

  def _get_rating(diagnostics, idx, min_max_fn) do
    if (length(diagnostics) > 1) do
      criterion = diag_criterion(diagnostics, idx, min_max_fn)
      new_diagnostics = diagnostics |> filter_by_first_bit(idx, criterion)
      _get_rating(new_diagnostics, idx + 1, min_max_fn)
    else
      Enum.at(diagnostics, 0)
    end
  end

  def filter_by_first_bit(diagnostics, idx, bit) do
    Enum.filter(diagnostics, fn diag ->
      String.at(diag, idx) == bit
    end)
  end
end
