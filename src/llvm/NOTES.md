

## Installation prefix

The toolchain is installed with a version suffix.
For LLVM 17, you can access clang with command `clang-17`.

If you would like to bypass this installation prefix,
you can use the following command (adjust `17` to whatever you installed)
```
for f in /usr/lib/llvm-17/bin/*; do ln -sf "$f" /usr/bin; done && \
```