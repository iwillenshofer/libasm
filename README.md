# libasm

The purpose of `libasm` is to create a static library with classic libc functions, as `strlen` and `strcpy`. However, it stands out for being written exclusively in assembly code, more specifically the Intel x64 assembly code syntax. For instance, the static library `libasm` has the following available functions:

- ft_strlen;
- ft_strcpy;
- ft_strcmp;
- ft_write;
- ft_read;
- ft_strdup;

The description of these functions may be found on your system under `man 3 <function>` (without *ft_*). As expected, the functions have to behave exactly like its C counterparts, including exceptions and errors.

## Prerequisites

The `libasma.a` library is compiled with `nasm` and `make` utilities, so be sure to have these packages installed on your system. A test file is available too, and you can use your favorite compiler to execute the tests. The following script may be helpful to setup a Debian based environment.

	sudo apt update && sudo apt install build-essentials nasm
