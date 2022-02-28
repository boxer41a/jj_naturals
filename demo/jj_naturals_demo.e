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
			t: JJ_NATURAL_8_TESTS
		do
			clear_terminal
				-- Make and run tests
			create t
			t.run_all
			io.put_string ("End test of JJ_NATURAL numbers %N")
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
