From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] Autodetect libdrm path (v2)
Date: Sun, 5 Feb 2017 22:42:46 +0000
Message-ID: <CY4PR12MB17683BCCBAC6759B4118F4EEF7410@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <20170205222447.19945-1-tom.stdenis@amd.com>,
 <62ec2a45-ea86-a643-f7fd-3e5e5054540b@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0905585622=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <62ec2a45-ea86-a643-f7fd-3e5e5054540b-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
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
To: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0905585622==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB17683BCCBAC6759B4118F4EEF7410CY4PR12MB1768namp_"

--_000_CY4PR12MB17683BCCBAC6759B4118F4EEF7410CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks.  Pushed it.


Tom


________________________________
From: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Sunday, February 5, 2017 17:28
To: Tom St Denis; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: StDenis, Tom
Subject: Re: [PATCH] Autodetect libdrm path (v2)

Reviewed-by: Andres Rodriguez<andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On 2/5/2017 5:24 PM, Tom St Denis wrote:
> (v2):  Use findLibDRM script instead of directly finding path
>
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>  CMakeLists.txt                 |  3 +++
>  cmake_modules/FindLibDRM.cmake | 35 +++++++++++++++++++++++++++++++++++
>  src/lib/query_drm.c            |  4 ++--
>  3 files changed, 40 insertions(+), 2 deletions(-)
>  create mode 100644 cmake_modules/FindLibDRM.cmake
>
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index bef94fdba788..ef78c97ad763 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -25,6 +25,9 @@ include_directories(${CURSES_INCLUDE_DIRS})
>  find_package(PCIAccess REQUIRED)
>  include_directories(${PCIACCESS_INCLUDE_DIR})
>
> +find_package(LibDRM REQUIRED)
> +include_directories(${LIBDRM_INCLUDE_DIR})
> +
>  set(REQUIRED_EXTERNAL_LIBS
>    ${CURSES_LIBRARIES}
>    ${PCIACCESS_LIBRARIES}
> diff --git a/cmake_modules/FindLibDRM.cmake b/cmake_modules/FindLibDRM.cm=
ake
> new file mode 100644
> index 000000000000..e840c4d1bfd0
> --- /dev/null
> +++ b/cmake_modules/FindLibDRM.cmake
> @@ -0,0 +1,35 @@
> +# Try to find libdrm
> +#
> +# Once done, this will define
> +#
> +# LIBDRM_FOUND
> +# LIBDRM_INCLUDE_DIR
> +# LIBDRM_LIBRARIES
> +
> +find_package(PkgConfig)
> +
> +pkg_check_modules(PC_LIBDRM QUIET libdrm)
> +
> +find_path(LIBDRM_INCLUDE_DIR NAMES amdgpu_drm.h
> +    HINTS
> +    ${PC_LIBDRM_INCLUDEDIR}
> +    ${PC_LIBDRM_INCLUDE_DIRS}
> +    /usr/include
> +)
> +
> +find_library(LIBDRM_LIBRARY NAMES libdrm_amdgpu.so.1
> +    HINTS
> +    ${PC_LIBDRM_LIBDIR}
> +    ${PC_LIBDRM_LIBRARY_DIRS}
> +    /usr/lib64
> +    /usr/lib
> +)
> +
> +SET(LIBDRM_LIBRARIES optimized ${LIBDRM_LIBRARY})
> +
> +include(FindPackageHandleStandardArgs)
> +find_package_handle_standard_args(LIBDRM DEFAULT_MSG
> +     LIBDRM_LIBRARIES LIBDRM_INCLUDE_DIR
> +)
> +
> +mark_as_advanced(LIBDRM_INCLUDE_DIR LIBDRM_LIBRARIES)
> diff --git a/src/lib/query_drm.c b/src/lib/query_drm.c
> index b9d80a8fc0c8..755c65fbc662 100644
> --- a/src/lib/query_drm.c
> +++ b/src/lib/query_drm.c
> @@ -25,8 +25,8 @@
>  #include "umr.h"
>  #include <asm/ioctl.h>
>  #include <sys/ioctl.h>
> -#include <drm/drm.h>
> -#include <drm/amdgpu_drm.h>
> +#include <drm.h>
> +#include <amdgpu_drm.h>
>
>  #define DRM_IOC(dir, group, nr, size) _IOC(dir, group, nr, size)
>  #define DRM_IOC_WRITE           _IOC_WRITE
>

--_000_CY4PR12MB17683BCCBAC6759B4118F4EEF7410CY4PR12MB1768namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>Thanks. &nbsp;Pushed it.</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Andres Rodriguez &l=
t;andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Sunday, February 5, 2017 17:28<br>
<b>To:</b> Tom St Denis; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> StDenis, Tom<br>
<b>Subject:</b> Re: [PATCH] Autodetect libdrm path (v2)</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Reviewed-by: Andres Rodriguez&lt;andresx7-Re5JQEeQqe8@public.gmane.org=
m&gt;<br>
<br>
On 2/5/2017 5:24 PM, Tom St Denis wrote:<br>
&gt; (v2):&nbsp; Use findLibDRM script instead of directly finding path<br>
&gt;<br>
&gt; Signed-off-by: Tom St Denis &lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; CMakeLists.txt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 &#43;&#43;&#43;<br=
>
&gt;&nbsp; cmake_modules/FindLibDRM.cmake | 35 &#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br=
>
&gt;&nbsp; src/lib/query_drm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 &#43;&#43;--<br>
&gt;&nbsp; 3 files changed, 40 insertions(&#43;), 2 deletions(-)<br>
&gt;&nbsp; create mode 100644 cmake_modules/FindLibDRM.cmake<br>
&gt;<br>
&gt; diff --git a/CMakeLists.txt b/CMakeLists.txt<br>
&gt; index bef94fdba788..ef78c97ad763 100644<br>
&gt; --- a/CMakeLists.txt<br>
&gt; &#43;&#43;&#43; b/CMakeLists.txt<br>
&gt; @@ -25,6 &#43;25,9 @@ include_directories(${CURSES_INCLUDE_DIRS})<br>
&gt;&nbsp; find_package(PCIAccess REQUIRED)<br>
&gt;&nbsp; include_directories(${PCIACCESS_INCLUDE_DIR})<br>
&gt;<br>
&gt; &#43;find_package(LibDRM REQUIRED)<br>
&gt; &#43;include_directories(${LIBDRM_INCLUDE_DIR})<br>
&gt; &#43;<br>
&gt;&nbsp; set(REQUIRED_EXTERNAL_LIBS<br>
&gt;&nbsp;&nbsp;&nbsp; ${CURSES_LIBRARIES}<br>
&gt;&nbsp;&nbsp;&nbsp; ${PCIACCESS_LIBRARIES}<br>
&gt; diff --git a/cmake_modules/FindLibDRM.cmake b/cmake_modules/FindLibDRM=
.cmake<br>
&gt; new file mode 100644<br>
&gt; index 000000000000..e840c4d1bfd0<br>
&gt; --- /dev/null<br>
&gt; &#43;&#43;&#43; b/cmake_modules/FindLibDRM.cmake<br>
&gt; @@ -0,0 &#43;1,35 @@<br>
&gt; &#43;# Try to find libdrm<br>
&gt; &#43;#<br>
&gt; &#43;# Once done, this will define<br>
&gt; &#43;#<br>
&gt; &#43;# LIBDRM_FOUND<br>
&gt; &#43;# LIBDRM_INCLUDE_DIR<br>
&gt; &#43;# LIBDRM_LIBRARIES<br>
&gt; &#43;<br>
&gt; &#43;find_package(PkgConfig)<br>
&gt; &#43;<br>
&gt; &#43;pkg_check_modules(PC_LIBDRM QUIET libdrm)<br>
&gt; &#43;<br>
&gt; &#43;find_path(LIBDRM_INCLUDE_DIR NAMES amdgpu_drm.h<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; HINTS<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; ${PC_LIBDRM_INCLUDEDIR}<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; ${PC_LIBDRM_INCLUDE_DIRS}<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; /usr/include<br>
&gt; &#43;)<br>
&gt; &#43;<br>
&gt; &#43;find_library(LIBDRM_LIBRARY NAMES libdrm_amdgpu.so.1<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; HINTS<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; ${PC_LIBDRM_LIBDIR}<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; ${PC_LIBDRM_LIBRARY_DIRS}<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; /usr/lib64<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; /usr/lib<br>
&gt; &#43;)<br>
&gt; &#43;<br>
&gt; &#43;SET(LIBDRM_LIBRARIES optimized ${LIBDRM_LIBRARY})<br>
&gt; &#43;<br>
&gt; &#43;include(FindPackageHandleStandardArgs)<br>
&gt; &#43;find_package_handle_standard_args(LIBDRM DEFAULT_MSG<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; LIBDRM_LIBRARIES LIBDRM_INCLUDE_DIR<br>
&gt; &#43;)<br>
&gt; &#43;<br>
&gt; &#43;mark_as_advanced(LIBDRM_INCLUDE_DIR LIBDRM_LIBRARIES)<br>
&gt; diff --git a/src/lib/query_drm.c b/src/lib/query_drm.c<br>
&gt; index b9d80a8fc0c8..755c65fbc662 100644<br>
&gt; --- a/src/lib/query_drm.c<br>
&gt; &#43;&#43;&#43; b/src/lib/query_drm.c<br>
&gt; @@ -25,8 &#43;25,8 @@<br>
&gt;&nbsp; #include &quot;umr.h&quot;<br>
&gt;&nbsp; #include &lt;asm/ioctl.h&gt;<br>
&gt;&nbsp; #include &lt;sys/ioctl.h&gt;<br>
&gt; -#include &lt;drm/drm.h&gt;<br>
&gt; -#include &lt;drm/amdgpu_drm.h&gt;<br>
&gt; &#43;#include &lt;drm.h&gt;<br>
&gt; &#43;#include &lt;amdgpu_drm.h&gt;<br>
&gt;<br>
&gt;&nbsp; #define DRM_IOC(dir, group, nr, size) _IOC(dir, group, nr, size)=
<br>
&gt;&nbsp; #define DRM_IOC_WRITE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; _IOC_WRITE<br>
&gt;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB17683BCCBAC6759B4118F4EEF7410CY4PR12MB1768namp_--

--===============0905585622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0905585622==--
