# Script to calculate credible intervals from boral model

# load packages
library(boral)
library(tidybayes)
library(tidyverse)

# read model
mod <- readRDS("Lai_et_al_2020_JEcol_boral_output.rds")

# to calculate credible intervals, we will need to retrieve the posterior
# of the parameters of interest
# for this demonstration, we will focus on the fourth corner coefficients
# which are named traits.coefs and traits.int in boral
# we also need trait.sigma, which is the residual variance in species' environmental
# responses not explained by traits (species random intercepts)
# generating CI with trait.sigma is akin to getting prediction intervals
# whereas without trait.sigma is akin to getting confidence intervals (to borrow
# nomenclature from the frequentist world...)
# anyhow, I suggest generating CI including trait.sigma so it is more conservative
draws <- get.mcmcsamples(mod)

# extract and tidy up the posterior
# I'll call them kappa following Francis Hui's nomenclature
kappa <- 
  draws %>% 
  # gather the traits.coefs, traits.int and trait.sigma into a long list
  # the env and trait are names for the row and column indices
  # where row is env and column is trait
  # note that Fig. 1 in Lai et al. (2020) transposes this matrix so that
  # we present it as a "trait"-by-"env" table (sorry for the potential confusion)
  spread_draws(traits.coefs[env, trait],
               traits.int[env],
               trait.sigma[env])

# note that traits.int is the main trait effects, which corresponds to
# the top row in Fig. 1 of Lai et al. (2020)

# let's name the traits and env for clarity
# you will need to rename them according to your trait and env column names
# but in Lai et al. (2020) the names are indexed as follows
trait_names <- c("T0", colnames(mod$traits))
env_names   <- c("beta0", colnames(mod$X))
trait_name_match <- 
  data.frame(
    trait = seq_along(trait_names),
    Trait = trait_names
  )
env_name_match <- 
  data.frame(
    env = seq_along(env_names),
    Env = env_names
  )
kappa <- 
  kappa %>% 
  left_join(trait_name_match) %>% 
  left_join(env_name_match)

# Now let's say we want to reproduce Fig. 2a in Lai et al. (2020)
# showing the WD - canopy opening relationship
WD_canopy <- 
  kappa %>% 
  filter(Trait == "WD",
         Env   == "Canopy")

# we need a counterfactual / "new data" of WD gradient
# recall that the covariates were scaled
WD_new <- seq(min(mod$traits[, "WD"]),
              max(mod$traits[, "WD"]),
              length.out = 100)
# then we merge it to the posterior of WD_canopy using expand grid to obtain
# all combinations (please bear with me, it'll become clear why)
WD_canopy <- 
  expand_grid(WD_canopy, WD_new) %>% 
  # then we calculate the "response to canopy cover", i.e., the Y axis of Fig. 2a
  # remember that this is not the final species-specific response to canopy
  # but the expected response to canopy due to WD, while holding all other traits
  # at their averages!
  # I'll call it partial slope for clarity
  mutate(beta_canopy_partial = 
           traits.int + 
           traits.coefs * WD_new +
           rnorm(n(), 0, trait.sigma)) %>% 
  # then we summarise it to median +- 95% CI
  group_by(WD_new) %>% 
  median_qi(beta_canopy_partial)

# plot!
# I'll leave it up to you to backscale / backtransform the trait to its original 
# values
ggplot(WD_canopy) +
  geom_hline(yintercept = 0, lty = 2) +
  geom_ribbon(aes(WD_new, ymin = .lower, ymax = .upper),
              alpha = 0.2) +
  geom_line(aes(WD_new, beta_canopy_partial)) +
  labs(x = "WD (scaled)",
       y = "Response to canopy opening")

# As you can see, it is a bit different from the original Fig. 2a!
# Apologies, this is because PhD Hao Ran was a noob back then and custom coded the
# posterior calculation, which was not perfectly correct, but here's admiting it
# with the correct code :)
# (at least the outcomes are qualitatively similar, and Fig. 1 is still correct,
# only Fig. 2 needs correction; also, the points in Fig. 2a, not shown here, 
# should also be correct)