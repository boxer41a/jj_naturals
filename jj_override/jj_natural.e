note
	description: "[
		This class is a new common ancestor to the	NATURAL_xx_REF classes setting
		between NUMERIC and NATURAL_xx, mainly to abstract the bit-shift features.
		
		I made the following modifications to the NATURAL_xx_REF classes:

			1) Added JJ_NATURAL as ancestor
			2) Removed inheritance from NUMRIC, COMPARABLE, and HASHABLE.
				(This inheritance is now in JJ_NATURAL.)
			3) Effected new feature `bit_count' from JJ_NATURAL as once.
				If was not defined as an attribute, because, according to
				Manu, the compiler ignores, though it allows, attributes
				when they are added to any basic type.
			4) Declared as deferred most [if not all] the featues that are
				defined in the original NATURAL_xx_REF classes.  Assertions
				are included in these features but removed from the effected
				versions.
			5) Had to add `jj_item', requiring descendents to effect this
				feature in order to wrap a call to `item', because declaring
				`item' as deferred here gives "Redeclaration changes expansion
				status error".
				PROBLEM: this forces a feature call instead of direct access
				through external implementation as before.
			6) Frozen features are declared here and deleted from decendents.
			7) Moved the pre- and post-conditions of `integer_remainder'
				up to {JJ_NATURAL}.  (Why do the other fetures not have
				similar assertions?)
			8) The comments on the conversion features were reworded from
				"convert `jj_item' into an NATURAL_xx value" to "A new object
				equivalent to Current."  (Saying "convert" implies Current is
				somehow	modified, which is not the case.)
			9) Reworked `to_hex_string' and `to_hex_character' and defined them
				in this class instead of in the NATURAL_xx_REF classes.
			10) Changed feature `divisible' to `is_divisible' and `exponetiable'
				 to `is_exponentiable'.
			11) Deleted `unapplicable_opposite' from rename clause, and added
				check statement to `opposite' to prevent calling.
			12) NO... Added modifying bit operations (e.g. `and_ed') corresponding to
				the original, non-modifying versions.  NO...did not work
			13) NO... Added modifying features (e.g. `add') to the basic operations that
				correspond to a non-modifying features.  NO...did not work because
				of build-in functions, I think.

		I need to complete the following:
			1) Fix the "not_to_big" preconditions on the conversion features.
			2) Find a work-around for `jj_item" problem mentioned above.

		I would like to have changed the signatures of `bit_shift_left' and
		`bit_shift_right' to take an argument like Current instead of INTEGER,
		but these features in the NATURAL_xx classes are built-in.
		]"
	author: "Jimmy J. Johnson"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	JJ_NATURAL

inherit

	NUMERIC
		rename
			divisible as is_divisible,
			exponentiable as is_exponentiable,
			quotient as integer_quotient alias "//"
		undefine
			is_equal
		end

	COMPARABLE
		undefine
			is_equal
		end

	HASHABLE
		undefine
			is_equal
		redefine
			is_hashable
		end

feature -- Access

	jj_item: JJ_NATURAL
			-- The value of Current.  The effected versions must wrap a call to
			-- `item'.  This was required because naming this `item' gives
			-- a "Redeclaration changes expansion status" error.
		deferred
		end

	bit_count: INTEGER
			-- The number of bits used to represent Current.
		deferred
		end

	zero: like Current
			-- Neutral element for "+" and "-".
		deferred
		end

	one: like Current
			-- Neutral element for "*" and "/".
		deferred
		end

	fifteen: like Current
			-- Useful for percondition in `to_hex_character'.
		deferred
		end

	min_value: like Current
			-- The smallest allowed value for Current.
		deferred
		ensure
			result_is_zero: Result = zero
		end

	max_value: like Current
			-- The largest value allowed for Current.
		deferred
		end


feature -- Comparison

--	is_less alias "<" (other: like Current): BOOLEAN
--			-- Is current integer less than `other'?
--		do
--			Result := jj_item < other.jj_item
--		end

