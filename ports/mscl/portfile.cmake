
include(vcpkg_common_functions)

set(VCPKG_LIBRARY_LINKAGE static)

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO LORD-MicroStrain/MSCL
  REF v61.0.16
  SHA512 4d3767039707952bf71526629b3b954c6703b4564173fa67141e7b1e9ee86247b5a3a812dac3ab2cc8b9d35b6a828e93e260785f04f77db45b6f278a86b283ce
  HEAD_REF master
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
      -DMSCL_DISABLE_WEBSOCKETS=ON
      -DMSCL_DISABLE_SSL=ON
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()

vcpkg_fixup_cmake_targets()

# remove debug/include
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# remove debug/share
#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

# Handle copyright
file(COPY ${SOURCE_PATH}/License_Boost.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/mscl)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/mscl/License_Boost.txt ${CURRENT_PACKAGES_DIR}/share/mscl/copyright)
