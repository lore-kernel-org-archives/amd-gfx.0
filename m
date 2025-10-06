Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CADCAC5B8
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Oct 2025 17:40:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F23AC10E18F;
	Mon,  6 Oct 2025 17:40:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OudTSwSr";
	dkim-atps=neutral
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B00F10E18F
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Oct 2025 17:40:30 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id
 ada2fe7eead31-5a703bc0e3aso145656137.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Oct 2025 10:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759772429; x=1760377229; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aPBMYQ2tb+pD0AtXF28kSh4A1mjQMEq6RDqcVC/E1hg=;
 b=OudTSwSrePW1wVq46jJcgXuhvQ+U4QpDeqvB7yGSaMBXv+uEAbfadOa+4LEezG/R7s
 +5Ye6jdMCOuT7sZg8epgRw+Fsn5UtxTg394mhA6BkZb+vUHJyhoPcXPU2hMkMJMVFxvE
 sf1469fkINnzHhqYpA45U63vDjaGqaWimsg2GfLRSVBuaBpiuTcr9VbB5u5Q2uM2NQTv
 28NuavewHcXCHyYFZhclMUT9aynsvS9em+yMPNfF2TUQ/tw9ZMzkHiDWXlYeh1jD8jxl
 K/jgv9MYqtp10mC1zhi4RA4ujTyTDnol1WQr58a8QHmtCU9+ntqFvVc8UwRYbmoZJ17D
 /e/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759772429; x=1760377229;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aPBMYQ2tb+pD0AtXF28kSh4A1mjQMEq6RDqcVC/E1hg=;
 b=VtAdmHT0wD8rjn2lfHFpcZbOZ2i/JDtkMvuiDmUz8m+G9W+FdkTbvREILNxg4qdi/R
 aHEpMiRyUpc2a1lH47zVHlCbd+Tmd5g17fuXsg0h46ptZwhchNAztpZddKik/DEEBYRb
 MyJEMNC5pD7Wl1xlJlKhSK04WMpVS8+vcEMZcMPD+sN7mDG9XP+ak6H5bFynJkfjkqEq
 LaYh5qFLPYeSXU7hb470+YaNQs26ObZWS7JZiPT1+UHcHxHUkFSrgz2UwTJgSIYr0Xhl
 cj1nMkqLUvo/gxwUqFDoR/reATtMVw+13DNGHG0/YW8stDiMWCxk+YO8tZ0lLm9L5oDF
 mvMQ==
X-Gm-Message-State: AOJu0YzJ7pzsZrasXMDiQ/43n87Z3aTx5MhVt9niLn18TaZfVuFKcb1j
 AL44nYhrrt8f6dzLY1txbiKJdnqtVd0PEuipCIPrfWBYeVQDFE5i9zKA0zcd8zsyWT0PnX6THJ/
 yzFyxRw6S31E8QkAn8nNSgGnXR/JCJF0=
X-Gm-Gg: ASbGnctvlRbp5UpgfAF/mKcxrUXwNDtKXeY7nvhPBjhZR1SUI58r2nJgt6Ga4jPS8CF
 hUQFQVf9GvoMHZe4rY/7j6aV1SePSDK+woPgIaH/BioYTk7+e/JNDH/K0+NybrLmrmkHC6KntQ2
 Yx58QgaMp76Zex2tMpiPhdmgRuJz7S69WuB12vRJDB+IC7vm+yYaLHwZtjLYuo3PpvH5eebqOsH
 VcvaDOEyhjuXp1ObH6lIujZtACtWYelTGCmPUVyZw==
X-Google-Smtp-Source: AGHT+IFAv0IZoSN7+CgmI0ox8KZJAi1UL0bDx/dja6/iwmuTomdzr+ldTWbmBLSur+OM06jJRsNIBoubGbCg+JywfA4=
X-Received: by 2002:a05:6102:c89:b0:5a1:7b39:d2d6 with SMTP id
 ada2fe7eead31-5d41d0f7abfmr2010980137.4.1759772429077; Mon, 06 Oct 2025
 10:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250807000156.196220-1-yunru.pan@amd.com>
In-Reply-To: <20250807000156.196220-1-yunru.pan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Oct 2025 13:40:17 -0400
X-Gm-Features: AS18NWDkp0mcludcWi9COwouyqz7xC7QBcbColetXujz6LUYKXaaNPMVEZD9LkA
Message-ID: <CADnq5_PP5ybZQvBj7MOhiWUPiivzn8hZVv9QWLWdKWsMiZdNAw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Introduce dynamic pf-vf critical region
 handling in SRIOV
To: Ellen Pan <yunru.pan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Shravankumar.Gande@amd.com, 
 Zhigang.Luo@amd.com
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

On Wed, Aug 6, 2025 at 8:19=E2=80=AFPM Ellen Pan <yunru.pan@amd.com> wrote:
>
> 1. Updated previous layout offsets and sizes to _V1.
> 2. Added v2 layout offset enums for dynamic pf-vf critical region handlin=
g.
> 3. Added crit_region version in VF's msg[2] during REQ_INIT_DATA.
> 4. Added support to init critical region v2 during device init.
>  - After VF sends out supported crit_region version during
> REQ_INIT_DATA, PF would confirm back with provided crit_region_header
> offset and size.
>  - VF uses the offset and size to fetch critical regions' offsets in VRAM=
 and
> save to local struct.
> 5. Added support for critical region handling:
>  - Init IP discovery table from dynamic offset from init_data_table.
>  - Init VF BIOS.
>  - Init DATA exchange region for VFs.
>  - Introduced ttm to manage critical region data in a 5MB chunk.

Would be good to split this up into multiple patches.  Will make
things easier to review.  More comments below.

