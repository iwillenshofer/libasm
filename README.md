<p align="center">
	<img width="130px;" src="https://game.42sp.org.br/static/assets/images/42_logo_black.svg" align="center" alt="42" />&nbsp;&nbsp;&nbsp;
	<img width="130px" src="https://game.42sp.org.br/static/assets/achievements/libasmm.png" align="center" alt="libasm" />
	<h1 align="center">libasm</h1>
</p>
<p align="center">
	<img src="https://img.shields.io/badge/Success-125/100_✓-gray.svg?colorA=61c265&colorB=4CAF50&style=for-the-badge">
	<img src="https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black">
</p>

<p align="center">
	<b><i>Development repository for the 42cursus libasm project @ 42 São Paulo</i></b><br>
</p>

<p align="center">
	<img alt="GitHub code size in bytes" src="https://img.shields.io/github/languages/code-size/iwillenshofer/libasm?color=blueviolet" />
	<img alt="GitHub top language" src="https://img.shields.io/github/languages/top/iwillenshofer/libasm?color=blue" />
	<img alt="GitHub top language" src="https://img.shields.io/github/commit-activity/t/iwillenshofer/libasm?color=brightgreen" />
	<img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/iwillenshofer/libasm?color=brightgreen" />
</p>
<br>

> _The aim of this project is to get familiar with assembly language._

[Download the Subject ⤓](en.subject.pdf)

<br>

<p align="center">
	<table>
		<tr>
			<td><b>Est. Time</b></td>
			<td><b>Skills</b></td>
			<td><b>Allowed Functions</b></td>
			<td><b>Difficulty</b></td>
		</tr>
		<tr>
			<td valign="top">70 hours</td>
			<td valign="top">
<img src="https://img.shields.io/badge/Imperative programming-555">
<img src="https://img.shields.io/badge/Rigor-555">
			</td>
			<td valign="top">
				<img src="https://img.shields.io/badge/malloc()-lightgrey">
			</td>
			<td valign="top"> 966 XP</td>
		</tr>
	</table>
</p>

<br>

### Info
Project developed in a squad, alongside [@aroque](https://www.github.com/AdrianWR) and [@rdjuric](https://github.com/rdjuric).

### Prerequisites

This project was developed on Ubuntu Linux 20.04.

The `libasma.a` library is compiled with `nasm` and `make` utilities, so be sure to have these packages installed on your system. A test file is available too, and you can use your favorite compiler to execute the tests. The following script may be helpful to setup a Debian based environment.

	sudo apt update && sudo apt install build-essentials nasm

### Usage
```bash
# create a main file.
$ make
$ gcc -L. -lasm -no-pie main.c 
$ ./a.out
```

#### Example of main() file
```c
#include "includes/libasm.h"

int	main(void)
{
	ft_write(1, "hello\n", 6);
	return (0);
}
```

### Included Functions
#### Part 1 - Libc functions

|name				|prototype																	|
|---				|---																		|
|	ft_strlen		|	size_t ft_strlen(const char *s);										|
|	ft_strcpy		|	char *	strcpy(char * dst, const char *src); 							|
|	ft_strcmp		|	int	strcmp(const char *s1, const char *s2);								|
|	ft_write		|	ssize_t	write(int fildes, const void *buf, size_t nbyte);				|
|	ft_read			|	ssize_t	read(int fildes, void *buf, size_t nbyte);						|
|	ft_strdup		|	char *	strdup(const char *s1);											|


#### Bonus Part
|name				|prototype																		|
|---				|---																			|
|ft_atoi_base		|int	ft_atoi_base(const char *str, int str_base);							|
|ft_list_push_front	|void	ft_list_push_front(t_list **begin_list, void *data);					|
|ft_list_size		|int	ft_list_size(t_list *begin_list);										|
|ft_list_sort		|void	ft_list_sort(t_list **begin_list, int (*cmp)());						|
|ft_list_remove_if	|void	ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)());	|
