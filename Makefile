#------------------------------------------------------------------------------#
#******************************* C MAKEFILE ***********************************#
#------------------------------------------------------------------------------#

# Nombre del ejecutable
NAME = program

# Configuración del compilador
CC = gcc
CFLAGS = -Wall -Wextra -Werror -g3

# Directorios y Archivos
SRC_DIR = src
OBJ_DIR = obj
SRCS = $(wildcard $(SRC_DIR)/*.c)
OBJS = $(SRCS:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)

# Configuración de la librería libft
LIBFT_REPO = git@github.com:sermaal11/libft_custom.git
LIBFT_DIR = libft
LIBFT = $(LIBFT_DIR)/libft.a

# Colores para los mensajes
ifndef NOCOLOR
RESET = \033[0m
CYAN = \033[0;36m
GREEN = \033[0;32m
RED = \033[0;31m
BOLD_GREEN = \033[1;32m
else
RESET =
CYAN =
GREEN =
RED =
BOLD_GREEN =
endif

#------------------------------------------------------------------------------#
# Reglas principales

all: clone_libft $(NAME)

# Compila el ejecutable
$(NAME): $(OBJS)
	@echo "$(CYAN)Compilando el ejecutable $(NAME)...$(RESET)"
	$(CC) $(CFLAGS) -o $@ $^ $(LIBFT)
	@echo "$(GREEN)¡Compilación completada con éxito!$(RESET)"

# Compila los archivos objeto
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	@echo "$(CYAN)Compilando $<...$(RESET)"
	$(CC) $(CFLAGS) -c $< -o $@

# Crea el directorio de archivos objeto
$(OBJ_DIR):
	@mkdir -p $@

# Clona el repositorio de libft si no existe
clone_libft:
	@if [ ! -d "$(LIBFT_DIR)" ]; then \
		echo "$(CYAN)Clonando el repositorio de libft...$(RESET)"; \
		git clone $(LIBFT_REPO) $(LIBFT_DIR); \
	else \
		echo "$(GREEN)El repositorio de libft ya existe.$(RESET)"; \
	fi

#------------------------------------------------------------------------------#
# Limpieza de archivos

clean:
	@echo "$(RED)Limpieza de archivos objeto...$(RESET)"
	rm -rf $(OBJ_DIR)
	$(MAKE) -C $(LIBFT_DIR) clean

fclean: clean
	@echo "$(RED)Eliminando el ejecutable...$(RESET)"
	rm -f $(NAME)
	$(MAKE) -C $(LIBFT_DIR) fclean

re: fclean all

#------------------------------------------------------------------------------#
# Funcionalidad de Git

git:
	git add .
	git status
	@read -p "¿Quieres continuar? [y/n]: " answer; \
	if [ "$$answer" = "y" ]; then \
		read -p "Mensaje para el commit: " message; \
		git commit -m "$$message"; \
		git push; \
		echo "$(BOLD_GREEN)(⌐■_■) ¡¡¡Git push realizado!!! (⌐■_■)$(RESET)"; \
	else \
		echo "$(RED)(҂◡_◡) ¡¡¡Git push no realizado!!!$(RESET)"; \
	fi

#------------------------------------------------------------------------------#
# Metainformación
.PHONY: all clean fclean re clone_libft git