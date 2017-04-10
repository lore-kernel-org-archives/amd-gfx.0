From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/gfx8: move MEC doorbell range setting
Date: Mon, 10 Apr 2017 17:50:00 +0000
Message-ID: <CY4PR12MB16879949ED3C0FDA063C8EA3FB010@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1491843722-11864-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1646533730=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1491843722-11864-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

--===============1646533730==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB16879949ED3C0FDA063C8EA3FB010CY4PR12MB1687namp_"

--_000_CY4PR12MB16879949ED3C0FDA063C8EA3FB010CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Patch was Tested-by and Reviewed-by:  Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>


Best Regards

Rex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Alex Deu=
cher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, April 11, 2017 1:02:02 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander
Subject: [PATCH] drm/amdgpu/gfx8: move MEC doorbell range setting

It's global, not queue specific, so move it out of the
kiq register init function.

Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c
index d3633cb..9bff7a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4930,20 +4930,6 @@ static int gfx_v8_0_kiq_init_register(struct amdgpu_=
ring *ring)
         WREG32(mmCP_HQD_PQ_WPTR_POLL_ADDR, mqd->cp_hqd_pq_wptr_poll_addr_l=
o);
         WREG32(mmCP_HQD_PQ_WPTR_POLL_ADDR_HI, mqd->cp_hqd_pq_wptr_poll_add=
r_hi);

