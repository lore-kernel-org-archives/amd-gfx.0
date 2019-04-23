From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 5/5] drm/amd/powerplay: support hwmon temperature channel
 labels V2
Date: Tue, 23 Apr 2019 13:47:48 +0000
Message-ID: <BN6PR12MB180904E13038F75D29575EBFF7230@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190423083701.26909-1-evan.quan@amd.com>,
 <20190423083701.26909-5-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2001766127=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190423083701.26909-5-evan.quan-5C7GfCeVMHo@public.gmane.org>
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

--===============2001766127==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180904E13038F75D29575EBFF7230BN6PR12MB1809namp_"

--_000_BN6PR12MB180904E13038F75D29575EBFF7230BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Series is:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Evan Qua=
n <evan.quan-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, April 23, 2019 4:37 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander; Quan, Evan
Subject: [PATCH 5/5] drm/amd/powerplay: support hwmon temperature channel l=
abels V2

Expose temp[1-3]_label hwmon interfaces. While temp2_label
and temp3_label are visible for SOC15 dGPUs only.

- V2: correct temp1_label as "edge"

Change-Id: I7f1e10c52ec21d272027554cdf6da97103e0be58
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c        | 35 ++++++++++++++++++-
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  7 ++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c
index 291c06f40dba..4fe1b58892a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -120,6 +120,15 @@ static const struct cg_flag_name clocks[] =3D {
         {0, NULL},
 };

+static const struct hwmon_temp_label {
+       enum PP_HWMON_TEMP channel;
+       const char *label;
+} temp_label[] =3D {
+       {PP_TEMP_EDGE, "edge"},
+       {PP_TEMP_JUNCTION, "junction"},
+       {PP_TEMP_MEM, "mem"},
+};
+
 void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
 {
         if (adev->pm.dpm_enabled) {
@@ -1511,6 +1520,19 @@ static ssize_t amdgpu_hwmon_show_mem_temp_thresh(str=
uct device *dev,
         return snprintf(buf, PAGE_SIZE, "%d\n", temp);
 }

+static ssize_t amdgpu_hwmon_show_temp_label(struct device *dev,
+                                            struct device_attribute *attr,
+                                            char *buf)
+{
+       struct amdgpu_device *adev =3D dev_get_drvdata(dev);
+       int channel =3D to_sensor_dev_attr(attr)->index;
+
+       if (channel >=3D PP_TEMP_MAX)
+               return -EINVAL;
+
+       return snprintf(buf, PAGE_SIZE, "%s\n", temp_label[channel].label);
+}
+
 static ssize_t amdgpu_hwmon_show_temp_emergency(struct device *dev,
                                              struct device_attribute *attr=
,
                                              char *buf)
@@ -2109,6 +2131,9 @@ static ssize_t amdgpu_hwmon_show_mclk_label(struct de=
vice *dev,
  * - temp[1-3]_input: the on die GPU temperature in millidegrees Celsius
  *   - temp2_input and temp3_input are supported on SOC15 dGPUs only
  *
+ * - temp[1-3]_label: temperature channel label
+ *   - temp2_label and temp3_label are supported on SOC15 dGPUs only
+ *
  * - temp[1-3]_crit: temperature critical max value in millidegrees Celsiu=
s
  *   - temp2_crit and temp3_crit are supported on SOC15 dGPUs only
  *
@@ -2176,6 +2201,9 @@ static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, amdgp=
u_hwmon_show_temp, NULL, PP
 static SENSOR_DEVICE_ATTR(temp3_crit, S_IRUGO, amdgpu_hwmon_show_mem_temp_=
thresh, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp3_crit_hyst, S_IRUGO, amdgpu_hwmon_show_mem_=
temp_thresh, NULL, 1);
 static SENSOR_DEVICE_ATTR(temp3_emergency, S_IRUGO, amdgpu_hwmon_show_temp=
_emergency, NULL, PP_TEMP_MEM);
+static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, amdgpu_hwmon_show_temp_lab=
el, NULL, PP_TEMP_EDGE);
+static SENSOR_DEVICE_ATTR(temp2_label, S_IRUGO, amdgpu_hwmon_show_temp_lab=
el, NULL, PP_TEMP_JUNCTION);
+static SENSOR_DEVICE_ATTR(temp3_label, S_IRUGO, amdgpu_hwmon_show_temp_lab=
el, NULL, PP_TEMP_MEM);
 static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, amdgpu_hwmon_get_pwm1, =
amdgpu_hwmon_set_pwm1, 0);
 static SENSOR_DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR, amdgpu_hwmon_get=
_pwm1_enable, amdgpu_hwmon_set_pwm1_enable, 0);
 static SENSOR_DEVICE_ATTR(pwm1_min, S_IRUGO, amdgpu_hwmon_get_pwm1_min, NU=
LL, 0);
@@ -2211,6 +2239,9 @@ static struct attribute *hwmon_attributes[] =3D {
         &sensor_dev_attr_temp1_emergency.dev_attr.attr,
         &sensor_dev_attr_temp2_emergency.dev_attr.attr,
         &sensor_dev_attr_temp3_emergency.dev_attr.attr,
+       &sensor_dev_attr_temp1_label.dev_attr.attr,
+       &sensor_dev_attr_temp2_label.dev_attr.attr,
+       &sensor_dev_attr_temp3_label.dev_attr.attr,
         &sensor_dev_attr_pwm1.dev_attr.attr,
         &sensor_dev_attr_pwm1_enable.dev_attr.attr,
         &sensor_dev_attr_pwm1_min.dev_attr.attr,
@@ -2344,7 +2375,9 @@ static umode_t hwmon_attributes_visible(struct kobjec=
t *kobj,
              attr =3D=3D &sensor_dev_attr_temp2_emergency.dev_attr.attr ||
              attr =3D=3D &sensor_dev_attr_temp3_emergency.dev_attr.attr ||
              attr =3D=3D &sensor_dev_attr_temp2_input.dev_attr.attr ||
-            attr =3D=3D &sensor_dev_attr_temp3_input.dev_attr.attr))
+            attr =3D=3D &sensor_dev_attr_temp3_input.dev_attr.attr ||
+            attr =3D=3D &sensor_dev_attr_temp2_label.dev_attr.attr ||
+            attr =3D=3D &sensor_dev_attr_temp3_label.dev_attr.attr))
                 return 0;

         return effective_mode;
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index a8bf8e90ceeb..30788d510576 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -162,6 +162,13 @@ struct pp_states_info {
         uint32_t states[16];
 };

