/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm_bonus.h                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: iwillens <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/04/09 13:23:51 by iwillens          #+#    #+#             */
/*   Updated: 2020/04/09 13:29:49 by iwillens         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_BONUS_H
# define LIBASM_BONUS_H

# include "libasm.h"

typedef struct		s_list
{
	void			*data;
	struct s_list	*next;
}					t_list;

void				ft_list_push_front(t_list **begin_list, void *data);
int					ft_list_size(t_list *begin_list);
void				ft_list_sort(t_list **begin_list, int (*cmp)());

#endif
