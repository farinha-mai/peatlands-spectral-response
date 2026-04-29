#README
#Per descarregar les imatges de S2 es necessiten dos fitxers ps1, que s'haurien de guardar junts en una mateixa carpeta. Aquest fitxers s'anomenen:

# 00_Call_DescarreguesSentinel2_v3.ps1
    ## Aquest script determina quines imatges es descarregen i on es guarden.
    ## Cal comprovar que totes les variables apunten als directoris que volem
# 01_DescarreguesSentinel2_v3.ps1
    ## Aquest script gestiona els llistats d'imatges a descarregar i fa les descàrregues.
    ## Cal comprovar que les variables descrites entre les línies 8 i 19 estiguin correctament definides




#carpeta on es guarden els scripts
$scripts="C:\Users\farin\Downloads\01_DescarreguesSentinel2_v5"

#Dates d'inici i final de cerca
$data_inici="2019-01-01"
$data_fi="2019-12-31"

#opció de descàrrega
$desc="N"
	#N vol dir que són descàrregues noves.
	#R vol dir revisar que s'hagin descarregat totes i, si no, descarregar les que falten

#directori on es guardaran les descàrregues
$sortida="C:\Users\farin\Downloads\Descargas_S2"

& $scripts\01_DescarreguesSentinel2_v5.ps1 -inici $data_inici -fi $data_fi -opcio $desc -descarregues $sortida -scr $scripts

# Missatge al final per confirmar la finalització
Write-Host "Descarga completada para el intervalo $data_inici a $data_fi." -ForegroundColor Green
