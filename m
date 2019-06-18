From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 247/459] Revert "drm/amdgpu: mask some pm interfaces for
 navi10 because they are changed or not workable so far"
Date: Tue, 18 Jun 2019 13:44:25 +0000
Message-ID: <MN2PR12MB3296A379AAC5F95927A9A3D9A2EA0@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20190617193106.18231-1-alexander.deucher@amd.com>
 <20190617193106.18231-48-alexander.deucher@amd.com>,
 <693bbb9c-2ff2-f25b-2d32-7729b1a46d84@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0820557643=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <693bbb9c-2ff2-f25b-2d32-7729b1a46d84-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Huang,
 Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>

--===============0820557643==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3296A379AAC5F95927A9A3D9A2EA0MN2PR12MB3296namp_"

--_000_MN2PR12MB3296A379AAC5F95927A9A3D9A2EA0MN2PR12MB3296namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

i think should be drop this patch  from git tree,

this patch only for bringing up stage.

thanks.


Best Regards,
Kevin


________________________________
From: Christian K?nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, June 18, 2019 3:58:28 PM
To: Alex Deucher; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander; Wang, Kevin(Yang); Huang, Ray
Subject: Re: [PATCH 247/459] Revert "drm/amdgpu: mask some pm interfaces fo=
r navi10 because they are changed or not workable so far"

Am 17.06.19 um 21:30 schrieb Alex Deucher:
> From: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>
>
> This reverts commit fd9c75d217d5b4ed72672722b6621e2635363dfe.
>
> Signed-off-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>
> Reviewed-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

