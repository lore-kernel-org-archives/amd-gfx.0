Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC00EC10F1A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 15:35:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 503D710EA43;
	Thu,  9 May 2024 15:35:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FjZMXxU/";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3906810E654
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 15:35:37 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-1ee5235f5c9so8213625ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 May 2024 08:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715268936; x=1715873736; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h6Pdgytl9XveXK3dz4UfAUZBUOOMqNe0C+D0xD5btIc=;
 b=FjZMXxU/Bq48QPs1tk1qQDQWB18h42GGsiav9RXKeko7l4EbbqFqF/NdIv78tVBReP
 WuL7AwjdWA5G6CTicrzAPqR5jAoJ2U1S+AEsXNvBfQHASZW7GuRodc9yBgt1Vf8TKc1R
 ez7AEDq8UY3c8+HqVywU+IiqpZzPoB2OxqupvwRoWFctRpz1cGTOSqsMTGrs4ntGFGtE
 LT7RjgdieGU8w58uoutXrGnGHZFqYyhSVnW+/uep+TVI96uKfAZeTMxYXxZlIufppu2D
 ei2eZtwzrT4wq4DJwFN4rkaOKbefqxHePvRU2UGbQBdul3dDmbp+eFo5kfmJHHNYVzsk
 lsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715268936; x=1715873736;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h6Pdgytl9XveXK3dz4UfAUZBUOOMqNe0C+D0xD5btIc=;
 b=j1WYWSimtdN8PzPsFynrwEeRiUc1JNcfkbRrsYPOTTZdSlRN5rgBtwvQFdsIOyW1Xk
 mpzdsy6gyhRbH3z5uSWDu0WhpJbDz18hZbivUU1BFwa6hW8oY/92JRKeGwEKeFmg225K
 1zOAI5qAfBX4XoQU9HUpBFyhLJcwVspSifkXSEbW2xRbQCJ2PApV0XhPsXPCSmdKzOjH
 MrN3RUyMXvju+VwHvKLeJN16QjM2ZbcOwcCIz5w2iJuVgT5NfiOVTqFFIb6U5ytOnfdP
 k4wJsDAgVD8j9HiaxTq+CQCHD4Vqn/eAwbI3dpAOK4rprxAHWENbgxtGeze0SCJIYj5I
 Y4SQ==
X-Gm-Message-State: AOJu0YyWCMAuAIFAEYUvYG4Zy8rZ5d7mFQQYzWqwyu7v6rCwGqdd64ev
 H4m4n/EbInyW4NVM+Qwa3VQyIP859o10GSks7s3RZOtNzGthFY5Pgwkk72ci4Y3sRh2AvdMBWzu
 +qoOrbEwutcroAU8R8O3AXayk3oo=
X-Google-Smtp-Source: AGHT+IHnoAc382d7e5i8b48IYqhD1X+vOz/dcAu1tggoMcv1wTdc08NU4XC/+MdjB2vqQHcrA2DyRw9E1Ht2ZKL0gkI=
X-Received: by 2002:a17:902:a584:b0:1eb:1af6:e7ea with SMTP id
 d9443c01a7336-1eeb05a1e2cmr49242745ad.34.1715268936280; Thu, 09 May 2024
 08:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240508145058.254306-1-pratap.nirujogi@amd.com>
