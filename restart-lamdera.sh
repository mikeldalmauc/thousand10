#!/bin/sh

echo "[Watcher] Cambio detectado. Intentando reiniciar el servidor Lamdera..."

# Usamos 'pkill -f' para encontrar CUALQUIER proceso que contenga "lamdera live"
# y lo matamos. Es mucho más efectivo que matar por PID.
# El '|| true' evita que el script falle si no encuentra ningún proceso (por ejemplo, en el primer arranque).
echo "[Watcher] Enviando señal de parada a cualquier proceso antiguo de Lamdera..."
pkill -f "lamdera live --port 3000" || true

# Esperamos un instante para asegurarnos de que el sistema operativo ha liberado el puerto.
sleep 1

echo "[Watcher] Iniciando nueva instancia de Lamdera..."

# Usamos 'exec' para reemplazar el proceso del script por el de Lamdera.
# Esto es una buena práctica para la gestión de procesos en Docker.
exec lamdera live --port 3000