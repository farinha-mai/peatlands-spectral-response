setlocal ENABLEDELAYEDEXPANSION

cls


set origen=D:\img
set year=2022
cd %origen%\%year%
@echo %origen%\%year%

goto REFLECTANCIAS_A

rem -------------Importar a IMG------------------
for /R %origen%\%year% %%i in ("*_MSIL2A.xml") do (

C:\MiraMon\SentIMG 1 %%i %%~dpi_importar_miramom /IMPORT_QI /COPY_QI)

@echo IMPORTACION

rem ----------------------------------
rem -------------------S2A---------------
rem ----------------------------------

rem -------------Cortar las imágenes------------------

for /R %origen%\%year% %%i in ("S2A_L2A_31TCH_*_B0?-V_10m.img") do (

rem Filtrar para NO procesar imagenes ya recortadas
echo %%i | find /I "_zona_estudio\" >nul
if errorlevel 1 (
rem Obtener ruta al directorio anterior a 10m
set ruta=%%~dpi
set ruta=!ruta:~0,-5!
echo Procesando: %%i
C:\MiraMon\Retalla 1 %%i !ruta!_zona_estudio 310000 355300 4713600 4743600 /MULTIBANDA /SAC)
)

for /R %origen%\%year% %%i in ("S2A_L2A_31TCH_*_B0?-V_20m.img") do (

rem Filtrar para NO procesar imagenes ya recortadas
echo %%i | find /I "_zona_estudio\" >nul
if errorlevel 1 (
rem Obtener ruta al directorio anterior a 20m
set ruta=%%~dpi
set ruta=!ruta:~0,-5!
echo Procesando: %%i
C:\MiraMon\Retalla 1 %%i !ruta!_zona_estudio 310000 355300 4713600 4743600 /MULTIBANDA /SAC)
)

for /R %origen%\%year% %%i in ("S2A_L2A_31TCH_*_SCL.img") do (

rem Filtrar para NO procesar imagenes ya recortadas
echo %%i | find /I "_zona_estudio\" >nul
if errorlevel 1 (
rem Obtener ruta al directorio anterior a 60m
set ruta=%%~dpi
set ruta=!ruta:~0,-5!
echo Procesando: %%i
C:\MiraMon\Retalla 1 %%i !ruta!_zona_estudio 310000 355300 4713600 4743600 /MULTIBANDA /SAC)
)
@echo LISTO RETALLA

:REFLECTANCIAS_A

rem -----------------------------Calcular reflectancias-----------------------------------

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\reflectancia.mmc


rem -------------------------------- B03 10m --------------------------------

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2A_L2A_31TCH_*_B03-V_10m.img") do (

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpireflectancia.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpireflectancia.mmc Variables

    rem Asignar la banda de entrada
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Variables BANDA %%i

    rem Definir fichero de salida
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Sortida Fitxer %%~dpi%%~ni_refl.img

    rem Ejecutamos la calculadora
    C:\MiraMon\Calcimg.exe %%~dpireflectancia.mmc
)


rem -------------------------------- B04 10m --------------------------------

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2A_L2A_31TCH_*_B04-R_10m.img") do (

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpireflectancia.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpireflectancia.mmc Variables

    rem Asignar la banda de entrada
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Variables BANDA %%i

    rem Definir fichero de salida
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Sortida Fitxer %%~dpi%%~ni_refl.img

    rem Ejecutamos la calculadora
    C:\MiraMon\Calcimg.exe %%~dpireflectancia.mmc
)


rem -------------------------------- B08 10m --------------------------------

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2A_L2A_31TCH_*_B08-IRp_10m.img") do (

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpireflectancia.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpireflectancia.mmc Variables

    rem Asignar la banda de entrada
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Variables BANDA %%i

    rem Definir fichero de salida
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Sortida Fitxer %%~dpi%%~ni_refl.img

    rem Ejecutamos la calculadora
    C:\MiraMon\Calcimg.exe %%~dpireflectancia.mmc
)


rem -------------------------------- B03 20m --------------------------------

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2A_L2A_31TCH_*_B03-V_20m.img") do (

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpireflectancia.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpireflectancia.mmc Variables

    rem Asignar la banda de entrada
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Variables BANDA %%i

    rem Definir fichero de salida
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Sortida Fitxer %%~dpi%%~ni_refl.img

    rem Ejecutamos la calculadora
    C:\MiraMon\Calcimg.exe %%~dpireflectancia.mmc
)


rem -------------------------------- B08A 20m --------------------------------

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2A_L2A_31TCH_*_B08A-IRp_20m.img") do (

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpireflectancia.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpireflectancia.mmc Variables

    rem Asignar la banda de entrada
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Variables BANDA %%i

    rem Definir fichero de salida
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Sortida Fitxer %%~dpi%%~ni_refl.img

    rem Ejecutamos la calculadora
    C:\MiraMon\Calcimg.exe %%~dpireflectancia.mmc
)


rem -------------------------------- B11 20m --------------------------------

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2A_L2A_31TCH_*_B11-IRoc_20m.img") do (

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpireflectancia.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpireflectancia.mmc Variables

    rem Asignar la banda de entrada
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Variables BANDA %%i

    rem Definir fichero de salida
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Sortida Fitxer %%~dpi%%~ni_refl.img

    rem Ejecutamos la calculadora
    C:\MiraMon\Calcimg.exe %%~dpireflectancia.mmc
)

@echo LISTO REFLECTANCIAS S2A


rem -----------------------------Calcular indices-----------------------------------

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2A_L2A_31TCH_*_B08-IRp_10m_refl.img") do (
set data=%%~ni
set data=!data:~14,8!

C:\MiraMon\Indexs 3 %%i %%~dpiS2A_L2A_31TCH_!data!_B04-R_10m_refl.img %%~dpiS2A_L2A_31TCH_!data!_NDVI_10m.img /SAC
C:\MiraMon\Indexs 17 %%i %%~dpiS2A_L2A_31TCH_!data!_B03-V_10m_refl.img %%~dpiS2A_L2A_31TCH_!data!_NDWI_10m.img /SAC)

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2A_L2A_31TCH_*_B08A-IRp_20m_refl.img") do (
set data=%%~ni
set data=!data:~14,8!

C:\MiraMon\Indexs 25 %%~dpiS2A_L2A_31TCH_!data!_B08A-IRp_20m_refl.img %%~dpiS2A_L2A_31TCH_!data!_B11-IRoc_20m_refl.img %%~dpiS2A_L2A_31TCH_!data!_NDWI_veget_20m.img /SAC
C:\MiraMon\Indexs 23 %%~dpiS2A_L2A_31TCH_!data!_B03-V_20m_refl.img %%~dpiS2A_L2A_31TCH_!data!_B11-IRoc_20m_refl.img %%~dpiS2A_L2A_31TCH_!data!_NDSI_20m.img /SAC)





rem ------------------------------ Importar metadatos --------------------------------


