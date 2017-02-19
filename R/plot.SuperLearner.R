#' @title Plot estimated risk and confidence interval for each learner
#'
#' @description
#' Does not include SuperLearner or Discrete SL results as that requires
#' CV.SuperLearner to estimate the standard errors.
#' @param x SuperLearner result object
#' @param Y Outcome vector
#' @param constant Multiplier of the standard error for confidence interval
#'   construction.
#' @param sort If TRUE re-orders the results by risk estimate.
#' @param ... Any remaining arguments (unused).
#' @importFrom ggplot2 ggplot aes_string geom_pointrange coord_flip ylab xlab
#' @importFrom stats qnorm
#' @export
plot.SuperLearner <- function(x, Y = x$Y,
                              constant = qnorm(0.975),
                              sort = TRUE, ...) {
  #.SL.require("ggplot2")

  # Use a clearer object name.
  sl = x

  # Need to pass in Y for now - should calculate SE during SuperLearner() to avoid this.
  table = data.frame(Learner = names(sl$cvRisk),
                     Risk = sl$cvRisk,
                     Risk_SE = sl_stderr(sl, Y),
                     Coef = sl$coef)
  if (sort) {
    table = table[order(table$Risk, decreasing = T), ]
  }

  # Convert to a factor with manual levels so ggplot doesn't re-order alphabetically.
  table$Learner = factor(table$Learner, levels = table$Learner)

  table$ci_lower = table$Risk - constant * table$Risk_SE
  table$ci_upper = table$Risk + constant * table$Risk_SE

  rownames(table) = NULL

  p = ggplot(table,
             aes(x = Learner, y = Risk, ymin = ci_lower, ymax = ci_upper)) +
    ggplot2::geom_pointrange(fatten = 2) +
    ggplot2::coord_flip() +
    ggplot2::ylab(paste0(length(sl$validRows), "-fold CV Risk Estimate")) +
    ggplot2::xlab("Method") + theme_bw()

  return(p)
}