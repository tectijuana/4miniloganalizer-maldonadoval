#!/usr/bin/env bash
# ============================================
# Mini Cloud Log Analyzer - Tests
# Variante C: detectar primer 503
# ============================================

set -euo pipefail

echo "===================================="
echo "[TEST] Mini Cloud Log Analyzer"
echo "===================================="

# Compilar si no existe el binario
if [[ ! -x ./analyzer ]]; then
  echo "[INFO] Compilando..."
  make
fi

# Ejecutar prueba con logs_C.txt
echo "[TEST] Ejecutando prueba con logs_C.txt"

output=$(cat data/logs_C.txt | ./analyzer)

expected="CRITICAL 503 DETECTED"

echo "[INFO] Salida obtenida:"
echo "$output"

echo "[INFO] Salida esperada:"
echo "$expected"

# Validación
if [[ "$output" == "$expected" ]]; then
  echo "[OK] Prueba correcta "
  exit 0
else
  echo "[FAIL] Prueba incorrecta "
  exit 1
fi
