# Kenai River Chinook Salmon Research: An Integrated Doctoral Research Program

**Author:** Benjamin Meyer, Kenai Watershed Forum\
**Started:** April 2026\
**Status:** Early development (planning and concept development phase)

## Overview

This repository supports development of a proposed doctoral research program on Kenai River Chinook salmon (*Oncorhynchus tshawytscha*). The program is designed to quantify the full suite of natural and anthropogenic factors driving wild Kenai River Chinook productivity, with particular attention to freshwater habitat condition, water quality, and population dynamics.

The research is organized into four chapters, each targeted as a standalone peer-reviewed publication. The program is being developed in collaboration with Kenai Watershed Forum (KWF) and will seek funding through the Pacific States Marine Fisheries Commission (PSMFC) Upper Cook Inlet Salmon Disaster Research program.

A rendered version of this document is published at: https://benmeyersalaska.github.io/kenai-chinook/

## Research Chapters

| Chapter | Topic |
|----|----|
| 1 | Kenai River water quality monitoring and trend analysis (2000-2025) |
| 2 | Predictive fish habitat mapping and Anadromous Waters Catalog expansion |
| 3 | Evaluation of Kenai River habitat restoration efforts |
| 4 | Kenai River Chinook productivity (Bayesian state-space spawner-recruit model) |

### Chapter 4 Modeling Approach

The productivity model is a linearized Ricker spawner-recruit equation in state-space form:

```         
ln(R/S) = ln(α) + β_climate × X_climate + β_bycatch × X_bycatch
          + β_competition × X_competition - β_density × S + ε
```

Key features:

- **State-space formulation** separates observation error from process error
- **Time-varying productivity** (ln α) modeled as a random walk or covariate-driven term
- **Cohort reconstruction** from ADF&G age composition data
- **Explicit mortality accounting** for directed harvest and bycatch
- **Bayesian covariate selection** using shrinkage priors or model comparison (WAIC / LOO-CV)
- **Estimation in Stan** via CmdStanR

## Repository Structure

```         
kenai-chinook/
├── _quarto.yml              # Quarto book configuration
├── index.qmd                # Book preface
├── concept_note.qmd         # Doctoral program concept note / PSMFC pitch
├── references.qmd           # Reference list
├── references.bib           # BibTeX bibliography
├── docx-formatting.lua      # Lua filter for DOCX output formatting
├── custom.css               # Custom CSS for HTML output
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

Output is written to `_book/` in HTML and DOCX formats. To publish to GitHub Pages:

``` bash
quarto publish gh-pages
```

## Key References

- DeFilippo, L. B., et al. (2026). Shifting stage-specific constraints on productivity shape recovery potential for Yukon River Chinook salmon. *Ecological Applications*. https://doi.org/10.1002/eap.3101
- Cunningham, C. J., et al. (2018). Signals of large-scale climate drivers, hatchery enhancement, and marine conditions on productivity of Chinook salmon populations across the North Pacific Ocean. *Global Change Biology*, 24(1), 159–174. https://doi.org/10.1111/gcb.13864
- Jones, M. L., et al. (2020). Watershed-scale climate influences productivity of Chinook salmon populations across Southcentral Alaska. *Global Change Biology*, 26(9), 5005–5020. https://doi.org/10.1111/gcb.15223
- Lamborn, C. C., et al. (2025). A synthesis of factors related to trends in abundance and demography of Alaska Chinook Salmon. *Fish and Fisheries*, 26(4), 520–532. https://doi.org/10.1111/faf.12895
- Ruggerone, G. T., & Irvine, J. R. (2018). Numbers and biomass of natural- and hatchery-origin Pink Salmon, Chum Salmon, and Sockeye Salmon in the North Pacific Ocean, 1925–2015. *Marine and Coastal Fisheries*, 10(2), 152–168. https://doi.org/10.1002/mcf2.10023

## License

This project is licensed under the GNU General Public License v3.0. See [LICENSE](LICENSE) for details.
