# jj_naturals
Provides an override cluster to insert a class between NUMERIC and the  NATURAL_xxx_REF classes in Eiffel.  As ancestor to the NATURAL_xxx classes, the JJ_NATURAL class allows for generic programming when they size of the natural (8, 16, 32, or 64-bits) does not matter but for which NUMERIC does not provide enough features (e.g. bit-shift operations).

Include the override cluster in a project to use the JJ_NATUAL_xxx classes.
