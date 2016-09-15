From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amd/amdgpu: Add sensors debugfs support
Date: Thu, 15 Sep 2016 15:10:36 +0000
Message-ID: <MWHPR12MB1694800A23CDF4BA960751F2F7F00@MWHPR12MB1694.namprd12.prod.outlook.com>
References: <20160915132228.27765-1-tom.stdenis@amd.com>
 <20160915132228.27765-2-tom.stdenis@amd.com>,
 <ad714ffe-1366-7af5-f01b-f3cc87f20841@vodafone.de>
 <CY4PR12MB176865A001D9C9891E4C09F7F7F00@CY4PR12MB1768.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1129595441=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB176865A001D9C9891E4C09F7F7F00-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1129595441==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB1694800A23CDF4BA960751F2F7F00MWHPR12MB1694namp_"

--_000_MWHPR12MB1694800A23CDF4BA960751F2F7F00MWHPR12MB1694namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

FWIW, temperature and fan are already exposed via standard hwmon interfaces=
.  It might be better to use standard interfaces for some of these things i=
f they exist.

Alex

From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf Of S=
tDenis, Tom
Sent: Thursday, September 15, 2016 9:32 AM
To: Christian K=F6nig; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amd/amdgpu: Add sensors debugfs support


I don't mind splitting this into pp/headers then amdgpu_device.c.



Took a bit to get the userland formatting pretty but it works.  Can --top t=
he PM values.  If we could get temp/watt/etc readings in the kernel I could=
 throw those in userland too.



Tom

________________________________
From: Christian K=F6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org<mailto:deathsimple@vodafon=
e.de>>
Sent: Thursday, September 15, 2016 09:29
To: Tom St Denis; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org>
Cc: StDenis, Tom
Subject: Re: [PATCH] drm/amd/amdgpu: Add sensors debugfs support

Am 15.09.2016 um 15:22 schrieb Tom St Denis:
> This patch adds a callback to powerplay which
> reads specific PP sensors (vdd/clocks/load) which is then
> accessible via debugfs.  The idea being is it'll be a standard
> interface between different ASICs that userland tools can
> read.
>
> Currently only CZ/ST is supported but the others are
> NULL'ed off so they shouldn't cause any sort of oops.
>
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org<mailto:tom.stdenis@amd.c=
om>>

Might be a good idea to split this into implementing the
backend/frontend functions, but this way works for me as well.

