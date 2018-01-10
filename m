From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: add custom power policy support in sysfs
Date: Wed, 10 Jan 2018 22:33:01 +0000
Message-ID: <CY4PR12MB1687E0FFA27CFA6F132C5731FB110@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1515582075-6326-1-git-send-email-Rex.Zhu@amd.com>,
 <CADnq5_PEegETmiiS+itf-HJKYH6ZeK7DEh6yJQc1kP-o7k+raA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0960437124=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_PEegETmiiS+itf-HJKYH6ZeK7DEh6yJQc1kP-o7k+raA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--===============0960437124==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687E0FFA27CFA6F132C5731FB110CY4PR12MB1687namp_"

--_000_CY4PR12MB1687E0FFA27CFA6F132C5731FB110CY4PR12MB1687namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Yes, this new interface is more common, I just save the input and send to h=
w backend. Smu7 and Vega can share this interface.


Best Regards
Rex
________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, January 11, 2018 4:18:11 AM
To: Zhu, Rex
Cc: amd-gfx list
Subject: Re: [PATCH 1/2] drm/amdgpu: add custom power policy support in sys=
fs

On Wed, Jan 10, 2018 at 6:01 AM, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:
> when cat pp_power_profile_mode on Vega10
> NUM        MODE_NAME BUSY_SET_POINT FPS USE_RLC_BUSY MIN_ACTIVE_LEVEL
>   0 3D_FULL_SCREEN :             70  60          1              3
>   1   POWER_SAVING :             90  60          0              0
>   2          VIDEO*:             70  60          0              0
>   3             VR :             70  90          0              0
>   4       COMPUTER :             30  60          0              6
>   5         CUSTOM :              0   0          0              0
>
> the result show all the profile mode we can support and custom mode.
> user can echo the num(0-4) to pp_power_profile_mode to select the profile
> mode or can echo "5 value value value value" to enter CUSTOM mode.
> the four parameter is set_point/FPS/USER_RLC_BUSY/MIN_ACTIVE_LEVEL.
>

Is there any way we can unify this with profile stuff implemented for
smu7?  I'd like to avoid lots of haphazard interfaces to support
specific use cases and asics.  It becomes a maintenance nightmare.

Alex

