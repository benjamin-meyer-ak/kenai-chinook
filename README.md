# Kenai River Chinook Salmon Productivity Study

**Author:** Benjamin Meyer\
**Started:** April 2026\
**Status:** Early development (planning and literature review phase)

## Overview

This project aims to use all best available data to understand the full suite of natural, anthropogenic, marine, freshwater, historical, present, and future factors that drive wild Kenai River Chinook salmon (*Oncorhynchus tshawytscha*) productivity. The analysis is grounded in the Kenai River and its environs but draws on other populations and the broader North Pacific literature as appropriate.

The core product is a Bayesian state-space spawner-recruit model with explicit environmental and anthropogenic covariates, estimated in Stan. The approach is informed by recent modeling work for Yukon River Chinook (DeFilippo et al. 2026; Cunningham et al. 2018) but is not a direct adaptation of either, and is designed specifically for the data landscape available in Cook Inlet.

The analysis and results will be documented in a Quarto book rendered to HTML and PDF.

## Modeling Approach

The model is a linearized Ricker spawner-recruit equation in state-space form:

```         
ln(R/S) = ln(α) + β_climate × X_climate + β_bycatch × X_bycatch
          + β_competition × X_competition - β_density × S + ε
```

Key features:

- **State-space formulation** separates observation error (imprecision in escapement and harvest counts) from process error (true biological variability)
- **Time-varying productivity** (ln α) modeled as a random walk or covariate-driven term
- **Cohort reconstruction** from ADF&G age composition data
- **Explicit mortality accounting** for directed harvest and bycatch
- **Bayesian covariate selection** using shrinkage priors or model comparison (WAIC / LOO-CV)
- **Estimation in Stan** via CmdStanR

## Repository Structure

```         
kenai-chinook/
├── _quarto.yml              # Quarto book configuration
├── index.qmd                # Book preface / introduction
├── intro.qmd                # Background and motivation
├── summary.qmd              # Summary and conclusions
├── references.qmd           # Reference list
├── references.bib           # BibTeX bibliography
├── other/
│   ├── agent_context/       # Project context and collaboration notes
│   ├── documents/           # Reference PDFs
│   ├── input/               # Data inputs (not tracked in git)
│   └── output/              # Analysis outputs and reports
└── AGENTS.md                # AI assistant memory file (project state, decisions, next steps)
```

## Rendering the Book

This project requires [Quarto](https://quarto.org) and R. To render:

``` bash
quarto render
```

Output will be written to `_book/` in both HTML and PDF formats.

## Key References

- DeFilippo, L. B., et al. (2026). Shifting stage-specific constraints on productivity shape recovery potential for Yukon River Chinook salmon. *Ecological Applications*. https://doi.org/10.1002/eap.3101
- Cunningham, C. J., et al. (2018). Signals of large-scale climate drivers, hatchery enhancement, and marine conditions on productivity of Chinook salmon populations across the North Pacific Ocean. *Global Change Biology*, 24(1), 159–174. https://doi.org/10.1111/gcb.13864
- Jones, M. L., et al. (2020). Watershed-scale climate influences productivity of Chinook salmon populations across Southcentral Alaska. *Global Change Biology*, 26(9), 5005–5020. https://doi.org/10.1111/gcb.15223
- Lamborn, C. C., et al. (2025). A synthesis of factors related to trends in abundance and demography of Alaska Chinook Salmon. *Fish and Fisheries*, 26(4), 520–532. https://doi.org/10.1111/faf.12895
- Ruggerone, G. T., & Irvine, J. R. (2018). Numbers and biomass of natural- and hatchery-origin Pink Salmon, Chum Salmon, and Sockeye Salmon in the North Pacific Ocean, 1925–2015. *Marine and Coastal Fisheries*, 10(2), 152–168. https://doi.org/10.1002/mcf2.10023

## License

This project is licensed under the GNU General Public License v3.0. See [LICENSE](LICENSE) for details.
