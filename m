From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: get real current gfxclk frequency
 instead of dpm level value
Date: Tue, 10 Apr 2018 05:25:33 +0000
Message-ID: <CY4PR12MB1687EE3DDBA3278BC669AE29FBBE0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1523336920-27223-1-git-send-email-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0323174931=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1523336920-27223-1-git-send-email-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0323174931==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687EE3DDBA3278BC669AE29FBBE0CY4PR12MB1687namp_"

--_000_CY4PR12MB1687EE3DDBA3278BC669AE29FBBE0CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

You can add descriptions like:


fix bug read wrong engine clock when in deep sleep.



Reviewed-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>


Best Regards

Rex


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Evan Qua=
n <evan.quan-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, April 10, 2018 1:08 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Quan, Evan; Zhu, Rex
Subject: [PATCH] drm/amd/powerplay: get real current gfxclk frequency inste=
ad of dpm level value

Change-Id: Ie9a684d018f9ed43e3baadc6ba2c7525da97d659
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 13 ++++---------
 drivers/gpu/drm/amd/powerplay/inc/vega10_ppsmc.h   |  1 +
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
index 5fc2f20..b8102c4 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -3799,7 +3799,7 @@ static int vega10_read_sensor(struct pp_hwmgr *hwmgr,=
 int idx,
                               void *value, int *size)
 {
         struct amdgpu_device *adev =3D hwmgr->adev;
-       uint32_t sclk_idx, mclk_idx, activity_percent =3D 0;
+       uint32_t sclk_mhz, mclk_idx, activity_percent =3D 0;
         struct vega10_hwmgr *data =3D hwmgr->backend;
         struct vega10_dpm_table *dpm_table =3D &data->dpm_table;
         int ret =3D 0;
@@ -3807,14 +3807,9 @@ static int vega10_read_sensor(struct pp_hwmgr *hwmgr=
, int idx,

         switch (idx) {
         case AMDGPU_PP_SENSOR_GFX_SCLK:
-               smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentGfxclkIndex=
);
-               sclk_idx =3D smum_get_argument(hwmgr);
-               if (sclk_idx <  dpm_table->gfx_table.count) {
-                       *((uint32_t *)value) =3D dpm_table->gfx_table.dpm_l=
evels[sclk_idx].value;
-                       *size =3D 4;
-               } else {
-                       ret =3D -EINVAL;
-               }
+               smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetAverageGfxclkActua=
lFrequency);
+               sclk_mhz =3D smum_get_argument(hwmgr);
+               *((uint32_t *)value) =3D sclk_mhz * 100;
                 break;
         case AMDGPU_PP_SENSOR_GFX_MCLK:
                 smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentUclkIndex)=
;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/vega10_ppsmc.h b/drivers/gpu=
/drm/amd/powerplay/inc/vega10_ppsmc.h
index c3ed737..715b5a1 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/vega10_ppsmc.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/vega10_ppsmc.h
@@ -131,6 +131,7 @@ typedef uint16_t PPSMC_Result;
 #define PPSMC_MSG_RunAcgInOpenLoop               0x5E
 #define PPSMC_MSG_InitializeAcg                  0x5F
 #define PPSMC_MSG_GetCurrPkgPwr                  0x61
+#define PPSMC_MSG_GetAverageGfxclkActualFrequency 0x63
 #define PPSMC_MSG_SetPccThrottleLevel            0x67
 #define PPSMC_MSG_UpdatePkgPwrPidAlpha           0x68
 #define PPSMC_Message_Count                      0x69
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of Conduct.



