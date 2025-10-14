---
title: Matchete
layout: home
nav_order: 1
---

<!-- Logo Section -->
<p align="center">
  <img src="{{ '/assets/images/matchete.pdf' | relative_url }}" alt="Project Logo" style="max-width: 1600px; margin-bottom: 2em;">
</p>

# Matchete

Matchete is a [Mathematica](https://www.wolfram.com/mathematica/resources/) package aimed at facilitating the functional matching procedure for generic weakly coupled UV models with a mass power counting. It is the first package fully automating functional one-loop matching computations. It is built upon and superseeds the [SuperTracer](https://gitlab.com/supertracer/supertracer) package [\[arXiv:2012.08506\]](https://arxiv.org/abs/2012.08506), which is used for the evaluation of the functional supertraces.

Matchete provides a simple and user-friendly interface for entering the Lagrangian of a generic UV theory. First of all, the user has to specify all the (gauge) symmetry groups and representations of the model, then all fields and couplings can be defined. Afterwards, the Lagrangian can be written very close to a pen-and-paper form.

The `Match` routine can then be applied to the UV Lagrangian to obtain the corresponding Effective Field Theory, where all heavy degrees of freedom have been integrated out, either at tree level, or at one loop.

The resulting EFT Lagrangian contains a (very) large number of redundant operators. These can be removed automatically by applying the routines `GreensSimplify`, which reduces the output to an off-shell Green's basis, and `EOMSimplify`, which performs field redefinitions. The fully simplified result will then be in a (near-)basis of the corresponding EFT operator space.

---

## LaTeX

Here is some LaTeX example $\Lambda^x$.

---

## Authors

* **Javier Fuentes-Martín** - *Universidad de Granada*
* **Matthias König** - *University of Mainz*
* **Julie Pagès** - *University of California at San Diego*
* **Anders Eller Thomsen** - *University of Bern*
* **Felix Wilsch** - *RWTH Aachen University*

---

## Bugs and feature requests

Please submit bugs and feature requests using GitLab's [issue system](https://gitlab.com/matchete/matchete/-/issues).

---

## License

MATCHETE is free software under the terms of the [GNU General Public License v3.0](https://gitlab.com/matchete/matchete/-/blob/master/LICENSE?ref_type=heads).

<!-- ---

## Acknowledgments

We thank José Santiago for his help with the cross-checks of the vector-like lepton example using matchmakereft. -->



<!-- This is a *bare-minimum* template to create a Jekyll site that uses the [Just the Docs] theme. You can easily set the created site to be published on [GitHub Pages] – the [README] file explains how to do that, along with other details.

If [Jekyll] is installed on your computer, you can also build and preview the created site *locally*. This lets you test changes before committing them, and avoids waiting for GitHub Pages.[^1] And you will be able to deploy your local build to a different platform than GitHub Pages.

More specifically, the created site:

- uses a gem-based approach, i.e. uses a `Gemfile` and loads the `just-the-docs` gem
- uses the [GitHub Pages / Actions workflow] to build and publish the site on GitHub Pages

Other than that, you're free to customize sites that you create with this template, however you like. You can easily change the versions of `just-the-docs` and Jekyll it uses, as well as adding further plugins.

[Browse our documentation][Just the Docs] to learn more about how to use this theme.

To get started with creating a site, simply:

1. click "[use this template]" to create a GitHub repository
2. go to Settings > Pages > Build and deployment > Source, and select GitHub Actions

If you want to maintain your docs in the `docs` directory of an existing project repo, see [Hosting your docs from an existing project repo](https://github.com/just-the-docs/just-the-docs-template/blob/main/README.md#hosting-your-docs-from-an-existing-project-repo) in the template README.

----

[^1]: [It can take up to 10 minutes for changes to your site to publish after you push the changes to GitHub](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/creating-a-github-pages-site-with-jekyll#creating-your-site).

[Just the Docs]: https://just-the-docs.github.io/just-the-docs/
[GitHub Pages]: https://docs.github.com/en/pages
[README]: https://github.com/just-the-docs/just-the-docs-template/blob/main/README.md
[Jekyll]: https://jekyllrb.com
[GitHub Pages / Actions workflow]: https://github.blog/changelog/2022-07-27-github-pages-custom-github-actions-workflows-beta/
[use this template]: https://github.com/just-the-docs/just-the-docs-template/generate -->
