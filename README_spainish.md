# Proyecto en C con Makefile

Este proyecto está configurado para compilar programas en C utilizando un **Makefile** flexible y bien documentado. Incluye soporte para librerías personalizadas como `libft`, limpieza de archivos, validación con `Norminette` y prueba de memoria con herramientas como `Valgrind` o `Leaks`.

## **Estructura del Proyecto**

La estructura del proyecto sigue el siguiente esquema:

```plaintext
.
├── Makefile          # Archivo principal para compilar y gestionar el proyecto
├── src/              # Carpeta con los archivos fuente (.c)
│   ├── main.c        # Archivo principal del programa
│   └── utils.c       # Otros archivos fuente
├── obj/              # Carpeta generada automáticamente para los archivos objeto (.o)
├── include/          # Carpeta opcional para archivos de cabecera (.h)
├── libft/            # Carpeta para la librería personalizada libft (opcional)
│   ├── libft.a       # Librería compilada
│   ├── ft_strlen.c   # Ejemplo de función en libft
│   └── Makefile      # Makefile de la librería
```

## **Comandos Principales**

### **Compilar el proyecto**
```bash
make
```
- Compila todos los archivos fuente en la carpeta `src/`.
- Genera los archivos objeto en la carpeta `obj/`.
- Crea el ejecutable especificado en la variable `NAME`.

---

### **Limpiar archivos intermedios**
```bash
make clean
```
- Elimina todos los archivos objeto (`.o`) generados en `obj/`.

---

### **Limpiar todo**
```bash
make fclean
```
- Elimina los archivos objeto (`.o`) y el ejecutable.
- También limpia la librería `libft.a`, si se usa.

---

### **Recompilar todo**
```bash
make re
```
- Equivalente a ejecutar `make fclean` seguido de `make`.
- Limpia todo y recompila desde cero.

---

### **Verificar Norminette**
```bash
make norm
```
- Ejecuta `Norminette` en los archivos fuente y cabecera del proyecto.
- Verifica que el código cumple con las normas de estilo de la academia 42.

---

### **Probar fugas de memoria**
```bash
make memcheck
```
- Detecta el sistema operativo y ejecuta:
  - **Valgrind** en Linux.
  - **Leaks** en macOS.
- Útil para identificar fugas de memoria o errores relacionados.

---

## **Variables Importantes**

### **Configuración Básica**
- `NAME`: Define el nombre del ejecutable.
- `SRC_DIR`: Carpeta donde están los archivos fuente.
- `OBJ_DIR`: Carpeta para los archivos objeto generados automáticamente.

### **Opcional: Librería libft**
- `LIBFT_DIR`: Directorio donde se encuentra la librería `libft`.
- `LIBFT`: Nombre del archivo de librería (`libft.a`).
- Si no usas `libft`, comenta las líneas relacionadas en el Makefile.

---

## **Colores en la Terminal**

El Makefile utiliza colores para resaltar los mensajes en la salida de la terminal:

- **Cian:** Mensajes informativos, como "Compilando".
- **Verde:** Mensajes de éxito, como "¡Compilación completada con éxito!".
- **Rojo:** Mensajes de limpieza o eliminación.

Para desactivar los colores:
```bash
make NOCOLOR=1
```

---

## **Requisitos Previos**

1. **Compilador GCC o Clang:**
   - Asegúrate de tener instalado un compilador compatible, como `gcc` o `clang`.

2. **Norminette (opcional):**
   - Si deseas verificar el estilo del código, instala `Norminette`.

3. **Valgrind o Leaks (opcional):**
   - Instala `Valgrind` para Linux o asegúrate de tener las herramientas de desarrollo de Xcode para usar `Leaks` en macOS.

---

## **Extensiones Futuras**

Este Makefile puede ser extendido para incluir nuevas funcionalidades, como:
- Generación automática de documentación con `Doxygen`.
- Soporte para múltiples librerías adicionales.
- Scripts para pruebas automatizadas.

¡Disfruta programando! Si tienes dudas, consulta el Makefile directamente, ya que contiene explicaciones detalladas en los comentarios.