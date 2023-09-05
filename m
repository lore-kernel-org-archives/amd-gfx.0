Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360BDC83F33
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 05:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9115C10E16E;
	Tue,  5 Sep 2023 05:22:34 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BD7810E16E
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 05:22:32 +0000 (UTC)
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2bbbda48904so34045521fa.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Sep 2023 22:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693891351; x=1694496151; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=npIVzyij/+KYCKpSqFFGASRV/s7Xo15DphJl3r3n7GA=;
 b=k38zJuiOIfRcMprNEyKsJGTFBhhWTwQza67gSSKADevYPcM0aX0/0MvTbaLVdnX4Ob
 oB3MAjGzDfXJcbkPzR5zeVXm3eiCIWlHW84+8OYm951NjPLbA3/1YGVAkcQLwa2ra9Vn
 1BQUl6DXu655aJ6AVyFWlNe0tc6EvLAAce+/bFCgMhSDhZxpgeXoZGNlLwfjn5MTWuW8
 +26SG7OQTjpQKMEaZM9LH7JDwb+1/ABO7dEpdtKjBLZGNdN8/jXA27n0na/Wl51bFbSZ
 ieL0eJ16ZlSEAYwH2F16tC/otLv/4wsk4eqLaCUVxeo+FS2irPnZGszaFsmYu6Ps2Wlt
 J17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693891351; x=1694496151;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=npIVzyij/+KYCKpSqFFGASRV/s7Xo15DphJl3r3n7GA=;
 b=HF4exCiKkX+n6/5q16UehbHOafV34ZfRv54F/1QJIvCu3qrnf+n+02/tc/bdCbxLvx
 6ccUT/g+4AsuYsiz4EjT4kOcJnB+rV2okRWrpod5sRu7LRmIIoQSlZtyh2BOYrpNi628
 m7ZvLTw6nAt4wvEU52v44qk30q+8GgBeusQyLfrGpYwr5+j6VUHJDWtqC6Oj538xL2jo
 RmBQgiWg1qEPu+/mXCF+1Xqh58Bg1ioOITx6OPL3rdtLf6In51zPRLwdJ8GU/ZUZtK7I
 qv5Rkc4vdz8H745DzyiTvRkGrIbmj2qrfNih3KVFbX2/w3KNnAGQHxxAsgYP58msL41g
 NR5g==
X-Gm-Message-State: AOJu0Yw0X7dY/zK0ppfhyfz7by2jQTLFF4jCeKzp4Hn7ecH/wnh7LCdt
 hmylrieYFsbmet9OUvucC7w=
X-Google-Smtp-Source: AGHT+IG5YooH+NT5d9+16BmRgjtmGW2A0bzDFe8kFnrKUuwfbRzRPzb/C97wLXAKMZPNgcMmfxafDQ==
X-Received: by 2002:a2e:87c9:0:b0:2bd:180d:67b7 with SMTP id
 v9-20020a2e87c9000000b002bd180d67b7mr7931056ljj.40.1693891350344; 
 Mon, 04 Sep 2023 22:22:30 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a1c7708000000b003fef60005b5sm15811157wmi.9.2023.09.04.22.22.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 22:22:29 -0700 (PDT)
Message-ID: <fbe06799-9455-403a-8311-00b3fc96440a@gmail.com>
Date: Tue, 5 Sep 2023 07:22:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: calling address translation functions to
 simplify codes
Content-Language: en-US
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230904081806.16624-1-yifan1.zhang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230904081806.16624-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 04.09.23 um 10:18 schrieb Yifan Zhang:
> Use amdgpu_gmc_vram_pa to simplify codes.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 3 +--
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 3 +--
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  | 3 +--
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      | 3 +--
>   drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c     | 3 +--
>   drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c   | 3 +--
>   drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c   | 3 +--
>   drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c     | 3 +--
>   8 files changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> index 2eb3386ae7ac..bcb6ba03cead 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> @@ -168,8 +168,7 @@ static void gfxhub_v11_5_0_init_system_aperture_regs(struct amdgpu_device *adev)
>   		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
>   
>   	/* Set default page address. */
> -	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start
> -		+ adev->vm_manager.vram_base_offset;
> +	value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
>   	WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
>   		     (u32)(value >> 12));
>   	WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> index e1c76c070ba9..89ff7910cb0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> @@ -164,8 +164,7 @@ static void gfxhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
>   		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
>   
>   	/* Set default page address. */
> -	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start
> -		+ adev->vm_manager.vram_base_offset;
> +	value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
>   	WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
>   		     (u32)(value >> 12));
>   	WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> index 07f369c7a1ed..be1da5927910 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> @@ -169,8 +169,7 @@ static void gfxhub_v3_0_3_init_system_aperture_regs(struct amdgpu_device *adev)
>   		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
>   
>   	/* Set default page address. */
> -	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start
> -		+ adev->vm_manager.vram_base_offset;
> +	value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
>   	WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
>   		     (u32)(value >> 12));
>   	WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index dcbba981462e..671e288c7575 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -500,8 +500,7 @@ static void gmc_v11_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   				 uint64_t *addr, uint64_t *flags)
>   {
>   	if (!(*flags & AMDGPU_PDE_PTE) && !(*flags & AMDGPU_PTE_SYSTEM))
> -		*addr = adev->vm_manager.vram_base_offset + *addr -
> -			adev->gmc.vram_start;
> +		*addr = amdgpu_gmc_vram_mc2pa(adev, *addr);
>   	BUG_ON(*addr & 0xFFFF00000000003FULL);
>   
>   	if (!adev->gmc.translate_further)
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> index 441379e91cfa..7c9ab5491067 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> @@ -189,8 +189,7 @@ static void mmhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
>   		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
>   
>   	/* Set default page address. */
> -	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start +
> -		adev->vm_manager.vram_base_offset;
> +	value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
>   	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
>   		     (u32)(value >> 12));
>   	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
> index 12c7f4b46ea9..db79e6f92441 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
> @@ -188,8 +188,7 @@ static void mmhub_v3_0_1_init_system_aperture_regs(struct amdgpu_device *adev)
>   		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
>   
>   	/* Set default page address. */
> -	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start +
> -		adev->vm_manager.vram_base_offset;
> +	value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
>   	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
>   		     (u32)(value >> 12));
>   	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
> index 5dadc85abf7e..d1fc9dce7151 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
> @@ -181,8 +181,7 @@ static void mmhub_v3_0_2_init_system_aperture_regs(struct amdgpu_device *adev)
>   	}
>   
>   	/* Set default page address. */
> -	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start +
> -		adev->vm_manager.vram_base_offset;
> +	value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
>   	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
>   		     (u32)(value >> 12));
>   	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
> index ec1fb329524d..8194ee2b96c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
> @@ -180,8 +180,7 @@ static void mmhub_v3_3_init_system_aperture_regs(struct amdgpu_device *adev)
>   		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
>   
>   	/* Set default page address. */
> -	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start +
> -		adev->vm_manager.vram_base_offset;
> +	value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
>   	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
>   		     (u32)(value >> 12));
>   	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,

