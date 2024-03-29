
#' @rdname getGradients
#' @export
getGradients.default <- function(x, method = "BelkinOReilly2009",
                                 intermediate = FALSE,
                                 ConvolNormalization = FALSE, ...){

  # Decide the method
  switch(simplifyChars(x = method),
         belkinoreilly2009 = df_BOR(a = x,
                                    intermediate = intermediate,
                                    ConvNorm = ConvolNormalization,
                                    ...),
         medianfilter = df_MF(x = x,
                               intermediate = intermediate,
                               ConvNorm = ConvolNormalization,
                               ...),
         agenbag20031 = df_Agenbag(x = x,
                                   intermediate = intermediate,
                                   ConvNorm = ConvolNormalization,
                                   algorithm = 1,
                                   ...),
         agenbag20032 = df_Agenbag(x = x,
                                   intermediate = intermediate,
                                   algorithm = 2,
                                   ...))
}

# Names of objects in this function follows the description of the algorithm in
# the article of Belkin and O'Reilly
df_BOR <- function(a, intermediate, ConvNorm, ...){

  # Define default kernel values (weights)
  control_default <- list(kernelValues = c(-1, -2, -1, 0, 0, 0, 1, 2, 1))

  # Merging with extra arguments passed from ...
  extraParams <- modifyList(x = control_default, val = list(...))

  # Apply a smooth (Contextual Median Filter)
  A <- contextualMF(X = a)

  # Define sobel kernel values
  sobelKernel <- extraParams$kernelValues

  # Define sobel kernels
  GX <- matrix(data = sobelKernel, nrow = 3)
  GY <- apply(t(GX), 2, rev) # GX rotated 90 deg counter-clockwise

  # Apply sobel filters (horizontal and verticaly)
  Gx <- convolution2D(X = A, kernel = GX)
  Gy <- convolution2D(X = A, kernel = GY)

  # Apply IDL normalization
  if(ConvNorm){
    Gx <- Gx/sum(abs(sobelKernel), na.rm = TRUE)
    Gy <- Gy/sum(abs(sobelKernel), na.rm = TRUE)
  }

  # Calculate gradient magnitude
  GM <- sqrt(Gx^2 + Gy^2)

  # Return output
  if(intermediate){
    list(original = a,
         CMF      = A,
         Gx       = Gx,
         Gy       = Gy,
         GD       = atan(Gy/Gx), # Gradient direction
         GM       = GM)          # Gradient magnitude
  }else{
    GM
  }
}

df_MF <- function(x, intermediate, ConvNorm, ...){

  # Define default kernel values (weights), radius and times for filter application
  control_default <- list(radius = 3,
                          times = 1,
                          kernelValues = c(-1, -2, -1, 0, 0, 0, 1, 2, 1))

  # Merging with extra arguments passed from ...
  extraParams <- modifyList(x = control_default, val = list(...))

  # Apply a smooth (Median Filter)
  preMatrix <- medianFilter(X = x, radius = extraParams$radius,
                            times = extraParams$times)

  # Define sobel kernel values
  sobelKernel <- extraParams$kernelValues

  # Define sobel kernels
  sobelV <- matrix(data = sobelKernel, nrow = 3)
  sobelH <- apply(t(sobelV), 2, rev) # sobelV rotated 90 deg counter-clockwise

  # Apply sobel filters (horizontal and verticaly)
  filteredV <- convolution2D(X = preMatrix, kernel = sobelV)
  filteredH <- convolution2D(X = preMatrix, kernel = sobelH)

  # Apply IDL normalization
  if(ConvNorm){
    filteredV <- filteredV/sum(abs(sobelKernel), na.rm = TRUE)
    filteredH <- filteredH/sum(abs(sobelKernel), na.rm = TRUE)
  }

  # Calculate gradient
  newSobel <- sqrt(filteredV^2 + filteredH^2)

  # Return output
  if(intermediate){
    list(original           = x,
         median_filter      = preMatrix,
         filtered_v         = filteredV,
         filtered_h         = filteredH,
         gradient_magnitude = newSobel,
         gradient_direction = atan(filteredH/filteredV))
  }else{
    newSobel
  }
}

df_Agenbag <- function(x, intermediate, algorithm, ...){

  # Apply a smooth (Median Filter)
  gradientMat <- agenbagFilters(X = x, algorithm = algorithm)

  # Return output
  if(intermediate){
    list(original           = x,
         gradient_magnitude = gradientMat)
  }else{
    gradientMat
  }
}
