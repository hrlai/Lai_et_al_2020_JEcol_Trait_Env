# Data for Lai et al. (2020) *J. Ecol*

## About
The `R` object `Lai_et_al_2020_JEcol_boral_output.rds` contains the data input and the `boral` model output described in
> Lai HR, KY Chong, ATK Yee, HTW Tan, and M van Breugel (2020) Functional traits that moderate tropical tree recruitment during post-windstorm secondary succession. *Journal of Ecology*

## Using the data
We analysed the data using the `boral` package in `R` (see version in Lai et al. 2020), therefore you will need to install `boral` to access most of the data input and model output easily:

```install.packages("boral")```

and then read our `boral` object:

```mod <- readRDS("Lai_et_al_2020_JEcol_boral_output.rds")```

Next, see `help(boral)` to access many of its well-documented functions. As a start, `summary(mod)` will be most useful.


## Citation


## Contact
[hrlai.ecology@gmail.com](mailto:hrlai.ecology@gmail.com)
