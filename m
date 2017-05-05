From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Fw: [PATCH 4/5] drm/amd/powerplay: refine pwm1_enable callback
 functions on vi.
Date: Fri, 5 May 2017 12:43:39 +0000
Message-ID: <CY4PR12MB1687F6302E45B425C0CA894BFBEB0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1493978213-19943-1-git-send-email-Rex.Zhu@amd.com>,
 <1493978213-19943-4-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1386709110=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1493978213-19943-4-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

--===============1386709110==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687F6302E45B425C0CA894BFBEB0CY4PR12MB1687namp_"

--_000_CY4PR12MB1687F6302E45B425C0CA894BFBEB0CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Change-Id: I72d61851630e5d4ff5b3236ca33abac6f5b200c6
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   | 35 ++++++++++++------=
----
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c |  9 +++---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.h |  2 +-
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |  1 +
 4 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index b3d4285..a74a3db 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -4334,26 +4334,31 @@ static int smu7_print_clock_levels(struct pp_hwmgr =
*hwmgr,

 static int smu7_set_fan_control_mode(struct pp_hwmgr *hwmgr, uint32_t mode=
)
 {
-       if (mode) {
-               /* stop auto-manage */
-               if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps=
,
-                               PHM_PlatformCaps_MicrocodeFanControl))
-                       smu7_fan_ctrl_stop_smc_fan_control(hwmgr);
-               smu7_fan_ctrl_set_static_mode(hwmgr, mode);
-       } else
-               /* restart auto-manage */
-               smu7_fan_ctrl_reset_fan_speed_to_default(hwmgr);
+       int result =3D 0;

-       return 0;
+       switch (mode) {
+       case AMD_FAN_CTRL_NONE:
+               result =3D smu7_fan_ctrl_set_fan_speed_percent(hwmgr, 100);
+               break;
+       case AMD_FAN_CTRL_MANUAL:
+               if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps=
,
+                       PHM_PlatformCaps_MicrocodeFanControl))
+                       result =3D smu7_fan_ctrl_stop_smc_fan_control(hwmgr=
);
+               break;
+       case AMD_FAN_CTRL_AUTO:
+               result =3D smu7_fan_ctrl_set_static_mode(hwmgr, mode);
+               if (!result)
+                       result =3D smu7_fan_ctrl_start_smc_fan_control(hwmg=
r);
+               break;
+       default:
+               break;
+       }
+       return result;
 }

 static int smu7_get_fan_control_mode(struct pp_hwmgr *hwmgr)
 {
-       if (hwmgr->fan_ctrl_is_in_default_mode)
-               return hwmgr->fan_ctrl_default_mode;
-       else
-               return PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_=
REG__SMC,
-                               CG_FDO_CTRL2, FDO_PWM_MODE);
+       return hwmgr->fan_ctrl_enabled ? AMD_FAN_CTRL_AUTO : AMD_FAN_CTRL_M=
ANUAL;
 }

 static int smu7_get_sclk_od(struct pp_hwmgr *hwmgr)
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/smu7_thermal.c
index 436ca5c..baddb56 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c
@@ -112,10 +112,9 @@ int smu7_fan_ctrl_get_fan_speed_rpm(struct pp_hwmgr *h=
wmgr, uint32_t *speed)
 */
 int smu7_fan_ctrl_set_static_mode(struct pp_hwmgr *hwmgr, uint32_t mode)
 {
-
         if (hwmgr->fan_ctrl_is_in_default_mode) {
                 hwmgr->fan_ctrl_default_mode =3D
-                               PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device,=
     CGS_IND_REG__SMC,
+                               PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device,=
 CGS_IND_REG__SMC,
                                                 CG_FDO_CTRL2, FDO_PWM_MODE=
);
                 hwmgr->tmin =3D
                                 PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device=
, CGS_IND_REG__SMC,
@@ -149,7 +148,7 @@ int smu7_fan_ctrl_set_default_mode(struct pp_hwmgr *hwm=
gr)
         return 0;
 }

-static int smu7_fan_ctrl_start_smc_fan_control(struct pp_hwmgr *hwmgr)
+int smu7_fan_ctrl_start_smc_fan_control(struct pp_hwmgr *hwmgr)
 {
         int result;

@@ -179,6 +178,7 @@ static int smu7_fan_ctrl_start_smc_fan_control(struct p=
p_hwmgr *hwmgr)
                                 PPSMC_MSG_SetFanTemperatureTarget,
                                 hwmgr->thermal_controller.
                                 advanceFanControlParameters.ucTargetTemper=
ature);
+       hwmgr->fan_ctrl_enabled =3D true;

         return result;
 }