--_000_CY4PR12MB1687EE3DDBA3278BC669AE29FBBE0CY4PR12MB1687namp_
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
<p style=3D"margin-top:0;margin-bottom:0">You can add&nbsp;<span>descriptio=
ns like:</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span>fix bug read wrong engine c=
lock when in deep sleep.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
<span></span></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><span>Reviewed-by:</span> <span>R=
ex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> amd-gfx &lt;amd-gfx-=
bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.=
com&gt;<br>
<b>Sent:</b> Tuesday, April 10, 2018 1:08 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Quan, Evan; Zhu, Rex<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: get real current gfxclk frequenc=
y instead of dpm level value</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Change-Id: Ie9a684d018f9ed43e3baadc6ba2c7525da97d6=
59<br>
Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 13 &#43;&#43;&#4=
3;&#43;---------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/vega10_ppsmc.h&nbsp;&nbsp; |&nbsp; =
1 &#43;<br>
&nbsp;2 files changed, 5 insertions(&#43;), 9 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
index 5fc2f20..b8102c4 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
@@ -3799,7 &#43;3799,7 @@ static int vega10_read_sensor(struct pp_hwmgr *hw=
mgr, int idx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *value, int *size)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D hwmgr-&gt;adev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sclk_idx, mclk_idx, activity=
_percent =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sclk_mhz, mclk_idx, acti=
vity_percent =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_hwmgr *data =
=3D hwmgr-&gt;backend;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_dpm_table *d=
pm_table =3D &amp;data-&gt;dpm_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -3807,14 &#43;3807,9 @@ static int vega10_read_sensor(struct pp_hwmgr *h=
wmgr, int idx,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (idx) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_GFX_=
SCLK:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentGfxclkIndex);<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sclk_idx =3D smum_get_argument(hwmgr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (sclk_idx &lt;&nbsp; dpm_table-&gt;gfx_table.count) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *((uint32_t *)va=
lue) =3D dpm_table-&gt;gfx_table.dpm_levels[sclk_idx].value;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *size =3D 4;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D -EINVAL;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetAverageGfxclkActual=
Frequency);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; sclk_mhz =3D smum_get_argument(hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *((uint32_t *)value) =3D sclk_mhz * 100;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_GFX_=
MCLK:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentUclkI=
ndex);<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/vega10_ppsmc.h b/drivers/gpu=
/drm/amd/powerplay/inc/vega10_ppsmc.h<br>
index c3ed737..715b5a1 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/vega10_ppsmc.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/vega10_ppsmc.h<br>
@@ -131,6 &#43;131,7 @@ typedef uint16_t PPSMC_Result;<br>
&nbsp;#define PPSMC_MSG_RunAcgInOpenLoop&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x5E<br>
&nbsp;#define PPSMC_MSG_InitializeAcg&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x5F<br>
&nbsp;#define PPSMC_MSG_GetCurrPkgPwr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x61<br>
&#43;#define PPSMC_MSG_GetAverageGfxclkActualFrequency 0x63<br>
&nbsp;#define PPSMC_MSG_SetPccThrottleLevel&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x67<br>
&nbsp;#define PPSMC_MSG_UpdatePkgPwrPidAlpha&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x68<br>
&nbsp;#define PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x69<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a previewremoved=3D"true" id=3D"LPlnk763949" href=3D"https://lists.freedes=
ktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div style=3D"margin-bottom: 20px; overflow: auto; width: 100%; text-indent=
: 0px;" id=3D"LPBorder_GT_15233364713540.7310393612879407">
<table role=3D"presentation" style=3D"width: 90%; background-color: rgb(255=
, 255, 255); position: relative; overflow: auto; padding-top: 20px; padding=
-bottom: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200);=
 border-bottom: 1px dotted rgb(200, 200, 200);" id=3D"LPContainer_152333647=
13520.42625979668606295" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td colspan=3D"2" style=3D"vertical-align: top; position: relative; padding=
: 0px; display: table-cell;" id=3D"TextCell_15233364713530.4830316004163536=
">
<div id=3D"LPRemovePreviewContainer_15233364713530.430401111716639"></div>
<div style=3D"top: 0px; color: rgb(0, 120, 215); font-weight: 400; font-siz=
e: 21px; font-family: &quot;wf_segoe-ui_light&quot;,&quot;Segoe UI Light&qu=
ot;,&quot;Segoe WP Light&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Ta=
homa,Arial,sans-serif; line-height: 21px;" id=3D"LPTitle_15233364713530.895=
3525699777491">
<a target=3D"_blank" href=3D"https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx" style=3D"text-decoration: none;" id=3D"LPUrlAnchor_15233364713530=
.07407912196749844">amd-gfx Info Page - freedesktop.org</a></div>
<div style=3D"margin: 10px 0px 16px; color: rgb(102, 102, 102); font-weight=
: 400; font-family: &quot;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&qu=
ot;Segoe WP&quot;,Tahoma,Arial,sans-serif; font-size: 14px; line-height: 14=
px;" id=3D"LPMetadata_15233364713540.5144975367752683">
lists.freedesktop.org</div>
<div style=3D"display: block; color: rgb(102, 102, 102); font-weight: 400; =
font-family: &quot;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Sego=
e WP&quot;,Tahoma,Arial,sans-serif; font-size: 14px; line-height: 20px; max=
-height: 100px; overflow: hidden;" id=3D"LPDescription_15233364713540.58459=
60638327531">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of Conduct.</d=
iv>
</td>
</tr>
</tbody>
</table>
</div>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1687EE3DDBA3278BC669AE29FBBE0CY4PR12MB1687namp_--

--===============0323174931==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0323174931==--
