/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main_bonus.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: iwillens <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/04/09 13:30:33 by iwillens          #+#    #+#             */
/*   Updated: 2020/04/09 14:21:26 by iwillens         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm_bonus.h"

static void	ft_putnbr(int nb)
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

static void	ft_putstr(char *s)
{
	int	i;

	i = 0;
	while (s && s[i])
	{
		ft_write(1, &s[i], 1);
		i++;
	}
}

void		print_list(t_list *elem)
{
	t_list *head;

	head = elem;
	ft_putstr("\n\n********Unsorted List ******\n");
	while (elem)
	{
		ft_putstr(elem->data);
		ft_putstr("\n");
		elem = elem->next;
	}
	elem = head;
	ft_list_sort(&elem, ft_strcmp);
	ft_putstr("\n\n********Sorted List ******\n");
	while (elem)
	{
		ft_putstr(elem->data);
		ft_putstr("\n");
		elem = elem->next;
	}
}

int			main(void)
{
	t_list *elem;

	elem = NULL;
	ft_list_push_front(&elem, "banana");
	ft_list_push_front(&elem, "manga");
	ft_list_push_front(&elem, "abacate");
	ft_list_push_front(&elem, "uva");
	ft_list_push_front(&elem, "cereja");
	ft_list_push_front(&elem, "abacaxi");
	ft_list_push_front(&elem, "amora");
	ft_list_push_front(&elem, "pessego");
	ft_list_push_front(&elem, "inhame");
	ft_putstr("\n****List size: ");
	ft_putnbr(ft_list_size(elem));
	print_list(elem);
	return (0);
}
