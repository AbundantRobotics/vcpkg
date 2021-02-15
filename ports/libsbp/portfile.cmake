# Common Ambient Variables:
#   VCPKG_ROOT_DIR = <C:\path\to\current\vcpkg>
#   TARGET_TRIPLET is the current triplet (x86-windows, etc)
#   PORT is the current port name (zlib, etc)
#   CURRENT_BUILDTREES_DIR = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR  = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#

include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO swift-nav/libsbp
    REF v3.4.5
    SHA512 0a671d4bab32152a7f13ce3f802628fa917c9155a4b773989478fb3a26ebd0a357fbd90f77c38077abe1340b14d858c719ca6a81c680f5f46c7789c64573f00b
    HEAD_REF master
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    #PREFER_NINJA # Disable this option if project cannot be built with Ninja
    OPTIONS_DEBUG -DINSTALL_INCLUDES=OFF
)

vcpkg_install_cmake()

# handle share cmake for debug build
file(COPY ${CURRENT_PACKAGES_DIR}/debug/share/libsbp/libsbpConfig-debug.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/libsbp)

file(READ ${CURRENT_PACKAGES_DIR}/debug/share/libsbp/libsbpConfig-debug.cmake LIBSBP_DEBUG)
string(REPLACE "\${_IMPORT_PREFIX}" "\${_IMPORT_PREFIX}/debug" LIBSBP_DEBUG "${LIBSBP_DEBUG}")
file(WRITE ${CURRENT_PACKAGES_DIR}/share/libsbp/libsbpConfig-debug.cmake "${LIBSBP_DEBUG}")

# remove debug/share
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

# Handle copyright
file(COPY ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libsbp)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/libsbp/LICENSE ${CURRENT_PACKAGES_DIR}/share/libsbp/copyright)

vcpkg_copy_pdbs()
