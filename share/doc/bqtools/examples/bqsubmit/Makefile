# Compiler
CC = cc

# Linker
LD = cc

# Compiler flags
CFLAGS = 

# Linker flags
LDFLAGS =

# Use this command to erase files
RM = /bin/rm -f

# List of generated object files
OBJS = ohms_law.o

# Program executable file name
PROG = ohms_law

# Top-level rule, to compile everything
all: $(PROG)

# Rule to link the program
$(PROG): $(OBJS)
	$(LD) $(LDFLAGS) $(OBJS) -o $(PROG)

# Rule for file "*.o"
%.o: %.c
	$(CC) $(CFLAGS) -c $<

# Rule for cleaning re-compilable files
clean:
	$(RM) $(PROG) $(OBJS)
