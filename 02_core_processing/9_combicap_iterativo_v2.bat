@echo off
setlocal EnableDelayedExpansion

rem === CONFIGURACIÓN GENERAL ==========================================
set "origen=D:\img"
set "year=2025"
set "polig_base=%origen%\poligonos_turberas\poligonos_turberas.pol"
set "dest=%origen%\estadisticos\combicapa_%year%"
if not exist "%dest%" md "%dest%"

set "log_fechas=%dest%\fechas_iteracion_%year%.txt"
echo. > "%log_fechas%"  rem limpiar archivo de fechas

set "LISTA_MASK=NDVI_10m_mask NDSI_20m_mask NDWI_10m_mask NDWI_v_20m_mask"

rem ====================================================================
for %%M in (%LISTA_MASK%) do (
    echo -------------------------------
    echo Procesando índice: %%M
    echo -------------------------------

    set "tmpList=%dest%\_tmp_archivos.txt"
    set "ordenadoList=%dest%\_ordenado.txt"
    if exist "!tmpList!" del "!tmpList!"
    if exist "!ordenadoList!" del "!ordenadoList!"

    rem -- buscar imágenes y guardar (fecha|nombre|ruta)
    for /R "%origen%\%year%" %%F in ("31TCH_zona_estudio\*%%M.img") do (
        set "nombre=%%~nF"
        set "fecha=!nombre:~14,8!"
        echo !fecha!^|!nombre!^|%%F>>"!tmpList!"
    )

    rem -- ordenar por fecha
    sort "!tmpList!" > "!ordenadoList!"

    set "salida_base="
    set "ultima_dbf="
    set /a contador=0

    rem -- recorrer archivo ordenado
    for /F "tokens=1-3 delims=|" %%A in (!ordenadoList!) do (
        set /a contador+=1
        set "fecha=%%A"
        set "nombre=%%B"
        set "input_img=%%C"

        echo Iteración !contador! - %%M - Fecha !fecha!>>"!log_fechas!"

        if !contador! EQU 1 (
            set "entrada_pol=%polig_base%"
        ) else (
            set "entrada_pol=!salida_base!"
        )

        set "salida_base=%dest%\%%M_estadisticas_!fecha!.pol"
        set "ultima_dbf=!salida_base:.pol=P.dbf!"

        if not exist "!salida_base!" (
            echo   CombiCap --> !salida_base!
            C:\MiraMon\CombiCap ^
                "!entrada_pol!" ^
                "!input_img!" ^
                /OVR_RAS_POL=ESTAD ^
                /MEDIANA_EMPAT=1 ^
                /FCAPA="!salida_base!" /SAC
        ) else (
            echo   [SKIP] ya existe !salida_base!
        )
    )

    rem -- Exportar CSV si hubo iteraciones
    if !contador! GTR 0 (
        set "csv_final=%dest%\%%M_estadisticas_%year%.csv"
        if exist "!ultima_dbf!" (
            echo   Exportando CSV final: !csv_final!
            C:\MiraMon\DBFCSV 1 "!ultima_dbf!" "!csv_final!"
        ) else (
            echo   [ERROR] No se encontró DBF para exportar: !ultima_dbf!
        )
    ) else (
        echo   [AVISO] No se encontraron imágenes para %%M
    )

    echo Terminado índice: %%M
    echo.
)

echo ============================
echo   PROCESO COMPLETADO
echo ============================
endlocal
pause
