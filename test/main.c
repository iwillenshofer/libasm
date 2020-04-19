/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: iwillens <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/04/07 19:32:21 by iwillens          #+#    #+#             */
/*   Updated: 2020/04/09 14:20:42 by iwillens         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm.h"
#include <fcntl.h>

static void		ft_putstr(char *s)
{
	int	i;

	i = 0;
	while (s && s[i])
	{
		ft_write(1, &s[i], 1);
		i++;
	}
}

static void		ft_putnbr(int nb)
{
	long int	n;
	char		c;

	n = nb;
	if (nb < 0)
	{
		ft_write(1, "-", 1);
		n = (long int)nb * -1;
	}
	if (n >= 10)
		ft_putnbr((int)(n / 10));
	c = n % 10 + '0';
	ft_write(1, &c, 1);
}

static void		read_stdin(void)
{
	int		ret;
	char	buffer[48];

	ret = 0;
	while ((ret = ft_read(1, &buffer, 47)) > 0)
	{
		buffer[ret] = 0;
		ft_putstr(buffer);
	}
}

static void		exception_test(void)
{
	int		ret;
	char	buffer[1];

	ft_putstr("\n***** Exceptions:");
	ft_putstr("\nft_read (Invalid Descriptor): ret-> ");
	ret = ft_read(4242, &buffer, 1);
	ft_putnbr(ret);
	ft_putstr("; errno: ");
	ft_putnbr(errno);
	ft_putstr("\nft_write (Invalid Descriptor): ret-> ");
	errno = 0;
	ret = ft_write(555, "XXXXX", 5);
	ft_putnbr(ret);
	ft_putstr("; errno: ");
	ft_putnbr(errno);
	ft_putstr("\n");
}

int				main(void)
{
	int	len;
	char	*s;

	exception_test();
	ft_write(1, "\n***** Normal Test: ", 20);
	ft_putstr("\nft_write: '42 Disassembly'");
	s = ft_strdup("42 Disassembly");
	ft_putstr("\nft_strdup: Duplicando '42 Disassembly': ");
	ft_putstr(s);
	len = ft_strlen(s);
	ft_putstr("\nft_strlen: '14': ");
	ft_putnbr(len);
	ft_putstr("\nft_strcpy: Alterando para '42 Assembly': ");
	ft_strcpy(&s[3], "Assembly");
	ft_putstr(s);
	ft_putstr("\nft_strcmp: Disassembly is greater than Assembly: '3': ");
	ft_putnbr(ft_strcmp("Disassembly", "Assembly"));
	ft_putstr("\nft_read: Reading from stdin: ");
	read_stdin();
}
