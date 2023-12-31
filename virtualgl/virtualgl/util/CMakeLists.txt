add_library(vglutil STATIC GenericQ.cpp Log.cpp Mutex.cpp Thread.cpp bmp.c
	pf.c)
if(UNIX)
	target_link_libraries(vglutil pthread)
endif()
if(CMAKE_SYSTEM_NAME STREQUAL "SunOS")
	target_link_libraries(vglutil rt)
endif()

add_executable(bmptest bmptest.c md5.c md5hl.c)
target_link_libraries(bmptest vglutil)

add_executable(pftest pftest.c)
target_link_libraries(pftest vglutil)

if(EXISTS /dev/urandom)
	message(STATUS "Using /dev/urandom for random number generation")
	add_definitions(-DHAVE_DEVURANDOM)
endif()

add_library(vglsocket STATIC Socket.cpp)
target_link_libraries(vglsocket vglutil)
if(WIN32)
	target_link_libraries(vglsocket ws2_32.lib)
endif()
if(CMAKE_SYSTEM_NAME MATCHES "SunOS")
	target_link_libraries(vglsocket socket xnet)
endif()

add_executable(nettest nettest.cpp)
target_link_libraries(nettest vglsocket)
if(CMAKE_SYSTEM_NAME MATCHES "SunOS")
	target_link_libraries(nettest kstat)
endif()
install(TARGETS nettest DESTINATION ${CMAKE_INSTALL_BINDIR})

add_library(fbx STATIC fbx.c)
target_link_libraries(fbx vglutil)

add_executable(fbxtest fbxtest.cpp)
target_link_libraries(fbxtest fbx)

if(UNIX)
	target_link_libraries(fbx ${X11_X11_LIB} ${X11_Xext_LIB})
endif()

if(VGL_USEXV)
	add_library(fbxv STATIC fbxv.c)
	target_link_libraries(fbxv ${X11_Xv_LIB} ${X11_X11_LIB} ${X11_Xext_LIB})

	add_executable(fbxvtest fbxvtest.c)
	target_link_libraries(fbxvtest fbxv)
endif()

add_executable(threadtest threadtest.cpp)
target_link_libraries(threadtest vglutil)

if(UNIX)
	option(VGL_USEIFR "Add nVidia Inband Frame Readback support to glreadtest"
		FALSE)
	if(VGL_USEIFR)
		message(STATUS "Enabling nVidia Inband Frame Readback support in glreadtest")
		set(DEFAULT_IFR_INCLUDE_DIR /opt/nvgrid/inc)
		set(IFR_INCLUDE_DIR ${DEFAULT_IFR_INCLUDE_DIR} CACHE PATH
			"Path to nVidia Inband Frame Readback include files (default: ${DEFAULT_IFR_INCLUDE_DIR})")
		add_definitions(-DUSEIFR)
		message(STATUS "IFR_INCLUDE_DIR = ${IFR_INCLUDE_DIR}")
		include_directories(${IFR_INCLUDE_DIR})
		include_directories(${IFR_INCLUDE_DIR}/../samples/common)
		set(IFRLIB nvidia-ifr)
	endif()

	add_executable(glreadtest glreadtest.cpp)
	target_link_libraries(glreadtest ${OPENGL_gl_LIBRARY} ${OPENGL_glu_LIBRARY}
		${X11_X11_LIB} ${IFRLIB} vglutil)
	if(VGL_BUILDSERVER)
		install(TARGETS glreadtest DESTINATION ${CMAKE_INSTALL_BINDIR})
	endif()
endif()

if(WIN32)
	configure_file(utiltest-win.in ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/utiltest)
else()
	configure_file(utiltest.in ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/utiltest)
	execute_process(COMMAND chmod +x ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/utiltest)
endif()
