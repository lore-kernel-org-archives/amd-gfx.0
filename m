From: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Subject: Re: Initial release of AMD Open Source Driver for Vulkan
Date: Fri, 22 Dec 2017 16:15:09 +0000
Message-ID: <CAHbf0-F+HU080yyDkp-WPm1Nf5gMuDaY2J=prWzC_oJQ-XjTTQ@mail.gmail.com>
References: <BN6PR1201MB012970C5E9B13A10B77FD103EE020@BN6PR1201MB0129.namprd12.prod.outlook.com>
 <CAHbf0-FG9RvkNj_S0yaGfChojL36boWbZU2q7meJjUg2t+ueUw@mail.gmail.com>
 <1EA656B0-81C7-45DD-8B52-496E56C8EFAC@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0750516720=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1EA656B0-81C7-45DD-8B52-496E56C8EFAC-5C7GfCeVMHo@public.gmane.org>
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

--===============0750516720==
Content-Type: multipart/alternative; boundary="001a1143c8607def8f0560f01fad"

--001a1143c8607def8f0560f01fad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

No I'm not using ICC however that section prevents you using Clang, it
basically says if not GCC then assumes Intel's compiler

Cheers

Mike

On Fri, 22 Dec 2017, 3:04 pm Mao, David, <David.Mao-5C7GfCeVMHo@public.gmane.org> wrote:

