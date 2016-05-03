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
			i: INTEGER
		do
			from i := 1
			until i > line_count
			loop
				print ("%N")
				i := i + 1
			end
			create t
			t.run_all
		end

feature -- Access

	Line_count: INTEGER = 40
		-- Used to clear console

end