> Change-Id: I72634646a9a179ccd57f175b4c0b3f45e538a03f
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h        |  8 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c         | 81 ++++++++++++++++++++=
+++++-
>  drivers/gpu/drm/amd/include/kgd_pp_interface.h | 11 +++-
>  3 files changed, 98 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_dpm.h
> index 8a8d09dd..986f1d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> @@ -366,6 +366,14 @@ enum amdgpu_pcie_gen {
>                         (adev)->powerplay.pp_handle, virtual_addr_low, \
>                         virtual_addr_hi, mc_addr_low, mc_addr_hi, size)
>
> +#define amdgpu_dpm_get_power_profile_mode(adev, buf) \
> +               ((adev)->powerplay.pp_funcs->get_power_profile_mode(\
> +                       (adev)->powerplay.pp_handle, buf))
> +
> +#define amdgpu_dpm_set_power_profile_mode(adev, parameter, size) \
> +               ((adev)->powerplay.pp_funcs->set_power_profile_mode(\
> +                       (adev)->powerplay.pp_handle, parameter, size))
> +
>  struct amdgpu_dpm {
>         struct amdgpu_ps        *ps;
>         /* number of valid power states */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_pm.c
> index e5ee7cf..662edca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -584,6 +584,73 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *=
dev,
>         return count;
>  }
>
> +static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
> +               struct device_attribute *attr,
> +               char *buf)
> +{
> +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> +       struct amdgpu_device *adev =3D ddev->dev_private;
> +
> +       if (adev->powerplay.pp_funcs->get_power_profile_mode)
> +               return amdgpu_dpm_get_power_profile_mode(adev, buf);
> +
> +       return snprintf(buf, PAGE_SIZE, "\n");
> +}
> +
> +
> +static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
> +               struct device_attribute *attr,
> +               const char *buf,
> +               size_t count)
> +{
> +       int ret =3D 0xff;
> +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> +       struct amdgpu_device *adev =3D ddev->dev_private;
> +       uint32_t parameter_size =3D 0;
> +       long parameter[64];
> +       char *sub_str, buf_cpy[128];
> +       char *tmp_str;
> +       uint32_t i =3D 0;
> +       char tmp[2];
> +       long int profile_mode =3D 0;
> +       const char delimiter[3] =3D {' ', '\n', '\0'};
> +
> +       tmp[0] =3D *(buf);
> +       tmp[1] =3D '\0';
> +       ret =3D kstrtol(tmp, 0, &profile_mode);
> +       if (ret)
> +               goto fail;
> +
> +       if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> +               if (count < 2 || count > 127)
> +                       return -EINVAL;
> +               while (isspace(*++buf))
> +                       i++;
> +               memcpy(buf_cpy, buf, count-i);
> +               tmp_str =3D buf_cpy;
> +               while (tmp_str[0]) {
> +                       sub_str =3D strsep(&tmp_str, delimiter);
> +                       ret =3D kstrtol(sub_str, 0, &parameter[parameter_=
size]);
> +                       if (ret) {
> +                               count =3D -EINVAL;
> +                               goto fail;
> +                       }
> +                       pr_info("value is %ld \n", parameter[parameter_si=
ze]);
> +                       parameter_size++;
> +                       while (isspace(*tmp_str))
> +                               tmp_str++;
> +               }
> +       }
> +       parameter[parameter_size] =3D profile_mode;
> +       if (adev->powerplay.pp_funcs->set_power_profile_mode)
> +               ret =3D amdgpu_dpm_set_power_profile_mode(adev, parameter=
, parameter_size);
> +
> +       if (!ret)
> +               return count;
> +fail:
> +       return -EINVAL;
> +}
> +
>  static ssize_t amdgpu_get_pp_power_profile(struct device *dev,
>                 char *buf, struct amd_pp_profile *query)
>  {
> @@ -772,7 +839,9 @@ static DEVICE_ATTR(pp_gfx_power_profile, S_IRUGO | S_=
IWUSR,
>  static DEVICE_ATTR(pp_compute_power_profile, S_IRUGO | S_IWUSR,
>                 amdgpu_get_pp_compute_power_profile,
>                 amdgpu_set_pp_compute_power_profile);
> -
> +static DEVICE_ATTR(pp_power_profile_mode, S_IRUGO | S_IWUSR,
> +               amdgpu_get_pp_power_profile_mode,
> +               amdgpu_set_pp_power_profile_mode);
>  static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
>                                       struct device_attribute *attr,
>                                       char *buf)
> @@ -1405,6 +1474,14 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *ade=
v)
>                 return ret;
>         }
>
> +       ret =3D device_create_file(adev->dev,
> +                       &dev_attr_pp_power_profile_mode);
> +       if (ret) {
> +               DRM_ERROR("failed to create device file "
> +                               "pp_power_profile_mode\n");
> +               return ret;
> +       }
> +
>         ret =3D amdgpu_debugfs_pm_init(adev);
>         if (ret) {
>                 DRM_ERROR("Failed to register debugfs file for dpm!\n");
> @@ -1440,6 +1517,8 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *ade=
v)
>                         &dev_attr_pp_gfx_power_profile);
>         device_remove_file(adev->dev,
>                         &dev_attr_pp_compute_power_profile);
> +       device_remove_file(adev->dev,
> +                       &dev_attr_pp_power_profile_mode);
>  }
>
>  void amdgpu_pm_compute_clocks(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu=
/drm/amd/include/kgd_pp_interface.h
> index 0f89d2a8..a823c03 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -140,7 +140,14 @@ struct amd_pp_init {
>         uint32_t feature_mask;
>  };
>
> -
> +enum PP_SMC_POWER_PROFILE {
> +       PP_SMC_POWER_PROFILE_FULLSCREEN3D =3D 0x0,
> +       PP_SMC_POWER_PROFILE_POWERSAVING  =3D 0x1,
> +       PP_SMC_POWER_PROFILE_VIDEO        =3D 0x2,
> +       PP_SMC_POWER_PROFILE_VR           =3D 0x3,
> +       PP_SMC_POWER_PROFILE_COMPUTE      =3D 0x4,
> +       PP_SMC_POWER_PROFILE_CUSTOM       =3D 0x5,
> +};
>
>  enum {
>         PP_GROUP_UNKNOWN =3D 0,
> @@ -289,6 +296,8 @@ struct amd_pm_funcs {
>                                 struct pp_display_clock_request *clock);
>         int (*get_display_mode_validation_clocks)(void *handle,
>                 struct amd_pp_simple_clock_info *clocks);
> +       int (*get_power_profile_mode)(void *handle, char *buf);
> +       int (*set_power_profile_mode)(void *handle, long *input, uint32_t=
 size);
>  };
>
>  #endif
> --
> 1.9.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB1687E0FFA27CFA6F132C5731FB110CY4PR12MB1687namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
Yes, this new interface is more common, I just save the input and send to h=
w backend. Smu7 and Vega can share this interface.<br>
<br>
<br>
Best Regards<br>
Rex<br>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, January 11, 2018 4:18:11 AM<br>
<b>To:</b> Zhu, Rex<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: add custom power policy support=
 in sysfs</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Wed, Jan 10, 2018 at 6:01 AM, Rex Zhu &lt;Rex.Z=
hu-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt; when cat pp_power_profile_mode on Vega10<br>
&gt; NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MODE_NAME BUSY_SET_POINT=
 FPS USE_RLC_BUSY MIN_ACTIVE_LEVEL<br>
&gt;&nbsp;&nbsp; 0 3D_FULL_SCREEN :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 70&nbsp; 60&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 3<br>
&gt;&nbsp;&nbsp; 1&nbsp;&nbsp; POWER_SAVING :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 90&nbsp; 60&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
&gt;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VI=
DEO*:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 70&nbsp; 60&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
<br>
&gt;&nbsp;&nbsp; 3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; VR :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 70&nbsp; 90&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0<br>
&gt;&nbsp;&nbsp; 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; COMPUTER :&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 30&nbsp; 60&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6<br>
&gt;&nbsp;&nbsp; 5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CUSTOM :=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 0&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 0<br>
&gt;<br>
&gt; the result show all the profile mode we can support and custom mode.<b=
r>
&gt; user can echo the num(0-4) to pp_power_profile_mode to select the prof=
ile<br>
&gt; mode or can echo &quot;5 value value value value&quot; to enter CUSTOM=
 mode.<br>
&gt; the four parameter is set_point/FPS/USER_RLC_BUSY/MIN_ACTIVE_LEVEL.<br=
>
&gt;<br>
<br>
Is there any way we can unify this with profile stuff implemented for<br>
smu7?&nbsp; I'd like to avoid lots of haphazard interfaces to support<br>
specific use cases and asics.&nbsp; It becomes a maintenance nightmare.<br>
<br>
Alex<br>
<br>
&gt; Change-Id: I72634646a9a179ccd57f175b4c0b3f45e538a03f<br>
&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; |&nbsp; 8 &#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; | 81 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;-<br>
&gt;&nbsp; drivers/gpu/drm/amd/include/kgd_pp_interface.h | 11 &#43;&#43;&#=
43;-<br>
&gt;&nbsp; 3 files changed, 98 insertions(&#43;), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_dpm.h<br>
&gt; index 8a8d09dd..986f1d5 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h<br>
&gt; @@ -366,6 &#43;366,14 @@ enum amdgpu_pcie_gen {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (=
adev)-&gt;powerplay.pp_handle, virtual_addr_low, \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v=
irtual_addr_hi, mc_addr_low, mc_addr_hi, size)<br>
&gt;<br>
&gt; &#43;#define amdgpu_dpm_get_power_profile_mode(adev, buf) \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ((adev)-&gt;powerplay.pp_funcs-&gt;get_power_profile_mo=
de(\<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev)-=
&gt;powerplay.pp_handle, buf))<br>
&gt; &#43;<br>
&gt; &#43;#define amdgpu_dpm_set_power_profile_mode(adev, parameter, size) =
\<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ((adev)-&gt;powerplay.pp_funcs-&gt;set_power_profile_mo=
de(\<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev)-=
&gt;powerplay.pp_handle, parameter, size))<br>
&gt; &#43;<br>
&gt;&nbsp; struct amdgpu_dpm {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ps&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ps;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* number of valid pow=
er states */<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_pm.c<br>
&gt; index e5ee7cf..662edca 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; @@ -584,6 &#43;584,73 @@ static ssize_t amdgpu_set_pp_mclk_od(struct d=
evice *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; &#43;static ssize_t amdgpu_get_pp_power_profile_mode(struct device *de=
v,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; char *buf)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D =
dev_get_drvdata(dev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D ddev-&gt;dev_private;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_fu=
ncs-&gt;get_power_profile_mode)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return amdgpu_dpm_get_power_profile_mode(adev, buf);<br=
>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAGE_SI=
ZE, &quot;\n&quot;);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;<br>
&gt; &#43;static ssize_t amdgpu_set_pp_power_profile_mode(struct device *de=
v,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; const char *buf,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; size_t count)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0xff;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D =
dev_get_drvdata(dev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D ddev-&gt;dev_private;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t parameter_size =3D =
0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long parameter[64];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *sub_str, buf_cpy[128];=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *tmp_str;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char tmp[2];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long int profile_mode =3D 0;=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char delimiter[3] =3D =
{' ', '\n', '\0'};<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp[0] =3D *(buf);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp[1] =3D '\0';<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kstrtol(tmp, 0, &amp=
;profile_mode);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto fail;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (profile_mode =3D=3D PP_S=
MC_POWER_PROFILE_CUSTOM) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (count &lt; 2 || count &gt; 127)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; while (isspace(*&#43;&#43;buf))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i&#43;&=
#43;;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; memcpy(buf_cpy, buf, count-i);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; tmp_str =3D buf_cpy;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; while (tmp_str[0]) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sub_str=
 =3D strsep(&amp;tmp_str, delimiter);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D=
 kstrtol(sub_str, 0, &amp;parameter[parameter_size]);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret=
) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count =3D -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fail;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info=
(&quot;value is %ld \n&quot;, parameter[parameter_size]);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; paramet=
er_size&#43;&#43;;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (=
isspace(*tmp_str))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_str&#43;&#43;;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; parameter[parameter_size] =
=3D profile_mode;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_fu=
ncs-&gt;set_power_profile_mode)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_dpm_set_power_profile_mode(adev, paramet=
er, parameter_size);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return count;<br>
&gt; &#43;fail:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; static ssize_t amdgpu_get_pp_power_profile(struct device *dev,<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; char *buf, struct amd_pp_profile *query)<br>
&gt;&nbsp; {<br>
&gt; @@ -772,7 &#43;839,9 @@ static DEVICE_ATTR(pp_gfx_power_profile, S_IRU=
GO | S_IWUSR,<br>
&gt;&nbsp; static DEVICE_ATTR(pp_compute_power_profile, S_IRUGO | S_IWUSR,<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_pp_compute_power_profile,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_set_pp_compute_power_profile);<br>
&gt; -<br>
&gt; &#43;static DEVICE_ATTR(pp_power_profile_mode, S_IRUGO | S_IWUSR,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_get_pp_power_profile_mode,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_set_pp_power_profile_mode);<br>
&gt;&nbsp; static ssize_t amdgpu_hwmon_show_temp(struct device *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; struct device_attribute *attr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; char *buf)<br>
&gt; @@ -1405,6 &#43;1474,14 @@ int amdgpu_pm_sysfs_init(struct amdgpu_devi=
ce *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_file(a=
dev-&gt;dev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;de=
v_attr_pp_power_profile_mode);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to create device file &quot;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;pp_power_profile_mode\n&quot=
;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_debugfs=
_pm_init(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to register debugfs file f=
or dpm!\n&quot;);<br>
&gt; @@ -1440,6 &#43;1517,8 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_devi=
ce *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
amp;dev_attr_pp_gfx_power_profile);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remove_file(ade=
v-&gt;dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
amp;dev_attr_pp_compute_power_profile);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remove_file(adev-&gt;=
dev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;de=
v_attr_pp_power_profile_mode);<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt;&nbsp; void amdgpu_pm_compute_clocks(struct amdgpu_device *adev)<br>
&gt; diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/=
gpu/drm/amd/include/kgd_pp_interface.h<br>
&gt; index 0f89d2a8..a823c03 100644<br>
&gt; --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&gt; @@ -140,7 &#43;140,14 @@ struct amd_pp_init {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t feature_mask;=
<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt; -<br>
&gt; &#43;enum PP_SMC_POWER_PROFILE {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_SMC_POWER_PROFILE_FULLSCR=
EEN3D =3D 0x0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_SMC_POWER_PROFILE_POWERSA=
VING&nbsp; =3D 0x1,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_SMC_POWER_PROFILE_VIDEO&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x2,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_SMC_POWER_PROFILE_VR&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x3,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_SMC_POWER_PROFILE_COMPUTE=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x4,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_SMC_POWER_PROFILE_CUSTOM&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x5,<br>
&gt; &#43;};<br>
&gt;<br>
&gt;&nbsp; enum {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_GROUP_UNKNOWN =3D 0=
,<br>
&gt; @@ -289,6 &#43;296,8 @@ struct amd_pm_funcs {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_display_clock_requ=
est *clock);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_display_mode=
_validation_clocks)(void *handle,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_simple_clock_info *clocks);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_power_profile_mode=
)(void *handle, char *buf);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_power_profile_mode=
)(void *handle, long *input, uint32_t size);<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; #endif<br>
&gt; --<br>
&gt; 1.9.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB1687E0FFA27CFA6F132C5731FB110CY4PR12MB1687namp_--

--===============0960437124==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0960437124==--
