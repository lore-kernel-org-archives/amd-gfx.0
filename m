From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: expose sclk and mclk via hwmon
Date: Tue, 8 Jan 2019 21:32:29 +0000
Message-ID: <BN6PR12MB1809786BD491F93EADF09B5FF78A0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20181210211727.2840-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1835830894=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181210211727.2840-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>, "Freehill, Chris" <Chris.Freehill-5C7GfCeVMHo@public.gmane.org>

--===============1835830894==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809786BD491F93EADF09B5FF78A0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809786BD491F93EADF09B5FF78A0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ping?  Useful for rocm-smi?

________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Monday, December 10, 2018 4:17:27 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander
Subject: [PATCH] drm/amdgpu: expose sclk and mclk via hwmon

Expose sclk (gfx clock) and mclk (memory clock) via
hwmon compatible interface.  hwmon does not actually
formally specify a frequency type attribute, but these
are compatible with the format of the other attributes
exposed via hwmon.  Units are hertz.

freq1_input - GPU gfx/compute clock in hertz
freq2_input - GPU memory clock in hertz (dGPU only)

Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 93 ++++++++++++++++++++++++++++++=
++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c
index 1f61ed95727c..6d52428fc45b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1516,6 +1516,75 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct dev=
ice *dev,
         return count;
 }

+static ssize_t amdgpu_hwmon_show_sclk(struct device *dev,
+                                     struct device_attribute *attr,
+                                     char *buf)
+{
+       struct amdgpu_device *adev =3D dev_get_drvdata(dev);
+       struct drm_device *ddev =3D adev->ddev;
+       uint32_t sclk;
+       int r, size =3D sizeof(sclk);
+
+       /* Can't get voltage when the card is off */
+       if  ((adev->flags & AMD_IS_PX) &&
+            (ddev->switch_power_state !=3D DRM_SWITCH_POWER_ON))
+               return -EINVAL;
+
+       /* sanity check PP is enabled */
+       if (!(adev->powerplay.pp_funcs &&
+             adev->powerplay.pp_funcs->read_sensor))
+             return -EINVAL;
+
+       /* get the sclk */
+       r =3D amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GFX_SCLK,
+                                  (void *)&sclk, &size);
+       if (r)
+               return r;
+
+       return snprintf(buf, PAGE_SIZE, "%d\n", sclk * 10 * 1000);
+}
+
+static ssize_t amdgpu_hwmon_show_sclk_label(struct device *dev,
+                                           struct device_attribute *attr,
+                                           char *buf)
+{
+       return snprintf(buf, PAGE_SIZE, "sclk\n");
+}
+
+static ssize_t amdgpu_hwmon_show_mclk(struct device *dev,
+                                     struct device_attribute *attr,
+                                     char *buf)
+{
+       struct amdgpu_device *adev =3D dev_get_drvdata(dev);
+       struct drm_device *ddev =3D adev->ddev;
+       uint32_t mclk;
+       int r, size =3D sizeof(mclk);
+
+       /* Can't get voltage when the card is off */
+       if  ((adev->flags & AMD_IS_PX) &&
+            (ddev->switch_power_state !=3D DRM_SWITCH_POWER_ON))
+               return -EINVAL;
+
+       /* sanity check PP is enabled */
+       if (!(adev->powerplay.pp_funcs &&
+             adev->powerplay.pp_funcs->read_sensor))
+             return -EINVAL;
+
+       /* get the sclk */
+       r =3D amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GFX_MCLK,
+                                  (void *)&mclk, &size);
+       if (r)
+               return r;
+
+       return snprintf(buf, PAGE_SIZE, "%d\n", mclk * 10 * 1000);
+}
+
+static ssize_t amdgpu_hwmon_show_mclk_label(struct device *dev,
+                                           struct device_attribute *attr,
+                                           char *buf)
+{
+       return snprintf(buf, PAGE_SIZE, "mclk\n");
+}

 /**
  * DOC: hwmon
@@ -1532,6 +1601,10 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct dev=
ice *dev,
  *
  * - GPU fan
  *
+ * - GPU gfx/compute engine clock
+ *
+ * - GPU memory clock (dGPU only)
+ *
  * hwmon interfaces for GPU temperature:
  *
  * - temp1_input: the on die GPU temperature in millidegrees Celsius
@@ -1576,6 +1649,12 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct dev=
ice *dev,
  *
  * - fan[1-*]_enable: Enable or disable the sensors.1: Enable 0: Disable
  *
+ * hwmon interfaces for GPU clocks:
+ *
+ * - freq1_input: the gfx/compute clock in hertz
+ *
+ * - freq2_input: the memory clock in hertz
+ *
  * You can use hwmon tools like sensors to view this information on your s=
ystem.
  *
  */
