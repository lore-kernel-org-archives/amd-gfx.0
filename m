Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38D9C761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:23:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D61910E412;
	Thu, 30 Mar 2023 14:23:34 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20BD210E412
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:23:32 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-17786581fe1so19862122fac.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 07:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680186211;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sFBA4PQqiMII2w7hfI37F8v86qouhgrk34C5YKNYZ34=;
 b=o+e9InSDgEFkuoq0rOld87WVuajtgO1QD7kIf8iRX9ifBDVKk9qi2brzWGBFOFdhtY
 KH5laml0axXqBUrn4Cfgx5oq8WCOx2Js2F69RRBEroES0alkw4bZ91eSYpKP3BKhOha7
 YBAGLpE2EbOSBQ45cWAsxeCG9D2RjPN55afpFMPN9NPINkqBMo4lCXkPl7udhzRql7xQ
 Kx1EYOoDmy+3kQEFFTr9A4SCcnTtiC4hX3nlilulDqmnxqVL/EcfgNr2HdO9rRyblzO7
 QmG8WE4x1axjQAA4y0MV6inUokuwFUBjM7dB8XAHNCEFlaopv/72y2Msc4RpLeYeVhnP
 4x/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680186211;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sFBA4PQqiMII2w7hfI37F8v86qouhgrk34C5YKNYZ34=;
 b=XpDjrj2qAM11yJlpsOVuil5Kw0kibq/HPzKVNwVbppLi6bwzfDCuHRZwVuejgt2rMj
 tew+IsLQ7l2CYxCFlQtFvNdRxfVYzK1UVrZai0f19G/rHbOktItHV8Ar1HJ+ADAikoc7
 yU4MiBPTz2A7vFw0bEC/NCAIJU13oHF877rkQdgchUoJ5m3GPt1lpfcEj6Bzl5E4ScVV
 No2umOQ5gY8mksqesyH9s9jfU4CPkbug6c1niM/4m+3KjytmpVreswmtfwe3AxLCvjbB
 1DJC9bRDLt05ooXW7CAepMH7Warlgk/DcF3g//Ab+F/PgFDLVyH9YqRCCuO3Vv394fil
 WElg==
X-Gm-Message-State: AAQBX9eZXYMItsufcbD9qAy6oMEfV3l/KPjkEnsVrZsQJgaaNUMBblrK
 M9gcJP8GkUl+mc+xtc8LGGjpRrKKG7U92722b8s=
X-Google-Smtp-Source: AKy350a5in5iDbDC1q7SbvWLNDTStnxHdfUegKu9hUeKDznDmgjfeHwCDqioPMuZdWWJ5I7selosHBGpzJat6ldj1to=
X-Received: by 2002:a05:6871:4910:b0:177:b992:fee7 with SMTP id
 tw16-20020a056871491000b00177b992fee7mr5840035oab.3.1680186211117; Thu, 30
 Mar 2023 07:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-4-shashank.sharma@amd.com>
