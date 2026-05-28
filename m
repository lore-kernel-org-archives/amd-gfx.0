Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17529CD4F54
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 13:34:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC37410F1A6;
	Thu, 28 May 2026 13:34:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BxsxsngT";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B49510F1A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 13:34:24 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-304dc707c7eso35274eec.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 06:34:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779975264; cv=none;
 d=google.com; s=arc-20240605;
 b=d5BO6PEf4IFPbDYExhGAsHiarxSkBmVGySmtiPd4tJs6MSwzlnM9BL+Dy8AYE8IkfU
 F+XNa+beuTfjfLsj9wJNB4y7RefsNe0knYKufo6PNG6aArZzLKBRVngS7imevpc2wEns
 0jcaDlD0MBmoi+fpds1XVKqW/qz8tuj4CXzojQVYUqK7H+Pk3449H97T67z7yqxRJJVX
 2Vdea9mVuCl3S9EA0Q/PLz0e9MWy7idKaCM3MWlEpG8CaF+yXYEhZk9Ul1vNoV+bZDrT
 bzELl9bwKgqZ/rRbFAt7/D+KgtILyZFRSXS2ILhm7ieSjTvurfVnqs7K4ManGYnRO3aU
 Kjyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wLW604TLCYRljIsDQSVVx2FZ5EMluG5JdTnKEVaOvbg=;
 fh=yMe2o3fCfszpsUMzrztkiU9Kk/JO0rSydARy/7BoFZU=;
 b=e3HkLVF4pEwzrJIcaaU20sy/dmjFKU9VCwCPW4daRPwqL8UfPnIUNnF5hM5NCGC2cH
 sF0PPJAKDx1bPB4aftyJU/N1ZTfa50j7N7UcyhI2isQVdmXWQjzwdZqtEu0UjLcdz+gm
 5c220rr9qXXEvuSLpFBLkwrIDSsjCHgplgJghgR4w0xEwdkcmsh9o0GqabLrYa/C/06E
 M834tQuxzJlUShMw6uQxRAXK/uS1XZlJa4EVdCo/za3X8Dv7ItBvJxik2L7DWyzS0hT6
 O5fSfLHaFTNMh/qlIExO4SG8Sqi5lytC4jBB+LjI5ZRp5/VVEjxteDMUjAsVKZ4eCmTj
 EHhQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779975264; x=1780580064; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wLW604TLCYRljIsDQSVVx2FZ5EMluG5JdTnKEVaOvbg=;
 b=BxsxsngTpT4OkhSz9j1FZedZXGVZgM3yTsbNl1l7JPGjX9e9cr7MwToQmWq8YKLBbS
 WOa07qK+Y9SdkeAHgfj4WUW5YgIJcXt8l99un92yoUr3v6SyGk/z2UprlQSVkhvDQIvw
 LDMTpRj8eze+6v1JHH9Ma/UVamtWA/Bz2za9GldxIq5PG2eSzw+seLMKNKhU68LsuMYn
 QJgM8bcZaHNam75CUp4yC03Zde9CunqMxgHCZXsUp2W22v4muP/MtqsBDHMJgtRbaYfL
 S5K2Qt6zBfo6Zqh9LjNdqkkcakasgJN1zV9fY4ZrYICyDPTlM292Qnk4xPlYNBTRVHiG
 qLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779975264; x=1780580064;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wLW604TLCYRljIsDQSVVx2FZ5EMluG5JdTnKEVaOvbg=;
 b=MuHAKFRMqsV5nLFVyFvrkufWIJ6Jo1SY7t5mHj26MinEZfY9Tf5TrK+g7sd2YsDJ50
 FUp4taYE8g4UOd1GlRKLLgtkGREQoXfyzMnj7UNs4gq1TXw8SSuBNEjbCVuKgARXyYKL
 hZFI1K+k2TW0yNz6AWijZDHNq6mNIq7FhzWoWIRO3AlyPwqcMpmk6h9EfozkTXWyT3NO
 Zrw/draNRJ6jRGWKt4pR4OaflFWNsrdH7+8Z/LUnawvjYcz+GM87/Sj0jl40mrozlQav
 3YPNijMaI4XcFWZolZaZ4Q5fQPwIoi6DIgTVfJBM0wxcX7W5WnTWfeEzPkDALHa9hiOh
 DXng==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lyhKNLiOnwHba7qDfBPTX7axXm6rWSgWZOEraiTwP0T7ejD13wgKIIsskiJX6uBD62bs603z1@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGB3KxC7YgLHSE1z1xKTtfp84AwGDy1/gIcY+atNpe5UY12szj
 5KDoDVUum72x9HAu6b3I9HUKLEd9FHqskn6wy9L3l/YghTxohn7sYyot09qc9JKS+pWAZb/iZww
 NsJ6jftuGHcXe8kjFME/CwkwJHRZ3xj4=