> Hi Lothian,
> Thanks for testing out out driver!
> Officially we recommend you to stick to GCC5 for now, however, we do have
> a fix for the constexpr issue mentioned below that just didn=E2=80=99t ma=
ke it to
> this first release.
> According to your diff, are you using ICC?
> Could you let us know the compiler version as well as your distro?
>
> Thanks.
> Best Regards,
> David
>
>
> On Dec 22, 2017, at 9:48 PM, Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org> wrote:
>
> Congratulations on getting this out the door
>
> It didn't compile for me without these changes:
>
> In pal:
>
> diff --git a/src/util/math.cpp b/src/util/math.cpp
> index 46e9ede..3af4259 100644
> --- a/src/util/math.cpp
> +++ b/src/util/math.cpp
> @@ -54,7 +54,7 @@ static uint32 Float32ToFloatN(float f, const
> NBitFloatInfo& info);
>  static float FloatNToFloat32(uint32 fBits, const NBitFloatInfo& info);
>
>  // Initialize the descriptors for various N-bit floating point
> representations:
> -static constexpr NBitFloatInfo Float16Info =3D
> +static NBitFloatInfo Float16Info =3D
>  {
>      16,                                                       // numBits
>      10,                                                       //
> numFracBits
> @@ -72,7 +72,7 @@ static constexpr NBitFloatInfo Float16Info =3D
>      (23 - 10),                                                //
> fracBitsDiff
>  };
>
> -static constexpr NBitFloatInfo Float11Info =3D
> +static NBitFloatInfo Float11Info =3D
>  {
>      11,                                                       // numBits
>      6,                                                        //
> numFracBits
> @@ -90,7 +90,7 @@ static constexpr NBitFloatInfo Float11Info =3D
>      23 - 6,                                                   //
> fracBitsDiff
>  };
>
> -static constexpr NBitFloatInfo Float10Info =3D
> +static NBitFloatInfo Float10Info =3D
>  {
>      10,                                                       // numBits
>      5,                                                        //
> numFracBits
>
> In xgl:
>
> diff --git a/icd/CMakeLists.txt b/icd/CMakeLists.txt
> index 4e4d669..5006184 100644
> --- a/icd/CMakeLists.txt
> +++ b/icd/CMakeLists.txt
> @@ -503,16 +503,16 @@ if (UNIX)
>
>      target_link_libraries(xgl PRIVATE c stdc++ ${CMAKE_DL_LIBS} pthread)
>
> -    if(NOT ICD_USE_GCC)
> -        message(WARNING "Intel ICC untested in CMake.")
> -        target_link_libraries(xgl PRIVATE -fabi-version=3D0 -static-inte=
l)
> -    endif()
> +    #if(NOT ICD_USE_GCC)
> +    #    message(WARNING "Intel ICC untested in CMake.")
> +    #    target_link_libraries(xgl PRIVATE -fabi-version=3D0 -static-int=
el)
> +    #endif()
>
>      if(CMAKE_BUILD_TYPE_RELEASE)
>          if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
>              execute_process(COMMAND ${CMAKE_C_COMPILER} -dumpversion
> OUTPUT_VARIABLE GCC_VERSION)
>              if (GCC_VERSION VERSION_GREATER 5.3 OR GCC_VERSION
> VERSION_EQUAL 5.3)
> -                target_link_libraries(xgl PRIVATE -flto=3D4
> -fuse-linker-plugin -Wno-odr)
> +                target_link_libraries(xgl PRIVATE -Wno-odr)
>                  message(WARNING "LTO enabled for Linking")
>              endif()
>          endif()
> @@ -530,17 +530,17 @@ if (UNIX)
>
>      # CMAKE-TODO: What is whole-archive used for?
>      #target_link_libraries(xgl -Wl,--whole-archive ${ICD_LIBS}
> -Wl,--no-whole-archive)
> -    if(CMAKE_BUILD_TYPE_RELEASE)
> -        execute_process(COMMAND ${CMAKE_C_COMPILER} -dumpversion
> OUTPUT_VARIABLE GCC_VERSION)
> -        if (GCC_VERSION VERSION_GREATER 5.3 OR GCC_VERSION VERSION_EQUAL
> 5.3)
> -            target_link_libraries(xgl PRIVATE -Wl,--whole-archive
> ${PROJECT_BINARY_DIR}/pal/src/libpal.a -Wl,--no-whole-archive)
> -            target_link_libraries(xgl PUBLIC -Wl,--whole-archive
> ${PROJECT_BINARY_DIR}/pal/metrohash/libmetrohash.a -Wl,--no-whole-archive=
)
> -            target_link_libraries(xgl PUBLIC -Wl,--whole-archive
> ${PROJECT_BINARY_DIR}/pal/gpuopen/libgpuopen.a -Wl,--no-whole-archive)
> -            target_link_libraries(xgl PUBLIC -Wl,--whole-archive
> ${PROJECT_BINARY_DIR}/pal/vam/libvam.a -Wl,--no-whole-archive)
> -            target_link_libraries(xgl PUBLIC -Wl,--whole-archive
> ${PROJECT_BINARY_DIR}/pal/addrlib/libaddrlib.a -Wl,--no-whole-archive)
> -            target_link_libraries(xgl PUBLIC -Wl,--whole-archive
> ${PROJECT_BINARY_DIR}/pal/jemalloc/libjemalloc.a -Wl,--no-whole-archive)
> -        endif()
> -    endif()
> +    #if(CMAKE_BUILD_TYPE_RELEASE)
> +    #    execute_process(COMMAND ${CMAKE_C_COMPILER} -dumpversion
> OUTPUT_VARIABLE GCC_VERSION)
> +    #    if (GCC_VERSION VERSION_GREATER 5.3 OR GCC_VERSION VERSION_EQUA=
L
> 5.3)
> +    #        target_link_libraries(xgl PRIVATE -Wl,--whole-archive
> ${PROJECT_BINARY_DIR}/pal/src/libpal.a -Wl,--no-whole-archive)
> +    #        target_link_libraries(xgl PUBLIC -Wl,--whole-archive
> ${PROJECT_BINARY_DIR}/pal/metrohash/libmetrohash.a -Wl,--no-whole-archive=
)
> +    #        target_link_libraries(xgl PUBLIC -Wl,--whole-archive
> ${PROJECT_BINARY_DIR}/pal/gpuopen/libgpuopen.a -Wl,--no-whole-archive)
> +    #        target_link_libraries(xgl PUBLIC -Wl,--whole-archive
> ${PROJECT_BINARY_DIR}/pal/vam/libvam.a -Wl,--no-whole-archive)
> +    #        target_link_libraries(xgl PUBLIC -Wl,--whole-archive
> ${PROJECT_BINARY_DIR}/pal/addrlib/libaddrlib.a -Wl,--no-whole-archive)
> +    #        target_link_libraries(xgl PUBLIC -Wl,--whole-archive
> ${PROJECT_BINARY_DIR}/pal/jemalloc/libjemalloc.a -Wl,--no-whole-archive)
> +    #    endif()
> +    #endif()
>
>      #${ICD_TARGET}.so${SO_VERSION_NUMBER} : ${filter-out -Wl%,$(LLLIBS})
>
>
> diff --git a/icd/api/llpc/util/llpcDebug.cpp
> b/icd/api/llpc/util/llpcDebug.cpp
> index 1273cd6..847786e 100644
> --- a/icd/api/llpc/util/llpcDebug.cpp
> +++ b/icd/api/llpc/util/llpcDebug.cpp
> @@ -113,7 +113,7 @@ bool EnableErrs()
>  // Translates enum "ResourceMappingNodeType" to string and output to
> ostream.
>  raw_ostream& operator<<(
>      raw_ostream&                       out,   // [out] Output stream
> -    enum class ResourceMappingNodeType type)  // Resource map node type
> +    enum ResourceMappingNodeType type)  // Resource map node type
>  {
>      const char* pString =3D nullptr;
>      switch (type)
>
>
>
>

--001a1143c8607def8f0560f01fad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Hi</p>
<p dir=3D"ltr">No I&#39;m not using ICC however that section prevents you u=
sing Clang, it basically says if not GCC then assumes Intel&#39;s compiler<=
/p>
<p dir=3D"ltr">Cheers</p>
<p dir=3D"ltr">Mike</p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri, 22 Dec 2017, 3:04 p=
m Mao, David, &lt;<a href=3D"mailto:David.Mao-5C7GfCeVMHo@public.gmane.org">David.Mao-5C7GfCeVMHo@public.gmane.org</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">



<div style=3D"word-wrap:break-word;line-break:after-white-space">
Hi Lothian,
<div>Thanks for testing out out driver!</div>
<div><span style=3D"color:rgb(36,41,46);font-variant-ligatures:normal;backg=
round-color:rgb(255,255,255)">Officially we recommend you to stick to GCC5 =
for now, however, we do have a fix for the constexpr issue
 mentioned below that just didn=E2=80=99t make it to this first release.</s=
pan></div>
<div>According to your diff, are you using ICC?</div>
<div>Could you let us know the compiler version as well as your distro?</di=
v>
<div><br>
</div>
<div>Thanks.</div>
<div>Best Regards,</div>
<div>David</div></div><div style=3D"word-wrap:break-word;line-break:after-w=
hite-space"><div><br>
<div><br>
<blockquote type=3D"cite">
<div>On Dec 22, 2017, at 9:48 PM, Mike Lothian &lt;<a href=3D"mailto:mike@f=
ireburn.co.uk" target=3D"_blank">mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org</a>&gt; wrote:</div>
<br class=3D"m_-3388281588475979354Apple-interchange-newline">
<div>
<div dir=3D"ltr">Congratulations on getting this out the door
<div><br>
</div>
<div>It didn&#39;t compile for me without these changes:</div>
<div><br>
</div>
<div>In pal:</div>
<div><br>
</div>
<div>
<div>diff --git a/src/util/math.cpp b/src/util/math.cpp</div>
<div>index 46e9ede..3af4259 100644</div>
<div>--- a/src/util/math.cpp</div>
<div>+++ b/src/util/math.cpp</div>
<div>@@ -54,7 +54,7 @@ static uint32 Float32ToFloatN(float f, const NBitFlo=
atInfo&amp; info);</div>
<div>=C2=A0static float FloatNToFloat32(uint32 fBits, const NBitFloatInfo&a=
mp; info);</div>
<div><br>
</div>
<div>=C2=A0// Initialize the descriptors for various N-bit floating point r=
epresentations:</div>
<div>-static constexpr NBitFloatInfo Float16Info =3D</div>
<div>+static NBitFloatInfo Float16Info =3D</div>
<div>=C2=A0{</div>
<div>=C2=A0 =C2=A0 =C2=A016,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0// numBits</div>
<div>=C2=A0 =C2=A0 =C2=A010,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0// numFracBits</div>
<div>@@ -72,7 +72,7 @@ static constexpr NBitFloatInfo Float16Info =3D</div>
<div>=C2=A0 =C2=A0 =C2=A0(23 - 10),=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // fracBitsDiff</di=
v>
<div>=C2=A0};</div>
<div><br>
</div>
<div>-static constexpr NBitFloatInfo Float11Info =3D</div>
<div>+static NBitFloatInfo Float11Info =3D</div>
<div>=C2=A0{</div>
<div>=C2=A0 =C2=A0 =C2=A011,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0// numBits</div>
<div>=C2=A0 =C2=A0 =C2=A06,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /=
/ numFracBits</div>
<div>@@ -90,7 +90,7 @@ static constexpr NBitFloatInfo Float11Info =3D</div>
<div>=C2=A0 =C2=A0 =C2=A023 - 6,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// fracBi=
tsDiff</div>
<div>=C2=A0};</div>
<div><br>
</div>
<div>-static constexpr NBitFloatInfo Float10Info =3D</div>
<div>+static NBitFloatInfo Float10Info =3D</div>
<div>=C2=A0{</div>
<div>=C2=A0 =C2=A0 =C2=A010,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0// numBits</div>
<div>=C2=A0 =C2=A0 =C2=A05,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /=
/ numFracBits</div>
</div>
<div><br>
</div>
<div>In xgl:</div>
<div><br>
</div>
<div>
<div>diff --git a/icd/CMakeLists.txt b/icd/CMakeLists.txt</div>
<div>index 4e4d669..5006184 100644</div>
<div>--- a/icd/CMakeLists.txt</div>
<div>+++ b/icd/CMakeLists.txt</div>
<div>@@ -503,16 +503,16 @@ if (UNIX)</div>
<div><br>
</div>
<div>=C2=A0 =C2=A0 =C2=A0target_link_libraries(xgl PRIVATE c stdc++ ${CMAKE=
_DL_LIBS} pthread)</div>
<div><br>
</div>
<div>-=C2=A0 =C2=A0 if(NOT ICD_USE_GCC)</div>
<div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 message(WARNING &quot;Intel ICC untested =
in CMake.&quot;)</div>
<div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_link_libraries(xgl PRIVATE -fabi-v=
ersion=3D0 -static-intel)</div>
<div>-=C2=A0 =C2=A0 endif()</div>
<div>+=C2=A0 =C2=A0 #if(NOT ICD_USE_GCC)</div>
<div>+=C2=A0 =C2=A0 #=C2=A0 =C2=A0 message(WARNING &quot;Intel ICC untested=
 in CMake.&quot;)</div>
<div>+=C2=A0 =C2=A0 #=C2=A0 =C2=A0 target_link_libraries(xgl PRIVATE -fabi-=
version=3D0 -static-intel)</div>
<div>+=C2=A0 =C2=A0 #endif()</div>
<div><br>
</div>
<div>=C2=A0 =C2=A0 =C2=A0if(CMAKE_BUILD_TYPE_RELEASE)</div>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if(&quot;${CMAKE_CXX_COMPILER_ID}&qu=
ot; STREQUAL &quot;GNU&quot;)</div>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0execute_process(COMMAN=
D ${CMAKE_C_COMPILER} -dumpversion OUTPUT_VARIABLE GCC_VERSION)</div>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (GCC_VERSION VERSIO=
N_GREATER 5.3 OR GCC_VERSION VERSION_EQUAL 5.3)</div>
<div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_link_l=
ibraries(xgl PRIVATE -flto=3D4=C2=A0 -fuse-linker-plugin -Wno-odr)</div>
<div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_link_l=
ibraries(xgl PRIVATE -Wno-odr)</div>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0message(=
WARNING &quot;LTO enabled for Linking&quot;)</div>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0endif()</div>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0endif()</div>
<div>@@ -530,17 +530,17 @@ if (UNIX)</div>
<div><br>
</div>
<div>=C2=A0 =C2=A0 =C2=A0# CMAKE-TODO: What is whole-archive used for?</div=
>
<div>=C2=A0 =C2=A0 =C2=A0#target_link_libraries(xgl -Wl,--whole-archive ${I=
CD_LIBS} -Wl,--no-whole-archive)</div>
<div>-=C2=A0 =C2=A0 if(CMAKE_BUILD_TYPE_RELEASE)</div>
<div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 execute_process(COMMAND ${CMAKE_C_COMPILE=
R} -dumpversion OUTPUT_VARIABLE GCC_VERSION)</div>
<div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (GCC_VERSION VERSION_GREATER 5.3 OR GC=
C_VERSION VERSION_EQUAL 5.3)</div>
<div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_link_libraries(xgl P=
RIVATE -Wl,--whole-archive ${PROJECT_BINARY_DIR}/pal/src/libpal.a -Wl,--no-=
whole-archive)</div>
<div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_link_libraries(xgl P=
UBLIC -Wl,--whole-archive ${PROJECT_BINARY_DIR}/pal/metrohash/libmetrohash.=
a -Wl,--no-whole-archive)</div>
<div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_link_libraries(xgl P=
UBLIC -Wl,--whole-archive ${PROJECT_BINARY_DIR}/pal/gpuopen/libgpuopen.a -W=
l,--no-whole-archive)</div>
<div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_link_libraries(xgl P=
UBLIC -Wl,--whole-archive ${PROJECT_BINARY_DIR}/pal/vam/libvam.a -Wl,--no-w=
hole-archive)</div>
<div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_link_libraries(xgl P=
UBLIC -Wl,--whole-archive ${PROJECT_BINARY_DIR}/pal/addrlib/libaddrlib.a -W=
l,--no-whole-archive)</div>
<div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_link_libraries(xgl P=
UBLIC -Wl,--whole-archive ${PROJECT_BINARY_DIR}/pal/jemalloc/libjemalloc.a =
-Wl,--no-whole-archive)</div>
<div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 endif()</div>
<div>-=C2=A0 =C2=A0 endif()</div>
<div>+=C2=A0 =C2=A0 #if(CMAKE_BUILD_TYPE_RELEASE)</div>
<div>+=C2=A0 =C2=A0 #=C2=A0 =C2=A0 execute_process(COMMAND ${CMAKE_C_COMPIL=
ER} -dumpversion OUTPUT_VARIABLE GCC_VERSION)</div>
<div>+=C2=A0 =C2=A0 #=C2=A0 =C2=A0 if (GCC_VERSION VERSION_GREATER 5.3 OR G=
CC_VERSION VERSION_EQUAL 5.3)</div>
<div>+=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_link_libraries(xgl =
PRIVATE -Wl,--whole-archive ${PROJECT_BINARY_DIR}/pal/src/libpal.a -Wl,--no=
-whole-archive)</div>
<div>+=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_link_libraries(xgl =
PUBLIC -Wl,--whole-archive ${PROJECT_BINARY_DIR}/pal/metrohash/libmetrohash=
.a -Wl,--no-whole-archive)</div>
<div>+=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_link_libraries(xgl =
PUBLIC -Wl,--whole-archive ${PROJECT_BINARY_DIR}/pal/gpuopen/libgpuopen.a -=
Wl,--no-whole-archive)</div>
<div>+=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_link_libraries(xgl =
PUBLIC -Wl,--whole-archive ${PROJECT_BINARY_DIR}/pal/vam/libvam.a -Wl,--no-=
whole-archive)</div>
<div>+=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_link_libraries(xgl =
PUBLIC -Wl,--whole-archive ${PROJECT_BINARY_DIR}/pal/addrlib/libaddrlib.a -=
Wl,--no-whole-archive)</div>
<div>+=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_link_libraries(xgl =
PUBLIC -Wl,--whole-archive ${PROJECT_BINARY_DIR}/pal/jemalloc/libjemalloc.a=
 -Wl,--no-whole-archive)</div>
