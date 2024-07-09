note
	description: "[
		Eiffel tests that can be executed by testing tool.
		
		This must be duplicated for all the natural types, changing only `value_8'.
		I tried anchored types, inheritance with anchors, and generic deferred
		class as root; none of these worked with the automatic tester.
	]"
	author: "Jimmy J. Johnson"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	JJ_NATURAL_8_TESTS

inherit

	EQA_TEST_SET
		redefine
			on_prepare
		end

feature -- Initialization

	on_prepare
		do
			value := value_8
			feature_name := "not set"
		end

feature -- Access

	class_name: STRING_8
			-- The name of this class
		do
			Result := value.generating_type
		end

	feature_name: STRING_8
			-- The name of the feature being tested.
			-- Set by each test feature.

	value_from_string (a_string: STRING_8): JJ_NATURAL
			-- To obtain a new object of correct type
		do
			Result := a_string.to_natural_8
		end

	value: JJ_NATURAL
			-- Holder for the current tested number

	value_8: NATURAL_8
			-- An eight-bit unsigned number

	value_16: NATURAL_16
			-- An 16-bit unsigned number

	value_32: NATURAL_32
			-- An 32-bit unsigned number

	value_64: NATURAL_64
			-- An 64-bit unsigned number


feature -- Basic operations

	run_all
		do
			item
			bit_count
			one
			zero
			fifteen
			min_value
			max_value
			is_less_1
			is_less_2
			is_less_3
			is_less_4
			byte_mask
			most_significant_bit
		end

feature -- Test routines

	test (a_expected: STRING_8; a_actual: STRING_8)
		do
			print (class_name + "." + feature_name +" %N")
			print ("%T expected = " + a_expected + "%N")
			print ("%T actual =   " + a_actual + "%N")
			assert (feature_name, a_actual.out ~ a_expected)
		end

	line
			-- Draw a line
		do
			print ("----------------------------------------------------------- %N")
		end

feature -- Test routines (Access)

	item
			-- Test properties calculations
		do
			feature_name := "item"
			value := value_8
			test ("0", value.out)
			value := value_16
			test ("0", value.out)
			value := value_32
			test ("0", value.out)
			value := value_64
			test ("0", value.out)
			line
		end

	bit_count
		do
			feature_name := "bit_count"
			value := value_8
			test ("8", {NATURAL_8}.bit_count.out)
			value := value_16
			test ("16", value.bit_count.out)
			value := value_32
			test ("32", value.bit_count.out)
			value := value_64
			test ("64", value.bit_count.out)
			line
		end

	zero
		do
			feature_name := "zero"
			value := value_8
			test ("0", value.zero.out)
			value := value_16
			test ("0", value.zero.out)
			value := value_32
			test ("0", value.zero.out)
			value := value_64
			test ("0", value.zero.out)
			line
		end

	one
		do
			feature_name := "one"
			value := value_8
			test ("1", value.one.out)
			value := value_16
			test ("1", value.one.out)
			value := value_32
			test ("1", value.one.out)
			value := value_64
			test ("1", value.one.out)
			line
		end

	fifteen
		do
			feature_name := "fifteen"
			value := value_8
			test ("15", value.fifteen.out)
			value := value_16
			test ("15", value.fifteen.out)
			value := value_32
			test ("15", value.fifteen.out)
			value := value_64
			test ("15", value.fifteen.out)
			line
		end

	min_value
		do
			feature_name := "min_value"
			value := value_8
			test ("0", value.min_value.out)
			value := value_16
			test ("0", value.min_value.out)
			value := value_32
			test ("0", value.min_value.out)
			value := value_64
			test ("0", value.min_value.out)
			line
		end

	max_value
		do
			feature_name := "max_value"
			value := value_8
			test ("255", value.max_value.out)
			value := value_16
			test ("65535", value.max_value.out)
			value := value_32
			test ("4294967295", value.max_value.out)
			value := value_64
			test ("18446744073709551615", value.max_value.out)
			line
		end

feature -- Test routines (Comparison)

	is_less_1
			-- Test properties calculations
		do
			feature_name := ".is_less_1  (28 < 10)"
			test ("False", (value_from_string ("28") < value_from_string ("10")).out)
		end

	is_less_2
			-- Test properties calculations
		do
			feature_name := ".is_less_2  (28 < 10)"
			test ("True", (value_from_string ("10") < value_from_string ("28")).out)
		end

	is_less_3
		do
			feature_name := ".is_less_3  (103 < 160)"
			test ("True", (value_from_string ("103") < value_from_string ("160")).out)
		end

	is_less_4
		do
			feature_name := ".is_less_4  (129 < 214)"
			test ("True", (value_from_string ("129") < value_from_string ("214")).out)
			line
		end

feature -- Test routines (Conversion)

	byte_mask
		do
				-- NATURAL_8
			feature_name := "byte_mask (1)"
			value := value_8
			test ("FF", value.byte_mask (1).to_hex_string)
				-- NATURAL_16
			value := value_16
			test ("00FF", value.byte_mask (1).to_hex_string)
			feature_name := "byte_mask (2)"
			test ("FF00", value.byte_mask (2).to_hex_string)
				-- NATURAL_32
			value := value_32
			feature_name := "byte_mask (1)"
			test ("000000FF", value.byte_mask (1).to_hex_string)
			feature_name := "byte_mask (2)"
			test ("0000FF00", value.byte_mask (2).to_hex_string)
			feature_name := "byte_mask (3)"
			test ("00FF0000", value.byte_mask (3).to_hex_string)
			feature_name := "byte_mask (4)"
			test ("FF000000", value.byte_mask (4).to_hex_string)
				-- NATURAL_64
			value := value_64
			feature_name := "byte_mask (1)"
			test ("00000000000000FF", value.byte_mask (1).to_hex_string)
			feature_name := "byte_mask (2)"
			test ("000000000000FF00", value.byte_mask (2).to_hex_string)
			feature_name := "byte_mask (3)"
			test ("0000000000FF0000", value.byte_mask (3).to_hex_string)
			feature_name := "byte_mask (4)"
			test ("00000000FF000000", value.byte_mask (4).to_hex_string)
			line
		end

feature -- Test routines (bit operations)

	most_significant_bit
		local
			n: NATURAL_8
			i: INTEGER
		do
			create n
			from
			until i > 17
			loop
				io.put_string ("i = " + i.out + "     ")
				io.put_string (n.out + "      msb = " + n.most_significant_bit.out + "%N")
				n := n + n.one
				i := i + 1
			end
		end

end


