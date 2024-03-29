﻿note
	description: "[
		References to objects containing a natural value coded on `bit_count'
		number of bits.

		See JJ_NATURAL for summary of class modifications.
		]"
	author: "modified by Jimmy J. Johnson"
	date: "$Date$"
	revision: "$Revision$"
	library: "replaces file from Free implementation of ELKS library"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "original's date: 2012-05-23 21:13:10 -0700 (Wed, 23 May 2012)"
	revision: "original number 91981"

class
	NATURAL_8_REF

inherit

	JJ_NATURAL
		redefine
			is_hashable,
--			divisible,
			to_boolean,
			out
		end

feature -- Access

	bit_count: INTEGER = 8
			-- The number of bits used to represent Current

	jj_item: like item
			-- The value of Current.  The effected versions must wrap
			-- a call to `item'.  This was required because naming this
			-- `jj_item' gives a "Redeclaration changes expansion status" error.
		do
			Result := item
		end

	item: NATURAL_8
			-- Integer value
		external
			"built_in"
		end

	hash_code: INTEGER
			-- Hash code value
		do
			Result := item
		end

	sign: INTEGER
			-- Sign value (0, -1 or 1)
		do
			if item > 0 then
				Result := 1
			elseif item < 0 then
				Result := -1
			end
		ensure
			three_way: Result = three_way_comparison (zero)
		end

	zero: like Current
			-- Neutral element for "+" and "-"
		do
			create Result
			Result.set_item (0)
		end

	one: like Current
			-- Neutral element for "*" and "/"
		do
			create Result
			Result.set_item (1)
		end

	fifteen: like Current
			-- Useful for percondition in `to_hex_character'
		do
			create Result
			Result.set_item (15)
		end

	ascii_char: CHARACTER_8
			-- Returns corresponding ASCII character to `item' value.
		obsolete
			"Use to_character_8 instead."
		require
			valid_character_code: is_valid_character_8_code
		do
			Result := item.to_character_8
		end

	Min_value: NATURAL_8 = 0
			-- Smallest value Current can have

	Max_value: NATURAL_8 = 255
			-- Maximum value Current can have

	Half_mask_value: NATURAL_8 = 0xF0
			-- Half bits (most significant) set (i.e. 11110000)

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current integer less than `other'?
		do
			Result := item < other.item
		end

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object of the same type
			-- as current object and identical to it?
		do
			Result := other.item = item
		end

feature -- Element change

	set_item (i: NATURAL_8)
			-- Make `i' the `item' value.
		external
			"built_in"
		ensure then
			item_set: item = i
		end

