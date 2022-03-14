Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C70BC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 19:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9CDF10E3AB;
	Mon, 14 Mar 2022 19:41:54 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 913A410E3AB
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 19:41:53 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id bg10so36476667ejb.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 12:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=S593QnWzZy3+zsXfBcoR4tbPDmTwalfo+JnXIFrs1/M=;
 b=iJ7BTUEgAsRo/cMixh3KCn417PP/CjjE/9Z3EF7dryT4haRYO4BlPvLEwb7augV8nx
 ddc4zHATHRykqj6vUhkQi7DBmoGCJw0NuEsxE3HRv7Rvg/Ubp8HukYZcViFgMJRE9nD2
 2qOvVt3Z4xz+uPOW7HhquqOZLD3oQpNLd1DlfecxxRtwb1YRBcAFbLN6u9lzMqbr/jeM
 tq3R4ra3kei285lQ7+kgwk8vmM755MfBnsYiWWtqAhVncNPFzp3aK9ucCyMJBgPa9BZU
 xyk2QEq74g8dpnkmRqH8/WHyRZ1OB9CHcjlM0rDb39E0Oj5CY0xN1z78vRXeJhwHNH/p
 8jrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=S593QnWzZy3+zsXfBcoR4tbPDmTwalfo+JnXIFrs1/M=;
 b=0p0lh9zzA2Z5G5aH1mUDFqbqGTqIjyldKmiuNsUoQmKBgOEV0zGuXHMO7by44/Ej0Z
 P8WsuRxvX0jQR74abLuijk5rge76SVdDZIbp8XNrpGMl6Wn2ZIAbTXFsK15udZvpvuCM
 BzfoQqmDbFYor0MdeGce68Y6ikXVOLePMDDzXqwoz47ncgLW9fH7//SnQnf5JqUN5uDi
 gVyW/yXkkDtm4dql6hDaJNy3v7Lw0ZLqFE04enmK73r9h4d5sOw1SN+EslwcpWZB9DQE
 53Iu9rnQ891yHF7udlb9N6TpyBBAwold1UMS+mwuaZW0sgL4Be676YgokJUkoE/GftcT
 5zhA==
X-Gm-Message-State: AOAM531D5G77V7CSkdNjl4i9Nfg+ZkHtWuHB73shTu4zme0YvMqEe9NZ
 7UBQqs1EyMPxIvqoP/xkBOo=
X-Google-Smtp-Source: ABdhPJy/NplggbbP419TuleDgICAzd0ZYPbdPMX0eCEf6f0Lwu6/F+i/N5yFwUq/ccWPVFN1dE+bQQ==
X-Received: by 2002:a17:906:4711:b0:6d0:67bb:59e1 with SMTP id
 y17-20020a170906471100b006d067bb59e1mr18878386ejq.211.1647286911887; 
 Mon, 14 Mar 2022 12:41:51 -0700 (PDT)
Received: from ?IPV6:2a02:908:1252:fb60:bb72:15dd:d97a:aa7c?
 ([2a02:908:1252:fb60:bb72:15dd:d97a:aa7c])
 by smtp.gmail.com with ESMTPSA id
 o3-20020a17090637c300b006d8631b2935sm7144463ejc.186.2022.03.14.12.41.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Mar 2022 12:41:51 -0700 (PDT)
Message-ID: <e2b06b36-293f-ce39-0f78-d4768ac0456b@gmail.com>
Date: Mon, 14 Mar 2022 20:41:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu: Add stolen reserved memory for MI25 SRIOV.
Content-Language: en-US
To: Yongqiang Sun <yongqiang.sun@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220314185403.137623-1-yongqiang.sun@amd.com>
 <20220314185403.137623-2-yongqiang.sun@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220314185403.137623-2-yongqiang.sun@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: alexander.deucher@amd.com, nikola.veljkovic@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.03.22 um 19:54 schrieb Yongqiang Sun:
> [Why]
> MI25 SRIOV guest driver loading failed due to allocate
> memory overlaps with private memory area.
>
> [How]
> 1. Allocate stolen reserved memory for MI25 SRIOV specifically to avoid
> the memory overlap.
> 2. Move allocate reserve allocation to vbios allocation since both the
> two functions are doing similar asic type check and no need to have
> seperate functions.
>
> Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
> Change-Id: I142127513047a3e81573eb983c510d763b548a24
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 37 ++++++++++++-------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  1 -
>   3 files changed, 18 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 7c2a9555b7cc..f7f4f00dd2b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -626,6 +626,11 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
>   {
>   	unsigned size;
>   
> +	/* Some ASICs need to reserve a region of video memory to avoid access
> +	 * from driver */
> +	adev->mman.stolen_reserved_offset = 0;
> +	adev->mman.stolen_reserved_size = 0;
> +
>   	/*
>   	 * TODO:
>   	 * Currently there is a bug where some memory client outside
> @@ -635,11 +640,24 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
>   	 * Keep the stolen memory reservation until the while this is not solved.
>   	 */
>   	switch (adev->asic_type) {
> +
>   	case CHIP_VEGA10:

Please don't add empty lines between switch and case. Good practice is 
to check your patches with checkpatch.pl before sending it out.

> +		adev->mman.keep_stolen_vga_memory = true;
> +		if (amdgpu_sriov_vf(adev)) {
> +			adev->mman.stolen_reserved_offset = 0x100000;
> +			adev->mman.stolen_reserved_size = 0x600000;
> +		}
> +		break;
>   	case CHIP_RAVEN:
>   	case CHIP_RENOIR:
>   		adev->mman.keep_stolen_vga_memory = true;
>   		break;
> +	case CHIP_YELLOW_CARP:
> +		if (amdgpu_discovery == 0) {
> +			adev->mman.stolen_reserved_offset = 0x1ffb0000;
> +			adev->mman.stolen_reserved_size = 64 * PAGE_SIZE;
> +		}
> +		break;

That looks like this is somehow mixed up. The stolen memory is for VGA 
emulation, but under SRIOV we should not have VGA emulation as far as I 
know.

Alex, what's going on here?

Regards,
Christian.

>   	default:
>   		adev->mman.keep_stolen_vga_memory = false;
>   		break;
> @@ -760,25 +778,6 @@ uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo
>   	return amdgpu_bo_gpu_offset(bo) - adev->gmc.vram_start + adev->gmc.aper_base;
>   }
>   
> -void amdgpu_gmc_get_reserved_allocation(struct amdgpu_device *adev)
> -{
> -	/* Some ASICs need to reserve a region of video memory to avoid access
> -	 * from driver */
> -	adev->mman.stolen_reserved_offset = 0;
> -	adev->mman.stolen_reserved_size = 0;
> -
> -	switch (adev->asic_type) {
> -	case CHIP_YELLOW_CARP:
> -		if (amdgpu_discovery == 0) {
> -			adev->mman.stolen_reserved_offset = 0x1ffb0000;
> -			adev->mman.stolen_reserved_size = 64 * PAGE_SIZE;
> -		}
> -		break;
> -	default:
> -		break;
> -	}
> -}
> -
>   int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_bo *vram_bo = NULL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 93505bb0a36c..032b0313f277 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -331,7 +331,6 @@ amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
>   			      bool enable);
>   
>   void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev);
> -void amdgpu_gmc_get_reserved_allocation(struct amdgpu_device *adev);
>   
>   void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev);
>   uint64_t amdgpu_gmc_vram_mc2pa(struct amdgpu_device *adev, uint64_t mc_addr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index f60b7bd4dbf5..3c1d440824a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -948,7 +948,6 @@ static int gmc_v10_0_sw_init(void *handle)
>   		return r;
>   
>   	amdgpu_gmc_get_vbios_allocations(adev);
> -	amdgpu_gmc_get_reserved_allocation(adev);
>   
>   	/* Memory manager */
>   	r = amdgpu_bo_init(adev);