for /R %origen%\%year% %%i in ("31TCH_zona_estudio\*.img") do (
    set nombre=%%~ni
    set date=!nombre:~14,8!
    C:\MiraMon\Canvirel 1 %%~dpi%%~ni.rel OVERVIEW contentdate !date! /SAC
)



rem ------------------------------ Generar mascaras --------------------------------

rem -------------------------------- mask_base.mmc

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\mask_base.mmc

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2A_L2A_31TCH_*_SCL.img") do (

    set "carpeta=%%~dpi"
    set "carpeta=!carpeta:~0,-1!"
    set "nombre=%%~ni"
    set "date=!nombre:~14,8!"

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpimask_base.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpimask_base.mmc Variables

    rem Ahora asignamos la variable con la ruta de imagen correcta
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_base.mmc Variables SCL %%i
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_base.mmc Reclassificadors MMReclas_0_NODATA %origen%\MMReclas_0_NODATA.mrc
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_base.mmc Sortida Fitxer %%~dpiS2A_L2A_31TCH_!date!_mask_base.img

    rem Ejecutamos la calculadora
    C:\MiraMon\Calcimg.exe %%~dpimask_base.mmc /SAC
)



rem -------------------------------- mask_nieve.mmc

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\mask_nieve.mmc

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2A_L2A_31TCH_*_NDSI_20m.img") do (

    set "carpeta=%%~dpi"
    set "carpeta=!carpeta:~0,-1!"
    set "nombre=%%~ni"
    set "date=!nombre:~14,8!"

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpimask_nieve.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpimask_nieve.mmc Variables

    rem Ahora asignamos la variable correcta
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_nieve.mmc Variables NDSI_20m %%i

    rem Los reclassificadores
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_nieve.mmc Reclassificadors MMReclas_0_NODATA %origen%\MMReclas_0_NODATA.mrc

    rem Salida
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_nieve.mmc Sortida Fitxer %%~dpiS2A_L2A_31TCH_!date!_mask_nieve.img

    rem Ejecutamos
    C:\MiraMon\Calcimg.exe %%~dpimask_nieve.mmc /SAC
)


rem -------------------------------- mask_agua

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\mask_agua.mmc

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2A_L2A_31TCH_*_NDWI_10m.img") do (

    set "carpeta=%%~dpi"
    set "carpeta=!carpeta:~0,-1!"
    set "nombre=%%~ni"
    set "date=!nombre:~14,8!"

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpimask_agua.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpimask_agua.mmc Variables

    rem Ahora asignamos la variable correcta
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_agua.mmc Variables NDWI_10m %%i

    rem Los reclassificadores
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_agua.mmc Reclassificadors MMReclas_0_NODATA %origen%\MMReclas_0_NODATA.mrc

    rem Salida
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_agua.mmc Sortida Fitxer %%~dpiS2A_L2A_31TCH_!date!_mask_agua.img

    rem Ejecutamos
    C:\MiraMon\Calcimg.exe %%~dpimask_agua.mmc /SAC
)


rem ---------------------- DENSIFICAR máscaras de nieve ----------------------

setlocal EnableDelayedExpansion

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2A_L2A_31TCH_*_mask_nieve.img") do (

    set "carpeta=%%~dpi"
    set "nombre=%%~ni"
    
    rem Extraemos la fecha después de mask_nieve_
    set "date=!nombre:~14,8!"

    rem Construimos el path final
    set "salida=!carpeta!S2A_L2A_31TCH_!date!_mask_nieve_10m"

    rem Ejecutamos densificación
    C:\MiraMon\DensRas %%i !salida! 310000 355300 4713600 4743600 10 V

)


rem -------------------------------- mask_1 = mask_agua * mask_nieve

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\mask_1.mmc

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2A_L2A_31TCH_*_mask_nieve_10m.img") do (

    set "carpeta=%%~dpi"
    set "carpeta=!carpeta:~0,-1!"
    set "nombre=%%~ni"
    set "date=!nombre:~14,8!"

    rem Creamos ruta de mask_agua usando la fecha
    set "agua_path=!carpeta!\S2A_L2A_31TCH_!date!_mask_agua.img"

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpimask_1.mmc

    rem ELIMINAR VARIABLES ANTERIORES
    C:\MiraMon\Canvirel.exe 3 %%~dpimask_1.mmc Variables

    rem Asignar variables correctas
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_1.mmc Variables mask_agua !agua_path!
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_1.mmc Variables mask_nieve_10m %%i

    rem Reclassificadores
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_1.mmc Reclassificadors MMReclas_0_NODATA %origen%\MMReclas_0_NODATA.mrc

    rem Salida final
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_1.mmc Sortida Fitxer %%~dpiS2A_L2A_31TCH_!date!_mask_1.img

    rem Ejecutar la calculadora
    C:\MiraMon\Calcimg.exe %%~dpimask_1.mmc /SAC

)


rem -------------------------------- mask_2.mmc

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\mask_2.mmc

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2A_L2A_31TCH_*_SCL.img") do (

    set "carpeta=%%~dpi"
    set "carpeta=!carpeta:~0,-1!"
    set "nombre=%%~ni"
    set "date=!nombre:~14,8!"

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpimask_2.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpimask_2.mmc Variables

    rem Ahora asignamos la variable con la ruta de imagen correcta
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_2.mmc Variables SCL %%i
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_2.mmc Reclassificadors MMReclas_0_NODATA %origen%\MMReclas_0_NODATA.mrc
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_2.mmc Sortida Fitxer %%~dpiS2A_L2A_31TCH_!date!_mask_2.img

    rem Ejecutamos la calculadora
    C:\MiraMon\Calcimg.exe %%~dpimask_2.mmc /SAC
)


rem -------------------DENSIFICAR mask_base a 10m----------------------

setlocal EnableDelayedExpansion

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2A_L2A_31TCH_*_mask_base.img") do (

    set "carpeta=%%~dpi"
    set "nombre=%%~ni"
    
    rem Extraemos la fecha después de mask_base_
    set "date=!nombre:~14,8!"

    rem Construimos el path final
    set "salida=!carpeta!S2A_L2A_31TCH_!date!_mask_base_10m"

    rem Ejecutamos densificación
    C:\MiraMon\DensRas %%i !salida! 310000 355300 4713600 4743600 10 V

)




rem -------------------CALCULAR INDICES ENMASACARADOS---------------

