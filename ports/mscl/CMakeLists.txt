cmake_minimum_required(VERSION 3.2 FATAL_ERROR)

#----------------------------------------------------------------------------
# project name


set(TARGET_NAME mscl)

project(${TARGET_NAME} VERSION 0.1 LANGUAGES CXX)

find_package(Boost 1.55.0 MODULE
  COMPONENTS
    context
    chrono
    date_time
    filesystem
    program_options
    regex
    system
    thread
  REQUIRED
)

set(CMAKE_DEBUG_POSTFIX "d")


#----------------------------------------------------------------------------
# Setup files

file (GLOB HEADER_FILES MSCL/source/*.h)
file (GLOB SOURCE_FILES MSCL/source/*.cpp)

file (GLOB mscl_HEADER_FILES MSCL/source/mscl/*.h)
file (GLOB mscl_SOURCE_FILES MSCL/source/mscl/*.cpp)

file (GLOB mscl_Communication_HEADER_FILES MSCL/source/mscl/Communication/*.h)
set (mscl_Communication_SOURCE_FILES 
  MSCL/source/mscl/Communication/Connection.cpp
  MSCL/source/mscl/Communication/ConnectionDebugData.cpp
  MSCL/source/mscl/Communication/Devices.cpp
  MSCL/source/mscl/Communication/SerialConnection.cpp
  MSCL/source/mscl/Communication/TcpIpConnection.cpp
)

if (WIN32)
  set (mscl_Communication_SOURCE_FILES 
    ${mscl_Communication_SOURCE_FILES}
    MSCL/source/mscl/Communication/UpnpDeviceFinderCallback.cpp
    MSCL/source/mscl/Communication/UpnpService.cpp
    MSCL/source/mscl/Communication/WsdaFinder.cpp
  )
else ()
  set (mscl_Communication_SOURCE_FILES 
    ${mscl_Communication_SOURCE_FILES}
    MSCL/source/mscl/Communication/UnixSocketConnection.cpp
  )
endif ()

file (GLOB mscl_MicroStrain_HEADER_FILES MSCL/source/mscl/MicroStrain/*.h)
file (GLOB mscl_MicroStrain_SOURCE_FILES MSCL/source/mscl/MicroStrain/*.cpp)

file (GLOB mscl_MicroStrain_Displacement_HEADER_FILES MSCL/source/mscl/MicroStrain/Displacement/*.h)
file (GLOB mscl_MicroStrain_Displacement_SOURCE_FILES MSCL/source/mscl/MicroStrain/Displacement/*.cpp)

file (GLOB mscl_MicroStrain_Displacement_Commands_HEADER_FILES MSCL/source/mscl/MicroStrain/Displacement/Commands/*.h)
file (GLOB mscl_MicroStrain_Displacement_Commands_SOURCE_FILES MSCL/source/mscl/MicroStrain/Displacement/Commands/*.cpp)

file (GLOB mscl_MicroStrain_Inertial_HEADER_FILES MSCL/source/mscl/MicroStrain/Inertial/*.h)
file (GLOB mscl_MicroStrain_Inertial_SOURCE_FILES MSCL/source/mscl/MicroStrain/Inertial/*.cpp)

file (GLOB mscl_MicroStrain_Inertial_Commands_HEADER_FILES MSCL/source/mscl/MicroStrain/Inertial/Commands/*.h)
file (GLOB mscl_MicroStrain_Inertial_Commands_SOURCE_FILES MSCL/source/mscl/MicroStrain/Inertial/Commands/*.cpp)

file (GLOB mscl_MicroStrain_Inertial_Features_HEADER_FILES MSCL/source/mscl/MicroStrain/Inertial/Features/*.h)
file (GLOB mscl_MicroStrain_Inertial_Features_SOURCE_FILES MSCL/source/mscl/MicroStrain/Inertial/Features/*.cpp)

file (GLOB mscl_MicroStrain_Inertial_Packets_HEADER_FILES MSCL/source/mscl/MicroStrain/Inertial/Packets/*.h)
file (GLOB mscl_MicroStrain_Inertial_Packets_SOURCE_FILES MSCL/source/mscl/MicroStrain/Inertial/Packets/*.cpp)

file (GLOB mscl_MicroStrain_MIP_HEADER_FILES MSCL/source/mscl/MicroStrain/MIP/*.h)
file (GLOB mscl_MicroStrain_MIP_SOURCE_FILES MSCL/source/mscl/MicroStrain/MIP/*.cpp)

file (GLOB mscl_MicroStrain_MIP_Commands_HEADER_FILES MSCL/source/mscl/MicroStrain/MIP/Commands/*.h)
file (GLOB mscl_MicroStrain_MIP_Commands_SOURCE_FILES MSCL/source/mscl/MicroStrain/MIP/Commands/*.cpp)

file (GLOB mscl_MicroStrain_MIP_Packet_HEADER_FILES MSCL/source/mscl/MicroStrain/MIP/Packets/*.h)
file (GLOB mscl_MicroStrain_MIP_Packet_SOURCE_FILES MSCL/source/mscl/MicroStrain/MIP/Packets/*.cpp)

file (GLOB mscl_MicroStrain_RTK_Commands_HEADER_FILES MSCL/source/mscl/MicroStrain/RTK/Commands/*.h)
file (GLOB mscl_MicroStrain_RTK_Commands_SOURCE_FILES MSCL/source/mscl/MicroStrain/RTK/Commands/*.cpp)

file (GLOB mscl_MicroStrain_RTK_HEADER_FILES MSCL/source/mscl/MicroStrain/RTK/*.h)
file (GLOB mscl_MicroStrain_RTK_SOURCE_FILES MSCL/source/mscl/MicroStrain/RTK/*.cpp)

file (GLOB mscl_MicroStrain_Wireless_HEADER_FILES MSCL/source/mscl/MicroStrain/Wireless/*.h)
file (GLOB mscl_MicroStrain_Wireless_SOURCE_FILES MSCL/source/mscl/MicroStrain/Wireless/*.cpp)

file (GLOB mscl_MicroStrain_Wireless_Commands_HEADER_FILES MSCL/source/mscl/MicroStrain/Wireless/Commands/*.h)
file (GLOB mscl_MicroStrain_Wireless_Commands_SOURCE_FILES MSCL/source/mscl/MicroStrain/Wireless/Commands/*.cpp)

file (GLOB mscl_MicroStrain_Wireless_Configuration_HEADER_FILES MSCL/source/mscl/MicroStrain/Wireless/Configuration/*.h)
file (GLOB mscl_MicroStrain_Wireless_Configuration_SOURCE_FILES MSCL/source/mscl/MicroStrain/Wireless/Configuration/*.cpp)

file (GLOB mscl_MicroStrain_Wireless_Features_HEADER_FILES MSCL/source/mscl/MicroStrain/Wireless/Features/*.h)
file (GLOB mscl_MicroStrain_Wireless_Features_SOURCE_FILES MSCL/source/mscl/MicroStrain/Wireless/Features/*.cpp)

file (GLOB mscl_MicroStrain_Wireless_Packets_HEADER_FILES MSCL/source/mscl/MicroStrain/Wireless/Packets/*.h)
file (GLOB mscl_MicroStrain_Wireless_Packets_SOURCE_FILES MSCL/source/mscl/MicroStrain/Wireless/Packets/*.cpp)

set (ALL_FILES 
  ${ALL_FILES} 

  ${HEADER_FILES}
  ${SOURCE_FILES}

  ${mscl_HEADER_FILES}
  ${mscl_SOURCE_FILES}

  ${mscl_Communication_HEADER_FILES}
  ${mscl_Communication_SOURCE_FILES}

  ${mscl_MicroStrain_HEADER_FILES}
  ${mscl_MicroStrain_SOURCE_FILES}

  ${mscl_MicroStrain_Displacement_HEADER_FILES}
  ${mscl_MicroStrain_Displacement_HEADER_FILES}

  ${mscl_MicroStrain_Displacement_Commands_HEADER_FILES}
  ${mscl_MicroStrain_Displacement_Commands_SOURCE_FILES}

  ${mscl_MicroStrain_Inertial_HEADER_FILES}
  ${mscl_MicroStrain_Inertial_SOURCE_FILES}

  ${mscl_MicroStrain_Inertial_Commands_HEADER_FILES}
  ${mscl_MicroStrain_Inertial_Commands_SOURCE_FILES}

  ${mscl_MicroStrain_Inertial_Features_HEADER_FILES}
  ${mscl_MicroStrain_Inertial_Features_SOURCE_FILES}

  ${mscl_MicroStrain_Inertial_Packets_HEADER_FILES}
  ${mscl_MicroStrain_Inertial_Packets_SOURCE_FILES}

  ${mscl_MicroStrain_MIP_HEADER_FILES}
  ${mscl_MicroStrain_MIP_SOURCE_FILES}

  ${mscl_MicroStrain_MIP_Commands_HEADER_FILES}
  ${mscl_MicroStrain_MIP_Commands_SOURCE_FILES}

  ${mscl_MicroStrain_MIP_Packet_HEADER_FILES}
  ${mscl_MicroStrain_MIP_Packet_SOURCE_FILES}

  ${mscl_MicroStrain_RTK_Commands_HEADER_FILES}
  ${mscl_MicroStrain_RTK_Commands_SOURCE_FILES}

  ${mscl_MicroStrain_RTK_HEADER_FILES}
  ${mscl_MicroStrain_RTK_SOURCE_FILES}

  ${mscl_MicroStrain_Wireless_HEADER_FILES}
  ${mscl_MicroStrain_Wireless_SOURCE_FILES}

  ${mscl_MicroStrain_Wireless_Commands_HEADER_FILES}
  ${mscl_MicroStrain_Wireless_Commands_SOURCE_FILES}

  ${mscl_MicroStrain_Wireless_Configuration_HEADER_FILES}
  ${mscl_MicroStrain_Wireless_Configuration_SOURCE_FILES}

  ${mscl_MicroStrain_Wireless_Features_HEADER_FILES}
  ${mscl_MicroStrain_Wireless_Features_SOURCE_FILES}

  ${mscl_MicroStrain_Wireless_Packets_HEADER_FILES}
  ${mscl_MicroStrain_Wireless_Packets_SOURCE_FILES}
)

SOURCE_GROUP(TREE "${PROJECT_SOURCE_DIR}/MSCL" FILES ${ALL_FILES})


#----------------------------------------------------------------------------
# Setup library

if(MSVC)
  add_definitions(/MP)
endif()

add_library (${TARGET_NAME}
  ${ALL_FILES}
)

add_library(Mscl::mscl ALIAS ${TARGET_NAME})

target_include_directories(${TARGET_NAME} PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/MSCL/source>
)

target_link_libraries(${TARGET_NAME} PUBLIC Boost::system)

target_compile_definitions(${TARGET_NAME} PUBLIC MSCL_DISABLE_WEBSOCKETS MSCL_DISABLE_SSL)
target_compile_definitions(${TARGET_NAME} PRIVATE BOOST_ASIO_ENABLE_OLD_SERVICES)

if (UNIX)
  target_compile_definitions(${TARGET_NAME} PRIVATE UNIX_BUILD)
else()
  target_compile_definitions(${TARGET_NAME} PRIVATE _WIN32_WINNT=0x0A00)
endif ()


#----------------------------------------------------------------------------
# install

install(TARGETS mscl EXPORT msclConfig
    ARCHIVE  DESTINATION lib
    LIBRARY  DESTINATION lib
    RUNTIME  DESTINATION bin 
)

install(FILES ${mscl_HEADER_FILES} DESTINATION include/mscl)

install(FILES ${mscl_Communication_HEADER_FILES} DESTINATION include/mscl/Communication)

install(FILES ${mscl_MicroStrain_HEADER_FILES} DESTINATION include/mscl/MicroStrain)

install(FILES ${mscl_MicroStrain_Displacement_HEADER_FILES} DESTINATION include/mscl/MicroStrain/Displacement)
install(FILES ${mscl_MicroStrain_Displacement_Commands_HEADER_FILES} DESTINATION include/mscl/MicroStrain/Displacement/Commands)

install(FILES ${mscl_MicroStrain_Inertial_HEADER_FILES} DESTINATION include/mscl/MicroStrain/Inertial)
install(FILES ${mscl_MicroStrain_Inertial_Commands_HEADER_FILES} DESTINATION include/mscl/MicroStrain/Inertial/Commands)
install(FILES ${mscl_MicroStrain_Inertial_Packets_HEADER_FILES} DESTINATION include/mscl/MicroStrain/Inertial/Packets)

install(FILES ${mscl_MicroStrain_MIP_HEADER_FILES} DESTINATION include/mscl/MicroStrain/MIP)
install(FILES ${mscl_MicroStrain_MIP_Commands_HEADER_FILES} DESTINATION include/mscl/MicroStrain/MIP/Commands)
install(FILES ${mscl_MicroStrain_MIP_Packet_HEADER_FILES} DESTINATION include/mscl/MicroStrain/MIP/Packets)

install(FILES ${mscl_MicroStrain_RTK_Commands_HEADER_FILES} DESTINATION include/mscl/MicroStrain/RTK/Commands)
install(FILES ${mscl_MicroStrain_RTK_HEADER_FILES} DESTINATION include/mscl/MicroStrain/RTK)

install(FILES ${mscl_MicroStrain_Wireless_HEADER_FILES} DESTINATION include/mscl/MicroStrain/Wireless)
install(FILES ${mscl_MicroStrain_Wireless_Commands_HEADER_FILES} DESTINATION include/mscl/MicroStrain/Wireless/Commands)
install(FILES ${mscl_MicroStrain_Wireless_Configuration_HEADER_FILES} DESTINATION include/mscl/MicroStrain/Wireless/Configuration)
install(FILES ${mscl_MicroStrain_Wireless_Features_HEADER_FILES} DESTINATION include/mscl/MicroStrain/Wireless/Features)
install(FILES ${mscl_MicroStrain_Wireless_Packets_HEADER_FILES} DESTINATION include/mscl/MicroStrain/Wireless/Packets)

install(EXPORT msclConfig DESTINATION share/mscl NAMESPACE Mscl::)

export(TARGETS mscl FILE msclConfig.cmake)


#----------------------------------------------------------------------------
# Setup pch

