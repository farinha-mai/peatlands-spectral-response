# ========================
# CONFIGURACIÓN - Cambiar solo el año aquí
$year = 2022
# ========================

# Rutas
$basePath = "C:\Users\farin\Downloads\img\$year"
$archivoNoData = "C:\Users\farin\Downloads\img\_imagenes_nodata\carpetas_nodata_$year.txt"
$logEliminadas = "C:\Users\farin\Downloads\img\_imagenes_nodata\carpetas_eliminadas_confirmadas_$year.txt"

# Verificar existencia del archivo con nombres
if (-not (Test-Path $archivoNoData)) {
    Write-Host "❌ Archivo no encontrado: $archivoNoData"
    exit
}

# Crear o limpiar archivo de registro
"" | Out-File -Encoding UTF8 $logEliminadas

# Leer carpetas válidas
$carpetas = Get-Content $archivoNoData | Where-Object {
    $_ -and ($_ -notmatch "^\s*$") -and ($_ -notmatch "^\s*(#|📂|🗑️|Listado)")
}

# Contadores
$eliminadas = 0
$noEncontradas = 0
$canceladas = 0

foreach ($nombre in $carpetas) {
    $soloNombre = [System.IO.Path]::GetFileNameWithoutExtension($nombre)
    $carpeta = Get-ChildItem $basePath -Directory | Where-Object { $_.Name -like "*$soloNombre*" }

    if ($carpeta) {
        foreach ($c in $carpeta) {
            $respuesta = Read-Host "❓ ¿Eliminar la carpeta '$($c.Name)'? (s/n)"
            if ($respuesta -eq "s" -or $respuesta -eq "S") {
                try {
                    Remove-Item -Path $c.FullName -Recurse -Force
                    Write-Host "✅ Eliminada: $($c.Name)"
                    Add-Content -Path $logEliminadas -Value $c.Name
                    $eliminadas++
                } catch {
                    Write-Host "❌ Error al eliminar: $($c.Name) - $_"
                }
            } else {
                Write-Host "⏩ Saltada: $($c.Name)"
                $canceladas++
            }
        }
    } else {
        Write-Host "⚠️  No encontrada: $soloNombre"
        $noEncontradas++
    }
}

# Resumen
Write-Host "`nResumen:"
Write-Host "🗑️  Total eliminadas     : $eliminadas"
Write-Host "🚫 Total no encontradas  : $noEncontradas"
Write-Host "⏭️  Total saltadas       : $canceladas"
Write-Host "`n📝 Log de eliminadas: $logEliminadas"
