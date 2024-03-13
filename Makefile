#------------------------------------------------------------------------------#
#******************************************************************************#
#********************************* C MAKEFILE *********************************#
#******************************************************************************#
#------------------------------------------------------------------------------#
# Antes de completar el Makefile, puedes ejecutar el siguiente comando para
# inicializar el proyecto:
# make init
# Este comando creará un archivo .gitignore con las extensiones mas comunes que
# se suelen ignorar en los proyectos de C para 42 y si lo deseas, te mostrará
# los comandos que puedes usar en este Makefile.
# ¡¡¡Recuerda que puedes añadir tus propias reglas al Makefile!!!
# ¡¡¡Buena suerte con tu proyecto!!!
#------------------------------------------------------------------------------#

# Nombre del ejecutable a crear (sin espacios)
NAME = 

#------------------------------------------------------------------------------#

# Compilador a utilizar (gcc, clang, etc)
CC = gcc
# Flags de compilacion (agregar los que se necesiten)
CFLAGS = -g3 -Wall -Wextra -Werror

#------------------------------------------------------------------------------#

# Archivos fuente (agregar los que se necesiten)
SRCS = 

#------------------------------------------------------------------------------#

# Archivos objeto (no tocar)
OBJS = $(SRCS:.c=.o)
# Directorio de los archivos objeto (no tocar)
OBJDIR = $(NAME)_objects
# Directorio de la libft. Si se usa, descomentar la linea
#LIBFT_DIR = ./libft
# Libreria a utilizar. Si se usa, descomentar la linea
#LIBFT = $(LIBFT_DIR)/libft.a

#------------------------------------------------------------------------------#

# Colores para el make.

# (Elige los colores que mas te gusten para el makefile. Elimina los que no
# necesites.)

