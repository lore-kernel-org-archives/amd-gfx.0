From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: fix KV harvesting
Date: Tue, 6 Mar 2018 14:23:16 +0000
Message-ID: <CY4PR12MB1687A6DA481570A539F50840FBD90@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <20180305183014.4861-1-alexander.deucher@amd.com>,
 <20180305183014.4861-2-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0509744322=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180305183014.4861-2-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

--===============0509744322==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687A6DA481570A539F50840FBD90CY4PR12MB1687namp_"

--_000_CY4PR12MB1687A6DA481570A539F50840FBD90CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Acked-by:  Rex Zhu<rezhu-5C7GfCeVMHo@public.gmane.org> for the series.


Best Regards
Rex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Alex Deu=
cher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, March 6, 2018 2:30 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander; stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: [PATCH 2/2] drm/amdgpu: fix KV harvesting

Always set the graphics values to the max for the
asic type.  E.g., some 1 RB chips are actually 1 RB chips,
others are actually harvested 2 RB chips.

Fixes: https://bugs.freedesktop.org/show_bug.cgi?id=3D99353
Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 30 ++----------------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v7_0.c
index 972d421caada..e13d9d83767b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4358,34 +4358,8 @@ static void gfx_v7_0_gpu_early_init(struct amdgpu_de=
vice *adev)
         case CHIP_KAVERI:
                 adev->gfx.config.max_shader_engines =3D 1;
                 adev->gfx.config.max_tile_pipes =3D 4;
-               if ((adev->pdev->device =3D=3D 0x1304) ||
-                   (adev->pdev->device =3D=3D 0x1305) ||
-                   (adev->pdev->device =3D=3D 0x130C) ||
-                   (adev->pdev->device =3D=3D 0x130F) ||
-                   (adev->pdev->device =3D=3D 0x1310) ||
-                   (adev->pdev->device =3D=3D 0x1311) ||
-                   (adev->pdev->device =3D=3D 0x131C)) {
-                       adev->gfx.config.max_cu_per_sh =3D 8;
-                       adev->gfx.config.max_backends_per_se =3D 2;
-               } else if ((adev->pdev->device =3D=3D 0x1309) ||
-                          (adev->pdev->device =3D=3D 0x130A) ||
-                          (adev->pdev->device =3D=3D 0x130D) ||
-                          (adev->pdev->device =3D=3D 0x1313) ||
-                          (adev->pdev->device =3D=3D 0x131D)) {
-                       adev->gfx.config.max_cu_per_sh =3D 6;
-                       adev->gfx.config.max_backends_per_se =3D 2;
-               } else if ((adev->pdev->device =3D=3D 0x1306) ||
-                          (adev->pdev->device =3D=3D 0x1307) ||
-                          (adev->pdev->device =3D=3D 0x130B) ||
-                          (adev->pdev->device =3D=3D 0x130E) ||
-                          (adev->pdev->device =3D=3D 0x1315) ||
-                          (adev->pdev->device =3D=3D 0x131B)) {
-                       adev->gfx.config.max_cu_per_sh =3D 4;
-                       adev->gfx.config.max_backends_per_se =3D 1;
-               } else {
-                       adev->gfx.config.max_cu_per_sh =3D 3;
-                       adev->gfx.config.max_backends_per_se =3D 1;
-               }
+               adev->gfx.config.max_cu_per_sh =3D 8;
+               adev->gfx.config.max_backends_per_se =3D 2;
                 adev->gfx.config.max_sh_per_se =3D 1;
                 adev->gfx.config.max_texture_channel_caches =3D 4;
                 adev->gfx.config.max_gprs =3D 256;
--
2.13.6

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...




