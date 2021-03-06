CFLAGS=-Wall -Wextra -g

ifeq "$(CC)" "clang"
CFLAGS += -Weverything -std=c++11
else
GCC_HAS_STDC_FLAG = $(shell expr `g++ -dumpversion | cut -f1-2 -d.` \>= 4.7)
ifeq "$(GCC_HAS_STDC_FLAG)" "1"
CFLAGS+=-std=c++11
else
CFLAGS+=-std=c++0x
endif
endif

all: bin/mm

tests: test valgrind

bin:
	mkdir -p $@

bin/mm: main.cpp mm.h | bin
	$(CC) $(CFLAGS) -o $@ main.cpp -lstdc++

test: bin/mm
	bin/mm

valgrind: bin/mm
	valgrind bin/mm

clean:
	rm -rf bin