rem -------------------NDVI_mask

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\NDVI_mask.mmc

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2A_L2A_31TCH_*_NDVI_10m.img") do (

    set "carpeta=%%~dpi"
    set "carpeta=!carpeta:~0,-1!"
    set "nombre=%%~ni"
    set "date=!nombre:~14,8!"

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpiNDVI_mask.mmc

    rem ELIMINAR VARIABLES ANTERIORES
    C:\MiraMon\Canvirel.exe 3 %%~dpiNDVI_mask.mmc Variables

    rem Antes del bloque de variables
    set "mascara_dir=%%~dpi"

    rem Asignar variables correctas
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDVI_mask.mmc Variables NDVI %%i
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDVI_mask.mmc Variables mask_base_10m !mascara_dir!S2A_L2A_31TCH_!date!_mask_base_10m.img
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDVI_mask.mmc Variables mask_1 !mascara_dir!S2A_L2A_31TCH_!date!_mask_1.img

    rem Reclassificadores
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDVI_mask.mmc Reclassificadors MMReclas_0_NODATA %origen%\MMReclas_0_NODATA.mrc

    rem Salida final
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDVI_mask.mmc Sortida Fitxer %%~dpiS2A_L2A_31TCH_!date!_NDVI_10m_mask.img

    rem Ejecutar la calculadora
    C:\MiraMon\Calcimg.exe %%~dpiNDVI_mask.mmc /SAC

)


rem -------------------NDSI_mask

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\NDSI_mask.mmc

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2A_L2A_31TCH_*_NDSI_20m.img") do (

    set "carpeta=%%~dpi"
    set "carpeta=!carpeta:~0,-1!"
    set "nombre=%%~ni"
    set "date=!nombre:~14,8!"

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpiNDSI_mask.mmc

    rem ELIMINAR VARIABLES ANTERIORES
    C:\MiraMon\Canvirel.exe 3 %%~dpiNDSI_mask.mmc Variables

    rem Antes del bloque de variables
    set "mascara_dir=%%~dpi"

    rem Asignar variables correctas
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDSI_mask.mmc Variables NDSI %%i
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDSI_mask.mmc Variables mask_base !mascara_dir!S2A_L2A_31TCH_!date!_mask_base.img
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDSI_mask.mmc Variables mask_2 !mascara_dir!S2A_L2A_31TCH_!date!_mask_2.img

    rem Reclassificadores
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDSI_mask.mmc Reclassificadors MMReclas_0_NODATA %origen%\MMReclas_0_NODATA.mrc

    rem Salida final
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDSI_mask.mmc Sortida Fitxer %%~dpiS2A_L2A_31TCH_!date!_NDSI_20m_mask.img

    rem Ejecutar la calculadora
    C:\MiraMon\Calcimg.exe %%~dpiNDSI_mask.mmc /SAC

)



rem -------------------NDWI_mask 

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\NDWI_mask.mmc

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2A_L2A_31TCH_*_NDWI_10m.img") do (

    set "carpeta=%%~dpi"
    set "carpeta=!carpeta:~0,-1!"
    set "nombre=%%~ni"
    set "date=!nombre:~14,8!"

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpiNDWI_mask.mmc

    rem ELIMINAR VARIABLES ANTERIORES
    C:\MiraMon\Canvirel.exe 3 %%~dpiNDWI_mask.mmc Variables

    rem Antes del bloque de variables
    set "mascara_dir=%%~dpi"

    rem Asignar variables correctas
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDWI_mask.mmc Variables NDWI %%i
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDWI_mask.mmc Variables mask_base_10m !mascara_dir!S2A_L2A_31TCH_!date!_mask_base_10m.img

    rem Reclassificadores
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDWI_mask.mmc Reclassificadors MMReclas_0_NODATA %origen%\MMReclas_0_NODATA.mrc

    rem Salida final
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDWI_mask.mmc Sortida Fitxer %%~dpiS2A_L2A_31TCH_!date!_NDWI_10m_mask.img

    rem Ejecutar la calculadora
    C:\MiraMon\Calcimg.exe %%~dpiNDWI_mask.mmc /SAC

)



rem -------------------NDWI_veget_mask 

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\NDWI_veget_mask.mmc

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2A_L2A_31TCH_*_NDWI_veget_20m.img") do (

    set "carpeta=%%~dpi"
    set "carpeta=!carpeta:~0,-1!"
    set "nombre=%%~ni"
    set "date=!nombre:~14,8!"

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpiNDWI_veget_mask.mmc

    rem ELIMINAR VARIABLES ANTERIORES
    C:\MiraMon\Canvirel.exe 3 %%~dpiNDWI_veget_mask.mmc Variables

    rem Antes del bloque de variables
    set "mascara_dir=%%~dpi"

    rem Asignar variables correctas
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDWI_veget_mask.mmc Variables NDWI_veget %%i
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDWI_veget_mask.mmc Variables mask_base !mascara_dir!S2A_L2A_31TCH_!date!_mask_base.img

    rem Reclassificadores
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDWI_veget_mask.mmc Reclassificadors MMReclas_0_NODATA %origen%\MMReclas_0_NODATA.mrc

    rem Salida final
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDWI_veget_mask.mmc Sortida Fitxer %%~dpiS2A_L2A_31TCH_!date!_NDWI_v_20m_mask.img

    rem Ejecutar la calculadora
    C:\MiraMon\Calcimg.exe %%~dpiNDWI_veget_mask.mmc /SAC

)



rem ----------------------------------
rem -------------------S2B---------------
rem ----------------------------------

goto REFLECTANCIAS_B

rem -------------Cortar las imágenes------------------


for /R %origen%\%year% %%i in ("S2B_L2A_31TCH_*_B0?-V_10m.img") do (

rem Filtrar para NO procesar imagenes ya recortadas
echo %%i | find /I "_zona_estudio\" >nul
if errorlevel 1 (
rem Obtener ruta al directorio anterior a 10m
set ruta=%%~dpi
set ruta=!ruta:~0,-5!
echo Procesando: %%i
C:\MiraMon\Retalla 1 %%i !ruta!_zona_estudio 310000 355300 4713600 4743600 /MULTIBANDA /SAC)
)

for /R %origen%\%year% %%i in ("S2B_L2A_31TCH_*_B0?-V_20m.img") do (

rem Filtrar para NO procesar imagenes ya recortadas
echo %%i | find /I "_zona_estudio\" >nul
if errorlevel 1 (
rem Obtener ruta al directorio anterior a 20m
set ruta=%%~dpi
set ruta=!ruta:~0,-5!
echo Procesando: %%i
C:\MiraMon\Retalla 1 %%i !ruta!_zona_estudio 310000 355300 4713600 4743600 /MULTIBANDA /SAC)
)

for /R %origen%\%year% %%i in ("S2B_L2A_31TCH_*_SCL.img") do (

rem Filtrar para NO procesar imagenes ya recortadas
echo %%i | find /I "_zona_estudio\" >nul
if errorlevel 1 (
rem Obtener ruta al directorio anterior a 60m
set ruta=%%~dpi
set ruta=!ruta:~0,-5!
echo Procesando: %%i
C:\MiraMon\Retalla 1 %%i !ruta!_zona_estudio 310000 355300 4713600 4743600 /MULTIBANDA /SAC)
)
@echo LISTO RETALLA

:REFLECTANCIAS_B

rem -----------------------------Calcular reflectancias-----------------------------------

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\reflectancia.mmc


