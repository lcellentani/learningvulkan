AddCompilerFlags(00-hellotriangle)

#SetupSample(00-hellotriangle)

add_executable(00-hellotriangle
    main.cpp
)

Enable_Cpp17(00-hellotriangle)
SetLinkerSubsystem(00-hellotriangle)

set_target_properties(00-hellotriangle
    PROPERTIES
        VS_DEBUGGER_WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}/media"
)

