% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bayes.mfsurv.R
\name{mfsurv}
\alias{mfsurv}
\title{mfsurv}
\usage{
mfsurv(
  formula,
  Y0,
  data = list(),
  N,
  burn,
  thin,
  w = c(1, 1, 1),
  m = 10,
  form = c("Weibull", "Exponential"),
  na.action = c("na.omit", "na.fail")
)
}
\arguments{
\item{formula}{a formula in the form Y ~ X1 + X2... | C ~ Z1 + Z2 ... where Y is the duration until failure or censoring, and C is a binary indicator of observed failure.}

\item{Y0}{the elapsed time since inception until the beginning of time period (t-1).}

\item{data}{list object of data.}

\item{N}{number of MCMC iterations.}

\item{burn}{burn-ins to be discarded.}

\item{thin}{thinning to prevent autocorrelation of chain of samples by only taking the n-th values.}

\item{w}{size of the slice in the slice sampling for (betas, gammas, lambda). The default is c(1,1,1). This value may be changed by the user to meet one's needs.}

\item{m}{limit on steps in the slice sampling. The default is 10. This value may be changed by the user to meet one's needs.}

\item{form}{type of parametric model distribution to be used. Options are "Exponential" or "Weibull". The default is "Weibull".}

\item{na.action}{a function indicating what should happen when NAs are included in the data. Options are "na.omit" or "na.fail". The default is "na.omit".}
}
\value{
mfsurv returns an object of class \code{"mfsurv"}.

A \code{"mfsurv"} object has the following elements:
\item{Y}{the vector of `Y'.}
\item{Y0}{the vector of `Y0'.}
\item{C}{the vector of `C'.}
\item{X}{matrix X's variables.}
\item{Z}{the vector of `Z'.}
\item{betas}{data.frame,  X.intercept and X variables.}
\item{gammas}{data.frame, Z.intercept and Z variables.}
\item{lambda}{integer.}
\item{post}{integer.}
\item{iterations}{number of MCMC iterations.}
\item{burn_in}{burn-ins to be discarded.}
\item{thinning}{integer.}
\item{betan}{integer, length of posterior sample for betas.}
\item{gamman}{integer, length of posterior sample for gammas.}
\item{distribution}{character, type of distribution.}
\item{call}{the call.}
\item{formula}{description for the model to be estimated.}
}
\description{
\code{mfsurv} fits a parametric Bayesian MF model via Markov Chain Monte Carlo (MCMC) to estimate the misclassification in the first stage
 and the hazard in the second stage.
}
\examples{
set.seed(95)
bgl <- Buhaugetal_2009_JCR
bgl <- subset(bgl, coupx == 0)
bgl <- na.omit(bgl)
Y   <- bgl$Y
X   <- as.matrix(cbind(1, bgl[,1:7]))
C   <- bgl$C
Z1  <- matrix(1, nrow = nrow(bgl))
Y0  <- bgl$Y0
model1 <- mfsurv(Y ~ X | C ~ Z1, Y0 = Y0,
                N = 50,
                burn = 20,
                thin = 15,
                w = c(0.1, .1, .1),
                m = 5,
                form = "Weibull",
                na.action = 'na.omit')
}