--	is_equal (other: like Current): BOOLEAN
--			-- Is `other' attached to an object of the same type
--			-- as current object and identical to it?
--		do
--			Result := other.jj_item = jj_item
--		end

feature -- Element change

	set_item (a_value: like jj_item)
			-- Set `jj_item' to `a_value'.
			-- "Built-in" in the descendents.
		deferred
		ensure
			item_set: jj_item = a_value
		end

feature -- Status report

	is_even: BOOLEAN
			-- Is Current an even number?
		do
			Result := bit_test (1)
		end

	is_divisible (other: like Current): BOOLEAN
			-- May current object be divided by `other'?
		deferred
		ensure then
			value: Result = not (other.jj_item ~ zero)
		end

	is_exponentiable (other: NUMERIC): BOOLEAN
			-- May current object be elevated to the power `other'?
		deferred
		ensure then
			safe_values: ((other.conforms_to (zero) and not (jj_item = zero.jj_item)) or
				(other.conforms_to (0.0) and jj_item > zero.jj_item)) implies Result
		end

	is_hashable: BOOLEAN
			-- May current object be hashed?
			-- (True if it is not its type's default.)
		do
			Result := not (jj_item ~ zero)
		ensure then
			not_default_value: not (jj_item ~ zero)
		end

	is_valid_character_code: BOOLEAN
			-- Does current object represent a CHARACTER_8?
		obsolete
			"Use `is_valid_character_8_code' instead."
		do
			Result := is_valid_character_8_code
		end

	is_valid_character_8_code: BOOLEAN
			-- Does current object represent a CHARACTER_8?
		deferred
		end

	is_valid_character_32_code: BOOLEAN
			-- Does current object represent a CHARACTER_32?
		deferred
		end

feature -- Basic operations

--	add (a_other: like Current)
--			-- Change Current to the sum of Current and `a_other'
--		deferred
--		end

	integer_quotient alias "//" (other: like Current): like Current
			-- Integer division of Current by `other'.
		deferred
		end

	integer_remainder alias "\\" (other: like Current): like Current
			-- Remainder of the integer division of Current by `other'.
		require
			other_exists: other /= Void
			good_divisor: is_divisible (other)
		deferred
		ensure
			result_exists: Result /= Void
		end

	power alias "^" (other: REAL_64): REAL_64
			-- Integer power of Current by `other'.
		deferred
		end

	opposite alias "-" alias "−": like Current
--	opposite alias "-": like Current
			-- Unary minus (not applicable).
		do
			check
				do_not_call: false then
					-- because does not apply to naturals
			end
		ensure then
			not_applicable: False
		end

feature -- Conversion

	to_boolean: BOOLEAN
			-- True if not `zero'.
		do
			Result := jj_item /= zero
		end

	as_same_type (a_other: JJ_NATURAL): like Current
			-- Result of converting `a_other' to the same type as Current,
			-- with possible data lose.
		deferred
		end

	as_other_type (a_other: JJ_NATURAL): like a_other
			-- Result of converting Current to the type of `a_other',
			-- with possible data lose.
		do
				-- Check the type of `a_other'
			if a_other.same_type (create {NATURAL_8}) then
				Result := as_natural_8
			elseif a_other.same_type (create {NATURAL_16}) then
				Result := as_natural_16
			elseif a_other.same_type (create {NATURAL_32}) then
				Result := as_natural_32
			else
				Result := as_natural_64
			end
		end

	as_type (a_string: STRING_8): JJ_NATURAL
			-- To get a natural of the type described by `a_string'.
			-- Useful when JJ_NATURAL is used as a generic.
		require
			valid_string: a_string ~ (0).as_natural_8.generating_type or
						 a_string ~ (0).as_natural_16.generating_type or
						 a_string ~ (0).as_natural_32.generating_type or
						 a_string ~ (0).as_natural_64.generating_type
		do
			if a_string ~ (0).as_natural_8.generating_type then
				Result := as_natural_8
			elseif a_string ~ (0).as_natural_16.generating_type then
				Result := as_natural_16
			elseif a_string ~ (0).as_natural_32.generating_type then
				Result := as_natural_32
			else
				Result := as_natural_64
			end

		end

	as_natural_8: NATURAL_8
			-- Result of converting `jj_item' into a NATURAL_8.
			-- Data lose is possible if Current's representation is larger
			-- than the Result.
		deferred
		end

	as_natural_16: NATURAL_16
			-- Result of converting `jj_item' into a NATURAL_16.
			-- Data lose is possible if Current's representation is larger
			-- than the Result.
		deferred
		end

	as_natural_32: NATURAL_32
			-- Result of converting `jj_item' into a NATURAL_32.
			-- Data lose is possible if Current's representation is larger
			-- than the Result.
		deferred
		end

	as_natural_64: NATURAL_64
			-- Result of converting `jj_item' into a NATURAL_64.
			-- Data lose is possible if Current's representation is larger
			-- than the Result.
		deferred
		end

	as_integer_8: INTEGER_8
			-- Result of converting `jj_item' into an INTEGER_8.
			-- Data lose is possible if Current's representation is larger
			-- than the Result.
		deferred
		end

	as_integer_16: INTEGER_16
			-- Result of converting `jj_item' into an INTEGER_16.
			-- Data lose is possible if Current's representation is larger
			-- than the Result.
		deferred
		end

	as_integer_32: INTEGER_32
			-- Result of converting `jj_item' into an INTEGER_32.
			-- Data lose is possible if Current's representation is larger
			-- than the Result.
		deferred
		end

	as_integer_64: INTEGER_64
			-- Result of converting `jj_item' into an INTEGER_64.
			-- Data lose is possible if Current's representation is larger
			-- than the Result.
		deferred
		end

	frozen to_natural_8: NATURAL_8
			-- Result of converting Current.
			-- Current's value must fit into the Result.
		require
--			not_too_big: jj_item <= {NATURAL_8}.Max_value
		do
			Result := as_natural_8
		end

	 frozen to_natural_16: NATURAL_16
			-- Result of converting Current.
			-- Current's value must fit into the Result.
		require
--			not_too_big: jj_item <= {NATURAL_16}.Max_value
		do
			Result := as_natural_16
		end

	frozen to_natural_32: NATURAL_32
			-- Result of converting Current.
			-- Current's value must fit into the Result.
		require
--			not_too_big: jj_item <= {NATURAL_32}.Max_value
		do
			Result := as_natural_32
		end

	frozen to_natural_64: NATURAL_64
			-- Result of converting Current.
			-- Current's value must fit into the Result.
		require
--			not_too_big: jj_item <= {NATURAL_64}.Max_value
		do
			Result := as_natural_64
		end

	frozen to_integer_8: INTEGER_8
			-- Result of converting Current.
			-- Current's value must fit into the Result.
		require
--			not_too_big: jj_item <= {INTEGER_8}.Max_value.to_natural_8
		do
			Result := as_integer_8
		end

	frozen to_integer_16: INTEGER_16
			-- Result of converting Current.
			-- Current's value must fit into the Result.
		require
--			not_too_big: jj_item <= {INTEGER_16}.Max_value.to_natural_8
		do
			Result := as_integer_16
		end

	frozen to_integer_32: INTEGER_32
			-- Result of converting Current.
			-- Current's value must fit into the Result.
		require
--			not_too_big: jj_item <= {INTEGER_32}.Max_value.to_natural_8
		do
			Result := as_integer_32
		end

	frozen to_integer_64: INTEGER_64
			-- Result of converting Current.
			-- Current's value must fit into the Result.
		require
--			not_too_big: jj_item <= {INTEGER_64}.Max_value.to_natural_8
		do
			Result := as_integer_64
		end

	to_real_32: REAL_32
			-- Result of converting Current.
		do
			Result := jj_item.to_real_32
		end

	to_real_64: REAL_64
			-- Result of converting Current.
		do
			Result := jj_item.to_real_64
		end

	from_hex_string (a_string: STRING_8)
			-- Set Current to the value represented by `a_string'
		require
			is_valid_creation_string: is_valid_creation_string (a_string)
		deferred
		end

	is_valid_creation_string (a_string: STRING_8): BOOLEAN
			-- Can `a_string' be used to initialize Current?
		deferred
		end

	frozen to_hex_string: STRING_8
			-- The representation of Current as a hexadecimal string.
		local
			a_digit: like Current
			m, mask: like Current
			i, n: INTEGER_32
		do
			m := nibble_mask
			n := bit_count // 4
			from
				i := 1
				create Result.make (n)
				Result.fill_blank
			until
				i > n
			loop
					-- Refresh val each time
				a_digit := jj_item
					-- And with `mask' to leave only the i-th nible
				a_digit := a_digit & m
					-- Shift `a_digit' so nible is at the right
				a_digit := a_digit.bit_shift_right ((n - i) * 4)
				Result.put (a_digit.to_hex_character, i)
					-- Shift the mask to zero all but the desired nible,
					-- starting with high-order bits
				m := m.bit_shift_right (4)
				i := i + 1
			end
		ensure
			result_not_void: Result /= Void
			result_valid_count: Result.count = bit_count // 4
		end

	frozen nibble_mask: like Current
			-- Build a bit pattern used by `to_hex_string' to mask out all
			-- but the high-order four bits.
			-- Used this feature because cannot say "mask = 0xF" because the
			-- hex value is not compatible with the type of `jj_item'
		local
			i: INTEGER
			n: INTEGER
		do
				-- Start with all zero's
			Result := min_value
			Result := Result + one
				-- Shift left to push one's into the four higher bits
			from i := 1
			until i > 3
			loop
				Result := Result.bit_shift_left (1)
				Result := Result + one
				i := i + 1
			end
				-- Shift the four one's so they are in the four high-order bits
			Result := Result.bit_shift_left (((bit_count // 4) - 1) * 4)
		end

	frozen byte_mask (a_byte: INTEGER): like Current
			-- Build a bit pattern with zeros in all the bytes except the byte
			-- indicated by `a_byte', where `a_byte' starts at one for the
			-- low-order byte.
			-- For example, for a 32 bit number (`n' between 1 and 4) for `n'
			-- set to 2:  00000000 00000000 11111111 00000000.
		require
			byte_big_enough: a_byte >= 1
			byte_small_enough: a_byte <= bit_count // 8
		local
			i: INTEGER
			n: INTEGER
		do
				-- Start with all zero's
			Result := min_value
				-- Add one and shift left until the byte is full of one's
			Result := Result + one
			from i := 1
			until i > 7
			loop
				Result := Result.bit_shift_left (1)
				Result := Result + one
				i := i + 1
			end
				-- Shift the eight one's so they are in the byte indicated
				-- by `a_byte'
			Result := Result.bit_shift_left ((a_byte - 1) * 8)
		end

	to_hex_character: CHARACTER_8
			-- The representation of Current as a hexadecimal character.
		require
			in_bounds: zero <= jj_item and jj_item <= fifteen.jj_item
		local
			tmp: INTEGER
		do
			tmp := jj_item.to_integer_32
			if tmp <= 9 then
				Result := (tmp + ('0').code).to_character_8
			else
				Result := (('A').code + (tmp - 10)).to_character_8
			end
		ensure
			valid_character: ("0123456789ABCDEF").has (Result)
		end

	to_character: CHARACTER
			-- Returns corresponding ASCII character to `jj_item' value.
		obsolete
			"Use `to_character_8' instead."
		require
			valid_character: is_valid_character_8_code
		do
			Result := jj_item.to_character_8
		end

	to_character_8: CHARACTER_8
			-- Associated character in 8 bit version.
		require
			valid_character: is_valid_character_8_code
		do
			Result := jj_item.to_character_8
		end

	to_character_32: CHARACTER_32
			-- Associated character in 32 bit version.
		require
			valid_character: is_valid_character_32_code
		do
			Result := jj_item.to_character_32
		end

feature -- Bit operations

	most_significant_bit: INTEGER
			-- The index of the most significant bit that is set.
			-- O(n) where n is the number of bits.
		local
			n: JJ_NATURAL
			i: INTEGER
		do
				-- Naive approach, but not the same as `log_base_two'
				-- as implied in "Bit Twiddling Hacks" at
				-- https://graphics.stanford.edu/~seander/bithacks.html.
				-- S. Anderson's `log_base_two' assumes zero-based indexing
				-- and will be one off for bit position (and does not apply
				-- to log(0), because it gives zero as answer even though
				-- none of the bits are set.
			from n := Current
			until n <= zero
			loop
				Result := Result + 1
				n := n.bit_shift_right (1)
			end
		ensure
			zero_result_definition: Result = zero implies Current = zero
			result_small_enough: Result <= bit_count
		end

	log_base_two: INTEGER
			-- The base-2 log of Current
		local
			v: JJ_NATURAL
			b: ARRAY [like Current]
			s: ARRAY [INTEGER]
			i: INTEGER
		do
				-- See https://graphics.stanford.edu/~seander/bithacks.html
			v := Current
			b := b_array
			s := s_array
			from i := b.count
			until i <= 0
			loop
				if v.bit_and (b[i]) > zero then
					v := v.bit_shift_right (s[i])
					Result := Result.bit_or (s[i])
				end
				i := i - 1
			end
		ensure
			zero_result_definition: Result = zero implies Current ~ zero
			result_small_enough: Result <= bit_count
		end

	bit_and alias "&" alias "⊗" (i: like Current): like Current
--	bit_and alias "&" (i: like Current): like Current
			-- Bitwise and between Current' and `i'.
		require
			i_not_void: i /= Void
		deferred
		ensure
			bitwise_and_not_void: Result /= Void
		end

	bit_or alias "|" alias "⦶" (i: like Current): like Current
--	bit_or alias "|" (i: like Current): like Current
			-- Bitwise or between Current' and `i'.
		require
			i_not_void: i /= Void
		deferred
		ensure
			bitwise_or_not_void: Result /= Void
		end

	bit_xor alias "⊕" (i: like Current): like Current
--	bit_xor (i: like Current): like Current
			-- Bitwise xor between Current' and `i'.
		require
			i_not_void: i /= Void
		deferred
		ensure
			bitwise_xor_not_void: Result /= Void
		end

	bit_not alias "⊝": like Current
--	bit_not: like Current
			-- One's complement of Current.
		deferred
		ensure
			bit_not_not_void: Result /= Void
		end

	bit_shift (n: INTEGER): JJ_NATURAL
			-- Shift Current from `n' position to right if `n' positive,
			-- to left otherwise.
		require
			n_less_or_equal_to_16: n <= bit_count
			n_greater_or_equal_to_minus_16: n >= -bit_count
		deferred
		end

	bit_shift_left alias "|<<" alias "⧀" (n: INTEGER): like Current
--	bit_shift_left alias "|<<" (n: INTEGER): like Current
			-- Shift Current from `n' position to left.
		require
			n_nonnegative: n >= 0
			n_less_or_equal_to_16: n <= bit_count
		deferred
		ensure
			bit_shift_left_not_void: Result /= Void
		end

	bit_shift_right alias "|>>" alias "⧁" (n: INTEGER): like Current
--	bit_shift_right alias "|>>" (n: INTEGER): like Current
			-- Shift Current from `n' position to right.
		require
			n_nonnegative: n >= 0
			n_less_or_equal_to_16: n <= bit_count
		deferred
		ensure
			bit_shift_right_not_void: Result /= Void
		end

	bit_test (n: INTEGER): BOOLEAN
			-- Test `n'-th position of Current.
		require
			n_nonnegative: n >= 0
			n_less_than_16: n < bit_count
		deferred
		end

	set_bit (b: BOOLEAN; n: INTEGER): like Current
			-- Copy of current with `n'-th position
			-- set to 1 if `b', 0 otherwise.
		require
			n_nonnegative: n >= 0
			n_less_than_16: n < bit_count
		deferred
		end

	set_bit_with_mask (b: BOOLEAN; m: like Current): JJ_NATURAL
			-- Copy of current with all 1 bits of m set to 1
			-- if `b', 0 otherwise.
		deferred
		end

feature {NONE} -- Implementation

	b_array: ARRAY [like Current]
			-- Helper function for `log_base_two'
		deferred
		end

	s_array: ARRAY [INTEGER]
			-- Helper function for `log_base_two'
		deferred
		end

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
