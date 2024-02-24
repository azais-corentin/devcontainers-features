## Installation prefix

The toolchain is installed with a version suffix.
For example for LLVM 17, you can access clang with command `clang-17`.

If you would like to remove this installation prefix,
you can use the following command (adjust `17` to the version you installed):
```
for f in /usr/lib/llvm-17/bin/*; do ln -sf "$f" /usr/bin; done
```