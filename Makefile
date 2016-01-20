suite_files = $(wildcard test/*_SUITE.erl)
suite ?= $(shell echo ${suite_files} | sed -e 's/ /,/g')

.PHONY: compile clean dev upgrade dialyzer test

compile: rebar3
	./rebar3 compile

upgrade: rebar3
	./rebar3 upgrade

clean: rebar3
	./rebar3 clean

dialyzer: rebar3
	./rebar3 dialyzer

test: ct proper

ct:  compile
	# make test suite=test/tt_importer_SUITE # to run specific suite
	./rebar3 ct --suite=$(suite)

proper: compile
	./rebar3 proper

shell: compile
	erl -pa _build/default/lib/*/ebin \
	-config config/sys \
	-eval "application:ensure_all_started(talks_tweeter)"

rebar3:
	wget -c https://s3.amazonaws.com/rebar3/rebar3
	chmod +x rebar3

