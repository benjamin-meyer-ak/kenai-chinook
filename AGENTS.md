# Kenai Chinook Project — Agent Memory

Last updated: 2026-04-03

## Project Goal

Assess the feasibility of replicating the lifecycle-modeling approach from Cunningham et al. (2018) for the Kenai River rather than the Yukon River. The goal is to estimate effect sizes of variables affecting Kenai River Chinook salmon abundance using existing publicly available datasets.

Reference paper PDF: `other/documents/Global Change Biology - 2018 - Cunningham - Signals of large scale climate drivers hatchery enhancement and marine.pdf`

## Project Structure

Quarto book project (HTML and PDF outputs). Key files: - `_quarto.yml` — book configuration - `index.qmd`, `intro.qmd`, `summary.qmd`, `references.qmd` — book chapters (currently placeholder content) - `other/agent_context/agent_context.txt` — project context and collaboration standards - `other/documents/` — reference PDFs - `other/input/` — data inputs (currently empty) - `other/output/` — analysis outputs (currently empty)

## Collaboration Standards (from agent_context.txt)

-   Do not implement code without first confirming the user understands how it works
-   Code must be readable and editable for future collaborative scientists
-   Avoid overuse of em-dashes in written text

## What Was Discussed in the First Session (2026-04-03)

### Cunningham et al. (2018) Methods Summary

Bayesian lifecycle model (Stan) for Yukon River Chinook salmon. Seven covariate categories tested:

1.  Ice-out date — Yukon and Tanana Rivers
2.  River discharge — Salcha and Chena Rivers
3.  Air temperature during egg incubation (freshwater temperature proxy)
4.  Air temperature post-hatch (freshwater temperature proxy)
5.  Sea surface temperature — May SST in SE Bering Sea; winter SST at Pribilof Islands
6.  Competition at sea — North Pacific pink salmon abundance; Japanese hatchery chum salmon abundance
7.  Chinook bycatch in the Bering Sea/Aleutian Island pollock trawl fishery

Key finding: marine mortality is the primary driver; survival increases with warmer Bering Sea winter temps, declines with later ice-out and higher competing salmon abundance.

### Key Adaptations Needed for Kenai River

-   **Ocean area**: Kenai Chinook use the Gulf of Alaska, not the Bering Sea. Gulf of Alaska SST indices replace Bering Sea/Pribilof SST.
-   **Bycatch**: BSAI pollock bycatch less relevant; GOA trawl bycatch data more appropriate.
-   **Two runs**: Kenai River has early run and late run Chinook, managed separately. Run scope (early, late, or both) needs to be decided before modeling.
-   **Hatchery**: Kenai/Crooked Creek hatchery release data should be considered.

### Proposed Data Sources

| Category                          | Source                           |
|-----------------------------------|----------------------------------|
| Escapement, age, harvest          | ADF&G                            |
| River discharge                   | USGS                             |
| Air/stream temperature, ice       | NOAA / GHCN                      |
| Gulf of Alaska SST                | NOAA ERSSTv5                     |
| PDO, NPGO indices                 | NOAA indices                     |
| Pink/chum abundance (competition) | Ruggerone & Irvine 2018 database |
| Hatchery releases                 | ADF&G hatchery records           |
| GOA trawl bycatch                 | NMFS observer program            |

### Relevant Prior Literature to Review

-   **Jones et al. 2020** — "Watershed-Scale Climate Influences Productivity of Chinook Salmon Populations Across Southcentral Alaska." *Global Change Biology* 26(9). Most directly relevant precedent; review before proceeding to understand what has already been done for Southcentral AK Chinook.
-   **Cunningham et al. 2018** — the target paper to replicate/adapt (PDF on file)

## Agreed Next Steps (in order)

1.  Review Jones et al. 2020 to understand prior Southcentral AK work and identify what this project adds
2.  Build a data inventory: each required variable, specific source, and estimated time series length
3.  Assess data overlap years to determine the usable modeling window
4.  Decide on run scope: early run, late run, or both
5.  Sketch the lifecycle stage structure and map covariates to stages
6.  Outline the Bayesian model structure (following Cunningham et al., adapted for Kenai)

Data acquisition and model development begin after steps 1-4 are complete.
