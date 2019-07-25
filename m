From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/5] drm/amd/powerplay: move
 smu_feature_update_enable_state to up level
Date: Thu, 25 Jul 2019 09:50:05 +0000
Message-ID: <MN2PR12MB3296C342CE9530F7A6754BEBA2C10@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20190725051057.28862-1-kevin1.wang@amd.com>
 <20190725051057.28862-4-kevin1.wang@amd.com>,
 <MN2PR12MB334402CBE2CB315E0205EC3BE4C10@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1635361213=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB334402CBE2CB315E0205EC3BE4C10-rweVpJHSKToDMgCC8P//OwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Huang,
 Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>

--===============1635361213==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3296C342CE9530F7A6754BEBA2C10MN2PR12MB3296namp_"

--_000_MN2PR12MB3296C342CE9530F7A6754BEBA2C10MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

i will addressed it before submit patch.
thanks.

Best Regards,
Kevin
________________________________
From: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, July 25, 2019 5:29 PM
To: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org =
<amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Huang, Ray <Ray.Huang@a=
md.com>; Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>; Wang, Kevin(Yang) <Kevin1.Wa=
ng-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 4/5] drm/amd/powerplay: move smu_feature_update_enable_=
state to up level

+       feature_mask =3D 1UL << feature_id;
Use "ULL" here. That can guard it to be 64bits long even on 32bits target.
With that fixed, reviewed-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of
> Wang, Kevin(Yang)
> Sent: Thursday, July 25, 2019 1:11 PM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Huang, Ray
> <Ray.Huang-5C7GfCeVMHo@public.gmane.org>; Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>; Wang,
> Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
> Subject: [PATCH 4/5] drm/amd/powerplay: move
> smu_feature_update_enable_state to up level
>
> this function is not ip or asic related function,
> so move it to top level as public api in smu.
>
> Signed-off-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 40
> ++++++++++++++++++-
>  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  4 +-
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 39 ------------------
>  3 files changed, 40 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 8563f9083f4e..e881de955388 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -507,6 +507,41 @@ int smu_feature_init_dpm(struct smu_context
> *smu)
>
>        return ret;
>  }
> +int smu_feature_update_enable_state(struct smu_context *smu, uint64_t
> feature_mask, bool enabled)
> +{
> +     uint32_t feature_low =3D 0, feature_high =3D 0;
> +     int ret =3D 0;
> +
> +     if (!smu->pm_enabled)
> +             return ret;
> +
> +     feature_low =3D (feature_mask >> 0 ) & 0xffffffff;
> +     feature_high =3D (feature_mask >> 32) & 0xffffffff;
> +
> +     if (enabled) {
> +             ret =3D smu_send_smc_msg_with_param(smu,
> SMU_MSG_EnableSmuFeaturesLow,
> +                                               feature_low);
> +             if (ret)
> +                     return ret;
> +             ret =3D smu_send_smc_msg_with_param(smu,
> SMU_MSG_EnableSmuFeaturesHigh,
> +                                               feature_high);
> +             if (ret)
> +                     return ret;
> +
> +     } else {
> +             ret =3D smu_send_smc_msg_with_param(smu,
> SMU_MSG_DisableSmuFeaturesLow,
> +                                               feature_low);
> +             if (ret)
> +                     return ret;
> +             ret =3D smu_send_smc_msg_with_param(smu,
> SMU_MSG_DisableSmuFeaturesHigh,
> +                                               feature_high);
> +             if (ret)
> +                     return ret;
> +
> +     }
> +
> +     return ret;
> +}
>
>  int smu_feature_is_enabled(struct smu_context *smu, enum
> smu_feature_mask mask)
>  {
> @@ -532,6 +567,7 @@ int smu_feature_set_enabled(struct smu_context
> *smu, enum smu_feature_mask mask,
>  {
>        struct smu_feature *feature =3D &smu->smu_feature;
>        int feature_id;
> +     uint64_t feature_mask =3D 0;
>        int ret =3D 0;
>
>        feature_id =3D smu_feature_get_index(smu, mask);
> @@ -540,8 +576,10 @@ int smu_feature_set_enabled(struct smu_context
> *smu, enum smu_feature_mask mask,
>
>        WARN_ON(feature_id > feature->feature_num);
>
> +     feature_mask =3D 1UL << feature_id;
> +
>        mutex_lock(&feature->mutex);
> -     ret =3D smu_feature_update_enable_state(smu, feature_id, enable);
> +     ret =3D smu_feature_update_enable_state(smu, feature_mask,
> enable);
>        if (ret)
>                goto failed;
>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index ba2385026b89..abc2644b4c07 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -479,7 +479,6 @@ struct smu_funcs
>        int (*init_display_count)(struct smu_context *smu, uint32_t count)=
;
>        int (*set_allowed_mask)(struct smu_context *smu);
>        int (*get_enabled_mask)(struct smu_context *smu, uint32_t
> *feature_mask, uint32_t num);
> -     int (*update_feature_enable_state)(struct smu_context *smu,
> uint32_t feature_id, bool enabled);
>        int (*notify_display_change)(struct smu_context *smu);
>        int (*get_power_limit)(struct smu_context *smu, uint32_t *limit,
> bool def);
>        int (*set_power_limit)(struct smu_context *smu, uint32_t n);
> @@ -595,8 +594,6 @@ struct smu_funcs
>        ((smu)->funcs->get_enabled_mask? (smu)->funcs-
> >get_enabled_mask((smu), (mask), (num)) : 0)
>  #define smu_is_dpm_running(smu) \
>        ((smu)->ppt_funcs->is_dpm_running ? (smu)->ppt_funcs-
> >is_dpm_running((smu)) : 0)
> -#define smu_feature_update_enable_state(smu, feature_id, enabled) \
> -     ((smu)->funcs->update_feature_enable_state? (smu)->funcs-
> >update_feature_enable_state((smu), (feature_id), (enabled)) : 0)
>  #define smu_notify_display_change(smu) \
>        ((smu)->funcs->notify_display_change? (smu)->funcs-
> >notify_display_change((smu)) : 0)
>  #define smu_store_powerplay_table(smu) \
> @@ -804,6 +801,7 @@ enum amd_dpm_forced_level
> smu_get_performance_level(struct smu_context *smu);
>  int smu_force_performance_level(struct smu_context *smu, enum
> amd_dpm_forced_level level);
>  int smu_set_display_count(struct smu_context *smu, uint32_t count);
>  bool smu_clk_dpm_is_enabled(struct smu_context *smu, enum
> smu_clk_type clk_type);
> +int smu_feature_update_enable_state(struct smu_context *smu, uint64_t
> feature_mask, bool enabled);
>  const char *smu_get_message_name(struct smu_context *smu, enum
> smu_message_type type);
>  const char *smu_get_feature_name(struct smu_context *smu, enum
> smu_feature_mask feature);
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index ccf6af055d03..93f3ffb8b471 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -795,44 +795,6 @@ static int smu_v11_0_init_display_count(struct
> smu_context *smu, uint32_t count)
>        return ret;
>  }
>
> -static int smu_v11_0_update_feature_enable_state(struct smu_context
> *smu, uint32_t feature_id, bool enabled)
> -{
> -     uint32_t feature_low =3D 0, feature_high =3D 0;
> -     int ret =3D 0;
> -
> -     if (!smu->pm_enabled)
> -             return ret;
> -     if (feature_id >=3D 0 && feature_id < 31)
> -             feature_low =3D (1 << feature_id);
> -     else if (feature_id > 31 && feature_id < 63)
> -             feature_high =3D (1 << feature_id);
> -     else
> -             return -EINVAL;
> -
> -     if (enabled) {
> -             ret =3D smu_send_smc_msg_with_param(smu,
> SMU_MSG_EnableSmuFeaturesLow,
> -                                               feature_low);
> -             if (ret)
> -                     return ret;
> -             ret =3D smu_send_smc_msg_with_param(smu,
> SMU_MSG_EnableSmuFeaturesHigh,
> -                                               feature_high);
> -             if (ret)
> -                     return ret;
> -
> -     } else {
> -             ret =3D smu_send_smc_msg_with_param(smu,
> SMU_MSG_DisableSmuFeaturesLow,
> -                                               feature_low);
> -             if (ret)
> -                     return ret;
> -             ret =3D smu_send_smc_msg_with_param(smu,
> SMU_MSG_DisableSmuFeaturesHigh,
> -                                               feature_high);
> -             if (ret)
> -                     return ret;
> -
> -     }
> -
> -     return ret;
> -}
>
>  static int smu_v11_0_set_allowed_mask(struct smu_context *smu)
>  {
> @@ -1781,7 +1743,6 @@ static const struct smu_funcs smu_v11_0_funcs =3D {
>        .set_allowed_mask =3D smu_v11_0_set_allowed_mask,
>        .get_enabled_mask =3D smu_v11_0_get_enabled_mask,
>        .system_features_control =3D smu_v11_0_system_features_control,
> -     .update_feature_enable_state =3D
> smu_v11_0_update_feature_enable_state,
>        .notify_display_change =3D smu_v11_0_notify_display_change,
>        .get_power_limit =3D smu_v11_0_get_power_limit,
>        .set_power_limit =3D smu_v11_0_set_power_limit,
> --
> 2.22.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB3296C342CE9530F7A6754BEBA2C10MN2PR12MB3296namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
i will addressed it before submit patch.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
thanks.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, July 25, 2019 5:29 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Huang, Ray=
 &lt;Ray.Huang-5C7GfCeVMHo@public.gmane.org&gt;; Feng, Kenneth &lt;Kenneth.Feng-5C7GfCeVMHo@public.gmane.org&gt;; Wan=
g, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> RE: [PATCH 4/5] drm/amd/powerplay: move smu_feature_update_=
enable_state to up level</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_=
mask =3D 1UL &lt;&lt; feature_id;<br>
Use &quot;ULL&quot; here. That can guard it to be 64bits long even on 32bit=
s target.<br>
With that fixed, reviewed-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; On Behalf =
Of<br>
&gt; Wang, Kevin(Yang)<br>
&gt; Sent: Thursday, July 25, 2019 1:11 PM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Huang, Ray<b=
r>
&gt; &lt;Ray.Huang-5C7GfCeVMHo@public.gmane.org&gt;; Feng, Kenneth &lt;Kenneth.Feng-5C7GfCeVMHo@public.gmane.org&gt;;=
 Wang,<br>
&gt; Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Subject: [PATCH 4/5] drm/amd/powerplay: move<br>
&gt; smu_feature_update_enable_state to up level<br>
&gt; <br>
&gt; this function is not ip or asic related function,<br>
&gt; so move it to top level as public api in smu.<br>
&gt; <br>
&gt; Signed-off-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/amdgpu_smu.c&nbsp;&nbsp;&nbsp; | 4=
0<br>
&gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;-<br>
&gt;&nbsp; .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp; |&n=
bsp; 4 &#43;-<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/smu_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp=
; | 39 ------------------<br>
&gt;&nbsp; 3 files changed, 40 insertions(&#43;), 43 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; index 8563f9083f4e..e881de955388 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; @@ -507,6 &#43;507,41 @@ int smu_feature_init_dpm(struct smu_context<b=
r>
&gt; *smu)<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt; &#43;int smu_feature_update_enable_state(struct smu_context *smu, uint=
64_t<br>
&gt; feature_mask, bool enabled)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t feature_low =3D 0, feature_high=
 =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return ret;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; feature_low =3D (feature_mask &gt;&gt; 0=
 ) &amp; 0xffffffff;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; feature_high =3D (feature_mask &gt;&gt; =
32) &amp; 0xffffffff;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (enabled) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D smu_send_smc_msg_with_param(smu,<br>
&gt; SMU_MSG_EnableSmuFeaturesLow,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_low);=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (ret)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D smu_send_smc_msg_with_param(smu,<br>
&gt; SMU_MSG_EnableSmuFeaturesHigh,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_high)=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (ret)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D smu_send_smc_msg_with_param(smu,<br>
&gt; SMU_MSG_DisableSmuFeaturesLow,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_low);=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (ret)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D smu_send_smc_msg_with_param(smu,<br>
&gt; SMU_MSG_DisableSmuFeaturesHigh,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_high)=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (ret)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;}<br>
&gt; <br>
&gt;&nbsp; int smu_feature_is_enabled(struct smu_context *smu, enum<br>
&gt; smu_feature_mask mask)<br>
&gt;&nbsp; {<br>
&gt; @@ -532,6 &#43;567,7 @@ int smu_feature_set_enabled(struct smu_context=
<br>
&gt; *smu, enum smu_feature_mask mask,<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_feature *feature =
=3D &amp;smu-&gt;smu_feature;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int feature_id;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t feature_mask =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_id =3D smu_feature_g=
et_index(smu, mask);<br>
&gt; @@ -540,8 &#43;576,10 @@ int smu_feature_set_enabled(struct smu_contex=
t<br>
&gt; *smu, enum smu_feature_mask mask,<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(feature_id &gt; feat=
ure-&gt;feature_num);<br>
&gt; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; feature_mask =3D 1UL &lt;&lt; feature_id=
;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;feature-&gt;=
mutex);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_feature_update_enable_state(smu,=
 feature_id, enable);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_feature_update_enable_state(=
smu, feature_mask,<br>
&gt; enable);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto failed;<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&gt; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&gt; index ba2385026b89..abc2644b4c07 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&gt; @@ -479,7 &#43;479,6 @@ struct smu_funcs<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*init_display_count)(st=
ruct smu_context *smu, uint32_t count);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_allowed_mask)(stru=
ct smu_context *smu);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_enabled_mask)(stru=
ct smu_context *smu, uint32_t<br>
&gt; *feature_mask, uint32_t num);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int (*update_feature_enable_state)(struct sm=
u_context *smu,<br>
&gt; uint32_t feature_id, bool enabled);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*notify_display_change)=
(struct smu_context *smu);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_power_limit)(struc=
t smu_context *smu, uint32_t *limit,<br>
&gt; bool def);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_power_limit)(struc=
t smu_context *smu, uint32_t n);<br>
&gt; @@ -595,8 &#43;594,6 @@ struct smu_funcs<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&gt;get_ena=
bled_mask? (smu)-&gt;funcs-<br>
&gt; &gt;get_enabled_mask((smu), (mask), (num)) : 0)<br>
&gt;&nbsp; #define smu_is_dpm_running(smu) \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;is_=
dpm_running ? (smu)-&gt;ppt_funcs-<br>
&gt; &gt;is_dpm_running((smu)) : 0)<br>
&gt; -#define smu_feature_update_enable_state(smu, feature_id, enabled) \<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&gt;update_feature_enable_s=
tate? (smu)-&gt;funcs-<br>
&gt; &gt;update_feature_enable_state((smu), (feature_id), (enabled)) : 0)<b=
r>
&gt;&nbsp; #define smu_notify_display_change(smu) \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&gt;notify_=
display_change? (smu)-&gt;funcs-<br>
&gt; &gt;notify_display_change((smu)) : 0)<br>
&gt;&nbsp; #define smu_store_powerplay_table(smu) \<br>
&gt; @@ -804,6 &#43;801,7 @@ enum amd_dpm_forced_level<br>
&gt; smu_get_performance_level(struct smu_context *smu);<br>
&gt;&nbsp; int smu_force_performance_level(struct smu_context *smu, enum<br=
>
&gt; amd_dpm_forced_level level);<br>
&gt;&nbsp; int smu_set_display_count(struct smu_context *smu, uint32_t coun=
t);<br>
&gt;&nbsp; bool smu_clk_dpm_is_enabled(struct smu_context *smu, enum<br>
&gt; smu_clk_type clk_type);<br>
&gt; &#43;int smu_feature_update_enable_state(struct smu_context *smu, uint=
64_t<br>
&gt; feature_mask, bool enabled);<br>
&gt;&nbsp; const char *smu_get_message_name(struct smu_context *smu, enum<b=
r>
&gt; smu_message_type type);<br>
&gt;&nbsp; const char *smu_get_feature_name(struct smu_context *smu, enum<b=
r>
&gt; smu_feature_mask feature);<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&gt; index ccf6af055d03..93f3ffb8b471 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&gt; @@ -795,44 &#43;795,6 @@ static int smu_v11_0_init_display_count(struc=
t<br>
&gt; smu_context *smu, uint32_t count)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt; -static int smu_v11_0_update_feature_enable_state(struct smu_context<b=
r>
&gt; *smu, uint32_t feature_id, bool enabled)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t feature_low =3D 0, feature_high =3D=
 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (feature_id &gt;=3D 0 &amp;&amp; feature_=
id &lt; 31)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; feature_low =3D (1 &lt;&lt; feature_id);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else if (feature_id &gt; 31 &amp;&amp; featu=
re_id &lt; 63)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; feature_high =3D (1 &lt;&lt; feature_id);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (enabled) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D smu_send_smc_msg_with_param(smu,<br>
&gt; SMU_MSG_EnableSmuFeaturesLow,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_low);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ret)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D smu_send_smc_msg_with_param(smu,<br>
&gt; SMU_MSG_EnableSmuFeaturesHigh,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_high);<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ret)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D smu_send_smc_msg_with_param(smu,<br>
&gt; SMU_MSG_DisableSmuFeaturesLow,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_low);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ret)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D smu_send_smc_msg_with_param(smu,<br>
&gt; SMU_MSG_DisableSmuFeaturesHigh,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_high);<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ret)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; -}<br>
&gt; <br>
&gt;&nbsp; static int smu_v11_0_set_allowed_mask(struct smu_context *smu)<b=
r>
&gt;&nbsp; {<br>
&gt; @@ -1781,7 &#43;1743,6 @@ static const struct smu_funcs smu_v11_0_func=
s =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_allowed_mask =3D smu_v1=
1_0_set_allowed_mask,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_enabled_mask =3D smu_v1=
1_0_get_enabled_mask,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .system_features_control =3D=
 smu_v11_0_system_features_control,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .update_feature_enable_state =3D<br>
&gt; smu_v11_0_update_feature_enable_state,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .notify_display_change =3D s=
mu_v11_0_notify_display_change,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_power_limit =3D smu_v11=
_0_get_power_limit,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_limit =3D smu_v11=
_0_set_power_limit,<br>
&gt; --<br>
&gt; 2.22.0<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB3296C342CE9530F7A6754BEBA2C10MN2PR12MB3296namp_--

--===============1635361213==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1635361213==--
