# jj_naturals
Provides an override cluster to insert a class between NUMERIC and the  NATURAL\_xx\_REF classes in Eiffel.  As ancestor to the NATURAL\_xx classes, the JJ_NATURAL class allows for generic programming when the size of the natural (8, 16, 32, or 64-bits) does not matter but for which NUMERIC does not provide enough features (e.g. bit-shift operations).

Include the override cluster in a project to use the JJ\_NATUAL\_xx classes.

Add an empty class called JJ_NATURAL to the "library/base/elks/kernel" cluster as described here:

 ![](JJ_NATURAL.png?raw=true)
 

For an example using this cluster see the SHA example found [here](http://github.com/boxer41a/jj_sha).