rem -------------------------------- B03 10m --------------------------------

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2B_L2A_31TCH_*_B03-V_10m.img") do (

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpireflectancia.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpireflectancia.mmc Variables

    rem Asignar la banda de entrada
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Variables BANDA %%i

    rem Definir fichero de salida
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Sortida Fitxer %%~dpi%%~ni_refl.img

    rem Ejecutamos la calculadora
    C:\MiraMon\Calcimg.exe %%~dpireflectancia.mmc /SAC
)


rem -------------------------------- B04 10m --------------------------------

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2B_L2A_31TCH_*_B04-R_10m.img") do (

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpireflectancia.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpireflectancia.mmc Variables

    rem Asignar la banda de entrada
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Variables BANDA %%i

    rem Definir fichero de salida
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Sortida Fitxer %%~dpi%%~ni_refl.img

    rem Ejecutamos la calculadora
    C:\MiraMon\Calcimg.exe %%~dpireflectancia.mmc
)


rem -------------------------------- B08 10m --------------------------------

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2B_L2A_31TCH_*_B08-IRp_10m.img") do (

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpireflectancia.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpireflectancia.mmc Variables

    rem Asignar la banda de entrada
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Variables BANDA %%i

    rem Definir fichero de salida
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Sortida Fitxer %%~dpi%%~ni_refl.img

    rem Ejecutamos la calculadora
    C:\MiraMon\Calcimg.exe %%~dpireflectancia.mmc
)


rem -------------------------------- B03 20m --------------------------------

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2B_L2A_31TCH_*_B03-V_20m.img") do (

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpireflectancia.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpireflectancia.mmc Variables

    rem Asignar la banda de entrada
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Variables BANDA %%i

    rem Definir fichero de salida
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Sortida Fitxer %%~dpi%%~ni_refl.img

    rem Ejecutamos la calculadora
    C:\MiraMon\Calcimg.exe %%~dpireflectancia.mmc
)


rem -------------------------------- B08A 20m --------------------------------

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2B_L2A_31TCH_*_B08A-IRp_20m.img") do (

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpireflectancia.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpireflectancia.mmc Variables

    rem Asignar la banda de entrada
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Variables BANDA %%i

    rem Definir fichero de salida
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Sortida Fitxer %%~dpi%%~ni_refl.img

    rem Ejecutamos la calculadora
    C:\MiraMon\Calcimg.exe %%~dpireflectancia.mmc
)


rem -------------------------------- B11 20m --------------------------------

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2B_L2A_31TCH_*_B11-IRoc_20m.img") do (

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpireflectancia.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpireflectancia.mmc Variables

    rem Asignar la banda de entrada
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Variables BANDA %%i

    rem Definir fichero de salida
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Sortida Fitxer %%~dpi%%~ni_refl.img

    rem Ejecutamos la calculadora
    C:\MiraMon\Calcimg.exe %%~dpireflectancia.mmc
)

@echo LISTO REFLECTANCIAS S2B


rem -----------------------------Calcular indices-----------------------------------

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2B_L2A_31TCH_*_B08-IRp_10m_refl.img") do (
set data=%%~ni
set data=!data:~14,8!

C:\MiraMon\Indexs 3 %%i %%~dpiS2B_L2A_31TCH_!data!_B04-R_10m_refl.img %%~dpiS2B_L2A_31TCH_!data!_NDVI_10m.img /SAC
C:\MiraMon\Indexs 17 %%i %%~dpiS2B_L2A_31TCH_!data!_B03-V_10m_refl.img %%~dpiS2B_L2A_31TCH_!data!_NDWI_10m.img /SAC)

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2B_L2A_31TCH_*_B08A-IRp_20m_refl.img") do (
set data=%%~ni
set data=!data:~14,8!

C:\MiraMon\Indexs 25 %%~dpiS2B_L2A_31TCH_!data!_B08A-IRp_20m_refl.img %%~dpiS2B_L2A_31TCH_!data!_B11-IRoc_20m_refl.img %%~dpiS2B_L2A_31TCH_!data!_NDWI_veget_20m.img /SAC
C:\MiraMon\Indexs 23 %%~dpiS2B_L2A_31TCH_!data!_B03-V_20m_refl.img %%~dpiS2B_L2A_31TCH_!data!_B11-IRoc_20m_refl.img %%~dpiS2B_L2A_31TCH_!data!_NDSI_20m.img /SAC)





rem ------------------------------ Importar metadatos --------------------------------


for /R %origen%\%year% %%i in ("31TCH_zona_estudio\*.img") do (
    set nombre=%%~ni
    set date=!nombre:~14,8!
    C:\MiraMon\Canvirel 1 %%~dpi%%~ni.rel OVERVIEW contentdate !date! /SAC
)



rem ------------------------------ Generar mascaras --------------------------------

rem -------------------------------- mask_base.mmc

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\mask_base.mmc

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2B_L2A_31TCH_*_SCL.img") do (

    set "carpeta=%%~dpi"
    set "carpeta=!carpeta:~0,-1!"
    set "nombre=%%~ni"
    set "date=!nombre:~14,8!"

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpimask_base.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpimask_base.mmc Variables

    rem Ahora asignamos la variable con la ruta de imagen correcta
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_base.mmc Variables SCL %%i
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_base.mmc Reclassificadors MMReclas_0_NODATA %origen%\MMReclas_0_NODATA.mrc
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_base.mmc Sortida Fitxer %%~dpiS2B_L2A_31TCH_!date!_mask_base.img

    rem Ejecutamos la calculadora
    C:\MiraMon\Calcimg.exe %%~dpimask_base.mmc /SAC
)



rem -------------------------------- mask_nieve.mmc

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\mask_nieve.mmc

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2B_L2A_31TCH_*_NDSI_20m.img") do (

    set "carpeta=%%~dpi"
    set "carpeta=!carpeta:~0,-1!"
    set "nombre=%%~ni"
    set "date=!nombre:~14,8!"

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpimask_nieve.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpimask_nieve.mmc Variables

    rem Ahora asignamos la variable correcta
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_nieve.mmc Variables NDSI_20m %%i

    rem Los reclassificadores
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_nieve.mmc Reclassificadors MMReclas_0_NODATA %origen%\MMReclas_0_NODATA.mrc

    rem Salida
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_nieve.mmc Sortida Fitxer %%~dpiS2B_L2A_31TCH_!date!_mask_nieve.img

    rem Ejecutamos
    C:\MiraMon\Calcimg.exe %%~dpimask_nieve.mmc /SAC
)


rem -------------------------------- mask_agua

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\mask_agua.mmc

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2B_L2A_31TCH_*_NDWI_10m.img") do (

    set "carpeta=%%~dpi"
    set "carpeta=!carpeta:~0,-1!"
    set "nombre=%%~ni"
    set "date=!nombre:~14,8!"

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpimask_agua.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpimask_agua.mmc Variables

    rem Ahora asignamos la variable correcta
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_agua.mmc Variables NDWI_10m %%i

    rem Los reclassificadores
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_agua.mmc Reclassificadors MMReclas_0_NODATA %origen%\MMReclas_0_NODATA.mrc

    rem Salida
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_agua.mmc Sortida Fitxer %%~dpiS2B_L2A_31TCH_!date!_mask_agua.img

    rem Ejecutamos
    C:\MiraMon\Calcimg.exe %%~dpimask_agua.mmc /SAC
)


