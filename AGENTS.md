# Kenai Chinook Project — Agent Memory

Last updated: 2026-04-15 (updated after modeling approach decision and statistical framework discussion)

## Project Goal

Characterize stage-specific drivers of Kenai River Chinook salmon productivity — particularly the role of marine mortality relative to anthropogenic factors (harvest, bycatch) — using a Bayesian state-space spawner-recruit model with explicit environmental and anthropogenic covariates. The approach is informed by DeFilippo et al. (2026) and Cunningham et al. (2018), but is not a direct adaptation of either.

Reference PDFs in `other/documents/`: - `Ecological Applications - 2026 - DeFilippo - Shifting stage-specific constraints on productivity shape recovery potential.pdf` (primary structural reference) - `Global Change Biology - 2018 - Cunningham - Signals of large scale climate drivers hatchery enhancement and marine.pdf`

## Project Structure

Quarto book project (HTML and PDF outputs). Key files: - `_quarto.yml` — book configuration - `index.qmd`, `intro.qmd`, `summary.qmd`, `references.qmd` — book chapters (currently placeholder content) - `other/agent_context/agent_context.txt` — project context and collaboration standards - `other/documents/` — reference PDFs - `other/input/` — data inputs (currently empty) - `other/output/` — analysis outputs (currently empty)

## Collaboration Standards (from agent_context.txt)

-   Do not implement code without first confirming the user understands how it works
-   Code must be readable and editable for future collaborative scientists
-   Avoid overuse of em-dashes in written text
-   **User background:** Studied linear regression; no formal training in advanced statistics. Statistical methods should be explained as they are introduced, building from linear regression toward more complex concepts.

------------------------------------------------------------------------

## Chosen Modeling Approach: State-Space Spawner-Recruit with Explicit Covariates (Option 2)

**Decision date:** 2026-04-15

This approach was chosen over a direct DeFilippo IPM adaptation primarily because no marine juvenile abundance index exists for Cook Inlet Chinook and none is expected to become available. Without a juvenile likelihood, the full IPM loses a key anchoring observation. Option 2 is a more identifiable and interpretable framework for the core question.

### Model Structure

The core is a **Ricker spawner-recruit model** in state-space form:

```         
ln(R/S) = ln(alpha) + beta_climate * X_climate + beta_bycatch * X_bycatch
          + beta_competition * X_competition - beta_density * S + error
```

Key structural features:

-   **State-space formulation:** Separates observation error (imprecision in escapement/harvest counts) from process error (true biological variability in S-R relationship). This distinction matters because observation error in spawner counts biases slope estimates in standard regression.
-   **Time-varying productivity (ln alpha):** Can be modeled as a random walk (latent drift) plus covariate effects, or covariates alone. Both will be explored.
-   **Cohort reconstruction:** Age composition data from escapement and harvest samples are used to reconstruct brood-year returns across multiple calendar years. This converts calendar-year counts into cohort-specific survival estimates and is more informative than escapement totals alone.
-   **Explicit mortality accounting:** Harvest F and bycatch F enter as known (or estimated) removals from each cohort, not as covariates. This allows the model to make direct statements about anthropogenic impacts rather than correlative ones.
-   **Covariate selection:** Multiple candidate covariates (climate, competition, bycatch) tested; Bayesian shrinkage priors or model comparison used for selection.
-   **Bayesian estimation in Stan** (CmdStanR interface).

### How This Differs from DeFilippo / Cunningham

| Feature | DeFilippo 2026 | Cunningham 2018 | Option 2 (chosen) |
|----|----|----|----|
| Juvenile likelihood | Required | Required | Dropped — no GOA analog |
| Marine mortality | Latent random walk M | Covariate-driven stage mortality | Latent or covariate-driven productivity (ln alpha) |
| Covariate handling | Post-hoc correlation | BMA within model | Explicit covariates in S-R; Bayesian selection |
| Implementation | Stan | JAGS | Stan |
| Age structure | Full IPM cohort tracking | Stage-structured | Cohort reconstruction from age comp |

### Key Statistical Concepts to Introduce as Needed

(In order of complexity; introduce as each becomes relevant)

1.  Ricker model as linearized regression — **introduced**
2.  Observation error vs. process error; state-space concept — **introduced**
3.  Time-varying parameters; random walk — **introduced conceptually**
4.  Cohort reconstruction from age composition data — **introduced conceptually**
5.  Bayesian inference, priors, posteriors, MCMC — **introduced briefly**
6.  Stan syntax and model blocks — not yet introduced
7.  Shrinkage priors for covariate selection — not yet introduced
8.  Model comparison (WAIC / LOO-CV) — not yet introduced