X-Gm-Gg: Acq92OGjFm5cezc4//NR18tcvg1UwnHJRCPU+JWB8yo6tLbM3UCQ+o7Wm7Cq+Jdhr7D
 CnhjCHPblm5AuFf+WAAMr/NJoYCdWGGZ0u66x1lv8oVuWaTyl57q62w18ikx64cYozieomwprkc
 Gx0LF+4T6c1m4mJQL21udBxiXvreyb34OeCrbrhdonSFExRfNinyI7yUlv3kdY15rAsVWL6F+g/
 4LTiNAAJq3wIlUU2+9+bpp4FynqpsEi8QHe8efcZ07akV8XqG3wnAOsPdTroVauo6W2XIUHF/MG
 XOhaCRLknWz8Qc/aOixzQOkhdkzRoZ5jpftmOpsFqWWG/bzKuwExgA+3HY18ZXGlP20lCjd1Bba
 zf8APISurHGoNcT4=
X-Received: by 2002:a05:7022:43a9:b0:12c:900b:9dee with SMTP id
 a92af1059eb24-1377c95c89fmr612946c88.1.1779975263571; Thu, 28 May 2026
 06:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260528064206.12358-1-Pratik.Vishwakarma@amd.com>
 <20260528064206.12358-3-Pratik.Vishwakarma@amd.com>
In-Reply-To: <20260528064206.12358-3-Pratik.Vishwakarma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 May 2026 09:34:11 -0400
X-Gm-Features: AVHnY4JWxSMxR7QuURll0y-qETA_z0A2E2OyDkgVkV_ViwoksZdJQ94kqN1-zZ8
Message-ID: <CADnq5_O+1RiLHx4aOO9Ri2YRuZByda3KO2Y9XdEAX=uht-tRRA@mail.gmail.com>
Subject: Re: [PATCH 3/8] drm/amdgpu: add support for NBIO IP version 7.11.5
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
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

On Thu, May 28, 2026 at 2:49=E2=80=AFAM Pratik Vishwakarma
<Pratik.Vishwakarma@amd.com> wrote:
>
> This initializes NBIO IP version 7.11.5.
>
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   1 +
>  drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c      | 148 +++++++++++++-----
>  2 files changed, 113 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index e23eda0c4ea5..32ceab25ad29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -3202,6 +3202,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_de=
vice *adev)
>                 break;
>         case IP_VERSION(6, 3, 1):
>         case IP_VERSION(7, 11, 4):
> +       case IP_VERSION(7, 11, 5):
>                 adev->nbio.funcs =3D &nbif_v6_3_1_funcs;
>                 adev->nbio.hdp_flush_reg =3D &nbif_v6_3_1_hdp_flush_reg;
>                 break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/a=
md/amdgpu/nbif_v6_3_1.c
> index 28a99b52f59f..d6c7234393a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
> @@ -57,12 +57,50 @@
>  #define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10                    =
                                          0x0021
>  #define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10_BASE_IDX           =
                                          2
>
> +#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH_nbio_7_11_5  =
                                    0x8e13
> +#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH_nbio_7_11_5_B=
ASE_IDX                             5
> +#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW_nbio_7_11_5   =
                                    0x8e14
> +#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW_nbio_7_11_5_BA=
SE_IDX                              5
> +#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL_nbio_7_11_5       =
                                    0x8e15
> +#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL_nbio_7_11_5_BASE_I=
DX                                  5
> +
> +#define regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL_nbio_7_11_5                 =
                                    0x8e4d
> +#define regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL_nbio_7_11_5_BASE_IDX        =
                                    5
> +#define regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL_nbio_7_11_5                 =
                                    0x8e4e
> +#define regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL_nbio_7_11_5_BASE_IDX        =
                                    5
> +
> +#define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbio_7_11_5                  =
                                    0xd000
> +#define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbio_7_11_5_BASE_IDX         =
                                    5
