CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
CMAKE_POLICY(VERSION 2.8)

PROJECT(NiftiNrrdConversion)

FIND_PACKAGE(ITK)
IF(ITK_FOUND)
	INCLUDE(${ITK_USE_FILE})
ELSE(ITK_FOUND)
	MESSAGE(FATAL_ERROR "ITK not found. Please set ITK_DIR")
ENDIF(ITK_FOUND)

FIND_PACKAGE(GenerateCLP REQUIRED)
IF (GenerateCLP_FOUND)
  INCLUDE(${GenerateCLP_USE_FILE})
ELSE(GenerateCLP_FOUND)
   MESSAGE(FATAL_ERROR, "GenerateCLP not found. Please set GenerateCLP_DIR.")
ENDIF (GenerateCLP_FOUND)

GENERATECLP(NiftiNrrdConversion.cxx NiftiNrrdConversion.xml)
ADD_EXECUTABLE(DWI_NiftiNrrdConversion NiftiNrrdConversion.cxx)

TARGET_LINK_LIBRARIES(DWI_NiftiNrrdConversion ${ITK_LIBRARIES})

install( TARGETS DWI_NiftiNrrdConversion RUNTIME DESTINATION bin )
