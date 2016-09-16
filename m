From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Add sensors debugfs support
Date: Fri, 16 Sep 2016 15:24:31 +1000
Message-ID: <345b5123-c13c-eba3-e2d6-15232cd50733@folklore1984.net>
References: <20160915132228.27765-1-tom.stdenis@amd.com>
 <20160915132228.27765-2-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1436661290=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160915132228.27765-2-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1436661290==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LegA6SPgWBQSN5J6d8X1gbwaDmP0NWgPa"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LegA6SPgWBQSN5J6d8X1gbwaDmP0NWgPa
Content-Type: multipart/mixed; boundary="IVUv5Mwn7nEb8fuMKb7VjEIjT7QCejpUl";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Message-ID: <345b5123-c13c-eba3-e2d6-15232cd50733-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Add sensors debugfs support
References: <20160915132228.27765-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
 <20160915132228.27765-2-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <20160915132228.27765-2-tom.stdenis-5C7GfCeVMHo@public.gmane.org>

--IVUv5Mwn7nEb8fuMKb7VjEIjT7QCejpUl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 09/15/2016 11:22 PM, Tom St Denis wrote:
> This patch adds a callback to powerplay which
> reads specific PP sensors (vdd/clocks/load) which is then
> accessible via debugfs.  The idea being is it'll be a standard
> interface between different ASICs that userland tools can
> read.
>=20
> Currently only CZ/ST is supported but the others are
> NULL'ed off so they shouldn't cause any sort of oops.
>=20
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 31 +++++++
>  drivers/gpu/drm/amd/powerplay/amd_powerplay.c      | 20 +++++
>  drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c     | 96 ++++++++++++++=
++++++++
>  drivers/gpu/drm/amd/powerplay/hwmgr/fiji_hwmgr.c   |  1 +
>  .../gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.c    |  1 +
>  .../gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.c  |  1 +
>  drivers/gpu/drm/amd/powerplay/hwmgr/tonga_hwmgr.c  |  1 +
>  drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h  | 10 +++
>  drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |  1 +
>  9 files changed, 162 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> index 9103e7baf26e..b6a4588c95ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2841,6 +2841,29 @@ static ssize_t amdgpu_debugfs_gca_config_read(st=
ruct file *f, char __user *buf,
>  	return result;
>  }
> =20
> +static ssize_t amdgpu_debugfs_sensor_read(struct file *f, char __user =
*buf,
> +					size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev =3D f->f_inode->i_private;
> +	int r;
> +	int32_t value;
> +
> +	if (size !=3D 4 || *pos & 0x3)

Just some minor questions,

maybe I miss-read but maybe dereference pos the once and have it const?

> +		return -EINVAL;
> +
> +	/* convert offset to sensor number */
> +	*pos >>=3D 2;
Is the intent here just a local mutation or a in-place global state
transition?

Kind Regards,
Edward.

> +
> +	if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->read_sensor=
)
> +		r =3D adev->powerplay.pp_funcs->read_sensor(adev->powerplay.pp_handl=
e, *pos, &value);
> +	else
> +		r =3D -EINVAL;
> +
> +	if (!r)
> +		r =3D put_user(value, (int32_t *)buf);
> +
> +	return !r ? 4 : r;
> +}
> =20
>  static const struct file_operations amdgpu_debugfs_regs_fops =3D {
>  	.owner =3D THIS_MODULE,
> @@ -2873,12 +2896,19 @@ static const struct file_operations amdgpu_debu=
gfs_gca_config_fops =3D {
>  	.llseek =3D default_llseek
>  };
> =20
> +static const struct file_operations amdgpu_debugfs_sensors_fops =3D {
> +	.owner =3D THIS_MODULE,
> +	.read =3D amdgpu_debugfs_sensor_read,
> +	.llseek =3D default_llseek
> +};
> +
>  static const struct file_operations *debugfs_regs[] =3D {
>  	&amdgpu_debugfs_regs_fops,
>  	&amdgpu_debugfs_regs_didt_fops,
>  	&amdgpu_debugfs_regs_pcie_fops,
>  	&amdgpu_debugfs_regs_smc_fops,
>  	&amdgpu_debugfs_gca_config_fops,
> +	&amdgpu_debugfs_sensors_fops,
>  };
> =20
>  static const char *debugfs_regs_names[] =3D {
> @@ -2887,6 +2917,7 @@ static const char *debugfs_regs_names[] =3D {
>  	"amdgpu_regs_pcie",
>  	"amdgpu_regs_smc",
>  	"amdgpu_gca_config",
> +	"amdgpu_sensors",
>  };
> =20
>  static int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gp=
u/drm/amd/powerplay/amd_powerplay.c
> index b1d19409bf86..ee0368381e82 100644
> --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> @@ -894,6 +894,25 @@ static int pp_dpm_set_mclk_od(void *handle, uint32=
_t value)
>  	return hwmgr->hwmgr_func->set_mclk_od(hwmgr, value);
>  }
> =20
> +static int pp_dpm_read_sensor(void *handle, int idx, int32_t *value)
> +{
> +	struct pp_hwmgr *hwmgr;
> +
> +	if (!handle)
> +		return -EINVAL;
> +
> +	hwmgr =3D ((struct pp_instance *)handle)->hwmgr;
> +
> +	PP_CHECK_HW(hwmgr);
> +
> +	if (hwmgr->hwmgr_func->read_sensor =3D=3D NULL) {
> +		printk(KERN_INFO "%s was not implemented.\n", __func__);
> +		return 0;
> +	}
> +
> +	return hwmgr->hwmgr_func->read_sensor(hwmgr, idx, value);
> +}
> +
>  const struct amd_powerplay_funcs pp_dpm_funcs =3D {
>  	.get_temperature =3D pp_dpm_get_temperature,
>  	.load_firmware =3D pp_dpm_load_fw,
> @@ -920,6 +939,7 @@ const struct amd_powerplay_funcs pp_dpm_funcs =3D {=

>  	.set_sclk_od =3D pp_dpm_set_sclk_od,
>  	.get_mclk_od =3D pp_dpm_get_mclk_od,
>  	.set_mclk_od =3D pp_dpm_set_mclk_od,
> +	.read_sensor =3D pp_dpm_read_sensor,
>  };
> =20
>  static int amd_pp_instance_init(struct amd_pp_init *pp_init,
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> index 5ecef1732e20..9f3c5a8a903c 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> @@ -1857,6 +1857,101 @@ static int cz_get_max_high_clocks(struct pp_hwm=
gr *hwmgr, struct amd_pp_simple_c
>  	return 0;
>  }
> =20
> +static int cz_read_sensor(struct pp_hwmgr *hwmgr, int idx, int32_t *va=
lue)
> +{
> +	struct cz_hwmgr *cz_hwmgr =3D (struct cz_hwmgr *)(hwmgr->backend);
> +
> +	struct phm_clock_voltage_dependency_table *table =3D
> +				hwmgr->dyn_state.vddc_dependency_on_sclk;
> +
> +	struct phm_vce_clock_voltage_dependency_table *vce_table =3D
> +		hwmgr->dyn_state.vce_clock_voltage_dependency_table;
> +
> +	struct phm_uvd_clock_voltage_dependency_table *uvd_table =3D
> +		hwmgr->dyn_state.uvd_clock_voltage_dependency_table;
> +
> +	uint32_t sclk_index =3D PHM_GET_FIELD(cgs_read_ind_register(hwmgr->de=
vice, CGS_IND_REG__SMC, ixTARGET_AND_CURRENT_PROFILE_INDEX),
> +					TARGET_AND_CURRENT_PROFILE_INDEX, CURR_SCLK_INDEX);
> +	uint32_t uvd_index =3D PHM_GET_FIELD(cgs_read_ind_register(hwmgr->dev=
ice, CGS_IND_REG__SMC, ixTARGET_AND_CURRENT_PROFILE_INDEX_2),
> +					TARGET_AND_CURRENT_PROFILE_INDEX_2, CURR_UVD_INDEX);
> +	uint32_t vce_index =3D PHM_GET_FIELD(cgs_read_ind_register(hwmgr->dev=
ice, CGS_IND_REG__SMC, ixTARGET_AND_CURRENT_PROFILE_INDEX_2),
> +					TARGET_AND_CURRENT_PROFILE_INDEX_2, CURR_VCE_INDEX);
> +
> +	uint32_t sclk, vclk, dclk, ecclk, tmp, activity_percent;
> +	uint16_t vddnb, vddgfx;
> +	int result;
> +
> +	switch (idx) {
> +	case AMDGPU_PP_SENSOR_GFX_SCLK:
> +		if (sclk_index < NUM_SCLK_LEVELS) {
> +			sclk =3D table->entries[sclk_index].clk;
> +			*value =3D sclk;
> +			return 0;
> +		}
> +		return -EINVAL;
> +	case AMDGPU_PP_SENSOR_VDDNB:
> +		tmp =3D (cgs_read_ind_register(hwmgr->device, CGS_IND_REG__SMC, ixSM=
USVI_NB_CURRENTVID) &
> +			CURRENT_NB_VID_MASK) >> CURRENT_NB_VID__SHIFT;
> +		vddnb =3D cz_convert_8Bit_index_to_voltage(hwmgr, tmp);
> +		*value =3D vddnb;
> +		return 0;
> +	case AMDGPU_PP_SENSOR_VDDGFX:
> +		tmp =3D (cgs_read_ind_register(hwmgr->device, CGS_IND_REG__SMC, ixSM=
USVI_GFX_CURRENTVID) &
> +			CURRENT_GFX_VID_MASK) >> CURRENT_GFX_VID__SHIFT;
> +		vddgfx =3D cz_convert_8Bit_index_to_voltage(hwmgr, (u16)tmp);
> +		*value =3D vddgfx;
> +		return 0;
> +	case AMDGPU_PP_SENSOR_UVD_VCLK:
> +		if (!cz_hwmgr->uvd_power_gated) {
> +			if (uvd_index >=3D CZ_MAX_HARDWARE_POWERLEVELS) {
> +				return -EINVAL;
> +			} else {
> +				vclk =3D uvd_table->entries[uvd_index].vclk;
> +				*value =3D vclk;
> +				return 0;
> +			}
> +		}
> +		*value =3D 0;
> +		return 0;
> +	case AMDGPU_PP_SENSOR_UVD_DCLK:
> +		if (!cz_hwmgr->uvd_power_gated) {
> +			if (uvd_index >=3D CZ_MAX_HARDWARE_POWERLEVELS) {
> +				return -EINVAL;
> +			} else {
> +				dclk =3D uvd_table->entries[uvd_index].dclk;
> +				*value =3D dclk;
> +				return 0;
> +			}
> +		}
> +		*value =3D 0;
> +		return 0;
> +	case AMDGPU_PP_SENSOR_VCE_ECCLK:
> +		if (!cz_hwmgr->vce_power_gated) {
> +			if (vce_index >=3D CZ_MAX_HARDWARE_POWERLEVELS) {
> +				return -EINVAL;
> +			} else {
> +				ecclk =3D vce_table->entries[vce_index].ecclk;
> +				*value =3D ecclk;
> +				return 0;
> +			}
> +		}
> +		*value =3D 0;
> +		return 0;
> +	case AMDGPU_PP_SENSOR_GPU_LOAD:
> +		result =3D smum_send_msg_to_smc(hwmgr->smumgr, PPSMC_MSG_GetAverageG=
raphicsActivity);
> +		if (0 =3D=3D result) {
> +			activity_percent =3D cgs_read_register(hwmgr->device, mmSMU_MP1_SRB=
M2P_ARG_0);
> +			activity_percent =3D activity_percent > 100 ? 100 : activity_percen=
t;
> +		} else {
> +			activity_percent =3D 50;
> +		}
> +		*value =3D activity_percent;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static const struct pp_hwmgr_func cz_hwmgr_funcs =3D {
>  	.backend_init =3D cz_hwmgr_backend_init,
>  	.backend_fini =3D cz_hwmgr_backend_fini,
> @@ -1882,6 +1977,7 @@ static const struct pp_hwmgr_func cz_hwmgr_funcs =
=3D {
>  	.get_current_shallow_sleep_clocks =3D cz_get_current_shallow_sleep_cl=
ocks,
>  	.get_clock_by_type =3D cz_get_clock_by_type,
>  	.get_max_high_clocks =3D cz_get_max_high_clocks,
> +	.read_sensor =3D cz_read_sensor,
>  };
> =20
>  int cz_hwmgr_init(struct pp_hwmgr *hwmgr)
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/fiji_hwmgr.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/fiji_hwmgr.c
> index 0d4c99b9e3f9..c64def1884c9 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/fiji_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/fiji_hwmgr.c
> @@ -5590,6 +5590,7 @@ static const struct pp_hwmgr_func fiji_hwmgr_func=
s =3D {
>  	.set_sclk_od =3D fiji_set_sclk_od,
>  	.get_mclk_od =3D fiji_get_mclk_od,
>  	.set_mclk_od =3D fiji_set_mclk_od,
> +	.read_sensor =3D NULL,
>  };
> =20
>  int fiji_hwmgr_init(struct pp_hwmgr *hwmgr)
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.c b/driv=
ers/gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.c
> index 5abe43360ec0..d7a1410402d4 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.c
> @@ -5663,6 +5663,7 @@ static const struct pp_hwmgr_func iceland_hwmgr_f=
uncs =3D {
>  	.set_sclk_od =3D iceland_set_sclk_od,
>  	.get_mclk_od =3D iceland_get_mclk_od,
>  	.set_mclk_od =3D iceland_set_mclk_od,
> +	.read_sensor =3D NULL,
>  };
> =20
>  int iceland_hwmgr_init(struct pp_hwmgr *hwmgr)
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.c b/dr=
ivers/gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.c
> index 970e3930452d..8da1d0f66240 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.c
> @@ -5278,6 +5278,7 @@ static const struct pp_hwmgr_func polaris10_hwmgr=
_funcs =3D {
>  	.set_sclk_od =3D polaris10_set_sclk_od,
>  	.get_mclk_od =3D polaris10_get_mclk_od,
>  	.set_mclk_od =3D polaris10_set_mclk_od,
> +	.read_sensor =3D NULL,
>  };
> =20
>  int polaris10_hwmgr_init(struct pp_hwmgr *hwmgr)
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/tonga_hwmgr.c b/driver=
s/gpu/drm/amd/powerplay/hwmgr/tonga_hwmgr.c
> index 42783bf7647c..a5175ea5bb46 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/tonga_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/tonga_hwmgr.c
> @@ -6359,6 +6359,7 @@ static const struct pp_hwmgr_func tonga_hwmgr_fun=
cs =3D {
>  	.set_sclk_od =3D tonga_set_sclk_od,
>  	.get_mclk_od =3D tonga_get_mclk_od,
>  	.set_mclk_od =3D tonga_set_mclk_od,
> +	.read_sensor =3D NULL,
>  };
> =20
>  int tonga_hwmgr_init(struct pp_hwmgr *hwmgr)
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h b/driver=
s/gpu/drm/amd/powerplay/inc/amd_powerplay.h
> index 18f39e89a7aa..bafb593b568a 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h
> @@ -29,6 +29,15 @@
>  #include "amd_shared.h"
>  #include "cgs_common.h"
> =20
> +enum amd_pp_sensors {
> +	AMDGPU_PP_SENSOR_GFX_SCLK =3D 0,
> +	AMDGPU_PP_SENSOR_VDDNB,
> +	AMDGPU_PP_SENSOR_VDDGFX,
> +	AMDGPU_PP_SENSOR_UVD_VCLK,
> +	AMDGPU_PP_SENSOR_UVD_DCLK,
> +	AMDGPU_PP_SENSOR_VCE_ECCLK,
> +	AMDGPU_PP_SENSOR_GPU_LOAD,
> +};
> =20
>  enum amd_pp_event {
>  	AMD_PP_EVENT_INITIALIZE =3D 0,
> @@ -346,6 +355,7 @@ struct amd_powerplay_funcs {
>  	int (*set_sclk_od)(void *handle, uint32_t value);
>  	int (*get_mclk_od)(void *handle);
>  	int (*set_mclk_od)(void *handle, uint32_t value);
> +	int (*read_sensor)(void *handle, int idx, int32_t *value);
>  };
> =20
>  struct amd_powerplay {
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/dr=
m/amd/powerplay/inc/hwmgr.h
> index e98748344801..310ba0ce2934 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> @@ -359,6 +359,7 @@ struct pp_hwmgr_func {
>  	int (*set_sclk_od)(struct pp_hwmgr *hwmgr, uint32_t value);
>  	int (*get_mclk_od)(struct pp_hwmgr *hwmgr);
>  	int (*set_mclk_od)(struct pp_hwmgr *hwmgr, uint32_t value);
> +	int (*read_sensor)(struct pp_hwmgr *hwmgr, int idx, int32_t *value);
>  };
> =20
>  struct pp_table_func {
>=20


--IVUv5Mwn7nEb8fuMKb7VjEIjT7QCejpUl--

--LegA6SPgWBQSN5J6d8X1gbwaDmP0NWgPa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX24IQAAoJEP4bvbfZuWjbPlMQANr/+aqX9auE4MDbpUalbsyu
VfRoYLyfkRQ/oLtRZstSEmI9WfQIXCjyTIdtHxqy2H3ctBYwYYXRnzaSHnE0oT4t
nDYGmYIVOpigNtxNGRNJdPLdcGkuCdbcvB8qEHYNqaiw1BuLd+xHbsZUVvsBPKNH
ypVB9+V1U+c+STMruIYuTh0WRCGKdKXTu3k7xUrbFBONZOxp93BrmM5ZMC33y+/z
cWWV3oMc9IY4DgJDXeWz7zAmPFOow4QUwHe3lVC/lDCfvWxMtL4OcXrP1nJnK4zs
JWwi5+/Sj8R6bxC/TUWqV4+62Ioef8/TrDFeQWAtgEr+qOoyOQwuJdxC0IyzspnL
wSTigMyJuz61vbvGZiSGKTbWHxUW/s4Ol+5xJx7XIN+1l0G1N1BIvE0GcMIVd6Hj
PklJv2sR0NP3Ry1quD17DhPBjOJWPKF2q4yBGnwi3eGcyYj8MgNT0Shtv/0sKr7D
itzQbhlk+chShpOSvHEsNILkSsCCkaAOXxR7Bx1wwEn255XBr2eBLd2Xkf2VKSLU
sPLLzyrn+IEuzJiVDnsuK5vVVVXiUckQ/59FfmlQ7Jeozck0WfySIzHJ25pf5/nq
PoC2BwUf3KOkmlhj3Q30ymMxOTcabVwphubUA0bBdF4EAoxZiwCJ2ypJpORYYvDL
sDL/nd1giK0UiziqbJa2
=QNy/
-----END PGP SIGNATURE-----

--LegA6SPgWBQSN5J6d8X1gbwaDmP0NWgPa--

--===============1436661290==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1436661290==--
