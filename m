Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E627B606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q5PrGvu/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B41610E272;
	Tue, 17 Nov 2026 15:17:42 +0000 (UTC)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA67010E272
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 15:17:36 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id
 5614622812f47-4b2b01478d0so195316b6e.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 07:17:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794928656; cv=none;
 d=google.com; s=arc-20260327;
 b=DMOCPE+SzPUh8YyysYje6BIC1X9ZqyNujfIfENbnQWBVSXfIVF39Djeh8v+aOoS//h
 gZkA06TJoYhpLlMvYlI2as9jCygTWqebC7+sNwCatSyU8RNLO2X+R7fvkOepd5dlA07e
 pN67exrF2F68KxY1S9jK+woVYuRgVoJH+QbnQNZqKPASGZ57u62q0npU+cFsV20tmAEF
 Ll5ex2r1PGJ/73KEMqNieFbjaz9oH4lf2Ena+feXtT9q72S4umMwEB66da1w4UARl80K
 NmiuqTcwH+FbbGehJEIlaRl5DU3fX2+jb0gJDTC8eDqsO5LjxBqpLfGK/DpBqVkHCaGr
 AIjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5ldmPrLAb02VGp5P2WMUkuS+PH54xTbStpjqlD3U4Mc=;
 fh=U3kLvFgdKDRkgbSWknNqrNAnj6PCBG9LbqtLadTSu8c=;
 b=WkCbJHjiqTSYiRMtuZyc2+aUvo4NDzg4TxqnWbYH7YB31yTd4S52RFGWTR+KNbFOrq
 JlXKGPc5mMNJ7yVmLHcWphokNgIK0a6QlP/dE0REvS3gxSgEHvBzEM8AZoXPUr4IqX7f
 KrmCJcKWnIkdOfYetxecnAjfrFcDfww1mMqD3OACs+GkNh2/xtUPwubGetGJ7gdT4hgp
 VQ28f28uszbMYm/vBc9sTW3Cs3Rhm6WK1i9vBaXAZLOqE0UE2+VO6uKtnrzJ5iYy/iaa
 RLkIX9jGgNZwL8O5rsZNVPN8gn43q3fonTywhWaAlx2IpvxqO8DB3qX+WDlhEQsA+ygn
 T4+A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794928656; x=1795533456; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5ldmPrLAb02VGp5P2WMUkuS+PH54xTbStpjqlD3U4Mc=;
 b=Q5PrGvu/DvmMQyj/GHDWaInCjlcFjHymtgmYSTilEqyXWD/y0oOlGK8P3yOWCq6nqT
 VWH3rsoWn8ISp+MVTM7lFpKGFLiCZUAICxHOoB9EVVy+QFEk/0e0TgR/57jPY78V1pFs
 LCzGbNk7rosG7ZWDxczhkV729oLvpnvmAR/dfcveersXgUGgE9On/3u2Vt3Rb/u6H4J8
 B9Bl+U6n/QjxQQSsK8cJLk5UczfUA2rpGyWhC1BoN7WTul04UJMKWHl3/HzzO+AptY1/
 ybvFUeUG2zpFiYt0/3E35WSJl888rU069045IdmSOhDkjI6GyBJ1PZbghxAVC6A/1RT5
 bpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794928656; x=1795533456;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5ldmPrLAb02VGp5P2WMUkuS+PH54xTbStpjqlD3U4Mc=;
 b=U2XUgW0YbpGE9YGLetvdiL0Z32dsiUPCMKS/Rzh6rvCl/Ol87pqlaN85YA83MlTOlq
 wKreIrWLyC+OD9s6gK7zhYpG9bzg71L7js+tU7KWu2vkB5okDz76rBRtrbbTPehgb+zD
 JYy7w/w73AS6vjBJOQMdOYmAxbQLGRuJXQ+hnV7FvrRSblbTN5lNfTTAqaXkab4C2CgN
 yhKKpWiz1djm3AnXrdCMc/88kak9Uy/2K8/YR+i/sVZR+f8JgIl1dWRg3fUJ9sVxL41A
 tFQ1KRwy32LRS6rWI1X9T6X/41eyse7qIlMXWnvkk87ccVmeCzaXlNjW7wUR/eFq+BAL
 AdiQ==
X-Gm-Message-State: APuU4Z9x8Q1pG+yhE3na9aij23iVNtsr7KGuJytFIXDxURP+QEliWhrd
 kiTw9imrxPMrrgi76FDM5UFWtBq/8vpDU6/MQaSoT1bT2/DoI3EFcIQTHCG1m35VhnHpdXPd8KZ
 30P6D79nh9/mcURAcj1hHZzh11bkg7cQ=
