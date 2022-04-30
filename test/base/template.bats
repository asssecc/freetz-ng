#!/usr/bin/env bats

#  author : sven zaugg
#    file : /test/base/template.bats
# purpose : template file for creating tests with bats 
#
# a list of all possible assertions can be viewed at /test/base/assertions.ref
# for more infos about bats, see https://bats-core.readthedocs.io/

setup() {
    load 'base/testsuite'
    _base_setup
}

teardown() {
	: #noop
}

setup_file() {
    load 'base/testsuite'
    _base_setup
}

teardown_file() {
	: #noop
}

@test "i'm gonna return successfully" {
	# given
	
	# when
	
	# then
	exit 0
}

@test "i wanna fail, yeah." {
	fail 'good practise, fail first!'
}

@test "tests can be skipped"  {
	skip "skipping, also known as rammstein song 'ich habe keine lust'";
}