@@ -186,6 +186,7 @@ static int smu7_fan_ctrl_start_smc_fan_control(struct p=
p_hwmgr *hwmgr)

 int smu7_fan_ctrl_stop_smc_fan_control(struct pp_hwmgr *hwmgr)
 {
+       hwmgr->fan_ctrl_enabled =3D false;
         return smum_send_msg_to_smc(hwmgr->smumgr, PPSMC_StopFanControl);
 }

@@ -280,7 +281,7 @@ int smu7_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hw=
mgr, uint32_t speed)
         PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC,
                                 CG_TACH_STATUS, TACH_PERIOD, tach_period);

-       return smu7_fan_ctrl_set_static_mode(hwmgr, FDO_PWM_MODE_STATIC);
+       return smu7_fan_ctrl_set_static_mode(hwmgr, FDO_PWM_MODE_STATIC_RPM=
);
 }

 /**
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.h b/drivers/g=
pu/drm/amd/powerplay/hwmgr/smu7_thermal.h
index 2ed774d..ba71b60 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.h
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.h
@@ -54,6 +54,6 @@
 extern int smu7_fan_ctrl_stop_smc_fan_control(struct pp_hwmgr *hwmgr);
 extern int smu7_thermal_enable_alert(struct pp_hwmgr *hwmgr);
 extern int smu7_thermal_disable_alert(struct pp_hwmgr *hwmgr);
-
+extern int smu7_fan_ctrl_start_smc_fan_control(struct pp_hwmgr *hwmgr);
 #endif

diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h
index e4574c2..805b9df 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
@@ -764,6 +764,7 @@ struct pp_hwmgr {
         struct pp_thermal_controller_info thermal_controller;
         bool fan_ctrl_is_in_default_mode;
         uint32_t fan_ctrl_default_mode;
+       bool fan_ctrl_enabled;
         uint32_t tmin;
         struct phm_microcode_version_info microcode_version_info;
         uint32_t ps_size;
--
1.9.1


--_000_CY4PR12MB1687F6302E45B425C0CA894BFBEB0CY4PR12MB1687namp_
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
<div style=3D"color: rgb(0, 0, 0);">
<div>
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr">
<div></div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Change-Id: I72d61851630e5d4ff5b3236ca33abac6f5b200c6<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c&nbsp;&nbsp; | 35 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;----------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c |&nbsp; 9 &#43;&#4=
3;&#43;---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.h |&nbsp; 2 &#43;-<b=
r>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/hwmgr.h&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 &#43;<br>
&nbsp;4 files changed, 27 insertions(&#43;), 20 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
index b3d4285..a74a3db 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
@@ -4334,26 &#43;4334,31 @@ static int smu7_print_clock_levels(struct pp_hw=
mgr *hwmgr,<br>
&nbsp;<br>
&nbsp;static int smu7_set_fan_control_mode(struct pp_hwmgr *hwmgr, uint32_t=
 mode)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mode) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* stop auto-manage */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (phm_cap_enabled(hwmgr-&gt;platform_descriptor.platformCaps,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_PlatformCaps_MicrocodeFanControl))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_fan_ctrl_st=