X-Gm-Gg: AYBFou0KKvdEt91jzsarmzdN6SAEPJLxRoO/yv7r3WV+jDQDQFwHC7y4zaZ80NW8RJp
 Kq9k5xCeDJcu+S7QWDFc8Y0Mnl8aiK14nTKQ6Kxwy6EnPHgJ24VVWLZwWuTYDZD2fuSwZ0W4mEb
 8vTu7oDQb8DR/8GnKWDvjiMHqHf1T13beffWgOzmx/jN1YS8PuZpWFkmYXNpDJu27n0CSFhHj6k
 DfDgG/R8RHLSi0PUJuyGBmm0nWmZySxrwGmww+O2mP69nnm6tCC2NMs0Gc6cmHKkpGt5Ox0BbhS
 jTX/xPXqY/1KS5kjiOgDLc7VZFZ4tMXGDBOywJJB9FfX/byU4hI9uwELmBlvqX/9nBBNgCV1rY+
 zf2lAOERUXcfC5QXGDY8lGKwKyia1JheiTdaaXuWpNypmc2mRHeSKb0qlj68ZT8kdW+FnqG6B7l
 2J4Xz+rdSJ2orWhqQjqoTwka1wFYtZVeh6LDV4NTJnR6vSzEjwmWm1SL6yFf9A
X-Received: by 2002:a05:6809:8c:10b0:574:6f37:6720 with SMTP id
 5614622812f47-5746f3797aemr5820678b6e.2.1794928656058; Tue, 17 Nov 2026
 07:17:36 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109184641.3656885-1-alexander.deucher@amd.com>
 <20261109184641.3656885-2-alexander.deucher@amd.com>
In-Reply-To: <20261109184641.3656885-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Nov 2026 10:17:24 -0500
X-Gm-Features: AclHuK-7_IvRMVCQ3od45xEU_rvtZ-0il5QfIw6Hxli9_1lftdvXsF8x6Jw0D9U
Message-ID: <CADnq5_PHx1+TQ-JwSzXNhCsEicnsL0Px1jypyxcGbLU0JScqvA@mail.gmail.com>
Subject: Re: [PATCH 1/8] drm/amdgpu: Add imu v13 ip block v2
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Frank Min <Frank.Min@amd.com>, 
 Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 9, 2026 at 2:06=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> From: Frank Min <Frank.Min@amd.com>