@@ -1600,6 +1679,10 @@ static SENSOR_DEVICE_ATTR(power1_average, S_IRUGO, a=
mdgpu_hwmon_show_power_avg,
 static SENSOR_DEVICE_ATTR(power1_cap_max, S_IRUGO, amdgpu_hwmon_show_power=
_cap_max, NULL, 0);
 static SENSOR_DEVICE_ATTR(power1_cap_min, S_IRUGO, amdgpu_hwmon_show_power=
_cap_min, NULL, 0);
 static SENSOR_DEVICE_ATTR(power1_cap, S_IRUGO | S_IWUSR, amdgpu_hwmon_show=
_power_cap, amdgpu_hwmon_set_power_cap, 0);
+static SENSOR_DEVICE_ATTR(freq1_input, S_IRUGO, amdgpu_hwmon_show_sclk, NU=
LL, 0);
+static SENSOR_DEVICE_ATTR(freq1_label, S_IRUGO, amdgpu_hwmon_show_sclk_lab=
el, NULL, 0);
+static SENSOR_DEVICE_ATTR(freq2_input, S_IRUGO, amdgpu_hwmon_show_mclk, NU=
LL, 0);
+static SENSOR_DEVICE_ATTR(freq2_label, S_IRUGO, amdgpu_hwmon_show_mclk_lab=
el, NULL, 0);

 static struct attribute *hwmon_attributes[] =3D {
         &sensor_dev_attr_temp1_input.dev_attr.attr,
@@ -1622,6 +1705,10 @@ static struct attribute *hwmon_attributes[] =3D {
         &sensor_dev_attr_power1_cap_max.dev_attr.attr,
         &sensor_dev_attr_power1_cap_min.dev_attr.attr,
         &sensor_dev_attr_power1_cap.dev_attr.attr,
+       &sensor_dev_attr_freq1_input.dev_attr.attr,
+       &sensor_dev_attr_freq1_label.dev_attr.attr,
+       &sensor_dev_attr_freq2_input.dev_attr.attr,
+       &sensor_dev_attr_freq2_label.dev_attr.attr,
         NULL
 };

@@ -1712,6 +1799,12 @@ static umode_t hwmon_attributes_visible(struct kobje=
ct *kobj,
              attr =3D=3D &sensor_dev_attr_in1_label.dev_attr.attr))
                 return 0;

+       /* no mclk on APUs */
+       if ((adev->flags & AMD_IS_APU) &&
+           (attr =3D=3D &sensor_dev_attr_freq2_input.dev_attr.attr ||
+            attr =3D=3D &sensor_dev_attr_freq2_label.dev_attr.attr))
+               return 0;
+
         return effective_mode;
 }

--
2.13.6


