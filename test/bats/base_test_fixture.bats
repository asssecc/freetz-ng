#!/usr/bin/env bats

#  author : sven zaugg
#    file : base_test_fixture.bats
# purpose : unit tests for bash script /test/bats/base_test_fixture

WORKING_DIRECTORY=___smells/like/teen/spirit

# pre-test hook: gets invoked BEFORE EACH annotated @test method
setup() {
	load base_test_fixture
	__base_setup test/bats
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
	# clean up test folder
	rm -rf ___smells 
}

@test '__git_root_dir() can ben run successfully' {
	run -0 __git_root_dir # expect exit code=0
}

@test '__git_root_dir() is expected to non-empty output' {
	# given
	
	# when
	run __git_root_dir

	# then
	assert_output
}

@test '__git_root_dir() is expected to return */freetz-ng' {
	# given

	# when
	run __git_root_dir

	# then
	assert_output --regexp '/freetz-ng$'
}

@test '__git_root_dir() refutes to return *smells/like/teen/spirit' {
	# given
	mkdir -p $WORKING_DIRECTORY
	cd $WORKING_DIRECTORY

	# when
	run __git_root_dir

	# then
	refute_output --partial 'smells/like/teen/spirit'
}

@test '__git_root_dir() should fail if invoked out of scope (repository)' {
	# given
	cd /

	# when
	run __git_root_dir

	# then
	assert_failure
}

@test '__git_root_dir() should return access prohibited' {
	# given
	cd /

	# when
	run __git_root_dir

	# then
	assert_output --partial 'access prohibited!'
}