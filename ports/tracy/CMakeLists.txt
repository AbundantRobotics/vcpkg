cmake_minimum_required(VERSION 3.8)
project(tracy CXX C)

set ( SOURCE_FILES 
  TracyClient.cpp
)

set ( HEADER_FILES 
  Tracy.hpp
  TracyC.h
)

set ( INSTALL_FILES 
)

FILE(GLOB INSTALL_COMMON_FILES common/*)
FILE(GLOB INSTALL_CLIENT_FILES client/*)


add_library ( ${PROJECT_NAME} STATIC
  ${SOURCE_FILES} 
  ${HEADER_FILES}
)

target_compile_definitions ( ${PROJECT_NAME} 
  PRIVATE TRACY_ENABLE
  PUBLIC TRACY_ON_DEMAND
  PUBLIC TRACY_NO_BROADCAST
)

if (WIN32)
  target_compile_definitions ( ${PROJECT_NAME} 
    PUBLIC WIN32_LEAN_AND_MEAN
    PRIVATE _CRT_SECURE_NO_WARNINGS
  )
endif ()

target_include_directories ( ${PROJECT_NAME} PUBLIC
  $<BUILD_INTERFACE:${TRACY_DIR}>
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

install ( TARGETS ${PROJECT_NAME}
  EXPORT TRACYExport
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
)

install ( EXPORT TRACYExport FILE ${PROJECT_NAME}Config.cmake NAMESPACE ${PROJECT_NAME}:: DESTINATION share/${PROJECT_NAME} )

if ( NOT TRACY_SKIP_HEADERS)
  install (
    FILES ${HEADER_FILES} ${SOURCE_FILES}
    DESTINATION include/tracy
  )

  install (
    FILES ${INSTALL_COMMON_FILES} 
    DESTINATION include/tracy/common
  )
  install (
    FILES ${INSTALL_CLIENT_FILES} 
    DESTINATION include/tracy/client
  )
endif ( )



set ( TARGET_NAME tracy-profiler )

set ( 
  SOURCE_FILES 
  common/TracySocket.cpp
  common/TracySystem.cpp
  common/tracy_lz4.cpp
  common/tracy_lz4hc.cpp
  imgui/imgui.cpp
  imgui/imgui_demo.cpp
  imgui/imgui_draw.cpp
  imgui/imgui_tables.cpp
  imgui/imgui_widgets.cpp
  nfd/nfd_common.c
  server/TracyBadVersion.cpp
  server/TracyColor.cpp
  server/TracyFilesystem.cpp
  server/TracyMemory.cpp
  server/TracyMicroArchitecture.cpp
  server/TracyMmap.cpp
  server/TracyMouse.cpp
  server/TracyPrint.cpp
  server/TracySourceView.cpp
  server/TracyStackFrames.cpp
  server/TracyStorage.cpp
  server/TracyTaskDispatch.cpp
  server/TracyTexture.cpp
  server/TracyTextureCompression.cpp
  server/TracyThreadCompress.cpp
  server/TracyUserData.cpp
  server/TracyView.cpp
  server/TracyWorker.cpp
  zstd/debug.c
  zstd/entropy_common.c
  zstd/error_private.c
  zstd/fse_compress.c
  zstd/fse_decompress.c
  zstd/hist.c
  zstd/huf_compress.c
  zstd/huf_decompress.c
  zstd/pool.c
  zstd/threading.c
  zstd/xxhash.c
  zstd/zstdmt_compress.c
  zstd/zstd_common.c
  zstd/zstd_compress.c
  zstd/zstd_compress_literals.c
  zstd/zstd_compress_sequences.c
  zstd/zstd_compress_superblock.c
  zstd/zstd_ddict.c
  zstd/zstd_decompress.c
  zstd/zstd_decompress_block.c
  zstd/zstd_double_fast.c
  zstd/zstd_fast.c
  zstd/zstd_lazy.c
  zstd/zstd_ldm.c
  zstd/zstd_opt.c
  # profiler/libs/gl3w/GL/gl3w.c
  profiler/src/HttpRequest.cpp
  profiler/src/imgui_freetype.cpp
  profiler/src/imgui_impl_glfw.cpp
  profiler/src/imgui_impl_opengl3.cpp
  profiler/src/main.cpp
  profiler/src/NativeWindow.cpp
  profiler/src/ResolvService.cpp

  common/TracyAlign.hpp
  common/TracyForceInline.hpp
  common/TracyMutex.hpp
  common/TracyProtocol.hpp
  common/TracyQueue.hpp
  common/TracySocket.hpp
  common/TracySystem.hpp
  common/tracy_lz4.hpp
  common/tracy_lz4hc.hpp
  imgui/imconfig.h
  imgui/imgui.h
  imgui/imgui_internal.h
  imgui/imstb_rectpack.h
  imgui/imstb_textedit.h
  imgui/imstb_truetype.h
  nfd/common.h
  nfd/nfd.h
  nfd/nfd_common.h
  server/IconsFontAwesome5.h
  server/TracyBadVersion.hpp
  server/TracyBuzzAnim.hpp
  server/TracyCharUtil.hpp
  server/TracyColor.hpp
  server/TracyDecayValue.hpp
  server/TracyEvent.hpp
  server/TracyFileHeader.hpp
  server/TracyFileRead.hpp
  server/TracyFilesystem.hpp
  server/TracyFileWrite.hpp
  server/TracyImGui.hpp
  server/TracyMemory.hpp
  server/TracyMicroArchitecture.hpp
  server/TracyMmap.hpp
  server/TracyPopcnt.hpp
  server/TracyPrint.hpp
  server/TracyShortPtr.hpp
  server/TracySlab.hpp
  server/TracySort.hpp
  server/TracySourceView.hpp
  server/TracyStorage.hpp
  server/TracyStringDiscovery.hpp
  server/TracyTaskDispatch.hpp
  server/TracyTexture.hpp
  server/TracyTextureCompression.hpp
  server/TracyThreadCompress.hpp
  server/TracyUserData.hpp
  server/TracyVarArray.hpp
  server/TracyVector.hpp
  server/TracyVersion.hpp
  server/TracyView.hpp
  server/TracyViewData.hpp
  server/TracyWorker.hpp
  server/TracyYield.hpp
  server/tracy_pdqsort.h
  server/tracy_robin_hood.h
  server/tracy_xxh3.h
  zstd/bitstream.h
  zstd/compiler.h
  zstd/cpu.h
  zstd/debug.h
  zstd/error_private.h
  zstd/fse.h
  zstd/hist.h
  zstd/huf.h
  zstd/mem.h
  zstd/pool.h
  zstd/threading.h
  zstd/xxhash.h
  zstd/zstd.h
  zstd/zstdmt_compress.h
  zstd/zstd_compress_internal.h
  zstd/zstd_compress_literals.h
  zstd/zstd_compress_sequences.h
  zstd/zstd_compress_superblock.h
  zstd/zstd_cwksp.h
  zstd/zstd_ddict.h
  zstd/zstd_decompress_block.h
  zstd/zstd_decompress_internal.h
  zstd/zstd_double_fast.h
  zstd/zstd_errors.h
  zstd/zstd_fast.h
  zstd/zstd_internal.h
  zstd/zstd_lazy.h
  zstd/zstd_ldm.h
  zstd/zstd_opt.h
  # profiler/libs/gl3w/GL/gl3w.h
  # profiler/libs/gl3w/GL/glcorearb.h
  profiler/src/Arimo.hpp
  profiler/src/Cousine.hpp
  profiler/src/FontAwesomeSolid.hpp
  profiler/src/icon.hpp
  profiler/src/imgui_freetype.h
  profiler/src/imgui_impl_glfw.h
  profiler/src/imgui_impl_opengl3.h
  profiler/src/ResolvService.hpp
  profiler/src/stb_image.h
)

if (WIN32)
  set ( 
    SOURCE_FILES 
    ${SOURCE_FILES}
    nfd/nfd_win.cpp
    profiler/src/winmain.cpp
    profiler/src/winmainArchDiscovery.cpp
  )
else ()
  set ( 
    SOURCE_FILES 
    ${SOURCE_FILES}
    nfd/nfd_gtk.c
  )
endif ()

set (TRACY_OPTIONS_PUBLIC TRACY_ON_DEMAND TRACY_FILESELECTOR TRACY_EXTENDED_FONT)
if (WIN32)
  set (TRACY_OPTIONS_PRIVATE NOMINMAX _CRT_SECURE_NO_DEPRECATE _CRT_NONSTDC_NO_DEPRECATE WIN32_LEAN_AND_MEAN _USE_MATH_DEFINES IMGUI_IMPL_OPENGL_LOADER_GL3W)
else ()
  set (TRACY_OPTIONS_PRIVATE IMGUI_IMPL_OPENGL_LOADER_GL3W)
endif ()

if (WIN32)
  add_executable (${TARGET_NAME} WIN32 ${SOURCE_FILES})
else ()
  add_executable (${TARGET_NAME} ${SOURCE_FILES})
endif ()

#source_group(TREE  PREFIX "Source Files" FILES ${SOURCE_FILES})

target_compile_definitions(${TARGET_NAME} PUBLIC TRACY_ROOT_WINDOW)

set_target_properties(${TARGET_NAME} PROPERTIES OUTPUT_NAME Profiler)

target_include_directories(
  ${TARGET_NAME} PRIVATE server
  ${TARGET_NAME} PRIVATE imgui
#  ${TARGET_NAME} PRIVATE profiler/libs/gl3w
#  ${TARGET_NAME} PRIVATE profiler/libs/glfw/include
)
target_compile_features(${TARGET_NAME} PRIVATE cxx_std_17)
target_compile_options(${TARGET_NAME} PRIVATE $<$<CXX_COMPILER_ID:MSVC>:/arch:AVX2>)
#target_link_libraries(${TARGET_NAME} IconFontCppHeaders)
target_compile_definitions(${TARGET_NAME} PUBLIC ${TRACY_OPTIONS_PUBLIC} PRIVATE ${TRACY_OPTIONS_PRIVATE})
if (MSVC)
  target_compile_options(${TARGET_NAME} PRIVATE /permissive-)
endif ()

find_package(glfw3 CONFIG REQUIRED)
target_link_libraries(${TARGET_NAME} PRIVATE glfw)

find_package(Freetype REQUIRED)
target_link_libraries(${TARGET_NAME} PRIVATE Freetype::Freetype)

find_package(GLEW REQUIRED)
target_link_libraries(${TARGET_NAME} PRIVATE GLEW::GLEW)

find_package(gl3w CONFIG REQUIRED)
target_link_libraries(${TARGET_NAME} PRIVATE unofficial::gl3w::gl3w)

if (WIN32)
  target_link_libraries(${TARGET_NAME} PRIVATE ws2_32.lib opengl32.lib)
  target_link_libraries(${TARGET_NAME} PRIVATE debug E:/vcpkg/installed/x64-windows/debug/lib/capstone_dll.lib optimized E:/vcpkg/installed/x64-windows/lib/capstone_dll.lib)
else ()
  find_package(GTK2 REQUIRED gtk)

  if(GTK2_FOUND)
    include_directories(${GTK2_INCLUDE_DIRS})
    target_link_libraries(${TARGET_NAME} PRIVATE ${GTK2_LIBRARIES})
  endif()

  find_library(CAPSTONE_LIBRARY capstone)
  target_link_libraries(${TARGET_NAME} PRIVATE ${CAPSTONE_LIBRARY})
  target_link_libraries(${TARGET_NAME} PRIVATE pthread dl)
endif ()

find_package(TBB CONFIG REQUIRED)
target_link_libraries(${TARGET_NAME} PRIVATE TBB::tbb TBB::tbbmalloc)

install (TARGETS ${TARGET_NAME}
  LIBRARY DESTINATION ${DEST_LIBRARY_DIR}
  RUNTIME DESTINATION ${DEST_BIN_DIR}
  ARCHIVE DESTINATION ${DEST_ARCHIVE_DIR}
)
