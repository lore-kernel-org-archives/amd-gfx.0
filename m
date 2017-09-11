From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 16/16] drm/amd/powerplay: Tidy up
 vega10_thermal_initialize()
Date: Mon, 11 Sep 2017 11:06:44 +0000
Message-ID: <CY4PR12MB1687DC291D785FD451540E5BFB680@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <20170908160149.9349-1-tom.stdenis@amd.com>,
 <20170908160149.9349-17-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2079024147=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170908160149.9349-17-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2079024147==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687DC291D785FD451540E5BFB680CY4PR12MB1687namp_"

--_000_CY4PR12MB1687DC291D785FD451540E5BFB680CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Series is:
Reviewed-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>



Best Regards

Rex



________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Tom St D=
enis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Sent: Saturday, September 9, 2017 12:01 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: StDenis, Tom
Subject: [PATCH 16/16] drm/amd/powerplay: Tidy up vega10_thermal_initialize=
()

Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c
index d5d676595f10..5b3c443d4e94 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c
@@ -429,19 +429,16 @@ static int vega10_thermal_initialize(struct pp_hwmgr =
*hwmgr)
                 reg =3D soc15_get_register_offset(THM_HWID, 0,
                                 mmCG_TACH_CTRL_BASE_IDX, mmCG_TACH_CTRL);
                 cgs_write_register(hwmgr->device, reg,
-                               (cgs_read_register(hwmgr->device, reg) &
-                               ~CG_TACH_CTRL__EDGE_PER_REV_MASK) |
-                               ((hwmgr->thermal_controller.fanInfo.
-                               ucTachometerPulsesPerRevolution - 1) <<
-                               CG_TACH_CTRL__EDGE_PER_REV__SHIFT));
+                       CGS_REG_SET_FIELD(cgs_read_register(hwmgr->device, =
reg),
+                               CG_TACH_CTRL, EDGE_PER_REV,
+                               hwmgr->thermal_controller.fanInfo.ucTachome=
terPulsesPerRevolution - 1));
         }

         reg =3D soc15_get_register_offset(THM_HWID, 0,
                         mmCG_FDO_CTRL2_BASE_IDX, mmCG_FDO_CTRL2);
         cgs_write_register(hwmgr->device, reg,
-                       (cgs_read_register(hwmgr->device, reg) &
-                       ~CG_FDO_CTRL2__TACH_PWM_RESP_RATE_MASK) |
-                       (0x28 << CG_FDO_CTRL2__TACH_PWM_RESP_RATE__SHIFT));
+               CGS_REG_SET_FIELD(cgs_read_register(hwmgr->device, reg),
+                       CG_FDO_CTRL2, TACH_PWM_RESP_RATE, 0x28));

         return 0;
 }
--
2.12.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...



