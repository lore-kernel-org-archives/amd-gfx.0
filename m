Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59EFC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 09:12:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6147B10EE71;
	Thu, 27 Jan 2022 09:12:33 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6A2410EE7B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 09:12:31 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id r7so1390700wmq.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 01:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=I6GEPCFLwXGuifYDLPqLG6JOYxMz+QHpp6L5IkMtQzI=;
 b=gk1psWrta8HRFRjgqwXgxArXr4slwxQJLO3LvwF5t6UVfeOTg6j0PoW72Lk3+Y6jr5
 3mwNtPr3NheOcEMh63Ag/iITaBL4BYQx8J2vk4v1RY6LccdJJ/twth8Hpsbx8/2Fqc3y
 gRn4NDn1MpkhrKwL9DxSGz/cfMaXWftHl6LGglfhofqqvkHJb4WLajKNEK49HJu1CFXT
 cP2ar0yO2JM8lM3DAoL4zCwz7DgAZLtp5tmfZeaIDfa0apDEzydG6es5DDpMlFeyaSOO
 lLFJd5+zIbJS6kNKtiV4zbjxRmjxH2qLwDq9a6GU/q+xMhWF0wiUPPlOtB3aimb6khLK
 bkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=I6GEPCFLwXGuifYDLPqLG6JOYxMz+QHpp6L5IkMtQzI=;
 b=JFEPWqm4xXovOt8wmwD5NJ3Nf53064WEUMWjpGO1LG/4cRCx2lUxsJBnvGK9ZGsPsZ
 QPdPM+HlCTdEayviJzBrji8uoiz0TJePnohwN6UGQgjXsj2sUM0rg9YClk46xwf0R/Qw
 ntqmO7GsUlnYYO54WY08Rk6B00aY2kJuu2FwZGYot9EfTztLB7wtpnVYDEJwFS42pMA3
 9mgJwuaH5cG2jrM/mNLpV/pUlM5983oFJHSCz5oL9FY3beHW9NUdgoAIzCRCv9vHNEli
 ADj8IRdHYrjUFmBcL6uS7I0P65gPte1yRawno7RCNwTh20nwt50RojFUWbhCJb63LMps
 IJAA==
X-Gm-Message-State: AOAM533+AGeAYDp+yFhF7BqMd54v3IzXSH0XVcR7f80eTNXZNbSrBDP8
 xiLuDLVGnMb9jB6QVWT5Sj2KTLj3UlM=
X-Google-Smtp-Source: ABdhPJyTE5zhAAYvz0Qr7g4UrgWZ9rvV/xIcLNGxjeKwtCu6byopoHvP15ghWjRnM68loioWrBqhbA==
X-Received: by 2002:a7b:ce0c:: with SMTP id m12mr2374483wmc.83.1643274750401; 
 Thu, 27 Jan 2022 01:12:30 -0800 (PST)
Received: from [192.168.178.21] (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id y15sm2433816wry.36.2022.01.27.01.12.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jan 2022 01:12:30 -0800 (PST)
Message-ID: <956520be-9e4b-a2df-d6d1-65ebfa135a30@gmail.com>
Date: Thu, 27 Jan 2022 10:12:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2] drm/amdgpu: move GTT allocation from gmc_sw_init to
 gmc_hw_init(V2)
Content-Language: en-US
To: Aaron Liu <aaron.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220127075225.3040986-1-aaron.liu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220127075225.3040986-1-aaron.liu@amd.com>
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
Cc: Alexander.Deucher@amd.com, ruili.ji@amd.com, felix.kuehling@amd.com,
 jonathan.kim@amd.com, Ray.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 27.01.22 um 08:52 schrieb Aaron Liu:
> The below patch causes system hang for harvested ASICs.
> d015e9861e55 drm/amdgpu: improve debug VRAM access performance using sdma
>
> The root cause is that GTT buffer should be allocated after GC SA harvest
> programming completed.

That doesn't make much sense. We intentionally modified the code so that 
this is possible.

What is the rational that we need to program the HW before allocating 
system memory?

Regards,
Christian.

