From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] Autodetect libdrm path (v2)
Date: Mon, 6 Feb 2017 21:33:10 +0000
Message-ID: <CY4PR12MB17689AEC15DEF9662A16DEA3F7400@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <20170205222447.19945-1-tom.stdenis@amd.com>,
 <CACvgo5230Use5sk8dm5jBbLqiJeSkgB6cDikz-N4omx-4Jgy9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2098824245=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CACvgo5230Use5sk8dm5jBbLqiJeSkgB6cDikz-N4omx-4Jgy9A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2098824245==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB17689AEC15DEF9662A16DEA3F7400CY4PR12MB1768namp_"

--_000_CY4PR12MB17689AEC15DEF9662A16DEA3F7400CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I have to NAK that idea since we use umr on NPI work which doesn't necessar=
ily have libdrm support.


Also umr can read/write registers via pci access without amdgpu loaded (han=
dy if amdgpu fails to init properly).

Though you are right that libdrm is technically a requirement and I should =
add that to the README.

Tom
________________________________
From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Monday, February 6, 2017 15:18
To: Tom St Denis
Cc: amd-gfx mailing list; StDenis, Tom
Subject: Re: [PATCH] Autodetect libdrm path (v2)

Hi Tom,

On 5 February 2017 at 22:24, Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> (v2):  Use findLibDRM script instead of directly finding path
>
Since the project already depends on libdrm you might want to use the
drmDevice2 API and drop the iteration over all PCI devices
(libpciaccess dependency).
If the former is lacking something feel free to suggest/send patches ;-)

The libdrm requirement was missing last time I've skimmed through the READM=
E.

> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---

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
You really want a version check.

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
Here is one of the things which makes me rage against cmake - no
picking /usr/{include,foo} is _not_ what you want.

During cross-compilation as one is missing the .pc file, the system
headers/libraries will be picked. This is horribly wrong, yet rather
common in cmake world.
What you really want is a lovely error message to warn the user -
s/OPTIONAL/REQUIRED/ will give you just that.

At which point, checking for the header/library in the paths provided
by the .pc file is redundant and thus nearly everything else in the
file ;-)


TL;Dr: All you need is pkg_check_modules(PC_LIBDRM REQUIRED libdrm>=3DXX).

Thanks
Emil

--_000_CY4PR12MB17689AEC15DEF9662A16DEA3F7400CY4PR12MB1768namp_
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
<p>I have to NAK that idea since we use umr on NPI work which doesn't neces=
sarily have libdrm support.</p>
<p><br>
</p>
<p>Also umr can read/write registers via pci access without amdgpu loaded (=
handy if amdgpu fails to init properly).&nbsp;</p>
<br>
Though you are right that libdrm is technically a requirement and I should =
add that to the README.
<div><br>
</div>
<div>Tom<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Emil Velikov &lt;em=
il.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, February 6, 2017 15:18<br>
<b>To:</b> Tom St Denis<br>
<b>Cc:</b> amd-gfx mailing list; StDenis, Tom<br>
<b>Subject:</b> Re: [PATCH] Autodetect libdrm path (v2)</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Hi Tom,<br>
<br>
On 5 February 2017 at 22:24, Tom St Denis &lt;tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt; wrot=
e:<br>
&gt; (v2):&nbsp; Use findLibDRM script instead of directly finding path<br>
&gt;<br>
Since the project already depends on libdrm you might want to use the<br>
drmDevice2 API and drop the iteration over all PCI devices<br>
(libpciaccess dependency).<br>
If the former is lacking something feel free to suggest/send patches ;-)<br=
>
<br>
The libdrm requirement was missing last time I've skimmed through the READM=
E.<br>
<br>
&gt; Signed-off-by: Tom St Denis &lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
<br>
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
You really want a version check.<br>
<br>
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
Here is one of the things which makes me rage against cmake - no<br>
picking /usr/{include,foo} is _not_ what you want.<br>
<br>
During cross-compilation as one is missing the .pc file, the system<br>
headers/libraries will be picked. This is horribly wrong, yet rather<br>
common in cmake world.<br>
What you really want is a lovely error message to warn the user -<br>
s/OPTIONAL/REQUIRED/ will give you just that.<br>
<br>
At which point, checking for the header/library in the paths provided<br>
by the .pc file is redundant and thus nearly everything else in the<br>
file ;-)<br>
<br>
<br>
TL;Dr: All you need is pkg_check_modules(PC_LIBDRM REQUIRED libdrm&gt;=3DXX=
).<br>
<br>
Thanks<br>
Emil<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB17689AEC15DEF9662A16DEA3F7400CY4PR12MB1768namp_--

--===============2098824245==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2098824245==--
