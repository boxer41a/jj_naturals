# jj_naturals
Provides an [override cluster](./jj_override) which inserts class [JJ_NATURAL](./jj_override/jj_natural.e) NUMERIC and the  NATURAL\_xx\_REF classes in Eiffel.  As ancestor to the NATURAL\_xx classes, the [JJ_NATURAL](./jj_override/jj_natural.e) class allows for generic programming when the size of the natural (8, 16, 32, or 64-bits) does not matter but for which NUMERIC does not provide enough features (e.g. bit-shift operations).

Include the override cluster in a project to use the JJ\_NATURAL\_xx classes.


See the [secure-hash-algorithm classes](http://github.com/boxer41a/jj_sha) for an example use of this cluster.  The SHA classes seem elegant because the generic use of JJ\_NATURAL eliminates code duplication that would be required with the use of NATURAL\_32 and NATURAL\_64 directly.  Also, the bit operations included in JJ\_NATURAL would have to be accessed through some type of facilities class. 

The elegance comes at a price.  It seems that the runtime may unable to use the built-in access to the values [though item?] and is using a function call instead.  Perhaps this is slowing down programs that use this cluster.