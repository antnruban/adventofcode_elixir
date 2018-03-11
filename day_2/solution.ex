Code.load_file("../input.ex")

defmodule Solution do
  @side_regex ~r/(?<length>\d+)x(?<width>\d+)x(?<height>\d+)(\n)?/

  def resolve do
    Input.read
    |> String.split("\n")
    |> Enum.reduce(0, fn(side, total_square) -> calculate_square(side, total_square) end )
  end

  defp calculate_square(side, total_square) when byte_size(side) != 0 do
    %{"length" => length, "width" => width, "height" => height} = Regex.named_captures(@side_regex, side)

    {length, ""} = Integer.parse(length)
    {height, ""} = Integer.parse(height)
    {width, ""} = Integer.parse(width)

    total_square + 2 * length * width + 2 * width * height + 2 * height * length + min_side_area([length, width, height])
  end

  defp calculate_square(_, total_square) do total_square end

  defp min_side_area(dimensions) do
    List.delete(dimensions, Enum.max(dimensions))
    |> Enum.reduce(1, fn(side, acc) -> acc * side end)
  end
end

#######
# IO.inspect(
#   Solution.resolve
# )