> +
> +#define regBIF_BX0_BIF_FB_EN_nbio_7_11_5                                =
                                    0x8e20
> +#define regBIF_BX0_BIF_FB_EN_nbio_7_11_5_BASE_IDX                       =
                                    5
> +
> +#define regBIF_BX0_INTERRUPT_CNTL_nbio_7_11_5                           =
                                    0x8e11
> +#define regBIF_BX0_INTERRUPT_CNTL_nbio_7_11_5_BASE_IDX                  =
                                    5
> +#define regBIF_BX0_INTERRUPT_CNTL2_nbio_7_11_5                          =
                                    0x8e12
> +#define regBIF_BX0_INTERRUPT_CNTL2_nbio_7_11_5_BASE_IDX                 =
                                    5
> +
> +#define regBIF_BX_PF0_GPU_HDP_FLUSH_REQ_nbio_7_11_5                     =
                                    0x8e26
> +#define regBIF_BX_PF0_GPU_HDP_FLUSH_REQ_nbio_7_11_5_BASE_IDX            =
                                    5
> +#define regBIF_BX_PF0_GPU_HDP_FLUSH_DONE_nbio_7_11_5                    =
                                    0x8e27
> +#define regBIF_BX_PF0_GPU_HDP_FLUSH_DONE_nbio_7_11_5_BASE_IDX           =
                                    5
> +
> +#define regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL_nbio_7_11_5          =
                                    0x8e17
> +#define regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL_nbio_7_11_5_BASE_IDX =
                                    5
> +
>  static void nbif_v6_3_1_remap_hdp_registers(struct amdgpu_device *adev)
>  {
> -       WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
> -               adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLU=
SH_CNTL);
> -       WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
> -               adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLU=
SH_CNTL);
> +       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(7, 11=
, 5)) {
> +               WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL=
_nbio_7_11_5,
> +                       adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP=
_MEM_FLUSH_CNTL);
> +               WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL=
_nbio_7_11_5,
> +                       adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP=
_REG_FLUSH_CNTL);
> +       } else {
> +               WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL=
,
> +                       adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP=
_MEM_FLUSH_CNTL);
> +               WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL=
,
> +                       adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP=
_REG_FLUSH_CNTL);
> +       }
>  }
>
>  static u32 nbif_v6_3_1_get_rev_id(struct amdgpu_device *adev)
> @@ -71,6 +109,8 @@ static u32 nbif_v6_3_1_get_rev_id(struct amdgpu_device=
 *adev)
