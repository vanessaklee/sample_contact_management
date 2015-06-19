MIX=mix
IEX=iex

.PHONY: all compile test

all: compile

compile: get-deps
  @$(MIX) compile

test:
  ELIXIR_ERL_OPTS='-config etc/test' $(MIX) $@

run:
  ELIXIR_ERL_OPTS='-config etc/dev' $(IEX) -S $(MIX)

clean:
  @$(MIX) clean

get-deps:
  @$(MIX) deps.get
