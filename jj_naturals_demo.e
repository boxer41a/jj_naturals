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
			clear_terminal
				-- Make and run tests
			create t
--			t.run_all

--			test_random_64
--			test_random_32
--			test_random_16
			test_random_8
			test_range_8
--			test_range_64
--			test_range_32
--			test_range_16
--			test_range_8

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
			jj_random_8.set_range (0, 8)
			from i := 1
			until i > 50
			loop
				r := jj_random_8.item
				io.put_string (r.out + "  ")
				jj_random_8.forth
				i := i + 1
			end
		end

	test_range_64
			-- Create the first few random numbers.
		local
			i, c: INTEGER
			a, b: NATURAL_64
			r: NATURAL_64
			tab: HASH_TABLE [INTEGER, NATURAL_64]
			arr: ARRAY [INTEGER]
		do
			a := 100
			b := 200
			create tab.make (50)
			create arr.make_filled (0, a.to_integer_32, b.to_integer_32)
			jj_random.set_range (a, b)
			from i := 1
			until i > 10_000
			loop
				r := jj_random.item
				if tab.has (r) then
					tab.force (tab.item (r) + 1, r)
				else
					tab.extend (1, r)
				end
				arr.put (arr.item (r.to_integer_32) + 1, r.to_integer_32)
				jj_random.forth
				i := i + 1
			end
			show_distribution (tab)
			show_array (arr)
		end

	test_range_8
			-- Create some 8-bit numbers.
		local
			i, c: INTEGER
			a, b: NATURAL_8
			r: NATURAL_8
			tab: HASH_TABLE [INTEGER, NATURAL_8]
			arr: ARRAY [INTEGER]
		do
			a := 10
			b := 200
			create tab.make (50)
			create arr.make_filled (0, a.to_integer_32, b.to_integer_32)
			jj_random_8.set_range (a, b)
			from i := 1
			until i > 30_000
			loop
				r := jj_random_8.item
				if tab.has (r) then
					tab.force (tab.item (r) + 1, r)
				else
					tab.extend (1, r)
				end
				arr.put (arr.item (r.to_integer_32) + 1, r.to_integer_32)
				jj_random_8.forth
				i := i + 1
			end
--			show_distribution (tab)
			show_array (arr)
		end


	show_distribution (a_table: HASH_TABLE [INTEGER, JJ_NATURAL])
			-- Display a chart depicting the distribution of number in `a_table'.
		local
			i, c: INTEGER
			n: JJ_NATURAL
		do
			from a_table.start
			print ("%N%N")
			print ("Distribution in table %N")
			until a_table.after
			loop
				n := a_table.key_for_iteration
				c := a_table.item_for_iteration
				print (a_table.key_for_iteration.out + "  ")
				from i := 1
				until i > c
				loop
					print ("*")
					i := i + 1
				end
				print ("%N")
				a_table.forth
			end
		end

	show_array (a_array: ARRAY [INTEGER_32])
			-- Display a chart depicting distribution in order
		local
			i, c: INTEGER
		do
			print ("%N%N")
			print ("Distribution in order %N")
			from i := a_array.lower
			until i > a_array.upper
			loop
				print (i.out + "  ")
				from c := 1
				until c > a_array.item (i)
				loop
					io.print ("*")
					c := c + 1
				end
				print ("%N")
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

feature -- Access

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
