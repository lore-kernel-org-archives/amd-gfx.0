From: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Subject: Re: Initial release of AMD Open Source Driver for Vulkan
Date: Fri, 22 Dec 2017 13:48:55 +0000
Message-ID: <CAHbf0-FG9RvkNj_S0yaGfChojL36boWbZU2q7meJjUg2t+ueUw@mail.gmail.com>
References: <BN6PR1201MB012970C5E9B13A10B77FD103EE020@BN6PR1201MB0129.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1068790689=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR1201MB012970C5E9B13A10B77FD103EE020-6iU6OBHu2P8DDbfZyiqacGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Mao, David" <David.Mao-5C7GfCeVMHo@public.gmane.org>
Cc: "mesa-dev-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <mesa-dev-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1068790689==
Content-Type: multipart/alternative; boundary="94eb2c05acc08a56600560ee14f8"

--94eb2c05acc08a56600560ee14f8
Content-Type: text/plain; charset="UTF-8"

Congratulations on getting this out the door

It didn't compile for me without these changes:

In pal:

diff --git a/src/util/math.cpp b/src/util/math.cpp
index 46e9ede..3af4259 100644
--- a/src/util/math.cpp
+++ b/src/util/math.cpp
@@ -54,7 +54,7 @@ static uint32 Float32ToFloatN(float f, const
NBitFloatInfo& info);
 static float FloatNToFloat32(uint32 fBits, const NBitFloatInfo& info);

 // Initialize the descriptors for various N-bit floating point
representations:
-static constexpr NBitFloatInfo Float16Info =
+static NBitFloatInfo Float16Info =
 {
     16,                                                       // numBits
     10,                                                       //
numFracBits
@@ -72,7 +72,7 @@ static constexpr NBitFloatInfo Float16Info =
     (23 - 10),                                                //
fracBitsDiff
 };

-static constexpr NBitFloatInfo Float11Info =
+static NBitFloatInfo Float11Info =
 {
     11,                                                       // numBits
     6,                                                        //
numFracBits
@@ -90,7 +90,7 @@ static constexpr NBitFloatInfo Float11Info =
     23 - 6,                                                   //
fracBitsDiff
 };

