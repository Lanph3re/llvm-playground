# Object Flattening

Unrolling structures recursively.

## Example

```
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
```

Structures in source code above can be flattened as follows.

```
%struct.Foo
i32
[4 x i32]
%struct.Hello = type { i8, i8, i8, i8 }
%struct.Hello*

%struct.Hello
i8
i8
i8
i8

%struct.Bar
%struct.Foo = type { i32, [4 x i32], %struct.Hello, %struct.Hello* }
i8*
i32*
i16

%Flattened struct.Foo
i32
[4 x i32]
i8
i8
i8
i8
%struct.Hello*

%Flattened struct.Bar
i32
[4 x i32]
i8
i8
i8
i8
%struct.Hello*
i8*
i32*
i16
```
