From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/gfx8: set doorbell range for polaris as well
Date: Mon, 10 Apr 2017 17:49:42 +0000
Message-ID: <CY4PR12MB1687D068489C74E4951A8CC6FB010@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1491843061-26138-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0695133784=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1491843061-26138-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

--===============0695133784==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687D068489C74E4951A8CC6FB010CY4PR12MB1687namp_"

--_000_CY4PR12MB1687D068489C74E4951A8CC6FB010CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Patch was Tested-by and Reviewed-by:  Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>


Best Regards

Rex


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Alex Deu=
cher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, April 11, 2017 12:51:01 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander
Subject: [PATCH] drm/amdgpu/gfx8: set doorbell range for polaris as well

Add missing chips to the doorbell range setup.  These
were missed in the KIQ code.  Fixes power and performance
regressions with KIQ.  Spotted by Rex.

Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c
index 4497514..d3633cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4933,8 +4933,11 @@ static int gfx_v8_0_kiq_init_register(struct amdgpu_=
ring *ring)
         /* enable the doorbell if requested */
         if (ring->use_doorbell) {
                 if ((adev->asic_type =3D=3D CHIP_CARRIZO) ||
-                               (adev->asic_type =3D=3D CHIP_FIJI) ||
-                               (adev->asic_type =3D=3D CHIP_STONEY)) {
+                   (adev->asic_type =3D=3D CHIP_FIJI) ||
+                   (adev->asic_type =3D=3D CHIP_STONEY) ||
+                   (adev->asic_type =3D=3D CHIP_POLARIS10) ||
+                   (adev->asic_type =3D=3D CHIP_POLARIS11) ||
+                   (adev->asic_type =3D=3D CHIP_POLARIS12)) {
                         WREG32(mmCP_MEC_DOORBELL_RANGE_LOWER,
                                                 AMDGPU_DOORBELL_KIQ << 2);
                         WREG32(mmCP_MEC_DOORBELL_RANGE_UPPER,
--
2.5.5

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - lists.freedesktop.org<https://lists.freedesktop.org/mai=
lman/listinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...




--_000_CY4PR12MB1687D068489C74E4951A8CC6FB010CY4PR12MB1687namp_
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
<p><br>
</p>
<meta content=3D"text/html; charset=3DUTF-8">
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p>Patch was&nbsp;<span>Tested-by and Reviewed-by: &nbsp;Rex Zhu &lt;Rex.Zh=
u@amd.com&gt;</span><span style=3D"color: rgb(255, 255, 255); font-size: 13=
.3333px; background-color: rgb(216, 35, 0);"><span></span></span></p>
<p><span><br>
</span></p>
<p><span>Best Regards</span></p>
<p><span>Rex</span></p>
<p><span style=3D"color: rgb(255, 255, 255); font-size: 13.3333px; backgrou=
nd-color: rgb(216, 35, 0);"><span><br>
</span></span></p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Alex Deucher &lt;alexdeuche=
r@gmail.com&gt;<br>
<b>Sent:</b> Tuesday, April 11, 2017 12:51:01 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> [PATCH] drm/amdgpu/gfx8: set doorbell range for polaris as =
well</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Add missing chips to the doorbell range setup.&nbs=
p; These<br>
were missed in the KIQ code.&nbsp; Fixes power and performance<br>
regressions with KIQ.&nbsp; Spotted by Rex.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 7 &#43;&#43;&#43;&#43;&#43;--=
<br>
&nbsp;1 file changed, 5 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c<br>
index 4497514..d3633cb 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
@@ -4933,8 &#43;4933,11 @@ static int gfx_v8_0_kiq_init_register(struct amd=
gpu_ring *ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable the doorbell if =
requested */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;use_doorbell)=
 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;asic_type =3D=3D CHIP_CARRIZO) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type =3D=3D CHIP_FIJI) ||<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type =3D=3D CHIP_STONEY)) {<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type =3D=3D CHIP_FIJI=
) ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type =3D=3D CHIP_STON=
EY) ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type =3D=3D CHIP_POLA=
RIS10) ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type =3D=3D CHIP_POLA=
RIS11) ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type =3D=3D CHIP_POLA=
RIS12)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG3=
2(mmCP_MEC_DOORBELL_RANGE_LOWER,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOOR=
BELL_KIQ &lt;&lt; 2);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG3=
2(mmCP_MEC_DOORBELL_RANGE_UPPER,<br>
-- <br>
2.5.5<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk482528" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_14918463284570.6465360585134476" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_14918463284510.8434309298172593" cellspacing=3D"0"=
 style=3D"width: 90%; position: relative; overflow: auto; padding-top: 20px=
; padding-bottom: 20px; margin-top: 20px; border-top-width: 1px; border-top=
-style: dotted; border-top-color: rgb(200, 200, 200); border-bottom-width: =
1px; border-bottom-style: dotted; border-bottom-color: rgb(200, 200, 200); =
background-color: rgb(255, 255, 255);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_14918463284530.16780364350415766" colspan=3D"2" style=3D=
"vertical-align: top; position: relative; padding: 0px; display: table-cell=
;">
<div id=3D"LPRemovePreviewContainer_14918463284540.6823420550208539"></div>
<div id=3D"LPTitle_14918463284540.4068454767111689" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: normal; font-size: 21px; font-family: wf_=
segoe-ui_light, 'Segoe UI Light', 'Segoe WP Light', 'Segoe UI', 'Segoe WP',=
 Tahoma, Arial, sans-serif; line-height: 21px;">
<a id=3D"LPUrlAnchor_14918463284550.6047477882821113" href=3D"https://lists=
.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-=
decoration: none;">amd-gfx Info Page - lists.freedesktop.org</a></div>
<div id=3D"LPMetadata_14918463284550.507929797982797" style=3D"margin: 10px=
 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_=
segoe-ui_normal, 'Segoe UI', 'Segoe WP', Tahoma, Arial, sans-serif; font-si=
ze: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_14918463284560.9515536716207862" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_seg=
oe-ui_normal, 'Segoe UI', 'Segoe WP', Tahoma, Arial, sans-serif; font-size:=
 14px; line-height: 20px; max-height: 100px; overflow: hidden;">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB1687D068489C74E4951A8CC6FB010CY4PR12MB1687namp_--

--===============0695133784==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0695133784==--