-static constexpr NBitFloatInfo Float10Info =
+static NBitFloatInfo Float10Info =
 {
     10,                                                       // numBits
     5,                                                        //
numFracBits

In xgl:

diff --git a/icd/CMakeLists.txt b/icd/CMakeLists.txt
index 4e4d669..5006184 100644
--- a/icd/CMakeLists.txt
+++ b/icd/CMakeLists.txt
@@ -503,16 +503,16 @@ if (UNIX)

     target_link_libraries(xgl PRIVATE c stdc++ ${CMAKE_DL_LIBS} pthread)

-    if(NOT ICD_USE_GCC)
-        message(WARNING "Intel ICC untested in CMake.")
-        target_link_libraries(xgl PRIVATE -fabi-version=0 -static-intel)
-    endif()
+    #if(NOT ICD_USE_GCC)
+    #    message(WARNING "Intel ICC untested in CMake.")
+    #    target_link_libraries(xgl PRIVATE -fabi-version=0 -static-intel)
+    #endif()

     if(CMAKE_BUILD_TYPE_RELEASE)
         if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
             execute_process(COMMAND ${CMAKE_C_COMPILER} -dumpversion
OUTPUT_VARIABLE GCC_VERSION)
             if (GCC_VERSION VERSION_GREATER 5.3 OR GCC_VERSION
VERSION_EQUAL 5.3)
-                target_link_libraries(xgl PRIVATE -flto=4
-fuse-linker-plugin -Wno-odr)
+                target_link_libraries(xgl PRIVATE -Wno-odr)
                 message(WARNING "LTO enabled for Linking")
             endif()
         endif()
@@ -530,17 +530,17 @@ if (UNIX)

     # CMAKE-TODO: What is whole-archive used for?
     #target_link_libraries(xgl -Wl,--whole-archive ${ICD_LIBS}
-Wl,--no-whole-archive)
-    if(CMAKE_BUILD_TYPE_RELEASE)
-        execute_process(COMMAND ${CMAKE_C_COMPILER} -dumpversion
OUTPUT_VARIABLE GCC_VERSION)
-        if (GCC_VERSION VERSION_GREATER 5.3 OR GCC_VERSION VERSION_EQUAL
5.3)
-            target_link_libraries(xgl PRIVATE -Wl,--whole-archive
${PROJECT_BINARY_DIR}/pal/src/libpal.a -Wl,--no-whole-archive)
-            target_link_libraries(xgl PUBLIC -Wl,--whole-archive
${PROJECT_BINARY_DIR}/pal/metrohash/libmetrohash.a -Wl,--no-whole-archive)
-            target_link_libraries(xgl PUBLIC -Wl,--whole-archive
${PROJECT_BINARY_DIR}/pal/gpuopen/libgpuopen.a -Wl,--no-whole-archive)
-            target_link_libraries(xgl PUBLIC -Wl,--whole-archive
${PROJECT_BINARY_DIR}/pal/vam/libvam.a -Wl,--no-whole-archive)
-            target_link_libraries(xgl PUBLIC -Wl,--whole-archive
${PROJECT_BINARY_DIR}/pal/addrlib/libaddrlib.a -Wl,--no-whole-archive)
-            target_link_libraries(xgl PUBLIC -Wl,--whole-archive
${PROJECT_BINARY_DIR}/pal/jemalloc/libjemalloc.a -Wl,--no-whole-archive)
-        endif()
-    endif()
+    #if(CMAKE_BUILD_TYPE_RELEASE)
+    #    execute_process(COMMAND ${CMAKE_C_COMPILER} -dumpversion
OUTPUT_VARIABLE GCC_VERSION)
+    #    if (GCC_VERSION VERSION_GREATER 5.3 OR GCC_VERSION VERSION_EQUAL
5.3)
+    #        target_link_libraries(xgl PRIVATE -Wl,--whole-archive
${PROJECT_BINARY_DIR}/pal/src/libpal.a -Wl,--no-whole-archive)
+    #        target_link_libraries(xgl PUBLIC -Wl,--whole-archive
${PROJECT_BINARY_DIR}/pal/metrohash/libmetrohash.a -Wl,--no-whole-archive)
+    #        target_link_libraries(xgl PUBLIC -Wl,--whole-archive
${PROJECT_BINARY_DIR}/pal/gpuopen/libgpuopen.a -Wl,--no-whole-archive)
+    #        target_link_libraries(xgl PUBLIC -Wl,--whole-archive
${PROJECT_BINARY_DIR}/pal/vam/libvam.a -Wl,--no-whole-archive)
+    #        target_link_libraries(xgl PUBLIC -Wl,--whole-archive
${PROJECT_BINARY_DIR}/pal/addrlib/libaddrlib.a -Wl,--no-whole-archive)
+    #        target_link_libraries(xgl PUBLIC -Wl,--whole-archive
${PROJECT_BINARY_DIR}/pal/jemalloc/libjemalloc.a -Wl,--no-whole-archive)
+    #    endif()
+    #endif()

     #${ICD_TARGET}.so${SO_VERSION_NUMBER} : ${filter-out -Wl%,$(LLLIBS})


diff --git a/icd/api/llpc/util/llpcDebug.cpp
b/icd/api/llpc/util/llpcDebug.cpp
index 1273cd6..847786e 100644
--- a/icd/api/llpc/util/llpcDebug.cpp
+++ b/icd/api/llpc/util/llpcDebug.cpp
@@ -113,7 +113,7 @@ bool EnableErrs()
 // Translates enum "ResourceMappingNodeType" to string and output to
