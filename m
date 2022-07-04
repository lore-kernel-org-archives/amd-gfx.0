Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B712AC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jul 2022 16:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE1E310E6CF;
	Mon,  4 Jul 2022 16:15:49 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93D7610E15D
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Jul 2022 13:53:29 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id r6so393143edd.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Jul 2022 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=qiPgRtSPU0kVqm3y0tTDc1N1l4YU4Z+a6Zu0LcB9lao=;
 b=M8eD+M+teTvWWQXxHZrt8LUKLWxwK7WIO7aM/74Q1zjaLDntk7M3QJg6yfS4HnwMKI
 OHPpkhjgVDU8/DC3x7r73Rkg3bg18BMYUxU3yX2C8fbLseDw/YkvalHkKe6rIWC5OCNT
 lPfFwiF5c23WTj20s+0XeI6pYkfqrlo9UlQRcpNGBmfy3NAhfLaKVJLnKlq6j4u1HzFo
 C/xvVacfN9HP+GEIcuTWSiz2qeizKBD9R6iBETr/M1QhfQlUMnPXt8adBu8SfqTbqX15
 4uqR5dNuDwRD7we/xuB0n4njF8JPrQtZ7ZftE/F0rsNBJDOt5qVZfoRDnVwSruSd3CI9
 w/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=qiPgRtSPU0kVqm3y0tTDc1N1l4YU4Z+a6Zu0LcB9lao=;
 b=BIAj8AgZR8uk2/JKgJr+J29GAumKLxG+pjBU3ofq0Gf/QwdOSNGClyDMwzIRAyiq0b
 W+UjK6OWvSaAbo9TGyDd4eo/U4IVV9ZlZq9Jsynm1k2HZUZL0EqGF09VxH4q+OiadQOd
 uR+dBUAAqMxEYyqxkZsTcNl4K1mC9YwdHXIs9nJATtw10m8fk3jNZTNf/QJ+xfPaAdUQ
 kci2ce5mGmTke3PotpKqLanPo1RyaykfJDbI/34Jam6ksoGXgMQavLuJQkelREgDApFA
 ewQ/Wxb2/YgJ/iIROK7jhQkRrWX6cB94gwORY5Fqt4397o3UekzbyP9Z3TuDW7+Xb7YY
 fEtg==
X-Gm-Message-State: AJIora/RCzBP9HXH042HTMr+svcI95+SHSPrObaqUUMYheg621cateAK
 QrwXw/ZkZ0b6DiXmzuiy4Kw=
X-Google-Smtp-Source: AGRyM1sJk4K7np4s6Qytw4Cx0uNRjNdUps9U6UkKKs83gbNaAgkkYc0a9R3GxVPoqpnDRuKQ9wXtww==
X-Received: by 2002:a05:6402:3807:b0:435:20fb:318d with SMTP id
 es7-20020a056402380700b0043520fb318dmr38706033edb.272.1656942808089; 
 Mon, 04 Jul 2022 06:53:28 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:601b:af42:6b18:b5ef?
 ([2a02:908:1256:79a0:601b:af42:6b18:b5ef])
 by smtp.gmail.com with ESMTPSA id
 r19-20020a1709062cd300b006ff802baf5dsm14324954ejr.54.2022.07.04.06.53.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Jul 2022 06:53:27 -0700 (PDT)
