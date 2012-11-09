libosmpbfreader
===============

A simple C++ library to read OpenStreetMap binary files

It is released under the BSD licence (to be precise, the  3-clause license aka "New BSD License" aka "Modified BSD License".

Goal
****

We hope that this library will help people to parse osm.pbf files in C++.
This library only provides a scaffold to read the data. It does no transformation.

We like a lot http://dev.omniscale.net/imposm.parser/ but wanted the same thing in C++.

Install
*******

The only dependency is libosmpbf. On debian/ubuntu just run::

	sudo apt-get install libosmpbf-dev

The library is a single header. No need to install or build anything.

Using it
********

The easiest is probably to look at the examples.

As it is a header only library, juste include the header file::

	#include "osmpbfreader.h"
	using namespace CanalTP;

To use the library you need to implement a struct having the following signature::
	
	struct Visitor {
	    void node_callback(uint64_t osmid, double lon, double lat, const Tags &tags){}
	    void way_callback(uint64_t osmid, const Tags &tags, const std::vector<uint64_t> &refs){}
	    void relation_callback(uint64_t osmid, const Tags &tags, const References &refs){}
	};

Tags and References are just typedefs::

	typedef std::map<std::string, std::string> Tags;
	typedef std::vector<std::pair<OSMPBF::Relation::MemberType, uint64_t> > References;

The functions are called every time a node, a way or a relation is encountered while reading the file.

.. warning::

	Don't expect the elements to be read in any specific order. For example the nodes of a way might not be parsed already.

Call the main function with the visitor you created::
	
	Visitor v;
	read_osm_pbf("your_file.osm.pbf", v);



Performances
************

Just reading (and doing nothing with the data) a europe extract (8Gb) requires 10 minutes on recent desktop computer.

You must be very careful about the memory consumption if you plan to keep the nodes and ways on large files.
Roughly count on 1Gb memory usage for an 100Mb .osm.pbf file.
If you want to parse large files (like a whole continent or the planet), consider storing them on disk, e.g. using
http://fallabs.com/kyotocabinet/

Future work
***********

It will depend on your feedback ;)

We might add some concurrency to speed up the parsing. However it will require more dependencies and will
yield some synchronization problems in the visitor. Is it worth it?
