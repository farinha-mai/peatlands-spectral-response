param (
[string]$inici,
[string]$fi,
[string]$opcio,
[string]$descarregues,
[string]$scr
)

#--------------
#variables que cal modificar si canvia l'usari
#--------------
$usr="mail"
$psw="password"

#--------------
#variables que cal modificar si volem canviar l'àmbit de cerca o el producte
#-------------- 
$prod="S2MSI2A" #nivel 2A (corregido)?
$bbox="0.67+42.42,1.14+42.43,1.13+42.72,0.67+42.71,0.67+42.42" #Pirineos Catalanes
#$bbox="0.704+42.794,0.437+40.542,0.678+40.731,0.865+41.082,2.052+41.371,3.087+41.957,3.016+42.479,1.463+42.460,0.704+42.794,0.704+42.794" #Cat


$temp="$scr\tmp"

# si no existeix la carpeta tmp la creem
if (-not (Test-Path $temp)) {
    New-Item -ItemType Directory -Path $temp | Out-Null
}


#Aquesta funció ens retorna el token a partir de l'usuari i els password per poder fer les descàrregues
#El token caduca cada 600s, per això caldrà demanar-lo cada cop que volguem fer descàrregues noves (no serveix d'un dia per l'altre)
function CreaToken() 
{
    $uri = "https://identity.dataspace.copernicus.eu/auth/realms/CDSE/protocol/openid-connect/token"

    $headers = @{
        "Content-Type" = "application/x-www-form-urlencoded"
    }

    $body = @{
        "username"    = $usr
        "password"    = $psw
        "grant_type"  = "password"
        "client_id"   = "cdse-public"
    }

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $tokenJson = Invoke-WebRequest -Uri $uri -Method POST -Headers $headers -Body $body | ConvertFrom-Json

    return $tokenJson
}

#Aquesta funció ens retorna el token a partir del refresh_token per poder fer les descàrregues
#El token caduca cada 600s, per això caldrà demanar-lo cada cop que volguem fer descàrregues noves (no serveix d'un dia per l'altre). 
#Com que 600s segons és molt poc i sempre demanem moltes descàrregues, no té sentit controlar el temps i esperar a que caduqui per demanar-ne un de nou. El refresquem a cada nova descàrrega
function RegeneraToken() 
{
    $uri = "https://identity.dataspace.copernicus.eu/auth/realms/CDSE/protocol/openid-connect/token"
    $token = $tokenJson.refresh_token

    $headers = @{
        "Content-Type" = "application/x-www-form-urlencoded"
    }

    $body = "grant_type=refresh_token&refresh_token=$token&client_id=cdse-public"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $response = Invoke-WebRequest -Uri $uri -Method POST -Headers $headers -Body $body

    $tokenJson = $response.Content | ConvertFrom-Json

    return $tokenJson
}

function CallDescarrega($taula)
{
    # Cridem les descàrregues
    $taulaDesc=Import-Csv -Path $taula -Delimiter ";" -Header "ID", "ZIPname"
    $total=$taulaDesc.ID.Count
    For ($s=0;$s -lt $total; $s++){
        $n=$s+1
        $status="$n"+"/"+"$total"
        if ($s -eq 0){
            $tokenJson=CreaToken
        }else{
            $tokenJson=RegeneraToken
        }
        DescarregaZIP $taulaDesc[$s].ID $taulaDesc[$s].ZIPname $descarregues $tokenJson.access_token $status
    }
}