-       /* enable the doorbell if requested */
-       if (ring->use_doorbell) {
-               if ((adev->asic_type =3D=3D CHIP_CARRIZO) ||
-                   (adev->asic_type =3D=3D CHIP_FIJI) ||
-                   (adev->asic_type =3D=3D CHIP_STONEY) ||
-                   (adev->asic_type =3D=3D CHIP_POLARIS10) ||
-                   (adev->asic_type =3D=3D CHIP_POLARIS11) ||
-                   (adev->asic_type =3D=3D CHIP_POLARIS12)) {
-                       WREG32(mmCP_MEC_DOORBELL_RANGE_LOWER,
-                                               AMDGPU_DOORBELL_KIQ << 2);
-                       WREG32(mmCP_MEC_DOORBELL_RANGE_UPPER,
-                                               AMDGPU_DOORBELL_MEC_RING7 <=
< 2);
-               }
-       }
         WREG32(mmCP_HQD_PQ_DOORBELL_CONTROL, mqd->cp_hqd_pq_doorbell_contr=
ol);

         /* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
@@ -5070,6 +5056,18 @@ static int gfx_v8_0_kiq_resume(struct amdgpu_device =
*adev)
                         goto done;
         }

+       if ((adev->asic_type =3D=3D CHIP_CARRIZO) ||
+           (adev->asic_type =3D=3D CHIP_FIJI) ||
+           (adev->asic_type =3D=3D CHIP_STONEY) ||
+           (adev->asic_type =3D=3D CHIP_POLARIS10) ||
+           (adev->asic_type =3D=3D CHIP_POLARIS11) ||
+           (adev->asic_type =3D=3D CHIP_POLARIS12)) {
+               WREG32(mmCP_MEC_DOORBELL_RANGE_LOWER,
+                      AMDGPU_DOORBELL_KIQ << 2);
+               WREG32(mmCP_MEC_DOORBELL_RANGE_UPPER,
+                      AMDGPU_DOORBELL_MEC_RING7 << 2);
+       }
+
         r =3D gfx_v8_0_kiq_kcq_enable(adev);
         if (r)
                 goto done;
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




--_000_CY4PR12MB16879949ED3C0FDA063C8EA3FB010CY4PR12MB1687namp_
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
<div>
<div><br>
</div>
<div>
<p style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size: =
16px;">Patch was&nbsp;Tested-by and Reviewed-by: &nbsp;Rex Zhu &lt;Rex.Zhu@=
amd.com&gt;<span style=3D"color: rgb(255, 255, 255); font-size: 13.3333px; =
background-color: rgb(216, 35, 0);"></span></p>
<p style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size: =
16px;"><br>
</p>
<p style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size: =
16px;">Best Regards</p>
<p style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size: =
16px;">Rex</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Alex Deucher &lt;alexdeuche=
r@gmail.com&gt;<br>
<b>Sent:</b> Tuesday, April 11, 2017 1:02:02 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> [PATCH] drm/amdgpu/gfx8: move MEC doorbell range setting</f=
ont>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">It's global, not queue specific, so move it out of=
 the<br>
kiq register init function.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 26 &#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;--------------<br>
&nbsp;1 file changed, 12 insertions(&#43;), 14 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c<br>
index d3633cb..9bff7a9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
@@ -4930,20 &#43;4930,6 @@ static int gfx_v8_0_kiq_init_register(struct amd=
gpu_ring *ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP_HQD_PQ_WPTR_PO=
LL_ADDR, mqd-&gt;cp_hqd_pq_wptr_poll_addr_lo);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP_HQD_PQ_WPTR_PO=
LL_ADDR_HI, mqd-&gt;cp_hqd_pq_wptr_poll_addr_hi);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable the doorbell if requested *=
/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;use_doorbell) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((adev-&gt;asic_type =3D=3D CHIP_CARRIZO) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type =3D=3D CHIP_FIJI) ||=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type =3D=3D CHIP_STONEY) =
||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type =3D=3D CHIP_POLARIS1=
0) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type =3D=3D CHIP_POLARIS1=
1) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type =3D=3D CHIP_POLARIS1=
2)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP_MEC_=
DOORBELL_RANGE_LOWER,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_KIQ &l=
t;&lt; 2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP_MEC_=
DOORBELL_RANGE_UPPER,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_MEC_RI=
NG7 &lt;&lt; 2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP_HQD_PQ_DOORBEL=
L_CONTROL, mqd-&gt;cp_hqd_pq_doorbell_control);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* reset read and write po=
inters, similar to CP_RB0_WPTR/_RPTR */<br>
@@ -5070,6 &#43;5056,18 @@ static int gfx_v8_0_kiq_resume(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
done;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;asic_type =3D=3D CH=
IP_CARRIZO) ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt=
;asic_type =3D=3D CHIP_FIJI) ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt=
;asic_type =3D=3D CHIP_STONEY) ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt=
;asic_type =3D=3D CHIP_POLARIS10) ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt=
;asic_type =3D=3D CHIP_POLARIS11) ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt=
;asic_type =3D=3D CHIP_POLARIS12)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(mmCP_MEC_DOORBELL_RANGE_LOWER,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_KI=
Q &lt;&lt; 2);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(mmCP_MEC_DOORBELL_RANGE_UPPER,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL_ME=
C_RING7 &lt;&lt; 2);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D gfx_v8_0_kiq_kcq_ena=
ble(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto done;<br>
-- <br>
2.5.5<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk719840" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_14918465006200.5341002836357802" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_14918465006170.8145173422526568" cellspacing=3D"0"=
 style=3D"width: 90%; position: relative; overflow: auto; padding-top: 20px=
; padding-bottom: 20px; margin-top: 20px; border-top-width: 1px; border-top=
-style: dotted; border-top-color: rgb(200, 200, 200); border-bottom-width: =
1px; border-bottom-style: dotted; border-bottom-color: rgb(200, 200, 200); =
background-color: rgb(255, 255, 255);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_14918465006180.8883486734703183" colspan=3D"2" style=3D"=
vertical-align: top; position: relative; padding: 0px; display: table-cell;=
">
<div id=3D"LPRemovePreviewContainer_14918465006180.9254352936986834"></div>
<div id=3D"LPTitle_14918465006180.7526611653156579" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: normal; font-size: 21px; font-family: wf_=
segoe-ui_light, 'Segoe UI Light', 'Segoe WP Light', 'Segoe UI', 'Segoe WP',=
 Tahoma, Arial, sans-serif; line-height: 21px;">
<a id=3D"LPUrlAnchor_14918465006180.6247792565263808" href=3D"https://lists=
.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-=
decoration: none;">amd-gfx Info Page - lists.freedesktop.org</a></div>
<div id=3D"LPMetadata_14918465006180.8303352994844317" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: wf=
_segoe-ui_normal, 'Segoe UI', 'Segoe WP', Tahoma, Arial, sans-serif; font-s=
ize: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_14918465006200.8823355177883059" style=3D"display:=
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

--_000_CY4PR12MB16879949ED3C0FDA063C8EA3FB010CY4PR12MB1687namp_--

--===============1646533730==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1646533730==--
