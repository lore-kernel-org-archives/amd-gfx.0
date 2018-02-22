From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: fix thermal interrupts on vega10
Date: Thu, 22 Feb 2018 19:08:14 +0000
Message-ID: <BN6PR12MB16522BCA6C9D1CE7D0D8BDBAF7CD0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1519323690-22004-1-git-send-email-JinHuiEric.Huang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1952106990=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1519323690-22004-1-git-send-email-JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
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
To: "Huang, JinHuiEric" <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1952106990==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB16522BCA6C9D1CE7D0D8BDBAF7CD0BN6PR12MB1652namp_"

--_000_BN6PR12MB16522BCA6C9D1CE7D0D8BDBAF7CD0BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Eric Hua=
ng <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, February 22, 2018 1:21 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Huang, JinHuiEric
Subject: [PATCH] drm/amd/powerplay: fix thermal interrupts on vega10

a bug in programming thermal interrupt register masks out
interrupts and driver cannot receive interrupts. Setting
0 to mask bits will fix it.

Signed-off-by: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c
index 7491163..eb6e965 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c
@@ -409,7 +409,9 @@ static int vega10_thermal_set_temperature_range(struct =
pp_hwmgr *hwmgr,
         val =3D CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_E=
NA, 1);
         val =3D CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INT=
H, (high / PP_TEMPERATURE_UNITS_PER_CENTIGRADES));
         val =3D CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INT=
L, (low / PP_TEMPERATURE_UNITS_PER_CENTIGRADES));
-       val =3D val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
+       val &=3D (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK) &
+                       (~THM_THERMAL_INT_CTRL__THERM_INTH_MASK_MASK) &
+                       (~THM_THERMAL_INT_CTRL__THERM_INTL_MASK_MASK);

         cgs_write_register(hwmgr->device, reg, val);

--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB16522BCA6C9D1CE7D0D8BDBAF7CD0BN6PR12MB1652namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Eric Huang &lt;JinHuiEric.H=
uang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, February 22, 2018 1:21 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Huang, JinHuiEric<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: fix thermal interrupts on vega10=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">a bug in programming thermal interrupt register ma=
sks out<br>
interrupts and driver cannot receive interrupts. Setting<br>
0 to mask bits will fix it.<br>
<br>
Signed-off-by: Eric Huang &lt;JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c | 4 &#43;&#43;&#=
43;-<br>
&nbsp;1 file changed, 3 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c<br>
index 7491163..eb6e965 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c<br>
@@ -409,7 &#43;409,9 @@ static int vega10_thermal_set_temperature_range(str=
uct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D CGS_REG_SET_FIELD(=
val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D CGS_REG_SET_FIELD(=
val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, (high / PP_TEMPERATURE_UNITS_PER=
_CENTIGRADES));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D CGS_REG_SET_FIELD(=
val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, (low / PP_TEMPERATURE_UNITS_PER_=
CENTIGRADES));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D val &amp; (~THM_THERMAL_INT_C=
TRL__THERM_TRIGGER_MASK_MASK);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val &amp;=3D (~THM_THERMAL_INT_CT=
RL__THERM_TRIGGER_MASK_MASK) &amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (~THM_THERMA=
L_INT_CTRL__THERM_INTH_MASK_MASK) &amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (~THM_THERMA=
L_INT_CTRL__THERM_INTL_MASK_MASK);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&=
gt;device, reg, val);<br>
&nbsp;<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk875302" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB16522BCA6C9D1CE7D0D8BDBAF7CD0BN6PR12MB1652namp_--

--===============1952106990==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1952106990==--
