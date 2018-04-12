From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/powerplay: fix smu7_get_memory_type for fiji
Date: Thu, 12 Apr 2018 02:57:08 +0000
Message-ID: <CY4PR12MB1687E29E26EA5567C5327BFEFBBC0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <20180411225908.409-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0275365199=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180411225908.409-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

--===============0275365199==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687E29E26EA5567C5327BFEFBBC0CY4PR12MB1687namp_"

--_000_CY4PR12MB1687E29E26EA5567C5327BFEFBBC0CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>



Best Regards

Rex


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Alex Deu=
cher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, April 12, 2018 6:59 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander
Subject: [PATCH] drm/amdgpu/powerplay: fix smu7_get_memory_type for fiji

Fiji uses a different register than other smu7 asics, but
we already have this info in the base driver so just
use that.

Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index 21c021ba0f49..97b7c2333f19 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -4150,13 +4150,9 @@ static int smu7_read_clock_registers(struct pp_hwmgr=
 *hwmgr)
 static int smu7_get_memory_type(struct pp_hwmgr *hwmgr)
 {
         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend);
-       uint32_t temp;
-
-       temp =3D cgs_read_register(hwmgr->device, mmMC_SEQ_MISC0);
+       struct amdgpu_device *adev =3D hwmgr->adev;

-       data->is_memory_gddr5 =3D (MC_SEQ_MISC0_GDDR5_VALUE =3D=3D
-                       ((temp & MC_SEQ_MISC0_GDDR5_MASK) >>
-                        MC_SEQ_MISC0_GDDR5_SHIFT));
+       data->is_memory_gddr5 =3D (adev->gmc.vram_type =3D=3D AMDGPU_VRAM_T=
YPE_GDDR5);

         return 0;
 }
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




--_000_CY4PR12MB1687E29E26EA5567C5327BFEFBBC0CY4PR12MB1687namp_
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
<p style=3D"margin-top: 0px; margin-bottom: 0px;">Reviewed-by: Rex Zhu &lt;=
Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">&nbsp;</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">Best Regards</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">Rex<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"width: 98%; display: inline-block;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font color=3D"#000000" face=3D"Calib=
ri, sans-serif" style=3D"font-size: 11pt;"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Alex Deucher &lt;alexdeuche=
r@gmail.com&gt;<br>
<b>Sent:</b> Thursday, April 12, 2018 6:59 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> [PATCH] drm/amdgpu/powerplay: fix smu7_get_memory_type for =
fiji</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size: 11pt=
;">
<div class=3D"PlainText">Fiji uses a different register than other smu7 asi=
cs, but<br>
we already have this info in the base driver so just<br>
use that.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 8 &#43;&#43;------=
<br>
&nbsp;1 file changed, 2 insertions(&#43;), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
index 21c021ba0f49..97b7c2333f19 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
@@ -4150,13 &#43;4150,9 @@ static int smu7_read_clock_registers(struct pp_h=
wmgr *hwmgr)<br>
&nbsp;static int smu7_get_memory_type(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_hwmgr *data =
=3D (struct smu7_hwmgr *)(hwmgr-&gt;backend);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t temp;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D cgs_read_register(hwmgr-&gt;=
device, mmMC_SEQ_MISC0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;is_memory_gddr5 =3D (MC_SEQ_=
MISC0_GDDR5_VALUE =3D=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((temp &amp; MC_=
SEQ_MISC0_GDDR5_MASK) &gt;&gt;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MC_SEQ_MIS=
C0_GDDR5_SHIFT));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;is_memory_gddr5 =3D (ade=
v-&gt;gmc.vram_type =3D=3D AMDGPU_VRAM_TYPE_GDDR5);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
-- <br>
2.13.6<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a id=3D"LPlnk988618" href=3D"https://lists.freedesktop.org/mailman/listinf=
o/amd-gfx" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<p></p>
<div id=3D"LPBorder_GT_15235017921200.41602104181648724" style=3D"width: 10=
0%; text-indent: 0px; overflow: auto; margin-bottom: 20px; display: inline-=
block;">
<table id=3D"LPContainer_15235017921050.7242531630817566" role=3D"presentat=
ion" style=3D"width: 90%; overflow: auto; padding-top: 20px; padding-bottom=
: 20px; margin-top: 20px; border-top-color: rgb(200, 200, 200); border-bott=
om-color: rgb(200, 200, 200); border-top-width: 1px; border-bottom-width: 1=
px; border-top-style: dotted; border-bottom-style: dotted; position: relati=
ve; background-color: rgb(255, 255, 255);" cellspacing=3D"0">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_15235017921080.36776829568810215" style=3D"padding: 0px;=
 vertical-align: top; display: table-cell; position: relative;" colspan=3D"=
2">
<div id=3D"LPRemovePreviewContainer_15235017921080.8136940580140316" style=
=3D"float: right;">
</div>
<div id=3D"LPTitle_15235017921080.8360581066433652" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); line-height: 21px; font-family: &quot;wf_segoe-ui_ligh=
t&quot;, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &quot;Sego=
e UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; font-size: 21p=
x; font-weight: 400;">
<a id=3D"LPUrlAnchor_15235017921120.7734456328443906" style=3D"text-decorat=
ion: none;" href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 target=3D"_blank">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15235017921120.5711695470615914" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); line-height: 14px; font-family: &quo=
t;wf_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tah=
oma, Arial, sans-serif; font-size: 14px; font-weight: 400;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15235017921160.5796179247845801" style=3D"color: r=
gb(102, 102, 102); line-height: 20px; overflow: hidden; font-family: &quot;=
wf_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahom=
a, Arial, sans-serif; font-size: 14px; font-weight: 400; display: block; ma=
x-height: 100px;">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of Conduct.</d=
iv>
</td>
</tr>
</tbody>
</table>
</div>
<p></p>
<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1687E29E26EA5567C5327BFEFBBC0CY4PR12MB1687namp_--

--===============0275365199==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0275365199==--