In-Reply-To: <20230329154753.1261-4-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Mar 2023 10:23:16 -0400
Message-ID: <CADnq5_PGPL1nTWyoiusGSLwBPMoFpv5a7sUpE6W99ozWTRv5-A@mail.gmail.com>
Subject: Re: [PATCH 03/16] drm/amdgpu: create a new file for doorbell manager
To: Shashank Sharma <shashank.sharma@amd.com>
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 29, 2023 at 11:48=E2=80=AFAM Shashank Sharma
<shashank.sharma@amd.com> wrote:
>
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> This patch:
> - creates a new file for doorbell management.
> - moves doorbell code from amdgpu_device.c to this file.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 164 ---------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |  22 +++
>  .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 186 ++++++++++++++++++
>  4 files changed, 209 insertions(+), 165 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/am=
dgpu/Makefile
> index 798d0e9a60b7..204665f20319 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -41,7 +41,7 @@ ccflags-y :=3D -I$(FULL_AMD_PATH)/include/asic_reg \
>  amdgpu-y :=3D amdgpu_drv.o
>
>  # add KMS driver
> -amdgpu-y +=3D amdgpu_device.o amdgpu_kms.o \
> +amdgpu-y +=3D amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
>         amdgpu_atombios.o atombios_crtc.o amdgpu_connectors.o \
>         atom.o amdgpu_fence.o amdgpu_ttm.o amdgpu_object.o amdgpu_gart.o =
\
>         amdgpu_encoders.o amdgpu_display.o amdgpu_i2c.o \
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 57ee1c4a81e9..7f8fcac4f18b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -579,94 +579,6 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *a=
dev,
>         }
>  }
>
> -/**
> - * amdgpu_mm_rdoorbell - read a doorbell dword
> - *
> - * @adev: amdgpu_device pointer
> - * @index: doorbell index
> - *
> - * Returns the value in the doorbell aperture at the
> - * requested doorbell index (CIK).
> - */
> -u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
> -{
> -       if (amdgpu_device_skip_hw_access(adev))
> -               return 0;
> -
> -       if (index < adev->doorbell.num_kernel_doorbells) {
> -               return readl(adev->doorbell.ptr + index);
> -       } else {
> -               DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", =
index);
> -               return 0;
> -       }
> -}
> -
> -/**
> - * amdgpu_mm_wdoorbell - write a doorbell dword
> - *
> - * @adev: amdgpu_device pointer
> - * @index: doorbell index
> - * @v: value to write
> - *
> - * Writes @v to the doorbell aperture at the
> - * requested doorbell index (CIK).
> - */
> -void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
> -{
> -       if (amdgpu_device_skip_hw_access(adev))
> -               return;
> -
> -       if (index < adev->doorbell.num_kernel_doorbells) {
> -               writel(v, adev->doorbell.ptr + index);
> -       } else {
> -               DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", =
index);
> -       }
> -}
> -
> -/**
> - * amdgpu_mm_rdoorbell64 - read a doorbell Qword
> - *
> - * @adev: amdgpu_device pointer
> - * @index: doorbell index
> - *
> - * Returns the value in the doorbell aperture at the
> - * requested doorbell index (VEGA10+).
> - */
> -u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
> -{
> -       if (amdgpu_device_skip_hw_access(adev))
> -               return 0;
> -
> -       if (index < adev->doorbell.num_kernel_doorbells) {
> -               return atomic64_read((atomic64_t *)(adev->doorbell.ptr + =
index));
> -       } else {
> -               DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", =
index);
> -               return 0;
> -       }
> -}
> -
> -/**
> - * amdgpu_mm_wdoorbell64 - write a doorbell Qword
> - *
> - * @adev: amdgpu_device pointer
> - * @index: doorbell index
> - * @v: value to write
> - *
> - * Writes @v to the doorbell aperture at the
> - * requested doorbell index (VEGA10+).
> - */
> -void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
> -{
> -       if (amdgpu_device_skip_hw_access(adev))
> -               return;
> -
> -       if (index < adev->doorbell.num_kernel_doorbells) {
> -               atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), =
v);
> -       } else {
> -               DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", =
index);
> -       }
> -}
> -
>  /**
>   * amdgpu_device_indirect_rreg - read an indirect register
>   *
> @@ -1016,82 +928,6 @@ int amdgpu_device_pci_reset(struct amdgpu_device *a=
dev)
>         return pci_reset_function(adev->pdev);
>  }
>
> -/*
> - * GPU doorbell aperture helpers function.
> - */
> -/**
> - * amdgpu_device_doorbell_init - Init doorbell driver information.
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Init doorbell driver information (CIK)
> - * Returns 0 on success, error on failure.
> - */
> -static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
> -{
> -
> -       /* No doorbell on SI hardware generation */
> -       if (adev->asic_type < CHIP_BONAIRE) {
> -               adev->doorbell.base =3D 0;
> -               adev->doorbell.size =3D 0;
> -               adev->doorbell.num_kernel_doorbells =3D 0;
> -               adev->doorbell.ptr =3D NULL;
> -               return 0;
> -       }
> -
> -       if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
> -               return -EINVAL;
> -
> -       amdgpu_asic_init_doorbell_index(adev);
> -
> -       /* doorbell bar mapping */
> -       adev->doorbell.base =3D pci_resource_start(adev->pdev, 2);
> -       adev->doorbell.size =3D pci_resource_len(adev->pdev, 2);
> -
> -       if (adev->enable_mes) {
> -               adev->doorbell.num_kernel_doorbells =3D
> -                       adev->doorbell.size / sizeof(u32);
> -       } else {
> -               adev->doorbell.num_kernel_doorbells =3D
> -                       min_t(u32, adev->doorbell.size / sizeof(u32),
> -                             adev->doorbell_index.max_assignment+1);
> -               if (adev->doorbell.num_kernel_doorbells =3D=3D 0)
> -                       return -EINVAL;
> -
> -               /* For Vega, reserve and map two pages on doorbell BAR si=
nce SDMA
> -                * paging queue doorbell use the second page. The
> -                * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes al=
l the
> -                * doorbells are in the first page. So with paging queue =
enabled,
> -                * the max num_kernel_doorbells should + 1 page (0x400 in=
 dword)
> -                */
> -               if (adev->asic_type >=3D CHIP_VEGA10)
> -                       adev->doorbell.num_kernel_doorbells +=3D 0x400;
> -       }
> -
> -       adev->doorbell.ptr =3D ioremap(adev->doorbell.base,
> -                                    adev->doorbell.num_kernel_doorbells =
*
> -                                    sizeof(u32));
> -       if (adev->doorbell.ptr =3D=3D NULL)
> -               return -ENOMEM;
> -
> -       return 0;
> -}
> -
> -/**
> - * amdgpu_device_doorbell_fini - Tear down doorbell driver information.
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Tear down doorbell driver information (CIK)
> - */
> -static void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
> -{
> -       iounmap(adev->doorbell.ptr);
> -       adev->doorbell.ptr =3D NULL;
> -}
> -
> -
> -
>  /*
>   * amdgpu_device_wb_*()
>   * Writeback is the method by which the GPU updates special pages in mem=
ory
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_doorbell.h
> index 6064943a1b53..f9c3b77bf65d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> @@ -306,6 +306,28 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev,=
 u32 index, u32 v);
>  u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index);
>  void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)=
;
>
> +/*
> + * GPU doorbell aperture helpers function.
> + */
> +/**
> + * amdgpu_device_doorbell_init - Init doorbell driver information.
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Init doorbell driver information (CIK)
> + * Returns 0 on success, error on failure.
> + */
> +int amdgpu_device_doorbell_init(struct amdgpu_device *adev);
> +
> +/**
> + * amdgpu_device_doorbell_fini - Tear down doorbell driver information.
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Tear down doorbell driver information (CIK)
> + */
> +void amdgpu_device_doorbell_fini(struct amdgpu_device *adev);
> +
>  #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>  #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>  #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> new file mode 100644
> index 000000000000..2206926ba289
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> @@ -0,0 +1,186 @@
> +/*
> + * Copyright 2023 Advanced Micro Devices, Inc.
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
> +#include "amdgpu.h"
> +
> +/**
> + * amdgpu_mm_rdoorbell - read a doorbell dword
> + *
> + * @adev: amdgpu_device pointer
> + * @index: doorbell index
> + *
> + * Returns the value in the doorbell aperture at the
> + * requested doorbell index (CIK).
> + */
> +u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
> +{
> +       if (amdgpu_device_skip_hw_access(adev))
> +               return 0;
> +
> +       if (index < adev->doorbell.num_kernel_doorbells) {
> +               return readl(adev->doorbell.ptr + index);
> +       } else {
> +               DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", =
index);
> +               return 0;
> +       }
> +}
> +
> +/**
> + * amdgpu_mm_wdoorbell - write a doorbell dword
> + *
> + * @adev: amdgpu_device pointer
> + * @index: doorbell index
> + * @v: value to write
> + *
> + * Writes @v to the doorbell aperture at the
> + * requested doorbell index (CIK).
> + */
> +void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
> +{
> +       if (amdgpu_device_skip_hw_access(adev))
> +               return;
> +
> +       if (index < adev->doorbell.num_kernel_doorbells) {
> +               writel(v, adev->doorbell.ptr + index);
> +       } else {
> +               DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", =
index);
> +       }
> +}
> +
> +/**
> + * amdgpu_mm_rdoorbell64 - read a doorbell Qword
> + *
> + * @adev: amdgpu_device pointer
> + * @index: doorbell index
> + *
> + * Returns the value in the doorbell aperture at the
> + * requested doorbell index (VEGA10+).
> + */
> +u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
> +{
> +       if (amdgpu_device_skip_hw_access(adev))
> +               return 0;
> +
> +       if (index < adev->doorbell.num_kernel_doorbells) {
> +               return atomic64_read((atomic64_t *)(adev->doorbell.ptr + =
index));
> +       } else {
> +               DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", =
index);
> +               return 0;
> +       }
> +}
> +
> +/**
> + * amdgpu_mm_wdoorbell64 - write a doorbell Qword
> + *
> + * @adev: amdgpu_device pointer
> + * @index: doorbell index
> + * @v: value to write
> + *
> + * Writes @v to the doorbell aperture at the
> + * requested doorbell index (VEGA10+).
> + */
> +void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
> +{
> +       if (amdgpu_device_skip_hw_access(adev))
> +               return;
> +
> +       if (index < adev->doorbell.num_kernel_doorbells) {
> +               atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), =
v);
> +       } else {
> +               DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", =
index);
> +       }
> +}
> +
> +/*
> + * GPU doorbell aperture helpers function.
> + */
> +/**
> + * amdgpu_device_doorbell_init - Init doorbell driver information.
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Init doorbell driver information (CIK)
> + * Returns 0 on success, error on failure.
> + */
> +int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
> +{
> +
> +       /* No doorbell on SI hardware generation */
> +       if (adev->asic_type < CHIP_BONAIRE) {
> +               adev->doorbell.base =3D 0;
> +               adev->doorbell.size =3D 0;
> +               adev->doorbell.num_kernel_doorbells =3D 0;
> +               adev->doorbell.ptr =3D NULL;
> +               return 0;
> +       }
> +
> +       if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
> +               return -EINVAL;
> +
> +       amdgpu_asic_init_doorbell_index(adev);
> +
> +       /* doorbell bar mapping */
> +       adev->doorbell.base =3D pci_resource_start(adev->pdev, 2);
> +       adev->doorbell.size =3D pci_resource_len(adev->pdev, 2);
> +
> +       if (adev->enable_mes) {
> +               adev->doorbell.num_kernel_doorbells =3D
> +                       adev->doorbell.size / sizeof(u32);
> +       } else {
> +               adev->doorbell.num_kernel_doorbells =3D
> +                       min_t(u32, adev->doorbell.size / sizeof(u32),
> +                             adev->doorbell_index.max_assignment+1);
> +               if (adev->doorbell.num_kernel_doorbells =3D=3D 0)
> +                       return -EINVAL;
> +
> +               /* For Vega, reserve and map two pages on doorbell BAR si=
nce SDMA
> +                * paging queue doorbell use the second page. The
> +                * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes al=
l the
> +                * doorbells are in the first page. So with paging queue =
enabled,
> +                * the max num_kernel_doorbells should + 1 page (0x400 in=
 dword)
> +                */
> +               if (adev->asic_type >=3D CHIP_VEGA10)
> +                       adev->doorbell.num_kernel_doorbells +=3D 0x400;
> +       }
> +
> +       adev->doorbell.ptr =3D ioremap(adev->doorbell.base,
> +                                    adev->doorbell.num_kernel_doorbells =
*
> +                                    sizeof(u32));
> +       if (adev->doorbell.ptr =3D=3D NULL)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +/**
> + * amdgpu_device_doorbell_fini - Tear down doorbell driver information.
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Tear down doorbell driver information (CIK)
> + */
> +void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
> +{
> +       iounmap(adev->doorbell.ptr);
> +       adev->doorbell.ptr =3D NULL;
> +}

I would suggest renaming these functions to begin with
amdgpu_doorbell_ to be consistent with the naming conventions in the
driver.

Alex