Would it be possible to squash that into the original commit which
disabled things?

Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c  | 156 +++++++++++-------------
>   2 files changed, 73 insertions(+), 85 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index af86d9f47785..ed051fdb509f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -690,7 +690,7 @@ static int amdgpu_info_ioctl(struct drm_device *dev, =
void *data, struct drm_file
>                dev_info.num_shader_arrays_per_engine =3D adev->gfx.config=
.max_sh_per_se;
>                /* return all clocks in KHz */
>                dev_info.gpu_counter_freq =3D amdgpu_asic_get_xclk(adev) *=
 10;
> -             if (adev->pm.dpm_enabled && adev->asic_type !=3D CHIP_NAVI1=
0) {
> +             if (adev->pm.dpm_enabled) {
>                        dev_info.max_engine_clock =3D amdgpu_dpm_get_sclk(=
adev, false) * 10;
>                        dev_info.max_memory_clock =3D amdgpu_dpm_get_mclk(=
adev, false) * 10;
>                } else if (amdgpu_sriov_vf(adev) && amdgim_is_hwperf(adev)=
 &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_pm.c
> index 8c28f816b50f..6b97f3098118 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -2793,33 +2793,32 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *ad=
ev)
>                return ret;
>        }
>
> -     if (adev->asic_type !=3D CHIP_NAVI10) {
> -             ret =3D device_create_file(adev->dev, &dev_attr_power_dpm_s=
tate);
> -             if (ret) {
> -                     DRM_ERROR("failed to create device file for dpm sta=
te\n");
> -                     return ret;
> -             }
> -             ret =3D device_create_file(adev->dev, &dev_attr_power_dpm_f=
orce_performance_level);
> -             if (ret) {
> -                     DRM_ERROR("failed to create device file for dpm sta=
te\n");
> -                     return ret;
> -             }
> +     ret =3D device_create_file(adev->dev, &dev_attr_power_dpm_state);
> +     if (ret) {
> +             DRM_ERROR("failed to create device file for dpm state\n");
> +             return ret;
> +     }
> +     ret =3D device_create_file(adev->dev, &dev_attr_power_dpm_force_per=
formance_level);
> +     if (ret) {
> +             DRM_ERROR("failed to create device file for dpm state\n");
> +             return ret;
> +     }
>
> -             ret =3D device_create_file(adev->dev, &dev_attr_pp_num_stat=
es);
> -             if (ret) {
> -                     DRM_ERROR("failed to create device file pp_num_stat=
es\n");
> -                     return ret;
> -             }
> -             ret =3D device_create_file(adev->dev, &dev_attr_pp_cur_stat=
e);
> -             if (ret) {
> -                     DRM_ERROR("failed to create device file pp_cur_stat=
e\n");
> -                     return ret;
> -             }
> -             ret =3D device_create_file(adev->dev, &dev_attr_pp_force_st=
ate);
> -             if (ret) {
> -                     DRM_ERROR("failed to create device file pp_force_st=
ate\n");
> -                     return ret;
> -             }
> +
> +     ret =3D device_create_file(adev->dev, &dev_attr_pp_num_states);
> +     if (ret) {
> +             DRM_ERROR("failed to create device file pp_num_states\n");
> +             return ret;
> +     }
> +     ret =3D device_create_file(adev->dev, &dev_attr_pp_cur_state);
> +     if (ret) {
> +             DRM_ERROR("failed to create device file pp_cur_state\n");
> +             return ret;
> +     }
> +     ret =3D device_create_file(adev->dev, &dev_attr_pp_force_state);
> +     if (ret) {
> +             DRM_ERROR("failed to create device file pp_force_state\n");
> +             return ret;
>        }
>        ret =3D device_create_file(adev->dev, &dev_attr_pp_table);
>        if (ret) {
> @@ -2832,55 +2831,52 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *ad=
ev)
>                DRM_ERROR("failed to create device file pp_dpm_sclk\n");
>                return ret;
>        }
> -
> -     if (adev->asic_type !=3D CHIP_NAVI10) {
> -             ret =3D device_create_file(adev->dev, &dev_attr_pp_dpm_mclk=
);
> -             if (ret) {
> -                     DRM_ERROR("failed to create device file pp_dpm_mclk=
\n");
> -                     return ret;
> -             }
> -             if (adev->asic_type >=3D CHIP_VEGA10) {
> -                     ret =3D device_create_file(adev->dev, &dev_attr_pp_=
dpm_socclk);
> -                     if (ret) {
> -                             DRM_ERROR("failed to create device file pp_=
dpm_socclk\n");
> -                             return ret;
> -                     }
> -                     ret =3D device_create_file(adev->dev, &dev_attr_pp_=
dpm_dcefclk);
> -                     if (ret) {
> -                             DRM_ERROR("failed to create device file pp_=
dpm_dcefclk\n");
> -                             return ret;
> -                     }
> -             }
> -             if (adev->asic_type >=3D CHIP_VEGA20) {
> -                     ret =3D device_create_file(adev->dev, &dev_attr_pp_=
dpm_fclk);
> -                     if (ret) {
> -                             DRM_ERROR("failed to create device file pp_=
dpm_fclk\n");
> -                             return ret;
> -                     }
> -             }
> -             ret =3D device_create_file(adev->dev, &dev_attr_pp_dpm_pcie=
);
> -             if (ret) {
> -                     DRM_ERROR("failed to create device file pp_dpm_pcie=
\n");
> -                     return ret;
> -             }
> -             ret =3D device_create_file(adev->dev, &dev_attr_pp_sclk_od)=
;
> +     ret =3D device_create_file(adev->dev, &dev_attr_pp_dpm_mclk);
> +     if (ret) {
> +             DRM_ERROR("failed to create device file pp_dpm_mclk\n");
> +             return ret;
> +     }
> +     if (adev->asic_type >=3D CHIP_VEGA10) {
> +             ret =3D device_create_file(adev->dev, &dev_attr_pp_dpm_socc=
lk);
>                if (ret) {
> -                     DRM_ERROR("failed to create device file pp_sclk_od\=
n");
> +                     DRM_ERROR("failed to create device file pp_dpm_socc=
lk\n");
>                        return ret;
>                }
> -             ret =3D device_create_file(adev->dev, &dev_attr_pp_mclk_od)=
;
> +             ret =3D device_create_file(adev->dev, &dev_attr_pp_dpm_dcef=
clk);
>                if (ret) {
> -                     DRM_ERROR("failed to create device file pp_mclk_od\=
n");
> +                     DRM_ERROR("failed to create device file pp_dpm_dcef=
clk\n");
>                        return ret;
>                }
> -             ret =3D device_create_file(adev->dev,
> -                             &dev_attr_pp_power_profile_mode);
> +     }
> +     if (adev->asic_type >=3D CHIP_VEGA20) {
> +             ret =3D device_create_file(adev->dev, &dev_attr_pp_dpm_fclk=
);
>                if (ret) {
> -                     DRM_ERROR("failed to create device file "
> -                                     "pp_power_profile_mode\n");
> +                     DRM_ERROR("failed to create device file pp_dpm_fclk=
\n");
>                        return ret;
>                }
>        }
> +     ret =3D device_create_file(adev->dev, &dev_attr_pp_dpm_pcie);
> +     if (ret) {
> +             DRM_ERROR("failed to create device file pp_dpm_pcie\n");
> +             return ret;
> +     }
> +     ret =3D device_create_file(adev->dev, &dev_attr_pp_sclk_od);
> +     if (ret) {
> +             DRM_ERROR("failed to create device file pp_sclk_od\n");
> +             return ret;
> +     }
> +     ret =3D device_create_file(adev->dev, &dev_attr_pp_mclk_od);
> +     if (ret) {
> +             DRM_ERROR("failed to create device file pp_mclk_od\n");
> +             return ret;
> +     }
> +     ret =3D device_create_file(adev->dev,
> +                     &dev_attr_pp_power_profile_mode);
> +     if (ret) {
> +             DRM_ERROR("failed to create device file "
> +                             "pp_power_profile_mode\n");
> +             return ret;
> +     }
>        if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
>            (!is_support_sw_smu(adev) && hwmgr->od_enabled)) {
>                ret =3D device_create_file(adev->dev,
> @@ -3056,25 +3052,21 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_f=
ile *m, struct amdgpu_device *a
>        /* GPU Clocks */
>        size =3D sizeof(value);
>        seq_printf(m, "GFX Clocks and Power:\n");
> -     if (adev->asic_type !=3D CHIP_NAVI10) {
> -             if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GFX_MCLK=
, (void *)&value, &size))
> -                     seq_printf(m, "\t%u MHz (MCLK)\n", value/100);
> -             if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GFX_SCLK=
, (void *)&value, &size))
> -                     seq_printf(m, "\t%u MHz (SCLK)\n", value/100);
> -             if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_STABLE_P=
STATE_SCLK, (void *)&value, &size))
> -                     seq_printf(m, "\t%u MHz (PSTATE_SCLK)\n", value/100=
);
> -             if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_STABLE_P=
STATE_MCLK, (void *)&value, &size))
> -                     seq_printf(m, "\t%u MHz (PSTATE_MCLK)\n", value/100=
);
> -     }
> +     if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GFX_MCLK, (void =
*)&value, &size))
> +             seq_printf(m, "\t%u MHz (MCLK)\n", value/100);
> +     if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GFX_SCLK, (void =
*)&value, &size))
> +             seq_printf(m, "\t%u MHz (SCLK)\n", value/100);
> +     if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_STABLE_PSTATE_SC=
LK, (void *)&value, &size))
> +             seq_printf(m, "\t%u MHz (PSTATE_SCLK)\n", value/100);
> +     if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_STABLE_PSTATE_MC=
LK, (void *)&value, &size))
> +             seq_printf(m, "\t%u MHz (PSTATE_MCLK)\n", value/100);
>        if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VDDGFX, (void *=
)&value, &size))
>                seq_printf(m, "\t%u mV (VDDGFX)\n", value);
>        if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VDDNB, (void *)=
&value, &size))
>                seq_printf(m, "\t%u mV (VDDNB)\n", value);
> -     if (adev->asic_type !=3D CHIP_NAVI10) {
> -             size =3D sizeof(uint32_t);
> -             if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_POWE=
R, (void *)&query, &size))
> -                     seq_printf(m, "\t%u.%u W (average GPU)\n", query >>=
 8, query & 0xff);