>
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      |  12 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   6 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   5 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  90 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   6 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 354 +++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  15 +
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h   |  93 ++++-
>  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         |  23 +-
>  9 files changed, 506 insertions(+), 98 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_bios.c
> index 00e96419fcda..2cbb24ede86e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -114,7 +114,17 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu=
_device *adev)
>
>         adev->bios =3D NULL;
>         vram_base =3D pci_resource_start(adev->pdev, 0);
> -       bios =3D ioremap_wc(vram_base, size);
> +
> +       if (amdgpu_sriov_vf(adev) && adev->virt.init_data_done) {
> +               resource_size_t bios_offset;
> +
> +               if (amdgpu_virt_get_bios_info(adev, &bios_offset, &size))
> +                       return false;
> +
> +               bios =3D ioremap_wc(vram_base + bios_offset, size);
> +       } else
> +               bios =3D ioremap_wc(vram_base, size);
> +
>         if (!bios)
>                 return false;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index f7d7e4748197..51157143135a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2716,6 +2716,12 @@ static int amdgpu_device_ip_early_init(struct amdg=
pu_device *adev)
>                 r =3D amdgpu_virt_request_full_gpu(adev, true);
>                 if (r)
>                         return r;
> +
> +               if (adev->virt.req_init_data_ver =3D=3D GPU_CRIT_REGION_V=
2) {
> +                       r =3D amdgpu_virt_init_critical_region(adev);
> +                       if (r)
> +                               return r;
> +               }
>         }
>
>         switch (adev->asic_type) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index efe0058b48ca..76d5e13aa837 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -292,6 +292,11 @@ static int amdgpu_discovery_read_binary_from_mem(str=
uct amdgpu_device *adev,
>                 }
>         }
>
> +       if ((adev->virt.req_init_data_ver =3D=3D GPU_CRIT_REGION_V2) && a=
dev->virt.init_data_done) {
> +               ret =3D amdgpu_virt_init_ip_discovery(adev, binary);
> +               return ret;
> +       }
> +
>         vram_size =3D RREG32(mmRCC_CONFIG_MEMSIZE);
>         if (!vram_size || vram_size =3D=3D U32_MAX)
>                 sz_valid =3D false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 27ab4e754b2a..6a77d63d224b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1644,6 +1644,20 @@ static void amdgpu_ttm_drv_reserve_vram_fini(struc=
t amdgpu_device *adev)
>                                                   &adev->mman.drv_vram_us=
age_va);
>  }
>
> +/**
> + * amdgpu_ttm_crit_regions_reserve_vram_fini - free crit regions reserve=
d vram
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * free crit regions reserved vram if it has been reserved.
> + */
> +static void amdgpu_ttm_crit_regions_reserve_vram_fini(struct amdgpu_devi=
ce *adev)
> +{
> +       amdgpu_bo_free_kernel(&adev->mman.crit_regions_vram_usage_reserve=
d_bo,
> +                                                 NULL,
> +                                                 &adev->mman.crit_region=
s_vram_usage_va);
> +}
> +
>  /**
>   * amdgpu_ttm_fw_reserve_vram_init - create bo vram reservation from fw
>   *
> @@ -1694,6 +1708,31 @@ static int amdgpu_ttm_drv_reserve_vram_init(struct=
 amdgpu_device *adev)
>                                           &adev->mman.drv_vram_usage_va);
>  }
>
> +/**
> + * amdgpu_ttm_crit_regions_reserve_vram_init - create bo vram reservatio=
n for critical regions
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * create bo vram reservation for critical regions.
> + */
> +static int amdgpu_ttm_crit_regions_reserve_vram_init(struct amdgpu_devic=
e *adev)
> +{
> +       u64 vram_size =3D adev->gmc.visible_vram_size;
> +
> +       adev->mman.crit_regions_vram_usage_va =3D NULL;
> +       adev->mman.crit_regions_vram_usage_reserved_bo =3D NULL;
> +
> +       if (adev->mman.crit_regions_vram_usage_size =3D=3D 0 ||
> +           adev->mman.crit_regions_vram_usage_size > vram_size)
> +               return 0;
> +
> +       return amdgpu_bo_create_kernel_at(adev,
> +                                         adev->mman.crit_regions_vram_us=
age_start_offset,
> +                                         adev->mman.crit_regions_vram_us=
age_size,
> +                                         &adev->mman.crit_regions_vram_u=
sage_reserved_bo,
> +                                         &adev->mman.crit_regions_vram_u=
sage_va);
> +}
> +
>  /*
>   * Memoy training reservation functions
>   */
> @@ -1901,31 +1940,37 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>                                 adev->gmc.visible_vram_size);
>  #endif
>
> -       /*
> -        *The reserved vram for firmware must be pinned to the specified
> -        *place on the VRAM, so reserve it early.
> -        */
> -       r =3D amdgpu_ttm_fw_reserve_vram_init(adev);
> -       if (r)
> -               return r;
> -
> -       /*
> -        *The reserved vram for driver must be pinned to the specified
> -        *place on the VRAM, so reserve it early.
> -        */
> -       r =3D amdgpu_ttm_drv_reserve_vram_init(adev);
> -       if (r)
> -               return r;
> +       if (amdgpu_sriov_vf(adev) && (adev->virt.req_init_data_ver =3D=3D=
 GPU_CRIT_REGION_V2)) {
> +               r =3D amdgpu_ttm_crit_regions_reserve_vram_init(adev);
> +               if (r)
> +                       return r;
> +       } else {
> +               /*
> +                *The reserved vram for firmware must be pinned to the sp=
ecified
> +                *place on the VRAM, so reserve it early.
> +                */
> +               r =3D amdgpu_ttm_fw_reserve_vram_init(adev);
> +               if (r)
> +                       return r;
>
> -       /*
> -        * only NAVI10 and onwards ASIC support for IP discovery.
> -        * If IP discovery enabled, a block of memory should be
> -        * reserved for IP discovey.
> -        */
> -       if (adev->mman.discovery_bin) {
> -               r =3D amdgpu_ttm_reserve_tmr(adev);
> +               /*
> +                *The reserved vram for driver must be pinned to the spec=
ified
> +                *place on the VRAM, so reserve it early.
> +                */
> +               r =3D amdgpu_ttm_drv_reserve_vram_init(adev);
>                 if (r)
>                         return r;
> +
> +               /*
> +                * only NAVI10 and onwards ASIC support for IP discovery.
> +                * If IP discovery enabled, a block of memory should be
> +                * reserved for IP discovey.
> +                */
> +               if (adev->mman.discovery_bin) {
> +                       r =3D amdgpu_ttm_reserve_tmr(adev);
> +                       if (r)
> +                               return r;
> +               }
>         }
>
>         /* allocate memory as required for VGA
> @@ -2072,6 +2117,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>                                         &adev->mman.sdma_access_ptr);
>         amdgpu_ttm_fw_reserve_vram_fini(adev);
>         amdgpu_ttm_drv_reserve_vram_fini(adev);
> +       amdgpu_ttm_crit_regions_reserve_vram_fini(adev);
>
>         if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.h
> index 2309df3f68a9..aa8ed6524386 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -100,6 +100,12 @@ struct amdgpu_mman {
>         struct amdgpu_bo        *drv_vram_usage_reserved_bo;
>         void            *drv_vram_usage_va;
>
> +       /* critical region VRAM reservation */
> +       u64             crit_regions_vram_usage_start_offset;
> +       u64             crit_regions_vram_usage_size;
> +       struct amdgpu_bo        *crit_regions_vram_usage_reserved_bo;
> +       void            *crit_regions_vram_usage_va;

Do you need these or can you just reuse mman.fw_vram_usage_* since the
two are mutually exclusive?  It would also simplify the code changed
in this patch.

Alex

> +
>         /* PAGE_SIZE'd BO for process memory r/w over SDMA. */
>         struct amdgpu_bo        *sdma_access_bo;
>         void                    *sdma_access_ptr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index 13f0cdeb59c4..24d25e4ed1b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -150,7 +150,8 @@ void amdgpu_virt_request_init_data(struct amdgpu_devi=
ce *adev)
>                 virt->ops->req_init_data(adev);
>
>         if (adev->virt.req_init_data_ver > 0)
> -               DRM_INFO("host supports REQ_INIT_DATA handshake\n");
> +               DRM_INFO("host supports REQ_INIT_DATA handshake of critic=
al_region_version %d\n",
> +                               adev->virt.req_init_data_ver);
>         else
>                 DRM_WARN("host doesn't support REQ_INIT_DATA handshake\n"=
);
>  }
> @@ -423,10 +424,14 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_=
device *adev,
>         uint32_t bp_idx, bp_cnt;
>         void *vram_usage_va =3D NULL;
>
> -       if (adev->mman.fw_vram_usage_va)
> -               vram_usage_va =3D adev->mman.fw_vram_usage_va;
> -       else
> -               vram_usage_va =3D adev->mman.drv_vram_usage_va;
> +       if (adev->virt.req_init_data_ver =3D=3D GPU_CRIT_REGION_V2) {
> +               vram_usage_va =3D adev->mman.crit_regions_vram_usage_va;
> +       } else {
> +               if (adev->mman.fw_vram_usage_va)
> +                       vram_usage_va =3D adev->mman.fw_vram_usage_va;
> +               else
> +                       vram_usage_va =3D adev->mman.drv_vram_usage_va;
> +       }
>
>         memset(&bp, 0, sizeof(bp));
>
> @@ -669,74 +674,137 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_=
device *adev)
>
>  void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
>  {
> +       uint32_t *pfvf_data =3D NULL;
> +
>         adev->virt.fw_reserve.p_pf2vf =3D NULL;
>         adev->virt.fw_reserve.p_vf2pf =3D NULL;
>         adev->virt.vf2pf_update_interval_ms =3D 0;
>         adev->virt.vf2pf_update_retry_cnt =3D 0;
>
> -       if (adev->mman.fw_vram_usage_va && adev->mman.drv_vram_usage_va) =
{
> -               DRM_WARN("Currently fw_vram and drv_vram should not have =
values at the same time!");
> -       } else if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_usa=
ge_va) {
> -               /* go through this logic in ip_init and reset to init wor=
kqueue*/
> -               amdgpu_virt_exchange_data(adev);
> -
> -               INIT_DELAYED_WORK(&adev->virt.vf2pf_work, amdgpu_virt_upd=
ate_vf2pf_work_item);
> -               schedule_delayed_work(&(adev->virt.vf2pf_work), msecs_to_=
jiffies(adev->virt.vf2pf_update_interval_ms));
> -       } else if (adev->bios !=3D NULL) {
> -               /* got through this logic in early init stage to get nece=
ssary flags, e.g. rlcg_acc related*/
> -               adev->virt.fw_reserve.p_pf2vf =3D
> -                       (struct amd_sriov_msg_pf2vf_info_header *)
> -                       (adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 1=
0));
> -
> -               amdgpu_virt_read_pf2vf_data(adev);
> +       if (adev->virt.req_init_data_ver =3D=3D GPU_CRIT_REGION_V2) {
> +               if (adev->mman.crit_regions_vram_usage_va) {
> +                       /* go through this logic in ip_init and reset to =
init workqueue*/
> +                       amdgpu_virt_exchange_data(adev);
> +
> +                       INIT_DELAYED_WORK(&adev->virt.vf2pf_work,
> +                                       amdgpu_virt_update_vf2pf_work_ite=
m);
> +                       schedule_delayed_work(&(adev->virt.vf2pf_work),
> +                                       msecs_to_jiffies(adev->virt.vf2pf=
_update_interval_ms));
> +               } else if (adev->bios !=3D NULL) {
> +                       /* got through this logic in early init stage to =
get necessary flags,
> +                        * e.g. rlcg_acc related */
> +                       pfvf_data =3D
> +                               kzalloc(adev->virt.crit_region_sizes_kb[A=
MD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID] << 10,
> +                                       GFP_KERNEL);
> +                       if (!pfvf_data) {
> +                               DRM_ERROR("Failed to allocate memory for =
pfvf_data\n");
> +                               return;
> +                       }
> +
> +                       if (amdgpu_virt_read_exchange_data_from_mem(adev,=
 pfvf_data))
> +                               goto free_pfvf_data;
> +
> +                       adev->virt.fw_reserve.p_pf2vf =3D
> +                               (struct amd_sriov_msg_pf2vf_info_header *=
)pfvf_data;
> +
> +                       amdgpu_virt_read_pf2vf_data(adev);
> +
> +free_pfvf_data:
> +                       kfree(pfvf_data);
> +                       pfvf_data =3D NULL;
> +                       adev->virt.fw_reserve.p_pf2vf =3D NULL;
> +               }
> +       } else {
> +               if (adev->mman.fw_vram_usage_va && adev->mman.drv_vram_us=
age_va) {
> +                       DRM_WARN("Currently fw_vram and drv_vram should n=
ot have values "
> +                                       "at the same time!");
> +               } else if (adev->mman.fw_vram_usage_va || adev->mman.drv_=
vram_usage_va) {
> +                       /* go through this logic in ip_init and reset to =
init workqueue*/
> +                       amdgpu_virt_exchange_data(adev);
> +
> +                       INIT_DELAYED_WORK(&adev->virt.vf2pf_work,
> +                               amdgpu_virt_update_vf2pf_work_item);
> +                       schedule_delayed_work(&(adev->virt.vf2pf_work),
> +                                       msecs_to_jiffies(adev->virt.vf2pf=
_update_interval_ms));
> +               } else if (adev->bios !=3D NULL) {
> +                       /* got through this logic in early init stage to =
get necessary flags,
> +                        * e.g. rlcg_acc related*/
> +                       adev->virt.fw_reserve.p_pf2vf =3D
> +                               (struct amd_sriov_msg_pf2vf_info_header *=
)
> +                               (adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET=
_KB_V1 << 10));
> +
> +                       amdgpu_virt_read_pf2vf_data(adev);
> +               }
>         }
>  }
>
> -
>  void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
>  {
>         uint64_t bp_block_offset =3D 0;
>         uint32_t bp_block_size =3D 0;
>         struct amd_sriov_msg_pf2vf_info *pf2vf_v2 =3D NULL;
>
> -       if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_usage_va) =
{
> -               if (adev->mman.fw_vram_usage_va) {
> +       if (adev->virt.req_init_data_ver =3D=3D GPU_CRIT_REGION_V2) {
> +               if (adev->mman.crit_regions_vram_usage_va) {
>                         adev->virt.fw_reserve.p_pf2vf =3D
>                                 (struct amd_sriov_msg_pf2vf_info_header *=
)
> -                               (adev->mman.fw_vram_usage_va + (AMD_SRIOV=
_MSG_PF2VF_OFFSET_KB << 10));
> +                               (adev->mman.crit_regions_vram_usage_va +
> +                               adev->virt.crit_region_offsets[AMD_SRIOV_=
MSG_DATAEXCHANGE_TABLE_ID]);
>                         adev->virt.fw_reserve.p_vf2pf =3D
>                                 (struct amd_sriov_msg_vf2pf_info_header *=
)
> -                               (adev->mman.fw_vram_usage_va + (AMD_SRIOV=
_MSG_VF2PF_OFFSET_KB << 10));
> +                               (adev->mman.crit_regions_vram_usage_va +
> +                               adev->virt.crit_region_offsets[AMD_SRIOV_=
MSG_DATAEXCHANGE_TABLE_ID] +
> +                               (AMD_SRIOV_MSG_SIZE_KB_V1 << 10));
>                         adev->virt.fw_reserve.ras_telemetry =3D
> -                               (adev->mman.fw_vram_usage_va + (AMD_SRIOV=
_MSG_RAS_TELEMETRY_OFFSET_KB << 10));
> -               } else if (adev->mman.drv_vram_usage_va) {
> -                       adev->virt.fw_reserve.p_pf2vf =3D
> -                               (struct amd_sriov_msg_pf2vf_info_header *=
)
> -                               (adev->mman.drv_vram_usage_va + (AMD_SRIO=
V_MSG_PF2VF_OFFSET_KB << 10));
> -                       adev->virt.fw_reserve.p_vf2pf =3D
> -                               (struct amd_sriov_msg_vf2pf_info_header *=
)
> -                               (adev->mman.drv_vram_usage_va + (AMD_SRIO=
V_MSG_VF2PF_OFFSET_KB << 10));
> -                       adev->virt.fw_reserve.ras_telemetry =3D
> -                               (adev->mman.drv_vram_usage_va + (AMD_SRIO=
V_MSG_RAS_TELEMETRY_OFFSET_KB << 10));
> +                               (adev->mman.crit_regions_vram_usage_va +
> +                               adev->virt.crit_region_offsets[AMD_SRIOV_=
MSG_RAS_TELEMETRY_TABLE_ID]);
> +               }
> +       } else {
> +               if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_us=
age_va) {
> +                       if (adev->mman.fw_vram_usage_va) {
> +                               adev->virt.fw_reserve.p_pf2vf =3D
> +                                       (struct amd_sriov_msg_pf2vf_info_=
header *)
> +                                       (adev->mman.fw_vram_usage_va +
> +                                       (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1=
 << 10));
> +                               adev->virt.fw_reserve.p_vf2pf =3D
> +                                       (struct amd_sriov_msg_vf2pf_info_=
header *)
> +                                       (adev->mman.fw_vram_usage_va +
> +                                       (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1=
 << 10));
> +                               adev->virt.fw_reserve.ras_telemetry =3D
> +                                       (adev->mman.fw_vram_usage_va +
> +                                        (AMD_SRIOV_MSG_RAS_TELEMETRY_OFF=
SET_KB_V1 << 10));
> +                       } else if (adev->mman.drv_vram_usage_va) {
> +                               adev->virt.fw_reserve.p_pf2vf =3D
> +                                       (struct amd_sriov_msg_pf2vf_info_=
header *)
> +                                       (adev->mman.drv_vram_usage_va +
> +                                       (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1=
 << 10));
> +                               adev->virt.fw_reserve.p_vf2pf =3D
> +                                       (struct amd_sriov_msg_vf2pf_info_=
header *)
> +                                       (adev->mman.drv_vram_usage_va +
> +                                       (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1=
 << 10));
> +                               adev->virt.fw_reserve.ras_telemetry =3D
> +                                       (adev->mman.drv_vram_usage_va +
> +                                        (AMD_SRIOV_MSG_RAS_TELEMETRY_OFF=
SET_KB_V1 << 10));
> +                       }
>                 }
> +       }
>
> -               amdgpu_virt_read_pf2vf_data(adev);
> -               amdgpu_virt_write_vf2pf_data(adev);
> +       amdgpu_virt_read_pf2vf_data(adev);
> +       amdgpu_virt_write_vf2pf_data(adev);
>
> -               /* bad page handling for version 2 */
> -               if (adev->virt.fw_reserve.p_pf2vf->version =3D=3D 2) {
> -                       pf2vf_v2 =3D (struct amd_sriov_msg_pf2vf_info *)a=
dev->virt.fw_reserve.p_pf2vf;
> +       /* bad page handling for version 2 */
> +       if (adev->virt.fw_reserve.p_pf2vf->version =3D=3D 2) {
> +               pf2vf_v2 =3D (struct amd_sriov_msg_pf2vf_info *)adev->vir=
t.fw_reserve.p_pf2vf;
>
> -                       bp_block_offset =3D ((uint64_t)pf2vf_v2->bp_block=
_offset_low & 0xFFFFFFFF) |
> -                               ((((uint64_t)pf2vf_v2->bp_block_offset_hi=
gh) << 32) & 0xFFFFFFFF00000000);
> -                       bp_block_size =3D pf2vf_v2->bp_block_size;
> +               bp_block_offset =3D ((uint64_t)pf2vf_v2->bp_block_offset_=
low & 0xFFFFFFFF) |
> +                       ((((uint64_t)pf2vf_v2->bp_block_offset_high) << 3=
2) & 0xFFFFFFFF00000000);
> +               bp_block_size =3D pf2vf_v2->bp_block_size;
>
> -                       if (bp_block_size && !adev->virt.ras_init_done)
> -                               amdgpu_virt_init_ras_err_handler_data(ade=
v);
> +               if (bp_block_size && !adev->virt.ras_init_done)
> +                       amdgpu_virt_init_ras_err_handler_data(adev);
>
> -                       if (adev->virt.ras_init_done)
> -                               amdgpu_virt_add_bad_page(adev, bp_block_o=
ffset, bp_block_size);
> -               }
> +               if (adev->virt.ras_init_done)
> +                       amdgpu_virt_add_bad_page(adev, bp_block_offset, b=
p_block_size);
>         }
>  }
>
> @@ -839,6 +907,192 @@ static void amdgpu_virt_init_ras(struct amdgpu_devi=
ce *adev)
>         adev->virt.ras.cper_rptr =3D 0;
>  }
>
> +static uint8_t amdgpu_virt_crit_region_calc_checksum(uint8_t *buf_start,=
 uint8_t *buf_end)
