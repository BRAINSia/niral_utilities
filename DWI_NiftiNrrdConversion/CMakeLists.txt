cmake_minimum_required(VERSION 2.8)
cmake_policy(VERSION 2.8)

PROJECT(NiftiNrrdConversion)

find_package(ITK REQUIRED)
if(ITK_USE_FILE)
	include(${ITK_USE_FILE})
endif(ITK_FOUND)

find_package(SlicerExecutionModel REQUIRED GenerateCLP)
include(${GenerateCLP_USE_FILE})

generateclp(NiftiNrrdConversion.cxx NiftiNrrdConversion.xml)
ADD_EXECUTABLE(DWI_NiftiNrrdConversion NiftiNrrdConversion.cxx)

TARGET_LINK_LIBRARIES(DWI_NiftiNrrdConversion ${ITK_LIBRARIES})

install( TARGETS DWI_NiftiNrrdConversion RUNTIME DESTINATION bin )
