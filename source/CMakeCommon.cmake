function(Enable_Cpp11 target)
	if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
		MESSAGE("!Compiler " ${CMAKE_CXX_COMPILER_ID})
		set_property(TARGET ${target} PROPERTY CXX_STANDARD 11)
		set_property(TARGET ${target} PROPERTY CXX_STANDARD_REQUIRED ON)
	else()
    	set(CMAKE_CXX_STANDARD 11)
    	set(CMAKE_CXX_STANDARD_REQUIRED ON)
    	set(CMAKE_CXX_EXTENSIONS OFF)
	endif()
endfunction(Enable_Cpp11)

function(Enable_Cpp17 target)
	if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
		set_property(TARGET ${target} PROPERTY CXX_STANDARD 17)
		set_property(TARGET ${target} PROPERTY CXX_STANDARD_REQUIRED ON)
	else()
    	set(CMAKE_CXX_STANDARD 17)
    	set(CMAKE_CXX_STANDARD_REQUIRED ON)
    	set(CMAKE_CXX_EXTENSIONS OFF)
	endif()
endfunction(Enable_Cpp17)

function(AddCompilerFlags target)
	if(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    	add_compile_options(-Wall -Wmaybe-uninitialized -Wuninitialized -Wunused -Wunused-local-typedefs -Wunused-parameter -Wunused-value  -Wunused-variable -Wunused-but-set-parameter -Wunused-but-set-variable -fno-exceptions)
    	add_compile_options(-Wno-reorder)  # disable this from -Wall, since it happens all over.
	elseif(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    	add_compile_options(-Wall -Wuninitialized -Wunused -Wunused-local-typedefs -Wunused-parameter -Wunused-value  -Wunused-variable)
    	add_compile_options(-Wno-reorder)  # disable this from -Wall, since it happens all over.
	elseif(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
		add_compile_options(/W4 /WX) # treat warnings as errors
		add_compile_options(/w34456) # warn about nested declarations
		add_compile_options(/w34701) # warn about potentially uninitialized variables
		add_compile_options(/w34703) # warn about potentially uninitialized variables
		add_compile_options(/w34057) # warn about different indirection types.
		add_compile_options(/w34245) # warn about signed/unsigned mismatch.
		add_compile_options(/wd4503) # truncated symbol
		add_compile_options(/wd4702) # unreachable code
		add_compile_options(/wd4091) # typedef ignored on left when no variable is declared
		add_compile_options(/wd4201)
		add_compile_options(/wd4324)
		add_compile_options("/GR-") # disable RTTI
		add_compile_options("/arch:SSE2")

		add_definitions(-D_CRT_SECURE_NO_WARNINGS)
		add_definitions(-D_CRT_NONSTDC_NO_DEPRECATE)
		add_definitions(-D_CRT_SECURE_NO_DEPRECATE)
		add_definitions(-D_SCL_SECURE_NO_DEPRECATE)
		if (MSVC14)
			add_definitions(-D_ITERATOR_DEBUG_LEVEL=0)
		else()
			add_definitions(-D_HAS_ITERATOR_DEBUGGING=0)
		endif()
	endif()

	SET(CMAKE_CXX_FLAGS "/EHa- /EHc- /EHs-")
	add_definitions(-D_HAS_EXCEPTIONS=0)
	add_compile_options(/fp:except-)
endfunction(AddCompilerFlags)

function(SetLinkerSubsystem target)
	if(WIN32) # Check if we are on Windows
		if(MSVC) # Check if we are using the Visual Studio compiler
			set_target_properties(${target} PROPERTIES LINK_FLAGS "/SUBSYSTEM:WINDOWS /ENTRY:\"mainCRTStartup\" /NODEFAULTLIB:\"msvcrt\"")
		elseif(CMAKE_COMPILER_IS_GNUCXX)
			# SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mwindows") # Not tested
		else()
			message(SEND_ERROR "You are using an unsupported Windows compiler! (Not MSVC or GCC)")
		endif()
	elseif(UNIX)
		# Nothing special required
	else()
		message(SEND_ERROR "You are on an unsupported platform! (Not Win32 or Unix)")
	endif()
endfunction(SetLinkerSubsystem)

function(SetupSample target)
target_include_directories(${target}
	PUBLIC
		"${PROJECT_SOURCE_DIR}/source/common"
)
target_link_libraries(${target}
	common
	opengl32.lib
	glfw3.lib
)
endfunction(SetupSample)