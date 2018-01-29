From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu/pm: get/set dgpu power cap via hwmon API
Date: Mon, 29 Jan 2018 22:07:31 +0000
Message-ID: <CY4PR12MB1687A137629E3B22710971DBFBE50@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1517220887-28406-1-git-send-email-Rex.Zhu@amd.com>
 <1517220887-28406-2-git-send-email-Rex.Zhu@amd.com>,
 <CADnq5_OD4S_HFzeQ0MHvoz_hms23YA_mT+H_0y8qjY53z5BWCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2064956500=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_OD4S_HFzeQ0MHvoz_hms23YA_mT+H_0y8qjY53z5BWCA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2064956500==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687A137629E3B22710971DBFBE50CY4PR12MB1687namp_"

--_000_CY4PR12MB1687A137629E3B22710971DBFBE50CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

>Isn't the power limit only multiplied by 256 on smu7?

Yes=1B$B!$=1B(BI will fix it and convert the output to mw.

Best Regards
Rex

________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, January 30, 2018 4:00 AM
To: Zhu, Rex
Cc: amd-gfx list
Subject: Re: [PATCH 2/2] drm/amdgpu/pm: get/set dgpu power cap via hwmon AP=
I

On Mon, Jan 29, 2018 at 5:14 AM, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:
> Adust power limit through power1_cap
> Get min/max power limit through power1_cap_min/power1_cap_max
>
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
>
> Change-Id: Idca81ae12dc9fa4e4dd6c89fe47e0318df2859d3
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 75 ++++++++++++++++++++++++++++=
++++++
>  1 file changed, 75 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_pm.c
> index b0cdb14..db6e2ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -1207,6 +1207,69 @@ static ssize_t amdgpu_hwmon_show_power_avg(struct =
device *dev,
>         return snprintf(buf, PAGE_SIZE, "%u\n", uw);
>  }
>
> +static ssize_t amdgpu_hwmon_show_power_cap_min(struct device *dev,
> +                                        struct device_attribute *attr,
> +                                        char *buf)
> +{
> +       return sprintf(buf, "%i\n", 0);
> +}
> +
> +static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
> +                                        struct device_attribute *attr,
> +                                        char *buf)
> +{
> +       struct amdgpu_device *adev =3D dev_get_drvdata(dev);
> +       uint32_t limit =3D 0;
> +
> +       if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->get_pow=
er_limit) {
> +               adev->powerplay.pp_funcs->get_power_limit(adev->powerplay=
.pp_handle, &limit, true);
> +               return snprintf(buf, PAGE_SIZE, "%d w\n", limit / 256);

Isn't the power limit only multiplied by 256 on smu7?  Please
normalize the internal interface.  Also the hwmon API takes the uses
microWatt units, please expose those and convert to normalized
internal units as necessary.
https://www.kernel.org/doc/Documentation/hwmon/sysfs-interface


> +       } else {
> +               return snprintf(buf, PAGE_SIZE, "\n");
> +       }
> +}
> +
> +static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
> +                                        struct device_attribute *attr,
> +                                        char *buf)
> +{
> +       struct amdgpu_device *adev =3D dev_get_drvdata(dev);
> +       uint32_t limit =3D 0;
> +
> +       if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->get_pow=
er_limit) {
> +               adev->powerplay.pp_funcs->get_power_limit(adev->powerplay=
.pp_handle, &limit, false);
> +               return snprintf(buf, PAGE_SIZE, "%d w\n", limit / 256);
> +       } else {
> +               return snprintf(buf, PAGE_SIZE, "\n");
> +       }
> +}
> +
> +
> +static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
> +               struct device_attribute *attr,
> +               const char *buf,
> +               size_t count)
> +{
> +       struct amdgpu_device *adev =3D dev_get_drvdata(dev);
> +       int err;
> +       u32 value;
> +
> +       err =3D kstrtou32(buf, 10, &value);
> +       if (err)
> +               return err;
> +
> +       value =3D value * 256;

Same comment here.

Alex

> +       if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->set_pow=
er_limit) {
> +               err =3D adev->powerplay.pp_funcs->set_power_limit(adev->p=
owerplay.pp_handle, value);
> +               if (err)
> +                       return err;
> +       } else {
> +               return -EINVAL;
> +       }
> +
> +       return count;
> +}
> +
>  static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, amdgpu_hwmon_show_temp, =
NULL, 0);
>  static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, amdgpu_hwmon_show_temp_th=
resh, NULL, 0);
>  static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO, amdgpu_hwmon_show_te=
mp_thresh, NULL, 1);
> @@ -1220,6 +1283,9 @@ static ssize_t amdgpu_hwmon_show_power_avg(struct d=
evice *dev,
>  static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, amdgpu_hwmon_show_vddnb, N=
ULL, 0);
>  static SENSOR_DEVICE_ATTR(in1_label, S_IRUGO, amdgpu_hwmon_show_vddnb_la=
bel, NULL, 0);
>  static SENSOR_DEVICE_ATTR(power1_average, S_IRUGO, amdgpu_hwmon_show_pow=
er_avg, NULL, 0);
> +static SENSOR_DEVICE_ATTR(power1_cap_max, S_IRUGO, amdgpu_hwmon_show_pow=
er_cap_max, NULL, 0);
> +static SENSOR_DEVICE_ATTR(power1_cap_min, S_IRUGO, amdgpu_hwmon_show_pow=
er_cap_min, NULL, 0);
> +static SENSOR_DEVICE_ATTR(power1_cap, S_IRUGO | S_IWUSR, amdgpu_hwmon_sh=
ow_power_cap, amdgpu_hwmon_set_power_cap, 0);
>
>  static struct attribute *hwmon_attributes[] =3D {
>         &sensor_dev_attr_temp1_input.dev_attr.attr,
> @@ -1235,6 +1301,9 @@ static ssize_t amdgpu_hwmon_show_power_avg(struct d=
evice *dev,
>         &sensor_dev_attr_in1_input.dev_attr.attr,
>         &sensor_dev_attr_in1_label.dev_attr.attr,
>         &sensor_dev_attr_power1_average.dev_attr.attr,
> +       &sensor_dev_attr_power1_cap_max.dev_attr.attr,
> +       &sensor_dev_attr_power1_cap_min.dev_attr.attr,
> +       &sensor_dev_attr_power1_cap.dev_attr.attr,
>         NULL
>  };
>
> @@ -1282,6 +1351,12 @@ static umode_t hwmon_attributes_visible(struct kob=
ject *kobj,
>              attr =3D=3D &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* =
can't manage state */
>                 effective_mode &=3D ~S_IWUSR;
>
> +       if ((adev->flags & AMD_IS_APU) &&
> +           (attr =3D=3D &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
> +            attr =3D=3D &sensor_dev_attr_power1_cap_min.dev_attr.attr||
> +            attr =3D=3D &sensor_dev_attr_power1_cap.dev_attr.attr))
> +               return 0;
> +
>         /* hide max/min values if we can't both query and manage the fan =
*/
>         if ((!adev->powerplay.pp_funcs->set_fan_speed_percent &&
>              !adev->powerplay.pp_funcs->get_fan_speed_percent) &&
> --
> 1.9.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...




--_000_CY4PR12MB1687A137629E3B22710971DBFBE50CY4PR12MB1687namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(33, 33,=
 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP=
&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;"=
>&gt;Isn't the power limit only multiplied by 256 on smu7?&nbsp;</span><br>
</p>
<div><br>
</div>
Yes=1B$B!$=1B(BI will fix it and convert the output to mw.
<div><br>
</div>
<div>Best Regards</div>
<div>Rex<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, January 30, 2018 4:00 AM<br>
<b>To:</b> Zhu, Rex<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu/pm: get/set dgpu power cap via h=
wmon API</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Mon, Jan 29, 2018 at 5:14 AM, Rex Zhu &lt;Rex.Z=
hu-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt; Adust power limit through power1_cap<br>
&gt; Get min/max power limit through power1_cap_min/power1_cap_max<br>
&gt;<br>
&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;<br>
&gt; Change-Id: Idca81ae12dc9fa4e4dd6c89fe47e0318df2859d3<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 75 &#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
<br>
&gt;&nbsp; 1 file changed, 75 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_pm.c<br>
&gt; index b0cdb14..db6e2ba 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; @@ -1207,6 &#43;1207,69 @@ static ssize_t amdgpu_hwmon_show_power_avg(=
struct device *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, P=
AGE_SIZE, &quot;%u\n&quot;, uw);<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; &#43;static ssize_t amdgpu_hwmon_show_power_cap_min(struct device *dev=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; char *buf)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sprintf(buf, &quot;%i=
\n&quot;, 0);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; char *buf)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D dev_get_drvdata(dev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit =3D 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_fu=
ncs &amp;&amp; adev-&gt;powerplay.pp_funcs-&gt;get_power_limit) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;powerplay.pp_funcs-&gt;get_power_limit(adev-&g=
t;powerplay.pp_handle, &amp;limit, true);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &quot;%d w\n&quot;, lim=
it / 256);<br>
<br>
Isn't the power limit only multiplied by 256 on smu7?&nbsp; Please<br>
normalize the internal interface.&nbsp; Also the hwmon API takes the uses<b=
r>
microWatt units, please expose those and convert to normalized<br>
internal units as necessary.<br>
<a href=3D"https://www.kernel.org/doc/Documentation/hwmon/sysfs-interface" =
id=3D"LPlnk37477" previewremoved=3D"true">https://www.kernel.org/doc/Docume=
ntation/hwmon/sysfs-interface</a><br>
<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; char *buf)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D dev_get_drvdata(dev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit =3D 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_fu=
ncs &amp;&amp; adev-&gt;powerplay.pp_funcs-&gt;get_power_limit) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;powerplay.pp_funcs-&gt;get_power_limit(adev-&g=
t;powerplay.pp_handle, &amp;limit, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &quot;%d w\n&quot;, lim=
it / 256);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, &quot;\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;<br>
&gt; &#43;static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; const char *buf,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; size_t count)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D dev_get_drvdata(dev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 value;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D kstrtou32(buf, 10, &=
amp;value);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return err;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D value * 256;<br>
<br>
Same comment here.<br>
<br>
Alex<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_fu=
ncs &amp;&amp; adev-&gt;powerplay.pp_funcs-&gt;set_power_limit) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; err =3D adev-&gt;powerplay.pp_funcs-&gt;set_power_limit=
(adev-&gt;powerplay.pp_handle, value);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (err)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
err;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, amdgpu_hwmon_sho=
w_temp, NULL, 0);<br>
&gt;&nbsp; static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, amdgpu_hwmon_show=
_temp_thresh, NULL, 0);<br>
&gt;&nbsp; static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO, amdgpu_hwmon=
_show_temp_thresh, NULL, 1);<br>
&gt; @@ -1220,6 &#43;1283,9 @@ static ssize_t amdgpu_hwmon_show_power_avg(s=
truct device *dev,<br>
&gt;&nbsp; static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, amdgpu_hwmon_show_=
vddnb, NULL, 0);<br>
&gt;&nbsp; static SENSOR_DEVICE_ATTR(in1_label, S_IRUGO, amdgpu_hwmon_show_=
vddnb_label, NULL, 0);<br>
&gt;&nbsp; static SENSOR_DEVICE_ATTR(power1_average, S_IRUGO, amdgpu_hwmon_=
show_power_avg, NULL, 0);<br>
&gt; &#43;static SENSOR_DEVICE_ATTR(power1_cap_max, S_IRUGO, amdgpu_hwmon_s=
how_power_cap_max, NULL, 0);<br>
&gt; &#43;static SENSOR_DEVICE_ATTR(power1_cap_min, S_IRUGO, amdgpu_hwmon_s=
how_power_cap_min, NULL, 0);<br>
&gt; &#43;static SENSOR_DEVICE_ATTR(power1_cap, S_IRUGO | S_IWUSR, amdgpu_h=
wmon_show_power_cap, amdgpu_hwmon_set_power_cap, 0);<br>
&gt;<br>
&gt;&nbsp; static struct attribute *hwmon_attributes[] =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sensor_dev_attr_t=
emp1_input.dev_attr.attr,<br>
&gt; @@ -1235,6 &#43;1301,9 @@ static ssize_t amdgpu_hwmon_show_power_avg(s=
truct device *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sensor_dev_attr_i=
n1_input.dev_attr.attr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sensor_dev_attr_i=
n1_label.dev_attr.attr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sensor_dev_attr_p=
ower1_average.dev_attr.attr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sensor_dev_attr_power1_=
cap_max.dev_attr.attr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sensor_dev_attr_power1_=
cap_min.dev_attr.attr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sensor_dev_attr_power1_=
cap.dev_attr.attr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt; @@ -1282,6 &#43;1351,12 @@ static umode_t hwmon_attributes_visible(str=
uct kobject *kobj,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; attr =3D=3D &amp;sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can=
't manage state */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; effective_mode &amp;=3D ~S_IWUSR;<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;flags &amp; AM=
D_IS_APU) &amp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (att=
r =3D=3D &amp;sensor_dev_attr_power1_cap_max.dev_attr.attr ||<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; attr =3D=3D &amp;sensor_dev_attr_power1_cap_min.dev_attr.attr||<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; attr =3D=3D &amp;sensor_dev_attr_power1_cap.dev_attr.attr))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* hide max/min values=
 if we can't both query and manage the fan */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((!adev-&gt;powerpl=
