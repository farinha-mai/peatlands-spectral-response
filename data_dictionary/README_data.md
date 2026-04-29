# Data dictionary

This folder contains the main tabular outputs used to support the analysis of high-mountain peatlands in the Catalan Pyrenees.

The files are organized according to processing stage and analytical purpose.

## General notes

- Most tables are provided as `.csv` files with **semicolon (`;`) separators**.
- File encoding may require **`latin1`** or **`cp1252`** when imported into Python or R.
- Date formats are not completely uniform across all files. Most tables use `YYYY-MM-DD`; however, some files associated with the Estanyeres peatland contain dates in `DD/MM/YYYY` format.
- Variable names are preserved as they appear in the original tabular outputs in order to maintain consistency with the analysis notebooks.

## Folder structure

### `derived_variables_ndsi/`
This folder contains one CSV file per peatland with seasonal snow metrics derived from NDSI.

Typical variables include:
- `Temporada`: snow season (e.g., 2015–2016)
- `Snow In`: estimated beginning of the snow-covered period
- `Snow Off`: estimated end of the snow-covered period
- `Periodo (dias)`: duration of the snow-covered period in days
- `Persistencia (conteo)`: count-based snow persistence metric
- `Persistencia (%)`: percentage snow persistence during the season

These files provide compact summary metrics derived from the snow analysis.

### `time_series_with_snow/`
This folder contains one CSV file per peatland with time series that retain dates affected by snow cover.

Typical variables include:
- `FECHA`: observation date
- `NDVI`, `NDWI`, `NDWI_v`, `NDSI`: spectral indices
- `NDATOS` and related columns: number of valid pixels used in the zonal statistics for each spectral index. These values are stored separately for the different indices.
- `SPEI_1`, `SPEI_24`: drought indicators at different temporal scales
- `Elevación`, `Pendiente`, `Orientación`: static morphometric variables
- `Año`, `Mes`, `Dia juliano`: temporal descriptors
- `hay_nieve`: logical flag indicating snow presence
- `días_sin_nieve`: days outside the snow-covered period

This folder preserves a more complete version of the time series prior to snow exclusion.

Also included:
- `day_in_off_snow.txt`: text summary of estimated snow onset and snow-off dates by peatland and season.

### `time_series_without_snow_filtered/`
This folder contains one CSV file per peatland with time series after excluding snow-covered periods and filtering observations according to the minimum percentage of valid pixels.

Typical variables include:
- `FECHA`: observation date
- `NDVI`, `NDWI`, `NDWI_V`, `NDSI`: spectral indices
- `NDATOS` and related columns: number of valid pixels used in the zonal statistics for each spectral index. These values are stored separately for the different indices.
- `SPEI_1`, `SPEI_24`, `SPEI_3`, `SPEI_12`: drought indicators
- `NDDI`: Normalized Difference Drought Index
- `AÑO`, `MES`, `DIA JULIANO`: temporal descriptors
- `HAY_NIEVE`: snow flag
- `DÍAS_SIN_NIEVE`: days outside the snow-covered period

The files in `time_series_without_snow_filtered/` are the closest to the datasets used in the final analyses, as they exclude snow-covered periods and apply the minimum-valid-pixel filtering criterion.

## Additional files in the root directory

### `porcentaje_de_datos_min_a_usar_v2.csv`
This table stores the minimum number or proportion of valid pixels required for each peatland and spectral index.

It was used as a quality-filtering reference to exclude observations with insufficient valid data.

### `tabla_resumen_morfometria_respuesta_Ori_letras.csv`
This table summarizes the relationship between peatland morphometric characteristics and spectral-response metrics.

Typical variables include:
- `Turbera`
- `Orientación`
- `Pendiente`
- `Altitud`
- `Superficie`
- `NDVI_vs_Duracion`
- `NDVI_vs_Persistencia`
- `NDWI_v_vs_Duracion`
- `NDWI_v_vs_Persistencia`
- `NDDI_vs_Duracion`
- `NDDI_vs_Persistencia`

This table provides a compact summary of response patterns in relation to morphometric controls.

## Import note

In Python, many of these files can be read using:

```python
import pandas as pd
df = pd.read_csv("file.csv", sep=";", encoding="latin1")