> -     }
> +     size =3D sizeof(uint32_t);
> +     if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_POWER, (void=
 *)&query, &size))
> +             seq_printf(m, "\t%u.%u W (average GPU)\n", query >> 8, quer=
y & 0xff);
>        size =3D sizeof(value);
>        seq_printf(m, "\n");
>
> @@ -3082,10 +3074,6 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_fi=
le *m, struct amdgpu_device *a
>        if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_TEMP, (void=
 *)&value, &size))
>                seq_printf(m, "GPU Temperature: %u C\n", value/1000);
>
> -     /* TODO: will be removed after gpu load, feature mask, uvd/vce cloc=
ks enabled on navi10 */
> -     if (adev->asic_type =3D=3D CHIP_NAVI10)
> -             return 0;
> -
>        /* GPU Load */
>        if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_LOAD, (void=
 *)&value, &size))
>                seq_printf(m, "GPU Load: %u %%\n", value);


--_000_MN2PR12MB3296A379AAC5F95927A9A3D9A2EA0MN2PR12MB3296namp_
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
<p style=3D"margin-top:0;margin-bottom:0">i think should be drop this patch=
&nbsp; from git tree,</p>
<p style=3D"margin-top:0;margin-bottom:0">this patch only for b<span style=
=3D"font-size: 12pt;">ringing up stage.</span></p>
<p style=3D"margin-top:0;margin-bottom:0">thanks.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards,<br>
Kevin<br>
<span style=3D"font-size: 12pt;"></span></p>
<div><br>
</div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(51, 51,=
 51); font-size: 21px;"></span></p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K&ouml;nig =
&lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, June 18, 2019 3:58:28 PM<br>
<b>To:</b> Alex Deucher; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander; Wang, Kevin(Yang); Huang, Ray<br>
<b>Subject:</b> Re: [PATCH 247/459] Revert &quot;drm/amdgpu: mask some pm i=
nterfaces for navi10 because they are changed or not workable so far&quot;<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 17.06.19 um 21:30 schrieb Alex Deucher:<br>
&gt; From: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;<br>
&gt; This reverts commit fd9c75d217d5b4ed72672722b6621e2635363dfe.<br>
&gt;<br>
&gt; Signed-off-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Reviewed-by: Huang Rui &lt;ray.huang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Would it be possible to squash that into the original commit which <br>
disabled things?<br>
<br>
Christian.<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |&nbsp;&nbsp; 2 &#=
43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c&nbsp; | 156 &#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-------------<br>
&gt;&nbsp;&nbsp; 2 files changed, 73 insertions(&#43;), 85 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_kms.c<br>
&gt; index af86d9f47785..ed051fdb509f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt; @@ -690,7 &#43;690,7 @@ static int amdgpu_info_ioctl(struct drm_device=
 *dev, void *data, struct drm_file<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dev_info.num_shader_arrays_per_engine =3D adev-&gt;gfx.=
config.max_sh_per_se;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* return all clocks in KHz */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dev_info.gpu_counter_freq =3D amdgpu_asic_get_xclk(adev=
) * 10;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;pm.dpm_enabled &amp;&amp; adev-&gt;asic_type !=3D CHIP_NAV=
I10) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (adev-&gt;pm.dpm_enabled) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_inf=
o.max_engine_clock =3D amdgpu_dpm_get_sclk(adev, false) * 10;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_inf=
o.max_memory_clock =3D amdgpu_dpm_get_mclk(adev, false) * 10;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; } else if (amdgpu_sriov_vf(adev) &amp;&amp; amdgim_is_h=
wperf(adev) &amp;&amp;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_pm.c<br>
&gt; index 8c28f816b50f..6b97f3098118 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; @@ -2793,33 &#43;2793,32 @@ int amdgpu_pm_sysfs_init(struct amdgpu_dev=
ice *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type !=3D CHIP_NAVI10) {<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D device_create_file(adev-&gt;dev, &amp;dev_attr_power_dpm_state)=
;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed =
to create device file for dpm state\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D device_create_file(adev-&gt;dev, &amp;dev_attr_power_dpm_force_=
performance_level);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed =
to create device file for dpm state\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_file(adev-&gt;dev,=
 &amp;dev_attr_power_dpm_state);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_ERROR(&quot;failed to create device file for dpm state\n&quot;)=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_file(adev-&gt;dev,=
 &amp;dev_attr_power_dpm_force_performance_level);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_ERROR(&quot;failed to create device file for dpm state\n&quot;)=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D device_create_file(adev-&gt;dev, &amp;dev_attr_pp_num_states);<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed =
to create device file pp_num_states\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D device_create_file(adev-&gt;dev, &amp;dev_attr_pp_cur_state);<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed =
to create device file pp_cur_state\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D device_create_file(adev-&gt;dev, &amp;dev_attr_pp_force_state);=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed =
to create device file pp_force_state\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_file(adev-&gt;dev,=
 &amp;dev_attr_pp_num_states);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_ERROR(&quot;failed to create device file pp_num_states\n&quot;)=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_file(adev-&gt;dev,=
 &amp;dev_attr_pp_cur_state);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_ERROR(&quot;failed to create device file pp_cur_state\n&quot;);=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_file(adev-&gt;dev,=
 &amp;dev_attr_pp_force_state);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_ERROR(&quot;failed to create device file pp_force_state\n&quot;=
);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_file(a=
dev-&gt;dev, &amp;dev_attr_pp_table);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; @@ -2832,55 &#43;2831,52 @@ int amdgpu_pm_sysfs_init(struct amdgpu_dev=
ice *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to create device file pp_dpm_scl=
k\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type !=3D CHIP_NAVI10) {<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D device_create_file(adev-&gt;dev, &amp;dev_attr_pp_dpm_mclk);<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed =
to create device file pp_dpm_mclk\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;asic_type &gt;=3D CHIP_VEGA10) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_f=
ile(adev-&gt;dev, &amp;dev_attr_pp_dpm_socclk);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to create device file pp_dp=
m_socclk\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_f=
ile(adev-&gt;dev, &amp;dev_attr_pp_dpm_dcefclk);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to create device file pp_dp=
m_dcefclk\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;asic_type &gt;=3D CHIP_VEGA20) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_f=
ile(adev-&gt;dev, &amp;dev_attr_pp_dpm_fclk);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to create device file pp_dp=
m_fclk\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D device_create_file(adev-&gt;dev, &amp;dev_attr_pp_dpm_pcie);<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed =
to create device file pp_dpm_pcie\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D device_create_file(adev-&gt;dev, &amp;dev_attr_pp_sclk_od);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_file(adev-&gt;dev,=
 &amp;dev_attr_pp_dpm_mclk);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_ERROR(&quot;failed to create device file pp_dpm_mclk\n&quot;);<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &gt;=3D CHIP_VEGA=
10) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D device_create_file(adev-&gt;dev, &amp;dev_attr_pp_dpm_soccl=
k);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed =
to create device file pp_sclk_od\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;fai=
led to create device file pp_dpm_socclk\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D device_create_file(adev-&gt;dev, &amp;dev_attr_pp_mclk_od);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D device_create_file(adev-&gt;dev, &amp;dev_attr_pp_dpm_dcefc=
lk);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed =
to create device file pp_mclk_od\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;fai=
led to create device file pp_dpm_dcefclk\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D device_create_file(adev-&gt;dev,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev_attr_pp_power_profile_mode);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &gt;=3D CHIP_VEGA=
20) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D device_create_file(adev-&gt;dev, &amp;dev_attr_pp_dpm_fclk)=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed =
to create device file &quot;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &q=
uot;pp_power_profile_mode\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;fai=
led to create device file pp_dpm_fclk\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_file(adev-&gt;dev,=
 &amp;dev_attr_pp_dpm_pcie);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_ERROR(&quot;failed to create device file pp_dpm_pcie\n&quot;);<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_file(adev-&gt;dev,=
 &amp;dev_attr_pp_sclk_od);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_ERROR(&quot;failed to create device file pp_sclk_od\n&quot;);<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_file(adev-&gt;dev,=
 &amp;dev_attr_pp_mclk_od);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_ERROR(&quot;failed to create device file pp_mclk_od\n&quot;);<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_create_file(adev-&gt;dev,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev_attr_pp_po=
wer_profile_mode);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_ERROR(&quot;failed to create device file &quot;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;pp_power_profile_mode\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((is_support_sw_smu(adev)=
 &amp;&amp; adev-&gt;smu.od_enabled) ||<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (!is=
_support_sw_smu(adev) &amp;&amp; hwmgr-&gt;od_enabled)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D device_create_file(adev-&gt;dev,<br>
&gt; @@ -3056,25 &#43;3052,21 @@ static int amdgpu_debugfs_pm_info_pp(struc=
t seq_file *m, struct amdgpu_device *a<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GPU Clocks */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =3D sizeof(value);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;GFX Cloc=
ks and Power:\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type !=3D CHIP_NAVI10) {<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GFX_MCLK, (void *)&a=
mp;value, &amp;size))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;\t%=
u MHz (MCLK)\n&quot;, value/100);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GFX_SCLK, (void *)&a=
mp;value, &amp;size))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;\t%=
u MHz (SCLK)\n&quot;, value/100);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_STABLE_PSTATE_SCLK, =
(void *)&amp;value, &amp;size))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;\t%=
u MHz (PSTATE_SCLK)\n&quot;, value/100);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_STABLE_PSTATE_MCLK, =
(void *)&amp;value, &amp;size))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;\t%=
u MHz (PSTATE_MCLK)\n&quot;, value/100);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_dpm_read_sensor(adev, AMDGPU=
_PP_SENSOR_GFX_MCLK, (void *)&amp;value, &amp;size))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; seq_printf(m, &quot;\t%u MHz (MCLK)\n&quot;, value/100);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_dpm_read_sensor(adev, AMDGPU=
_PP_SENSOR_GFX_SCLK, (void *)&amp;value, &amp;size))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; seq_printf(m, &quot;\t%u MHz (SCLK)\n&quot;, value/100);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_dpm_read_sensor(adev, AMDGPU=
_PP_SENSOR_STABLE_PSTATE_SCLK, (void *)&amp;value, &amp;size))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; seq_printf(m, &quot;\t%u MHz (PSTATE_SCLK)\n&quot;, value/100);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_dpm_read_sensor(adev, AMDGPU=
_PP_SENSOR_STABLE_PSTATE_MCLK, (void *)&amp;value, &amp;size))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; seq_printf(m, &quot;\t%u MHz (PSTATE_MCLK)\n&quot;, value/100);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_dpm_read_sensor(=
adev, AMDGPU_PP_SENSOR_VDDGFX, (void *)&amp;value, &amp;size))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;\t%u mV (VDDGFX)\n&quot;, value);<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_dpm_read_sensor(=
adev, AMDGPU_PP_SENSOR_VDDNB, (void *)&amp;value, &amp;size))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;\t%u mV (VDDNB)\n&quot;, value);<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type !=3D CHIP_NAVI10) {<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; size =3D sizeof(uint32_t);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_POWER, (void *)&=
amp;query, &amp;size))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;\t%=
u.%u W (average GPU)\n&quot;, query &gt;&gt; 8, query &amp; 0xff);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; size =3D sizeof(uint32_t);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_dpm_read_sensor(adev, AMDGPU=
_PP_SENSOR_GPU_POWER, (void *)&amp;query, &amp;size))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; seq_printf(m, &quot;\t%u.%u W (average GPU)\n&quot;, query &gt;&gt;=
 8, query &amp; 0xff);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =3D sizeof(value);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;\n&quot;=
);<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -3082,10 &#43;3074,6 @@ static int amdgpu_debugfs_pm_info_pp(struct=
 seq_file *m, struct amdgpu_device *a<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_dpm_read_sensor(=
adev, AMDGPU_PP_SENSOR_GPU_TEMP, (void *)&amp;value, &amp;size))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;GPU Temperature: %u C\n&quot;, valu=
e/1000);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* TODO: will be removed after gpu load, fea=
ture mask, uvd/vce clocks enabled on navi10 */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_NAVI10)<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GPU Load */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_dpm_read_sensor(=
adev, AMDGPU_PP_SENSOR_GPU_LOAD, (void *)&amp;value, &amp;size))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;GPU Load: %u %%\n&quot;, value);<br=
>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB3296A379AAC5F95927A9A3D9A2EA0MN2PR12MB3296namp_--

--===============0820557643==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0820557643==--