>
> For harvested AISC, the GC SA harvest process(see utcl2_harvest) is
> programmed in gmc_v10_0_hw_init function. This is a hardware programming.
> Therefore should be located in hw init. Hence need to move GTT allocation
> from gmc_v*_0_sw_init to gmc_v*_0_hw_init.
>
> V2: expand to all gmc_v*_0_hw_init functions.
>
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 21 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  3 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  8 --------
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  4 +++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   | 13 +++++++++----
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   | 13 +++++++++----
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   | 13 +++++++++----
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 13 +++++++++----
>   8 files changed, 63 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index d426de48d299..ac75bde8ac61 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -876,3 +876,24 @@ int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
>   
>   	return 0;
>   }
> +
> +int amdgpu_gmc_allocate_sdma_access_gtt(struct amdgpu_device *adev)
> +{
> +	int ret;
> +
> +	ret = amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
> +					AMDGPU_GEM_DOMAIN_GTT,
> +					&adev->mman.sdma_access_bo, NULL,
> +					&adev->mman.sdma_access_ptr);
> +
> +	if (ret)
> +		DRM_WARN("Debug VRAM access will use slowpath MM access\n");
> +
> +	return ret;
> +}
> +
> +void amdgpu_gmc_free_sdma_access_gtt(struct amdgpu_device *adev)
> +{
> +	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
> +					&adev->mman.sdma_access_ptr);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 93505bb0a36c..b8ba16de5e1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -338,4 +338,7 @@ uint64_t amdgpu_gmc_vram_mc2pa(struct amdgpu_device *adev, uint64_t mc_addr);
>   uint64_t amdgpu_gmc_vram_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
>   uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
>   int amdgpu_gmc_vram_checking(struct amdgpu_device *adev);
> +int amdgpu_gmc_allocate_sdma_access_gtt(struct amdgpu_device *adev);
> +void amdgpu_gmc_free_sdma_access_gtt(struct amdgpu_device *adev);
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 3d8a20956b74..7ce0478b2908 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1823,12 +1823,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   		return r;
>   	}
>   
> -	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
> -				AMDGPU_GEM_DOMAIN_GTT,
> -				&adev->mman.sdma_access_bo, NULL,
> -				&adev->mman.sdma_access_ptr))
> -		DRM_WARN("Debug VRAM access will use slowpath MM access\n");
> -
>   	return 0;
>   }
>   
> @@ -1850,8 +1844,6 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>   	if (adev->mman.stolen_reserved_size)
>   		amdgpu_bo_free_kernel(&adev->mman.stolen_reserved_memory,
>   				      NULL, NULL);
> -	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
> -					&adev->mman.sdma_access_ptr);
>   	amdgpu_ttm_fw_reserve_vram_fini(adev);
>   
>   	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 73ab0eebe4e2..d923e4127c87 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -1062,7 +1062,7 @@ static int gmc_v10_0_hw_init(void *handle)
>   	if (adev->umc.funcs && adev->umc.funcs->init_registers)
>   		adev->umc.funcs->init_registers(adev);
>   
> -	return 0;
> +	return amdgpu_gmc_allocate_sdma_access_gtt(adev);
>   }
>   
>   /**
> @@ -1082,6 +1082,8 @@ static int gmc_v10_0_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	amdgpu_gmc_free_sdma_access_gtt(adev);
> +
>   	gmc_v10_0_gart_disable(adev);
>   
>   	if (amdgpu_sriov_vf(adev)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index ec291d28edff..ca397d4d4aa8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -919,16 +919,21 @@ static int gmc_v6_0_hw_init(void *handle)
>   	if (r)
>   		return r;
>   
> -	if (amdgpu_emu_mode == 1)
> -		return amdgpu_gmc_vram_checking(adev);
> -	else
> -		return r;
> +	if (amdgpu_emu_mode == 1) {
> +		r = amdgpu_gmc_vram_checking(adev);
> +		if (r)
> +			return r;
> +	}
> +
> +	return amdgpu_gmc_allocate_sdma_access_gtt(adev);
>   }
>   
>   static int gmc_v6_0_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	amdgpu_gmc_free_sdma_access_gtt(adev);
> +
>   	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
>   	gmc_v6_0_gart_disable(adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index 344d819b4c1b..11f87f8adae8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -1107,16 +1107,21 @@ static int gmc_v7_0_hw_init(void *handle)
>   	if (r)
>   		return r;
>   
> -	if (amdgpu_emu_mode == 1)
> -		return amdgpu_gmc_vram_checking(adev);
> -	else
> -		return r;
> +	if (amdgpu_emu_mode == 1) {
> +		r = amdgpu_gmc_vram_checking(adev);
> +		if (r)
> +			return r;
> +	}
> +
> +	return amdgpu_gmc_allocate_sdma_access_gtt(adev);
>   }
>   
>   static int gmc_v7_0_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	amdgpu_gmc_free_sdma_access_gtt(adev);
> +
>   	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
>   	gmc_v7_0_gart_disable(adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index ca9841d5669f..c90f9016d093 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1238,16 +1238,21 @@ static int gmc_v8_0_hw_init(void *handle)
>   	if (r)
>   		return r;
>   
> -	if (amdgpu_emu_mode == 1)
> -		return amdgpu_gmc_vram_checking(adev);
> -	else
> -		return r;
> +	if (amdgpu_emu_mode == 1) {
> +		r = amdgpu_gmc_vram_checking(adev);
> +		if (r)
> +			return r;
> +	}
> +
> +	return amdgpu_gmc_allocate_sdma_access_gtt(adev);
>   }
>   
>   static int gmc_v8_0_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	amdgpu_gmc_free_sdma_access_gtt(adev);
> +
>   	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
>   	gmc_v8_0_gart_disable(adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 4595027a8c63..9b4b1d9a0769 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1852,10 +1852,13 @@ static int gmc_v9_0_hw_init(void *handle)
>   	if (r)
>   		return r;
>   
> -	if (amdgpu_emu_mode == 1)
> -		return amdgpu_gmc_vram_checking(adev);
> -	else
> -		return r;
> +	if (amdgpu_emu_mode == 1) {
> +		r = amdgpu_gmc_vram_checking(adev);
> +		if (r)
> +			return r;
> +	}
> +
> +	return amdgpu_gmc_allocate_sdma_access_gtt(adev);
>   }
>   
>   /**
> @@ -1875,6 +1878,8 @@ static int gmc_v9_0_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	amdgpu_gmc_free_sdma_access_gtt(adev);
> +
>   	gmc_v9_0_gart_disable(adev);
>   
>   	if (amdgpu_sriov_vf(adev)) {

