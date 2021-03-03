; ModuleID = 'foo.bc'
source_filename = "foo.cc"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx11.0.0"

%struct.Foo = type { i32, [4 x i32], %struct.Hello, %struct.Hello* }
%struct.Hello = type { i8, i8, i8, i8 }
%struct.Bar = type { %struct.Foo, i8*, i32*, i16 }

; Function Attrs: noinline norecurse nounwind optnone ssp uwtable
define i32 @main(i32 %0, i8** %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i8**, align 8
  %6 = alloca %struct.Foo, align 8
  %7 = alloca %struct.Bar, align 8
  %8 = alloca i32, align 4
  store i32 0, i32* %3, align 4
  store i32 %0, i32* %4, align 4
  store i8** %1, i8*** %5, align 8
  %9 = getelementptr inbounds %struct.Foo, %struct.Foo* %6, i32 0, i32 0
  store i32 1, i32* %9, align 8
  %10 = getelementptr inbounds %struct.Bar, %struct.Bar* %7, i32 0, i32 0
  %11 = getelementptr inbounds %struct.Foo, %struct.Foo* %10, i32 0, i32 0
  store i32 10, i32* %11, align 8
  store i32 0, i32* %8, align 4
  br label %12

12:                                               ; preds = %22, %2
  %13 = load i32, i32* %8, align 4
  %14 = getelementptr inbounds %struct.Bar, %struct.Bar* %7, i32 0, i32 0
  %15 = getelementptr inbounds %struct.Foo, %struct.Foo* %14, i32 0, i32 0
  %16 = load i32, i32* %15, align 8
  %17 = icmp slt i32 %13, %16
  br i1 %17, label %18, label %25

18:                                               ; preds = %12
  %19 = getelementptr inbounds %struct.Foo, %struct.Foo* %6, i32 0, i32 0
  %20 = load i32, i32* %19, align 8
  %21 = add nsw i32 %20, 1
  store i32 %21, i32* %19, align 8
  br label %22

22:                                               ; preds = %18
  %23 = load i32, i32* %8, align 4
  %24 = add nsw i32 %23, 1
  store i32 %24, i32* %8, align 4
  br label %12

25:                                               ; preds = %12
  %26 = load i32, i32* %3, align 4
  ret i32 %26
}

attributes #0 = { noinline norecurse nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"clang version 11.0.1"}