> +{
> +       uint32_t sum =3D 0;
> +
> +       if (buf_start >=3D buf_end)
> +               return 0;
> +
> +       for (; buf_start < buf_end; buf_start++)
> +               sum +=3D buf_start[0];
> +
> +       return 0xffffffff - sum;
> +}
> +
> +#define mmRCC_CONFIG_MEMSIZE   0xde3
> +int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
> +{
> +       struct amd_sriov_msg_init_data_header *init_data_hdr =3D NULL;
> +       uint32_t init_hdr_offset =3D adev->virt.init_data_header_offset;
> +       uint32_t init_hdr_size =3D adev->virt.init_data_header_size_kb <<=
 10;
> +       uint64_t pos =3D 0;
> +       uint64_t vram_size;
> +       int r =3D 0;
> +       uint8_t checksum =3D 0;
> +
> +       if (init_hdr_offset < 0) {
> +               DRM_ERROR("Invalid init header offset\n");
> +               return -EINVAL;
> +       }
> +
> +       vram_size =3D RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
> +       if ((init_hdr_offset + init_hdr_size) > vram_size) {
> +               DRM_ERROR("init_data_header exceeds VRAM size, exiting\n"=
);
> +               return -EINVAL;
> +       }
> +
> +       /* Allocate for init_data_hdr */
> +       init_data_hdr =3D kzalloc(sizeof(struct amd_sriov_msg_init_data_h=
eader), GFP_KERNEL);
> +       if (!init_data_hdr)
> +               return -ENOMEM;
> +
> +       pos =3D (uint64_t)init_hdr_offset;
> +       amdgpu_device_vram_access(adev, pos, (uint32_t *)init_data_hdr,
> +                                       sizeof(struct amd_sriov_msg_init_=
data_header), false);
> +
> +       switch (init_data_hdr->version) {
> +       case GPU_CRIT_REGION_V2:
> +               if (strncmp(init_data_hdr->signature, "INDA", 4) !=3D 0) =
{
> +                       DRM_ERROR("Invalid init data signature: %.4s\n", =
init_data_hdr->signature);
> +                       r =3D -EINVAL;
> +                       goto out;
> +               }
> +
> +               checksum =3D
> +                       amdgpu_virt_crit_region_calc_checksum((uint8_t *)=
&init_data_hdr->initdata_offset,
> +                               (uint8_t *)init_data_hdr + sizeof(struct =
amd_sriov_msg_init_data_header));
> +               if (checksum !=3D init_data_hdr->checksum) {
> +                       DRM_ERROR("Found unmatching checksum from calcula=
tion 0x%x and init_data 0x%x\n",
> +                                               checksum, init_data_hdr->=
checksum);
> +                       r =3D -EINVAL;
> +                       goto out;
> +               }
> +
> +               /* Initialize critical region offsets */
> +               adev->virt.crit_region_base_offset =3D init_data_hdr->ini=
tdata_offset;
> +               adev->virt.crit_region_offsets[AMD_SRIOV_MSG_IPD_TABLE_ID=
] =3D
> +                       init_data_hdr->ip_discovery_offset;
> +               adev->virt.crit_region_offsets[AMD_SRIOV_MSG_VBIOS_IMG_TA=
BLE_ID] =3D
> +                       init_data_hdr->vbios_img_offset;
> +               adev->virt.crit_region_offsets[AMD_SRIOV_MSG_RAS_TELEMETR=
Y_TABLE_ID] =3D
> +                       init_data_hdr->ras_tele_info_offset;
> +               adev->virt.crit_region_offsets[AMD_SRIOV_MSG_DATAEXCHANGE=
_TABLE_ID] =3D
> +                       init_data_hdr->dataexchange_offset;
> +               adev->virt.crit_region_offsets[AMD_SRIOV_MSG_BAD_PAGE_INF=
O_TABLE_ID] =3D
> +                       init_data_hdr->bad_page_info_offset;
> +
> +               /* Initialize critical region sizes */
> +               adev->virt.crit_region_size_in_kb =3D init_data_hdr->init=
data_size_in_kb;
> +               adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_IPD_TABLE_I=
D] =3D
> +                       init_data_hdr->ip_discovery_size_in_kb;
> +               adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_VBIOS_IMG_T=
ABLE_ID] =3D
> +                       init_data_hdr->vbios_img_size_in_kb;
> +               adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_RAS_TELEMET=
RY_TABLE_ID] =3D
> +                       init_data_hdr->ras_tele_info_size_in_kb;
> +               adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_DATAEXCHANG=
E_TABLE_ID] =3D
> +                       init_data_hdr->dataexchange_size_in_kb;
> +               adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_BAD_PAGE_IN=
FO_TABLE_ID] =3D
> +                       init_data_hdr->bad_page_size_in_kb;
> +
> +               /* reserved memory starts from crit region base offset  w=
ith the size of 5MB */
> +               adev->mman.crit_regions_vram_usage_start_offset =3D adev-=
>virt.crit_region_base_offset;
> +               adev->mman.crit_regions_vram_usage_size =3D adev->virt.cr=
it_region_size_in_kb << 10;
> +               DRM_INFO("critical region v%d requested to reserve memory=
 start at %08x with %d KB.\n",
> +                         init_data_hdr->version,
> +                         adev->mman.crit_regions_vram_usage_start_offset=
,
> +                         adev->mman.crit_regions_vram_usage_size >> 10);
> +
> +               adev->virt.init_data_done =3D true;
> +               break;
> +       default:
> +               DRM_ERROR("Invalid init header version: 0x%x\n", init_dat=
a_hdr->version);
> +               r =3D -EINVAL;
> +               goto out;
> +       }
> +
> +out:
> +       kfree(init_data_hdr);
> +       init_data_hdr =3D NULL;
> +
> +       return r;
> +}
> +
> +int amdgpu_virt_init_ip_discovery(struct amdgpu_device *adev, uint8_t *b=
inary)
> +{
> +       uint32_t ip_discovery_offset =3D
> +               adev->virt.crit_region_offsets[AMD_SRIOV_MSG_IPD_TABLE_ID=
];
> +       uint32_t ip_discovery_size =3D
> +               adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_IPD_TABLE_I=
D] << 10;
> +       uint64_t pos =3D 0;
> +
> +       dev_info(adev->dev, "use ip discovery information copied from dyn=
amic "
> +               "crit_region_table at offset 0x%x with size of 0x%x bytes=
.\n",
> +                       ip_discovery_offset, ip_discovery_size);
> +
> +       if (!IS_ALIGNED(ip_discovery_offset, 4) || !IS_ALIGNED(ip_discove=
ry_size, 4)) {
> +               DRM_ERROR("IP discovery data not aligned to 4 bytes\n");
> +               return -EINVAL;
> +       }
> +
> +       if (ip_discovery_size > DISCOVERY_TMR_SIZE) {
> +               DRM_ERROR("Invalid IP discovery size: 0x%x\n", ip_discove=
ry_size);
> +               return -EINVAL;
> +       }
> +
> +       pos =3D (uint64_t)ip_discovery_offset;
> +       amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
> +                                         ip_discovery_size, false);
> +
> +       return 0;
> +}
> +
> +int amdgpu_virt_get_bios_info(struct amdgpu_device *adev,
> +               resource_size_t *bios_offset, resource_size_t *bios_size)
> +{
> +       uint32_t vbios_offset =3D adev->virt.crit_region_offsets[AMD_SRIO=
V_MSG_VBIOS_IMG_TABLE_ID];
> +       uint32_t vbios_size =3D
> +               adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_VBIOS_IMG_T=
ABLE_ID] << 10;
> +
> +       dev_info(adev->dev, "use bios information copied from dynamic "
> +               "crit_region_table at offset 0x%x with size of 0x%x bytes=
.\n",
> +                       vbios_offset, vbios_size);
> +
> +       if (vbios_size > *bios_size) {
> +               DRM_ERROR("Invalid vbios size: 0x%x\n", vbios_size);
> +               return -EINVAL;
> +       }
> +
> +       *bios_offset =3D vbios_offset;
> +       *bios_size =3D vbios_size;
> +
> +       return 0;
> +}
> +
> +int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev, =
uint32_t *pfvf_data)
> +{
> +       uint32_t dataexchange_offset =3D
> +               adev->virt.crit_region_offsets[AMD_SRIOV_MSG_DATAEXCHANGE=
_TABLE_ID];
> +       uint32_t dataexchange_size =3D
> +               adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_DATAEXCHANG=
E_TABLE_ID] << 10;
> +       uint64_t pos =3D 0;
> +
> +       dev_info(adev->dev, "use data exchange information copied from dy=
namic "
> +               "crit_region_table at offset 0x%x with size of 0x%x bytes=
.\n",
> +                       dataexchange_offset, dataexchange_size);
> +
> +       if (!IS_ALIGNED(dataexchange_offset, 4) || !IS_ALIGNED(dataexchan=
ge_size, 4)) {
> +               DRM_ERROR("Data exchange data not aligned to 4 bytes\n");
> +               return -EINVAL;
> +       }
> +
> +       pos =3D (uint64_t)dataexchange_offset;
> +       amdgpu_device_vram_access(adev, pos, pfvf_data,
> +                                       dataexchange_size, false);
> +
> +       return 0;
> +}
> +
>  void amdgpu_virt_init(struct amdgpu_device *adev)
>  {
>         bool is_sriov =3D false;
> @@ -1301,7 +1555,7 @@ static int amdgpu_virt_cache_host_error_counts(stru=
ct amdgpu_device *adev,
>         checksum =3D host_telemetry->header.checksum;
>         used_size =3D host_telemetry->header.used_size;
>
> -       if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
> +       if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB_V1 << 10))
>                 return 0;
>
>         tmp =3D kmemdup(&host_telemetry->body.error_count, used_size, GFP=
_KERNEL);
> @@ -1380,7 +1634,7 @@ amdgpu_virt_write_cpers_to_ring(struct amdgpu_devic=
e *adev,
>         checksum =3D host_telemetry->header.checksum;
>         used_size =3D host_telemetry->header.used_size;
>
> -       if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
> +       if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB_V1 << 10))
>                 return -EINVAL;
>
>         cper_dump =3D kmemdup(&host_telemetry->body.cper_dump, used_size,=
 GFP_KERNEL);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.h