rem ---------------------- DENSIFICAR máscaras de nieve ----------------------

setlocal EnableDelayedExpansion

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2B_L2A_31TCH_*_mask_nieve.img") do (

    set "carpeta=%%~dpi"
    set "nombre=%%~ni"
    
    rem Extraemos la fecha después de mask_nieve_
    set "date=!nombre:~14,8!"

    rem Construimos el path final
    set "salida=!carpeta!S2B_L2A_31TCH_!date!_mask_nieve_10m"

    rem Ejecutamos densificación
    C:\MiraMon\DensRas %%i !salida! 310000 355300 4713600 4743600 10 V

)


rem -------------------------------- mask_1 = mask_agua * mask_nieve

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\mask_1.mmc

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2B_L2A_31TCH_*_mask_nieve_10m.img") do (

    set "carpeta=%%~dpi"
    set "carpeta=!carpeta:~0,-1!"
    set "nombre=%%~ni"
    set "date=!nombre:~14,8!"

    rem Creamos ruta de mask_agua usando la fecha
    set "agua_path=!carpeta!\S2B_L2A_31TCH_!date!_mask_agua.img"

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpimask_1.mmc

    rem ELIMINAR VARIABLES ANTERIORES
    C:\MiraMon\Canvirel.exe 3 %%~dpimask_1.mmc Variables

    rem Asignar variables correctas
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_1.mmc Variables mask_agua !agua_path!
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_1.mmc Variables mask_nieve_10m %%i

    rem Reclassificadores
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_1.mmc Reclassificadors MMReclas_0_NODATA %origen%\MMReclas_0_NODATA.mrc

    rem Salida final
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_1.mmc Sortida Fitxer %%~dpiS2B_L2A_31TCH_!date!_mask_1.img

    rem Ejecutar la calculadora
    C:\MiraMon\Calcimg.exe %%~dpimask_1.mmc /SAC

)


rem -------------------------------- mask_2.mmc

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\mask_2.mmc

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2B_L2A_31TCH_*_SCL.img") do (

    set "carpeta=%%~dpi"
    set "carpeta=!carpeta:~0,-1!"
    set "nombre=%%~ni"
    set "date=!nombre:~14,8!"

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpimask_2.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpimask_2.mmc Variables

    rem Ahora asignamos la variable con la ruta de imagen correcta
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_2.mmc Variables SCL %%i
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_2.mmc Reclassificadors MMReclas_0_NODATA %origen%\MMReclas_0_NODATA.mrc
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_2.mmc Sortida Fitxer %%~dpiS2B_L2A_31TCH_!date!_mask_2.img

    rem Ejecutamos la calculadora
    C:\MiraMon\Calcimg.exe %%~dpimask_2.mmc /SAC
)


rem -------------------DENSIFICAR mask_base a 10m----------------------

setlocal EnableDelayedExpansion

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2B_L2A_31TCH_*_mask_base.img") do (

    set "carpeta=%%~dpi"
    set "nombre=%%~ni"
    
    rem Extraemos la fecha después de mask_base_
    set "date=!nombre:~14,8!"

    rem Construimos el path final
    set "salida=!carpeta!S2B_L2A_31TCH_!date!_mask_base_10m"

    rem Ejecutamos densificación
    C:\MiraMon\DensRas %%i !salida! 310000 355300 4713600 4743600 10 V

)




rem -------------------CALCULAR INDICES ENMASACARADOS---------------

rem -------------------NDVI_mask

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\NDVI_mask.mmc

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2B_L2A_31TCH_*_NDVI_10m.img") do (

    set "carpeta=%%~dpi"
    set "carpeta=!carpeta:~0,-1!"
    set "nombre=%%~ni"
    set "date=!nombre:~14,8!"

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpiNDVI_mask.mmc

    rem ELIMINAR VARIABLES ANTERIORES
    C:\MiraMon\Canvirel.exe 3 %%~dpiNDVI_mask.mmc Variables

    rem Antes del bloque de variables
    set "mascara_dir=%%~dpi"

    rem Asignar variables correctas
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDVI_mask.mmc Variables NDVI %%i
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDVI_mask.mmc Variables mask_base_10m !mascara_dir!S2B_L2A_31TCH_!date!_mask_base_10m.img
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDVI_mask.mmc Variables mask_1 !mascara_dir!S2B_L2A_31TCH_!date!_mask_1.img

    rem Reclassificadores
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDVI_mask.mmc Reclassificadors MMReclas_0_NODATA %origen%\MMReclas_0_NODATA.mrc

    rem Salida final
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDVI_mask.mmc Sortida Fitxer %%~dpiS2B_L2A_31TCH_!date!_NDVI_10m_mask.img

    rem Ejecutar la calculadora
    C:\MiraMon\Calcimg.exe %%~dpiNDVI_mask.mmc /SAC

)


rem -------------------NDSI_mask

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\NDSI_mask.mmc

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2B_L2A_31TCH_*_NDSI_20m.img") do (

    set "carpeta=%%~dpi"
    set "carpeta=!carpeta:~0,-1!"
    set "nombre=%%~ni"
    set "date=!nombre:~14,8!"

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpiNDSI_mask.mmc

    rem ELIMINAR VARIABLES ANTERIORES
    C:\MiraMon\Canvirel.exe 3 %%~dpiNDSI_mask.mmc Variables

    rem Antes del bloque de variables
    set "mascara_dir=%%~dpi"

    rem Asignar variables correctas
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDSI_mask.mmc Variables NDSI %%i
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDSI_mask.mmc Variables mask_base !mascara_dir!S2B_L2A_31TCH_!date!_mask_base.img
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDSI_mask.mmc Variables mask_2 !mascara_dir!S2B_L2A_31TCH_!date!_mask_2.img

    rem Reclassificadores
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDSI_mask.mmc Reclassificadors MMReclas_0_NODATA %origen%\MMReclas_0_NODATA.mrc

    rem Salida final
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDSI_mask.mmc Sortida Fitxer %%~dpiS2B_L2A_31TCH_!date!_NDSI_20m_mask.img

    rem Ejecutar la calculadora
    C:\MiraMon\Calcimg.exe %%~dpiNDSI_mask.mmc /SAC

)



