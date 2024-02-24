
# LLVM (llvm)

Installs LLVM using the automatic installation script

## Example Usage

```json
"features": {
    "ghcr.io/azais-corentin/devcontainers-features/llvm:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | Select a specific LLVM version or use latest (default) | string | latest |

## Installation prefix

The toolchain is installed with a version suffix.
For example for LLVM 17, you can access clang with command `clang-17`.

If you would like to remove this installation prefix,
you can use the following command (adjust `17` to the version you installed):
```
for f in /usr/lib/llvm-17/bin/*; do ln -sf "$f" /usr/bin; done
```

---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/azais-corentin/devcontainers-features/blob/main/src/llvm/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
