# -------------------------------------------------
#  Extraer fechas (YYYYMMDD) de los nombres Sentinel-2
# -------------------------------------------------

$anio      = 2025
$raiz      = "D:\img\$anio"              # carpeta que quieres recorrer
$salidaTxt = "D:\img\estadisticos\combicapa_$anio\fechas_$anio.txt"   # listado que se creará

# 1) Buscar carpetas y/o archivos con patrón Sentinel-2
$patron = '^S2[A-B-C]_MSIL2A_(\d{8})T'     # captura 8 dígitos tras S2A_MSIL2A_

$fechas = Get-ChildItem -Path $raiz -Recurse -Name |
          Where-Object { $_ -match $patron } |
          ForEach-Object { ($Matches[1]) } |   # el grupo (\d{8})
          Sort-Object -Unique

# 2) Guardar resultado
$fechas | Out-File -FilePath $salidaTxt -Encoding UTF8

Write-Host "`n✅  Se han encontrado $($fechas.Count) fechas. Listado en:`n$salidaTxt"



# ============================================
# CONFIGURACION
# ============================================

# Año a procesar (modifica solo esta línea para otro año)
$anio = "2025"

# Ruta origen de los CSV generados por CombiCap
$origen = "D:\img\estadisticos\combicapa_$anio"

# Carpeta destino común donde se copian
$destino = "D:\img\estadisticos\anual\$anio"

# Crear destino si no existe
if (-not (Test-Path $destino)) {
    New-Item -ItemType Directory -Path $destino | Out-Null
}

# ============================================
# 1. COPIAR CSV ORIGINALES A CARPETA ANUAL
# ============================================

Write-Host "`n== COPIANDO CSV A LA CARPETA ANUAL =="

$csvs = Get-ChildItem -Path $origen -Filter *.csv
foreach ($archivo in $csvs) {
    $destPath = Join-Path -Path $destino -ChildPath $archivo.Name
    Copy-Item -Path $archivo.FullName -Destination $destPath -Force
    Write-Host "✔ Copiado: $($archivo.Name) -> $destino"
}

# ============================================
# 2. RECORTAR Y RENOMBRAR CSV
# ============================================

Write-Host "`n== FILTRANDO Y RENOMBRANDO LOS CSV =="

# Detectar número de columnas MEDIANA
$primero = Import-Csv -Path (Get-ChildItem -Path $destino -Filter *.csv)[0].FullName -Delimiter ";"
$colNames = $primero[0].PSObject.Properties.Name
$nFechas  = ($colNames | Where-Object { $_ -like 'MEDIANA*' }).Count

# Generar columnas automáticamente
$columnas = @("ID_GRAFIC", "NOMBRE")
for ($i = 1; $i -le $nFechas; $i++) {
    if ($i -eq 1) {
        $columnas += "NREG_DADES"
        $columnas += "MEDIANA"
    } else {
        $columnas += "NREG_DADES$i"
        $columnas += "MEDIANA$i"
    }
}

# Recorrer todos los CSV copiados
Get-ChildItem -Path $destino -Filter *.csv | ForEach-Object {
    $archivo = $_
    Write-Host "Procesando $($archivo.Name)..."

    $datos = Import-Csv -Path $archivo.FullName -Delimiter ";"

    if ($datos.Count -gt 0) {
        $columnasPresentes = $columnas | Where-Object { $_ -in $datos[0].PSObject.Properties.Name }
        $datosFiltrados = $datos | Select-Object -Property $columnasPresentes

        # Renombrar como nombre_MEDIANA_2015.csv
        $nombreOriginal = [System.IO.Path]::GetFileNameWithoutExtension($archivo.Name)
        $nombreLimpio = $nombreOriginal -replace "_estadisticas_$anio", ""
        $nuevoNombre = "${nombreLimpio}_MEDIANA_${anio}.csv"
        $rutaSalida = Join-Path $destino $nuevoNombre

        # Guardar nuevo CSV
        $datosFiltrados | Export-Csv -Path $rutaSalida -NoTypeInformation -Encoding UTF8 -Delimiter ";"
        Write-Host "✔ Guardado: $rutaSalida"
    } else {
        Write-Host "⚠️  Archivo vacío o sin datos válidos: $($archivo.Name)"
    }
}

Write-Host "`n✅ Todos los archivos han sido copiados y recortados correctamente para el año $anio."
