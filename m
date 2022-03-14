Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7861CC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 21:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05BAA10E0E8;
	Mon, 14 Mar 2022 21:22:15 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7721910E0E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 21:22:13 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id s207so18799783oie.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 14:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Wu9KfT0mdoOVajICZJryME6Rio+MyiLS0QmrwsqBK5M=;
 b=eQP6CXprpOam1qJ/MXxhIuIjuSIY+O3l4JyYE6EKPh/riFk9FyT2KrY+3XxU2TtQ0s
 glx7CyGTUsO4HXnA/SDPisGlD2kYGx5vImjYi1CLKZ4q1twbqAnoGr2jamVdjqSxPHUo
 zy0n0y3YVfs10kVXShWAcJ6BDwQ/K47X8DdkPEEFYQAb4SkPYw3JgpljyfkeRT3/iQ2X
 DTKS0vLaGGaYZbREhsPaaz5ypDwOGUYr/NekquIrHpVJcKSueu/JHmaTPG/S9eG6rxEU
 A9K+iOxzzEpIBWKCxgPPLI9Ur8UaT0qtCWkF4cdUOY4GY0pSsU0WaqLHeZLeOXwe1eOv
 PAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Wu9KfT0mdoOVajICZJryME6Rio+MyiLS0QmrwsqBK5M=;
 b=C2ozZSfDDF0bd+KOwOMTv1ZcMYe0iNss8hSWU/NXttCxp4uDgQW7L0imB2GwUzZRn4
 bAiUM4jajFLus9RT9VvxdPikZAN7M+eofNIggrd/yGDBkz5Xgw1+ZV4DAa3QURWefx98
 lr46xXlYJBlVGqq9W90n29wYkldHOt1d7eCbu2qXVRSfO6/vbn9EhFj6jttOe471YTqj
 ZE4yhGsJA7XdG83y9T3bRVzznClUJZeyZArB0LfLTsARwLUGo7VlbPxLT4kYv5g4L3ng
 B8pxKtDa0yY1cNf32AgxLypICf3a4Mk3z9UaSdpyq2ZNM/5RVmh94IeGSILb5IZC/9gp
 DE7g==
X-Gm-Message-State: AOAM530g3haTmy99QT/gBkJJJrzSKBctqw1pxl1X/C7m0P4cLUbYYcmU
 3y7pSPy4fhDRbbItGmUzMHYIhSquXKCYv4n7Ao8=
X-Google-Smtp-Source: ABdhPJxBng/XjgkrUvvBmwggbN2FjbfuY8W+z9e2KiVvoAcz/nDBjxVdZo0IdqFznmIAl/L9ldzsDJzPpjzyBdPEbF4=
X-Received: by 2002:aca:d07:0:b0:2ec:eaaf:a036 with SMTP id
 7-20020aca0d07000000b002eceaafa036mr506194oin.253.1647292932612; Mon, 14 Mar
 2022 14:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220314211035.142938-1-yongqiang.sun@amd.com>
In-Reply-To: <20220314211035.142938-1-yongqiang.sun@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Mar 2022 17:22:01 -0400
Message-ID: <CADnq5_Md8v_UQUe7U40mMtuDowrc8RZZ1WsCWMNXCj+Xg4zm8g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add stolen reserved memory for MI25 SRIOV.
To: Yongqiang Sun <yongqiang.sun@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 14, 2022 at 5:10 PM Yongqiang Sun <yongqiang.sun@amd.com> wrote:
>
> MI25 SRIOV guest driver loading failed due to allocate
> memory overlaps with private memory area.

maybe instead of "private memory area", say something like "firmware
reserved area".

> Add below change to fix the issue:
> 1. Allocate stolen reserved memory for MI25 SRIOV specifically to avoid
> the memory overlap.
> 2. Move allocate reserve allocation to vbios allocation since both the
> two functions are doing similar asic type check and no need to have
> separate functions.

These could be split into two patches, one to merge
amdgpu_gmc_get_reserved_allocation() into
amdgpu_gmc_get_vbios_allocations(), and one to add the
stolen_reserved_* for vega10.

>
> Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
> Change-Id: I142127513047a3e81573eb983c510d763b548a24

With the above changes addressed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 38 ++++++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 -
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  1 -
>  3 files changed, 19 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 7c2a9555b7cc..7e4d298e8df8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -626,6 +626,13 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
>  {
>         unsigned size;
>
> +       /*
> +        * Some ASICs need to reserve a region of video memory to avoid access
> +        * from driver
> +        */
> +       adev->mman.stolen_reserved_offset = 0;
> +       adev->mman.stolen_reserved_size = 0;
> +
>         /*
>          * TODO:
>          * Currently there is a bug where some memory client outside
> @@ -636,10 +643,22 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
>          */
>         switch (adev->asic_type) {
>         case CHIP_VEGA10:
> +               adev->mman.keep_stolen_vga_memory = true;
> +               if (amdgpu_sriov_vf(adev)) {
> +                       adev->mman.stolen_reserved_offset = 0x100000;
> +                       adev->mman.stolen_reserved_size = 0x600000;
> +               }
> +               break;
>         case CHIP_RAVEN:
>         case CHIP_RENOIR:
>                 adev->mman.keep_stolen_vga_memory = true;
>                 break;
> +       case CHIP_YELLOW_CARP:
> +               if (amdgpu_discovery == 0) {
> +                       adev->mman.stolen_reserved_offset = 0x1ffb0000;
> +                       adev->mman.stolen_reserved_size = 64 * PAGE_SIZE;
> +               }
> +               break;
>         default:
>                 adev->mman.keep_stolen_vga_memory = false;
>                 break;
> @@ -760,25 +779,6 @@ uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo
>         return amdgpu_bo_gpu_offset(bo) - adev->gmc.vram_start + adev->gmc.aper_base;
>  }
>
> -void amdgpu_gmc_get_reserved_allocation(struct amdgpu_device *adev)
> -{
> -       /* Some ASICs need to reserve a region of video memory to avoid access
> -        * from driver */
> -       adev->mman.stolen_reserved_offset = 0;
> -       adev->mman.stolen_reserved_size = 0;
> -
> -       switch (adev->asic_type) {
> -       case CHIP_YELLOW_CARP:
> -               if (amdgpu_discovery == 0) {
> -                       adev->mman.stolen_reserved_offset = 0x1ffb0000;
> -                       adev->mman.stolen_reserved_size = 64 * PAGE_SIZE;
> -               }
> -               break;
> -       default:
> -               break;
> -       }
> -}
> -
>  int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
>  {
>         struct amdgpu_bo *vram_bo = NULL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 93505bb0a36c..032b0313f277 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -331,7 +331,6 @@ amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
>                               bool enable);
>
>  void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev);
> -void amdgpu_gmc_get_reserved_allocation(struct amdgpu_device *adev);
>
>  void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev);
>  uint64_t amdgpu_gmc_vram_mc2pa(struct amdgpu_device *adev, uint64_t mc_addr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index f60b7bd4dbf5..3c1d440824a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -948,7 +948,6 @@ static int gmc_v10_0_sw_init(void *handle)
>                 return r;
>
>         amdgpu_gmc_get_vbios_allocations(adev);
> -       amdgpu_gmc_get_reserved_allocation(adev);
>
>         /* Memory manager */
>         r = amdgpu_bo_init(adev);
> --
> 2.25.1
>