--_000_CY4PR12MB1687DC291D785FD451540E5BFB680CY4PR12MB1687namp_
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
<p></p>
<div>Series is:<br>
Reviewed-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</div>
<p></p>
<p><br>
</p>
<p><br>
</p>
<p>Best Regards</p>
<p>Rex<br>
</p>
<p><br>
</p>
<p><font size=3D"2"><span style=3D"font-size:10pt;"></span></font><span><sp=
an></span></span><br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" colo=
r=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Tom St Denis &lt;tom.stdeni=
s@amd.com&gt;<br>
<b>Sent:</b> Saturday, September 9, 2017 12:01 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> StDenis, Tom<br>
<b>Subject:</b> [PATCH 16/16] drm/amd/powerplay: Tidy up vega10_thermal_ini=
tialize()</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Signed-off-by: Tom St Denis &lt;tom.stdenis-urvtwAKJhsc@public.gmane.org=
m&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c | 13 &#43;&#43;&=
#43;&#43;&#43;--------<br>
&nbsp;1 file changed, 5 insertions(&#43;), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c<br>
index d5d676595f10..5b3c443d4e94 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c<br>
@@ -429,19 &#43;429,16 @@ static int vega10_thermal_initialize(struct pp_hw=
mgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(THM_HWID, 0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCG_TACH_CTRL_BASE_IDX, mmCG_TA=
CH_CTRL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, reg,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (cgs_read_register(hwmgr-&gt;device, reg) &=
amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~CG_TACH_CTRL__EDGE_PER_REV_MASK) |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((hwmgr-&gt;thermal_controller.fanInfo.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ucTachometerPulsesPerRevolution - 1) &lt;&l=
t;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CG_TACH_CTRL__EDGE_PER_REV__SHIFT));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGS_REG_SET_=
FIELD(cgs_read_register(hwmgr-&gt;device, reg),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CG_TACH_CTRL, EDGE_PER_REV,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;thermal_controller.fanInfo.uc=
TachometerPulsesPerRevolution - 1));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register=
_offset(THM_HWID, 0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCG_=
FDO_CTRL2_BASE_IDX, mmCG_FDO_CTRL2);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&=
gt;device, reg,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (cgs_read_regist=
er(hwmgr-&gt;device, reg) &amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~CG_FDO_CTRL2__T=
ACH_PWM_RESP_RATE_MASK) |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x28 &lt;&lt; C=
G_FDO_CTRL2__TACH_PWM_RESP_RATE__SHIFT));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; CGS_REG_SET_FIELD(cgs_read_register(hwmgr-&gt;device, reg),<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CG_FDO_CTRL2=
, TACH_PWM_RESP_RATE, 0x28));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
-- <br>
2.12.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a previewremoved=3D"true" id=3D"LPlnk257147" href=3D"https://lists.freedes=
ktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div style=3D"margin-bottom: 20px; overflow: auto; width: 100%; text-indent=
: 0px;" id=3D"LPBorder_GT_15051270193460.6331715354292681">
<table role=3D"presentation" style=3D"width: 90%; background-color: rgb(255=
, 255, 255); position: relative; overflow: auto; padding-top: 20px; padding=
-bottom: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200);=
 border-bottom: 1px dotted rgb(200, 200, 200);" id=3D"LPContainer_150512701=
93430.08215395543104731" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td colspan=3D"2" style=3D"vertical-align: top; position: relative; padding=
: 0px; display: table-cell;" id=3D"TextCell_15051270193450.8434762655037125=
">
<div id=3D"LPRemovePreviewContainer_15051270193450.019914902208305496"></di=
v>
<div style=3D"top: 0px; color: rgb(0, 120, 215); font-weight: 400; font-siz=
e: 21px; font-family: &quot;wf_segoe-ui_light&quot;,&quot;Segoe UI Light&qu=
ot;,&quot;Segoe WP Light&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Ta=
homa,Arial,sans-serif; line-height: 21px;" id=3D"LPTitle_15051270193450.431=
8257709761001">
<a target=3D"_blank" href=3D"https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx" style=3D"text-decoration: none;" id=3D"LPUrlAnchor_15051270193450=
.4794142730862342">amd-gfx Info Page - freedesktop.org</a></div>
<div style=3D"margin: 10px 0px 16px; color: rgb(102, 102, 102); font-weight=
: 400; font-family: &quot;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&qu=
ot;Segoe WP&quot;,Tahoma,Arial,sans-serif; font-size: 14px; line-height: 14=
px;" id=3D"LPMetadata_15051270193450.2295830383996682">
lists.freedesktop.org</div>
<div style=3D"display: block; color: rgb(102, 102, 102); font-weight: 400; =
font-family: &quot;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Sego=
e WP&quot;,Tahoma,Arial,sans-serif; font-size: 14px; line-height: 20px; max=
-height: 100px; overflow: hidden;" id=3D"LPDescription_15051270193450.33281=
9494062337">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...</div>
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

--_000_CY4PR12MB1687DC291D785FD451540E5BFB680CY4PR12MB1687namp_--

--===============2079024147==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2079024147==--
