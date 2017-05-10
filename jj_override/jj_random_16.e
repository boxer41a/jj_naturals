note
	description: "[
		Random number generator for 16-bit values.  Derived from
		JJ_RANDOM_32, this class simply returns 16 bits of the 
		generated 32-bit number.
		]"
	author: "Jimmy J. Johnson"

class
	JJ_RANDOM_16

inherit

	JJ_RANDOM [NATURAL_16]

create
	default_create

feature -- Access

feature -- Access

	Default_seed: NATURAL_16 = 1031
			-- The default value used for the `seed'.

feature {NONE} -- Implementation

	integer_to_word (a_value: INTEGER): like item
			-- Convert `a_value' to the correct type.
		do
			Result := a_value.as_natural_16
		end

feature {NONE} -- Implementation (constants)

	w: INTEGER = 32
			-- Word size (i.e. the number of bits in a word).

	n: INTEGER = 624
			-- The degree of recurrence.

	m: INTEGER = 397
			-- Middle word, an offset used in the recurrence relation
			-- defining the series.

	r: INTEGER = 31
			-- The separation point of one word, or the number of bits
			-- of the lower bitmask, 0 <= r <= w - 1.

	s: INTEGER = 7
			-- A bit shift.

	t: INTEGER  = 15
			-- A bit shift.

	u: INTEGER = 11
			-- A bit shift.

	z: INTEGER = 18
			-- A tempering bitmask.
			-- Was called "l" (i.e. elle) in the original and on Wiki, but
			-- an elle looks too much like a one.

	a: NATURAL_16 = 0x990F		--8B0DF
			-- The coefficients of the rational normal form twist matrix.

	b: NATURAL_16 = 0x9D2C		--5680
			-- A tempering bitmask.

	c: NATURAL_16 = 0xEF00		--C60000
			-- A tempering bitmask.

	d: NATURAL_16 = 0xFFFF
			-- A tempering bitmask.

	f: NATURAL_16 = 	27655	--1812433253
			-- Another parameter.

	lower_mask: NATURAL_16 = 0x007F
			-- Mask to obtain the lower `r' bits of a particular
			-- value from `mt'.

	upper_mask: NATURAL_16 = 0xFF80
			-- Mask to obtain the upper `w' - `r' bits of a particular
			-- value from `mt'.

end
