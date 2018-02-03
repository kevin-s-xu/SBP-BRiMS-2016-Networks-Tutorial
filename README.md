# SBP-BRiMS 2016 Tutorial: Generative Models for Social Network Data
This repository contains material from the [SBP-BRiMS 2016 tutorial on generative models for social network data](http://sbp-brims.org/2016/tutorial07/) by Kevin S. Xu and James R. Foulds.

## Contents

- This README file
- Presentation slides: [SbpBrims2016NetworksTutorialSlides.pdf](SbpBrims2016NetworksTutorialSlides.pdf)
- Demo of stochastic block model and latent space model applied to dolphin social network: [DolphinsDemoSbmLsm.m](DolphinsDemoSbmLsm.m)
- Demo of stochastic block model applied to directed network of wall posts on Facebook: [FacebookWallDemoSbm.m](FacebookWallDemoSbm.m)

The remaining MATLAB .m files are functions used for either the latent space model or stochastic block model. Functions used for the stochastic block model are taken from the [Dynamic Stochastic Block Models MATLAB Toolbox](https://github.com/IdeasLabUT/Dynamic-Stochastic-Block-Model)

## Software Requirements

- MATLAB R2015b or later: the estimation procedure for the latent space model uses functions for graph data types in MATLAB, which were first added in R2015b.
- MATLAB Statistics Toolbox: the estimation procedures for both the stochastic block model and latent space model use functions from the Statistics Toolbox, including multidimensional scaling and k-means as well as helper functions such as `squareform()`.

## License

Distributed with a BSD license; see `LICENSE.txt`