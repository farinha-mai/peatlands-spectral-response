# Spectral response of high-mountain peatlands to climatic anomalies

This repository contains the core scripts and notebooks used to process Sentinel-2 imagery, extract zonal statistics, build spectral-index time series, integrate climatic drought indicators (SPEI), and validate spectral signals with field data for peatlands in the Catalan Pyrenees.

It supports analyses on high-mountain peatlands in the Catalan Pyrenees, including spectral characterization, drought-related variability, snow-cover dynamics, and field-data validation.

Because some steps depend on external software (e.g., MiraMon), local directory structures, and partially manual preparation of intermediate tables, this repository should be understood as a core workflow rather than a fully automated pipeline.

## Workflow overview

The workflow is organized into three main stages:

### 1. Scene download and initial filtering
This stage includes scripts used to:
- download Sentinel-2 scenes,
- retain the most recent processing versions,
- identify invalid scenes,
- detect scenes with no useful data in the study area, and
- remove scenes that should not be processed further.

### 2. Core processing
This stage includes scripts used to:
- run clipping and index-calculation workflows,
- enrich peatland polygons with zonal statistics,
- export and clean DBF/CSV tables,
- standardize image dates in tabular outputs, and
- build consolidated spectral-index time series.

### 3. Python notebooks for analysis, data integration, variable derivation, and validation
This stage includes Python notebooks used to:
- derive spectral-index variables (NDVI, NDWI_v, NDDI, NDSI),
- integrate SPEI3 and SPEI12 drought indicators,
- analyze snow-cover duration and persistence,
- explore relationships between climatic and spectral variables, and
- validate spectral indices using field data.

## Repository structure

- `01_download_and_filtering/`  
  Scripts for scene filtering, version control, no-data auditing, and scene exclusion.

- `02_core_processing/`  
  Scripts for clipping/index processing, zonal statistics, and construction of cleaned CSV inputs.

- `03_analysis_python/`  
  Main notebooks for time-series analysis, drought integration, spectral-index analysis, and validation.

- `archive/`  
  Exploratory scripts, alternative figure-generation notebooks, and intermediate versions not required to reproduce the final analyses.

## Included files

This repository includes the **main files used in the core workflow**.  
Not all development scripts are included in the main folders. During the project, multiple intermediate and exploratory scripts were created for testing, visualization, and methodological decisions. These were either excluded from the repository or moved to `archive/` in order to keep the core workflow clear and easier to follow.

```text
peatlands-spectral-response/
├── 01_download_and_filtering/
│   ├── 00_Call_DescarreguesSentinel2_v5.ps1 (***)
│   ├── 01_DescarreguesSentinel2_v5.ps1 (***)
│   ├── 1_ultimas_versiones.ps1
│   ├── 2_listado_imagenes_excluidas.ps1
│   ├── 3_eliminar_carpetas.ps1
│   ├── 6_auditar_no_data_archivos.bat
│   ├── 7_auditar_no_data_CARPETAS.ps1
│   └── 8_eliminar_nodata.ps1
│
├── 02_core_processing/
│   ├── 5_bats_retalla_index_calculadora_v4_S2A_B_C.bat
│   ├── 9_combicap_iterativo_v2.bat
│   ├── 10_edit_csv_regdades.ps1
│   ├── 11_edit_csv_fechas.ps1
│   └── 12_csv_TOT_v2.ps1
│
├── 03_analysis_python/
│   ├── DATA_todos_indices.ipynb
│   ├── indices_analisis_NDSI.ipynb
│   ├── indices_analisis_NDVI.ipynb
│   ├── indices_analisis_NDWI_v.ipynb
│   ├── indices_analisis_NDDI.ipynb
│   ├── NDDI_vs_SPEI.ipynb
│   ├── Mediana_indices_TOT_SUBSET_filtrado.ipynb
│   └── _validacion.ipynb
│
├── archive/
│   ├── exploratory_notebooks/
│   ├── alternative_figures/
│   └── legacy_scripts/
│
├── data_dictionary/
├── requirements.txt
└── README.md
```

(***) Adapted Sentinel-2 download scripts; see the License and authorship section.

## Data availability

Raw Sentinel-2 imagery is not distributed through this repository.

The analyses were performed on Sentinel-2 L2A scenes covering tile `T31TCH` for the 2015–2025 period.  
Derived climatic data were based on SPEI series obtained from the historical database of the Spanish Meteorological Drought Monitor, based on AEMET meteorological data.

Field data used for validation are not included in this repository.

## Software requirements

The workflow combines:
- PowerShell
- Windows batch scripts
- Python
- MiraMon

The Python analyses are provided as Jupyter notebooks (.ipynb).
Running them requires Python plus a Jupyter environment (e.g., Jupyter Notebook or JupyterLab).

Python dependencies are listed in `requirements.txt`.

## Path configuration note

Some scripts and notebooks retain project-specific local paths from the original working environment. These paths should be adapted by the user before execution in a different system. The repository is therefore intended to document the core workflow rather than provide a fully portable, end-to-end executable pipeline.


## License and authorship

Unless otherwise indicated, code developed by María Isabel Farinha Vieira for this repository is released under the MIT License.

Initial Sentinel-2 download scripts were adapted, with permission from the original author, from scripts available in the [Sentinel-2-Downloads repository](https://github.com/OGOGU/Sentinel-2-Downloads) by Óscar González. These scripts were modified for the specific download and filtering requirements of this project.

Raw Sentinel-2 imagery, field data, and third-party datasets are not distributed through this repository and remain subject to their respective data providers' licenses.


## Reproducibility note

This repository is intended to provide a **minimal reproducible workflow** for the analyses presented in the manuscripts. The main goal is transparency and methodological traceability rather than exhaustive publication of every intermediate script produced during development.

In some intermediate workflow outputs, the peatland name Pla de Sartari appeared with the misspelling Pla de Satari. File names included in this repository have been standardized to the correct form.

## Contact

María Isabel Farinha Vieira  
farinha.mai@gmail.com
