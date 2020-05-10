note
	description : "[
		Class for testing compilation of my JJ_NATURAL classes.
	]"
	author: "Jimmy J. Johnson"
	date: "$Date$"
	revision: "$Revision$"

class
	JJ_NATURALS_DEMO

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			i: INTEGER
			t: JJ_NATURAL_8_TESTS
			r: JJ_RANDOMS_TESTER
		do
			clear_terminal
				-- Make and run tests
			create t
			create r
			t.run_all
			r.run_all
			io.put_string ("End test of random numbers %N")
		end

	clear_terminal
			-- Print some newlines in order to simulate clearing the terminal.
			-- Just moves previous output up and out of view.
		local
			i: INTEGER
		do
			from i := 1
			until i > 30
			loop
				print ("%N")
				i := i + 1
			end
		end

feature -- Access

	rand: RANDOM
			-- Force a compilation.
		once
			create Result.make
		end

end
