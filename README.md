# TravelClient

Simple client for [api.skypicker.com](http://docs.skypickerpublicapi.apiary.io/#reference).

The code is based on example from [Programming Elixir 1.3](https://www.amazon.com/Programming-Elixir-1-3-Functional-Concurrent/dp/168050200X).

See my blogpost to get more insights about this application [Travel API client in Elixir](http://misha-slyusarev.github.io/elixir/api/2017/02/18/travel-client.html).

## Installation

Clone the project and compile with escript.

```bash
git clone https://github.com/misha-slyusarev/travel_cllient.git
cd travel_cllient
mix deps.get
mix escript.build
./travel_client -h
```
