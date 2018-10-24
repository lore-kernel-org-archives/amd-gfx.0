From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amd/powerplay: added hwmon interfaces for setting
 max/min fan speed
Date: Wed, 24 Oct 2018 08:36:21 +0000
Message-ID: <BYAPR12MB2775F650496C7DA583461501FBF60@BYAPR12MB2775.namprd12.prod.outlook.com>
References: <20181024081141.18647-1-evan.quan@amd.com>,
 <20181024081141.18647-2-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0206297104=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181024081141.18647-2-evan.quan-5C7GfCeVMHo@public.gmane.org>
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

--===============0206297104==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB2775F650496C7DA583461501FBF60BYAPR12MB2775namp_"

--_000_BYAPR12MB2775F650496C7DA583461501FBF60BYAPR12MB2775namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

One question: how to exit the max/min fan speed and return to auto mode?


Best Regards

Rex



________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Evan Qua=
n <evan.quan-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, October 24, 2018 4:11 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Quan, Evan
Subject: [PATCH 2/3] drm/amd/powerplay: added hwmon interfaces for setting =
max/min fan speed

New hwmon interfaces for maximum and minimum fan speed setting.

Change-Id: Ic9ec9f2427c6d3425e1c7e7b765d7d01a92f9a26
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h       |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c        | 56 ++++++++++++++++++-
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 46 +++++++++++++++
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h     |  2 +
 5 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_dpm.h
index f972cd156795..12c4e461a7bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
@@ -364,6 +364,12 @@ enum amdgpu_pcie_gen {
                 ((adev)->powerplay.pp_funcs->enable_mgpu_fan_boost(\
                         (adev)->powerplay.pp_handle))

+#define amdgpu_dpm_set_fan_speed_max_rpm(adev, s) \
+               ((adev)->powerplay.pp_funcs->set_fan_speed_max_rpm)((adev)-=
>powerplay.pp_handle, (s))
+
+#define amdgpu_dpm_set_fan_speed_min_rpm(adev, s) \
+               ((adev)->powerplay.pp_funcs->set_fan_speed_min_rpm)((adev)-=
>powerplay.pp_handle, (s))
+
 struct amdgpu_dpm {
         struct amdgpu_ps        *ps;
         /* number of valid power states */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c
index 8e94255654ed..92da37bb51ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1265,6 +1265,32 @@ static ssize_t amdgpu_hwmon_get_fan1_min(struct devi=
ce *dev,
         return snprintf(buf, PAGE_SIZE, "%d\n", min_rpm);
 }

+static ssize_t amdgpu_hwmon_set_fan1_min(struct device *dev,
+                                    struct device_attribute *attr,
+                                    const char *buf, size_t count)
+{
+       struct amdgpu_device *adev =3D dev_get_drvdata(dev);
+       int err;
+       u32 value;
+
+       /* Can't adjust fan when the card is off */
+       if  ((adev->flags & AMD_IS_PX) &&
+            (adev->ddev->switch_power_state !=3D DRM_SWITCH_POWER_ON))
+               return -EINVAL;
+
+       err =3D kstrtou32(buf, 10, &value);
+       if (err)
+               return err;
+
+       if (adev->powerplay.pp_funcs->set_fan_speed_min_rpm) {
+               err =3D amdgpu_dpm_set_fan_speed_min_rpm(adev, value);
+               if (err)
+                       return err;
+       }
+
+       return count;
+}
+
 static ssize_t amdgpu_hwmon_get_fan1_max(struct device *dev,
                                          struct device_attribute *attr,
                                          char *buf)
@@ -1285,6 +1311,32 @@ static ssize_t amdgpu_hwmon_get_fan1_max(struct devi=
ce *dev,
         return snprintf(buf, PAGE_SIZE, "%d\n", max_rpm);
 }

+static ssize_t amdgpu_hwmon_set_fan1_max(struct device *dev,
+                                    struct device_attribute *attr,
+                                    const char *buf, size_t count)
+{
+       struct amdgpu_device *adev =3D dev_get_drvdata(dev);
+       int err;
+       u32 value;
+
+       /* Can't adjust fan when the card is off */
+       if  ((adev->flags & AMD_IS_PX) &&
+            (adev->ddev->switch_power_state !=3D DRM_SWITCH_POWER_ON))
+               return -EINVAL;
+
+       err =3D kstrtou32(buf, 10, &value);
+       if (err)
+               return err;
+
+       if (adev->powerplay.pp_funcs->set_fan_speed_max_rpm) {
+               err =3D amdgpu_dpm_set_fan_speed_max_rpm(adev, value);
+               if (err)
+                       return err;
+       }
+
+       return count;
+}
+
 static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
                                            struct device_attribute *attr,
                                            char *buf)
@@ -1628,8 +1680,8 @@ static SENSOR_DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IW=
USR, amdgpu_hwmon_get_pwm1_
 static SENSOR_DEVICE_ATTR(pwm1_min, S_IRUGO, amdgpu_hwmon_get_pwm1_min, NU=
LL, 0);
 static SENSOR_DEVICE_ATTR(pwm1_max, S_IRUGO, amdgpu_hwmon_get_pwm1_max, NU=
LL, 0);
 static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, amdgpu_hwmon_get_fan1_input=
, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan1_min, S_IRUGO, amdgpu_hwmon_get_fan1_min, NU=
LL, 0);
-static SENSOR_DEVICE_ATTR(fan1_max, S_IRUGO, amdgpu_hwmon_get_fan1_max, NU=
LL, 0);
+static SENSOR_DEVICE_ATTR(fan1_min, S_IRUGO | S_IWUSR, amdgpu_hwmon_get_fa=
n1_min, amdgpu_hwmon_set_fan1_min, 0);
+static SENSOR_DEVICE_ATTR(fan1_max, S_IRUGO | S_IWUSR, amdgpu_hwmon_get_fa=
n1_max, amdgpu_hwmon_set_fan1_max, 0);
 static SENSOR_DEVICE_ATTR(fan1_target, S_IRUGO | S_IWUSR, amdgpu_hwmon_get=
_fan1_target, amdgpu_hwmon_set_fan1_target, 0);
 static SENSOR_DEVICE_ATTR(fan1_enable, S_IRUGO | S_IWUSR, amdgpu_hwmon_get=
_fan1_enable, amdgpu_hwmon_set_fan1_enable, 0);
 static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, amdgpu_hwmon_show_vddgfx, NU=
