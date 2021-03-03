bin/clang++ `bin/llvm-config --cxxflags` -c llvm_foo.cc  &&
bin/clang++ `bin/llvm-config --ldflags` \
    llvm_foo.o \
    `bin/llvm-config --system-libs` \
    `bin/llvm-config --libs`
