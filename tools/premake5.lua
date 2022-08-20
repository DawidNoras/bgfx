function setBxCompat()
	filter "action:vs*"
		includedirs { "../../bx/include/compat/msvc" }
	filter { "system:windows", "action:gmake" }
		includedirs { "../../bx/include/compat/mingw" }
	filter { "system:macosx" }
		includedirs { "../../bx/include/compat/osx" }
		buildoptions { "-x objective-c++" }
end

function toolsCommon()
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"
	exceptionhandling "Off"
	rtti "Off"
	defines "__STDC_FORMAT_MACROS"

	includedirs
	{
		"../../bx/include",
		"../../bimg/include",
		"../../bgfx/include",
		"../include",
		"../3rdparty",
		"../3rdparty/dxsdk/include",
		"../3rdparty/khronos",
		"../3rdparty/meshoptimizer/src/"
	}
	links 
	{
		"bx",
		"bimg",
		"bgfx",
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
	setBxCompat()
end

project "GeometryCompiler"
	location "geometryc"

	files
	{
		"geometryc/geometryc.cpp"
	}

	toolsCommon()

-- project "ShaderCompiler"
-- 	location "shaderc"
-- 
-- 	includedirs
-- 	{
-- 		"../../bgfx/3rdparty/fcpp",
-- 		"../../bgfx/3rdparty/glsl-optimizer/src/glsl",
-- 		"../../bgfx/3rdparty/glslang/glslang/Public",
-- 		"../../bgfx/3rdparty/glslang/glslang/Include",
-- 		"../../bgfx/3rdparty/glslang",
-- 		"../../bgfx/3rdparty/spirv-cross",
-- 		"../../bgfx/3rdparty/spirv-tools/include",
-- 		"../../bgfx/3rdparty/webgpu/include"
-- 	}
-- 
-- 	files
-- 	{
-- 		"shaderc/shaderc.h",
-- 		"shaderc/shaderc.cpp",
-- 		"shaderc/shaderc_glsl.cpp",
-- 		"shaderc/shaderc_hlsl.cpp",
-- 		"shaderc/shaderc_metal.cpp",
-- 		"shaderc/shaderc_pssl.cpp",
-- 		"shaderc/shaderc_spirv.cpp",
-- 	}
-- 
-- 	toolsCommon()
