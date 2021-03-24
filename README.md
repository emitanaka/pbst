
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pbst

<!-- badges: start -->

<!-- badges: end -->

This R-package implements tools to assist selection from
multi-environment trial data of plant breeding experiments based on
Smith and Cullis (2018) “Plant breeding selection tools built on factor
analytic mixedmodels for multi-environment trial data” *Euphytica*.

## Installation

You can install the development version of this package as:

``` r
#  install.packages("remotes")
remotes::install_github("emitanaka/pbst")
```

## Example

Suppose there are \(m\) varieties tested at \(p\) locations. You fit a
factor analytic model as per Smith (2001) with \(k\) factors.

You should have a data that consists of the estimates of the loading
matrix which has dimension of \(p\) rows and \(k\) columns. In addition,
you should have the variety scores as a *matrix* with \(m\) rows and
\(k\) factors. The score matrix should have the rownames with the names
of the variety.

A sample data provided by Manigben Kulai Amadu are provided as
`loadings` and `scores` when you load the package.

``` r
library(pbst)
dim(scores)
#> [1] 315   4
head(scores)
#>            Score1  Score2  Score3  Score4
#> 1:SBP16   -0.1787  0.0660 -0.2532 -0.7102
#> 1:ZIZ17    0.3692 -0.0935 -1.3845  1.4063
#> 10:ZWB17   0.0021  0.0764 -0.1005  0.5150
#> 100:ZIZ17  0.0239 -0.0840 -0.6460  0.3571
#> 100:ZWB17  1.4273 -0.9519 -0.3182  0.8584
#> 101:ZIF16  0.2582 -0.4001 -0.5079  2.2997
loadings
#>       Load1   Load2   Load3   Load4
#> [1,] 0.1613 -0.0574  0.0787 -0.0472
#> [2,] 0.3587  0.0165  0.1834  0.0519
#> [3,] 0.0853  0.0227  0.0160 -0.1354
#> [4,] 0.0755  0.0434  0.0897  0.0080
#> [5,] 0.3771 -0.2787 -0.1071  0.0151
#> [6,] 0.0938 -0.0004 -0.0704  0.0001
#> [7,] 0.2360  0.1037 -0.0272 -0.0789
#> [8,] 0.2963  0.2659 -0.1120  0.0435
```

In the example above there are 315 varieties tested at 8 environments
(note: not all varieties are tested at each location).

The estimates of the loading matrix are not unique. There are some
common rotation used and below employs the one recommended by Smith &
Cullis (2018).

``` r
rotate_loading(loadings)
#>            [,1]          [,2]        [,3]          [,4]
#> [1,] 0.16130167  0.0573674568 -0.07871267 -0.0472127240
#> [2,] 0.35871359 -0.0165945309 -0.18337789  0.0518540172
#> [3,] 0.08529129 -0.0226924638 -0.01597056 -0.1354102252
#> [4,] 0.07550509 -0.0434432049 -0.08967655  0.0079803068
#> [5,] 0.37709790  0.2787440184  0.10699030  0.0151176320
#> [6,] 0.09379611  0.0004316402  0.07040500  0.0001009407
#> [7,] 0.23599199 -0.1036805517  0.02726936 -0.0789255657
#> [8,] 0.29629413 -0.2658561567  0.11213495  0.0434602453
```

When using the recommended Factor Analytic Selection Tools (FAST), you
should use the rotated version of the loading matrix. The output shows
the overall performance (OP) and the root mean square deviation.

``` r
results <- FAST(rotate_loading(loadings), scores)
head(results)
#>     variety          OP        RMSD
#> 1   1:SBP16 -0.03761635 0.002709926
#> 2   1:ZIZ17  0.07771660 0.026657802
#> 3  10:ZWB17  0.00044205 0.001268511
#> 4 100:ZIZ17  0.00503095 0.004711070
#> 5 100:ZWB17  0.30044665 0.022600699
#> 6 101:ZIF16  0.05435110 0.026743080
```
