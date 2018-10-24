From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amd/powerplay: support hwmon max/min fan speed
 setting on Vega20
Date: Wed, 24 Oct 2018 08:37:28 +0000
Message-ID: <BYAPR12MB277564C5DF32AFE83E33F7D8FBF60@BYAPR12MB2775.namprd12.prod.outlook.com>
References: <20181024081141.18647-1-evan.quan@amd.com>,
 <20181024081141.18647-3-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0412365939=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181024081141.18647-3-evan.quan-5C7GfCeVMHo@public.gmane.org>
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

--===============0412365939==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB277564C5DF32AFE83E33F7D8FBF60BYAPR12MB2775namp_"

--_000_BYAPR12MB277564C5DF32AFE83E33F7D8FBF60BYAPR12MB2775namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

-       percent =3D current_rpm * 100 / pp_table->FanMaximumRpm;
+       percent =3D (current_rpm * 100) /
+               hwmgr->thermal_controller.fanInfo.ulMaxRPM;


Better check hwmgr->thermal_controller.fanInfo.ulMaxRPM not equal to 0.


Best Regards

Rex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Evan Qua=
n <evan.quan-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, October 24, 2018 4:11 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Quan, Evan
Subject: [PATCH 3/3] drm/amd/powerplay: support hwmon max/min fan speed set=
ting on Vega20

Added support for hwmon max/min fan speed setting on Vega20.

Change-Id: Ieab42c744d6c54f8b85a71be80f7c6832ae7352b
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
---
 .../drm/amd/powerplay/hwmgr/vega20_hwmgr.c    |  4 ++
 .../drm/amd/powerplay/hwmgr/vega20_thermal.c  | 56 ++++++++++++++++++-
 .../drm/amd/powerplay/hwmgr/vega20_thermal.h  |  4 ++
 3 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index 57143d51e3ee..2513e6be3219 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
