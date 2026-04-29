# ==========================================================================
# Fusionar archivos CSV ya renombrados (sin modificar nombres de columnas)
# ==========================================================================
$basePath = "D:\img\estadisticos\anual"
$indice   = "NDSI"           # <- Cambiar si es necesario
$resol    = "20m"
$tipo     = "MEDIANA"

$columnasFijas = @("ID_GRAFIC", "NOMBRE")
$csvTotales = @()

# Buscar y ordenar archivos por año según el nombre
$csvPaths = Get-ChildItem -Path $basePath -Recurse -Filter "${indice}_${resol}_mask_${tipo}_*.csv" |
    Sort-Object {
        if ($_ -match "_${tipo}_(\d{4})\.csv") { [int]$matches[1] } else { 9999 }
    }

$i = 0
foreach ($csv in $csvPaths) {
    Write-Host "Procesando: $($csv.Name)"
    $df = Import-Csv -Path $csv.FullName -Delimiter ';'

    if ($i -eq 0) {
        $csvTotales = $df
    }
    else {
        # Excluir columnas fijas para evitar duplicarlas
        $dfExtra = $df | Select-Object -ExcludeProperty $columnasFijas
        for ($r = 0; $r -lt $csvTotales.Count; $r++) {
            foreach ($prop in $dfExtra[$r].PSObject.Properties.Name) {
                $csvTotales[$r] | Add-Member -NotePropertyName $prop -NotePropertyValue $dfExtra[$r].$prop -Force
            }
        }
    }
    $i++
}

# Guardar archivo final combinado
$outFile = Join-Path $basePath "${indice}_${resol}_mask_${tipo}_TOT.csv"
$csvTotales | Export-Csv -Path $outFile -Delimiter ';' -NoTypeInformation -Encoding UTF8

Write-Host "`n✅ Guardado archivo combinado: $outFile"
