@echo off
setlocal EnableDelayedExpansion
if [%1]==[] (
set BUILD_CONFIG=Debug
set TARGET_DIRECTORY=debug_arm64
) else (
set BUILD_CONFIG=%1
set TARGET_DIRECTORY=release_arm64
)

set ANDROID_BUILD_ABI=arm64-v8a
set ANDROID_SYSTEM_VERSION=18
set ANDROID_PLATFORM_VERSION=android-%ANDROID_SYSTEM_VERSION%
set ANDROID_NDK_PATH=C:\DevTools\android-ndk-r19c
set ANDROID_SDK_PATH=C:\DevTools\android-sdk
set CMAKE_TOOLCHAIN_PATH=%ANDROID_NDK_PATH%\build\cmake\android.toolchain.cmake
set CMAKE_PATH=%ANDROID_SDK_PATH%\cmake\3.10.2.4988404\bin\cmake.exe
set NINJA_PATH=%ANDROID_SDK_PATH%\cmake\3.10.2.4988404\bin\ninja.exe

if not exist "%TARGET_DIRECTORY%" (
mkdir %TARGET_DIRECTORY%
)

pushd %~dp0
cd %TARGET_DIRECTORY%
REM if error, please use: call %CMAKE_PATH%
call cmake ^
	-DANDROID_ABI=%ANDROID_BUILD_ABI%^
	-DANDROID_PLATFORM=%ANDROID_PLATFORM_VERSION%^
	-DCMAKE_BUILD_TYPE=%BUILD_CONFIG% ^
	-DCMAKE_TOOLCHAIN_FILE=%CMAKE_TOOLCHAIN_PATH%^
	-DCMAKE_MAKE_PROGRAM=%NINJA_PATH% ^
	-DCMAKE_EXPORT_COMPILE_COMMANDS=ON ^
	-DCMAKE_ANDROID_NDK=%ANDROID_NDK_PATH%^
	-DCMAKE_SYSTEM_NAME=Android^
	-DCMAKE_ANDROID_ARCH_ABI=%ANDROID_BUILD_ABI%^
	-DCMAKE_SYSTEM_VERSION=%ANDROID_SYSTEM_VERSION%^
	-DANDROID_STL=c++_static^
	-DANDROID_BUILD=1^
	-DTARGET_PLATFORM=arm64-v8a^
	-G Ninja ..
popd