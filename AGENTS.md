# Kenai Chinook Project — Agent Memory

Last updated: 2026-04-14 (updated after review of DeFilippo 2026 and juvenile survey investigation)

## Project Goal

Assess the feasibility of adapting a Bayesian integrated population model (IPM) for Kenai River Chinook salmon, following the approach of DeFilippo et al. (2026) and Cunningham et al. (2018), both developed for Yukon River Chinook. The goal is to characterize stage-specific drivers of Kenai River Chinook abundance — particularly the role of marine mortality — using existing publicly available datasets.

Reference PDFs in `other/documents/`: - `Ecological Applications - 2026 - DeFilippo - Shifting stage-specific constraints on productivity shape recovery potential.pdf` **(primary template)** - `Global Change Biology - 2018 - Cunningham - Signals of large scale climate drivers hatchery enhancement and marine.pdf`

## Project Structure

Quarto book project (HTML and PDF outputs). Key files: - `_quarto.yml` — book configuration - `index.qmd`, `intro.qmd`, `summary.qmd`, `references.qmd` — book chapters (currently placeholder content) - `other/agent_context/agent_context.txt` — project context and collaboration standards - `other/documents/` — reference PDFs - `other/input/` — data inputs (currently empty) - `other/output/` — analysis outputs (currently empty)

## Collaboration Standards (from agent_context.txt)

-   Do not implement code without first confirming the user understands how it works
-   Code must be readable and editable for future collaborative scientists
-   Avoid overuse of em-dashes in written text

------------------------------------------------------------------------

## Primary Modeling Template: DeFilippo et al. (2026)

**DeFilippo, L. (2026). "Shifting stage-specific constraints on productivity shape recovery potential for Yukon River Chinook salmon." *Ecological Applications*.**

Code: https://figshare.com/articles/dataset/29963606 (two Stan files, CC BY 4.0)

### Why DeFilippo over Cunningham as the primary template

DeFilippo (2026) is preferred over Cunningham (2018) for the Kenai adaptation for several reasons:

-   **Stan, not JAGS**: The model is implemented in Stan (CmdStanR interface), which is more actively maintained, computationally efficient, and widely used than JAGS.
-   **Time-varying marine mortality**: Rather than Bayesian Model Averaging over explicit environmental covariates, DeFilippo estimates a time-varying natural mortality rate (M) via a random walk. Climate drivers are examined post-hoc by correlating the latent M time series with environmental indices. This is simpler to implement and sidesteps the need to assemble Gulf of Alaska covariate time series as model inputs.
-   **Time-varying maturation**: A random walk on the logistic maturation parameter captures documented shifts in Kenai Chinook age composition over decades.
-   **Counterfactual projections**: The `_proj` version of the code supports forward simulation with alternative M or bycatch F values, directly useful for management questions.
-   **Clearer management implications**: The paper finds bycatch and harvest have limited effect on productivity, with marine heatwaves the dominant driver. This simplifies the data requirements and reduces the importance of the bycatch likelihood block.

### DeFilippo vs. Cunningham: Key Structural Differences

| Feature | Cunningham 2018 | DeFilippo 2026 |
|----|----|----|
| Implementation | JAGS | Stan |
| Marine mortality | Stage-structured, covariate effects via logistic/log-linear links | Single time-varying M with age-specific selectivity (random walk) |
| Covariate approach | Bayesian Model Averaging (BMA) with inclusion probabilities | No explicit covariates in model; correlate latent M post-hoc |
| Maturation schedule | Single time-invariant logistic parameter | Time-varying lambda (random walk) |
| Bycatch | Hierarchical continuous bycatch F | Same structure, plus counterfactual simulation |
| Forward projection | No | Yes (`_proj` version) |
| Juvenile likelihood | Required | Required (same NBS survey) |

### DeFilippo Model: Data Inputs Required

| Data type | Description | Kenai analog |
|----|----|----|
| Escapement abundance | Annual adult escapement | ADF&G sonar (RM 13.7) |
| Escapement age comp | Numbers-at-age samples | ADF&G age sampling |
| Harvest abundance | Annual harvest count | ADF&G harvest records |
| Harvest age comp | Numbers-at-age samples | ADF&G age sampling |
| Juvenile abundance | First-summer-at-sea marine trawl index | **No analog — see gap below** |
| Initial spawners | Pre-series spawner counts to initialize first juvenile cohorts | ADF&G historical records |
| Bycatch abundance | Annual total bycatch (expanded from stock comp) | GOA trawl bycatch (NMFS) |
| Bycatch age comp | Numbers-at-age in bycatch | NMFS observer data |
| Bycatch stock comp | Genetic proportion attributable to stock, by age | **Sparse for Kenai — see gap below** |
| Observation error terms | sigma for escapement, harvest, bycatch, juvenile likelihoods | ADF&G precision data |