function DescarregaZIP ($id, $ZIPname, $descarregues, $token, $status)
{
    # Si la imatge que volem descarregar ja existeix, no la descarreguem. 
    # Això no hauria de passar mai si no fos perquè no està clar que fa curl quan li demanes de descarregui dos cops el mateix fitxer, així que per si de cas, poso aquest if i evito repeticions.
    if (Test-Path $descarregues\$ZIPname.zip -PathType Leaf){
        Write-Host "$status LA IMATGE JA EXISTEIX"
        return
    }
    else
    {
        #rebem els paràmetres i executem curl per descarregar la imatge que ens ha arribat.
        $clau="Bearer $token"
        $url="https://catalogue.dataspace.copernicus.eu/odata/v1/Products("+$id+")/"+"$"+"value"
        $file=$descarregues+'\'+$ZIPname+'.zip'

        $expression='curl.exe -H "Authorization: '+$clau+'" "'+$url+'" --location-trusted --output '+$file
        $expression | Out-File -FilePath "$temp\curl.bat" -Encoding ASCII

        $psi = New-Object System.Diagnostics.ProcessStartInfo
        $psi.FileName = "$temp\curl.bat"
        $psi.WindowStyle = "Hidden"

        $proces = [System.Diagnostics.Process]::Start($psi)
        $proces.WaitForExit()

        $size = (Get-Item $file).Length
        #comprovem que la descarrega s'hagi completat correctament (exit code correcte i fitxer de més de 100 bytes)--> Quan la descarrega falla, si no fem res queda guardat un fitxer zip de ~25bytes que en realitat és un json que diu {"detail":"Unauthorized"}
        #en cas contrari eliminem el ZIP pq es torni a descarregar en un futur
        if (($proces.ExitCode -ne 0) -or ((Test-Path $file -PathType Leaf) -and ($size -le 100))) {
                Write-Host "$status $file $size ERROR EN LA DESCÀRREGA!" 
                Remove-Item $file -Force
        }else{
            if(Test-Path $file -PathType Leaf){
                Write-Host "$status $file $size FET!"
            }else{
                Write-Host "$status $file $size ERROR: IMATGE NO DISPONIBLE?" #Això no ha passat mai i no sé si és possible. En teoria si passa alguna cosa amb la descàrrega ho hauríem de saber en l'if aaterior i hauriem de tenir un ExitCode diferent de 0
            }
        }
    }
}

function RetornaJson ($url)
{
    $url= $url -replace '%24', '$' -replace '%2F', '/' -replace '%28', '(' -replace '%3A', ':' -replace '%27', "'" -replace '%29', ')' -replace '%3D', '=' -replace '%3B', ';' -replace '%2C', ','
    $exp='wget --output-document='+$temp+'\consulta.json "'+$url+'"'
    $exp | Out-File -FilePath "$temp\wget.bat" -Encoding ASCII
    $var = Start-Process -FilePath "$temp\wget.bat" -PassThru
    $var.WaitForExit()

    $Json=Get-Content -Raw -Path $temp\consulta.json | ConvertFrom-Json

    return $Json
}

