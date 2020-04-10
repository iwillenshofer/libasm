/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main_bonus.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: iwillens <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/04/09 13:30:33 by iwillens          #+#    #+#             */
/*   Updated: 2020/04/09 23:12:20 by iwillens         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm_bonus.h"

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

static void		print_list(t_list *elem, char *title)
{
	t_list *head;

	ft_putstr("************** ");
	ft_putstr(title);
	ft_putstr(" ************** \n");
	head = elem;
	while (elem)
	{
		ft_putstr(elem->data);
		ft_putstr("\n");
		elem = elem->next;
	}
	ft_putstr("*******************  List size: ");
	ft_putnbr(ft_list_size(head));
	ft_putstr("  ******************** \n\n");
}

static void		free_fct(void *elem)
{
	if (elem)
		free(elem);
}

int				main(void)
{
	t_list	*elem;
	char	*string;
	char	*base;

	elem = NULL;
	ft_list_push_front(&elem, ft_strdup("banana"));
	ft_list_push_front(&elem, ft_strdup("manga"));
	ft_list_push_front(&elem, ft_strdup("abacate"));
	ft_list_push_front(&elem, ft_strdup("uva"));
	ft_list_push_front(&elem, ft_strdup("amora"));
	ft_list_push_front(&elem, ft_strdup("pessego"));
	print_list(elem, "      Unsorted List      ");
	ft_list_sort(&elem, ft_strcmp);
	print_list(elem, "       Sorted List       ");
	ft_list_remove_if(&elem, "inhame", ft_strcmp, free_fct);
	print_list(elem, "List with Removed Element");
	string = ft_strdup("10100101");
	base = ft_strdup("01");
	ft_putstr("*** ft_atoi_base -> string: '");
	ft_putstr(string);
	ft_putstr("', base: '");
	ft_putstr(base);
	ft_putstr("'. Result: ");
	ft_putnbr(ft_atoi_base(string, base));
	return (0);
}
