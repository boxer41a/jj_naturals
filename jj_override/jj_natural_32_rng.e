note
	description: "[
		A wrapper class to generate 32-bit natural numbers.
		]"
	author: "Jimmy J. Johnson"

class
	JJ_NATURAL_32_RNG

inherit

	JJ_NATURAL_RNG [NATURAL_32]

create
	default_create

feature -- Access

	item: NATURAL_32
			-- The number generated by Current
		do
			Result := melg_item.as_natural_32
		end

end
