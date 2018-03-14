# Thanks for writing this makefile Waitman Gobble <ns@waitman.net> 
CXX = g++

CXXFLAGS = -O3 -std=c++0x -Wall -Wextra

LDFLAGS = -lprotobuf-lite -losmpbf -lz 

PROGRAMS = \
example_routing \
example_counter

all: $(PROGRAMS)

example_routing: example_routing.cc osmpbfreader.h
	$(CXX) $(CXXFLAGS) -o $@ $< $(LDFLAGS)

example_counter: example_counter.cc osmpbfreader.h
	$(CXX) $(CXXFLAGS) -o $@ $< $(LDFLAGS)

clean:
	rm -f *.o core $(PROGRAMS)
