# Kenai Chinook Project — Agent Memory

Last updated: 2026-04-29 (session: Quarto book structure configured; pitch letter renamed to concept_note.qmd; Chapter 3 approach revised to use NetMap habitat values at landscape scale)

------------------------------------------------------------------------

## Project Scope (as of 2026-04-29)

This repository now serves to develop ideas, plans, and documents for a **doctoral research program** on Kenai River Chinook salmon. The scope was expanded on 2026-04-29 from a single spawner-recruit productivity analysis to a multi-chapter doctoral program.

### Doctoral Program Stages

1.  Develop a summary pitch to recruit funding (primarily PSMFC; secondarily other sources) and to recruit academic advisors/committee members.
2.  Develop additional research chapters addressing Kenai Chinook salmon beyond total run productivity. The broader program also addresses habitat.

### Chapter Topics (working list)

| Chapter | Topic | Key Reference/Anchor |
|----|----|----|
| 1 | Kenai River water quality monitoring and trend analysis | KWF draft report "Water Quality Assessment of the Kenai River Watershed from 2000 to 2025" (B. Meyer, KWF); https://kenai-watershed-forum.github.io/kenai-river-wqx/. Covers 18 parameters (metals, nutrients, organics, bacteria, physical). Updates McCard 2007 and Guerron Orejuela 2016. |
| 2 | Predictive fish habitat mapping / Anadromous Waters Catalog expansion | KWF habitat mapping initiative launched spring 2025 with National Coastal Resilience Fund grant; https://www.kenaiwatershed.org/news-media/fish-habitat-mapping-2025/. Partners: Romey Riverscape Sciences, Terrainworks, Cook Inletkeeper. Modeled on Hoonah Native Forest Partnership approach (\>98% accuracy in SE Alaska). \<40% of Kenai Peninsula Borough anadromous waters currently inventoried. |
| 3 | Evaluation of Kenai River habitat restoration efforts | ADF&G Spring 2026 report ("Kenai River Chinook salmon juvenile rearing habitat use and assessment of habitat improvement techniques") in `other/documents/` |
| 4 | Kenai River Chinook productivity (Bayesian state-space spawner-recruit model) | Existing work in this repo; DeFilippo 2026, Cunningham 2018 |

Each chapter is intended to become a published academic manuscript.

### Funding and Institutional Context

