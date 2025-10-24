# ======================================================================
# setup_env.R  —  Environment bootstrap script for Simulation/ project
# ----------------------------------------------------------------------
# Run once after cloning the repo or creating a fresh renv environment.
# This script ensures all dependencies are installed and recorded.
# ======================================================================

# 0. Safety: ensure we’re inside the project
if (!requireNamespace("renv", quietly = TRUE)) install.packages("renv")
renv::activate()

# 1. Core CRAN dependencies
base_pkgs <- c(
  "rmarkdown","knitr",
  "tidyverse","dplyr","magrittr","tibble","broom",
  "data.table","glue","stringr","janitor",
  "ggplot2","patchwork","cowplot",
  "MASS","VGAM","survival",
  "BayesFactor","logspline"
)

# 2. Optional heavy dependencies (only needed for MCMC-based BFs)
optional_pkgs <- c("rstan")

# 3. Install anything missing
to_install <- setdiff(c(base_pkgs, optional_pkgs), rownames(installed.packages()))
if (length(to_install)) {
  message("Installing missing packages: ", paste(to_install, collapse = ", "))
  install.packages(to_install)
} else {
  message("All required packages already installed.")
}

# 4. Snapshot to renv.lock for reproducibility
renv::snapshot(prompt = FALSE)

# 5. Verify environment
cat("\nEnvironment setup complete.\n")
cat("renv project root: ", renv::project(), "\n")
cat("Total packages installed: ", length(c(base_pkgs, optional_pkgs)), "\n")