ostream.
 raw_ostream& operator<<(
     raw_ostream&                       out,   // [out] Output stream
-    enum class ResourceMappingNodeType type)  // Resource map node type
+    enum ResourceMappingNodeType type)  // Resource map node type
 {
     const char* pString = nullptr;
     switch (type)

--94eb2c05acc08a56600560ee14f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Congratulations on getting this out the door<div><br></div=
><div>It didn&#39;t compile for me without these changes:</div><div><br></d=
iv><div>In pal:</div><div><br></div><div><div>diff --git a/src/util/math.cp=
p b/src/util/math.cpp</div><div>index 46e9ede..3af4259 100644</div><div>---=
 a/src/util/math.cpp</div><div>+++ b/src/util/math.cpp</div><div>@@ -54,7 +=
54,7 @@ static uint32 Float32ToFloatN(float f, const NBitFloatInfo&amp; inf=
o);</div><div>=C2=A0static float FloatNToFloat32(uint32 fBits, const NBitFl=
oatInfo&amp; info);</div><div><br></div><div>=C2=A0// Initialize the descri=
ptors for various N-bit floating point representations:</div><div>-static c=
onstexpr NBitFloatInfo Float16Info =3D</div><div>+static NBitFloatInfo Floa=
t16Info =3D</div><div>=C2=A0{</div><div>=C2=A0 =C2=A0 =C2=A016,=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// numBits</div><div>=C2=A0 =C2=A0 =
=C2=A010,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// numFracBits</div>=
<div>@@ -72,7 +72,7 @@ static constexpr NBitFloatInfo Float16Info =3D</div>=
<div>=C2=A0 =C2=A0 =C2=A0(23 - 10),=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // fracBitsDiff</di=
v><div>=C2=A0};</div><div><br></div><div>-static constexpr NBitFloatInfo Fl=
oat11Info =3D</div><div>+static NBitFloatInfo Float11Info =3D</div><div>=C2=
=A0{</div><div>=C2=A0 =C2=A0 =C2=A011,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0// numBits</div><div>=C2=A0 =C2=A0 =C2=A06,=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // numFracBits</div><div>@@ -90,7 +90,7 @@ =
static constexpr NBitFloatInfo Float11Info =3D</div><div>=C2=A0 =C2=A0 =C2=
=A023 - 6,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// fracBitsDiff</div><div>=C2=
=A0};</div><div><br></div><div>-static constexpr NBitFloatInfo Float10Info =
=3D</div><div>+static NBitFloatInfo Float10Info =3D</div><div>=C2=A0{</div>=
<div>=C2=A0 =C2=A0 =C2=A010,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0// numBits</div><div>=C2=A0 =C2=A0 =C2=A05,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 // numFracBits</div></div><div><br></div><div>In xgl:<=
/div><div><br></div><div><div>diff --git a/icd/CMakeLists.txt b/icd/CMakeLi=
sts.txt</div><div>index 4e4d669..5006184 100644</div><div>--- a/icd/CMakeLi=
sts.txt</div><div>+++ b/icd/CMakeLists.txt</div><div>@@ -503,16 +503,16 @@ =
if (UNIX)</div><div><br></div><div>=C2=A0 =C2=A0 =C2=A0target_link_librarie=
s(xgl PRIVATE c stdc++ ${CMAKE_DL_LIBS} pthread)</div><div><br></div><div>-=
=C2=A0 =C2=A0 if(NOT ICD_USE_GCC)</div><div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 me=
ssage(WARNING &quot;Intel ICC untested in CMake.&quot;)</div><div>-=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 target_link_libraries(xgl PRIVATE -fabi-version=3D0 -s=
tatic-intel)</div><div>-=C2=A0 =C2=A0 endif()</div><div>+=C2=A0 =C2=A0 #if(=
NOT ICD_USE_GCC)</div><div>+=C2=A0 =C2=A0 #=C2=A0 =C2=A0 message(WARNING &q=
uot;Intel ICC untested in CMake.&quot;)</div><div>+=C2=A0 =C2=A0 #=C2=A0 =
=C2=A0 target_link_libraries(xgl PRIVATE -fabi-version=3D0 -static-intel)</=
div><div>+=C2=A0 =C2=A0 #endif()</div><div><br></div><div>=C2=A0 =C2=A0 =C2=
=A0if(CMAKE_BUILD_TYPE_RELEASE)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if(&quot;${CMAKE_CXX_COMPILER_ID}&quot; STREQUAL &quot;GNU&quot;)</div><=
div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0execute_process(COMMAND=
 ${CMAKE_C_COMPILER} -dumpversion OUTPUT_VARIABLE GCC_VERSION)</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (GCC_VERSION VERSION_GRE=
ATER 5.3 OR GCC_VERSION VERSION_EQUAL 5.3)</div><div>-=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_link_libraries(xgl PRIVATE -flto=
=3D4=C2=A0 -fuse-linker-plugin -Wno-odr)</div><div>+=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_link_libraries(xgl PRIVATE -Wno-o=
dr)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0message(WARNING &quot;LTO enabled for Linking&quot;)</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0endif()</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0endif()</div><div>@@ -530,17 +530,17 @@ if (UNIX)</div>=
<div><br></div><div>=C2=A0 =C2=A0 =C2=A0# CMAKE-TODO: What is whole-archive=
 used for?</div><div>=C2=A0 =C2=A0 =C2=A0#target_link_libraries(xgl -Wl,--w=
