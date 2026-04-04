# Kenai Chinook Project — Agent Memory

Last updated: 2026-04-03 (updated after code review of Cunningham repo)

## Project Goal

Assess the feasibility of replicating the lifecycle-modeling approach from Cunningham et al. (2018) for the Kenai River rather than the Yukon River. The goal is to estimate effect sizes of variables affecting Kenai River Chinook salmon abundance using existing publicly available datasets.

Reference paper PDF: `other/documents/Global Change Biology - 2018 - Cunningham - Signals of large scale climate drivers hatchery enhancement and marine.pdf`

## Project Structure

Quarto book project (HTML and PDF outputs). Key files:
- `_quarto.yml` — book configuration
- `index.qmd`, `intro.qmd`, `summary.qmd`, `references.qmd` — book chapters (currently placeholder content)
- `other/agent_context/agent_context.txt` — project context and collaboration standards
- `other/documents/` — reference PDFs
- `other/input/` — data inputs (currently empty)
- `other/output/` — analysis outputs (currently empty)

## Collaboration Standards (from agent_context.txt)

-   Do not implement code without first confirming the user understands how it works
-   Code must be readable and editable for future collaborative scientists
-   Avoid overuse of em-dashes in written text

## Cunningham et al. (2018) Methods Summary

Bayesian stage-structured lifecycle model implemented in **JAGS** (via `R2jags`), not Stan as the paper title might imply. Seven covariate categories tested:

1.  Ice-out date — Yukon and Tanana Rivers
2.  River discharge — Salcha and Chena Rivers
3.  Air temperature during egg incubation (freshwater temperature proxy)
4.  Air temperature post-hatch (freshwater temperature proxy)
5.  Sea surface temperature — May SST in SE Bering Sea; winter SST at Pribilof Islands
6.  Competition at sea — North Pacific pink salmon abundance; Japanese hatchery chum salmon abundance
7.  Chinook bycatch in the Bering Sea/Aleutian Island pollock trawl fishery

Key finding: marine mortality is the primary driver; survival increases with warmer Bering Sea winter temps, declines with later ice-out and higher competing salmon abundance.

**Model structure details (from code review):**

-   Stage structure: 2 freshwater stages + 5 ocean age classes = 7 total stages
-   Survival at each stage: Ricker-type density dependence — `surv = prod / (1 + (prod * N) / cap)` — where `prod` and `cap` are modified by covariate effects via logistic and log-linear links
-   Bayesian Model Averaging (BMA) via indicator variables (`ind.prod`) on each covariate coefficient. Each covariate has a Bernoulli inclusion probability drawn from `Beta(2,8)` (prior favoring exclusion)
-   Hierarchical prior on beta coefficients: `sigma.prod ~ Gamma(1,1)`, betas drawn from `Normal(0, 1/sigma.prod^2)`
-   Bycatch modeled explicitly using continuous fishing mortality (`F_bycatch`) estimated hierarchically, with age-specific selectivity estimated from bycatch age composition
-   Maturation schedule estimated with a single logistic parameter (`mat.param`)
-   Likelihoods: lognormal for spawner abundance and juvenile index; Dirichlet-multinomial for age composition (escapement and bycatch)

**Required data inputs (from code — all in a single Excel workbook with named sheets):**

| Sheet | Contents | Kenai analog |
|---|---|---|
| Spawners | Annual adult escapement by stock | ADF&G weir/sonar counts |
| AgeComp | Age composition of escapement by year | ADF&G age sampling |
| FemaleAge | Female age composition | ADF&G biosampling |
| PropFemale | Proportion female in escapement | ADF&G biosampling |
| Fecundity | Eggs per female by ocean age | Literature or ADF&G |
| Catch | Annual harvest | ADF&G harvest records |
| HarvestRate | Annual harvest rate | Derived from ADF&G data |
| SpawnAbundOE | Historical counting error estimates (for sigma prior) | ADF&G sonar/weir precision data |
| Juvenile | Juvenile abundance index by year | **No direct analog — see gap below** |
| JuvenileGSI | GSI proportions for apportioning juvenile index | Not applicable for single-river |
| PropEsc | Stock-specific proportion of escapement | Not needed (single river) |
| Bycatch | Annual bycatch count (apportioned to stock) | GOA trawl bycatch (NMFS) |
| BycatchAC | Bycatch age composition | NMFS observer data |
| BycatchACsampleSize | Sample sizes for bycatch age comp | NMFS observer data |
| BCgen | Genetic proportion of bycatch attributable to stock | **Sparse for Kenai — see gap below** |
| Covars | All environmental covariates, with metadata (stage, link type, year offset) | Replaced with GOA-relevant covariates |
| Stages | Stage names and year offsets | Same structure |

## Key Adaptations Needed for Kenai River

