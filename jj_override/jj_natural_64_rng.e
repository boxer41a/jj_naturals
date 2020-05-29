note
	description: "[
		A 64-bit implementation of the Mersenne Twister algorithm originally
		described in "Mersenne Twister:  A 623-Dimensionally Equidistributed
		Uniform Pseudorandom Number Generator" by Makoto Matsumoto and Takuji
		Nishimura.
		]"
	author: "Jimmy J. Johnson"

class
	JJ_NATURAL_64_RNG

inherit

	JJ_NATURAL_RNG [NATURAL_64]

create
	default_create

feature -- Access

	Default_seed: NATURAL_64 = 5489
			-- The default value used for the `seed'.

feature {NONE} -- Implementation

	integer_to_word (a_value: INTEGER): like item
			-- Convert `a_value' to the correct type.
		do
			Result := a_value.as_natural_64
		end

feature {NONE} -- Implementation (constants)

	w: INTEGER = 64
			-- Word size (i.e. the number of bits in a word).

	n: INTEGER = 312
			-- The degree of recurrence.

	m: INTEGER = 156
			-- Middle word, an offset used in the recurrence relation
			-- defining the series.

	r: INTEGER = 31
			-- The separation point of one word, or the number of bits
			-- of the lower bitmask, 0 <= r <= w - 1.

	s: INTEGER = 17
			-- A bit shift.

	t: INTEGER  = 37
			-- A bit shift.

	u: INTEGER = 29
			-- A bit shift.

	z: INTEGER = 43
			-- A tempering bitmask.
			-- Was called "l" (i.e. elle) in the original and on Wiki, but
			-- an elle looks too much like a one.

	a: NATURAL_64 = 0xB5026F5AA96619E9
			-- The coefficients of the rational normal form twist matrix.

	b: NATURAL_64 = 0x71D67FFFEDA60000
			-- A tempering bitmask.

	c: NATURAL_64 = 0xFFF7EEE000000000
			-- A tempering bitmask.

	d: NATURAL_64 = 0x5555555555555555
			-- A tempering bitmask.

	f: NATURAL_64 = 6364136223846793005
			-- Another parameter.

	lower_mask: NATURAL_64 = 0x7FFFFFFF
			-- Mask to obtain the lower `r' bits of a particular
			-- value from `mt'.

	upper_mask: NATURAL_64 = 0xFFFFFFFF80000000
			-- Mask to obtain the upper `w' - `r' bits of a particular
			-- value from `mt'.

end