- **Primary funder target:** Pacific States Marine Fisheries Commission (PSMFC), Upper Cook Inlet Salmon Disaster Research program. The 2025 RFP (https://www.psmfc.org/procurement/upper-cook-inlet-salmon-disaster-research/) offered \~\$882,000 over 3 years (concluding by Sept 30, 2028). The 2026 RFP is expected to be similar.
- **Employment structure:** Unresolved. May proceed as a graduate research assistant at a university, or as a Kenai Watershed Forum (KWF) employee. Decision pending.
- **Primary collaborating organization:** Kenai Watershed Forum. All chapters are intended to provide funding support to KWF work.

### Key Documents Generated

- `concept_note.qmd` (formerly `pitch_letter.qmd`, created 2026-04-29): Research concept paper / pitch for PSMFC funding and academic collaborator recruitment. Titled "Concept Note: An Integrated Doctoral Research Program on Kenai River Chinook Salmon." This is an active book chapter.
- `other/output/kenai_chinook_project_brief_2026-04-23.docx`: Earlier project brief focused on the productivity modeling chapter.

### Existing PSMFC-Funded Project: Critical Context for Chapter 3

**Grant:** PSMFC No. 26-084G, "Juvenile Kenai River Chinook Salmon Rearing Habitat Quality and Usage" **Amount:** \$94,974 \| **Period:** October 1, 2025 through September 30, 2028 **PIs:** Daniel Donnelly (ADF&G Division of Sport Fish, Soldotna) and Dr. Jeffrey Muehlbauer (University of Alaska Fairbanks) **Personnel:** 1 M.S. candidate (UAF, under Muehlbauer) + 1 field technician + ADF&G staff

**What this project does:** Stratified random sampling of juvenile KRCS rearing habitat in 3 mainstem reaches below Skilak Lake. Quantifies flow, depth, substrate, temperature, and vegetation density across 5 streambank cover types (intact riparian, restored riparian, large woody debris, erosion control structures, bare bank). Uses baited minnow traps to index habitat use. Develops a best-fit regression model (AIC/BIC comparison) predicting optimal juvenile KRCS rearing habitat. Evaluates whether restored banks meet preferred habitat conditions. Also crosslinks with a concurrent JSATS smolt outmigration/tagging project (ADF&G/UAF).

**Key personnel:** The M.S. candidate is Danielle Tryon (UAF/ADF&G), as confirmed by a poster presented at the 2026 Alaska Chapter of the American Fisheries Society (`other/documents/tryon_poster_uaf_2026.jpeg`). The poster title is "Habitat utilization of juvenile Chinook Salmon (*Oncorhynchus tshawytscha*) in the Kenai River." Contact: detryon\@alaska.edu.

**Methodological concern flagged for Chapter 3:** The Tryon poster frames hypotheses in terms of fish presence/trap catch as a proxy for habitat quality (e.g., "sites with more vegetation will have more fish present"; "anthropogenic alteration will present less fish"). This is an unreliable assumption. Fish abundance in baited minnow traps conflates habitat suitability with trap catchability, behavioral aggregation, density-dependent displacement, and sampling artifacts. Chapter 3 should use physical habitat covariates (flow, depth, substrate, temperature, vegetation) directly as quality indicators rather than inferring quality from fish presence.

**Implications for Chapter 3 of the doctoral program:** - A simple BACI study using fish presence as a habitat quality proxy would be both redundant with and methodologically weaker than the Tryon/Muehlbauer work. - Chapter 3 should operate at the watershed/landscape scale using NetMap habitat attribute outputs (channel gradient, valley confinement, wood recruitment potential, sediment delivery, flood frequency, lateral migration potential, etc.) rather than generating new metrics from aerial imagery. - NetMap for the Kenai River watershed will be completed as part of Chapter 2 (KWF habitat mapping initiative / Terrainworks partnership) and will therefore be directly available for Chapter 3. - The landscape-scale, process-based framing is scientifically stronger and clearly distinct from the site-scale presence/absence approach of the Tryon/Muehlbauer project. - The resulting habitat capacity or quality index can serve as a spatial covariate linking Chapter 3 to the productivity model in Chapter 4. - Dr. Muehlbauer (UAF) is a natural candidate for doctoral committee membership; Danielle Tryon is a direct collaborator. - The M.S.-at-UAF funding model in grant 26-084G is the established PSMFC precedent for the institutional structure the doctoral program would follow.

**Future direction (separate project, not in current scope):** Chapter 3 develops the NetMap habitat quality index and applies it once to establish a landscape-scale baseline. Generating a time series of habitat change using repeat LiDAR epochs or NAIP imagery is a natural follow-on project but constitutes a separate research effort. Flag for a post-dissertation or concurrent project.

------------------------------------------------------------------------

## Project Goal

Use all best available data to understand the full suite of natural, anthropogenic, marine, freshwater, historical, present, and future factors that drive wild Kenai River Chinook salmon productivity. The analysis is grounded in the Kenai River and its environs but draws on other populations and broader North Pacific literature as appropriate. The approach uses a Bayesian state-space spawner-recruit model with explicit environmental and anthropogenic covariates, informed by DeFilippo et al. (2026) and Cunningham et al. (2018), but not a direct adaptation of either.

Reference PDFs in `other/documents/`: - `Ecological Applications - 2026 - DeFilippo - Shifting stage-specific constraints on productivity shape recovery potential.pdf` (primary structural reference) - `Global Change Biology - 2018 - Cunningham - Signals of large scale climate drivers hatchery enhancement and marine.pdf` - `Global Change Biology - 2020 - Jones - Watershed-scale climate influences productivity of Chinook salmon populations across.pdf` (PDF now present; review before developing covariate list) - `Fish and Fisheries - 2025 - Lamborn - A Synthesis of Factors Related to Trends in Abundance and Demography of Alaska.pdf` (new; high priority review)

## Project Structure

Quarto book project (HTML and DOCX outputs). Key files:

- `_quarto.yml` — book configuration. Active chapters: `index.qmd`, `concept_note.qmd`, `references.qmd`. `intro.qmd` and `summary.qmd` are placeholder files commented out of the chapters list. `index.qmd` has `draft: true` to suppress it from rendering while satisfying the Quarto book home-page requirement.
- `concept_note.qmd` — the primary active document; the doctoral program concept note / PSMFC pitch.
- `docx-formatting.lua` — Lua filter applied to DOCX output only. Inserts a page break before every level-2 heading (`##`) and reorders the title block so date appears above author name (by prepending date to the author metadata list, since Pandoc's DOCX template renders author before date).
- `intro.qmd`, `summary.qmd` — placeholder chapters, currently inactive (commented out in `_quarto.yml`).
- `references.qmd`, `references.bib` — references chapter and bibliography.
- `other/agent_context/agent_context.txt` — project context and collaboration standards.
- `other/documents/` — reference PDFs.
- `other/input/` — data inputs (currently empty).
- `other/output/` — analysis outputs.

## Collaboration Standards (from agent_context.txt)

- Do not implement code without first confirming the user understands how it works
- Code must be readable and editable for future collaborative scientists
- **Do not use em dashes in written prose.** This is a known AI writing habit the user finds unappealing. Use commas, parentheses, semicolons, or restructure the sentence instead. This rule was violated in the April 23 project brief draft and had to be corrected retroactively.
- **User background:** Studied linear regression; no formal training in advanced statistics. Statistical methods should be explained as they are introduced, building from linear regression toward more complex concepts.

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

- **State-space formulation:** Separates observation error (imprecision in escapement/harvest counts) from process error (true biological variability in S-R relationship). This distinction matters because observation error in spawner counts biases slope estimates in standard regression.
- **Time-varying productivity (ln alpha):** Can be modeled as a random walk (latent drift) plus covariate effects, or covariates alone. Both will be explored.
- **Cohort reconstruction:** Age composition data from escapement and harvest samples are used to reconstruct brood-year returns across multiple calendar years. This converts calendar-year counts into cohort-specific survival estimates and is more informative than escapement totals alone.
- **Explicit mortality accounting:** Harvest F and bycatch F enter as known (or estimated) removals from each cohort, not as covariates. This allows the model to make direct statements about anthropogenic impacts rather than correlative ones.
- **Covariate selection:** Multiple candidate covariates (climate, competition, bycatch) tested; Bayesian shrinkage priors or model comparison used for selection.
- **Bayesian estimation in Stan** (CmdStanR interface).

### Competition Covariate: Wild vs. Hatchery Pink/Chum

The competition term (X_competition) should be considered carefully in light of recent literature (see Lamborn 2025, Medred 2026 commentary, and references therein). There is growing peer-reviewed evidence that hatchery-origin pink and chum salmon exert competitive pressure on wild Chinook at sea, potentially distinct from wild pink/chum abundance. The Ruggerone & Irvine (2018) database covers total abundance; separating hatchery contribution may require supplemental data from ADF&G hatchery records and NPAFC statistics. Whether to treat these as a single competition index or separate terms should be decided after reviewing Lamborn 2025 and Jones 2020.

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

## Reference Literature

### Primary modeling references

- **DeFilippo et al. 2026** — Primary structural reference. Stan IPM for Yukon Chinook with time-varying M (random walk) and maturation. Juvenile NBS trawl likelihood required. Finds marine heatwaves dominate productivity; bycatch and harvest have limited effect. Code: https://figshare.com/articles/dataset/29963606 (CC BY 4.0).
- **Cunningham et al. 2018** — JAGS lifecycle model with Bayesian Model Averaging over seven covariate categories for Yukon Chinook. Key finding: marine mortality is the primary driver. Code: https://github.com/curryc2/Yukon_Chinook_Bayes

### Key substantive references (review before covariate development)

- **Jones et al. 2020** — "Watershed-Scale Climate Influences Productivity of Chinook Salmon Populations Across Southcentral Alaska." *Global Change Biology* 26(9). Most directly relevant Southcentral AK precedent. PDF present. **Review before developing covariate list.**
- **Lamborn et al. 2025** — "A Synthesis of Factors Related to Trends in Abundance and Demography of Alaska Chinook Salmon (*Oncorhynchus tshawytscha*, Salmonidae): Implications for Research, Management, and Policy." *Fish and Fisheries*, 26(4), 520–532. https://doi.org/10.1111/faf.12895. Authors: Lamborn, C. C., Ohlberger, J., Walsworth, T. E., Westley, P. A. H., Cunningham, C. J., Wynsma, S., & Smith, J. W. New synthesis paper on Alaska-wide Chinook trends and drivers. PDF present. **High priority review; likely informs covariate selection and scope of analysis.**
- **Ruggerone & Irvine 2018** — North Pacific pink and chum abundance database; primary source for competition covariate.

### Gray/popular literature (contextual)

- **Medred, C. (2026-04-21)** — "Growing Awareness." https://craigmedred.news/2026/04/21/growing-awareness/ — Commentary synthesizing peer-reviewed evidence that hatchery pink salmon production may suppress wild Chinook productivity through competition at sea. References the Lamborn 2025 synthesis and prior studies (including PWS sockeye-pink competition work). Useful for framing the hatchery competition hypothesis and the policy/social context around Alaska hatcheries.

------------------------------------------------------------------------

## Critical Data Gaps

### 1. Juvenile abundance index — resolved, dropped

No Cook Inlet marine juvenile trawl index exists. No Kenai smolt trap has a useful historical record. ADF&G/UAF initiated a JSATS acoustic telemetry smolt study in 2025 (too new for historical series). The juvenile likelihood is dropped from Option 2. Standard S-R analysis from lagged spawner-to-adult data is sufficient for the model as specified.

### 2. GOA bycatch genetic apportionment — unresolved, high priority

GOA trawl bycatch of Chinook is documented by NMFS observers. Apportionment to Kenai-origin fish requires genetic stock composition sampling, which may have a shorter or noisier record than the BSAI equivalent used in the Yukon models.

**Important context:** Bycatch is a significant topic socially and culturally in Alaska. The project should make every effort to include bycatch as an explicit mortality term if data permit. Any decision to simplify or omit it must be justified by data availability, not assumed away based on DeFilippo's effect-size result. A well-supported finding that bycatch explains little variance in Kenai productivity is itself a meaningful result.

### 3. Hatchery vs. wild competition — flag for covariate development

It is not yet decided whether the competition term should distinguish hatchery-origin from wild pink/chum abundance. Lamborn 2025 should inform this decision.

------------------------------------------------------------------------

## What Looks Feasible

The following data requirements appear obtainable for Kenai:

- Adult escapement and harvest: ADF&G weir/sonar (RM 13.7 mainstem Kenai) and fishery records
- Age composition of escapement: ADF&G age sampling program
- Harvest age composition: ADF&G age sampling
- Harvest rate: derivable from ADF&G escapement and catch data
- Observation error for spawning abundance: ADF&G sonar/weir precision data
- Initial spawner abundance (pre-series initialization): ADF&G historical records
- Climate covariates: GOA SST (NOAA ERSSTv5), PDO/NPGO, marine heatwave indices
- Competition (total pink/chum abundance): Ruggerone & Irvine (2018) database
- Hatchery release data (for separating hatchery competition term): ADF&G hatchery records, NPAFC statistics

## Proposed Data Sources

| Category | Source |
|----|----|
| Escapement, age, harvest | ADF&G |
| River discharge | USGS |
| Air/stream temperature | NOAA / GHCN |
| Gulf of Alaska SST, marine heatwave indices | NOAA ERSSTv5, NOAA Coral Reef Watch |
| PDO, NPGO indices | NOAA indices |
| Pink/chum abundance (competition) | Ruggerone & Irvine 2018 database |
| Hatchery releases (AK and North Pacific) | ADF&G hatchery records; NPAFC statistics |
| GOA trawl bycatch | NMFS observer program |

------------------------------------------------------------------------

## Agreed Next Steps (in order)

1.  Review Jones et al. 2020 to understand prior Southcentral AK work and identify what this project adds
2.  Review Lamborn et al. 2025 for Alaska-wide Chinook synthesis; inform covariate list and competition term structure
3.  Build a data inventory: each required variable, specific source, and estimated time series length. Focus on (a) GOA bycatch availability and genetic apportionment depth, (b) escapement and age data depth, (c) hatchery pink/chum release data availability for competition term
4.  Assess data overlap years to determine the usable modeling window
5.  Decide on run scope: early run, late run, or both
6.  Decide whether to separate hatchery vs. wild pink/chum competition covariates
7.  Develop cohort reconstruction from ADF&G escapement and age composition data
8.  Build the state-space Ricker model in Stan, starting with a simple version (no covariates) and expanding

Data acquisition and model development begin after steps 1-5 are complete.

------------------------------------------------------------------------

## Feasibility Assessment Summary (as of 2026-04-15)

The state-space Ricker approach (Option 2) is **feasible and well-suited** to the available data. It avoids the identifiability problems introduced by dropping the juvenile likelihood from a full IPM, while preserving the ability to make direct statements about the magnitude of natural vs. anthropogenic impacts. Bycatch feasibility in the GOA remains the primary unresolved data question. Hatchery competition has been added as a candidate covariate pending literature review.
