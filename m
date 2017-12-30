From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/4] drm/amd/powerplay: remove unused parameter of
 phm_start_thermal_controller
Date: Sat, 30 Dec 2017 18:31:14 +0000
Message-ID: <BN6PR12MB1652FB809C0FE26E36E11B16F71A0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1514533479-14038-1-git-send-email-evan.quan@amd.com>,
 <1514533479-14038-2-git-send-email-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1863159777=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1514533479-14038-2-git-send-email-evan.quan-5C7GfCeVMHo@public.gmane.org>
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

--===============1863159777==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652FB809C0FE26E36E11B16F71A0BN6PR12MB1652namp_"

--_000_BN6PR12MB1652FB809C0FE26E36E11B16F71A0BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Should this be used to set the default critical temperatures?  IIRC, they w=
ere set to 0 until last week when someone sent a patch to fix them.


Alex


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Evan Qua=
n <evan.quan-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, December 29, 2017 2:44 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Quan, Evan
Subject: [PATCH 2/4] drm/amd/powerplay: remove unused parameter of phm_star=
t_thermal_controller

Change-Id: Id6039cb50b73bdf8a6df37e5383f4bea4ae737ed
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c | 14 +++-----------
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c           |  4 ++--
 drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h   |  2 +-
 3 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c b/driver=
s/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
index 623cff9..cba0aee 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
@@ -220,20 +220,12 @@ int phm_register_thermal_interrupt(struct pp_hwmgr *h=
wmgr, const void *info)
 * Initializes the thermal controller subsystem.
 *
 * @param    pHwMgr  the address of the powerplay hardware manager.
-* @param    pTemperatureRange the address of the structure holding the tem=
perature range.
 * @exception PP_Result_Failed if any of the paramters is NULL, otherwise t=
he return value from the dispatcher.
 */
-int phm_start_thermal_controller(struct pp_hwmgr *hwmgr, struct PP_Tempera=
tureRange *temperature_range)
+int phm_start_thermal_controller(struct pp_hwmgr *hwmgr)
 {
-       struct PP_TemperatureRange range;
-
-       if (temperature_range =3D=3D NULL) {
-               range.max =3D TEMP_RANGE_MAX;
-               range.min =3D TEMP_RANGE_MIN;
-       } else {
-               range.max =3D temperature_range->max;
-               range.min =3D temperature_range->min;
-       }
+       struct PP_TemperatureRange range =3D {{TEMP_RANGE_MIN, TEMP_RANGE_M=
AX}};
+
         if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
                         PHM_PlatformCaps_ThermalController)
                         && hwmgr->hwmgr_func->start_thermal_controller !=
=3D NULL)
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/=
amd/powerplay/hwmgr/hwmgr.c
index 08b7963..38f7d0d 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
@@ -265,7 +265,7 @@ int hwmgr_hw_init(struct pp_instance *handle)
         ret =3D phm_enable_dynamic_state_management(hwmgr);
         if (ret)
                 goto err2;
-       ret =3D phm_start_thermal_controller(hwmgr, NULL);
+       ret =3D phm_start_thermal_controller(hwmgr);
         ret |=3D psm_set_performance_states(hwmgr);
         if (ret)
                 goto err2;
@@ -345,7 +345,7 @@ int hwmgr_hw_resume(struct pp_instance *handle)
         ret =3D phm_enable_dynamic_state_management(hwmgr);
         if (ret)
                 return ret;
-       ret =3D phm_start_thermal_controller(hwmgr, NULL);
+       ret =3D phm_start_thermal_controller(hwmgr);
         if (ret)
                 return ret;