Message-ID: <4a80f007-7775-18ea-d8fc-c168d5be94c1@gmail.com>
Date: Mon, 4 Jul 2022 15:53:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] drm/amdgpu: remove acc_size from reserve/unreserve mem
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220628002347.3982-1-alex.sierra@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220628002347.3982-1-alex.sierra@amd.com>
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
Cc: Philip Yang <philip.yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 28.06.22 um 02:23 schrieb Alex Sierra:
> TTM used to track the "acc_size" of all BOs internally. We needed to
> keep track of it in our memory reservation to avoid TTM running out
> of memory in its own accounting. However, that "acc_size" accounting
> has since been removed from TTM. Therefore we don't really need to
> track it any more.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> Reviewed-by: Philip Yang <philip.yang@amd.com>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 60 ++++++-------------
>   1 file changed, 17 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 5ba9070d8722..9142f6cc3f4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -114,21 +114,12 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
>    * compromise that should work in most cases without reserving too
>    * much memory for page tables unnecessarily (factor 16K, >> 14).
>    */
> -#define ESTIMATE_PT_SIZE(mem_size) max(((mem_size) >> 14), AMDGPU_VM_RESERVED_VRAM)
> -
> -static size_t amdgpu_amdkfd_acc_size(uint64_t size)
> -{
> -	size >>= PAGE_SHIFT;
> -	size *= sizeof(dma_addr_t) + sizeof(void *);
>   
> -	return __roundup_pow_of_two(sizeof(struct amdgpu_bo)) +
> -		__roundup_pow_of_two(sizeof(struct ttm_tt)) +
> -		PAGE_ALIGN(size);
> -}
> +#define ESTIMATE_PT_SIZE(mem_size) max(((mem_size) >> 14), AMDGPU_VM_RESERVED_VRAM)
>   
>   /**
>    * amdgpu_amdkfd_reserve_mem_limit() - Decrease available memory by size
> - * of buffer including any reserved for control structures
> + * of buffer.
>    *
>    * @adev: Device to which allocated BO belongs to
>    * @size: Size of buffer, in bytes, encapsulated by B0. This should be
> @@ -142,19 +133,16 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   {
>   	uint64_t reserved_for_pt =
>   		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
> -	size_t acc_size, system_mem_needed, ttm_mem_needed, vram_needed;
> +	size_t system_mem_needed, ttm_mem_needed, vram_needed;
>   	int ret = 0;
>   
> -	acc_size = amdgpu_amdkfd_acc_size(size);
> -
> +	system_mem_needed = 0;
> +	ttm_mem_needed = 0;
>   	vram_needed = 0;
>   	if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
> -		system_mem_needed = acc_size + size;
> -		ttm_mem_needed = acc_size + size;
> +		system_mem_needed = size;
> +		ttm_mem_needed = size;
>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
> -		system_mem_needed = acc_size;
> -		ttm_mem_needed = acc_size;
> -
>   		/*
>   		 * Conservatively round up the allocation requirement to 2 MB
>   		 * to avoid fragmentation caused by 4K allocations in the tail
> @@ -162,14 +150,10 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   		 */
>   		vram_needed = ALIGN(size, VRAM_ALLOCATION_ALIGN);
>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
> -		system_mem_needed = acc_size + size;
> -		ttm_mem_needed = acc_size;
> -	} else if (alloc_flag &
> -		   (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> -		    KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
> -		system_mem_needed = acc_size;
> -		ttm_mem_needed = acc_size;
> -	} else {
> +		system_mem_needed = size;
> +	} else if (!(alloc_flag &
> +				(KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> +				 KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
>   		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
>   		return -ENOMEM;
>   	}
> @@ -207,28 +191,18 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   static void unreserve_mem_limit(struct amdgpu_device *adev,
>   		uint64_t size, u32 alloc_flag)
>   {
> -	size_t acc_size;
> -
> -	acc_size = amdgpu_amdkfd_acc_size(size);
> -
>   	spin_lock(&kfd_mem_limit.mem_limit_lock);
>   
>   	if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
> -		kfd_mem_limit.system_mem_used -= (acc_size + size);
> -		kfd_mem_limit.ttm_mem_used -= (acc_size + size);
> +		kfd_mem_limit.system_mem_used -= size;
> +		kfd_mem_limit.ttm_mem_used -= size;
>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
> -		kfd_mem_limit.system_mem_used -= acc_size;
> -		kfd_mem_limit.ttm_mem_used -= acc_size;
>   		adev->kfd.vram_used -= ALIGN(size, VRAM_ALLOCATION_ALIGN);
>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
> -		kfd_mem_limit.system_mem_used -= (acc_size + size);
> -		kfd_mem_limit.ttm_mem_used -= acc_size;
> -	} else if (alloc_flag &
> -		   (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> -		    KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
> -		kfd_mem_limit.system_mem_used -= acc_size;
> -		kfd_mem_limit.ttm_mem_used -= acc_size;
> -	} else {
> +		kfd_mem_limit.system_mem_used -= size;
> +	} else if (!(alloc_flag &
> +				(KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> +				 KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
>   		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
>   		goto release;
>   	}

