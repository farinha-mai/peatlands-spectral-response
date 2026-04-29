# ========================
# CONFIGURACIÓN
$year = 2022
# ========================

# Ruta principal
$rutaBase = "C:\Users\farin\Downloads\img"
$archivoRel = "C:\Users\farin\Downloads\img\_imagenes_nodata\archivos_nodata_$year.txt"
$salidaCarpetas = "C:\Users\farin\Downloads\img\_imagenes_nodata\carpetas_nodata_$year.txt"

# Leer nombres de archivos .rel
$relNombres = Get-Content $archivoRel | Where-Object { $_ -ne "" }

# Crear lista para guardar nombres de carpetas encontradas
$carpetasEncontradas = @()

# Recorrer todos los archivos .rel dentro del año
Get-ChildItem -Path $rutaBase -Recurse -Filter *.rel | ForEach-Object {
    $archivo = $_
    if ($relNombres -contains $archivo.Name) {
        # Subir hasta la carpeta Sentinel (5 niveles arriba)
        $carpetaSentinel = $archivo.FullName -split "\\"
        if ($carpetaSentinel.Length -ge 6) {
            $nombreCarpeta = $carpetaSentinel[$carpetaSentinel.Length - 6]
            $carpetasEncontradas += $nombreCarpeta
            Write-Host "📂 Detectada: $nombreCarpeta"
        }
    }
}

# Eliminar duplicados y guardar
$carpetasEncontradas = $carpetasEncontradas | Sort-Object -Unique
$carpetasEncontradas | Out-File -FilePath $salidaCarpetas -Encoding UTF8

Write-Host "`n✅ Archivo generado: $salidaCarpetas"
