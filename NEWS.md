## 1.6.1
  - Minor corrections on documentation and demo files.

## 1.6.0
  - We are changing the name of the `detectFronts` function to `getGradients`. However, for backwards compatibility, `detectFronts` will still be available until v2.0.0.
  - Adding new methods for `getGradients`: *Agenbag-1* and *Agenbag-2*.
  - Some minor improvements in documentation and code.

# 1.5.0
  - Compatibility with **imagine >= 2.0.0**.
  - New method for `SpatRast` objects (from **terra** package).
  - Improvements on all methods.
  - `ConvolNormalization = FALSE` by default now in `detectFronts` function. 

# 1.3.5
  - Corrections in Belkin and O'Reilly method (GX and GY kernel orientation).
  - Adding methods for `SpatRast` (from **terra** package) objects.
  - Support for `Raster-` objects will be retired since next versions of **grec**.
  - Improving methods for `array` objects.
  - `ConvolNormalization` argument is now set as `FALSE` by default in `detectFronts` function.
  - Minor corrections and improvements in efficiency.

# 1.3.4
  - Improvements on the way to work with matrix, arrays, list and `RasterLayer` objects.
  - Correcting some bugs regarded with methods.
  - Include `ConvolNormalization` argument and enable normalization of convolutions as default.
  - Add documentation of methods.

# 1.2.2
  - Improvements on the way to extract matrix data from `RasterLayer` object.
  - Correcting a bug when `RasterLayer` has not in-memory loaded data (e.g. `RasterLayer` gotten from read a tiff file).
  - Add documentation for NW_USA_SST data.
  
# 1.2.1
  - Some corrections in demos.
  - Include a new example data set for SST: NW_USA_SST
  - Testing normalization inside B&O method.

# 1.2.0
  - Several changes and improvements on package structure.
  - `finalSmooth` and `control` arguments `detectFronts` were deleted.
  - `extraParams` function were deleted. Now, available advanced arguments will be showed in help.
  - Help document for `detectFronts` were updated.
  - Another little corrections and improvements.

# 1.1.2
  - Now, `detectFronts` function has the `method` argument, using by default the Belkin & O'Reilly (2009) algorithm.
  - Some little corrections.

# 1.1.1
  - Modifications on the title of package.
  - New set of exampling data (`grecExData`).
  - Changes how the `detectFronts` algorithm works internally.
  

# 1.1.0
  - Change function name: from `fromDetection` to `detectFronts`.
  - Change several argument names on `detectFronts` function.
  - `thresholds` argument has been replaced by `qLimits`. Check help of `detectFronts` function for details.
  - On `detectFronts` function, the final smooth application is optional now, controling by `finalSmooth` argument.
  - Now `detectFronts` is a method for classes: `matrix`, `array` and `RasterLayer`.
  - Bugs and corrections.

# 1.0.0
  First Public Release