op_smc_fan_control(hwmgr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu7_fan_ctrl_set_static_mode(hwmgr, mode);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* restart auto-manage */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu7_fan_ctrl_reset_fan_speed_to_default(hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (mode) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_FAN_CTRL_NONE:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; result =3D smu7_fan_ctrl_set_fan_speed_percent(hwmgr, 100);<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_FAN_CTRL_MANUAL:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (phm_cap_enabled(hwmgr-&gt;platform_descriptor.platformCa=
ps,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_Platform=
Caps_MicrocodeFanControl))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D s=
mu7_fan_ctrl_stop_smc_fan_control(hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_FAN_CTRL_AUTO:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; result =3D smu7_fan_ctrl_set_static_mode(hwmgr, mode);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!result)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D s=
mu7_fan_ctrl_start_smc_fan_control(hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int smu7_get_fan_control_mode(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;fan_ctrl_is_in_default_=
mode)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return hwmgr-&gt;fan_ctrl_default_mode;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return PHM_READ_VFPF_INDIRECT_FIELD(hwmgr-&gt;device, CGS_IND_RE=
G__SMC,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CG_FDO_CTRL2, FDO_PWM_MODE);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr-&gt;fan_ctrl_enabled=
 ? AMD_FAN_CTRL_AUTO : AMD_FAN_CTRL_MANUAL;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int smu7_get_sclk_od(struct pp_hwmgr *hwmgr)<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/smu7_thermal.c<br>
index 436ca5c..baddb56 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c<br>
@@ -112,10 &#43;112,9 @@ int smu7_fan_ctrl_get_fan_speed_rpm(struct pp_hwmg=
r *hwmgr, uint32_t *speed)<br>
&nbsp;*/<br>
&nbsp;int smu7_fan_ctrl_set_static_mode(struct pp_hwmgr *hwmgr, uint32_t mo=
de)<br>
&nbsp;{<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;fan_ctrl_is_=
in_default_mode) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;fan_ctrl_default_mode =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_READ_VFPF_INDIRECT_FIELD(hwmgr-&gt;devi=
ce,&nbsp;&nbsp;&nbsp;&nbsp; CGS_IND_REG__SMC,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_READ_VFPF_INDIRECT_FIELD(hwmgr-&gt;=
device, CGS_IND_REG__SMC,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CG_FDO_CTRL=
2, FDO_PWM_MODE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;tmin =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_READ_VFPF_INDIRECT_FIELD(hwm=
gr-&gt;device, CGS_IND_REG__SMC,<br>
@@ -149,7 &#43;148,7 @@ int smu7_fan_ctrl_set_default_mode(struct pp_hwmgr =
*hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static int smu7_fan_ctrl_start_smc_fan_control(struct pp_hwmgr *hwmgr)<br>
&#43;int smu7_fan_ctrl_start_smc_fan_control(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result;<br>
&nbsp;<br>
@@ -179,6 &#43;178,7 @@ static int smu7_fan_ctrl_start_smc_fan_control(stru=
ct pp_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SetFanTemperatureTarge=
t,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;thermal_controller.<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; advanceFanControlParameters.ucTa=
rgetTemperature);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;fan_ctrl_enabled =3D tr=
ue;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&nbsp;}<br>
@@ -186,6 &#43;186,7 @@ static int smu7_fan_ctrl_start_smc_fan_control(stru=
ct pp_hwmgr *hwmgr)<br>
&nbsp;<br>
&nbsp;int smu7_fan_ctrl_stop_smc_fan_control(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;fan_ctrl_enabled =3D fa=
lse;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smum_send_msg_to_sm=
c(hwmgr-&gt;smumgr, PPSMC_StopFanControl);<br>
&nbsp;}<br>
&nbsp;<br>
@@ -280,7 &#43;281,7 @@ int smu7_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr=
 *hwmgr, uint32_t speed)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_WRITE_VFPF_INDIRECT_FI=
ELD(hwmgr-&gt;device, CGS_IND_REG__SMC,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CG_TACH_STATUS, TACH_PERIOD, tac=
h_period);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu7_fan_ctrl_set_static_mode(=
hwmgr, FDO_PWM_MODE_STATIC);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu7_fan_ctrl_set_static_m=
ode(hwmgr, FDO_PWM_MODE_STATIC_RPM);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.h b/drivers/g=
pu/drm/amd/powerplay/hwmgr/smu7_thermal.h<br>
index 2ed774d..ba71b60 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.h<br>
@@ -54,6 &#43;54,6 @@<br>
&nbsp;extern int smu7_fan_ctrl_stop_smc_fan_control(struct pp_hwmgr *hwmgr)=
;<br>
&nbsp;extern int smu7_thermal_enable_alert(struct pp_hwmgr *hwmgr);<br>
&nbsp;extern int smu7_thermal_disable_alert(struct pp_hwmgr *hwmgr);<br>
-<br>
&#43;extern int smu7_fan_ctrl_start_smc_fan_control(struct pp_hwmgr *hwmgr)=
;<br>
&nbsp;#endif<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h<br>
index e4574c2..805b9df 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
@@ -764,6 &#43;764,7 @@ struct pp_hwmgr {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_thermal_controll=
er_info thermal_controller;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool fan_ctrl_is_in_defaul=
t_mode;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t fan_ctrl_default_=
mode;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool fan_ctrl_enabled;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmin;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_microcode_versi=
on_info microcode_version_info;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ps_size;<br>
-- <br>
1.9.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB1687F6302E45B425C0CA894BFBEB0CY4PR12MB1687namp_--

--===============1386709110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1386709110==--