# Recuerda siempre usar $(RESET) al final de tu mensaje para restablecer los
# colores a los valores predeterminados de la terminal.
RESET = \033[0m

# Regular
BLACK = \033[0;30m
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[0;33m
BLUE = \033[0;34m
PURPLE = \033[0;35m
CYAN = \033[0;36m
WHITE = \033[0;37m
ORANGE = \033[0;91m
PINK = \033[0;95m

# Bold
BOLD_BLACK = \033[1;30m
BOLD_RED = \033[1;31m
BOLD_GREEN = \033[1;32m
BOLD_YELLOW = \033[1;33m
BOLD_BLUE = \033[1;34m
BOLD_PURPLE = \033[1;35m
BOLD_CYAN = \033[1;36m
BOLD_WHITE = \033[1;37m
BOLD_ORANGE = \033[1;91m
BOLD_PINK = \033[1;95m

# Underline
UNDERLINE_BLACK = \033[4;30m
UNDERLINE_RED = \033[4;31m
UNDERLINE_GREEN = \033[4;32m
UNDERLINE_YELLOW = \033[4;33m
UNDERLINE_BLUE = \033[4;34m
UNDERLINE_PURPLE = \033[4;35m
UNDERLINE_CYAN = \033[4;36m
UNDERLINE_WHITE = \033[4;37m
UNDERLINE_ORANGE = \033[4;91m
UNDERLINE_PINK = \033[4;95m

# Background
BACKGROUND_BLACK = \033[40m
BACKGROUND_RED = \033[41m
BACKGROUND_GREEN = \033[42m
BACKGROUND_YELLOW = \033[43m
BACKGROUND_BLUE = \033[44m
BACKGROUND_PURPLE = \033[45m
BACKGROUND_CYAN = \033[46m
BACKGROUND_WHITE = \033[47m
BACKGROUND_ORANGE = \033[101m
BACKGROUND_PINK = \033[105m

#------------------------------------------------------------------------------#

# Reglas del make (no tocar)

# La regla all compila el ejecutable
all:libft $(NAME)
	@echo "$(BOLD_GREEN)(⌐■_■) ¡¡¡$(NAME) compilado con exito!!! (⌐■_■)$(RESET)"

# La regla $(NAME) compila el ejecutable con los archivos objeto creados
$(NAME): $(addprefix $(OBJDIR)/, $(OBJS))
	@echo "$(GREEN)¡Objetos creados!$(RESET)"
	@echo "$(CYAN)Compilando $(NAME)...$(RESET)"
	$(CC) $(CFLAGS) -o $@ $^ $(LIBFT)

# La regla %.o compila los archivos objeto
$(OBJDIR)/%.o : %.c | $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

# La regla $(OBJDIR) crea el directorio de los archivos objeto
$(OBJDIR):
	@echo "$(CYAN)Creando directorio de objetos...$(RESET)"
	mkdir $(OBJDIR)
	@echo "$(GREEN)¡Directorio de objetos creado!$(RESET)"
	@echo "$(CYAN)Creando objetos...$(RESET)"

# La regla libft compila la libft. Si se usa, descomentar las siguientes
# dos lineas
#libft:
#	@make -C $(LIBFT_DIR)

# La regla libft_clean elimina los archivos objeto de la libft. Si se usa,
# descomentar las siguientes dos lineas
#libft_clean:
#	@make -C $(LIBFT_DIR) clean

# La regla libft_clean elimina los archivos objeto de la libft y el ejecutable.
# Si se usa, descomentar las siguientes dos lineas
#libft_fclean:
#	@make -C $(LIBFT_DIR) fclean

# La regla clean elimina todos los archivos objeto y su directorio. Si se usa la
# libft, descomentar la linea libft_clean
clean: #libft_clean
	@echo "$(RED)Eliminando archivos objeto...$(RESET)"
	rm -rf $(addprefix $(OBJDIR)/, $(OBJS))
	@echo "$(RED)¡Todos los archivos objeto han sido eliminados!$(RESET)"
	@echo "$(RED)Eliminando directorio de objetos...$(RESET)"
	rm -rf $(OBJDIR)
	@echo "$(RED)¡Directorio de objetos eliminado!$(RESET)"

# La regla fclean elimina todos los archivos objeto y el ejecutable. Si se usa
# la libft, descomentar la linea libft_fclean
fclean: clean #libft_fclean
	@echo "$(RED)Eliminando ejecutable...$(RESET)"
	rm -rf $(NAME)
	@echo "$(RED)¡El ejecutable ha sido eliminado!$(RESET)"

# La regla re elimina todo y compila nuevamente
re: fclean all

# La regla init inicializa el proyecto
init:
	@echo "$(CYAN)Creando archivo .gitignore...$(RESET)"
	@echo "$(CYAN)Añadiendo .DS_Store, .vscode, .dSYM y .o al archivo .gitignore...$(RESET)"
	@echo "\n"
	@echo ".DS_Store" > .gitignore
	@echo ".vscode" >> .gitignore
	@echo "*.dSYM" >> .gitignore
	@echo "*.o" >> .gitignore
	@read -p "Quieres ver los comandos de los que dispone este Makefile? [y/n]: " answer; \
	if [ "$$answer" = "y" ]; then \
		make help; \
		read -p "Para continuar, presiona enter..."; \
	else \
		echo "Puedes ver los comandos con 'make help' en cualquier momento"; \
	fi
	@echo "$(BOLD_GREEN)(⌐■_■) ¡¡¡Proyecto inicializado, ya puedes empezar a completar el Makefile!!! (⌐■_■)$(RESET)"

# La regla test compila y ejecuta el programa con los argumentos que le pases
test: re
	@read -p "¿Cuántos argumentos quieres introducir? " num_args; \
	for ((i=1; i<=num_args; i++)); do \
		read -p "Introduce el argumento $$i: " arg; \
		args+=" $$arg"; \
	done; \
	./$(NAME)$$args


# La regla git agrega, hace commit y hace push
git: fclean
	git add .
	git status
	@read -p "Quieres continuar? [y/n]: " answer; \
	if [ "$$answer" = "y" ]; then \
		read -p "Mensaje para el commit: " message; \
		git commit -m "$$message"; \
		git push; \
		echo "$(BOLD_GREEN)(⌐■_■) ¡¡¡Git push realizado!!! (⌐■_■)$(RESET)"; \
	else \
		echo "$(BOLD_RED)(҂◡_◡) ¡¡¡Git push no realizado (҂◡_◡)!!!$(RESET)"; \
	fi

# La regla norm comprueba la norminette en las SRCS y en el .h
norm:
	@norminette $(SRCS) minishell.h | grep -v Norme -B1 || true

# La regla help muestra las reglas del make
help:
	@echo "\n"
	@echo "$(BOLD_PURPLE)Reglas incluidas en el Makefile:$(RESET)"
	@echo "\n"
	@echo "  $(CYAN)all$(RESET)	-> Compila el ejecutable"
	@echo "  $(CYAN)clean$(RESET)	-> Elimina los archivos objeto"
	@echo "  $(CYAN)fclean$(RESET)-> Elimina los archivos objeto y el ejecutable"
	@echo "  $(CYAN)re$(RESET)	-> Elimina todo y compila nuevamente"
	@echo "  $(CYAN)init$(RESET)	-> Inicializa el proyecto"
	@echo "  $(CYAN)test$(RESET)	-> Compila y ejecuta el promgrama con los argumentos que le pases"
	@echo "  $(CYAN)git$(RESET)	-> Agrega, hace commit y hace push"
	@echo "  $(CYAN)norm$(RESET)	-> Ejecuta Norminette"
	@echo "  $(CYAN)help$(RESET)	-> Muestra las reglas del make"
	@echo "\n"

# La regla .PHONY indica que no hay un archivo llamado all, clean, fclean, 
# git, re o libft
.PHONY: all clean fclean git re libft
#------------------------------------------------------------------------------#