<div>+=C2=A0 =C2=A0 #=C2=A0 =C2=A0 endif()</div>
<div>+=C2=A0 =C2=A0 #endif()</div>
<div><br>
</div>
<div>=C2=A0 =C2=A0 =C2=A0#${ICD_TARGET}.so${SO_VERSION_NUMBER} : ${filter-o=
ut -Wl%,$(LLLIBS})</div>
<div>
<div><br>
</div>
<div><br>
</div>
<div>diff --git a/icd/api/llpc/util/llpcDebug.cpp b/icd/api/llpc/util/llpcD=
ebug.cpp</div>
<div>index 1273cd6..847786e 100644</div>
<div>--- a/icd/api/llpc/util/llpcDebug.cpp</div>
<div>+++ b/icd/api/llpc/util/llpcDebug.cpp</div>
<div>@@ -113,7 +113,7 @@ bool EnableErrs()</div>
<div>=C2=A0// Translates enum &quot;ResourceMappingNodeType&quot; to string=
 and output to ostream.</div>
<div>=C2=A0raw_ostream&amp; operator&lt;&lt;(</div>
<div>=C2=A0 =C2=A0 =C2=A0raw_ostream&amp;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0out,=C2=A0 =C2=A0// [out] =
Output stream</div>
<div>-=C2=A0 =C2=A0 enum class ResourceMappingNodeType type)=C2=A0 // Resou=
rce map node type</div>
<div>+=C2=A0 =C2=A0 enum ResourceMappingNodeType type)=C2=A0 // Resource ma=
p node type</div>
<div>=C2=A0{</div>
<div>=C2=A0 =C2=A0 =C2=A0const char* pString =3D nullptr;</div>
<div>=C2=A0 =C2=A0 =C2=A0switch (type)</div>
</div>
</div>
<div><br>
</div>
<div><br>
</div>
</div>
</div>
</blockquote>
</div>
<br>
</div></div></blockquote></div>

--001a1143c8607def8f0560f01fad--

--===============0750516720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0750516720==--
