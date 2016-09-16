From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Add sensors debugfs support
Date: Fri, 16 Sep 2016 11:45:21 +0000
Message-ID: <BN6PR12MB176483F1A5B0F38D068CFCC7F7F30@BN6PR12MB1764.namprd12.prod.outlook.com>
References: <20160915132228.27765-1-tom.stdenis@amd.com>
 <20160915132228.27765-2-tom.stdenis@amd.com>,
 <345b5123-c13c-eba3-e2d6-15232cd50733@folklore1984.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0582682023=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <345b5123-c13c-eba3-e2d6-15232cd50733-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
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
To: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0582682023==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB176483F1A5B0F38D068CFCC7F7F30BN6PR12MB1764namp_"

--_000_BN6PR12MB176483F1A5B0F38D068CFCC7F7F30BN6PR12MB1764namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

The idea was to treat it like a somewhat normal file.  So every 4 bytes is =
a new sensor.  So I do "*pos >>=3D 2" to map an offset to an index.  Linux =
doesn't care that I modified *pos though because we're not allowing the use=
r to read more than a 4 bytes at a time (so if they tried to read more than=
 a page it would just fail anyways).


Tom


________________________________
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Sent: Friday, September 16, 2016 01:24
To: Tom St Denis; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: StDenis, Tom
Subject: Re: [PATCH] drm/amd/amdgpu: Add sensors debugfs support