hole-archive ${ICD_LIBS} -Wl,--no-whole-archive)</div><div>-=C2=A0 =C2=A0 i=
f(CMAKE_BUILD_TYPE_RELEASE)</div><div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 execute_=
process(COMMAND ${CMAKE_C_COMPILER} -dumpversion OUTPUT_VARIABLE GCC_VERSIO=
N)</div><div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (GCC_VERSION VERSION_GREATER 5=
.3 OR GCC_VERSION VERSION_EQUAL 5.3)</div><div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 target_link_libraries(xgl PRIVATE -Wl,--whole-archive ${PROJ=
ECT_BINARY_DIR}/pal/src/libpal.a -Wl,--no-whole-archive)</div><div>-=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_link_libraries(xgl PUBLIC -Wl,--w=
hole-archive ${PROJECT_BINARY_DIR}/pal/metrohash/libmetrohash.a -Wl,--no-wh=
ole-archive)</div><div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_li=
nk_libraries(xgl PUBLIC -Wl,--whole-archive ${PROJECT_BINARY_DIR}/pal/gpuop=
en/libgpuopen.a -Wl,--no-whole-archive)</div><div>-=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 target_link_libraries(xgl PUBLIC -Wl,--whole-archive ${PR=
OJECT_BINARY_DIR}/pal/vam/libvam.a -Wl,--no-whole-archive)</div><div>-=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_link_libraries(xgl PUBLIC -Wl=
,--whole-archive ${PROJECT_BINARY_DIR}/pal/addrlib/libaddrlib.a -Wl,--no-wh=
ole-archive)</div><div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_li=
nk_libraries(xgl PUBLIC -Wl,--whole-archive ${PROJECT_BINARY_DIR}/pal/jemal=
loc/libjemalloc.a -Wl,--no-whole-archive)</div><div>-=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 endif()</div><div>-=C2=A0 =C2=A0 endif()</div><div>+=C2=A0 =C2=A0 #i=
f(CMAKE_BUILD_TYPE_RELEASE)</div><div>+=C2=A0 =C2=A0 #=C2=A0 =C2=A0 execute=
_process(COMMAND ${CMAKE_C_COMPILER} -dumpversion OUTPUT_VARIABLE GCC_VERSI=
ON)</div><div>+=C2=A0 =C2=A0 #=C2=A0 =C2=A0 if (GCC_VERSION VERSION_GREATER=
 5.3 OR GCC_VERSION VERSION_EQUAL 5.3)</div><div>+=C2=A0 =C2=A0 #=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 target_link_libraries(xgl PRIVATE -Wl,--whole-archive ${P=
ROJECT_BINARY_DIR}/pal/src/libpal.a -Wl,--no-whole-archive)</div><div>+=C2=
=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_link_libraries(xgl PUBLIC -W=
l,--whole-archive ${PROJECT_BINARY_DIR}/pal/metrohash/libmetrohash.a -Wl,--=
no-whole-archive)</div><div>+=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 tar=
get_link_libraries(xgl PUBLIC -Wl,--whole-archive ${PROJECT_BINARY_DIR}/pal=
/gpuopen/libgpuopen.a -Wl,--no-whole-archive)</div><div>+=C2=A0 =C2=A0 #=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 target_link_libraries(xgl PUBLIC -Wl,--whole-archi=
ve ${PROJECT_BINARY_DIR}/pal/vam/libvam.a -Wl,--no-whole-archive)</div><div=
>+=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_link_libraries(xgl PUBL=
IC -Wl,--whole-archive ${PROJECT_BINARY_DIR}/pal/addrlib/libaddrlib.a -Wl,-=
-no-whole-archive)</div><div>+=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 ta=
rget_link_libraries(xgl PUBLIC -Wl,--whole-archive ${PROJECT_BINARY_DIR}/pa=
l/jemalloc/libjemalloc.a -Wl,--no-whole-archive)</div><div>+=C2=A0 =C2=A0 #=
=C2=A0 =C2=A0 endif()</div><div>+=C2=A0 =C2=A0 #endif()</div><div><br></div=
><div>=C2=A0 =C2=A0 =C2=A0#${ICD_TARGET}.so${SO_VERSION_NUMBER} : ${filter-=
out -Wl%,$(LLLIBS})</div><div><div><br></div><div><br></div><div>diff --git=
 a/icd/api/llpc/util/llpcDebug.cpp b/icd/api/llpc/util/llpcDebug.cpp</div><=
div>index 1273cd6..847786e 100644</div><div>--- a/icd/api/llpc/util/llpcDeb=
ug.cpp</div><div>+++ b/icd/api/llpc/util/llpcDebug.cpp</div><div>@@ -113,7 =
+113,7 @@ bool EnableErrs()</div><div>=C2=A0// Translates enum &quot;Resour=
ceMappingNodeType&quot; to string and output to ostream.</div><div>=C2=A0ra=
w_ostream&amp; operator&lt;&lt;(</div><div>=C2=A0 =C2=A0 =C2=A0raw_ostream&=
amp;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0out,=C2=A0 =C2=A0// [out] Output stream</div><div>-=C2=A0 =C2=
=A0 enum class ResourceMappingNodeType type)=C2=A0 // Resource map node typ=
e</div><div>+=C2=A0 =C2=A0 enum ResourceMappingNodeType type)=C2=A0 // Reso=
urce map node type</div><div>=C2=A0{</div><div>=C2=A0 =C2=A0 =C2=A0const ch=
ar* pString =3D nullptr;</div><div>=C2=A0 =C2=A0 =C2=A0switch (type)</div><=
/div></div><div><br></div><div><br></div></div>

--94eb2c05acc08a56600560ee14f8--

--===============1068790689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1068790689==--