--_000_CY4PR12MB1687A6DA481570A539F50840FBD90CY4PR12MB1687namp_
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
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(33, 33,=
 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP=
&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;"=
>Acked-by:
<span style=3D"color: rgb(33, 33, 33); font-family: wf_segoe-ui_normal, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif, =
EmojiFont; font-size: 14.6667px;">
&nbsp;Rex Zhu&lt;rezhu-5C7GfCeVMHo@public.gmane.org&gt;</span>&nbsp;for the series.</span><br>
</p>
<div><br>
</div>
<div><br>
</div>
Best Regards
<div>Rex<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Alex Deucher &lt;alexdeucher@=
gmail.com&gt;<br>
<b>Sent:</b> Tuesday, March 6, 2018 2:30 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander; stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: fix KV harvesting</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Always set the graphics values to the max for the<=
br>
asic type.&nbsp; E.g., some 1 RB chips are actually 1 RB chips,<br>
others are actually harvested 2 RB chips.<br>
<br>
Fixes: <a href=3D"https://bugs.freedesktop.org/show_bug.cgi?id=3D99353" id=
=3D"LPlnk129555" previewremoved=3D"true">
https://bugs.freedesktop.org/show_bug.cgi?id=3D99353</a><br>
Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 30 &#43;&#43;----------------=
------------<br>
&nbsp;1 file changed, 2 insertions(&#43;), 28 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v7_0.c<br>
index 972d421caada..e13d9d83767b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
@@ -4358,34 &#43;4358,8 @@ static void gfx_v7_0_gpu_early_init(struct amdgp=
u_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_KAVERI:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.config.max_shader_engines =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.config.max_tile_pipes =3D 4;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((adev-&gt;pdev-&gt;device =3D=3D 0x1304) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pdev-&gt;device =3D=3D 0x1305)=
 ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pdev-&gt;device =3D=3D 0x130C)=
 ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pdev-&gt;device =3D=3D 0x130F)=
 ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pdev-&gt;device =3D=3D 0x1310)=
 ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pdev-&gt;device =3D=3D 0x1311)=
 ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pdev-&gt;device =3D=3D 0x131C)=
) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.con=
fig.max_cu_per_sh =3D 8;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.con=
fig.max_backends_per_se =3D 2;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if ((adev-&gt;pdev-&gt;device =3D=3D 0x1309) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; (adev-&gt;pdev-&gt;device =3D=3D 0x130A) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; (adev-&gt;pdev-&gt;device =3D=3D 0x130D) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; (adev-&gt;pdev-&gt;device =3D=3D 0x1313) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; (adev-&gt;pdev-&gt;device =3D=3D 0x131D)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.con=
fig.max_cu_per_sh =3D 6;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.con=
fig.max_backends_per_se =3D 2;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if ((adev-&gt;pdev-&gt;device =3D=3D 0x1306) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; (adev-&gt;pdev-&gt;device =3D=3D 0x1307) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; (adev-&gt;pdev-&gt;device =3D=3D 0x130B) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; (adev-&gt;pdev-&gt;device =3D=3D 0x130E) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; (adev-&gt;pdev-&gt;device =3D=3D 0x1315) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; (adev-&gt;pdev-&gt;device =3D=3D 0x131B)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.con=
fig.max_cu_per_sh =3D 4;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.con=
fig.max_backends_per_se =3D 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.con=
fig.max_cu_per_sh =3D 3;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.con=
fig.max_backends_per_se =3D 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;gfx.config.max_cu_per_sh =3D 8;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;gfx.config.max_backends_per_se =3D 2;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.config.max_sh_per_se =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.config.max_texture_channel_caches =3D 4;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.config.max_gprs =3D 256;<br>
-- <br>
2.13.6<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk276780" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15203461461870.5458896767413355" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15203461461830.5976726513849222" role=3D"presentat=
ion" cellspacing=3D"0" style=3D"width: 90%; background-color: rgb(255, 255,=
 255); position: relative; overflow: auto; padding-top: 20px; padding-botto=
m: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200); borde=
r-bottom: 1px dotted rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_15203461461840.31511378275455026" colspan=3D"2" style=3D=
"vertical-align: top; position: relative; padding: 0px; display: table-cell=
;">
<div id=3D"LPRemovePreviewContainer_15203461461840.9511131829412953"></div>
<div id=3D"LPTitle_15203461461840.7955384077310457" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: normal; font-size: 21px; font-family: wf_=
segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-he=
ight: 21px;">
<a id=3D"LPUrlAnchor_15203461461850.4521393599461305" href=3D"https://lists=
.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-=
decoration: none;">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15203461461850.24606067221729422" style=3D"margin: 10=
px 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: w=
f_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Aria=
l, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15203461461860.3013675815531236" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_seg=
oe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sa=
ns-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow: =
hidden;">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1687A6DA481570A539F50840FBD90CY4PR12MB1687namp_--

--===============0509744322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0509744322==--