> index 3da3ebb1d9a1..f1498671e8a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -281,6 +281,15 @@ struct amdgpu_virt {
>         bool ras_init_done;
>         uint32_t reg_access;
>
> +       /* critical regions v2 */
> +       uint32_t init_data_header_offset;
> +       uint32_t init_data_header_size_kb;
> +       uint32_t crit_region_base_offset;
> +       uint32_t crit_region_size_in_kb;
> +       uint64_t crit_region_offsets[AMD_SRIOV_MSG_MAX_TABLE_ID];
> +       uint64_t crit_region_sizes_kb[AMD_SRIOV_MSG_MAX_TABLE_ID];
> +       bool init_data_done;
> +
>         /* vf2pf message */
>         struct delayed_work vf2pf_work;
>         uint32_t vf2pf_update_interval_ms;
> @@ -416,6 +425,12 @@ void amdgpu_virt_exchange_data(struct amdgpu_device =
*adev);
>  void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
>  void amdgpu_virt_init(struct amdgpu_device *adev);
>
> +int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
> +int amdgpu_virt_init_ip_discovery(struct amdgpu_device *adev, uint8_t *b=
inary);
> +int amdgpu_virt_get_bios_info(struct amdgpu_device *adev,
> +                                         resource_size_t *bios_offset, r=
esource_size_t *bios_size);
> +int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev, =
uint32_t *pfvf_data);
> +
>  bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
>  int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
>  void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgv_sriovmsg.h
> index 33edad1f9dcd..130f188ebb84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -23,26 +23,83 @@
>  #ifndef AMDGV_SRIOV_MSG__H_
>  #define AMDGV_SRIOV_MSG__H_
>
> -/* unit in kilobytes */
> -#define AMD_SRIOV_MSG_VBIOS_OFFSET          0
> -#define AMD_SRIOV_MSG_VBIOS_SIZE_KB         64
> -#define AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB AMD_SRIOV_MSG_VBIOS_SIZE_KB
> -#define AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB   4
> -#define AMD_SRIOV_MSG_TMR_OFFSET_KB         2048
> -#define AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB      2
> -#define AMD_SRIOV_RAS_TELEMETRY_SIZE_KB             64
>  /*
> - * layout
> + * layout v1
>   * 0           64KB        65KB        66KB           68KB              =
     132KB
>   * |   VBIOS   |   PF2VF   |   VF2PF   |   Bad Page   | RAS Telemetry Re=
gion | ...
>   * |   64KB    |   1KB     |   1KB     |   2KB        | 64KB            =
     | ...
>   */
>
> -#define AMD_SRIOV_MSG_SIZE_KB                   1
> -#define AMD_SRIOV_MSG_PF2VF_OFFSET_KB           AMD_SRIOV_MSG_DATAEXCHAN=
GE_OFFSET_KB
> -#define AMD_SRIOV_MSG_VF2PF_OFFSET_KB           (AMD_SRIOV_MSG_PF2VF_OFF=
SET_KB + AMD_SRIOV_MSG_SIZE_KB)
> -#define AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB        (AMD_SRIOV_MSG_VF2PF_OFF=
SET_KB + AMD_SRIOV_MSG_SIZE_KB)
> -#define AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB   (AMD_SRIOV_MSG_BAD_PAGE_=
OFFSET_KB + AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB)
> +/*
> + * layout v2 (offsets are dynamically allocated and the offsets below ar=
e examples)
> + * 0           1KB         64KB        65KB        66KB           68KB  =
                 132KB
> + * |  INITD_H  |   VBIOS   |   PF2VF   |   VF2PF   |   Bad Page   | RAS =
Telemetry Region | ...
> + * |   1KB     |   64KB    |   1KB     |   1KB     |   2KB        | 64KB=
                 | ...
> + *
> + * Note: PF2VF + VF2PF + Bad Page =3D DataExchange region (allocated con=
tiguously)
> + */
> +
> +/* v1 layout sizes */
> +#define AMD_SRIOV_MSG_VBIOS_SIZE_KB_V1                 64
> +#define AMD_SRIOV_MSG_PF2VF_SIZE_KB_V1                 1
> +#define AMD_SRIOV_MSG_VF2PF_SIZE_KB_V1                 1
> +#define AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB_V1              2
> +#define AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1         64
> +#define AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB_V1          \
> +       (AMD_SRIOV_MSG_PF2VF_SIZE_KB_V1 + AMD_SRIOV_MSG_VF2PF_SIZE_KB_V1 =
+ \
> +        AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB_V1)
> +
> +/* v1 offsets */
> +#define AMD_SRIOV_MSG_VBIOS_OFFSET_V1                  0
> +#define AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB_V1                AMD_SRIOV=
_MSG_VBIOS_SIZE_KB_V1
> +#define AMD_SRIOV_MSG_TMR_OFFSET_KB                    2048
> +#define AMD_SRIOV_MSG_SIZE_KB_V1                       1
> +#define AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1               AMD_SRIOV_MSG_DAT=
AEXCHANGE_OFFSET_KB_V1
> +#define AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1               \
> +       (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 + AMD_SRIOV_MSG_SIZE_KB_V1)
> +#define AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB_V1            \
> +       (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 + AMD_SRIOV_MSG_SIZE_KB_V1)
> +#define AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1       \
> +       (AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB_V1 + AMD_SRIOV_MSG_BAD_PAGE_SIZ=
E_KB_V1)
> +#define AMD_SRIOV_MSG_INIT_DATA_TOT_SIZE_KB_V1         \
> +       (AMD_SRIOV_MSG_VBIOS_SIZE_KB_V1 + AMD_SRIOV_MSG_DATAEXCHANGE_SIZE=
_KB_V1 + \
> +        AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1)
> +
> +/* v2 layout offset enum (in order of allocation) */
> +enum amd_sriov_msg_table_id_enum {
> +       AMD_SRIOV_MSG_IPD_TABLE_ID =3D 0,
> +       AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID,
> +       AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID,
> +       AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID,
> +       AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID,
> +       AMD_SRIOV_MSG_INITD_H_TABLE_ID,
> +       AMD_SRIOV_MSG_MAX_TABLE_ID,
> +};
> +
> +enum amd_sriov_crit_region_version {
> +       GPU_CRIT_REGION_V1 =3D 1,
> +       GPU_CRIT_REGION_V2 =3D 2,
> +};
> +
> +struct amd_sriov_msg_init_data_header {
> +       char     signature[4];  /* "INDA"  */
> +       uint32_t version;
> +       uint32_t checksum;
> +       uint32_t initdata_offset; /* 0 */
> +       uint32_t initdata_size_in_kb; /* 5MB */
> +       uint32_t valid_tables;
> +       uint32_t vbios_img_offset;
> +       uint32_t vbios_img_size_in_kb;
> +       uint32_t dataexchange_offset;
> +       uint32_t dataexchange_size_in_kb;
> +       uint32_t ras_tele_info_offset;
> +       uint32_t ras_tele_info_size_in_kb;
> +       uint32_t ip_discovery_offset;
> +       uint32_t ip_discovery_size_in_kb;
> +       uint32_t bad_page_info_offset;
> +       uint32_t bad_page_size_in_kb;
> +       uint32_t reserved[8];
> +};
>
>  /*
>   * PF2VF history log:
> @@ -431,12 +488,12 @@ unsigned int amd_sriov_msg_checksum(void *obj, unsi=
gned long obj_size, unsigned
>  #define _stringification(s) #s
>
>  _Static_assert(
> -       sizeof(struct amd_sriov_msg_vf2pf_info) =3D=3D AMD_SRIOV_MSG_SIZE=
_KB << 10,
> -       "amd_sriov_msg_vf2pf_info must be " stringification(AMD_SRIOV_MSG=
_SIZE_KB) " KB");
> +       sizeof(struct amd_sriov_msg_vf2pf_info) =3D=3D AMD_SRIOV_MSG_SIZE=
_KB_V1 << 10,
> +       "amd_sriov_msg_vf2pf_info must be " stringification(AMD_SRIOV_MSG=
_SIZE_KB_V1) " KB");
>
>  _Static_assert(
> -       sizeof(struct amd_sriov_msg_pf2vf_info) =3D=3D AMD_SRIOV_MSG_SIZE=
_KB << 10,
> -       "amd_sriov_msg_pf2vf_info must be " stringification(AMD_SRIOV_MSG=
_SIZE_KB) " KB");
> +       sizeof(struct amd_sriov_msg_pf2vf_info) =3D=3D AMD_SRIOV_MSG_SIZE=
_KB_V1 << 10,
> +       "amd_sriov_msg_pf2vf_info must be " stringification(AMD_SRIOV_MSG=
_SIZE_KB_V1) " KB");
>
>  _Static_assert(AMD_SRIOV_MSG_RESERVE_UCODE % 4 =3D=3D 0,
>                "AMD_SRIOV_MSG_RESERVE_UCODE must be multiple of 4");
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/=
amdgpu/mxgpu_nv.c
> index f6d8597452ed..e1244cbee1c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -222,12 +222,20 @@ static int xgpu_nv_send_access_requests_with_param(=
struct amdgpu_device *adev,
>                                 adev->virt.req_init_data_ver =3D 0;
>                 } else {
>                         if (req =3D=3D IDH_REQ_GPU_INIT_DATA) {
> -                               adev->virt.req_init_data_ver =3D
> -                                       RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RC=
V_DW1);
> -
> -                               /* assume V1 in case host doesn't set ver=
sion number */
> -                               if (adev->virt.req_init_data_ver < 1)
> -                                       adev->virt.req_init_data_ver =3D =
1;
> +                               switch (RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RC=
V_DW1)) {
> +                               case GPU_CRIT_REGION_V2:
> +                                       adev->virt.req_init_data_ver =3D =
GPU_CRIT_REGION_V2;
> +                                       adev->virt.init_data_header_offse=
t =3D
> +                                               RREG32_NO_KIQ(mmMAILBOX_M=
SGBUF_RCV_DW2);
> +                                       adev->virt.init_data_header_size_=
kb =3D
> +                                               RREG32_NO_KIQ(mmMAILBOX_M=
SGBUF_RCV_DW3);
> +                                       break;
> +                               default:
> +                                       adev->virt.req_init_data_ver =3D =
GPU_CRIT_REGION_V1;
> +                                       adev->virt.init_data_header_offse=
t =3D -1;
> +                                       adev->virt.init_data_header_size_=
kb =3D 0;
> +                                       break;
> +                               }
>                         }
>                 }
>
> @@ -285,7 +293,8 @@ static int xgpu_nv_release_full_gpu_access(struct amd=
gpu_device *adev,
>
>  static int xgpu_nv_request_init_data(struct amdgpu_device *adev)
>  {
> -       return xgpu_nv_send_access_requests(adev, IDH_REQ_GPU_INIT_DATA);
> +       return xgpu_nv_send_access_requests_with_param(adev, IDH_REQ_GPU_=
INIT_DATA,
> +                       0, GPU_CRIT_REGION_V2, 0);
>  }
>
>  static int xgpu_nv_mailbox_ack_irq(struct amdgpu_device *adev,
> --
> 2.17.1
>
