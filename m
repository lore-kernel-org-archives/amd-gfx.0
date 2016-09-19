From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/powerplay: Add read_sensor() callback to
 hwmgr (v3)
Date: Mon, 19 Sep 2016 15:54:59 +0000
Message-ID: <CY4PR12MB17688AA3886A61A51BE31262F7F40@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <20160919131023.30064-1-tom.stdenis@amd.com>
 <20160919131023.30064-2-tom.stdenis@amd.com>,
 <CADnq5_PDWVmDxGLbQ=Kxe1UADO6PsLC=17uqUrQfnM2BWmKATQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0321915723=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_PDWVmDxGLbQ=Kxe1UADO6PsLC=17uqUrQfnM2BWmKATQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--===============0321915723==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB17688AA3886A61A51BE31262F7F40CY4PR12MB1768namp_"

--_000_CY4PR12MB17688AA3886A61A51BE31262F7F40CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Alex,


Would you prefer I re-write #1 to avoid churn in the tree?


Cheers,

Tom


________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Monday, September 19, 2016 11:53
To: Tom St Denis
Cc: amd-gfx list; StDenis, Tom
Subject: Re: [PATCH 1/2] drm/amd/powerplay: Add read_sensor() callback to h=
wmgr (v3)

On Mon, Sep 19, 2016 at 9:10 AM, Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Provides standardized interface to read various sensors.
> The API is extensible (by adding to the end of the
> amd_pp_sensors enumeration list.
>
> Support has been added to Carrizo/smu7
>
> (v2) Squashed the two sensor patches into one.
> (v3) Updated to apply to smu7_hwmgr instead
>
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/amd_powerplay.c     | 20 +++++
>  drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c    | 96 +++++++++++++++++=
++++++
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c  | 36 +++++++++
>  drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h | 12 +++
>  drivers/gpu/drm/amd/powerplay/inc/hwmgr.h         |  1 +
>  5 files changed, 165 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/=
drm/amd/powerplay/amd_powerplay.c
> index b1d19409bf86..ee0368381e82 100644
> --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> @@ -894,6 +894,25 @@ static int pp_dpm_set_mclk_od(void *handle, uint32_t=
 value)
>         return hwmgr->hwmgr_func->set_mclk_od(hwmgr, value);
>  }
>
> +static int pp_dpm_read_sensor(void *handle, int idx, int32_t *value)
> +{
> +       struct pp_hwmgr *hwmgr;
> +
> +       if (!handle)
> +               return -EINVAL;
> +
> +       hwmgr =3D ((struct pp_instance *)handle)->hwmgr;
> +
> +       PP_CHECK_HW(hwmgr);
> +
> +       if (hwmgr->hwmgr_func->read_sensor =3D=3D NULL) {
> +               printk(KERN_INFO "%s was not implemented.\n", __func__);
> +               return 0;
> +       }
> +
> +       return hwmgr->hwmgr_func->read_sensor(hwmgr, idx, value);
> +}
> +
>  const struct amd_powerplay_funcs pp_dpm_funcs =3D {
>         .get_temperature =3D pp_dpm_get_temperature,
>         .load_firmware =3D pp_dpm_load_fw,
> @@ -920,6 +939,7 @@ const struct amd_powerplay_funcs pp_dpm_funcs =3D {
>         .set_sclk_od =3D pp_dpm_set_sclk_od,
>         .get_mclk_od =3D pp_dpm_get_mclk_od,
>         .set_mclk_od =3D pp_dpm_set_mclk_od,
> +       .read_sensor =3D pp_dpm_read_sensor,

As a future patch it would be nice to hook up this sensor interface to
the existing amdgpu_pm_info code and make that asic indpendent.

Series is:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

Alex


>  };
>
>  static int amd_pp_instance_init(struct amd_pp_init *pp_init,
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> index 5ecef1732e20..9f3c5a8a903c 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> @@ -1857,6 +1857,101 @@ static int cz_get_max_high_clocks(struct pp_hwmgr=
 *hwmgr, struct amd_pp_simple_c
>         return 0;
>  }
>
> +static int cz_read_sensor(struct pp_hwmgr *hwmgr, int idx, int32_t *valu=
e)
> +{
> +       struct cz_hwmgr *cz_hwmgr =3D (struct cz_hwmgr *)(hwmgr->backend)=
;
> +
> +       struct phm_clock_voltage_dependency_table *table =3D
> +                               hwmgr->dyn_state.vddc_dependency_on_sclk;
> +
> +       struct phm_vce_clock_voltage_dependency_table *vce_table =3D
> +               hwmgr->dyn_state.vce_clock_voltage_dependency_table;
> +
> +       struct phm_uvd_clock_voltage_dependency_table *uvd_table =3D
> +               hwmgr->dyn_state.uvd_clock_voltage_dependency_table;
> +
> +       uint32_t sclk_index =3D PHM_GET_FIELD(cgs_read_ind_register(hwmgr=
->device, CGS_IND_REG__SMC, ixTARGET_AND_CURRENT_PROFILE_INDEX),
> +                                       TARGET_AND_CURRENT_PROFILE_INDEX,=
 CURR_SCLK_INDEX);
> +       uint32_t uvd_index =3D PHM_GET_FIELD(cgs_read_ind_register(hwmgr-=
>device, CGS_IND_REG__SMC, ixTARGET_AND_CURRENT_PROFILE_INDEX_2),
> +                                       TARGET_AND_CURRENT_PROFILE_INDEX_=
2, CURR_UVD_INDEX);
> +       uint32_t vce_index =3D PHM_GET_FIELD(cgs_read_ind_register(hwmgr-=
>device, CGS_IND_REG__SMC, ixTARGET_AND_CURRENT_PROFILE_INDEX_2),
> +                                       TARGET_AND_CURRENT_PROFILE_INDEX_=
2, CURR_VCE_INDEX);
> +
> +       uint32_t sclk, vclk, dclk, ecclk, tmp, activity_percent;
> +       uint16_t vddnb, vddgfx;
> +       int result;
> +
> +       switch (idx) {
> +       case AMDGPU_PP_SENSOR_GFX_SCLK:
> +               if (sclk_index < NUM_SCLK_LEVELS) {
> +                       sclk =3D table->entries[sclk_index].clk;
> +                       *value =3D sclk;
> +                       return 0;
> +               }
> +               return -EINVAL;
> +       case AMDGPU_PP_SENSOR_VDDNB:
> +               tmp =3D (cgs_read_ind_register(hwmgr->device, CGS_IND_REG=
__SMC, ixSMUSVI_NB_CURRENTVID) &
> +                       CURRENT_NB_VID_MASK) >> CURRENT_NB_VID__SHIFT;
> +               vddnb =3D cz_convert_8Bit_index_to_voltage(hwmgr, tmp);
> +               *value =3D vddnb;
> +               return 0;
> +       case AMDGPU_PP_SENSOR_VDDGFX:
> +               tmp =3D (cgs_read_ind_register(hwmgr->device, CGS_IND_REG=
__SMC, ixSMUSVI_GFX_CURRENTVID) &
> +                       CURRENT_GFX_VID_MASK) >> CURRENT_GFX_VID__SHIFT;
> +               vddgfx =3D cz_convert_8Bit_index_to_voltage(hwmgr, (u16)t=
mp);
> +               *value =3D vddgfx;
> +               return 0;
> +       case AMDGPU_PP_SENSOR_UVD_VCLK:
> +               if (!cz_hwmgr->uvd_power_gated) {
> +                       if (uvd_index >=3D CZ_MAX_HARDWARE_POWERLEVELS) {
> +                               return -EINVAL;
> +                       } else {
> +                               vclk =3D uvd_table->entries[uvd_index].vc=
lk;
> +                               *value =3D vclk;
> +                               return 0;
> +                       }
> +               }
> +               *value =3D 0;
> +               return 0;
> +       case AMDGPU_PP_SENSOR_UVD_DCLK:
> +               if (!cz_hwmgr->uvd_power_gated) {
> +                       if (uvd_index >=3D CZ_MAX_HARDWARE_POWERLEVELS) {
> +                               return -EINVAL;
> +                       } else {
> +                               dclk =3D uvd_table->entries[uvd_index].dc=
lk;
> +                               *value =3D dclk;
> +                               return 0;
> +                       }
> +               }
> +               *value =3D 0;
> +               return 0;
> +       case AMDGPU_PP_SENSOR_VCE_ECCLK:
> +               if (!cz_hwmgr->vce_power_gated) {
> +                       if (vce_index >=3D CZ_MAX_HARDWARE_POWERLEVELS) {
> +                               return -EINVAL;
> +                       } else {
> +                               ecclk =3D vce_table->entries[vce_index].e=
cclk;
> +                               *value =3D ecclk;
> +                               return 0;
> +                       }
> +               }
> +               *value =3D 0;
> +               return 0;
> +       case AMDGPU_PP_SENSOR_GPU_LOAD:
> +               result =3D smum_send_msg_to_smc(hwmgr->smumgr, PPSMC_MSG_=
GetAverageGraphicsActivity);
> +               if (0 =3D=3D result) {
> +                       activity_percent =3D cgs_read_register(hwmgr->dev=
ice, mmSMU_MP1_SRBM2P_ARG_0);
> +                       activity_percent =3D activity_percent > 100 ? 100=
 : activity_percent;
> +               } else {
> +                       activity_percent =3D 50;
> +               }
> +               *value =3D activity_percent;
> +               return 0;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
>  static const struct pp_hwmgr_func cz_hwmgr_funcs =3D {
>         .backend_init =3D cz_hwmgr_backend_init,
>         .backend_fini =3D cz_hwmgr_backend_fini,
> @@ -1882,6 +1977,7 @@ static const struct pp_hwmgr_func cz_hwmgr_funcs =
=3D {
>         .get_current_shallow_sleep_clocks =3D cz_get_current_shallow_slee=
p_clocks,
>         .get_clock_by_type =3D cz_get_clock_by_type,
>         .get_max_high_clocks =3D cz_get_max_high_clocks,
> +       .read_sensor =3D cz_read_sensor,
>  };
>
>  int cz_hwmgr_init(struct pp_hwmgr *hwmgr)
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> index f67e1e260b30..07a7d046d6f6 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> @@ -3144,6 +3144,41 @@ smu7_print_current_perforce_level(struct pp_hwmgr =
*hwmgr, struct seq_file *m)
>         seq_printf(m, "vce    %sabled\n", data->vce_power_gated ? "dis" :=
 "en");
>  }
>
> +static int smu7_read_sensor(struct pp_hwmgr *hwmgr, int idx, int32_t *va=
lue)
> +{
> +       uint32_t sclk, mclk, activity_percent;
> +       uint32_t offset;
> +       struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
> +
> +       switch (idx) {
> +       case AMDGPU_PP_SENSOR_GFX_SCLK:
> +               smum_send_msg_to_smc(hwmgr->smumgr, PPSMC_MSG_API_GetSclk=
Frequency);
> +               sclk =3D cgs_read_register(hwmgr->device, mmSMC_MSG_ARG_0=
);
> +               *value =3D sclk;
> +               return 0;
> +       case AMDGPU_PP_SENSOR_GFX_MCLK:
> +               smum_send_msg_to_smc(hwmgr->smumgr, PPSMC_MSG_API_GetMclk=
Frequency);
> +               mclk =3D cgs_read_register(hwmgr->device, mmSMC_MSG_ARG_0=
);
> +               *value =3D mclk;
> +               return 0;
> +       case AMDGPU_PP_SENSOR_GPU_LOAD:
> +               offset =3D data->soft_regs_start + smum_get_offsetof(hwmg=
r->smumgr,
> +                                                               SMU_SoftR=
egisters,
> +                                                               AverageGr=
aphicsActivity);
> +
> +               activity_percent =3D cgs_read_ind_register(hwmgr->device,=
 CGS_IND_REG__SMC, offset);
> +               activity_percent +=3D 0x80;
> +               activity_percent >>=3D 8;
> +               *value =3D activity_percent > 100 ? 100 : activity_percen=
t;
> +               return 0;
> +       case AMDGPU_PP_SENSOR_GPU_TEMP:
> +               *value =3D smu7_thermal_get_temperature(hwmgr);
> +               return 0;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
>  static int smu7_find_dpm_states_clocks_in_dpm_table(struct pp_hwmgr *hwm=
gr, const void *input)
>  {
>         const struct phm_set_power_state_input *states =3D
> @@ -4315,6 +4350,7 @@ static struct pp_hwmgr_func smu7_hwmgr_funcs =3D {
>         .get_mclk_od =3D smu7_get_mclk_od,
>         .set_mclk_od =3D smu7_set_mclk_od,
>         .get_clock_by_type =3D smu7_get_clock_by_type,
> +       .read_sensor =3D smu7_read_sensor,
>  };
>
>  uint8_t smu7_get_sleep_divider_id_from_clock(uint32_t clock,
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h b/drivers/=
gpu/drm/amd/powerplay/inc/amd_powerplay.h
> index f941acf563a9..dfa0f38a5e76 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h
> @@ -29,6 +29,17 @@
>  #include "amd_shared.h"
>  #include "cgs_common.h"
>
> +enum amd_pp_sensors {
> +       AMDGPU_PP_SENSOR_GFX_SCLK =3D 0,
> +       AMDGPU_PP_SENSOR_VDDNB,
> +       AMDGPU_PP_SENSOR_VDDGFX,
> +       AMDGPU_PP_SENSOR_UVD_VCLK,
> +       AMDGPU_PP_SENSOR_UVD_DCLK,
> +       AMDGPU_PP_SENSOR_VCE_ECCLK,
> +       AMDGPU_PP_SENSOR_GPU_LOAD,
> +       AMDGPU_PP_SENSOR_GFX_MCLK,
> +       AMDGPU_PP_SENSOR_GPU_TEMP,
> +};
>
>  enum amd_pp_event {
>         AMD_PP_EVENT_INITIALIZE =3D 0,
> @@ -347,6 +358,7 @@ struct amd_powerplay_funcs {
>         int (*set_sclk_od)(void *handle, uint32_t value);
>         int (*get_mclk_od)(void *handle);
>         int (*set_mclk_od)(void *handle, uint32_t value);
> +       int (*read_sensor)(void *handle, int idx, int32_t *value);
>  };
>
>  struct amd_powerplay {
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/=
amd/powerplay/inc/hwmgr.h
> index c9628b4db2c3..fcd45452380d 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> @@ -359,6 +359,7 @@ struct pp_hwmgr_func {
>         int (*set_sclk_od)(struct pp_hwmgr *hwmgr, uint32_t value);
>         int (*get_mclk_od)(struct pp_hwmgr *hwmgr);
>         int (*set_mclk_od)(struct pp_hwmgr *hwmgr, uint32_t value);
> +       int (*read_sensor)(struct pp_hwmgr *hwmgr, int idx, int32_t *valu=
e);
>  };
>
>  struct pp_table_func {
> --
> 2.10.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - lists.freedesktop.org<https://lists.freedesktop.org/mai=
lman/listinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...




--_000_CY4PR12MB17688AA3886A61A51BE31262F7F40CY4PR12MB1768namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Hi Alex,</p>
<p><br>
</p>
<p>Would you prefer I re-write #1 to avoid churn in the tree?</p>
<p><br>
</p>
<p>Cheers,</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Alex Deucher &lt;al=
exdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, September 19, 2016 11:53<br>
<b>To:</b> Tom St Denis<br>
<b>Cc:</b> amd-gfx list; StDenis, Tom<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amd/powerplay: Add read_sensor() callba=
ck to hwmgr (v3)</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On Mon, Sep 19, 2016 at 9:10 AM, Tom St Denis &lt;=
tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt; wrote:<br>
&gt; Provides standardized interface to read various sensors.<br>
&gt; The API is extensible (by adding to the end of the<br>
&gt; amd_pp_sensors enumeration list.<br>
&gt;<br>
&gt; Support has been added to Carrizo/smu7<br>
&gt;<br>
&gt; (v2) Squashed the two sensor patches into one.<br>
&gt; (v3) Updated to apply to smu7_hwmgr instead<br>
&gt;<br>
&gt; Signed-off-by: Tom St Denis &lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/amd_powerplay.c&nbsp;&nbsp;&nbsp;&=
nbsp; | 20 &#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c&nbsp;&nbsp;&nbsp;=
 | 96 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c&nbsp; | 36 &#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h | 12 &#43;&#43=
;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/inc/hwmgr.h&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 &#43;<br>
&gt;&nbsp; 5 files changed, 165 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/g=
pu/drm/amd/powerplay/amd_powerplay.c<br>
&gt; index b1d19409bf86..ee0368381e82 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&gt; @@ -894,6 &#43;894,25 @@ static int pp_dpm_set_mclk_od(void *handle, u=
int32_t value)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr-&gt;hwmgr=
_func-&gt;set_mclk_od(hwmgr, value);<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; &#43;static int pp_dpm_read_sensor(void *handle, int idx, int32_t *val=
ue)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!handle)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr =3D ((struct pp_instan=
ce *)handle)-&gt;hwmgr;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_CHECK_HW(hwmgr);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;hwmgr_func-&gt=
;read_sensor =3D=3D NULL) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; printk(KERN_INFO &quot;%s was not implemented.\n&quot;,=
 __func__);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr-&gt;hwmgr_func-=
&gt;read_sensor(hwmgr, idx, value);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; const struct amd_powerplay_funcs pp_dpm_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_temperature =3D p=
p_dpm_get_temperature,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .load_firmware =3D pp_=
dpm_load_fw,<br>
&gt; @@ -920,6 &#43;939,7 @@ const struct amd_powerplay_funcs pp_dpm_funcs =
=3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_sclk_od =3D pp_dp=
m_set_sclk_od,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_mclk_od =3D pp_dp=
m_get_mclk_od,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mclk_od =3D pp_dp=
m_set_mclk_od,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_sensor =3D pp_dpm_read=
_sensor,<br>
<br>
As a future patch it would be nice to hook up this sensor interface to<br>
the existing amdgpu_pm_info code and make that asic indpendent.<br>
<br>
Series is:<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Alex<br>
<br>
<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static int amd_pp_instance_init(struct amd_pp_init *pp_init,<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c b/drivers/=
gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt; index 5ecef1732e20..9f3c5a8a903c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt; @@ -1857,6 &#43;1857,101 @@ static int cz_get_max_high_clocks(struct p=
p_hwmgr *hwmgr, struct amd_pp_simple_c<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; &#43;static int cz_read_sensor(struct pp_hwmgr *hwmgr, int idx, int32_=
t *value)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct cz_hwmgr *cz_hwmgr =
=3D (struct cz_hwmgr *)(hwmgr-&gt;backend);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_clock_voltage_dep=
endency_table *table =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;dyn_state.vddc_dependenc=
y_on_sclk;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_vce_clock_voltage=
_dependency_table *vce_table =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hwmgr-&gt;dyn_state.vce_clock_voltage_dependency_table;=
<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_uvd_clock_voltage=
_dependency_table *uvd_table =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hwmgr-&gt;dyn_state.uvd_clock_voltage_dependency_table;=
<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sclk_index =3D PHM_=
GET_FIELD(cgs_read_ind_register(hwmgr-&gt;device, CGS_IND_REG__SMC, ixTARGE=
T_AND_CURRENT_PROFILE_INDEX),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; TARGET_AND_CURRENT_PROFILE_INDEX, CURR_SCLK_INDEX);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t uvd_index =3D PHM_G=
ET_FIELD(cgs_read_ind_register(hwmgr-&gt;device, CGS_IND_REG__SMC, ixTARGET=
_AND_CURRENT_PROFILE_INDEX_2),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; TARGET_AND_CURRENT_PROFILE_INDEX_2, CURR_UVD_INDEX);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vce_index =3D PHM_G=
ET_FIELD(cgs_read_ind_register(hwmgr-&gt;device, CGS_IND_REG__SMC, ixTARGET=
_AND_CURRENT_PROFILE_INDEX_2),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; TARGET_AND_CURRENT_PROFILE_INDEX_2, CURR_VCE_INDEX);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sclk, vclk, dclk, e=
cclk, tmp, activity_percent;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t vddnb, vddgfx;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (idx) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_GFX_SC=
LK:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (sclk_index &lt; NUM_SCLK_LEVELS) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sclk =
=3D table-&gt;entries[sclk_index].clk;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =
=3D sclk;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_VDDNB:=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; tmp =3D (cgs_read_ind_register(hwmgr-&gt;device, CGS_IN=
D_REG__SMC, ixSMUSVI_NB_CURRENTVID) &amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CURRENT=
_NB_VID_MASK) &gt;&gt; CURRENT_NB_VID__SHIFT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; vddnb =3D cz_convert_8Bit_index_to_voltage(hwmgr, tmp);=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *value =3D vddnb;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_VDDGFX=
:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; tmp =3D (cgs_read_ind_register(hwmgr-&gt;device, CGS_IN=
D_REG__SMC, ixSMUSVI_GFX_CURRENTVID) &amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CURRENT=
_GFX_VID_MASK) &gt;&gt; CURRENT_GFX_VID__SHIFT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; vddgfx =3D cz_convert_8Bit_index_to_voltage(hwmgr, (u16=
)tmp);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *value =3D vddgfx;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_UVD_VC=
LK:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!cz_hwmgr-&gt;uvd_power_gated) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (uvd=
_index &gt;=3D CZ_MAX_HARDWARE_POWERLEVELS) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else =
{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vclk =3D uvd_table-&gt;entries[uvd=
_index].vclk;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D vclk;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *value =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_UVD_DC=
LK:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!cz_hwmgr-&gt;uvd_power_gated) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (uvd=
_index &gt;=3D CZ_MAX_HARDWARE_POWERLEVELS) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else =
{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dclk =3D uvd_table-&gt;entries[uvd=
_index].dclk;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D dclk;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *value =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_VCE_EC=
CLK:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!cz_hwmgr-&gt;vce_power_gated) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vce=
_index &gt;=3D CZ_MAX_HARDWARE_POWERLEVELS) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else =
{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecclk =3D vce_table-&gt;entries[vc=
e_index].ecclk;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D ecclk;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *value =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_GPU_LO=
AD:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; result =3D smum_send_msg_to_smc(hwmgr-&gt;smumgr, PPSMC=
_MSG_GetAverageGraphicsActivity);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (0 =3D=3D result) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; activit=
y_percent =3D cgs_read_register(hwmgr-&gt;device, mmSMU_MP1_SRBM2P_ARG_0);<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; activit=
y_percent =3D activity_percent &gt; 100 ? 100 : activity_percent;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; activit=
y_percent =3D 50;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *value =3D activity_percent;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; static const struct pp_hwmgr_func cz_hwmgr_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .backend_init =3D cz_h=
wmgr_backend_init,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .backend_fini =3D cz_h=
wmgr_backend_fini,<br>
&gt; @@ -1882,6 &#43;1977,7 @@ static const struct pp_hwmgr_func cz_hwmgr_f=
uncs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_current_shallow_s=
leep_clocks =3D cz_get_current_shallow_sleep_clocks,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_clock_by_type =3D=
 cz_get_clock_by_type,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_max_high_clocks =
=3D cz_get_max_high_clocks,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_sensor =3D cz_read_sen=
sor,<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; int cz_hwmgr_init(struct pp_hwmgr *hwmgr)<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/driver=
s/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; index f67e1e260b30..07a7d046d6f6 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; @@ -3144,6 &#43;3144,41 @@ smu7_print_current_perforce_level(struct pp=
_hwmgr *hwmgr, struct seq_file *m)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;vc=
e&nbsp;&nbsp;&nbsp; %sabled\n&quot;, data-&gt;vce_power_gated ? &quot;dis&q=
uot; : &quot;en&quot;);<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; &#43;static int smu7_read_sensor(struct pp_hwmgr *hwmgr, int idx, int3=
2_t *value)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sclk, mclk, activit=
y_percent;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t offset;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_hwmgr *data =3D =
(struct smu7_hwmgr *)(hwmgr-&gt;backend);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (idx) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_GFX_SC=
LK:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc(hwmgr-&gt;smumgr, PPSMC_MSG_API_Ge=
tSclkFrequency);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; sclk =3D cgs_read_register(hwmgr-&gt;device, mmSMC_MSG_=
ARG_0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *value =3D sclk;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_GFX_MC=
LK:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc(hwmgr-&gt;smumgr, PPSMC_MSG_API_Ge=
tMclkFrequency);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mclk =3D cgs_read_register(hwmgr-&gt;device, mmSMC_MSG_=
ARG_0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *value =3D mclk;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_GPU_LO=
AD:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; offset =3D data-&gt;soft_regs_start &#43; smum_get_offs=
etof(hwmgr-&gt;smumgr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; SMU_SoftRegisters,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; AverageGraphicsActivity);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; activity_percent =3D cgs_read_ind_register(hwmgr-&gt;de=
vice, CGS_IND_REG__SMC, offset);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; activity_percent &#43;=3D 0x80;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; activity_percent &gt;&gt;=3D 8;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *value =3D activity_percent &gt; 100 ? 100 : activity_p=
ercent;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_GPU_TE=
MP:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *value =3D smu7_thermal_get_temperature(hwmgr);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; static int smu7_find_dpm_states_clocks_in_dpm_table(struct pp_hw=
mgr *hwmgr, const void *input)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct phm_set_p=
ower_state_input *states =3D<br>
&gt; @@ -4315,6 &#43;4350,7 @@ static struct pp_hwmgr_func smu7_hwmgr_funcs=
 =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_mclk_od =3D smu7_=
get_mclk_od,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mclk_od =3D smu7_=
set_mclk_od,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_clock_by_type =3D=
 smu7_get_clock_by_type,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_sensor =3D smu7_read_s=
ensor,<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; uint8_t smu7_get_sleep_divider_id_from_clock(uint32_t clock,<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h b/drive=
rs/gpu/drm/amd/powerplay/inc/amd_powerplay.h<br>
&gt; index f941acf563a9..dfa0f38a5e76 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h<br=
>
&gt; @@ -29,6 &#43;29,17 @@<br>
&gt;&nbsp; #include &quot;amd_shared.h&quot;<br>
&gt;&nbsp; #include &quot;cgs_common.h&quot;<br>
&gt;<br>
&gt; &#43;enum amd_pp_sensors {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PP_SENSOR_GFX_SCLK =
=3D 0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PP_SENSOR_VDDNB,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PP_SENSOR_VDDGFX,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PP_SENSOR_UVD_VCLK,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PP_SENSOR_UVD_DCLK,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PP_SENSOR_VCE_ECCLK,<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PP_SENSOR_GPU_LOAD,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PP_SENSOR_GFX_MCLK,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PP_SENSOR_GPU_TEMP,<b=
r>
&gt; &#43;};<br>
&gt;<br>
&gt;&nbsp; enum amd_pp_event {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PP_EVENT_INITIALIZ=
E =3D 0,<br>
&gt; @@ -347,6 &#43;358,7 @@ struct amd_powerplay_funcs {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_sclk_od)(voi=
d *handle, uint32_t value);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_mclk_od)(voi=
d *handle);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_mclk_od)(voi=
d *handle, uint32_t value);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*read_sensor)(void *han=
dle, int idx, int32_t *value);<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; struct amd_powerplay {<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/d=
rm/amd/powerplay/inc/hwmgr.h<br>
&gt; index c9628b4db2c3..fcd45452380d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&gt; @@ -359,6 &#43;359,7 @@ struct pp_hwmgr_func {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_sclk_od)(str=
uct pp_hwmgr *hwmgr, uint32_t value);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_mclk_od)(str=
uct pp_hwmgr *hwmgr);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_mclk_od)(str=
uct pp_hwmgr *hwmgr, uint32_t value);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*read_sensor)(struct pp=
_hwmgr *hwmgr, int idx, int32_t *value);<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; struct pp_table_func {<br>
&gt; --<br>
&gt; 2.10.0<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=
=3D"LPlnk724524">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_14743004775210.15276233173698328" style=3D"margin-bo=
ttom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_14743004775190.49899342106105293" cellspacing=3D"0=
" style=3D"width: 90%; background-color: rgb(255, 255, 255); position: rela=
tive; overflow: auto; padding-top: 20px; padding-bottom: 20px; margin-top: =
20px; border-top: 1px dotted rgb(200, 200, 200); border-bottom: 1px dotted =
rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_14743004775200.7956016082987132" colspan=3D"2" style=3D"=
vertical-align: top; position: relative; padding: 0px; display: table-cell;=
">
<div id=3D"LPRemovePreviewContainer_14743004775200.6248479015358717"></div>
<div id=3D"LPTitle_14743004775200.21508066420594152" style=3D"top: 0px; col=
or: rgb(59, 87, 119); font-weight: normal; font-size: 21px; font-family: wf=
_segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &q=
uot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-h=
eight: 21px;">
<a id=3D"LPUrlAnchor_14743004775200.7167293884594854" href=3D"https://lists=
.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-=
decoration: none;">amd-gfx Info Page - lists.freedesktop.org</a></div>
<div id=3D"LPMetadata_14743004775200.2972104013311352" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: wf=
_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial=
, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_14743004775200.9065864460282174" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_seg=
oe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sa=
ns-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow: =
hidden;">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...</div>
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
</body>
</html>

--_000_CY4PR12MB17688AA3886A61A51BE31262F7F40CY4PR12MB1768namp_--

--===============0321915723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0321915723==--
