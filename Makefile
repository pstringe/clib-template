# Compiler and tools
CC        = gcc
AR        = ar
ARFLAGS   = rcs

# Compiler flags
CFLAGS    = -Wall -Wextra -O2
PICFLAGS  = -fPIC

# Source files
SRC       = mylib.c
OBJS      = mylib.o

# Library names
STATIC_LIB  = libmylib.a
DYNAMIC_LIB = libmylib.so

# Main program (uses mylib.h)
MAIN_SRC      = main.c
MAIN_STATIC   = main_static
MAIN_DYNAMIC  = main_dynamic

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
	$(CC) $(CFLAGS) $(MAIN_SRC) -L. -lmylib -o $(MAIN_DYNAMIC)

# Build executable linking dynamically.
# The -Wl,-Bdynamic flag tells the linker to choose shared libraries.
prog-dynamic: $(MAIN_SRC) $(DYNAMIC_LIB)
	$(CC) $(CFLAGS) $(MAIN_SRC) -L. -lmylib -o $(MAIN_DYNAMIC) -Wl,-Bdynamic

# Clean up generated files.
clean:
	rm -f $(OBJS) $(STATIC_LIB) $(DYNAMIC_LIB) $(MAIN_STATIC) $(MAIN_DYNAMIC)