In-Reply-To: <20240508145058.254306-1-pratap.nirujogi@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 May 2024 11:35:24 -0400
Message-ID: <CADnq5_NQMXJ5a1HkNYQyub5X73C5jqvoi0yJJ6L7VhY8K2bPcQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amd/amdgpu: Add ISP driver support
To: Pratap Nirujogi <pratap.nirujogi@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 benjamin.chan@amd.com, king.li@amd.com, bin.du@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 8, 2024 at 11:17=E2=80=AFAM Pratap Nirujogi <pratap.nirujogi@am=
d.com> wrote:
>
> Add the isp driver in amdgpu to support ISP device on the APUs that
> supports ISP IP block. ISP hw block is used for camera front-end, pre
> and post processing operations.
>
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile       |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h       |   4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c   | 298 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h   |  54 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c |   5 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |   1 +
>  7 files changed, 368 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/am=
dgpu/Makefile
> index de7b76327f5b..12ba76025cb7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -324,4 +324,7 @@ amdgpu-y +=3D $(AMD_DISPLAY_FILES)
>
>  endif
>
> +# add isp block
> +amdgpu-y +=3D amdgpu_isp.o
> +
>  obj-$(CONFIG_DRM_AMDGPU)+=3D amdgpu.o
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index eb60d28a3a13..6d7f9ef53269 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -112,6 +112,7 @@
>  #include "amdgpu_xcp.h"
>  #include "amdgpu_seq64.h"
>  #include "amdgpu_reg_state.h"
> +#include "amdgpu_isp.h"
>
>  #define MAX_GPU_INSTANCE               64
>
> @@ -1045,6 +1046,9 @@ struct amdgpu_device {
>         /* display related functionality */
>         struct amdgpu_display_manager dm;
>
> +       /* isp */
> +       struct amdgpu_isp               isp;
> +
>         /* mes */
>         bool                            enable_mes;
>         bool                            enable_mes_kiq;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_isp.c
> new file mode 100644
> index 000000000000..dcc01a339a43
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> @@ -0,0 +1,298 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
> + * All Rights Reserved.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the
> + * "Software"), to deal in the Software without restriction, including
> + * without limitation the rights to use, copy, modify, merge, publish,
> + * distribute, sub license, and/or sell copies of the Software, and to
> + * permit persons to whom the Software is furnished to do so, subject to
> + * the following conditions:
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY=
 CLAIM,
> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR=
 THE
> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * The above copyright notice and this permission notice (including the
> + * next paragraph) shall be included in all copies or substantial portio=
ns
> + * of the Software.
> + *
> + */
> +
> +#include <linux/irqdomain.h>
> +#include <linux/pm_domain.h>
> +#include <linux/platform_device.h>
> +#include <sound/designware_i2s.h>
> +#include <sound/pcm.h>
> +#include <linux/acpi.h>
> +#include <linux/firmware.h>
> +
> +#include "amdgpu_smu.h"
> +#include "atom.h"
> +#include "amdgpu_isp.h"
> +#include "smu_internal.h"
> +#include "smu_v11_5_ppsmc.h"
> +#include "smu_v11_5_pmfw.h"
> +
> +#define mmDAGB0_WRCLI5_V4_1    0x6811C
> +#define mmDAGB0_WRCLI9_V4_1    0x6812C
> +#define mmDAGB0_WRCLI10_V4_1   0x68130
> +#define mmDAGB0_WRCLI14_V4_1   0x68140
> +#define mmDAGB0_WRCLI19_V4_1   0x68154
> +#define mmDAGB0_WRCLI20_V4_1   0x68158
> +
> +static int isp_sw_init(void *handle)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +       pr_info("%s called adev %p\n", __func__, adev);
> +
> +       adev->isp.parent =3D adev->dev;
> +
> +       adev->isp.cgs_device =3D amdgpu_cgs_create_device(adev);
> +       if (!adev->isp.cgs_device)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +static int isp_sw_fini(void *handle)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +       pr_info("%s called adev %p\n", __func__, adev);
> +
> +       if (adev->isp.cgs_device)
> +               amdgpu_cgs_destroy_device(adev->isp.cgs_device);
> +
> +       return 0;
> +}
> +
> +/**
> + * isp_hw_init - start and test isp block
> + *
> + * @adev: amdgpu_device pointer
> + *
> + */
> +static int isp_hw_init(void *handle)
> +{
> +       int r;
> +       u64 isp_base;
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +       const struct amdgpu_ip_block *ip_block =3D
> +               amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_ISP=
);
> +
> +       if (!ip_block)
> +               return -EINVAL;
> +
> +       if (adev->rmmio_size =3D=3D 0 || adev->rmmio_size < 0x5289)
> +               return -EINVAL;
> +
> +       isp_base =3D adev->rmmio_base;
> +
> +       adev->isp.isp_cell =3D kcalloc(1, sizeof(struct mfd_cell), GFP_KE=
RNEL);
> +       if (!adev->isp.isp_cell) {
> +               r =3D -ENOMEM;
> +               DRM_ERROR("%s: isp mfd cell alloc failed\n", __func__);
> +               goto failure;
> +       }
> +
> +       adev->isp.isp_res =3D kcalloc(2, sizeof(struct resource), GFP_KER=
NEL);
> +       if (!adev->isp.isp_res) {
> +               r =3D -ENOMEM;
> +               DRM_ERROR("%s: isp mfd res alloc failed\n", __func__);
> +               goto failure;
> +       }
> +
> +       adev->isp.isp_pdata =3D kzalloc(sizeof(*adev->isp.isp_pdata), GFP=
_KERNEL);
> +       if (!adev->isp.isp_pdata) {
> +               r =3D -ENOMEM;
> +               DRM_ERROR("%s: isp platform data alloc failed\n", __func_=
_);
> +               goto failure;
> +       }
> +
> +       // initialize isp platform data
> +       adev->isp.isp_pdata->adev =3D (void *)adev;
> +       adev->isp.isp_pdata->asic_type =3D adev->asic_type;
> +       adev->isp.isp_pdata->base_rmmio_size =3D adev->rmmio_size;
> +
> +       adev->isp.isp_res[0].name =3D "isp41_reg";
> +       adev->isp.isp_res[0].flags =3D IORESOURCE_MEM;
> +       adev->isp.isp_res[0].start =3D isp_base;
> +       adev->isp.isp_res[0].end =3D isp_base + ISP_REGS_OFFSET_END;
> +
> +       adev->isp.isp_res[1].name =3D "isp41_irq";
> +       adev->isp.isp_res[1].flags =3D IORESOURCE_IRQ;
> +       adev->isp.isp_res[1].start =3D amdgpu_irq_create_mapping(adev, 16=
2);

You should replace 162 with whatever the src id you need for your IP
is.  162 was the src id for ACP.  I think it's something else for ISP.
Also, if you need both the client id and the src id, you should update
amdgpu_irq_create_mapping() to take into account both ids.

Alex