@@ -3539,6 +3539,10 @@ static const struct pp_hwmgr_func vega20_hwmgr_funcs=
 =3D {
                 vega20_get_fan_control_mode,
         .set_fan_control_mode =3D
                 vega20_set_fan_control_mode,
+       .set_fan_speed_max_rpm =3D
+               vega20_fan_ctrl_set_fan_speed_max_rpm,
+       .set_fan_speed_min_rpm =3D
+               vega20_fan_ctrl_set_fan_speed_min_rpm,
         /* smu memory related */
         .notify_cac_buffer_info =3D
                 vega20_notify_cac_buffer_info,
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c
index ede54e87e287..da9fd2168dcb 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c
@@ -118,7 +118,6 @@ int vega20_fan_ctrl_get_fan_speed_percent(struct pp_hwm=
gr *hwmgr,
                 uint32_t *speed)
 {
         struct vega20_hwmgr *data =3D (struct vega20_hwmgr *)(hwmgr->backe=
nd);
-       PPTable_t *pp_table =3D &(data->smc_state_table.pp_table);
         uint32_t current_rpm, percent =3D 0;
         int ret =3D 0;

@@ -126,7 +125,8 @@ int vega20_fan_ctrl_get_fan_speed_percent(struct pp_hwm=
gr *hwmgr,
         if (ret)
                 return ret;

-       percent =3D current_rpm * 100 / pp_table->FanMaximumRpm;
+       percent =3D (current_rpm * 100) /
+               hwmgr->thermal_controller.fanInfo.ulMaxRPM;

         *speed =3D percent > 100 ? 100 : percent;

@@ -208,6 +208,58 @@ int vega20_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr =
*hwmgr, uint32_t speed)
         return vega20_fan_ctrl_set_static_mode(hwmgr, FDO_PWM_MODE_STATIC_=
RPM);
 }

+int vega20_fan_ctrl_set_fan_speed_max_rpm(struct pp_hwmgr *hwmgr, uint32_t=
 speed)
+{
+       struct vega20_hwmgr *data =3D (struct vega20_hwmgr *)(hwmgr->backen=
d);
+       struct vega20_od8_settings *od8_settings =3D &(data->od8_settings);
+       int ret =3D 0;
+
+       if ((od8_settings->overdrive8_capabilities & OD8_ACOUSTIC_LIMIT_SCL=
K) &&
+           (speed > od8_settings->od8_settings_array[OD8_SETTING_FAN_ACOUS=
TIC_LIMIT].max_value ||
+            speed < od8_settings->od8_settings_array[OD8_SETTING_FAN_ACOUS=
TIC_LIMIT].min_value))
+               return -EINVAL;
+
+       ret =3D smum_send_msg_to_smc_with_parameter(hwmgr,
+                       PPSMC_MSG_SetFanMaxRpm,
+                       speed);
+       PP_ASSERT_WITH_CODE(!ret,
+                       "Set FanMaxRpm Failed!",
+                       return ret);
+
+       hwmgr->thermal_controller.fanInfo.ulMinRPM =3D
+               (speed * hwmgr->thermal_controller.fanInfo.ulMinPWM) / 255;
+
+       return ret;
+}
+
+int vega20_fan_ctrl_set_fan_speed_min_rpm(struct pp_hwmgr *hwmgr, uint32_t=
 speed)
+{
+       struct vega20_hwmgr *data =3D (struct vega20_hwmgr *)(hwmgr->backen=
d);
+       struct vega20_od8_settings *od8_settings =3D &(data->od8_settings);
+       int ret =3D 0;
+       uint32_t pwm =3D 0;
+
+       if ((od8_settings->overdrive8_capabilities & OD8_FAN_SPEED_MIN) &&
+           (speed > od8_settings->od8_settings_array[OD8_FAN_SPEED_MIN].ma=
x_value ||
+            speed < od8_settings->od8_settings_array[OD8_FAN_SPEED_MIN].mi=
n_value))
+               return -EINVAL;
+
+       if (speed > hwmgr->thermal_controller.fanInfo.ulMaxRPM)
+               return -EINVAL;
+
+       pwm =3D (speed * 255) / hwmgr->thermal_controller.fanInfo.ulMaxRPM;
+       ret =3D smum_send_msg_to_smc_with_parameter(hwmgr,
+                       PPSMC_MSG_SetFanMinPwm,
+                       pwm);
+       PP_ASSERT_WITH_CODE(!ret,
+                       "Set FanMinPwm Failed!",
+                       return ret);
+
+       hwmgr->thermal_controller.fanInfo.ulMinPWM =3D pwm;
+
+       return ret;
+}
+
 /**
 * Reads the remote temperature from the SIslands thermal controller.
 *
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.h b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.h
index 2d1769bbd24e..ddfc950e90ca 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.h
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.h
@@ -56,6 +56,10 @@ extern int vega20_fan_ctrl_get_fan_speed_rpm(struct pp_h=
wmgr *hwmgr,
                 uint32_t *speed);
 extern int vega20_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr,
                 uint32_t speed);
+extern int vega20_fan_ctrl_set_fan_speed_max_rpm(struct pp_hwmgr *hwmgr,
+               uint32_t speed);
+extern int vega20_fan_ctrl_set_fan_speed_min_rpm(struct pp_hwmgr *hwmgr,
+               uint32_t speed);
 extern int vega20_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwmgr,
                 uint32_t *speed);
 extern int vega20_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
--
2.19.1

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



--_000_BYAPR12MB277564C5DF32AFE83E33F7D8FBF60BYAPR12MB2775namp_
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
<p style=3D"margin-top:0;margin-bottom:0"><font size=3D"2"><span style=3D"f=
ont-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; percent =3D current_r=
pm * 100 / pp_table-&gt;FanMaximumRpm;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; percent =3D (current_rpm * 100) /=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;thermal_controller.fanInfo.ulMaxRPM;</span></font>=
<br>
</p>
<br>
<p style=3D"margin-top:0;margin-bottom:0">Better check <font size=3D"2"><sp=
an style=3D"font-size:11pt;">hwmgr-&gt;thermal_controller.fanInfo.ulMaxRPM<=
/span></font> not equal to 0.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex<br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> amd-gfx &lt;amd-gfx-=
bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.=
com&gt;<br>
<b>Sent:</b> Wednesday, October 24, 2018 4:11 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Quan, Evan<br>
<b>Subject:</b> [PATCH 3/3] drm/amd/powerplay: support hwmon max/min fan sp=
eed setting on Vega20</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Added support for hwmon max/min fan speed setting =
on Vega20.<br>
<br>
Change-Id: Ieab42c744d6c54f8b85a71be80f7c6832ae7352b<br>
Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;.../drm/amd/powerplay/hwmgr/vega20_hwmgr.c&nbsp;&nbsp;&nbsp; |&nbsp; =
4 &#43;&#43;<br>
&nbsp;.../drm/amd/powerplay/hwmgr/vega20_thermal.c&nbsp; | 56 &#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;-<br>
&nbsp;.../drm/amd/powerplay/hwmgr/vega20_thermal.h&nbsp; |&nbsp; 4 &#43;&#4=
3;<br>
&nbsp;3 files changed, 62 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
index 57143d51e3ee..2513e6be3219 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
@@ -3539,6 &#43;3539,10 @@ static const struct pp_hwmgr_func vega20_hwmgr_f=
uncs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vega20_get_fan_control_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_control_mode =3D<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vega20_set_fan_control_mode,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_speed_max_rpm =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vega20_fan_ctrl_set_fan_speed_max_rpm,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_speed_min_rpm =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vega20_fan_ctrl_set_fan_speed_min_rpm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* smu memory related */<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .notify_cac_buffer_info =
=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vega20_notify_cac_buffer_info,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c<br>
index ede54e87e287..da9fd2168dcb 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.c<br>
@@ -118,7 &#43;118,6 @@ int vega20_fan_ctrl_get_fan_speed_percent(struct pp=
_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t *speed)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_hwmgr *data =
=3D (struct vega20_hwmgr *)(hwmgr-&gt;backend);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPTable_t *pp_table =3D &amp;(data-&g=
t;smc_state_table.pp_table);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t current_rpm, perc=
ent =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
@@ -126,7 &#43;125,8 @@ int vega20_fan_ctrl_get_fan_speed_percent(struct pp=
_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; percent =3D current_rpm * 100 / pp_ta=
ble-&gt;FanMaximumRpm;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; percent =3D (current_rpm * 100) /=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;thermal_controller.fanInfo.ulMaxRPM;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *speed =3D percent &gt; 10=
0 ? 100 : percent;<br>
&nbsp;<br>
@@ -208,6 &#43;208,58 @@ int vega20_fan_ctrl_set_fan_speed_rpm(struct pp_hw=
mgr *hwmgr, uint32_t speed)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return vega20_fan_ctrl_set=
_static_mode(hwmgr, FDO_PWM_MODE_STATIC_RPM);<br>
&nbsp;}<br>
&nbsp;<br>
&#43;int vega20_fan_ctrl_set_fan_speed_max_rpm(struct pp_hwmgr *hwmgr, uint=
32_t speed)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_hwmgr *data =3D (st=
ruct vega20_hwmgr *)(hwmgr-&gt;backend);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_od8_settings *od8_s=
ettings =3D &amp;(data-&gt;od8_settings);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((od8_settings-&gt;overdrive8_=
capabilities &amp; OD8_ACOUSTIC_LIMIT_SCLK) &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (speed &g=
t; od8_settings-&gt;od8_settings_array[OD8_SETTING_FAN_ACOUSTIC_LIMIT].max_=
value ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spe=
ed &lt; od8_settings-&gt;od8_settings_array[OD8_SETTING_FAN_ACOUSTIC_LIMIT]=
.min_value))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smum_send_msg_to_smc_with=
_parameter(hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_Se=
tFanMaxRpm,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; speed);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!ret,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Set Fa=
nMaxRpm Failed!&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret);=
<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;thermal_controller.fanI=
nfo.ulMinRPM =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; (speed * hwmgr-&gt;thermal_controller.fanInfo.ulMinPWM) / 25=
5;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&#43;int vega20_fan_ctrl_set_fan_speed_min_rpm(struct pp_hwmgr *hwmgr, uint=
32_t speed)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_hwmgr *data =3D (st=
ruct vega20_hwmgr *)(hwmgr-&gt;backend);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_od8_settings *od8_s=
ettings =3D &amp;(data-&gt;od8_settings);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pwm =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((od8_settings-&gt;overdrive8_=
capabilities &amp; OD8_FAN_SPEED_MIN) &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (speed &g=
t; od8_settings-&gt;od8_settings_array[OD8_FAN_SPEED_MIN].max_value ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spe=
ed &lt; od8_settings-&gt;od8_settings_array[OD8_FAN_SPEED_MIN].min_value))<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (speed &gt; hwmgr-&gt;thermal_=
controller.fanInfo.ulMaxRPM)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pwm =3D (speed * 255) / hwmgr-&gt=
;thermal_controller.fanInfo.ulMaxRPM;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smum_send_msg_to_smc_with=
_parameter(hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_Se=
tFanMinPwm,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pwm);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!ret,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Set Fa=
nMinPwm Failed!&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret);=
<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;thermal_controller.fanI=
nfo.ulMinPWM =3D pwm;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&nbsp;/**<br>
&nbsp;* Reads the remote temperature from the SIslands thermal controller.<=
br>
&nbsp;*<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.h b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.h<br>
index 2d1769bbd24e..ddfc950e90ca 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_thermal.h<br>
@@ -56,6 &#43;56,10 @@ extern int vega20_fan_ctrl_get_fan_speed_rpm(struct =
pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t *speed);<br>
&nbsp;extern int vega20_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t speed);<br>
&#43;extern int vega20_fan_ctrl_set_fan_speed_max_rpm(struct pp_hwmgr *hwmg=
r,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; uint32_t speed);<br>
&#43;extern int vega20_fan_ctrl_set_fan_speed_min_rpm(struct pp_hwmgr *hwmg=
r,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; uint32_t speed);<br>
&nbsp;extern int vega20_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwm=
gr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t *speed);<br>
&nbsp;extern int vega20_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwm=
gr,<br>
-- <br>
2.19.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk381309" class=3D"OWAAutoLink" previewremoved=3D"true">https://lists.free=
desktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15403701438120.35346562924862934" style=3D"margin-bo=
ttom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15403701438100.09324088395310604" style=3D"width: =
90%; background-color: rgb(255, 255, 255); position: relative; overflow: au=
to; padding-top: 20px; padding-bottom: 20px; margin-top: 20px; border-top: =
1px dotted rgb(200, 200, 200); border-bottom: 1px dotted rgb(200, 200, 200)=
;" role=3D"presentation" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td id=3D"TextCell_15403701438100.42838297273526393" style=3D"vertical-alig=
n: top; position: relative; padding: 0px; display: table-cell;" colspan=3D"=
2">
<div id=3D"LPRemovePreviewContainer_15403701438100.12312966594444197"></div=
>
<div id=3D"LPTitle_15403701438100.6054106554689949" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: 400; font-size: 21px; font-family: &quot;=
wf_segoe-ui_light&quot;, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&q=
uot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif=
; line-height: 21px;">
<a id=3D"LPUrlAnchor_15403701438120.9937893318723561" style=3D"text-decorat=
ion: none;" href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 target=3D"_blank">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15403701438120.035970050768817985" style=3D"margin: 1=
0px 0px 16px; color: rgb(102, 102, 102); font-weight: 400; font-family: &qu=
ot;wf_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Ta=
homa, Arial, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15403701438120.9681582559548375" style=3D"display:=
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
</div>
</body>
</html>

--_000_BYAPR12MB277564C5DF32AFE83E33F7D8FBF60BYAPR12MB2775namp_--

--===============0412365939==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0412365939==--
