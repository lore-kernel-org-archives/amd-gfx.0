From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: add vega20 sriov capability detection
Date: Tue, 18 Sep 2018 14:20:48 +0000
Message-ID: <BN6PR12MB1809DAB6226CD941D9800D43F71D0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1537264563-19653-1-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0055140397=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1537264563-19653-1-git-send-email-Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
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
To: "Yu, Xiangliang" <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Min, Frank" <Frank.Min-5C7GfCeVMHo@public.gmane.org>

--===============0055140397==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809DAB6226CD941D9800D43F71D0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809DAB6226CD941D9800D43F71D0BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Series is:

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Xianglia=
ng Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, September 18, 2018 5:56:03 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Yu, Xiangliang; Min, Frank
Subject: [PATCH 1/2] drm/amdgpu: add vega20 sriov capability detection

From: Frank Min <Frank.Min-5C7GfCeVMHo@public.gmane.org>

Add sriov capability detection for vega20, then can check if device is
virtual device.

Signed-off-by: Frank Min <Frank.Min-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_4.c
index 2e65447..f8cee95 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -205,8 +205,19 @@ static const struct nbio_hdp_flush_reg nbio_v7_4_hdp_f=
lush_reg =3D {

 static void nbio_v7_4_detect_hw_virt(struct amdgpu_device *adev)
 {
-       if (is_virtual_machine())       /* passthrough mode exclus sriov mo=
d */
-               adev->virt.caps |=3D AMDGPU_PASSTHROUGH_MODE;
+       uint32_t reg;
+
+       reg =3D RREG32_SOC15(NBIO, 0, mmRCC_IOV_FUNC_IDENTIFIER);
+       if (reg & 1)
+               adev->virt.caps |=3D AMDGPU_SRIOV_CAPS_IS_VF;
+
+       if (reg & 0x80000000)
+               adev->virt.caps |=3D AMDGPU_SRIOV_CAPS_ENABLE_IOV;
+
+       if (!reg) {
+               if (is_virtual_machine())       /* passthrough mode exclus =
sriov mod */
+                       adev->virt.caps |=3D AMDGPU_PASSTHROUGH_MODE;
+       }
 }

 static void nbio_v7_4_init_registers(struct amdgpu_device *adev)
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org You can subscribe to the list, or change=
 your existing subscription, in the sections below.



--_000_BN6PR12MB1809DAB6226CD941D9800D43F71D0BN6PR12MB1809namp_
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
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size: 12pt; colo=
r: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFo=
nt&quot;, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoCo=
lorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymb=
ols;">
<p style=3D"margin-top:0; margin-bottom:0">Series is:<br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">Reviewed-by: Alex Deucher &lt;al=
exander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Xiangliang Yu &lt;Xianglian=
g.Yu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, September 18, 2018 5:56:03 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Yu, Xiangliang; Min, Frank<br>
<b>Subject:</b> [PATCH 1/2] drm/amdgpu: add vega20 sriov capability detecti=
on</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">From: Frank Min &lt;Frank.Min-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Add sriov capability detection for vega20, then can check if device is<br>
virtual device.<br>
<br>
Signed-off-by: Frank Min &lt;Frank.Min-5C7GfCeVMHo@public.gmane.org&gt;<br>
Signed-off-by: Xiangliang Yu &lt;Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 15 &#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<br>
&nbsp;1 file changed, 13 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_4.c<br>
index 2e65447..f8cee95 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<br>
@@ -205,8 &#43;205,19 @@ static const struct nbio_hdp_flush_reg nbio_v7_4_h=
dp_flush_reg =3D {<br>
&nbsp;<br>
&nbsp;static void nbio_v7_4_detect_hw_virt(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_virtual_machine())&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; /* passthrough mode exclus sriov mod */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;virt.caps |=3D AMDGPU_PASSTHROUGH_MODE;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D RREG32_SOC15(NBIO, 0, mmR=
CC_IOV_FUNC_IDENTIFIER);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (reg &amp; 1)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;virt.caps |=3D AMDGPU_SRIOV_CAPS_IS_VF;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (reg &amp; 0x80000000)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;virt.caps |=3D AMDGPU_SRIOV_CAPS_ENABLE_IOV;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!reg) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (is_virtual_machine())&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /* passthrough mode exclus sriov mod */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vir=
t.caps |=3D AMDGPU_PASSTHROUGH_MODE;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void nbio_v7_4_init_registers(struct amdgpu_device *adev)<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk885788" class=3D"OWAAutoLink" previewremoved=3D"true">https://lists.free=
desktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15372804152960.8296961064802353" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15372804152910.20274386836632818" style=3D"width: =
90%; background-color: rgb(255, 255, 255); position: relative; overflow: au=
to; padding-top: 20px; padding-bottom: 20px; margin-top: 20px; border-top: =
1px dotted rgb(200, 200, 200); border-bottom: 1px dotted rgb(200, 200, 200)=
;" role=3D"presentation" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td id=3D"TextCell_15372804152920.9083858010860605" style=3D"vertical-align=
: top; position: relative; padding: 0px; display: table-cell;" colspan=3D"2=
">
<div id=3D"LPRemovePreviewContainer_15372804152930.9251240967637734"></div>
<div id=3D"LPTitle_15372804152930.42943841693937224" style=3D"top: 0px; col=
or: rgb(0, 120, 215); font-weight: 400; font-size: 21px; font-family: &quot=
;wf_segoe-ui_light&quot;, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&=
quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-seri=
f; line-height: 21px;">
<a id=3D"LPUrlAnchor_15372804152940.9187358876714641" style=3D"text-decorat=
ion: none;" href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 target=3D"_blank">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15372804152940.9460074817537815" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot=
;wf_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Taho=
ma, Arial, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15372804152960.8151952695998103" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot;wf_=
segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, =
Arial, sans-serif; font-size: 14px; line-height: 20px; max-height: 100px; o=
verflow: hidden;">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org You can subscribe to the list, or change=
 your existing subscription, in
 the sections below.</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN6PR12MB1809DAB6226CD941D9800D43F71D0BN6PR12MB1809namp_--

--===============0055140397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0055140397==--
