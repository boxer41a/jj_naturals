note
	description: "[
		Root classes containing routines for testing the JJ_NATURAL classes.
		]"
	author: "Jimmy J. Johnson"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_ROUTINES

inherit

	EQA_TEST_SET
		redefine
--			on_prepare
		end

feature {NONE} -- Initialization

feature -- Access

	class_name: STRING_8
			-- The name of this class
		once
			Result := generating_type
		end

	value: JJ_NATURAL
			-- To obtain a new object of correct type
		deferred
		end

	value_from_string (a_string: STRING): JJ_NATURAL
		deferred
		end

feature -- Basic operations

	run_all
		deferred
		end

feature -- Test routines

	test (a_feature_name: STRING_8; a_expected: STRING_8; a_actual: STRING_8)
		do
			print (class_name + a_feature_name +" %N")
			print ("%T expected = " + a_expected + "%N")
			print ("%T actual =   " + a_actual + "%N")
			assert (a_feature_name, a_actual.out ~ a_expected)
		end

end
