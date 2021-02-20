include(vcpkg_common_functions)

#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO wolfpld/tracy
    REF v0.7.6
    SHA512 0f4e143e5b845e6077b0b77c446dfdf80778c73f710544f1ed802778e93c4ab317a314fbe9ac635754782b1f6ec80140cd4af2347bc434e256f07b685942bfd6
    HEAD_REF master
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS_DEBUG
        -DTRACY_SKIP_HEADERS=ON
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()
vcpkg_fixup_cmake_targets()


set(TRACY_TOOL_PATH ${CURRENT_PACKAGES_DIR}/tools/${PORT})
file(MAKE_DIRECTORY ${TRACY_TOOL_PATH})

file(GLOB TRACY_TOOLS ${CURRENT_PACKAGES_DIR}/bin/*${VCPKG_TARGET_EXECUTABLE_SUFFIX})
file(COPY ${TRACY_TOOLS} DESTINATION ${TRACY_TOOL_PATH})
file(REMOVE_RECURSE ${TRACY_TOOLS})

file(GLOB TRACY_TOOLS_DBG ${CURRENT_PACKAGES_DIR}/debug/bin/*${VCPKG_TARGET_EXECUTABLE_SUFFIX})
file(REMOVE_RECURSE ${TRACY_TOOLS_DBG})

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin)

configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/tracy/copyright COPYONLY)