>
> Add imu v13 ip block.
> V2: clean up code.
>
> Signed-off-by: Frank Min <Frank.Min@amd.com>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Likun Gao <Likun.Gao@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Patches 1-3, 5-8:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile    |   3 +-
>  drivers/gpu/drm/amd/amdgpu/imu_v13_0.c | 288 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/imu_v13_0.h |  29 +++
>  3 files changed, 319 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/imu_v13_0.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/imu_v13_0.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/am=
dgpu/Makefile
> index 2f708710e020a..92236baf43498 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -170,7 +170,8 @@ amdgpu-y +=3D \
>         gfx_v12_0.o \
>         gfx_v12_1.o \
>         imu_v12_0.o \
> -       imu_v12_1.o
> +       imu_v12_1.o \
> +       imu_v13_0.o
>
>  # add async DMA block
>  amdgpu-y +=3D \
> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v13_0.c b/drivers/gpu/drm/amd=
/amdgpu/imu_v13_0.c
> new file mode 100644
> index 0000000000000..aea418be444a0
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v13_0.c
> @@ -0,0 +1,288 @@
> +/*
> + * Copyright 2025 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include <linux/firmware.h>
> +#include "amdgpu.h"
> +#include "amdgpu_imu.h"
> +#include "amdgpu_dpm.h"
> +
> +#include "imu_v13_0.h"
> +
> +#include "gc/gc_13_0_1_offset.h"
> +#include "gc/gc_13_0_1_sh_mask.h"
> +#include "mmhub/mmhub_5_0_1_offset.h"
> +
> +MODULE_FIRMWARE("amdgpu/gc_13_0_1_imu.bin");
> +
> +#define TRANSFER_RAM_MASK      0x001c0000
> +
> +static int imu_v13_0_init_microcode(struct amdgpu_device *adev)
> +{
> +       char ucode_prefix[15];
> +       int err;
> +       const struct imu_firmware_header_v1_0 *imu_hdr;
> +       struct amdgpu_firmware_info *info =3D NULL;
> +
> +       DRM_DEBUG("\n");
> +
> +       amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeo=
f(ucode_prefix));
> +       err =3D amdgpu_ucode_request(adev, &adev->gfx.imu_fw, AMDGPU_UCOD=
E_REQUIRED,
> +                                  "amdgpu/%s_imu.bin", ucode_prefix);
> +       if (err)
> +               goto out;
> +
> +       imu_hdr =3D (const struct imu_firmware_header_v1_0 *)adev->gfx.im=
u_fw->data;
> +       adev->gfx.imu_fw_version =3D le32_to_cpu(imu_hdr->header.ucode_ve=
rsion);
> +
> +       if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
> +               info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_IMU_I];
> +               info->ucode_id =3D AMDGPU_UCODE_ID_IMU_I;
> +               info->fw =3D adev->gfx.imu_fw;
> +               adev->firmware.fw_size +=3D
> +                       ALIGN(le32_to_cpu(imu_hdr->imu_iram_ucode_size_by=
tes), PAGE_SIZE);
> +               info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_IMU_D];
> +               info->ucode_id =3D AMDGPU_UCODE_ID_IMU_D;
> +               info->fw =3D adev->gfx.imu_fw;
> +               adev->firmware.fw_size +=3D
> +                       ALIGN(le32_to_cpu(imu_hdr->imu_dram_ucode_size_by=
tes), PAGE_SIZE);
> +       }
> +
> +out:
> +       if (err) {
> +               dev_err(adev->dev,
> +                       "gfx13: Failed to load firmware \"%s_imu.bin\"\n"=
,
> +                       ucode_prefix);
> +               amdgpu_ucode_release(&adev->gfx.imu_fw);
> +       }
> +
> +       return err;
> +}
> +
> +static int imu_v13_0_load_microcode(struct amdgpu_device *adev)
> +{
> +       const struct imu_firmware_header_v1_0 *hdr;
> +       const __le32 *fw_data;
> +       unsigned i, fw_size;
> +
> +       if (!adev->gfx.imu_fw)
> +               return -EINVAL;
> +
> +       hdr =3D (const struct imu_firmware_header_v1_0 *)adev->gfx.imu_fw=
->data;
> +
> +       fw_data =3D (const __le32 *)(adev->gfx.imu_fw->data +
> +                       le32_to_cpu(hdr->header.ucode_array_offset_bytes)=
);
> +       fw_size =3D le32_to_cpu(hdr->imu_iram_ucode_size_bytes) / 4;
> +
> +       WREG32_SOC15(GC, 0, regGFX_IMU_I_RAM_ADDR, 0);
> +
> +       for (i =3D 0; i < fw_size; i++)
> +               WREG32_SOC15(GC, 0, regGFX_IMU_I_RAM_DATA, le32_to_cpup(f=
w_data++));
> +
> +       WREG32_SOC15(GC, 0, regGFX_IMU_I_RAM_ADDR, adev->gfx.imu_fw_versi=
on);
> +
> +       fw_data =3D (const __le32 *)(adev->gfx.imu_fw->data +
> +                       le32_to_cpu(hdr->header.ucode_array_offset_bytes)=
 +
> +                       le32_to_cpu(hdr->imu_iram_ucode_size_bytes));
> +       fw_size =3D le32_to_cpu(hdr->imu_dram_ucode_size_bytes) / 4;
> +
> +       WREG32_SOC15(GC, 0, regGFX_IMU_D_RAM_ADDR, 0);
> +
> +       for (i =3D 0; i < fw_size; i++)
> +               WREG32_SOC15(GC, 0, regGFX_IMU_D_RAM_DATA, le32_to_cpup(f=
w_data++));
> +
> +       WREG32_SOC15(GC, 0, regGFX_IMU_D_RAM_ADDR, adev->gfx.imu_fw_versi=
on);
> +
> +       return 0;
> +}
> +
> +static int imu_v13_0_wait_for_reset_status(struct amdgpu_device *adev)
> +{
> +       u32 imu_reg_val =3D 0;
> +       int i;
> +
> +       for (i =3D 0; i < adev->usec_timeout; i++) {
> +               imu_reg_val =3D RREG32_SOC15(GC, 0, regGFX_IMU_GFX_RESET_=
CTRL);
> +               if ((imu_reg_val & 0x1f) =3D=3D 0x1f)
> +                       break;
> +               udelay(1);
> +       }
> +
> +       if (i >=3D adev->usec_timeout) {
> +               dev_err(adev->dev, "init imu: IMU start timeout\n");
> +               return -ETIMEDOUT;
> +       }
> +
> +       return 0;
> +}
> +
> +static void imu_v13_0_setup(struct amdgpu_device *adev)
> +{
> +       u32 imu_reg_val;
> +
> +       WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_ACCESS_CTRL0, 0xffffff);
> +       WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_ACCESS_CTRL1, 0xffff);
> +
> +       if (adev->gfx.imu.mode =3D=3D DEBUG_MODE) {
> +               imu_reg_val =3D RREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_16)=
;
> +               imu_reg_val |=3D 0x1;
> +               WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_16, imu_reg_val);
> +
> +               imu_reg_val =3D RREG32_SOC15(GC, 0, regGFX_IMU_SCRATCH_10=
);
> +               imu_reg_val |=3D 0x10007;
> +               WREG32_SOC15(GC, 0, regGFX_IMU_SCRATCH_10, imu_reg_val);
> +
> +       }
> +}
> +
> +static int imu_v13_0_start(struct amdgpu_device *adev)
> +{
> +       u32 imu_reg_val;
> +
> +       imu_reg_val =3D RREG32_SOC15(GC, 0, regGFX_IMU_CORE_CTRL);
> +       imu_reg_val &=3D 0xfffffffe;
> +       WREG32_SOC15(GC, 0, regGFX_IMU_CORE_CTRL, imu_reg_val);
> +
> +       if (adev->flags & AMD_IS_APU)
> +               amdgpu_dpm_set_gfx_power_up_by_imu(adev);
> +
> +       return imu_v13_0_wait_for_reset_status(adev);
> +}
> +
> +static u32 imu_v13_0_grbm_gfx_index_remap(struct amdgpu_device *adev,
> +                                         u32 data, bool high)
> +{
> +       u32 val, inst_index;
> +
> +       inst_index =3D REG_GET_FIELD(data, GRBM_GFX_INDEX, INSTANCE_INDEX=
);
> +
> +       if (high)
> +               val =3D inst_index >> 5;
> +       else
> +               val =3D REG_GET_FIELD(data, GRBM_GFX_INDEX, SE_BROADCAST_=
WRITES) << 18 |
> +                     REG_GET_FIELD(data, GRBM_GFX_INDEX, SA_BROADCAST_WR=
ITES) << 19 |
> +                     REG_GET_FIELD(data, GRBM_GFX_INDEX, INSTANCE_BROADC=
AST_WRITES) << 20 |
> +                     REG_GET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX) << 21=
 |
> +                     REG_GET_FIELD(data, GRBM_GFX_INDEX, SA_INDEX) << 25=
 |
> +                     (inst_index & 0x1f);
> +
> +       return val;
> +}
> +
> +static u32 imu_v13_init_gfxhub_settings(struct amdgpu_device *adev,
> +                                       u32 reg, u32 data)
> +{
> +       if (reg =3D=3D SOC15_REG_OFFSET(GC, 0, regGCMC_VM_FB_LOCATION_BAS=
E))
> +               return RREG32_SOC15(MMHUB, 0, regMMMC_VM_FB_LOCATION_BASE=
);
> +       else if (reg =3D=3D SOC15_REG_OFFSET(GC, 0, regGCMC_VM_FB_LOCATIO=
N_TOP))
> +               return RREG32_SOC15(MMHUB, 0, regMMMC_VM_FB_LOCATION_TOP)=
;
> +       else if (reg =3D=3D SOC15_REG_OFFSET(GC, 0, regGCMC_VM_FB_OFFSET)=
)
> +               return RREG32_SOC15(MMHUB, 0, regMMMC_VM_FB_OFFSET);
> +       else if (reg =3D=3D SOC15_REG_OFFSET(GC, 0, regGCMC_VM_AGP_BASE))
> +               return RREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE);
> +       else if (reg =3D=3D SOC15_REG_OFFSET(GC, 0, regGCMC_VM_AGP_BOT))
> +               return RREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT);
> +       else if (reg =3D=3D SOC15_REG_OFFSET(GC, 0, regGCMC_VM_AGP_TOP))
> +               return RREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP);
> +       else if (reg =3D=3D SOC15_REG_OFFSET(GC, 0, regGCMC_VM_MX_L1_TLB_=
CNTL))
> +               return RREG32_SOC15(MMHUB, 0, regMMMC_VM_MX_L1_TLB_CNTL);
> +       else if (reg =3D=3D SOC15_REG_OFFSET(GC, 0, regGCMC_VM_SYSTEM_APE=
RTURE_LOW_ADDR))
> +               return RREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_=
LOW_ADDR);
> +       else if (reg =3D=3D SOC15_REG_OFFSET(GC, 0, regGCMC_VM_SYSTEM_APE=
RTURE_HIGH_ADDR))
> +               return RREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_=
HIGH_ADDR);
> +       else if (reg =3D=3D SOC15_REG_OFFSET(GC, 0, regGCMC_VM_LOCAL_FB_A=
DDRESS_START))
> +               return RREG32_SOC15(MMHUB, 0, regMMMC_VM_LOCAL_FB_ADDRESS=
_START);
> +       else if (reg =3D=3D SOC15_REG_OFFSET(GC, 0, regGCMC_VM_LOCAL_FB_A=
DDRESS_END))
> +               return RREG32_SOC15(MMHUB, 0, regMMMC_VM_LOCAL_FB_ADDRESS=
_END);
> +       else if (reg =3D=3D SOC15_REG_OFFSET(GC, 0, regGCMC_VM_LOCAL_SYSM=
EM_ADDRESS_START))
> +               return RREG32_SOC15(MMHUB, 0, regMMMC_VM_LOCAL_SYSMEM_ADD=
RESS_START);
> +       else if (reg =3D=3D SOC15_REG_OFFSET(GC, 0, regGCMC_VM_LOCAL_SYSM=
EM_ADDRESS_END))
> +               return RREG32_SOC15(MMHUB, 0, regMMMC_VM_LOCAL_SYSMEM_ADD=
RESS_END);
> +       else if (reg =3D=3D SOC15_REG_OFFSET(GC, 0, regGCMC_VM_SYSTEM_APE=
RTURE_DEFAULT_ADDR_LSB))
> +               return RREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_=
DEFAULT_ADDR_LSB);
> +       else if (reg =3D=3D SOC15_REG_OFFSET(GC, 0, regGCMC_VM_SYSTEM_APE=
RTURE_DEFAULT_ADDR_MSB))
> +               return RREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_=
DEFAULT_ADDR_MSB);
> +       else
> +               return data;
> +}
> +
> +static void program_imu_rlc_ram(struct amdgpu_device *adev,
> +                               const u32 *regs,
> +                               const u32 array_size)
> +{
> +       u32 reg, data, val_h =3D 0, val_l =3D TRANSFER_RAM_MASK;
> +       int i;
> +
> +       if (array_size % 3)
> +               return;
> +
> +       for (i =3D 0; i < array_size; i +=3D 3) {
> +               reg =3D regs[i + 0];
> +               data =3D regs[i + 2];
> +               data =3D imu_v13_init_gfxhub_settings(adev, reg, data);
> +               if (reg =3D=3D SOC15_REG_OFFSET(GC, 0, regGRBM_GFX_INDEX)=
) {
> +                       val_l =3D imu_v13_0_grbm_gfx_index_remap(adev, da=
ta, false);
> +                       val_h =3D imu_v13_0_grbm_gfx_index_remap(adev, da=
ta, true);
> +               } else {
> +                       WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_HIGH,=
 val_h);
> +                       WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_LOW, =
reg | val_l);
> +                       WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_DATA, data=
);
> +               }
> +       }
> +}
> +
> +static void imu_v13_0_program_rlc_ram(struct amdgpu_device *adev)
> +{
> +       u32 reg_data, size =3D 0;
> +       const u32 *data;
> +       int r =3D -EINVAL;
> +
> +       WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_INDEX, 0x2);
> +
> +       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +       case IP_VERSION(13, 0, 1):
> +               if (!r)
> +                       program_imu_rlc_ram(adev, data, (const u32)size);
> +               break;
> +       default:
> +               BUG();
> +               break;
> +       }
> +
> +       //Indicate the latest entry
> +       WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_HIGH, 0);
> +       WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_LOW, 0);
> +       WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_DATA, 0);
> +
> +       reg_data =3D RREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_INDEX);
> +       reg_data |=3D GFX_IMU_RLC_RAM_INDEX__RAM_VALID_MASK;
> +       WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_INDEX, reg_data);
> +}
> +
> +const struct amdgpu_imu_funcs gfx_v13_0_imu_funcs =3D {
> +       .init_microcode =3D imu_v13_0_init_microcode,
> +       .load_microcode =3D imu_v13_0_load_microcode,
> +       .setup_imu =3D imu_v13_0_setup,
> +       .start_imu =3D imu_v13_0_start,
> +       .program_rlc_ram =3D imu_v13_0_program_rlc_ram,
> +       .wait_for_reset_status =3D imu_v13_0_wait_for_reset_status,
> +};
> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v13_0.h b/drivers/gpu/drm/amd=
/amdgpu/imu_v13_0.h
> new file mode 100644
> index 0000000000000..83f041d8cd34d
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v13_0.h
> @@ -0,0 +1,29 @@
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __IMU_V13_0_H__
> +#define __IMU_V13_0_H__
> +
> +extern const struct amdgpu_imu_funcs gfx_v13_0_imu_funcs;
> +
> +#endif
> --
> 2.56.0
>
