From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: add callback function of
 get_thermal_temperature_range
Date: Tue, 23 Jul 2019 11:49:21 +0000
Message-ID: <MN2PR12MB32969A2B87949FAF8001AE4BA2C70@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20190723093109.2701-1-kevin1.wang@amd.com>,
 <BN8PR12MB33290D4E7F1743C60EA4CCB4E4C70@BN8PR12MB3329.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0342792990=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN8PR12MB33290D4E7F1743C60EA4CCB4E4C70-h6+T2+wrnx3WSNCBJ7MpiAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>

--===============0342792990==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB32969A2B87949FAF8001AE4BA2C70MN2PR12MB3296namp_"

--_000_MN2PR12MB32969A2B87949FAF8001AE4BA2C70MN2PR12MB3296namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

sure, i know it, this patch is from navi10 topic branch.

the final result don't change the temperature granularity.

please see below code.


but it seems miss other temperature type in this patch,

i will submit a new patch to fix it.


#define SMU_TEMPERATURE_UNITS_PER_CENTIGRADES (1000)

> +     adev->pm.dpm.thermal.min_temp =3D range.min *
> SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> +     adev->pm.dpm.thermal.max_temp =3D range.max *
> +SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>


Thanks.


Best Regards,

Kevin

________________________________
From: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, July 23, 2019 7:15:59 PM
To: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org =
<amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Deucher, Alexander <Alexander.Deucher@amd.=
com>
Cc: Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>; Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>; W=
ang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amd/powerplay: add callback function of get_therma=
l_temperature_range

Please do not change the output temperature granularity.
Although it seems a little weird. It's required by hwmon interfaces design =
 and has to be in millidegrees Celsius (@Deucher, Alexander, right?).

* hwmon interfaces for GPU temperature:
 *
 * - temp[1-3]_input: the on die GPU temperature in millidegrees Celsius
 *   - temp2_input and temp3_input are supported on SOC15 dGPUs only
 *
 * - temp[1-3]_label: temperature channel label
 *   - temp2_label and temp3_label are supported on SOC15 dGPUs only
 *
 * - temp[1-3]_crit: temperature critical max value in millidegrees Celsius
 *   - temp2_crit and temp3_crit are supported on SOC15 dGPUs only
 *
 * - temp[1-3]_crit_hyst: temperature hysteresis for critical limit in mill=
idegrees Celsius
 *   - temp2_crit_hyst and temp3_crit_hyst are supported on SOC15 dGPUs onl=
y
 *
 * - temp[1-3]_emergency: temperature emergency max value(asic shutdown) in=
 millidegrees Celsius
 *   - these are supported on SOC15 dGPUs only

