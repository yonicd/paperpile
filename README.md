
<!-- README.md is generated from README.Rmd. Please edit that file -->

# paperpile

<!-- badges: start -->

[![stability-experimental](https://img.shields.io/badge/stability-experimental-orange.svg)]()
<!-- badges: end -->

The goal of paperpile is to interact with paperpile from `R`.

## Installation

You can install the package by cloning and installing locally

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(paperpile)
```

## Querying

### Default

``` r
query('Holford and Sheiner 1981')
#> # A tibble: 2 x 3
#>   name                                   id                 drive_resource 
#> * <chr>                                  <chr>              <list>         
#> 1 Holford and Sheiner 1981 - Understand… 16hvq4xeiD0VhUhrX… <named list [3…
#> 2 Holford and Sheiner 1981 - Pharmacoki… 1q-deuKBo52LH_nAz… <named list [3…
```

### Exact matches

``` r
query('Holford and Sheiner 1981 - Pharmacokinetic and pharmacodynamic modeling in vivo.pdf',
      operator = '=')
#> # A tibble: 1 x 3
#>   name                                   id                 drive_resource 
#> * <chr>                                  <chr>              <list>         
#> 1 Holford and Sheiner 1981 - Pharmacoki… 1q-deuKBo52LH_nAz… <named list [3…
```

``` r
query('Holford and Sheiner 1981',operator = '=')
#> # A tibble: 0 x 3
#> # … with 3 variables: name <chr>, id <chr>, drive_resource <list>
```

## Download file to local machine

``` r
query('Holford and Sheiner 1981')%>%fetch()
#> File downloaded:
#>   * Holford and Sheiner 1981 - Understanding the dose-effect relationship - clinical application of pharmacokinetic-pharmacodynamic models.pdf
#> Saved locally as:
#>   * /var/folders/kx/t4h_mm1910sb7vhm_gnfnx2c0000gn/T//RtmprBlxIv/Holford and Sheiner 1981 - Understanding the dose-effect relationship - clinical application of pharmacokinetic-pharmacodynamic models.pdf
#> File downloaded:
#>   * Holford and Sheiner 1981 - Pharmacokinetic and pharmacodynamic modeling in vivo.pdf
#> Saved locally as:
#>   * /var/folders/kx/t4h_mm1910sb7vhm_gnfnx2c0000gn/T//RtmprBlxIv/Holford and Sheiner 1981 - Pharmacokinetic and pharmacodynamic modeling in vivo.pdf
```

## Interacting with exported bib file from paperpile

### Read in bib file as list

``` r
bib <- paperpile::parse_bib()
```

### Convert the list to a tibble

``` r
bib_tbl <- bib%>%
  bibble()

bib_tbl
#> # A tibble: 6,731 x 4
#>    rowid key         title                      author                     
#>    <int> <chr>       <chr>                      <chr>                      
#>  1     1 Miller2011… The highs and lows of can… Miller Lydia K and Devi La…
#>  2     2 Howlett200… Cannabinoid receptor sign… Howlett A C                
#>  3     3 Aggarwal20… Cannabinergic pain medici… Aggarwal Sunil K           
#>  4     4 Bi2019-yp   {Model-Informed} Drug Dev… Bi Youwei and Liu Jiang an…
#>  5     5 Gorovits20… Anti-drug Antibody Assay … Gorovits Boris and Wang Yi…
#>  6     6 Psioda2018… Bayesian design of a surv… Psioda Matthew A and Ibrah…
#>  7     7 Neuenschwa… Summarizing historical in… Neuenschwander Beat and Ca…
#>  8     8 Hobbs2012-… Commensurate Priors for I… Hobbs Brian P and Sargent …
#>  9     9 Psioda2019… Bayesian clinical trial d… Psioda Matthew A and Ibrah…
#> 10    10 Schmulson2… What Is New in Rome {IV}   Schmulson Max J and Drossm…
#> # … with 6,721 more rows
```

### Filter the tibble using tidyverse packages

``` r
keys <- bib_tbl%>%
  dplyr::filter(grepl('Knebel W',author,ignore.case = TRUE))%>%
  dplyr::pull(rowid)

keys
#>  [1]  703 2154 3508 3830 3851 3989 4111 4233 4460 4529 5061 5100 5106 5133
#> [15] 5602 5603 5715 6145 6483
```

### Write subset of original bib file as new smaller bib file

``` r
bib%>%write_bib(keys)
```

<details>

<summary>bib output</summary>

    #> @ARTICLE{Barrett2001-lx,
    #>   title   = "Anticoagulant pharmacodynamics of tinzaparin following 175 iu/kg
    #>              subcutaneous administration to healthy volunteers",
    #>   author  = "Barrett, J S and Hainer, J W and Kornhauser, D M and Gaskill, J L
    #>              and Hua, T A and Sprogel, P and Johansen, K and van Lier, J J and
    #>              Knebel, W and Pieniaszek, H. J., Jr",
    #>   journal = "Thromb. Res.",
    #>   volume  =  101,
    #>   number  =  4,
    #>   pages   = "243--254",
    #>   year    =  2001
    #> }
    #> @ARTICLE{Dvorchik2004-yi,
    #>   title   = "Population pharmacokinetics of daptomycin",
    #>   author  = "Dvorchik, B and Arbeit, R D and Chung, J and Liu, S and Knebel, W
    #>              and Kastrissios, H",
    #>   journal = "Antimicrob. Agents Chemother.",
    #>   volume  =  48,
    #>   number  =  8,
    #>   pages   = "2799--2807",
    #>   year    =  2004
    #> }
    #> @TECHREPORT{Knebel2009-mf,
    #>   title       = "Population {PK} Modeling of {PF-04360365} in Adults with
    #>                  {Mild-to-Moderate} Alzheimer's Disease",
    #>   author      = "Knebel, W",
    #>   institution = "Pfizer, Inc.",
    #>   year        =  2009
    #> }
    #> @ARTICLE{Knebel2010-dr,
    #>   title   = "Population Pharmacokinetic Analysis of Istradefylline in Healthy
    #>              Subjects and in Patients With Parkinson's Disease",
    #>   author  = "Knebel, William and Rao, Niranjan and Uchimura, Tatsuo and Mori,
    #>              Akihisa and Fisher, Jeannine and Gastonguay, Marc R and Chaikin,
    #>              Philip",
    #>   journal = "J. Clin. Pharmacol.",
    #>   month   =  mar,
    #>   year    =  2010
    #> }
    #> @ARTICLE{Knebel2010-oq,
    #>   title   = "Population Pharmacokinetic Modeling of Pantoprazole in Pediatric
    #>              Patients From Birth to 16 Years",
    #>   author  = "Knebel, W and Tammara, B and Udata, C and Comer, G and Gastonguay,
    #>              M R and Meng, X",
    #>   journal = "J. Clin. Pharmacol.",
    #>   month   =  may,
    #>   year    =  2010
    #> }
    #> @TECHREPORT{Knebel2010-cd,
    #>   title       = "Population Pharmacokinetic Modeling of {CXL}
    #>                  (Co-administration of Ceftaroline Fosamil for Injection and
    #>                  {NXL104} for Injection)",
    #>   author      = "Knebel, W",
    #>   institution = "Forest Research Institute, Inc.",
    #>   year        =  2010
    #> }
    #> @TECHREPORT{Knebel2007-pp,
    #>   title       = "Population Pharmacokinetic and Pharmacodynamic Analysis of
    #>                  Guanfacine in Pediatric Patients with Attention Deficit
    #>                  Hyperactivity Disorder",
    #>   author      = "Knebel, William",
    #>   institution = "Shire Pharmaceuticals Group",
    #>   year        =  2007
    #> }
    #> @TECHREPORT{Knebel2010-ds,
    #>   title       = "Executive Summary of Ceftaroline Pediatric Modeling and
    #>                  Simulation",
    #>   author      = "Knebel, W",
    #>   institution = "Forest Research Institute",
    #>   month       =  oct,
    #>   year        =  2010
    #> }
    #> @TECHREPORT{Knebel2011-pp,
    #>   title       = "Executive Summary of Guanfacine Clinical Trial Simulation for
    #>                  Study {SPD503-312}",
    #>   author      = "Knebel, William",
    #>   institution = "Shire Pharmaceuticals, Inc.",
    #>   month       =  apr,
    #>   year        =  2011
    #> }
    #> @ARTICLE{Knebel2011-tq,
    #>   title   = "Population {Pharmacokinetic-Pharmacodynamic} Analysis of
    #>              Istradefylline in Patients With Parkinson Disease",
    #>   author  = "Knebel, William and Rao, Niranjan and Uchimura, T and Mori,
    #>              Akihisa and Fisher, Jeannine and Gastonguay, Marc R and Chaikin,
    #>              Philip",
    #>   journal = "J. Clin. Pharmacol.",
    #>   month   =  dec,
    #>   year    =  2011
    #> }
    #> @TECHREPORT{Knebel2012-bc,
    #>   title       = "Pediatric {Fosphenytoin/Phenytoin} Analysis",
    #>   author      = "Knebel, William",
    #>   institution = "Pfizer, Inc.",
    #>   year        =  2012
    #> }
    #> @ARTICLE{Bergsma2013-nh,
    #>   title   = "Facilitating pharmacometric workflow with the metrumrg package for
    #>              {R}",
    #>   author  = "Bergsma, Timothy T and Knebel, William and Fisher, Jeannine and
    #>              Gillespie, William R and Riggs, Matthew M and Gibiansky, Leonid
    #>              and Gastonguay, Marc R",
    #>   journal = "Comput. Methods Programs Biomed.",
    #>   volume  =  109,
    #>   number  =  1,
    #>   pages   = "77--85",
    #>   month   =  jan,
    #>   year    =  2013
    #> }
    #> @ARTICLE{Knebel2008-ng,
    #>   title   = "Population pharmacokinetic modeling of epoetin delta in pediatric
    #>              patients with chronic kidney disease",
    #>   author  = "Knebel, William and Palmen, Mary and Dowell, James A and
    #>              Gastonguay, Marc",
    #>   journal = "J. Clin. Pharmacol.",
    #>   volume  =  48,
    #>   number  =  7,
    #>   pages   = "837--848",
    #>   month   =  jul,
    #>   year    =  2008
    #> }
    #> @ARTICLE{Knebel2013-sb,
    #>   title   = "Population Pharmacokinetics of Atorvastatin and Its Active
    #>              Metabolites in Children and Adolescents With Heterozygous Familial
    #>              Hypercholesterolemia: Selective Use of Informative Prior
    #>              Distributions from Adults",
    #>   author  = "Knebel, William and Gastonguay, Marc R and Malhotra, Bimal and
    #>              El-Tahtawy, Ahmed and Jen, Frank and Gandelman, Kuan",
    #>   journal = "J. Clin. Pharmacol.",
    #>   pages   = "1--5",
    #>   month   =  feb,
    #>   year    =  2013
    #> }
    #> @TECHREPORT{Knebel2013-nr,
    #>   title       = "Pediatric {Fosphenytoin/Phenytoin} Analysis (Revised)",
    #>   author      = "Knebel, William and {Metrum Research Group}",
    #>   institution = "Pfizer, Inc.",
    #>   year        =  2013
    #> }
    #> @TECHREPORT{Knebel2013-ow,
    #>   title       = "Summary of Fosphenytoin Simulations (Revised)",
    #>   author      = "Knebel, William and {Metrum Research Group}",
    #>   institution = "Pfizer, Inc.",
    #>   year        =  2013
    #> }
    #> @ARTICLE{Knebel2014-sm,
    #>   title   = "Population {Pharmacokinetic/Pharmacodynamic} Modeling of
    #>              Guanfacine Effects on {QTc} and Heart Rate in Pediatric Patients",
    #>   author  = "Knebel, William and Ermer, James and Purkayastha, Jaideep and
    #>              Martin, Patrick and Gastonguay, Marc R",
    #>   journal = "AAPS J.",
    #>   month   =  aug,
    #>   year    =  2014
    #> }
    #> @ARTICLE{Knebel2015-ih,
    #>   title   = "Modeling and simulation of the exposure-response and dropout
    #>              pattern of guanfacine extended-release in pediatric patients with
    #>              {ADHD}",
    #>   author  = "Knebel, William and Rogers, Jim and Polhamus, Dan and Ermer, James
    #>              and Gastonguay, Marc R",
    #>   journal = "J. Pharmacokinet. Pharmacodyn.",
    #>   volume  =  42,
    #>   number  =  1,
    #>   pages   = "45--65",
    #>   month   =  feb,
    #>   year    =  2015
    #> }
    #> @TECHREPORT{Knebel2012-ht,
    #>   title       = "Analysis of Ceftaroline in Lung Epithelial Lining Fluid
    #>                  ({ELF})",
    #>   author      = "Knebel, William",
    #>   institution = "Forest Research Institute",
    #>   year        =  2012
    #> }

</details>