LL, 0);
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index 980e696989b1..1af55997bdb9 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -276,6 +276,8 @@ struct amd_pm_funcs {
                 struct amd_pp_simple_clock_info *clocks);
         int (*notify_smu_enable_pwe)(void *handle);
         int (*enable_mgpu_fan_boost)(void *handle);
+       int (*set_fan_speed_max_rpm)(void *handle, uint32_t rpm);
+       int (*set_fan_speed_min_rpm)(void *handle, uint32_t rpm);
 };

 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c
index 586f1ff9f73e..f10237b4d057 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -603,6 +603,50 @@ static int pp_dpm_set_fan_speed_rpm(void *handle, uint=
32_t rpm)
         return ret;
 }

+static int pp_dpm_set_fan_speed_max_rpm(void *handle, uint32_t rpm)
+{
+       struct pp_hwmgr *hwmgr =3D handle;
+       int ret =3D 0;
+
+       if (!hwmgr || !hwmgr->pm_en)
+               return -EINVAL;
+
+       if (hwmgr->hwmgr_func->set_fan_speed_max_rpm =3D=3D NULL) {
+               pr_info("%s was not implemented.\n", __func__);
+               return -EOPNOTSUPP;
+       }
+       mutex_lock(&hwmgr->smu_lock);
+       ret =3D hwmgr->hwmgr_func->set_fan_speed_max_rpm(hwmgr, rpm);
+       mutex_unlock(&hwmgr->smu_lock);
+
+       if (!ret)
+               hwmgr->thermal_controller.fanInfo.ulMaxRPM =3D rpm;
+
+       return ret;
+}
+
+static int pp_dpm_set_fan_speed_min_rpm(void *handle, uint32_t rpm)
+{
+       struct pp_hwmgr *hwmgr =3D handle;
+       int ret =3D 0;
+
+       if (!hwmgr || !hwmgr->pm_en)
+               return -EINVAL;
+
+       if (hwmgr->hwmgr_func->set_fan_speed_min_rpm =3D=3D NULL) {
+               pr_info("%s was not implemented.\n", __func__);
+               return -EOPNOTSUPP;
+       }
+       mutex_lock(&hwmgr->smu_lock);
+       ret =3D hwmgr->hwmgr_func->set_fan_speed_min_rpm(hwmgr, rpm);
+       mutex_unlock(&hwmgr->smu_lock);
+
+       if (!ret)
+               hwmgr->thermal_controller.fanInfo.ulMinRPM =3D rpm;
+
+       return ret;
+}
+
 static int pp_dpm_get_pp_num_states(void *handle,
                 struct pp_states_info *data)
 {
@@ -1342,6 +1386,8 @@ static const struct amd_pm_funcs pp_dpm_funcs =3D {
         .get_fan_speed_percent =3D pp_dpm_get_fan_speed_percent,
         .get_fan_speed_rpm =3D pp_dpm_get_fan_speed_rpm,
         .set_fan_speed_rpm =3D pp_dpm_set_fan_speed_rpm,
+       .set_fan_speed_max_rpm =3D pp_dpm_set_fan_speed_max_rpm,
+       .set_fan_speed_min_rpm =3D pp_dpm_set_fan_speed_min_rpm,
         .get_pp_num_states =3D pp_dpm_get_pp_num_states,
         .get_pp_table =3D pp_dpm_get_pp_table,
         .set_pp_table =3D pp_dpm_set_pp_table,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h
index 687f73fe4cf5..0242bc039a48 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
@@ -269,6 +269,8 @@ struct pp_hwmgr_func {
         int (*get_fan_speed_percent)(struct pp_hwmgr *hwmgr, uint32_t *spe=
ed);
         int (*set_fan_speed_rpm)(struct pp_hwmgr *hwmgr, uint32_t percent)=
;
         int (*get_fan_speed_rpm)(struct pp_hwmgr *hwmgr, uint32_t *speed);
+       int (*set_fan_speed_max_rpm)(struct pp_hwmgr *hwmgr, uint32_t max_r=
pm);
+       int (*set_fan_speed_min_rpm)(struct pp_hwmgr *hwmgr, uint32_t min_r=
pm);
         int (*reset_fan_speed_to_default)(struct pp_hwmgr *hwmgr);
         int (*uninitialize_thermal_controller)(struct pp_hwmgr *hwmgr);
         int (*register_irq_handlers)(struct pp_hwmgr *hwmgr);
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



--_000_BYAPR12MB2775F650496C7DA583461501FBF60BYAPR12MB2775namp_
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
<p style=3D"margin-top:0;margin-bottom:0">One question: how to exit the max=
/min fan speed and return to auto mode?</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex<br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> amd-gfx &lt;amd-gfx-=
bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.=
com&gt;<br>
<b>Sent:</b> Wednesday, October 24, 2018 4:11 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Quan, Evan<br>
<b>Subject:</b> [PATCH 2/3] drm/amd/powerplay: added hwmon interfaces for s=
etting max/min fan speed</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">New hwmon interfaces for maximum and minimum fan s=
peed setting.<br>
<br>
Change-Id: Ic9ec9f2427c6d3425e1c7e7b765d7d01a92f9a26<br>
Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 6 &#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 56 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&nbsp;.../gpu/drm/amd/include/kgd_pp_interface.h&nbsp;&nbsp;&nbsp; |&nbsp; =
2 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 46 &#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/hwmgr.h&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 2 &#43;<br>
&nbsp;5 files changed, 110 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_dpm.h<br>
index f972cd156795..12c4e461a7bc 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h<br>
@@ -364,6 &#43;364,12 @@ enum amdgpu_pcie_gen {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ((adev)-&gt;powerplay.pp_funcs-&gt;enable_mgpu_fan_bo=
ost(\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev=
)-&gt;powerplay.pp_handle))<br>
&nbsp;<br>
&#43;#define amdgpu_dpm_set_fan_speed_max_rpm(adev, s) \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ((adev)-&gt;powerplay.pp_funcs-&gt;set_fan_speed_max_rpm)((a=
dev)-&gt;powerplay.pp_handle, (s))<br>
&#43;<br>
&#43;#define amdgpu_dpm_set_fan_speed_min_rpm(adev, s) \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ((adev)-&gt;powerplay.pp_funcs-&gt;set_fan_speed_min_rpm)((a=
dev)-&gt;powerplay.pp_handle, (s))<br>
&#43;<br>
&nbsp;struct amdgpu_dpm {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ps&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ps;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* number of valid power s=
tates */<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c<br>
index 8e94255654ed..92da37bb51ba 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
@@ -1265,6 &#43;1265,32 @@ static ssize_t amdgpu_hwmon_get_fan1_min(struct =
device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAGE_=
SIZE, &quot;%d\n&quot;, min_rpm);<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static ssize_t amdgpu_hwmon_set_fan1_min(struct device *dev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct de=
vice_attribute *attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const cha=
r *buf, size_t count)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D de=
v_get_drvdata(dev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 value;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Can't adjust fan when the card=
 is off */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if&nbsp; ((adev-&gt;flags &amp; A=
MD_IS_PX) &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (ad=
ev-&gt;ddev-&gt;switch_power_state !=3D DRM_SWITCH_POWER_ON))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D kstrtou32(buf, 10, &amp;v=
alue);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return err;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-&=
gt;set_fan_speed_min_rpm) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; err =3D amdgpu_dpm_set_fan_speed_min_rpm(adev, value);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (err)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&#43;}<br>
&#43;<br>
&nbsp;static ssize_t amdgpu_hwmon_get_fan1_max(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; char *buf)<br>
@@ -1285,6 &#43;1311,32 @@ static ssize_t amdgpu_hwmon_get_fan1_max(struct =
device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAGE_=
SIZE, &quot;%d\n&quot;, max_rpm);<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static ssize_t amdgpu_hwmon_set_fan1_max(struct device *dev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct de=
vice_attribute *attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const cha=
r *buf, size_t count)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D de=
v_get_drvdata(dev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 value;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Can't adjust fan when the card=
 is off */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if&nbsp; ((adev-&gt;flags &amp; A=
MD_IS_PX) &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (ad=
ev-&gt;ddev-&gt;switch_power_state !=3D DRM_SWITCH_POWER_ON))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D kstrtou32(buf, 10, &amp;v=
alue);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return err;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-&=
gt;set_fan_speed_max_rpm) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; err =3D amdgpu_dpm_set_fan_speed_max_rpm(adev, value);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (err)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&#43;}<br>
&#43;<br>
&nbsp;static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<br>
@@ -1628,8 &#43;1680,8 @@ static SENSOR_DEVICE_ATTR(pwm1_enable, S_IRUGO | =
S_IWUSR, amdgpu_hwmon_get_pwm1_<br>
&nbsp;static SENSOR_DEVICE_ATTR(pwm1_min, S_IRUGO, amdgpu_hwmon_get_pwm1_mi=
n, NULL, 0);<br>
&nbsp;static SENSOR_DEVICE_ATTR(pwm1_max, S_IRUGO, amdgpu_hwmon_get_pwm1_ma=
x, NULL, 0);<br>
&nbsp;static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, amdgpu_hwmon_get_fan1_=
input, NULL, 0);<br>
-static SENSOR_DEVICE_ATTR(fan1_min, S_IRUGO, amdgpu_hwmon_get_fan1_min, NU=
LL, 0);<br>
-static SENSOR_DEVICE_ATTR(fan1_max, S_IRUGO, amdgpu_hwmon_get_fan1_max, NU=
LL, 0);<br>
&#43;static SENSOR_DEVICE_ATTR(fan1_min, S_IRUGO | S_IWUSR, amdgpu_hwmon_ge=
t_fan1_min, amdgpu_hwmon_set_fan1_min, 0);<br>
&#43;static SENSOR_DEVICE_ATTR(fan1_max, S_IRUGO | S_IWUSR, amdgpu_hwmon_ge=
t_fan1_max, amdgpu_hwmon_set_fan1_max, 0);<br>
&nbsp;static SENSOR_DEVICE_ATTR(fan1_target, S_IRUGO | S_IWUSR, amdgpu_hwmo=
n_get_fan1_target, amdgpu_hwmon_set_fan1_target, 0);<br>
&nbsp;static SENSOR_DEVICE_ATTR(fan1_enable, S_IRUGO | S_IWUSR, amdgpu_hwmo=
n_get_fan1_enable, amdgpu_hwmon_set_fan1_enable, 0);<br>
&nbsp;static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, amdgpu_hwmon_show_vddgf=
x, NULL, 0);<br>
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h<br>
index 980e696989b1..1af55997bdb9 100644<br>
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
@@ -276,6 &#43;276,8 @@ struct amd_pm_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amd_pp_simple_clock_info *clocks);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*notify_smu_enable_pw=
e)(void *handle);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*enable_mgpu_fan_boos=
t)(void *handle);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_fan_speed_max_rpm)(void=
 *handle, uint32_t rpm);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_fan_speed_min_rpm)(void=
 *handle, uint32_t rpm);<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c<br>
