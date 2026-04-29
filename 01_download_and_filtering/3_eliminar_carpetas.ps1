# ========================
# CONFIGURACIÓN - Cambiar solo el año aquí
$year = 2024
# ========================

# Ruta base donde están las carpetas
$basePath = "D:\img\$year"
#$basePath = "C:\Users\farin\Downloads\img\$year"

# Archivo con nombres de carpetas a eliminar
$archivoEliminar = "$basePath\carpetas_a_eliminar_$year.txt"

# Leer las carpetas desde el archivo, ignorando líneas vacías y encabezado
$carpetas = Get-Content $archivoEliminar | Where-Object { $_ -ne "" -and $_ -notmatch "^📂|^🗑️|^Listado" }

# Contador
$eliminadas = 0
$noEncontradas = 0

foreach ($nombre in $carpetas) {
    $rutaCompleta = Join-Path $basePath $nombre

    if (Test-Path $rutaCompleta) {
        try {
            Remove-Item $rutaCompleta -Recurse -Force
            Write-Host "✅ Eliminada: $nombre"
            $eliminadas++
        } catch {
            Write-Host "❌ Error al eliminar: $nombre - $_"
        }
    } else {
        Write-Host "⚠️  No encontrada: $nombre"
        $noEncontradas++
    }
}

# Resumen
Write-Host "`nResumen:"
Write-Host "🗑️  Total eliminadas    : $eliminadas"
Write-Host "🚫 Total no encontradas : $noEncontradas"