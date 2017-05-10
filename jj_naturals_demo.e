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
--			r: JJ_RANDOM_8_TESTS
		do
			from i := 1
			until i > line_count
			loop
				print ("%N")
				i := i + 1
			end
			create t
--			t.run_all

--			test_random_64
--			test_random_32
--			test_random_16
			test_random_8
--			test_range
--			test_range_32
--			test_range_16
--			test_range_8

			io.put_string ("End test of random numbers %N")
		end

feature -- Basic operations

	test_random_64
			-- Create the first few random numbers.
		local
			i: INTEGER
			r: NATURAL_64
		do
			from i := 1
			until i > 100
			loop
				r := jj_random.item
				io.put_string (r.out + "   ")
				jj_random.forth
				i := i + 1
			end
			io.new_line
		end

	test_random_32
			-- Create the first few random numbers.
		local
			i: INTEGER
			r: NATURAL_32
		do
			from i := 1
			until i > 10
			loop
				r := jj_random_32.item
				io.put_string ("r = " + r.out + "%N")
				jj_random_32.forth
				i := i + 1
			end
		end

	test_random_16
			-- Create the first few random numbers.
		local
			i: INTEGER
			r: NATURAL_16
		do
			from i := 1
			until i > 10
			loop
				r := jj_random_16.item
				io.put_string ("r = " + r.out + "%N")
				jj_random_16.forth
				i := i + 1
			end
		end

	test_random_8
			-- Create the first few random numbers.
		local
			i: INTEGER
			r: NATURAL_8
			frst, secd, thrd: NATURAL_8
		do
			jj_random_8.set_range (0, 3)
			from i := 1
			until i > i.max_value
			loop
				r := jj_random_8.item
				io.put_string (r.out + "  ")
				jj_random_8.forth
				i := i + 1
			end
		end

	test_range
			-- Create the first few random numbers.
		local
			i, c: INTEGER
			a, b: NATURAL_64
			r: NATURAL_64
			tab: HASH_TABLE [INTEGER, NATURAL_64]
		do
			create tab.make (50)
			a := 100
			b := 200
			jj_random.set_range (a, b)
			from i := 1
			until i > 100_000
			loop
				r := jj_random.item
				if tab.has (r) then
					tab.force (tab.item (r) + 1, r)
				else
					tab.extend (1, r)
				end
				jj_random.forth
				i := i + 1
			end
			from i := a.as_integer_32
			until i > b.as_integer_32
			loop
				c := tab.item (i.as_natural_64)
				io.put_string (i.out + " %T" + c.out + "%N")
				i := i + 1
			end
		end

	test_range_32
			-- Test distribution of 32-bit randoms.
		local
			i, c: INTEGER
			a, b: NATURAL_32
			r: NATURAL_32
			tab: HASH_TABLE [INTEGER, NATURAL_32]
		do
			create tab.make (50)
			a := 200
			b := 300
			jj_random_32.set_range (a, b)
			from i := 1
			until i > 100_000
			loop
				r := jj_random_32.item
				if tab.has (r) then
					tab.force (tab.item (r) + 1, r)
				else
					tab.extend (1, r)
				end
				jj_random_32.forth
				i := i + 1
			end
			from i := a.as_integer_32
			until i > b.as_integer_32
			loop
				c := tab.item (i.as_natural_32)
				io.put_string (i.out + " %T" + c.out + "%N")
				i := i + 1
			end
		end

	test_range_16
			-- Test distribution of 16-bit randoms
		local
			i, c: INTEGER
			a, b: NATURAL_16
			r: NATURAL_16
			tab: HASH_TABLE [INTEGER, NATURAL_16]
		do
			create tab.make (50)
			a := 300
			b := 400
			jj_random_16.set_range (a, b)
			from i := 1
			until i > 100
			loop
				r := jj_random_16.item
				io.put_string ("r16 = " + r.out + "%N")
				if tab.has (r) then
					tab.force (tab.item (r) + 1, r)
				else
					tab.extend (1, r)
				end
				jj_random_16.forth
				i := i + 1
			end
			from i := a
			until i > b
			loop
				c := tab.item (i.as_natural_16)
				io.put_string (i.out + " %T" + c.out + "%N")
				i := i + 1
			end
		end

	test_range_8
			-- Test distribution of 16-bit randoms
		local
			i, c: INTEGER
			a, b: NATURAL_8
			r: NATURAL_8
			tab: HASH_TABLE [INTEGER, NATURAL_16]
		do
			create tab.make (50)
			a := 0
			b := 255
			jj_random_8.set_range (a, b)
			from i := 1
			until i > 100
			loop
				r := jj_random_8.item
				io.put_string ("r8 = " + r.out + "%N")
				if tab.has (r) then
					tab.force (tab.item (r) + 1, r)
				else
					tab.extend (1, r)
				end
				jj_random_8.forth
				i := i + 1
			end
			from i := a
			until i > b
			loop
				c := tab.item (i.as_natural_8)
				io.put_string (i.out + " %T" + c.out + "%N")
				i := i + 1
			end
		end

feature -- Access

	Line_count: INTEGER = 40
		-- Used to clear console

	rand: RANDOM
			-- Force a compilation.
		once
			create Result.make
		end

	jj_random: JJ_RANDOM_64
		once
			create Result
		end

	jj_random_32: JJ_RANDOM_32
		once
			create Result
		end

	jj_random_16: JJ_RANDOM_16
		once
			create Result
		end

	jj_random_8: JJ_RANDOM_8
		once
			create Result
		end

end
