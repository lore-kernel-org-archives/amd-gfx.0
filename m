From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Fw: [PATCH 3/5] drm/amd/powerplay: refine pwm1_enable callback
 functions on vega10.
Date: Fri, 5 May 2017 12:44:17 +0000
Message-ID: <CY4PR12MB1687C4B56C80ACF9BB9CF3B3FBEB0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1493978213-19943-1-git-send-email-Rex.Zhu@amd.com>,
 <1493978213-19943-3-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1290522079=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1493978213-19943-3-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

--===============1290522079==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687C4B56C80ACF9BB9CF3B3FBEB0CY4PR12MB1687namp_"

--_000_CY4PR12MB1687C4B56C80ACF9BB9CF3B3FBEB0CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Change-Id: Ib8681558cabab99da804d1d10987aca63435b1e5
Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 43 ++++++++++++------=
----
 .../gpu/drm/amd/powerplay/hwmgr/vega10_thermal.h   |  1 +
 2 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
index 625ee9d..9fef840 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -3962,32 +3962,37 @@ static int vega10_dpm_force_dpm_level(struct pp_hwm=
gr *hwmgr,

 static int vega10_set_fan_control_mode(struct pp_hwmgr *hwmgr, uint32_t mo=
de)
 {
-       if (mode) {
-               /* stop auto-manage */
-               if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps=
,
-                               PHM_PlatformCaps_MicrocodeFanControl))
-                       vega10_fan_ctrl_stop_smc_fan_control(hwmgr);
-               vega10_fan_ctrl_set_static_mode(hwmgr, mode);
-       } else
-               /* restart auto-manage */
-               vega10_fan_ctrl_reset_fan_speed_to_default(hwmgr);
+       int result =3D 0;

