From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Fix "dc has no member named dml" compile
 error
Date: Thu, 21 Mar 2019 14:51:10 +0000
Message-ID: <DM5PR12MB18209DFF429BF3D722253483F7420@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <1553179469-10012-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1574315214=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1553179469-10012-1-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
To: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>

--===============1574315214==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB18209DFF429BF3D722253483F7420DM5PR12MB1820namp_"

--_000_DM5PR12MB18209DFF429BF3D722253483F7420DM5PR12MB1820namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks!

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of sunpeng.=
li-5C7GfCeVMHo@public.gmane.org <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, March 21, 2019 10:44 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Li, Sun peng (Leo); Alex Deucher; Wentland, Harry; Kazlauskas, Nicholas
Subject: [PATCH] drm/amd/display: Fix "dc has no member named dml" compile =
error

From: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>

For DCN disabled builds, dc->dml is stripped out. Therefore, guard usage
in dc_create_state() with CONFIG_DRM_AMD_DC_DCN1_0.

It fixes the following error:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c: In function 'dc_create_=
state':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1237:34: error: 'stru=
ct dc' has no member named 'dml'
     memcpy(&context->bw_ctx.dml, &dc->dml, sizeof(struct display_mode_lib)=
);
                                     ^~

Signed-off-by: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
CC: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
CC: Harry Wentland <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
CC: Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd=
/display/dc/core/dc.c
index cebd083..589cd95 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1245,7 +1245,9 @@ struct dc_state *dc_create_state(struct dc *dc)
          * initialize and obtain IP and SOC the base DML instance from DC =
is
          * initially copied into every context
          */
+#ifdef CONFIG_DRM_AMD_DC_DCN1_0
         memcpy(&context->bw_ctx.dml, &dc->dml, sizeof(struct display_mode_=
lib));
+#endif

         kref_init(&context->refcount);

--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB18209DFF429BF3D722253483F7420DM5PR12MB1820namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of sunpeng.li-5C7GfCeVMHo@public.gmane.org &lt;sunp=
eng.li-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, March 21, 2019 10:44 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Li, Sun peng (Leo); Alex Deucher; Wentland, Harry; Kazlauskas, N=
icholas<br>
<b>Subject:</b> [PATCH] drm/amd/display: Fix &quot;dc has no member named d=
ml&quot; compile error</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">From: Leo Li &lt;sunpeng.li-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
For DCN disabled builds, dc-&gt;dml is stripped out. Therefore, guard usage=
<br>
in dc_create_state() with CONFIG_DRM_AMD_DC_DCN1_0.<br>
<br>
It fixes the following error:<br>
<br>
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c: In function 'dc_create_=
state':<br>
&gt;&gt; drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1237:34: error:=
 'struct dc' has no member named 'dml'<br>
&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;context-&gt;bw_ctx.dml, &amp;dc-&gt;dm=
l, sizeof(struct display_mode_lib));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~<br>
<br>
Signed-off-by: Leo Li &lt;sunpeng.li-5C7GfCeVMHo@public.gmane.org&gt;<br>
CC: Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
CC: Harry Wentland &lt;Harry.Wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
CC: Nicholas Kazlauskas &lt;nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/core/dc.c | 2 &#43;&#43;<br>
&nbsp;1 file changed, 2 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd=
/display/dc/core/dc.c<br>
index cebd083..589cd95 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/core/dc.c<br>
@@ -1245,7 &#43;1245,9 @@ struct dc_state *dc_create_state(struct dc *dc)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * initialize and obt=
ain IP and SOC the base DML instance from DC is<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * initially copied i=
nto every context<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;#ifdef CONFIG_DRM_AMD_DC_DCN1_0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;context-&gt;bw=
_ctx.dml, &amp;dc-&gt;dml, sizeof(struct display_mode_lib));<br>
&#43;#endif<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kref_init(&amp;context-&gt=
;refcount);<br>
&nbsp;<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_DM5PR12MB18209DFF429BF3D722253483F7420DM5PR12MB1820namp_--

--===============1574315214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1574315214==--
