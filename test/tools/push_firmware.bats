#!/usr/bin/env bats

#  author : sven zaugg
#    file : push_firmware.bats
# purpose : unit tests for bash script /tools/push_firmware

# pre-test hook: gets invoked BEFORE EACH annotated @test method
setup() {
	load tools_test_fixture
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

@test '/tools/push_firmware running without any arguments' {
	# given

	# when
	run push_firmware
	
	# then
	assert_failure
}

@test '/tools/push_firmware shows command usage' {
	# given

	# when
	run push_firmware
	
	# then
	assert_output --partial 'Usage'
}