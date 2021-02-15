cmake_minimum_required(VERSION 3.5)
project(libsbp VERSION 3.4.5 LANGUAGES C)

set(CMAKE_DEBUG_POSTFIX  "d")

set(INSTALL_INCLUDES ON CACHE BOOL "Install include files")

file(GLOB HEADER_FILES c/include/libsbp/*.h)
file(GLOB SOURCE_FILES c/src/*.c)

#include_directories(
#  c/include
#)

SOURCE_GROUP("Source" FILES 
  ${HEADER_FILES}
  ${SOURCE_FILES}
)

set (ALL_FILES ${ALL_FILES} ${HEADER_FILES} ${SOURCE_FILES})

add_library(
  libsbp STATIC 
  ${ALL_FILES}
)

target_include_directories(libsbp PUBLIC 
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/c/include>
  $<INSTALL_INTERFACE:include>)


#----------------------------------------------------------------------------
# install 

install(TARGETS libsbp EXPORT libsbpConfig
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin
  )

if(INSTALL_INCLUDES)
  install(FILES ${HEADER_FILES} DESTINATION include/libsbp)
endif()

install(EXPORT libsbpConfig DESTINATION share/libsbp)

export(TARGETS libsbp FILE libsbpConfig.cmake)
