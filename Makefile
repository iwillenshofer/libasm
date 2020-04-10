# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: iwillens <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/31 22:38:06 by aroque            #+#    #+#              #
#    Updated: 2020/04/09 20:42:53 by iwillens         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME	=	libasm.a

SRC_DIR	=	./src
SRC		=	${SRC_DIR}/ft_strlen.s	\
			${SRC_DIR}/ft_strcpy.s	\
			${SRC_DIR}/ft_strcmp.s	\
			${SRC_DIR}/ft_write.s	\
			${SRC_DIR}/ft_read.s	\
			${SRC_DIR}/ft_strdup.s

SRCBONUS =	${SRC_DIR}/ft_list_push_front_bonus.s \
			${SRC_DIR}/ft_list_size_bonus.s \
			${SRC_DIR}/ft_list_sort_bonus.s \
			${SRC_DIR}/ft_atoi_base_bonus.s \
			${SRC_DIR}/ft_list_remove_if_bonus.s

OBJ_DIR	=	./build
OBJ		=	$(patsubst ${SRC_DIR}/%.s, ${OBJ_DIR}/%.o, ${SRC})
OBJ_BONUS	=	$(patsubst ${SRC_DIR}/%.s, ${OBJ_DIR}/%.o, ${SRCBONUS})

INCLUDE	=	./include

ASM			=	nasm
ASM_FLAGS	=	-fmacho64

AR_FLAGS	=	rcs

CC			=	gcc
CC_FLAGS	=	-Wall			\
 				-Wextra			\
 				-Werror			\
				-Wno-nullability-completeness \
				-fsanitize=address \
				-g \
 				-I${INCLUDE}	\
 				-L.				\
 				-lasm

TEST_DIR	=	./test
TEST		=	${TEST_DIR}/main.c
TEST_BONUS	=	${TEST_DIR}/main_bonus.c
EXEC		=	${TEST_DIR}/main
EXEC_BONUS		=	${TEST_DIR}/mainbonus

all: $(NAME)

$(NAME): $(OBJ)
	$(AR) $(AR_FLAGS) $(NAME) $(OBJ)


$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s
	mkdir -p $(OBJ_DIR)
	$(ASM) $(ASM_FLAGS)	$< -o $@

test: $(EXEC)
	./$(EXEC)

testbonus: $(EXEC_BONUS)
	./$(EXEC_BONUS)

$(EXEC): $(TEST) $(NAME)
	$(CC) $< $(CC_FLAGS) -o $(EXEC)

$(EXEC_BONUS): $(TEST_BONUS) bonus
	$(CC) $< $(CC_FLAGS) -o $(EXEC_BONUS)

bonus: all $(OBJ_BONUS)
	$(AR) $(AR_FLAGS) $(NAME) $(OBJ_BONUS)

linux: ASM_FLAGS = -felf64

linux: $(NAME)

mac: all

clean:
	$(RM) $(OBJ) $(OBJ_BONUS)

fclean: clean
	$(RM) $(NAME) $(EXEC)

re: fclean all
