
#' Rotate loadings
#'
#' @param loading The loading matrix.
#' @export
rotate_loading <- function(loading) {
  res <- svd(loading)
  L1 <- loading %*% res$v
  L2 <- -loading %*% res$v
  if(sum(L1 > 0) > sum(L2 > 0)) {
    L1
  } else {
    L2
  }
}

#' Stability calculation of variety
#'
#' The function also performs a check taht the
#' estimated loadings for the first factor is all positive.
#'
#' @param loading The rotated loading matrix.
#' @param scores The score matrix with the rownames containing the names of the
#' varieties.
#'
#' @seealso rotate
#' @return A named list containing overall performance (OP) and
#' root mean square deviation (RSMD)
#' @export
#' @source Smith & Cullis (2018) Plant breeding selection tools built on
#' factor analytic mixedmodels for multi-environment trial data. Euphytica.
#'
FAST <- function(loading, scores) {
  if(!all(loading[,1] >= 0)) {
    warning("The first factor of the input loading matrix are not all positive.")
  }
  OP <- mean(loadings[, 1]) * scores[, 1]
  E <- scores[, -1, drop = FALSE] %*% t(loadings[, -1, drop = FALSE])
  RMSD <- rowMeans(E^2)

  df <- data.frame(variety = names(OP),
             OP = OP,
             RMSD = RMSD[names(OP)])
  rownames(df) <- NULL
  df
}