index 586f1ff9f73e..f10237b4d057 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
@@ -603,6 &#43;603,50 @@ static int pp_dpm_set_fan_speed_rpm(void *handle, =
uint32_t rpm)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int pp_dpm_set_fan_speed_max_rpm(void *handle, uint32_t rpm)<br=
>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr =3D handle=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr-&gt;pm_en)<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;hwmgr_func-&gt;set_=
fan_speed_max_rpm =3D=3D NULL) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&quot;, __func__);<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hwmgr-&gt;smu_loc=
k);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D hwmgr-&gt;hwmgr_func-&gt;=
set_fan_speed_max_rpm(hwmgr, rpm);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hwmgr-&gt;smu_l=
ock);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;thermal_controller.fanInfo.ulMaxRPM =3D rpm;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&#43;static int pp_dpm_set_fan_speed_min_rpm(void *handle, uint32_t rpm)<br=
>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr =3D handle=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr-&gt;pm_en)<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;hwmgr_func-&gt;set_=
fan_speed_min_rpm =3D=3D NULL) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&quot;, __func__);<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hwmgr-&gt;smu_loc=
k);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D hwmgr-&gt;hwmgr_func-&gt;=
set_fan_speed_min_rpm(hwmgr, rpm);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hwmgr-&gt;smu_l=
ock);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;thermal_controller.fanInfo.ulMinRPM =3D rpm;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&nbsp;static int pp_dpm_get_pp_num_states(void *handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct pp_states_info *data)<br>
&nbsp;{<br>
@@ -1342,6 &#43;1386,8 @@ static const struct amd_pm_funcs pp_dpm_funcs =3D=
 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_speed_percent =3D=
 pp_dpm_get_fan_speed_percent,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_speed_rpm =3D pp_=
dpm_get_fan_speed_rpm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_speed_rpm =3D pp_=
dpm_set_fan_speed_rpm,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_speed_max_rpm =3D pp_dpm=
_set_fan_speed_max_rpm,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_fan_speed_min_rpm =3D pp_dpm=
_set_fan_speed_min_rpm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_pp_num_states =3D pp_=
dpm_get_pp_num_states,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_pp_table =3D pp_dpm_g=
et_pp_table,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_pp_table =3D pp_dpm_s=
et_pp_table,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h<br>
index 687f73fe4cf5..0242bc039a48 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
@@ -269,6 &#43;269,8 @@ struct pp_hwmgr_func {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_fan_speed_percen=
t)(struct pp_hwmgr *hwmgr, uint32_t *speed);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_fan_speed_rpm)(s=
truct pp_hwmgr *hwmgr, uint32_t percent);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_fan_speed_rpm)(s=
truct pp_hwmgr *hwmgr, uint32_t *speed);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_fan_speed_max_rpm)(stru=
ct pp_hwmgr *hwmgr, uint32_t max_rpm);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_fan_speed_min_rpm)(stru=
ct pp_hwmgr *hwmgr, uint32_t min_rpm);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*reset_fan_speed_to_d=
efault)(struct pp_hwmgr *hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*uninitialize_thermal=
_controller)(struct pp_hwmgr *hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*register_irq_handler=
s)(struct pp_hwmgr *hwmgr);<br>
-- <br>
2.19.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk568164" class=3D"OWAAutoLink" previewremoved=3D"true">https://lists.free=
desktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15403698863000.14269909928300328" style=3D"margin-bo=
ttom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15403698862980.8796761397604639" style=3D"width: 9=
0%; background-color: rgb(255, 255, 255); position: relative; overflow: aut=
o; padding-top: 20px; padding-bottom: 20px; margin-top: 20px; border-top: 1=
px dotted rgb(200, 200, 200); border-bottom: 1px dotted rgb(200, 200, 200);=
" role=3D"presentation" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td id=3D"TextCell_15403698863000.8597383540435837" style=3D"vertical-align=
: top; position: relative; padding: 0px; display: table-cell;" colspan=3D"2=
">
<div id=3D"LPRemovePreviewContainer_15403698863000.8055293495204474"></div>
<div id=3D"LPTitle_15403698863000.9916224528545828" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: 400; font-size: 21px; font-family: &quot;=
wf_segoe-ui_light&quot;, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&q=
uot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif=
; line-height: 21px;">
<a id=3D"LPUrlAnchor_15403698863000.14093576092280713" style=3D"text-decora=
tion: none;" href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx=
" target=3D"_blank">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15403698863000.39120505537129757" style=3D"margin: 10=
px 0px 16px; color: rgb(102, 102, 102); font-weight: 400; font-family: &quo=
t;wf_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tah=
oma, Arial, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15403698863000.17702711523041492" style=3D"display=
: block; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot;wf=
_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma,=
 Arial, sans-serif; font-size: 14px; line-height: 20px; max-height: 100px; =
overflow: hidden;">
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

--_000_BYAPR12MB2775F650496C7DA583461501FBF60BYAPR12MB2775namp_--

--===============0206297104==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0206297104==--
