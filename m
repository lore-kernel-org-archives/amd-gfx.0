From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: Fix braces around scalar initializer
 warning
Date: Wed, 3 Jan 2018 21:12:35 +0000
Message-ID: <BN6PR12MB1652FD548D99F0820652FD22F71E0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <20180103205713.9625-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1373581251=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180103205713.9625-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1373581251==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652FD548D99F0820652FD22F71E0BN6PR12MB1652namp_"

--_000_BN6PR12MB1652FD548D99F0820652FD22F71E0BN6PR12MB1652namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Harry We=
ntland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, January 3, 2018 3:57 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Wentland, Harry
Subject: [PATCH] drm/amd/powerplay: Fix braces around scalar initializer wa=
rning

This fixes the following two warnings:

drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/hardwaremanager.c: In functio=
n =91phm_start_thermal_controller=92:
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/hardwaremanager.c:230:9: warn=
ing: braces around scalar initializer
  struct PP_TemperatureRange range =3D {{TEMP_RANGE_MIN, TEMP_RANGE_MAX}};
           ^~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/hardwaremanager.c:230:9: note=
: (near initialization for =91range.min=92)
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/hardwaremanager.c:31:24: warn=
ing: excess elements in scalar initializer
 #define TEMP_RANGE_MAX (80 * 1000)

Signed-off-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c b/driver=
s/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
index 297ec0db2ef5..e23f63ea07cd 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
@@ -227,7 +227,7 @@ int phm_register_thermal_interrupt(struct pp_hwmgr *hwm=
gr, const void *info)
 */
 int phm_start_thermal_controller(struct pp_hwmgr *hwmgr)
 {
-       struct PP_TemperatureRange range =3D {{TEMP_RANGE_MIN, TEMP_RANGE_M=
AX}};
+       struct PP_TemperatureRange range =3D {TEMP_RANGE_MIN, TEMP_RANGE_MA=
X};

         if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
                         PHM_PlatformCaps_ThermalController)
--
2.14.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1652FD548D99F0820652FD22F71E0BN6PR12MB1652namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Harry Wentland &lt;harry.we=
ntland-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, January 3, 2018 3:57 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Wentland, Harry<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: Fix braces around scalar initial=
izer warning</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This fixes the following two warnings:<br>
<br>
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/hardwaremanager.c: In functio=
n =91phm_start_thermal_controller=92:<br>
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/hardwaremanager.c:230:9: warn=
ing: braces around scalar initializer<br>
&nbsp; struct PP_TemperatureRange range =3D {{TEMP_RANGE_MIN, TEMP_RANGE_MA=
X}};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~~~~~~~~~~=
~~~~~<br>
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/hardwaremanager.c:230:9: note=
: (near initialization for =91range.min=92)<br>
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/hardwaremanager.c:31:24: warn=
ing: excess elements in scalar initializer<br>
&nbsp;#define TEMP_RANGE_MAX (80 * 1000)<br>
<br>
Signed-off-by: Harry Wentland &lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c b/driver=
s/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c<br>
index 297ec0db2ef5..e23f63ea07cd 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c<br>
@@ -227,7 &#43;227,7 @@ int phm_register_thermal_interrupt(struct pp_hwmgr =
*hwmgr, const void *info)<br>
&nbsp;*/<br>
&nbsp;int phm_start_thermal_controller(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct PP_TemperatureRange range =3D =
{{TEMP_RANGE_MIN, TEMP_RANGE_MAX}};<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct PP_TemperatureRange range =
=3D {TEMP_RANGE_MIN, TEMP_RANGE_MAX};<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (phm_cap_enabled(hwmgr-=
&gt;platform_descriptor.platformCaps,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_P=
latformCaps_ThermalController)<br>
-- <br>
2.14.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk625135" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB1652FD548D99F0820652FD22F71E0BN6PR12MB1652namp_--

--===============1373581251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1373581251==--