-       return 0;
+       switch (mode) {
+       case AMD_FAN_CTRL_NONE:
+               result =3D vega10_fan_ctrl_set_fan_speed_percent(hwmgr, 100=
);
+               break;
+       case AMD_FAN_CTRL_MANUAL:
+               if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps=
,
+                       PHM_PlatformCaps_MicrocodeFanControl))
+                       result =3D vega10_fan_ctrl_stop_smc_fan_control(hwm=
gr);
+               break;
+       case AMD_FAN_CTRL_AUTO:
+               result =3D vega10_fan_ctrl_set_static_mode(hwmgr, mode);
+               if (!result)
+                       result =3D vega10_fan_ctrl_start_smc_fan_control(hw=
mgr);
+               break;
+       default:
+               break;
+       }
+       return result;
 }

 static int vega10_get_fan_control_mode(struct pp_hwmgr *hwmgr)
 {
         uint32_t reg;
+       struct vega10_hwmgr *data =3D (struct vega10_hwmgr *)(hwmgr->backen=
d);

-       if (hwmgr->fan_ctrl_is_in_default_mode) {
-               return hwmgr->fan_ctrl_default_mode;
-       } else {
-               reg =3D soc15_get_register_offset(THM_HWID, 0,
-                       mmCG_FDO_CTRL2_BASE_IDX, mmCG_FDO_CTRL2);
-               return (cgs_read_register(hwmgr->device, reg) &
-                               CG_FDO_CTRL2__FDO_PWM_MODE_MASK) >>
-                               CG_FDO_CTRL2__FDO_PWM_MODE__SHIFT;
-       }
+       if (data->smu_features[GNLD_FAN_CONTROL].enabled =3D=3D false)
+               return AMD_FAN_CTRL_MANUAL;
+       else
+               return AMD_FAN_CTRL_AUTO;
 }

 static int vega10_get_dal_power_level(struct pp_hwmgr *hwmgr,
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.h b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.h
index 70c1d22..776f3a2 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.h
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.h
@@ -79,6 +79,7 @@ extern int vega10_fan_ctrl_get_fan_speed_rpm(struct pp_hw=
mgr *hwmgr,
 extern int vega10_fan_ctrl_stop_smc_fan_control(struct pp_hwmgr *hwmgr);
 extern uint32_t smu7_get_xclk(struct pp_hwmgr *hwmgr);
 extern int vega10_thermal_disable_alert(struct pp_hwmgr *hwmgr);
+int vega10_fan_ctrl_start_smc_fan_control(struct pp_hwmgr *hwmgr);

 #endif

--
1.9.1


--_000_CY4PR12MB1687C4B56C80ACF9BB9CF3B3FBEB0CY4PR12MB1687namp_
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
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size: 12pt; colo=
r: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica, sans-serif, EmojiF=
ont, 'Apple Color Emoji', 'Segoe UI Emoji', NotoColorEmoji, 'Segoe UI Symbo=
l', 'Android Emoji', EmojiSymbols;">
<p><br>
</p>
<div style=3D"color:rgb(0,0,0)">
<div>
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr">
<div></div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt">
<div class=3D"PlainText">Change-Id: Ib8681558cabab99da804d1d10987aca63435b1=
e5<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 43 &#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;----------<br>
&nbsp;.../gpu/drm/amd/powerplay/hwmgr/vega10_thermal.h&nbsp;&nbsp; |&nbsp; =
1 &#43;<br>
&nbsp;2 files changed, 25 insertions(&#43;), 19 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
index 625ee9d..9fef840 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
@@ -3962,32 &#43;3962,37 @@ static int vega10_dpm_force_dpm_level(struct pp=
_hwmgr *hwmgr,<br>
&nbsp;<br>
&nbsp;static int vega10_set_fan_control_mode(struct pp_hwmgr *hwmgr, uint32=
_t mode)<br>
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
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_fan_ctrl_=
stop_smc_fan_control(hwmgr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega10_fan_ctrl_set_static_mode(hwmgr, mode);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* restart auto-manage */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega10_fan_ctrl_reset_fan_speed_to_default(hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (mode) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_FAN_CTRL_NONE:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; result =3D vega10_fan_ctrl_set_fan_speed_percent(hwmgr, 100)=
;<br>
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
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D v=
ega10_fan_ctrl_stop_smc_fan_control(hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_FAN_CTRL_AUTO:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; result =3D vega10_fan_ctrl_set_static_mode(hwmgr, mode);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!result)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D v=
ega10_fan_ctrl_start_smc_fan_control(hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int vega10_get_fan_control_mode(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_hwmgr *data =3D (st=
ruct vega10_hwmgr *)(hwmgr-&gt;backend);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;fan_ctrl_is_in_default_=
mode) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return hwmgr-&gt;fan_ctrl_default_mode;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; reg =3D soc15_get_register_offset(THM_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCG_FDO_CTRL2_B=
ASE_IDX, mmCG_FDO_CTRL2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return (cgs_read_register(hwmgr-&gt;device, reg) &amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CG_FDO_CTRL2__FDO_PWM_MODE_MASK) &gt;&gt;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CG_FDO_CTRL2__FDO_PWM_MODE__SHIFT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;smu_features[GNLD_FA=
N_CONTROL].enabled =3D=3D false)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return AMD_FAN_CTRL_MANUAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return AMD_FAN_CTRL_AUTO;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int vega10_get_dal_power_level(struct pp_hwmgr *hwmgr,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.h b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.h<br>
index 70c1d22..776f3a2 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.h<br>
@@ -79,6 &#43;79,7 @@ extern int vega10_fan_ctrl_get_fan_speed_rpm(struct p=
p_hwmgr *hwmgr,<br>
&nbsp;extern int vega10_fan_ctrl_stop_smc_fan_control(struct pp_hwmgr *hwmg=
r);<br>
&nbsp;extern uint32_t smu7_get_xclk(struct pp_hwmgr *hwmgr);<br>
&nbsp;extern int vega10_thermal_disable_alert(struct pp_hwmgr *hwmgr);<br>
&#43;int vega10_fan_ctrl_start_smc_fan_control(struct pp_hwmgr *hwmgr);<br>
&nbsp;<br>
&nbsp;#endif<br>
&nbsp;<br>
-- <br>
1.9.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB1687C4B56C80ACF9BB9CF3B3FBEB0CY4PR12MB1687namp_--

--===============1290522079==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1290522079==--
