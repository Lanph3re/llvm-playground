struct Hello {
  char a_;
  char b_;
  char c_;
  char d_;
};

struct Foo {
  int x_;
  int y_[4];
  Hello hello_;
  Hello* hello_ptr_;
};

struct Bar {
  Foo foo_;
  void* ptr_;
  int* int_ptr_;
  short short_;
};

int main(int argc, char** argv) {
  Foo foo;
  foo.x_ = 1;

  Bar bar;
  bar.foo_.x_ = 10;
  for (int i = 0; i < bar.foo_.x_; ++i)
    foo.x_++;
}
