From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: use powerplay module for dgpu of VI.
Date: Mon, 19 Sep 2016 22:32:30 +1000
Message-ID: <2e7ec10a-a455-ad68-288f-20bfe7eff664@folklore1984.net>
References: <1474287433-16705-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2099142407=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1474287433-16705-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2099142407==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1BN31V6g3FaLtRRHMvn5de8Vxskak7xfC"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1BN31V6g3FaLtRRHMvn5de8Vxskak7xfC
Content-Type: multipart/mixed; boundary="LFRMbx76ghWx0vT2sKQETFRcvrbA3sNOh";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <2e7ec10a-a455-ad68-288f-20bfe7eff664-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: use powerplay module for dgpu of VI.
References: <1474287433-16705-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1474287433-16705-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

--LFRMbx76ghWx0vT2sKQETFRcvrbA3sNOh
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

So now just pure PP paths for Tonga, Fiji & Topaz. Is there any perf or
power usage difference from this change-set across any of these ASIC's?

Acked-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 09/19/2016 10:17 PM, Rex Zhu wrote:
> delete vi dpm related code and files.
>=20
> Change-Id: I080de47df12d45be06a72fe229695675cf6648d6
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile           |   5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.c |  13 +-
>  drivers/gpu/drm/amd/amdgpu/fiji_dpm.c         | 186 ------
>  drivers/gpu/drm/amd/amdgpu/fiji_smc.c         | 863 ------------------=
--------
>  drivers/gpu/drm/amd/amdgpu/fiji_smum.h        |  42 --
>  drivers/gpu/drm/amd/amdgpu/iceland_dpm.c      | 200 ------
>  drivers/gpu/drm/amd/amdgpu/iceland_smc.c      | 677 ------------------=
--
>  drivers/gpu/drm/amd/amdgpu/iceland_smum.h     |  41 --
>  drivers/gpu/drm/amd/amdgpu/tonga_dpm.c        | 186 ------
>  drivers/gpu/drm/amd/amdgpu/tonga_smc.c        | 862 ------------------=
-------
>  drivers/gpu/drm/amd/amdgpu/tonga_smum.h       |  42 --
>  drivers/gpu/drm/amd/amdgpu/vi.c               |   3 +
>  12 files changed, 6 insertions(+), 3114 deletions(-)
>  delete mode 100644 drivers/gpu/drm/amd/amdgpu/fiji_dpm.c
>  delete mode 100644 drivers/gpu/drm/amd/amdgpu/fiji_smc.c
>  delete mode 100644 drivers/gpu/drm/amd/amdgpu/fiji_smum.h
>  delete mode 100644 drivers/gpu/drm/amd/amdgpu/iceland_dpm.c
>  delete mode 100644 drivers/gpu/drm/amd/amdgpu/iceland_smc.c
>  delete mode 100644 drivers/gpu/drm/amd/amdgpu/iceland_smum.h
>  delete mode 100644 drivers/gpu/drm/amd/amdgpu/tonga_dpm.c
>  delete mode 100644 drivers/gpu/drm/amd/amdgpu/tonga_smc.c
>  delete mode 100644 drivers/gpu/drm/amd/amdgpu/tonga_smum.h
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/=
amdgpu/Makefile
> index f2b97cb..786b28a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -59,10 +59,7 @@ amdgpu-y +=3D \
>  amdgpu-y +=3D \
>  	amdgpu_dpm.o \
>  	amdgpu_powerplay.o \
> -	cz_smc.o cz_dpm.o \
> -	tonga_smc.o tonga_dpm.o \
> -	fiji_smc.o fiji_dpm.o \
> -	iceland_smc.o iceland_dpm.o
> +	cz_smc.o cz_dpm.o
> =20
>  # add DCE block
>  amdgpu-y +=3D \
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_powerplay.c
> index 1e7f160..68ad241 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.c
> @@ -80,15 +80,6 @@ static int amdgpu_powerplay_init(struct amdgpu_devic=
e *adev)
>  			amd_pp->ip_funcs =3D &kv_dpm_ip_funcs;
>  			break;
>  #endif
> -		case CHIP_TOPAZ:
> -			amd_pp->ip_funcs =3D &iceland_dpm_ip_funcs;
> -			break;
> -		case CHIP_TONGA:
> -			amd_pp->ip_funcs =3D &tonga_dpm_ip_funcs;
> -			break;
> -		case CHIP_FIJI:
> -			amd_pp->ip_funcs =3D &fiji_dpm_ip_funcs;
> -			break;
>  		case CHIP_CARRIZO:
>  		case CHIP_STONEY:
>  			amd_pp->ip_funcs =3D &cz_dpm_ip_funcs;
> @@ -110,11 +101,11 @@ static int amdgpu_pp_early_init(void *handle)
>  	switch (adev->asic_type) {
>  	case CHIP_POLARIS11:
>  	case CHIP_POLARIS10:
> -		adev->pp_enabled =3D true;
> -		break;
>  	case CHIP_TONGA:
>  	case CHIP_FIJI:
>  	case CHIP_TOPAZ:
> +		adev->pp_enabled =3D true;
> +		break;
>  	case CHIP_CARRIZO:
>  	case CHIP_STONEY:
>  		adev->pp_enabled =3D (amdgpu_powerplay =3D=3D 0) ? false : true;
> diff --git a/drivers/gpu/drm/amd/amdgpu/fiji_dpm.c b/drivers/gpu/drm/am=
d/amdgpu/fiji_dpm.c
> deleted file mode 100644
> index ed03b75..0000000
> --- a/drivers/gpu/drm/amd/amdgpu/fiji_dpm.c
> +++ /dev/null
> @@ -1,186 +0,0 @@
> -/*
> - * Copyright 2014 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> - * copy of this software and associated documentation files (the "Soft=
ware"),
> - * to deal in the Software without restriction, including without limi=
tation
> - * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> - * and/or sell copies of the Software, and to permit persons to whom t=
he
> - * Software is furnished to do so, subject to the following conditions=
:
> - *
> - * The above copyright notice and this permission notice shall be incl=
uded in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - */
> -
> -#include <linux/firmware.h>
> -#include "drmP.h"
> -#include "amdgpu.h"
> -#include "fiji_smum.h"
> -
> -MODULE_FIRMWARE("amdgpu/fiji_smc.bin");
> -
> -static void fiji_dpm_set_funcs(struct amdgpu_device *adev);
> -
> -static int fiji_dpm_early_init(void *handle)
> -{
> -	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -
> -	fiji_dpm_set_funcs(adev);
> -
> -	return 0;
> -}
> -
> -static int fiji_dpm_init_microcode(struct amdgpu_device *adev)
> -{
> -	char fw_name[30] =3D "amdgpu/fiji_smc.bin";
> -	int err;
> -
> -	err =3D request_firmware(&adev->pm.fw, fw_name, adev->dev);
> -	if (err)
> -		goto out;
> -	err =3D amdgpu_ucode_validate(adev->pm.fw);
> -
> -out:
> -	if (err) {
> -		DRM_ERROR("Failed to load firmware \"%s\"", fw_name);
> -		release_firmware(adev->pm.fw);
> -		adev->pm.fw =3D NULL;
> -	}
> -	return err;
> -}
> -
> -static int fiji_dpm_sw_init(void *handle)
> -{
> -	int ret;
> -	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -
> -	ret =3D fiji_dpm_init_microcode(adev);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> -}
> -
> -static int fiji_dpm_sw_fini(void *handle)
> -{
> -	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -
> -	release_firmware(adev->pm.fw);
> -	adev->pm.fw =3D NULL;
> -
> -	return 0;
> -}
> -
> -static int fiji_dpm_hw_init(void *handle)
> -{
> -	int ret;
> -	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -
> -	mutex_lock(&adev->pm.mutex);
> -
> -	ret =3D fiji_smu_init(adev);
> -	if (ret) {
> -		DRM_ERROR("SMU initialization failed\n");
> -		goto fail;
> -	}
> -
> -	ret =3D fiji_smu_start(adev);
> -	if (ret) {
> -		DRM_ERROR("SMU start failed\n");
> -		goto fail;
> -	}
> -
> -	mutex_unlock(&adev->pm.mutex);
> -	return 0;
> -
> -fail:
> -	adev->firmware.smu_load =3D false;
> -	mutex_unlock(&adev->pm.mutex);
> -	return -EINVAL;
> -}
> -
> -static int fiji_dpm_hw_fini(void *handle)
> -{
> -	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -	mutex_lock(&adev->pm.mutex);
> -	fiji_smu_fini(adev);
> -	mutex_unlock(&adev->pm.mutex);
> -	return 0;
> -}
> -
> -static int fiji_dpm_suspend(void *handle)
> -{
> -	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -
> -	fiji_dpm_hw_fini(adev);
> -
> -	return 0;
> -}
> -
> -static int fiji_dpm_resume(void *handle)
> -{
> -	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -
> -	fiji_dpm_hw_init(adev);
> -
> -	return 0;
> -}
> -
> -static int fiji_dpm_set_clockgating_state(void *handle,
> -			enum amd_clockgating_state state)
> -{
> -	return 0;
> -}
> -
> -static int fiji_dpm_set_powergating_state(void *handle,
> -			enum amd_powergating_state state)
> -{
> -	return 0;
> -}
> -
> -const struct amd_ip_funcs fiji_dpm_ip_funcs =3D {
> -	.name =3D "fiji_dpm",
> -	.early_init =3D fiji_dpm_early_init,
> -	.late_init =3D NULL,
> -	.sw_init =3D fiji_dpm_sw_init,
> -	.sw_fini =3D fiji_dpm_sw_fini,
> -	.hw_init =3D fiji_dpm_hw_init,
> -	.hw_fini =3D fiji_dpm_hw_fini,
> -	.suspend =3D fiji_dpm_suspend,
> -	.resume =3D fiji_dpm_resume,
> -	.is_idle =3D NULL,
> -	.wait_for_idle =3D NULL,
> -	.soft_reset =3D NULL,
> -	.set_clockgating_state =3D fiji_dpm_set_clockgating_state,
> -	.set_powergating_state =3D fiji_dpm_set_powergating_state,
> -};
> -
> -static const struct amdgpu_dpm_funcs fiji_dpm_funcs =3D {
> -	.get_temperature =3D NULL,
> -	.pre_set_power_state =3D NULL,
> -	.set_power_state =3D NULL,
> -	.post_set_power_state =3D NULL,
> -	.display_configuration_changed =3D NULL,
> -	.get_sclk =3D NULL,
> -	.get_mclk =3D NULL,
> -	.print_power_state =3D NULL,
> -	.debugfs_print_current_performance_level =3D NULL,
> -	.force_performance_level =3D NULL,
> -	.vblank_too_short =3D NULL,
> -	.powergate_uvd =3D NULL,
> -};
> -
> -static void fiji_dpm_set_funcs(struct amdgpu_device *adev)
> -{
> -	if (NULL =3D=3D adev->pm.funcs)
> -		adev->pm.funcs =3D &fiji_dpm_funcs;
> -}
> diff --git a/drivers/gpu/drm/amd/amdgpu/fiji_smc.c b/drivers/gpu/drm/am=
d/amdgpu/fiji_smc.c
> deleted file mode 100644
> index 8cfb0a3..0000000
> --- a/drivers/gpu/drm/amd/amdgpu/fiji_smc.c
> +++ /dev/null
> @@ -1,863 +0,0 @@
> -/*
> - * Copyright 2014 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> - * copy of this software and associated documentation files (the "Soft=
ware"),
> - * to deal in the Software without restriction, including without limi=
tation
> - * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> - * and/or sell copies of the Software, and to permit persons to whom t=
he
> - * Software is furnished to do so, subject to the following conditions=
:
> - *
> - * The above copyright notice and this permission notice shall be incl=
uded in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - */
> -
> -#include <linux/firmware.h>
> -#include "drmP.h"
> -#include "amdgpu.h"
> -#include "fiji_ppsmc.h"
> -#include "fiji_smum.h"
> -#include "smu_ucode_xfer_vi.h"
> -#include "amdgpu_ucode.h"
> -
> -#include "smu/smu_7_1_3_d.h"
> -#include "smu/smu_7_1_3_sh_mask.h"
> -
> -#define FIJI_SMC_SIZE 0x20000
> -
> -static int fiji_set_smc_sram_address(struct amdgpu_device *adev, uint3=
2_t smc_address, uint32_t limit)
> -{
> -	uint32_t val;
> -
> -	if (smc_address & 3)
> -		return -EINVAL;
> -
> -	if ((smc_address + 3) > limit)
> -		return -EINVAL;
> -
> -	WREG32(mmSMC_IND_INDEX_0, smc_address);
> -
> -	val =3D RREG32(mmSMC_IND_ACCESS_CNTL);
> -	val =3D REG_SET_FIELD(val, SMC_IND_ACCESS_CNTL, AUTO_INCREMENT_IND_0,=
 0);
> -	WREG32(mmSMC_IND_ACCESS_CNTL, val);
> -
> -	return 0;
> -}
> -
> -static int fiji_copy_bytes_to_smc(struct amdgpu_device *adev, uint32_t=
 smc_start_address, const uint8_t *src, uint32_t byte_count, uint32_t lim=
it)
> -{
> -	uint32_t addr;
> -	uint32_t data, orig_data;
> -	int result =3D 0;
> -	uint32_t extra_shift;
> -	unsigned long flags;
> -
> -	if (smc_start_address & 3)
> -		return -EINVAL;
> -
> -	if ((smc_start_address + byte_count) > limit)
> -		return -EINVAL;
> -
> -	addr =3D smc_start_address;
> -
> -	spin_lock_irqsave(&adev->smc_idx_lock, flags);
> -	while (byte_count >=3D 4) {
> -		/* Bytes are written into the SMC addres space with the MSB first */=

> -		data =3D (src[0] << 24) + (src[1] << 16) + (src[2] << 8) + src[3];
> -
> -		result =3D fiji_set_smc_sram_address(adev, addr, limit);
> -
> -		if (result)
> -			goto out;
> -
> -		WREG32(mmSMC_IND_DATA_0, data);
> -
> -		src +=3D 4;
> -		byte_count -=3D 4;
> -		addr +=3D 4;
> -	}
> -
> -	if (0 !=3D byte_count) {
> -		/* Now write odd bytes left, do a read modify write cycle */
> -		data =3D 0;
> -
> -		result =3D fiji_set_smc_sram_address(adev, addr, limit);
> -		if (result)
> -			goto out;
> -
> -		orig_data =3D RREG32(mmSMC_IND_DATA_0);
> -		extra_shift =3D 8 * (4 - byte_count);
> -
> -		while (byte_count > 0) {
> -			data =3D (data << 8) + *src++;
> -			byte_count--;
> -		}
> -
> -		data <<=3D extra_shift;
> -		data |=3D (orig_data & ~((~0UL) << extra_shift));
> -
> -		result =3D fiji_set_smc_sram_address(adev, addr, limit);
> -		if (result)
> -			goto out;
> -
> -		WREG32(mmSMC_IND_DATA_0, data);
> -	}
> -
> -out:
> -	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
> -	return result;
> -}
> -
> -static int fiji_program_jump_on_start(struct amdgpu_device *adev)
> -{
> -	static unsigned char data[] =3D {0xE0, 0x00, 0x80, 0x40};
> -	fiji_copy_bytes_to_smc(adev, 0x0, data, 4, sizeof(data)+1);
> -
> -	return 0;
> -}
> -
> -static bool fiji_is_smc_ram_running(struct amdgpu_device *adev)
> -{
> -	uint32_t val =3D RREG32_SMC(ixSMC_SYSCON_CLOCK_CNTL_0);
> -	val =3D REG_GET_FIELD(val, SMC_SYSCON_CLOCK_CNTL_0, ck_disable);
> -
> -	return ((0 =3D=3D val) && (0x20100 <=3D RREG32_SMC(ixSMC_PC_C)));
> -}
> -
> -static int wait_smu_response(struct amdgpu_device *adev)
> -{
> -	int i;
> -	uint32_t val;
> -
> -	for (i =3D 0; i < adev->usec_timeout; i++) {
> -		val =3D RREG32(mmSMC_RESP_0);
> -		if (REG_GET_FIELD(val, SMC_RESP_0, SMC_RESP))
> -			break;
> -		udelay(1);
> -	}
> -
> -	if (i =3D=3D adev->usec_timeout)
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
> -static int fiji_send_msg_to_smc_offset(struct amdgpu_device *adev)
> -{
> -	if (wait_smu_response(adev)) {
> -		DRM_ERROR("Failed to send previous message\n");
> -		return -EINVAL;
> -	}
> -
> -	WREG32(mmSMC_MSG_ARG_0, 0x20000);
> -	WREG32(mmSMC_MESSAGE_0, PPSMC_MSG_Test);
> -
> -	if (wait_smu_response(adev)) {
> -		DRM_ERROR("Failed to send message\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -static int fiji_send_msg_to_smc(struct amdgpu_device *adev, PPSMC_Msg =
msg)
> -{
> -	if (!fiji_is_smc_ram_running(adev))
> -	{
> -		return -EINVAL;
> -	}
> -
> -	if (wait_smu_response(adev)) {
> -		DRM_ERROR("Failed to send previous message\n");
> -		return -EINVAL;
> -	}
> -
> -	WREG32(mmSMC_MESSAGE_0, msg);
> -
> -	if (wait_smu_response(adev)) {
> -		DRM_ERROR("Failed to send message\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -static int fiji_send_msg_to_smc_without_waiting(struct amdgpu_device *=
adev,
> -						PPSMC_Msg msg)
> -{
> -	if (wait_smu_response(adev)) {
> -		DRM_ERROR("Failed to send previous message\n");
> -		return -EINVAL;
> -	}
> -
> -	WREG32(mmSMC_MESSAGE_0, msg);
> -
> -	return 0;
> -}
> -
> -static int fiji_send_msg_to_smc_with_parameter(struct amdgpu_device *a=
dev,
> -						PPSMC_Msg msg,
> -						uint32_t parameter)
> -{
> -	if (!fiji_is_smc_ram_running(adev))
> -		return -EINVAL;
> -
> -	if (wait_smu_response(adev)) {
> -		DRM_ERROR("Failed to send previous message\n");
> -		return -EINVAL;
> -	}
> -
> -	WREG32(mmSMC_MSG_ARG_0, parameter);
> -
> -	return fiji_send_msg_to_smc(adev, msg);
> -}
> -
> -static int fiji_send_msg_to_smc_with_parameter_without_waiting(
> -					struct amdgpu_device *adev,
> -					PPSMC_Msg msg, uint32_t parameter)
> -{
> -	if (wait_smu_response(adev)) {
> -		DRM_ERROR("Failed to send previous message\n");
> -		return -EINVAL;
> -	}
> -
> -	WREG32(mmSMC_MSG_ARG_0, parameter);
> -
> -	return fiji_send_msg_to_smc_without_waiting(adev, msg);
> -}
> -
> -#if 0 /* not used yet */
> -static int fiji_wait_for_smc_inactive(struct amdgpu_device *adev)
> -{
> -	int i;
> -	uint32_t val;
> -
> -	if (!fiji_is_smc_ram_running(adev))
> -		return -EINVAL;
> -
> -	for (i =3D 0; i < adev->usec_timeout; i++) {
> -		val =3D RREG32_SMC(ixSMC_SYSCON_CLOCK_CNTL_0);
> -		if (REG_GET_FIELD(val, SMC_SYSCON_CLOCK_CNTL_0, cken) =3D=3D 0)
> -			break;
> -		udelay(1);
> -	}
> -
> -	if (i =3D=3D adev->usec_timeout)
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -#endif
> -
> -static int fiji_smu_upload_firmware_image(struct amdgpu_device *adev)
> -{
> -	const struct smc_firmware_header_v1_0 *hdr;
> -	uint32_t ucode_size;
> -	uint32_t ucode_start_address;
> -	const uint8_t *src;
> -	uint32_t val;
> -	uint32_t byte_count;
> -	uint32_t *data;
> -	unsigned long flags;
> -
> -	if (!adev->pm.fw)
> -		return -EINVAL;
> -
> -	/* Skip SMC ucode loading on SR-IOV capable boards.
> -	 * vbios does this for us in asic_init in that case.
> -	 */
> -	if (amdgpu_sriov_bios(adev))
> -		return 0;
> -
> -	hdr =3D (const struct smc_firmware_header_v1_0 *)adev->pm.fw->data;
> -	amdgpu_ucode_print_smc_hdr(&hdr->header);
> -
> -	adev->pm.fw_version =3D le32_to_cpu(hdr->header.ucode_version);
> -	ucode_size =3D le32_to_cpu(hdr->header.ucode_size_bytes);
> -	ucode_start_address =3D le32_to_cpu(hdr->ucode_start_addr);
> -	src =3D (const uint8_t *)
> -		(adev->pm.fw->data + le32_to_cpu(hdr->header.ucode_array_offset_byte=
s));
> -
> -	if (ucode_size & 3) {
> -		DRM_ERROR("SMC ucode is not 4 bytes aligned\n");
> -		return -EINVAL;
> -	}
> -
> -	if (ucode_size > FIJI_SMC_SIZE) {
> -		DRM_ERROR("SMC address is beyond the SMC RAM area\n");
> -		return -EINVAL;
> -	}
> -
> -	spin_lock_irqsave(&adev->smc_idx_lock, flags);
> -	WREG32(mmSMC_IND_INDEX_0, ucode_start_address);
> -
> -	val =3D RREG32(mmSMC_IND_ACCESS_CNTL);
> -	val =3D REG_SET_FIELD(val, SMC_IND_ACCESS_CNTL, AUTO_INCREMENT_IND_0,=
 1);
> -	WREG32(mmSMC_IND_ACCESS_CNTL, val);
> -
> -	byte_count =3D ucode_size;
> -	data =3D (uint32_t *)src;
> -	for (; byte_count >=3D 4; data++, byte_count -=3D 4)
> -		WREG32(mmSMC_IND_DATA_0, data[0]);
> -
> -	val =3D RREG32(mmSMC_IND_ACCESS_CNTL);
> -	val =3D REG_SET_FIELD(val, SMC_IND_ACCESS_CNTL, AUTO_INCREMENT_IND_0,=
 0);
> -	WREG32(mmSMC_IND_ACCESS_CNTL, val);
> -	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
> -
> -	return 0;
> -}
> -
> -#if 0 /* not used yet */
> -static int fiji_read_smc_sram_dword(struct amdgpu_device *adev,
> -				uint32_t smc_address,
> -				uint32_t *value,
> -				uint32_t limit)
> -{
> -	int result;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&adev->smc_idx_lock, flags);
> -	result =3D fiji_set_smc_sram_address(adev, smc_address, limit);
> -	if (result =3D=3D 0)
> -		*value =3D RREG32(mmSMC_IND_DATA_0);
> -	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
> -	return result;
> -}
> -
> -static int fiji_write_smc_sram_dword(struct amdgpu_device *adev,
> -				uint32_t smc_address,
> -				uint32_t value,
> -				uint32_t limit)
> -{
> -	int result;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&adev->smc_idx_lock, flags);
> -	result =3D fiji_set_smc_sram_address(adev, smc_address, limit);
> -	if (result =3D=3D 0)
> -		WREG32(mmSMC_IND_DATA_0, value);
> -	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
> -	return result;
> -}
> -
> -static int fiji_smu_stop_smc(struct amdgpu_device *adev)
> -{
> -	uint32_t val =3D RREG32_SMC(ixSMC_SYSCON_RESET_CNTL);
> -	val =3D REG_SET_FIELD(val, SMC_SYSCON_RESET_CNTL, rst_reg, 1);
> -	WREG32_SMC(ixSMC_SYSCON_RESET_CNTL, val);
> -
> -	val =3D RREG32_SMC(ixSMC_SYSCON_CLOCK_CNTL_0);
> -	val =3D REG_SET_FIELD(val, SMC_SYSCON_CLOCK_CNTL_0, ck_disable, 1);
> -	WREG32_SMC(ixSMC_SYSCON_CLOCK_CNTL_0, val);
> -
> -	return 0;
> -}
> -#endif
> -
> -static enum AMDGPU_UCODE_ID fiji_convert_fw_type(uint32_t fw_type)
> -{
> -	switch (fw_type) {
> -		case UCODE_ID_SDMA0:
> -			return AMDGPU_UCODE_ID_SDMA0;
> -		case UCODE_ID_SDMA1:
> -			return AMDGPU_UCODE_ID_SDMA1;
> -		case UCODE_ID_CP_CE:
> -			return AMDGPU_UCODE_ID_CP_CE;
> -		case UCODE_ID_CP_PFP:
> -			return AMDGPU_UCODE_ID_CP_PFP;
> -		case UCODE_ID_CP_ME:
> -			return AMDGPU_UCODE_ID_CP_ME;
> -		case UCODE_ID_CP_MEC:
> -		case UCODE_ID_CP_MEC_JT1:
> -		case UCODE_ID_CP_MEC_JT2:
> -			return AMDGPU_UCODE_ID_CP_MEC1;
> -		case UCODE_ID_RLC_G:
> -			return AMDGPU_UCODE_ID_RLC_G;
> -		default:
> -			DRM_ERROR("ucode type is out of range!\n");
> -			return AMDGPU_UCODE_ID_MAXIMUM;
> -	}
> -}
> -
> -static int fiji_smu_populate_single_firmware_entry(struct amdgpu_devic=
e *adev,
> -						uint32_t fw_type,
> -						struct SMU_Entry *entry)
> -{
> -	enum AMDGPU_UCODE_ID id =3D fiji_convert_fw_type(fw_type);
> -	struct amdgpu_firmware_info *ucode =3D &adev->firmware.ucode[id];
> -	const struct gfx_firmware_header_v1_0 *header =3D NULL;
> -	uint64_t gpu_addr;
> -	uint32_t data_size;
> -
> -	if (ucode->fw =3D=3D NULL)
> -		return -EINVAL;
> -	gpu_addr  =3D ucode->mc_addr;
> -	header =3D (const struct gfx_firmware_header_v1_0 *)ucode->fw->data;
> -	data_size =3D le32_to_cpu(header->header.ucode_size_bytes);
> -
> -	if ((fw_type =3D=3D UCODE_ID_CP_MEC_JT1) ||
> -		(fw_type =3D=3D UCODE_ID_CP_MEC_JT2)) {
> -		gpu_addr +=3D le32_to_cpu(header->jt_offset) << 2;
> -		data_size =3D le32_to_cpu(header->jt_size) << 2;
> -	}
> -
> -	entry->version =3D (uint16_t)le32_to_cpu(header->header.ucode_version=
);
> -	entry->id =3D (uint16_t)fw_type;
> -	entry->image_addr_high =3D upper_32_bits(gpu_addr);
> -	entry->image_addr_low =3D lower_32_bits(gpu_addr);
> -	entry->meta_data_addr_high =3D 0;
> -	entry->meta_data_addr_low =3D 0;
> -	entry->data_size_byte =3D data_size;
> -	entry->num_register_entries =3D 0;
> -
> -	if (fw_type =3D=3D UCODE_ID_RLC_G)
> -		entry->flags =3D 1;
> -	else
> -		entry->flags =3D 0;
> -
> -	return 0;
> -}
> -
> -static int fiji_smu_request_load_fw(struct amdgpu_device *adev)
> -{
> -	struct fiji_smu_private_data *private =3D (struct fiji_smu_private_da=
ta *)adev->smu.priv;
> -	struct SMU_DRAMData_TOC *toc;
> -	uint32_t fw_to_load;
> -
> -	WREG32_SMC(ixSOFT_REGISTERS_TABLE_28, 0);
> -
> -	fiji_send_msg_to_smc_with_parameter(adev, PPSMC_MSG_SMU_DRAM_ADDR_HI,=
 private->smu_buffer_addr_high);
> -	fiji_send_msg_to_smc_with_parameter(adev, PPSMC_MSG_SMU_DRAM_ADDR_LO,=
 private->smu_buffer_addr_low);
> -
> -	toc =3D (struct SMU_DRAMData_TOC *)private->header;
> -	toc->num_entries =3D 0;
> -	toc->structure_version =3D 1;
> -
> -	if (!adev->firmware.smu_load)
> -		return 0;
> -
> -	if (fiji_smu_populate_single_firmware_entry(adev, UCODE_ID_RLC_G,
> -			&toc->entry[toc->num_entries++])) {
> -		DRM_ERROR("Failed to get firmware entry for RLC\n");
> -		return -EINVAL;
> -	}
> -
> -	if (fiji_smu_populate_single_firmware_entry(adev, UCODE_ID_CP_CE,
> -			&toc->entry[toc->num_entries++])) {
> -		DRM_ERROR("Failed to get firmware entry for CE\n");
> -		return -EINVAL;
> -	}
> -
> -	if (fiji_smu_populate_single_firmware_entry(adev, UCODE_ID_CP_PFP,
> -			&toc->entry[toc->num_entries++])) {
> -		DRM_ERROR("Failed to get firmware entry for PFP\n");
> -		return -EINVAL;
> -	}
> -
> -	if (fiji_smu_populate_single_firmware_entry(adev, UCODE_ID_CP_ME,
> -			&toc->entry[toc->num_entries++])) {
> -		DRM_ERROR("Failed to get firmware entry for ME\n");
> -		return -EINVAL;
> -	}
> -
> -	if (fiji_smu_populate_single_firmware_entry(adev, UCODE_ID_CP_MEC,
> -			&toc->entry[toc->num_entries++])) {
> -		DRM_ERROR("Failed to get firmware entry for MEC\n");
> -		return -EINVAL;
> -	}
> -
> -	if (fiji_smu_populate_single_firmware_entry(adev, UCODE_ID_CP_MEC_JT1=
,
> -			&toc->entry[toc->num_entries++])) {
> -		DRM_ERROR("Failed to get firmware entry for MEC_JT1\n");
> -		return -EINVAL;
> -	}
> -
> -	if (fiji_smu_populate_single_firmware_entry(adev, UCODE_ID_CP_MEC_JT2=
,
> -			&toc->entry[toc->num_entries++])) {
> -		DRM_ERROR("Failed to get firmware entry for MEC_JT2\n");
> -		return -EINVAL;
> -	}
> -
> -	if (fiji_smu_populate_single_firmware_entry(adev, UCODE_ID_SDMA0,
> -			&toc->entry[toc->num_entries++])) {
> -		DRM_ERROR("Failed to get firmware entry for SDMA0\n");
> -		return -EINVAL;
> -	}
> -
> -	if (fiji_smu_populate_single_firmware_entry(adev, UCODE_ID_SDMA1,
> -			&toc->entry[toc->num_entries++])) {
> -		DRM_ERROR("Failed to get firmware entry for SDMA1\n");
> -		return -EINVAL;
> -	}
> -
> -	fiji_send_msg_to_smc_with_parameter(adev, PPSMC_MSG_DRV_DRAM_ADDR_HI,=
 private->header_addr_high);
> -	fiji_send_msg_to_smc_with_parameter(adev, PPSMC_MSG_DRV_DRAM_ADDR_LO,=
 private->header_addr_low);
> -
> -	fw_to_load =3D UCODE_ID_RLC_G_MASK |
> -			UCODE_ID_SDMA0_MASK |
> -			UCODE_ID_SDMA1_MASK |
> -			UCODE_ID_CP_CE_MASK |
> -			UCODE_ID_CP_ME_MASK |
> -			UCODE_ID_CP_PFP_MASK |
> -			UCODE_ID_CP_MEC_MASK;
> -
> -	if (fiji_send_msg_to_smc_with_parameter_without_waiting(adev, PPSMC_M=
SG_LoadUcodes, fw_to_load)) {
> -		DRM_ERROR("Fail to request SMU load ucode\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -static uint32_t fiji_smu_get_mask_for_fw_type(uint32_t fw_type)
> -{
> -	switch (fw_type) {
> -		case AMDGPU_UCODE_ID_SDMA0:
> -			return UCODE_ID_SDMA0_MASK;
> -		case AMDGPU_UCODE_ID_SDMA1:
> -			return UCODE_ID_SDMA1_MASK;
> -		case AMDGPU_UCODE_ID_CP_CE:
> -			return UCODE_ID_CP_CE_MASK;
> -		case AMDGPU_UCODE_ID_CP_PFP:
> -			return UCODE_ID_CP_PFP_MASK;
> -		case AMDGPU_UCODE_ID_CP_ME:
> -			return UCODE_ID_CP_ME_MASK;
> -		case AMDGPU_UCODE_ID_CP_MEC1:
> -			return UCODE_ID_CP_MEC_MASK;
> -		case AMDGPU_UCODE_ID_CP_MEC2:
> -			return UCODE_ID_CP_MEC_MASK;
> -		case AMDGPU_UCODE_ID_RLC_G:
> -			return UCODE_ID_RLC_G_MASK;
> -		default:
> -			DRM_ERROR("ucode type is out of range!\n");
> -			return 0;
> -	}
> -}
> -
> -static int fiji_smu_check_fw_load_finish(struct amdgpu_device *adev,
> -					uint32_t fw_type)
> -{
> -	uint32_t fw_mask =3D fiji_smu_get_mask_for_fw_type(fw_type);
> -	int i;
> -
> -	for (i =3D 0; i < adev->usec_timeout; i++) {
> -		if (fw_mask =3D=3D (RREG32_SMC(ixSOFT_REGISTERS_TABLE_28) & fw_mask)=
)
> -			break;
> -		udelay(1);
> -	}
> -
> -	if (i =3D=3D adev->usec_timeout) {
> -		DRM_ERROR("check firmware loading failed\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -static int fiji_smu_start_in_protection_mode(struct amdgpu_device *ade=
v)
> -{
> -	int result;
> -	uint32_t val;
> -	int i;
> -
> -	/* Assert reset */
> -	val =3D RREG32_SMC(ixSMC_SYSCON_RESET_CNTL);
> -	val =3D REG_SET_FIELD(val, SMC_SYSCON_RESET_CNTL, rst_reg, 1);
> -	WREG32_SMC(ixSMC_SYSCON_RESET_CNTL, val);
> -
> -	result =3D fiji_smu_upload_firmware_image(adev);
> -	if (result)
> -		return result;
> -
> -	/* Clear status */
> -	WREG32_SMC(ixSMU_STATUS, 0);
> -
> -	/* Enable clock */
> -	val =3D RREG32_SMC(ixSMC_SYSCON_CLOCK_CNTL_0);
> -	val =3D REG_SET_FIELD(val, SMC_SYSCON_CLOCK_CNTL_0, ck_disable, 0);
> -	WREG32_SMC(ixSMC_SYSCON_CLOCK_CNTL_0, val);
> -
> -	/* De-assert reset */
> -	val =3D RREG32_SMC(ixSMC_SYSCON_RESET_CNTL);
> -	val =3D REG_SET_FIELD(val, SMC_SYSCON_RESET_CNTL, rst_reg, 0);
> -	WREG32_SMC(ixSMC_SYSCON_RESET_CNTL, val);
> -
> -	/* Set SMU Auto Start */
> -	val =3D RREG32_SMC(ixSMU_INPUT_DATA);
> -	val =3D REG_SET_FIELD(val, SMU_INPUT_DATA, AUTO_START, 1);
> -	WREG32_SMC(ixSMU_INPUT_DATA, val);
> -
> -	/* Clear firmware interrupt enable flag */
> -	WREG32_SMC(ixFIRMWARE_FLAGS, 0);
> -
> -	for (i =3D 0; i < adev->usec_timeout; i++) {
> -		val =3D RREG32_SMC(ixRCU_UC_EVENTS);
> -		if (REG_GET_FIELD(val, RCU_UC_EVENTS, INTERRUPTS_ENABLED))
> -			break;
> -		udelay(1);
> -	}
> -
> -	if (i =3D=3D adev->usec_timeout) {
> -		DRM_ERROR("Interrupt is not enabled by firmware\n");
> -		return -EINVAL;
> -	}
> -
> -	/* Call Test SMU message with 0x20000 offset
> -	 * to trigger SMU start
> -	 */
> -	fiji_send_msg_to_smc_offset(adev);
> -	DRM_INFO("[FM]try triger smu start\n");
> -	/* Wait for done bit to be set */
> -	for (i =3D 0; i < adev->usec_timeout; i++) {
> -		val =3D RREG32_SMC(ixSMU_STATUS);
> -		if (REG_GET_FIELD(val, SMU_STATUS, SMU_DONE))
> -			break;
> -		udelay(1);
> -	}
> -
> -	if (i =3D=3D adev->usec_timeout) {
> -		DRM_ERROR("Timeout for SMU start\n");
> -		return -EINVAL;
> -	}
> -
> -	/* Check pass/failed indicator */
> -	val =3D RREG32_SMC(ixSMU_STATUS);
> -	if (!REG_GET_FIELD(val, SMU_STATUS, SMU_PASS)) {
> -		DRM_ERROR("SMU Firmware start failed\n");
> -		return -EINVAL;
> -	}
> -	DRM_INFO("[FM]smu started\n");
> -	/* Wait for firmware to initialize */
> -	for (i =3D 0; i < adev->usec_timeout; i++) {
> -		val =3D RREG32_SMC(ixFIRMWARE_FLAGS);
> -		if(REG_GET_FIELD(val, FIRMWARE_FLAGS, INTERRUPTS_ENABLED))
> -			break;
> -		udelay(1);
> -	}
> -
> -	if (i =3D=3D adev->usec_timeout) {
> -		DRM_ERROR("SMU firmware initialization failed\n");
> -		return -EINVAL;
> -	}
> -	DRM_INFO("[FM]smu initialized\n");
> -
> -	return 0;
> -}
> -
> -static int fiji_smu_start_in_non_protection_mode(struct amdgpu_device =
*adev)
> -{
> -	int i, result;
> -	uint32_t val;
> -
> -	/* wait for smc boot up */
> -	for (i =3D 0; i < adev->usec_timeout; i++) {
> -		val =3D RREG32_SMC(ixRCU_UC_EVENTS);
> -		val =3D REG_GET_FIELD(val, RCU_UC_EVENTS, boot_seq_done);
> -		if (val)
> -			break;
> -		udelay(1);
> -	}
> -
> -	if (i =3D=3D adev->usec_timeout) {
> -		DRM_ERROR("SMC boot sequence is not completed\n");
> -		return -EINVAL;
> -	}
> -
> -	/* Clear firmware interrupt enable flag */
> -	WREG32_SMC(ixFIRMWARE_FLAGS, 0);
> -
> -	/* Assert reset */
> -	val =3D RREG32_SMC(ixSMC_SYSCON_RESET_CNTL);
> -	val =3D REG_SET_FIELD(val, SMC_SYSCON_RESET_CNTL, rst_reg, 1);
> -	WREG32_SMC(ixSMC_SYSCON_RESET_CNTL, val);
> -
> -	result =3D fiji_smu_upload_firmware_image(adev);
> -	if (result)
> -		return result;
> -
> -	/* Set smc instruct start point at 0x0 */
> -	fiji_program_jump_on_start(adev);
> -
> -	/* Enable clock */
> -	val =3D RREG32_SMC(ixSMC_SYSCON_CLOCK_CNTL_0);
> -	val =3D REG_SET_FIELD(val, SMC_SYSCON_CLOCK_CNTL_0, ck_disable, 0);
> -	WREG32_SMC(ixSMC_SYSCON_CLOCK_CNTL_0, val);
> -
> -	/* De-assert reset */
> -	val =3D RREG32_SMC(ixSMC_SYSCON_RESET_CNTL);
> -	val =3D REG_SET_FIELD(val, SMC_SYSCON_RESET_CNTL, rst_reg, 0);
> -	WREG32_SMC(ixSMC_SYSCON_RESET_CNTL, val);
> -
> -	/* Wait for firmware to initialize */
> -	for (i =3D 0; i < adev->usec_timeout; i++) {
> -		val =3D RREG32_SMC(ixFIRMWARE_FLAGS);
> -		if (REG_GET_FIELD(val, FIRMWARE_FLAGS, INTERRUPTS_ENABLED))
> -			break;
> -		udelay(1);
> -	}
> -
> -	if (i =3D=3D adev->usec_timeout) {
> -		DRM_ERROR("Timeout for SMC firmware initialization\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -int fiji_smu_start(struct amdgpu_device *adev)
> -{
> -	int result;
> -	uint32_t val;
> -
> -	if (!fiji_is_smc_ram_running(adev)) {
> -		val =3D RREG32_SMC(ixSMU_FIRMWARE);
> -		if (!REG_GET_FIELD(val, SMU_FIRMWARE, SMU_MODE)) {
> -			DRM_INFO("[FM]start smu in nonprotection mode\n");
> -			result =3D fiji_smu_start_in_non_protection_mode(adev);
> -			if (result)
> -				return result;
> -		} else {
> -			DRM_INFO("[FM]start smu in protection mode\n");
> -			result =3D fiji_smu_start_in_protection_mode(adev);
> -			if (result)
> -				return result;
> -		}
> -	}
> -
> -	return fiji_smu_request_load_fw(adev);
> -}
> -
> -static const struct amdgpu_smumgr_funcs fiji_smumgr_funcs =3D {
> -	.check_fw_load_finish =3D fiji_smu_check_fw_load_finish,
> -	.request_smu_load_fw =3D NULL,
> -	.request_smu_specific_fw =3D NULL,
> -};
> -
> -int fiji_smu_init(struct amdgpu_device *adev)
> -{
> -	struct fiji_smu_private_data *private;
> -	uint32_t image_size =3D ((sizeof(struct SMU_DRAMData_TOC) / 4096) + 1=
) * 4096;
> -	uint32_t smu_internal_buffer_size =3D 200*4096;
> -	struct amdgpu_bo **toc_buf =3D &adev->smu.toc_buf;
> -	struct amdgpu_bo **smu_buf =3D &adev->smu.smu_buf;
> -	uint64_t mc_addr;
> -	void *toc_buf_ptr;
> -	void *smu_buf_ptr;
> -	int ret;
> -
> -	private =3D kzalloc(sizeof(struct fiji_smu_private_data), GFP_KERNEL)=
;
> -	if (NULL =3D=3D private)
> -		return -ENOMEM;
> -
> -	/* allocate firmware buffers */
> -	if (adev->firmware.smu_load)
> -		amdgpu_ucode_init_bo(adev);
> -
> -	adev->smu.priv =3D private;
> -	adev->smu.fw_flags =3D 0;
> -
> -	/* Allocate FW image data structure and header buffer */
> -	ret =3D amdgpu_bo_create(adev, image_size, PAGE_SIZE,
> -			       true, AMDGPU_GEM_DOMAIN_VRAM,
> -			       AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED,
> -			       NULL, NULL, toc_buf);
> -	if (ret) {
> -		DRM_ERROR("Failed to allocate memory for TOC buffer\n");
> -		return -ENOMEM;
> -	}
> -
> -	/* Allocate buffer for SMU internal buffer */
> -	ret =3D amdgpu_bo_create(adev, smu_internal_buffer_size, PAGE_SIZE,
> -			       true, AMDGPU_GEM_DOMAIN_VRAM,
> -			       AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED,
> -			       NULL, NULL, smu_buf);
> -	if (ret) {
> -		DRM_ERROR("Failed to allocate memory for SMU internal buffer\n");
> -		return -ENOMEM;
> -	}
> -
> -	/* Retrieve GPU address for header buffer and internal buffer */
> -	ret =3D amdgpu_bo_reserve(adev->smu.toc_buf, false);
> -	if (ret) {
> -		amdgpu_bo_unref(&adev->smu.toc_buf);
> -		DRM_ERROR("Failed to reserve the TOC buffer\n");
> -		return -EINVAL;
> -	}
> -
> -	ret =3D amdgpu_bo_pin(adev->smu.toc_buf, AMDGPU_GEM_DOMAIN_VRAM, &mc_=
addr);
> -	if (ret) {
> -		amdgpu_bo_unreserve(adev->smu.toc_buf);
> -		amdgpu_bo_unref(&adev->smu.toc_buf);
> -		DRM_ERROR("Failed to pin the TOC buffer\n");
> -		return -EINVAL;
> -	}
> -
> -	ret =3D amdgpu_bo_kmap(*toc_buf, &toc_buf_ptr);
> -	if (ret) {
> -		amdgpu_bo_unreserve(adev->smu.toc_buf);
> -		amdgpu_bo_unref(&adev->smu.toc_buf);
> -		DRM_ERROR("Failed to map the TOC buffer\n");
> -		return -EINVAL;
> -	}
> -
> -	amdgpu_bo_unreserve(adev->smu.toc_buf);
> -	private->header_addr_low =3D lower_32_bits(mc_addr);
> -	private->header_addr_high =3D upper_32_bits(mc_addr);
> -	private->header =3D toc_buf_ptr;
> -
> -	ret =3D amdgpu_bo_reserve(adev->smu.smu_buf, false);
> -	if (ret) {
> -		amdgpu_bo_unref(&adev->smu.smu_buf);
> -		amdgpu_bo_unref(&adev->smu.toc_buf);
> -		DRM_ERROR("Failed to reserve the SMU internal buffer\n");
> -		return -EINVAL;
> -	}
> -
> -	ret =3D amdgpu_bo_pin(adev->smu.smu_buf, AMDGPU_GEM_DOMAIN_VRAM, &mc_=
addr);
> -	if (ret) {
> -		amdgpu_bo_unreserve(adev->smu.smu_buf);
> -		amdgpu_bo_unref(&adev->smu.smu_buf);
> -		amdgpu_bo_unref(&adev->smu.toc_buf);
> -		DRM_ERROR("Failed to pin the SMU internal buffer\n");
> -		return -EINVAL;
> -	}
> -
> -	ret =3D amdgpu_bo_kmap(*smu_buf, &smu_buf_ptr);
> -	if (ret) {
> -		amdgpu_bo_unreserve(adev->smu.smu_buf);
> -		amdgpu_bo_unref(&adev->smu.smu_buf);
> -		amdgpu_bo_unref(&adev->smu.toc_buf);
> -		DRM_ERROR("Failed to map the SMU internal buffer\n");
> -		return -EINVAL;
> -	}
> -
> -	amdgpu_bo_unreserve(adev->smu.smu_buf);
> -	private->smu_buffer_addr_low =3D lower_32_bits(mc_addr);
> -	private->smu_buffer_addr_high =3D upper_32_bits(mc_addr);
> -
> -	adev->smu.smumgr_funcs =3D &fiji_smumgr_funcs;
> -
> -	return 0;
> -}
> -
> -int fiji_smu_fini(struct amdgpu_device *adev)
> -{
> -	amdgpu_bo_unref(&adev->smu.toc_buf);
> -	amdgpu_bo_unref(&adev->smu.smu_buf);
> -	kfree(adev->smu.priv);
> -	adev->smu.priv =3D NULL;
> -	if (adev->firmware.fw_buf)
> -		amdgpu_ucode_fini_bo(adev);
> -
> -	return 0;
> -}
> diff --git a/drivers/gpu/drm/amd/amdgpu/fiji_smum.h b/drivers/gpu/drm/a=
md/amdgpu/fiji_smum.h
> deleted file mode 100644
> index 1cef03d..0000000
> --- a/drivers/gpu/drm/amd/amdgpu/fiji_smum.h
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -/*
> - * Copyright 2014 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> - * copy of this software and associated documentation files (the "Soft=
ware"),
> - * to deal in the Software without restriction, including without limi=
tation
> - * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> - * and/or sell copies of the Software, and to permit persons to whom t=
he
> - * Software is furnished to do so, subject to the following conditions=
:
> - *
> - * The above copyright notice and this permission notice shall be incl=
uded in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - */
> -
> -#ifndef FIJI_SMUMGR_H
> -#define FIJI_SMUMGR_H
> -
> -#include "fiji_ppsmc.h"
> -
> -int fiji_smu_init(struct amdgpu_device *adev);
> -int fiji_smu_fini(struct amdgpu_device *adev);
> -int fiji_smu_start(struct amdgpu_device *adev);
> -
> -struct fiji_smu_private_data
> -{
> -	uint8_t *header;
> -	uint32_t smu_buffer_addr_high;
> -	uint32_t smu_buffer_addr_low;
> -	uint32_t header_addr_high;
> -	uint32_t header_addr_low;
> -};
> -
> -#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_dpm.c b/drivers/gpu/drm=
/amd/amdgpu/iceland_dpm.c
> deleted file mode 100644
> index 2f078ad..0000000
> --- a/drivers/gpu/drm/amd/amdgpu/iceland_dpm.c
> +++ /dev/null
> @@ -1,200 +0,0 @@
> -/*
> - * Copyright 2014 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> - * copy of this software and associated documentation files (the "Soft=
ware"),
> - * to deal in the Software without restriction, including without limi=
tation
> - * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> - * and/or sell copies of the Software, and to permit persons to whom t=
he
> - * Software is furnished to do so, subject to the following conditions=
:
> - *
> - * The above copyright notice and this permission notice shall be incl=
uded in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - */
> -
> -#include <linux/firmware.h>
> -#include "drmP.h"
> -#include "amdgpu.h"
> -#include "iceland_smum.h"
> -
> -MODULE_FIRMWARE("amdgpu/topaz_smc.bin");
> -
> -static void iceland_dpm_set_funcs(struct amdgpu_device *adev);
> -
> -static int iceland_dpm_early_init(void *handle)
> -{
> -	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -
> -	iceland_dpm_set_funcs(adev);
> -
> -	return 0;
> -}
> -
> -static int iceland_dpm_init_microcode(struct amdgpu_device *adev)
> -{
> -	char fw_name[30] =3D "amdgpu/topaz_smc.bin";
> -	int err;
> -
> -	err =3D request_firmware(&adev->pm.fw, fw_name, adev->dev);
> -	if (err)
> -		goto out;
> -	err =3D amdgpu_ucode_validate(adev->pm.fw);
> -
> -out:
> -	if (err) {
> -		DRM_ERROR("Failed to load firmware \"%s\"", fw_name);
> -		release_firmware(adev->pm.fw);
> -		adev->pm.fw =3D NULL;
> -	}
> -	return err;
> -}
> -
> -static int iceland_dpm_sw_init(void *handle)
> -{
> -	int ret;
> -	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -
> -	ret =3D iceland_dpm_init_microcode(adev);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> -}
> -
> -static int iceland_dpm_sw_fini(void *handle)
> -{
> -	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -
> -	release_firmware(adev->pm.fw);
> -	adev->pm.fw =3D NULL;
> -
> -	return 0;
> -}
> -
> -static int iceland_dpm_hw_init(void *handle)
> -{
> -	int ret;
> -	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -
> -	mutex_lock(&adev->pm.mutex);
> -
> -	/* smu init only needs to be called at startup, not resume.
> -	 * It should be in sw_init, but requires the fw info gathered
> -	 * in sw_init from other IP modules.
> -	 */
> -	ret =3D iceland_smu_init(adev);
> -	if (ret) {
> -		DRM_ERROR("SMU initialization failed\n");
> -		goto fail;
> -	}
> -
> -	ret =3D iceland_smu_start(adev);
> -	if (ret) {
> -		DRM_ERROR("SMU start failed\n");
> -		goto fail;
> -	}
> -
> -	mutex_unlock(&adev->pm.mutex);
> -	return 0;
> -
> -fail:
> -	adev->firmware.smu_load =3D false;
> -	mutex_unlock(&adev->pm.mutex);
> -	return -EINVAL;
> -}
> -
> -static int iceland_dpm_hw_fini(void *handle)
> -{
> -	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -
> -	mutex_lock(&adev->pm.mutex);
> -	/* smu fini only needs to be called at teardown, not suspend.
> -	 * It should be in sw_fini, but we put it here for symmetry
> -	 * with smu init.
> -	 */
> -	iceland_smu_fini(adev);
> -	mutex_unlock(&adev->pm.mutex);
> -	return 0;
> -}
> -
> -static int iceland_dpm_suspend(void *handle)
> -{
> -	return 0;
> -}
> -
> -static int iceland_dpm_resume(void *handle)
> -{
> -	int ret;
> -	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -
> -	mutex_lock(&adev->pm.mutex);
> -
> -	ret =3D iceland_smu_start(adev);
> -	if (ret) {
> -		DRM_ERROR("SMU start failed\n");
> -		goto fail;
> -	}
> -
> -fail:
> -	mutex_unlock(&adev->pm.mutex);
> -	return ret;
> -}
> -
> -static int iceland_dpm_set_clockgating_state(void *handle,
> -			enum amd_clockgating_state state)
> -{
> -	return 0;
> -}
> -
> -static int iceland_dpm_set_powergating_state(void *handle,
> -			enum amd_powergating_state state)
> -{
> -	return 0;
> -}
> -
> -const struct amd_ip_funcs iceland_dpm_ip_funcs =3D {
> -	.name =3D "iceland_dpm",
> -	.early_init =3D iceland_dpm_early_init,
> -	.late_init =3D NULL,
> -	.sw_init =3D iceland_dpm_sw_init,
> -	.sw_fini =3D iceland_dpm_sw_fini,
> -	.hw_init =3D iceland_dpm_hw_init,
> -	.hw_fini =3D iceland_dpm_hw_fini,
> -	.suspend =3D iceland_dpm_suspend,
> -	.resume =3D iceland_dpm_resume,
> -	.is_idle =3D NULL,
> -	.wait_for_idle =3D NULL,
> -	.soft_reset =3D NULL,
> -	.set_clockgating_state =3D iceland_dpm_set_clockgating_state,
> -	.set_powergating_state =3D iceland_dpm_set_powergating_state,
> -};
> -
> -static const struct amdgpu_dpm_funcs iceland_dpm_funcs =3D {
> -	.get_temperature =3D NULL,
> -	.pre_set_power_state =3D NULL,
> -	.set_power_state =3D NULL,
> -	.post_set_power_state =3D NULL,
> -	.display_configuration_changed =3D NULL,
> -	.get_sclk =3D NULL,
> -	.get_mclk =3D NULL,
> -	.print_power_state =3D NULL,
> -	.debugfs_print_current_performance_level =3D NULL,
> -	.force_performance_level =3D NULL,
> -	.vblank_too_short =3D NULL,
> -	.powergate_uvd =3D NULL,
> -};
> -
> -static void iceland_dpm_set_funcs(struct amdgpu_device *adev)
> -{
> -	if (NULL =3D=3D adev->pm.funcs)
> -		adev->pm.funcs =3D &iceland_dpm_funcs;
> -}
> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_smc.c b/drivers/gpu/drm=
/amd/amdgpu/iceland_smc.c
> deleted file mode 100644
> index c6e004a..0000000
> --- a/drivers/gpu/drm/amd/amdgpu/iceland_smc.c
> +++ /dev/null
> @@ -1,677 +0,0 @@
> -/*
> - * Copyright 2014 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> - * copy of this software and associated documentation files (the "Soft=
ware"),
> - * to deal in the Software without restriction, including without limi=
tation
> - * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> - * and/or sell copies of the Software, and to permit persons to whom t=
he
> - * Software is furnished to do so, subject to the following conditions=
:
> - *
> - * The above copyright notice and this permission notice shall be incl=
uded in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - */
> -
> -#include <linux/firmware.h>
> -#include "drmP.h"
> -#include "amdgpu.h"
> -#include "ppsmc.h"
> -#include "iceland_smum.h"
> -#include "smu_ucode_xfer_vi.h"
> -#include "amdgpu_ucode.h"
> -
> -#include "smu/smu_7_1_1_d.h"
> -#include "smu/smu_7_1_1_sh_mask.h"
> -
> -#define ICELAND_SMC_SIZE 0x20000
> -
> -static int iceland_set_smc_sram_address(struct amdgpu_device *adev,
> -					uint32_t smc_address, uint32_t limit)
> -{
> -	uint32_t val;
> -
> -	if (smc_address & 3)
> -		return -EINVAL;
> -
> -	if ((smc_address + 3) > limit)
> -		return -EINVAL;
> -
> -	WREG32(mmSMC_IND_INDEX_0, smc_address);
> -
> -	val =3D RREG32(mmSMC_IND_ACCESS_CNTL);
> -	val =3D REG_SET_FIELD(val, SMC_IND_ACCESS_CNTL, AUTO_INCREMENT_IND_0,=
 0);
> -	WREG32(mmSMC_IND_ACCESS_CNTL, val);
> -
> -	return 0;
> -}
> -
> -static int iceland_copy_bytes_to_smc(struct amdgpu_device *adev,
> -				     uint32_t smc_start_address,
> -				     const uint8_t *src,
> -				     uint32_t byte_count, uint32_t limit)
> -{
> -	uint32_t addr;
> -	uint32_t data, orig_data;
> -	int result =3D 0;
> -	uint32_t extra_shift;
> -	unsigned long flags;
> -
> -	if (smc_start_address & 3)
> -		return -EINVAL;
> -
> -	if ((smc_start_address + byte_count) > limit)
> -		return -EINVAL;
> -
> -	addr =3D smc_start_address;
> -
> -	spin_lock_irqsave(&adev->smc_idx_lock, flags);
> -	while (byte_count >=3D 4) {
> -		/* Bytes are written into the SMC addres space with the MSB first */=

> -		data =3D (src[0] << 24) + (src[1] << 16) + (src[2] << 8) + src[3];
> -
> -		result =3D iceland_set_smc_sram_address(adev, addr, limit);
> -
> -		if (result)
> -			goto out;
> -
> -		WREG32(mmSMC_IND_DATA_0, data);
> -
> -		src +=3D 4;
> -		byte_count -=3D 4;
> -		addr +=3D 4;
> -	}
> -
> -	if (0 !=3D byte_count) {
> -		/* Now write odd bytes left, do a read modify write cycle */
> -		data =3D 0;
> -
> -		result =3D iceland_set_smc_sram_address(adev, addr, limit);
> -		if (result)
> -			goto out;
> -
> -		orig_data =3D RREG32(mmSMC_IND_DATA_0);
> -		extra_shift =3D 8 * (4 - byte_count);
> -
> -		while (byte_count > 0) {
> -			data =3D (data << 8) + *src++;
> -			byte_count--;
> -		}
> -
> -		data <<=3D extra_shift;
> -		data |=3D (orig_data & ~((~0UL) << extra_shift));
> -
> -		result =3D iceland_set_smc_sram_address(adev, addr, limit);
> -		if (result)
> -			goto out;
> -
> -		WREG32(mmSMC_IND_DATA_0, data);
> -	}
> -
> -out:
> -	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
> -	return result;
> -}
> -
> -static void iceland_start_smc(struct amdgpu_device *adev)
> -{
> -	uint32_t val =3D RREG32_SMC(ixSMC_SYSCON_RESET_CNTL);
> -
> -	val =3D REG_SET_FIELD(val, SMC_SYSCON_RESET_CNTL, rst_reg, 0);
> -	WREG32_SMC(ixSMC_SYSCON_RESET_CNTL, val);
> -}
> -
> -static void iceland_reset_smc(struct amdgpu_device *adev)
> -{
> -	uint32_t val =3D RREG32_SMC(ixSMC_SYSCON_RESET_CNTL);
> -
> -	val =3D REG_SET_FIELD(val, SMC_SYSCON_RESET_CNTL, rst_reg, 1);
> -	WREG32_SMC(ixSMC_SYSCON_RESET_CNTL, val);
> -}
> -
> -static int iceland_program_jump_on_start(struct amdgpu_device *adev)
> -{
> -	static unsigned char data[] =3D {0xE0, 0x00, 0x80, 0x40};
> -	iceland_copy_bytes_to_smc(adev, 0x0, data, 4, sizeof(data)+1);
> -
> -	return 0;
> -}
> -
> -static void iceland_stop_smc_clock(struct amdgpu_device *adev)
> -{
> -	uint32_t val =3D RREG32_SMC(ixSMC_SYSCON_CLOCK_CNTL_0);
> -
> -	val =3D REG_SET_FIELD(val, SMC_SYSCON_CLOCK_CNTL_0, ck_disable, 1);
> -	WREG32_SMC(ixSMC_SYSCON_CLOCK_CNTL_0, val);
> -}
> -
> -static void iceland_start_smc_clock(struct amdgpu_device *adev)
> -{
> -	uint32_t val =3D RREG32_SMC(ixSMC_SYSCON_CLOCK_CNTL_0);
> -
> -	val =3D REG_SET_FIELD(val, SMC_SYSCON_CLOCK_CNTL_0, ck_disable, 0);
> -	WREG32_SMC(ixSMC_SYSCON_CLOCK_CNTL_0, val);
> -}
> -
> -static bool iceland_is_smc_ram_running(struct amdgpu_device *adev)
> -{
> -	uint32_t val =3D RREG32_SMC(ixSMC_SYSCON_CLOCK_CNTL_0);
> -	val =3D REG_GET_FIELD(val, SMC_SYSCON_CLOCK_CNTL_0, ck_disable);
> -
> -	return ((0 =3D=3D val) && (0x20100 <=3D RREG32_SMC(ixSMC_PC_C)));
> -}
> -
> -static int wait_smu_response(struct amdgpu_device *adev)
> -{
> -	int i;
> -	uint32_t val;
> -
> -	for (i =3D 0; i < adev->usec_timeout; i++) {
> -		val =3D RREG32(mmSMC_RESP_0);
> -		if (REG_GET_FIELD(val, SMC_RESP_0, SMC_RESP))
> -			break;
> -		udelay(1);
> -	}
> -
> -	if (i =3D=3D adev->usec_timeout)
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
> -static int iceland_send_msg_to_smc(struct amdgpu_device *adev, PPSMC_M=
sg msg)
> -{
> -	if (!iceland_is_smc_ram_running(adev))
> -		return -EINVAL;
> -
> -	if (wait_smu_response(adev)) {
> -		DRM_ERROR("Failed to send previous message\n");
> -		return -EINVAL;
> -	}
> -
> -	WREG32(mmSMC_MESSAGE_0, msg);
> -
> -	if (wait_smu_response(adev)) {
> -		DRM_ERROR("Failed to send message\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -static int iceland_send_msg_to_smc_without_waiting(struct amdgpu_devic=
e *adev,
> -						   PPSMC_Msg msg)
> -{
> -	if (!iceland_is_smc_ram_running(adev))
> -		return -EINVAL;
> -
> -	if (wait_smu_response(adev)) {
> -		DRM_ERROR("Failed to send previous message\n");
> -		return -EINVAL;
> -	}
> -
> -	WREG32(mmSMC_MESSAGE_0, msg);
> -
> -	return 0;
> -}
> -
> -static int iceland_send_msg_to_smc_with_parameter(struct amdgpu_device=
 *adev,
> -						  PPSMC_Msg msg,
> -						  uint32_t parameter)
> -{
> -	WREG32(mmSMC_MSG_ARG_0, parameter);
> -
> -	return iceland_send_msg_to_smc(adev, msg);
> -}
> -
> -static int iceland_send_msg_to_smc_with_parameter_without_waiting(
> -					struct amdgpu_device *adev,
> -					PPSMC_Msg msg, uint32_t parameter)
> -{
> -	WREG32(mmSMC_MSG_ARG_0, parameter);
> -
> -	return iceland_send_msg_to_smc_without_waiting(adev, msg);
> -}
> -
> -#if 0 /* not used yet */
> -static int iceland_wait_for_smc_inactive(struct amdgpu_device *adev)
> -{
> -	int i;
> -	uint32_t val;
> -
> -	if (!iceland_is_smc_ram_running(adev))
> -		return -EINVAL;
> -
> -	for (i =3D 0; i < adev->usec_timeout; i++) {
> -		val =3D RREG32_SMC(ixSMC_SYSCON_CLOCK_CNTL_0);
> -		if (REG_GET_FIELD(val, SMC_SYSCON_CLOCK_CNTL_0, cken) =3D=3D 0)
> -			break;
> -		udelay(1);
> -	}
> -
> -	if (i =3D=3D adev->usec_timeout)
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -#endif
> -
> -static int iceland_smu_upload_firmware_image(struct amdgpu_device *ade=
v)
> -{
> -	const struct smc_firmware_header_v1_0 *hdr;
> -	uint32_t ucode_size;
> -	uint32_t ucode_start_address;
> -	const uint8_t *src;
> -	uint32_t val;
> -	uint32_t byte_count;
> -	uint32_t data;
> -	unsigned long flags;
> -	int i;
> -
> -	if (!adev->pm.fw)
> -		return -EINVAL;
> -
> -	/* Skip SMC ucode loading on SR-IOV capable boards.
> -	 * vbios does this for us in asic_init in that case.
> -	 */
> -	if (amdgpu_sriov_bios(adev))
> -		return 0;
> -
> -	hdr =3D (const struct smc_firmware_header_v1_0 *)adev->pm.fw->data;
> -	amdgpu_ucode_print_smc_hdr(&hdr->header);
> -
> -	adev->pm.fw_version =3D le32_to_cpu(hdr->header.ucode_version);
> -	ucode_size =3D le32_to_cpu(hdr->header.ucode_size_bytes);
> -	ucode_start_address =3D le32_to_cpu(hdr->ucode_start_addr);
> -	src =3D (const uint8_t *)
> -		(adev->pm.fw->data + le32_to_cpu(hdr->header.ucode_array_offset_byte=
s));
> -
> -	if (ucode_size & 3) {
> -		DRM_ERROR("SMC ucode is not 4 bytes aligned\n");
> -		return -EINVAL;
> -	}
> -
> -	if (ucode_size > ICELAND_SMC_SIZE) {
> -		DRM_ERROR("SMC address is beyond the SMC RAM area\n");
> -		return -EINVAL;
> -	}
> -
> -	for (i =3D 0; i < adev->usec_timeout; i++) {
> -		val =3D RREG32_SMC(ixRCU_UC_EVENTS);
> -		if (REG_GET_FIELD(val, RCU_UC_EVENTS, boot_seq_done) =3D=3D 0)
> -			break;
> -		udelay(1);
> -	}
> -	val =3D RREG32_SMC(ixSMC_SYSCON_MISC_CNTL);
> -	WREG32_SMC(ixSMC_SYSCON_MISC_CNTL, val | 1);
> -
> -	iceland_stop_smc_clock(adev);
> -	iceland_reset_smc(adev);
> -
> -	spin_lock_irqsave(&adev->smc_idx_lock, flags);
> -	WREG32(mmSMC_IND_INDEX_0, ucode_start_address);
> -
> -	val =3D RREG32(mmSMC_IND_ACCESS_CNTL);
> -	val =3D REG_SET_FIELD(val, SMC_IND_ACCESS_CNTL, AUTO_INCREMENT_IND_0,=
 1);
> -	WREG32(mmSMC_IND_ACCESS_CNTL, val);
> -
> -	byte_count =3D ucode_size;
> -	while (byte_count >=3D 4) {
> -		data =3D (src[0] << 24) + (src[1] << 16) + (src[2] << 8) + src[3];
> -		WREG32(mmSMC_IND_DATA_0, data);
> -		src +=3D 4;
> -		byte_count -=3D 4;
> -	}
> -	val =3D RREG32(mmSMC_IND_ACCESS_CNTL);
> -	val =3D REG_SET_FIELD(val, SMC_IND_ACCESS_CNTL, AUTO_INCREMENT_IND_0,=
 0);
> -	WREG32(mmSMC_IND_ACCESS_CNTL, val);
> -	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
> -
> -	return 0;
> -}
> -
> -#if 0 /* not used yet */
> -static int iceland_read_smc_sram_dword(struct amdgpu_device *adev,
> -				       uint32_t smc_address,
> -				       uint32_t *value,
> -				       uint32_t limit)
> -{
> -	int result;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&adev->smc_idx_lock, flags);
> -	result =3D iceland_set_smc_sram_address(adev, smc_address, limit);
> -	if (result =3D=3D 0)
> -		*value =3D RREG32(mmSMC_IND_DATA_0);
> -	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
> -	return result;
> -}
> -
> -static int iceland_write_smc_sram_dword(struct amdgpu_device *adev,
> -					uint32_t smc_address,
> -					uint32_t value,
> -					uint32_t limit)
> -{
> -	int result;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&adev->smc_idx_lock, flags);
> -	result =3D iceland_set_smc_sram_address(adev, smc_address, limit);
> -	if (result =3D=3D 0)
> -		WREG32(mmSMC_IND_DATA_0, value);
> -	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
> -	return result;
> -}
> -
> -static int iceland_smu_stop_smc(struct amdgpu_device *adev)
> -{
> -	iceland_reset_smc(adev);
> -	iceland_stop_smc_clock(adev);
> -
> -	return 0;
> -}
> -#endif
> -
> -static int iceland_smu_start_smc(struct amdgpu_device *adev)
> -{
> -	int i;
> -	uint32_t val;
> -
> -	iceland_program_jump_on_start(adev);
> -	iceland_start_smc_clock(adev);
> -	iceland_start_smc(adev);
> -
> -	for (i =3D 0; i < adev->usec_timeout; i++) {
> -		val =3D RREG32_SMC(ixFIRMWARE_FLAGS);
> -		if (REG_GET_FIELD(val, FIRMWARE_FLAGS, INTERRUPTS_ENABLED) =3D=3D 1)=

> -			break;
> -		udelay(1);
> -	}
> -	return 0;
> -}
> -
> -static enum AMDGPU_UCODE_ID iceland_convert_fw_type(uint32_t fw_type)
> -{
> -	switch (fw_type) {
> -		case UCODE_ID_SDMA0:
> -			return AMDGPU_UCODE_ID_SDMA0;
> -		case UCODE_ID_SDMA1:
> -			return AMDGPU_UCODE_ID_SDMA1;
> -		case UCODE_ID_CP_CE:
> -			return AMDGPU_UCODE_ID_CP_CE;
> -		case UCODE_ID_CP_PFP:
> -			return AMDGPU_UCODE_ID_CP_PFP;
> -		case UCODE_ID_CP_ME:
> -			return AMDGPU_UCODE_ID_CP_ME;
> -		case UCODE_ID_CP_MEC:
> -		case UCODE_ID_CP_MEC_JT1:
> -			return AMDGPU_UCODE_ID_CP_MEC1;
> -		case UCODE_ID_CP_MEC_JT2:
> -			return AMDGPU_UCODE_ID_CP_MEC2;
> -		case UCODE_ID_RLC_G:
> -			return AMDGPU_UCODE_ID_RLC_G;
> -		default:
> -			DRM_ERROR("ucode type is out of range!\n");
> -			return AMDGPU_UCODE_ID_MAXIMUM;
> -	}
> -}
> -
> -static uint32_t iceland_smu_get_mask_for_fw_type(uint32_t fw_type)
> -{
> -	switch (fw_type) {
> -		case AMDGPU_UCODE_ID_SDMA0:
> -			return UCODE_ID_SDMA0_MASK;
> -		case AMDGPU_UCODE_ID_SDMA1:
> -			return UCODE_ID_SDMA1_MASK;
> -		case AMDGPU_UCODE_ID_CP_CE:
> -			return UCODE_ID_CP_CE_MASK;
> -		case AMDGPU_UCODE_ID_CP_PFP:
> -			return UCODE_ID_CP_PFP_MASK;
> -		case AMDGPU_UCODE_ID_CP_ME:
> -			return UCODE_ID_CP_ME_MASK;
> -		case AMDGPU_UCODE_ID_CP_MEC1:
> -			return UCODE_ID_CP_MEC_MASK | UCODE_ID_CP_MEC_JT1_MASK;
> -		case AMDGPU_UCODE_ID_CP_MEC2:
> -			return UCODE_ID_CP_MEC_MASK;
> -		case AMDGPU_UCODE_ID_RLC_G:
> -			return UCODE_ID_RLC_G_MASK;
> -		default:
> -			DRM_ERROR("ucode type is out of range!\n");
> -			return 0;
> -	}
> -}
> -
> -static int iceland_smu_populate_single_firmware_entry(struct amdgpu_de=
vice *adev,
> -						      uint32_t fw_type,
> -						      struct SMU_Entry *entry)
> -{
> -	enum AMDGPU_UCODE_ID id =3D iceland_convert_fw_type(fw_type);
> -	struct amdgpu_firmware_info *ucode =3D &adev->firmware.ucode[id];
> -	const struct gfx_firmware_header_v1_0 *header =3D NULL;
> -	uint64_t gpu_addr;
> -	uint32_t data_size;
> -
> -	if (ucode->fw =3D=3D NULL)
> -		return -EINVAL;
> -
> -	gpu_addr  =3D ucode->mc_addr;
> -	header =3D (const struct gfx_firmware_header_v1_0 *)ucode->fw->data;
> -	data_size =3D le32_to_cpu(header->header.ucode_size_bytes);
> -
> -	entry->version =3D (uint16_t)le32_to_cpu(header->header.ucode_version=
);
> -	entry->id =3D (uint16_t)fw_type;
> -	entry->image_addr_high =3D upper_32_bits(gpu_addr);
> -	entry->image_addr_low =3D lower_32_bits(gpu_addr);
> -	entry->meta_data_addr_high =3D 0;
> -	entry->meta_data_addr_low =3D 0;
> -	entry->data_size_byte =3D data_size;
> -	entry->num_register_entries =3D 0;
> -	entry->flags =3D 0;
> -
> -	return 0;
> -}
> -
> -static int iceland_smu_request_load_fw(struct amdgpu_device *adev)
> -{
> -	struct iceland_smu_private_data *private =3D (struct iceland_smu_priv=
ate_data *)adev->smu.priv;
> -	struct SMU_DRAMData_TOC *toc;
> -	uint32_t fw_to_load;
> -
> -	toc =3D (struct SMU_DRAMData_TOC *)private->header;
> -	toc->num_entries =3D 0;
> -	toc->structure_version =3D 1;
> -
> -	if (!adev->firmware.smu_load)
> -		return 0;
> -
> -	if (iceland_smu_populate_single_firmware_entry(adev, UCODE_ID_RLC_G,
> -			&toc->entry[toc->num_entries++])) {
> -		DRM_ERROR("Failed to get firmware entry for RLC\n");
> -		return -EINVAL;
> -	}
> -
> -	if (iceland_smu_populate_single_firmware_entry(adev, UCODE_ID_CP_CE,
> -			&toc->entry[toc->num_entries++])) {
> -		DRM_ERROR("Failed to get firmware entry for CE\n");
> -		return -EINVAL;
> -	}
> -
> -	if (iceland_smu_populate_single_firmware_entry(adev, UCODE_ID_CP_PFP,=

> -			&toc->entry[toc->num_entries++])) {
> -		DRM_ERROR("Failed to get firmware entry for PFP\n");
> -		return -EINVAL;
> -	}
> -
> -	if (iceland_smu_populate_single_firmware_entry(adev, UCODE_ID_CP_ME,
> -			&toc->entry[toc->num_entries++])) {
> -		DRM_ERROR("Failed to get firmware entry for ME\n");
> -		return -EINVAL;
> -	}
> -
> -	if (iceland_smu_populate_single_firmware_entry(adev, UCODE_ID_CP_MEC,=

> -			&toc->entry[toc->num_entries++])) {
> -		DRM_ERROR("Failed to get firmware entry for MEC\n");
> -		return -EINVAL;
> -	}
> -
> -	if (iceland_smu_populate_single_firmware_entry(adev, UCODE_ID_CP_MEC_=
JT1,
> -			&toc->entry[toc->num_entries++])) {
> -		DRM_ERROR("Failed to get firmware entry for MEC_JT1\n");
> -		return -EINVAL;
> -	}
> -
> -	if (iceland_smu_populate_single_firmware_entry(adev, UCODE_ID_SDMA0,
> -			&toc->entry[toc->num_entries++])) {
> -		DRM_ERROR("Failed to get firmware entry for SDMA0\n");
> -		return -EINVAL;
> -	}
> -
> -	if (iceland_smu_populate_single_firmware_entry(adev, UCODE_ID_SDMA1,
> -			&toc->entry[toc->num_entries++])) {
> -		DRM_ERROR("Failed to get firmware entry for SDMA1\n");
> -		return -EINVAL;
> -	}
> -
> -	iceland_send_msg_to_smc_with_parameter(adev, PPSMC_MSG_DRV_DRAM_ADDR_=
HI, private->header_addr_high);
> -	iceland_send_msg_to_smc_with_parameter(adev, PPSMC_MSG_DRV_DRAM_ADDR_=
LO, private->header_addr_low);
> -
> -	fw_to_load =3D UCODE_ID_RLC_G_MASK |
> -			UCODE_ID_SDMA0_MASK |
> -			UCODE_ID_SDMA1_MASK |
> -			UCODE_ID_CP_CE_MASK |
> -			UCODE_ID_CP_ME_MASK |
> -			UCODE_ID_CP_PFP_MASK |
> -			UCODE_ID_CP_MEC_MASK |
> -			UCODE_ID_CP_MEC_JT1_MASK;
> -
> -
> -	if (iceland_send_msg_to_smc_with_parameter_without_waiting(adev, PPSM=
C_MSG_LoadUcodes, fw_to_load)) {
> -		DRM_ERROR("Fail to request SMU load ucode\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -static int iceland_smu_check_fw_load_finish(struct amdgpu_device *adev=
,
> -					    uint32_t fw_type)
> -{
> -	uint32_t fw_mask =3D iceland_smu_get_mask_for_fw_type(fw_type);
> -	int i;
> -
> -	for (i =3D 0; i < adev->usec_timeout; i++) {
> -		if (fw_mask =3D=3D (RREG32_SMC(ixSOFT_REGISTERS_TABLE_27) & fw_mask)=
)
> -			break;
> -		udelay(1);
> -	}
> -
> -	if (i =3D=3D adev->usec_timeout) {
> -		DRM_ERROR("check firmware loading failed\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -int iceland_smu_start(struct amdgpu_device *adev)
> -{
> -	int result;
> -
> -	result =3D iceland_smu_upload_firmware_image(adev);
> -	if (result)
> -		return result;
> -	result =3D iceland_smu_start_smc(adev);
> -	if (result)
> -		return result;
> -
> -	return iceland_smu_request_load_fw(adev);
> -}
> -
> -static const struct amdgpu_smumgr_funcs iceland_smumgr_funcs =3D {
> -	.check_fw_load_finish =3D iceland_smu_check_fw_load_finish,
> -	.request_smu_load_fw =3D NULL,
> -	.request_smu_specific_fw =3D NULL,
> -};
> -
> -int iceland_smu_init(struct amdgpu_device *adev)
> -{
> -	struct iceland_smu_private_data *private;
> -	uint32_t image_size =3D ((sizeof(struct SMU_DRAMData_TOC) / 4096) + 1=
) * 4096;
> -	struct amdgpu_bo **toc_buf =3D &adev->smu.toc_buf;
> -	uint64_t mc_addr;
> -	void *toc_buf_ptr;
> -	int ret;
> -
> -	private =3D kzalloc(sizeof(struct iceland_smu_private_data), GFP_KERN=
EL);
> -	if (NULL =3D=3D private)
> -		return -ENOMEM;
> -
> -	/* allocate firmware buffers */
> -	if (adev->firmware.smu_load)
> -		amdgpu_ucode_init_bo(adev);
> -
> -	adev->smu.priv =3D private;
> -	adev->smu.fw_flags =3D 0;
> -
> -	/* Allocate FW image data structure and header buffer */
> -	ret =3D amdgpu_bo_create(adev, image_size, PAGE_SIZE,
> -			       true, AMDGPU_GEM_DOMAIN_VRAM,
> -			       AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED,
> -			       NULL, NULL, toc_buf);
> -	if (ret) {
> -		DRM_ERROR("Failed to allocate memory for TOC buffer\n");
> -		return -ENOMEM;
> -	}
> -
> -	/* Retrieve GPU address for header buffer and internal buffer */
> -	ret =3D amdgpu_bo_reserve(adev->smu.toc_buf, false);
> -	if (ret) {
> -		amdgpu_bo_unref(&adev->smu.toc_buf);
> -		DRM_ERROR("Failed to reserve the TOC buffer\n");
> -		return -EINVAL;
> -	}
> -
> -	ret =3D amdgpu_bo_pin(adev->smu.toc_buf, AMDGPU_GEM_DOMAIN_VRAM, &mc_=
addr);
> -	if (ret) {
> -		amdgpu_bo_unreserve(adev->smu.toc_buf);
> -		amdgpu_bo_unref(&adev->smu.toc_buf);
> -		DRM_ERROR("Failed to pin the TOC buffer\n");
> -		return -EINVAL;
> -	}
> -
> -	ret =3D amdgpu_bo_kmap(*toc_buf, &toc_buf_ptr);
> -	if (ret) {
> -		amdgpu_bo_unreserve(adev->smu.toc_buf);
> -		amdgpu_bo_unref(&adev->smu.toc_buf);
> -		DRM_ERROR("Failed to map the TOC buffer\n");
> -		return -EINVAL;
> -	}
> -
> -	amdgpu_bo_unreserve(adev->smu.toc_buf);
> -	private->header_addr_low =3D lower_32_bits(mc_addr);
> -	private->header_addr_high =3D upper_32_bits(mc_addr);
> -	private->header =3D toc_buf_ptr;
> -
> -	adev->smu.smumgr_funcs =3D &iceland_smumgr_funcs;
> -
> -	return 0;
> -}
> -
> -int iceland_smu_fini(struct amdgpu_device *adev)
> -{
> -	amdgpu_bo_unref(&adev->smu.toc_buf);
> -	kfree(adev->smu.priv);
> -	adev->smu.priv =3D NULL;
> -	if (adev->firmware.fw_buf)
> -		amdgpu_ucode_fini_bo(adev);
> -
> -	return 0;
> -}
> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_smum.h b/drivers/gpu/dr=
m/amd/amdgpu/iceland_smum.h
> deleted file mode 100644
> index 5983e31..0000000
> --- a/drivers/gpu/drm/amd/amdgpu/iceland_smum.h
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -/*
> - * Copyright 2014 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> - * copy of this software and associated documentation files (the "Soft=
ware"),
> - * to deal in the Software without restriction, including without limi=
tation
> - * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> - * and/or sell copies of the Software, and to permit persons to whom t=
he
> - * Software is furnished to do so, subject to the following conditions=
:
> - *
> - * The above copyright notice and this permission notice shall be incl=
uded in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - */
> -
> -#ifndef ICELAND_SMUM_H
> -#define ICELAND_SMUM_H
> -
> -#include "ppsmc.h"
> -
> -extern int iceland_smu_init(struct amdgpu_device *adev);
> -extern int iceland_smu_fini(struct amdgpu_device *adev);
> -extern int iceland_smu_start(struct amdgpu_device *adev);
> -
> -struct iceland_smu_private_data
> -{
> -	uint8_t *header;
> -	uint8_t *mec_image;
> -	uint32_t header_addr_high;
> -	uint32_t header_addr_low;
> -};
> -
> -#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_dpm.c b/drivers/gpu/drm/a=
md/amdgpu/tonga_dpm.c
> deleted file mode 100644
> index f06f6f4..0000000
> --- a/drivers/gpu/drm/amd/amdgpu/tonga_dpm.c
> +++ /dev/null
> @@ -1,186 +0,0 @@
> -/*
> - * Copyright 2014 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> - * copy of this software and associated documentation files (the "Soft=
ware"),
> - * to deal in the Software without restriction, including without limi=
tation
> - * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> - * and/or sell copies of the Software, and to permit persons to whom t=
he
> - * Software is furnished to do so, subject to the following conditions=
:
> - *
> - * The above copyright notice and this permission notice shall be incl=
uded in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - */
> -
> -#include <linux/firmware.h>
> -#include "drmP.h"
> -#include "amdgpu.h"
> -#include "tonga_smum.h"
> -
> -MODULE_FIRMWARE("amdgpu/tonga_smc.bin");
> -
> -static void tonga_dpm_set_funcs(struct amdgpu_device *adev);
> -
> -static int tonga_dpm_early_init(void *handle)
> -{
> -	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -
> -	tonga_dpm_set_funcs(adev);
> -
> -	return 0;
> -}
> -
> -static int tonga_dpm_init_microcode(struct amdgpu_device *adev)
> -{
> -	char fw_name[30] =3D "amdgpu/tonga_smc.bin";
> -	int err;
> -	err =3D request_firmware(&adev->pm.fw, fw_name, adev->dev);
> -	if (err)
> -		goto out;
> -	err =3D amdgpu_ucode_validate(adev->pm.fw);
> -
> -out:
> -	if (err) {
> -		DRM_ERROR("Failed to load firmware \"%s\"", fw_name);
> -		release_firmware(adev->pm.fw);
> -		adev->pm.fw =3D NULL;
> -	}
> -	return err;
> -}
> -
> -static int tonga_dpm_sw_init(void *handle)
> -{
> -	int ret;
> -	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -
> -	ret =3D tonga_dpm_init_microcode(adev);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> -}
> -
> -static int tonga_dpm_sw_fini(void *handle)
> -{
> -	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -
> -	release_firmware(adev->pm.fw);
> -	adev->pm.fw =3D NULL;
> -
> -	return 0;
> -}
> -
> -static int tonga_dpm_hw_init(void *handle)
> -{
> -	int ret;
> -	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -
> -	mutex_lock(&adev->pm.mutex);
> -
> -	/* smu init only needs to be called at startup, not resume.
> -	 * It should be in sw_init, but requires the fw info gathered
> -	 * in sw_init from other IP modules.
> -	 */
> -	ret =3D tonga_smu_init(adev);
> -	if (ret) {
> -		DRM_ERROR("SMU initialization failed\n");
> -		goto fail;
> -	}
> -
> -	ret =3D tonga_smu_start(adev);
> -	if (ret) {
> -		DRM_ERROR("SMU start failed\n");
> -		goto fail;
> -	}
> -
> -	mutex_unlock(&adev->pm.mutex);
> -	return 0;
> -
> -fail:
> -	adev->firmware.smu_load =3D false;
> -	mutex_unlock(&adev->pm.mutex);
> -	return -EINVAL;
> -}
> -
> -static int tonga_dpm_hw_fini(void *handle)
> -{
> -	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -
> -	mutex_lock(&adev->pm.mutex);
> -	/* smu fini only needs to be called at teardown, not suspend.
> -	 * It should be in sw_fini, but we put it here for symmetry
> -	 * with smu init.
> -	 */
> -	tonga_smu_fini(adev);
> -	mutex_unlock(&adev->pm.mutex);
> -	return 0;
> -}
> -
> -static int tonga_dpm_suspend(void *handle)
> -{
> -	return tonga_dpm_hw_fini(handle);
> -}
> -
> -static int tonga_dpm_resume(void *handle)
> -{
> -	return tonga_dpm_hw_init(handle);
> -}
> -
> -static int tonga_dpm_set_clockgating_state(void *handle,
> -			enum amd_clockgating_state state)
> -{
> -	return 0;
> -}
> -
> -static int tonga_dpm_set_powergating_state(void *handle,
> -			enum amd_powergating_state state)
> -{
> -	return 0;
> -}
> -
> -const struct amd_ip_funcs tonga_dpm_ip_funcs =3D {
> -	.name =3D "tonga_dpm",
> -	.early_init =3D tonga_dpm_early_init,
> -	.late_init =3D NULL,
> -	.sw_init =3D tonga_dpm_sw_init,
> -	.sw_fini =3D tonga_dpm_sw_fini,
> -	.hw_init =3D tonga_dpm_hw_init,
> -	.hw_fini =3D tonga_dpm_hw_fini,
> -	.suspend =3D tonga_dpm_suspend,
> -	.resume =3D tonga_dpm_resume,
> -	.is_idle =3D NULL,
> -	.wait_for_idle =3D NULL,
> -	.soft_reset =3D NULL,
> -	.set_clockgating_state =3D tonga_dpm_set_clockgating_state,
> -	.set_powergating_state =3D tonga_dpm_set_powergating_state,
> -};
> -
> -static const struct amdgpu_dpm_funcs tonga_dpm_funcs =3D {
> -	.get_temperature =3D NULL,
> -	.pre_set_power_state =3D NULL,
> -	.set_power_state =3D NULL,
> -	.post_set_power_state =3D NULL,
> -	.display_configuration_changed =3D NULL,
> -	.get_sclk =3D NULL,
> -	.get_mclk =3D NULL,
> -	.print_power_state =3D NULL,
> -	.debugfs_print_current_performance_level =3D NULL,
> -	.force_performance_level =3D NULL,
> -	.vblank_too_short =3D NULL,
> -	.powergate_uvd =3D NULL,
> -};
> -
> -static void tonga_dpm_set_funcs(struct amdgpu_device *adev)
> -{
> -	if (NULL =3D=3D adev->pm.funcs)
> -		adev->pm.funcs =3D &tonga_dpm_funcs;
> -}
> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_smc.c b/drivers/gpu/drm/a=
md/amdgpu/tonga_smc.c
> deleted file mode 100644
> index 1e71e81..0000000
> --- a/drivers/gpu/drm/amd/amdgpu/tonga_smc.c
> +++ /dev/null
> @@ -1,862 +0,0 @@
> -/*
> - * Copyright 2014 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> - * copy of this software and associated documentation files (the "Soft=
ware"),
> - * to deal in the Software without restriction, including without limi=
tation
> - * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> - * and/or sell copies of the Software, and to permit persons to whom t=
he
> - * Software is furnished to do so, subject to the following conditions=
:
> - *
> - * The above copyright notice and this permission notice shall be incl=
uded in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - */
> -
> -#include <linux/firmware.h>
> -#include "drmP.h"
> -#include "amdgpu.h"
> -#include "tonga_ppsmc.h"
> -#include "tonga_smum.h"
> -#include "smu_ucode_xfer_vi.h"
> -#include "amdgpu_ucode.h"
> -
> -#include "smu/smu_7_1_2_d.h"
> -#include "smu/smu_7_1_2_sh_mask.h"
> -
> -#define TONGA_SMC_SIZE 0x20000
> -
> -static int tonga_set_smc_sram_address(struct amdgpu_device *adev, uint=
32_t smc_address, uint32_t limit)
> -{
> -	uint32_t val;
> -
> -	if (smc_address & 3)
> -		return -EINVAL;
> -
> -	if ((smc_address + 3) > limit)
> -		return -EINVAL;
> -
> -	WREG32(mmSMC_IND_INDEX_0, smc_address);
> -
> -	val =3D RREG32(mmSMC_IND_ACCESS_CNTL);
> -	val =3D REG_SET_FIELD(val, SMC_IND_ACCESS_CNTL, AUTO_INCREMENT_IND_0,=
 0);
> -	WREG32(mmSMC_IND_ACCESS_CNTL, val);
> -
> -	return 0;
> -}
> -
> -static int tonga_copy_bytes_to_smc(struct amdgpu_device *adev, uint32_=
t smc_start_address, const uint8_t *src, uint32_t byte_count, uint32_t li=
mit)
> -{
> -	uint32_t addr;
> -	uint32_t data, orig_data;
> -	int result =3D 0;
> -	uint32_t extra_shift;
> -	unsigned long flags;
> -
> -	if (smc_start_address & 3)
> -		return -EINVAL;
> -
> -	if ((smc_start_address + byte_count) > limit)
> -		return -EINVAL;
> -
> -	addr =3D smc_start_address;
> -
> -	spin_lock_irqsave(&adev->smc_idx_lock, flags);
> -	while (byte_count >=3D 4) {
> -		/* Bytes are written into the SMC addres space with the MSB first */=

> -		data =3D (src[0] << 24) + (src[1] << 16) + (src[2] << 8) + src[3];
> -
> -		result =3D tonga_set_smc_sram_address(adev, addr, limit);
> -
> -		if (result)
> -			goto out;
> -
> -		WREG32(mmSMC_IND_DATA_0, data);
> -
> -		src +=3D 4;
> -		byte_count -=3D 4;
> -		addr +=3D 4;
> -	}
> -
> -	if (0 !=3D byte_count) {
> -		/* Now write odd bytes left, do a read modify write cycle */
> -		data =3D 0;
> -
> -		result =3D tonga_set_smc_sram_address(adev, addr, limit);
> -		if (result)
> -			goto out;
> -
> -		orig_data =3D RREG32(mmSMC_IND_DATA_0);
> -		extra_shift =3D 8 * (4 - byte_count);
> -
> -		while (byte_count > 0) {
> -			data =3D (data << 8) + *src++;
> -			byte_count--;
> -		}
> -
> -		data <<=3D extra_shift;
> -		data |=3D (orig_data & ~((~0UL) << extra_shift));
> -
> -		result =3D tonga_set_smc_sram_address(adev, addr, limit);
> -		if (result)
> -			goto out;
> -
> -		WREG32(mmSMC_IND_DATA_0, data);
> -	}
> -
> -out:
> -	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
> -	return result;
> -}
> -
> -static int tonga_program_jump_on_start(struct amdgpu_device *adev)
> -{
> -	static unsigned char data[] =3D {0xE0, 0x00, 0x80, 0x40};
> -	tonga_copy_bytes_to_smc(adev, 0x0, data, 4, sizeof(data)+1);
> -
> -	return 0;
> -}
> -
> -static bool tonga_is_smc_ram_running(struct amdgpu_device *adev)
> -{
> -	uint32_t val =3D RREG32_SMC(ixSMC_SYSCON_CLOCK_CNTL_0);
> -	val =3D REG_GET_FIELD(val, SMC_SYSCON_CLOCK_CNTL_0, ck_disable);
> -
> -	return ((0 =3D=3D val) && (0x20100 <=3D RREG32_SMC(ixSMC_PC_C)));
> -}
> -
> -static int wait_smu_response(struct amdgpu_device *adev)
> -{
> -	int i;
> -	uint32_t val;
> -
> -	for (i =3D 0; i < adev->usec_timeout; i++) {
> -		val =3D RREG32(mmSMC_RESP_0);
> -		if (REG_GET_FIELD(val, SMC_RESP_0, SMC_RESP))
> -			break;
> -		udelay(1);
> -	}
> -
> -	if (i =3D=3D adev->usec_timeout)
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
> -static int tonga_send_msg_to_smc_offset(struct amdgpu_device *adev)
> -{
> -	if (wait_smu_response(adev)) {
> -		DRM_ERROR("Failed to send previous message\n");
> -		return -EINVAL;
> -	}
> -
> -	WREG32(mmSMC_MSG_ARG_0, 0x20000);
> -	WREG32(mmSMC_MESSAGE_0, PPSMC_MSG_Test);
> -
> -	if (wait_smu_response(adev)) {
> -		DRM_ERROR("Failed to send message\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -static int tonga_send_msg_to_smc(struct amdgpu_device *adev, PPSMC_Msg=
 msg)
> -{
> -	if (!tonga_is_smc_ram_running(adev))
> -	{
> -		return -EINVAL;
> -	}
> -
> -	if (wait_smu_response(adev)) {
> -		DRM_ERROR("Failed to send previous message\n");
> -		return -EINVAL;
> -	}
> -
> -	WREG32(mmSMC_MESSAGE_0, msg);
> -
> -	if (wait_smu_response(adev)) {
> -		DRM_ERROR("Failed to send message\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -static int tonga_send_msg_to_smc_without_waiting(struct amdgpu_device =
*adev,
> -						PPSMC_Msg msg)
> -{
> -	if (wait_smu_response(adev)) {
> -		DRM_ERROR("Failed to send previous message\n");
> -		return -EINVAL;
> -	}
> -
> -	WREG32(mmSMC_MESSAGE_0, msg);
> -
> -	return 0;
> -}
> -
> -static int tonga_send_msg_to_smc_with_parameter(struct amdgpu_device *=
adev,
> -						PPSMC_Msg msg,
> -						uint32_t parameter)
> -{
> -	if (!tonga_is_smc_ram_running(adev))
> -		return -EINVAL;
> -
> -	if (wait_smu_response(adev)) {
> -		DRM_ERROR("Failed to send previous message\n");
> -		return -EINVAL;
> -	}
> -
> -	WREG32(mmSMC_MSG_ARG_0, parameter);
> -
> -	return tonga_send_msg_to_smc(adev, msg);
> -}
> -
> -static int tonga_send_msg_to_smc_with_parameter_without_waiting(
> -					struct amdgpu_device *adev,
> -					PPSMC_Msg msg, uint32_t parameter)
> -{
> -	if (wait_smu_response(adev)) {
> -		DRM_ERROR("Failed to send previous message\n");
> -		return -EINVAL;
> -	}
> -
> -	WREG32(mmSMC_MSG_ARG_0, parameter);
> -
> -	return tonga_send_msg_to_smc_without_waiting(adev, msg);
> -}
> -
> -#if 0 /* not used yet */
> -static int tonga_wait_for_smc_inactive(struct amdgpu_device *adev)
> -{
> -	int i;
> -	uint32_t val;
> -
> -	if (!tonga_is_smc_ram_running(adev))
> -		return -EINVAL;
> -
> -	for (i =3D 0; i < adev->usec_timeout; i++) {
> -		val =3D RREG32_SMC(ixSMC_SYSCON_CLOCK_CNTL_0);
> -		if (REG_GET_FIELD(val, SMC_SYSCON_CLOCK_CNTL_0, cken) =3D=3D 0)
> -			break;
> -		udelay(1);
> -	}
> -
> -	if (i =3D=3D adev->usec_timeout)
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -#endif
> -
> -static int tonga_smu_upload_firmware_image(struct amdgpu_device *adev)=

> -{
> -	const struct smc_firmware_header_v1_0 *hdr;
> -	uint32_t ucode_size;
> -	uint32_t ucode_start_address;
> -	const uint8_t *src;
> -	uint32_t val;
> -	uint32_t byte_count;
> -	uint32_t *data;
> -	unsigned long flags;
> -
> -	if (!adev->pm.fw)
> -		return -EINVAL;
> -
> -	/* Skip SMC ucode loading on SR-IOV capable boards.
> -	 * vbios does this for us in asic_init in that case.
> -	 */
> -	if (amdgpu_sriov_bios(adev))
> -		return 0;
> -
> -	hdr =3D (const struct smc_firmware_header_v1_0 *)adev->pm.fw->data;
> -	amdgpu_ucode_print_smc_hdr(&hdr->header);
> -
> -	adev->pm.fw_version =3D le32_to_cpu(hdr->header.ucode_version);
> -	ucode_size =3D le32_to_cpu(hdr->header.ucode_size_bytes);
> -	ucode_start_address =3D le32_to_cpu(hdr->ucode_start_addr);
> -	src =3D (const uint8_t *)
> -		(adev->pm.fw->data + le32_to_cpu(hdr->header.ucode_array_offset_byte=
s));
> -
> -	if (ucode_size & 3) {
> -		DRM_ERROR("SMC ucode is not 4 bytes aligned\n");
> -		return -EINVAL;
> -	}
> -
> -	if (ucode_size > TONGA_SMC_SIZE) {
> -		DRM_ERROR("SMC address is beyond the SMC RAM area\n");
> -		return -EINVAL;
> -	}
> -
> -	spin_lock_irqsave(&adev->smc_idx_lock, flags);
> -	WREG32(mmSMC_IND_INDEX_0, ucode_start_address);
> -
> -	val =3D RREG32(mmSMC_IND_ACCESS_CNTL);
> -	val =3D REG_SET_FIELD(val, SMC_IND_ACCESS_CNTL, AUTO_INCREMENT_IND_0,=
 1);
> -	WREG32(mmSMC_IND_ACCESS_CNTL, val);
> -
> -	byte_count =3D ucode_size;
> -	data =3D (uint32_t *)src;
> -	for (; byte_count >=3D 4; data++, byte_count -=3D 4)
> -		WREG32(mmSMC_IND_DATA_0, data[0]);
> -
> -	val =3D RREG32(mmSMC_IND_ACCESS_CNTL);
> -	val =3D REG_SET_FIELD(val, SMC_IND_ACCESS_CNTL, AUTO_INCREMENT_IND_0,=
 0);
> -	WREG32(mmSMC_IND_ACCESS_CNTL, val);
> -	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
> -
> -	return 0;
> -}
> -
> -#if 0 /* not used yet */
> -static int tonga_read_smc_sram_dword(struct amdgpu_device *adev,
> -				uint32_t smc_address,
> -				uint32_t *value,
> -				uint32_t limit)
> -{
> -	int result;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&adev->smc_idx_lock, flags);
> -	result =3D tonga_set_smc_sram_address(adev, smc_address, limit);
> -	if (result =3D=3D 0)
> -		*value =3D RREG32(mmSMC_IND_DATA_0);
> -	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
> -	return result;
> -}
> -
> -static int tonga_write_smc_sram_dword(struct amdgpu_device *adev,
> -				uint32_t smc_address,
> -				uint32_t value,
> -				uint32_t limit)
> -{
> -	int result;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&adev->smc_idx_lock, flags);
> -	result =3D tonga_set_smc_sram_address(adev, smc_address, limit);
> -	if (result =3D=3D 0)
> -		WREG32(mmSMC_IND_DATA_0, value);
> -	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
> -	return result;
> -}
> -
> -static int tonga_smu_stop_smc(struct amdgpu_device *adev)
> -{
> -	uint32_t val =3D RREG32_SMC(ixSMC_SYSCON_RESET_CNTL);
> -	val =3D REG_SET_FIELD(val, SMC_SYSCON_RESET_CNTL, rst_reg, 1);
> -	WREG32_SMC(ixSMC_SYSCON_RESET_CNTL, val);
> -
> -	val =3D RREG32_SMC(ixSMC_SYSCON_CLOCK_CNTL_0);
> -	val =3D REG_SET_FIELD(val, SMC_SYSCON_CLOCK_CNTL_0, ck_disable, 1);
> -	WREG32_SMC(ixSMC_SYSCON_CLOCK_CNTL_0, val);
> -
> -	return 0;
> -}
> -#endif
> -
> -static enum AMDGPU_UCODE_ID tonga_convert_fw_type(uint32_t fw_type)
> -{
> -	switch (fw_type) {
> -		case UCODE_ID_SDMA0:
> -			return AMDGPU_UCODE_ID_SDMA0;
> -		case UCODE_ID_SDMA1:
> -			return AMDGPU_UCODE_ID_SDMA1;
> -		case UCODE_ID_CP_CE:
> -			return AMDGPU_UCODE_ID_CP_CE;
> -		case UCODE_ID_CP_PFP:
> -			return AMDGPU_UCODE_ID_CP_PFP;
> -		case UCODE_ID_CP_ME:
> -			return AMDGPU_UCODE_ID_CP_ME;
> -		case UCODE_ID_CP_MEC:
> -		case UCODE_ID_CP_MEC_JT1:
> -			return AMDGPU_UCODE_ID_CP_MEC1;
> -		case UCODE_ID_CP_MEC_JT2:
> -			return AMDGPU_UCODE_ID_CP_MEC2;
> -		case UCODE_ID_RLC_G:
> -			return AMDGPU_UCODE_ID_RLC_G;
> -		default:
> -			DRM_ERROR("ucode type is out of range!\n");
> -			return AMDGPU_UCODE_ID_MAXIMUM;
> -	}
> -}
> -
> -static int tonga_smu_populate_single_firmware_entry(struct amdgpu_devi=
ce *adev,
> -						uint32_t fw_type,
> -						struct SMU_Entry *entry)
> -{
> -	enum AMDGPU_UCODE_ID id =3D tonga_convert_fw_type(fw_type);
> -	struct amdgpu_firmware_info *ucode =3D &adev->firmware.ucode[id];
> -	const struct gfx_firmware_header_v1_0 *header =3D NULL;
> -	uint64_t gpu_addr;
> -	uint32_t data_size;
> -
> -	if (ucode->fw =3D=3D NULL)
> -		return -EINVAL;
> -
> -	gpu_addr  =3D ucode->mc_addr;
> -	header =3D (const struct gfx_firmware_header_v1_0 *)ucode->fw->data;
> -	data_size =3D le32_to_cpu(header->header.ucode_size_bytes);
> -
> -	if ((fw_type =3D=3D UCODE_ID_CP_MEC_JT1) ||
> -		(fw_type =3D=3D UCODE_ID_CP_MEC_JT2)) {
> -		gpu_addr +=3D le32_to_cpu(header->jt_offset) << 2;
> -		data_size =3D le32_to_cpu(header->jt_size) << 2;
> -	}
> -
> -	entry->version =3D (uint16_t)le32_to_cpu(header->header.ucode_version=
);
> -	entry->id =3D (uint16_t)fw_type;
> -	entry->image_addr_high =3D upper_32_bits(gpu_addr);
> -	entry->image_addr_low =3D lower_32_bits(gpu_addr);
> -	entry->meta_data_addr_high =3D 0;
> -	entry->meta_data_addr_low =3D 0;
> -	entry->data_size_byte =3D data_size;
> -	entry->num_register_entries =3D 0;
> -
> -	if (fw_type =3D=3D UCODE_ID_RLC_G)
> -		entry->flags =3D 1;
> -	else
> -		entry->flags =3D 0;
> -
> -	return 0;
> -}
> -
> -static int tonga_smu_request_load_fw(struct amdgpu_device *adev)
> -{
> -	struct tonga_smu_private_data *private =3D (struct tonga_smu_private_=
data *)adev->smu.priv;
> -	struct SMU_DRAMData_TOC *toc;
> -	uint32_t fw_to_load;
> -
> -	WREG32_SMC(ixSOFT_REGISTERS_TABLE_28, 0);
> -
> -	tonga_send_msg_to_smc_with_parameter(adev, PPSMC_MSG_SMU_DRAM_ADDR_HI=
, private->smu_buffer_addr_high);
> -	tonga_send_msg_to_smc_with_parameter(adev, PPSMC_MSG_SMU_DRAM_ADDR_LO=
, private->smu_buffer_addr_low);
> -
> -	toc =3D (struct SMU_DRAMData_TOC *)private->header;
> -	toc->num_entries =3D 0;
> -	toc->structure_version =3D 1;
> -
> -	if (!adev->firmware.smu_load)
> -		return 0;
> -
> -	if (tonga_smu_populate_single_firmware_entry(adev, UCODE_ID_RLC_G,
> -			&toc->entry[toc->num_entries++])) {
> -		DRM_ERROR("Failed to get firmware entry for RLC\n");
> -		return -EINVAL;
> -	}
> -
> -	if (tonga_smu_populate_single_firmware_entry(adev, UCODE_ID_CP_CE,
> -			&toc->entry[toc->num_entries++])) {
> -		DRM_ERROR("Failed to get firmware entry for CE\n");
> -		return -EINVAL;
> -	}
> -
> -	if (tonga_smu_populate_single_firmware_entry(adev, UCODE_ID_CP_PFP,
> -			&toc->entry[toc->num_entries++])) {
> -		DRM_ERROR("Failed to get firmware entry for PFP\n");
> -		return -EINVAL;
> -	}
> -
> -	if (tonga_smu_populate_single_firmware_entry(adev, UCODE_ID_CP_ME,
> -			&toc->entry[toc->num_entries++])) {
> -		DRM_ERROR("Failed to get firmware entry for ME\n");
> -		return -EINVAL;
> -	}
> -
> -	if (tonga_smu_populate_single_firmware_entry(adev, UCODE_ID_CP_MEC,
> -			&toc->entry[toc->num_entries++])) {
> -		DRM_ERROR("Failed to get firmware entry for MEC\n");
> -		return -EINVAL;
> -	}
> -
> -	if (tonga_smu_populate_single_firmware_entry(adev, UCODE_ID_CP_MEC_JT=
1,
> -			&toc->entry[toc->num_entries++])) {
> -		DRM_ERROR("Failed to get firmware entry for MEC_JT1\n");
> -		return -EINVAL;
> -	}
> -
> -	if (tonga_smu_populate_single_firmware_entry(adev, UCODE_ID_CP_MEC_JT=
2,
> -			&toc->entry[toc->num_entries++])) {
> -		DRM_ERROR("Failed to get firmware entry for MEC_JT2\n");
> -		return -EINVAL;
> -	}
> -
> -	if (tonga_smu_populate_single_firmware_entry(adev, UCODE_ID_SDMA0,
> -			&toc->entry[toc->num_entries++])) {
> -		DRM_ERROR("Failed to get firmware entry for SDMA0\n");
> -		return -EINVAL;
> -	}
> -
> -	if (tonga_smu_populate_single_firmware_entry(adev, UCODE_ID_SDMA1,
> -			&toc->entry[toc->num_entries++])) {
> -		DRM_ERROR("Failed to get firmware entry for SDMA1\n");
> -		return -EINVAL;
> -	}
> -
> -	tonga_send_msg_to_smc_with_parameter(adev, PPSMC_MSG_DRV_DRAM_ADDR_HI=
, private->header_addr_high);
> -	tonga_send_msg_to_smc_with_parameter(adev, PPSMC_MSG_DRV_DRAM_ADDR_LO=
, private->header_addr_low);
> -
> -	fw_to_load =3D UCODE_ID_RLC_G_MASK |
> -			UCODE_ID_SDMA0_MASK |
> -			UCODE_ID_SDMA1_MASK |
> -			UCODE_ID_CP_CE_MASK |
> -			UCODE_ID_CP_ME_MASK |
> -			UCODE_ID_CP_PFP_MASK |
> -			UCODE_ID_CP_MEC_MASK;
> -
> -	if (tonga_send_msg_to_smc_with_parameter_without_waiting(adev, PPSMC_=
MSG_LoadUcodes, fw_to_load)) {
> -		DRM_ERROR("Fail to request SMU load ucode\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -static uint32_t tonga_smu_get_mask_for_fw_type(uint32_t fw_type)
> -{
> -	switch (fw_type) {
> -		case AMDGPU_UCODE_ID_SDMA0:
> -			return UCODE_ID_SDMA0_MASK;
> -		case AMDGPU_UCODE_ID_SDMA1:
> -			return UCODE_ID_SDMA1_MASK;
> -		case AMDGPU_UCODE_ID_CP_CE:
> -			return UCODE_ID_CP_CE_MASK;
> -		case AMDGPU_UCODE_ID_CP_PFP:
> -			return UCODE_ID_CP_PFP_MASK;
> -		case AMDGPU_UCODE_ID_CP_ME:
> -			return UCODE_ID_CP_ME_MASK;
> -		case AMDGPU_UCODE_ID_CP_MEC1:
> -			return UCODE_ID_CP_MEC_MASK;
> -		case AMDGPU_UCODE_ID_CP_MEC2:
> -			return UCODE_ID_CP_MEC_MASK;
> -		case AMDGPU_UCODE_ID_RLC_G:
> -			return UCODE_ID_RLC_G_MASK;
> -		default:
> -			DRM_ERROR("ucode type is out of range!\n");
> -			return 0;
> -	}
> -}
> -
> -static int tonga_smu_check_fw_load_finish(struct amdgpu_device *adev,
> -					uint32_t fw_type)
> -{
> -	uint32_t fw_mask =3D tonga_smu_get_mask_for_fw_type(fw_type);
> -	int i;
> -
> -	for (i =3D 0; i < adev->usec_timeout; i++) {
> -		if (fw_mask =3D=3D (RREG32_SMC(ixSOFT_REGISTERS_TABLE_28) & fw_mask)=
)
> -			break;
> -		udelay(1);
> -	}
> -
> -	if (i =3D=3D adev->usec_timeout) {
> -		DRM_ERROR("check firmware loading failed\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -static int tonga_smu_start_in_protection_mode(struct amdgpu_device *ad=
ev)
> -{
> -	int result;
> -	uint32_t val;
> -	int i;
> -
> -	/* Assert reset */
> -	val =3D RREG32_SMC(ixSMC_SYSCON_RESET_CNTL);
> -	val =3D REG_SET_FIELD(val, SMC_SYSCON_RESET_CNTL, rst_reg, 1);
> -	WREG32_SMC(ixSMC_SYSCON_RESET_CNTL, val);
> -
> -	result =3D tonga_smu_upload_firmware_image(adev);
> -	if (result)
> -		return result;
> -
> -	/* Clear status */
> -	WREG32_SMC(ixSMU_STATUS, 0);
> -
> -	/* Enable clock */
> -	val =3D RREG32_SMC(ixSMC_SYSCON_CLOCK_CNTL_0);
> -	val =3D REG_SET_FIELD(val, SMC_SYSCON_CLOCK_CNTL_0, ck_disable, 0);
> -	WREG32_SMC(ixSMC_SYSCON_CLOCK_CNTL_0, val);
> -
> -	/* De-assert reset */
> -	val =3D RREG32_SMC(ixSMC_SYSCON_RESET_CNTL);
> -	val =3D REG_SET_FIELD(val, SMC_SYSCON_RESET_CNTL, rst_reg, 0);
> -	WREG32_SMC(ixSMC_SYSCON_RESET_CNTL, val);
> -
> -	/* Set SMU Auto Start */
> -	val =3D RREG32_SMC(ixSMU_INPUT_DATA);
> -	val =3D REG_SET_FIELD(val, SMU_INPUT_DATA, AUTO_START, 1);
> -	WREG32_SMC(ixSMU_INPUT_DATA, val);
> -
> -	/* Clear firmware interrupt enable flag */
> -	WREG32_SMC(ixFIRMWARE_FLAGS, 0);
> -
> -	for (i =3D 0; i < adev->usec_timeout; i++) {
> -		val =3D RREG32_SMC(ixRCU_UC_EVENTS);
> -		if (REG_GET_FIELD(val, RCU_UC_EVENTS, INTERRUPTS_ENABLED))
> -			break;
> -		udelay(1);
> -	}
> -
> -	if (i =3D=3D adev->usec_timeout) {
> -		DRM_ERROR("Interrupt is not enabled by firmware\n");
> -		return -EINVAL;
> -	}
> -
> -	/* Call Test SMU message with 0x20000 offset
> -	 * to trigger SMU start
> -	 */
> -	tonga_send_msg_to_smc_offset(adev);
> -
> -	/* Wait for done bit to be set */
> -	for (i =3D 0; i < adev->usec_timeout; i++) {
> -		val =3D RREG32_SMC(ixSMU_STATUS);
> -		if (REG_GET_FIELD(val, SMU_STATUS, SMU_DONE))
> -			break;
> -		udelay(1);
> -	}
> -
> -	if (i =3D=3D adev->usec_timeout) {
> -		DRM_ERROR("Timeout for SMU start\n");
> -		return -EINVAL;
> -	}
> -
> -	/* Check pass/failed indicator */
> -	val =3D RREG32_SMC(ixSMU_STATUS);
> -	if (!REG_GET_FIELD(val, SMU_STATUS, SMU_PASS)) {
> -		DRM_ERROR("SMU Firmware start failed\n");
> -		return -EINVAL;
> -	}
> -
> -	/* Wait for firmware to initialize */
> -	for (i =3D 0; i < adev->usec_timeout; i++) {
> -		val =3D RREG32_SMC(ixFIRMWARE_FLAGS);
> -		if(REG_GET_FIELD(val, FIRMWARE_FLAGS, INTERRUPTS_ENABLED))
> -			break;
> -		udelay(1);
> -	}
> -
> -	if (i =3D=3D adev->usec_timeout) {
> -		DRM_ERROR("SMU firmware initialization failed\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -static int tonga_smu_start_in_non_protection_mode(struct amdgpu_device=
 *adev)
> -{
> -	int i, result;
> -	uint32_t val;
> -
> -	/* wait for smc boot up */
> -	for (i =3D 0; i < adev->usec_timeout; i++) {
> -		val =3D RREG32_SMC(ixRCU_UC_EVENTS);
> -		val =3D REG_GET_FIELD(val, RCU_UC_EVENTS, boot_seq_done);
> -		if (val)
> -			break;
> -		udelay(1);
> -	}
> -
> -	if (i =3D=3D adev->usec_timeout) {
> -		DRM_ERROR("SMC boot sequence is not completed\n");
> -		return -EINVAL;
> -	}
> -
> -	/* Clear firmware interrupt enable flag */
> -	WREG32_SMC(ixFIRMWARE_FLAGS, 0);
> -
> -	/* Assert reset */
> -	val =3D RREG32_SMC(ixSMC_SYSCON_RESET_CNTL);
> -	val =3D REG_SET_FIELD(val, SMC_SYSCON_RESET_CNTL, rst_reg, 1);
> -	WREG32_SMC(ixSMC_SYSCON_RESET_CNTL, val);
> -
> -	result =3D tonga_smu_upload_firmware_image(adev);
> -	if (result)
> -		return result;
> -
> -	/* Set smc instruct start point at 0x0 */
> -	tonga_program_jump_on_start(adev);
> -
> -	/* Enable clock */
> -	val =3D RREG32_SMC(ixSMC_SYSCON_CLOCK_CNTL_0);
> -	val =3D REG_SET_FIELD(val, SMC_SYSCON_CLOCK_CNTL_0, ck_disable, 0);
> -	WREG32_SMC(ixSMC_SYSCON_CLOCK_CNTL_0, val);
> -
> -	/* De-assert reset */
> -	val =3D RREG32_SMC(ixSMC_SYSCON_RESET_CNTL);
> -	val =3D REG_SET_FIELD(val, SMC_SYSCON_RESET_CNTL, rst_reg, 0);
> -	WREG32_SMC(ixSMC_SYSCON_RESET_CNTL, val);
> -
> -	/* Wait for firmware to initialize */
> -	for (i =3D 0; i < adev->usec_timeout; i++) {
> -		val =3D RREG32_SMC(ixFIRMWARE_FLAGS);
> -		if (REG_GET_FIELD(val, FIRMWARE_FLAGS, INTERRUPTS_ENABLED))
> -			break;
> -		udelay(1);
> -	}
> -
> -	if (i =3D=3D adev->usec_timeout) {
> -		DRM_ERROR("Timeout for SMC firmware initialization\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -int tonga_smu_start(struct amdgpu_device *adev)
> -{
> -	int result;
> -	uint32_t val;
> -
> -	if (!tonga_is_smc_ram_running(adev)) {
> -		val =3D RREG32_SMC(ixSMU_FIRMWARE);
> -		if (!REG_GET_FIELD(val, SMU_FIRMWARE, SMU_MODE)) {
> -			result =3D tonga_smu_start_in_non_protection_mode(adev);
> -			if (result)
> -				return result;
> -		} else {
> -			result =3D tonga_smu_start_in_protection_mode(adev);
> -			if (result)
> -				return result;
> -		}
> -	}
> -
> -	return tonga_smu_request_load_fw(adev);
> -}
> -
> -static const struct amdgpu_smumgr_funcs tonga_smumgr_funcs =3D {
> -	.check_fw_load_finish =3D tonga_smu_check_fw_load_finish,
> -	.request_smu_load_fw =3D NULL,
> -	.request_smu_specific_fw =3D NULL,
> -};
> -
> -int tonga_smu_init(struct amdgpu_device *adev)
> -{
> -	struct tonga_smu_private_data *private;
> -	uint32_t image_size =3D ((sizeof(struct SMU_DRAMData_TOC) / 4096) + 1=
) * 4096;
> -	uint32_t smu_internal_buffer_size =3D 200*4096;
> -	struct amdgpu_bo **toc_buf =3D &adev->smu.toc_buf;
> -	struct amdgpu_bo **smu_buf =3D &adev->smu.smu_buf;
> -	uint64_t mc_addr;
> -	void *toc_buf_ptr;
> -	void *smu_buf_ptr;
> -	int ret;
> -
> -	private =3D kzalloc(sizeof(struct tonga_smu_private_data), GFP_KERNEL=
);
> -	if (NULL =3D=3D private)
> -		return -ENOMEM;
> -
> -	/* allocate firmware buffers */
> -	if (adev->firmware.smu_load)
> -		amdgpu_ucode_init_bo(adev);
> -
> -	adev->smu.priv =3D private;
> -	adev->smu.fw_flags =3D 0;
> -
> -	/* Allocate FW image data structure and header buffer */
> -	ret =3D amdgpu_bo_create(adev, image_size, PAGE_SIZE,
> -			       true, AMDGPU_GEM_DOMAIN_VRAM,
> -			       AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED,
> -			       NULL, NULL, toc_buf);
> -	if (ret) {
> -		DRM_ERROR("Failed to allocate memory for TOC buffer\n");
> -		return -ENOMEM;
> -	}
> -
> -	/* Allocate buffer for SMU internal buffer */
> -	ret =3D amdgpu_bo_create(adev, smu_internal_buffer_size, PAGE_SIZE,
> -			       true, AMDGPU_GEM_DOMAIN_VRAM,
> -			       AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED,
> -			       NULL, NULL, smu_buf);
> -	if (ret) {
> -		DRM_ERROR("Failed to allocate memory for SMU internal buffer\n");
> -		return -ENOMEM;
> -	}
> -
> -	/* Retrieve GPU address for header buffer and internal buffer */
> -	ret =3D amdgpu_bo_reserve(adev->smu.toc_buf, false);
> -	if (ret) {
> -		amdgpu_bo_unref(&adev->smu.toc_buf);
> -		DRM_ERROR("Failed to reserve the TOC buffer\n");
> -		return -EINVAL;
> -	}
> -
> -	ret =3D amdgpu_bo_pin(adev->smu.toc_buf, AMDGPU_GEM_DOMAIN_VRAM, &mc_=
addr);
> -	if (ret) {
> -		amdgpu_bo_unreserve(adev->smu.toc_buf);
> -		amdgpu_bo_unref(&adev->smu.toc_buf);
> -		DRM_ERROR("Failed to pin the TOC buffer\n");
> -		return -EINVAL;
> -	}
> -
> -	ret =3D amdgpu_bo_kmap(*toc_buf, &toc_buf_ptr);
> -	if (ret) {
> -		amdgpu_bo_unreserve(adev->smu.toc_buf);
> -		amdgpu_bo_unref(&adev->smu.toc_buf);
> -		DRM_ERROR("Failed to map the TOC buffer\n");
> -		return -EINVAL;
> -	}
> -
> -	amdgpu_bo_unreserve(adev->smu.toc_buf);
> -	private->header_addr_low =3D lower_32_bits(mc_addr);
> -	private->header_addr_high =3D upper_32_bits(mc_addr);
> -	private->header =3D toc_buf_ptr;
> -
> -	ret =3D amdgpu_bo_reserve(adev->smu.smu_buf, false);
> -	if (ret) {
> -		amdgpu_bo_unref(&adev->smu.smu_buf);
> -		amdgpu_bo_unref(&adev->smu.toc_buf);
> -		DRM_ERROR("Failed to reserve the SMU internal buffer\n");
> -		return -EINVAL;
> -	}
> -
> -	ret =3D amdgpu_bo_pin(adev->smu.smu_buf, AMDGPU_GEM_DOMAIN_VRAM, &mc_=
addr);
> -	if (ret) {
> -		amdgpu_bo_unreserve(adev->smu.smu_buf);
> -		amdgpu_bo_unref(&adev->smu.smu_buf);
> -		amdgpu_bo_unref(&adev->smu.toc_buf);
> -		DRM_ERROR("Failed to pin the SMU internal buffer\n");
> -		return -EINVAL;
> -	}
> -
> -	ret =3D amdgpu_bo_kmap(*smu_buf, &smu_buf_ptr);
> -	if (ret) {
> -		amdgpu_bo_unreserve(adev->smu.smu_buf);
> -		amdgpu_bo_unref(&adev->smu.smu_buf);
> -		amdgpu_bo_unref(&adev->smu.toc_buf);
> -		DRM_ERROR("Failed to map the SMU internal buffer\n");
> -		return -EINVAL;
> -	}
> -
> -	amdgpu_bo_unreserve(adev->smu.smu_buf);
> -	private->smu_buffer_addr_low =3D lower_32_bits(mc_addr);
> -	private->smu_buffer_addr_high =3D upper_32_bits(mc_addr);
> -
> -	adev->smu.smumgr_funcs =3D &tonga_smumgr_funcs;
> -
> -	return 0;
> -}
> -
> -int tonga_smu_fini(struct amdgpu_device *adev)
> -{
> -	amdgpu_bo_unref(&adev->smu.toc_buf);
> -	amdgpu_bo_unref(&adev->smu.smu_buf);
> -	kfree(adev->smu.priv);
> -	adev->smu.priv =3D NULL;
> -	if (adev->firmware.fw_buf)
> -		amdgpu_ucode_fini_bo(adev);
> -
> -	return 0;
> -}
> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_smum.h b/drivers/gpu/drm/=
amd/amdgpu/tonga_smum.h
> deleted file mode 100644
> index c031ff9..0000000
> --- a/drivers/gpu/drm/amd/amdgpu/tonga_smum.h
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -/*
> - * Copyright 2014 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> - * copy of this software and associated documentation files (the "Soft=
ware"),
> - * to deal in the Software without restriction, including without limi=
tation
> - * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> - * and/or sell copies of the Software, and to permit persons to whom t=
he
> - * Software is furnished to do so, subject to the following conditions=
:
> - *
> - * The above copyright notice and this permission notice shall be incl=
uded in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - */
> -
> -#ifndef TONGA_SMUMGR_H
> -#define TONGA_SMUMGR_H
> -
> -#include "tonga_ppsmc.h"
> -
> -int tonga_smu_init(struct amdgpu_device *adev);
> -int tonga_smu_fini(struct amdgpu_device *adev);
> -int tonga_smu_start(struct amdgpu_device *adev);
> -
> -struct tonga_smu_private_data
> -{
> -	uint8_t *header;
> -	uint32_t smu_buffer_addr_high;
> -	uint32_t smu_buffer_addr_low;
> -	uint32_t header_addr_high;
> -	uint32_t header_addr_low;
> -};
> -
> -#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdg=
pu/vi.c
> index 4f74e4b..c0f8f20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -80,6 +80,9 @@
>  #include "amdgpu_powerplay.h"
>  #include "dce_virtual.h"
> =20
> +MODULE_FIRMWARE("amdgpu/topaz_smc.bin");
> +MODULE_FIRMWARE("amdgpu/tonga_smc.bin");
> +MODULE_FIRMWARE("amdgpu/fiji_smc.bin");
>  MODULE_FIRMWARE("amdgpu/polaris10_smc.bin");
>  MODULE_FIRMWARE("amdgpu/polaris10_smc_sk.bin");
>  MODULE_FIRMWARE("amdgpu/polaris11_smc.bin");
>=20


--LFRMbx76ghWx0vT2sKQETFRcvrbA3sNOh--

--1BN31V6g3FaLtRRHMvn5de8Vxskak7xfC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX39reAAoJEP4bvbfZuWjblgUP/0c785dx7Wjd5QDBGcKY+P0f
v78VDLr1F/gtNVu8aHY3LiXO0+IhJBAx7igdOEEHXfcIEOSfIN+FC+moI1r5Uqlt
HCnZCXiaQe5P72dx5A4TMyc7fRreY384EO/H97f/i7mfZKLwpH5pdFIdtaKPssGa
EDMTVffS0887gjhh7kMhS0z5eLoCFbGFqqn5isI3ElBgc+HSS7CBsvX8kw4X8/yT
0lqDZxUdC637XrTKwzne1ClsiErDANr/FZrDDdv21Ecc26QedZ+xtZdTPkp+e/M6
2FG9n7fyIdpbWKwdv8qwtEfoU+5dQ+TkTklDRUj7ZSfV45IwhLQcEIAN/Ngso5Zb
f8ziSE9kkdlzGw55/DGw4Pl3lZe5DCID2g+QOkwPrvuolByn5LF5KRdRbUH5gMTV
TwwPadydSyuiubfLM0MdxupN+H3uMsKBVWXTm6YW7zZ8BadoiPAN4fRPkQmWjgzQ
/xF3Q6HgVjXB60vaoXt5XnQ6utrR8llzJ/cAXTAQLFLBzPi+2bqoC59MEueX2PYP
Te1DsFxYhQ2DuGx7v1lFTb0kvWvhIXWDDCmMnY4QUEoVaK8vwh2J7glQCTENRdSZ
vl+VhAO0XKvh4Sfjsgmk8Dn1lZ+KGJoOWq0JCeFc35lVCijPRU09/GB/l4Onps/g
DPjjbAFpnUwi4W31DMOj
=MZtW
-----END PGP SIGNATURE-----

--1BN31V6g3FaLtRRHMvn5de8Vxskak7xfC--

--===============2099142407==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2099142407==--