>
>         if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(7, 11=
, 4))
>                 tmp =3D RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0=
_STRAP0_nbif_4_10);
> +       else if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(=
7, 11, 5))
> +               tmp =3D RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0=
_STRAP0_nbio_7_11_5);
>         else
>                 tmp =3D RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0=
_STRAP0);
>
> @@ -82,12 +122,21 @@ static u32 nbif_v6_3_1_get_rev_id(struct amdgpu_devi=
ce *adev)
>
>  static void nbif_v6_3_1_mc_access_enable(struct amdgpu_device *adev, boo=
l enable)
>  {
> -       if (enable)
> -               WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN,
> -                            BIF_BX0_BIF_FB_EN__FB_READ_EN_MASK |
> -                            BIF_BX0_BIF_FB_EN__FB_WRITE_EN_MASK);
> -       else
> -               WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN, 0);
> +       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(7, 11=
, 5)) {
> +               if (enable)
> +                       WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN_nbio_7=
_11_5,
> +                                    BIF_BX0_BIF_FB_EN__FB_READ_EN_MASK |
> +                                    BIF_BX0_BIF_FB_EN__FB_WRITE_EN_MASK)=
;
> +               else
> +                       WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN_nbio_7=
_11_5, 0);
> +       } else {
> +               if (enable)
> +                       WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN,
> +                                    BIF_BX0_BIF_FB_EN__FB_READ_EN_MASK |
> +                                    BIF_BX0_BIF_FB_EN__FB_WRITE_EN_MASK)=
;
> +               else
> +                       WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN, 0);
> +       }
>  }
>
>  static u32 nbif_v6_3_1_get_memsize(struct amdgpu_device *adev)
> @@ -100,8 +149,14 @@ static void nbif_v6_3_1_sdma_doorbell_range(struct a=
mdgpu_device *adev,
>                                             int doorbell_index,
>                                             int doorbell_size)
>  {
> +       u32 doorbell_range;
>         if (instance =3D=3D 0) {
> -               u32 doorbell_range =3D RREG32_SOC15(NBIO, 0, regGDC_S2A0_=
S2A_DOORBELL_ENTRY_2_CTRL);
> +               if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >=3D IP_VERSION=
(7, 11, 4))
> +                       doorbell_range =3D RREG32_SOC15(NBIO, 0,
> +                                       regGDC_S2A0_S2A_DOORBELL_ENTRY_2_=
CTRL_nbif_4_10);
> +               else
> +                       doorbell_range =3D RREG32_SOC15(NBIO, 0,
> +                                       regGDC_S2A0_S2A_DOORBELL_ENTRY_2_=
CTRL);
>
>                 if (use_doorbell) {
>                         doorbell_range =3D REG_SET_FIELD(doorbell_range,
> @@ -130,11 +185,10 @@ static void nbif_v6_3_1_sdma_doorbell_range(struct =
amdgpu_device *adev,
>                                                        S2A_DOORBELL_PORT2=
_RANGE_SIZE,
>                                                        0);
>
> -               if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSI=
ON(7, 11, 4)) {
> +               if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >=3D IP_VERSION=
(7, 11, 4))
>                         WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_EN=
TRY_2_CTRL_nbif_4_10, doorbell_range);
> -               } else {
> +               else
>                         WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_EN=
TRY_2_CTRL, doorbell_range);
> -               }
>         }
>  }
>
> @@ -179,14 +233,15 @@ static void nbif_v6_3_1_vcn_doorbell_range(struct a=
mdgpu_device *adev,
>                                                S2A_DOORBELL_PORT4_RANGE_S=
IZE,
>                                                0);
>
> -       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(7, 11=
, 4)) {
> -               WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CT=
RL_nbif_4_10, doorbell_range);
> -       } else {
> +       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >=3D IP_VERSION(7, 11, =
4))
> +               WREG32_SOC15(NBIO, 0,
> +                               regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL_nbi=
f_4_10,
> +                               doorbell_range);
> +       else
>                 if (instance)
>                         WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_EN=
TRY_5_CTRL, doorbell_range);
>                 else
>                         WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_EN=
TRY_4_CTRL, doorbell_range);
> -       }
>  }
>
>  static void nbif_v6_3_1_vpe_doorbell_range(struct amdgpu_device *adev,
> @@ -236,7 +291,7 @@ static void nbif_v6_3_1_vpe_doorbell_range(struct amd=
gpu_device *adev,
>
>  static void nbif_v6_3_1_gc_doorbell_init(struct amdgpu_device *adev)
>  {
> -       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(7, 11=
, 4)) {
> +       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >=3D IP_VERSION(7, 11, =
4)) {
>                 WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CT=
RL_nbif_4_10, 0x30000007);
>                 WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CT=
RL_nbif_4_10, 0x3000000d);
>         } else {
> @@ -278,7 +333,13 @@ nbif_v6_3_1_enable_doorbell_selfring_aperture(struct=
 amdgpu_device *adev,
>  static void nbif_v6_3_1_ih_doorbell_range(struct amdgpu_device *adev,
>                                           bool use_doorbell, int doorbell=
_index)
>  {
> -       u32 ih_doorbell_range =3D RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_D=
OORBELL_ENTRY_1_CTRL);
> +       u32 ih_doorbell_range;
> +
> +       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >=3D IP_VERSION(7, 11, =
4))
> +               ih_doorbell_range =3D RREG32_SOC15(NBIO, 0,
> +                               regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL_nbi=
f_4_10);
> +       else
> +               ih_doorbell_range =3D RREG32_SOC15(NBIO, 0, regGDC_S2A0_S=
2A_DOORBELL_ENTRY_1_CTRL);
>
>         if (use_doorbell) {
>                 ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range,
> @@ -307,11 +368,11 @@ static void nbif_v6_3_1_ih_doorbell_range(struct am=
dgpu_device *adev,
>                                                   S2A_DOORBELL_PORT1_RANG=
E_SIZE,
>                                                   0);
>
> -       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(7, 11=
, 4)) {
> -               WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CT=
RL_nbif_4_10, ih_doorbell_range);
> -       } else {
> +       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >=3D IP_VERSION(7, 11, =
4))
> +               WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CT=
RL_nbif_4_10,
> +                               ih_doorbell_range);
> +       else
>                 WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CT=
RL, ih_doorbell_range);
> -       }
>  }
>
>  static void nbif_v6_3_1_ih_control(struct amdgpu_device *adev)
> @@ -319,9 +380,13 @@ static void nbif_v6_3_1_ih_control(struct amdgpu_dev=
ice *adev)
>         u32 interrupt_cntl;
>
>         /* setup interrupt control */
> -       WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL2, adev->dummy_pag=
e_addr >> 8);
> +       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(7, 11=
, 5))
> +               WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL2_nbio_7_1=
1_5,
> +                               adev->dummy_page_addr >> 8);
> +       else
> +               WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL2, adev->d=
ummy_page_addr >> 8);
>
> -       interrupt_cntl =3D RREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNT=
L);
> +       interrupt_cntl =3D RREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNT=
L_nbio_7_11_5);
>         /*
>          * BIF_BX0_INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE_MASK=3D0 - dummy =
read disabled with msi, enabled without msi
>          * BIF_BX0_INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE_MASK=3D1 - dummy =
read controlled by IH_DUMMY_RD_EN
> @@ -333,7 +398,10 @@ static void nbif_v6_3_1_ih_control(struct amdgpu_dev=
ice *adev)
>         interrupt_cntl =3D REG_SET_FIELD(interrupt_cntl, BIF_BX0_INTERRUP=
T_CNTL,
>                                        IH_REQ_NONSNOOP_EN, 0);
>
> -       WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL, interrupt_cntl);
> +       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(7, 11=
, 5))
> +               WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL_nbio_7_11=
_5, interrupt_cntl);
> +       else
> +               WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL, interrup=
t_cntl);
>  }
>
>  static void
> @@ -356,27 +424,31 @@ nbif_v6_3_1_get_clockgating_state(struct amdgpu_dev=
ice *adev,
>
>  static u32 nbif_v6_3_1_get_hdp_flush_req_offset(struct amdgpu_device *ad=
ev)
>  {
> -       return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_REQ)=
;
> +       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(7, 11=
, 5))
> +               return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FL=
USH_REQ_nbio_7_11_5);
> +       else
> +               return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FL=
USH_REQ);
>  }
>
>  static u32 nbif_v6_3_1_get_hdp_flush_done_offset(struct amdgpu_device *a=
dev)
>  {
> -       return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_DONE=
);
> +       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(7, 11=
, 5))
> +               return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FL=
USH_DONE_nbio_7_11_5);
> +       else
> +               return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FL=
USH_DONE);
>  }
>
>  static u32 nbif_v6_3_1_get_pcie_index_offset(struct amdgpu_device *adev)
>  {
> -       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(7, 11=
, 4)) {
> +       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >=3D IP_VERSION(7, 11, =
4))
>                 return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_INDEX);
> -       }
> -       else {
> +       else
>                 return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_INDEX=
);
> -       }
>  }
>
>  static u32 nbif_v6_3_1_get_pcie_data_offset(struct amdgpu_device *adev)
>  {
> -       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(7, 11=
, 4))
> +       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >=3D IP_VERSION(7, 11, =
4))
>                 return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_DATA);
>         else
>                 return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_DATA)=
;
> @@ -546,8 +618,12 @@ static void nbif_v6_3_1_set_reg_remap(struct amdgpu_=
device *adev)
>                 adev->rmmio_remap.reg_offset =3D MMIO_REG_HOLE_OFFSET;
>                 adev->rmmio_remap.bus_addr =3D adev->rmmio_base + MMIO_RE=
G_HOLE_OFFSET;
>         } else {
> -               adev->rmmio_remap.reg_offset =3D SOC15_REG_OFFSET(NBIO, 0=
,
> -                       regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
> +               if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSI=
ON(7, 11, 5))
> +                       adev->rmmio_remap.reg_offset =3D SOC15_REG_OFFSET=
(NBIO, 0,
> +                               regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNT=
L_nbio_7_11_5) << 2;
> +               else
> +                       adev->rmmio_remap.reg_offset =3D SOC15_REG_OFFSET=
(NBIO, 0,
> +                               regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNT=
L) << 2;
>                 adev->rmmio_remap.bus_addr =3D 0;
>         }
>  }
> --
> 2.43.0
>
