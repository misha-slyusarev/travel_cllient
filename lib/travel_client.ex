defmodule TravelClient do

  @moduledoc """
    Request information, according to parameters received from
    CLI module, and process it.
  """

  require Logger

  @doc """
    When command line arguments parsed we get to processing.
    If there was a request for help, though, let's show help message and quit.
  """
  def process(:help) do
    IO.puts """
    usage: travel_client <from> <to> <from_date> <to_date>
    example: travel_client berlin paris 2017-06-21 2017-06-28
    """
    System.halt(0)
  end

  @doc """
    Request data from API and handle the response
  """
  def process({from, to, from_date, to_date}) do
    TravelClient.API.fetch(from, to, from_date, to_date)
    |> decode_response
    |> convert
    |> output
  end

  @doc """
    Check response status and take actions if it wasn't ok
  """
  def decode_response({:ok, body}) do
    Logger.info("Successful request")
    body
  end

  def decode_response({:error, _}) do
    Logger.info("Error fetching from API")
    System.halt(2)
  end

  @doc """
    Convert received data into internal format for output
  """
  def convert(body) do
    %{ currency: body["currency"], flights: extract_flights(body["data"]) }
  end

  @doc """
    Extract flight information and save it to a list
    of flights
  """
  def extract_flights([]), do: []
  def extract_flights([head | tail]) do
    flight = %Flight{
      departue_time: DateTime.from_unix!(head["dTimeUTC"], :second),
      arrival_time: DateTime.from_unix!(head["aTimeUTC"], :second),
      duration: head["fly_duration"],
      price: head["price"]
    }

    [ flight | extract_flights(tail)]
  end

  @doc """
    Output data to the console
  """
  def output(data) do
    IO.puts "Departue | Arrival | Duration | Price (#{data.currency})"
    Enum.each(data.flights, &IO.puts/1)
  end
end
