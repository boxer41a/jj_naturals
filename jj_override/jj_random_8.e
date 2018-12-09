note
	description: "[
		An 8-bit implementation of the Mersenne Twister algorithm originally
		described in "Mersenne Twister:  A 623-Dimensionally Equidistributed
		Uniform Pseudorandom Number Generator" by Makoto Matsumoto and Takuji
		Nishimura.
		]"
	author: "Jimmy J. Johnson"

class
	JJ_RANDOM_8

inherit

	JJ_RANDOM [NATURAL_8]

create
	default_create

feature -- Access

	Default_seed: NATURAL_8 = 47
			-- The default value used for the `seed'.

feature -- Implementation

	integer_to_word (a_value: INTEGER): like item
			-- Convert `a_value' to the correct type.
			-- Needed by this class and maybe convenient to others.
		do
			Result := a_value.to_natural_8
		end

feature {NONE} -- Implementation (constants)

	w: INTEGER = 8
			-- Word size (i.e. the number of bits in a word).

	n: INTEGER = 1401
			-- The degree of recurrence.

	m: INTEGER = 397
			-- Middle word, an offset summed with a counter in `twist' to
			-- index a particular word in `mt'.  It must be between 1 and n.

	r: INTEGER = 5
			-- The separation point of one word, or the number of bits
			-- of the lower bitmask, 0 <= r <= w - 1.

	s: INTEGER = 3
			-- A bit shift.

	t: INTEGER  = 4
			-- A bit shift.

	u: INTEGER = 5
			-- A bit shift.

	z: INTEGER = 18
			-- A tempering bitmask.
			-- Was called "l" (i.e. elle) in the original and on Wiki, but
			-- an elle looks too much like a one.

	a: NATURAL_8 = 0x99
			-- The coefficients of the rational normal form twist matrix.

	b: NATURAL_8 = 0x9D
			-- A tempering bitmask.

	c: NATURAL_8 = 0xEB
			-- A tempering bitmask.

	d: NATURAL_8 = 0xFF
			-- A tempering bitmask.

	f: NATURAL_8 = 109
			-- Another parameter.  Picked at random.

	lower_mask: NATURAL_8 = 0x07
			-- Mask to obtain the lower `r' bits of a particular
			-- value from `mt'.

	upper_mask: NATURAL_8 = 0xF8
			-- Mask to obtain the upper `w' - `r' bits of a particular
			-- value from `mt'.

end