+enum PP_HWMON_TEMP {
+       PP_TEMP_EDGE =3D 0,
+       PP_TEMP_JUNCTION,
+       PP_TEMP_MEM,
+       PP_TEMP_MAX
+};
+
 #define PP_GROUP_MASK        0xF0000000
 #define PP_GROUP_SHIFT       28

--
2.21.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180904E13038F75D29575EBFF7230BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.c=
om&gt;<br>
<b>Sent:</b> Tuesday, April 23, 2019 4:37 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander; Quan, Evan<br>
<b>Subject:</b> [PATCH 5/5] drm/amd/powerplay: support hwmon temperature ch=
annel labels V2</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Expose temp[1-3]_label hwmon interfaces. While tem=
p2_label<br>
and temp3_label are visible for SOC15 dGPUs only.<br>
<br>
- V2: correct temp1_label as &quot;edge&quot;<br>
<br>
Change-Id: I7f1e10c52ec21d272027554cdf6da97103e0be58<br>
Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 35 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&nbsp;.../gpu/drm/amd/include/kgd_pp_interface.h&nbsp;&nbsp;&nbsp; |&nbsp; =
7 &#43;&#43;&#43;&#43;<br>
&nbsp;2 files changed, 41 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c<br>
index 291c06f40dba..4fe1b58892a2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
@@ -120,6 &#43;120,15 @@ static const struct cg_flag_name clocks[] =3D {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0, NULL},<br>
&nbsp;};<br>
&nbsp;<br>
&#43;static const struct hwmon_temp_label {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum PP_HWMON_TEMP channel;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *label;<br>
&#43;} temp_label[] =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {PP_TEMP_EDGE, &quot;edge&quot;},=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {PP_TEMP_JUNCTION, &quot;junction=
&quot;},<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {PP_TEMP_MEM, &quot;mem&quot;},<b=
r>
&#43;};<br>
&#43;<br>
&nbsp;void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.dpm_enable=
d) {<br>
@@ -1511,6 &#43;1520,19 @@ static ssize_t amdgpu_hwmon_show_mem_temp_thresh=
(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAGE_=
SIZE, &quot;%d\n&quot;, temp);<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static ssize_t amdgpu_hwmon_show_temp_label(struct device *dev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D de=
v_get_drvdata(dev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int channel =3D to_sensor_dev_att=
r(attr)-&gt;index;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (channel &gt;=3D PP_TEMP_MAX)<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &=
quot;%s\n&quot;, temp_label[channel].label);<br>
&#43;}<br>
&#43;<br>
&nbsp;static ssize_t amdgpu_hwmon_show_temp_emergency(struct device *dev,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<br>
@@ -2109,6 &#43;2131,9 @@ static ssize_t amdgpu_hwmon_show_mclk_label(struc=
t device *dev,<br>
&nbsp; * - temp[1-3]_input: the on die GPU temperature in millidegrees Cels=
ius<br>
&nbsp; *&nbsp;&nbsp; - temp2_input and temp3_input are supported on SOC15 d=
GPUs only<br>
&nbsp; *<br>
&#43; * - temp[1-3]_label: temperature channel label<br>
&#43; *&nbsp;&nbsp; - temp2_label and temp3_label are supported on SOC15 dG=
PUs only<br>
&#43; *<br>
&nbsp; * - temp[1-3]_crit: temperature critical max value in millidegrees C=
elsius<br>
&nbsp; *&nbsp;&nbsp; - temp2_crit and temp3_crit are supported on SOC15 dGP=
Us only<br>
&nbsp; *<br>
@@ -2176,6 &#43;2201,9 @@ static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, a=
mdgpu_hwmon_show_temp, NULL, PP<br>
&nbsp;static SENSOR_DEVICE_ATTR(temp3_crit, S_IRUGO, amdgpu_hwmon_show_mem_=
temp_thresh, NULL, 0);<br>
&nbsp;static SENSOR_DEVICE_ATTR(temp3_crit_hyst, S_IRUGO, amdgpu_hwmon_show=
_mem_temp_thresh, NULL, 1);<br>
&nbsp;static SENSOR_DEVICE_ATTR(temp3_emergency, S_IRUGO, amdgpu_hwmon_show=
_temp_emergency, NULL, PP_TEMP_MEM);<br>
&#43;static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, amdgpu_hwmon_show_temp=
_label, NULL, PP_TEMP_EDGE);<br>
&#43;static SENSOR_DEVICE_ATTR(temp2_label, S_IRUGO, amdgpu_hwmon_show_temp=
_label, NULL, PP_TEMP_JUNCTION);<br>
&#43;static SENSOR_DEVICE_ATTR(temp3_label, S_IRUGO, amdgpu_hwmon_show_temp=
_label, NULL, PP_TEMP_MEM);<br>
&nbsp;static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, amdgpu_hwmon_get_p=
wm1, amdgpu_hwmon_set_pwm1, 0);<br>
&nbsp;static SENSOR_DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR, amdgpu_hwmo=
n_get_pwm1_enable, amdgpu_hwmon_set_pwm1_enable, 0);<br>
&nbsp;static SENSOR_DEVICE_ATTR(pwm1_min, S_IRUGO, amdgpu_hwmon_get_pwm1_mi=
n, NULL, 0);<br>
@@ -2211,6 &#43;2239,9 @@ static struct attribute *hwmon_attributes[] =3D {=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sensor_dev_attr_temp1=
_emergency.dev_attr.attr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sensor_dev_attr_temp2=
_emergency.dev_attr.attr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sensor_dev_attr_temp3=
_emergency.dev_attr.attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sensor_dev_attr_temp1_label.=
dev_attr.attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sensor_dev_attr_temp2_label.=
dev_attr.attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sensor_dev_attr_temp3_label.=
dev_attr.attr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sensor_dev_attr_pwm1.=
dev_attr.attr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sensor_dev_attr_pwm1_=
enable.dev_attr.attr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sensor_dev_attr_pwm1_=
min.dev_attr.attr,<br>
@@ -2344,7 &#43;2375,9 @@ static umode_t hwmon_attributes_visible(struct ko=
bject *kobj,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; attr =3D=3D &amp;sensor_dev_attr_temp2_emergency.dev_attr.attr ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; attr =3D=3D &amp;sensor_dev_attr_temp3_emergency.dev_attr.attr ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; attr =3D=3D &amp;sensor_dev_attr_temp2_input.dev_attr.attr ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr =
=3D=3D &amp;sensor_dev_attr_temp3_input.dev_attr.attr))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; att=
r =3D=3D &amp;sensor_dev_attr_temp3_input.dev_attr.attr ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; att=
r =3D=3D &amp;sensor_dev_attr_temp2_label.dev_attr.attr ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; att=
r =3D=3D &amp;sensor_dev_attr_temp3_label.dev_attr.attr))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return effective_mode;<br>
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h<br>
index a8bf8e90ceeb..30788d510576 100644<br>
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
@@ -162,6 &#43;162,13 @@ struct pp_states_info {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t states[16];<br>
&nbsp;};<br>
&nbsp;<br>
&#43;enum PP_HWMON_TEMP {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_TEMP_EDGE =3D 0,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_TEMP_JUNCTION,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_TEMP_MEM,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_TEMP_MAX<br>
&#43;};<br>
&#43;<br>
&nbsp;#define PP_GROUP_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xF00=
00000<br>
&nbsp;#define PP_GROUP_SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 28<br>
&nbsp;<br>
-- <br>
2.21.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB180904E13038F75D29575EBFF7230BN6PR12MB1809namp_--

--===============2001766127==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============2001766127==--