feature -- Status report

	is_divisible (other: like Current): BOOLEAN
			-- May current object be divided by `other'?
		do
			Result := other.item /= 0
		ensure then
			value: Result = (other.item /= 0)
		end

	is_exponentiable (other: NUMERIC): BOOLEAN
			-- May current object be elevated to the power `other'?
		do
			if attached {INTEGER_32_REF} other as integer_value then
				Result := integer_value.item >= 0 or item /= 0
			elseif attached {REAL_32_REF} other as real_value then
				Result := real_value.item >= 0.0 or item /= 0
			elseif attached {REAL_64_REF} other as double_value then
				Result := double_value.item >= 0.0 or item /= 0
			end
		ensure then
			safe_values: ((other.conforms_to (0) and item /= 0) or
				(other.conforms_to (0.0) and item > 0)) implies Result
		end

	is_hashable: BOOLEAN
			-- May current object be hashed?
			-- (True if it is not its type's default.)
		do
			Result := item /= 0
		end

	is_valid_character_8_code: BOOLEAN
			-- Does current object represent a CHARACTER_8?
		do
			Result := True
		ensure then
			in_bounds: Result = (item >= {CHARACTER_8}.Min_value and item <= {CHARACTER_8}.Max_value)
		end

	is_valid_character_32_code: BOOLEAN
			-- Does current object represent a CHARACTER_32?
		do
			Result := True
		ensure then
			in_bounds: Result = (item >= {CHARACTER_32}.Min_value and item <= {CHARACTER_32}.Max_value)
		end

feature -- Basic operations

--	add (a_other: like Current)
--			-- Change Current to the sum of Current and `a_other'
--		do
--			set_item (Current + a_other)
--		end

	plus alias "+" (other: like Current): like Current
			-- Sum with `other'
		do
			create Result
			Result.set_item (item + other.item)
		end

	minus alias "-" alias "−" (other: like Current): like Current
--	minus alias "-" (other: like Current): like Current
			-- Result of subtracting `other'
		do
			create Result
			Result.set_item (item - other.item)
		end

	product alias "*" alias "×" (other: like Current): like Current
--	product alias "*" (other: like Current): like Current
			-- Product by `other'
		do
			create Result
			Result.set_item (item * other.item)
		end

	quotient alias "/" alias "÷" (other: like Current): REAL_64
--	quotient alias "/" (other: like Current): REAL_64
			-- Division by `other'
		require
			other_exists: other /= Void
			good_divisor: is_divisible (other)
		do
			Result := item / other.item
		end

	identity alias "+": like Current
			-- Unary plus
		do
			create Result
			Result.set_item (+ item)
		end

	integer_quotient alias "//" (other: like Current): like Current
			-- Integer division of Current by `other'
		do
			create Result
			Result.set_item (item // other.item)
		end

	integer_remainder alias "\\" (other: like Current): like Current
			-- Remainder of the integer division of Current by `other'
		do
			create Result
			Result.set_item (item \\ other.item)
		end

	power alias "^" (other: REAL_64): REAL_64
			-- Integer power of Current by `other'
		do
			Result := item ^ other
		end

	interval alias "|..|" (other: INTEGER): INTEGER_INTERVAL
			-- Interval from current element to `other'
			-- (empty if `other' less than current integer)
		do
			create Result.make (item, other)
		end

feature {NONE} -- Conversion

	make_from_reference (v: NATURAL_8_REF)
			-- Initialize `Current' with `v.item'.
		require
			v_not_void: V /= Void
		do
			set_item (v.item)
		ensure
			item_set: item = v.item
		end

feature -- Conversion

	to_reference: NATURAL_8_REF
			-- Associated reference of Current
		do
			create Result
			Result.set_item (item)
		ensure
			to_reference_not_void: Result /= Void
		end

	frozen to_boolean: BOOLEAN
			-- True if not `zero'.
		do
			Result := item /= 0
		end

	as_same_type (a_other: JJ_NATURAL): like Current
			-- Result of converting `a_other' to the same type as Current,
			-- with possible data lose
		do
			Result := a_other.as_natural_8
		end

	as_natural_8: NATURAL_8
			-- Convert `item' into an NATURAL_8 value.
		do
			Result := item.as_natural_8
		end

	as_natural_16: NATURAL_16
			-- Convert `item' into an NATURAL_16 value.
		do
			Result := item.as_natural_16
		end

	as_natural_32: NATURAL_32
			-- Convert `item' into an NATURAL_32 value.
		do
			Result := item.as_natural_32
		end

	as_natural_64: NATURAL_64
			-- Convert `item' into an NATURAL_64 value.
		do
			Result := item.as_natural_64
		end

	as_integer_8: INTEGER_8
			-- Convert `item' into an INTEGER_8 value.
		do
			Result := item.as_integer_8
		end

	as_integer_16: INTEGER_16
			-- Convert `item' into an INTEGER_16 value.
		do
			Result := item.as_integer_16
		end

	as_integer_32: INTEGER_32
			-- Convert `item' into an INTEGER_32 value.
		do
			Result := item.as_integer_32
		end

	as_integer_64: INTEGER_64
			-- Convert `item' into an INTEGER_64 value.
		do
			Result := item.as_integer_64
		end

	from_hex_string (a_string: STRING_8)
			-- Set Current based on `a_string'
		do
			set_item (a_string.to_natural_8)
		end

	is_valid_creation_string (a_string: STRING_8): BOOLEAN
			-- Can `a_string' be used to initialize Current?
		do
			Result := a_string.is_natural_8
		end

feature -- Bit operations

--	most_significant_bit, log_base_two: INTEGER
--			-- The index (starting with one at the least significant bit
--			-- and increasing up to `bit_count' for the most significant
--			-- bit) of the most significant bit that is set.
--		local
--			n: JJ_NATURAL
--			b: ARRAY [like Current]
--			s: ARRAY [like Current]
--			i: INTEGER
--		do
--				-- See https://graphics.stanford.edu/~seander/bithacks.html
--			n := Current
--			b := <<0x2, 0xC, 0xF0, 0xFF00, 0xFFFF0000>>
--			s := <<1, 2, 4, 8, 16>>
--			from i := 4
--			until i < 0
--			loop
--				if n.bit_and (b[i]) > 0 then
--					n := n.bit_shift_right (s[i])
--					Result := Result.bit_or (s[i])
--				end
--				i := i - 1
--			end
--		end

	bit_and alias "&" alias "⊗" (i: like Current): like Current
--	bit_and alias "&" (i: like Current): like Current
			-- Bitwise and between Current' and `i'.
		do
			create Result
			Result.set_item (item.bit_and (i.item))
		end

	bit_or alias "|" alias "⦶" (i: like Current): like Current
--	bit_or alias "|" (i: like Current): like Current
			-- Bitwise or between Current' and `i'.
		do
			create Result
			Result.set_item (item.bit_or (i.item))
		end

	bit_xor alias "⊕" (i: like Current): like Current
--	bit_xor (i: like Current): like Current
			-- Bitwise xor between Current' and `i'.
		do
			create Result
			Result.set_item (item.bit_xor (i.item))
		end

	bit_not alias "⊝": like Current
--	bit_not: like Current
			-- One's complement of Current.
		do
			create Result
			Result.set_item (item.bit_not)
		end

	frozen bit_shift (n: INTEGER): like Current
			-- Shift Current from `n' position to right if `n' positive,
			-- to left otherwise.
		do
			if n > 0 then
				Result := bit_shift_right (n)
			else
				Result := bit_shift_left (- n)
			end
		end

	bit_shift_left alias "|<<" alias "⧀" (n: INTEGER): like Current
--	bit_shift_left alias "|<<" (n: INTEGER): like Current
			-- Shift Current from `n' position to left.
		do
			create Result
			Result.set_item (item.bit_shift_left (n))
		end

	bit_shift_right alias "|>>" alias "⧁" (n: INTEGER): like Current
--	bit_shift_right alias "|>>" (n: INTEGER): like Current
			-- Shift Current from `n' position to right.
		do
			create Result
			Result.set_item (item.bit_shift_right (n))
		end

	frozen bit_test (n: INTEGER): BOOLEAN
			-- Test `n'-th position of Current.
		do
			Result := item & ((1).to_natural_8 |<< n) /= 0
		end

	frozen set_bit (b: BOOLEAN; n: INTEGER): like Current
			-- Copy of current with `n'-th position
			-- set to 1 if `b', 0 otherwise.
		do
			if b then
				Result := item | ((1).to_natural_8 |<< n)
			else
				Result := item & ((1).to_natural_8 |<< n).bit_not
			end
		end

	frozen set_bit_with_mask (b: BOOLEAN; m: NATURAL_8): NATURAL_8
			-- Copy of current with all 1 bits of m set to 1
			-- if `b', 0 otherwise.
		do
			if b then
				Result := item | m
			else
				Result := item & m.bit_not
			end
		end

feature -- Output

	out: STRING
			-- Printable representation of integer value
		do
			create Result.make (3)
			Result.append_natural_8 (item)
		end

feature {NONE} -- Implementation

	b_array: ARRAY [like Current]
			-- Helper function for `log_base_two'
			-- A function because cannot add attribute to built-in class
		do
			Result := {ARRAY [NATURAL_8]} <<0x2, 0xC, 0xF0>>
		end

	s_array: ARRAY [INTEGER]
			-- Helper function for `log_base_two'
			-- A function because cannot add attribute to built-in class
		do
			Result := {ARRAY [INTEGER]} <<1, 2, 4>>
		end

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