rem -------------------NDWI_mask 

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\NDWI_mask.mmc

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2B_L2A_31TCH_*_NDWI_10m.img") do (

    set "carpeta=%%~dpi"
    set "carpeta=!carpeta:~0,-1!"
    set "nombre=%%~ni"
    set "date=!nombre:~14,8!"

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpiNDWI_mask.mmc

    rem ELIMINAR VARIABLES ANTERIORES
    C:\MiraMon\Canvirel.exe 3 %%~dpiNDWI_mask.mmc Variables

    rem Antes del bloque de variables
    set "mascara_dir=%%~dpi"

    rem Asignar variables correctas
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDWI_mask.mmc Variables NDWI %%i
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDWI_mask.mmc Variables mask_base_10m !mascara_dir!S2B_L2A_31TCH_!date!_mask_base_10m.img

    rem Reclassificadores
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDWI_mask.mmc Reclassificadors MMReclas_0_NODATA %origen%\MMReclas_0_NODATA.mrc

    rem Salida final
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDWI_mask.mmc Sortida Fitxer %%~dpiS2B_L2A_31TCH_!date!_NDWI_10m_mask.img

    rem Ejecutar la calculadora
    C:\MiraMon\Calcimg.exe %%~dpiNDWI_mask.mmc /SAC

)



rem -------------------NDWI_veget_mask 

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\NDWI_veget_mask.mmc

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2B_L2A_31TCH_*_NDWI_veget_20m.img") do (

    set "carpeta=%%~dpi"
    set "carpeta=!carpeta:~0,-1!"
    set "nombre=%%~ni"
    set "date=!nombre:~14,8!"

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpiNDWI_veget_mask.mmc

    rem ELIMINAR VARIABLES ANTERIORES
    C:\MiraMon\Canvirel.exe 3 %%~dpiNDWI_veget_mask.mmc Variables

    rem Antes del bloque de variables
    set "mascara_dir=%%~dpi"

    rem Asignar variables correctas
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDWI_veget_mask.mmc Variables NDWI_veget %%i
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDWI_veget_mask.mmc Variables mask_base !mascara_dir!S2B_L2A_31TCH_!date!_mask_base.img

    rem Reclassificadores
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDWI_veget_mask.mmc Reclassificadors MMReclas_0_NODATA %origen%\MMReclas_0_NODATA.mrc

    rem Salida final
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDWI_veget_mask.mmc Sortida Fitxer %%~dpiS2B_L2A_31TCH_!date!_NDWI_v_20m_mask.img

    rem Ejecutar la calculadora
    C:\MiraMon\Calcimg.exe %%~dpiNDWI_veget_mask.mmc /SAC

)


rem ----------------------------------
rem -------------------S2C---------------
rem ----------------------------------

goto REFLECTANCIAS_C

rem -------------Cortar las imágenes------------------

for /R %origen%\%year% %%i in ("S2C_L2A_31TCH_*_B0?-V_10m.img") do (

rem Filtrar para NO procesar imagenes ya recortadas
echo %%i | find /I "_zona_estudio\" >nul
if errorlevel 1 (
rem Obtener ruta al directorio anterior a 10m
set ruta=%%~dpi
set ruta=!ruta:~0,-5!
echo Procesando: %%i
C:\MiraMon\Retalla 1 %%i !ruta!_zona_estudio 310000 355300 4713600 4743600 /MULTIBANDA /SAC)
)

for /R %origen%\%year% %%i in ("S2C_L2A_31TCH_*_B0?-V_20m.img") do (

rem Filtrar para NO procesar imagenes ya recortadas
echo %%i | find /I "_zona_estudio\" >nul
if errorlevel 1 (
rem Obtener ruta al directorio anterior a 20m
set ruta=%%~dpi
set ruta=!ruta:~0,-5!
echo Procesando: %%i
C:\MiraMon\Retalla 1 %%i !ruta!_zona_estudio 310000 355300 4713600 4743600 /MULTIBANDA /SAC)
)

for /R %origen%\%year% %%i in ("S2C_L2A_31TCH_*_SCL.img") do (

rem Filtrar para NO procesar imagenes ya recortadas
echo %%i | find /I "_zona_estudio\" >nul
if errorlevel 1 (
rem Obtener ruta al directorio anterior a 60m
set ruta=%%~dpi
set ruta=!ruta:~0,-5!
echo Procesando: %%i
C:\MiraMon\Retalla 1 %%i !ruta!_zona_estudio 310000 355300 4713600 4743600 /MULTIBANDA /SAC)
)
@echo LISTO RETALLA

:REFLECTANCIAS_C

rem -----------------------------Calcular reflectancias-----------------------------------

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\reflectancia.mmc


rem -------------------------------- B03 10m --------------------------------

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2C_L2A_31TCH_*_B03-V_10m.img") do (

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpireflectancia.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpireflectancia.mmc Variables

    rem Asignar la banda de entrada
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Variables BANDA %%i

    rem Definir fichero de salida
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Sortida Fitxer %%~dpi%%~ni_refl.img

    rem Ejecutamos la calculadora
    C:\MiraMon\Calcimg.exe %%~dpireflectancia.mmc
)


rem -------------------------------- B04 10m --------------------------------

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2C_L2A_31TCH_*_B04-R_10m.img") do (

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpireflectancia.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpireflectancia.mmc Variables

    rem Asignar la banda de entrada
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Variables BANDA %%i

    rem Definir fichero de salida
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Sortida Fitxer %%~dpi%%~ni_refl.img

    rem Ejecutamos la calculadora
    C:\MiraMon\Calcimg.exe %%~dpireflectancia.mmc
)


rem -------------------------------- B08 10m --------------------------------

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2C_L2A_31TCH_*_B08-IRp_10m.img") do (

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpireflectancia.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpireflectancia.mmc Variables

    rem Asignar la banda de entrada
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Variables BANDA %%i

    rem Definir fichero de salida
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Sortida Fitxer %%~dpi%%~ni_refl.img

    rem Ejecutamos la calculadora
    C:\MiraMon\Calcimg.exe %%~dpireflectancia.mmc
)


rem -------------------------------- B03 20m --------------------------------

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2C_L2A_31TCH_*_B03-V_20m.img") do (

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpireflectancia.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpireflectancia.mmc Variables

    rem Asignar la banda de entrada
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Variables BANDA %%i

    rem Definir fichero de salida
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Sortida Fitxer %%~dpi%%~ni_refl.img

    rem Ejecutamos la calculadora
    C:\MiraMon\Calcimg.exe %%~dpireflectancia.mmc
)


rem -------------------------------- B08A 20m --------------------------------

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2C_L2A_31TCH_*_B08A-IRp_20m.img") do (

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpireflectancia.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpireflectancia.mmc Variables

    rem Asignar la banda de entrada
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Variables BANDA %%i

    rem Definir fichero de salida
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Sortida Fitxer %%~dpi%%~ni_refl.img

    rem Ejecutamos la calculadora
    C:\MiraMon\Calcimg.exe %%~dpireflectancia.mmc
)


rem -------------------------------- B11 20m --------------------------------

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2C_L2A_31TCH_*_B11-IRoc_20m.img") do (

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpireflectancia.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpireflectancia.mmc Variables

    rem Asignar la banda de entrada
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Variables BANDA %%i

    rem Definir fichero de salida
    C:\MiraMon\Canvirel.exe 1 %%~dpireflectancia.mmc Sortida Fitxer %%~dpi%%~ni_refl.img

    rem Ejecutamos la calculadora
    C:\MiraMon\Calcimg.exe %%~dpireflectancia.mmc
)

