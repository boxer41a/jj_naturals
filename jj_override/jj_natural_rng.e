note
	description: "[
		A pseudorandom number generator that uses a {MELG} class as
		implementation, converting the 64-bit value to the correct
		type in feature `item', which is effected in descendants.
	]"
	author: "Jimmy J. Johnson"

deferred class
	JJ_NATURAL_RNG [G -> JJ_NATURAL]

inherit

	MELG_607
		rename
			item as melg_item
		export
			{NONE}
				melg_item
		end

feature -- Access

	item: G
			-- A random number of the correct type
		deferred
		end

end
