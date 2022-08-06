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
	cppdialect "C++14"
	exceptionhandling "Off"
	rtti "Off"
	defines "__STDC_FORMAT_MACROS"

	files
	{
		"../bx/include",
		"src/*.cpp",
		"src/*.h"
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
		"3rdparty/khronos"
	}
	filter "configurations:Release"
		defines "BX_CONFIG_DEBUG=0"
	filter "configurations:Debug"
		defines "BX_CONFIG_DEBUG=1"
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