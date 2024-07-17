Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3791AC3DA5D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 21:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDB1710E451;
	Wed, 17 Jul 2024 21:20:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N7ygfgP/";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD9BF10E46C
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 21:20:11 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-795d2aa4ba4so41573a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 14:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721251211; x=1721856011; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zlIB+wJ1C/+ZgQOKhRzEwlwaOdn3z27UOdDV9lvZF+4=;
 b=N7ygfgP/Pmh4bvMrJNBC1k59L2gXlLhTTMTs5FNikXbxXkM/DxCCZT0OyCODFlpvNA
 aDW2oq4z8kdm53Yu8Fdwg8Ds0vUDtV+80tOcf/GdBkvC5AEvzPp+ZGKFbeP9JqgUpBg/
 6Xdw6/8ifRyFoxvrHdKu6QePgpE/+xOdywYXH5hcfr6jMnRWX6R3rd4tmN12UMmu87ol
 PQoG19wtPGXPYY0T4AZ5jV4KMd/ZMHri0TLNZBOzj3WeCi7vBE58D1A/qAqjK0nNIGvg
 oq51q43ChEuFdqYE2O+ljgaVMO38GK5FyXCCdZbtlY1W9auOBNYI78XSFiWbysoT7VqY
 9koA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721251211; x=1721856011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zlIB+wJ1C/+ZgQOKhRzEwlwaOdn3z27UOdDV9lvZF+4=;
 b=tctNVMthhtvDTq2KNNfgO463VNQUII9hgM56+X4cfFPC4jrKoXHAn6Gv8rCYloqrbO
 A9t1tCxZUyD90IPSwpPm9cc6ZBdTO5cuQJP/JLDV3UdSplsxceZqRy+AZvGvqnAg4x7u
 OurpHl2UixI6tYliyFxKC6eWsxMS1x993tZGRwME2FT1XaXVpoCU0PYCifVgHFQqopmB
 DrlfYHp/Pb6XpHgKr4QxnK5GROBDFwEMSdJtwEfBdJvpUVlRbyFY8jv22Mj2zmWgpx21
 e5kYLELpScChQ6jsAF+B6s4VUD1LVMNykwyZbfWWUPUMtz3atmN5fppBETA4uJYN1moA
 WmEw==
X-Gm-Message-State: AOJu0YzS6+7ekWWt6xp4++UTnElEoHBHy7G/xetXj5kBhYZI1gl+0Zgl
 pknF/ZjMI4HNAbXUOpR852Ao+Fhtayk90kybYfJaSizSo9GIrEj+Kdt7DwGCV1uBNpcOHvdHL0k
 7mNyem0XoW1k/lqHuN3/p6CNsuTnpQA==
X-Google-Smtp-Source: AGHT+IGYA5deYENnXdcD31tIo9mLioiINr2IkdEA0D6G8g8FPwdmdHO1Rmc+g3R2n2s/Cuilicaq6h1pED3lkTE4ckA=
X-Received: by 2002:a05:6a21:710a:b0:1c2:89a3:4e1f with SMTP id
 adf61e73a8af0-1c3fdc848ddmr3665107637.16.1721251211018; Wed, 17 Jul 2024
 14:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240711231959.272993-1-vengutta@amd.com>
 <20240711231959.272993-2-vengutta@amd.com>
In-Reply-To: <20240711231959.272993-2-vengutta@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Jul 2024 17:19:59 -0400
Message-ID: <CADnq5_PRT9FUofzksBH2roiXo=bw+ReEb9NdW1kDtoXgG4_Hzg@mail.gmail.com>
Subject: Re: [PATCH v0 1/1] Add MFD support for ISP I2C bus
To: Venkata Narendra Kumar Gutta <vengutta@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, mlimonci@amd.com, benjamin.chan@amd.com, 
 king.li@amd.com, bin.du@amd.com, pratap.nirujogi@amd.com
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

