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

create
	default_create

feature {NONE} -- Initialization

	default_create
			-- Create an instance
		do
--			histogram
		end

feature -- Access

feature -- Basic operations

	run_all
			-- Run the tests
		do
--			check_items
			histogram
		end

feature {NONE} -- Implementation

	check_items
			-- Check the first 1000 generated numbers against
			-- expected values
		local
			a: ARRAY [NATURAL_32]
			f: PLAIN_TEXT_FILE
			s: STRING
			i: INTEGER
			rand: JJ_NATURAL_32_RNG
			n, r: NATURAL_32
		do
			io.put_string ("`check_items: %N")
			a := {ARRAY [NATURAL_32]} <<123, 234, 345, 456>>
			create rand.from_array (a)
			io.put_string (" check items:  just after create rand %N")
			create f.make_open_read ("mt19937ar/mt19937ar.out")
			f.read_line
			io.put_string (f.last_string + "%N")
			from i := 1
			until i > 10
			loop
				f.read_natural_32
				n := f.last_natural_32
				r := rand.item
				rand.forth
				io.put_string ("i = " + i.out + "     n = " + n.out + "     r = " + r.out)
				if n /= r then
					io.put_string ("    no match ")
				end
				io.put_string ("%N")
				i := i + 1
			end
			f.close
		end

	histogram
			-- Create some random numbers.
		local
			r: JJ_NATURAL_32_RNG
			a: ARRAY [INTEGER_32]
			i, c: INTEGER
			n: NATURAL_32
		do
			create r
			io.put_string ("  histogram:  right after create r %N")
			r.set_range (0, 1000)
			create a.make_filled (0, r.lower.to_integer_32, r.upper.to_integer_32)
			from i := 1
			until i > (r.upper * (100).as_natural_32).as_integer_32
			loop
				n := r.item
				a[n.to_integer_32] := a[n.to_integer_32] + 1
				r.forth
				i := i + 1
			end
				-- Show the histogram
			print ("%N%N")
			print ("Distribution in order %N")
			from i := a.lower
			until i > a.upper
			loop
				print (i.out + "  ")
				from c := 1
				until c > a.item (i)
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
--			fx := (array.upper - array.lower) / count	-- normal distro
--				-- `array' already holds the sum of values < X[i]
--			from i := array.lower
--			until i > array.upper
--			loop
--				fnx := array[i] / count
--				dif := fnx - fx
--				if dif < 0.0 then
--					dif := -dif
--				end
--				if dif > Result then
--					Result := dif
--				end
--				i := i + 1
--			end
		end

feature {NONE} -- Implementation

	count: INTEGER_32 = 1000
--	count: INTEGER_32 = 147_483_647
--	count: INTEGER_32 = 2_147_483_646
			-- Number of randoms to generate for the test.
			-- (One less than maximum integer.)

end