diff --git a/drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h b/drivers/=
gpu/drm/amd/powerplay/inc/hardwaremanager.h
index b8bd86b..7489003 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h
@@ -407,7 +407,7 @@ extern int phm_force_dpm_levels(struct pp_hwmgr *hwmgr,=
 enum amd_dpm_forced_leve
 extern int phm_display_configuration_changed(struct pp_hwmgr *hwmgr);
 extern int phm_notify_smc_display_config_after_ps_adjustment(struct pp_hwm=
gr *hwmgr);
 extern int phm_register_thermal_interrupt(struct pp_hwmgr *hwmgr, const vo=
id *info);
-extern int phm_start_thermal_controller(struct pp_hwmgr *hwmgr, struct PP_=
TemperatureRange *temperature_range);
+extern int phm_start_thermal_controller(struct pp_hwmgr *hwmgr);
 extern int phm_stop_thermal_controller(struct pp_hwmgr *hwmgr);
 extern bool phm_check_smc_update_required_for_display_configuration(struct=
 pp_hwmgr *hwmgr);

--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1652FB809C0FE26E36E11B16F71A0BN6PR12MB1652namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Should this be used to set the de=
fault critical temperatures?&nbsp; IIRC, they were set to 0 until last week=
 when someone sent a patch to fix them.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Evan Quan &lt;evan.quan@amd=
.com&gt;<br>
<b>Sent:</b> Friday, December 29, 2017 2:44 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Quan, Evan<br>
<b>Subject:</b> [PATCH 2/4] drm/amd/powerplay: remove unused parameter of p=
hm_start_thermal_controller</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Change-Id: Id6039cb50b73bdf8a6df37e5383f4bea4ae737=
ed<br>
Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c | 14 &#43;&#43;=
&#43;-----------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 &#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h&nbsp;&nbsp; |&nbs=
p; 2 &#43;-<br>
&nbsp;3 files changed, 6 insertions(&#43;), 14 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c b/driver=
s/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c<br>
index 623cff9..cba0aee 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c<br>
@@ -220,20 &#43;220,12 @@ int phm_register_thermal_interrupt(struct pp_hwmg=
r *hwmgr, const void *info)<br>
&nbsp;* Initializes the thermal controller subsystem.<br>
&nbsp;*<br>
&nbsp;* @param&nbsp;&nbsp;&nbsp; pHwMgr&nbsp; the address of the powerplay =
hardware manager.<br>
-* @param&nbsp;&nbsp;&nbsp; pTemperatureRange the address of the structure =
holding the temperature range.<br>
&nbsp;* @exception PP_Result_Failed if any of the paramters is NULL, otherw=
ise the return value from the dispatcher.<br>
&nbsp;*/<br>
-int phm_start_thermal_controller(struct pp_hwmgr *hwmgr, struct PP_Tempera=
tureRange *temperature_range)<br>
&#43;int phm_start_thermal_controller(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct PP_TemperatureRange range;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (temperature_range =3D=3D NULL) {<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; range.max =3D TEMP_RANGE_MAX;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; range.min =3D TEMP_RANGE_MIN;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; range.max =3D temperature_range-&gt;max;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; range.min =3D temperature_range-&gt;min;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct PP_TemperatureRange range =
=3D {{TEMP_RANGE_MIN, TEMP_RANGE_MAX}};<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (phm_cap_enabled(hwmgr-=
&gt;platform_descriptor.platformCaps,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_P=
latformCaps_ThermalController)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
&amp; hwmgr-&gt;hwmgr_func-&gt;start_thermal_controller !=3D NULL)<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/=
amd/powerplay/hwmgr/hwmgr.c<br>
index 08b7963..38f7d0d 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
@@ -265,7 &#43;265,7 @@ int hwmgr_hw_init(struct pp_instance *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D phm_enable_dynamic=
_state_management(hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto err2;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D phm_start_thermal_controller(=
hwmgr, NULL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D phm_start_thermal_control=
ler(hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret |=3D psm_set_performan=
ce_states(hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto err2;<br>
@@ -345,7 &#43;345,7 @@ int hwmgr_hw_resume(struct pp_instance *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D phm_enable_dynamic=
_state_management(hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D phm_start_thermal_controller(=
hwmgr, NULL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D phm_start_thermal_control=
ler(hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h b/drivers/=
gpu/drm/amd/powerplay/inc/hardwaremanager.h<br>
index b8bd86b..7489003 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h<br>
@@ -407,7 &#43;407,7 @@ extern int phm_force_dpm_levels(struct pp_hwmgr *hw=
mgr, enum amd_dpm_forced_leve<br>
&nbsp;extern int phm_display_configuration_changed(struct pp_hwmgr *hwmgr);=
<br>
&nbsp;extern int phm_notify_smc_display_config_after_ps_adjustment(struct p=
p_hwmgr *hwmgr);<br>
&nbsp;extern int phm_register_thermal_interrupt(struct pp_hwmgr *hwmgr, con=
st void *info);<br>
-extern int phm_start_thermal_controller(struct pp_hwmgr *hwmgr, struct PP_=
TemperatureRange *temperature_range);<br>
&#43;extern int phm_start_thermal_controller(struct pp_hwmgr *hwmgr);<br>
&nbsp;extern int phm_stop_thermal_controller(struct pp_hwmgr *hwmgr);<br>
&nbsp;extern bool phm_check_smc_update_required_for_display_configuration(s=
truct pp_hwmgr *hwmgr);<br>
&nbsp;<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk358679" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB1652FB809C0FE26E36E11B16F71A0BN6PR12MB1652namp_--

--===============1863159777==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1863159777==--