if ($opcio -eq "N")
{
    #URL sobre la que es fa la consulta
    #$url ="https://catalogue.dataspace.copernicus.eu/odata/v1/Products?"+"$"+"filter=Attributes/OData.CSC.StringAttribute/any(att:att/Name+eq+'productType'+and+att/OData.CSC.StringAttribute/Value+eq+'"+$prod+"')+and+OData.CSC.Intersects(area=geography'SRID=4326;POLYGON(("+$bbox+"))')+and+ContentDate/Start+gt+"+$inici+"T00:00:00.000Z+and+ContentDate/End+lt+"+$fi+"T23:59:59.999Z&"+"$"+"count=True&"+"$"+"orderby=ContentDate/Start asc"
    $url ="https://catalogue.dataspace.copernicus.eu/odata/v1/Products?"+"$"+
"filter=Attributes/OData.CSC.StringAttribute/any(att:att/Name+eq+'productType'+and+att/OData.CSC.StringAttribute/Value+eq+'"+$prod+"')"+
"+and+Attributes/OData.CSC.StringAttribute/any(att:att/Name+eq+'tileId'+and+att/OData.CSC.StringAttribute/Value+eq+'31TCH')"+
"+and+ContentDate/Start+gt+"+$inici+"T00:00:00.000Z"+
"+and+ContentDate/End+lt+"+$fi+"T23:59:59.999Z&"+"$"+
"count=True&"+"$"+"orderby=ContentDate/Start asc"


    $Json=RetornaJson($url)
    #$Json | Format-List | Out-String | Write-Output

    #Com que cada consulta només retorna un màxim de 20 resultats, $Json.'@odata.nextLink' ens dona la url de la consulta que cal fer per obtenir el següents 20 elements.
    $next=$Json.'@odata.nextLink'
    
    #Comprovem que no existeixi una consulta igual ja feta. En cas que exisiteixi la eliminem
    $consulta="$temp\$inici"+"_"+"$fi.csv"
    if (Test-Path $consulta -PathType Leaf) {
        Remove-Item $consulta -Force
    }

    #mentre existeixi una URL per seguir consultant elements, anem generant una llista de ids i noms de les imatges
    while ($next -ne $null)
    {
	    $n=$Json.value.Length #aquí n hauria de valdre sempre 20, però ho deixo així per evitar problemes si hi ha canvis.
        for ($s=0; $s -lt $n; $s++) {
            $nomLlarg=$Json.value[$s].Name
            $nomZip=$nomLlarg.Substring(0, $nomLlarg.Length - 5)
		    $Json.value[$s].id+";"+$nomZip | Out-File -FilePath $consulta -Append
	    }
	    $Json=RetornaJson($next)
	    $next=$Json.'@odata.nextLink'
    } 
    #En el moment en que és null, encara falta imprimir la última pàgina
    $n=$Json.value.Length
    for ($s=0; $s -lt $n; $s++) {
        $nomLlarg=$Json.value[$s].Name
        $nomZip=$nomLlarg.Substring(0, $nomLlarg.Length - 5)
	    $Json.value[$s].id+";"+$nomZip | Out-File -FilePath $consulta -Append
    }

    # Cridem les descàrregues
    CallDescarrega($consulta)
 }

if ($opcio -eq "R")
{
    #1 Creem el llistat d'imatges ja descarregades
    
    $llistaDescarregats = "$temp\ImatgesDescarregades.csv"
    $csvSortida = "$temp\Imatges_NO_Descarregades.csv"

    # Si ja existeixen llistes prèvies, les eliminem
    if (Test-Path $llistaDescarregats -PathType Leaf) {
        Remove-Item $llistaDescarregats -Force
    }
    if (Test-Path $csvSortida -PathType Leaf) {
        Remove-Item $csvSortida -Force
    }

    # Generem una variable que conté el llistat de ZIPs ja descarregats (sense extensió)
    $elementsDescarregats = Get-ChildItem -Path $descarregues -Filter "*.zip" | ForEach-Object { $_.BaseName }

    # Guardem el nom dels fitxers descarregats al fitxer de sortida
    $elementsDescarregats | Out-File -FilePath $llistaDescarregats

    
    #2 Comparem les imatges ja descarregades amb la consulta inicial i guardem en un fitxer les que no s'han descarregat encara
    
    # Ruta del CSV que conté totes les imatges entre les dates demanades que s'haurien d'haver descarregat
    $csv1 = "$temp\$inici"+"_"+"$fi.csv"

    # Llegim els dos CSV i els guardem en variables
    $data1 = Import-Csv -Path $csv1 -Delimiter ";" -Header "ID", "ZIPname"
    $data2 = Import-Csv -Path $llistaDescarregats -Header "ZIPname"

    # Comparem les columnes i obtenim els elements no coincidents
    $noCoincidents = $data1 | Where-Object { $_.ZIPname -notin $data2.ZIPname }

    # Escrivim els elements no coincidents en un nou CSV
    $noCoincidents |Export-Csv -Path $csvSortida -Delimiter ";" -NoTypeInformation
    
    # Eliminem la capçalera del CSV de sortida
    (Get-Content -Path $csvSortida | Select-Object -Skip 1) | Set-Content -Path $csvSortida

    # Cridem les descàrregues
    CallDescarrega($csvSortida)
}
