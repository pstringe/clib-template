# Compiler and tools
CC        = gcc
AR        = ar
ARFLAGS   = rcs

# Compiler flags
CFLAGS    = -Wall -Wextra -O2
PICFLAGS  = -fPIC

# Source files
SRC       = libtemplate.c
OBJS      = libtemplate.o

# Library names
STATIC_LIB  = libtemplate.a
DYNAMIC_LIB = libtemplate.so

# Main program (uses mylib.h)
MAIN_SRC      = main.c
MAIN_STATIC   = main_static
MAIN_DYNAMIC  = main_dynamic

# Test executable
TEST_EXEC = test_libtemplate

# Build test executable
test: $(STATIC_LIB) test_libtemplate.c
	$(CC) $(CFLAGS) test_libtemplate.c $(STATIC_LIB) -o $(TEST_EXEC)

# Run tests
run-tests: test
	./$(TEST_EXEC)

.PHONY: all clean static dynamic prog-static prog-dynamic

# Default target: build everything.
all: static dynamic prog-static prog-dynamic

# Build static library
static: $(STATIC_LIB)

$(STATIC_LIB): $(OBJS)
	$(AR) $(ARFLAGS) $@ $^

# Build dynamic (shared) library.
dynamic: $(DYNAMIC_LIB)

$(DYNAMIC_LIB): $(SRC)
	$(CC) $(PICFLAGS) -shared -o $@ $^

# Compile object file(s)
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Build executable linking statically.
# The -Wl,-Bstatic flag forces static linking.
prog-static: $(MAIN_SRC) $(STATIC_LIB)
	$(CC) $(CFLAGS) $(MAIN_SRC) -L. -llibtemplate -o $(MAIN_DYNAMIC)

# Build executable linking dynamically.
# The -Wl,-Bdynamic flag tells the linker to choose shared libraries.
prog-dynamic: $(MAIN_SRC) $(DYNAMIC_LIB)
	$(CC) $(CFLAGS) $(MAIN_SRC) -L. -llibtemplate -o $(MAIN_DYNAMIC) -Wl,-Bdynamic

# Clean up generated files.
clean:
	rm -f $(OBJS) $(STATIC_LIB) $(DYNAMIC_LIB) $(MAIN_STATIC) $(MAIN_DYNAMIC)
	rm -f $(TEST_EXEC) *.o