------------------------------------------------------------------------

## Cunningham et al. (2018) Methods Summary (retained for reference)

Bayesian stage-structured lifecycle model implemented in **JAGS** (via `R2jags`). Seven covariate categories tested via BMA:

1.  Ice-out date — Yukon and Tanana Rivers
2.  River discharge — Salcha and Chena Rivers
3.  Air temperature during egg incubation (freshwater temperature proxy)
4.  Air temperature post-hatch (freshwater temperature proxy)
5.  Sea surface temperature — May SST in SE Bering Sea; winter SST at Pribilof Islands
6.  Competition at sea — North Pacific pink salmon abundance; Japanese hatchery chum salmon abundance
7.  Chinook bycatch in the Bering Sea/Aleutian Island pollock trawl fishery

Key finding: marine mortality is the primary driver; survival increases with warmer Bering Sea winter temps, declines with later ice-out and higher competing salmon abundance.

Code repository: https://github.com/curryc2/Yukon_Chinook_Bayes

------------------------------------------------------------------------

## Critical Data Gaps for Kenai Adaptation

### 1. Juvenile abundance index (major gap — juvenile likelihood will be dropped)

**What the NBS survey actually is:** The juvenile survey in both DeFilippo and Cunningham is a marine surface trawl, not a freshwater smolt trap. NOAA's Northern Bering Sea (NBS) survey has been conducted annually since 2002. It catches fish in their first summer at sea (total age \~2 years; age-1 ocean fish) distributed across the Bering Sea in September, after the freshwater-to-marine transition. Abundance is estimated by expanding CPUE to the survey area and apportioning by genetic stock composition. In the model, it provides an observation that bridges the spawning event and eventual adult return.

**Why no Kenai analog exists:** The NBS survey targets western Alaska stocks (Yukon, Kuskokwim, Norton Sound) that rear in the Bering Sea. Kenai River Chinook emigrate to the Gulf of Alaska, not the Bering Sea — they are simply absent from the NBS sampling area. No equivalent first-summer-at-sea marine trawl exists for Cook Inlet Chinook stocks.

**Freshwater smolt monitoring:** No long-term smolt trap or outmigrant index exists for Kenai River Chinook. ADF&G and UAF initiated a JSATS acoustic telemetry study of Kenai River Chinook smolt in 2025, focused on in-river and early marine movement and survival. This study is brand new and will not produce a historical time series. ADF&G also began a rotary screw trap on the Anchor River (a separate, smaller lower-Kenai-Peninsula river) in 2025.

**Decision:** The juvenile likelihood block (`n_juv_abun_real = 0`) will be dropped for the Kenai adaptation. Given DeFilippo's finding that marine mortality dominates, the freshwater S-R parameters are not the primary inference target. The Ricker function will be identified from the lagged spawner-to-adult relationship alone, which is standard practice in Pacific salmon S-R analysis.

### 2. Bycatch genetic apportionment (moderate gap — high priority to resolve)

GOA trawl bycatch of Chinook is documented by NMFS observers, but apportionment to Kenai-origin fish via genetic sampling may have a shorter or noisier time series than the BSAI equivalent used in the Yukon models. Needs verification.

**Important context:** Bycatch is a significant topic socially and culturally in Alaska, independent of its statistical explanatory power for low Chinook runs. The project should make every effort to include the bycatch likelihood if data are available. If bycatch data are ultimately excluded or simplified (e.g., bycatch F fixed at observed values), that decision must be explicitly justified based on data availability, not assumed away on the basis of DeFilippo's effect-size finding. A well-supported finding that bycatch explains little variance in Kenai productivity is itself a meaningful scientific and management result — but it requires actually fitting the bycatch data to make that claim.

### 3. Bycatch in GOA vs. BSAI (moderate gap — high priority to resolve)

