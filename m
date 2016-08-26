From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [Part II PATCH 08/15] drm/amd/powerplay: add iceland HW manager
Date: Fri, 26 Aug 2016 13:05:31 +1000
Message-ID: <4b2a29d9-ba8c-4d38-765f-6820242ee87f@folklore1984.net>
References: <1469690705-877-1-git-send-email-ray.huang@amd.com>
 <1469690705-877-9-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2067580855=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1469690705-877-9-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2067580855==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hrBPn7gJpuRkcbtK4W5t8s0nSrukVos7b"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hrBPn7gJpuRkcbtK4W5t8s0nSrukVos7b
Content-Type: multipart/mixed; boundary="A2xm9eShc15jN6SxxOCHu6cwuCeTeBmRu"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
 Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Message-ID: <4b2a29d9-ba8c-4d38-765f-6820242ee87f-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [Part II PATCH 08/15] drm/amd/powerplay: add iceland HW manager
References: <1469690705-877-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
 <1469690705-877-9-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1469690705-877-9-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>

--A2xm9eShc15jN6SxxOCHu6cwuCeTeBmRu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 07/28/2016 05:24 PM, Huang Rui wrote:
> This patch introduces the iceland HW manager of powerplay which
> includes HW manager, clockpowergating, thermal, and powertune.
>=20
> Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/Makefile       |    4 +-
>  drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        |    4 +
>  .../amd/powerplay/hwmgr/iceland_clockpowergating.c |  119 +
>  .../amd/powerplay/hwmgr/iceland_clockpowergating.h |   38 +
>  .../gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.c    | 5617 ++++++++++++=
++++++++
>  .../gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.h    |  424 ++
>  .../drm/amd/powerplay/hwmgr/iceland_powertune.c    |  491 ++
>  .../drm/amd/powerplay/hwmgr/iceland_powertune.h    |   74 +
>  .../gpu/drm/amd/powerplay/hwmgr/iceland_thermal.c  |  595 +++
>  .../gpu/drm/amd/powerplay/hwmgr/iceland_thermal.h  |   58 +
>  10 files changed, 7423 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/iceland_clockpo=
wergating.c
>  create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/iceland_clockpo=
wergating.h
>  create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.c=

>  create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.h=

>  create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/iceland_powertu=
ne.c
>  create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/iceland_powertu=
ne.h
>  create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/iceland_thermal=
=2Ec
>  create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/iceland_thermal=
=2Eh
>=20
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/Makefile b/drivers/gpu=
/drm/amd/powerplay/hwmgr/Makefile
> index f7ce4cb..c264cb6 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/Makefile
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/Makefile
> @@ -10,7 +10,9 @@ HARDWARE_MGR =3D hwmgr.o processpptables.o functionta=
bles.o \
>                 fiji_powertune.o fiji_hwmgr.o tonga_clockpowergating.o =
\
>                 fiji_clockpowergating.o fiji_thermal.o \
>  	       polaris10_hwmgr.o polaris10_powertune.o polaris10_thermal.o \
> -	       polaris10_clockpowergating.o
> +	       polaris10_clockpowergating.o iceland_hwmgr.o \
> +	       iceland_clockpowergating.o iceland_thermal.o \
> +	       iceland_powertune.o
> =20
>  AMD_PP_HWMGR =3D $(addprefix $(AMD_PP_PATH)/hwmgr/,$(HARDWARE_MGR))
> =20
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/=
drm/amd/powerplay/hwmgr/hwmgr.c
> index 03b6128..411c267 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
> @@ -39,6 +39,7 @@ extern int cz_hwmgr_init(struct pp_hwmgr *hwmgr);
>  extern int tonga_hwmgr_init(struct pp_hwmgr *hwmgr);
>  extern int fiji_hwmgr_init(struct pp_hwmgr *hwmgr);
>  extern int polaris10_hwmgr_init(struct pp_hwmgr *hwmgr);
> +extern int iceland_hwmgr_init(struct pp_hwmgr *hwmgr);
> =20
>  int hwmgr_init(struct amd_pp_init *pp_init, struct pp_instance *handle=
)
>  {
> @@ -67,6 +68,9 @@ int hwmgr_init(struct amd_pp_init *pp_init, struct pp=
_instance *handle)
>  		break;
>  	case AMDGPU_FAMILY_VI:
>  		switch (hwmgr->chip_id) {
> +		case CHIP_TOPAZ:
> +			iceland_hwmgr_init(hwmgr);
> +			break;
>  		case CHIP_TONGA:
>  			tonga_hwmgr_init(hwmgr);
>  			break;
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/iceland_clockpowergati=
ng.c b/drivers/gpu/drm/amd/powerplay/hwmgr/iceland_clockpowergating.c
> new file mode 100644
> index 0000000..47949f5
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/iceland_clockpowergating.c
> @@ -0,0 +1,119 @@
> +/*
> + * Copyright 2016 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> + * copy of this software and associated documentation files (the "Soft=
ware"),
> + * to deal in the Software without restriction, including without limi=
tation
> + * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> + * and/or sell copies of the Software, and to permit persons to whom t=
he
> + * Software is furnished to do so, subject to the following conditions=
:
> + *
> + * The above copyright notice and this permission notice shall be incl=
uded in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Author: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> + *
> + */
> +
> +#include "hwmgr.h"
> +#include "iceland_clockpowergating.h"
> +#include "ppsmc.h"
> +#include "iceland_hwmgr.h"
> +
> +int iceland_phm_powerdown_uvd(struct pp_hwmgr *hwmgr)
> +{
> +	/* iceland does not have MM hardware block */
> +	return 0;
> +}
> +
> +static int iceland_phm_powerup_uvd(struct pp_hwmgr *hwmgr)
> +{
> +	/* iceland does not have MM hardware block */
> +	return 0;
> +}
> +
> +static int iceland_phm_powerdown_vce(struct pp_hwmgr *hwmgr)
> +{
> +	/* iceland does not have MM hardware block */
> +	return 0;
> +}
> +
> +static int iceland_phm_powerup_vce(struct pp_hwmgr *hwmgr)
> +{
> +	/* iceland does not have MM hardware block */
> +	return 0;
> +}
> +
> +int iceland_phm_set_asic_block_gating(struct pp_hwmgr *hwmgr, enum
> +		PHM_AsicBlock block, enum PHM_ClockGateSetting gating)
> +{
> +	int ret =3D 0;
> +
> +	switch (block) {
> +	case PHM_AsicBlock_UVD_MVC:
> +	case PHM_AsicBlock_UVD:
> +	case PHM_AsicBlock_UVD_HD:
> +	case PHM_AsicBlock_UVD_SD:
> +		if (gating =3D=3D PHM_ClockGateSetting_StaticOff)
> +			ret =3D iceland_phm_powerdown_uvd(hwmgr);
> +		else
> +			ret =3D iceland_phm_powerup_uvd(hwmgr);
> +		break;
> +	case PHM_AsicBlock_GFX:
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +int iceland_phm_disable_clock_power_gating(struct pp_hwmgr *hwmgr)
> +{
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +
> +	data->uvd_power_gated =3D false;
> +	data->vce_power_gated =3D false;
> +
> +	iceland_phm_powerup_uvd(hwmgr);
> +	iceland_phm_powerup_vce(hwmgr);
> +
> +	return 0;
> +}
> +
> +int iceland_phm_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
> +{
> +	if (bgate) {
> +		iceland_update_uvd_dpm(hwmgr, true);
> +		iceland_phm_powerdown_uvd(hwmgr);
> +	} else {
> +		iceland_phm_powerup_uvd(hwmgr);
> +		iceland_update_uvd_dpm(hwmgr, false);
> +	}
> +
> +	return 0;
> +}
> +
> +int iceland_phm_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
> +{
> +	if (bgate)
> +		return iceland_phm_powerdown_vce(hwmgr);
> +	else
> +		return iceland_phm_powerup_vce(hwmgr);
> +
> +	return 0;
> +}
> +
> +int iceland_phm_update_clock_gatings(struct pp_hwmgr *hwmgr,
> +					const uint32_t *msg_id)
> +{
> +	/* iceland does not have MM hardware block */
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/iceland_clockpowergati=
ng.h b/drivers/gpu/drm/amd/powerplay/hwmgr/iceland_clockpowergating.h
> new file mode 100644
> index 0000000..ff5ef00
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/iceland_clockpowergating.h
> @@ -0,0 +1,38 @@
> +/*
> + * Copyright 2016 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> + * copy of this software and associated documentation files (the "Soft=
ware"),
> + * to deal in the Software without restriction, including without limi=
tation
> + * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> + * and/or sell copies of the Software, and to permit persons to whom t=
he
> + * Software is furnished to do so, subject to the following conditions=
:
> + *
> + * The above copyright notice and this permission notice shall be incl=
uded in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Author: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> + *
> + */
> +
> +#ifndef _ICELAND_CLOCK_POWER_GATING_H_
> +#define _ICELAND_CLOCK_POWER_GATING_H_
> +
> +#include "iceland_hwmgr.h"
> +#include "pp_asicblocks.h"
> +
> +extern int iceland_phm_set_asic_block_gating(struct pp_hwmgr *hwmgr, e=
num PHM_AsicBlock block, enum PHM_ClockGateSetting gating);
> +extern int iceland_phm_powergate_vce(struct pp_hwmgr *hwmgr, bool bgat=
e);
> +extern int iceland_phm_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgat=
e);
> +extern int iceland_phm_powerdown_uvd(struct pp_hwmgr *hwmgr);
> +extern int iceland_phm_disable_clock_power_gating(struct pp_hwmgr *hwm=
gr);
> +extern int iceland_phm_update_clock_gatings(struct pp_hwmgr *hwmgr, co=
nst uint32_t *msg_id);
> +#endif /* _ICELAND_CLOCK_POWER_GATING_H_ */
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.c b/driv=
ers/gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.c
> new file mode 100644
> index 0000000..9c6d7e3
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.c
> @@ -0,0 +1,5617 @@
> +/*
> + * Copyright 2016 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> + * copy of this software and associated documentation files (the "Soft=
ware"),
> + * to deal in the Software without restriction, including without limi=
tation
> + * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> + * and/or sell copies of the Software, and to permit persons to whom t=
he
> + * Software is furnished to do so, subject to the following conditions=
:
> + *
> + * The above copyright notice and this permission notice shall be incl=
uded in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Author: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> + *
> + */
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/fb.h>
> +#include "linux/delay.h"
> +#include "pp_acpi.h"
> +#include "hwmgr.h"
> +#include <atombios.h>
> +#include "iceland_hwmgr.h"
> +#include "pptable.h"
> +#include "processpptables.h"
> +#include "pp_debug.h"
> +#include "ppsmc.h"
> +#include "cgs_common.h"
> +#include "pppcielanes.h"
> +#include "iceland_dyn_defaults.h"
> +#include "smumgr.h"
> +#include "iceland_smumgr.h"
> +#include "iceland_clockpowergating.h"
> +#include "iceland_thermal.h"
> +#include "iceland_powertune.h"
> +
> +#include "gmc/gmc_8_1_d.h"
> +#include "gmc/gmc_8_1_sh_mask.h"
> +
> +#include "bif/bif_5_0_d.h"
> +#include "bif/bif_5_0_sh_mask.h"
> +
> +#include "smu/smu_7_1_1_d.h"
> +#include "smu/smu_7_1_1_sh_mask.h"
> +
> +#include "cgs_linux.h"
> +#include "eventmgr.h"
> +#include "amd_pcie_helpers.h"
> +
> +#define MC_CG_ARB_FREQ_F0           0x0a
> +#define MC_CG_ARB_FREQ_F1           0x0b
> +#define MC_CG_ARB_FREQ_F2           0x0c
> +#define MC_CG_ARB_FREQ_F3           0x0d
> +
> +#define MC_CG_SEQ_DRAMCONF_S0       0x05
> +#define MC_CG_SEQ_DRAMCONF_S1       0x06
> +#define MC_CG_SEQ_YCLK_SUSPEND      0x04
> +#define MC_CG_SEQ_YCLK_RESUME       0x0a
> +
> +#define PCIE_BUS_CLK                10000
> +#define TCLK                        (PCIE_BUS_CLK / 10)
> +
> +#define SMC_RAM_END		    0x40000
> +#define SMC_CG_IND_START            0xc0030000
> +#define SMC_CG_IND_END              0xc0040000  /* First byte after SM=
C_CG_IND*/
> +
> +#define VOLTAGE_SCALE               4
> +#define VOLTAGE_VID_OFFSET_SCALE1   625
> +#define VOLTAGE_VID_OFFSET_SCALE2   100
> +
> +const uint32_t iceland_magic =3D (uint32_t)(PHM_VIslands_Magic);
> +
> +#define MC_SEQ_MISC0_GDDR5_SHIFT 28
> +#define MC_SEQ_MISC0_GDDR5_MASK  0xf0000000
> +#define MC_SEQ_MISC0_GDDR5_VALUE 5
> +
> +/** Values for the CG_THERMAL_CTRL::DPM_EVENT_SRC field. */
> +enum DPM_EVENT_SRC {
> +    DPM_EVENT_SRC_ANALOG =3D 0,               /* Internal analog trip =
point */
> +    DPM_EVENT_SRC_EXTERNAL =3D 1,             /* External (GPIO 17) si=
gnal */
> +    DPM_EVENT_SRC_DIGITAL =3D 2,              /* Internal digital trip=
 point (DIG_THERM_DPM) */
> +    DPM_EVENT_SRC_ANALOG_OR_EXTERNAL =3D 3,   /* Internal analog or ex=
ternal */
> +    DPM_EVENT_SRC_DIGITAL_OR_EXTERNAL =3D 4   /* Internal digital or e=
xternal */
> +};
> +
> +static int iceland_read_clock_registers(struct pp_hwmgr *hwmgr)
> +{
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +
> +	data->clock_registers.vCG_SPLL_FUNC_CNTL         =3D
> +		cgs_read_ind_register(hwmgr->device, CGS_IND_REG__SMC, ixCG_SPLL_FUN=
C_CNTL);
> +	data->clock_registers.vCG_SPLL_FUNC_CNTL_2       =3D
> +		cgs_read_ind_register(hwmgr->device, CGS_IND_REG__SMC, ixCG_SPLL_FUN=
C_CNTL_2);
> +	data->clock_registers.vCG_SPLL_FUNC_CNTL_3       =3D
> +		cgs_read_ind_register(hwmgr->device, CGS_IND_REG__SMC, ixCG_SPLL_FUN=
C_CNTL_3);
> +	data->clock_registers.vCG_SPLL_FUNC_CNTL_4       =3D
> +		cgs_read_ind_register(hwmgr->device, CGS_IND_REG__SMC, ixCG_SPLL_FUN=
C_CNTL_4);
> +	data->clock_registers.vCG_SPLL_SPREAD_SPECTRUM   =3D
> +		cgs_read_ind_register(hwmgr->device, CGS_IND_REG__SMC, ixCG_SPLL_SPR=
EAD_SPECTRUM);
> +	data->clock_registers.vCG_SPLL_SPREAD_SPECTRUM_2 =3D
> +		cgs_read_ind_register(hwmgr->device, CGS_IND_REG__SMC, ixCG_SPLL_SPR=
EAD_SPECTRUM_2);
> +	data->clock_registers.vDLL_CNTL                  =3D
> +		cgs_read_register(hwmgr->device, mmDLL_CNTL);
> +	data->clock_registers.vMCLK_PWRMGT_CNTL          =3D
> +		cgs_read_register(hwmgr->device, mmMCLK_PWRMGT_CNTL);
> +	data->clock_registers.vMPLL_AD_FUNC_CNTL         =3D
> +		cgs_read_register(hwmgr->device, mmMPLL_AD_FUNC_CNTL);
> +	data->clock_registers.vMPLL_DQ_FUNC_CNTL         =3D
> +		cgs_read_register(hwmgr->device, mmMPLL_DQ_FUNC_CNTL);
> +	data->clock_registers.vMPLL_FUNC_CNTL            =3D
> +		cgs_read_register(hwmgr->device, mmMPLL_FUNC_CNTL);
> +	data->clock_registers.vMPLL_FUNC_CNTL_1          =3D
> +		cgs_read_register(hwmgr->device, mmMPLL_FUNC_CNTL_1);
> +	data->clock_registers.vMPLL_FUNC_CNTL_2          =3D
> +		cgs_read_register(hwmgr->device, mmMPLL_FUNC_CNTL_2);
> +	data->clock_registers.vMPLL_SS1                  =3D
> +		cgs_read_register(hwmgr->device, mmMPLL_SS1);
> +	data->clock_registers.vMPLL_SS2                  =3D
> +		cgs_read_register(hwmgr->device, mmMPLL_SS2);
> +
> +	return 0;
> +}
> +
> +/**
> + * Find out if memory is GDDR5.
> + *
> + * @param    hwmgr  the address of the powerplay hardware manager.
> + * @return   always 0
> + */
> +int iceland_get_memory_type(struct pp_hwmgr *hwmgr)
> +{
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +	uint32_t temp;
> +
> +	temp =3D cgs_read_register(hwmgr->device, mmMC_SEQ_MISC0);
> +
> +	data->is_memory_GDDR5 =3D (MC_SEQ_MISC0_GDDR5_VALUE =3D=3D
> +			((temp & MC_SEQ_MISC0_GDDR5_MASK) >>
> +			 MC_SEQ_MISC0_GDDR5_SHIFT));
> +
> +	return 0;
> +}
> +
> +int iceland_update_uvd_dpm(struct pp_hwmgr *hwmgr, bool bgate)
> +{
> +	/* iceland does not have MM hardware blocks */
> +	return 0;
> +}
> +
> +/**
> + * Enables Dynamic Power Management by SMC
> + *
> + * @param    hwmgr  the address of the powerplay hardware manager.
> + * @return   always 0
> + */
> +int iceland_enable_acpi_power_management(struct pp_hwmgr *hwmgr)
> +{
> +	PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC, GENERA=
L_PWRMGT, STATIC_PM_EN, 1);
> +
> +	return 0;
> +}
> +
> +/**
> + * Find the MC microcode version and store it in the HwMgr struct
> + *
> + * @param    hwmgr  the address of the powerplay hardware manager.
> + * @return   always 0
> + */
> +int iceland_get_mc_microcode_version(struct pp_hwmgr *hwmgr)
> +{
> +	cgs_write_register(hwmgr->device, mmMC_SEQ_IO_DEBUG_INDEX, 0x9F);
> +
> +	hwmgr->microcode_version_info.MC =3D cgs_read_register(hwmgr->device,=
 mmMC_SEQ_IO_DEBUG_DATA);
> +
> +	return 0;
> +}
> +
> +static int iceland_init_sclk_threshold(struct pp_hwmgr *hwmgr)
> +{
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +
> +	data->low_sclk_interrupt_threshold =3D 0;
> +
> +	return 0;
> +}
> +
> +
> +static int iceland_setup_asic_task(struct pp_hwmgr *hwmgr)
> +{
> +	int tmp_result, result =3D 0;
> +
> +	tmp_result =3D iceland_read_clock_registers(hwmgr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result),
> +		"Failed to read clock registers!", result =3D tmp_result);
> +
> +	tmp_result =3D iceland_get_memory_type(hwmgr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result),
> +		"Failed to get memory type!", result =3D tmp_result);
> +
> +	tmp_result =3D iceland_enable_acpi_power_management(hwmgr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result),
> +		"Failed to enable ACPI power management!", result =3D tmp_result);
> +
> +	tmp_result =3D iceland_get_mc_microcode_version(hwmgr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result),
> +		"Failed to get MC microcode version!", result =3D tmp_result);
> +
> +	tmp_result =3D iceland_init_sclk_threshold(hwmgr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result),
> +		"Failed to init sclk threshold!", result =3D tmp_result);
> +
> +	return result;
> +}
> +
> +static bool cf_iceland_voltage_control(struct pp_hwmgr *hwmgr)
> +{
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +
> +	return ICELAND_VOLTAGE_CONTROL_NONE !=3D data->voltage_control;
> +}
> +
> +/*
> + * -------------- Voltage Tables ----------------------
> + * If the voltage table would be bigger than what will fit into the
> + * state table on the SMC keep only the higher entries.
> + */
> +
> +static void iceland_trim_voltage_table_to_fit_state_table(
> +		struct pp_hwmgr *hwmgr,
> +		uint32_t max_voltage_steps,
> +		pp_atomctrl_voltage_table *voltage_table)
> +{
> +	unsigned int i, diff;
> +
> +	if (voltage_table->count <=3D max_voltage_steps) {
> +		return;
> +	}
> +
> +	diff =3D voltage_table->count - max_voltage_steps;
> +
> +	for (i =3D 0; i < max_voltage_steps; i++) {
> +		voltage_table->entries[i] =3D voltage_table->entries[i + diff];
> +	}
> +
> +	voltage_table->count =3D max_voltage_steps;
> +
> +	return;
> +}
> +
> +/**
> + * Enable voltage control
> + *
> + * @param    hwmgr  the address of the powerplay hardware manager.
> + * @return   always 0
> + */
> +int iceland_enable_voltage_control(struct pp_hwmgr *hwmgr)
> +{
> +	/* enable voltage control */
> +	PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC, GENERA=
L_PWRMGT, VOLT_PWRMGT_EN, 1);
> +
> +	return 0;
> +}
> +
> +static int iceland_get_svi2_voltage_table(struct pp_hwmgr *hwmgr,
> +		struct phm_clock_voltage_dependency_table *voltage_dependency_table,=

> +		pp_atomctrl_voltage_table *voltage_table)
> +{
> +	uint32_t i;
> +
> +	PP_ASSERT_WITH_CODE((NULL !=3D voltage_table),
> +			"Voltage Dependency Table empty.", return -EINVAL;);
> +
> +	voltage_table->mask_low =3D 0;
> +	voltage_table->phase_delay =3D 0;
> +	voltage_table->count =3D voltage_dependency_table->count;
> +
> +	for (i =3D 0; i < voltage_dependency_table->count; i++) {
> +		voltage_table->entries[i].value =3D
> +			voltage_dependency_table->entries[i].v;
> +		voltage_table->entries[i].smio_low =3D 0;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * Create Voltage Tables.
> + *
> + * @param    hwmgr  the address of the powerplay hardware manager.
> + * @return   always 0
> + */
> +int iceland_construct_voltage_tables(struct pp_hwmgr *hwmgr)
> +{
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +	int result;
> +
> +	/* GPIO voltage */
> +	if (ICELAND_VOLTAGE_CONTROL_BY_GPIO =3D=3D data->voltage_control) {
> +		result =3D atomctrl_get_voltage_table_v3(hwmgr,
> +					VOLTAGE_TYPE_VDDC, VOLTAGE_OBJ_GPIO_LUT,
> +					&data->vddc_voltage_table);
> +		PP_ASSERT_WITH_CODE((0 =3D=3D result),
> +			"Failed to retrieve VDDC table.", return result;);
> +	} else if (ICELAND_VOLTAGE_CONTROL_BY_SVID2 =3D=3D data->voltage_cont=
rol) {
> +		/* SVI2 VDDC voltage */
> +		result =3D iceland_get_svi2_voltage_table(hwmgr,
> +					hwmgr->dyn_state.vddc_dependency_on_mclk,
> +					&data->vddc_voltage_table);
> +		PP_ASSERT_WITH_CODE((0 =3D=3D result),
> +			"Failed to retrieve SVI2 VDDC table from dependancy table.", return=
 result;);
> +	}
> +
> +	PP_ASSERT_WITH_CODE(
> +			(data->vddc_voltage_table.count <=3D (SMU71_MAX_LEVELS_VDDC)),
> +			"Too many voltage values for VDDC. Trimming to fit state table.",
> +			iceland_trim_voltage_table_to_fit_state_table(hwmgr,
> +			SMU71_MAX_LEVELS_VDDC, &(data->vddc_voltage_table));
> +			);
> +
> +	/* GPIO */
> +	if (ICELAND_VOLTAGE_CONTROL_BY_GPIO =3D=3D data->vdd_ci_control) {
> +		result =3D atomctrl_get_voltage_table_v3(hwmgr,
> +					VOLTAGE_TYPE_VDDCI, VOLTAGE_OBJ_GPIO_LUT, &(data->vddci_voltage_t=
able));
> +		PP_ASSERT_WITH_CODE((0 =3D=3D result),
> +			"Failed to retrieve VDDCI table.", return result;);
> +	}
> +
> +	/* SVI2 VDDCI voltage */
> +	if (ICELAND_VOLTAGE_CONTROL_BY_SVID2 =3D=3D data->vdd_ci_control) {
> +		result =3D iceland_get_svi2_voltage_table(hwmgr,
> +					hwmgr->dyn_state.vddci_dependency_on_mclk,
> +					&data->vddci_voltage_table);
> +		PP_ASSERT_WITH_CODE((0 =3D=3D result),
> +			"Failed to retrieve SVI2 VDDCI table from dependancy table.", retur=
n result;);
> +	}
> +
> +	PP_ASSERT_WITH_CODE(
> +			(data->vddci_voltage_table.count <=3D (SMU71_MAX_LEVELS_VDDCI)),
> +			"Too many voltage values for VDDCI. Trimming to fit state table.",
> +			iceland_trim_voltage_table_to_fit_state_table(hwmgr,
> +			SMU71_MAX_LEVELS_VDDCI, &(data->vddci_voltage_table));
> +			);
> +
> +
> +	/* GPIO */
> +	if (ICELAND_VOLTAGE_CONTROL_BY_GPIO =3D=3D data->mvdd_control) {
> +		result =3D atomctrl_get_voltage_table_v3(hwmgr,
> +					VOLTAGE_TYPE_MVDDC, VOLTAGE_OBJ_GPIO_LUT, &(data->mvdd_voltage_ta=
ble));
> +		PP_ASSERT_WITH_CODE((0 =3D=3D result),
> +			"Failed to retrieve table.", return result;);
> +	}
> +
> +	/* SVI2 voltage control */
> +	if (ICELAND_VOLTAGE_CONTROL_BY_SVID2 =3D=3D data->mvdd_control) {
> +		result =3D iceland_get_svi2_voltage_table(hwmgr,
> +					hwmgr->dyn_state.mvdd_dependency_on_mclk,
> +					&data->mvdd_voltage_table);
> +		PP_ASSERT_WITH_CODE((0 =3D=3D result),
> +			"Failed to retrieve SVI2 MVDD table from dependancy table.", return=
 result;);
> +	}
> +
> +	PP_ASSERT_WITH_CODE(
> +			(data->mvdd_voltage_table.count <=3D (SMU71_MAX_LEVELS_MVDD)),
> +			"Too many voltage values for MVDD. Trimming to fit state table.",
> +			iceland_trim_voltage_table_to_fit_state_table(hwmgr,
> +			SMU71_MAX_LEVELS_MVDD, &(data->mvdd_voltage_table));
> +			);
> +
> +	return 0;
> +}
> +
> +/*---------------------------MC----------------------------*/
> +
> +uint8_t iceland_get_memory_module_index(struct pp_hwmgr *hwmgr)
> +{
> +	return (uint8_t) (0xFF & (cgs_read_register(hwmgr->device, mmBIOS_SCR=
ATCH_4) >> 16));
> +}
> +
> +bool iceland_check_s0_mc_reg_index(uint16_t inReg, uint16_t *outReg)
> +{
> +	bool result =3D true;
> +
> +	switch (inReg) {
> +	case  mmMC_SEQ_RAS_TIMING:
> +		*outReg =3D mmMC_SEQ_RAS_TIMING_LP;
> +		break;
> +
> +	case  mmMC_SEQ_DLL_STBY:
> +		*outReg =3D mmMC_SEQ_DLL_STBY_LP;
> +		break;
> +
> +	case  mmMC_SEQ_G5PDX_CMD0:
> +		*outReg =3D mmMC_SEQ_G5PDX_CMD0_LP;
> +		break;
> +
> +	case  mmMC_SEQ_G5PDX_CMD1:
> +		*outReg =3D mmMC_SEQ_G5PDX_CMD1_LP;
> +		break;
> +
> +	case  mmMC_SEQ_G5PDX_CTRL:
> +		*outReg =3D mmMC_SEQ_G5PDX_CTRL_LP;
> +		break;
> +
> +	case mmMC_SEQ_CAS_TIMING:
> +		*outReg =3D mmMC_SEQ_CAS_TIMING_LP;
> +		break;
> +
> +	case mmMC_SEQ_MISC_TIMING:
> +		*outReg =3D mmMC_SEQ_MISC_TIMING_LP;
> +		break;
> +
> +	case mmMC_SEQ_MISC_TIMING2:
> +		*outReg =3D mmMC_SEQ_MISC_TIMING2_LP;
> +		break;
> +
> +	case mmMC_SEQ_PMG_DVS_CMD:
> +		*outReg =3D mmMC_SEQ_PMG_DVS_CMD_LP;
> +		break;
> +
> +	case mmMC_SEQ_PMG_DVS_CTL:
> +		*outReg =3D mmMC_SEQ_PMG_DVS_CTL_LP;
> +		break;
> +
> +	case mmMC_SEQ_RD_CTL_D0:
> +		*outReg =3D mmMC_SEQ_RD_CTL_D0_LP;
> +		break;
> +
> +	case mmMC_SEQ_RD_CTL_D1:
> +		*outReg =3D mmMC_SEQ_RD_CTL_D1_LP;
> +		break;
> +
> +	case mmMC_SEQ_WR_CTL_D0:
> +		*outReg =3D mmMC_SEQ_WR_CTL_D0_LP;
> +		break;
> +
> +	case mmMC_SEQ_WR_CTL_D1:
> +		*outReg =3D mmMC_SEQ_WR_CTL_D1_LP;
> +		break;
> +
> +	case mmMC_PMG_CMD_EMRS:
> +		*outReg =3D mmMC_SEQ_PMG_CMD_EMRS_LP;
> +		break;
> +
> +	case mmMC_PMG_CMD_MRS:
> +		*outReg =3D mmMC_SEQ_PMG_CMD_MRS_LP;
> +		break;
> +
> +	case mmMC_PMG_CMD_MRS1:
> +		*outReg =3D mmMC_SEQ_PMG_CMD_MRS1_LP;
> +		break;
> +
> +	case mmMC_SEQ_PMG_TIMING:
> +		*outReg =3D mmMC_SEQ_PMG_TIMING_LP;
> +		break;
> +
> +	case mmMC_PMG_CMD_MRS2:
> +		*outReg =3D mmMC_SEQ_PMG_CMD_MRS2_LP;
> +		break;
> +
> +	case mmMC_SEQ_WR_CTL_2:
> +		*outReg =3D mmMC_SEQ_WR_CTL_2_LP;
> +		break;
> +
> +	default:
> +		result =3D false;
> +		break;
> +	}
> +
> +	return result;
> +}
> +
> +int iceland_set_s0_mc_reg_index(phw_iceland_mc_reg_table *table)
> +{
> +	uint32_t i;
> +	uint16_t address;
> +
> +	for (i =3D 0; i < table->last; i++) {
> +		table->mc_reg_address[i].s0 =3D
> +			iceland_check_s0_mc_reg_index(table->mc_reg_address[i].s1, &address=
)
> +			? address : table->mc_reg_address[i].s1;
> +	}
> +	return 0;
> +}
> +
> +int iceland_copy_vbios_smc_reg_table(const pp_atomctrl_mc_reg_table *t=
able, phw_iceland_mc_reg_table *ni_table)
> +{
> +	uint8_t i, j;
> +
> +	PP_ASSERT_WITH_CODE((table->last <=3D SMU71_DISCRETE_MC_REGISTER_ARRA=
Y_SIZE),
> +		"Invalid VramInfo table.", return -1);
> +	PP_ASSERT_WITH_CODE((table->num_entries <=3D MAX_AC_TIMING_ENTRIES),
> +		"Invalid VramInfo table.", return -1);
> +
> +	for (i =3D 0; i < table->last; i++) {
> +		ni_table->mc_reg_address[i].s1 =3D table->mc_reg_address[i].s1;
> +	}
> +	ni_table->last =3D table->last;
> +
> +	for (i =3D 0; i < table->num_entries; i++) {
> +		ni_table->mc_reg_table_entry[i].mclk_max =3D
> +			table->mc_reg_table_entry[i].mclk_max;
> +		for (j =3D 0; j < table->last; j++) {
> +			ni_table->mc_reg_table_entry[i].mc_data[j] =3D
> +				table->mc_reg_table_entry[i].mc_data[j];
> +		}
> +	}
> +
> +	ni_table->num_entries =3D table->num_entries;
> +
> +	return 0;
> +}
> +
> +/**
> + * VBIOS omits some information to reduce size, we need to recover the=
m here.
> + * 1.   when we see mmMC_SEQ_MISC1, bit[31:16] EMRS1, need to be write=
 to  mmMC_PMG_CMD_EMRS /_LP[15:0].
> + *      Bit[15:0] MRS, need to be update mmMC_PMG_CMD_MRS/_LP[15:0]
> + * 2.   when we see mmMC_SEQ_RESERVE_M, bit[15:0] EMRS2, need to be wr=
ite to mmMC_PMG_CMD_MRS1/_LP[15:0].
> + * 3.   need to set these data for each clock range
> + *
> + * @param    hwmgr the address of the powerplay hardware manager.
> + * @param    table the address of MCRegTable
> + * @return   always 0
> + */
> +static int iceland_set_mc_special_registers(struct pp_hwmgr *hwmgr, ph=
w_iceland_mc_reg_table *table)
> +{
> +	uint8_t i, j, k;
> +	uint32_t temp_reg;
> +	const iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backend=
);
> +
> +	for (i =3D 0, j =3D table->last; i < table->last; i++) {
> +		PP_ASSERT_WITH_CODE((j < SMU71_DISCRETE_MC_REGISTER_ARRAY_SIZE),
> +			"Invalid VramInfo table.", return -1);
> +		switch (table->mc_reg_address[i].s1) {
> +		/*
> +		 * mmMC_SEQ_MISC1, bit[31:16] EMRS1, need to be write
> +		 * to mmMC_PMG_CMD_EMRS/_LP[15:0]. Bit[15:0] MRS, need
> +		 * to be update mmMC_PMG_CMD_MRS/_LP[15:0]
> +		 */
> +		case mmMC_SEQ_MISC1:
> +			temp_reg =3D cgs_read_register(hwmgr->device, mmMC_PMG_CMD_EMRS);
> +			table->mc_reg_address[j].s1 =3D mmMC_PMG_CMD_EMRS;
> +			table->mc_reg_address[j].s0 =3D mmMC_SEQ_PMG_CMD_EMRS_LP;
> +			for (k =3D 0; k < table->num_entries; k++) {
> +				table->mc_reg_table_entry[k].mc_data[j] =3D
> +					((temp_reg & 0xffff0000)) |
> +					((table->mc_reg_table_entry[k].mc_data[i] & 0xffff0000) >> 16);
> +			}
> +			j++;
> +			PP_ASSERT_WITH_CODE((j < SMU71_DISCRETE_MC_REGISTER_ARRAY_SIZE),
> +				"Invalid VramInfo table.", return -1);
> +
> +			temp_reg =3D cgs_read_register(hwmgr->device, mmMC_PMG_CMD_MRS);
> +			table->mc_reg_address[j].s1 =3D mmMC_PMG_CMD_MRS;
> +			table->mc_reg_address[j].s0 =3D mmMC_SEQ_PMG_CMD_MRS_LP;
> +			for (k =3D 0; k < table->num_entries; k++) {
> +				table->mc_reg_table_entry[k].mc_data[j] =3D
> +					(temp_reg & 0xffff0000) |
> +					(table->mc_reg_table_entry[k].mc_data[i] & 0x0000ffff);
> +
> +				if (!data->is_memory_GDDR5) {
> +					table->mc_reg_table_entry[k].mc_data[j] |=3D 0x100;
> +				}
> +			}
> +			j++;
> +			PP_ASSERT_WITH_CODE((j <=3D SMU71_DISCRETE_MC_REGISTER_ARRAY_SIZE),=

> +				"Invalid VramInfo table.", return -1);
> +
> +			if (!data->is_memory_GDDR5) {
> +				table->mc_reg_address[j].s1 =3D mmMC_PMG_AUTO_CMD;
> +				table->mc_reg_address[j].s0 =3D mmMC_PMG_AUTO_CMD;
> +				for (k =3D 0; k < table->num_entries; k++) {
> +					table->mc_reg_table_entry[k].mc_data[j] =3D
> +						(table->mc_reg_table_entry[k].mc_data[i] & 0xffff0000) >> 16;
> +				}
> +				j++;
> +				PP_ASSERT_WITH_CODE((j <=3D SMU71_DISCRETE_MC_REGISTER_ARRAY_SIZE)=
,
> +					"Invalid VramInfo table.", return -1);
> +			}
> +
> +			break;
> +
> +		case mmMC_SEQ_RESERVE_M:
> +			temp_reg =3D cgs_read_register(hwmgr->device, mmMC_PMG_CMD_MRS1);
> +			table->mc_reg_address[j].s1 =3D mmMC_PMG_CMD_MRS1;
> +			table->mc_reg_address[j].s0 =3D mmMC_SEQ_PMG_CMD_MRS1_LP;
> +			for (k =3D 0; k < table->num_entries; k++) {
> +				table->mc_reg_table_entry[k].mc_data[j] =3D
> +					(temp_reg & 0xffff0000) |
> +					(table->mc_reg_table_entry[k].mc_data[i] & 0x0000ffff);
> +			}
> +			j++;
> +			PP_ASSERT_WITH_CODE((j <=3D SMU71_DISCRETE_MC_REGISTER_ARRAY_SIZE),=

> +				"Invalid VramInfo table.", return -1);
> +			break;
> +
> +		default:
> +			break;
> +		}
> +
> +	}
> +
> +	table->last =3D j;
> +
> +	return 0;
> +}
> +
> +
> +static int iceland_set_valid_flag(phw_iceland_mc_reg_table *table)
> +{
> +	uint8_t i, j;
> +	for (i =3D 0; i < table->last; i++) {
> +		for (j =3D 1; j < table->num_entries; j++) {
> +			if (table->mc_reg_table_entry[j-1].mc_data[i] !=3D
> +				table->mc_reg_table_entry[j].mc_data[i]) {
> +				table->validflag |=3D (1<<i);
> +				break;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int iceland_initialize_mc_reg_table(struct pp_hwmgr *hwmgr)
> +{
> +	int result;
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +	pp_atomctrl_mc_reg_table *table;
> +	phw_iceland_mc_reg_table *ni_table =3D &data->iceland_mc_reg_table;
> +	uint8_t module_index =3D iceland_get_memory_module_index(hwmgr);
> +
> +	table =3D kzalloc(sizeof(pp_atomctrl_mc_reg_table), GFP_KERNEL);
> +
> +	if (NULL =3D=3D table)
> +		return -ENOMEM;
> +
> +	/* Program additional LP registers that are no longer programmed by V=
BIOS */
> +	cgs_write_register(hwmgr->device, mmMC_SEQ_RAS_TIMING_LP, cgs_read_re=
gister(hwmgr->device, mmMC_SEQ_RAS_TIMING));
> +	cgs_write_register(hwmgr->device, mmMC_SEQ_CAS_TIMING_LP, cgs_read_re=
gister(hwmgr->device, mmMC_SEQ_CAS_TIMING));
> +	cgs_write_register(hwmgr->device, mmMC_SEQ_DLL_STBY_LP, cgs_read_regi=
ster(hwmgr->device, mmMC_SEQ_DLL_STBY));
> +	cgs_write_register(hwmgr->device, mmMC_SEQ_G5PDX_CMD0_LP, cgs_read_re=
gister(hwmgr->device, mmMC_SEQ_G5PDX_CMD0));
> +	cgs_write_register(hwmgr->device, mmMC_SEQ_G5PDX_CMD1_LP, cgs_read_re=
gister(hwmgr->device, mmMC_SEQ_G5PDX_CMD1));
> +	cgs_write_register(hwmgr->device, mmMC_SEQ_G5PDX_CTRL_LP, cgs_read_re=
gister(hwmgr->device, mmMC_SEQ_G5PDX_CTRL));
> +	cgs_write_register(hwmgr->device, mmMC_SEQ_PMG_DVS_CMD_LP, cgs_read_r=
egister(hwmgr->device, mmMC_SEQ_PMG_DVS_CMD));
> +	cgs_write_register(hwmgr->device, mmMC_SEQ_PMG_DVS_CTL_LP, cgs_read_r=
egister(hwmgr->device, mmMC_SEQ_PMG_DVS_CTL));
> +	cgs_write_register(hwmgr->device, mmMC_SEQ_MISC_TIMING_LP, cgs_read_r=
egister(hwmgr->device, mmMC_SEQ_MISC_TIMING));
> +	cgs_write_register(hwmgr->device, mmMC_SEQ_MISC_TIMING2_LP, cgs_read_=
register(hwmgr->device, mmMC_SEQ_MISC_TIMING2));
> +	cgs_write_register(hwmgr->device, mmMC_SEQ_PMG_CMD_EMRS_LP, cgs_read_=
register(hwmgr->device, mmMC_PMG_CMD_EMRS));
> +	cgs_write_register(hwmgr->device, mmMC_SEQ_PMG_CMD_MRS_LP, cgs_read_r=
egister(hwmgr->device, mmMC_PMG_CMD_MRS));
> +	cgs_write_register(hwmgr->device, mmMC_SEQ_PMG_CMD_MRS1_LP, cgs_read_=
register(hwmgr->device, mmMC_PMG_CMD_MRS1));
> +	cgs_write_register(hwmgr->device, mmMC_SEQ_WR_CTL_D0_LP, cgs_read_reg=
ister(hwmgr->device, mmMC_SEQ_WR_CTL_D0));
> +	cgs_write_register(hwmgr->device, mmMC_SEQ_WR_CTL_D1_LP, cgs_read_reg=
ister(hwmgr->device, mmMC_SEQ_WR_CTL_D1));
> +	cgs_write_register(hwmgr->device, mmMC_SEQ_RD_CTL_D0_LP, cgs_read_reg=
ister(hwmgr->device, mmMC_SEQ_RD_CTL_D0));
> +	cgs_write_register(hwmgr->device, mmMC_SEQ_RD_CTL_D1_LP, cgs_read_reg=
ister(hwmgr->device, mmMC_SEQ_RD_CTL_D1));
> +	cgs_write_register(hwmgr->device, mmMC_SEQ_PMG_TIMING_LP, cgs_read_re=
gister(hwmgr->device, mmMC_SEQ_PMG_TIMING));
> +	cgs_write_register(hwmgr->device, mmMC_SEQ_PMG_CMD_MRS2_LP, cgs_read_=
register(hwmgr->device, mmMC_PMG_CMD_MRS2));
> +	cgs_write_register(hwmgr->device, mmMC_SEQ_WR_CTL_2_LP, cgs_read_regi=
ster(hwmgr->device, mmMC_SEQ_WR_CTL_2));
> +
> +	memset(table, 0x00, sizeof(pp_atomctrl_mc_reg_table));
> +
> +	result =3D atomctrl_initialize_mc_reg_table(hwmgr, module_index, tabl=
e);
> +
> +	if (0 =3D=3D result)
> +		result =3D iceland_copy_vbios_smc_reg_table(table, ni_table);
> +
> +	if (0 =3D=3D result) {
> +		iceland_set_s0_mc_reg_index(ni_table);
> +		result =3D iceland_set_mc_special_registers(hwmgr, ni_table);
> +	}
> +
> +	if (0 =3D=3D result)
> +		iceland_set_valid_flag(ni_table);
> +
> +	kfree(table);
> +	return result;
> +}
> +
> +/**
> + * Programs static screed detection parameters
> + *
> + * @param   hwmgr  the address of the powerplay hardware manager.
> + * @return   always 0
> + */
> +int iceland_program_static_screen_threshold_parameters(struct pp_hwmgr=
 *hwmgr)
> +{
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +
> +	/* Set static screen threshold unit*/
> +	PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device,
> +		CGS_IND_REG__SMC, CG_STATIC_SCREEN_PARAMETER, STATIC_SCREEN_THRESHOL=
D_UNIT,
> +		data->static_screen_threshold_unit);
> +	/* Set static screen threshold*/
> +	PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device,
> +		CGS_IND_REG__SMC, CG_STATIC_SCREEN_PARAMETER, STATIC_SCREEN_THRESHOL=
D,
> +		data->static_screen_threshold);
> +
> +	return 0;
> +}
> +
> +/**
> + * Setup display gap for glitch free memory clock switching.
> + *
> + * @param    hwmgr  the address of the powerplay hardware manager.
> + * @return   always 0
> + */
> +int iceland_enable_display_gap(struct pp_hwmgr *hwmgr)
> +{
> +	uint32_t display_gap =3D cgs_read_ind_register(hwmgr->device,
> +							CGS_IND_REG__SMC, ixCG_DISPLAY_GAP_CNTL);
> +
> +	display_gap =3D PHM_SET_FIELD(display_gap,
> +					CG_DISPLAY_GAP_CNTL, DISP_GAP, DISPLAY_GAP_IGNORE);
> +
> +	display_gap =3D PHM_SET_FIELD(display_gap,
> +					CG_DISPLAY_GAP_CNTL, DISP_GAP_MCHG, DISPLAY_GAP_VBLANK);
> +
> +	cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC,
> +		ixCG_DISPLAY_GAP_CNTL, display_gap);
> +
> +	return 0;
> +}
> +
> +/**
> + * Programs activity state transition voting clients
> + *
> + * @param    hwmgr  the address of the powerplay hardware manager.
> + * @return   always 0
> + */
> +int iceland_program_voting_clients(struct pp_hwmgr *hwmgr)
> +{
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +
> +	/* Clear reset for voting clients before enabling DPM */
> +	PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC,
> +		SCLK_PWRMGT_CNTL, RESET_SCLK_CNT, 0);
> +	PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC,
> +		SCLK_PWRMGT_CNTL, RESET_BUSY_CNT, 0);
> +
> +	cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC,
> +		ixCG_FREQ_TRAN_VOTING_0, data->voting_rights_clients0);
> +	cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC,
> +		ixCG_FREQ_TRAN_VOTING_1, data->voting_rights_clients1);
> +	cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC,
> +		ixCG_FREQ_TRAN_VOTING_2, data->voting_rights_clients2);
> +	cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC,
> +		ixCG_FREQ_TRAN_VOTING_3, data->voting_rights_clients3);
> +	cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC,
> +		ixCG_FREQ_TRAN_VOTING_4, data->voting_rights_clients4);
> +	cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC,
> +		ixCG_FREQ_TRAN_VOTING_5, data->voting_rights_clients5);
> +	cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC,
> +		ixCG_FREQ_TRAN_VOTING_6, data->voting_rights_clients6);
> +	cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC,
> +		ixCG_FREQ_TRAN_VOTING_7, data->voting_rights_clients7);
> +
> +	return 0;
> +}
> +
> +static int iceland_upload_firmware(struct pp_hwmgr *hwmgr)
> +{
> +	int ret =3D 0;
> +
> +	if (!iceland_is_smc_ram_running(hwmgr->smumgr))
> +		ret =3D iceland_smu_upload_firmware_image(hwmgr->smumgr);
> +
> +	return ret;
> +}
> +
> +/**
> + * Get the location of various tables inside the FW image.
> + *
> + * @param    hwmgr  the address of the powerplay hardware manager.
> + * @return   always 0
> + */
> +int iceland_process_firmware_header(struct pp_hwmgr *hwmgr)
> +{
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +
> +	uint32_t tmp;
> +	int result;
> +	bool error =3D 0;
> +
> +	result =3D iceland_read_smc_sram_dword(hwmgr->smumgr,
> +				SMU71_FIRMWARE_HEADER_LOCATION +
> +				offsetof(SMU71_Firmware_Header, DpmTable),
> +				&tmp, data->sram_end);
> +
> +	if (0 =3D=3D result) {
> +		data->dpm_table_start =3D tmp;
> +	}
> +
> +	error |=3D (0 !=3D result);
> +
> +	result =3D iceland_read_smc_sram_dword(hwmgr->smumgr,
> +				SMU71_FIRMWARE_HEADER_LOCATION +
> +				offsetof(SMU71_Firmware_Header, SoftRegisters),
> +				&tmp, data->sram_end);
> +
> +	if (0 =3D=3D result) {
> +		data->soft_regs_start =3D tmp;
> +	}
> +
> +	error |=3D (0 !=3D result);
> +
> +
> +	result =3D iceland_read_smc_sram_dword(hwmgr->smumgr,
> +				SMU71_FIRMWARE_HEADER_LOCATION +
> +				offsetof(SMU71_Firmware_Header, mcRegisterTable),
> +				&tmp, data->sram_end);
> +
> +	if (0 =3D=3D result) {
> +		data->mc_reg_table_start =3D tmp;
> +	}
> +
> +	result =3D iceland_read_smc_sram_dword(hwmgr->smumgr,
> +				SMU71_FIRMWARE_HEADER_LOCATION +
> +				offsetof(SMU71_Firmware_Header, FanTable),
> +				&tmp, data->sram_end);
> +
> +	if (0 =3D=3D result) {
> +		data->fan_table_start =3D tmp;
> +	}
> +
> +	error |=3D (0 !=3D result);
> +
> +	result =3D iceland_read_smc_sram_dword(hwmgr->smumgr,
> +				SMU71_FIRMWARE_HEADER_LOCATION +
> +				offsetof(SMU71_Firmware_Header, mcArbDramTimingTable),
> +				&tmp, data->sram_end);
> +
> +	if (0 =3D=3D result) {
> +		data->arb_table_start =3D tmp;
> +	}
> +
> +	error |=3D (0 !=3D result);
> +
> +
> +	result =3D iceland_read_smc_sram_dword(hwmgr->smumgr,
> +				SMU71_FIRMWARE_HEADER_LOCATION +
> +				offsetof(SMU71_Firmware_Header, Version),
> +				&tmp, data->sram_end);
> +
> +	if (0 =3D=3D result) {
> +		hwmgr->microcode_version_info.SMC =3D tmp;
> +	}
> +
> +	error |=3D (0 !=3D result);
> +
> +	result =3D iceland_read_smc_sram_dword(hwmgr->smumgr,
> +				SMU71_FIRMWARE_HEADER_LOCATION +
> +				offsetof(SMU71_Firmware_Header, UlvSettings),
> +				&tmp, data->sram_end);
> +
> +	if (0 =3D=3D result) {
> +		data->ulv_settings_start =3D tmp;
> +	}
> +
> +	error |=3D (0 !=3D result);
> +
> +	return error ? 1 : 0;
> +}
> +
> +/*
> +* Copy one arb setting to another and then switch the active set.
> +* arbFreqSrc and arbFreqDest is one of the MC_CG_ARB_FREQ_Fx constants=
=2E
> +*/
> +int iceland_copy_and_switch_arb_sets(struct pp_hwmgr *hwmgr,
> +		uint32_t arbFreqSrc, uint32_t arbFreqDest)
> +{
> +	uint32_t mc_arb_dram_timing;
> +	uint32_t mc_arb_dram_timing2;
> +	uint32_t burst_time;
> +	uint32_t mc_cg_config;
> +
> +	switch (arbFreqSrc) {
> +	case MC_CG_ARB_FREQ_F0:
> +		mc_arb_dram_timing  =3D cgs_read_register(hwmgr->device, mmMC_ARB_DR=
AM_TIMING);
> +		mc_arb_dram_timing2 =3D cgs_read_register(hwmgr->device, mmMC_ARB_DR=
AM_TIMING2);
> +		burst_time =3D PHM_READ_FIELD(hwmgr->device, MC_ARB_BURST_TIME, STAT=
E0);
> +		break;
> +
> +	case MC_CG_ARB_FREQ_F1:
> +		mc_arb_dram_timing  =3D cgs_read_register(hwmgr->device, mmMC_ARB_DR=
AM_TIMING_1);
> +		mc_arb_dram_timing2 =3D cgs_read_register(hwmgr->device, mmMC_ARB_DR=
AM_TIMING2_1);
> +		burst_time =3D PHM_READ_FIELD(hwmgr->device, MC_ARB_BURST_TIME, STAT=
E1);
> +		break;
> +
> +	default:
> +		return -1;
> +	}
> +
> +	switch (arbFreqDest) {
> +	case MC_CG_ARB_FREQ_F0:
> +		cgs_write_register(hwmgr->device, mmMC_ARB_DRAM_TIMING, mc_arb_dram_=
timing);
> +		cgs_write_register(hwmgr->device, mmMC_ARB_DRAM_TIMING2, mc_arb_dram=
_timing2);
> +		PHM_WRITE_FIELD(hwmgr->device, MC_ARB_BURST_TIME, STATE0, burst_time=
);
> +		break;
> +
> +	case MC_CG_ARB_FREQ_F1:
> +		cgs_write_register(hwmgr->device, mmMC_ARB_DRAM_TIMING_1, mc_arb_dra=
m_timing);
> +		cgs_write_register(hwmgr->device, mmMC_ARB_DRAM_TIMING2_1, mc_arb_dr=
am_timing2);
> +		PHM_WRITE_FIELD(hwmgr->device, MC_ARB_BURST_TIME, STATE1, burst_time=
);
> +		break;
> +
> +	default:
> +		return -1;
> +	}
> +
> +	mc_cg_config =3D cgs_read_register(hwmgr->device, mmMC_CG_CONFIG);
> +	mc_cg_config |=3D 0x0000000F;
> +	cgs_write_register(hwmgr->device, mmMC_CG_CONFIG, mc_cg_config);
> +	PHM_WRITE_FIELD(hwmgr->device, MC_ARB_CG, CG_ARB_REQ, arbFreqDest);
> +
> +	return 0;
> +}
> +
> +/**
> + * Initial switch from ARB F0->F1
> + *
> + * @param    hwmgr  the address of the powerplay hardware manager.
> + * @return   always 0
> + * This function is to be called from the SetPowerState table.
> + */
> +int iceland_initial_switch_from_arb_f0_to_f1(struct pp_hwmgr *hwmgr)
> +{
> +	return iceland_copy_and_switch_arb_sets(hwmgr, MC_CG_ARB_FREQ_F0, MC_=
CG_ARB_FREQ_F1);
> +}
> +
> +/* ---------------------------------------- ULV related functions ----=
------------------------------------------------*/
> +
> +
> +static int iceland_reset_single_dpm_table(
> +	struct pp_hwmgr *hwmgr,
> +	struct iceland_single_dpm_table *dpm_table,
> +	uint32_t count)
> +{
> +	uint32_t i;
> +	if (!(count <=3D MAX_REGULAR_DPM_NUMBER))
> +		printk(KERN_ERR "[ powerplay ] Fatal error, can not set up single DP=
M \
> +			table entries to exceed max number! \n");
> +
> +	dpm_table->count =3D count;
> +	for (i =3D 0; i < MAX_REGULAR_DPM_NUMBER; i++) {
> +		dpm_table->dpm_levels[i].enabled =3D 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static void iceland_setup_pcie_table_entry(
> +	struct iceland_single_dpm_table *dpm_table,
> +	uint32_t index, uint32_t pcie_gen,
> +	uint32_t pcie_lanes)
> +{
> +	dpm_table->dpm_levels[index].value =3D pcie_gen;
> +	dpm_table->dpm_levels[index].param1 =3D pcie_lanes;
> +	dpm_table->dpm_levels[index].enabled =3D 1;
> +}
> +
> +/*
> + * Set up the PCIe DPM table as follows:
> + *
> + * A  =3D Performance State, Max, Gen Speed
> + * C  =3D Performance State, Min, Gen Speed
> + * 1  =3D Performance State, Max, Lane #
> + * 3  =3D Performance State, Min, Lane #
> + *
> + * B  =3D Power Saving State, Max, Gen Speed
> + * D  =3D Power Saving State, Min, Gen Speed
> + * 2  =3D Power Saving State, Max, Lane #
> + * 4  =3D Power Saving State, Min, Lane #
> + *
> + *
> + * DPM Index   Gen Speed   Lane #
> + * 5           A           1
> + * 4           B           2
> + * 3           C           1
> + * 2           D           2
> + * 1           C           3
> + * 0           D           4
> + *
> + */
> +static int iceland_setup_default_pcie_tables(struct pp_hwmgr *hwmgr)
> +{
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +
> +	PP_ASSERT_WITH_CODE((data->use_pcie_performance_levels ||
> +				data->use_pcie_power_saving_levels),
> +			"No pcie performance levels!", return -EINVAL);
> +
> +	if (data->use_pcie_performance_levels && !data->use_pcie_power_saving=
_levels) {
> +		data->pcie_gen_power_saving =3D data->pcie_gen_performance;
> +		data->pcie_lane_power_saving =3D data->pcie_lane_performance;
> +	} else if (!data->use_pcie_performance_levels && data->use_pcie_power=
_saving_levels) {
> +		data->pcie_gen_performance =3D data->pcie_gen_power_saving;
> +		data->pcie_lane_performance =3D data->pcie_lane_power_saving;
> +	}
> +
> +	iceland_reset_single_dpm_table(hwmgr, &data->dpm_table.pcie_speed_tab=
le, SMU71_MAX_LEVELS_LINK);
> +
> +	/* Hardcode Pcie Table */
> +	iceland_setup_pcie_table_entry(&data->dpm_table.pcie_speed_table, 0,
> +		get_pcie_gen_support(data->pcie_gen_cap, PP_Min_PCIEGen),
> +		get_pcie_lane_support(data->pcie_lane_cap, PP_Max_PCIELane));
> +	iceland_setup_pcie_table_entry(&data->dpm_table.pcie_speed_table, 1,
> +		get_pcie_gen_support(data->pcie_gen_cap, PP_Min_PCIEGen),
> +		get_pcie_lane_support(data->pcie_lane_cap, PP_Max_PCIELane));
> +	iceland_setup_pcie_table_entry(&data->dpm_table.pcie_speed_table, 2,
> +		get_pcie_gen_support(data->pcie_gen_cap, PP_Max_PCIEGen),
> +		get_pcie_lane_support(data->pcie_lane_cap, PP_Max_PCIELane));
> +	iceland_setup_pcie_table_entry(&data->dpm_table.pcie_speed_table, 3,
> +		get_pcie_gen_support(data->pcie_gen_cap, PP_Max_PCIEGen),
> +		get_pcie_lane_support(data->pcie_lane_cap, PP_Max_PCIELane));
> +	iceland_setup_pcie_table_entry(&data->dpm_table.pcie_speed_table, 4,
> +		get_pcie_gen_support(data->pcie_gen_cap, PP_Max_PCIEGen),
> +		get_pcie_lane_support(data->pcie_lane_cap, PP_Max_PCIELane));
> +	iceland_setup_pcie_table_entry(&data->dpm_table.pcie_speed_table, 5,
> +		get_pcie_gen_support(data->pcie_gen_cap, PP_Max_PCIEGen),
> +		get_pcie_lane_support(data->pcie_lane_cap, PP_Max_PCIELane));
> +	data->dpm_table.pcie_speed_table.count =3D 6;
> +
> +	return 0;
> +
> +}
> +
> +
> +/*
> + * This function is to initalize all DPM state tables for SMU7 based o=
n the dependency table.
> + * Dynamic state patching function will then trim these state tables t=
o the allowed range based
> + * on the power policy or external client requests, such as UVD reques=
t, etc.
> + */
> +static int iceland_setup_default_dpm_tables(struct pp_hwmgr *hwmgr)
> +{
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +	uint32_t i;
> +
> +	struct phm_clock_voltage_dependency_table *allowed_vdd_sclk_table =3D=

> +		hwmgr->dyn_state.vddc_dependency_on_sclk;
> +	struct phm_clock_voltage_dependency_table *allowed_vdd_mclk_table =3D=

> +		hwmgr->dyn_state.vddc_dependency_on_mclk;
> +	struct phm_cac_leakage_table *std_voltage_table =3D
> +		hwmgr->dyn_state.cac_leakage_table;
> +
> +	PP_ASSERT_WITH_CODE(allowed_vdd_sclk_table !=3D NULL,
> +		"SCLK dependency table is missing. This table is mandatory", return =
-1);
> +	PP_ASSERT_WITH_CODE(allowed_vdd_sclk_table->count >=3D 1,
> +		"SCLK dependency table has to have is missing. This table is mandato=
ry", return -1);
> +
> +	PP_ASSERT_WITH_CODE(allowed_vdd_mclk_table !=3D NULL,
> +		"MCLK dependency table is missing. This table is mandatory", return =
-1);
> +	PP_ASSERT_WITH_CODE(allowed_vdd_mclk_table->count >=3D 1,
> +		"VMCLK dependency table has to have is missing. This table is mandat=
ory", return -1);
> +
> +	/* clear the state table to reset everything to default */
> +	memset(&(data->dpm_table), 0x00, sizeof(data->dpm_table));
> +	iceland_reset_single_dpm_table(hwmgr, &data->dpm_table.sclk_table, SM=
U71_MAX_LEVELS_GRAPHICS);
> +	iceland_reset_single_dpm_table(hwmgr, &data->dpm_table.mclk_table, SM=
U71_MAX_LEVELS_MEMORY);
> +	iceland_reset_single_dpm_table(hwmgr, &data->dpm_table.vddc_table, SM=
U71_MAX_LEVELS_VDDC);
> +	iceland_reset_single_dpm_table(hwmgr, &data->dpm_table.vdd_ci_table, =
SMU71_MAX_LEVELS_VDDCI);
> +	iceland_reset_single_dpm_table(hwmgr, &data->dpm_table.mvdd_table, SM=
U71_MAX_LEVELS_MVDD);
> +
> +	PP_ASSERT_WITH_CODE(allowed_vdd_sclk_table !=3D NULL,
> +		"SCLK dependency table is missing. This table is mandatory", return =
-1);
> +	/* Initialize Sclk DPM table based on allow Sclk values*/
> +	data->dpm_table.sclk_table.count =3D 0;
> +
> +	for (i =3D 0; i < allowed_vdd_sclk_table->count; i++) {
> +		if (i =3D=3D 0 || data->dpm_table.sclk_table.dpm_levels[data->dpm_ta=
ble.sclk_table.count-1].value !=3D
> +				allowed_vdd_sclk_table->entries[i].clk) {
> +			data->dpm_table.sclk_table.dpm_levels[data->dpm_table.sclk_table.co=
unt].value =3D
> +				allowed_vdd_sclk_table->entries[i].clk;
> +			data->dpm_table.sclk_table.dpm_levels[data->dpm_table.sclk_table.co=
unt].enabled =3D 1; /*(i=3D=3D0) ? 1 : 0; to do */
> +			data->dpm_table.sclk_table.count++;
> +		}
> +	}
> +
> +	PP_ASSERT_WITH_CODE(allowed_vdd_mclk_table !=3D NULL,
> +		"MCLK dependency table is missing. This table is mandatory", return =
-1);
> +	/* Initialize Mclk DPM table based on allow Mclk values */
> +	data->dpm_table.mclk_table.count =3D 0;
> +	for (i =3D 0; i < allowed_vdd_mclk_table->count; i++) {
> +		if (i =3D=3D 0 || data->dpm_table.mclk_table.dpm_levels[data->dpm_ta=
ble.mclk_table.count-1].value !=3D
> +			allowed_vdd_mclk_table->entries[i].clk) {
> +			data->dpm_table.mclk_table.dpm_levels[data->dpm_table.mclk_table.co=
unt].value =3D
> +				allowed_vdd_mclk_table->entries[i].clk;
> +			data->dpm_table.mclk_table.dpm_levels[data->dpm_table.mclk_table.co=
unt].enabled =3D 1; /*(i=3D=3D0) ? 1 : 0; */
> +			data->dpm_table.mclk_table.count++;
> +		}
> +	}
> +
> +	/* Initialize Vddc DPM table based on allow Vddc values.  And populat=
e corresponding std values. */
> +	for (i =3D 0; i < allowed_vdd_sclk_table->count; i++) {
> +		data->dpm_table.vddc_table.dpm_levels[i].value =3D allowed_vdd_mclk_=
table->entries[i].v;
> +		data->dpm_table.vddc_table.dpm_levels[i].param1 =3D std_voltage_tabl=
e->entries[i].Leakage;
> +		/* param1 is for corresponding std voltage */
> +		data->dpm_table.vddc_table.dpm_levels[i].enabled =3D 1;
> +	}
> +
> +	data->dpm_table.vddc_table.count =3D allowed_vdd_sclk_table->count;
> +	allowed_vdd_mclk_table =3D hwmgr->dyn_state.vddci_dependency_on_mclk;=

> +
> +	if (NULL !=3D allowed_vdd_mclk_table) {
> +		/* Initialize Vddci DPM table based on allow Mclk values */
> +		for (i =3D 0; i < allowed_vdd_mclk_table->count; i++) {
> +			data->dpm_table.vdd_ci_table.dpm_levels[i].value =3D allowed_vdd_mc=
lk_table->entries[i].v;
> +			data->dpm_table.vdd_ci_table.dpm_levels[i].enabled =3D 1;
> +		}
> +		data->dpm_table.vdd_ci_table.count =3D allowed_vdd_mclk_table->count=
;
> +	}
> +
> +	allowed_vdd_mclk_table =3D hwmgr->dyn_state.mvdd_dependency_on_mclk;
> +
> +	if (NULL !=3D allowed_vdd_mclk_table) {
> +		/*
> +		 * Initialize MVDD DPM table based on allow Mclk
> +		 * values
> +		 */
> +		for (i =3D 0; i < allowed_vdd_mclk_table->count; i++) {
> +			data->dpm_table.mvdd_table.dpm_levels[i].value =3D allowed_vdd_mclk=
_table->entries[i].v;
> +			data->dpm_table.mvdd_table.dpm_levels[i].enabled =3D 1;
> +		}
> +		data->dpm_table.mvdd_table.count =3D allowed_vdd_mclk_table->count;
> +	}
> +
> +	/* setup PCIE gen speed levels*/
> +	iceland_setup_default_pcie_tables(hwmgr);
> +
> +	/* save a copy of the default DPM table*/
> +	memcpy(&(data->golden_dpm_table), &(data->dpm_table), sizeof(struct i=
celand_dpm_table));
> +
> +	return 0;
> +}
> +
> +/**
> + * @brief PhwIceland_GetVoltageOrder
> + *  Returns index of requested voltage record in lookup(table)
> + * @param hwmgr - pointer to hardware manager
> + * @param lookutab - lookup list to search in
> + * @param voltage - voltage to look for
> + * @return 0 on success
> + */
> +uint8_t iceland_get_voltage_index(phm_ppt_v1_voltage_lookup_table *loo=
k_up_table,
> +		uint16_t voltage)
> +{
> +	uint8_t count =3D (uint8_t) (look_up_table->count);
> +	uint8_t i;
> +
> +	PP_ASSERT_WITH_CODE((NULL !=3D look_up_table), "Lookup Table empty.",=
 return 0;);
> +	PP_ASSERT_WITH_CODE((0 !=3D count), "Lookup Table empty.", return 0;)=
;
> +
> +	for (i =3D 0; i < count; i++) {
> +		/* find first voltage equal or bigger than requested */
> +		if (look_up_table->entries[i].us_vdd >=3D voltage)
> +			return i;
> +	}
> +
> +	/* voltage is bigger than max voltage in the table */
> +	return i-1;
> +}
> +
> +
> +static int iceland_get_std_voltage_value_sidd(struct pp_hwmgr *hwmgr,
> +		pp_atomctrl_voltage_table_entry *tab, uint16_t *hi,
> +		uint16_t *lo)
> +{
> +	uint16_t v_index;
> +	bool vol_found =3D false;
> +	*hi =3D tab->value * VOLTAGE_SCALE;
> +	*lo =3D tab->value * VOLTAGE_SCALE;
> +
> +	/* SCLK/VDDC Dependency Table has to exist. */
> +	PP_ASSERT_WITH_CODE(NULL !=3D hwmgr->dyn_state.vddc_dependency_on_scl=
k,
> +	                    "The SCLK/VDDC Dependency Table does not exist.\n=
",
> +	                    return -EINVAL);
> +
> +	if (NULL =3D=3D hwmgr->dyn_state.cac_leakage_table) {
> +		pr_warning("CAC Leakage Table does not exist, using vddc.\n");
> +		return 0;
> +	}
> +
> +	/*
> +	 * Since voltage in the sclk/vddc dependency table is not
> +	 * necessarily in ascending order because of ELB voltage
> +	 * patching, loop through entire list to find exact voltage.
> +	 */
> +	for (v_index =3D 0; (uint32_t)v_index < hwmgr->dyn_state.vddc_depende=
ncy_on_sclk->count; v_index++) {
> +		if (tab->value =3D=3D hwmgr->dyn_state.vddc_dependency_on_sclk->entr=
ies[v_index].v) {
> +			vol_found =3D true;
> +			if ((uint32_t)v_index < hwmgr->dyn_state.cac_leakage_table->count) =
{
> +				*lo =3D hwmgr->dyn_state.cac_leakage_table->entries[v_index].Vddc =
* VOLTAGE_SCALE;
> +				*hi =3D (uint16_t)(hwmgr->dyn_state.cac_leakage_table->entries[v_i=
ndex].Leakage * VOLTAGE_SCALE);
> +			} else {
> +				pr_warning("Index from SCLK/VDDC Dependency Table exceeds the CAC =
Leakage Table index, using maximum index from CAC table.\n");
> +				*lo =3D hwmgr->dyn_state.cac_leakage_table->entries[hwmgr->dyn_sta=
te.cac_leakage_table->count - 1].Vddc * VOLTAGE_SCALE;
> +				*hi =3D (uint16_t)(hwmgr->dyn_state.cac_leakage_table->entries[hwm=
gr->dyn_state.cac_leakage_table->count - 1].Leakage * VOLTAGE_SCALE);
> +			}
> +			break;
> +		}
> +	}
> +
> +	/*
> +	 * If voltage is not found in the first pass, loop again to
> +	 * find the best match, equal or higher value.
> +	 */
> +	if (!vol_found) {
> +		for (v_index =3D 0; (uint32_t)v_index < hwmgr->dyn_state.vddc_depend=
ency_on_sclk->count; v_index++) {
> +			if (tab->value <=3D hwmgr->dyn_state.vddc_dependency_on_sclk->entri=
es[v_index].v) {
> +				vol_found =3D true;
> +				if ((uint32_t)v_index < hwmgr->dyn_state.cac_leakage_table->count)=
 {
> +					*lo =3D hwmgr->dyn_state.cac_leakage_table->entries[v_index].Vddc=
 * VOLTAGE_SCALE;
> +					*hi =3D (uint16_t)(hwmgr->dyn_state.cac_leakage_table->entries[v_=
index].Leakage) * VOLTAGE_SCALE;
> +				} else {
> +					pr_warning("Index from SCLK/VDDC Dependency Table exceeds the CAC=
 Leakage Table index in second look up, using maximum index from CAC tabl=
e.");
> +					*lo =3D hwmgr->dyn_state.cac_leakage_table->entries[hwmgr->dyn_st=
ate.cac_leakage_table->count - 1].Vddc * VOLTAGE_SCALE;
> +					*hi =3D (uint16_t)(hwmgr->dyn_state.cac_leakage_table->entries[hw=
mgr->dyn_state.cac_leakage_table->count - 1].Leakage * VOLTAGE_SCALE);
> +				}
> +				break;
> +			}
> +		}
> +
> +		if (!vol_found)
> +			pr_warning("Unable to get std_vddc from SCLK/VDDC Dependency Table,=
 using vddc.\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int iceland_populate_smc_voltage_table(struct pp_hwmgr *hwmgr,
> +		pp_atomctrl_voltage_table_entry *tab,
> +		SMU71_Discrete_VoltageLevel *smc_voltage_tab) {
> +	int result;
> +
> +
> +	result =3D iceland_get_std_voltage_value_sidd(hwmgr, tab,
> +			&smc_voltage_tab->StdVoltageHiSidd,
> +			&smc_voltage_tab->StdVoltageLoSidd);
> +	if (0 !=3D result) {
> +		smc_voltage_tab->StdVoltageHiSidd =3D tab->value * VOLTAGE_SCALE;
> +		smc_voltage_tab->StdVoltageLoSidd =3D tab->value * VOLTAGE_SCALE;
> +	}
> +
> +	smc_voltage_tab->Voltage =3D PP_HOST_TO_SMC_US(tab->value * VOLTAGE_S=
CALE);
> +	CONVERT_FROM_HOST_TO_SMC_US(smc_voltage_tab->StdVoltageHiSidd);
> +	CONVERT_FROM_HOST_TO_SMC_US(smc_voltage_tab->StdVoltageHiSidd);
> +
> +	return 0;
> +}
> +
> +/**
> + * Vddc table preparation for SMC.
> + *
> + * @param    hwmgr      the address of the hardware manager
> + * @param    table     the SMC DPM table structure to be populated
> + * @return   always 0
> + */
> +static int iceland_populate_smc_vddc_table(struct pp_hwmgr *hwmgr,
> +			SMU71_Discrete_DpmTable *table)
> +{
> +	unsigned int count;
> +	int result;
> +
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +
> +	table->VddcLevelCount =3D data->vddc_voltage_table.count;
> +	for (count =3D 0; count < table->VddcLevelCount; count++) {
> +		result =3D iceland_populate_smc_voltage_table(hwmgr,
> +				&data->vddc_voltage_table.entries[count],
> +				&table->VddcLevel[count]);
> +		PP_ASSERT_WITH_CODE(0 =3D=3D result, "do not populate SMC VDDC volta=
ge table", return -EINVAL);
> +
> +		/* GPIO voltage control */
> +		if (ICELAND_VOLTAGE_CONTROL_BY_GPIO =3D=3D data->voltage_control)
> +			table->VddcLevel[count].Smio |=3D data->vddc_voltage_table.entries[=
count].smio_low;
> +		else if (ICELAND_VOLTAGE_CONTROL_BY_SVID2 =3D=3D data->voltage_contr=
ol)
> +			table->VddcLevel[count].Smio =3D 0;
> +	}
> +
> +	CONVERT_FROM_HOST_TO_SMC_UL(table->VddcLevelCount);
> +
> +	return 0;
> +}
> +
> +/**
> + * Vddci table preparation for SMC.
> + *
> + * @param    *hwmgr The address of the hardware manager.
> + * @param    *table The SMC DPM table structure to be populated.
> + * @return   0
> + */
> +static int iceland_populate_smc_vdd_ci_table(struct pp_hwmgr *hwmgr,
> +			SMU71_Discrete_DpmTable *table)
> +{
> +	int result;
> +	uint32_t count;
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +
> +	table->VddciLevelCount =3D data->vddci_voltage_table.count;
> +	for (count =3D 0; count < table->VddciLevelCount; count++) {
> +		result =3D iceland_populate_smc_voltage_table(hwmgr,
> +				&data->vddci_voltage_table.entries[count],
> +				&table->VddciLevel[count]);
> +		PP_ASSERT_WITH_CODE(0 =3D=3D result, "do not populate SMC VDDCI volt=
age table", return -EINVAL);
> +
> +		/* GPIO voltage control */
> +		if (ICELAND_VOLTAGE_CONTROL_BY_GPIO =3D=3D data->vdd_ci_control)
> +			table->VddciLevel[count].Smio |=3D data->vddci_voltage_table.entrie=
s[count].smio_low;
> +		else
> +			table->VddciLevel[count].Smio =3D 0;
> +	}
> +
> +	CONVERT_FROM_HOST_TO_SMC_UL(table->VddcLevelCount);
> +
> +	return 0;
> +}
> +
> +/**
> + * Mvdd table preparation for SMC.
> + *
> + * @param    *hwmgr The address of the hardware manager.
> + * @param    *table The SMC DPM table structure to be populated.
> + * @return   0
> + */
> +static int iceland_populate_smc_mvdd_table(struct pp_hwmgr *hwmgr,
> +			SMU71_Discrete_DpmTable *table)
> +{
> +	int result;
> +	uint32_t count;
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +
> +	table->MvddLevelCount =3D data->mvdd_voltage_table.count;
> +	for (count =3D 0; count < table->MvddLevelCount; count++) {
> +		result =3D iceland_populate_smc_voltage_table(hwmgr,
> +				&data->mvdd_voltage_table.entries[count],
> +				&table->MvddLevel[count]);
> +		PP_ASSERT_WITH_CODE(0 =3D=3D result, "do not populate SMC VDDCI volt=
age table", return -EINVAL);
> +
> +		/* GPIO voltage control */
> +		if (ICELAND_VOLTAGE_CONTROL_BY_GPIO =3D=3D data->mvdd_control)
> +			table->MvddLevel[count].Smio |=3D data->mvdd_voltage_table.entries[=
count].smio_low;
> +		else
> +			table->MvddLevel[count].Smio =3D 0;
> +	}
> +
> +	CONVERT_FROM_HOST_TO_SMC_UL(table->MvddLevelCount);
> +
> +	return 0;
> +}
> +
> +/**
> + * Convert a voltage value in mv unit to VID number required by SMU fi=
rmware
> + */
> +static uint8_t convert_to_vid(uint16_t vddc)
> +{
> +	return (uint8_t) ((6200 - (vddc * VOLTAGE_SCALE)) / 25);
> +}
> +
> +int iceland_populate_bapm_vddc_vid_sidd(struct pp_hwmgr *hwmgr)
> +{
> +	int i;
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +	uint8_t * hi_vid =3D data->power_tune_table.BapmVddCVidHiSidd;
> +	uint8_t * lo_vid =3D data->power_tune_table.BapmVddCVidLoSidd;
> +
> +	PP_ASSERT_WITH_CODE(NULL !=3D hwmgr->dyn_state.cac_leakage_table,
> +			    "The CAC Leakage table does not exist!", return -EINVAL);
> +	PP_ASSERT_WITH_CODE(hwmgr->dyn_state.cac_leakage_table->count <=3D 8,=

> +			    "There should never be more than 8 entries for BapmVddcVid!!!",=
 return -EINVAL);
> +	PP_ASSERT_WITH_CODE(hwmgr->dyn_state.cac_leakage_table->count =3D=3D =
hwmgr->dyn_state.vddc_dependency_on_sclk->count,
> +			    "CACLeakageTable->count and VddcDependencyOnSCLk->count not equ=
al", return -EINVAL);
> +
> +	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_Plat=
formCaps_EVV)) {
> +		for (i =3D 0; (uint32_t) i < hwmgr->dyn_state.cac_leakage_table->cou=
nt; i++) {
> +			lo_vid[i] =3D convert_to_vid(hwmgr->dyn_state.cac_leakage_table->en=
tries[i].Vddc1);
> +			hi_vid[i] =3D convert_to_vid(hwmgr->dyn_state.cac_leakage_table->en=
tries[i].Vddc2);
> +		}
> +	} else {
> +		PP_ASSERT_WITH_CODE(false, "Iceland should always support EVV", retu=
rn -EINVAL);
> +	}
> +
> +	return 0;
> +}
> +
> +int iceland_populate_vddc_vid(struct pp_hwmgr *hwmgr)
> +{
> +	int i;
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +	uint8_t *vid =3D data->power_tune_table.VddCVid;
> +
> +	PP_ASSERT_WITH_CODE(data->vddc_voltage_table.count <=3D 8,
> +		"There should never be more than 8 entries for VddcVid!!!",
> +		return -EINVAL);
> +
> +	for (i =3D 0; i < (int)data->vddc_voltage_table.count; i++) {
> +		vid[i] =3D convert_to_vid(data->vddc_voltage_table.entries[i].value)=
;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * Preparation of voltage tables for SMC.
> + *
> + * @param    hwmgr      the address of the hardware manager
> + * @param    table     the SMC DPM table structure to be populated
> + * @return   always 0
> + */
> +
> +int iceland_populate_smc_voltage_tables(struct pp_hwmgr *hwmgr,
> +	SMU71_Discrete_DpmTable *table)
> +{
> +	int result;
> +
> +	result =3D iceland_populate_smc_vddc_table(hwmgr, table);
> +	PP_ASSERT_WITH_CODE(0 =3D=3D result,
> +			"can not populate VDDC voltage table to SMC", return -1);
> +
> +	result =3D iceland_populate_smc_vdd_ci_table(hwmgr, table);
> +	PP_ASSERT_WITH_CODE(0 =3D=3D result,
> +			"can not populate VDDCI voltage table to SMC", return -1);
> +
> +	result =3D iceland_populate_smc_mvdd_table(hwmgr, table);
> +	PP_ASSERT_WITH_CODE(0 =3D=3D result,
> +			"can not populate MVDD voltage table to SMC", return -1);
> +
> +	return 0;
> +}
> +
> +
> +/**
> + * Re-generate the DPM level mask value
> + * @param    hwmgr      the address of the hardware manager
> + */
> +static uint32_t iceland_get_dpm_level_enable_mask_value(
> +			struct iceland_single_dpm_table * dpm_table)
> +{
> +	uint32_t i;
> +	uint32_t mask_value =3D 0;
> +
> +	for (i =3D dpm_table->count; i > 0; i--) {
> +		mask_value =3D mask_value << 1;
> +
> +		if (dpm_table->dpm_levels[i-1].enabled)
> +			mask_value |=3D 0x1;
> +		else
> +			mask_value &=3D 0xFFFFFFFE;
> +	}
> +	return mask_value;
> +}
> +
> +int iceland_populate_memory_timing_parameters(
> +		struct pp_hwmgr *hwmgr,
> +		uint32_t engine_clock,
> +		uint32_t memory_clock,
> +		struct SMU71_Discrete_MCArbDramTimingTableEntry *arb_regs
> +		)
> +{
> +	uint32_t dramTiming;
> +	uint32_t dramTiming2;
> +	uint32_t burstTime;
> +	int result;
> +
> +	result =3D atomctrl_set_engine_dram_timings_rv770(hwmgr,
> +				engine_clock, memory_clock);
> +
> +	PP_ASSERT_WITH_CODE(result =3D=3D 0,
> +		"Error calling VBIOS to set DRAM_TIMING.", return result);
> +
> +	dramTiming  =3D cgs_read_register(hwmgr->device, mmMC_ARB_DRAM_TIMING=
);
> +	dramTiming2 =3D cgs_read_register(hwmgr->device, mmMC_ARB_DRAM_TIMING=
2);
> +	burstTime =3D PHM_READ_FIELD(hwmgr->device, MC_ARB_BURST_TIME, STATE0=
);
> +
> +	arb_regs->McArbDramTiming  =3D PP_HOST_TO_SMC_UL(dramTiming);
> +	arb_regs->McArbDramTiming2 =3D PP_HOST_TO_SMC_UL(dramTiming2);
> +	arb_regs->McArbBurstTime =3D (uint8_t)burstTime;
> +
> +	return 0;
> +}
> +
> +/**
> + * Setup parameters for the MC ARB.
> + *
> + * @param    hwmgr  the address of the powerplay hardware manager.
> + * @return   always 0
> + * This function is to be called from the SetPowerState table.
> + */
> +int iceland_program_memory_timing_parameters(struct pp_hwmgr *hwmgr)
> +{
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +	int result =3D 0;
> +	SMU71_Discrete_MCArbDramTimingTable  arb_regs;
> +	uint32_t i, j;
> +
> +	memset(&arb_regs, 0x00, sizeof(SMU71_Discrete_MCArbDramTimingTable));=

> +
> +	for (i =3D 0; i < data->dpm_table.sclk_table.count; i++) {
> +		for (j =3D 0; j < data->dpm_table.mclk_table.count; j++) {
> +			result =3D iceland_populate_memory_timing_parameters
> +				(hwmgr, data->dpm_table.sclk_table.dpm_levels[i].value,
> +				 data->dpm_table.mclk_table.dpm_levels[j].value,
> +				 &arb_regs.entries[i][j]);
> +
> +			if (0 !=3D result) {
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (0 =3D=3D result) {
> +		result =3D iceland_copy_bytes_to_smc(
> +				hwmgr->smumgr,
> +				data->arb_table_start,
> +				(uint8_t *)&arb_regs,
> +				sizeof(SMU71_Discrete_MCArbDramTimingTable),
> +				data->sram_end
> +				);
> +	}
> +
> +	return result;
> +}
> +
> +static int iceland_populate_smc_link_level(struct pp_hwmgr *hwmgr, SMU=
71_Discrete_DpmTable *table)
> +{
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +	struct iceland_dpm_table *dpm_table =3D &data->dpm_table;
> +	uint32_t i;
> +
> +	/* Index (dpm_table->pcie_speed_table.count) is reserved for PCIE boo=
t level. */
> +	for (i =3D 0; i <=3D dpm_table->pcie_speed_table.count; i++) {
> +		table->LinkLevel[i].PcieGenSpeed  =3D
> +			(uint8_t)dpm_table->pcie_speed_table.dpm_levels[i].value;
> +		table->LinkLevel[i].PcieLaneCount =3D
> +			(uint8_t)encode_pcie_lane_width(dpm_table->pcie_speed_table.dpm_lev=
els[i].param1);
> +		table->LinkLevel[i].EnabledForActivity =3D
> +			1;
> +		table->LinkLevel[i].SPC =3D
> +			(uint8_t)(data->pcie_spc_cap & 0xff);
> +		table->LinkLevel[i].DownThreshold =3D
> +			PP_HOST_TO_SMC_UL(5);
> +		table->LinkLevel[i].UpThreshold =3D
> +			PP_HOST_TO_SMC_UL(30);
> +	}
> +
> +	data->smc_state_table.LinkLevelCount =3D
> +		(uint8_t)dpm_table->pcie_speed_table.count;
> +	data->dpm_level_enable_mask.pcie_dpm_enable_mask =3D
> +		iceland_get_dpm_level_enable_mask_value(&dpm_table->pcie_speed_table=
);
> +
> +	return 0;
> +}
> +
> +static int iceland_populate_smc_uvd_level(struct pp_hwmgr *hwmgr,
> +					SMU71_Discrete_DpmTable *table)
> +{
> +	return 0;
> +}
> +
> +uint8_t iceland_get_voltage_id(pp_atomctrl_voltage_table *voltage_tabl=
e,
> +		uint32_t voltage)
> +{
> +	uint8_t count =3D (uint8_t) (voltage_table->count);
> +	uint8_t i =3D 0;
> +
> +	PP_ASSERT_WITH_CODE((NULL !=3D voltage_table),
> +		"Voltage Table empty.", return 0;);
> +	PP_ASSERT_WITH_CODE((0 !=3D count),
> +		"Voltage Table empty.", return 0;);
> +
> +	for (i =3D 0; i < count; i++) {
> +		/* find first voltage bigger than requested */
> +		if (voltage_table->entries[i].value >=3D voltage)
> +			return i;
> +	}
> +
> +	/* voltage is bigger than max voltage in the table */
> +	return i - 1;
> +}
> +
> +static int iceland_populate_smc_vce_level(struct pp_hwmgr *hwmgr,
> +					  SMU71_Discrete_DpmTable *table)
> +{
> +	return 0;
> +}
> +
> +static int iceland_populate_smc_acp_level(struct pp_hwmgr *hwmgr,
> +					  SMU71_Discrete_DpmTable *table)
> +{
> +	return 0;
> +}
> +
> +static int iceland_populate_smc_samu_level(struct pp_hwmgr *hwmgr,
> +					   SMU71_Discrete_DpmTable *table)
> +{
> +	return 0;
> +}
> +
> +
> +static int iceland_populate_smc_svi2_config(struct pp_hwmgr *hwmgr,
> +					    SMU71_Discrete_DpmTable *tab)
> +{
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +
> +	if(ICELAND_VOLTAGE_CONTROL_BY_SVID2 =3D=3D data->voltage_control)
> +		tab->SVI2Enable |=3D VDDC_ON_SVI2;
> +
> +	if(ICELAND_VOLTAGE_CONTROL_BY_SVID2 =3D=3D data->vdd_ci_control)
> +		tab->SVI2Enable |=3D VDDCI_ON_SVI2;
> +	else
> +		tab->MergedVddci =3D 1;
> +
> +	if(ICELAND_VOLTAGE_CONTROL_BY_SVID2 =3D=3D data->mvdd_control)
> +		tab->SVI2Enable |=3D MVDD_ON_SVI2;
> +
> +	PP_ASSERT_WITH_CODE( tab->SVI2Enable !=3D (VDDC_ON_SVI2 | VDDCI_ON_SV=
I2 | MVDD_ON_SVI2) &&
> +	        (tab->SVI2Enable & VDDC_ON_SVI2), "SVI2 domain configuration =
is incorrect!", return -EINVAL);
> +
> +	return 0;
> +}
> +
> +static int iceland_get_dependecy_volt_by_clk(struct pp_hwmgr *hwmgr,
> +	struct phm_clock_voltage_dependency_table *allowed_clock_voltage_tabl=
e,
> +	uint32_t clock, uint32_t *vol)
> +{
> +	uint32_t i =3D 0;
> +
> +	/* clock - voltage dependency table is empty table */
> +	if (allowed_clock_voltage_table->count =3D=3D 0)
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < allowed_clock_voltage_table->count; i++) {
> +		/* find first sclk bigger than request */
> +		if (allowed_clock_voltage_table->entries[i].clk >=3D clock) {
> +			*vol =3D allowed_clock_voltage_table->entries[i].v;
> +			return 0;
> +		}
> +	}
> +
> +	/* sclk is bigger than max sclk in the dependence table */
> +	*vol =3D allowed_clock_voltage_table->entries[i - 1].v;
> +
> +	return 0;
> +}
> +
> +static uint8_t iceland_get_mclk_frequency_ratio(uint32_t memory_clock,=

> +		bool strobe_mode)
> +{
> +	uint8_t mc_para_index;
> +
> +	if (strobe_mode) {
> +		if (memory_clock < 12500) {
> +			mc_para_index =3D 0x00;
> +		} else if (memory_clock > 47500) {
> +			mc_para_index =3D 0x0f;
> +		} else {
> +			mc_para_index =3D (uint8_t)((memory_clock - 10000) / 2500);
> +		}
> +	} else {
> +		if (memory_clock < 65000) {
> +			mc_para_index =3D 0x00;
> +		} else if (memory_clock > 135000) {
> +			mc_para_index =3D 0x0f;
> +		} else {
> +			mc_para_index =3D (uint8_t)((memory_clock - 60000) / 5000);
> +		}
> +	}
> +
> +	return mc_para_index;
> +}
> +
> +static uint8_t iceland_get_ddr3_mclk_frequency_ratio(uint32_t memory_c=
lock)
> +{
> +	uint8_t mc_para_index;
> +
> +	if (memory_clock < 10000) {
> +		mc_para_index =3D 0;
> +	} else if (memory_clock >=3D 80000) {
> +		mc_para_index =3D 0x0f;
> +	} else {
> +		mc_para_index =3D (uint8_t)((memory_clock - 10000) / 5000 + 1);
> +	}
> +
> +	return mc_para_index;
> +}
> +
> +static int iceland_populate_phase_value_based_on_sclk(struct pp_hwmgr =
*hwmgr, const struct phm_phase_shedding_limits_table *pl,
> +					uint32_t sclk, uint32_t *p_shed)
> +{
> +	unsigned int i;
> +
> +	/* use the minimum phase shedding */
> +	*p_shed =3D 1;
> +
> +	/*
> +	 * PPGen ensures the phase shedding limits table is sorted
> +	 * from lowest voltage/sclk/mclk to highest voltage/sclk/mclk.
> +	 * VBIOS ensures the phase shedding masks table is sorted from
> +	 * least phases enabled (phase shedding on) to most phases
> +	 * enabled (phase shedding off).
> +	 */
> +	for (i =3D 0; i < pl->count; i++) {
> +	    if (sclk < pl->entries[i].Sclk) {
> +	        /* Enable phase shedding */
> +	        *p_shed =3D i;
> +	        break;
> +	    }
> +	}
> +
> +	return 0;
> +}
> +
> +static int iceland_populate_phase_value_based_on_mclk(struct pp_hwmgr =
*hwmgr, const struct phm_phase_shedding_limits_table *pl,
> +					uint32_t memory_clock, uint32_t *p_shed)
> +{
> +	unsigned int i;
> +
> +	/* use the minimum phase shedding */
> +	*p_shed =3D 1;
> +
> +	/*
> +	 * PPGen ensures the phase shedding limits table is sorted
> +	 * from lowest voltage/sclk/mclk to highest voltage/sclk/mclk.
> +	 * VBIOS ensures the phase shedding masks table is sorted from
> +	 * least phases enabled (phase shedding on) to most phases
> +	 * enabled (phase shedding off).
> +	 */
> +	for (i =3D 0; i < pl->count; i++) {
> +	    if (memory_clock < pl->entries[i].Mclk) {
> +	        /* Enable phase shedding */
> +	        *p_shed =3D i;
> +	        break;
> +	    }
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * Populates the SMC MCLK structure using the provided memory clock
> + *
> + * @param    hwmgr      the address of the hardware manager
> + * @param    memory_clock the memory clock to use to populate the stru=
cture
> + * @param    sclk        the SMC SCLK structure to be populated
> + */
> +static int iceland_calculate_mclk_params(
> +		struct pp_hwmgr *hwmgr,
> +		uint32_t memory_clock,
> +		SMU71_Discrete_MemoryLevel *mclk,
> +		bool strobe_mode,
> +		bool dllStateOn
> +		)
> +{
> +	const iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +	uint32_t  dll_cntl =3D data->clock_registers.vDLL_CNTL;
> +	uint32_t  mclk_pwrmgt_cntl =3D data->clock_registers.vMCLK_PWRMGT_CNT=
L;
> +	uint32_t  mpll_ad_func_cntl =3D data->clock_registers.vMPLL_AD_FUNC_C=
NTL;
> +	uint32_t  mpll_dq_func_cntl =3D data->clock_registers.vMPLL_DQ_FUNC_C=
NTL;
> +	uint32_t  mpll_func_cntl =3D data->clock_registers.vMPLL_FUNC_CNTL;
> +	uint32_t  mpll_func_cntl_1 =3D data->clock_registers.vMPLL_FUNC_CNTL_=
1;
> +	uint32_t  mpll_func_cntl_2 =3D data->clock_registers.vMPLL_FUNC_CNTL_=
2;
> +	uint32_t  mpll_ss1 =3D data->clock_registers.vMPLL_SS1;
> +	uint32_t  mpll_ss2 =3D data->clock_registers.vMPLL_SS2;
> +
> +	pp_atomctrl_memory_clock_param mpll_param;
> +	int result;
> +
> +	result =3D atomctrl_get_memory_pll_dividers_si(hwmgr,
> +				memory_clock, &mpll_param, strobe_mode);
> +	PP_ASSERT_WITH_CODE(0 =3D=3D result,
> +		"Error retrieving Memory Clock Parameters from VBIOS.", return resul=
t);
> +
> +	/* MPLL_FUNC_CNTL setup*/
> +	mpll_func_cntl =3D PHM_SET_FIELD(mpll_func_cntl, MPLL_FUNC_CNTL, BWCT=
RL, mpll_param.bw_ctrl);
> +
> +	/* MPLL_FUNC_CNTL_1 setup*/
> +	mpll_func_cntl_1  =3D PHM_SET_FIELD(mpll_func_cntl_1,
> +							MPLL_FUNC_CNTL_1, CLKF, mpll_param.mpll_fb_divider.cl_kf);
> +	mpll_func_cntl_1  =3D PHM_SET_FIELD(mpll_func_cntl_1,
> +							MPLL_FUNC_CNTL_1, CLKFRAC, mpll_param.mpll_fb_divider.clk_frac)=
;
> +	mpll_func_cntl_1  =3D PHM_SET_FIELD(mpll_func_cntl_1,
> +							MPLL_FUNC_CNTL_1, VCO_MODE, mpll_param.vco_mode);
> +
> +	/* MPLL_AD_FUNC_CNTL setup*/
> +	mpll_ad_func_cntl =3D PHM_SET_FIELD(mpll_ad_func_cntl,
> +							MPLL_AD_FUNC_CNTL, YCLK_POST_DIV, mpll_param.mpll_post_divider)=
;
> +
> +	if (data->is_memory_GDDR5) {
> +		/* MPLL_DQ_FUNC_CNTL setup*/
> +		mpll_dq_func_cntl  =3D PHM_SET_FIELD(mpll_dq_func_cntl,
> +								MPLL_DQ_FUNC_CNTL, YCLK_SEL, mpll_param.yclk_sel);
> +		mpll_dq_func_cntl  =3D PHM_SET_FIELD(mpll_dq_func_cntl,
> +								MPLL_DQ_FUNC_CNTL, YCLK_POST_DIV, mpll_param.mpll_post_divider=
);
> +	}
> +
> +	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
> +			PHM_PlatformCaps_MemorySpreadSpectrumSupport)) {
> +		/*
> +		 ************************************
> +		 Fref =3D Reference Frequency
> +		 NF =3D Feedback divider ratio
> +		 NR =3D Reference divider ratio
> +		 Fnom =3D Nominal VCO output frequency =3D Fref * NF / NR
> +		 Fs =3D Spreading Rate
> +		 D =3D Percentage down-spread / 2
> +		 Fint =3D Reference input frequency to PFD =3D Fref / NR
> +		 NS =3D Spreading rate divider ratio =3D int(Fint / (2 * Fs))
> +		 CLKS =3D NS - 1 =3D ISS_STEP_NUM[11:0]
> +		 NV =3D D * Fs / Fnom * 4 * ((Fnom/Fref * NR) ^ 2)
> +		 CLKV =3D 65536 * NV =3D ISS_STEP_SIZE[25:0]
> +		 *************************************
> +		 */
> +		pp_atomctrl_internal_ss_info ss_info;
> +		uint32_t freq_nom;
> +		uint32_t tmp;
> +		uint32_t reference_clock =3D atomctrl_get_mpll_reference_clock(hwmgr=
);
> +
> +		/* for GDDR5 for all modes and DDR3 */
> +		if (1 =3D=3D mpll_param.qdr)
> +			freq_nom =3D memory_clock * 4 * (1 << mpll_param.mpll_post_divider)=
;
> +		else
> +			freq_nom =3D memory_clock * 2 * (1 << mpll_param.mpll_post_divider)=
;
> +
> +		/* tmp =3D (freq_nom / reference_clock * reference_divider) ^ 2  Not=
e: S.I. reference_divider =3D 1*/
> +		tmp =3D (freq_nom / reference_clock);
> +		tmp =3D tmp * tmp;
> +
> +		if (0 =3D=3D atomctrl_get_memory_clock_spread_spectrum(hwmgr, freq_n=
om, &ss_info)) {
> +			/* ss_info.speed_spectrum_percentage -- in unit of 0.01% */
> +			/* ss.Info.speed_spectrum_rate -- in unit of khz */
> +			/* CLKS =3D reference_clock / (2 * speed_spectrum_rate * reference_=
divider) * 10 */
> +			/*     =3D reference_clock * 5 / speed_spectrum_rate */
> +			uint32_t clks =3D reference_clock * 5 / ss_info.speed_spectrum_rate=
;
> +
> +			/* CLKV =3D 65536 * speed_spectrum_percentage / 2 * spreadSpecrumRa=
te / freq_nom * 4 / 100000 * ((freq_nom / reference_clock) ^ 2) */
> +			/*     =3D 131 * speed_spectrum_percentage * speed_spectrum_rate / =
100 * ((freq_nom / reference_clock) ^ 2) / freq_nom */
> +			uint32_t clkv =3D
> +				(uint32_t)((((131 * ss_info.speed_spectrum_percentage *
> +							ss_info.speed_spectrum_rate) / 100) * tmp) / freq_nom);
> +
> +			mpll_ss1 =3D PHM_SET_FIELD(mpll_ss1, MPLL_SS1, CLKV, clkv);
> +			mpll_ss2 =3D PHM_SET_FIELD(mpll_ss2, MPLL_SS2, CLKS, clks);
> +		}
> +	}
> +
> +	/* MCLK_PWRMGT_CNTL setup */
> +	mclk_pwrmgt_cntl =3D PHM_SET_FIELD(mclk_pwrmgt_cntl,
> +		MCLK_PWRMGT_CNTL, DLL_SPEED, mpll_param.dll_speed);
> +	mclk_pwrmgt_cntl =3D PHM_SET_FIELD(mclk_pwrmgt_cntl,
> +		MCLK_PWRMGT_CNTL, MRDCK0_PDNB, dllStateOn);
> +	mclk_pwrmgt_cntl =3D PHM_SET_FIELD(mclk_pwrmgt_cntl,
> +		MCLK_PWRMGT_CNTL, MRDCK1_PDNB, dllStateOn);
> +
> +
> +	/* Save the result data to outpupt memory level structure */
> +	mclk->MclkFrequency   =3D memory_clock;
> +	mclk->MpllFuncCntl    =3D mpll_func_cntl;
> +	mclk->MpllFuncCntl_1  =3D mpll_func_cntl_1;
> +	mclk->MpllFuncCntl_2  =3D mpll_func_cntl_2;
> +	mclk->MpllAdFuncCntl  =3D mpll_ad_func_cntl;
> +	mclk->MpllDqFuncCntl  =3D mpll_dq_func_cntl;
> +	mclk->MclkPwrmgtCntl  =3D mclk_pwrmgt_cntl;
> +	mclk->DllCntl         =3D dll_cntl;
> +	mclk->MpllSs1         =3D mpll_ss1;
> +	mclk->MpllSs2         =3D mpll_ss2;
> +
> +	return 0;
> +}
> +
> +static int iceland_populate_single_memory_level(
> +		struct pp_hwmgr *hwmgr,
> +		uint32_t memory_clock,
> +		SMU71_Discrete_MemoryLevel *memory_level
> +		)
> +{
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +	int result =3D 0;
> +	bool dllStateOn;
> +	struct cgs_display_info info =3D {0};
> +
> +
> +	if (NULL !=3D hwmgr->dyn_state.vddc_dependency_on_mclk) {
> +		result =3D iceland_get_dependecy_volt_by_clk(hwmgr,
> +			hwmgr->dyn_state.vddc_dependency_on_mclk, memory_clock, &memory_lev=
el->MinVddc);
> +		PP_ASSERT_WITH_CODE((0 =3D=3D result),
> +			"can not find MinVddc voltage value from memory VDDC voltage depend=
ency table", return result);
> +	}
> +
> +	if (data->vdd_ci_control =3D=3D ICELAND_VOLTAGE_CONTROL_NONE) {
> +		memory_level->MinVddci =3D memory_level->MinVddc;
> +	} else if (NULL !=3D hwmgr->dyn_state.vddci_dependency_on_mclk) {
> +		result =3D iceland_get_dependecy_volt_by_clk(hwmgr,
> +				hwmgr->dyn_state.vddci_dependency_on_mclk,
> +				memory_clock,
> +				&memory_level->MinVddci);
> +		PP_ASSERT_WITH_CODE((0 =3D=3D result),
> +			"can not find MinVddci voltage value from memory VDDCI voltage depe=
ndency table", return result);
> +	}
> +
> +	if (NULL !=3D hwmgr->dyn_state.mvdd_dependency_on_mclk) {
> +		result =3D iceland_get_dependecy_volt_by_clk(hwmgr,
> +			hwmgr->dyn_state.mvdd_dependency_on_mclk, memory_clock, &memory_lev=
el->MinMvdd);
> +		PP_ASSERT_WITH_CODE((0 =3D=3D result),
> +			"can not find MinMVDD voltage value from memory MVDD voltage depend=
ency table", return result);
> +	}
> +
> +	memory_level->MinVddcPhases =3D 1;
> +
> +	if (data->vddc_phase_shed_control) {
> +		iceland_populate_phase_value_based_on_mclk(hwmgr, hwmgr->dyn_state.v=
ddc_phase_shed_limits_table,
> +				memory_clock, &memory_level->MinVddcPhases);
> +	}
> +
> +	memory_level->EnabledForThrottle =3D 1;
> +	memory_level->EnabledForActivity =3D 1;
> +	memory_level->UpHyst =3D 0;
> +	memory_level->DownHyst =3D 100;
> +	memory_level->VoltageDownHyst =3D 0;
> +
> +	/* Indicates maximum activity level for this performance level.*/
> +	memory_level->ActivityLevel =3D (uint16_t)data->mclk_activity_target;=

> +	memory_level->StutterEnable =3D 0;
> +	memory_level->StrobeEnable =3D 0;
> +	memory_level->EdcReadEnable =3D 0;
> +	memory_level->EdcWriteEnable =3D 0;
> +	memory_level->RttEnable =3D 0;
> +
> +	/* default set to low watermark. Highest level will be set to high la=
ter.*/
> +	memory_level->DisplayWatermark =3D PPSMC_DISPLAY_WATERMARK_LOW;
> +
> +	cgs_get_active_displays_info(hwmgr->device, &info);
> +	data->display_timing.num_existing_displays =3D info.display_count;
> +
> +	//if ((data->mclk_stutter_mode_threshold !=3D 0) &&
> +	//    (memory_clock <=3D data->mclk_stutter_mode_threshold) &&
> +	//    (data->is_uvd_enabled =3D=3D 0)
> +	//    && (PHM_READ_FIELD(hwmgr->device, DPG_PIPE_STUTTER_CONTROL, STU=
TTER_ENABLE) & 0x1)
> +	//    && (data->display_timing.num_existing_displays <=3D 2)
> +	//    && (data->display_timing.num_existing_displays !=3D 0))
> +	//	memory_level->StutterEnable =3D 1;
> +
> +	/* decide strobe mode*/
> +	memory_level->StrobeEnable =3D (data->mclk_strobe_mode_threshold !=3D=
 0) &&
> +		(memory_clock <=3D data->mclk_strobe_mode_threshold);
> +
> +	/* decide EDC mode and memory clock ratio*/
> +	if (data->is_memory_GDDR5) {
> +		memory_level->StrobeRatio =3D iceland_get_mclk_frequency_ratio(memor=
y_clock,
> +					memory_level->StrobeEnable);
> +
> +		if ((data->mclk_edc_enable_threshold !=3D 0) &&
> +				(memory_clock > data->mclk_edc_enable_threshold)) {
> +			memory_level->EdcReadEnable =3D 1;
> +		}
> +
> +		if ((data->mclk_edc_wr_enable_threshold !=3D 0) &&
> +				(memory_clock > data->mclk_edc_wr_enable_threshold)) {
> +			memory_level->EdcWriteEnable =3D 1;
> +		}
> +
> +		if (memory_level->StrobeEnable) {
> +			if (iceland_get_mclk_frequency_ratio(memory_clock, 1) >=3D
> +					((cgs_read_register(hwmgr->device, mmMC_SEQ_MISC7) >> 16) & 0xf))=
 {
> +				dllStateOn =3D ((cgs_read_register(hwmgr->device, mmMC_SEQ_MISC5) =
>> 1) & 0x1) ? 1 : 0;
> +			} else {
> +				dllStateOn =3D ((cgs_read_register(hwmgr->device, mmMC_SEQ_MISC6) =
>> 1) & 0x1) ? 1 : 0;
> +			}
> +
> +		} else {
> +			dllStateOn =3D data->dll_defaule_on;
> +		}
> +	} else {
> +		memory_level->StrobeRatio =3D
> +			iceland_get_ddr3_mclk_frequency_ratio(memory_clock);
> +		dllStateOn =3D ((cgs_read_register(hwmgr->device, mmMC_SEQ_MISC5) >>=
 1) & 0x1) ? 1 : 0;
> +	}
> +
> +	result =3D iceland_calculate_mclk_params(hwmgr,
> +		memory_clock, memory_level, memory_level->StrobeEnable, dllStateOn);=

> +
> +	if (0 =3D=3D result) {
> +		memory_level->MinVddc =3D PP_HOST_TO_SMC_UL(memory_level->MinVddc * =
VOLTAGE_SCALE);
> +		CONVERT_FROM_HOST_TO_SMC_UL(memory_level->MinVddcPhases);
> +		memory_level->MinVddci =3D PP_HOST_TO_SMC_UL(memory_level->MinVddci =
* VOLTAGE_SCALE);
> +		memory_level->MinMvdd =3D PP_HOST_TO_SMC_UL(memory_level->MinMvdd * =
VOLTAGE_SCALE);
> +		/* MCLK frequency in units of 10KHz*/
> +		CONVERT_FROM_HOST_TO_SMC_UL(memory_level->MclkFrequency);
> +		/* Indicates maximum activity level for this performance level.*/
> +		CONVERT_FROM_HOST_TO_SMC_US(memory_level->ActivityLevel);
> +		CONVERT_FROM_HOST_TO_SMC_UL(memory_level->MpllFuncCntl);
> +		CONVERT_FROM_HOST_TO_SMC_UL(memory_level->MpllFuncCntl_1);
> +		CONVERT_FROM_HOST_TO_SMC_UL(memory_level->MpllFuncCntl_2);
> +		CONVERT_FROM_HOST_TO_SMC_UL(memory_level->MpllAdFuncCntl);
> +		CONVERT_FROM_HOST_TO_SMC_UL(memory_level->MpllDqFuncCntl);
> +		CONVERT_FROM_HOST_TO_SMC_UL(memory_level->MclkPwrmgtCntl);
> +		CONVERT_FROM_HOST_TO_SMC_UL(memory_level->DllCntl);
> +		CONVERT_FROM_HOST_TO_SMC_UL(memory_level->MpllSs1);
> +		CONVERT_FROM_HOST_TO_SMC_UL(memory_level->MpllSs2);
> +	}
> +
> +	return result;
> +}
> +
> +/**
> + * Populates the SMC MVDD structure using the provided memory clock.
> + *
> + * @param    hwmgr      the address of the hardware manager
> + * @param    mclk        the MCLK value to be used in the decision if =
MVDD should be high or low.
> + * @param    voltage     the SMC VOLTAGE structure to be populated
> + */
> +int iceland_populate_mvdd_value(struct pp_hwmgr *hwmgr, uint32_t mclk,=
 SMU71_Discrete_VoltageLevel *voltage)
> +{
> +	const iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +	uint32_t i =3D 0;
> +
> +	if (ICELAND_VOLTAGE_CONTROL_NONE !=3D data->mvdd_control) {
> +		/* find mvdd value which clock is more than request */
> +		for (i =3D 0; i < hwmgr->dyn_state.mvdd_dependency_on_mclk->count; i=
++) {
> +			if (mclk <=3D hwmgr->dyn_state.mvdd_dependency_on_mclk->entries[i].=
clk) {
> +				/* Always round to higher voltage. */
> +				voltage->Voltage =3D data->mvdd_voltage_table.entries[i].value;
> +				break;
> +			}
> +		}
> +
> +		PP_ASSERT_WITH_CODE(i < hwmgr->dyn_state.mvdd_dependency_on_mclk->co=
unt,
> +			"MVDD Voltage is outside the supported range.", return -1);
> +
> +	} else {
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +
> +static int iceland_populate_smc_acpi_level(struct pp_hwmgr *hwmgr,
> +	SMU71_Discrete_DpmTable *table)
> +{
> +	int result =3D 0;
> +	const iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +	pp_atomctrl_clock_dividers_vi dividers;
> +	SMU71_Discrete_VoltageLevel voltage_level;
> +	uint32_t spll_func_cntl    =3D data->clock_registers.vCG_SPLL_FUNC_CN=
TL;
> +	uint32_t spll_func_cntl_2  =3D data->clock_registers.vCG_SPLL_FUNC_CN=
TL_2;
> +	uint32_t dll_cntl          =3D data->clock_registers.vDLL_CNTL;
> +	uint32_t mclk_pwrmgt_cntl  =3D data->clock_registers.vMCLK_PWRMGT_CNT=
L;
> +
> +	/* The ACPI state should not do DPM on DC (or ever).*/
> +	table->ACPILevel.Flags &=3D ~PPSMC_SWSTATE_FLAG_DC;
> +
> +	if (data->acpi_vddc)
> +		table->ACPILevel.MinVddc =3D PP_HOST_TO_SMC_UL(data->acpi_vddc * VOL=
TAGE_SCALE);
> +	else
> +		table->ACPILevel.MinVddc =3D PP_HOST_TO_SMC_UL(data->min_vddc_in_pp_=
table * VOLTAGE_SCALE);
> +
> +	table->ACPILevel.MinVddcPhases =3D (data->vddc_phase_shed_control) ? =
0 : 1;
> +
> +	/* assign zero for now*/
> +	table->ACPILevel.SclkFrequency =3D atomctrl_get_reference_clock(hwmgr=
);
> +
> +	/* get the engine clock dividers for this clock value*/
> +	result =3D atomctrl_get_engine_pll_dividers_vi(hwmgr,
> +		table->ACPILevel.SclkFrequency,  &dividers);
> +
> +	PP_ASSERT_WITH_CODE(result =3D=3D 0,
> +		"Error retrieving Engine Clock dividers from VBIOS.", return result)=
;
> +
> +	/* divider ID for required SCLK*/
> +	table->ACPILevel.SclkDid =3D (uint8_t)dividers.pll_post_divider;
> +	table->ACPILevel.DisplayWatermark =3D PPSMC_DISPLAY_WATERMARK_LOW;
> +	table->ACPILevel.DeepSleepDivId =3D 0;
> +
> +	spll_func_cntl      =3D PHM_SET_FIELD(spll_func_cntl,
> +							CG_SPLL_FUNC_CNTL,   SPLL_PWRON,     0);
> +	spll_func_cntl      =3D PHM_SET_FIELD(spll_func_cntl,
> +							CG_SPLL_FUNC_CNTL,   SPLL_RESET,     1);
> +	spll_func_cntl_2    =3D PHM_SET_FIELD(spll_func_cntl_2,
> +							CG_SPLL_FUNC_CNTL_2, SCLK_MUX_SEL,   4);
> +
> +	table->ACPILevel.CgSpllFuncCntl =3D spll_func_cntl;
> +	table->ACPILevel.CgSpllFuncCntl2 =3D spll_func_cntl_2;
> +	table->ACPILevel.CgSpllFuncCntl3 =3D data->clock_registers.vCG_SPLL_F=
UNC_CNTL_3;
> +	table->ACPILevel.CgSpllFuncCntl4 =3D data->clock_registers.vCG_SPLL_F=
UNC_CNTL_4;
> +	table->ACPILevel.SpllSpreadSpectrum =3D data->clock_registers.vCG_SPL=
L_SPREAD_SPECTRUM;
> +	table->ACPILevel.SpllSpreadSpectrum2 =3D data->clock_registers.vCG_SP=
LL_SPREAD_SPECTRUM_2;
> +	table->ACPILevel.CcPwrDynRm =3D 0;
> +	table->ACPILevel.CcPwrDynRm1 =3D 0;
> +
> +
> +	/* For various features to be enabled/disabled while this level is ac=
tive.*/
> +	CONVERT_FROM_HOST_TO_SMC_UL(table->ACPILevel.Flags);
> +	/* SCLK frequency in units of 10KHz*/
> +	CONVERT_FROM_HOST_TO_SMC_UL(table->ACPILevel.SclkFrequency);
> +	CONVERT_FROM_HOST_TO_SMC_UL(table->ACPILevel.CgSpllFuncCntl);
> +	CONVERT_FROM_HOST_TO_SMC_UL(table->ACPILevel.CgSpllFuncCntl2);
> +	CONVERT_FROM_HOST_TO_SMC_UL(table->ACPILevel.CgSpllFuncCntl3);
> +	CONVERT_FROM_HOST_TO_SMC_UL(table->ACPILevel.CgSpllFuncCntl4);
> +	CONVERT_FROM_HOST_TO_SMC_UL(table->ACPILevel.SpllSpreadSpectrum);
> +	CONVERT_FROM_HOST_TO_SMC_UL(table->ACPILevel.SpllSpreadSpectrum2);
> +	CONVERT_FROM_HOST_TO_SMC_UL(table->ACPILevel.CcPwrDynRm);
> +	CONVERT_FROM_HOST_TO_SMC_UL(table->ACPILevel.CcPwrDynRm1);
> +
> +	table->MemoryACPILevel.MinVddc =3D table->ACPILevel.MinVddc;
> +	table->MemoryACPILevel.MinVddcPhases =3D table->ACPILevel.MinVddcPhas=
es;
> +
> +	/*  CONVERT_FROM_HOST_TO_SMC_UL(table->MemoryACPILevel.MinVoltage);*/=

> +
> +	if (0 =3D=3D iceland_populate_mvdd_value(hwmgr, 0, &voltage_level))
> +		table->MemoryACPILevel.MinMvdd =3D
> +			PP_HOST_TO_SMC_UL(voltage_level.Voltage * VOLTAGE_SCALE);
> +	else
> +		table->MemoryACPILevel.MinMvdd =3D 0;
> +
> +	/* Force reset on DLL*/
> +	mclk_pwrmgt_cntl    =3D PHM_SET_FIELD(mclk_pwrmgt_cntl,
> +		MCLK_PWRMGT_CNTL, MRDCK0_RESET, 0x1);
> +	mclk_pwrmgt_cntl    =3D PHM_SET_FIELD(mclk_pwrmgt_cntl,
> +		MCLK_PWRMGT_CNTL, MRDCK1_RESET, 0x1);
> +
> +	/* Disable DLL in ACPIState*/
> +	mclk_pwrmgt_cntl    =3D PHM_SET_FIELD(mclk_pwrmgt_cntl,
> +		MCLK_PWRMGT_CNTL, MRDCK0_PDNB, 0);
> +	mclk_pwrmgt_cntl    =3D PHM_SET_FIELD(mclk_pwrmgt_cntl,
> +		MCLK_PWRMGT_CNTL, MRDCK1_PDNB, 0);
> +
> +	/* Enable DLL bypass signal*/
> +	dll_cntl            =3D PHM_SET_FIELD(dll_cntl,
> +		DLL_CNTL, MRDCK0_BYPASS, 0);
> +	dll_cntl            =3D PHM_SET_FIELD(dll_cntl,
> +		DLL_CNTL, MRDCK1_BYPASS, 0);
> +
> +	table->MemoryACPILevel.DllCntl            =3D
> +		PP_HOST_TO_SMC_UL(dll_cntl);
> +	table->MemoryACPILevel.MclkPwrmgtCntl     =3D
> +		PP_HOST_TO_SMC_UL(mclk_pwrmgt_cntl);
> +	table->MemoryACPILevel.MpllAdFuncCntl     =3D
> +		PP_HOST_TO_SMC_UL(data->clock_registers.vMPLL_AD_FUNC_CNTL);
> +	table->MemoryACPILevel.MpllDqFuncCntl     =3D
> +		PP_HOST_TO_SMC_UL(data->clock_registers.vMPLL_DQ_FUNC_CNTL);
> +	table->MemoryACPILevel.MpllFuncCntl       =3D
> +		PP_HOST_TO_SMC_UL(data->clock_registers.vMPLL_FUNC_CNTL);
> +	table->MemoryACPILevel.MpllFuncCntl_1     =3D
> +		PP_HOST_TO_SMC_UL(data->clock_registers.vMPLL_FUNC_CNTL_1);
> +	table->MemoryACPILevel.MpllFuncCntl_2     =3D
> +		PP_HOST_TO_SMC_UL(data->clock_registers.vMPLL_FUNC_CNTL_2);
> +	table->MemoryACPILevel.MpllSs1            =3D
> +		PP_HOST_TO_SMC_UL(data->clock_registers.vMPLL_SS1);
> +	table->MemoryACPILevel.MpllSs2            =3D
> +		PP_HOST_TO_SMC_UL(data->clock_registers.vMPLL_SS2);
> +
> +	table->MemoryACPILevel.EnabledForThrottle =3D 0;
> +	table->MemoryACPILevel.EnabledForActivity =3D 0;
> +	table->MemoryACPILevel.UpHyst =3D 0;
> +	table->MemoryACPILevel.DownHyst =3D 100;
> +	table->MemoryACPILevel.VoltageDownHyst =3D 0;
> +	/* Indicates maximum activity level for this performance level.*/
> +	table->MemoryACPILevel.ActivityLevel =3D PP_HOST_TO_SMC_US((uint16_t)=
data->mclk_activity_target);
> +
> +	table->MemoryACPILevel.StutterEnable =3D 0;
> +	table->MemoryACPILevel.StrobeEnable =3D 0;
> +	table->MemoryACPILevel.EdcReadEnable =3D 0;
> +	table->MemoryACPILevel.EdcWriteEnable =3D 0;
> +	table->MemoryACPILevel.RttEnable =3D 0;
> +
> +	return result;
> +}
> +
> +static int iceland_find_boot_level(struct iceland_single_dpm_table *ta=
ble, uint32_t value, uint32_t *boot_level)
> +{
> +	int result =3D 0;
> +	uint32_t i;
> +
> +	for (i =3D 0; i < table->count; i++) {
> +		if (value =3D=3D table->dpm_levels[i].value) {
> +			*boot_level =3D i;
> +			result =3D 0;
> +		}
> +	}
> +	return result;
> +}
> +
> +/**
> + * Calculates the SCLK dividers using the provided engine clock
> + *
> + * @param    hwmgr      the address of the hardware manager
> + * @param    engine_clock the engine clock to use to populate the stru=
cture
> + * @param    sclk        the SMC SCLK structure to be populated
> + */
> +int iceland_calculate_sclk_params(struct pp_hwmgr *hwmgr,
> +		uint32_t engine_clock, SMU71_Discrete_GraphicsLevel *sclk)
> +{
> +	const iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +	pp_atomctrl_clock_dividers_vi dividers;
> +	uint32_t spll_func_cntl            =3D data->clock_registers.vCG_SPLL=
_FUNC_CNTL;
> +	uint32_t spll_func_cntl_3          =3D data->clock_registers.vCG_SPLL=
_FUNC_CNTL_3;
> +	uint32_t spll_func_cntl_4          =3D data->clock_registers.vCG_SPLL=
_FUNC_CNTL_4;
> +	uint32_t cg_spll_spread_spectrum   =3D data->clock_registers.vCG_SPLL=
_SPREAD_SPECTRUM;
> +	uint32_t cg_spll_spread_spectrum_2 =3D data->clock_registers.vCG_SPLL=
_SPREAD_SPECTRUM_2;
> +	uint32_t    reference_clock;
> +	uint32_t reference_divider;
> +	uint32_t fbdiv;
> +	int result;
> +
> +	/* get the engine clock dividers for this clock value*/
> +	result =3D atomctrl_get_engine_pll_dividers_vi(hwmgr, engine_clock,  =
&dividers);
> +
> +	PP_ASSERT_WITH_CODE(result =3D=3D 0,
> +		"Error retrieving Engine Clock dividers from VBIOS.", return result)=
;
> +
> +	/* To get FBDIV we need to multiply this by 16384 and divide it by Fr=
ef.*/
> +	reference_clock =3D atomctrl_get_reference_clock(hwmgr);
> +
> +	reference_divider =3D 1 + dividers.uc_pll_ref_div;
> +
> +	/* low 14 bits is fraction and high 12 bits is divider*/
> +	fbdiv =3D dividers.ul_fb_div.ul_fb_divider & 0x3FFFFFF;
> +
> +	/* SPLL_FUNC_CNTL setup*/
> +	spll_func_cntl =3D PHM_SET_FIELD(spll_func_cntl,
> +		CG_SPLL_FUNC_CNTL, SPLL_REF_DIV, dividers.uc_pll_ref_div);
> +	spll_func_cntl =3D PHM_SET_FIELD(spll_func_cntl,
> +		CG_SPLL_FUNC_CNTL, SPLL_PDIV_A,  dividers.uc_pll_post_div);
> +
> +	/* SPLL_FUNC_CNTL_3 setup*/
> +	spll_func_cntl_3 =3D PHM_SET_FIELD(spll_func_cntl_3,
> +		CG_SPLL_FUNC_CNTL_3, SPLL_FB_DIV, fbdiv);
> +
> +	/* set to use fractional accumulation*/
> +	spll_func_cntl_3 =3D PHM_SET_FIELD(spll_func_cntl_3,
> +		CG_SPLL_FUNC_CNTL_3, SPLL_DITHEN, 1);
> +
> +	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
> +			PHM_PlatformCaps_EngineSpreadSpectrumSupport)) {
> +		pp_atomctrl_internal_ss_info ss_info;
> +
> +		uint32_t vcoFreq =3D engine_clock * dividers.uc_pll_post_div;
> +		if (0 =3D=3D atomctrl_get_engine_clock_spread_spectrum(hwmgr, vcoFre=
q, &ss_info)) {
> +			/*
> +			* ss_info.speed_spectrum_percentage -- in unit of 0.01%
> +			* ss_info.speed_spectrum_rate -- in unit of khz
> +			*/
> +			/* clks =3D reference_clock * 10 / (REFDIV + 1) / speed_spectrum_ra=
te / 2 */
> +			uint32_t clkS =3D reference_clock * 5 / (reference_divider * ss_inf=
o.speed_spectrum_rate);
> +
> +			/* clkv =3D 2 * D * fbdiv / NS */
> +			uint32_t clkV =3D 4 * ss_info.speed_spectrum_percentage * fbdiv / (=
clkS * 10000);
> +
> +			cg_spll_spread_spectrum =3D
> +				PHM_SET_FIELD(cg_spll_spread_spectrum, CG_SPLL_SPREAD_SPECTRUM, CL=
KS, clkS);
> +			cg_spll_spread_spectrum =3D
> +				PHM_SET_FIELD(cg_spll_spread_spectrum, CG_SPLL_SPREAD_SPECTRUM, SS=
EN, 1);
> +			cg_spll_spread_spectrum_2 =3D
> +				PHM_SET_FIELD(cg_spll_spread_spectrum_2, CG_SPLL_SPREAD_SPECTRUM_2=
, CLKV, clkV);
> +		}
> +	}
> +
> +	sclk->SclkFrequency        =3D engine_clock;
> +	sclk->CgSpllFuncCntl3      =3D spll_func_cntl_3;
> +	sclk->CgSpllFuncCntl4      =3D spll_func_cntl_4;
> +	sclk->SpllSpreadSpectrum   =3D cg_spll_spread_spectrum;
> +	sclk->SpllSpreadSpectrum2  =3D cg_spll_spread_spectrum_2;
> +	sclk->SclkDid              =3D (uint8_t)dividers.pll_post_divider;
> +
> +	return 0;
> +}
> +
> +static uint8_t iceland_get_sleep_divider_id_from_clock(struct pp_hwmgr=
 *hwmgr,
> +		uint32_t engine_clock, uint32_t min_engine_clock_in_sr)
> +{
> +	uint32_t i, temp;
> +	uint32_t min =3D (min_engine_clock_in_sr > ICELAND_MINIMUM_ENGINE_CLO=
CK) ?
> +			min_engine_clock_in_sr : ICELAND_MINIMUM_ENGINE_CLOCK;
> +
> +	PP_ASSERT_WITH_CODE((engine_clock >=3D min),
> +			"Engine clock can't satisfy stutter requirement!", return 0);
> +
> +	for (i =3D ICELAND_MAX_DEEPSLEEP_DIVIDER_ID;; i--) {
> +		temp =3D engine_clock / (1 << i);
> +
> +		if(temp >=3D min || i =3D=3D 0)
> +			break;
> +	}
> +	return (uint8_t)i;
> +}
> +
> +/**
> + * Populates single SMC SCLK structure using the provided engine clock=

> + *
> + * @param    hwmgr      the address of the hardware manager
> + * @param    engine_clock the engine clock to use to populate the stru=
cture
> + * @param    sclk        the SMC SCLK structure to be populated
> + */
> +static int iceland_populate_single_graphic_level(struct pp_hwmgr *hwmg=
r,
> +		uint32_t engine_clock, uint16_t	sclk_activity_level_threshold,
> +		SMU71_Discrete_GraphicsLevel *graphic_level)
> +{
> +	int result;
> +	uint32_t threshold;
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +
> +	result =3D iceland_calculate_sclk_params(hwmgr, engine_clock, graphic=
_level);
> +
> +
> +	/* populate graphics levels*/
> +	result =3D iceland_get_dependecy_volt_by_clk(hwmgr,
> +			hwmgr->dyn_state.vddc_dependency_on_sclk, engine_clock, &graphic_le=
vel->MinVddc);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D result),
> +		"can not find VDDC voltage value for VDDC engine clock dependency ta=
ble", return result);
> +
> +	/* SCLK frequency in units of 10KHz*/
> +	graphic_level->SclkFrequency =3D engine_clock;
> +
> +	/*
> +	 * Minimum VDDC phases required to support this level, it
> +	 * should get from dependence table.
> +	 */
> +	graphic_level->MinVddcPhases =3D 1;
> +
> +	if (data->vddc_phase_shed_control) {
> +		iceland_populate_phase_value_based_on_sclk(hwmgr,
> +				hwmgr->dyn_state.vddc_phase_shed_limits_table,
> +				engine_clock,
> +				&graphic_level->MinVddcPhases);
> +	}
> +
> +	/* Indicates maximum activity level for this performance level. 50% f=
or now*/
> +	graphic_level->ActivityLevel =3D sclk_activity_level_threshold;
> +
> +	graphic_level->CcPwrDynRm =3D 0;
> +	graphic_level->CcPwrDynRm1 =3D 0;
> +	/* this level can be used if activity is high enough.*/
> +	graphic_level->EnabledForActivity =3D 1;
> +	/* this level can be used for throttling.*/
> +	graphic_level->EnabledForThrottle =3D 1;
> +	graphic_level->UpHyst =3D 0;
> +	graphic_level->DownHyst =3D 100;
> +	graphic_level->VoltageDownHyst =3D 0;
> +	graphic_level->PowerThrottle =3D 0;
> +
> +	threshold =3D engine_clock * data->fast_watermark_threshold / 100;
> +
> +	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
> +			PHM_PlatformCaps_SclkDeepSleep)) {
> +		graphic_level->DeepSleepDivId =3D
> +				iceland_get_sleep_divider_id_from_clock(hwmgr, engine_clock,
> +						data->display_timing.min_clock_insr);
> +	}
> +
> +	/* Default to slow, highest DPM level will be set to PPSMC_DISPLAY_WA=
TERMARK_LOW later.*/
> +	graphic_level->DisplayWatermark =3D PPSMC_DISPLAY_WATERMARK_LOW;
> +
> +	if (0 =3D=3D result) {
> +		graphic_level->MinVddc =3D PP_HOST_TO_SMC_UL(graphic_level->MinVddc =
* VOLTAGE_SCALE);
> +		/* CONVERT_FROM_HOST_TO_SMC_UL(graphic_level->MinVoltage);*/
> +		CONVERT_FROM_HOST_TO_SMC_UL(graphic_level->MinVddcPhases);
> +		CONVERT_FROM_HOST_TO_SMC_UL(graphic_level->SclkFrequency);
> +		CONVERT_FROM_HOST_TO_SMC_US(graphic_level->ActivityLevel);
> +		CONVERT_FROM_HOST_TO_SMC_UL(graphic_level->CgSpllFuncCntl3);
> +		CONVERT_FROM_HOST_TO_SMC_UL(graphic_level->CgSpllFuncCntl4);
> +		CONVERT_FROM_HOST_TO_SMC_UL(graphic_level->SpllSpreadSpectrum);
> +		CONVERT_FROM_HOST_TO_SMC_UL(graphic_level->SpllSpreadSpectrum2);
> +		CONVERT_FROM_HOST_TO_SMC_UL(graphic_level->CcPwrDynRm);
> +		CONVERT_FROM_HOST_TO_SMC_UL(graphic_level->CcPwrDynRm1);
> +	}
> +
> +	return result;
> +}
> +
> +/**
> + * Populates all SMC SCLK levels' structure based on the trimmed allow=
ed dpm engine clock states
> + *
> + * @param    hwmgr      the address of the hardware manager
> + */
> +static int iceland_populate_all_graphic_levels(struct pp_hwmgr *hwmgr)=

> +{
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +	struct iceland_dpm_table *dpm_table =3D &data->dpm_table;
> +	int result =3D 0;
> +	uint32_t level_array_adress =3D data->dpm_table_start +
> +		offsetof(SMU71_Discrete_DpmTable, GraphicsLevel);
> +
> +	uint32_t level_array_size =3D sizeof(SMU71_Discrete_GraphicsLevel) * =
SMU71_MAX_LEVELS_GRAPHICS;
> +	SMU71_Discrete_GraphicsLevel *levels =3D data->smc_state_table.Graphi=
csLevel;
> +	uint32_t i;
> +	uint8_t highest_pcie_level_enabled =3D 0, lowest_pcie_level_enabled =3D=
 0, mid_pcie_level_enabled =3D 0, count =3D 0;
> +	memset(levels, 0x00, level_array_size);
> +
> +	for (i =3D 0; i < dpm_table->sclk_table.count; i++) {
> +		result =3D iceland_populate_single_graphic_level(hwmgr,
> +					dpm_table->sclk_table.dpm_levels[i].value,
> +					(uint16_t)data->activity_target[i],
> +					&(data->smc_state_table.GraphicsLevel[i]));
> +		if (0 !=3D result)
> +			return result;
> +
> +		/* Making sure only DPM level 0-1 have Deep Sleep Div ID populated. =
*/
> +		if (i > 1)
> +			data->smc_state_table.GraphicsLevel[i].DeepSleepDivId =3D 0;
> +	}
> +
> +	/* set highest level watermark to high */
> +	if (dpm_table->sclk_table.count > 1)
> +		data->smc_state_table.GraphicsLevel[dpm_table->sclk_table.count-1].D=
isplayWatermark =3D
> +			PPSMC_DISPLAY_WATERMARK_HIGH;
> +
> +	data->smc_state_table.GraphicsDpmLevelCount =3D
> +		(uint8_t)dpm_table->sclk_table.count;
> +	data->dpm_level_enable_mask.sclk_dpm_enable_mask =3D
> +		iceland_get_dpm_level_enable_mask_value(&dpm_table->sclk_table);
> +
> +	while ((data->dpm_level_enable_mask.pcie_dpm_enable_mask &
> +				(1 << (highest_pcie_level_enabled + 1))) !=3D 0) {
> +		highest_pcie_level_enabled++;
> +	}
> +
> +	while ((data->dpm_level_enable_mask.pcie_dpm_enable_mask &
> +	       (1 << lowest_pcie_level_enabled)) =3D=3D 0) {
> +		lowest_pcie_level_enabled++;
> +	}
> +
> +	while ((count < highest_pcie_level_enabled) &&
> +			((data->dpm_level_enable_mask.pcie_dpm_enable_mask &
> +				(1 << (lowest_pcie_level_enabled + 1 + count))) =3D=3D 0)) {
> +		count++;
> +	}
> +
> +	mid_pcie_level_enabled =3D (lowest_pcie_level_enabled+1+count) < high=
est_pcie_level_enabled ?
> +		(lowest_pcie_level_enabled + 1 + count) : highest_pcie_level_enabled=
;
> +
> +	/* set pcieDpmLevel to highest_pcie_level_enabled*/
> +	for (i =3D 2; i < dpm_table->sclk_table.count; i++) {
> +		data->smc_state_table.GraphicsLevel[i].pcieDpmLevel =3D highest_pcie=
_level_enabled;
> +	}
> +
> +	/* set pcieDpmLevel to lowest_pcie_level_enabled*/
> +	data->smc_state_table.GraphicsLevel[0].pcieDpmLevel =3D lowest_pcie_l=
evel_enabled;
> +
> +	/* set pcieDpmLevel to mid_pcie_level_enabled*/
> +	data->smc_state_table.GraphicsLevel[1].pcieDpmLevel =3D mid_pcie_leve=
l_enabled;
> +
> +	for (i =3D 0; i < dpm_table->sclk_table.count; i++)
> +
> +	/* level count will send to smc once at init smc table and never chan=
ge*/
> +	result =3D iceland_copy_bytes_to_smc(hwmgr->smumgr, level_array_adres=
s, (uint8_t *)levels, (uint32_t)level_array_size, data->sram_end);
> +
> +	if (0 !=3D result)
> +		return result;
> +
> +	return 0;
> +}
> +
> +/**
> + * Populates all SMC MCLK levels' structure based on the trimmed allow=
ed dpm memory clock states
> + *
> + * @param    hwmgr      the address of the hardware manager
> + */
> +
> +static int iceland_populate_all_memory_levels(struct pp_hwmgr *hwmgr)
> +{
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +	struct iceland_dpm_table *dpm_table =3D &data->dpm_table;
> +	int result;
> +	/* populate MCLK dpm table to SMU7 */
> +	uint32_t level_array_adress =3D data->dpm_table_start + offsetof(SMU7=
1_Discrete_DpmTable, MemoryLevel);
> +	uint32_t level_array_size =3D sizeof(SMU71_Discrete_MemoryLevel) * SM=
U71_MAX_LEVELS_MEMORY;
> +	SMU71_Discrete_MemoryLevel *levels =3D data->smc_state_table.MemoryLe=
vel;
> +	uint32_t i;
> +
> +	memset(levels, 0x00, level_array_size);
> +
> +	for (i =3D 0; i < dpm_table->mclk_table.count; i++) {
> +		PP_ASSERT_WITH_CODE((0 !=3D dpm_table->mclk_table.dpm_levels[i].valu=
e),
> +			"can not populate memory level as memory clock is zero", return -1)=
;
> +		result =3D iceland_populate_single_memory_level(hwmgr, dpm_table->mc=
lk_table.dpm_levels[i].value,
> +			&(data->smc_state_table.MemoryLevel[i]));
> +		if (0 !=3D result) {
> +			return result;
> +		}
> +	}
> +
> +	/* Only enable level 0 for now.*/
> +	data->smc_state_table.MemoryLevel[0].EnabledForActivity =3D 1;
> +
> +	/*
> +	* in order to prevent MC activity from stutter mode to push DPM up.
> +	* the UVD change complements this by putting the MCLK in a higher sta=
te
> +	* by default such that we are not effected by up threshold or and MCL=
K DPM latency.
> +	*/
> +	data->smc_state_table.MemoryLevel[0].ActivityLevel =3D 0x1F;
> +	CONVERT_FROM_HOST_TO_SMC_US(data->smc_state_table.MemoryLevel[0].Acti=
vityLevel);
> +
> +	data->smc_state_table.MemoryDpmLevelCount =3D (uint8_t)dpm_table->mcl=
k_table.count;
> +	data->dpm_level_enable_mask.mclk_dpm_enable_mask =3D iceland_get_dpm_=
level_enable_mask_value(&dpm_table->mclk_table);
> +	/* set highest level watermark to high*/
> +	data->smc_state_table.MemoryLevel[dpm_table->mclk_table.count-1].Disp=
layWatermark =3D PPSMC_DISPLAY_WATERMARK_HIGH;
> +
> +	/* level count will send to smc once at init smc table and never chan=
ge*/
> +	result =3D iceland_copy_bytes_to_smc(hwmgr->smumgr,
> +		level_array_adress, (uint8_t *)levels, (uint32_t)level_array_size, d=
ata->sram_end);
> +
> +	if (0 !=3D result) {
> +		return result;
> +	}
> +
> +	return 0;
> +}
> +
> +struct ICELAND_DLL_SPEED_SETTING
> +{
> +	uint16_t        Min;           /* Minimum Data Rate*/
> +	uint16_t        Max;           /* Maximum Data Rate*/
> +	uint32_t	dll_speed;     /* The desired DLL_SPEED setting*/
> +};
> +
> +static int iceland_populate_ulv_level(struct pp_hwmgr *hwmgr, SMU71_Di=
screte_Ulv *pstate)
> +{
> +	int result =3D 0;
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +	uint32_t voltage_response_time, ulv_voltage;
> +
> +	pstate->CcPwrDynRm =3D 0;
> +	pstate->CcPwrDynRm1 =3D 0;
> +
> +	//backbiasResponseTime is use for ULV state voltage value.
> +	result =3D pp_tables_get_response_times(hwmgr, &voltage_response_time=
, &ulv_voltage);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D result), "can not get ULV voltage value=
", return result;);
> +
> +	if(!ulv_voltage) {
> +		data->ulv.ulv_supported =3D false;
> +		return 0;
> +	}
> +
> +	if (ICELAND_VOLTAGE_CONTROL_BY_SVID2 !=3D data->voltage_control) {
> +		/* use minimum voltage if ulv voltage in pptable is bigger than mini=
mum voltage */
> +		if (ulv_voltage > hwmgr->dyn_state.vddc_dependency_on_sclk->entries[=
0].v) {
> +			pstate->VddcOffset =3D 0;
> +		}
> +		else {
> +			/* used in SMIO Mode. not implemented for now. this is backup only =
for CI. */
> +			pstate->VddcOffset =3D (uint16_t)(hwmgr->dyn_state.vddc_dependency_=
on_sclk->entries[0].v - ulv_voltage);
> +		}
> +	} else {
> +		/* use minimum voltage if ulv voltage in pptable is bigger than mini=
mum voltage */
> +		if(ulv_voltage > hwmgr->dyn_state.vddc_dependency_on_sclk->entries[0=
].v) {
> +			pstate->VddcOffsetVid =3D 0;
> +		} else {
> +			/* used in SVI2 Mode */
> +			pstate->VddcOffsetVid =3D (uint8_t)((hwmgr->dyn_state.vddc_dependen=
cy_on_sclk->entries[0].v - ulv_voltage) * VOLTAGE_VID_OFFSET_SCALE2 / VOL=
TAGE_VID_OFFSET_SCALE1);
> +		}
> +	}
> +
> +	/* used in SVI2 Mode to shed phase */
> +	pstate->VddcPhase =3D (data->vddc_phase_shed_control) ? 0 : 1;
> +
> +	if (0 =3D=3D result) {
> +		CONVERT_FROM_HOST_TO_SMC_UL(pstate->CcPwrDynRm);
> +		CONVERT_FROM_HOST_TO_SMC_UL(pstate->CcPwrDynRm1);
> +		CONVERT_FROM_HOST_TO_SMC_US(pstate->VddcOffset);
> +	}
> +
> +	return result;
> +}
> +
> +static int iceland_populate_ulv_state(struct pp_hwmgr *hwmgr, SMU71_Di=
screte_Ulv *ulv)
> +{
> +	return iceland_populate_ulv_level(hwmgr, ulv);
> +}
> +
> +static int iceland_populate_smc_initial_state(struct pp_hwmgr *hwmgr)
> +{
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +	uint8_t count, level;
> +
> +	count =3D (uint8_t)(hwmgr->dyn_state.vddc_dependency_on_sclk->count);=

> +
> +	for (level =3D 0; level < count; level++) {
> +		if (hwmgr->dyn_state.vddc_dependency_on_sclk->entries[level].clk
> +			 >=3D data->vbios_boot_state.sclk_bootup_value) {
> +			data->smc_state_table.GraphicsBootLevel =3D level;
> +			break;
> +		}
> +	}
> +
> +	count =3D (uint8_t)(hwmgr->dyn_state.vddc_dependency_on_mclk->count);=

> +
> +	for (level =3D 0; level < count; level++) {
> +		if (hwmgr->dyn_state.vddc_dependency_on_mclk->entries[level].clk
> +			>=3D data->vbios_boot_state.mclk_bootup_value) {
> +			data->smc_state_table.MemoryBootLevel =3D level;
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * Initializes the SMC table and uploads it
> + *
> + * @param    hwmgr  the address of the powerplay hardware manager.
> + * @param    pInput  the pointer to input data (PowerState)
> + * @return   always 0
> + */
> +int iceland_init_smc_table(struct pp_hwmgr *hwmgr)
> +{
> +	int result;
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +	SMU71_Discrete_DpmTable  *table =3D &(data->smc_state_table);
> +	const struct phw_iceland_ulv_parm *ulv =3D &(data->ulv);
> +
> +	result =3D iceland_setup_default_dpm_tables(hwmgr);
> +	PP_ASSERT_WITH_CODE(0 =3D=3D result,
> +		"Failed to setup default DPM tables!", return result;);
> +	memset(&(data->smc_state_table), 0x00, sizeof(data->smc_state_table))=
;
> +
> +	if (ICELAND_VOLTAGE_CONTROL_NONE !=3D data->voltage_control) {
> +		iceland_populate_smc_voltage_tables(hwmgr, table);
> +	}
> +
> +	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
> +			PHM_PlatformCaps_AutomaticDCTransition)) {
> +		table->SystemFlags |=3D PPSMC_SYSTEMFLAG_GPIO_DC;
> +	}
> +
> +	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
> +			PHM_PlatformCaps_StepVddc)) {
> +		table->SystemFlags |=3D PPSMC_SYSTEMFLAG_STEPVDDC;
> +	}
> +
> +	if (data->is_memory_GDDR5) {
> +		table->SystemFlags |=3D PPSMC_SYSTEMFLAG_GDDR5;
> +	}
> +
> +	if (ulv->ulv_supported) {
> +		result =3D iceland_populate_ulv_state(hwmgr, &data->ulv_setting);
> +		PP_ASSERT_WITH_CODE(0 =3D=3D result,
> +			"Failed to initialize ULV state!", return result;);
> +
> +		cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC,
> +			ixCG_ULV_PARAMETER, ulv->ch_ulv_parameter);
> +	}
> +
> +	result =3D iceland_populate_smc_link_level(hwmgr, table);
> +	PP_ASSERT_WITH_CODE(0 =3D=3D result,
> +		"Failed to initialize Link Level!", return result;);
> +
> +	result =3D iceland_populate_all_graphic_levels(hwmgr);
> +	PP_ASSERT_WITH_CODE(0 =3D=3D result,
> +		"Failed to initialize Graphics Level!", return result;);
> +
> +	result =3D iceland_populate_all_memory_levels(hwmgr);
> +	PP_ASSERT_WITH_CODE(0 =3D=3D result,
> +		"Failed to initialize Memory Level!", return result;);
> +
> +	result =3D iceland_populate_smc_acpi_level(hwmgr, table);
> +	PP_ASSERT_WITH_CODE(0 =3D=3D result,
> +		"Failed to initialize ACPI Level!", return result;);
> +
> +	result =3D iceland_populate_smc_vce_level(hwmgr, table);
> +	PP_ASSERT_WITH_CODE(0 =3D=3D result,
> +		"Failed to initialize VCE Level!", return result;);
> +
> +	result =3D iceland_populate_smc_acp_level(hwmgr, table);
> +	PP_ASSERT_WITH_CODE(0 =3D=3D result,
> +		"Failed to initialize ACP Level!", return result;);
> +
> +	result =3D iceland_populate_smc_samu_level(hwmgr, table);
> +	PP_ASSERT_WITH_CODE(0 =3D=3D result,
> +		"Failed to initialize SAMU Level!", return result;);
> +
> +	/*
> +	 * Since only the initial state is completely set up at this
> +	 * point (the other states are just copies of the boot state)
> +	 * we only need to populate the  ARB settings for the initial
> +	 * state.
> +	 */
> +	result =3D iceland_program_memory_timing_parameters(hwmgr);
> +	PP_ASSERT_WITH_CODE(0 =3D=3D result,
> +		"Failed to Write ARB settings for the initial state.", return result=
;);
> +
> +	result =3D iceland_populate_smc_uvd_level(hwmgr, table);
> +	PP_ASSERT_WITH_CODE(0 =3D=3D result,
> +		"Failed to initialize UVD Level!", return result;);
> +
> +	table->GraphicsBootLevel =3D 0;
> +	table->MemoryBootLevel =3D 0;
> +
> +	/* find boot level from dpm table */
> +	result =3D iceland_find_boot_level(&(data->dpm_table.sclk_table),
> +			data->vbios_boot_state.sclk_bootup_value,
> +			(uint32_t *)&(data->smc_state_table.GraphicsBootLevel));
> +
> +	if (result)
> +		pr_warning("VBIOS did not find boot engine clock value in dependency=
 table.\n");
> +
> +	result =3D iceland_find_boot_level(&(data->dpm_table.mclk_table),
> +				data->vbios_boot_state.mclk_bootup_value,
> +				(uint32_t *)&(data->smc_state_table.MemoryBootLevel));
> +
> +	if (result)
> +		pr_warning("VBIOS did not find boot memory clock value in dependency=
 table.\n");
> +
> +	table->BootVddc =3D data->vbios_boot_state.vddc_bootup_value;
> +	if (ICELAND_VOLTAGE_CONTROL_NONE =3D=3D data->vdd_ci_control) {
> +		table->BootVddci =3D table->BootVddc;
> +	}
> +	else {
> +		table->BootVddci =3D data->vbios_boot_state.vddci_bootup_value;
> +	}
> +	table->BootMVdd =3D data->vbios_boot_state.mvdd_bootup_value;
> +
> +	result =3D iceland_populate_smc_initial_state(hwmgr);
> +	PP_ASSERT_WITH_CODE(0 =3D=3D result, "Failed to initialize Boot State=
!", return result);
> +
> +	result =3D iceland_populate_bapm_parameters_in_dpm_table(hwmgr);
> +	PP_ASSERT_WITH_CODE(0 =3D=3D result, "Failed to populate BAPM Paramet=
ers!", return result);
> +
> +	table->GraphicsVoltageChangeEnable  =3D 1;
> +	table->GraphicsThermThrottleEnable  =3D 1;
> +	table->GraphicsInterval =3D 1;
> +	table->VoltageInterval  =3D 1;
> +	table->ThermalInterval  =3D 1;
> +	table->TemperatureLimitHigh =3D
> +		(data->thermal_temp_setting.temperature_high *
> +		 ICELAND_Q88_FORMAT_CONVERSION_UNIT) / PP_TEMPERATURE_UNITS_PER_CENT=
IGRADES;
> +	table->TemperatureLimitLow =3D
> +		(data->thermal_temp_setting.temperature_low *
> +		ICELAND_Q88_FORMAT_CONVERSION_UNIT) / PP_TEMPERATURE_UNITS_PER_CENTI=
GRADES;
> +	table->MemoryVoltageChangeEnable  =3D 1;
> +	table->MemoryInterval  =3D 1;
> +	table->VoltageResponseTime  =3D 0;
> +	table->PhaseResponseTime  =3D 0;
> +	table->MemoryThermThrottleEnable  =3D 1;
> +	table->PCIeBootLinkLevel =3D 0;
> +	table->PCIeGenInterval =3D 1;
> +
> +	result =3D iceland_populate_smc_svi2_config(hwmgr, table);
> +	PP_ASSERT_WITH_CODE(0 =3D=3D result,
> +		"Failed to populate SVI2 setting!", return result);
> +
> +	table->ThermGpio  =3D 17;
> +	table->SclkStepSize =3D 0x4000;
> +
> +	CONVERT_FROM_HOST_TO_SMC_UL(table->SystemFlags);
> +	CONVERT_FROM_HOST_TO_SMC_UL(table->SmioMaskVddcVid);
> +	CONVERT_FROM_HOST_TO_SMC_UL(table->SmioMaskVddcPhase);
> +	CONVERT_FROM_HOST_TO_SMC_UL(table->SmioMaskVddciVid);
> +	CONVERT_FROM_HOST_TO_SMC_UL(table->SmioMaskMvddVid);
> +	CONVERT_FROM_HOST_TO_SMC_UL(table->SclkStepSize);
> +	CONVERT_FROM_HOST_TO_SMC_US(table->TemperatureLimitHigh);
> +	CONVERT_FROM_HOST_TO_SMC_US(table->TemperatureLimitLow);
> +	CONVERT_FROM_HOST_TO_SMC_US(table->VoltageResponseTime);
> +	CONVERT_FROM_HOST_TO_SMC_US(table->PhaseResponseTime);
> +
> +	table->BootVddc =3D PP_HOST_TO_SMC_US(table->BootVddc * VOLTAGE_SCALE=
);
> +	table->BootVddci =3D PP_HOST_TO_SMC_US(table->BootVddci * VOLTAGE_SCA=
LE);
> +	table->BootMVdd =3D PP_HOST_TO_SMC_US(table->BootMVdd * VOLTAGE_SCALE=
);
> +
> +	/* Upload all dpm data to SMC memory.(dpm level, dpm level count etc)=
 */
> +	result =3D iceland_copy_bytes_to_smc(hwmgr->smumgr, data->dpm_table_s=
tart +
> +				offsetof(SMU71_Discrete_DpmTable, SystemFlags),
> +				(uint8_t *)&(table->SystemFlags),
> +				sizeof(SMU71_Discrete_DpmTable) - 3 * sizeof(SMU71_PIDController),=

> +				data->sram_end);
> +
> +	PP_ASSERT_WITH_CODE(0 =3D=3D result,
> +		"Failed to upload dpm data to SMC memory!", return result);
> +
> +	/* Upload all ulv setting to SMC memory.(dpm level, dpm level count e=
tc) */
> +	result =3D iceland_copy_bytes_to_smc(hwmgr->smumgr,
> +			data->ulv_settings_start,
> +			(uint8_t *)&(data->ulv_setting),
> +			sizeof(SMU71_Discrete_Ulv),
> +			data->sram_end);
> +
> +#if 0
> +	/* Notify SMC to follow new GPIO scheme */
> +	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
> +			PHM_PlatformCaps_AutomaticDCTransition)) {
> +		if (0 =3D=3D iceland_send_msg_to_smc(hwmgr->smumgr, PPSMC_MSG_UseNew=
GPIOScheme))
> +			phm_cap_set(hwmgr->platform_descriptor.platformCaps,
> +				PHM_PlatformCaps_SMCtoPPLIBAcdcGpioScheme);
> +	}
> +#endif
> +
> +	return result;
> +}
> +
> +int iceland_populate_mc_reg_address(struct pp_hwmgr *hwmgr, SMU71_Disc=
rete_MCRegisters *mc_reg_table)
> +{
> +	const struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->=
backend);
> +
> +	uint32_t i, j;
> +
> +	for (i =3D 0, j =3D 0; j < data->iceland_mc_reg_table.last; j++) {
> +		if (data->iceland_mc_reg_table.validflag & 1<<j) {
> +			PP_ASSERT_WITH_CODE(i < SMU71_DISCRETE_MC_REGISTER_ARRAY_SIZE,
> +				"Index of mc_reg_table->address[] array out of boundary", return -=
1);
> +			mc_reg_table->address[i].s0 =3D
> +				PP_HOST_TO_SMC_US(data->iceland_mc_reg_table.mc_reg_address[j].s0)=
;
> +			mc_reg_table->address[i].s1 =3D
> +				PP_HOST_TO_SMC_US(data->iceland_mc_reg_table.mc_reg_address[j].s1)=
;
> +			i++;
> +		}
> +	}
> +
> +	mc_reg_table->last =3D (uint8_t)i;
> +
> +	return 0;
> +}
> +
> +/* convert register values from driver to SMC format */
> +void iceland_convert_mc_registers(
> +	const phw_iceland_mc_reg_entry * pEntry,
> +	SMU71_Discrete_MCRegisterSet *pData,
> +	uint32_t numEntries, uint32_t validflag)
> +{
> +	uint32_t i, j;
> +
> +	for (i =3D 0, j =3D 0; j < numEntries; j++) {
> +		if (validflag & 1<<j) {
> +			pData->value[i] =3D PP_HOST_TO_SMC_UL(pEntry->mc_data[j]);
> +			i++;
> +		}
> +	}
> +}
> +
> +/* find the entry in the memory range table, then populate the value t=
o SMC's iceland_mc_reg_table */
> +int iceland_convert_mc_reg_table_entry_to_smc(
> +		struct pp_hwmgr *hwmgr,
> +		const uint32_t memory_clock,
> +		SMU71_Discrete_MCRegisterSet *mc_reg_table_data
> +		)
> +{
> +	const iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backend=
);
> +	uint32_t i =3D 0;
> +
> +	for (i =3D 0; i < data->iceland_mc_reg_table.num_entries; i++) {
> +		if (memory_clock <=3D
> +			data->iceland_mc_reg_table.mc_reg_table_entry[i].mclk_max) {
> +			break;
> +		}
> +	}
> +
> +	if ((i =3D=3D data->iceland_mc_reg_table.num_entries) && (i > 0))
> +		--i;
> +
> +	iceland_convert_mc_registers(&data->iceland_mc_reg_table.mc_reg_table=
_entry[i],
> +		mc_reg_table_data, data->iceland_mc_reg_table.last, data->iceland_mc=
_reg_table.validflag);
> +
> +	return 0;
> +}
> +
> +int iceland_convert_mc_reg_table_to_smc(struct pp_hwmgr *hwmgr,
> +		SMU71_Discrete_MCRegisters *mc_reg_table)
> +{
> +	int result =3D 0;
> +	iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backend);
> +	int res;
> +	uint32_t i;
> +
> +	for (i =3D 0; i < data->dpm_table.mclk_table.count; i++) {
> +		res =3D iceland_convert_mc_reg_table_entry_to_smc(
> +				hwmgr,
> +				data->dpm_table.mclk_table.dpm_levels[i].value,
> +				&mc_reg_table->data[i]
> +				);
> +
> +		if (0 !=3D res)
> +			result =3D res;
> +	}
> +
> +	return result;
> +}
> +
> +int iceland_populate_initial_mc_reg_table(struct pp_hwmgr *hwmgr)
> +{
> +	int result;
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +
> +	memset(&data->mc_reg_table, 0x00, sizeof(SMU71_Discrete_MCRegisters))=
;
> +	result =3D iceland_populate_mc_reg_address(hwmgr, &(data->mc_reg_tabl=
e));
> +	PP_ASSERT_WITH_CODE(0 =3D=3D result,
> +		"Failed to initialize MCRegTable for the MC register addresses!", re=
turn result;);
> +
> +	result =3D iceland_convert_mc_reg_table_to_smc(hwmgr, &data->mc_reg_t=
able);
> +	PP_ASSERT_WITH_CODE(0 =3D=3D result,
> +		"Failed to initialize MCRegTable for driver state!", return result;)=
;
> +
> +	return iceland_copy_bytes_to_smc(hwmgr->smumgr, data->mc_reg_table_st=
art,
> +			(uint8_t *)&data->mc_reg_table, sizeof(SMU71_Discrete_MCRegisters),=
 data->sram_end);
> +}
> +
> +int iceland_notify_smc_display_change(struct pp_hwmgr *hwmgr, bool has=
_display)
> +{
> +	PPSMC_Msg msg =3D has_display? (PPSMC_Msg)PPSMC_HasDisplay : (PPSMC_M=
sg)PPSMC_NoDisplay;
> +
> +	return (smum_send_msg_to_smc(hwmgr->smumgr, msg) =3D=3D 0) ?  0 : -1;=

> +}
> +
> +int iceland_enable_sclk_control(struct pp_hwmgr *hwmgr)
> +{
> +	PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC, SCLK_P=
WRMGT_CNTL, SCLK_PWRMGT_OFF, 0);
> +
> +	return 0;
> +}
> +
> +int iceland_enable_sclk_mclk_dpm(struct pp_hwmgr *hwmgr)
> +{
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +
> +	/* enable SCLK dpm */
> +	if (0 =3D=3D data->sclk_dpm_key_disabled) {
> +		PP_ASSERT_WITH_CODE(
> +				(0 =3D=3D smum_send_msg_to_smc(hwmgr->smumgr,
> +						   PPSMC_MSG_DPM_Enable)),
> +				"Failed to enable SCLK DPM during DPM Start Function!",
> +				return -1);
> +	}
> +
> +	/* enable MCLK dpm */
> +	if (0 =3D=3D data->mclk_dpm_key_disabled) {
> +		PP_ASSERT_WITH_CODE(
> +				(0 =3D=3D smum_send_msg_to_smc(hwmgr->smumgr,
> +					     PPSMC_MSG_MCLKDPM_Enable)),
> +				"Failed to enable MCLK DPM during DPM Start Function!",
> +				return -1);
> +
> +		PHM_WRITE_FIELD(hwmgr->device, MC_SEQ_CNTL_3, CAC_EN, 0x1);
> +
> +		cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC,
> +			ixLCAC_MC0_CNTL, 0x05);/* CH0,1 read */
> +		cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC,
> +			ixLCAC_MC1_CNTL, 0x05);/* CH2,3 read */
> +		cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC,
> +			ixLCAC_CPL_CNTL, 0x100005);/*Read */
> +
> +		udelay(10);
> +
> +		cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC,
> +			ixLCAC_MC0_CNTL, 0x400005);/* CH0,1 write */
> +		cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC,
> +			ixLCAC_MC1_CNTL, 0x400005);/* CH2,3 write */
> +		cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC,
> +			ixLCAC_CPL_CNTL, 0x500005);/* write */
> +
> +	}
> +
> +	return 0;
> +}
> +
> +int iceland_start_dpm(struct pp_hwmgr *hwmgr)
> +{
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +
> +	/* enable general power management */
> +	PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC, GENERA=
L_PWRMGT, GLOBAL_PWRMGT_EN, 1);
> +	/* enable sclk deep sleep */
> +	PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC, SCLK_P=
WRMGT_CNTL, DYNAMIC_PM_EN, 1);
> +
> +	/* prepare for PCIE DPM */
> +	PHM_WRITE_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC, SOFT_REGIST=
ERS_TABLE_12, VoltageChangeTimeout, 0x1000);
> +
> +	PHM_WRITE_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__PCIE, SWRST_COMM=
AND_1, RESETLC, 0x0);
> +
> +#if 0
> +	PP_ASSERT_WITH_CODE(
> +			(0 =3D=3D smum_send_msg_to_smc(hwmgr->smumgr,
> +					PPSMC_MSG_Voltage_Cntl_Enable)),
> +			"Failed to enable voltage DPM during DPM Start Function!",
> +			return -1);
> +#endif
> +
> +	if (0 !=3D iceland_enable_sclk_mclk_dpm(hwmgr)) {
> +		PP_ASSERT_WITH_CODE(0, "Failed to enable Sclk DPM and Mclk DPM!", re=
turn -1);
> +	}
> +
> +	/* enable PCIE dpm */
> +	if (0 =3D=3D data->pcie_dpm_key_disabled) {
> +		PP_ASSERT_WITH_CODE(
> +				(0 =3D=3D smum_send_msg_to_smc(hwmgr->smumgr,
> +						PPSMC_MSG_PCIeDPM_Enable)),
> +				"Failed to enable pcie DPM during DPM Start Function!",
> +				return -1
> +				);
> +	}
> +
> +	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
> +			    PHM_PlatformCaps_Falcon_QuickTransition)) {
> +		smum_send_msg_to_smc(hwmgr->smumgr,
> +				     PPSMC_MSG_EnableACDCGPIOInterrupt);
> +	}
> +
> +	return 0;
> +}
> +
> +static void iceland_set_dpm_event_sources(struct pp_hwmgr *hwmgr,
> +		uint32_t sources)
> +{
> +	bool protection;
> +	enum DPM_EVENT_SRC src;
> +
> +	switch (sources) {
> +	default:
> +		printk(KERN_ERR "Unknown throttling event sources.");
> +		/* fall through */
> +	case 0:
> +		protection =3D false;
> +		/* src is unused */
> +		break;
> +	case (1 << PHM_AutoThrottleSource_Thermal):
> +		protection =3D true;
> +		src =3D DPM_EVENT_SRC_DIGITAL;
> +		break;
> +	case (1 << PHM_AutoThrottleSource_External):
> +		protection =3D true;
> +		src =3D DPM_EVENT_SRC_EXTERNAL;
> +		break;
> +	case (1 << PHM_AutoThrottleSource_External) |
> +			(1 << PHM_AutoThrottleSource_Thermal):
> +		protection =3D true;
> +		src =3D DPM_EVENT_SRC_DIGITAL_OR_EXTERNAL;
> +		break;
> +	}
> +	/* Order matters - don't enable thermal protection for the wrong sour=
ce. */
> +	if (protection) {
> +		PHM_WRITE_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC, CG_THERMAL=
_CTRL,
> +				DPM_EVENT_SRC, src);
> +		PHM_WRITE_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC, GENERAL_PW=
RMGT,
> +				THERMAL_PROTECTION_DIS,
> +				!phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
> +						PHM_PlatformCaps_ThermalController));
> +	} else
> +		PHM_WRITE_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC, GENERAL_PW=
RMGT,
> +				THERMAL_PROTECTION_DIS, 1);
> +}
> +
> +static int iceland_enable_auto_throttle_source(struct pp_hwmgr *hwmgr,=

> +		PHM_AutoThrottleSource source)
> +{
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +
> +	if (!(data->active_auto_throttle_sources & (1 << source))) {
> +		data->active_auto_throttle_sources |=3D 1 << source;
> +		iceland_set_dpm_event_sources(hwmgr, data->active_auto_throttle_sour=
ces);
> +	}
> +	return 0;
> +}
> +
> +static int iceland_enable_thermal_auto_throttle(struct pp_hwmgr *hwmgr=
)
> +{
> +	return iceland_enable_auto_throttle_source(hwmgr, PHM_AutoThrottleSou=
rce_Thermal);
> +}
> +
> +static int iceland_tf_start_smc(struct pp_hwmgr *hwmgr)
> +{
> +	int ret =3D 0;
> +
> +	if (!iceland_is_smc_ram_running(hwmgr->smumgr))
> +		ret =3D iceland_smu_start_smc(hwmgr->smumgr);
> +
> +	return ret;
> +}
> +
> +static int iceland_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
> +{
> +	int tmp_result, result =3D 0;
> +
> +	if (cf_iceland_voltage_control(hwmgr)) {
> +		tmp_result =3D iceland_enable_voltage_control(hwmgr);
> +		PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result),
> +			"Failed to enable voltage control!", return tmp_result);
> +
> +		tmp_result =3D iceland_construct_voltage_tables(hwmgr);
> +		PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result),
> +			"Failed to contruct voltage tables!", return tmp_result);
> +	}
> +
> +	tmp_result =3D iceland_initialize_mc_reg_table(hwmgr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result),
> +		"Failed to initialize MC reg table!", return tmp_result);
> +
> +	tmp_result =3D iceland_program_static_screen_threshold_parameters(hwm=
gr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result),
> +		"Failed to program static screen threshold parameters!", return tmp_=
result);
> +
> +	tmp_result =3D iceland_enable_display_gap(hwmgr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result),
> +		"Failed to enable display gap!", return tmp_result);
> +
> +	tmp_result =3D iceland_program_voting_clients(hwmgr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result),
> +		"Failed to program voting clients!", return tmp_result);
> +
> +	tmp_result =3D iceland_upload_firmware(hwmgr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result),
> +		"Failed to upload firmware header!", return tmp_result);
> +
> +	tmp_result =3D iceland_process_firmware_header(hwmgr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result),
> +		"Failed to process firmware header!", return tmp_result);
> +
> +	tmp_result =3D iceland_initial_switch_from_arb_f0_to_f1(hwmgr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result),
> +		"Failed to initialize switch from ArbF0 to F1!", return tmp_result);=

> +
> +	tmp_result =3D iceland_init_smc_table(hwmgr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result),
> +		"Failed to initialize SMC table!", return tmp_result);
> +
> +	tmp_result =3D iceland_populate_initial_mc_reg_table(hwmgr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result),
> +		"Failed to populate initialize MC Reg table!", return tmp_result);
> +
> +	tmp_result =3D iceland_populate_pm_fuses(hwmgr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result),
> +		"Failed to populate PM fuses!", return tmp_result);
> +
> +	/* start SMC */
> +	tmp_result =3D iceland_tf_start_smc(hwmgr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result),
> +		"Failed to start SMC!", return tmp_result);
> +
> +	/* enable SCLK control */
> +	tmp_result =3D iceland_enable_sclk_control(hwmgr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result),
> +		"Failed to enable SCLK control!", return tmp_result);
> +
> +	/* enable DPM */
> +	tmp_result =3D iceland_start_dpm(hwmgr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result),
> +		"Failed to start DPM!", return tmp_result);
> +
> +	tmp_result =3D iceland_enable_smc_cac(hwmgr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result),
> +		"Failed to enable SMC CAC!", return tmp_result);
> +
> +	tmp_result =3D iceland_enable_power_containment(hwmgr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result),
> +		"Failed to enable power containment!", return tmp_result);
> +
> +	tmp_result =3D iceland_power_control_set_level(hwmgr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result),
> +		"Failed to power control set level!", result =3D tmp_result);
> +
> +	tmp_result =3D iceland_enable_thermal_auto_throttle(hwmgr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result),
> +			"Failed to enable thermal auto throttle!", result =3D tmp_result);
> +
> +	return result;
> +}
> +
> +static int iceland_hwmgr_backend_fini(struct pp_hwmgr *hwmgr)
> +{
> +	return phm_hwmgr_backend_fini(hwmgr);
> +}
> +
> +static void iceland_initialize_dpm_defaults(struct pp_hwmgr *hwmgr)
> +{
> +	iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backend);
> +	struct phw_iceland_ulv_parm *ulv;
> +
> +	ulv =3D &data->ulv;
> +	ulv->ch_ulv_parameter =3D PPICELAND_CGULVPARAMETER_DFLT;
> +	data->voting_rights_clients0 =3D PPICELAND_VOTINGRIGHTSCLIENTS_DFLT0;=

> +	data->voting_rights_clients1 =3D PPICELAND_VOTINGRIGHTSCLIENTS_DFLT1;=

> +	data->voting_rights_clients2 =3D PPICELAND_VOTINGRIGHTSCLIENTS_DFLT2;=

> +	data->voting_rights_clients3 =3D PPICELAND_VOTINGRIGHTSCLIENTS_DFLT3;=

> +	data->voting_rights_clients4 =3D PPICELAND_VOTINGRIGHTSCLIENTS_DFLT4;=

> +	data->voting_rights_clients5 =3D PPICELAND_VOTINGRIGHTSCLIENTS_DFLT5;=

> +	data->voting_rights_clients6 =3D PPICELAND_VOTINGRIGHTSCLIENTS_DFLT6;=

> +	data->voting_rights_clients7 =3D PPICELAND_VOTINGRIGHTSCLIENTS_DFLT7;=

> +
> +	data->static_screen_threshold_unit =3D PPICELAND_STATICSCREENTHRESHOL=
DUNIT_DFLT;
> +	data->static_screen_threshold =3D PPICELAND_STATICSCREENTHRESHOLD_DFL=
T;
> +
> +	phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
> +		      PHM_PlatformCaps_ABM);
> +	phm_cap_set(hwmgr->platform_descriptor.platformCaps,
> +		    PHM_PlatformCaps_NonABMSupportInPPLib);
> +
> +	phm_cap_set(hwmgr->platform_descriptor.platformCaps,
> +		    PHM_PlatformCaps_DynamicACTiming);
> +
> +	phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
> +		      PHM_PlatformCaps_DisableMemoryTransition);
> +
> +	iceland_initialize_power_tune_defaults(hwmgr);
> +
> +	data->mclk_strobe_mode_threshold =3D 40000;
> +	data->mclk_stutter_mode_threshold =3D 30000;
> +	data->mclk_edc_enable_threshold =3D 40000;
> +	data->mclk_edc_wr_enable_threshold =3D 40000;
> +
> +	phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
> +		      PHM_PlatformCaps_DisableMCLS);
> +
> +	data->pcie_gen_performance.max =3D PP_PCIEGen1;
> +	data->pcie_gen_performance.min =3D PP_PCIEGen3;
> +	data->pcie_gen_power_saving.max =3D PP_PCIEGen1;
> +	data->pcie_gen_power_saving.min =3D PP_PCIEGen3;
> +
> +	data->pcie_lane_performance.max =3D 0;
> +	data->pcie_lane_performance.min =3D 16;
> +	data->pcie_lane_power_saving.max =3D 0;
> +	data->pcie_lane_power_saving.min =3D 16;
> +
> +	phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
> +		      PHM_PlatformCaps_SclkThrottleLowNotification);
> +}
> +
> +static int iceland_get_evv_voltage(struct pp_hwmgr *hwmgr)
> +{
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +	uint16_t    virtual_voltage_id;
> +	uint16_t    vddc =3D 0;
> +	uint16_t    i;
> +
> +	/* the count indicates actual number of entries */
> +	data->vddc_leakage.count =3D 0;
> +	data->vddci_leakage.count =3D 0;
> +
> +	if (!phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_Pla=
tformCaps_EVV)) {
> +		pr_err("Iceland should always support EVV\n");
> +		return -EINVAL;
> +	}
> +
> +	/* retrieve voltage for leakage ID (0xff01 + i) */
> +	for (i =3D 0; i < ICELAND_MAX_LEAKAGE_COUNT; i++) {
> +		virtual_voltage_id =3D ATOM_VIRTUAL_VOLTAGE_ID0 + i;
> +
> +		PP_ASSERT_WITH_CODE((0 =3D=3D atomctrl_get_voltage_evv(hwmgr, virtua=
l_voltage_id, &vddc)),
> +				    "Error retrieving EVV voltage value!\n", continue);
> +
> +		if (vddc >=3D 2000)
> +			pr_warning("Invalid VDDC value!\n");
> +
> +		if (vddc !=3D 0 && vddc !=3D virtual_voltage_id) {
> +			data->vddc_leakage.actual_voltage[data->vddc_leakage.count] =3D vdd=
c;
> +			data->vddc_leakage.leakage_id[data->vddc_leakage.count] =3D virtual=
_voltage_id;
> +			data->vddc_leakage.count++;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void iceland_patch_with_vddc_leakage(struct pp_hwmgr *hwmgr,
> +					    uint32_t *vddc)
> +{
> +	iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backend);
> +	uint32_t leakage_index;
> +	struct phw_iceland_leakage_voltage *leakage_table =3D &data->vddc_lea=
kage;
> +
> +	/* search for leakage voltage ID 0xff01 ~ 0xff08 */
> +	for (leakage_index =3D 0; leakage_index < leakage_table->count; leaka=
ge_index++) {
> +		/*
> +		 * If this voltage matches a leakage voltage ID, patch
> +		 * with actual leakage voltage.
> +		 */
> +		if (leakage_table->leakage_id[leakage_index] =3D=3D *vddc) {
> +			/*
> +			 * Need to make sure vddc is less than 2v or
> +			 * else, it could burn the ASIC.
> +			 */
> +			if (leakage_table->actual_voltage[leakage_index] >=3D 2000)
> +				pr_warning("Invalid VDDC value!\n");
> +			*vddc =3D leakage_table->actual_voltage[leakage_index];
> +			/* we found leakage voltage */
> +			break;
> +		}
> +	}
> +
> +	if (*vddc >=3D ATOM_VIRTUAL_VOLTAGE_ID0)
> +		pr_warning("Voltage value looks like a Leakage ID but it's not patch=
ed\n");
> +}
> +
> +static void iceland_patch_with_vddci_leakage(struct pp_hwmgr *hwmgr,
> +					     uint32_t *vddci)
> +{
> +	iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backend);
> +	uint32_t leakage_index;
> +	struct phw_iceland_leakage_voltage *leakage_table =3D &data->vddci_le=
akage;
> +
> +	/* search for leakage voltage ID 0xff01 ~ 0xff08 */
> +	for (leakage_index =3D 0; leakage_index < leakage_table->count; leaka=
ge_index++) {
> +		/*
> +		 * If this voltage matches a leakage voltage ID, patch
> +		 * with actual leakage voltage.
> +		 */
> +		if (leakage_table->leakage_id[leakage_index] =3D=3D *vddci) {
> +			*vddci =3D leakage_table->actual_voltage[leakage_index];
> +			/* we found leakage voltage */
> +			break;
> +		}
> +	}
> +
> +	if (*vddci >=3D ATOM_VIRTUAL_VOLTAGE_ID0)
> +		pr_warning("Voltage value looks like a Leakage ID but it's not patch=
ed\n");
> +}
> +
> +static int iceland_patch_vddc(struct pp_hwmgr *hwmgr,
> +			      struct phm_clock_voltage_dependency_table *tab)
> +{
> +	uint16_t i;
> +
> +	if (tab)
> +		for (i =3D 0; i < tab->count; i++)
> +			iceland_patch_with_vddc_leakage(hwmgr, &tab->entries[i].v);
> +
> +	return 0;
> +}
> +
> +static int iceland_patch_vddci(struct pp_hwmgr *hwmgr,
> +			       struct phm_clock_voltage_dependency_table *tab)
> +{
> +	uint16_t i;
> +
> +	if (tab)
> +		for (i =3D 0; i < tab->count; i++)
> +			iceland_patch_with_vddci_leakage(hwmgr, &tab->entries[i].v);
> +
> +	return 0;
> +}
> +
> +static int iceland_patch_vce_vddc(struct pp_hwmgr *hwmgr,
> +				  struct phm_vce_clock_voltage_dependency_table *tab)
> +{
> +	uint16_t i;
> +
> +	if (tab)
> +		for (i =3D 0; i < tab->count; i++)
> +			iceland_patch_with_vddc_leakage(hwmgr, &tab->entries[i].v);
> +
> +	return 0;
> +}
> +
> +
> +static int iceland_patch_uvd_vddc(struct pp_hwmgr *hwmgr,
> +				  struct phm_uvd_clock_voltage_dependency_table *tab)
> +{
> +	uint16_t i;
> +
> +	if (tab)
> +		for (i =3D 0; i < tab->count; i++)
> +			iceland_patch_with_vddc_leakage(hwmgr, &tab->entries[i].v);
> +
> +	return 0;
> +}
> +
> +static int iceland_patch_vddc_shed_limit(struct pp_hwmgr *hwmgr,
> +					 struct phm_phase_shedding_limits_table *tab)
> +{
> +	uint16_t i;
> +
> +	if (tab)
> +		for (i =3D 0; i < tab->count; i++)
> +			iceland_patch_with_vddc_leakage(hwmgr, &tab->entries[i].Voltage);
> +
> +	return 0;
> +}
> +
> +static int iceland_patch_samu_vddc(struct pp_hwmgr *hwmgr,
> +				   struct phm_samu_clock_voltage_dependency_table *tab)
> +{
> +	uint16_t i;
> +
> +	if (tab)
> +		for (i =3D 0; i < tab->count; i++)
> +			iceland_patch_with_vddc_leakage(hwmgr, &tab->entries[i].v);
> +
> +	return 0;
> +}
> +
> +static int iceland_patch_acp_vddc(struct pp_hwmgr *hwmgr,
> +				  struct phm_acp_clock_voltage_dependency_table *tab)
> +{
> +	uint16_t i;
> +
> +	if (tab)
> +		for (i =3D 0; i < tab->count; i++)
> +			iceland_patch_with_vddc_leakage(hwmgr, &tab->entries[i].v);
> +
> +	return 0;
> +}
> +
> +static int iceland_patch_limits_vddc(struct pp_hwmgr *hwmgr,
> +				     struct phm_clock_and_voltage_limits *tab)
> +{
> +	if (tab) {
> +		iceland_patch_with_vddc_leakage(hwmgr, (uint32_t *)&tab->vddc);
> +		iceland_patch_with_vddci_leakage(hwmgr, (uint32_t *)&tab->vddci);
> +	}
> +
> +	return 0;
> +}
> +
> +static int iceland_patch_cac_vddc(struct pp_hwmgr *hwmgr, struct phm_c=
ac_leakage_table *tab)
> +{
> +	uint32_t i;
> +	uint32_t vddc;
> +
> +	if (tab) {
> +		for (i =3D 0; i < tab->count; i++) {
> +			vddc =3D (uint32_t)(tab->entries[i].Vddc);
> +			iceland_patch_with_vddc_leakage(hwmgr, &vddc);
> +			tab->entries[i].Vddc =3D (uint16_t)vddc;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int iceland_patch_dependency_tables_with_leakage(struct pp_hwmg=
r *hwmgr)
> +{
> +	int tmp;
> +
> +	tmp =3D iceland_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dependency_on=
_sclk);
> +	if(tmp)
> +		return -EINVAL;
> +
> +	tmp =3D iceland_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dependency_on=
_mclk);
> +	if(tmp)
> +		return -EINVAL;
> +
> +	tmp =3D iceland_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dep_on_dal_pw=
rl);
> +	if(tmp)
> +		return -EINVAL;
> +
> +	tmp =3D iceland_patch_vddci(hwmgr, hwmgr->dyn_state.vddci_dependency_=
on_mclk);
> +	if(tmp)
> +		return -EINVAL;
> +
> +	tmp =3D iceland_patch_vce_vddc(hwmgr, hwmgr->dyn_state.vce_clock_volt=
age_dependency_table);
> +	if(tmp)
> +		return -EINVAL;
> +
> +	tmp =3D iceland_patch_uvd_vddc(hwmgr, hwmgr->dyn_state.uvd_clock_volt=
age_dependency_table);
> +	if(tmp)
> +		return -EINVAL;
> +
> +	tmp =3D iceland_patch_samu_vddc(hwmgr, hwmgr->dyn_state.samu_clock_vo=
ltage_dependency_table);
> +	if(tmp)
> +		return -EINVAL;
> +
> +	tmp =3D iceland_patch_acp_vddc(hwmgr, hwmgr->dyn_state.acp_clock_volt=
age_dependency_table);
> +	if(tmp)
> +		return -EINVAL;
> +
> +	tmp =3D iceland_patch_vddc_shed_limit(hwmgr, hwmgr->dyn_state.vddc_ph=
ase_shed_limits_table);
> +	if(tmp)
> +		return -EINVAL;
> +
> +	tmp =3D iceland_patch_limits_vddc(hwmgr, &hwmgr->dyn_state.max_clock_=
voltage_on_ac);
> +	if(tmp)
> +		return -EINVAL;
> +
> +	tmp =3D iceland_patch_limits_vddc(hwmgr, &hwmgr->dyn_state.max_clock_=
voltage_on_dc);
> +	if(tmp)
> +		return -EINVAL;
> +
> +	tmp =3D iceland_patch_cac_vddc(hwmgr, hwmgr->dyn_state.cac_leakage_ta=
ble);
> +	if(tmp)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int iceland_set_private_var_based_on_pptale(struct pp_hwmgr *hw=
mgr)
> +{
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +
> +	struct phm_clock_voltage_dependency_table *allowed_sclk_vddc_table =3D=
 hwmgr->dyn_state.vddc_dependency_on_sclk;
> +	struct phm_clock_voltage_dependency_table *allowed_mclk_vddc_table =3D=
 hwmgr->dyn_state.vddc_dependency_on_mclk;
> +	struct phm_clock_voltage_dependency_table *allowed_mclk_vddci_table =3D=
 hwmgr->dyn_state.vddci_dependency_on_mclk;
> +
> +	PP_ASSERT_WITH_CODE(allowed_sclk_vddc_table !=3D NULL,
> +		"VDDC dependency on SCLK table is missing. This table is mandatory\n=
", return -EINVAL);
> +	PP_ASSERT_WITH_CODE(allowed_sclk_vddc_table->count >=3D 1,
> +		"VDDC dependency on SCLK table has to have is missing. This table is=
 mandatory\n", return -EINVAL);
> +
> +	PP_ASSERT_WITH_CODE(allowed_mclk_vddc_table !=3D NULL,
> +		"VDDC dependency on MCLK table is missing. This table is mandatory\n=
", return -EINVAL);
> +	PP_ASSERT_WITH_CODE(allowed_mclk_vddc_table->count >=3D 1,
> +		"VDD dependency on MCLK table has to have is missing. This table is =
mandatory\n", return -EINVAL);
> +
> +	data->min_vddc_in_pp_table =3D (uint16_t)allowed_sclk_vddc_table->ent=
ries[0].v;
> +	data->max_vddc_in_pp_table =3D (uint16_t)allowed_sclk_vddc_table->ent=
ries[allowed_sclk_vddc_table->count - 1].v;
> +
> +	hwmgr->dyn_state.max_clock_voltage_on_ac.sclk =3D
> +		allowed_sclk_vddc_table->entries[allowed_sclk_vddc_table->count - 1]=
=2Eclk;
> +	hwmgr->dyn_state.max_clock_voltage_on_ac.mclk =3D
> +		allowed_mclk_vddc_table->entries[allowed_mclk_vddc_table->count - 1]=
=2Eclk;
> +	hwmgr->dyn_state.max_clock_voltage_on_ac.vddc =3D
> +		allowed_sclk_vddc_table->entries[allowed_sclk_vddc_table->count - 1]=
=2Ev;
> +
> +	if (allowed_mclk_vddci_table !=3D NULL && allowed_mclk_vddci_table->c=
ount >=3D 1) {
> +		data->min_vddci_in_pp_table =3D (uint16_t)allowed_mclk_vddci_table->=
entries[0].v;
> +		data->max_vddci_in_pp_table =3D (uint16_t)allowed_mclk_vddci_table->=
entries[allowed_mclk_vddci_table->count - 1].v;
> +	}
> +
> +	if (hwmgr->dyn_state.vddci_dependency_on_mclk !=3D NULL && hwmgr->dyn=
_state.vddci_dependency_on_mclk->count > 1)
> +		hwmgr->dyn_state.max_clock_voltage_on_ac.vddci =3D hwmgr->dyn_state.=
vddci_dependency_on_mclk->entries[hwmgr->dyn_state.vddci_dependency_on_mc=
lk->count - 1].v;
> +
> +	return 0;
> +}
> +
> +static int iceland_initializa_dynamic_state_adjustment_rule_settings(s=
truct pp_hwmgr *hwmgr)
> +{
> +	uint32_t table_size;
> +	struct phm_clock_voltage_dependency_table *table_clk_vlt;
> +
> +	hwmgr->dyn_state.mclk_sclk_ratio =3D 4;
> +	hwmgr->dyn_state.sclk_mclk_delta =3D 15000;      /* 150 MHz */
> +	hwmgr->dyn_state.vddc_vddci_delta =3D 200;       /* 200mV */
> +
> +	/* initialize vddc_dep_on_dal_pwrl table */
> +	table_size =3D sizeof(uint32_t) + 4 * sizeof(struct phm_clock_voltage=
_dependency_record);
> +	table_clk_vlt =3D (struct phm_clock_voltage_dependency_table *)kzallo=
c(table_size, GFP_KERNEL);

No need for the type cast here.

Kind Regards,
Edward.

> +
> +	if (NULL =3D=3D table_clk_vlt) {
> +		pr_err("[ powerplay ] Can not allocate space for vddc_dep_on_dal_pwr=
l! \n");
> +		return -ENOMEM;
> +	} else {
> +		table_clk_vlt->count =3D 4;
> +		table_clk_vlt->entries[0].clk =3D PP_DAL_POWERLEVEL_ULTRALOW;
> +		table_clk_vlt->entries[0].v =3D 0;
> +		table_clk_vlt->entries[1].clk =3D PP_DAL_POWERLEVEL_LOW;
> +		table_clk_vlt->entries[1].v =3D 720;
> +		table_clk_vlt->entries[2].clk =3D PP_DAL_POWERLEVEL_NOMINAL;
> +		table_clk_vlt->entries[2].v =3D 810;
> +		table_clk_vlt->entries[3].clk =3D PP_DAL_POWERLEVEL_PERFORMANCE;
> +		table_clk_vlt->entries[3].v =3D 900;
> +		hwmgr->dyn_state.vddc_dep_on_dal_pwrl =3D table_clk_vlt;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * Initializes the Volcanic Islands Hardware Manager
> + *
> + * @param   hwmgr the address of the powerplay hardware manager.
> + * @return   1 if success; otherwise appropriate error code.
> + */
> +static int iceland_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
> +{
> +	int result =3D 0;
> +	SMU71_Discrete_DpmTable *table =3D NULL;
> +	iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backend);
> +	pp_atomctrl_gpio_pin_assignment gpio_pin_assignment;
> +	bool stay_in_boot;
> +	struct phw_iceland_ulv_parm *ulv;
> +	struct cgs_system_info sys_info =3D {0};
> +
> +	PP_ASSERT_WITH_CODE((NULL !=3D hwmgr),
> +		"Invalid Parameter!", return -EINVAL;);
> +
> +	data->dll_defaule_on =3D 0;
> +	data->sram_end =3D SMC_RAM_END;
> +
> +	data->activity_target[0] =3D PPICELAND_TARGETACTIVITY_DFLT;
> +	data->activity_target[1] =3D PPICELAND_TARGETACTIVITY_DFLT;
> +	data->activity_target[2] =3D PPICELAND_TARGETACTIVITY_DFLT;
> +	data->activity_target[3] =3D PPICELAND_TARGETACTIVITY_DFLT;
> +	data->activity_target[4] =3D PPICELAND_TARGETACTIVITY_DFLT;
> +	data->activity_target[5] =3D PPICELAND_TARGETACTIVITY_DFLT;
> +	data->activity_target[6] =3D PPICELAND_TARGETACTIVITY_DFLT;
> +	data->activity_target[7] =3D PPICELAND_TARGETACTIVITY_DFLT;
> +
> +	data->mclk_activity_target =3D PPICELAND_MCLK_TARGETACTIVITY_DFLT;
> +
> +	data->sclk_dpm_key_disabled =3D 0;
> +	data->mclk_dpm_key_disabled =3D 0;
> +	data->pcie_dpm_key_disabled =3D 0;
> +	data->pcc_monitor_enabled =3D 0;
> +
> +	phm_cap_set(hwmgr->platform_descriptor.platformCaps,
> +		    PHM_PlatformCaps_UnTabledHardwareInterface);
> +
> +	data->gpio_debug =3D 0;
> +	data->engine_clock_data =3D 0;
> +	data->memory_clock_data =3D 0;
> +
> +	phm_cap_set(hwmgr->platform_descriptor.platformCaps,
> +		    PHM_PlatformCaps_SclkDeepSleep);
> +
> +	phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
> +		      PHM_PlatformCaps_SclkDeepSleepAboveLow);
> +
> +	phm_cap_set(hwmgr->platform_descriptor.platformCaps,
> +		    PHM_PlatformCaps_DynamicPatchPowerState);
> +
> +	phm_cap_set(hwmgr->platform_descriptor.platformCaps,
> +		    PHM_PlatformCaps_TablelessHardwareInterface);
> +
> +	/* Initializes DPM default values. */
> +	iceland_initialize_dpm_defaults(hwmgr);
> +
> +	/* Enable Platform EVV support. */
> +	phm_cap_set(hwmgr->platform_descriptor.platformCaps,
> +		    PHM_PlatformCaps_EVV);
> +
> +	/* Get leakage voltage based on leakage ID. */
> +	result =3D iceland_get_evv_voltage(hwmgr);
> +	if (result)
> +		goto failed;
> +
> +	/**
> +	 * Patch our voltage dependency table with actual leakage
> +	 * voltage. We need to perform leakage translation before it's
> +	 * used by other functions such as
> +	 * iceland_set_hwmgr_variables_based_on_pptable.
> +	 */
> +	result =3D iceland_patch_dependency_tables_with_leakage(hwmgr);
> +	if (result)
> +		goto failed;
> +
> +	/* Parse pptable data read from VBIOS. */
> +	result =3D iceland_set_private_var_based_on_pptale(hwmgr);
> +	if (result)
> +		goto failed;
> +
> +	/* ULV support */
> +	ulv =3D &(data->ulv);
> +	ulv->ulv_supported =3D 1;
> +
> +	/* Initalize Dynamic State Adjustment Rule Settings*/
> +	result =3D iceland_initializa_dynamic_state_adjustment_rule_settings(=
hwmgr);
> +	if (result) {
> +		pr_err("[ powerplay ] iceland_initializa_dynamic_state_adjustment_ru=
le_settings failed!\n");
> +		goto failed;
> +	}
> +
> +	data->voltage_control =3D ICELAND_VOLTAGE_CONTROL_NONE;
> +	data->vdd_ci_control =3D ICELAND_VOLTAGE_CONTROL_NONE;
> +	data->mvdd_control =3D ICELAND_VOLTAGE_CONTROL_NONE;
> +
> +	/*
> +	 * Hardcode thermal temperature settings for now, these will
> +	 * be overwritten if a custom policy exists.
> +	 */
> +	data->thermal_temp_setting.temperature_low =3D 99500;
> +	data->thermal_temp_setting.temperature_high =3D 100000;
> +	data->thermal_temp_setting.temperature_shutdown =3D 104000;
> +	data->uvd_enabled =3D false;
> +
> +	table =3D &data->smc_state_table;
> +
> +	if (atomctrl_get_pp_assign_pin(hwmgr, VDDC_VRHOT_GPIO_PINID,
> +				       &gpio_pin_assignment)) {
> +		table->VRHotGpio =3D gpio_pin_assignment.uc_gpio_pin_bit_shift;
> +		phm_cap_set(hwmgr->platform_descriptor.platformCaps,
> +			    PHM_PlatformCaps_RegulatorHot);
> +	} else {
> +		table->VRHotGpio =3D ICELAND_UNUSED_GPIO_PIN;
> +		phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
> +			      PHM_PlatformCaps_RegulatorHot);
> +	}
> +
> +	if (atomctrl_get_pp_assign_pin(hwmgr, PP_AC_DC_SWITCH_GPIO_PINID,
> +				       &gpio_pin_assignment)) {
> +		table->AcDcGpio =3D gpio_pin_assignment.uc_gpio_pin_bit_shift;
> +		phm_cap_set(hwmgr->platform_descriptor.platformCaps,
> +			    PHM_PlatformCaps_AutomaticDCTransition);
> +	} else {
> +		table->AcDcGpio =3D ICELAND_UNUSED_GPIO_PIN;
> +		phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
> +			      PHM_PlatformCaps_AutomaticDCTransition);
> +	}
> +
> +	/*
> +	 * If ucGPIO_ID=3DVDDC_PCC_GPIO_PINID in GPIO_LUTable, Peak.
> +	 * Current Control feature is enabled and we should program
> +	 * PCC HW register
> +	 */
> +	if (atomctrl_get_pp_assign_pin(hwmgr, VDDC_PCC_GPIO_PINID,
> +				       &gpio_pin_assignment)) {
> +		uint32_t temp_reg =3D cgs_read_ind_register(hwmgr->device,
> +							  CGS_IND_REG__SMC,
> +							  ixCNB_PWRMGT_CNTL);
> +
> +		switch (gpio_pin_assignment.uc_gpio_pin_bit_shift) {
> +		case 0:
> +			temp_reg =3D PHM_SET_FIELD(temp_reg,
> +				CNB_PWRMGT_CNTL, GNB_SLOW_MODE, 0x1);
> +			break;
> +		case 1:
> +			temp_reg =3D PHM_SET_FIELD(temp_reg,
> +				CNB_PWRMGT_CNTL, GNB_SLOW_MODE, 0x2);
> +			break;
> +		case 2:
> +			temp_reg =3D PHM_SET_FIELD(temp_reg,
> +				CNB_PWRMGT_CNTL, GNB_SLOW, 0x1);
> +			break;
> +		case 3:
> +			temp_reg =3D PHM_SET_FIELD(temp_reg,
> +				CNB_PWRMGT_CNTL, FORCE_NB_PS1, 0x1);
> +			break;
> +		case 4:
> +			temp_reg =3D PHM_SET_FIELD(temp_reg,
> +				CNB_PWRMGT_CNTL, DPM_ENABLED, 0x1);
> +			break;
> +		default:
> +			pr_warning("[ powerplay ] Failed to setup PCC HW register! Wrong GP=
IO assigned for VDDC_PCC_GPIO_PINID!\n");
> +			break;
> +		}
> +		cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC,
> +				       ixCNB_PWRMGT_CNTL, temp_reg);
> +	}
> +
> +	phm_cap_set(hwmgr->platform_descriptor.platformCaps,
> +		    PHM_PlatformCaps_EnableSMU7ThermalManagement);
> +	phm_cap_set(hwmgr->platform_descriptor.platformCaps,
> +		    PHM_PlatformCaps_SMU7);
> +
> +	if (atomctrl_is_voltage_controled_by_gpio_v3(hwmgr,
> +						     VOLTAGE_TYPE_VDDC,
> +						     VOLTAGE_OBJ_GPIO_LUT))
> +		data->voltage_control =3D ICELAND_VOLTAGE_CONTROL_BY_GPIO;
> +	else if (atomctrl_is_voltage_controled_by_gpio_v3(hwmgr,
> +							  VOLTAGE_TYPE_VDDC,
> +							  VOLTAGE_OBJ_SVID2))
> +		data->voltage_control =3D ICELAND_VOLTAGE_CONTROL_BY_SVID2;
> +
> +	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
> +			    PHM_PlatformCaps_ControlVDDCI)) {
> +		if (atomctrl_is_voltage_controled_by_gpio_v3(hwmgr,
> +							     VOLTAGE_TYPE_VDDCI,
> +							     VOLTAGE_OBJ_GPIO_LUT))
> +			data->vdd_ci_control =3D ICELAND_VOLTAGE_CONTROL_BY_GPIO;
> +		else if (atomctrl_is_voltage_controled_by_gpio_v3(hwmgr,
> +								  VOLTAGE_TYPE_VDDCI,
> +								  VOLTAGE_OBJ_SVID2))
> +			data->vdd_ci_control =3D ICELAND_VOLTAGE_CONTROL_BY_SVID2;
> +	}
> +
> +	if (data->vdd_ci_control =3D=3D ICELAND_VOLTAGE_CONTROL_NONE)
> +		phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
> +			      PHM_PlatformCaps_ControlVDDCI);
> +
> +	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
> +			    PHM_PlatformCaps_EnableMVDDControl)) {
> +		if (atomctrl_is_voltage_controled_by_gpio_v3(hwmgr,
> +							     VOLTAGE_TYPE_MVDDC,
> +							     VOLTAGE_OBJ_GPIO_LUT))
> +			data->mvdd_control =3D ICELAND_VOLTAGE_CONTROL_BY_GPIO;
> +		else if (atomctrl_is_voltage_controled_by_gpio_v3(hwmgr,
> +								  VOLTAGE_TYPE_MVDDC,
> +								  VOLTAGE_OBJ_SVID2))
> +			data->mvdd_control =3D ICELAND_VOLTAGE_CONTROL_BY_SVID2;
> +	}
> +
> +	if (data->mvdd_control =3D=3D ICELAND_VOLTAGE_CONTROL_NONE)
> +		phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
> +			      PHM_PlatformCaps_EnableMVDDControl);
> +
> +	data->vddc_phase_shed_control =3D false;
> +
> +	stay_in_boot =3D phm_cap_enabled(hwmgr->platform_descriptor.platformC=
aps,
> +				       PHM_PlatformCaps_StayInBootState);
> +
> +	/* iceland doesn't support UVD and VCE */
> +	phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
> +		      PHM_PlatformCaps_UVDPowerGating);
> +	phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
> +		      PHM_PlatformCaps_VCEPowerGating);
> +
> +	sys_info.size =3D sizeof(struct cgs_system_info);
> +	sys_info.info_id =3D CGS_SYSTEM_INFO_PG_FLAGS;
> +	result =3D cgs_query_system_info(hwmgr->device, &sys_info);
> +	if (!result) {
> +		if (sys_info.value & AMD_PG_SUPPORT_UVD)
> +			phm_cap_set(hwmgr->platform_descriptor.platformCaps,
> +				      PHM_PlatformCaps_UVDPowerGating);
> +		if (sys_info.value & AMD_PG_SUPPORT_VCE)
> +			phm_cap_set(hwmgr->platform_descriptor.platformCaps,
> +				      PHM_PlatformCaps_VCEPowerGating);
> +
> +		data->is_tlu_enabled =3D false;
> +		hwmgr->platform_descriptor.hardwareActivityPerformanceLevels =3D
> +			ICELAND_MAX_HARDWARE_POWERLEVELS;
> +		hwmgr->platform_descriptor.hardwarePerformanceLevels =3D 2;
> +		hwmgr->platform_descriptor.minimumClocksReductionPercentage  =3D 50;=

> +
> +		sys_info.size =3D sizeof(struct cgs_system_info);
> +		sys_info.info_id =3D CGS_SYSTEM_INFO_PCIE_GEN_INFO;
> +		result =3D cgs_query_system_info(hwmgr->device, &sys_info);
> +		if (result)
> +			data->pcie_gen_cap =3D AMDGPU_DEFAULT_PCIE_GEN_MASK;
> +		else
> +			data->pcie_gen_cap =3D (uint32_t)sys_info.value;
> +		if (data->pcie_gen_cap & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
> +			data->pcie_spc_cap =3D 20;
> +		sys_info.size =3D sizeof(struct cgs_system_info);
> +		sys_info.info_id =3D CGS_SYSTEM_INFO_PCIE_MLW;
> +		result =3D cgs_query_system_info(hwmgr->device, &sys_info);
> +		if (result)
> +			data->pcie_lane_cap =3D AMDGPU_DEFAULT_PCIE_MLW_MASK;
> +		else
> +			data->pcie_lane_cap =3D (uint32_t)sys_info.value;
> +	} else {
> +		/* Ignore return value in here, we are cleaning up a mess. */
> +		iceland_hwmgr_backend_fini(hwmgr);
> +	}
> +
> +	return 0;
> +failed:
> +	return result;
> +}
> +
> +static int iceland_get_num_of_entries(struct pp_hwmgr *hwmgr)
> +{
> +	int result;
> +	unsigned long ret =3D 0;
> +
> +	result =3D pp_tables_get_num_of_entries(hwmgr, &ret);
> +
> +	return result ? 0 : ret;
> +}
> +
> +static const unsigned long PhwIceland_Magic =3D (unsigned long)(PHM_VI=
slands_Magic);
> +
> +struct iceland_power_state *cast_phw_iceland_power_state(
> +				  struct pp_hw_power_state *hw_ps)
> +{
> +	if (hw_ps =3D=3D NULL)
> +		return NULL;
> +
> +	PP_ASSERT_WITH_CODE((PhwIceland_Magic =3D=3D hw_ps->magic),
> +				"Invalid Powerstate Type!",
> +				 return NULL);
> +
> +	return (struct iceland_power_state *)hw_ps;
> +}
> +
> +static int iceland_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
> +				struct pp_power_state  *prequest_ps,
> +			const struct pp_power_state *pcurrent_ps)
> +{
> +	struct iceland_power_state *iceland_ps =3D
> +				cast_phw_iceland_power_state(&prequest_ps->hardware);
> +
> +	uint32_t sclk;
> +	uint32_t mclk;
> +	struct PP_Clocks minimum_clocks =3D {0};
> +	bool disable_mclk_switching;
> +	bool disable_mclk_switching_for_frame_lock;
> +	struct cgs_display_info info =3D {0};
> +	const struct phm_clock_and_voltage_limits *max_limits;
> +	uint32_t i;
> +	iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backend);
> +
> +	int32_t count;
> +	int32_t stable_pstate_sclk =3D 0, stable_pstate_mclk =3D 0;
> +
> +	data->battery_state =3D (PP_StateUILabel_Battery =3D=3D prequest_ps->=
classification.ui_label);
> +
> +	PP_ASSERT_WITH_CODE(iceland_ps->performance_level_count =3D=3D 2,
> +				 "VI should always have 2 performance levels",
> +				 );
> +
> +	max_limits =3D (PP_PowerSource_AC =3D=3D hwmgr->power_source) ?
> +			&(hwmgr->dyn_state.max_clock_voltage_on_ac) :
> +			&(hwmgr->dyn_state.max_clock_voltage_on_dc);
> +
> +	if (PP_PowerSource_DC =3D=3D hwmgr->power_source) {
> +		for (i =3D 0; i < iceland_ps->performance_level_count; i++) {
> +			if (iceland_ps->performance_levels[i].memory_clock > max_limits->mc=
lk)
> +				iceland_ps->performance_levels[i].memory_clock =3D max_limits->mcl=
k;
> +			if (iceland_ps->performance_levels[i].engine_clock > max_limits->sc=
lk)
> +				iceland_ps->performance_levels[i].engine_clock =3D max_limits->scl=
k;
> +		}
> +	}
> +
> +	iceland_ps->vce_clocks.EVCLK =3D hwmgr->vce_arbiter.evclk;
> +	iceland_ps->vce_clocks.ECCLK =3D hwmgr->vce_arbiter.ecclk;
> +
> +	cgs_get_active_displays_info(hwmgr->device, &info);
> +
> +	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_Plat=
formCaps_StablePState)) {
> +
> +		max_limits =3D &(hwmgr->dyn_state.max_clock_voltage_on_ac);
> +		stable_pstate_sclk =3D (max_limits->sclk * 75) / 100;
> +
> +		for (count =3D hwmgr->dyn_state.vddc_dependency_on_sclk->count-1; co=
unt >=3D 0; count--) {
> +			if (stable_pstate_sclk >=3D hwmgr->dyn_state.vddc_dependency_on_scl=
k->entries[count].clk) {
> +				stable_pstate_sclk =3D hwmgr->dyn_state.vddc_dependency_on_sclk->e=
ntries[count].clk;
> +				break;
> +			}
> +		}
> +
> +		if (count < 0)
> +			stable_pstate_sclk =3D hwmgr->dyn_state.vddc_dependency_on_sclk->en=
tries[0].clk;
> +
> +		stable_pstate_mclk =3D max_limits->mclk;
> +
> +		minimum_clocks.engineClock =3D stable_pstate_sclk;
> +		minimum_clocks.memoryClock =3D stable_pstate_mclk;
> +	}
> +
> +	if (minimum_clocks.engineClock < hwmgr->gfx_arbiter.sclk)
> +		minimum_clocks.engineClock =3D hwmgr->gfx_arbiter.sclk;
> +
> +	if (minimum_clocks.memoryClock < hwmgr->gfx_arbiter.mclk)
> +		minimum_clocks.memoryClock =3D hwmgr->gfx_arbiter.mclk;
> +
> +	iceland_ps->sclk_threshold =3D hwmgr->gfx_arbiter.sclk_threshold;
> +
> +	if (0 !=3D hwmgr->gfx_arbiter.sclk_over_drive) {
> +		PP_ASSERT_WITH_CODE((hwmgr->gfx_arbiter.sclk_over_drive <=3D hwmgr->=
platform_descriptor.overdriveLimit.engineClock),
> +					"Overdrive sclk exceeds limit",
> +					hwmgr->gfx_arbiter.sclk_over_drive =3D hwmgr->platform_descriptor=
=2EoverdriveLimit.engineClock);
> +
> +		if (hwmgr->gfx_arbiter.sclk_over_drive >=3D hwmgr->gfx_arbiter.sclk)=

> +			iceland_ps->performance_levels[1].engine_clock =3D hwmgr->gfx_arbit=
er.sclk_over_drive;
> +	}
> +
> +	if (0 !=3D hwmgr->gfx_arbiter.mclk_over_drive) {
> +		PP_ASSERT_WITH_CODE((hwmgr->gfx_arbiter.mclk_over_drive <=3D hwmgr->=
platform_descriptor.overdriveLimit.memoryClock),
> +			"Overdrive mclk exceeds limit",
> +			hwmgr->gfx_arbiter.mclk_over_drive =3D hwmgr->platform_descriptor.o=
verdriveLimit.memoryClock);
> +
> +		if (hwmgr->gfx_arbiter.mclk_over_drive >=3D hwmgr->gfx_arbiter.mclk)=

> +			iceland_ps->performance_levels[1].memory_clock =3D hwmgr->gfx_arbit=
er.mclk_over_drive;
> +	}
> +
> +	disable_mclk_switching_for_frame_lock =3D phm_cap_enabled(
> +				    hwmgr->platform_descriptor.platformCaps,
> +				    PHM_PlatformCaps_DisableMclkSwitchingForFrameLock);
> +
> +	disable_mclk_switching =3D (1 < info.display_count) ||
> +				    disable_mclk_switching_for_frame_lock;
> +
> +	sclk  =3D iceland_ps->performance_levels[0].engine_clock;
> +	mclk  =3D iceland_ps->performance_levels[0].memory_clock;
> +
> +	if (disable_mclk_switching)
> +		mclk  =3D iceland_ps->performance_levels[iceland_ps->performance_lev=
el_count - 1].memory_clock;
> +
> +	if (sclk < minimum_clocks.engineClock)
> +		sclk =3D (minimum_clocks.engineClock > max_limits->sclk) ? max_limit=
s->sclk : minimum_clocks.engineClock;
> +
> +	if (mclk < minimum_clocks.memoryClock)
> +		mclk =3D (minimum_clocks.memoryClock > max_limits->mclk) ? max_limit=
s->mclk : minimum_clocks.memoryClock;
> +
> +	iceland_ps->performance_levels[0].engine_clock =3D sclk;
> +	iceland_ps->performance_levels[0].memory_clock =3D mclk;
> +
> +	iceland_ps->performance_levels[1].engine_clock =3D
> +		(iceland_ps->performance_levels[1].engine_clock >=3D iceland_ps->per=
formance_levels[0].engine_clock) ?
> +			      iceland_ps->performance_levels[1].engine_clock :
> +			      iceland_ps->performance_levels[0].engine_clock;
> +
> +	if (disable_mclk_switching) {
> +		if (mclk < iceland_ps->performance_levels[1].memory_clock)
> +			mclk =3D iceland_ps->performance_levels[1].memory_clock;
> +
> +		iceland_ps->performance_levels[0].memory_clock =3D mclk;
> +		iceland_ps->performance_levels[1].memory_clock =3D mclk;
> +	} else {
> +		if (iceland_ps->performance_levels[1].memory_clock < iceland_ps->per=
formance_levels[0].memory_clock)
> +			iceland_ps->performance_levels[1].memory_clock =3D iceland_ps->perf=
ormance_levels[0].memory_clock;
> +	}
> +
> +	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_Plat=
formCaps_StablePState)) {
> +		for (i=3D0; i < iceland_ps->performance_level_count; i++) {
> +			iceland_ps->performance_levels[i].engine_clock =3D stable_pstate_sc=
lk;
> +			iceland_ps->performance_levels[i].memory_clock =3D stable_pstate_mc=
lk;
> +			iceland_ps->performance_levels[i].pcie_gen =3D data->pcie_gen_perfo=
rmance.max;
> +			iceland_ps->performance_levels[i].pcie_lane =3D data->pcie_gen_perf=
ormance.max;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static bool iceland_is_dpm_running(struct pp_hwmgr *hwmgr)
> +{
> +	/*
> +	 * We return the status of Voltage Control instead of checking SCLK/M=
CLK DPM
> +	 * because we may have test scenarios that need us intentionly disabl=
e SCLK/MCLK DPM,
> +	 * whereas voltage control is a fundemental change that will not be d=
isabled
> +	 */
> +	return (0 =3D=3D PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_=
REG__SMC,
> +					FEATURE_STATUS, VOLTAGE_CONTROLLER_ON) ? 1 : 0);
> +}
> +
> +/**
> + * force DPM power State
> + *
> + * @param    hwmgr:  the address of the powerplay hardware manager.
> + * @param    n     :  DPM level
> + * @return   The response that came from the SMC.
> + */
> +int iceland_dpm_force_state(struct pp_hwmgr *hwmgr, uint32_t n)
> +{
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +
> +	/* Checking if DPM is running.  If we discover hang because of this, =
we should skip this message. */
> +	PP_ASSERT_WITH_CODE(0 =3D=3D iceland_is_dpm_running(hwmgr),
> +			"Trying to force SCLK when DPM is disabled", return -1;);
> +	if (0 =3D=3D data->sclk_dpm_key_disabled)
> +		return (0 =3D=3D smum_send_msg_to_smc_with_parameter(
> +							     hwmgr->smumgr,
> +							     PPSMC_MSG_DPM_ForceState,
> +							     n) ? 0 : 1);
> +
> +	return 0;
> +}
> +
> +/**
> + * force DPM power State
> + *
> + * @param    hwmgr:  the address of the powerplay hardware manager.
> + * @param    n     :  DPM level
> + * @return   The response that came from the SMC.
> + */
> +int iceland_dpm_force_state_mclk(struct pp_hwmgr *hwmgr, uint32_t n)
> +{
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +
> +	/* Checking if DPM is running.  If we discover hang because of this, =
we should skip this message. */
> +	PP_ASSERT_WITH_CODE(0 =3D=3D iceland_is_dpm_running(hwmgr),
> +			"Trying to Force MCLK when DPM is disabled", return -1;);
> +	if (0 =3D=3D data->mclk_dpm_key_disabled)
> +		return (0 =3D=3D smum_send_msg_to_smc_with_parameter(
> +								hwmgr->smumgr,
> +								PPSMC_MSG_MCLKDPM_ForceState,
> +								n) ? 0 : 1);
> +
> +	return 0;
> +}
> +
> +/**
> + * force DPM power State
> + *
> + * @param    hwmgr:  the address of the powerplay hardware manager.
> + * @param    n     :  DPM level
> + * @return   The response that came from the SMC.
> + */
> +int iceland_dpm_force_state_pcie(struct pp_hwmgr *hwmgr, uint32_t n)
> +{
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +
> +	/* Checking if DPM is running.  If we discover hang because of this, =
we should skip this message.*/
> +	PP_ASSERT_WITH_CODE(0 =3D=3D iceland_is_dpm_running(hwmgr),
> +			"Trying to Force PCIE level when DPM is disabled", return -1;);
> +	if (0 =3D=3D data->pcie_dpm_key_disabled)
> +		return (0 =3D=3D smum_send_msg_to_smc_with_parameter(
> +							     hwmgr->smumgr,
> +							     PPSMC_MSG_PCIeDPM_ForceLevel,
> +							     n) ? 0 : 1);
> +
> +	return 0;
> +}
> +
> +static int iceland_force_dpm_highest(struct pp_hwmgr *hwmgr)
> +{
> +	uint32_t level, tmp;
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +
> +	if (0 =3D=3D data->sclk_dpm_key_disabled) {
> +		/* SCLK */
> +		if (data->dpm_level_enable_mask.sclk_dpm_enable_mask !=3D 0) {
> +			level =3D 0;
> +			tmp =3D data->dpm_level_enable_mask.sclk_dpm_enable_mask;
> +			while (tmp >>=3D 1)
> +				level++ ;
> +
> +			if (0 !=3D level) {
> +				PP_ASSERT_WITH_CODE((0 =3D=3D iceland_dpm_force_state(hwmgr, level=
)),
> +					"force highest sclk dpm state failed!", return -1);
> +				PHM_WAIT_INDIRECT_FIELD(hwmgr->device,
> +					SMC_IND, TARGET_AND_CURRENT_PROFILE_INDEX, CURR_SCLK_INDEX, level=
);
> +			}
> +		}
> +	}
> +
> +	if (0 =3D=3D data->mclk_dpm_key_disabled) {
> +		/* MCLK */
> +		if (data->dpm_level_enable_mask.mclk_dpm_enable_mask !=3D 0) {
> +			level =3D 0;
> +			tmp =3D data->dpm_level_enable_mask.mclk_dpm_enable_mask;
> +			while (tmp >>=3D 1)
> +				level++ ;
> +
> +			if (0 !=3D level) {
> +				PP_ASSERT_WITH_CODE((0 =3D=3D iceland_dpm_force_state_mclk(hwmgr, =
level)),
> +					"force highest mclk dpm state failed!", return -1);
> +				PHM_WAIT_INDIRECT_FIELD(hwmgr->device, SMC_IND,
> +					TARGET_AND_CURRENT_PROFILE_INDEX, CURR_MCLK_INDEX, level);
> +			}
> +		}
> +	}
> +
> +	if (0 =3D=3D data->pcie_dpm_key_disabled) {
> +		/* PCIE */
> +		if (data->dpm_level_enable_mask.pcie_dpm_enable_mask !=3D 0) {
> +			level =3D 0;
> +			tmp =3D data->dpm_level_enable_mask.pcie_dpm_enable_mask;
> +			while (tmp >>=3D 1)
> +				level++ ;
> +
> +			if (0 !=3D level) {
> +				PP_ASSERT_WITH_CODE((0 =3D=3D iceland_dpm_force_state_pcie(hwmgr, =
level)),
> +					"force highest pcie dpm state failed!", return -1);
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static uint32_t iceland_get_lowest_enable_level(struct pp_hwmgr *hwmgr=
,
> +						uint32_t level_mask)
> +{
> +	uint32_t level =3D 0;
> +
> +	while (0 =3D=3D (level_mask & (1 << level)))
> +		level++;
> +
> +	return level;
> +}
> +
> +static int iceland_force_dpm_lowest(struct pp_hwmgr *hwmgr)
> +{
> +	uint32_t level;
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +
> +	/* for now force only sclk */
> +	if (0 !=3D data->dpm_level_enable_mask.sclk_dpm_enable_mask) {
> +		level =3D iceland_get_lowest_enable_level(hwmgr,
> +						      data->dpm_level_enable_mask.sclk_dpm_enable_mask);
> +
> +		PP_ASSERT_WITH_CODE((0 =3D=3D iceland_dpm_force_state(hwmgr, level))=
,
> +				    "force sclk dpm state failed!", return -1);
> +
> +		PHM_WAIT_INDIRECT_FIELD(hwmgr->device, SMC_IND,
> +					TARGET_AND_CURRENT_PROFILE_INDEX,
> +					CURR_SCLK_INDEX,
> +					level);
> +	}
> +
> +	return 0;
> +}
> +
> +int iceland_unforce_dpm_levels(struct pp_hwmgr *hwmgr)
> +{
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +
> +#if 0
> +	PP_ASSERT_WITH_CODE (0 =3D=3D iceland_is_dpm_running(hwmgr),
> +		"Trying to Unforce DPM when DPM is disabled. Returning without sendi=
ng SMC message.",
> +		return -1);
> +#endif
> +
> +	if (0 =3D=3D data->sclk_dpm_key_disabled) {
> +		PP_ASSERT_WITH_CODE((0 =3D=3D smum_send_msg_to_smc(
> +							     hwmgr->smumgr,
> +					PPSMC_MSG_NoForcedLevel)),
> +					   "unforce sclk dpm state failed!",
> +								return -1);
> +	}
> +
> +	if (0 =3D=3D data->pcie_dpm_key_disabled) {
> +		PP_ASSERT_WITH_CODE((0 =3D=3D smum_send_msg_to_smc(
> +							     hwmgr->smumgr,
> +					PPSMC_MSG_MCLKDPM_NoForcedLevel)),
> +					   "unforce mclk dpm state failed!",
> +								return -1);
> +	}
> +
> +	if (0 =3D=3D data->pcie_dpm_key_disabled) {
> +		PP_ASSERT_WITH_CODE((0 =3D=3D smum_send_msg_to_smc(
> +							     hwmgr->smumgr,
> +					PPSMC_MSG_PCIeDPM_UnForceLevel)),
> +					   "unforce pcie level failed!",
> +								return -1);
> +	}
> +
> +	return 0;
> +}
> +
> +static int iceland_force_dpm_level(struct pp_hwmgr *hwmgr,
> +		enum amd_dpm_forced_level level)
> +{
> +	int ret =3D 0;
> +
> +	switch (level) {
> +	case AMD_DPM_FORCED_LEVEL_HIGH:
> +		ret =3D iceland_force_dpm_highest(hwmgr);
> +		if (ret)
> +			return ret;
> +		break;
> +	case AMD_DPM_FORCED_LEVEL_LOW:
> +		ret =3D iceland_force_dpm_lowest(hwmgr);
> +		if (ret)
> +			return ret;
> +		break;
> +	case AMD_DPM_FORCED_LEVEL_AUTO:
> +		ret =3D iceland_unforce_dpm_levels(hwmgr);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	hwmgr->dpm_level =3D level;
> +	return ret;
> +}
> +
> +const struct iceland_power_state *cast_const_phw_iceland_power_state(
> +				 const struct pp_hw_power_state *hw_ps)
> +{
> +	if (hw_ps =3D=3D NULL)
> +		return NULL;
> +
> +	PP_ASSERT_WITH_CODE((PhwIceland_Magic =3D=3D hw_ps->magic),
> +			    "Invalid Powerstate Type!",
> +			    return NULL);
> +
> +	return (const struct iceland_power_state *)hw_ps;
> +}
> +
> +static int iceland_find_dpm_states_clocks_in_dpm_table(struct pp_hwmgr=
 *hwmgr, const void *input)
> +{
> +	const struct phm_set_power_state_input *states =3D (const struct phm_=
set_power_state_input *)input;
> +	const struct iceland_power_state *iceland_ps =3D cast_const_phw_icela=
nd_power_state(states->pnew_state);
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +	struct iceland_single_dpm_table *psclk_table =3D &(data->dpm_table.sc=
lk_table);
> +	uint32_t sclk =3D iceland_ps->performance_levels[iceland_ps->performa=
nce_level_count-1].engine_clock;
> +	struct iceland_single_dpm_table *pmclk_table =3D &(data->dpm_table.mc=
lk_table);
> +	uint32_t mclk =3D iceland_ps->performance_levels[iceland_ps->performa=
nce_level_count-1].memory_clock;
> +	struct PP_Clocks min_clocks =3D {0};
> +	uint32_t i;
> +	struct cgs_display_info info =3D {0};
> +
> +	data->need_update_smu7_dpm_table =3D 0;
> +
> +	for (i =3D 0; i < psclk_table->count; i++) {
> +		if (sclk =3D=3D psclk_table->dpm_levels[i].value)
> +			break;
> +	}
> +
> +	if (i >=3D psclk_table->count)
> +		data->need_update_smu7_dpm_table |=3D DPMTABLE_OD_UPDATE_SCLK;
> +	else {
> +		/*
> +		 * TODO: Check SCLK in DAL's minimum clocks in case DeepSleep
> +		 * divider update is required.
> +		 */
> +		if(data->display_timing.min_clock_insr !=3D min_clocks.engineClockIn=
SR)
> +			data->need_update_smu7_dpm_table |=3D DPMTABLE_UPDATE_SCLK;
> +	}
> +
> +	for (i =3D 0; i < pmclk_table->count; i++) {
> +		if (mclk =3D=3D pmclk_table->dpm_levels[i].value)
> +			break;
> +	}
> +
> +	if (i >=3D pmclk_table->count)
> +		data->need_update_smu7_dpm_table |=3D DPMTABLE_OD_UPDATE_MCLK;
> +
> +	cgs_get_active_displays_info(hwmgr->device, &info);
> +
> +	if (data->display_timing.num_existing_displays !=3D info.display_coun=
t)
> +		data->need_update_smu7_dpm_table |=3D DPMTABLE_UPDATE_MCLK;
> +
> +	return 0;
> +}
> +
> +static uint16_t iceland_get_maximum_link_speed(struct pp_hwmgr *hwmgr,=
 const struct iceland_power_state *hw_ps)
> +{
> +	uint32_t i;
> +	uint32_t pcie_speed, max_speed =3D 0;
> +
> +	for (i =3D 0; i < hw_ps->performance_level_count; i++) {
> +		pcie_speed =3D hw_ps->performance_levels[i].pcie_gen;
> +		if (max_speed < pcie_speed)
> +			max_speed =3D pcie_speed;
> +	}
> +
> +	return max_speed;
> +}
> +
> +static uint16_t iceland_get_current_pcie_speed(struct pp_hwmgr *hwmgr)=

> +{
> +	uint32_t speed_cntl =3D 0;
> +
> +	speed_cntl =3D cgs_read_ind_register(hwmgr->device,
> +					   CGS_IND_REG__PCIE,
> +					   ixPCIE_LC_SPEED_CNTL);
> +	return((uint16_t)PHM_GET_FIELD(speed_cntl,
> +			PCIE_LC_SPEED_CNTL, LC_CURRENT_DATA_RATE));
> +}
> +
> +
> +static int iceland_request_link_speed_change_before_state_change(struc=
t pp_hwmgr *hwmgr, const void *input)
> +{
> +	const struct phm_set_power_state_input *states =3D (const struct phm_=
set_power_state_input *)input;
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +	const struct iceland_power_state *iceland_nps =3D cast_const_phw_icel=
and_power_state(states->pnew_state);
> +	const struct iceland_power_state *iceland_cps =3D cast_const_phw_icel=
and_power_state(states->pcurrent_state);
> +
> +	uint16_t target_link_speed =3D iceland_get_maximum_link_speed(hwmgr, =
iceland_nps);
> +	uint16_t current_link_speed;
> +
> +	if (data->force_pcie_gen =3D=3D PP_PCIEGenInvalid)
> +		current_link_speed =3D iceland_get_maximum_link_speed(hwmgr, iceland=
_cps);
> +	else
> +		current_link_speed =3D data->force_pcie_gen;
> +
> +	data->force_pcie_gen =3D PP_PCIEGenInvalid;
> +	data->pspp_notify_required =3D false;
> +	if (target_link_speed > current_link_speed) {
> +		switch(target_link_speed) {
> +		case PP_PCIEGen3:
> +			if (0 =3D=3D acpi_pcie_perf_request(hwmgr->device, PCIE_PERF_REQ_GE=
N3, false))
> +				break;
> +			data->force_pcie_gen =3D PP_PCIEGen2;
> +			if (current_link_speed =3D=3D PP_PCIEGen2)
> +				break;
> +		case PP_PCIEGen2:
> +			if (0 =3D=3D acpi_pcie_perf_request(hwmgr->device, PCIE_PERF_REQ_GE=
N2, false))
> +				break;
> +		default:
> +			data->force_pcie_gen =3D iceland_get_current_pcie_speed(hwmgr);
> +			break;
> +		}
> +	} else {
> +		if (target_link_speed < current_link_speed)
> +			data->pspp_notify_required =3D true;
> +	}
> +
> +	return 0;
> +}
> +
> +static int iceland_freeze_sclk_mclk_dpm(struct pp_hwmgr *hwmgr)
> +{
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +
> +	if (0 =3D=3D data->need_update_smu7_dpm_table)
> +		return 0;
> +
> +	if ((0 =3D=3D data->sclk_dpm_key_disabled) &&
> +		(data->need_update_smu7_dpm_table &
> +		(DPMTABLE_OD_UPDATE_SCLK + DPMTABLE_UPDATE_SCLK))) {
> +		PP_ASSERT_WITH_CODE(
> +			0 =3D=3D iceland_is_dpm_running(hwmgr),
> +			"Trying to freeze SCLK DPM when DPM is disabled",
> +			);
> +		PP_ASSERT_WITH_CODE(
> +			0 =3D=3D smum_send_msg_to_smc(hwmgr->smumgr,
> +					  PPSMC_MSG_SCLKDPM_FreezeLevel),
> +			"Failed to freeze SCLK DPM during FreezeSclkMclkDPM Function!",
> +			return -1);
> +	}
> +
> +	if ((0 =3D=3D data->mclk_dpm_key_disabled) &&
> +		(data->need_update_smu7_dpm_table &
> +		 DPMTABLE_OD_UPDATE_MCLK)) {
> +		PP_ASSERT_WITH_CODE(0 =3D=3D iceland_is_dpm_running(hwmgr),
> +			"Trying to freeze MCLK DPM when DPM is disabled",
> +			);
> +		PP_ASSERT_WITH_CODE(
> +			0 =3D=3D smum_send_msg_to_smc(hwmgr->smumgr,
> +							PPSMC_MSG_MCLKDPM_FreezeLevel),
> +			"Failed to freeze MCLK DPM during FreezeSclkMclkDPM Function!",
> +			return -1);
> +	}
> +
> +	return 0;
> +}
> +
> +static int iceland_populate_and_upload_sclk_mclk_dpm_levels(struct pp_=
hwmgr *hwmgr, const void *input)
> +{
> +	int result =3D 0;
> +
> +	const struct phm_set_power_state_input *states =3D (const struct phm_=
set_power_state_input *)input;
> +	const struct iceland_power_state *iceland_ps =3D cast_const_phw_icela=
nd_power_state(states->pnew_state);
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +	uint32_t sclk =3D iceland_ps->performance_levels[iceland_ps->performa=
nce_level_count-1].engine_clock;
> +	uint32_t mclk =3D iceland_ps->performance_levels[iceland_ps->performa=
nce_level_count-1].memory_clock;
> +	struct iceland_dpm_table *pdpm_table =3D &data->dpm_table;
> +
> +	struct iceland_dpm_table *pgolden_dpm_table =3D &data->golden_dpm_tab=
le;
> +	uint32_t dpm_count, clock_percent;
> +	uint32_t i;
> +
> +	if (0 =3D=3D data->need_update_smu7_dpm_table)
> +		return 0;
> +
> +	if (data->need_update_smu7_dpm_table & DPMTABLE_OD_UPDATE_SCLK) {
> +		pdpm_table->sclk_table.dpm_levels[pdpm_table->sclk_table.count-1].va=
lue =3D sclk;
> +
> +		if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_Pla=
tformCaps_OD6PlusinACSupport) ||
> +		    phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_Pla=
tformCaps_OD6PlusinDCSupport)) {
> +			/*
> +			 * Need to do calculation based on the golden DPM table
> +			 * as the Heatmap GPU Clock axis is also based on the default value=
s
> +			 */
> +			PP_ASSERT_WITH_CODE(
> +				(pgolden_dpm_table->sclk_table.dpm_levels[pgolden_dpm_table->sclk_=
table.count-1].value !=3D 0),
> +				"Divide by 0!",
> +				return -1);
> +			dpm_count =3D pdpm_table->sclk_table.count < 2 ? 0 : pdpm_table->sc=
lk_table.count-2;
> +			for (i =3D dpm_count; i > 1; i--) {
> +				if (sclk > pgolden_dpm_table->sclk_table.dpm_levels[pgolden_dpm_ta=
ble->sclk_table.count-1].value) {
> +					clock_percent =3D ((sclk - pgolden_dpm_table->sclk_table.dpm_leve=
ls[pgolden_dpm_table->sclk_table.count-1].value)*100) /
> +							pgolden_dpm_table->sclk_table.dpm_levels[pgolden_dpm_table->scl=
k_table.count-1].value;
> +
> +					pdpm_table->sclk_table.dpm_levels[i].value =3D
> +							pgolden_dpm_table->sclk_table.dpm_levels[i].value +
> +							(pgolden_dpm_table->sclk_table.dpm_levels[i].value * clock_perc=
ent)/100;
> +
> +				} else if (pgolden_dpm_table->sclk_table.dpm_levels[pdpm_table->sc=
lk_table.count-1].value > sclk) {
> +					clock_percent =3D ((pgolden_dpm_table->sclk_table.dpm_levels[pgol=
den_dpm_table->sclk_table.count-1].value - sclk)*100) /
> +								pgolden_dpm_table->sclk_table.dpm_levels[pgolden_dpm_table->sc=
lk_table.count-1].value;
> +
> +					pdpm_table->sclk_table.dpm_levels[i].value =3D
> +							pgolden_dpm_table->sclk_table.dpm_levels[i].value -
> +							(pgolden_dpm_table->sclk_table.dpm_levels[i].value * clock_perc=
ent)/100;
> +				} else
> +					pdpm_table->sclk_table.dpm_levels[i].value =3D
> +							pgolden_dpm_table->sclk_table.dpm_levels[i].value;
> +			}
> +		}
> +	}
> +
> +	if (data->need_update_smu7_dpm_table & DPMTABLE_OD_UPDATE_MCLK) {
> +		pdpm_table->mclk_table.dpm_levels[pdpm_table->mclk_table.count-1].va=
lue =3D mclk;
> +
> +		if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_Pla=
tformCaps_OD6PlusinACSupport) ||
> +			phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_Platfo=
rmCaps_OD6PlusinDCSupport)) {
> +
> +			PP_ASSERT_WITH_CODE(
> +					(pgolden_dpm_table->mclk_table.dpm_levels[pgolden_dpm_table->mclk=
_table.count-1].value !=3D 0),
> +					"Divide by 0!",
> +					return -1);
> +			dpm_count =3D pdpm_table->mclk_table.count < 2? 0 : pdpm_table->mcl=
k_table.count-2;
> +			for (i =3D dpm_count; i > 1; i--) {
> +				if (mclk > pgolden_dpm_table->mclk_table.dpm_levels[pgolden_dpm_ta=
ble->mclk_table.count-1].value) {
> +						clock_percent =3D ((mclk - pgolden_dpm_table->mclk_table.dpm_lev=
els[pgolden_dpm_table->mclk_table.count-1].value)*100) /
> +								    pgolden_dpm_table->mclk_table.dpm_levels[pgolden_dpm_table=
->mclk_table.count-1].value;
> +
> +						pdpm_table->mclk_table.dpm_levels[i].value =3D
> +										pgolden_dpm_table->mclk_table.dpm_levels[i].value +
> +										(pgolden_dpm_table->mclk_table.dpm_levels[i].value * clock_p=
ercent)/100;
> +
> +				} else if (pgolden_dpm_table->mclk_table.dpm_levels[pdpm_table->mc=
lk_table.count-1].value > mclk) {
> +						clock_percent =3D ((pgolden_dpm_table->mclk_table.dpm_levels[pgo=
lden_dpm_table->mclk_table.count-1].value - mclk)*100) /
> +								    pgolden_dpm_table->mclk_table.dpm_levels[pgolden_dpm_table=
->mclk_table.count-1].value;
> +
> +						pdpm_table->mclk_table.dpm_levels[i].value =3D
> +									pgolden_dpm_table->mclk_table.dpm_levels[i].value -
> +									(pgolden_dpm_table->mclk_table.dpm_levels[i].value * clock_pe=
rcent)/100;
> +				} else
> +					pdpm_table->mclk_table.dpm_levels[i].value =3D pgolden_dpm_table-=
>mclk_table.dpm_levels[i].value;
> +			}
> +		}
> +	}
> +
> +
> +	if (data->need_update_smu7_dpm_table & (DPMTABLE_OD_UPDATE_SCLK + DPM=
TABLE_UPDATE_SCLK)) {
> +		result =3D iceland_populate_all_graphic_levels(hwmgr);
> +		PP_ASSERT_WITH_CODE((0 =3D=3D result),
> +			"Failed to populate SCLK during PopulateNewDPMClocksStates Function=
!",
> +			return result);
> +	}
> +
> +	if (data->need_update_smu7_dpm_table & (DPMTABLE_OD_UPDATE_MCLK + DPM=
TABLE_UPDATE_MCLK)) {
> +		/*populate MCLK dpm table to SMU7 */
> +		result =3D iceland_populate_all_memory_levels(hwmgr);
> +		PP_ASSERT_WITH_CODE((0 =3D=3D result),
> +				"Failed to populate MCLK during PopulateNewDPMClocksStates Functio=
n!",
> +				return result);
> +	}
> +
> +	return result;
> +}
> +
> +static int iceland_trim_single_dpm_states(struct pp_hwmgr *hwmgr,
> +			  struct iceland_single_dpm_table *pdpm_table,
> +			     uint32_t low_limit, uint32_t high_limit)
> +{
> +	uint32_t i;
> +
> +	for (i =3D 0; i < pdpm_table->count; i++) {
> +		if ((pdpm_table->dpm_levels[i].value < low_limit) ||
> +		    (pdpm_table->dpm_levels[i].value > high_limit))
> +			pdpm_table->dpm_levels[i].enabled =3D false;
> +		else
> +			pdpm_table->dpm_levels[i].enabled =3D true;
> +	}
> +	return 0;
> +}
> +
> +static int iceland_trim_dpm_states(struct pp_hwmgr *hwmgr, const struc=
t iceland_power_state *hw_state)
> +{
> +	int result =3D 0;
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +	uint32_t high_limit_count;
> +
> +	PP_ASSERT_WITH_CODE((hw_state->performance_level_count >=3D 1),
> +				"power state did not have any performance level",
> +				 return -1);
> +
> +	high_limit_count =3D (1 =3D=3D hw_state->performance_level_count) ? 0=
: 1;
> +
> +	iceland_trim_single_dpm_states(hwmgr, &(data->dpm_table.sclk_table),
> +					hw_state->performance_levels[0].engine_clock,
> +					hw_state->performance_levels[high_limit_count].engine_clock);
> +
> +	iceland_trim_single_dpm_states(hwmgr, &(data->dpm_table.mclk_table),
> +					hw_state->performance_levels[0].memory_clock,
> +					hw_state->performance_levels[high_limit_count].memory_clock);
> +
> +	return result;
> +}
> +
> +static int iceland_generate_dpm_level_enable_mask(struct pp_hwmgr *hwm=
gr, const void *input)
> +{
> +	int result;
> +	const struct phm_set_power_state_input *states =3D (const struct phm_=
set_power_state_input *)input;
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +	const struct iceland_power_state *iceland_ps =3D cast_const_phw_icela=
nd_power_state(states->pnew_state);
> +
> +	result =3D iceland_trim_dpm_states(hwmgr, iceland_ps);
> +	if (0 !=3D result)
> +		return result;
> +
> +	data->dpm_level_enable_mask.sclk_dpm_enable_mask =3D iceland_get_dpm_=
level_enable_mask_value(&data->dpm_table.sclk_table);
> +	data->dpm_level_enable_mask.mclk_dpm_enable_mask =3D iceland_get_dpm_=
level_enable_mask_value(&data->dpm_table.mclk_table);
> +	data->last_mclk_dpm_enable_mask =3D data->dpm_level_enable_mask.mclk_=
dpm_enable_mask;
> +	if (data->uvd_enabled && (data->dpm_level_enable_mask.mclk_dpm_enable=
_mask & 1))
> +		data->dpm_level_enable_mask.mclk_dpm_enable_mask &=3D 0xFFFFFFFE;
> +
> +	data->dpm_level_enable_mask.pcie_dpm_enable_mask =3D iceland_get_dpm_=
level_enable_mask_value(&data->dpm_table.pcie_speed_table);
> +
> +	return 0;
> +}
> +
> +static int iceland_update_vce_dpm(struct pp_hwmgr *hwmgr, const void *=
input)
> +{
> +	return 0;
> +}
> +
> +int iceland_update_sclk_threshold(struct pp_hwmgr *hwmgr)
> +{
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +
> +	int result =3D 0;
> +	uint32_t low_sclk_interrupt_threshold =3D 0;
> +
> +	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
> +			PHM_PlatformCaps_SclkThrottleLowNotification)
> +		&& (hwmgr->gfx_arbiter.sclk_threshold !=3D data->low_sclk_interrupt_=
threshold)) {
> +		data->low_sclk_interrupt_threshold =3D hwmgr->gfx_arbiter.sclk_thres=
hold;
> +		low_sclk_interrupt_threshold =3D data->low_sclk_interrupt_threshold;=

> +
> +		CONVERT_FROM_HOST_TO_SMC_UL(low_sclk_interrupt_threshold);
> +
> +		result =3D iceland_copy_bytes_to_smc(
> +				hwmgr->smumgr,
> +				data->dpm_table_start + offsetof(SMU71_Discrete_DpmTable,
> +				LowSclkInterruptThreshold),
> +				(uint8_t *)&low_sclk_interrupt_threshold,
> +				sizeof(uint32_t),
> +				data->sram_end
> +				);
> +	}
> +
> +	return result;
> +}
> +
> +static int iceland_update_and_upload_mc_reg_table(struct pp_hwmgr *hwm=
gr)
> +{
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +
> +	uint32_t address;
> +	int32_t result;
> +
> +	if (0 =3D=3D (data->need_update_smu7_dpm_table & DPMTABLE_OD_UPDATE_M=
CLK))
> +		return 0;
> +
> +
> +	memset(&data->mc_reg_table, 0, sizeof(SMU71_Discrete_MCRegisters));
> +
> +	result =3D iceland_convert_mc_reg_table_to_smc(hwmgr, &(data->mc_reg_=
table));
> +
> +	if(result !=3D 0)
> +		return result;
> +
> +
> +	address =3D data->mc_reg_table_start + (uint32_t)offsetof(SMU71_Discr=
ete_MCRegisters, data[0]);
> +
> +	return  iceland_copy_bytes_to_smc(hwmgr->smumgr, address,
> +				 (uint8_t *)&data->mc_reg_table.data[0],
> +				sizeof(SMU71_Discrete_MCRegisterSet) * data->dpm_table.mclk_table.=
count,
> +				data->sram_end);
> +}
> +
> +static int iceland_program_memory_timing_parameters_conditionally(stru=
ct pp_hwmgr *hwmgr)
> +{
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +
> +	if (data->need_update_smu7_dpm_table &
> +		(DPMTABLE_OD_UPDATE_SCLK + DPMTABLE_OD_UPDATE_MCLK))
> +		return iceland_program_memory_timing_parameters(hwmgr);
> +
> +	return 0;
> +}
> +
> +static int iceland_unfreeze_sclk_mclk_dpm(struct pp_hwmgr *hwmgr)
> +{
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +
> +	if (0 =3D=3D data->need_update_smu7_dpm_table)
> +		return 0;
> +
> +	if ((0 =3D=3D data->sclk_dpm_key_disabled) &&
> +		(data->need_update_smu7_dpm_table &
> +		(DPMTABLE_OD_UPDATE_SCLK + DPMTABLE_UPDATE_SCLK))) {
> +
> +		PP_ASSERT_WITH_CODE(0 =3D=3D iceland_is_dpm_running(hwmgr),
> +			"Trying to Unfreeze SCLK DPM when DPM is disabled",
> +			);
> +		PP_ASSERT_WITH_CODE(
> +			 0 =3D=3D smum_send_msg_to_smc(hwmgr->smumgr,
> +					 PPSMC_MSG_SCLKDPM_UnfreezeLevel),
> +			"Failed to unfreeze SCLK DPM during UnFreezeSclkMclkDPM Function!",=

> +			return -1);
> +	}
> +
> +	if ((0 =3D=3D data->mclk_dpm_key_disabled) &&
> +		(data->need_update_smu7_dpm_table & DPMTABLE_OD_UPDATE_MCLK)) {
> +
> +		PP_ASSERT_WITH_CODE(
> +				0 =3D=3D iceland_is_dpm_running(hwmgr),
> +				"Trying to Unfreeze MCLK DPM when DPM is disabled",
> +				);
> +		PP_ASSERT_WITH_CODE(
> +			 0 =3D=3D smum_send_msg_to_smc(hwmgr->smumgr,
> +					 PPSMC_MSG_MCLKDPM_UnfreezeLevel),
> +		    "Failed to unfreeze MCLK DPM during UnFreezeSclkMclkDPM Function=
!",
> +		    return -1);
> +	}
> +
> +	data->need_update_smu7_dpm_table =3D 0;
> +
> +	return 0;
> +}
> +
> +static int iceland_notify_link_speed_change_after_state_change(struct =
pp_hwmgr *hwmgr, const void *input)
> +{
> +	const struct phm_set_power_state_input *states =3D (const struct phm_=
set_power_state_input *)input;
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +	const struct iceland_power_state *iceland_ps =3D cast_const_phw_icela=
nd_power_state(states->pnew_state);
> +	uint16_t target_link_speed =3D iceland_get_maximum_link_speed(hwmgr, =
iceland_ps);
> +	uint8_t  request;
> +
> +	if (data->pspp_notify_required  ||
> +	    data->pcie_performance_request) {
> +		if (target_link_speed =3D=3D PP_PCIEGen3)
> +			request =3D PCIE_PERF_REQ_GEN3;
> +		else if (target_link_speed =3D=3D PP_PCIEGen2)
> +			request =3D PCIE_PERF_REQ_GEN2;
> +		else
> +			request =3D PCIE_PERF_REQ_GEN1;
> +
> +		if(request =3D=3D PCIE_PERF_REQ_GEN1 && iceland_get_current_pcie_spe=
ed(hwmgr) > 0) {
> +			data->pcie_performance_request =3D false;
> +			return 0;
> +		}
> +
> +		if (0 !=3D acpi_pcie_perf_request(hwmgr->device, request, false)) {
> +			if (PP_PCIEGen2 =3D=3D target_link_speed)
> +				printk("PSPP request to switch to Gen2 from Gen3 Failed!");
> +			else
> +				printk("PSPP request to switch to Gen1 from Gen2 Failed!");
> +		}
> +	}
> +
> +	data->pcie_performance_request =3D false;
> +	return 0;
> +}
> +
> +int iceland_upload_dpm_level_enable_mask(struct pp_hwmgr *hwmgr)
> +{
> +	PPSMC_Result result;
> +	iceland_hwmgr *data =3D (iceland_hwmgr *)(hwmgr->backend);
> +
> +	if (0 =3D=3D data->sclk_dpm_key_disabled) {
> +		/* Checking if DPM is running.  If we discover hang because of this,=
 we should skip this message.*/
> +		if (0 !=3D iceland_is_dpm_running(hwmgr))
> +			printk(KERN_ERR "[ powerplay ] Trying to set Enable Sclk Mask when =
DPM is disabled \n");
> +
> +		if (0 !=3D data->dpm_level_enable_mask.sclk_dpm_enable_mask) {
> +			result =3D smum_send_msg_to_smc_with_parameter(
> +								hwmgr->smumgr,
> +				(PPSMC_Msg)PPSMC_MSG_SCLKDPM_SetEnabledMask,
> +				data->dpm_level_enable_mask.sclk_dpm_enable_mask);
> +			PP_ASSERT_WITH_CODE((0 =3D=3D result),
> +				"Set Sclk Dpm enable Mask failed", return -1);
> +		}
> +	}
> +
> +	if (0 =3D=3D data->mclk_dpm_key_disabled) {
> +		/* Checking if DPM is running.  If we discover hang because of this,=
 we should skip this message.*/
> +		if (0 !=3D iceland_is_dpm_running(hwmgr))
> +			printk(KERN_ERR "[ powerplay ] Trying to set Enable Mclk Mask when =
DPM is disabled \n");
> +
> +		if (0 !=3D data->dpm_level_enable_mask.mclk_dpm_enable_mask) {
> +			result =3D smum_send_msg_to_smc_with_parameter(
> +								hwmgr->smumgr,
> +				(PPSMC_Msg)PPSMC_MSG_MCLKDPM_SetEnabledMask,
> +				data->dpm_level_enable_mask.mclk_dpm_enable_mask);
> +			PP_ASSERT_WITH_CODE((0 =3D=3D result),
> +				"Set Mclk Dpm enable Mask failed", return -1);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int iceland_set_power_state_tasks(struct pp_hwmgr *hwmgr, const=
 void *input)
> +{
> +	int tmp_result, result =3D 0;
> +
> +	tmp_result =3D iceland_find_dpm_states_clocks_in_dpm_table(hwmgr, inp=
ut);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result), "Failed to find DPM states=
 clocks in DPM table!", result =3D tmp_result);
> +
> +	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_Plat=
formCaps_PCIEPerformanceRequest)) {
> +		tmp_result =3D iceland_request_link_speed_change_before_state_change=
(hwmgr, input);
> +		PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result), "Failed to request link s=
peed change before state change!", result =3D tmp_result);
> +	}
> +
> +	tmp_result =3D iceland_freeze_sclk_mclk_dpm(hwmgr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result), "Failed to freeze SCLK MCL=
K DPM!", result =3D tmp_result);
> +
> +	tmp_result =3D iceland_populate_and_upload_sclk_mclk_dpm_levels(hwmgr=
, input);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result), "Failed to populate and up=
load SCLK MCLK DPM levels!", result =3D tmp_result);
> +
> +	tmp_result =3D iceland_generate_dpm_level_enable_mask(hwmgr, input);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result), "Failed to generate DPM le=
vel enabled mask!", result =3D tmp_result);
> +
> +	tmp_result =3D iceland_update_vce_dpm(hwmgr, input);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result), "Failed to update VCE DPM!=
", result =3D tmp_result);
> +
> +	tmp_result =3D iceland_update_sclk_threshold(hwmgr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result), "Failed to update SCLK thr=
eshold!", result =3D tmp_result);
> +
> +	tmp_result =3D iceland_update_and_upload_mc_reg_table(hwmgr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result), "Failed to upload MC reg t=
able!", result =3D tmp_result);
> +
> +	tmp_result =3D iceland_program_memory_timing_parameters_conditionally=
(hwmgr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result), "Failed to program memory =
timing parameters!", result =3D tmp_result);
> +
> +	tmp_result =3D iceland_unfreeze_sclk_mclk_dpm(hwmgr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result), "Failed to unfreeze SCLK M=
CLK DPM!", result =3D tmp_result);
> +
> +	tmp_result =3D iceland_upload_dpm_level_enable_mask(hwmgr);
> +	PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result), "Failed to upload DPM leve=
l enabled mask!", result =3D tmp_result);
> +
> +	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_Plat=
formCaps_PCIEPerformanceRequest)) {
> +		tmp_result =3D iceland_notify_link_speed_change_after_state_change(h=
wmgr, input);
> +		PP_ASSERT_WITH_CODE((0 =3D=3D tmp_result), "Failed to notify link sp=
eed change after state change!", result =3D tmp_result);
> +	}
> +
> +	return result;
> +}
> +
> +static int iceland_get_power_state_size(struct pp_hwmgr *hwmgr)
> +{
> +	return sizeof(struct iceland_power_state);
> +}
> +
> +static int iceland_dpm_get_mclk(struct pp_hwmgr *hwmgr, bool low)
> +{
> +	struct pp_power_state  *ps;
> +	struct iceland_power_state  *iceland_ps;
> +
> +	if (hwmgr =3D=3D NULL)
> +		return -EINVAL;
> +
> +	ps =3D hwmgr->request_ps;
> +
> +	if (ps =3D=3D NULL)
> +		return -EINVAL;
> +
> +	iceland_ps =3D cast_phw_iceland_power_state(&ps->hardware);
> +
> +	if (low)
> +		return iceland_ps->performance_levels[0].memory_clock;
> +	else
> +		return iceland_ps->performance_levels[iceland_ps->performance_level_=
count-1].memory_clock;
> +}
> +
> +static int iceland_dpm_get_sclk(struct pp_hwmgr *hwmgr, bool low)
> +{
> +	struct pp_power_state  *ps;
> +	struct iceland_power_state  *iceland_ps;
> +
> +	if (hwmgr =3D=3D NULL)
> +		return -EINVAL;
> +
> +	ps =3D hwmgr->request_ps;
> +
> +	if (ps =3D=3D NULL)
> +		return -EINVAL;
> +
> +	iceland_ps =3D cast_phw_iceland_power_state(&ps->hardware);
> +
> +	if (low)
> +		return iceland_ps->performance_levels[0].engine_clock;
> +	else
> +		return iceland_ps->performance_levels[iceland_ps->performance_level_=
count-1].engine_clock;
> +}
> +
> +static int iceland_get_current_pcie_lane_number(
> +						   struct pp_hwmgr *hwmgr)
> +{
> +	uint32_t link_width;
> +
> +	link_width =3D PHM_READ_INDIRECT_FIELD(hwmgr->device,
> +							CGS_IND_REG__PCIE,
> +						  PCIE_LC_LINK_WIDTH_CNTL,
> +							LC_LINK_WIDTH_RD);
> +
> +	PP_ASSERT_WITH_CODE((7 >=3D link_width),
> +			"Invalid PCIe lane width!", return 0);
> +
> +	return decode_pcie_lane_width(link_width);
> +}
> +
> +static int iceland_dpm_patch_boot_state(struct pp_hwmgr *hwmgr,
> +					struct pp_hw_power_state *hw_ps)
> +{
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +	struct iceland_power_state *ps =3D (struct iceland_power_state *)hw_p=
s;
> +	ATOM_FIRMWARE_INFO_V2_2 *fw_info;
> +	uint16_t size;
> +	uint8_t frev, crev;
> +	int index =3D GetIndexIntoMasterTable(DATA, FirmwareInfo);
> +
> +	/* First retrieve the Boot clocks and VDDC from the firmware info tab=
le.
> +	 * We assume here that fw_info is unchanged if this call fails.
> +	 */
> +	fw_info =3D (ATOM_FIRMWARE_INFO_V2_2 *)cgs_atom_get_data_table(
> +			hwmgr->device, index,
> +			&size, &frev, &crev);
> +	if (!fw_info)
> +		/* During a test, there is no firmware info table. */
> +		return 0;
> +
> +	/* Patch the state. */
> +	data->vbios_boot_state.sclk_bootup_value  =3D le32_to_cpu(fw_info->ul=
DefaultEngineClock);
> +	data->vbios_boot_state.mclk_bootup_value  =3D le32_to_cpu(fw_info->ul=
DefaultMemoryClock);
> +	data->vbios_boot_state.mvdd_bootup_value  =3D le16_to_cpu(fw_info->us=
BootUpMVDDCVoltage);
> +	data->vbios_boot_state.vddc_bootup_value  =3D le16_to_cpu(fw_info->us=
BootUpVDDCVoltage);
> +	data->vbios_boot_state.vddci_bootup_value =3D le16_to_cpu(fw_info->us=
BootUpVDDCIVoltage);
> +	data->vbios_boot_state.pcie_gen_bootup_value =3D iceland_get_current_=
pcie_speed(hwmgr);
> +	data->vbios_boot_state.pcie_lane_bootup_value =3D
> +			(uint16_t)iceland_get_current_pcie_lane_number(hwmgr);
> +
> +	/* set boot power state */
> +	ps->performance_levels[0].memory_clock =3D data->vbios_boot_state.mcl=
k_bootup_value;
> +	ps->performance_levels[0].engine_clock =3D data->vbios_boot_state.scl=
k_bootup_value;
> +	ps->performance_levels[0].pcie_gen =3D data->vbios_boot_state.pcie_ge=
n_bootup_value;
> +	ps->performance_levels[0].pcie_lane =3D data->vbios_boot_state.pcie_l=
ane_bootup_value;
> +
> +	return 0;
> +}
> +
> +static int iceland_get_pp_table_entry_callback_func(struct pp_hwmgr *h=
wmgr,
> +					struct pp_hw_power_state *power_state,
> +					unsigned int index, const void *clock_info)
> +{
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +	struct iceland_power_state  *iceland_power_state =3D cast_phw_iceland=
_power_state(power_state);
> +	const ATOM_PPLIB_CI_CLOCK_INFO *visland_clk_info =3D clock_info;
> +	struct iceland_performance_level *performance_level;
> +	uint32_t engine_clock, memory_clock;
> +	uint16_t pcie_gen_from_bios;
> +
> +	engine_clock =3D visland_clk_info->ucEngineClockHigh << 16 | visland_=
clk_info->usEngineClockLow;
> +	memory_clock =3D visland_clk_info->ucMemoryClockHigh << 16 | visland_=
clk_info->usMemoryClockLow;
> +
> +	if (!(data->mc_micro_code_feature & DISABLE_MC_LOADMICROCODE) && memo=
ry_clock > data->highest_mclk)
> +		data->highest_mclk =3D memory_clock;
> +
> +	performance_level =3D &(iceland_power_state->performance_levels
> +			[iceland_power_state->performance_level_count++]);
> +
> +	PP_ASSERT_WITH_CODE(
> +			(iceland_power_state->performance_level_count < SMU71_MAX_LEVELS_GR=
APHICS),
> +			"Performance levels exceeds SMC limit!",
> +			return -1);
> +
> +	PP_ASSERT_WITH_CODE(
> +			(iceland_power_state->performance_level_count <=3D
> +					hwmgr->platform_descriptor.hardwareActivityPerformanceLevels),
> +			"Performance levels exceeds Driver limit!",
> +			return -1);
> +
> +	/* Performance levels are arranged from low to high. */
> +	performance_level->memory_clock =3D memory_clock;
> +	performance_level->engine_clock =3D engine_clock;
> +
> +	pcie_gen_from_bios =3D visland_clk_info->ucPCIEGen;
> +
> +	performance_level->pcie_gen =3D get_pcie_gen_support(data->pcie_gen_c=
ap, pcie_gen_from_bios);
> +	performance_level->pcie_lane =3D get_pcie_lane_support(data->pcie_lan=
e_cap, visland_clk_info->usPCIELane);
> +
> +	return 0;
> +}
> +
> +static int iceland_get_pp_table_entry(struct pp_hwmgr *hwmgr,
> +		unsigned long entry_index, struct pp_power_state *state)
> +{
> +	int result;
> +	struct iceland_power_state *ps;
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +	struct phm_clock_voltage_dependency_table *dep_mclk_table =3D
> +			hwmgr->dyn_state.vddci_dependency_on_mclk;
> +
> +	memset(&state->hardware, 0x00, sizeof(struct pp_hw_power_state));
> +
> +	state->hardware.magic =3D PHM_VIslands_Magic;
> +
> +	ps =3D (struct iceland_power_state *)(&state->hardware);
> +
> +	result =3D pp_tables_get_entry(hwmgr, entry_index, state,
> +			iceland_get_pp_table_entry_callback_func);
> +
> +	/*
> +	 * This is the earliest time we have all the dependency table
> +	 * and the VBIOS boot state as
> +	 * PP_Tables_GetPowerPlayTableEntry retrieves the VBIOS boot
> +	 * state if there is only one VDDCI/MCLK level, check if it's
> +	 * the same as VBIOS boot state
> +	 */
> +	if (dep_mclk_table !=3D NULL && dep_mclk_table->count =3D=3D 1) {
> +		if (dep_mclk_table->entries[0].clk !=3D
> +				data->vbios_boot_state.mclk_bootup_value)
> +			printk(KERN_ERR "Single MCLK entry VDDCI/MCLK dependency table "
> +					"does not match VBIOS boot MCLK level");
> +		if (dep_mclk_table->entries[0].v !=3D
> +				data->vbios_boot_state.vddci_bootup_value)
> +			printk(KERN_ERR "Single VDDCI entry VDDCI/MCLK dependency table "
> +					"does not match VBIOS boot VDDCI level");
> +	}
> +
> +	/* set DC compatible flag if this state supports DC */
> +	if (!state->validation.disallowOnDC)
> +		ps->dc_compatible =3D true;
> +
> +	if (state->classification.flags & PP_StateClassificationFlag_ACPI)
> +		data->acpi_pcie_gen =3D ps->performance_levels[0].pcie_gen;
> +	else if (0 !=3D (state->classification.flags & PP_StateClassification=
Flag_Boot)) {
> +		if (data->bacos.best_match =3D=3D 0xffff) {
> +			/* For C.I. use boot state as base BACO state */
> +			data->bacos.best_match =3D PP_StateClassificationFlag_Boot;
> +			data->bacos.performance_level =3D ps->performance_levels[0];
> +		}
> +	}
> +
> +
> +	ps->uvd_clocks.VCLK =3D state->uvd_clocks.VCLK;
> +	ps->uvd_clocks.DCLK =3D state->uvd_clocks.DCLK;
> +
> +	if (!result) {
> +		uint32_t i;
> +
> +		switch (state->classification.ui_label) {
> +		case PP_StateUILabel_Performance:
> +			data->use_pcie_performance_levels =3D true;
> +
> +			for (i =3D 0; i < ps->performance_level_count; i++) {
> +				if (data->pcie_gen_performance.max <
> +						ps->performance_levels[i].pcie_gen)
> +					data->pcie_gen_performance.max =3D
> +							ps->performance_levels[i].pcie_gen;
> +
> +				if (data->pcie_gen_performance.min >
> +						ps->performance_levels[i].pcie_gen)
> +					data->pcie_gen_performance.min =3D
> +							ps->performance_levels[i].pcie_gen;
> +
> +				if (data->pcie_lane_performance.max <
> +						ps->performance_levels[i].pcie_lane)
> +					data->pcie_lane_performance.max =3D
> +							ps->performance_levels[i].pcie_lane;
> +
> +				if (data->pcie_lane_performance.min >
> +						ps->performance_levels[i].pcie_lane)
> +					data->pcie_lane_performance.min =3D
> +							ps->performance_levels[i].pcie_lane;
> +			}
> +			break;
> +		case PP_StateUILabel_Battery:
> +			data->use_pcie_power_saving_levels =3D true;
> +
> +			for (i =3D 0; i < ps->performance_level_count; i++) {
> +				if (data->pcie_gen_power_saving.max <
> +						ps->performance_levels[i].pcie_gen)
> +					data->pcie_gen_power_saving.max =3D
> +							ps->performance_levels[i].pcie_gen;
> +
> +				if (data->pcie_gen_power_saving.min >
> +						ps->performance_levels[i].pcie_gen)
> +					data->pcie_gen_power_saving.min =3D
> +							ps->performance_levels[i].pcie_gen;
> +
> +				if (data->pcie_lane_power_saving.max <
> +						ps->performance_levels[i].pcie_lane)
> +					data->pcie_lane_power_saving.max =3D
> +							ps->performance_levels[i].pcie_lane;
> +
> +				if (data->pcie_lane_power_saving.min >
> +						ps->performance_levels[i].pcie_lane)
> +					data->pcie_lane_power_saving.min =3D
> +							ps->performance_levels[i].pcie_lane;
> +			}
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static void
> +iceland_print_current_perforce_level(struct pp_hwmgr *hwmgr, struct se=
q_file *m)
> +{
> +	uint32_t sclk, mclk, activity_percent;
> +	uint32_t offset;
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +
> +	smum_send_msg_to_smc(hwmgr->smumgr, (PPSMC_Msg)(PPSMC_MSG_API_GetSclk=
Frequency));
> +
> +	sclk =3D cgs_read_register(hwmgr->device, mmSMC_MSG_ARG_0);
> +
> +	smum_send_msg_to_smc(hwmgr->smumgr, (PPSMC_Msg)(PPSMC_MSG_API_GetMclk=
Frequency));
> +
> +	mclk =3D cgs_read_register(hwmgr->device, mmSMC_MSG_ARG_0);
> +	seq_printf(m, "\n [  mclk  ]: %u MHz\n\n [  sclk  ]: %u MHz\n", mclk/=
100, sclk/100);
> +
> +	offset =3D data->soft_regs_start + offsetof(SMU71_SoftRegisters, Aver=
ageGraphicsActivity);
> +	activity_percent =3D cgs_read_ind_register(hwmgr->device, CGS_IND_REG=
__SMC, offset);
> +	activity_percent +=3D 0x80;
> +	activity_percent >>=3D 8;
> +
> +	seq_printf(m, "\n [GPU load]: %u%%\n\n", activity_percent > 100 ? 100=
 : activity_percent);
> +
> +	seq_printf(m, "uvd    %sabled\n", data->uvd_power_gated ? "dis" : "en=
");
> +
> +	seq_printf(m, "vce    %sabled\n", data->vce_power_gated ? "dis" : "en=
");
> +}
> +
> +int iceland_notify_smc_display_config_after_ps_adjustment(struct pp_hw=
mgr *hwmgr)
> +{
> +	uint32_t num_active_displays =3D 0;
> +	struct cgs_display_info info =3D {0};
> +	info.mode_info =3D NULL;
> +
> +	cgs_get_active_displays_info(hwmgr->device, &info);
> +
> +	num_active_displays =3D info.display_count;
> +
> +	if (num_active_displays > 1)  /* to do && (pHwMgr->pPECI->displayConf=
iguration.bMultiMonitorInSync !=3D TRUE)) */
> +		iceland_notify_smc_display_change(hwmgr, false);
> +	else
> +		iceland_notify_smc_display_change(hwmgr, true);
> +
> +	return 0;
> +}
> +
> +/**
> +* Programs the display gap
> +*
> +* @param    hwmgr  the address of the powerplay hardware manager.
> +* @return   always OK
> +*/
> +int iceland_program_display_gap(struct pp_hwmgr *hwmgr)
> +{
> +	uint32_t num_active_displays =3D 0;
> +	uint32_t display_gap =3D cgs_read_ind_register(hwmgr->device, CGS_IND=
_REG__SMC, ixCG_DISPLAY_GAP_CNTL);
> +	uint32_t display_gap2;
> +	uint32_t pre_vbi_time_in_us;
> +	uint32_t frame_time_in_us;
> +	uint32_t ref_clock;
> +	uint32_t refresh_rate =3D 0;
> +	struct cgs_display_info info =3D {0};
> +	struct cgs_mode_info mode_info;
> +
> +	info.mode_info =3D &mode_info;
> +
> +	cgs_get_active_displays_info(hwmgr->device, &info);
> +	num_active_displays =3D info.display_count;
> +
> +	display_gap =3D PHM_SET_FIELD(display_gap, CG_DISPLAY_GAP_CNTL, DISP_=
GAP, (num_active_displays > 0)? DISPLAY_GAP_VBLANK_OR_WM : DISPLAY_GAP_IG=
NORE);
> +	cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC, ixCG_DISPLAY_=
GAP_CNTL, display_gap);
> +
> +	ref_clock =3D mode_info.ref_clock;
> +	refresh_rate =3D mode_info.refresh_rate;
> +
> +	if(0 =3D=3D refresh_rate)
> +		refresh_rate =3D 60;
> +
> +	frame_time_in_us =3D 1000000 / refresh_rate;
> +
> +	pre_vbi_time_in_us =3D frame_time_in_us - 200 - mode_info.vblank_time=
_us;
> +	display_gap2 =3D pre_vbi_time_in_us * (ref_clock / 100);
> +
> +	cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC, ixCG_DISPLAY_=
GAP_CNTL2, display_gap2);
> +
> +	PHM_WRITE_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC, SOFT_REGIST=
ERS_TABLE_4, PreVBlankGap, 0x64);
> +
> +	PHM_WRITE_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC, SOFT_REGIST=
ERS_TABLE_5, VBlankTimeout, (frame_time_in_us - pre_vbi_time_in_us));
> +
> +	if (num_active_displays =3D=3D 1)
> +		iceland_notify_smc_display_change(hwmgr, true);
> +
> +	return 0;
> +}
> +
> +int iceland_display_configuration_changed_task(struct pp_hwmgr *hwmgr)=

> +{
> +	iceland_program_display_gap(hwmgr);
> +
> +	return 0;
> +}
> +
> +/**
> +*  Set maximum target operating fan output PWM
> +*
> +* @param    pHwMgr:  the address of the powerplay hardware manager.
> +* @param    usMaxFanPwm:  max operating fan PWM in percents
> +* @return   The response that came from the SMC.
> +*/
> +static int iceland_set_max_fan_pwm_output(struct pp_hwmgr *hwmgr, uint=
16_t us_max_fan_pwm)
> +{
> +	hwmgr->thermal_controller.advanceFanControlParameters.usMaxFanPWM =3D=
 us_max_fan_pwm;
> +
> +	if (phm_is_hw_access_blocked(hwmgr))
> +		return 0;
> +
> +	return (0 =3D=3D smum_send_msg_to_smc_with_parameter(hwmgr->smumgr, P=
PSMC_MSG_SetFanPwmMax, us_max_fan_pwm) ? 0 : -1);
> +}
> +
> +/**
> +*  Set maximum target operating fan output RPM
> +*
> +* @param    pHwMgr:  the address of the powerplay hardware manager.
> +* @param    usMaxFanRpm:  max operating fan RPM value.
> +* @return   The response that came from the SMC.
> +*/
> +static int iceland_set_max_fan_rpm_output(struct pp_hwmgr *hwmgr, uint=
16_t us_max_fan_pwm)
> +{
> +	hwmgr->thermal_controller.advanceFanControlParameters.usMaxFanRPM =3D=
 us_max_fan_pwm;
> +
> +	if (phm_is_hw_access_blocked(hwmgr))
> +		return 0;
> +
> +	return (0 =3D=3D smum_send_msg_to_smc_with_parameter(hwmgr->smumgr, P=
PSMC_MSG_SetFanRpmMax, us_max_fan_pwm) ? 0 : -1);
> +}
> +
> +static int iceland_dpm_set_interrupt_state(void *private_data,
> +					 unsigned src_id, unsigned type,
> +					 int enabled)
> +{
> +	uint32_t cg_thermal_int;
> +	struct pp_hwmgr *hwmgr =3D ((struct pp_eventmgr *)private_data)->hwmg=
r;
> +
> +	if (hwmgr =3D=3D NULL)
> +		return -EINVAL;
> +
> +	switch (type) {
> +	case AMD_THERMAL_IRQ_LOW_TO_HIGH:
> +		if (enabled) {
> +			cg_thermal_int =3D cgs_read_ind_register(hwmgr->device, CGS_IND_REG=
__SMC, ixCG_THERMAL_INT);
> +			cg_thermal_int |=3D CG_THERMAL_INT_CTRL__THERM_INTH_MASK_MASK;
> +			cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC, ixCG_THERMA=
L_INT, cg_thermal_int);
> +		} else {
> +			cg_thermal_int =3D cgs_read_ind_register(hwmgr->device, CGS_IND_REG=
__SMC, ixCG_THERMAL_INT);
> +			cg_thermal_int &=3D ~CG_THERMAL_INT_CTRL__THERM_INTH_MASK_MASK;
> +			cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC, ixCG_THERMA=
L_INT, cg_thermal_int);
> +		}
> +		break;
> +
> +	case AMD_THERMAL_IRQ_HIGH_TO_LOW:
> +		if (enabled) {
> +			cg_thermal_int =3D cgs_read_ind_register(hwmgr->device, CGS_IND_REG=
__SMC, ixCG_THERMAL_INT);
> +			cg_thermal_int |=3D CG_THERMAL_INT_CTRL__THERM_INTL_MASK_MASK;
> +			cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC, ixCG_THERMA=
L_INT, cg_thermal_int);
> +		} else {
> +			cg_thermal_int =3D cgs_read_ind_register(hwmgr->device, CGS_IND_REG=
__SMC, ixCG_THERMAL_INT);
> +			cg_thermal_int &=3D ~CG_THERMAL_INT_CTRL__THERM_INTL_MASK_MASK;
> +			cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC, ixCG_THERMA=
L_INT, cg_thermal_int);
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static int iceland_register_internal_thermal_interrupt(struct pp_hwmgr=
 *hwmgr,
> +					const void *thermal_interrupt_info)
> +{
> +	int result;
> +	const struct pp_interrupt_registration_info *info =3D
> +			(const struct pp_interrupt_registration_info *)thermal_interrupt_in=
fo;
> +
> +	if (info =3D=3D NULL)
> +		return -EINVAL;
> +
> +	result =3D cgs_add_irq_source(hwmgr->device, 230, AMD_THERMAL_IRQ_LAS=
T,
> +				iceland_dpm_set_interrupt_state,
> +				info->call_back, info->context);
> +
> +	if (result)
> +		return -EINVAL;
> +
> +	result =3D cgs_add_irq_source(hwmgr->device, 231, AMD_THERMAL_IRQ_LAS=
T,
> +				iceland_dpm_set_interrupt_state,
> +				info->call_back, info->context);
> +
> +	if (result)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +
> +static bool iceland_check_smc_update_required_for_display_configuratio=
n(struct pp_hwmgr *hwmgr)
> +{
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +	bool is_update_required =3D false;
> +	struct cgs_display_info info =3D {0,0,NULL};
> +
> +	cgs_get_active_displays_info(hwmgr->device, &info);
> +
> +	if (data->display_timing.num_existing_displays !=3D info.display_coun=
t)
> +		is_update_required =3D true;
> +/* TO DO NEED TO GET DEEP SLEEP CLOCK FROM DAL
> +	if (phm_cap_enabled(hwmgr->hwmgr->platform_descriptor.platformCaps, P=
HM_PlatformCaps_SclkDeepSleep)) {
> +		cgs_get_min_clock_settings(hwmgr->device, &min_clocks);
> +		if(min_clocks.engineClockInSR !=3D data->display_timing.minClockInSR=
)
> +			is_update_required =3D true;
> +*/
> +	return is_update_required;
> +}
> +
> +
> +static inline bool iceland_are_power_levels_equal(const struct iceland=
_performance_level *pl1,
> +							   const struct iceland_performance_level *pl2)
> +{
> +	return ((pl1->memory_clock =3D=3D pl2->memory_clock) &&
> +		  (pl1->engine_clock =3D=3D pl2->engine_clock) &&
> +		  (pl1->pcie_gen =3D=3D pl2->pcie_gen) &&
> +		  (pl1->pcie_lane =3D=3D pl2->pcie_lane));
> +}
> +
> +int iceland_check_states_equal(struct pp_hwmgr *hwmgr, const struct pp=
_hw_power_state *pstate1,
> +		const struct pp_hw_power_state *pstate2, bool *equal)
> +{
> +	const struct iceland_power_state *psa =3D cast_const_phw_iceland_powe=
r_state(pstate1);
> +	const struct iceland_power_state *psb =3D cast_const_phw_iceland_powe=
r_state(pstate2);
> +	int i;
> +
> +	if (equal =3D=3D NULL || psa =3D=3D NULL || psb =3D=3D NULL)
> +		return -EINVAL;
> +
> +	/* If the two states don't even have the same number of performance l=
evels they cannot be the same state. */
> +	if (psa->performance_level_count !=3D psb->performance_level_count) {=

> +		*equal =3D false;
> +		return 0;
> +	}
> +
> +	for (i =3D 0; i < psa->performance_level_count; i++) {
> +		if (!iceland_are_power_levels_equal(&(psa->performance_levels[i]), &=
(psb->performance_levels[i]))) {
> +			/* If we have found even one performance level pair that is differe=
nt the states are different. */
> +			*equal =3D false;
> +			return 0;
> +		}
> +	}
> +
> +	/* If all performance levels are the same try to use the UVD clocks t=
o break the tie.*/
> +	*equal =3D ((psa->uvd_clocks.VCLK =3D=3D psb->uvd_clocks.VCLK) && (ps=
a->uvd_clocks.DCLK =3D=3D psb->uvd_clocks.DCLK));
> +	*equal &=3D ((psa->vce_clocks.EVCLK =3D=3D psb->vce_clocks.EVCLK) && =
(psa->vce_clocks.ECCLK =3D=3D psb->vce_clocks.ECCLK));
> +	*equal &=3D (psa->sclk_threshold =3D=3D psb->sclk_threshold);
> +	*equal &=3D (psa->acp_clk =3D=3D psb->acp_clk);
> +
> +	return 0;
> +}
> +
> +static int iceland_set_fan_control_mode(struct pp_hwmgr *hwmgr, uint32=
_t mode)
> +{
> +	if (mode) {
> +		/* stop auto-manage */
> +		if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
> +				PHM_PlatformCaps_MicrocodeFanControl))
> +			iceland_fan_ctrl_stop_smc_fan_control(hwmgr);
> +		iceland_fan_ctrl_set_static_mode(hwmgr, mode);
> +	} else
> +		/* restart auto-manage */
> +		iceland_fan_ctrl_reset_fan_speed_to_default(hwmgr);
> +
> +	return 0;
> +}
> +
> +static int iceland_get_fan_control_mode(struct pp_hwmgr *hwmgr)
> +{
> +	if (hwmgr->fan_ctrl_is_in_default_mode)
> +		return hwmgr->fan_ctrl_default_mode;
> +	else
> +		return PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC,=

> +				CG_FDO_CTRL2, FDO_PWM_MODE);
> +}
> +
> +static int iceland_force_clock_level(struct pp_hwmgr *hwmgr,
> +		enum pp_clock_type type, uint32_t mask)
> +{
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +
> +	if (hwmgr->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL)
> +		return -EINVAL;
> +
> +	switch (type) {
> +	case PP_SCLK:
> +		if (!data->sclk_dpm_key_disabled)
> +			smum_send_msg_to_smc_with_parameter(hwmgr->smumgr,
> +					PPSMC_MSG_SCLKDPM_SetEnabledMask,
> +					data->dpm_level_enable_mask.sclk_dpm_enable_mask & mask);
> +		break;
> +	case PP_MCLK:
> +		if (!data->mclk_dpm_key_disabled)
> +			smum_send_msg_to_smc_with_parameter(hwmgr->smumgr,
> +					PPSMC_MSG_MCLKDPM_SetEnabledMask,
> +					data->dpm_level_enable_mask.mclk_dpm_enable_mask & mask);
> +		break;
> +	case PP_PCIE:
> +	{
> +		uint32_t tmp =3D mask & data->dpm_level_enable_mask.pcie_dpm_enable_=
mask;
> +		uint32_t level =3D 0;
> +
> +		while (tmp >>=3D 1)
> +			level++;
> +
> +		if (!data->pcie_dpm_key_disabled)
> +			smum_send_msg_to_smc_with_parameter(hwmgr->smumgr,
> +					PPSMC_MSG_PCIeDPM_ForceLevel,
> +					level);
> +		break;
> +	}
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int iceland_print_clock_levels(struct pp_hwmgr *hwmgr,
> +		enum pp_clock_type type, char *buf)
> +{
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +	struct iceland_single_dpm_table *sclk_table =3D &(data->dpm_table.scl=
k_table);
> +	struct iceland_single_dpm_table *mclk_table =3D &(data->dpm_table.mcl=
k_table);
> +	struct iceland_single_dpm_table *pcie_table =3D &(data->dpm_table.pci=
e_speed_table);
> +	int i, now, size =3D 0;
> +	uint32_t clock, pcie_speed;
> +
> +	switch (type) {
> +	case PP_SCLK:
> +		smum_send_msg_to_smc(hwmgr->smumgr, PPSMC_MSG_API_GetSclkFrequency);=

> +		clock =3D cgs_read_register(hwmgr->device, mmSMC_MSG_ARG_0);
> +
> +		for (i =3D 0; i < sclk_table->count; i++) {
> +			if (clock > sclk_table->dpm_levels[i].value)
> +				continue;
> +			break;
> +		}
> +		now =3D i;
> +
> +		for (i =3D 0; i < sclk_table->count; i++)
> +			size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
> +					i, sclk_table->dpm_levels[i].value / 100,
> +					(i =3D=3D now) ? "*" : "");
> +		break;
> +	case PP_MCLK:
> +		smum_send_msg_to_smc(hwmgr->smumgr, PPSMC_MSG_API_GetMclkFrequency);=

> +		clock =3D cgs_read_register(hwmgr->device, mmSMC_MSG_ARG_0);
> +
> +		for (i =3D 0; i < mclk_table->count; i++) {
> +			if (clock > mclk_table->dpm_levels[i].value)
> +				continue;
> +			break;
> +		}
> +		now =3D i;
> +
> +		for (i =3D 0; i < mclk_table->count; i++)
> +			size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
> +					i, mclk_table->dpm_levels[i].value / 100,
> +					(i =3D=3D now) ? "*" : "");
> +		break;
> +	case PP_PCIE:
> +		pcie_speed =3D iceland_get_current_pcie_speed(hwmgr);
> +		for (i =3D 0; i < pcie_table->count; i++) {
> +			if (pcie_speed !=3D pcie_table->dpm_levels[i].value)
> +				continue;
> +			break;
> +		}
> +		now =3D i;
> +
> +		for (i =3D 0; i < pcie_table->count; i++)
> +			size +=3D sprintf(buf + size, "%d: %s %s\n", i,
> +					(pcie_table->dpm_levels[i].value =3D=3D 0) ? "2.5GB, x8" :
> +					(pcie_table->dpm_levels[i].value =3D=3D 1) ? "5.0GB, x16" :
> +					(pcie_table->dpm_levels[i].value =3D=3D 2) ? "8.0GB, x16" : "",
> +					(i =3D=3D now) ? "*" : "");
> +		break;
> +	default:
> +		break;
> +	}
> +	return size;
> +}
> +
> +static int iceland_get_sclk_od(struct pp_hwmgr *hwmgr)
> +{
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +	struct iceland_single_dpm_table *sclk_table =3D &(data->dpm_table.scl=
k_table);
> +	struct iceland_single_dpm_table *golden_sclk_table =3D
> +			&(data->golden_dpm_table.sclk_table);
> +	int value;
> +
> +	value =3D (sclk_table->dpm_levels[sclk_table->count - 1].value -
> +			golden_sclk_table->dpm_levels[golden_sclk_table->count - 1].value) =
*
> +			100 /
> +			golden_sclk_table->dpm_levels[golden_sclk_table->count - 1].value;
> +
> +	return value;
> +}
> +
> +static int iceland_set_sclk_od(struct pp_hwmgr *hwmgr, uint32_t value)=

> +{
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +	struct iceland_single_dpm_table *golden_sclk_table =3D
> +			&(data->golden_dpm_table.sclk_table);
> +	struct pp_power_state  *ps;
> +	struct iceland_power_state  *iceland_ps;
> +
> +	if (value > 20)
> +		value =3D 20;
> +
> +	ps =3D hwmgr->request_ps;
> +
> +	if (ps =3D=3D NULL)
> +		return -EINVAL;
> +
> +	iceland_ps =3D cast_phw_iceland_power_state(&ps->hardware);
> +
> +	iceland_ps->performance_levels[iceland_ps->performance_level_count - =
1].engine_clock =3D
> +			golden_sclk_table->dpm_levels[golden_sclk_table->count - 1].value *=

> +			value / 100 +
> +			golden_sclk_table->dpm_levels[golden_sclk_table->count - 1].value;
> +
> +	return 0;
> +}
> +
> +static int iceland_get_mclk_od(struct pp_hwmgr *hwmgr)
> +{
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +	struct iceland_single_dpm_table *mclk_table =3D &(data->dpm_table.mcl=
k_table);
> +	struct iceland_single_dpm_table *golden_mclk_table =3D
> +			&(data->golden_dpm_table.mclk_table);
> +	int value;
> +
> +	value =3D (mclk_table->dpm_levels[mclk_table->count - 1].value -
> +			golden_mclk_table->dpm_levels[golden_mclk_table->count - 1].value) =
*
> +			100 /
> +			golden_mclk_table->dpm_levels[golden_mclk_table->count - 1].value;
> +
> +	return value;
> +}
> +
> +uint32_t iceland_get_xclk(struct pp_hwmgr *hwmgr)
> +{
> +	uint32_t reference_clock;
> +	uint32_t tc;
> +	uint32_t divide;
> +
> +	ATOM_FIRMWARE_INFO *fw_info;
> +	uint16_t size;
> +	uint8_t frev, crev;
> +	int index =3D GetIndexIntoMasterTable(DATA, FirmwareInfo);
> +
> +	tc =3D PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC, =
CG_CLKPIN_CNTL_2, MUX_TCLK_TO_XCLK);
> +
> +	if (tc)
> +		return TCLK;
> +
> +	fw_info =3D (ATOM_FIRMWARE_INFO *)cgs_atom_get_data_table(hwmgr->devi=
ce, index,
> +						  &size, &frev, &crev);
> +
> +	if (!fw_info)
> +		return 0;
> +
> +	reference_clock =3D le16_to_cpu(fw_info->usReferenceClock);
> +
> +	divide =3D PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__S=
MC, CG_CLKPIN_CNTL, XTALIN_DIVIDE);
> +
> +	if (0 !=3D divide)
> +		return reference_clock / 4;
> +
> +	return reference_clock;
> +}
> +
> +static int iceland_set_mclk_od(struct pp_hwmgr *hwmgr, uint32_t value)=

> +{
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +	struct iceland_single_dpm_table *golden_mclk_table =3D
> +			&(data->golden_dpm_table.mclk_table);
> +	struct pp_power_state  *ps;
> +	struct iceland_power_state  *iceland_ps;
> +
> +	if (value > 20)
> +		value =3D 20;
> +
> +	ps =3D hwmgr->request_ps;
> +
> +	if (ps =3D=3D NULL)
> +		return -EINVAL;
> +
> +	iceland_ps =3D cast_phw_iceland_power_state(&ps->hardware);
> +
> +	iceland_ps->performance_levels[iceland_ps->performance_level_count - =
1].memory_clock =3D
> +			golden_mclk_table->dpm_levels[golden_mclk_table->count - 1].value *=

> +			value / 100 +
> +			golden_mclk_table->dpm_levels[golden_mclk_table->count - 1].value;
> +
> +	return 0;
> +}
> +
> +static const struct pp_hwmgr_func iceland_hwmgr_funcs =3D {
> +	.backend_init =3D &iceland_hwmgr_backend_init,
> +	.backend_fini =3D &iceland_hwmgr_backend_fini,
> +	.asic_setup =3D &iceland_setup_asic_task,
> +	.dynamic_state_management_enable =3D &iceland_enable_dpm_tasks,
> +	.apply_state_adjust_rules =3D iceland_apply_state_adjust_rules,
> +	.force_dpm_level =3D &iceland_force_dpm_level,
> +	.power_state_set =3D iceland_set_power_state_tasks,
> +	.get_power_state_size =3D iceland_get_power_state_size,
> +	.get_mclk =3D iceland_dpm_get_mclk,
> +	.get_sclk =3D iceland_dpm_get_sclk,
> +	.patch_boot_state =3D iceland_dpm_patch_boot_state,
> +	.get_pp_table_entry =3D iceland_get_pp_table_entry,
> +	.get_num_of_pp_table_entries =3D iceland_get_num_of_entries,
> +	.print_current_perforce_level =3D iceland_print_current_perforce_leve=
l,
> +	.powerdown_uvd =3D iceland_phm_powerdown_uvd,
> +	.powergate_uvd =3D iceland_phm_powergate_uvd,
> +	.powergate_vce =3D iceland_phm_powergate_vce,
> +	.disable_clock_power_gating =3D iceland_phm_disable_clock_power_gatin=
g,
> +	.update_clock_gatings =3D iceland_phm_update_clock_gatings,
> +	.notify_smc_display_config_after_ps_adjustment =3D iceland_notify_smc=
_display_config_after_ps_adjustment,
> +	.display_config_changed =3D iceland_display_configuration_changed_tas=
k,
> +	.set_max_fan_pwm_output =3D iceland_set_max_fan_pwm_output,
> +	.set_max_fan_rpm_output =3D iceland_set_max_fan_rpm_output,
> +	.get_temperature =3D iceland_thermal_get_temperature,
> +	.stop_thermal_controller =3D iceland_thermal_stop_thermal_controller,=

> +	.get_fan_speed_info =3D iceland_fan_ctrl_get_fan_speed_info,
> +	.get_fan_speed_percent =3D iceland_fan_ctrl_get_fan_speed_percent,
> +	.set_fan_speed_percent =3D iceland_fan_ctrl_set_fan_speed_percent,
> +	.reset_fan_speed_to_default =3D iceland_fan_ctrl_reset_fan_speed_to_d=
efault,
> +	.get_fan_speed_rpm =3D iceland_fan_ctrl_get_fan_speed_rpm,
> +	.set_fan_speed_rpm =3D iceland_fan_ctrl_set_fan_speed_rpm,
> +	.uninitialize_thermal_controller =3D iceland_thermal_ctrl_uninitializ=
e_thermal_controller,
> +	.register_internal_thermal_interrupt =3D iceland_register_internal_th=
ermal_interrupt,
> +	.check_smc_update_required_for_display_configuration =3D iceland_chec=
k_smc_update_required_for_display_configuration,
> +	.check_states_equal =3D iceland_check_states_equal,
> +	.set_fan_control_mode =3D iceland_set_fan_control_mode,
> +	.get_fan_control_mode =3D iceland_get_fan_control_mode,
> +	.force_clock_level =3D iceland_force_clock_level,
> +	.print_clock_levels =3D iceland_print_clock_levels,
> +	.get_sclk_od =3D iceland_get_sclk_od,
> +	.set_sclk_od =3D iceland_set_sclk_od,
> +	.get_mclk_od =3D iceland_get_mclk_od,
> +	.set_mclk_od =3D iceland_set_mclk_od,
> +};
> +
> +int iceland_hwmgr_init(struct pp_hwmgr *hwmgr)
> +{
> +	iceland_hwmgr  *data;
> +
> +	data =3D kzalloc (sizeof(iceland_hwmgr), GFP_KERNEL);
> +	if (data =3D=3D NULL)
> +		return -ENOMEM;
> +	memset(data, 0x00, sizeof(iceland_hwmgr));
> +
> +	hwmgr->backend =3D data;
> +	hwmgr->hwmgr_func =3D &iceland_hwmgr_funcs;
> +	hwmgr->pptable_func =3D &pptable_funcs;
> +
> +	/* thermal */
> +	pp_iceland_thermal_initialize(hwmgr);
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.h b/driv=
ers/gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.h
> new file mode 100644
> index 0000000..f253988
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.h
> @@ -0,0 +1,424 @@
> +/*
> + * Copyright 2016 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> + * copy of this software and associated documentation files (the "Soft=
ware"),
> + * to deal in the Software without restriction, including without limi=
tation
> + * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> + * and/or sell copies of the Software, and to permit persons to whom t=
he
> + * Software is furnished to do so, subject to the following conditions=
:
> + *
> + * The above copyright notice and this permission notice shall be incl=
uded in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Author: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> + *
> + */
> +#ifndef ICELAND_HWMGR_H
> +#define ICELAND_HWMGR_H
> +
> +#include "hwmgr.h"
> +#include "ppatomctrl.h"
> +#include "ppinterrupt.h"
> +#include "ppsmc.h"
> +#include "iceland_powertune.h"
> +#include "pp_endian.h"
> +#include "smu71_discrete.h"
> +
> +#define ICELAND_MAX_HARDWARE_POWERLEVELS 2
> +#define ICELAND_DYNCLK_NUMBER_OF_TREND_COEFFICIENTS 15
> +
> +struct iceland_performance_level {
> +	uint32_t	memory_clock;
> +	uint32_t	engine_clock;
> +	uint16_t	pcie_gen;
> +	uint16_t	pcie_lane;
> +};
> +
> +struct _phw_iceland_bacos {
> +	uint32_t                          best_match;
> +	uint32_t                          baco_flags;
> +	struct iceland_performance_level		  performance_level;
> +};
> +typedef struct _phw_iceland_bacos phw_iceland_bacos;
> +
> +struct _phw_iceland_uvd_clocks {
> +	uint32_t   VCLK;
> +	uint32_t   DCLK;
> +};
> +
> +typedef struct _phw_iceland_uvd_clocks phw_iceland_uvd_clocks;
> +
> +struct _phw_iceland_vce_clocks {
> +	uint32_t   EVCLK;
> +	uint32_t   ECCLK;
> +};
> +
> +typedef struct _phw_iceland_vce_clocks phw_iceland_vce_clocks;
> +
> +struct iceland_power_state {
> +	uint32_t                    magic;
> +	phw_iceland_uvd_clocks        uvd_clocks;
> +	phw_iceland_vce_clocks        vce_clocks;
> +	uint32_t                    sam_clk;
> +	uint32_t                    acp_clk;
> +	uint16_t                    performance_level_count;
> +	bool                        dc_compatible;
> +	uint32_t                    sclk_threshold;
> +	struct iceland_performance_level performance_levels[ICELAND_MAX_HARDW=
ARE_POWERLEVELS];
> +};
> +
> +struct _phw_iceland_dpm_level {
> +	bool		enabled;
> +	uint32_t    value;
> +	uint32_t    param1;
> +};
> +typedef struct _phw_iceland_dpm_level phw_iceland_dpm_level;
> +
> +#define ICELAND_MAX_DEEPSLEEP_DIVIDER_ID 5
> +#define MAX_REGULAR_DPM_NUMBER 8
> +#define ICELAND_MINIMUM_ENGINE_CLOCK 5000
> +
> +struct iceland_single_dpm_table {
> +	uint32_t count;
> +	phw_iceland_dpm_level dpm_levels[MAX_REGULAR_DPM_NUMBER];
> +};
> +
> +struct iceland_dpm_table {
> +	struct iceland_single_dpm_table  sclk_table;
> +	struct iceland_single_dpm_table  mclk_table;
> +	struct iceland_single_dpm_table  pcie_speed_table;
> +	struct iceland_single_dpm_table  vddc_table;
> +	struct iceland_single_dpm_table  vdd_gfx_table;
> +	struct iceland_single_dpm_table  vdd_ci_table;
> +	struct iceland_single_dpm_table  mvdd_table;
> +};
> +typedef struct _phw_iceland_dpm_table phw_iceland_dpm_table;
> +
> +
> +struct _phw_iceland_clock_regisiters {
> +	uint32_t  vCG_SPLL_FUNC_CNTL;
> +	uint32_t  vCG_SPLL_FUNC_CNTL_2;
> +	uint32_t  vCG_SPLL_FUNC_CNTL_3;
> +	uint32_t  vCG_SPLL_FUNC_CNTL_4;
> +	uint32_t  vCG_SPLL_SPREAD_SPECTRUM;
> +	uint32_t  vCG_SPLL_SPREAD_SPECTRUM_2;
> +	uint32_t  vDLL_CNTL;
> +	uint32_t  vMCLK_PWRMGT_CNTL;
> +	uint32_t  vMPLL_AD_FUNC_CNTL;
> +	uint32_t  vMPLL_DQ_FUNC_CNTL;
> +	uint32_t  vMPLL_FUNC_CNTL;
> +	uint32_t  vMPLL_FUNC_CNTL_1;
> +	uint32_t  vMPLL_FUNC_CNTL_2;
> +	uint32_t  vMPLL_SS1;
> +	uint32_t  vMPLL_SS2;
> +};
> +typedef struct _phw_iceland_clock_regisiters phw_iceland_clock_registe=
rs;
> +
> +struct _phw_iceland_voltage_smio_registers {
> +	uint32_t vs0_vid_lower_smio_cntl;
> +};
> +typedef struct _phw_iceland_voltage_smio_registers phw_iceland_voltage=
_smio_registers;
> +
> +
> +struct _phw_iceland_mc_reg_entry {
> +	uint32_t mclk_max;
> +	uint32_t mc_data[SMU71_DISCRETE_MC_REGISTER_ARRAY_SIZE];
> +};
> +typedef struct _phw_iceland_mc_reg_entry phw_iceland_mc_reg_entry;
> +
> +struct _phw_iceland_mc_reg_table {
> +	uint8_t   last;               /* number of registers*/
> +	uint8_t   num_entries;        /* number of entries in mc_reg_table_en=
try used*/
> +	uint16_t  validflag;          /* indicate the corresponding register =
is valid or not. 1: valid, 0: invalid. bit0->address[0], bit1->address[1]=
, etc.*/
> +	phw_iceland_mc_reg_entry    mc_reg_table_entry[MAX_AC_TIMING_ENTRIES]=
;
> +	SMU71_Discrete_MCRegisterAddress mc_reg_address[SMU71_DISCRETE_MC_REG=
ISTER_ARRAY_SIZE];
> +};
> +typedef struct _phw_iceland_mc_reg_table phw_iceland_mc_reg_table;
> +
> +#define DISABLE_MC_LOADMICROCODE   1
> +#define DISABLE_MC_CFGPROGRAMMING  2
> +
> +
> +/*Ultra Low Voltage parameter structure */
> +struct phw_iceland_ulv_parm{
> +	bool					ulv_supported;
> +	uint32_t   				ch_ulv_parameter;
> +	uint32_t				ulv_volt_change_delay;
> +	struct iceland_performance_level	ulv_power_level;
> +};
> +
> +#define ICELAND_MAX_LEAKAGE_COUNT  8
> +
> +struct phw_iceland_leakage_voltage {
> +	uint16_t  count;
> +	uint16_t  leakage_id[ICELAND_MAX_LEAKAGE_COUNT];
> +	uint16_t  actual_voltage[ICELAND_MAX_LEAKAGE_COUNT];
> +};
> +
> +struct _phw_iceland_display_timing {
> +	uint32_t min_clock_insr;
> +	uint32_t num_existing_displays;
> +};
> +typedef struct _phw_iceland_display_timing phw_iceland_display_timing;=

> +
> +
> +struct phw_iceland_thermal_temperature_setting
> +{
> +	long temperature_low;
> +	long temperature_high;
> +	long temperature_shutdown;
> +};
> +
> +struct _phw_iceland_dpmlevel_enable_mask {
> +	uint32_t uvd_dpm_enable_mask;
> +	uint32_t vce_dpm_enable_mask;
> +	uint32_t acp_dpm_enable_mask;
> +	uint32_t samu_dpm_enable_mask;
> +	uint32_t sclk_dpm_enable_mask;
> +	uint32_t mclk_dpm_enable_mask;
> +	uint32_t pcie_dpm_enable_mask;
> +};
> +typedef struct _phw_iceland_dpmlevel_enable_mask phw_iceland_dpmlevel_=
enable_mask;
> +
> +struct _phw_iceland_pcie_perf_range {
> +	uint16_t max;
> +	uint16_t min;
> +};
> +typedef struct _phw_iceland_pcie_perf_range phw_iceland_pcie_perf_rang=
e;
> +
> +struct _phw_iceland_vbios_boot_state {
> +	uint16_t					mvdd_bootup_value;
> +	uint16_t					vddc_bootup_value;
> +	uint16_t					vddci_bootup_value;
> +	uint16_t					vddgfx_bootup_value;
> +	uint32_t					sclk_bootup_value;
> +	uint32_t					mclk_bootup_value;
> +	uint16_t					pcie_gen_bootup_value;
> +	uint16_t					pcie_lane_bootup_value;
> +};
> +typedef struct _phw_iceland_vbios_boot_state phw_iceland_vbios_boot_st=
ate;
> +
> +#define DPMTABLE_OD_UPDATE_SCLK     0x00000001
> +#define DPMTABLE_OD_UPDATE_MCLK     0x00000002
> +#define DPMTABLE_UPDATE_SCLK        0x00000004
> +#define DPMTABLE_UPDATE_MCLK        0x00000008
> +
> +/* We need to review which fields are needed. */
> +/* This is mostly a copy of the RV7xx/Evergreen structure which is clo=
se, but not identical to the N.Islands one. */
> +struct iceland_hwmgr {
> +	struct iceland_dpm_table               dpm_table;
> +	struct iceland_dpm_table               golden_dpm_table;
> +
> +	uint32_t                           voting_rights_clients0;
> +	uint32_t                           voting_rights_clients1;
> +	uint32_t                           voting_rights_clients2;
> +	uint32_t                           voting_rights_clients3;
> +	uint32_t                           voting_rights_clients4;
> +	uint32_t                           voting_rights_clients5;
> +	uint32_t                           voting_rights_clients6;
> +	uint32_t                           voting_rights_clients7;
> +	uint32_t                           static_screen_threshold_unit;
> +	uint32_t                           static_screen_threshold;
> +	uint32_t                           voltage_control;
> +	uint32_t                           vdd_gfx_control;
> +
> +	uint32_t                           vddc_vddci_delta;
> +	uint32_t                           vddc_vddgfx_delta;
> +
> +	struct pp_interrupt_registration_info    internal_high_thermal_interr=
upt_info;
> +	struct pp_interrupt_registration_info    internal_low_thermal_interru=
pt_info;
> +	struct pp_interrupt_registration_info    smc_to_host_interrupt_info;
> +	uint32_t                          active_auto_throttle_sources;
> +
> +	struct pp_interrupt_registration_info    external_throttle_interrupt;=

> +	irq_handler_func_t             external_throttle_callback;
> +	void                             *external_throttle_context;
> +
> +	struct pp_interrupt_registration_info    ctf_interrupt_info;
> +	irq_handler_func_t             ctf_callback;
> +	void                             *ctf_context;
> +
> +	phw_iceland_clock_registers	  clock_registers;
> +	phw_iceland_voltage_smio_registers  voltage_smio_registers;
> +
> +	bool	is_memory_GDDR5;
> +	uint16_t                          acpi_vddc;
> +	bool	pspp_notify_required;        /* Flag to indicate if PSPP notific=
ation to SBIOS is required */
> +	uint16_t                          force_pcie_gen;            /* The f=
orced PCI-E speed if not 0xffff */
> +	uint16_t                          acpi_pcie_gen;             /* The P=
CI-E speed at ACPI time */
> +	uint32_t                           pcie_gen_cap;             /* The P=
CI-E speed capabilities bitmap from CAIL */
> +	uint32_t                           pcie_lane_cap;            /* The P=
CI-E lane capabilities bitmap from CAIL */
> +	uint32_t                           pcie_spc_cap;             /* Symbo=
l Per Clock Capabilities from registry */
> +	struct phw_iceland_leakage_voltage	vddc_leakage;        /* The Leakag=
e VDDC supported (based on leakage ID).*/
> +	struct phw_iceland_leakage_voltage	vddcgfx_leakage;     /* The Leakag=
e VDDC supported (based on leakage ID). */
> +	struct phw_iceland_leakage_voltage	vddci_leakage;       /* The Leakag=
e VDDCI supported (based on leakage ID). */
> +
> +	uint32_t                           mvdd_control;
> +	uint32_t                           vddc_mask_low;
> +	uint32_t                           mvdd_mask_low;
> +	uint16_t                          max_vddc_in_pp_table;        /* the=
 maximum VDDC value in the powerplay table*/
> +	uint16_t                          min_vddc_in_pp_table;
> +	uint16_t                          max_vddci_in_pp_table;       /* the=
 maximum VDDCI value in the powerplay table */
> +	uint16_t                          min_vddci_in_pp_table;
> +	uint32_t                           mclk_strobe_mode_threshold;
> +	uint32_t                           mclk_stutter_mode_threshold;
> +	uint32_t                           mclk_edc_enable_threshold;
> +	uint32_t                           mclk_edc_wr_enable_threshold;
> +	bool	is_uvd_enabled;
> +	bool	is_xdma_enabled;
> +	phw_iceland_vbios_boot_state      vbios_boot_state;
> +
> +	bool                         battery_state;
> +	bool                         is_tlu_enabled;
> +	bool                         pcie_performance_request;
> +
> +	/* -------------- SMC SRAM Address of firmware header tables --------=
--------*/
> +	uint32_t			sram_end;           /* The first address after the SMC SRA=
M. */
> +	uint32_t			dpm_table_start;    /* The start of the dpm table in the S=
MC SRAM. */
> +	uint32_t			soft_regs_start;    /* The start of the soft registers in =
the SMC SRAM. */
> +	uint32_t			mc_reg_table_start; /* The start of the mc register table =
in the SMC SRAM. */
> +	uint32_t			fan_table_start;    /* The start of the fan table in the S=
MC SRAM. */
> +	uint32_t			arb_table_start;    /* The start of the ARB setting table =
in the SMC SRAM. */
> +	uint32_t			ulv_settings_start;
> +	SMU71_Discrete_DpmTable		smc_state_table;    /* The carbon copy of th=
e SMC state table. */
> +	SMU71_Discrete_MCRegisters      mc_reg_table;
> +	SMU71_Discrete_Ulv              ulv_setting;         /* The carbon co=
py of ULV setting. */
> +
> +	/* -------------- Stuff originally coming from Evergreen ------------=
--------*/
> +	phw_iceland_mc_reg_table	 iceland_mc_reg_table;
> +	uint32_t                         vdd_ci_control;
> +	pp_atomctrl_voltage_table        vddc_voltage_table;
> +	pp_atomctrl_voltage_table        vddci_voltage_table;
> +	pp_atomctrl_voltage_table        vddgfx_voltage_table;
> +	pp_atomctrl_voltage_table        mvdd_voltage_table;
> +
> +	uint32_t                           mgcg_cgtt_local2;
> +	uint32_t                           mgcg_cgtt_local3;
> +	uint32_t                           gpio_debug;
> +	uint32_t			mc_micro_code_feature;
> +	uint32_t			highest_mclk;
> +	uint16_t                          acpi_vdd_ci;
> +	uint8_t                           mvdd_high_index;
> +	uint8_t                           mvdd_low_index;
> +	bool                         dll_defaule_on;
> +	bool                         performance_request_registered;
> +
> +	/* ----------------- Low Power Features ---------------------*/
> +	phw_iceland_bacos					bacos;
> +	struct phw_iceland_ulv_parm              	ulv;
> +
> +	/* ----------------- CAC Stuff ---------------------*/
> +	uint32_t					cac_table_start;
> +	bool                         cac_configuration_required;    /* TRUE i=
f PP_CACConfigurationRequired =3D=3D 1 */
> +	bool                         driver_calculate_cac_leakage;  /* TRUE i=
f PP_DriverCalculateCACLeakage =3D=3D 1 */
> +	bool                         cac_enabled;
> +
> +	/* ----------------- DPM2 Parameters ---------------------*/
> +	uint32_t		power_containment_features;
> +	bool                         enable_bapm_feature;
> +	bool			     enable_dte_feature;
> +	bool                         enable_tdc_limit_feature;
> +	bool                         enable_pkg_pwr_tracking_feature;
> +	bool                         disable_uvd_power_tune_feature;
> +	struct iceland_pt_defaults           *power_tune_defaults;
> +	SMU71_Discrete_PmFuses           power_tune_table;
> +	uint32_t                           ul_dte_tj_offset;     /* Fudge fac=
tor in DPM table to correct HW DTE errors */
> +	uint32_t                           fast_watermark_threshold;  /* use =
fast watermark if clock is equal or above this. In percentage of the targ=
et high sclk. */
> +
> +	/* ----------------- Phase Shedding ---------------------*/
> +	bool                         vddc_phase_shed_control;
> +
> +	/* --------------------- DI/DT --------------------------*/
> +	phw_iceland_display_timing       display_timing;
> +
> +	/* --------- ReadRegistry data for memory and engine clock margins --=
-- */
> +	uint32_t                           engine_clock_data;
> +	uint32_t                           memory_clock_data;
> +
> +	/* -------- Thermal Temperature Setting --------------*/
> +	struct phw_iceland_thermal_temperature_setting 	thermal_temp_setting;=

> +	phw_iceland_dpmlevel_enable_mask     dpm_level_enable_mask;
> +
> +	uint32_t				need_update_smu7_dpm_table;
> +	uint32_t				sclk_dpm_key_disabled;
> +	uint32_t				mclk_dpm_key_disabled;
> +	uint32_t				pcie_dpm_key_disabled;
> +	/* used to store the previous dal min sclock */
> +	uint32_t                           min_engine_clocks;
> +	phw_iceland_pcie_perf_range       pcie_gen_performance;
> +	phw_iceland_pcie_perf_range       pcie_lane_performance;
> +	phw_iceland_pcie_perf_range       pcie_gen_power_saving;
> +	phw_iceland_pcie_perf_range       pcie_lane_power_saving;
> +	bool                            use_pcie_performance_levels;
> +	bool                            use_pcie_power_saving_levels;
> +	/* percentage value from 0-100, default 50 */
> +	uint32_t                           activity_target[SMU71_MAX_LEVELS_G=
RAPHICS];
> +	uint32_t                           mclk_activity_target;
> +	uint32_t                           low_sclk_interrupt_threshold;
> +	uint32_t                           last_mclk_dpm_enable_mask;
> +	bool								uvd_enabled;
> +	uint32_t                           pcc_monitor_enabled;
> +
> +	/* --------- Power Gating States ------------*/
> +	bool                           uvd_power_gated;  /* 1: gated, 0:not g=
ated */
> +	bool                           vce_power_gated;  /* 1: gated, 0:not g=
ated */
> +	bool                           samu_power_gated; /* 1: gated, 0:not g=
ated */
> +	bool                           acp_power_gated;  /* 1: gated, 0:not g=
ated */
> +	bool                           pg_acp_init;
> +
> +	/* soft pptable for re-uploading into smu */
> +	void *soft_pp_table;
> +};
> +
> +typedef struct iceland_hwmgr iceland_hwmgr;
> +
> +int iceland_hwmgr_init(struct pp_hwmgr *hwmgr);
> +int iceland_update_uvd_dpm(struct pp_hwmgr *hwmgr, bool bgate);
> +uint32_t iceland_get_xclk(struct pp_hwmgr *hwmgr);
> +int iceland_populate_bapm_vddc_vid_sidd(struct pp_hwmgr *hwmgr);
> +int iceland_populate_vddc_vid(struct pp_hwmgr *hwmgr);
> +
> +#define ICELAND_DPM2_NEAR_TDP_DEC          10
> +#define ICELAND_DPM2_ABOVE_SAFE_INC        5
> +#define ICELAND_DPM2_BELOW_SAFE_INC        20
> +
> +/*
> + * Log2 of the LTA window size (l2numWin_TDP). Eg. If LTA windows size=

> + * is 128, then this value should be Log2(128) =3D 7.
> + */
> +#define ICELAND_DPM2_LTA_WINDOW_SIZE       7
> +
> +#define ICELAND_DPM2_LTS_TRUNCATE          0
> +
> +#define ICELAND_DPM2_TDP_SAFE_LIMIT_PERCENT            80  // Maximum =
100
> +
> +#define ICELAND_DPM2_MAXPS_PERCENT_H                   90  // Maximum =
0xFF
> +#define ICELAND_DPM2_MAXPS_PERCENT_M                   90  // Maximum =
0xFF
> +
> +#define ICELAND_DPM2_PWREFFICIENCYRATIO_MARGIN         50
> +
> +#define ICELAND_DPM2_SQ_RAMP_MAX_POWER                 0x3FFF
> +#define ICELAND_DPM2_SQ_RAMP_MIN_POWER                 0x12
> +#define ICELAND_DPM2_SQ_RAMP_MAX_POWER_DELTA           0x15
> +#define ICELAND_DPM2_SQ_RAMP_SHORT_TERM_INTERVAL_SIZE  0x1E
> +#define ICELAND_DPM2_SQ_RAMP_LONG_TERM_INTERVAL_RATIO  0xF
> +
> +#define ICELAND_VOLTAGE_CONTROL_NONE                   0x0
> +#define ICELAND_VOLTAGE_CONTROL_BY_GPIO                0x1
> +#define ICELAND_VOLTAGE_CONTROL_BY_SVID2               0x2
> +
> +/* convert to Q8.8 format for firmware */
> +#define ICELAND_Q88_FORMAT_CONVERSION_UNIT             256
> +
> +#define ICELAND_UNUSED_GPIO_PIN 0x7F
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/iceland_powertune.c b/=
drivers/gpu/drm/amd/powerplay/hwmgr/iceland_powertune.c
> new file mode 100644
> index 0000000..d10cd9f
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/iceland_powertune.c
> @@ -0,0 +1,491 @@
> +/*
> + * Copyright 2016 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> + * copy of this software and associated documentation files (the "Soft=
ware"),
> + * to deal in the Software without restriction, including without limi=
tation
> + * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> + * and/or sell copies of the Software, and to permit persons to whom t=
he
> + * Software is furnished to do so, subject to the following conditions=
:
> + *
> + * The above copyright notice and this permission notice shall be incl=
uded in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Author: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> + *
> + */
> +
> +#include "amdgpu.h"
> +#include "hwmgr.h"
> +#include "smumgr.h"
> +#include "iceland_hwmgr.h"
> +#include "iceland_powertune.h"
> +#include "iceland_smumgr.h"
> +#include "smu71_discrete.h"
> +#include "smu71.h"
> +#include "pp_debug.h"
> +#include "cgs_common.h"
> +#include "pp_endian.h"
> +
> +#include "bif/bif_5_0_d.h"
> +#include "bif/bif_5_0_sh_mask.h"
> +
> +#define VOLTAGE_SCALE  4
> +#define POWERTUNE_DEFAULT_SET_MAX    1
> +
> +#define DEVICE_ID_VI_ICELAND_M_6900	0x6900
> +#define DEVICE_ID_VI_ICELAND_M_6901	0x6901
> +#define DEVICE_ID_VI_ICELAND_M_6902	0x6902
> +#define DEVICE_ID_VI_ICELAND_M_6903	0x6903
> +
> +
> +struct iceland_pt_defaults defaults_iceland =3D
> +{
> +	/*
> +	 * sviLoadLIneEn, SviLoadLineVddC, TDC_VDDC_ThrottleReleaseLimitPerc,=

> +	 * TDC_MAWt, TdcWaterfallCtl, DTEAmbientTempBase, DisplayCac, BAPM_TE=
MP_GRADIENT
> +	 */
> +	1, 0xF, 0xFD, 0x19, 5, 45, 0, 0xB0000,
> +	{ 0x79,  0x253, 0x25D, 0xAE,  0x72,  0x80,  0x83,  0x86,  0x6F,  0xC8=
,  0xC9,  0xC9,  0x2F,  0x4D,  0x61  },
> +	{ 0x17C, 0x172, 0x180, 0x1BC, 0x1B3, 0x1BD, 0x206, 0x200, 0x203, 0x25=
D, 0x25A, 0x255, 0x2C3, 0x2C5, 0x2B4 }
> +};
> +
> +/* 35W - XT, XTL */
> +struct iceland_pt_defaults defaults_icelandxt =3D
> +{
> +	/*
> +	 * sviLoadLIneEn, SviLoadLineVddC,
> +	 * TDC_VDDC_ThrottleReleaseLimitPerc, TDC_MAWt,
> +	 * TdcWaterfallCtl, DTEAmbientTempBase, DisplayCac,
> +	 * BAPM_TEMP_GRADIENT
> +	 */
> +	1, 0xF, 0xFD, 0x19, 5, 45, 0, 0x0,
> +	{ 0xA7,  0x0, 0x0, 0xB5,  0x0, 0x0, 0x9F,  0x0, 0x0, 0xD6,  0x0, 0x0,=
 0xD7,  0x0, 0x0},
> +	{ 0x1EA, 0x0, 0x0, 0x224, 0x0, 0x0, 0x25E, 0x0, 0x0, 0x28E, 0x0, 0x0,=
 0x2AB, 0x0, 0x0}
> +};
> +
> +/* 25W - PRO, LE */
> +struct iceland_pt_defaults defaults_icelandpro =3D
> +{
> +	/*
> +	 * sviLoadLIneEn, SviLoadLineVddC,
> +	 * TDC_VDDC_ThrottleReleaseLimitPerc, TDC_MAWt,
> +	 * TdcWaterfallCtl, DTEAmbientTempBase, DisplayCac,
> +	 * BAPM_TEMP_GRADIENT
> +	 */
> +	1, 0xF, 0xFD, 0x19, 5, 45, 0, 0x0,
> +	{ 0xB7,  0x0, 0x0, 0xC3,  0x0, 0x0, 0xB5,  0x0, 0x0, 0xEA,  0x0, 0x0,=
 0xE6,  0x0, 0x0},
> +	{ 0x1EA, 0x0, 0x0, 0x224, 0x0, 0x0, 0x25E, 0x0, 0x0, 0x28E, 0x0, 0x0,=
 0x2AB, 0x0, 0x0}
> +};
> +
> +void iceland_initialize_power_tune_defaults(struct pp_hwmgr *hwmgr)
> +{
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +	uint32_t tmp =3D 0;
> +	struct cgs_system_info sys_info =3D {0};
> +	uint32_t pdev_id;
> +
> +	sys_info.size =3D sizeof(struct cgs_system_info);
> +	sys_info.info_id =3D CGS_SYSTEM_INFO_PCIE_DEV;
> +	cgs_query_system_info(hwmgr->device, &sys_info);
> +	pdev_id =3D (uint32_t)sys_info.value;
> +
> +	switch (pdev_id) {
> +	case DEVICE_ID_VI_ICELAND_M_6900:
> +	case DEVICE_ID_VI_ICELAND_M_6903:
> +		data->power_tune_defaults =3D &defaults_icelandxt;
> +		break;
> +
> +	case DEVICE_ID_VI_ICELAND_M_6901:
> +	case DEVICE_ID_VI_ICELAND_M_6902:
> +		data->power_tune_defaults =3D &defaults_icelandpro;
> +		break;
> +	default:
> +	    /* TODO: need to assign valid defaults */
> +	    data->power_tune_defaults =3D &defaults_iceland;
> +	    pr_warning("Unknown V.I. Device ID.\n");
> +	    break;
> +	}
> +
> +	/* Assume disabled */
> +	phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
> +			PHM_PlatformCaps_PowerContainment);
> +	phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
> +			PHM_PlatformCaps_CAC);
> +	phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
> +			PHM_PlatformCaps_SQRamping);
> +	phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
> +			PHM_PlatformCaps_DBRamping);
> +	phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
> +			PHM_PlatformCaps_TDRamping);
> +	phm_cap_unset(hwmgr->platform_descriptor.platformCaps,
> +			PHM_PlatformCaps_TCPRamping);
> +
> +	data->ul_dte_tj_offset =3D tmp;
> +
> +	if (!tmp) {
> +		phm_cap_set(hwmgr->platform_descriptor.platformCaps,
> +				PHM_PlatformCaps_CAC);
> +
> +		data->fast_watermark_threshold =3D 100;
> +
> +		if (hwmgr->powercontainment_enabled) {
> +			phm_cap_set(hwmgr->platform_descriptor.platformCaps,
> +				    PHM_PlatformCaps_PowerContainment);
> +			tmp =3D 1;
> +			data->enable_dte_feature =3D tmp ? false : true;
> +			data->enable_tdc_limit_feature =3D tmp ? true : false;
> +			data->enable_pkg_pwr_tracking_feature =3D tmp ? true : false;
> +		}
> +	}
> +}
> +
> +int iceland_populate_bapm_parameters_in_dpm_table(struct pp_hwmgr *hwm=
gr)
> +{
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +	struct iceland_pt_defaults *defaults =3D data->power_tune_defaults;
> +	SMU71_Discrete_DpmTable  *dpm_table =3D &(data->smc_state_table);
> +	struct phm_cac_tdp_table *cac_dtp_table =3D hwmgr->dyn_state.cac_dtp_=
table;
> +	struct phm_ppm_table *ppm =3D hwmgr->dyn_state.ppm_parameter_table;
> +	uint16_t *def1, *def2;
> +	int i, j, k;
> +
> +	/*
> +	 * TDP number of fraction bits are changed from 8 to 7 for Iceland
> +	 * as requested by SMC team
> +	 */
> +	dpm_table->DefaultTdp =3D PP_HOST_TO_SMC_US((uint16_t)(cac_dtp_table-=
>usTDP * 256));
> +	dpm_table->TargetTdp =3D PP_HOST_TO_SMC_US((uint16_t)(cac_dtp_table->=
usConfigurableTDP * 256));
> +
> +	dpm_table->DTETjOffset =3D (uint8_t)data->ul_dte_tj_offset;
> +
> +	dpm_table->GpuTjMax =3D (uint8_t)(data->thermal_temp_setting.temperat=
ure_high / PP_TEMPERATURE_UNITS_PER_CENTIGRADES);
> +	dpm_table->GpuTjHyst =3D 8;
> +
> +	dpm_table->DTEAmbientTempBase =3D defaults->dte_ambient_temp_base;
> +
> +	/* The following are for new Iceland Multi-input fan/thermal control =
*/
> +	if(NULL !=3D ppm) {
> +		dpm_table->PPM_PkgPwrLimit =3D (uint16_t)ppm->dgpu_tdp * 256 / 1000;=

> +		dpm_table->PPM_TemperatureLimit =3D (uint16_t)ppm->tj_max * 256;
> +	} else {
> +		dpm_table->PPM_PkgPwrLimit =3D 0;
> +		dpm_table->PPM_TemperatureLimit =3D 0;
> +	}
> +
> +	CONVERT_FROM_HOST_TO_SMC_US(dpm_table->PPM_PkgPwrLimit);
> +	CONVERT_FROM_HOST_TO_SMC_US(dpm_table->PPM_TemperatureLimit);
> +
> +	dpm_table->BAPM_TEMP_GRADIENT =3D PP_HOST_TO_SMC_UL(defaults->bamp_te=
mp_gradient);
> +	def1 =3D defaults->bapmti_r;
> +	def2 =3D defaults->bapmti_rc;
> +
> +	for (i =3D 0; i < SMU71_DTE_ITERATIONS; i++) {
> +		for (j =3D 0; j < SMU71_DTE_SOURCES; j++) {
> +			for (k =3D 0; k < SMU71_DTE_SINKS; k++) {
> +				dpm_table->BAPMTI_R[i][j][k] =3D PP_HOST_TO_SMC_US(*def1);
> +				dpm_table->BAPMTI_RC[i][j][k] =3D PP_HOST_TO_SMC_US(*def2);
> +				def1++;
> +				def2++;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int iceland_populate_svi_load_line(struct pp_hwmgr *hwmgr)
> +{
> +    struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->bac=
kend);
> +    const struct iceland_pt_defaults *defaults =3D data->power_tune_de=
faults;
> +
> +    data->power_tune_table.SviLoadLineEn =3D defaults->svi_load_line_e=
n;
> +    data->power_tune_table.SviLoadLineVddC =3D defaults->svi_load_line=
_vddc;
> +    data->power_tune_table.SviLoadLineTrimVddC =3D 3;
> +    data->power_tune_table.SviLoadLineOffsetVddC =3D 0;
> +
> +    return 0;
> +}
> +
> +static int iceland_populate_tdc_limit(struct pp_hwmgr *hwmgr)
> +{
> +	uint16_t tdc_limit;
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +	const struct iceland_pt_defaults *defaults =3D data->power_tune_defau=
lts;
> +
> +	/* TDC number of fraction bits are changed from 8 to 7
> +	 * for Iceland as requested by SMC team
> +	 */
> +	tdc_limit =3D (uint16_t)(hwmgr->dyn_state.cac_dtp_table->usTDC * 256)=
;
> +	data->power_tune_table.TDC_VDDC_PkgLimit =3D
> +			CONVERT_FROM_HOST_TO_SMC_US(tdc_limit);
> +	data->power_tune_table.TDC_VDDC_ThrottleReleaseLimitPerc =3D
> +			defaults->tdc_vddc_throttle_release_limit_perc;
> +	data->power_tune_table.TDC_MAWt =3D defaults->tdc_mawt;
> +
> +	return 0;
> +}
> +
> +static int iceland_populate_dw8(struct pp_hwmgr *hwmgr, uint32_t fuse_=
table_offset)
> +{
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +	const struct iceland_pt_defaults *defaults =3D data->power_tune_defau=
lts;
> +	uint32_t temp;
> +
> +	if (iceland_read_smc_sram_dword(hwmgr->smumgr,
> +			fuse_table_offset +
> +			offsetof(SMU71_Discrete_PmFuses, TdcWaterfallCtl),
> +			(uint32_t *)&temp, data->sram_end))
> +		PP_ASSERT_WITH_CODE(false,
> +				"Attempt to read PmFuses.DW6 (SviLoadLineEn) from SMC Failed!",
> +				return -EINVAL);
> +	else
> +		data->power_tune_table.TdcWaterfallCtl =3D defaults->tdc_waterfall_c=
tl;
> +
> +	return 0;
> +}
> +
> +static int iceland_populate_temperature_scaler(struct pp_hwmgr *hwmgr)=

> +{
> +	return 0;
> +}
> +
> +static int iceland_populate_gnb_lpml(struct pp_hwmgr *hwmgr)
> +{
> +	int i;
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +
> +	/* Currently not used. Set all to zero. */
> +	for (i =3D 0; i < 8; i++)
> +		data->power_tune_table.GnbLPML[i] =3D 0;
> +
> +	return 0;
> +}
> +
> +static int iceland_min_max_vgnb_lpml_id_from_bapm_vddc(struct pp_hwmgr=
 *hwmgr)
> +{
> +    return 0;
> +}
> +
> +static int iceland_populate_bapm_vddc_base_leakage_sidd(struct pp_hwmg=
r *hwmgr)
> +{
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +	uint16_t HiSidd =3D data->power_tune_table.BapmVddCBaseLeakageHiSidd;=

> +	uint16_t LoSidd =3D data->power_tune_table.BapmVddCBaseLeakageLoSidd;=

> +	struct phm_cac_tdp_table *cac_table =3D hwmgr->dyn_state.cac_dtp_tabl=
e;
> +
> +	HiSidd =3D (uint16_t)(cac_table->usHighCACLeakage / 100 * 256);
> +	LoSidd =3D (uint16_t)(cac_table->usLowCACLeakage / 100 * 256);
> +
> +	data->power_tune_table.BapmVddCBaseLeakageHiSidd =3D
> +			CONVERT_FROM_HOST_TO_SMC_US(HiSidd);
> +	data->power_tune_table.BapmVddCBaseLeakageLoSidd =3D
> +			CONVERT_FROM_HOST_TO_SMC_US(LoSidd);
> +
> +	return 0;
> +}
> +
> +int iceland_populate_pm_fuses(struct pp_hwmgr *hwmgr)
> +{
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +	uint32_t pm_fuse_table_offset;
> +
> +	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
> +			PHM_PlatformCaps_PowerContainment)) {
> +		if (iceland_read_smc_sram_dword(hwmgr->smumgr,
> +				SMU71_FIRMWARE_HEADER_LOCATION +
> +				offsetof(SMU71_Firmware_Header, PmFuseTable),
> +				&pm_fuse_table_offset, data->sram_end))
> +			PP_ASSERT_WITH_CODE(false,
> +					"Attempt to get pm_fuse_table_offset Failed!",
> +					return -EINVAL);
> +
> +		/* DW0 - DW3 */
> +		if (iceland_populate_bapm_vddc_vid_sidd(hwmgr))
> +			PP_ASSERT_WITH_CODE(false,
> +					"Attempt to populate bapm vddc vid Failed!",
> +					return -EINVAL);
> +
> +		/* DW4 - DW5 */
> +		if (iceland_populate_vddc_vid(hwmgr))
> +			PP_ASSERT_WITH_CODE(false,
> +					"Attempt to populate vddc vid Failed!",
> +					return -EINVAL);
> +
> +		/* DW6 */
> +		if (iceland_populate_svi_load_line(hwmgr))
> +			PP_ASSERT_WITH_CODE(false,
> +					"Attempt to populate SviLoadLine Failed!",
> +					return -EINVAL);
> +		/* DW7 */
> +		if (iceland_populate_tdc_limit(hwmgr))
> +			PP_ASSERT_WITH_CODE(false,
> +					"Attempt to populate TDCLimit Failed!", return -EINVAL);
> +		/* DW8 */
> +		if (iceland_populate_dw8(hwmgr, pm_fuse_table_offset))
> +			PP_ASSERT_WITH_CODE(false,
> +					"Attempt to populate TdcWaterfallCtl, "
> +					"LPMLTemperature Min and Max Failed!",
> +					return -EINVAL);
> +
> +		/* DW9-DW12 */
> +		if (0 !=3D iceland_populate_temperature_scaler(hwmgr))
> +			PP_ASSERT_WITH_CODE(false,
> +					"Attempt to populate LPMLTemperatureScaler Failed!",
> +					return -EINVAL);
> +
> +		/* DW13-DW16 */
> +		if (iceland_populate_gnb_lpml(hwmgr))
> +			PP_ASSERT_WITH_CODE(false,
> +					"Attempt to populate GnbLPML Failed!",
> +					return -EINVAL);
> +
> +		/* DW17 */
> +		if (iceland_min_max_vgnb_lpml_id_from_bapm_vddc(hwmgr))
> +			PP_ASSERT_WITH_CODE(false,
> +					"Attempt to populate GnbLPML Min and Max Vid Failed!",
> +					return -EINVAL);
> +
> +		/* DW18 */
> +		if (iceland_populate_bapm_vddc_base_leakage_sidd(hwmgr))
> +			PP_ASSERT_WITH_CODE(false,
> +					"Attempt to populate BapmVddCBaseLeakage Hi and Lo Sidd Failed!",=

> +					return -EINVAL);
> +
> +		if (iceland_copy_bytes_to_smc(hwmgr->smumgr, pm_fuse_table_offset,
> +				(uint8_t *)&data->power_tune_table,
> +				sizeof(struct SMU71_Discrete_PmFuses), data->sram_end))
> +			PP_ASSERT_WITH_CODE(false,
> +					"Attempt to download PmFuseTable Failed!",
> +					return -EINVAL);
> +	}
> +	return 0;
> +}
> +
> +int iceland_enable_smc_cac(struct pp_hwmgr *hwmgr)
> +{
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +	int result =3D 0;
> +
> +	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
> +			PHM_PlatformCaps_CAC)) {
> +		int smc_result;
> +		smc_result =3D smum_send_msg_to_smc(hwmgr->smumgr,
> +				(uint16_t)(PPSMC_MSG_EnableCac));
> +		PP_ASSERT_WITH_CODE((0 =3D=3D smc_result),
> +				"Failed to enable CAC in SMC.", result =3D -1);
> +
> +		data->cac_enabled =3D (0 =3D=3D smc_result) ? true : false;
> +	}
> +	return result;
> +}
> +
> +static int iceland_set_power_limit(struct pp_hwmgr *hwmgr, uint32_t n)=

> +{
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +
> +	if(data->power_containment_features &
> +			POWERCONTAINMENT_FEATURE_PkgPwrLimit)
> +		return smum_send_msg_to_smc_with_parameter(hwmgr->smumgr,
> +				PPSMC_MSG_PkgPwrSetLimit, n);
> +	return 0;
> +}
> +
> +static int iceland_set_overdriver_target_tdp(struct pp_hwmgr *pHwMgr, =
uint32_t target_tdp)
> +{
> +	return smum_send_msg_to_smc_with_parameter(pHwMgr->smumgr,
> +			PPSMC_MSG_OverDriveSetTargetTdp, target_tdp);
> +}
> +
> +int iceland_enable_power_containment(struct pp_hwmgr *hwmgr)
> +{
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +	SMU71_Discrete_DpmTable *dpm_table =3D &data->smc_state_table;
> +	int smc_result;
> +	int result =3D 0;
> +	uint32_t is_asic_kicker;
> +
> +	data->power_containment_features =3D 0;
> +	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
> +			PHM_PlatformCaps_PowerContainment)) {
> +		is_asic_kicker =3D cgs_read_register(hwmgr->device, mmCC_BIF_BX_STRA=
P2);
> +		is_asic_kicker =3D (is_asic_kicker >> 12) & 0x01;
> +
> +		if (data->enable_bapm_feature &&
> +			(!is_asic_kicker ||
> +			 phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
> +				 PHM_PlatformCaps_DisableUsingActualTemperatureForPowerCalc))) {
> +			smc_result =3D smum_send_msg_to_smc(hwmgr->smumgr,
> +					(uint16_t)(PPSMC_MSG_EnableDTE));
> +			PP_ASSERT_WITH_CODE((0 =3D=3D smc_result),
> +					"Failed to enable BAPM in SMC.", result =3D -1;);
> +			if (0 =3D=3D smc_result)
> +				data->power_containment_features |=3D POWERCONTAINMENT_FEATURE_BAP=
M;
> +		}
> +
> +		if (is_asic_kicker && !phm_cap_enabled(hwmgr->platform_descriptor.pl=
atformCaps,
> +				PHM_PlatformCaps_DisableUsingActualTemperatureForPowerCalc))
> +			dpm_table->DTEMode =3D 2;
> +
> +		if (data->enable_tdc_limit_feature) {
> +			smc_result =3D smum_send_msg_to_smc(hwmgr->smumgr,
> +					(uint16_t)(PPSMC_MSG_TDCLimitEnable));
> +			PP_ASSERT_WITH_CODE((0 =3D=3D smc_result),
> +					"Failed to enable TDCLimit in SMC.", result =3D -1;);
> +			if (0 =3D=3D smc_result)
> +				data->power_containment_features |=3D
> +						POWERCONTAINMENT_FEATURE_TDCLimit;
> +		}
> +
> +		if (data->enable_pkg_pwr_tracking_feature) {
> +			smc_result =3D smum_send_msg_to_smc(hwmgr->smumgr,
> +					(uint16_t)(PPSMC_MSG_PkgPwrLimitEnable));
> +			PP_ASSERT_WITH_CODE((0 =3D=3D smc_result),
> +					"Failed to enable PkgPwrTracking in SMC.", result =3D -1;);
> +			if (0 =3D=3D smc_result) {
> +				struct phm_cac_tdp_table *cac_table =3D
> +						hwmgr->dyn_state.cac_dtp_table;
> +				uint32_t default_limit =3D
> +					(uint32_t)(cac_table->usMaximumPowerDeliveryLimit * 256);
> +
> +				data->power_containment_features |=3D
> +						POWERCONTAINMENT_FEATURE_PkgPwrLimit;
> +
> +				if (iceland_set_power_limit(hwmgr, default_limit))
> +					printk(KERN_ERR "Failed to set Default Power Limit in SMC!");
> +			}
> +		}
> +	}
> +	return result;
> +}
> +
> +int iceland_power_control_set_level(struct pp_hwmgr *hwmgr)
> +{
> +	struct phm_cac_tdp_table *cac_table =3D hwmgr->dyn_state.cac_dtp_tabl=
e;
> +	int adjust_percent, target_tdp;
> +	int result =3D 0;
> +
> +	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
> +			PHM_PlatformCaps_PowerContainment)) {
> +		/* adjustment percentage has already been validated */
> +		adjust_percent =3D hwmgr->platform_descriptor.TDPAdjustmentPolarity =
?
> +				hwmgr->platform_descriptor.TDPAdjustment :
> +				(-1 * hwmgr->platform_descriptor.TDPAdjustment);
> +		/*
> +		 * SMC requested that target_tdp to be 7 bit fraction in DPM table
> +		 * but message to be 8 bit fraction for messages
> +		 */
> +		target_tdp =3D ((100 + adjust_percent) * (int)(cac_table->usTDP * 25=
6)) / 100;
> +		result =3D iceland_set_overdriver_target_tdp(hwmgr, (uint32_t)target=
_tdp);
> +	}
> +
> +	return result;
> +}
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/iceland_powertune.h b/=
drivers/gpu/drm/amd/powerplay/hwmgr/iceland_powertune.h
> new file mode 100644
> index 0000000..6c25ee1
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/iceland_powertune.h
> @@ -0,0 +1,74 @@
> +/*
> + * Copyright 2016 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> + * copy of this software and associated documentation files (the "Soft=
ware"),
> + * to deal in the Software without restriction, including without limi=
tation
> + * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> + * and/or sell copies of the Software, and to permit persons to whom t=
he
> + * Software is furnished to do so, subject to the following conditions=
:
> + *
> + * The above copyright notice and this permission notice shall be incl=
uded in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Author: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> + *
> + */
> +#ifndef ICELAND_POWERTUNE_H
> +#define ICELAND_POWERTUNE_H
> +
> +#include "smu71.h"
> +
> +enum iceland_pt_config_reg_type {
> +	ICELAND_CONFIGREG_MMR =3D 0,
> +	ICELAND_CONFIGREG_SMC_IND,
> +	ICELAND_CONFIGREG_DIDT_IND,
> +	ICELAND_CONFIGREG_CACHE,
> +	ICELAND_CONFIGREG_MAX
> +};
> +
> +/* PowerContainment Features */
> +#define POWERCONTAINMENT_FEATURE_DTE             0x00000001
> +#define POWERCONTAINMENT_FEATURE_TDCLimit        0x00000002
> +#define POWERCONTAINMENT_FEATURE_PkgPwrLimit     0x00000004
> +#define POWERCONTAINMENT_FEATURE_BAPM		 0x00000001
> +
> +struct iceland_pt_config_reg {
> +	uint32_t                           offset;
> +	uint32_t                           mask;
> +	uint32_t                           shift;
> +	uint32_t                           value;
> +	enum iceland_pt_config_reg_type       type;
> +};
> +
> +struct iceland_pt_defaults
> +{
> +	uint8_t   svi_load_line_en;
> +	uint8_t   svi_load_line_vddc;
> +	uint8_t   tdc_vddc_throttle_release_limit_perc;
> +	uint8_t   tdc_mawt;
> +	uint8_t   tdc_waterfall_ctl;
> +	uint8_t   dte_ambient_temp_base;
> +	uint32_t  display_cac;
> +	uint32_t  bamp_temp_gradient;
> +	uint16_t  bapmti_r[SMU71_DTE_ITERATIONS * SMU71_DTE_SOURCES * SMU71_D=
TE_SINKS];
> +	uint16_t  bapmti_rc[SMU71_DTE_ITERATIONS * SMU71_DTE_SOURCES * SMU71_=
DTE_SINKS];
> +};
> +
> +void iceland_initialize_power_tune_defaults(struct pp_hwmgr *hwmgr);
> +int iceland_populate_bapm_parameters_in_dpm_table(struct pp_hwmgr *hwm=
gr);
> +int iceland_populate_pm_fuses(struct pp_hwmgr *hwmgr);
> +int iceland_enable_smc_cac(struct pp_hwmgr *hwmgr);
> +int iceland_enable_power_containment(struct pp_hwmgr *hwmgr);
> +int iceland_power_control_set_level(struct pp_hwmgr *hwmgr);
> +
> +#endif  /* ICELAND_POWERTUNE_H */
> +
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/iceland_thermal.c b/dr=
ivers/gpu/drm/amd/powerplay/hwmgr/iceland_thermal.c
> new file mode 100644
> index 0000000..527f370
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/iceland_thermal.c
> @@ -0,0 +1,595 @@
> +/*
> + * Copyright 2016 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> + * copy of this software and associated documentation files (the "Soft=
ware"),
> + * to deal in the Software without restriction, including without limi=
tation
> + * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> + * and/or sell copies of the Software, and to permit persons to whom t=
he
> + * Software is furnished to do so, subject to the following conditions=
:
> + *
> + * The above copyright notice and this permission notice shall be incl=
uded in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Author: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> + *
> + */
> +#include <asm/div64.h>
> +#include "iceland_thermal.h"
> +#include "iceland_hwmgr.h"
> +#include "iceland_smumgr.h"
> +#include "atombios.h"
> +#include "ppsmc.h"
> +
> +#include "gmc/gmc_8_1_d.h"
> +#include "gmc/gmc_8_1_sh_mask.h"
> +
> +#include "bif/bif_5_0_d.h"
> +#include "bif/bif_5_0_sh_mask.h"
> +
> +#include "smu/smu_7_1_1_d.h"
> +#include "smu/smu_7_1_1_sh_mask.h"
> +
> +
> +/**
> +* Get Fan Speed Control Parameters.
> +* @param    hwmgr  the address of the powerplay hardware manager.
> +* @param    pSpeed is the address of the structure where the result is=
 to be placed.
> +* @exception Always succeeds except if we cannot zero out the output s=
tructure.
> +*/
> +int iceland_fan_ctrl_get_fan_speed_info(struct pp_hwmgr *hwmgr,
> +					struct phm_fan_speed_info *fan_speed_info)
> +{
> +
> +	if (hwmgr->thermal_controller.fanInfo.bNoFan)
> +		return 0;
> +
> +	fan_speed_info->supports_percent_read =3D true;
> +	fan_speed_info->supports_percent_write =3D true;
> +	fan_speed_info->min_percent =3D 0;
> +	fan_speed_info->max_percent =3D 100;
> +
> +	if (0 !=3D hwmgr->thermal_controller.fanInfo.ucTachometerPulsesPerRev=
olution) {
> +		fan_speed_info->supports_rpm_read =3D true;
> +		fan_speed_info->supports_rpm_write =3D true;
> +		fan_speed_info->min_rpm =3D hwmgr->thermal_controller.fanInfo.ulMinR=
PM;
> +		fan_speed_info->max_rpm =3D hwmgr->thermal_controller.fanInfo.ulMaxR=
PM;
> +	} else {
> +		fan_speed_info->min_rpm =3D 0;
> +		fan_speed_info->max_rpm =3D 0;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> +* Get Fan Speed in percent.
> +* @param    hwmgr  the address of the powerplay hardware manager.
> +* @param    pSpeed is the address of the structure where the result is=
 to be placed.
> +* @exception Fails is the 100% setting appears to be 0.
> +*/
> +int iceland_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwmgr, uin=
t32_t *speed)
> +{
> +	uint32_t duty100;
> +	uint32_t duty;
> +	uint64_t tmp64;
> +
> +	if (hwmgr->thermal_controller.fanInfo.bNoFan)
> +		return 0;
> +
> +	duty100 =3D PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__=
SMC, CG_FDO_CTRL1, FMAX_DUTY100);
> +	duty =3D PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC=
, CG_THERMAL_STATUS, FDO_PWM_DUTY);
> +
> +	if (0 =3D=3D duty100)
> +		return -EINVAL;
> +
> +
> +	tmp64 =3D (uint64_t)duty * 100;
> +	do_div(tmp64, duty100);
> +	*speed =3D (uint32_t)tmp64;
> +
> +	if (*speed > 100)
> +		*speed =3D 100;
> +
> +	return 0;
> +}
> +
> +/**
> +* Get Fan Speed in RPM.
> +* @param    hwmgr  the address of the powerplay hardware manager.
> +* @param    speed is the address of the structure where the result is =
to be placed.
> +* @exception Returns not supported if no fan is found or if pulses per=
 revolution are not set
> +*/
> +int iceland_fan_ctrl_get_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_=
t *speed)
> +{
> +	return 0;
> +}
> +
> +/**
> +* Set Fan Speed Control to static mode, so that the user can decide wh=
at speed to use.
> +* @param    hwmgr  the address of the powerplay hardware manager.
> +*           mode    the fan control mode, 0 default, 1 by percent, 5, =
by RPM
> +* @exception Should always succeed.
> +*/
> +int iceland_fan_ctrl_set_static_mode(struct pp_hwmgr *hwmgr, uint32_t =
mode)
> +{
> +
> +	if (hwmgr->fan_ctrl_is_in_default_mode) {
> +		hwmgr->fan_ctrl_default_mode =3D PHM_READ_VFPF_INDIRECT_FIELD(hwmgr-=
>device, CGS_IND_REG__SMC, CG_FDO_CTRL2, FDO_PWM_MODE);
> +		hwmgr->tmin =3D PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_=
REG__SMC, CG_FDO_CTRL2, TMIN);
> +		hwmgr->fan_ctrl_is_in_default_mode =3D false;
> +	}
> +
> +	PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC, CG_FDO=
_CTRL2, TMIN, 0);
> +	PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC, CG_FDO=
_CTRL2, FDO_PWM_MODE, mode);
> +
> +	return 0;
> +}
> +
> +/**
> +* Reset Fan Speed Control to default mode.
> +* @param    hwmgr  the address of the powerplay hardware manager.
> +* @exception Should always succeed.
> +*/
> +static int iceland_fan_ctrl_set_default_mode(struct pp_hwmgr *hwmgr)
> +{
> +	if (!hwmgr->fan_ctrl_is_in_default_mode) {
> +		PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC, CG_FD=
O_CTRL2, FDO_PWM_MODE, hwmgr->fan_ctrl_default_mode);
> +		PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC, CG_FD=
O_CTRL2, TMIN, hwmgr->tmin);
> +		hwmgr->fan_ctrl_is_in_default_mode =3D true;
> +	}
> +
> +	return 0;
> +}
> +
> +int iceland_fan_ctrl_start_smc_fan_control(struct pp_hwmgr *hwmgr)
> +{
> +	return (smum_send_msg_to_smc(hwmgr->smumgr, PPSMC_StartFanControl) =3D=
=3D 0) ?  0 : -EINVAL;
> +}
> +
> +
> +int iceland_fan_ctrl_stop_smc_fan_control(struct pp_hwmgr *hwmgr)
> +{
> +	return (smum_send_msg_to_smc(hwmgr->smumgr, PPSMC_StopFanControl) =3D=
=3D 0) ?  0 : -EINVAL;
> +}
> +
> +/**
> +* Set Fan Speed in percent.
> +* @param    hwmgr  the address of the powerplay hardware manager.
> +* @param    speed is the percentage value (0% - 100%) to be set.
> +* @exception Fails is the 100% setting appears to be 0.
> +*/
> +int iceland_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr, uin=
t32_t speed)
> +{
> +	uint32_t duty100;
> +	uint32_t duty;
> +	uint64_t tmp64;
> +
> +	if (hwmgr->thermal_controller.fanInfo.bNoFan)
> +		return -EINVAL;
> +
> +	if (speed > 100) {
> +		pr_warning("Cannot set more than 100%% duty cycle. Set it to 100.\n"=
);
> +		speed =3D 100;
> +	}
> +
> +	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_Plat=
formCaps_MicrocodeFanControl))
> +		iceland_fan_ctrl_stop_smc_fan_control(hwmgr);
> +
> +	duty100 =3D PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__=
SMC, CG_FDO_CTRL1, FMAX_DUTY100);
> +
> +	if (0 =3D=3D duty100)
> +		return -EINVAL;
> +
> +	tmp64 =3D (uint64_t)speed * duty100;
> +	do_div(tmp64, 100);
> +	duty =3D (uint32_t)tmp64;
> +
> +	PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC, CG_FDO=
_CTRL0, FDO_STATIC_DUTY, duty);
> +
> +	return iceland_fan_ctrl_set_static_mode(hwmgr, FDO_PWM_MODE_STATIC);
> +}
> +
> +/**
> +* Reset Fan Speed to default.
> +* @param    hwmgr  the address of the powerplay hardware manager.
> +* @exception Always succeeds.
> +*/
> +int iceland_fan_ctrl_reset_fan_speed_to_default(struct pp_hwmgr *hwmgr=
)
> +{
> +	int result;
> +
> +	if (hwmgr->thermal_controller.fanInfo.bNoFan)
> +		return 0;
> +
> +	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_Plat=
formCaps_MicrocodeFanControl)) {
> +		result =3D iceland_fan_ctrl_set_static_mode(hwmgr, FDO_PWM_MODE_STAT=
IC);
> +		if (0 =3D=3D result)
> +			result =3D iceland_fan_ctrl_start_smc_fan_control(hwmgr);
> +	} else
> +		result =3D iceland_fan_ctrl_set_default_mode(hwmgr);
> +
> +	return result;
> +}
> +
> +/**
> +* Set Fan Speed in RPM.
> +* @param    hwmgr  the address of the powerplay hardware manager.
> +* @param    speed is the percentage value (min - max) to be set.
> +* @exception Fails is the speed not lie between min and max.
> +*/
> +int iceland_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_=
t speed)
> +{
> +	return 0;
> +}
> +
> +/**
> +* Reads the remote temperature from the SIslands thermal controller.
> +*
> +* @param    hwmgr The address of the hardware manager.
> +*/
> +int iceland_thermal_get_temperature(struct pp_hwmgr *hwmgr)
> +{
> +	int temp;
> +
> +	temp =3D PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC=
, CG_MULT_THERMAL_STATUS, CTF_TEMP);
> +
> +	/*
> +	 * Bit 9 means the reading is lower than the lowest usable
> +	 * value.
> +	 */
> +	if (0 !=3D (0x200 & temp))
> +		temp =3D ICELAND_THERMAL_MAXIMUM_TEMP_READING;
> +	else
> +		temp =3D (temp & 0x1ff);
> +
> +	temp =3D temp * PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
> +
> +	return temp;
> +}
> +
> +/**
> +* Set the requested temperature range for high and low alert signals
> +*
> +* @param    hwmgr The address of the hardware manager.
> +* @param    range Temperature range to be programmed for high and low =
alert signals
> +* @exception PP_Result_BadInput if the input data is not valid.
> +*/
> +static int iceland_thermal_set_temperature_range(struct pp_hwmgr *hwmg=
r, uint32_t low_temp, uint32_t high_temp)
> +{
> +	uint32_t low =3D ICELAND_THERMAL_MINIMUM_ALERT_TEMP * PP_TEMPERATURE_=
UNITS_PER_CENTIGRADES;
> +	uint32_t high =3D ICELAND_THERMAL_MAXIMUM_ALERT_TEMP * PP_TEMPERATURE=
_UNITS_PER_CENTIGRADES;
> +
> +	if (low < low_temp)
> +		low =3D low_temp;
> +	if (high > high_temp)
> +		high =3D high_temp;
> +
> +	if (low > high)
> +		return -EINVAL;
> +
> +	PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC, CG_THE=
RMAL_INT, DIG_THERM_INTH, (high / PP_TEMPERATURE_UNITS_PER_CENTIGRADES));=

> +	PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC, CG_THE=
RMAL_INT, DIG_THERM_INTL, (low / PP_TEMPERATURE_UNITS_PER_CENTIGRADES));
> +	PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC, CG_THE=
RMAL_CTRL, DIG_THERM_DPM, (high / PP_TEMPERATURE_UNITS_PER_CENTIGRADES));=

> +
> +	return 0;
> +}
> +
> +/**
> +* Programs thermal controller one-time setting registers
> +*
> +* @param    hwmgr The address of the hardware manager.
> +*/
> +static int iceland_thermal_initialize(struct pp_hwmgr *hwmgr)
> +{
> +	if (0 !=3D hwmgr->thermal_controller.fanInfo.ucTachometerPulsesPerRev=
olution)
> +		PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC,
> +						CG_TACH_CTRL, EDGE_PER_REV,
> +						hwmgr->thermal_controller.fanInfo.ucTachometerPulsesPerRevolutio=
n - 1);
> +
> +	PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC, CG_FDO=
_CTRL2, TACH_PWM_RESP_RATE, 0x28);
> +
> +	return 0;
> +}
> +
> +/**
> +* Enable thermal alerts on the RV770 thermal controller.
> +*
> +* @param    hwmgr The address of the hardware manager.
> +*/
> +static int iceland_thermal_enable_alert(struct pp_hwmgr *hwmgr)
> +{
> +	uint32_t alert;
> +
> +	alert =3D PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SM=
C, CG_THERMAL_INT, THERM_INT_MASK);
> +	alert &=3D ~(ICELAND_THERMAL_HIGH_ALERT_MASK | ICELAND_THERMAL_LOW_AL=
ERT_MASK);
> +	PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC, CG_THE=
RMAL_INT, THERM_INT_MASK, alert);
> +
> +	/* send message to SMU to enable internal thermal interrupts */
> +	return (smum_send_msg_to_smc(hwmgr->smumgr, PPSMC_MSG_Thermal_Cntl_En=
able) =3D=3D 0) ? 0 : -1;
> +}
> +
> +/**
> +* Disable thermal alerts on the RV770 thermal controller.
> +* @param    hwmgr The address of the hardware manager.
> +*/
> +static int iceland_thermal_disable_alert(struct pp_hwmgr *hwmgr)
> +{
> +	uint32_t alert;
> +
> +	alert =3D PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SM=
C, CG_THERMAL_INT, THERM_INT_MASK);
> +	alert |=3D (ICELAND_THERMAL_HIGH_ALERT_MASK | ICELAND_THERMAL_LOW_ALE=
RT_MASK);
> +	PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC, CG_THE=
RMAL_INT, THERM_INT_MASK, alert);
> +
> +	/* send message to SMU to disable internal thermal interrupts */
> +	return (smum_send_msg_to_smc(hwmgr->smumgr, PPSMC_MSG_Thermal_Cntl_Di=
sable) =3D=3D 0) ? 0 : -1;
> +}
> +
> +/**
> +* Uninitialize the thermal controller.
> +* Currently just disables alerts.
> +* @param    hwmgr The address of the hardware manager.
> +*/
> +int iceland_thermal_stop_thermal_controller(struct pp_hwmgr *hwmgr)
> +{
> +	int result =3D iceland_thermal_disable_alert(hwmgr);
> +
> +	if (result)
> +		pr_warning("Failed to disable thermal alerts!\n");
> +
> +	if (hwmgr->thermal_controller.fanInfo.bNoFan)
> +		iceland_fan_ctrl_set_default_mode(hwmgr);
> +
> +	return result;
> +}
> +
> +/**
> +* Set up the fan table to control the fan using the SMC.
> +* @param    hwmgr  the address of the powerplay hardware manager.
> +* @param    pInput the pointer to input data
> +* @param    pOutput the pointer to output data
> +* @param    pStorage the pointer to temporary storage
> +* @param    Result the last failure code
> +* @return   result from set temperature range routine
> +*/
> +int tf_iceland_thermal_setup_fan_table(struct pp_hwmgr *hwmgr, void *i=
nput, void *output, void *storage, int result)
> +{
> +	struct iceland_hwmgr *data =3D (struct iceland_hwmgr *)(hwmgr->backen=
d);
> +	SMU71_Discrete_FanTable fan_table =3D { FDO_MODE_HARDWARE };
> +	uint32_t duty100;
> +	uint32_t t_diff1, t_diff2, pwm_diff1, pwm_diff2;
> +	uint16_t fdo_min, slope1, slope2;
> +	uint32_t reference_clock;
> +	int res;
> +	uint64_t tmp64;
> +
> +	if (!phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_Pla=
tformCaps_MicrocodeFanControl))
> +		return 0;
> +
> +	if (0 =3D=3D data->fan_table_start) {
> +		phm_cap_unset(hwmgr->platform_descriptor.platformCaps, PHM_PlatformC=
aps_MicrocodeFanControl);
> +		return 0;
> +	}
> +
> +	duty100 =3D PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__=
SMC, CG_FDO_CTRL1, FMAX_DUTY100);
> +
> +	if (0 =3D=3D duty100) {
> +		phm_cap_unset(hwmgr->platform_descriptor.platformCaps, PHM_PlatformC=
aps_MicrocodeFanControl);
> +		return 0;
> +	}
> +
> +	tmp64 =3D hwmgr->thermal_controller.advanceFanControlParameters.usPWM=
Min * duty100;
> +	do_div(tmp64, 10000);
> +	fdo_min =3D (uint16_t)tmp64;
> +
> +	t_diff1 =3D hwmgr->thermal_controller.advanceFanControlParameters.usT=
Med - hwmgr->thermal_controller.advanceFanControlParameters.usTMin;
> +	t_diff2 =3D hwmgr->thermal_controller.advanceFanControlParameters.usT=
High - hwmgr->thermal_controller.advanceFanControlParameters.usTMed;
> +
> +	pwm_diff1 =3D hwmgr->thermal_controller.advanceFanControlParameters.u=
sPWMMed - hwmgr->thermal_controller.advanceFanControlParameters.usPWMMin;=

> +	pwm_diff2 =3D hwmgr->thermal_controller.advanceFanControlParameters.u=
sPWMHigh - hwmgr->thermal_controller.advanceFanControlParameters.usPWMMed=
;
> +
> +	slope1 =3D (uint16_t)((50 + ((16 * duty100 * pwm_diff1) / t_diff1)) /=
 100);
> +	slope2 =3D (uint16_t)((50 + ((16 * duty100 * pwm_diff2) / t_diff2)) /=
 100);
> +
> +	fan_table.TempMin =3D cpu_to_be16((50 + hwmgr->thermal_controller.adv=
anceFanControlParameters.usTMin) / 100);
> +	fan_table.TempMed =3D cpu_to_be16((50 + hwmgr->thermal_controller.adv=
anceFanControlParameters.usTMed) / 100);
> +	fan_table.TempMax =3D cpu_to_be16((50 + hwmgr->thermal_controller.adv=
anceFanControlParameters.usTMax) / 100);
> +
> +	fan_table.Slope1 =3D cpu_to_be16(slope1);
> +	fan_table.Slope2 =3D cpu_to_be16(slope2);
> +
> +	fan_table.FdoMin =3D cpu_to_be16(fdo_min);
> +
> +	fan_table.HystDown =3D cpu_to_be16(hwmgr->thermal_controller.advanceF=
anControlParameters.ucTHyst);
> +
> +	fan_table.HystUp =3D cpu_to_be16(1);
> +
> +	fan_table.HystSlope =3D cpu_to_be16(1);
> +
> +	fan_table.TempRespLim =3D cpu_to_be16(5);
> +
> +	reference_clock =3D iceland_get_xclk(hwmgr);
> +
> +	fan_table.RefreshPeriod =3D cpu_to_be32((hwmgr->thermal_controller.ad=
vanceFanControlParameters.ulCycleDelay * reference_clock) / 1600);
> +
> +	fan_table.FdoMax =3D cpu_to_be16((uint16_t)duty100);
> +
> +	fan_table.TempSrc =3D (uint8_t)PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->de=
vice, CGS_IND_REG__SMC, CG_MULT_THERMAL_CTRL, TEMP_SEL);
> +
> +	//fan_table.FanControl_GL_Flag =3D 1;
> +
> +	res =3D iceland_copy_bytes_to_smc(hwmgr->smumgr, data->fan_table_star=
t, (uint8_t *)&fan_table, (uint32_t)sizeof(fan_table), data->sram_end);
> +/* TO DO FOR SOME DEVICE ID 0X692b, send this msg return invalid comma=
nd.
> +	if (res =3D=3D 0 && hwmgr->thermal_controller.advanceFanControlParame=
ters.ucMinimumPWMLimit !=3D 0)
> +		res =3D (0 =3D=3D smum_send_msg_to_smc_with_parameter(hwmgr->smumgr,=
 PPSMC_MSG_SetFanMinPwm, \
> +						hwmgr->thermal_controller.advanceFanControlParameters.ucMinimumP=
WMLimit) ? 0 : -1);
> +
> +	if (res =3D=3D 0 && hwmgr->thermal_controller.advanceFanControlParame=
ters.ulMinFanSCLKAcousticLimit !=3D 0)
> +		res =3D (0 =3D=3D smum_send_msg_to_smc_with_parameter(hwmgr->smumgr,=
 PPSMC_MSG_SetFanSclkTarget, \
> +					hwmgr->thermal_controller.advanceFanControlParameters.ulMinFanSCL=
KAcousticLimit) ? 0 : -1);
> +
> +	if (0 !=3D res)
> +		phm_cap_unset(hwmgr->platform_descriptor.platformCaps, PHM_PlatformC=
aps_MicrocodeFanControl);
> +*/
> +	return 0;
> +}
> +
> +/**
> +* Start the fan control on the SMC.
> +* @param    hwmgr  the address of the powerplay hardware manager.
> +* @param    pInput the pointer to input data
> +* @param    pOutput the pointer to output data
> +* @param    pStorage the pointer to temporary storage
> +* @param    Result the last failure code
> +* @return   result from set temperature range routine
> +*/
> +int tf_iceland_thermal_start_smc_fan_control(struct pp_hwmgr *hwmgr, v=
oid *input, void *output, void *storage, int result)
> +{
> +/* If the fantable setup has failed we could have disabled PHM_Platfor=
mCaps_MicrocodeFanControl even after this function was included in the ta=
ble.
> + * Make sure that we still think controlling the fan is OK.
> +*/
> +	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_Plat=
formCaps_MicrocodeFanControl)) {
> +		iceland_fan_ctrl_start_smc_fan_control(hwmgr);
> +		iceland_fan_ctrl_set_static_mode(hwmgr, FDO_PWM_MODE_STATIC);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> +* Set temperature range for high and low alerts
> +* @param    hwmgr  the address of the powerplay hardware manager.
> +* @param    pInput the pointer to input data
> +* @param    pOutput the pointer to output data
> +* @param    pStorage the pointer to temporary storage
> +* @param    Result the last failure code
> +* @return   result from set temperature range routine
> +*/
> +static int tf_iceland_thermal_set_temperature_range(struct pp_hwmgr *h=
wmgr,
> +		void *input, void *output, void *storage, int result)
> +{
> +	struct PP_TemperatureRange *range =3D (struct PP_TemperatureRange *)i=
nput;
> +
> +	if (range =3D=3D NULL)
> +		return -EINVAL;
> +
> +	return iceland_thermal_set_temperature_range(hwmgr, range->min, range=
->max);
> +}
> +
> +/**
> +* Programs one-time setting registers
> +* @param    hwmgr  the address of the powerplay hardware manager.
> +* @param    pInput the pointer to input data
> +* @param    pOutput the pointer to output data
> +* @param    pStorage the pointer to temporary storage
> +* @param    Result the last failure code
> +* @return   result from initialize thermal controller routine
> +*/
> +static int tf_iceland_thermal_initialize(struct pp_hwmgr *hwmgr, void =
*input,
> +				void *output, void *storage, int result)
> +{
> +    return iceland_thermal_initialize(hwmgr);
> +}
> +
> +/**
> +* Enable high and low alerts
> +* @param    hwmgr  the address of the powerplay hardware manager.
> +* @param    pInput the pointer to input data
> +* @param    pOutput the pointer to output data
> +* @param    pStorage the pointer to temporary storage
> +* @param    Result the last failure code
> +* @return   result from enable alert routine
> +*/
> +static int tf_iceland_thermal_enable_alert(struct pp_hwmgr *hwmgr,
> +		void *input, void *output, void *storage, int result)
> +{
> +	return iceland_thermal_enable_alert(hwmgr);
> +}
> +
> +/**
> +* Disable high and low alerts
> +* @param    hwmgr  the address of the powerplay hardware manager.
> +* @param    pInput the pointer to input data
> +* @param    pOutput the pointer to output data
> +* @param    pStorage the pointer to temporary storage
> +* @param    Result the last failure code
> +* @return   result from disable alert routine
> +*/
> +static int tf_iceland_thermal_disable_alert(struct pp_hwmgr *hwmgr, vo=
id *input, void *output, void *storage, int result)
> +{
> +	return iceland_thermal_disable_alert(hwmgr);
> +}
> +
> +static const struct phm_master_table_item iceland_thermal_start_therma=
l_controller_master_list[] =3D {
> +	{ NULL, tf_iceland_thermal_initialize },
> +	{ NULL, tf_iceland_thermal_set_temperature_range },
> +	{ NULL, tf_iceland_thermal_enable_alert },
> +	/*
> +	 * We should restrict performance levels to low before we halt
> +	 * the SMC.  On the other hand we are still in boot state when
> +	 * we do this so it would be pointless.  If this assumption
> +	 * changes we have to revisit this table.
> +	 */
> +	{ NULL, tf_iceland_thermal_setup_fan_table},
> +	{ NULL, tf_iceland_thermal_start_smc_fan_control},
> +	{ NULL, NULL }
> +};
> +
> +static const struct phm_master_table_header iceland_thermal_start_ther=
mal_controller_master =3D {
> +	0,
> +	PHM_MasterTableFlag_None,
> +	iceland_thermal_start_thermal_controller_master_list
> +};
> +
> +static const struct phm_master_table_item iceland_thermal_set_temperat=
ure_range_master_list[] =3D {
> +	{ NULL, tf_iceland_thermal_disable_alert},
> +	{ NULL, tf_iceland_thermal_set_temperature_range},
> +	{ NULL, tf_iceland_thermal_enable_alert},
> +	{ NULL, NULL }
> +};
> +
> +static const struct phm_master_table_header iceland_thermal_set_temper=
ature_range_master =3D {
> +	0,
> +	PHM_MasterTableFlag_None,
> +	iceland_thermal_set_temperature_range_master_list
> +};
> +
> +int iceland_thermal_ctrl_uninitialize_thermal_controller(struct pp_hwm=
gr *hwmgr)
> +{
> +	if (!hwmgr->thermal_controller.fanInfo.bNoFan)
> +		iceland_fan_ctrl_set_default_mode(hwmgr);
> +	return 0;
> +}
> +
> +/**
> +* Initializes the thermal controller related functions in the Hardware=
 Manager structure.
> +* @param    hwmgr The address of the hardware manager.
> +* @exception Any error code from the low-level communication.
> +*/
> +int pp_iceland_thermal_initialize(struct pp_hwmgr *hwmgr)
> +{
> +	int result;
> +
> +	result =3D phm_construct_table(hwmgr, &iceland_thermal_set_temperatur=
e_range_master, &(hwmgr->set_temperature_range));
> +
> +	if (0 =3D=3D result) {
> +		result =3D phm_construct_table(hwmgr,
> +						&iceland_thermal_start_thermal_controller_master,
> +						&(hwmgr->start_thermal_controller));
> +		if (0 !=3D result)
> +			phm_destroy_table(hwmgr, &(hwmgr->set_temperature_range));
> +	}
> +
> +	if (0 =3D=3D result)
> +		hwmgr->fan_ctrl_is_in_default_mode =3D true;
> +	return result;
> +}
> +
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/iceland_thermal.h b/dr=
ivers/gpu/drm/amd/powerplay/hwmgr/iceland_thermal.h
> new file mode 100644
> index 0000000..267945f
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/iceland_thermal.h
> @@ -0,0 +1,58 @@
> +/*
> + * Copyright 2016 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> + * copy of this software and associated documentation files (the "Soft=
ware"),
> + * to deal in the Software without restriction, including without limi=
tation
> + * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> + * and/or sell copies of the Software, and to permit persons to whom t=
he
> + * Software is furnished to do so, subject to the following conditions=
:
> + *
> + * The above copyright notice and this permission notice shall be incl=
uded in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Author: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> + *
> + */
> +
> +#ifndef ICELAND_THERMAL_H
> +#define ICELAND_THERMAL_H
> +
> +#include "hwmgr.h"
> +
> +#define ICELAND_THERMAL_HIGH_ALERT_MASK         0x1
> +#define ICELAND_THERMAL_LOW_ALERT_MASK          0x2
> +
> +#define ICELAND_THERMAL_MINIMUM_TEMP_READING    -256
> +#define ICELAND_THERMAL_MAXIMUM_TEMP_READING    255
> +
> +#define ICELAND_THERMAL_MINIMUM_ALERT_TEMP      0
> +#define ICELAND_THERMAL_MAXIMUM_ALERT_TEMP      255
> +
> +#define FDO_PWM_MODE_STATIC  1
> +#define FDO_PWM_MODE_STATIC_RPM 5
> +
> +
> +extern int iceland_thermal_get_temperature(struct pp_hwmgr *hwmgr);
> +extern int iceland_thermal_stop_thermal_controller(struct pp_hwmgr *hw=
mgr);
> +extern int iceland_fan_ctrl_get_fan_speed_info(struct pp_hwmgr *hwmgr,=
 struct phm_fan_speed_info *fan_speed_info);
> +extern int iceland_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwm=
gr, uint32_t *speed);
> +extern int iceland_fan_ctrl_set_static_mode(struct pp_hwmgr *hwmgr, ui=
nt32_t mode);
> +extern int iceland_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwm=
gr, uint32_t speed);
> +extern int iceland_fan_ctrl_reset_fan_speed_to_default(struct pp_hwmgr=
 *hwmgr);
> +extern int pp_iceland_thermal_initialize(struct pp_hwmgr *hwmgr);
> +extern int iceland_thermal_ctrl_uninitialize_thermal_controller(struct=
 pp_hwmgr *hwmgr);
> +extern int iceland_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr, =
uint32_t speed);
> +extern int iceland_fan_ctrl_get_fan_speed_rpm(struct pp_hwmgr *hwmgr, =
uint32_t *speed);
> +extern int iceland_fan_ctrl_stop_smc_fan_control(struct pp_hwmgr *hwmg=
r);
> +
> +#endif
> +
>=20


--A2xm9eShc15jN6SxxOCHu6cwuCeTeBmRu--

--hrBPn7gJpuRkcbtK4W5t8s0nSrukVos7b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXv7H/AAoJEP4bvbfZuWjbIfsP/1BYpDRDfFIjRHDhAjlSjK0K
2DtnwzCELN4vtg9SEy5s73/RJ22r+Bs1az2NFFUKyenaO2rqUtOE2BSpl66RV+tu
UlB9ct4poRJgjGll60BpUw0dOKxo7vhRivafZZCymX/rcB15PJXPk0c4InCeOVmb
q3kqBgbbntZBDyHfc5hd/lgCj8wWprLcVgu2pDaEkIpu9v2122Ljix+JQzltE5U5
uAH6PtWU9s/TXzbfYa4Gp87Yu6NM7XAgFW617D4gr1ODQ1wABDrF8Unq3veATfQr
CP1CBZmwU/3glPPf/u4hMi7ukR9Cqn8TJHGyJhxLJC4oQFxDumXMFD9F09UF4qJO
IvRSNO4ggc3Bw/TXD76hk+dCaqcLhSu/ZyU0r6Qk90T9+L8MVH7x124869NEswFW
sXKA/6BTa4EAgB5lNG6pPoNmneca9gXE7gkDPBQ7YDDTGkil8cnN8yOwfXaYT2Q8
qU1cCPJy1ZApIvGQo/jASec04vi2ryK1YiE3fylQv/C0sYsnDigs0WX/dGLHEZV8
3m4wtWebgZ7pVK9KyWemGXqgVFYLvsFMDOQDa1NTHw3ETEdjQnAvV+u5t4LCoSvM
9OxbCL7SXOQ/AmiIwVqKNtQtoY2IK42A+wravkXNSF7rfTlpOEIOmneV47OrOY2+
d+CNNSBtNCXznDwY3DIJ
=iZJk
-----END PGP SIGNATURE-----

--hrBPn7gJpuRkcbtK4W5t8s0nSrukVos7b--


--===============2067580855==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2067580855==--
