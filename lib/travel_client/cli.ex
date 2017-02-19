defmodule TravelClient.CLI do

  @moduledoc """
    Handle input parameters and run a request to API
  """

  require Logger

  @doc """
    Entry point for the application
  """
  def main(argv) do
    argv
    |> parse_args
    |> TravelClient.process
  end

  @doc """
    `argv` can be -h or --help, which returns :help. Otherwise it is 'from',
    'to', 'from_date', and 'to_date'.

    Return a tuple of `{ from, to, from_date, to_date }`, or `:help` if
    --help (-h) was given.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean], aliases: [ h: :help ])
    case parse do
      { [ help: true ], _, _ } -> :help
      { _, [ from, to, from_date, to_date ], _ } ->
        from_date_t = check_date(Date.from_iso8601(from_date))
        to_date_t = check_date(Date.from_iso8601(to_date))
        { from, to, from_date_t, to_date_t }
      _ -> :help
    end
  end

  @doc """
    Check if date parsing was correct
  """
  def check_date({:ok, date}), do: date
  def check_date({:error, error}) do
    Logger.info("Error parsing dates: #{error}")
    TravelClient.process(:help)
  end
end