-   **Ocean area**: Kenai Chinook use the Gulf of Alaska, not the Bering Sea. Gulf of Alaska SST indices replace Bering Sea/Pribilof SST.
-   **Bycatch**: BSAI pollock bycatch less relevant; GOA trawl bycatch data more appropriate.
-   **Two runs**: Kenai River has early run and late run Chinook, managed separately. The Cunningham code runs one population at a time, so early and late runs would be modeled separately or the code extended. Run scope needs to be decided before modeling.
-   **Hatchery**: Kenai/Crooked Creek hatchery release data should be considered.
-   **Juvenile index**: The Cunningham model fits to a juvenile abundance survey index (Murphy survey). This is a key data input. See critical data gaps below.

## Critical Data Gaps for Kenai Adaptation

These gaps are the primary feasibility concerns, identified from the code:

1.  **Juvenile abundance index (major gap)**: The model includes a likelihood term fitting to annual juvenile Chinook counts. For the Yukon, this comes from the Murphy sonar survey on the Yukon mainstem, apportioned by GSI. No equivalent annual juvenile index exists for Kenai River Chinook. The model *can* be run without this likelihood component (the code simply omits those observations), but it reduces information and may lead to weaker identifiability for freshwater survival parameters. This is the most significant structural difference.

2.  **Bycatch genetic apportionment (moderate gap)**: The Yukon model apportions BSAI bycatch to Chena/Salcha populations using genetic sampling (`BCgen` sheet). For Kenai, GOA trawl bycatch would need to be apportioned to Kenai-origin fish. NMFS does conduct genetic sampling of GOA bycatch, but the time series may be shorter and the Kenai-specific fraction noisier than the Yukon equivalent. Worth investigating NMFS observer program records.

3.  **Bycatch in GOA vs. BSAI**: The Cunningham model includes bycatch from BSAI pollock trawl, which is well-documented. GOA trawl bycatch of Chinook is also documented but may have a shorter consistent time series. The structure of the bycatch likelihood (fitting both total bycatch and age composition) would need the same data from GOA.

## What Looks Feasible

The following data requirements from the code appear obtainable for Kenai:

-   Adult escapement and harvest: ADF&G weir/sonar and fishery records
-   Age composition of escapement: ADF&G age sampling program
-   Female age, proportion female, fecundity: ADF&G biosampling; fecundity by ocean age from literature
-   Harvest rate: derivable from ADF&G escapement and catch data
-   Observation error for spawning abundance: ADF&G precision data from sonar/weir counting
-   Environmental covariates: GOA SST (NOAA ERSSTv5), PDO/NPGO (NOAA indices), Kenai R discharge (USGS), air temperature (GHCN/NOAA)
-   Competition: Ruggerone & Irvine (2018) pink and chum abundance database

## Proposed Data Sources

| Category | Source |
|---|---|
| Escapement, age, harvest | ADF&G |
| River discharge | USGS |
| Air/stream temperature, ice | NOAA / GHCN |
| Gulf of Alaska SST | NOAA ERSSTv5 |
| PDO, NPGO indices | NOAA indices |
| Pink/chum abundance (competition) | Ruggerone & Irvine 2018 database |
| Hatchery releases | ADF&G hatchery records |
| GOA trawl bycatch | NMFS observer program |

## Relevant Prior Literature to Review

-   **Jones et al. 2020** — "Watershed-Scale Climate Influences Productivity of Chinook Salmon Populations Across Southcentral Alaska." *Global Change Biology* 26(9). Most directly relevant precedent; review before proceeding to understand what has already been done for Southcentral AK Chinook.
-   **Cunningham et al. 2018** — the target paper to replicate/adapt (PDF on file). Code repository: https://github.com/curryc2/Yukon_Chinook_Bayes

## Agreed Next Steps (in order)

1.  Review Jones et al. 2020 to understand prior Southcentral AK work and identify what this project adds
2.  Build a data inventory: each required variable, specific source, and estimated time series length. Focus especially on (a) whether a juvenile index of any kind exists for Kenai Chinook and (b) availability and length of GOA bycatch data with genetic apportionment
3.  Assess data overlap years to determine the usable modeling window
4.  Decide on run scope: early run, late run, or both (code runs one population at a time)
5.  Sketch the lifecycle stage structure and map covariates to stages (7 stages: 2 freshwater, 5 ocean)
6.  Outline the Bayesian model structure (following Cunningham et al., adapted for Kenai) — including whether to omit the juvenile likelihood component

Data acquisition and model development begin after steps 1-4 are complete.

## Feasibility Assessment Summary (as of 2026-04-03)

The adaptation is **structurally feasible** using the existing JAGS code as a template. The core model architecture (stage-structured survival, Ricker density dependence, BMA covariate selection) transfers directly. The main concern is not the model itself but two data gaps:

-   The **absence of a juvenile index** removes one likelihood component that the Yukon model uses to constrain freshwater survival. The model can still run but freshwater parameters will be less well identified.
-   **GOA bycatch genetic apportionment** needs to be verified as a usable time series before the bycatch likelihood component can be retained.

If neither gap can be filled, a reduced version of the model (no juvenile likelihood, simplified bycatch) is still scientifically defensible and would address the core project question about covariate effects on survival.
