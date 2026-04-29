# ================================
# CONFIGURACIÓN
# ================================

$anio = "2025"
$carpetaCSV = "D:\img\estadisticos\anual\$anio"
$rutaFechas = "D:\img\estadisticos\combicapa_$anio\fechas_$anio.txt"

# ================================
# CARGAR FECHAS
# ================================

if (-Not (Test-Path $rutaFechas)) {
    Write-Error "❌ Archivo de fechas no encontrado."
    exit
}
$fechas = Get-Content $rutaFechas

# ================================
# PROCESAR TODOS LOS CSV
# ================================

Get-ChildItem -Path $carpetaCSV -Filter "*_MEDIANA_${anio}.csv" | ForEach-Object {

    $rutaCSV = $_.FullName
    Write-Host "`n📂 Procesando: $($_.Name)"

    $lineas = Get-Content $rutaCSV
    if ($lineas.Count -eq 0) {
        Write-Warning "⚠️ Archivo vacío: $($_.Name)"
        return
    }

    # Detectar delimitador automáticamente
    $primeralinea = $lineas[0]
    $delimitador = if ($primeralinea -match ';') { ';' } else { ',' }

    # Renombrar cabeceras
    $cabecera = $lineas[0] -split $delimitador

    for ($i = 0; $i -lt $cabecera.Count; $i++) {
        $col = $cabecera[$i].Trim('"')

        if ($col -match '^MEDIANA(\d*)$') {
            $n = if ($Matches[1] -eq '') { 0 } else { [int]$Matches[1] - 1 }
            if ($n -lt $fechas.Count) {
                $cabecera[$i] = "MEDIANA_$($fechas[$n])"
            }
        }
        elseif ($col -match '^NREG_DADES(\d*)$') {
            $n = if ($Matches[1] -eq '') { 0 } else { [int]$Matches[1] - 1 }
            if ($n -lt $fechas.Count) {
                $cabecera[$i] = "nDATOS_$($fechas[$n])"
            }
        }
    }

    # Reemplazar cabecera y guardar
    $lineas[0] = $cabecera -join $delimitador
    Set-Content -Path $rutaCSV -Value $lineas -Encoding UTF8 -Force

    Write-Host "✅ Cabeceras actualizadas: $($_.Name)"
}

Write-Host "`n🎉 Todos los archivos han sido actualizados correctamente."
