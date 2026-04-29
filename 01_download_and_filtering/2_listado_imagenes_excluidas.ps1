# ========================
# CONFIGURACIÓN - Cambiar solo el año aquí
$year = 2024
# ========================

# Definir rutas de entrada y salida
$baseDir = "D:\img\$year"
#$baseDir = "C:\Users\farin\Downloads\img\$year"
$archivoEntrada = "$baseDir\listado_carpetas_$year.txt"
$archivoSalida = "$baseDir\ultimas_versiones_$year.txt"
$archivoEliminar = "$baseDir\carpetas_a_eliminar_$year.txt"

# Leer todas las carpetas del archivo
$carpetas = Get-Content $archivoEntrada | Where-Object { $_ -ne "" }

# Crear diccionario para almacenar la versión más reciente por fecha de adquisición
$ultimosProcesados = @{}

foreach ($nombre in $carpetas) {
    if ($nombre -match "_([0-9]{8})T[0-9]{6}_N[0-9]{4}_R[0-9]{3}_T[0-9A-Z]{5}_([0-9]{8})T") {
        $fechaAdq = $matches[1]
        $fechaProc = $matches[2]

        if (-not $ultimosProcesados.ContainsKey($fechaAdq)) {
            $ultimosProcesados[$fechaAdq] = @($fechaProc, $nombre)
        } elseif ($fechaProc -gt $ultimosProcesados[$fechaAdq][0]) {
            $ultimosProcesados[$fechaAdq] = @($fechaProc, $nombre)
        }
    }
}

# Extraer solo los nombres de carpeta seleccionados (últimos procesados)
$resultadoFinal = $ultimosProcesados.Values | ForEach-Object { $_[1] } | Sort-Object

# Guardar archivo de últimas versiones
$resultadoFinal | Out-File -FilePath $archivoSalida -Encoding UTF8
Write-Host "✔ Generado archivo con últimas versiones: $archivoSalida"

# Calcular las carpetas a eliminar (diferencia)
$carpetasAEliminar = $carpetas | Where-Object { $resultadoFinal -notcontains $_ }

# Crear contenido del resumen
$resumen = @()
$resumen += "📂 Total de carpetas           : $($carpetas.Count)"
$resumen += "📂 Total de últimas versiones : $($resultadoFinal.Count)"
$resumen += "🗑️  Total de carpetas a eliminar : $($carpetasAEliminar.Count)"
$resumen += ""
$resumen += "Listado de carpetas a eliminar:"
$resumen += $carpetasAEliminar

# Guardar archivo con carpetas a eliminar + resumen
$resumen | Out-File -FilePath $archivoEliminar -Encoding UTF8
Write-Host "🗑️  Generado archivo con carpetas a eliminar: $archivoEliminar"

# Mostrar resumen en pantalla también
Write-Host "`nResumen:"
$resumen[0..4] | ForEach-Object { Write-Host $_ }