The DeFilippo/Cunningham models use BSAI pollock trawl bycatch, which is well-documented. GOA trawl bycatch is the relevant source for Kenai fish. The same data structure is needed (total count, age composition, stock genetic composition) but may have a shorter consistent record. Investigating the depth and consistency of NMFS GOA observer bycatch data — including availability of genetic apportionment to Kenai-origin fish — is a priority data inventory task before any decision is made to simplify or drop this model component.

------------------------------------------------------------------------

## What Looks Feasible

The following data requirements appear obtainable for Kenai:

-   Adult escapement and harvest: ADF&G weir/sonar (RM 13.7 mainstem Kenai) and fishery records
-   Age composition of escapement: ADF&G age sampling program
-   Harvest age composition: ADF&G age sampling
-   Harvest rate: derivable from ADF&G escapement and catch data
-   Observation error for spawning abundance: ADF&G sonar/weir precision data
-   Initial spawner abundance (pre-series initialization): ADF&G historical records
-   Post-hoc climate correlates for latent M: GOA SST (NOAA ERSSTv5), PDO/NPGO, marine heatwave indices
-   Competition: Ruggerone & Irvine (2018) pink and chum abundance database

## Proposed Data Sources

| Category | Source |
|----|----|
| Escapement, age, harvest | ADF&G |
| River discharge | USGS |
| Air/stream temperature | NOAA / GHCN |
| Gulf of Alaska SST, marine heatwave indices | NOAA ERSSTv5, NOAA Coral Reef Watch |
| PDO, NPGO indices | NOAA indices |
| Pink/chum abundance (competition) | Ruggerone & Irvine 2018 database |
| Hatchery releases | ADF&G hatchery records |
| GOA trawl bycatch | NMFS observer program |

------------------------------------------------------------------------

## Relevant Prior Literature

-   **DeFilippo et al. 2026** — "Shifting stage-specific constraints on productivity shape recovery potential for Yukon River Chinook salmon." *Ecological Applications.* **Primary modeling template.** Stan IPM with time-varying M and maturation; finds marine heatwaves dominate productivity, bycatch and harvest have limited effect. Code on figshare (CC BY 4.0).
-   **Jones et al. 2020** — "Watershed-Scale Climate Influences Productivity of Chinook Salmon Populations Across Southcentral Alaska." *Global Change Biology* 26(9). Most directly relevant precedent for Southcentral AK; review before proceeding to understand what has already been established.
-   **Cunningham et al. 2018** — JAGS lifecycle model with BMA covariate selection for Yukon Chinook. Secondary reference; architecture retained for context.

------------------------------------------------------------------------

## Agreed Next Steps (in order)

1.  Review Jones et al. 2020 to understand prior Southcentral AK work and identify what this project adds
2.  Build a data inventory: each required variable, specific source, and estimated time series length. Focus on (a) availability and length of GOA bycatch data with genetic apportionment and (b) historical escapement and age data depth
3.  Assess data overlap years to determine the usable modeling window
4.  Decide on run scope: early run, late run, or both (model runs one population at a time)
5.  Adapt the DeFilippo Stan code for Kenai: replace NBS juvenile likelihood with empty data, substitute GOA bycatch inputs, confirm age structure matches Kenai Chinook age composition

Data acquisition and model development begin after steps 1-4 are complete.

------------------------------------------------------------------------

## Feasibility Assessment Summary (as of 2026-04-14)

The adaptation is **structurally feasible** using the DeFilippo (2026) Stan code as the primary template. The core architecture (age-structured population, Ricker S-R, time-varying marine mortality, bycatch F, time-varying maturation) transfers directly. Key conclusions:

-   The **juvenile likelihood will be dropped** (`n_juv_abun_real = 0`). No Cook Inlet marine juvenile trawl index exists, and no Kenai smolt trap has a useful historical record. DeFilippo's finding that marine mortality dominates means the freshwater S-R parameters are not the primary inference target, reducing the cost of this omission.
-   **Bycatch data feasibility** needs to be confirmed for the GOA. Bycatch carries significant social and cultural weight in Alaska; the bycatch likelihood should be retained if data permit. Any decision to simplify or omit it must be data-driven and explicitly justified, not assumed on the basis of DeFilippo's effect-size result alone.
-   The **primary scientific output** will be a time series of latent annual marine mortality (M) for Kenai Chinook, which can then be examined post-hoc for correlation with Gulf of Alaska marine heatwave indices and other climate variables.
-   A **reduced version** of the model (no juvenile likelihood, simplified or fixed bycatch) is still scientifically defensible and addresses the core question about drivers of Kenai Chinook productivity.
