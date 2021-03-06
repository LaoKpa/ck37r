% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ipa_measure.R
\name{ipa_measure}
\alias{ipa_measure}
\title{Calculate IPA measure from cross-validation results}
\usage{
ipa_measure(preds, actual, test_folds)
}
\arguments{
\item{preds}{Predicted values or score}

\item{actual}{Known label value}

\item{test_folds}{Length n vector assigning each vector to a given test fold}
}
\value{
Dataframe of results, including Brier score and standard deviation
}
\description{
Calculate IPA measure from cross-validation results
}
