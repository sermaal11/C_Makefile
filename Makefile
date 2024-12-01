#------------------------------------------------------------------------------#
#                             # C MAKEFILE #                                   #
#------------------------------------------------------------------------------#

# Nombre del ejecutable
# Define cómo se llamará el ejecutable final de tu proyecto.
# Cambia "program" por el nombre que desees para tu ejecutable.
NAME = program

#------------------------------------------------------------------------------#
# Configuración del compilador

# Compilador que se usará para compilar los archivos fuente.
# Puedes cambiar gcc por clang si prefieres usar otro compilador.
CC = gcc

# Flags de compilación:
# - Wall: Habilita todas las advertencias importantes.
# - Wextra: Habilita advertencias adicionales útiles.
# - Werror: Convierte las advertencias en errores.
# - g3: Genera información de depuración para herramientas como gdb.
CFLAGS = -Wall -Wextra -Werror -g3

#------------------------------------------------------------------------------#
# Directorios y Archivos

# Carpeta donde se encuentran los archivos fuente (.c) de tu proyecto.
SRC_DIR = src

# Carpeta donde se generarán los archivos objeto (.o).
# Esta carpeta se creará automáticamente si no existe.
OBJ_DIR = obj

# Variable que lista todos los archivos fuente en SRC_DIR.
# $(wildcard $(SRC_DIR)/*.c): Busca todos los archivos con extensión .c en la carpeta src.
SRCS = $(wildcard $(SRC_DIR)/*.c)

# Variable que lista todos los archivos objeto (.o) correspondientes a los archivos fuente.
# Convierte cada archivo fuente en un archivo objeto, ubicado en obj/.
OBJS = $(SRCS:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)

#------------------------------------------------------------------------------#
# Librería opcional: libft

# Carpeta donde se encuentra tu librería personalizada (libft).
# Cambia esta ruta si tu librería está en otra ubicación.
LIBFT_DIR = ./libft

# Nombre de la librería compilada (archivo libft.a).
LIBFT = $(LIBFT_DIR)/libft.a

#------------------------------------------------------------------------------#
# Colores para los mensajes en la terminal

# Estos colores son para resaltar mensajes en la salida del terminal.
# Puedes desactivarlos estableciendo la variable NOCOLOR=1 al ejecutar make.
ifndef NOCOLOR
RESET = \033[0m
CYAN = \033[0;36m
GREEN = \033[0;32m
RED = \033[0;31m
else
RESET =
CYAN =
GREEN =
RED =
endif

#------------------------------------------------------------------------------#
# Reglas principales

# La regla "all" compila todo: la librería (si se usa) y el ejecutable.
all: $(LIBFT) $(NAME)

# La regla para compilar el ejecutable final.
# Depende de los archivos objeto generados y de la librería (si está definida).
$(NAME): $(OBJS)
	@echo "$(CYAN)Compilando el ejecutable $(NAME)...$(RESET)"
	$(CC) $(CFLAGS) -o $@ $^ $(LIBFT)
	@echo "$(GREEN)¡Compilación completada con éxito!$(RESET)"

# La regla para compilar archivos objeto (.o) desde archivos fuente (.c).
# Cada archivo fuente se convierte en un archivo objeto y se guarda en OBJ_DIR.
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	@echo "$(CYAN)Compilando $<...$(RESET)"
	$(CC) $(CFLAGS) -c $< -o $@

# Crea la carpeta de archivos objeto si no existe.
# Esta regla se ejecuta automáticamente antes de compilar cualquier archivo objeto.
$(OBJ_DIR):
	@mkdir -p $@

#------------------------------------------------------------------------------#
# Reglas para la librería libft

# Compila la librería libft si está definida.
# Llama al Makefile que se encuentra dentro de LIBFT_DIR.
$(LIBFT):
	@echo "$(CYAN)Compilando la librería libft...$(RESET)"
	$(MAKE) -C $(LIBFT_DIR)
	@echo "$(GREEN)¡Librería libft compilada con éxito!$(RESET)"

#------------------------------------------------------------------------------#
# Limpieza de archivos intermedios

# Limpia los archivos objeto (.o) generados durante la compilación.
clean:
	@echo "$(RED)Limpieza de archivos objeto...$(RESET)"
	rm -rf $(OBJ_DIR)
	@echo "$(RED)Limpieza de objetos de libft...$(RESET)"
	$(MAKE) -C $(LIBFT_DIR) clean

# Limpia todo: los archivos objeto y el ejecutable final.
fclean: clean
	@echo "$(RED)Eliminando el ejecutable...$(RESET)"
	rm -f $(NAME)
	@echo "$(RED)Eliminando libft.a...$(RESET)"
	$(MAKE) -C $(LIBFT_DIR) fclean

# Limpia todo y recompila desde cero.
re: fclean all

#------------------------------------------------------------------------------#
# Reglas adicionales

# Verifica el código con Norminette.
# Este comando asume que tienes Norminette instalado.
norm:
	@norminette $(SRCS) $(LIBFT_DIR)/*.c | grep -v Norme -B1 || true

# Prueba el programa con Valgrind (Linux) o Leaks (macOS).
# Detecta fugas de memoria y otros problemas relacionados.
memcheck: $(NAME)
	@echo "$(CYAN)Detectando sistema operativo...$(RESET)"
	@if [ "$(shell uname)" = "Darwin" ]; then \
		echo "$(CYAN)Ejecutando leaks en macOS...$(RESET)"; \
		leaks --atExit -- ./$(NAME); \
	else \
		echo "$(CYAN)Ejecutando Valgrind en Linux...$(RESET)"; \
		valgrind --leak-check=full --show-leak-kinds=all ./$(NAME); \
	fi

#------------------------------------------------------------------------------#
# Dependencias automáticas

# Esto asegura que si cambias un archivo de cabecera (.h), los archivos objeto
# que lo usan se recompilarán automáticamente.
-include $(OBJS:.o=.d)

#------------------------------------------------------------------------------#
# Metainformación

# Estas reglas indican que no hay un archivo físico llamado "all", "clean", etc.
.PHONY: all clean fclean re norm memcheck