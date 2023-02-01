function setBxCompat()
	filter "action:vs*"
		includedirs { "../bx/include/compat/msvc" }
	filter { "system:windows", "action:gmake" }
		includedirs { "../bx/include/compat/mingw" }
	filter { "system:macosx" }
		includedirs { "../bx/include/compat/osx" }
		buildoptions { "-x objective-c++" }
end

project "bgfx"
	kind "StaticLib"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"
	exceptionhandling "Off"
	rtti "Off"
	defines "__STDC_FORMAT_MACROS"
	_3rd_party_location_dir()
	set_output_dir()

	files
	{
		"include/bgfx/**.h",
		"src/**.cpp",
		"src/**.h",
		"3rdparty/meshoptimizer/src/**.cpp",
		"examples/common/debugdraw/debugdraw.cpp",
	}
	excludes
	{
		"src/amalgamated.cpp",
	}
	includedirs
	{
		"../bx/include",
		"../bimg/include",
		"include",
		"3rdparty",
		"3rdparty/dxsdk/include",
		"3rdparty/khronos",
		"3rdparty/meshoptimizer/src/",
		"examples/common/debugdraw",
	}
	links 
	{
		"bx",
		"bimg",
	}

	filter "configurations:Debug"
		defines "BX_CONFIG_DEBUG=1"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "BX_CONFIG_DEBUG=0"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "BX_CONFIG_DEBUG=0"
		runtime "Release"
		optimize "on"

	filter "action:vs*"
		defines "_CRT_SECURE_NO_WARNINGS"
		excludes
		{
			"src/glcontext_glx.cpp",
			"src/glcontext_egl.cpp"
		}
	filter "system:macosx"
		files
		{
			"src/*.mm",
		}
	setBxCompat()