@echo LISTO REFLECTANCIAS S2C

rem -----------------------------Calcular indices-----------------------------------

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2C_L2A_31TCH_*_B08-IRp_10m_refl.img") do (
set data=%%~ni
set data=!data:~14,8!

C:\MiraMon\Indexs 3 %%i %%~dpiS2C_L2A_31TCH_!data!_B04-R_10m_refl.img %%~dpiS2C_L2A_31TCH_!data!_NDVI_10m.img /SAC
C:\MiraMon\Indexs 17 %%i %%~dpiS2C_L2A_31TCH_!data!_B03-V_10m_refl.img %%~dpiS2C_L2A_31TCH_!data!_NDWI_10m.img /SAC)

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2C_L2A_31TCH_*_B08A-IRp_20m_refl.img") do (
set data=%%~ni
set data=!data:~14,8!

C:\MiraMon\Indexs 25 %%~dpiS2C_L2A_31TCH_!data!_B08A-IRp_20m_refl.img %%~dpiS2C_L2A_31TCH_!data!_B11-IRoc_20m_refl.img %%~dpiS2C_L2A_31TCH_!data!_NDWI_veget_20m.img /SAC
C:\MiraMon\Indexs 23 %%~dpiS2C_L2A_31TCH_!data!_B03-V_20m_refl.img %%~dpiS2C_L2A_31TCH_!data!_B11-IRoc_20m_refl.img %%~dpiS2C_L2A_31TCH_!data!_NDSI_20m.img /SAC)





rem ------------------------------ Importar metadatos --------------------------------


for /R %origen%\%year% %%i in ("31TCH_zona_estudio\*.img") do (
    set nombre=%%~ni
    set date=!nombre:~14,8!
    C:\MiraMon\Canvirel 1 %%~dpi%%~ni.rel OVERVIEW contentdate !date! /SAC
)



rem ------------------------------ Generar mascaras --------------------------------

rem -------------------------------- mask_base.mmc

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\mask_base.mmc

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2C_L2A_31TCH_*_SCL.img") do (

    set "carpeta=%%~dpi"
    set "carpeta=!carpeta:~0,-1!"
    set "nombre=%%~ni"
    set "date=!nombre:~14,8!"

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpimask_base.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpimask_base.mmc Variables

    rem Ahora asignamos la variable con la ruta de imagen correcta
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_base.mmc Variables SCL %%i
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_base.mmc Reclassificadors MMReclas_0_NODATA %origen%\MMReclas_0_NODATA.mrc
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_base.mmc Sortida Fitxer %%~dpiS2C_L2A_31TCH_!date!_mask_base.img

    rem Ejecutamos la calculadora
    C:\MiraMon\Calcimg.exe %%~dpimask_base.mmc /SAC
)



rem -------------------------------- mask_nieve.mmc

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\mask_nieve.mmc

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2C_L2A_31TCH_*_NDSI_20m.img") do (

    set "carpeta=%%~dpi"
    set "carpeta=!carpeta:~0,-1!"
    set "nombre=%%~ni"
    set "date=!nombre:~14,8!"

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpimask_nieve.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpimask_nieve.mmc Variables

    rem Ahora asignamos la variable correcta
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_nieve.mmc Variables NDSI_20m %%i

    rem Los reclassificadores
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_nieve.mmc Reclassificadors MMReclas_0_NODATA %origen%\MMReclas_0_NODATA.mrc

    rem Salida
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_nieve.mmc Sortida Fitxer %%~dpiS2C_L2A_31TCH_!date!_mask_nieve.img

    rem Ejecutamos
    C:\MiraMon\Calcimg.exe %%~dpimask_nieve.mmc /SAC
)


rem -------------------------------- mask_agua

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\mask_agua.mmc

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2C_L2A_31TCH_*_NDWI_10m.img") do (

    set "carpeta=%%~dpi"
    set "carpeta=!carpeta:~0,-1!"
    set "nombre=%%~ni"
    set "date=!nombre:~14,8!"

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpimask_agua.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpimask_agua.mmc Variables

    rem Ahora asignamos la variable correcta
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_agua.mmc Variables NDWI_10m %%i

    rem Los reclassificadores
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_agua.mmc Reclassificadors MMReclas_0_NODATA %origen%\MMReclas_0_NODATA.mrc

    rem Salida
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_agua.mmc Sortida Fitxer %%~dpiS2C_L2A_31TCH_!date!_mask_agua.img

    rem Ejecutamos
    C:\MiraMon\Calcimg.exe %%~dpimask_agua.mmc /SAC
)


rem ---------------------- DENSIFICAR máscaras de nieve ----------------------

setlocal EnableDelayedExpansion

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2C_L2A_31TCH_*_mask_nieve.img") do (

    set "carpeta=%%~dpi"
    set "nombre=%%~ni"
    
    rem Extraemos la fecha después de mask_nieve_
    set "date=!nombre:~14,8!"

    rem Construimos el path final
    set "salida=!carpeta!S2C_L2A_31TCH_!date!_mask_nieve_10m"

    rem Ejecutamos densificación
    C:\MiraMon\DensRas %%i !salida! 310000 355300 4713600 4743600 10 V

)


rem -------------------------------- mask_1 = mask_agua * mask_nieve

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\mask_1.mmc

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2C_L2A_31TCH_*_mask_nieve_10m.img") do (

    set "carpeta=%%~dpi"
    set "carpeta=!carpeta:~0,-1!"
    set "nombre=%%~ni"
    set "date=!nombre:~14,8!"

    rem Creamos ruta de mask_agua usando la fecha
    set "agua_path=!carpeta!\S2C_L2A_31TCH_!date!_mask_agua.img"

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpimask_1.mmc

    rem ELIMINAR VARIABLES ANTERIORES
    C:\MiraMon\Canvirel.exe 3 %%~dpimask_1.mmc Variables

    rem Asignar variables correctas
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_1.mmc Variables mask_agua !agua_path!
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_1.mmc Variables mask_nieve_10m %%i

    rem Reclassificadores
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_1.mmc Reclassificadors MMReclas_0_NODATA %origen%\MMReclas_0_NODATA.mrc

    rem Salida final
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_1.mmc Sortida Fitxer %%~dpiS2C_L2A_31TCH_!date!_mask_1.img

    rem Ejecutar la calculadora
    C:\MiraMon\Calcimg.exe %%~dpimask_1.mmc /SAC

)


rem -------------------------------- mask_2.mmc

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\mask_2.mmc

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2C_L2A_31TCH_*_SCL.img") do (

    set "carpeta=%%~dpi"
    set "carpeta=!carpeta:~0,-1!"
    set "nombre=%%~ni"
    set "date=!nombre:~14,8!"

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpimask_2.mmc

    rem ELIMINAR TODAS LAS VARIABLES EXISTENTES PARA EVITAR ACUMULACIONES
    C:\MiraMon\Canvirel.exe 3 %%~dpimask_2.mmc Variables

    rem Ahora asignamos la variable con la ruta de imagen correcta
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_2.mmc Variables SCL %%i
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_2.mmc Reclassificadors MMReclas_0_NODATA %origen%\MMReclas_0_NODATA.mrc
    C:\MiraMon\Canvirel.exe 1 %%~dpimask_2.mmc Sortida Fitxer %%~dpiS2C_L2A_31TCH_!date!_mask_2.img

    rem Ejecutamos la calculadora
    C:\MiraMon\Calcimg.exe %%~dpimask_2.mmc /SAC
)