> +       adev->isp.isp_res[1].end =3D adev->isp.isp_res[1].start;
> +
> +       adev->isp.isp_cell[0].name =3D "amd_isp41_capture";
> +       adev->isp.isp_cell[0].num_resources =3D 2;
> +       adev->isp.isp_cell[0].resources =3D &adev->isp.isp_res[0];
> +       adev->isp.isp_cell[0].platform_data =3D adev->isp.isp_pdata;
> +       adev->isp.isp_cell[0].pdata_size =3D sizeof(struct isp_platform_d=
ata);
> +
> +       r =3D mfd_add_hotplug_devices(adev->isp.parent, adev->isp.isp_cel=
l, 1);
> +       if (r) {
> +               DRM_ERROR("%s: add mfd hotplug device failed\n", __func__=
);
> +               goto failure;
> +       }
> +
> +       // Temporary WA added to disable MMHUB TLSi until the GART initia=
lization
> +       // is ready to support MMHUB TLSi and SAW for ISP HW to access GA=
RT memory
> +       // using the TLSi path
> +       cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI5_V4_1 >> 2=
, 0xFE5FEAA8);
> +       cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI9_V4_1 >> 2=
, 0xFE5FEAA8);
> +       cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI10_V4_1 >> =
2, 0xFE5FEAA8);
> +       cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI14_V4_1 >> =
2, 0xFE5FEAA8);
> +       cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI19_V4_1 >> =
2, 0xFE5FEAA8);
> +       cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI20_V4_1 >> =
2, 0xFE5FEAA8);
> +
> +       return 0;
> +
> +failure:
> +
> +       kfree(adev->isp.isp_pdata);
> +       kfree(adev->isp.isp_res);
> +       kfree(adev->isp.isp_cell);
> +
> +       return r;
> +}
> +
> +/**
> + * isp_hw_fini - stop the hardware block
> + *
> + * @adev: amdgpu_device pointer
> + *
> + */
> +static int isp_hw_fini(void *handle)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +       // remove isp mfd device
> +       mfd_remove_devices(adev->isp.parent);
> +
> +       kfree(adev->isp.isp_res);
> +       kfree(adev->isp.isp_cell);
> +       kfree(adev->isp.isp_pdata);
> +
> +       return 0;
> +}
> +
> +static int isp_suspend(void *handle)
> +{
> +       return 0;
> +}
> +
> +static int isp_resume(void *handle)
> +{
> +       return 0;
> +}
> +
> +static int isp_load_fw_by_psp(struct amdgpu_device *adev)
> +{
> +       const struct common_firmware_header *hdr;
> +       char ucode_prefix[30];
> +       char fw_name[40];
> +       int r =3D 0;
> +
> +       // get isp fw binary name and path
> +       amdgpu_ucode_ip_version_decode(adev, ISP_HWIP, ucode_prefix,
> +                                      sizeof(ucode_prefix));
> +       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix)=
;
> +
> +       // read isp fw
> +       r =3D amdgpu_ucode_request(adev, &adev->isp.fw, fw_name);
> +       if (r) {
> +               DRM_ERROR("%s: failed to read isp fw %s\n", __func__, fw_=
name);
> +               amdgpu_ucode_release(&adev->isp.fw);
> +               return r;
> +       }
> +
> +       hdr =3D (const struct common_firmware_header *)adev->isp.fw->data=
;
> +
> +       adev->firmware.ucode[AMDGPU_UCODE_ID_ISP].ucode_id =3D
> +               AMDGPU_UCODE_ID_ISP;
> +       adev->firmware.ucode[AMDGPU_UCODE_ID_ISP].fw =3D adev->isp.fw;
> +
> +       adev->firmware.fw_size +=3D
> +               ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
> +
> +       DRM_INFO("isp fw <%s> load success, (base_addr, size)=3D(%p,%d)\n=
", fw_name,
> +                adev->isp.fw->data, (int)adev->isp.fw->size);
> +
> +       return r;
> +}
> +
> +static int isp_early_init(void *handle)
> +{
> +       int ret =3D 0;
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +       ret =3D isp_load_fw_by_psp(adev);
> +       if (ret) {
> +               DRM_WARN("%s: isp fw load failed\n", __func__);
> +               ret =3D 0;
> +       }
> +
> +       return ret;
> +}
> +
> +static bool isp_is_idle(void *handle)
> +{
> +       return true;
> +}
> +
> +static int isp_wait_for_idle(void *handle)
> +{
> +       return 0;
> +}
> +
> +static int isp_soft_reset(void *handle)
> +{
> +       return 0;
> +}
> +
> +static int isp_set_clockgating_state(void *handle,
> +                                    enum amd_clockgating_state state)
> +{
> +       return 0;
> +}
> +
> +static int isp_set_powergating_state(void *handle,
> +                                    enum amd_powergating_state state)
> +{
> +       return 0;
> +}
> +
> +static const struct amd_ip_funcs isp_ip_funcs =3D {
> +       .name =3D "isp_ip",
> +       .early_init =3D isp_early_init,
> +       .late_init =3D NULL,
> +       .sw_init =3D isp_sw_init,
> +       .sw_fini =3D isp_sw_fini,
> +       .hw_init =3D isp_hw_init,
> +       .hw_fini =3D isp_hw_fini,
> +       .suspend =3D isp_suspend,
> +       .resume =3D isp_resume,
> +       .is_idle =3D isp_is_idle,
> +       .wait_for_idle =3D isp_wait_for_idle,
> +       .soft_reset =3D isp_soft_reset,
> +       .set_clockgating_state =3D isp_set_clockgating_state,
> +       .set_powergating_state =3D isp_set_powergating_state,
> +};
> +
> +const struct amdgpu_ip_block_version isp_ip_block =3D {
> +       .type =3D AMD_IP_BLOCK_TYPE_ISP,
> +       .major =3D 4,
> +       .minor =3D 1,
> +       .rev =3D 0,
> +       .funcs =3D &isp_ip_funcs,
> +};
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_isp.h
> new file mode 100644
> index 000000000000..2adcb4b4dc6e
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
> + * All Rights Reserved.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the
> + * "Software"), to deal in the Software without restriction, including
> + * without limitation the rights to use, copy, modify, merge, publish,
> + * distribute, sub license, and/or sell copies of the Software, and to
> + * permit persons to whom the Software is furnished to do so, subject to
> + * the following conditions:
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY=
 CLAIM,
> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR=
 THE
> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * The above copyright notice and this permission notice (including the
> + * next paragraph) shall be included in all copies or substantial portio=
ns
> + * of the Software.
> + *
> + */
> +
> +#ifndef __AMDGPU_ISP_H__
> +#define __AMDGPU_ISP_H__
> +
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/core.h>
> +
> +#define ISP_REGS_OFFSET_END 0x629A4
> +
> +struct isp_platform_data {
> +       void *adev;
> +       u32 asic_type;
> +       resource_size_t base_rmmio_size;
> +};
> +
> +struct amdgpu_isp {
> +       struct device *parent;
> +       struct cgs_device *cgs_device;
> +       struct mfd_cell *isp_cell;
> +       struct resource *isp_res;
> +       struct isp_platform_data *isp_pdata;
> +       unsigned int harvest_config;
> +       const struct firmware   *fw;
> +};
> +
> +extern const struct amdgpu_ip_block_version isp_ip_block;
> +
> +#endif /* __AMDGPU_ISP_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 37820dd03cab..b4bd943a7cc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2539,6 +2539,9 @@ static int psp_get_fw_type(struct amdgpu_firmware_i=
nfo *ucode,
>         case AMDGPU_UCODE_ID_JPEG_RAM:
>                 *type =3D GFX_FW_TYPE_JPEG_RAM;
>                 break;
> +       case AMDGPU_UCODE_ID_ISP:
> +               *type =3D GFX_FW_TYPE_ISP;
> +               break;
>         case AMDGPU_UCODE_ID_MAXIMUM:
>         default:
>                 return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ucode.c
> index 75ece8a2f96b..a9de78bb96e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -712,6 +712,8 @@ const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID uc=
ode_id)
>                 return "RS64_MEC_P2_STACK";
>         case AMDGPU_UCODE_ID_CP_RS64_MEC_P3_STACK:
>                 return "RS64_MEC_P3_STACK";
> +       case AMDGPU_UCODE_ID_ISP:
> +               return "ISP";
>         default:
>                 return "UNKNOWN UCODE";
>         }
> @@ -1411,6 +1413,9 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_d=
evice *adev, int block_type,
>         case VPE_HWIP:
>                 ip_name =3D "vpe";
>                 break;
> +       case ISP_HWIP:
> +               ip_name =3D "isp";
> +               break;
>         default:
>                 BUG();
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ucode.h
> index a3c04f711099..db745ab7b0c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> @@ -523,6 +523,7 @@ enum AMDGPU_UCODE_ID {
>         AMDGPU_UCODE_ID_UMSCH_MM_CMD_BUFFER,
>         AMDGPU_UCODE_ID_P2S_TABLE,
>         AMDGPU_UCODE_ID_JPEG_RAM,
> +       AMDGPU_UCODE_ID_ISP,
>         AMDGPU_UCODE_ID_MAXIMUM,
>  };
>
> --
> 2.34.1
>
