#!/usr/bin/env bats

#  author : sven zaugg
#    file : template_test.bats
# purpose : template file for creating @tests with bats 

# bats test worklow
# -----------------
# 1) each test file (.bats) is preprocessed. lines like @test "first test" {...} are mapped into native bash functions.
# 2) each test file is executed (1-n test cases) in a single process, hence it can be parallelized.
#
# bats test helper 'run'
# ----------------------
# "Bats includes a run helper that invokes its arguments as a command, saves the exit status and output into special 
# global variables, and then returns with a 0 status code so you can continue to make assertions in your test case."
# (https://github.com/bats-core/bats-core/wiki/Bats-Evaluation-Process, May 2022)
#
# bats internals
# -----------------
# "Anything written to stdout or stderr in setup, teardown, or a test function is captured by Bats. 
# If the test case fails, the error trap prints the output to the TAP stream as a comment. 
# Outside a test case, though, stdout is the TAP stream, so you'll want to specifically redirect any output to stderr."
# (https://github.com/bats-core/bats-core/wiki/Bats-Evaluation-Process, May 2022)
#
# documentation
# -----------------
# for more infos about bats, see https://bats-core.readthedocs.io/
# a reference list of all possible assertions can be found at /test/bats/doc/assertions
# a reference list for mocking can be found at /test/bats/doc/mocking
# syntax highlighting: https://github.com/bats-core/bats-core/wiki/Syntax-Highlighting

# pre-test hook: gets invoked BEFORE EACH annotated @test method
setup() {
	load template_test_fixture
	_base_setup
}

# post-test hook: gets invoked AFTER EACH annotated @test method
teardown() {
	: #noop
}

# pre-test hook: runs only ONCE BEFORE the first pre-test hook of setup() is run
setup_file() {
	: #noop
}

# post-test hook: runs only ONCE AFTER last post-test hook of teardown() is run
teardown_file() {
	: #noop
}

@test "example1: i'm gonna return successfully" {
	# given
	cmd=non-existing-shell-command
	
	# when
	# note: the run helper executes its argument(s) in a subshell, 
	# so if writing tests against environmental side-effects like a variable’s
	# value being changed, these changes will not persist after run completes.
	run cmd

	# then
	assert_failure
}

@test "example2: i wanna fail, yeah." {
	fail 'good practise, fail first!'
}

@test "example3: tests can be skipped" {
	skip "skipping, also known as rammstein song 'ich habe keine lust'";
}