--_000_BN6PR12MB1809786BD491F93EADF09B5FF78A0BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Ping?&nbsp; Useful for rocm-smi?<=
br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, December 10, 2018 4:17:27 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> [PATCH] drm/amdgpu: expose sclk and mclk via hwmon</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Expose sclk (gfx clock) and mclk (memory clock) vi=
a<br>
hwmon compatible interface.&nbsp; hwmon does not actually<br>
formally specify a frequency type attribute, but these<br>
are compatible with the format of the other attributes<br>
exposed via hwmon.&nbsp; Units are hertz.<br>
<br>
freq1_input - GPU gfx/compute clock in hertz<br>
freq2_input - GPU memory clock in hertz (dGPU only)<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 93 &#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;1 file changed, 93 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c<br>
index 1f61ed95727c..6d52428fc45b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
@@ -1516,6 &#43;1516,75 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct=
 device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static ssize_t amdgpu_hwmon_show_sclk(struct device *dev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct device_attribute *attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cha=
r *buf)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D de=
v_get_drvdata(dev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D adev-=
&gt;ddev;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sclk;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, size =3D sizeof(sclk);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Can't get voltage when the car=
d is off */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if&nbsp; ((adev-&gt;flags &amp; A=
MD_IS_PX) &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (dd=
ev-&gt;switch_power_state !=3D DRM_SWITCH_POWER_ON))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* sanity check PP is enabled */<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;powerplay.pp_funcs=
 &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; adev-&gt;powerplay.pp_funcs-&gt;read_sensor))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* get the sclk */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_dpm_read_sensor(adev=
, AMDGPU_PP_SENSOR_GFX_SCLK,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)&amp;sclk, &a=
mp;size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return r;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &=
quot;%d\n&quot;, sclk * 10 * 1000);<br>
&#43;}<br>
&#43;<br>
&#43;static ssize_t amdgpu_hwmon_show_sclk_label(struct device *dev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &=
quot;sclk\n&quot;);<br>
&#43;}<br>
&#43;<br>
&#43;static ssize_t amdgpu_hwmon_show_mclk(struct device *dev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct device_attribute *attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cha=
r *buf)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D de=
v_get_drvdata(dev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D adev-=
&gt;ddev;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mclk;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, size =3D sizeof(mclk);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Can't get voltage when the car=
d is off */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if&nbsp; ((adev-&gt;flags &amp; A=
MD_IS_PX) &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (dd=
ev-&gt;switch_power_state !=3D DRM_SWITCH_POWER_ON))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* sanity check PP is enabled */<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;powerplay.pp_funcs=
 &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; adev-&gt;powerplay.pp_funcs-&gt;read_sensor))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* get the sclk */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_dpm_read_sensor(adev=
, AMDGPU_PP_SENSOR_GFX_MCLK,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)&amp;mclk, &a=
mp;size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return r;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &=
quot;%d\n&quot;, mclk * 10 * 1000);<br>
&#43;}<br>
&#43;<br>
&#43;static ssize_t amdgpu_hwmon_show_mclk_label(struct device *dev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &=
quot;mclk\n&quot;);<br>
&#43;}<br>
&nbsp;<br>
&nbsp;/**<br>
&nbsp; * DOC: hwmon<br>
@@ -1532,6 &#43;1601,10 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct=
 device *dev,<br>
&nbsp; *<br>
&nbsp; * - GPU fan<br>
&nbsp; *<br>
&#43; * - GPU gfx/compute engine clock<br>
&#43; *<br>
&#43; * - GPU memory clock (dGPU only)<br>
&#43; *<br>
&nbsp; * hwmon interfaces for GPU temperature:<br>
&nbsp; *<br>
&nbsp; * - temp1_input: the on die GPU temperature in millidegrees Celsius<=
br>
@@ -1576,6 &#43;1649,12 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct=
 device *dev,<br>
&nbsp; *<br>
&nbsp; * - fan[1-*]_enable: Enable or disable the sensors.1: Enable 0: Disa=
ble<br>
&nbsp; *<br>
&#43; * hwmon interfaces for GPU clocks:<br>
&#43; *<br>
&#43; * - freq1_input: the gfx/compute clock in hertz<br>
&#43; *<br>
&#43; * - freq2_input: the memory clock in hertz<br>
&#43; *<br>
&nbsp; * You can use hwmon tools like sensors to view this information on y=
our system.<br>
&nbsp; *<br>
&nbsp; */<br>
@@ -1600,6 &#43;1679,10 @@ static SENSOR_DEVICE_ATTR(power1_average, S_IRUG=
O, amdgpu_hwmon_show_power_avg,<br>
&nbsp;static SENSOR_DEVICE_ATTR(power1_cap_max, S_IRUGO, amdgpu_hwmon_show_=
power_cap_max, NULL, 0);<br>
&nbsp;static SENSOR_DEVICE_ATTR(power1_cap_min, S_IRUGO, amdgpu_hwmon_show_=
power_cap_min, NULL, 0);<br>
&nbsp;static SENSOR_DEVICE_ATTR(power1_cap, S_IRUGO | S_IWUSR, amdgpu_hwmon=
_show_power_cap, amdgpu_hwmon_set_power_cap, 0);<br>
&#43;static SENSOR_DEVICE_ATTR(freq1_input, S_IRUGO, amdgpu_hwmon_show_sclk=
, NULL, 0);<br>
&#43;static SENSOR_DEVICE_ATTR(freq1_label, S_IRUGO, amdgpu_hwmon_show_sclk=
_label, NULL, 0);<br>
&#43;static SENSOR_DEVICE_ATTR(freq2_input, S_IRUGO, amdgpu_hwmon_show_mclk=
, NULL, 0);<br>
&#43;static SENSOR_DEVICE_ATTR(freq2_label, S_IRUGO, amdgpu_hwmon_show_mclk=
_label, NULL, 0);<br>
&nbsp;<br>
&nbsp;static struct attribute *hwmon_attributes[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sensor_dev_attr_temp1=
_input.dev_attr.attr,<br>
@@ -1622,6 &#43;1705,10 @@ static struct attribute *hwmon_attributes[] =3D =
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sensor_dev_attr_power=
1_cap_max.dev_attr.attr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sensor_dev_attr_power=
1_cap_min.dev_attr.attr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sensor_dev_attr_power=
1_cap.dev_attr.attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sensor_dev_attr_freq1_input.=
dev_attr.attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sensor_dev_attr_freq1_label.=
dev_attr.attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sensor_dev_attr_freq2_input.=
dev_attr.attr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sensor_dev_attr_freq2_label.=
dev_attr.attr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL<br>
&nbsp;};<br>
&nbsp;<br>
@@ -1712,6 &#43;1799,12 @@ static umode_t hwmon_attributes_visible(struct k=
object *kobj,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; attr =3D=3D &amp;sensor_dev_attr_in1_label.dev_attr.attr))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* no mclk on APUs */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;flags &amp; AMD_IS_=
APU) &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (attr =3D=
=3D &amp;sensor_dev_attr_freq2_input.dev_attr.attr ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; att=
r =3D=3D &amp;sensor_dev_attr_freq2_label.dev_attr.attr))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return effective_mode;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.13.6<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809786BD491F93EADF09B5FF78A0BN6PR12MB1809namp_--

--===============1835830894==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1835830894==--