rem -------------------DENSIFICAR mask_base a 10m----------------------

setlocal EnableDelayedExpansion

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2C_L2A_31TCH_*_mask_base.img") do (

    set "carpeta=%%~dpi"
    set "nombre=%%~ni"
    
    rem Extraemos la fecha después de mask_base_
    set "date=!nombre:~14,8!"

    rem Construimos el path final
    set "salida=!carpeta!S2C_L2A_31TCH_!date!_mask_base_10m"

    rem Ejecutamos densificación
    C:\MiraMon\DensRas %%i !salida! 310000 355300 4713600 4743600 10 V

)




rem -------------------CALCULAR INDICES ENMASACARADOS---------------

rem -------------------NDVI_mask

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\NDVI_mask.mmc

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2C_L2A_31TCH_*_NDVI_10m.img") do (

    set "carpeta=%%~dpi"
    set "carpeta=!carpeta:~0,-1!"
    set "nombre=%%~ni"
    set "date=!nombre:~14,8!"

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpiNDVI_mask.mmc

    rem ELIMINAR VARIABLES ANTERIORES
    C:\MiraMon\Canvirel.exe 3 %%~dpiNDVI_mask.mmc Variables

    rem Antes del bloque de variables
    set "mascara_dir=%%~dpi"

    rem Asignar variables correctas
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDVI_mask.mmc Variables NDVI %%i
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDVI_mask.mmc Variables mask_base_10m !mascara_dir!S2C_L2A_31TCH_!date!_mask_base_10m.img
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDVI_mask.mmc Variables mask_1 !mascara_dir!S2C_L2A_31TCH_!date!_mask_1.img

    rem Reclassificadores
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDVI_mask.mmc Reclassificadors MMReclas_0_NODATA %origen%\MMReclas_0_NODATA.mrc

    rem Salida final
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDVI_mask.mmc Sortida Fitxer %%~dpiS2C_L2A_31TCH_!date!_NDVI_10m_mask.img

    rem Ejecutar la calculadora
    C:\MiraMon\Calcimg.exe %%~dpiNDVI_mask.mmc /SAC

)


rem -------------------NDSI_mask

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\NDSI_mask.mmc

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2C_L2A_31TCH_*_NDSI_20m.img") do (

    set "carpeta=%%~dpi"
    set "carpeta=!carpeta:~0,-1!"
    set "nombre=%%~ni"
    set "date=!nombre:~14,8!"

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpiNDSI_mask.mmc

    rem ELIMINAR VARIABLES ANTERIORES
    C:\MiraMon\Canvirel.exe 3 %%~dpiNDSI_mask.mmc Variables

    rem Antes del bloque de variables
    set "mascara_dir=%%~dpi"

    rem Asignar variables correctas
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDSI_mask.mmc Variables NDSI %%i
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDSI_mask.mmc Variables mask_base !mascara_dir!S2C_L2A_31TCH_!date!_mask_base.img
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDSI_mask.mmc Variables mask_2 !mascara_dir!S2C_L2A_31TCH_!date!_mask_2.img

    rem Reclassificadores
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDSI_mask.mmc Reclassificadors MMReclas_0_NODATA %origen%\MMReclas_0_NODATA.mrc

    rem Salida final
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDSI_mask.mmc Sortida Fitxer %%~dpiS2C_L2A_31TCH_!date!_NDSI_20m_mask.img

    rem Ejecutar la calculadora
    C:\MiraMon\Calcimg.exe %%~dpiNDSI_mask.mmc /SAC

)



rem -------------------NDWI_mask 

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\NDWI_mask.mmc

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2C_L2A_31TCH_*_NDWI_10m.img") do (

    set "carpeta=%%~dpi"
    set "carpeta=!carpeta:~0,-1!"
    set "nombre=%%~ni"
    set "date=!nombre:~14,8!"

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpiNDWI_mask.mmc

    rem ELIMINAR VARIABLES ANTERIORES
    C:\MiraMon\Canvirel.exe 3 %%~dpiNDWI_mask.mmc Variables

    rem Antes del bloque de variables
    set "mascara_dir=%%~dpi"

    rem Asignar variables correctas
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDWI_mask.mmc Variables NDWI %%i
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDWI_mask.mmc Variables mask_base_10m !mascara_dir!S2C_L2A_31TCH_!date!_mask_base_10m.img

    rem Reclassificadores
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDWI_mask.mmc Reclassificadors MMReclas_0_NODATA %origen%\MMReclas_0_NODATA.mrc

    rem Salida final
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDWI_mask.mmc Sortida Fitxer %%~dpiS2C_L2A_31TCH_!date!_NDWI_10m_mask.img

    rem Ejecutar la calculadora
    C:\MiraMon\Calcimg.exe %%~dpiNDWI_mask.mmc /SAC

)



rem -------------------NDWI_veget_mask 

setlocal ENABLEDELAYEDEXPANSION

set calcula_base_mmc=%origen%\NDWI_veget_mask.mmc

for /R %origen%\%year% %%i in ("31TCH_zona_estudio\S2C_L2A_31TCH_*_NDWI_veget_20m.img") do (

    set "carpeta=%%~dpi"
    set "carpeta=!carpeta:~0,-1!"
    set "nombre=%%~ni"
    set "date=!nombre:~14,8!"

    rem Copiar la plantilla limpia de MMC
    copy /Y %calcula_base_mmc% %%~dpiNDWI_veget_mask.mmc

    rem ELIMINAR VARIABLES ANTERIORES
    C:\MiraMon\Canvirel.exe 3 %%~dpiNDWI_veget_mask.mmc Variables

    rem Antes del bloque de variables
    set "mascara_dir=%%~dpi"

    rem Asignar variables correctas
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDWI_veget_mask.mmc Variables NDWI_veget %%i
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDWI_veget_mask.mmc Variables mask_base !mascara_dir!S2C_L2A_31TCH_!date!_mask_base.img

    rem Reclassificadores
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDWI_veget_mask.mmc Reclassificadors MMReclas_0_NODATA %origen%\MMReclas_0_NODATA.mrc

    rem Salida final
    C:\MiraMon\Canvirel.exe 1 %%~dpiNDWI_veget_mask.mmc Sortida Fitxer %%~dpiS2C_L2A_31TCH_!date!_NDWI_v_20m_mask.img

    rem Ejecutar la calculadora
    C:\MiraMon\Calcimg.exe %%~dpiNDWI_veget_mask.mmc /SAC

)



@echo LISTO



@echo LISTO

:FIN

@echo LISTO

