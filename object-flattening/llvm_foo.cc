#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/Support/SourceMgr.h>
#include "llvm/Support/raw_ostream.h"

#include <iostream>
#include <iterator>
#include <set>
#include <vector>

using namespace llvm;
using namespace std;

vector<Type*> FlattenToElements(StructType* s) {
  vector<Type*> member_fields;
  for (auto e : s->elements()) {
    if (!e->isStructTy()) {
      member_fields.push_back(e);
      continue;
    }

    auto flattened_members = FlattenToElements(cast<StructType>(e));
    move(flattened_members.begin(), flattened_members.end(),
         back_inserter(member_fields));
  }

  return member_fields;
}

StructType* FlattenToStruct(StructType* s) {
  return StructType::create(FlattenToElements(s),
                            "Flattened " + s->getName().str());
}

int main(int argc, char** argv) {
  if (argc < 2) {
    cerr << "./a.out <llvm-bitcode>\n";
    return 0;
  }

  auto& os = outs();
  SMDiagnostic err;
  LLVMContext ctx;

  auto m = parseIRFile(argv[1], err, ctx);
  if (!m) {
    cerr << "parseIRFile() failed\n";
    return 0;
  }

  // Print all struct types in the module.
  // if a struct has a member variable that is also a struct,
  // the struct is stored in set for future flattening.
  set<StructType*> nested_structs;
  for (auto s : m->getIdentifiedStructTypes()) {
    cout << "\%" << s->getName().str() << endl;
    for (auto e : s->elements()) {
      e->print(os);
      cout << '\n';
      if (e->isStructTy())
        nested_structs.emplace(s);
    }
    cout << '\n';
  }

  // Flatten nested structs
  for (auto s : nested_structs) {
    auto f = FlattenToStruct(s);
    cout << "\%" << f->getName().str() << endl;
    for (auto e : f->elements()) {
      e->print(os);
      cout << '\n';
    }
    cout << '\n';
  }

  return 0;
}
