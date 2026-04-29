@echo off 
setlocal ENABLEDELAYEDEXPANSION

rem ======= CONFIGURACIÓN ========
set "origen=C:\Users\farin\Downloads\img"
set "year=2022"
set "ruta_anio=%origen%\%year%"
set "salida_dir=%origen%\_imagenes_nodata"
if not exist "%salida_dir%" mkdir "%salida_dir%"
set "archivo_salida=%salida_dir%\archivos_nodata_%year%.txt"
echo. > "%archivo_salida%"  rem Vaciar o crear archivo de salida

rem ======= BÚSQUEDA DE REL CON NODATA ========
for /R "%ruta_anio%" %%f in ("*_NDVI_10m_maskI.rel") do (
    set "minimo="
    set "maximo="

    for /F "usebackq tokens=1,* delims==" %%a in ("%%f") do (
        set "clave=%%a"
        set "valor=%%b"
        set "clave=!clave: =!"
        set "valor=!valor: =!"

        if /I "!clave!"=="Min" set "minimo=!valor!"
        if /I "!clave!"=="Max" set "maximo=!valor!"
    )

    if "!minimo!"=="255" if "!maximo!"=="255" (
        rem Subir desde el REL hasta la carpeta Sentinel (2 niveles arriba)
        for %%g in ("%%~dpf..\..\") do (
            echo %%~nxf>>"%archivo_salida%"
            echo Carpeta con NoData detectada: %%~nxf
        )
    )
)

echo
echo Analisis finalizado. Resultado guardado en: %archivo_salida%


