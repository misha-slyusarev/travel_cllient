defmodule Flight do
  defstruct [:departue_time, :arrival_time, :duration, :price]
end

defimpl String.Chars, for: Flight do
  def to_string(f) do
    "#{f.departue_time} | #{f.arrival_time} | #{f.duration} | #{f.price}"
  end
end