Acked-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org<mailto:christian.koen=
ig-5C7GfCeVMHo@public.gmane.org>>.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 31 +++++++
>   drivers/gpu/drm/amd/powerplay/amd_powerplay.c      | 20 +++++
>   drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c     | 96 +++++++++++++++=
+++++++
>   drivers/gpu/drm/amd/powerplay/hwmgr/fiji_hwmgr.c   |  1 +
>   .../gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.c    |  1 +
>   .../gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.c  |  1 +
>   drivers/gpu/drm/amd/powerplay/hwmgr/tonga_hwmgr.c  |  1 +
>   drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h  | 10 +++
>   drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |  1 +
>   9 files changed, 162 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 9103e7baf26e..b6a4588c95ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2841,6 +2841,29 @@ static ssize_t amdgpu_debugfs_gca_config_read(stru=
ct file *f, char __user *buf,
>        return result;
>   }
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
> +             return -EINVAL;
> +
> +     /* convert offset to sensor number */
> +     *pos >>=3D 2;
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
>   static const struct file_operations amdgpu_debugfs_regs_fops =3D {
>        .owner =3D THIS_MODULE,
> @@ -2873,12 +2896,19 @@ static const struct file_operations amdgpu_debugf=
s_gca_config_fops =3D {
>        .llseek =3D default_llseek
>   };
>
> +static const struct file_operations amdgpu_debugfs_sensors_fops =3D {
> +     .owner =3D THIS_MODULE,
> +     .read =3D amdgpu_debugfs_sensor_read,
> +     .llseek =3D default_llseek
> +};
> +
>   static const struct file_operations *debugfs_regs[] =3D {
>        &amdgpu_debugfs_regs_fops,
>        &amdgpu_debugfs_regs_didt_fops,
>        &amdgpu_debugfs_regs_pcie_fops,
>        &amdgpu_debugfs_regs_smc_fops,
>        &amdgpu_debugfs_gca_config_fops,
> +     &amdgpu_debugfs_sensors_fops,
>   };
>
>   static const char *debugfs_regs_names[] =3D {
> @@ -2887,6 +2917,7 @@ static const char *debugfs_regs_names[] =3D {
>        "amdgpu_regs_pcie",
>        "amdgpu_regs_smc",
>        "amdgpu_gca_config",
> +     "amdgpu_sensors",
>   };
>
>   static int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/=
drm/amd/powerplay/amd_powerplay.c
> index b1d19409bf86..ee0368381e82 100644
> --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> @@ -894,6 +894,25 @@ static int pp_dpm_set_mclk_od(void *handle, uint32_t=
 value)
>        return hwmgr->hwmgr_func->set_mclk_od(hwmgr, value);
>   }
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
>   const struct amd_powerplay_funcs pp_dpm_funcs =3D {
>        .get_temperature =3D pp_dpm_get_temperature,
>        .load_firmware =3D pp_dpm_load_fw,
> @@ -920,6 +939,7 @@ const struct amd_powerplay_funcs pp_dpm_funcs =3D {
>        .set_sclk_od =3D pp_dpm_set_sclk_od,
>        .get_mclk_od =3D pp_dpm_get_mclk_od,
>        .set_mclk_od =3D pp_dpm_set_mclk_od,
> +     .read_sensor =3D pp_dpm_read_sensor,
>   };
>
>   static int amd_pp_instance_init(struct amd_pp_init *pp_init,
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> index 5ecef1732e20..9f3c5a8a903c 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> @@ -1857,6 +1857,101 @@ static int cz_get_max_high_clocks(struct pp_hwmgr=
 *hwmgr, struct amd_pp_simple_c
>        return 0;
>   }
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
>   static const struct pp_hwmgr_func cz_hwmgr_funcs =3D {
>        .backend_init =3D cz_hwmgr_backend_init,
>        .backend_fini =3D cz_hwmgr_backend_fini,
> @@ -1882,6 +1977,7 @@ static const struct pp_hwmgr_func cz_hwmgr_funcs =
=3D {
>        .get_current_shallow_sleep_clocks =3D cz_get_current_shallow_sleep=
_clocks,
>        .get_clock_by_type =3D cz_get_clock_by_type,
>        .get_max_high_clocks =3D cz_get_max_high_clocks,
> +     .read_sensor =3D cz_read_sensor,
>   };
>
>   int cz_hwmgr_init(struct pp_hwmgr *hwmgr)
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
>   };
>
>   int fiji_hwmgr_init(struct pp_hwmgr *hwmgr)
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
>   };
>
>   int iceland_hwmgr_init(struct pp_hwmgr *hwmgr)
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
>   };
>
>   int polaris10_hwmgr_init(struct pp_hwmgr *hwmgr)
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
>   };
>
>   int tonga_hwmgr_init(struct pp_hwmgr *hwmgr)
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h b/drivers/=
gpu/drm/amd/powerplay/inc/amd_powerplay.h
> index 18f39e89a7aa..bafb593b568a 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h
> @@ -29,6 +29,15 @@
>   #include "amd_shared.h"
>   #include "cgs_common.h"
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
>   enum amd_pp_event {
>        AMD_PP_EVENT_INITIALIZE =3D 0,
> @@ -346,6 +355,7 @@ struct amd_powerplay_funcs {
>        int (*set_sclk_od)(void *handle, uint32_t value);
>        int (*get_mclk_od)(void *handle);
>        int (*set_mclk_od)(void *handle, uint32_t value);
> +     int (*read_sensor)(void *handle, int idx, int32_t *value);
>   };
>
>   struct amd_powerplay {
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
>   };
>
>   struct pp_table_func {


--_000_MWHPR12MB1694800A23CDF4BA960751F2F7F00MWHPR12MB1694namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">FWIW, temperature and fan=
 are already exposed via standard hwmon interfaces.&nbsp; It might be bette=
r to use standard interfaces for some of these things if they
 exist.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Alex<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> amd-gfx =
[mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org]
<b>On Behalf Of </b>StDenis, Tom<br>
<b>Sent:</b> Thursday, September 15, 2016 9:32 AM<br>
<b>To:</b> Christian K=F6nig; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amd/amdgpu: Add sensors debugfs support<o:p=
></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;;color:black">I don't mind splitting this into pp/h=
eaders then amdgpu_device.c.&nbsp;<o:p></o:p></span></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;;color:black">Took a bit to get the userland format=
ting pretty but it works. &nbsp;Can --top the PM values. &nbsp;If we could =
get temp/watt/etc readings in the kernel I could throw those in userland
 too. &nbsp;<o:p></o:p></span></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;;color:black">Tom<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt;background:white"><spa=
n style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:bla=
ck"><o:p>&nbsp;</o:p></span></p>
<div>
<div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center;backgr=
ound:white">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color=
:black">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal" style=3D"background:white"><b><span style=3D"font-si=
ze:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:blac=
k">From:</span></b><span style=3D"font-size:11.0pt;font-family:&quot;Calibr=
i&quot;,&quot;sans-serif&quot;;color:black"> Christian K=F6nig &lt;<a href=
=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Thursday, September 15, 2016 09:29<br>
<b>To:</b> Tom St Denis; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">a=
md-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> StDenis, Tom<br>
<b>Subject:</b> Re: [PATCH] drm/amd/amdgpu: Add sensors debugfs support</sp=
an><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">&nbsp;<o:p></o:p>=
</span></p>
</div>
</div>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt;background:white"><spa=
n style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-seri=
f&quot;;color:black">Am 15.09.2016 um 15:22 schrieb Tom St Denis:<br>
&gt; This patch adds a callback to powerplay which<br>
&gt; reads specific PP sensors (vdd/clocks/load) which is then<br>
&gt; accessible via debugfs.&nbsp; The idea being is it'll be a standard<br=
>
&gt; interface between different ASICs that userland tools can<br>
&gt; read.<br>
&gt;<br>
&gt; Currently only CZ/ST is supported but the others are<br>
&gt; NULL'ed off so they shouldn't cause any sort of oops.<br>
&gt;<br>
&gt; Signed-off-by: Tom St Denis &lt;<a href=3D"mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org"=
>tom.stdenis-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
Might be a good idea to split this into implementing the <br>
backend/frontend functions, but this way works for me as well.<br>
<br>
Acked-by: Christian K=F6nig &lt;<a href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org"=
>christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 31 &#43;&#43;&#43;&#43;&#43;&#43;&#43;<b=
r>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/amd_powerplay.c&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; | 20 &#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c&nbsp;&nbsp;=
&nbsp;&nbsp; | 96 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/fiji_hwmgr.c&nbsp;&nbs=
p; |&nbsp; 1 &#43;<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.c&nbsp;&nbsp=
;&nbsp; |&nbsp; 1 &#43;<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.c&nbsp; |&=
nbsp; 1 &#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/tonga_hwmgr.c&nbsp; |&=
nbsp; 1 &#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h&nbsp; | =
10 &#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/inc/hwmgr.h&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 &#43;<br>
&gt;&nbsp;&nbsp; 9 files changed, 162 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index 9103e7baf26e..b6a4588c95ee 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -2841,6 &#43;2841,29 @@ static ssize_t amdgpu_debugfs_gca_config_re=
ad(struct file *f, char __user *buf,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
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
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -EINVAL;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* convert offset to sensor number */<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; *pos &gt;&gt;=3D 2;<br>
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
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static const struct file_operations amdgpu_debugfs_regs_fo=
ps =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,<br>
&gt; @@ -2873,12 &#43;2896,19 @@ static const struct file_operations amdgpu=
_debugfs_gca_config_fops =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek<b=
r>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;static const struct file_operations amdgpu_debugfs_sensors_fops =
=3D {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .read =3D amdgpu_debugfs_sensor_read,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; static const struct file_operations *debugfs_regs[] =3D {<=
br>
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
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static const char *debugfs_regs_names[] =3D {<br>
&gt; @@ -2887,6 &#43;2917,7 @@ static const char *debugfs_regs_names[] =3D =
{<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;amdgpu_regs_pcie&quot;=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;amdgpu_regs_smc&quot;,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;amdgpu_gca_config&quot=
;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; &quot;amdgpu_sensors&quot;,<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static int amdgpu_debugfs_regs_init(struct amdgpu_device *=
adev)<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/g=
pu/drm/amd/powerplay/amd_powerplay.c<br>
&gt; index b1d19409bf86..ee0368381e82 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&gt; @@ -894,6 &#43;894,25 @@ static int pp_dpm_set_mclk_od(void *handle, u=
int32_t value)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr-&gt;hwmgr_func-=
&gt;set_mclk_od(hwmgr, value);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
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
&gt;&nbsp;&nbsp; const struct amd_powerplay_funcs pp_dpm_funcs =3D {<br>
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
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static int amd_pp_instance_init(struct amd_pp_init *pp_ini=
t,<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c b/drivers/=
gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt; index 5ecef1732e20..9f3c5a8a903c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt; @@ -1857,6 &#43;1857,101 @@ static int cz_get_max_high_clocks(struct p=
p_hwmgr *hwmgr, struct amd_pp_simple_c<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
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
&gt;&nbsp;&nbsp; static const struct pp_hwmgr_func cz_hwmgr_funcs =3D {<br>
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
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; int cz_hwmgr_init(struct pp_hwmgr *hwmgr)<br>
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
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; int fiji_hwmgr_init(struct pp_hwmgr *hwmgr)<br>
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
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; int iceland_hwmgr_init(struct pp_hwmgr *hwmgr)<br>
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
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; int polaris10_hwmgr_init(struct pp_hwmgr *hwmgr)<br>
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
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; int tonga_hwmgr_init(struct pp_hwmgr *hwmgr)<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h b/drive=
rs/gpu/drm/amd/powerplay/inc/amd_powerplay.h<br>
&gt; index 18f39e89a7aa..bafb593b568a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h<br=
>
&gt; @@ -29,6 &#43;29,15 @@<br>
&gt;&nbsp;&nbsp; #include &quot;amd_shared.h&quot;<br>
&gt;&nbsp;&nbsp; #include &quot;cgs_common.h&quot;<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;enum amd_pp_sensors {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PP_SENSOR_GFX_SCLK =3D 0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PP_SENSOR_VDDNB,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PP_SENSOR_VDDGFX,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PP_SENSOR_UVD_VCLK,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PP_SENSOR_UVD_DCLK,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PP_SENSOR_VCE_ECCLK,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PP_SENSOR_GPU_LOAD,<br>
&gt; &#43;};<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; enum amd_pp_event {<br>
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
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; struct amd_powerplay {<br>
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
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; struct pp_table_func {<br>
<br>
<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MWHPR12MB1694800A23CDF4BA960751F2F7F00MWHPR12MB1694namp_--

--===============1129595441==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1129595441==--
