# SBP-BRiMS 2016 Tutorial: Generative Models for Social Network Data
This repository contains material from the [SBP-BRiMS 2016 tutorial on generative models for social network data](http://sbp-brims.org/2016/tutorial07/) by Kevin S. Xu and James R. Foulds.

## Tutorial Abstract

Due in part to the ubiquity of social network data today, interest in social network analysis has spread beyond its traditional home in the social sciences to many other disciplines including physics, computer science, statistics, and engineering. A topic of significant interest in social network analysis is the creation of statistical models for social network data. Many of these models are generative, which allows one to simulate random networks from a particular model. Additionally many models share a common structure: each vertex is assigned a set of latent or hidden attributes, and edges between vertices are generated with probability conditional on the hidden attributes of the vertices. These latent variables, which are automatically inferred from the network, can be valuable for understanding network structure with respect to sociological principles, and for making predictions about the network’s current and future state.

In this tutorial, we cover four main classes of generative models for social network data, under which many of the commonly used statistical network models fall:

- *Latent space models*, which generally assume latent continuous attributes for vertices where the probability of an edge between two vertices is given by a distance function applied to the attributes of the vertices.
- *Block models*, which divide vertices into one of `k` latent classes where the probability of an edge between two vertices depends only on the classes of the vertices.
- *Latent feature models*, which allow vertices to have arbitrarily many unique (typically binary) features, where the probability of an edge between two vertices is given by a weighted sum of the elements of their feature vectors.
- *Mixed membership models*, in which each vertex has partial membership in their latent classes.

We discuss some of the challenges when it comes to applying these types of generative models on social network data, including

- Optimization methods to fit these generative models, which involve estimating the latent attributes of the vertices, in an optimal or near-optimal manner.
- Simulation approaches for Bayesian inference in these models using Markov chain Monte Carlo.
- Model selection and verification to validate a particular fit to a social network model.
- Interpretation of model parameters and their relationship to social network structure.

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