------------------------------------------------------------------------

## Reference Models (retained for context)

### DeFilippo et al. (2026)

**"Shifting stage-specific constraints on productivity shape recovery potential for Yukon River Chinook salmon." *Ecological Applications*.**

Code: https://figshare.com/articles/dataset/29963606 (two Stan files, CC BY 4.0)

Stan IPM with time-varying M (random walk) and time-varying maturation. Juvenile NBS trawl likelihood required. Finds marine heatwaves dominate productivity; bycatch and harvest have limited effect. Counterfactual projection version available.

### Cunningham et al. (2018)

**"Signals of large-scale climate drivers, hatchery enhancement, and marine conditions on productivity of Chinook salmon populations across the North Pacific Ocean." *Global Change Biology*.**

Code: https://github.com/curryc2/Yukon_Chinook_Bayes

JAGS lifecycle model with Bayesian Model Averaging over seven covariate categories. Key finding: marine mortality is the primary driver.

------------------------------------------------------------------------

## Critical Data Gaps

### 1. Juvenile abundance index — resolved, dropped

No Cook Inlet marine juvenile trawl index exists. No Kenai smolt trap has a useful historical record. ADF&G/UAF initiated a JSATS acoustic telemetry smolt study in 2025 (too new for historical series). The juvenile likelihood is dropped from Option 2. Standard S-R analysis from lagged spawner-to-adult data is sufficient for the model as specified.

### 2. GOA bycatch genetic apportionment — unresolved, high priority

GOA trawl bycatch of Chinook is documented by NMFS observers. Apportionment to Kenai-origin fish requires genetic stock composition sampling, which may have a shorter or noisier record than the BSAI equivalent used in the Yukon models.

**Important context:** Bycatch is a significant topic socially and culturally in Alaska. The project should make every effort to include bycatch as an explicit mortality term if data permit. Any decision to simplify or omit it must be justified by data availability, not assumed away based on DeFilippo's effect-size result. A well-supported finding that bycatch explains little variance in Kenai productivity is itself a meaningful result.

------------------------------------------------------------------------

## What Looks Feasible

The following data requirements appear obtainable for Kenai:

-   Adult escapement and harvest: ADF&G weir/sonar (RM 13.7 mainstem Kenai) and fishery records
-   Age composition of escapement: ADF&G age sampling program
-   Harvest age composition: ADF&G age sampling
-   Harvest rate: derivable from ADF&G escapement and catch data
-   Observation error for spawning abundance: ADF&G sonar/weir precision data
-   Initial spawner abundance (pre-series initialization): ADF&G historical records
-   Climate covariates: GOA SST (NOAA ERSSTv5), PDO/NPGO, marine heatwave indices
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

-   **DeFilippo et al. 2026** — Primary structural reference. Stan IPM for Yukon Chinook; code on figshare (CC BY 4.0).
-   **Jones et al. 2020** — "Watershed-Scale Climate Influences Productivity of Chinook Salmon Populations Across Southcentral Alaska." *Global Change Biology* 26(9). Most directly relevant precedent for Southcentral AK. **Review before developing covariate list.**
-   **Cunningham et al. 2018** — JAGS lifecycle model with BMA covariate selection for Yukon Chinook. Secondary reference.

------------------------------------------------------------------------

## Agreed Next Steps (in order)

1.  Review Jones et al. 2020 to understand prior Southcentral AK work and identify what this project adds
2.  Build a data inventory: each required variable, specific source, and estimated time series length. Focus on (a) GOA bycatch availability and genetic apportionment depth, (b) escapement and age data depth
3.  Assess data overlap years to determine the usable modeling window
4.  Decide on run scope: early run, late run, or both
5.  Develop cohort reconstruction from ADF&G escapement and age composition data
6.  Build the state-space Ricker model in Stan, starting with a simple version (no covariates) and expanding

Data acquisition and model development begin after steps 1-4 are complete.

------------------------------------------------------------------------

## Feasibility Assessment Summary (as of 2026-04-15)

The state-space Ricker approach (Option 2) is **feasible and well-suited** to the available data. It avoids the identifiability problems introduced by dropping the juvenile likelihood from a full IPM, while preserving the ability to make direct statements about the magnitude of natural vs. anthropogenic impacts. Bycatch feasibility in the GOA remains the primary unresolved data question.