On 09/15/2016 11:22 PM, Tom St Denis wrote:
> This patch adds a callback to powerplay which
> reads specific PP sensors (vdd/clocks/load) which is then
> accessible via debugfs.  The idea being is it'll be a standard
> interface between different ASICs that userland tools can
> read.
>
> Currently only CZ/ST is supported but the others are
> NULL'ed off so they shouldn't cause any sort of oops.
>
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 31 +++++++
>  drivers/gpu/drm/amd/powerplay/amd_powerplay.c      | 20 +++++
>  drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c     | 96 ++++++++++++++++=
++++++
>  drivers/gpu/drm/amd/powerplay/hwmgr/fiji_hwmgr.c   |  1 +
>  .../gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.c    |  1 +
>  .../gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.c  |  1 +
>  drivers/gpu/drm/amd/powerplay/hwmgr/tonga_hwmgr.c  |  1 +
>  drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h  | 10 +++
>  drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |  1 +
>  9 files changed, 162 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 9103e7baf26e..b6a4588c95ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2841,6 +2841,29 @@ static ssize_t amdgpu_debugfs_gca_config_read(stru=
ct file *f, char __user *buf,
>        return result;
>  }
>
> +static ssize_t amdgpu_debugfs_sensor_read(struct file *f, char __user *b=
uf,
> +                                     size_t size, loff_t *pos)
> +{
> +     struct amdgpu_device *adev =3D f->f_inode->i_private;
> +     int r;
> +     int32_t value;
> +
> +     if (size !=3D 4 || *pos & 0x3)

Just some minor questions,

maybe I miss-read but maybe dereference pos the once and have it const?

> +             return -EINVAL;
> +
> +     /* convert offset to sensor number */
> +     *pos >>=3D 2;
Is the intent here just a local mutation or a in-place global state
transition?

Kind Regards,
Edward.

> +
> +     if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->read_sens=
or)
> +             r =3D adev->powerplay.pp_funcs->read_sensor(adev->powerplay=
.pp_handle, *pos, &value);
> +     else
> +             r =3D -EINVAL;
> +
> +     if (!r)
> +             r =3D put_user(value, (int32_t *)buf);
> +
> +     return !r ? 4 : r;
> +}
>
>  static const struct file_operations amdgpu_debugfs_regs_fops =3D {
>        .owner =3D THIS_MODULE,
> @@ -2873,12 +2896,19 @@ static const struct file_operations amdgpu_debugf=
s_gca_config_fops =3D {
>        .llseek =3D default_llseek
>  };
>
> +static const struct file_operations amdgpu_debugfs_sensors_fops =3D {
> +     .owner =3D THIS_MODULE,
> +     .read =3D amdgpu_debugfs_sensor_read,
> +     .llseek =3D default_llseek
> +};
> +
>  static const struct file_operations *debugfs_regs[] =3D {
>        &amdgpu_debugfs_regs_fops,
>        &amdgpu_debugfs_regs_didt_fops,
>        &amdgpu_debugfs_regs_pcie_fops,
>        &amdgpu_debugfs_regs_smc_fops,
>        &amdgpu_debugfs_gca_config_fops,
> +     &amdgpu_debugfs_sensors_fops,
>  };
>
>  static const char *debugfs_regs_names[] =3D {
> @@ -2887,6 +2917,7 @@ static const char *debugfs_regs_names[] =3D {
>        "amdgpu_regs_pcie",
>        "amdgpu_regs_smc",
>        "amdgpu_gca_config",
> +     "amdgpu_sensors",
>  };
>
>  static int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/=
drm/amd/powerplay/amd_powerplay.c
> index b1d19409bf86..ee0368381e82 100644
> --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> @@ -894,6 +894,25 @@ static int pp_dpm_set_mclk_od(void *handle, uint32_t=
 value)
>        return hwmgr->hwmgr_func->set_mclk_od(hwmgr, value);
>  }
>
> +static int pp_dpm_read_sensor(void *handle, int idx, int32_t *value)
> +{
> +     struct pp_hwmgr *hwmgr;
> +
> +     if (!handle)
> +             return -EINVAL;
> +
> +     hwmgr =3D ((struct pp_instance *)handle)->hwmgr;
> +
> +     PP_CHECK_HW(hwmgr);
> +
> +     if (hwmgr->hwmgr_func->read_sensor =3D=3D NULL) {
> +             printk(KERN_INFO "%s was not implemented.\n", __func__);
> +             return 0;
> +     }
> +
> +     return hwmgr->hwmgr_func->read_sensor(hwmgr, idx, value);
> +}
> +
>  const struct amd_powerplay_funcs pp_dpm_funcs =3D {
>        .get_temperature =3D pp_dpm_get_temperature,
>        .load_firmware =3D pp_dpm_load_fw,
> @@ -920,6 +939,7 @@ const struct amd_powerplay_funcs pp_dpm_funcs =3D {
>        .set_sclk_od =3D pp_dpm_set_sclk_od,
>        .get_mclk_od =3D pp_dpm_get_mclk_od,
>        .set_mclk_od =3D pp_dpm_set_mclk_od,
> +     .read_sensor =3D pp_dpm_read_sensor,
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
>        return 0;
>  }
>
> +static int cz_read_sensor(struct pp_hwmgr *hwmgr, int idx, int32_t *valu=
e)
> +{
> +     struct cz_hwmgr *cz_hwmgr =3D (struct cz_hwmgr *)(hwmgr->backend);
> +
> +     struct phm_clock_voltage_dependency_table *table =3D
> +                             hwmgr->dyn_state.vddc_dependency_on_sclk;
> +
> +     struct phm_vce_clock_voltage_dependency_table *vce_table =3D
> +             hwmgr->dyn_state.vce_clock_voltage_dependency_table;
> +
> +     struct phm_uvd_clock_voltage_dependency_table *uvd_table =3D
> +             hwmgr->dyn_state.uvd_clock_voltage_dependency_table;
> +
> +     uint32_t sclk_index =3D PHM_GET_FIELD(cgs_read_ind_register(hwmgr->=
device, CGS_IND_REG__SMC, ixTARGET_AND_CURRENT_PROFILE_INDEX),
> +                                     TARGET_AND_CURRENT_PROFILE_INDEX, C=
URR_SCLK_INDEX);
> +     uint32_t uvd_index =3D PHM_GET_FIELD(cgs_read_ind_register(hwmgr->d=
evice, CGS_IND_REG__SMC, ixTARGET_AND_CURRENT_PROFILE_INDEX_2),
> +                                     TARGET_AND_CURRENT_PROFILE_INDEX_2,=
 CURR_UVD_INDEX);
> +     uint32_t vce_index =3D PHM_GET_FIELD(cgs_read_ind_register(hwmgr->d=
evice, CGS_IND_REG__SMC, ixTARGET_AND_CURRENT_PROFILE_INDEX_2),
> +                                     TARGET_AND_CURRENT_PROFILE_INDEX_2,=
 CURR_VCE_INDEX);
> +
> +     uint32_t sclk, vclk, dclk, ecclk, tmp, activity_percent;
> +     uint16_t vddnb, vddgfx;
> +     int result;
> +
> +     switch (idx) {
> +     case AMDGPU_PP_SENSOR_GFX_SCLK:
> +             if (sclk_index < NUM_SCLK_LEVELS) {
> +                     sclk =3D table->entries[sclk_index].clk;
> +                     *value =3D sclk;
> +                     return 0;
> +             }
> +             return -EINVAL;
> +     case AMDGPU_PP_SENSOR_VDDNB:
> +             tmp =3D (cgs_read_ind_register(hwmgr->device, CGS_IND_REG__=
SMC, ixSMUSVI_NB_CURRENTVID) &
> +                     CURRENT_NB_VID_MASK) >> CURRENT_NB_VID__SHIFT;
> +             vddnb =3D cz_convert_8Bit_index_to_voltage(hwmgr, tmp);
> +             *value =3D vddnb;
> +             return 0;
> +     case AMDGPU_PP_SENSOR_VDDGFX:
> +             tmp =3D (cgs_read_ind_register(hwmgr->device, CGS_IND_REG__=
SMC, ixSMUSVI_GFX_CURRENTVID) &
> +                     CURRENT_GFX_VID_MASK) >> CURRENT_GFX_VID__SHIFT;
> +             vddgfx =3D cz_convert_8Bit_index_to_voltage(hwmgr, (u16)tmp=
);
> +             *value =3D vddgfx;
> +             return 0;
> +     case AMDGPU_PP_SENSOR_UVD_VCLK:
> +             if (!cz_hwmgr->uvd_power_gated) {
> +                     if (uvd_index >=3D CZ_MAX_HARDWARE_POWERLEVELS) {
> +                             return -EINVAL;
> +                     } else {
> +                             vclk =3D uvd_table->entries[uvd_index].vclk=
;
> +                             *value =3D vclk;
> +                             return 0;
> +                     }
> +             }
> +             *value =3D 0;
> +             return 0;
> +     case AMDGPU_PP_SENSOR_UVD_DCLK:
> +             if (!cz_hwmgr->uvd_power_gated) {
> +                     if (uvd_index >=3D CZ_MAX_HARDWARE_POWERLEVELS) {
> +                             return -EINVAL;
> +                     } else {
> +                             dclk =3D uvd_table->entries[uvd_index].dclk=
;
> +                             *value =3D dclk;
> +                             return 0;
> +                     }
> +             }
> +             *value =3D 0;
> +             return 0;
> +     case AMDGPU_PP_SENSOR_VCE_ECCLK:
> +             if (!cz_hwmgr->vce_power_gated) {
> +                     if (vce_index >=3D CZ_MAX_HARDWARE_POWERLEVELS) {
> +                             return -EINVAL;
> +                     } else {
> +                             ecclk =3D vce_table->entries[vce_index].ecc=
lk;
> +                             *value =3D ecclk;
> +                             return 0;
> +                     }
> +             }
> +             *value =3D 0;
> +             return 0;
> +     case AMDGPU_PP_SENSOR_GPU_LOAD:
> +             result =3D smum_send_msg_to_smc(hwmgr->smumgr, PPSMC_MSG_Ge=
tAverageGraphicsActivity);
> +             if (0 =3D=3D result) {
> +                     activity_percent =3D cgs_read_register(hwmgr->devic=
e, mmSMU_MP1_SRBM2P_ARG_0);
> +                     activity_percent =3D activity_percent > 100 ? 100 :=
 activity_percent;
> +             } else {
> +                     activity_percent =3D 50;
> +             }
> +             *value =3D activity_percent;
> +             return 0;
> +     default:
> +             return -EINVAL;
> +     }
> +}
> +
>  static const struct pp_hwmgr_func cz_hwmgr_funcs =3D {
>        .backend_init =3D cz_hwmgr_backend_init,
>        .backend_fini =3D cz_hwmgr_backend_fini,
> @@ -1882,6 +1977,7 @@ static const struct pp_hwmgr_func cz_hwmgr_funcs =
=3D {
>        .get_current_shallow_sleep_clocks =3D cz_get_current_shallow_sleep=
_clocks,
>        .get_clock_by_type =3D cz_get_clock_by_type,
>        .get_max_high_clocks =3D cz_get_max_high_clocks,
> +     .read_sensor =3D cz_read_sensor,
>  };
>
>  int cz_hwmgr_init(struct pp_hwmgr *hwmgr)
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/fiji_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/fiji_hwmgr.c
> index 0d4c99b9e3f9..c64def1884c9 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/fiji_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/fiji_hwmgr.c
> @@ -5590,6 +5590,7 @@ static const struct pp_hwmgr_func fiji_hwmgr_funcs =
=3D {
>        .set_sclk_od =3D fiji_set_sclk_od,
>        .get_mclk_od =3D fiji_get_mclk_od,
>        .set_mclk_od =3D fiji_set_mclk_od,
> +     .read_sensor =3D NULL,
>  };
>
>  int fiji_hwmgr_init(struct pp_hwmgr *hwmgr)
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.c b/driver=
s/gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.c
> index 5abe43360ec0..d7a1410402d4 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.c
> @@ -5663,6 +5663,7 @@ static const struct pp_hwmgr_func iceland_hwmgr_fun=
cs =3D {
>        .set_sclk_od =3D iceland_set_sclk_od,
>        .get_mclk_od =3D iceland_get_mclk_od,
>        .set_mclk_od =3D iceland_set_mclk_od,
> +     .read_sensor =3D NULL,
>  };
>
>  int iceland_hwmgr_init(struct pp_hwmgr *hwmgr)
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.c b/driv=
ers/gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.c
> index 970e3930452d..8da1d0f66240 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.c
> @@ -5278,6 +5278,7 @@ static const struct pp_hwmgr_func polaris10_hwmgr_f=
uncs =3D {
>        .set_sclk_od =3D polaris10_set_sclk_od,
>        .get_mclk_od =3D polaris10_get_mclk_od,
>        .set_mclk_od =3D polaris10_set_mclk_od,
> +     .read_sensor =3D NULL,
>  };
>
>  int polaris10_hwmgr_init(struct pp_hwmgr *hwmgr)
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/tonga_hwmgr.c b/drivers/=
gpu/drm/amd/powerplay/hwmgr/tonga_hwmgr.c
> index 42783bf7647c..a5175ea5bb46 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/tonga_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/tonga_hwmgr.c
> @@ -6359,6 +6359,7 @@ static const struct pp_hwmgr_func tonga_hwmgr_funcs=
 =3D {
>        .set_sclk_od =3D tonga_set_sclk_od,
>        .get_mclk_od =3D tonga_get_mclk_od,
>        .set_mclk_od =3D tonga_set_mclk_od,
> +     .read_sensor =3D NULL,
>  };
>
>  int tonga_hwmgr_init(struct pp_hwmgr *hwmgr)
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h b/drivers/=
gpu/drm/amd/powerplay/inc/amd_powerplay.h
> index 18f39e89a7aa..bafb593b568a 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h
> @@ -29,6 +29,15 @@
>  #include "amd_shared.h"
>  #include "cgs_common.h"
>
> +enum amd_pp_sensors {
> +     AMDGPU_PP_SENSOR_GFX_SCLK =3D 0,
> +     AMDGPU_PP_SENSOR_VDDNB,
> +     AMDGPU_PP_SENSOR_VDDGFX,
> +     AMDGPU_PP_SENSOR_UVD_VCLK,
> +     AMDGPU_PP_SENSOR_UVD_DCLK,
> +     AMDGPU_PP_SENSOR_VCE_ECCLK,
> +     AMDGPU_PP_SENSOR_GPU_LOAD,
> +};
>
>  enum amd_pp_event {
>        AMD_PP_EVENT_INITIALIZE =3D 0,
> @@ -346,6 +355,7 @@ struct amd_powerplay_funcs {
>        int (*set_sclk_od)(void *handle, uint32_t value);
>        int (*get_mclk_od)(void *handle);
>        int (*set_mclk_od)(void *handle, uint32_t value);
> +     int (*read_sensor)(void *handle, int idx, int32_t *value);
>  };
>
>  struct amd_powerplay {
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/=
amd/powerplay/inc/hwmgr.h
> index e98748344801..310ba0ce2934 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> @@ -359,6 +359,7 @@ struct pp_hwmgr_func {
>        int (*set_sclk_od)(struct pp_hwmgr *hwmgr, uint32_t value);
>        int (*get_mclk_od)(struct pp_hwmgr *hwmgr);
>        int (*set_mclk_od)(struct pp_hwmgr *hwmgr, uint32_t value);
> +     int (*read_sensor)(struct pp_hwmgr *hwmgr, int idx, int32_t *value)=
;
>  };
>
>  struct pp_table_func {
>


--_000_BN6PR12MB176483F1A5B0F38D068CFCC7F7F30BN6PR12MB1764namp_
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
<p>The idea was to treat it like a somewhat normal file. &nbsp;So every 4 b=
ytes is a new sensor. &nbsp;So I do &quot;*pos &gt;&gt;=3D 2&quot; to map a=
n offset to an index. &nbsp;Linux doesn't care that I modified *pos though =
because we're not allowing the user to read more than a 4 bytes at
 a time (so if they tried to read more than a page it would just fail anywa=
ys).</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Edward O'Callaghan =
&lt;funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, September 16, 2016 01:24<br>
<b>To:</b> Tom St Denis; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> StDenis, Tom<br>
<b>Subject:</b> Re: [PATCH] drm/amd/amdgpu: Add sensors debugfs support</fo=
nt>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText"><br>
<br>
On 09/15/2016 11:22 PM, Tom St Denis wrote:<br>
&gt; This patch adds a callback to powerplay which<br>
&gt; reads specific PP sensors (vdd/clocks/load) which is then<br>
&gt; accessible via debugfs.&nbsp; The idea being is it'll be a standard<br=
>
&gt; interface between different ASICs that userland tools can<br>
&gt; read.<br>
&gt; <br>
&gt; Currently only CZ/ST is supported but the others are<br>
&gt; NULL'ed off so they shouldn't cause any sort of oops.<br>
&gt; <br>
&gt; Signed-off-by: Tom St Denis &lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; | 31 &#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/amd_powerplay.c&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 20 &#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c&nbsp;&nbsp;&nbsp;=
&nbsp; | 96 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/fiji_hwmgr.c&nbsp;&nbsp; |&n=
bsp; 1 &#43;<br>
&gt;&nbsp; .../gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.c&nbsp;&nbsp;&nbsp=
; |&nbsp; 1 &#43;<br>
&gt;&nbsp; .../gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.c&nbsp; |&nbsp; =
1 &#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/tonga_hwmgr.c&nbsp; |&nbsp; =
1 &#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h&nbsp; | 10 &#4=
3;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/inc/hwmgr.h&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 &#43;<br>
&gt;&nbsp; 9 files changed, 162 insertions(&#43;)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index 9103e7baf26e..b6a4588c95ee 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -2841,6 &#43;2841,29 @@ static ssize_t amdgpu_debugfs_gca_config_re=
ad(struct file *f, char __user *buf,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; &#43;static ssize_t amdgpu_debugfs_sensor_read(struct file *f, char __=
user *buf,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; size_t size, loff_t *pos)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D f-&gt;f_i=
node-&gt;i_private;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int32_t value;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (size !=3D 4 || *pos &amp; 0x3)<br>
<br>
Just some minor questions,<br>
<br>
maybe I miss-read but maybe dereference pos the once and have it const?<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -EINVAL;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* convert offset to sensor number */<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; *pos &gt;&gt;=3D 2;<br>
Is the intent here just a local mutation or a in-place global state<br>
transition?<br>
<br>
Kind Regards,<br>
Edward.<br>
<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs &amp;&am=
p; adev-&gt;powerplay.pp_funcs-&gt;read_sensor)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D adev-&gt;powerplay.pp_funcs-&gt;read_sensor(adev-&gt;powerpla=
y.pp_handle, *pos, &amp;value);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D -EINVAL;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D put_user(value, (int32_t *)buf);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return !r ? 4 : r;<br>
&gt; &#43;}<br>
&gt;&nbsp; <br>
&gt;&nbsp; static const struct file_operations amdgpu_debugfs_regs_fops =3D=
 {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,<br>
&gt; @@ -2873,12 &#43;2896,19 @@ static const struct file_operations amdgpu=
_debugfs_gca_config_fops =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek<b=
r>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt; &#43;static const struct file_operations amdgpu_debugfs_sensors_fops =
=3D {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .read =3D amdgpu_debugfs_sensor_read,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt;&nbsp; static const struct file_operations *debugfs_regs[] =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_regs_fop=
s,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_regs_did=
t_fops,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_regs_pci=
e_fops,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_regs_smc=
_fops,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_gca_conf=
ig_fops,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; &amp;amdgpu_debugfs_sensors_fops,<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt;&nbsp; static const char *debugfs_regs_names[] =3D {<br>
&gt; @@ -2887,6 &#43;2917,7 @@ static const char *debugfs_regs_names[] =3D =
{<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;amdgpu_regs_pcie&quot;=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;amdgpu_regs_smc&quot;,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;amdgpu_gca_config&quot=
;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; &quot;amdgpu_sensors&quot;,<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt;&nbsp; static int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)<=
br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/g=
pu/drm/amd/powerplay/amd_powerplay.c<br>
&gt; index b1d19409bf86..ee0368381e82 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&gt; @@ -894,6 &#43;894,25 @@ static int pp_dpm_set_mclk_od(void *handle, u=
int32_t value)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr-&gt;hwmgr_func-=
&gt;set_mclk_od(hwmgr, value);<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; &#43;static int pp_dpm_read_sensor(void *handle, int idx, int32_t *val=
ue)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!handle)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -EINVAL;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr =3D ((struct pp_instance *)handle)=
-&gt;hwmgr;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; PP_CHECK_HW(hwmgr);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;hwmgr_func-&gt;read_sensor=
 =3D=3D NULL) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; printk(KERN_INFO &quot;%s was not implemented.\n&quot;, __func__);<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr-&gt;hwmgr_func-&gt;read_sen=
sor(hwmgr, idx, value);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; const struct amd_powerplay_funcs pp_dpm_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_temperature =3D pp_dpm_=
get_temperature,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .load_firmware =3D pp_dpm_lo=
ad_fw,<br>
&gt; @@ -920,6 &#43;939,7 @@ const struct amd_powerplay_funcs pp_dpm_funcs =
=3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_sclk_od =3D pp_dpm_set_=
sclk_od,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_mclk_od =3D pp_dpm_get_=
mclk_od,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mclk_od =3D pp_dpm_set_=
mclk_od,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .read_sensor =3D pp_dpm_read_sensor,<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt;&nbsp; static int amd_pp_instance_init(struct amd_pp_init *pp_init,<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c b/drivers/=
gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt; index 5ecef1732e20..9f3c5a8a903c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt; @@ -1857,6 &#43;1857,101 @@ static int cz_get_max_high_clocks(struct p=
p_hwmgr *hwmgr, struct amd_pp_simple_c<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; &#43;static int cz_read_sensor(struct pp_hwmgr *hwmgr, int idx, int32_=
t *value)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct cz_hwmgr *cz_hwmgr =3D (struct cz=
_hwmgr *)(hwmgr-&gt;backend);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_clock_voltage_dependency_tabl=
e *table =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;dyn_state.vddc_dependency_on_sclk;<b=
r>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_vce_clock_voltage_dependency_=
table *vce_table =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; hwmgr-&gt;dyn_state.vce_clock_voltage_dependency_table;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_uvd_clock_voltage_dependency_=
table *uvd_table =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; hwmgr-&gt;dyn_state.uvd_clock_voltage_dependency_table;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sclk_index =3D PHM_GET_FIELD(cg=
s_read_ind_register(hwmgr-&gt;device, CGS_IND_REG__SMC, ixTARGET_AND_CURREN=
T_PROFILE_INDEX),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; TARGET_AND_CURRENT_PROFILE_INDEX, CURR_SCLK_INDEX);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t uvd_index =3D PHM_GET_FIELD(cgs=
_read_ind_register(hwmgr-&gt;device, CGS_IND_REG__SMC, ixTARGET_AND_CURRENT=
_PROFILE_INDEX_2),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; TARGET_AND_CURRENT_PROFILE_INDEX_2, CURR_UVD_INDEX);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vce_index =3D PHM_GET_FIELD(cgs=
_read_ind_register(hwmgr-&gt;device, CGS_IND_REG__SMC, ixTARGET_AND_CURRENT=
_PROFILE_INDEX_2),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; TARGET_AND_CURRENT_PROFILE_INDEX_2, CURR_VCE_INDEX);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sclk, vclk, dclk, ecclk, tmp, a=
ctivity_percent;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t vddnb, vddgfx;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int result;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; switch (idx) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_GFX_SCLK:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (sclk_index &lt; NUM_SCLK_LEVELS) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sclk =3D table-&gt;=
entries[sclk_index].clk;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D sclk;<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_VDDNB:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; tmp =3D (cgs_read_ind_register(hwmgr-&gt;device, CGS_IND_REG__SMC, =
ixSMUSVI_NB_CURRENTVID) &amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CURRENT_NB_VID_MASK=
) &gt;&gt; CURRENT_NB_VID__SHIFT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; vddnb =3D cz_convert_8Bit_index_to_voltage(hwmgr, tmp);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; *value =3D vddnb;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_VDDGFX:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; tmp =3D (cgs_read_ind_register(hwmgr-&gt;device, CGS_IND_REG__SMC, =
ixSMUSVI_GFX_CURRENTVID) &amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CURRENT_GFX_VID_MAS=
K) &gt;&gt; CURRENT_GFX_VID__SHIFT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; vddgfx =3D cz_convert_8Bit_index_to_voltage(hwmgr, (u16)tmp);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; *value =3D vddgfx;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_UVD_VCLK:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (!cz_hwmgr-&gt;uvd_power_gated) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (uvd_index &gt;=
=3D CZ_MAX_HARDWARE_POWERLEVELS) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; vclk =3D uvd_table-&gt;entries[uvd_index].vclk=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D vclk;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; *value =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_UVD_DCLK:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (!cz_hwmgr-&gt;uvd_power_gated) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (uvd_index &gt;=
=3D CZ_MAX_HARDWARE_POWERLEVELS) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; dclk =3D uvd_table-&gt;entries[uvd_index].dclk=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D dclk;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; *value =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_VCE_ECCLK:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (!cz_hwmgr-&gt;vce_power_gated) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vce_index &gt;=
=3D CZ_MAX_HARDWARE_POWERLEVELS) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; ecclk =3D vce_table-&gt;entries[vce_index].ecc=
lk;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D ecclk;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; *value =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_GPU_LOAD:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; result =3D smum_send_msg_to_smc(hwmgr-&gt;smumgr, PPSMC_MSG_GetAver=
ageGraphicsActivity);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (0 =3D=3D result) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; activity_percent =
=3D cgs_read_register(hwmgr-&gt;device, mmSMU_MP1_SRBM2P_ARG_0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; activity_percent =
=3D activity_percent &gt; 100 ? 100 : activity_percent;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; activity_percent =
=3D 50;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; *value =3D activity_percent;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; static const struct pp_hwmgr_func cz_hwmgr_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .backend_init =3D cz_hwmgr_b=
ackend_init,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .backend_fini =3D cz_hwmgr_b=
ackend_fini,<br>
&gt; @@ -1882,6 &#43;1977,7 @@ static const struct pp_hwmgr_func cz_hwmgr_f=
uncs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_current_shallow_sleep_c=
locks =3D cz_get_current_shallow_sleep_clocks,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_clock_by_type =3D cz_ge=
t_clock_by_type,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_max_high_clocks =3D cz_=
get_max_high_clocks,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .read_sensor =3D cz_read_sensor,<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt;&nbsp; int cz_hwmgr_init(struct pp_hwmgr *hwmgr)<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/fiji_hwmgr.c b/driver=
s/gpu/drm/amd/powerplay/hwmgr/fiji_hwmgr.c<br>
&gt; index 0d4c99b9e3f9..c64def1884c9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/fiji_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/fiji_hwmgr.c<br>
&gt; @@ -5590,6 &#43;5590,7 @@ static const struct pp_hwmgr_func fiji_hwmgr=
_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_sclk_od =3D fiji_set_sc=
lk_od,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_mclk_od =3D fiji_get_mc=
lk_od,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mclk_od =3D fiji_set_mc=
lk_od,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .read_sensor =3D NULL,<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt;&nbsp; int fiji_hwmgr_init(struct pp_hwmgr *hwmgr)<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.c b/dri=
vers/gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.c<br>
&gt; index 5abe43360ec0..d7a1410402d4 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.c<=
br>
&gt; @@ -5663,6 &#43;5663,7 @@ static const struct pp_hwmgr_func iceland_hw=
mgr_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_sclk_od =3D iceland_set=
_sclk_od,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_mclk_od =3D iceland_get=
_mclk_od,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mclk_od =3D iceland_set=
_mclk_od,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .read_sensor =3D NULL,<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt;&nbsp; int iceland_hwmgr_init(struct pp_hwmgr *hwmgr)<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.c b/d=
rivers/gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.c<br>
&gt; index 970e3930452d..8da1d0f66240 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.=
c<br>
&gt; @@ -5278,6 &#43;5278,7 @@ static const struct pp_hwmgr_func polaris10_=
hwmgr_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_sclk_od =3D polaris10_s=
et_sclk_od,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_mclk_od =3D polaris10_g=
et_mclk_od,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mclk_od =3D polaris10_s=
et_mclk_od,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .read_sensor =3D NULL,<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt;&nbsp; int polaris10_hwmgr_init(struct pp_hwmgr *hwmgr)<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/tonga_hwmgr.c b/drive=
rs/gpu/drm/amd/powerplay/hwmgr/tonga_hwmgr.c<br>
&gt; index 42783bf7647c..a5175ea5bb46 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/tonga_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/tonga_hwmgr.c<br=
>
&gt; @@ -6359,6 &#43;6359,7 @@ static const struct pp_hwmgr_func tonga_hwmg=
r_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_sclk_od =3D tonga_set_s=
clk_od,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_mclk_od =3D tonga_get_m=
clk_od,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mclk_od =3D tonga_set_m=
clk_od,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .read_sensor =3D NULL,<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt;&nbsp; int tonga_hwmgr_init(struct pp_hwmgr *hwmgr)<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h b/drive=
rs/gpu/drm/amd/powerplay/inc/amd_powerplay.h<br>
&gt; index 18f39e89a7aa..bafb593b568a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h<br=
>
&gt; @@ -29,6 &#43;29,15 @@<br>
&gt;&nbsp; #include &quot;amd_shared.h&quot;<br>
&gt;&nbsp; #include &quot;cgs_common.h&quot;<br>
&gt;&nbsp; <br>
&gt; &#43;enum amd_pp_sensors {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PP_SENSOR_GFX_SCLK =3D 0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PP_SENSOR_VDDNB,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PP_SENSOR_VDDGFX,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PP_SENSOR_UVD_VCLK,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PP_SENSOR_UVD_DCLK,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PP_SENSOR_VCE_ECCLK,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PP_SENSOR_GPU_LOAD,<br>
&gt; &#43;};<br>
&gt;&nbsp; <br>
&gt;&nbsp; enum amd_pp_event {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PP_EVENT_INITIALIZE =3D =
0,<br>
&gt; @@ -346,6 &#43;355,7 @@ struct amd_powerplay_funcs {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_sclk_od)(void *han=
dle, uint32_t value);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_mclk_od)(void *han=
dle);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_mclk_od)(void *han=
dle, uint32_t value);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int (*read_sensor)(void *handle, int idx=
, int32_t *value);<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt;&nbsp; struct amd_powerplay {<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/d=
rm/amd/powerplay/inc/hwmgr.h<br>
&gt; index e98748344801..310ba0ce2934 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&gt; @@ -359,6 &#43;359,7 @@ struct pp_hwmgr_func {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_sclk_od)(struct pp=
_hwmgr *hwmgr, uint32_t value);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_mclk_od)(struct pp=
_hwmgr *hwmgr);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_mclk_od)(struct pp=
_hwmgr *hwmgr, uint32_t value);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int (*read_sensor)(struct pp_hwmgr *hwmg=
r, int idx, int32_t *value);<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt;&nbsp; struct pp_table_func {<br>
&gt; <br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN6PR12MB176483F1A5B0F38D068CFCC7F7F30BN6PR12MB1764namp_--

--===============0582682023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0582682023==--
