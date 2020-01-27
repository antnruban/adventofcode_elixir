Code.load_file("../input.ex")

defmodule Edge do
  defstruct length: nil, width: nil, height: nil
end

defmodule Solution do
  @edge_regex ~r/(?<length>\d+)x(?<width>\d+)x(?<height>\d+)(\n)?/

  def resolve do
    Input.read
    |> String.split("\n")
    |> Enum.reduce(0, fn(side, total_square) -> calculate_square(side, total_square) end )
  end

  def resolve_ribbon do
    Input.read
    |> String.split("\n")
    |> Enum.reduce(0, fn(side, total_length) -> calculate_ribbon_lenght(side, total_length) end )
  end

  defp calculate_ribbon_lenght(side, total_length) when byte_size(side) != 0 do
    dimensions = parse(side)
    smallest_side = except_biggest_edge([dimensions.length, dimensions.width, dimensions.height])
    |> Enum.reduce(0, fn(edge, acc) -> acc + edge end)

    total_length + 2 * smallest_side + dimensions.length * dimensions.width * dimensions.height
  end

  defp calculate_ribbon_lenght(_, total_length) do total_length end

  defp calculate_square(side, total_square) when byte_size(side) != 0 do
    dimensions = parse(side)
    total_square + 2 * dimensions.length * dimensions.width +
      2 * dimensions.width * dimensions.height + 2 * dimensions.height * dimensions.length +
      min_side_area([dimensions.length, dimensions.width, dimensions.height])
  end

  defp calculate_square(_, total_square) do total_square end

  defp min_side_area(dimensions) do
    except_biggest_edge(dimensions)
    |> Enum.reduce(1, fn(edge, acc) -> acc * edge end)
  end

  defp except_biggest_edge(dimensions_list) do
    List.delete(dimensions_list, Enum.max(dimensions_list))
  end

  defp parse(side) do
    captures = Regex.named_captures(@edge_regex, side)
    %Edge{
      length: elem(Integer.parse(captures["length"]), 0),
      width: elem(Integer.parse(captures["width"]), 0),
      height: elem(Integer.parse(captures["height"]), 0)
    }
  end
end

#######
IO.inspect(
  "Papper Order: #{Solution.resolve} feets"
)
IO.inspect(
  "Ribbon Order: #{Solution.resolve_ribbon} feets"
)
