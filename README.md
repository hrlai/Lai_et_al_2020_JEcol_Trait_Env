# Data for Lai et al. (2020) *J. Ecol*

## About
The `R` object `Lai_et_al_2020_JEcol_boral_output.rds` contains the data input and the `boral` model output described in
> Lai HR, KY Chong, ATK Yee, HTW Tan, and M van Breugel (2020) Functional traits that moderate tropical tree recruitment during post-windstorm secondary succession. *Journal of Ecology*

## Using the data
We analysed the data using the `boral` package in `R` (see versions in Lai et al. 2020), therefore you will need to install `boral` to access most of the data input and model output easily:

```install.packages("boral")```

and then import our `boral` object into your `R` session:

```mod <- readRDS("Lai_et_al_2020_JEcol_boral_output.rds")```

Next, see `help(boral)` to access many of its well-documented functions or give Hui (2016) *MEE* a read (see `citation("boral")`). As a start, `summary(mod)` will be most useful for an overview of all our parameter estimates, though we've done our best to show the most informative model summaries in our Supplementary Information.

The data inputs are formatted the way `boral` likes it and are accessible via:

- Community data a.k.a. site--species matrix: `mod$Y`
- Environmental covariates: `mod$X`
- Trait data: `mod$traits`

Please note that both environmental covariates and traits were centered to zero mean and scaled to unit standard deviation, as described in Lai et al. (2020). For the trait data, only the leaf traits are collected by us *in situ*, while the other traits are a mixture of our field collection and published datasets, or entirely the latter (see our Supplementary Information). Therefore, these traits from various sources are probably more suitable to be used to scrutinise our analyses (or in a meta-analysis) than to be directly used as raw trait inputs for another analysis. The leaf traits that were collected from our field sites are accessible from the file `Lai_et_al_2020_JEcol_leaf_traits.rds`, and note that both specific leaf area (`SLA`) and lamina thickness (`Th`) are natural log-transformed as described in our paper. If you use these leaf traits, please cite an earlier paper in which they had been used:
> Yee, A. T. K., Lai, H. R., Chong, K. Y., Neo, L., Koh, C. Y., Tan, S. Y., … Tan, H. T. W. (2019). Short-term responses in a secondary tropical forest after a severe windstorm event. *Journal of Vegetation Science*, 30(4), 720--731. https://doi.org/10.1111/jvs.12753

If you use traits other than the leaf traits, please refer to our Supplementary Information for citations and original data sources or, better yet, make a new data request from [TRY](https://www.try-db.org/TryWeb/Home.php).

## Citation
We believe that the sharing of datasets is important for advancing ecology. At the same time, for data sharing to be successful and sustainable, it is important that those individuals whose time and efforts generated the data are acknowledged. Therefore, when you use the data or model output in your original research or meta-analysis, we appreciate if the following papers are cited:

- For leaf trait data: Yee, A. T. K., Lai, H. R., Chong, K. Y., Neo, L., Koh, C. Y., Tan, S. Y., … Tan, H. T. W. (2019). Short-term responses in a secondary tropical forest after a severe windstorm event. *Journal of Vegetation Science*, 30(4), 720--731. https://doi.org/10.1111/jvs.12753
- For everything else: Lai HR, KY Chong, ATK Yee, HTW Tan, and M van Breugel (2020) Functional traits that moderate tropical tree recruitment during post-windstorm secondary succession. *Journal of Ecology*

If this dataset forms the entirety or >50% of your own dataset used for a publication, we suggest that you might raise the possibility of coauthorship with the corresponding authors of the papers above (depending on the circumstances coauthorship may or may not be appropriate, but let's have a conversation at least).

## Contact
Hao Ran Lai [hrlai.ecology@gmail.com](mailto:hrlai.ecology@gmail.com)
