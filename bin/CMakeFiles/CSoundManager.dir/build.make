# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The program to use to edit the cache.
CMAKE_EDIT_COMMAND = /usr/bin/ccmake

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/ubuntu/Documents/Git/uSonifier

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ubuntu/Documents/Git/uSonifier/bin

# Include any dependencies generated for this target.
include CMakeFiles/CSoundManager.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/CSoundManager.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/CSoundManager.dir/flags.make

CMakeFiles/CSoundManager.dir/src/CSoundManager/CSoundManager.cpp.o: CMakeFiles/CSoundManager.dir/flags.make
CMakeFiles/CSoundManager.dir/src/CSoundManager/CSoundManager.cpp.o: ../src/CSoundManager/CSoundManager.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/ubuntu/Documents/Git/uSonifier/bin/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object CMakeFiles/CSoundManager.dir/src/CSoundManager/CSoundManager.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/CSoundManager.dir/src/CSoundManager/CSoundManager.cpp.o -c /home/ubuntu/Documents/Git/uSonifier/src/CSoundManager/CSoundManager.cpp

CMakeFiles/CSoundManager.dir/src/CSoundManager/CSoundManager.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/CSoundManager.dir/src/CSoundManager/CSoundManager.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/ubuntu/Documents/Git/uSonifier/src/CSoundManager/CSoundManager.cpp > CMakeFiles/CSoundManager.dir/src/CSoundManager/CSoundManager.cpp.i

CMakeFiles/CSoundManager.dir/src/CSoundManager/CSoundManager.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/CSoundManager.dir/src/CSoundManager/CSoundManager.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/ubuntu/Documents/Git/uSonifier/src/CSoundManager/CSoundManager.cpp -o CMakeFiles/CSoundManager.dir/src/CSoundManager/CSoundManager.cpp.s

CMakeFiles/CSoundManager.dir/src/CSoundManager/CSoundManager.cpp.o.requires:
.PHONY : CMakeFiles/CSoundManager.dir/src/CSoundManager/CSoundManager.cpp.o.requires

CMakeFiles/CSoundManager.dir/src/CSoundManager/CSoundManager.cpp.o.provides: CMakeFiles/CSoundManager.dir/src/CSoundManager/CSoundManager.cpp.o.requires
	$(MAKE) -f CMakeFiles/CSoundManager.dir/build.make CMakeFiles/CSoundManager.dir/src/CSoundManager/CSoundManager.cpp.o.provides.build
.PHONY : CMakeFiles/CSoundManager.dir/src/CSoundManager/CSoundManager.cpp.o.provides

CMakeFiles/CSoundManager.dir/src/CSoundManager/CSoundManager.cpp.o.provides.build: CMakeFiles/CSoundManager.dir/src/CSoundManager/CSoundManager.cpp.o

# Object files for target CSoundManager
CSoundManager_OBJECTS = \
"CMakeFiles/CSoundManager.dir/src/CSoundManager/CSoundManager.cpp.o"

# External object files for target CSoundManager
CSoundManager_EXTERNAL_OBJECTS =

libCSoundManager.a: CMakeFiles/CSoundManager.dir/src/CSoundManager/CSoundManager.cpp.o
libCSoundManager.a: CMakeFiles/CSoundManager.dir/build.make
libCSoundManager.a: CMakeFiles/CSoundManager.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX static library libCSoundManager.a"
	$(CMAKE_COMMAND) -P CMakeFiles/CSoundManager.dir/cmake_clean_target.cmake
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/CSoundManager.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/CSoundManager.dir/build: libCSoundManager.a
.PHONY : CMakeFiles/CSoundManager.dir/build

CMakeFiles/CSoundManager.dir/requires: CMakeFiles/CSoundManager.dir/src/CSoundManager/CSoundManager.cpp.o.requires
.PHONY : CMakeFiles/CSoundManager.dir/requires

CMakeFiles/CSoundManager.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/CSoundManager.dir/cmake_clean.cmake
.PHONY : CMakeFiles/CSoundManager.dir/clean

CMakeFiles/CSoundManager.dir/depend:
	cd /home/ubuntu/Documents/Git/uSonifier/bin && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ubuntu/Documents/Git/uSonifier /home/ubuntu/Documents/Git/uSonifier /home/ubuntu/Documents/Git/uSonifier/bin /home/ubuntu/Documents/Git/uSonifier/bin /home/ubuntu/Documents/Git/uSonifier/bin/CMakeFiles/CSoundManager.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/CSoundManager.dir/depend

