note
	description: "[
		Tests for the JJ_RANDOM} classes.
		]"
	author: "Jimmy J. Johnson"
	date: "5/8/20"
	revision: "$Revision$"

class
	JJ_RANDOMS_TESTER

inherit

	ANY
		redefine
			default_create
		end

creation
	default_create

feature {NONE} -- Initialization

	default_create
			-- Create an instance
		local
			n: NATURAL_8
		do
			create random_8
			create random_16
			create random_32
			create random_64
			create array.make_empty
			random := random_8
		end

feature -- Access

feature -- Element change

	set_range_8 (a_first, a_last: like random_8.item)
			-- Force Current to run statistics for 8-bit generator and
			-- set its range to `a_first' through `a_last' inclusive.
		do
			random_8.set_range (a_first, a_last)
			random := random_8
		end

	set_range_16 (a_first, a_last: like random_16.item)
			-- Force Current to run statistics for 16-bit generator and
			-- set its range to `a_first' through `a_last' inclusive.
		do
			random_16.set_range (a_first, a_last)
			random := random_16
		end

	set_range_32 (a_first, a_last: like random_32.item)
			-- Force Current to run statistics for 32-bit generator and
			-- set its range to `a_first' through `a_last' inclusive.
		do
			random_32.set_range (a_first, a_last)
			random := random_32
		end

	set_range_64 (a_first, a_last: like random_64.item)
			-- Force Current to run statistics for 64-bit generator and
			-- set its range to `a_first' through `a_last' inclusive.
		do
			random_64.set_range (a_first, a_last)
			random := random_64
		end

feature -- Basic operations

	run_all
			-- Call all the test features
		do
				-- Test with default (i.e. with `random_8' with range [0..255]
			test
				-- Test with other ranges
			set_range_8 (150, 250)
			test
				-- ARRAY can only index up to half of the positie range
			set_range_32 (0, {NATURAL_32}.max_value // 8)
			test
		end

	test
			-- Produce numbers, show them, and print stats
		do
			test_random
			show_array
			show_statistics
		end

feature {NONE} -- Implementation

	test_random
			-- Create some 8-bit numbers.
		local
			i: INTEGER
			n: JJ_NATURAL
		do
			create array.make_filled (0, random.lower.to_integer_32, random.upper.to_integer_32)
			from i := 1
			until i > count
			loop
				n := random.item
				array[n.to_integer_32] := array[n.to_integer_32] + 1
				random.forth
				i := i + 1
			end
		end

	show_array
			-- Display a chart depicting distribution
		local
			i, c: INTEGER
		do
			print ("%N%N")
			print ("Distribution in order %N")
			from i := array.lower
			until i > array.upper
			loop
				print (i.out + "  ")
				from c := 1
				until c > array.item (i)
				loop
					io.print ("*")
					c := c + 1
				end
				print ("%N")
				i := i + 1
			end
		end

	show_statistics
			-- Gather some infomation about the generated numbers
			-- that were stored in `array'.
		do
			io.put_string ("Kolmogorov-Smirnov = " + kolmogorov_smirnov.out + "%N")
		end

feature {NONE} -- Implementation

	kolmogorov_smirnov: REAL_64
			-- Apply the Kolmogorov-Smirnov test to data in `a_array', comparing
			-- the data to a normal distribution.
			-- As of 5/9/20 -- https://en.wikipedia.org/wiki/Kolmogorov-Smirnov_test
		local
			i: INTEGER_32
			fnx: REAL_64		-- F-sub-n of x (empirical distribution function)
			dif: REAL_64		-- Difference between distance of
			fx: REAL_64		-- Same for all x values in noramal distro
		do
			fx := (array.upper - array.lower) / count	-- normal distro
				-- `array' already holds the sum of values < X[i]
			from i := array.lower
			until i > array.upper
			loop
				fnx := array[i] / count
				dif := fnx - fx
				if dif < 0.0 then
					dif := -dif
				end
				if dif > Result then
					Result := dif
				end
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	random: JJ_NATURAL_RNG [JJ_NATURAL]
			-- The currently selected generator on which to run tests.

	random_8: JJ_NATURAL_8_RNG
			-- Generator for 8-bit random numbers

	random_16: JJ_NATURAL_16_RNG
			-- Generator for 16-bit random numbers

	random_32: JJ_NATURAL_32_RNG
			-- Generator for 16-bit random numbers

	random_64: JJ_NATURAL_64_RNG
			-- Generator for 16-bit random numbers

	array: ARRAY [INTEGER_32]
			-- Distribution of generated random numbers

	count: INTEGER_32 = 147_483_647
--	count: INTEGER_32 = 2_147_483_646
			-- Number of randoms to generate for the test.
			-- (One less than maximum integer.)

invariant

	generator_selected: random = random_8 or else random = random_32

end