ay.pp_funcs-&gt;set_fan_speed_percent &amp;&amp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; !adev-&gt;powerplay.pp_funcs-&gt;get_fan_speed_percent) &amp;&amp;<=
br>
&gt; --<br>
&gt; 1.9.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=
=3D"LPlnk32052" previewremoved=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15172635569800.8063216739451147" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15172635569770.4522080127564547" role=3D"presentat=
ion" cellspacing=3D"0" style=3D"width: 90%; background-color: rgb(255, 255,=
 255); position: relative; overflow: auto; padding-top: 20px; padding-botto=
m: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200); borde=
r-bottom: 1px dotted rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_15172635569780.7714998563208677" colspan=3D"2" style=3D"=
vertical-align: top; position: relative; padding: 0px; display: table-cell;=
">
<div id=3D"LPRemovePreviewContainer_15172635569790.8900824754268704"></div>
<div id=3D"LPTitle_15172635569790.2954400542439797" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: normal; font-size: 21px; font-family: wf_=
segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-he=
ight: 21px;">
<a id=3D"LPUrlAnchor_15172635569790.2935921932351151" href=3D"https://lists=
.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-=
decoration: none;">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15172635569790.030739303613855462" style=3D"margin: 1=
0px 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: =
wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Ari=
al, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15172635569800.3105988911815125" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_seg=
oe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sa=
ns-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow: =
hidden;">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1687A137629E3B22710971DBFBE50CY4PR12MB1687namp_--

--===============2064956500==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2064956500==--
