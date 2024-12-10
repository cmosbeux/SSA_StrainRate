# Define directories
SRC_DIR = src
BLD_DIR = bld

# Define the Fortran compiler
FC = elmerf90

# Define the source files and object files
SRC_FILES = $(wildcard $(SRC_DIR)/*.F90)
OBJ_FILES = $(patsubst $(SRC_DIR)/%.F90, $(BLD_DIR)/%.o, $(SRC_FILES))
EXE_FILES = $(patsubst $(SRC_DIR)/%.F90, $(BLD_DIR)/%, $(SRC_FILES))

# Default target
all: $(EXE_FILES)

# Link the object files to create the executables
$(BLD_DIR)/%: $(BLD_DIR)/%.o
	@mkdir -p $(BLD_DIR)
	$(FC) -o $@ $^ -fallow-argument-mismatch -DHAVE_PARMETIS -DCONTIG= -DHAVE_EXECUTECOMMANDLINE -DUSE_ISO_C_BINDINGS -DUSE_ARPACK -O2 -g -DNDEBUG -fPIC -shared -I/usr/local/Elmer-devel/share/elmersolver/include -L/usr/local/Elmer-devel/share/elmersolver/../../lib/elmersolver -Xlinker -rpath=/usr/local/Elmer-devel/share/elmersolver/../../lib/elmersolver/../../share/elmersolver/lib /usr/local/Elmer-devel/share/elmersolver/../../lib/elmersolver/../../share/elmersolver/lib/ElmerIceSolvers.so /usr/local/Elmer-devel/share/elmersolver/../../lib/elmersolver/../../share/elmersolver/lib/ElmerIceUSF.so -shared -lelmersolver

# Compile the source files to object files
$(BLD_DIR)/%.o: $(SRC_DIR)/%.F90
	@mkdir -p $(BLD_DIR)
	$(FC) -c -o $@ $<

# Clean up the build directory
clean:
	rm -rf $(BLD_DIR)

.PHONY: all clean