Regards,
Evan
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of
> Wang, Kevin(Yang)
> Sent: Tuesday, July 23, 2019 5:32 PM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>; Feng, Kenneth
> <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>; Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
> Subject: [PATCH] drm/amd/powerplay: add callback function of
> get_thermal_temperature_range
>
> 1. the thermal temperature is asic related data, move the code logic to
> xxx_ppt.c.
> 2. replace data structure PP_TemperatureRange with
> smu_temperature_range.
> 3. change temperature uint from temp*1000 to temp (temperature uint).
>
> Signed-off-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Kenneth Feng <kenneth.feng-5C7GfCeVMHo@public.gmane.org>
> Acked-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> ---
>  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 -
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 17 ++++++++++
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 18 ++++++----
>  drivers/gpu/drm/amd/powerplay/vega20_ppt.c    | 34 ++++++-------------
>  4 files changed, 40 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 34093ddca105..7105f8041088 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -439,7 +439,6 @@ struct smu_table_context
>        struct smu_table                *tables;
>        uint32_t                        table_count;
>        struct smu_table                memory_pool;
> -     uint16_t                        software_shutdown_temp;
>        uint8_t                         thermal_controller_type;
>        uint16_t                        TDPODLimit;
>
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index 46e2913e4af4..a4c4d4997189 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -1638,6 +1638,22 @@ static int navi10_set_performance_level(struct
> smu_context *smu, enum amd_dpm_fo
>        return ret;
>  }
>
> +static int navi10_get_thermal_temperature_range(struct smu_context
> *smu,
> +                                             struct
> smu_temperature_range *range) {
> +     struct smu_table_context *table_context =3D &smu->smu_table;
> +     struct smu_11_0_powerplay_table *powerplay_table =3D
> +table_context->power_play_table;
> +
> +     if (!range || !powerplay_table)
> +             return -EINVAL;
> +
> +     /* The unit is temperature */
> +     range->min =3D 0;
> +     range->max =3D powerplay_table->software_shutdown_temp;
> +
> +     return 0;
> +}
> +
>  static const struct pptable_funcs navi10_ppt_funcs =3D {
>        .tables_init =3D navi10_tables_init,
>        .alloc_dpm_context =3D navi10_allocate_dpm_context, @@ -1674,6
> +1690,7 @@ static const struct pptable_funcs navi10_ppt_funcs =3D {
>        .get_ppfeature_status =3D navi10_get_ppfeature_status,
>        .set_ppfeature_status =3D navi10_set_ppfeature_status,
>        .set_performance_level =3D navi10_set_performance_level,
> +     .get_thermal_temperature_range =3D
> navi10_get_thermal_temperature_range,
>  };
>
>  void navi10_set_ppt_funcs(struct smu_context *smu) diff --git
> a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 76bc157525d0..4ad9e0c5a637 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1147,10 +1147,8 @@ static int smu_v11_0_set_thermal_range(struct
> smu_context *smu,
>                                       struct smu_temperature_range *range=
)  {
>        struct amdgpu_device *adev =3D smu->adev;
> -     int low =3D SMU_THERMAL_MINIMUM_ALERT_TEMP *
> -             SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> -     int high =3D SMU_THERMAL_MAXIMUM_ALERT_TEMP *
> -             SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> +     int low =3D SMU_THERMAL_MINIMUM_ALERT_TEMP;
> +     int high =3D SMU_THERMAL_MAXIMUM_ALERT_TEMP;
>        uint32_t val;
>
>        if (!range)
> @@ -1161,6 +1159,9 @@ static int smu_v11_0_set_thermal_range(struct
> smu_context *smu,
>        if (high > range->max)
>                high =3D range->max;
>
> +     low =3D max(SMU_THERMAL_MINIMUM_ALERT_TEMP, range->min);
> +     high =3D min(SMU_THERMAL_MAXIMUM_ALERT_TEMP, range->max);
> +
>        if (low > high)
>                return -EINVAL;
>
> @@ -1169,8 +1170,8 @@ static int smu_v11_0_set_thermal_range(struct
> smu_context *smu,
>        val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL,
> THERM_IH_HW_ENA, 1);
>        val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL,
> THERM_INTH_MASK, 0);
>        val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL,
> THERM_INTL_MASK, 0);
> -     val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL,
> DIG_THERM_INTH, (high /
> SMU_TEMPERATURE_UNITS_PER_CENTIGRADES));
> -     val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL,
> DIG_THERM_INTL, (low / SMU_TEMPERATURE_UNITS_PER_CENTIGRADES));
> +     val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL,
> DIG_THERM_INTH, (high & 0xff));
> +     val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL,
> DIG_THERM_INTL, (low &
> +0xff));
>        val =3D val &
> (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
>
>        WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val); @@ -
> 1209,7 +1210,10 @@ static int smu_v11_0_start_thermal_control(struct
> smu_context *smu)
>
>        if (!smu->pm_enabled)
>                return ret;
> +
>        ret =3D smu_get_thermal_temperature_range(smu, &range);
> +     if (ret)
> +             return ret;
>
>        if (smu->smu_table.thermal_controller_type) {
>                ret =3D smu_v11_0_set_thermal_range(smu, &range); @@ -
> 1234,6 +1238,8 @@ static int smu_v11_0_start_thermal_control(struct
> smu_context *smu)
>        adev->pm.dpm.thermal.min_mem_temp =3D range.mem_min;
>        adev->pm.dpm.thermal.max_mem_crit_temp =3D
> range.mem_crit_max;
>        adev->pm.dpm.thermal.max_mem_emergency_temp =3D
> range.mem_emergency_max;
> +     adev->pm.dpm.thermal.min_temp =3D range.min *
> SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> +     adev->pm.dpm.thermal.max_temp =3D range.max *
> +SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>
>        return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> index bcd0efaf7bbd..deb102ffedc2 100644
> --- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> @@ -463,7 +463,6 @@ static int vega20_store_powerplay_table(struct
> smu_context *smu)
>        memcpy(table_context->driver_pptable, &powerplay_table-
> >smcPPTable,
>               sizeof(PPTable_t));
>
> -     table_context->software_shutdown_temp =3D powerplay_table-
> >usSoftwareShutdownTemp;
>        table_context->thermal_controller_type =3D powerplay_table-
> >ucThermalControllerType;
>        table_context->TDPODLimit =3D le32_to_cpu(powerplay_table-
> >OverDrive8Table.ODSettingsMax[ATOM_VEGA20_ODSETTING_POWERPER
> CENTAGE]);
>
> @@ -3235,35 +3234,24 @@ static int vega20_set_watermarks_table(struct
> smu_context *smu,
>        return 0;
>  }
>
> -static const struct smu_temperature_range vega20_thermal_policy[] =3D -{
> -     {-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 990=
00},
> -     { 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000,
> 120000},
> -};
> -
>  static int vega20_get_thermal_temperature_range(struct smu_context
> *smu,
>                                                struct
> smu_temperature_range*range)  {
> -
> +     struct smu_table_context *table_context =3D &smu->smu_table;
> +     ATOM_Vega20_POWERPLAYTABLE *powerplay_table =3D
> +table_context->power_play_table;
>        PPTable_t *pptable =3D smu->smu_table.driver_pptable;
>
> -     if (!range)
> +     if (!range || !powerplay_table)
>                return -EINVAL;
>
> -     memcpy(range, &vega20_thermal_policy[0], sizeof(struct
> smu_temperature_range));
> -
> -     range->max =3D pptable->TedgeLimit *
> -             SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> -     range->edge_emergency_max =3D (pptable->TedgeLimit +
> CTF_OFFSET_EDGE) *
> -             SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> -     range->hotspot_crit_max =3D pptable->ThotspotLimit *
> -             SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> -     range->hotspot_emergency_max =3D (pptable->ThotspotLimit +
> CTF_OFFSET_HOTSPOT) *
> -             SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> -     range->mem_crit_max =3D pptable->ThbmLimit *
> -             SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> -     range->mem_emergency_max =3D (pptable->ThbmLimit +
> CTF_OFFSET_HBM)*
> -             SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> +     /* The unit is temperature */
> +     range->min =3D 0;
> +     range->max =3D powerplay_table->usSoftwareShutdownTemp;
> +     range->edge_emergency_max =3D (pptable->TedgeLimit +
> CTF_OFFSET_EDGE);
> +     range->hotspot_crit_max =3D pptable->ThotspotLimit;
> +     range->hotspot_emergency_max =3D (pptable->ThotspotLimit +
> CTF_OFFSET_HOTSPOT);
> +     range->mem_crit_max =3D pptable->ThbmLimit;
> +     range->mem_emergency_max =3D (pptable->ThbmLimit +
> CTF_OFFSET_HBM);
>
>
>        return 0;
> --
> 2.22.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB32969A2B87949FAF8001AE4BA2C70MN2PR12MB3296namp_
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
<p style=3D"margin-top:0;margin-bottom:0">sure, i know it, this patch is fr=
om navi10 topic branch.&nbsp;</p>
<p style=3D"margin-top:0;margin-bottom:0">the final result don't change the=
 temperature granularity.<span style=3D"color: rgb(33, 33, 33); font-family=
: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, A=
rial, sans-serif, serif, EmojiFont; font-size: 14.6667px;"></span></p>
<p style=3D"margin-top:0;margin-bottom:0">please see below code.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">but it seems miss other temperatu=
re type in this patch,</p>
<p style=3D"margin-top:0;margin-bottom:0">i will submit a new patch to fix =
it.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">#define&nbsp;<span style=3D"color=
: rgb(33, 33, 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &=
quot;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size=
: 14.6667px;"><b>SMU_TEMPERATURE_UNITS_PER_CENTIGRADES</b> (1000)</span></p=
>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(33, 33,=
 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP=
&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;"=
>&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.min_temp =3D ra=
nge.min *</span><br style=3D"color: rgb(33, 33, 33); font-family: wf_segoe-=
ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-=
serif, serif, EmojiFont; font-size: 14.6667px;">
<span style=3D"color: rgb(33, 33, 33); font-family: wf_segoe-ui_normal, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif, =
EmojiFont; font-size: 14.6667px;">&gt;
<b>SMU_TEMPERATURE_UNITS_PER_CENTIGRADES</b>;</span><br style=3D"color: rgb=
(33, 33, 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;=
Segoe WP&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.=
6667px;">
<span style=3D"color: rgb(33, 33, 33); font-family: wf_segoe-ui_normal, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif, =
EmojiFont; font-size: 14.6667px;">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; adev-&=
gt;pm.dpm.thermal.max_temp =3D range.max *</span><br style=3D"color: rgb(33=
, 33, 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Seg=
oe WP&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.666=
7px;">
<span style=3D"color: rgb(33, 33, 33); font-family: wf_segoe-ui_normal, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif, =
EmojiFont; font-size: 14.6667px;">&gt; &#43;<b>SMU_TEMPERATURE_UNITS_PER_CE=
NTIGRADES</b>;</span><br style=3D"color: rgb(33, 33, 33); font-family: wf_s=
egoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, =
sans-serif, serif, EmojiFont; font-size: 14.6667px;">
<span style=3D"color: rgb(33, 33, 33); font-family: wf_segoe-ui_normal, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif, =
EmojiFont; font-size: 14.6667px;">&gt;&nbsp;</span><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(33, 33,=
 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP=
&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;"=
><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(33, 33,=
 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP=
&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;"=
>Thanks.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards,</p>
<p style=3D"margin-top:0;margin-bottom:0">Kevin</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, July 23, 2019 7:15:59 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;; Deucher, Alexander &lt;=
Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang-5C7GfCeVMHo@public.gmane.org&gt;; Feng, Kenneth &lt;Kenneth.=
Feng-5C7GfCeVMHo@public.gmane.org&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/powerplay: add callback function of get=
_thermal_temperature_range</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Please do not change the output temperature granul=
arity.<br>
Although it seems a little weird. It's required by hwmon interfaces design&=
nbsp; and has to be in millidegrees Celsius (@Deucher, Alexander, right?).<=
br>
<br>
* hwmon interfaces for GPU temperature:<br>
&nbsp;*<br>
&nbsp;* - temp[1-3]_input: the on die GPU temperature in millidegrees Celsi=
us<br>
&nbsp;*&nbsp;&nbsp; - temp2_input and temp3_input are supported on SOC15 dG=
PUs only<br>
&nbsp;*<br>
&nbsp;* - temp[1-3]_label: temperature channel label<br>
&nbsp;*&nbsp;&nbsp; - temp2_label and temp3_label are supported on SOC15 dG=
PUs only<br>
&nbsp;*<br>
&nbsp;* - temp[1-3]_crit: temperature critical max value in millidegrees Ce=
lsius<br>
&nbsp;*&nbsp;&nbsp; - temp2_crit and temp3_crit are supported on SOC15 dGPU=
s only<br>
&nbsp;*<br>
&nbsp;* - temp[1-3]_crit_hyst: temperature hysteresis for critical limit in=
 millidegrees Celsius<br>
&nbsp;*&nbsp;&nbsp; - temp2_crit_hyst and temp3_crit_hyst are supported on =
SOC15 dGPUs only<br>
&nbsp;*<br>
&nbsp;* - temp[1-3]_emergency: temperature emergency max value(asic shutdow=
n) in millidegrees Celsius<br>
&nbsp;*&nbsp;&nbsp; - these are supported on SOC15 dGPUs only<br>
<br>
Regards,<br>
Evan<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; On Behalf =
Of<br>
&gt; Wang, Kevin(Yang)<br>
&gt; Sent: Tuesday, July 23, 2019 5:32 PM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Huang, Ray &lt;Ray.Huang-5C7GfCeVMHo@public.gmane.org&gt;; Feng, Kenneth<br>
&gt; &lt;Kenneth.Feng-5C7GfCeVMHo@public.gmane.org&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang-urvtwAKJhsc@public.gmane.org=
m&gt;<br>
&gt; Subject: [PATCH] drm/amd/powerplay: add callback function of<br>
&gt; get_thermal_temperature_range<br>
&gt; <br>
&gt; 1. the thermal temperature is asic related data, move the code logic t=
o<br>
&gt; xxx_ppt.c.<br>
&gt; 2. replace data structure PP_TemperatureRange with<br>
&gt; smu_temperature_range.<br>
&gt; 3. change temperature uint from temp*1000 to temp (temperature uint).<=
br>
&gt; <br>
&gt; Signed-off-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Signed-off-by: Kenneth Feng &lt;kenneth.feng-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Acked-by: Huang Rui &lt;ray.huang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp; |&n=
bsp; 1 -<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/navi10_ppt.c&nbsp;&nbsp;&nbsp; | 1=
7 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/smu_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp=
; | 18 &#43;&#43;&#43;&#43;&#43;&#43;----<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/vega20_ppt.c&nbsp;&nbsp;&nbsp; | 3=
4 &#43;&#43;&#43;&#43;&#43;&#43;-------------<br>
&gt;&nbsp; 4 files changed, 40 insertions(&#43;), 30 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&gt; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&gt; index 34093ddca105..7105f8041088 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&gt; @@ -439,7 &#43;439,6 @@ struct smu_table_context<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *tables;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_count;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; memory_pool;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; software_shutdown_temp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; thermal_controller_type;<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TDPODLimit;<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&gt; index 46e2913e4af4..a4c4d4997189 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&gt; @@ -1638,6 &#43;1638,22 @@ static int navi10_set_performance_level(str=
uct<br>
&gt; smu_context *smu, enum amd_dpm_fo<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt; &#43;static int navi10_get_thermal_temperature_range(struct smu_contex=
t<br>
&gt; *smu,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct<br>
&gt; smu_temperature_range *range) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *table_context =
=3D &amp;smu-&gt;smu_table;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_11_0_powerplay_table *powerpl=
ay_table =3D<br>
&gt; &#43;table_context-&gt;power_play_table;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!range || !powerplay_table)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -EINVAL;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* The unit is temperature */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;min =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;max =3D powerplay_table-&gt;so=
ftware_shutdown_temp;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; static const struct pptable_funcs navi10_ppt_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .tables_init =3D navi10_tabl=
es_init,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .alloc_dpm_context =3D navi1=
0_allocate_dpm_context, @@ -1674,6<br>
&gt; &#43;1690,7 @@ static const struct pptable_funcs navi10_ppt_funcs =3D =
{<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_ppfeature_status =3D na=
vi10_get_ppfeature_status,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_ppfeature_status =3D na=
vi10_set_ppfeature_status,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_performance_level =3D n=
avi10_set_performance_level,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .get_thermal_temperature_range =3D<br>
&gt; navi10_get_thermal_temperature_range,<br>
&gt;&nbsp; };<br>
&gt; <br>
&gt;&nbsp; void navi10_set_ppt_funcs(struct smu_context *smu) diff --git<br=
>
&gt; a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&gt; index 76bc157525d0..4ad9e0c5a637 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&gt; @@ -1147,10 &#43;1147,8 @@ static int smu_v11_0_set_thermal_range(stru=
ct<br>
&gt; smu_context *smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; struct smu_temperature_range *range)&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D smu-&gt;adev;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int low =3D SMU_THERMAL_MINIMUM_ALERT_TEMP *=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int high =3D SMU_THERMAL_MAXIMUM_ALERT_TEMP =
*<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int low =3D SMU_THERMAL_MINIMUM_ALERT_TE=
MP;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int high =3D SMU_THERMAL_MAXIMUM_ALERT_T=
EMP;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t val;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!range)<br>
&gt; @@ -1161,6 &#43;1159,9 @@ static int smu_v11_0_set_thermal_range(struc=
t<br>
&gt; smu_context *smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (high &gt; range-&gt;max)=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; high =3D range-&gt;max;<br>
&gt; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; low =3D max(SMU_THERMAL_MINIMUM_ALERT_TE=
MP, range-&gt;min);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; high =3D min(SMU_THERMAL_MAXIMUM_ALERT_T=
EMP, range-&gt;max);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (low &gt; high)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; <br>
&gt; @@ -1169,8 &#43;1170,8 @@ static int smu_v11_0_set_thermal_range(struc=
t<br>
&gt; smu_context *smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, T=
HM_THERMAL_INT_CTRL,<br>
&gt; THERM_IH_HW_ENA, 1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, T=
HM_THERMAL_INT_CTRL,<br>
&gt; THERM_INTH_MASK, 0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, T=
HM_THERMAL_INT_CTRL,<br>
&gt; THERM_INTL_MASK, 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_THERMAL_INT_C=
TRL,<br>
&gt; DIG_THERM_INTH, (high /<br>
&gt; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_THERMAL_INT_C=
TRL,<br>
&gt; DIG_THERM_INTL, (low / SMU_TEMPERATURE_UNITS_PER_CENTIGRADES));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_THERMAL_I=
NT_CTRL,<br>
&gt; DIG_THERM_INTH, (high &amp; 0xff));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_THERMAL_I=
NT_CTRL,<br>
&gt; DIG_THERM_INTL, (low &amp;<br>
&gt; &#43;0xff));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D val &amp;<br>
&gt; (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(THM, 0, mmTHM_T=
HERMAL_INT_CTRL, val); @@ -<br>
&gt; 1209,7 &#43;1210,10 @@ static int smu_v11_0_start_thermal_control(stru=
ct<br>
&gt; smu_context *smu)<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_get_thermal_temp=
erature_range(smu, &amp;range);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return ret;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;smu_table.therma=
l_controller_type) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_set_thermal_range(smu, &amp;range); @=
@ -<br>
&gt; 1234,6 &#43;1238,8 @@ static int smu_v11_0_start_thermal_control(struc=
t<br>
&gt; smu_context *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.min_=
mem_temp =3D range.mem_min;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.max_=
mem_crit_temp =3D<br>
&gt; range.mem_crit_max;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.max_=
mem_emergency_temp =3D<br>
&gt; range.mem_emergency_max;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.min_temp =3D ran=
ge.min *<br>
&gt; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.dpm.thermal.max_temp =3D ran=
ge.max *<br>
&gt; &#43;SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
&gt; index bcd0efaf7bbd..deb102ffedc2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
&gt; @@ -463,7 &#43;463,6 @@ static int vega20_store_powerplay_table(struct=
<br>
&gt; smu_context *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(table_context-&gt;dri=
ver_pptable, &amp;powerplay_table-<br>
&gt; &gt;smcPPTable,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; sizeof(PPTable_t));<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; table_context-&gt;software_shutdown_temp =3D=
 powerplay_table-<br>
&gt; &gt;usSoftwareShutdownTemp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_context-&gt;thermal_co=
ntroller_type =3D powerplay_table-<br>
&gt; &gt;ucThermalControllerType;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_context-&gt;TDPODLimit=
 =3D le32_to_cpu(powerplay_table-<br>
&gt; &gt;OverDrive8Table.ODSettingsMax[ATOM_VEGA20_ODSETTING_POWERPER<br>
&gt; CENTAGE]);<br>
&gt; <br>
&gt; @@ -3235,35 &#43;3234,24 @@ static int vega20_set_watermarks_table(str=
uct<br>
&gt; smu_context *smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt; -static const struct smu_temperature_range vega20_thermal_policy[] =3D=
 -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; {-273150,&nbsp; 99000, 99000, -273150, 99000=
, 99000, -273150, 99000, 99000},<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; { 120000, 120000, 120000, 120000, 120000, 12=
0000, 120000, 120000,<br>
&gt; 120000},<br>
&gt; -};<br>
&gt; -<br>
&gt;&nbsp; static int vega20_get_thermal_temperature_range(struct smu_conte=
xt<br>
&gt; *smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct<br>
&gt; smu_temperature_range*range)&nbsp; {<br>
&gt; -<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *table_context =
=3D &amp;smu-&gt;smu_table;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ATOM_Vega20_POWERPLAYTABLE *powerplay_ta=
ble =3D<br>
&gt; &#43;table_context-&gt;power_play_table;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPTable_t *pptable =3D smu-&=
gt;smu_table.driver_pptable;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!range)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!range || !powerplay_table)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; memcpy(range, &amp;vega20_thermal_policy[0],=
 sizeof(struct<br>
&gt; smu_temperature_range));<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;max =3D pptable-&gt;TedgeLimit *<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;edge_emergency_max =3D (pptable-&g=
t;TedgeLimit &#43;<br>
&gt; CTF_OFFSET_EDGE) *<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;hotspot_crit_max =3D pptable-&gt;T=
hotspotLimit *<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;hotspot_emergency_max =3D (pptable=
-&gt;ThotspotLimit &#43;<br>
&gt; CTF_OFFSET_HOTSPOT) *<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;mem_crit_max =3D pptable-&gt;ThbmL=
imit *<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;mem_emergency_max =3D (pptable-&gt=
;ThbmLimit &#43;<br>
&gt; CTF_OFFSET_HBM)*<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* The unit is temperature */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;min =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;max =3D powerplay_table-&gt;us=
SoftwareShutdownTemp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;edge_emergency_max =3D (pptabl=
e-&gt;TedgeLimit &#43;<br>
&gt; CTF_OFFSET_EDGE);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;hotspot_crit_max =3D pptable-&=
gt;ThotspotLimit;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;hotspot_emergency_max =3D (ppt=
able-&gt;ThotspotLimit &#43;<br>
&gt; CTF_OFFSET_HOTSPOT);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;mem_crit_max =3D pptable-&gt;T=
hbmLimit;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; range-&gt;mem_emergency_max =3D (pptable=
-&gt;ThbmLimit &#43;<br>
&gt; CTF_OFFSET_HBM);<br>
&gt; <br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
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

--_000_MN2PR12MB32969A2B87949FAF8001AE4BA2C70MN2PR12MB3296namp_--

--===============0342792990==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0342792990==--
