note
	description: "[
		A 32-bit implementation of the Mersenne Twister algorithm originally
		described in "Mersenne Twister:  A 623-Dimensionally Equidistributed
		Uniform Pseudorandom Number Generator" by Makoto Matsumoto and Takuji
		Nishimura.
		]"
	author: "Jimmy J. Johnson"

class
	JJ_NATURAL_32_RNG

inherit

	JJ_NATURAL_RNG [NATURAL_32]

create
	default_create

feature -- Access

	Default_seed: NATURAL_32 = 5489
			-- The default value used for the `seed'.

feature {NONE} -- Implementation

	integer_to_word (a_value: INTEGER): like item
			-- Convert `a_value' to the correct type.
		do
			Result := a_value.as_NATURAL_32
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

	a: NATURAL_32 = 0x9908B0DF
			-- The coefficients of the rational normal form twist matrix.

	b: NATURAL_32 = 0x9D2C5680
			-- A tempering bitmask.

	c: NATURAL_32 = 0xEFC60000
			-- A tempering bitmask.

	d: NATURAL_32 = 0xFFFFFFFF
			-- A tempering bitmask.

	f: NATURAL_32 = 1812433253
			-- Another parameter.

	lower_mask: NATURAL_32 = 0x7FFFFFFF
			-- Mask to obtain the lower `r' bits of a particular
			-- value from `mt'.

	upper_mask: NATURAL_32 = 0xFFFF8000
			-- Mask to obtain the upper `w' - `r' bits of a particular
			-- value from `mt'.

end
