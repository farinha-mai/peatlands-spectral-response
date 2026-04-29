# Cambiar solo esta línea para actualizar el año
$year = 2024

# Definir rutas usando interpolación de variables
$archivoEntrada = "D:\img\$year\listado_carpetas_$year.txt"
$archivoSalida  = "D:\img\$year\ultimas_versiones_$year.txt"
#$archivoEntrada = "C:\Users\farin\Downloads\img\$year\listado_carpetas_$year.txt"
#$archivoSalida  = "C:\Users\farin\Downloads\img\$year\ultimas_versiones_$year.txt"

# Leer las líneas del archivo
$carpetas = Get-Content $archivoEntrada | Where-Object { $_ -ne "" }

# Crear un diccionario (Hashtable) para almacenar la versión más reciente por fecha de adquisición
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

# Extraer solo los nombres de carpeta seleccionados
$resultadoFinal = $ultimosProcesados.Values | ForEach-Object { $_[1] } | Sort-Object

# Guardar en archivo de salida
$resultadoFinal | Out-File -FilePath $archivoSalida -Encoding UTF8

Write-Host "✔ Listado de versiones más recientes generado: $archivoSalida"