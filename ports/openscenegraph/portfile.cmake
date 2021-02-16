# Common Ambient Variables:
#   VCPKG_ROOT_DIR = <C:\path\to\current\vcpkg>
#   TARGET_TRIPLET is the current triplet (x86-windows, etc)
#   PORT is the current port name (zlib, etc)
#   CURRENT_BUILDTREES_DIR = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR  = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#

include(vcpkg_common_functions)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/OpenSceneGraph-OpenSceneGraph-3.6.4)
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/openscenegraph/OpenSceneGraph/archive/OpenSceneGraph-3.6.4.zip"
    FILENAME "OpenSceneGraph-3.6.4.zip"
    SHA512 7bc72a0ca3c875f80449f617467e14fa5fef2598633a70b1fc0fc5c00c0c500f691fdfeb7e7e07b59dd3fcf3bdd5de2e8e24827c005571e051189c21d7401276
)
vcpkg_extract_source_archive(${ARCHIVE})

if(VCPKG_CRT_LINKAGE STREQUAL static)
    set(USE_DYNAMIC_RUNTIME OFF)
else()
    set(USE_DYNAMIC_RUNTIME ON)
endif()

SET(OPENGL_HEADER1 "#include <GL/gl.h>")

vcpkg_configure_cmake(
  SOURCE_PATH ${SOURCE_PATH}
 # PREFER_NINJA
  OPTIONS
    -DBUILD_OSG_APPLICATIONS=OFF
    -DBUILD_OSG_EXAMPLES=OFF
    -DBUILD_OSG_PLUGINS=OFF
    -DBUILD_OSG_DEPRECATED_SERIALIZERS=OFF
    -DBUILD_OSG_PLUGINS_BY_DEFAULT=OFF
    -DBUILD_OSG_PLUGIN_FREETYPE=ON
    -DBUILD_OSG_PLUGIN_OSG=ON
    -DBUILD_OSG_PLUGIN_STL=ON
    -DBUILD_OSG_PLUGIN_OBJ=ON
    -DDYNAMIC_OPENSCENEGRAPH=${USE_DYNAMIC_RUNTIME}
    -DDYNAMIC_OPENTHREADS=${USE_DYNAMIC_RUNTIME}

    -DOSG_GL1_AVAILABLE=OFF
    -DOSG_GL2_AVAILABLE=OFF
    -DOSG_GLES1_AVAILABLE=OFF
    -DOSG_GLES2_AVAILABLE=OFF
    -DOSG_GL_DISPLAYLISTS_AVAILABLE=OFF
    -DOSG_GL_FIXED_FUNCTION_AVAILABLE=OFF
    -DOSG_GL_MATRICES_AVAILABLE=OFF
    -DOSG_GL_VERTEX_ARRAY_FUNCS_AVAILABLE=OFF
    -DOSG_GL_VERTEX_FUNCS_AVAILABLE=OFF

    -DOSG_GL3_AVAILABLE=ON

    -DOPENGL_PROFILE=GLCORE

    -DGLCORE_INCLUDE_DIR=E:/Idun/Dependencies/opengl4

    -DMSVC_BUILD_USE_SOLUTION_FOLDERS=ON
    -DWIN32_USE_MP=ON

    -DOSG_USE_DEPRECATED_API=OFF

    -DOPENGL_HEADER1=${OPENGL_HEADER1}
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()

#vcpkg_fixup_cmake_targets()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

set(OSG_TOOL_PATH ${CURRENT_PACKAGES_DIR}/tools/osg)
file(MAKE_DIRECTORY ${OSG_TOOL_PATH})

file(GLOB OSG_PLUGINS_DBG ${CURRENT_PACKAGES_DIR}/debug/bin/osgPlugins-3.6.4/*.dll)
file(COPY ${OSG_PLUGINS_DBG} DESTINATION ${OSG_TOOL_PATH}/osgPlugins-3.6.4)
file(GLOB OSG_PLUGINS_REL ${CURRENT_PACKAGES_DIR}/bin/osgPlugins-3.6.4/*.dll)
file(COPY ${OSG_PLUGINS_REL} DESTINATION ${OSG_TOOL_PATH}/osgPlugins-3.6.4)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/osgPlugins-3.6.4/)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/osgPlugins-3.6.4/)

# Handle copyright
file(COPY ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/OpenSceneGraph)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/OpenSceneGraph/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/OpenSceneGraph/copyright)