On Thu, Jul 11, 2024 at 7:40=E2=80=AFPM Venkata Narendra Kumar Gutta
<vengutta@amd.com> wrote:
>
> ISP I2C bus device can't be enumerated via ACPI mechanism
> since it shares the memory map with the AMDGPU.
> So use the MFD mechanism for registering the ISP I2C device
> and add the required resources.
>
> Signed-off-by: Venkata Narendra Kumar Gutta <vengutta@amd.com>

Ackd-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c | 57 +++++++++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h | 12 ++++++
>  drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 57 +++++++++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h | 11 +++++
>  5 files changed, 114 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_isp.h
> index 44e2ea8c9728..b03664c66dd6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> @@ -49,6 +49,7 @@ struct amdgpu_isp {
>         const struct isp_funcs  *funcs;
>         struct mfd_cell *isp_cell;
>         struct resource *isp_res;
> +       struct resource *isp_i2c_res;
>         struct isp_platform_data *isp_pdata;
>         unsigned int harvest_config;
>         const struct firmware   *fw;
> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c b/drivers/gpu/drm/am=
d/amdgpu/isp_v4_1_0.c
> index aac107898bae..964c29ef25dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
> @@ -42,23 +42,23 @@ static const unsigned int isp_4_1_0_int_srcid[MAX_ISP=
410_INT_SRC] =3D {
>  static int isp_v4_1_0_hw_init(struct amdgpu_isp *isp)
>  {
>         struct amdgpu_device *adev =3D isp->adev;
> +       int idx, int_idx, num_res, r;
>         u64 isp_base;
> -       int int_idx;
> -       int r;
>
>         if (adev->rmmio_size =3D=3D 0 || adev->rmmio_size < 0x5289)
>                 return -EINVAL;
>
>         isp_base =3D adev->rmmio_base;
>
> -       isp->isp_cell =3D kcalloc(1, sizeof(struct mfd_cell), GFP_KERNEL)=
;
> +       isp->isp_cell =3D kcalloc(2, sizeof(struct mfd_cell), GFP_KERNEL)=
;
>         if (!isp->isp_cell) {
>                 r =3D -ENOMEM;
>                 DRM_ERROR("%s: isp mfd cell alloc failed\n", __func__);
>                 goto failure;
>         }
>
> -       isp->isp_res =3D kcalloc(MAX_ISP410_INT_SRC + 1, sizeof(struct re=
source),
> +       num_res =3D MAX_ISP410_MEM_RES + MAX_ISP410_SENSOR_RES + MAX_ISP4=
10_INT_SRC;
> +       isp->isp_res =3D kcalloc(num_res, sizeof(struct resource),
>                                GFP_KERNEL);
>         if (!isp->isp_res) {
>                 r =3D -ENOMEM;
> @@ -83,22 +83,53 @@ static int isp_v4_1_0_hw_init(struct amdgpu_isp *isp)
>         isp->isp_res[0].start =3D isp_base;
>         isp->isp_res[0].end =3D isp_base + ISP_REGS_OFFSET_END;
>
> -       for (int_idx =3D 0; int_idx < MAX_ISP410_INT_SRC; int_idx++) {
> -               isp->isp_res[int_idx + 1].name =3D "isp_4_1_0_irq";
> -               isp->isp_res[int_idx + 1].flags =3D IORESOURCE_IRQ;
> -               isp->isp_res[int_idx + 1].start =3D
> +       isp->isp_res[1].name =3D "isp_4_1_phy0_reg";
> +       isp->isp_res[1].flags =3D IORESOURCE_MEM;
> +       isp->isp_res[1].start =3D isp_base + ISP410_PHY0_OFFSET;
> +       isp->isp_res[1].end =3D isp_base + ISP410_PHY0_OFFSET + ISP410_PH=
Y0_SIZE;
> +
> +       isp->isp_res[2].name =3D "isp_gpio_sensor0_reg";
> +       isp->isp_res[2].flags =3D IORESOURCE_MEM;
> +       isp->isp_res[2].start =3D isp_base + ISP410_GPIO_SENSOR0_OFFSET;
> +       isp->isp_res[2].end =3D isp_base + ISP410_GPIO_SENSOR0_OFFSET +
> +                             ISP410_GPIO_SENSOR0_SIZE;
> +
> +       for (idx =3D MAX_ISP410_MEM_RES + MAX_ISP410_SENSOR_RES, int_idx =
=3D 0;
> +            idx < num_res; idx++, int_idx++) {
> +               isp->isp_res[idx].name =3D "isp_4_1_0_irq";
> +               isp->isp_res[idx].flags =3D IORESOURCE_IRQ;
> +               isp->isp_res[idx].start =3D
>                         amdgpu_irq_create_mapping(adev, isp_4_1_0_int_src=
id[int_idx]);
> -               isp->isp_res[int_idx + 1].end =3D
> -                       isp->isp_res[int_idx + 1].start;
> +               isp->isp_res[idx].end =3D
> +                       isp->isp_res[idx].start;
>         }
>
>         isp->isp_cell[0].name =3D "amd_isp_capture";
> -       isp->isp_cell[0].num_resources =3D MAX_ISP410_INT_SRC + 1;
> +       isp->isp_cell[0].num_resources =3D num_res;
>         isp->isp_cell[0].resources =3D &isp->isp_res[0];
>         isp->isp_cell[0].platform_data =3D isp->isp_pdata;
>         isp->isp_cell[0].pdata_size =3D sizeof(struct isp_platform_data);
>
> -       r =3D mfd_add_hotplug_devices(isp->parent, isp->isp_cell, 1);
> +       isp->isp_i2c_res =3D kcalloc(1, sizeof(struct resource),
> +                                  GFP_KERNEL);
> +       if (!isp->isp_i2c_res) {
> +               r =3D -ENOMEM;
> +               DRM_ERROR("%s: isp mfd res alloc failed\n", __func__);
> +               goto failure;
> +       }
> +
> +       isp->isp_i2c_res[0].name =3D "isp_i2c0_reg";
> +       isp->isp_i2c_res[0].flags =3D IORESOURCE_MEM;
> +       isp->isp_i2c_res[0].start =3D isp_base + ISP410_I2C0_OFFSET;
> +       isp->isp_i2c_res[0].end =3D isp_base + ISP410_I2C0_OFFSET + ISP41=
0_I2C0_SIZE;
> +
> +       isp->isp_cell[1].name =3D "amd_isp_i2c_designware";
> +       isp->isp_cell[1].num_resources =3D 1;
> +       isp->isp_cell[1].resources =3D &isp->isp_i2c_res[0];
> +       isp->isp_cell[1].platform_data =3D isp->isp_pdata;
> +       isp->isp_cell[1].pdata_size =3D sizeof(struct isp_platform_data);
> +
> +       r =3D mfd_add_hotplug_devices(isp->parent, isp->isp_cell, 2);
>         if (r) {
>                 DRM_ERROR("%s: add mfd hotplug device failed\n", __func__=
);
>                 goto failure;
> @@ -111,6 +142,7 @@ static int isp_v4_1_0_hw_init(struct amdgpu_isp *isp)
>         kfree(isp->isp_pdata);
>         kfree(isp->isp_res);
>         kfree(isp->isp_cell);
> +       kfree(isp->isp_i2c_res);
>
>         return r;
>  }
> @@ -122,6 +154,7 @@ static int isp_v4_1_0_hw_fini(struct amdgpu_isp *isp)
>         kfree(isp->isp_res);
>         kfree(isp->isp_cell);
>         kfree(isp->isp_pdata);
> +       kfree(isp->isp_i2c_res);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h b/drivers/gpu/drm/am=
d/amdgpu/isp_v4_1_0.h
> index 315f2822410c..d6f7ffb0e2f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h
> @@ -32,8 +32,20 @@
>
>  #include "ivsrcid/isp/irqsrcs_isp_4_1.h"
>
> +#define MAX_ISP410_MEM_RES 2
> +#define MAX_ISP410_SENSOR_RES 1
>  #define MAX_ISP410_INT_SRC 8
>
> +#define ISP410_PHY0_OFFSET 0x66700
> +#define ISP410_PHY0_SIZE   0xD30
> +
> +#define ISP410_I2C0_OFFSET 0x66400
> +#define ISP410_I2C0_SIZE 0x100
> +
> +#define ISP410_GPIO_SENSOR0_OFFSET 0x6613C
> +#define ISP410_GPIO_SENSOR0_SIZE 0x4
> +
> +
>  void isp_v4_1_0_set_isp_funcs(struct amdgpu_isp *isp);
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/am=
d/amdgpu/isp_v4_1_1.c
> index 4e17fa03f7b5..b56f27295468 100644
> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> @@ -42,23 +42,24 @@ static const unsigned int isp_4_1_1_int_srcid[MAX_ISP=
411_INT_SRC] =3D {
>  static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>  {
>         struct amdgpu_device *adev =3D isp->adev;
> +       int idx, int_idx, num_res, r;
>         u64 isp_base;
> -       int int_idx;
> -       int r;
>
>         if (adev->rmmio_size =3D=3D 0 || adev->rmmio_size < 0x5289)
>                 return -EINVAL;
>
>         isp_base =3D adev->rmmio_base;
>
> -       isp->isp_cell =3D kcalloc(1, sizeof(struct mfd_cell), GFP_KERNEL)=
;
> +       isp->isp_cell =3D kcalloc(2, sizeof(struct mfd_cell), GFP_KERNEL)=
;
>         if (!isp->isp_cell) {
>                 r =3D -ENOMEM;
>                 DRM_ERROR("%s: isp mfd cell alloc failed\n", __func__);
>                 goto failure;
>         }
>
> -       isp->isp_res =3D kcalloc(MAX_ISP411_INT_SRC + 1, sizeof(struct re=
source),
> +       num_res =3D MAX_ISP411_MEM_RES + MAX_ISP411_SENSOR_RES + MAX_ISP4=
11_INT_SRC;
> +
> +       isp->isp_res =3D kcalloc(num_res, sizeof(struct resource),
>                                GFP_KERNEL);
>         if (!isp->isp_res) {
>                 r =3D -ENOMEM;
> @@ -83,22 +84,52 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>         isp->isp_res[0].start =3D isp_base;
>         isp->isp_res[0].end =3D isp_base + ISP_REGS_OFFSET_END;
>
> -       for (int_idx =3D 0; int_idx < MAX_ISP411_INT_SRC; int_idx++) {
> -               isp->isp_res[int_idx + 1].name =3D "isp_4_1_1_irq";
> -               isp->isp_res[int_idx + 1].flags =3D IORESOURCE_IRQ;
> -               isp->isp_res[int_idx + 1].start =3D
> +       isp->isp_res[1].name =3D "isp_4_1_1_phy0_reg";
> +       isp->isp_res[1].flags =3D IORESOURCE_MEM;
> +       isp->isp_res[1].start =3D isp_base + ISP411_PHY0_OFFSET;
> +       isp->isp_res[1].end =3D isp_base + ISP411_PHY0_OFFSET + ISP411_PH=
Y0_SIZE;
> +
> +       isp->isp_res[2].name =3D "isp_4_1_1_sensor0_reg";
> +       isp->isp_res[2].flags =3D IORESOURCE_MEM;
> +       isp->isp_res[2].start =3D isp_base + ISP411_GPIO_SENSOR0_OFFSET;
> +       isp->isp_res[2].end =3D isp_base + ISP411_GPIO_SENSOR0_OFFSET +
> +                             ISP411_GPIO_SENSOR0_SIZE;
> +
> +       for (idx =3D MAX_ISP411_MEM_RES + MAX_ISP411_SENSOR_RES, int_idx =
=3D 0;
> +            idx < num_res; idx++, int_idx++) {
> +               isp->isp_res[idx].name =3D "isp_4_1_1_irq";
> +               isp->isp_res[idx].flags =3D IORESOURCE_IRQ;
> +               isp->isp_res[idx].start =3D
>                         amdgpu_irq_create_mapping(adev, isp_4_1_1_int_src=
id[int_idx]);
> -               isp->isp_res[int_idx + 1].end =3D
> -                       isp->isp_res[int_idx + 1].start;
> +               isp->isp_res[idx].end =3D
> +                       isp->isp_res[idx].start;
>         }
>
>         isp->isp_cell[0].name =3D "amd_isp_capture";
> -       isp->isp_cell[0].num_resources =3D MAX_ISP411_INT_SRC + 1;
> +       isp->isp_cell[0].num_resources =3D num_res;
>         isp->isp_cell[0].resources =3D &isp->isp_res[0];
>         isp->isp_cell[0].platform_data =3D isp->isp_pdata;
>         isp->isp_cell[0].pdata_size =3D sizeof(struct isp_platform_data);
>
> -       r =3D mfd_add_hotplug_devices(isp->parent, isp->isp_cell, 1);
> +       isp->isp_i2c_res =3D kcalloc(1, sizeof(struct resource), GFP_KERN=
EL);
> +       if (!isp->isp_i2c_res) {
> +               r =3D -ENOMEM;
> +               DRM_ERROR("%s: isp mfd res alloc failed\n", __func__);
> +               goto failure;
> +       }
> +
> +       isp->isp_i2c_res[0].name =3D "isp_i2c0_reg";
> +       isp->isp_i2c_res[0].flags =3D IORESOURCE_MEM;
> +       isp->isp_i2c_res[0].start =3D isp_base + ISP411_I2C0_OFFSET;
> +       isp->isp_i2c_res[0].end =3D isp_base + ISP411_I2C0_OFFSET + ISP41=
1_I2C0_SIZE;
> +
> +       isp->isp_cell[1].name =3D "amd_isp_i2c_designware";
> +       isp->isp_cell[1].num_resources =3D 1;
> +       isp->isp_cell[1].resources =3D &isp->isp_i2c_res[0];
> +       isp->isp_cell[1].platform_data =3D isp->isp_pdata;
> +       isp->isp_cell[1].pdata_size =3D sizeof(struct isp_platform_data);
> +
> +       r =3D mfd_add_hotplug_devices(isp->parent, isp->isp_cell, 2);
>         if (r) {
>                 DRM_ERROR("%s: add mfd hotplug device failed\n", __func__=
);
>                 goto failure;
> @@ -111,6 +142,7 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>         kfree(isp->isp_pdata);
>         kfree(isp->isp_res);
>         kfree(isp->isp_cell);
> +       kfree(isp->isp_i2c_res);
>
>         return r;
>  }
> @@ -122,6 +154,7 @@ static int isp_v4_1_1_hw_fini(struct amdgpu_isp *isp)
>         kfree(isp->isp_res);
>         kfree(isp->isp_cell);
>         kfree(isp->isp_pdata);
> +       kfree(isp->isp_i2c_res);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h b/drivers/gpu/drm/am=
d/amdgpu/isp_v4_1_1.h
> index dfb9522c9d6a..40887ddeb08c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
> @@ -32,8 +32,19 @@
>
>  #include "ivsrcid/isp/irqsrcs_isp_4_1.h"
>
> +#define MAX_ISP411_MEM_RES 2
> +#define MAX_ISP411_SENSOR_RES 1
>  #define MAX_ISP411_INT_SRC 8
>
> +#define ISP411_PHY0_OFFSET 0x66700
> +#define ISP411_PHY0_SIZE   0xD30
> +
> +#define ISP411_I2C0_OFFSET 0x66400
> +#define ISP411_I2C0_SIZE 0x100
> +
> +#define ISP411_GPIO_SENSOR0_OFFSET 0x6613C
> +#define ISP411_GPIO_SENSOR0_SIZE 0x4
> +
>  void isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp);
>
>  #endif
> --
> 2.34.1
>
