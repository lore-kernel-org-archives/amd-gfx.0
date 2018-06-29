From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/pp: fix endian swapping in
 atomctrl_get_voltage_range
Date: Fri, 29 Jun 2018 00:21:50 +0000
Message-ID: <CY4PR12MB168723E6A12FD5F2AE709729FB4E0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <20180628183804.9846-1-alexander.deucher@amd.com>,
 <20180628183804.9846-5-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0961455015=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180628183804.9846-5-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============0961455015==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB168723E6A12FD5F2AE709729FB4E0CY4PR12MB1687namp_"

--_000_CY4PR12MB168723E6A12FD5F2AE709729FB4E0CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>



Best Regards

Rex



________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Alex Deu=
cher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, June 29, 2018 2:38 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander
Subject: [PATCH] drm/amdgpu/pp: fix endian swapping in atomctrl_get_voltage=
_range

Need to swap before doing arthimetic on the values.

Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/ppatomctrl.c
index 7047e29755c3..01dc46dc9c8a 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c
@@ -1544,14 +1544,14 @@ void atomctrl_get_voltage_range(struct pp_hwmgr *hw=
mgr, uint32_t *max_vddc,
                 switch (hwmgr->chip_id) {
                 case CHIP_TONGA:
                 case CHIP_FIJI:
-                       *max_vddc =3D le32_to_cpu(((ATOM_ASIC_PROFILING_INF=
O_V3_3 *)profile)->ulMaxVddc/4);
-                       *min_vddc =3D le32_to_cpu(((ATOM_ASIC_PROFILING_INF=
O_V3_3 *)profile)->ulMinVddc/4);
+                       *max_vddc =3D le32_to_cpu(((ATOM_ASIC_PROFILING_INF=
O_V3_3 *)profile)->ulMaxVddc) / 4;
+                       *min_vddc =3D le32_to_cpu(((ATOM_ASIC_PROFILING_INF=
O_V3_3 *)profile)->ulMinVddc) / 4;
                         return;
                 case CHIP_POLARIS11:
                 case CHIP_POLARIS10:
                 case CHIP_POLARIS12:
-                       *max_vddc =3D le32_to_cpu(((ATOM_ASIC_PROFILING_INF=
O_V3_6 *)profile)->ulMaxVddc/100);
-                       *min_vddc =3D le32_to_cpu(((ATOM_ASIC_PROFILING_INF=
O_V3_6 *)profile)->ulMinVddc/100);
+                       *max_vddc =3D le32_to_cpu(((ATOM_ASIC_PROFILING_INF=
O_V3_6 *)profile)->ulMaxVddc) / 100;
+                       *min_vddc =3D le32_to_cpu(((ATOM_ASIC_PROFILING_INF=
O_V3_6 *)profile)->ulMinVddc) / 100;
                         return;
                 default:
                         break;
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
orm. Use of all freedesktop.org lists is subject to our Code of Conduct.




--_000_CY4PR12MB168723E6A12FD5F2AE709729FB4E0CY4PR12MB1687namp_
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
<p style=3D"margin-top:0;margin-bottom:0"></p>
<p style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont; =
font-size: 16px;">
Reviewed-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</p>
<p style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont; =
font-size: 16px;">
&nbsp;</p>
<p style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont; =
font-size: 16px;">
Best Regards</p>
<p style=3D"font-family: Calibri, Helvetica, sans-serif, serif, EmojiFont; =
font-size: 16px;">
Rex</p>
<br>
<p></p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Alex Deucher &lt;alexdeucher@=
gmail.com&gt;<br>
<b>Sent:</b> Friday, June 29, 2018 2:38 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> [PATCH] drm/amdgpu/pp: fix endian swapping in atomctrl_get_=
voltage_range</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Need to swap before doing arthimetic on the values=
.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c | 8 &#43;&#43;&#43;&=
#43;----<br>
&nbsp;1 file changed, 4 insertions(&#43;), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/ppatomctrl.c<br>
index 7047e29755c3..01dc46dc9c8a 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/ppatomctrl.c<br>
@@ -1544,14 &#43;1544,14 @@ void atomctrl_get_voltage_range(struct pp_hwmgr=
 *hwmgr, uint32_t *max_vddc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; switch (hwmgr-&gt;chip_id) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case CHIP_TONGA:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case CHIP_FIJI:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *max_vddc =3D le=
32_to_cpu(((ATOM_ASIC_PROFILING_INFO_V3_3 *)profile)-&gt;ulMaxVddc/4);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *min_vddc =3D le=
32_to_cpu(((ATOM_ASIC_PROFILING_INFO_V3_3 *)profile)-&gt;ulMinVddc/4);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *max_vddc =
=3D le32_to_cpu(((ATOM_ASIC_PROFILING_INFO_V3_3 *)profile)-&gt;ulMaxVddc) /=
 4;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *min_vddc =
=3D le32_to_cpu(((ATOM_ASIC_PROFILING_INFO_V3_3 *)profile)-&gt;ulMinVddc) /=
 4;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case CHIP_POLARIS11:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case CHIP_POLARIS10:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case CHIP_POLARIS12:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *max_vddc =3D le=
32_to_cpu(((ATOM_ASIC_PROFILING_INFO_V3_6 *)profile)-&gt;ulMaxVddc/100);<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *min_vddc =3D le=
32_to_cpu(((ATOM_ASIC_PROFILING_INFO_V3_6 *)profile)-&gt;ulMinVddc/100);<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *max_vddc =
=3D le32_to_cpu(((ATOM_ASIC_PROFILING_INFO_V3_6 *)profile)-&gt;ulMaxVddc) /=
 100;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *min_vddc =
=3D le32_to_cpu(((ATOM_ASIC_PROFILING_INFO_V3_6 *)profile)-&gt;ulMinVddc) /=
 100;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
-- <br>
2.13.6<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk875278" class=3D"OWAAutoLink" previewremoved=3D"true">https://lists.free=
desktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15302317002550.0688863695531059" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15302317002520.3572867646043596" role=3D"presentat=
ion" cellspacing=3D"0" style=3D"width: 90%; background-color: rgb(255, 255,=
 255); position: relative; overflow: auto; padding-top: 20px; padding-botto=
m: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200); borde=
r-bottom: 1px dotted rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_15302317002530.9557018518335572" colspan=3D"2" style=3D"=
vertical-align: top; position: relative; padding: 0px; display: table-cell;=
">
<div id=3D"LPRemovePreviewContainer_15302317002530.8589911167004127"></div>
<div id=3D"LPTitle_15302317002530.6375754765735355" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: normal; font-size: 21px; font-family: wf_=
segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-he=
ight: 21px;">
<a id=3D"LPUrlAnchor_15302317002540.061052169720554605" href=3D"https://lis=
ts.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"tex=
t-decoration: none;">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15302317002540.05811874441337017" style=3D"margin: 10=
px 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: w=
f_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Aria=
l, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15302317002540.3789556757928134" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_seg=
oe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sa=
ns-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow: =
hidden;">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of Conduct.</d=
iv>
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
</body>
</html>

--_000_CY4PR12MB168723E6A12FD5F2AE709729FB4E0CY4PR12MB1687namp_--

--===============0961455015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0961455015==--
