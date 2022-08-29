Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F964ECAAD2
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 15:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 440D910F401;
	Mon, 29 Aug 2022 15:38:11 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 672CA10F401
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 15:38:07 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id p16so13365655ejb.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 08:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=GEwyRCCYuoqNlJvmYKDre4sMifcMiaDMhbkv+zMvMis=;
 b=CSsVSCxJckYnWjBssQwEEuppQzaADRnAftqQUVHy6kBU88xwQqj+xHZli2uRyiQ3a/
 vvPXKLSK/maa2Pqb3DKhl2U8b16kJvHMYLaeyJKlcoHcCLOnv0wMDhifY/O/H+PhDMCT
 TfE3a9bOKLA0RQ6CEUjq+Jws0S2VE86R9oJ1AoNgzbzl0VJraIAVvWA5X/Re4vXQ5P0G
 2NeHdCDRYbMhPAec3IEbEUHrVKrLapsD8mEr7Zi72UhaawHXSgNfz3vClkSjC5C5K5qM
 88E4Rzq8HE0i+pEzHNd2pdlUa9aHmMAPdudVqLsxFcgycFGGDdzE9Xftjn5jr71/SJi2
 li8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=GEwyRCCYuoqNlJvmYKDre4sMifcMiaDMhbkv+zMvMis=;
 b=sFWMjgpZdlT8/hCkQ9PUDU8EAjVcvLyCCV/nPr9CKxjCSx/xfC+Wp+5pxVvKrDiHvl
 eFiIaQ9tIX+We2zx/3qtQV6l4th4y1ZqVg0f70UMsN6jQK0aYi4WYdZj4aI/YX4f044q
 Ok7+ZH/OyYOKxqJaO6cVyo1PakEXoLTOKrMDllOE9I3yT0bVT9+AA3p5y00FJ4QLQilQ
 CFYUKqFHbNQn9RrWGHn+nu55mdDD8srnmbpwQaLZBIvOCdkZ8jJqnHCJI9kaNhGIS4P3
 Ci1Fp6EGcJ2jBQHW4yajIQlsiPVgMNPVpc2cM0WYJbS5V0/Rtxryi5cGPlsioBG8k/e5
 dekQ==
X-Gm-Message-State: ACgBeo35JDliYuvGJeXPQYWJyWnkgkKgkIoB0hzmoyFtqR6kAZsdo4zt
 qYG/gOQnFZ/gnzdcYk3HTT0=
X-Google-Smtp-Source: AA6agR4RlOBhkqVuS0WzZCRfn3JINxWPlJv+3v6+B42lN4Yz/U1wIJV+tTwx82bYRBj6tAIMAKg2nw==
X-Received: by 2002:a17:907:2bc7:b0:73d:d239:110b with SMTP id
 gv7-20020a1709072bc700b0073dd239110bmr13573177ejc.752.1661787485882; 
 Mon, 29 Aug 2022 08:38:05 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:3268:d71d:7f41:e0fa?
 ([2a02:908:1256:79a0:3268:d71d:7f41:e0fa])
 by smtp.gmail.com with ESMTPSA id
 ky17-20020a170907779100b0072b13ac9ca3sm1070835ejc.183.2022.08.29.08.38.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Aug 2022 08:38:04 -0700 (PDT)
Message-ID: <2707c040-2b99-8c48-237d-45dee65e8833@gmail.com>
Date: Mon, 29 Aug 2022 17:38:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdkfd: Set pte_flags for actual BO location
Content-Language: en-US
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220826231654.335169-1-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220826231654.335169-1-Felix.Kuehling@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 27.08.22 um 01:16 schrieb Felix Kuehling:
> BOs can be in a different location than was intended at allocation time,
> for example when restoring fails after an eviction or BOs get pinned in
> system memory. On some GPUs the MTYPE for coherent mappings depends on
> the actual memory location.
>
> Use the actual location to determine the pte_flags every time the page
> tables are updated.

For a workaround ok, but looks a bit awkward. Basically we need 
different MTYPE based on the location, right?

Christian.

>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  9 ++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 19 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  1 +
>   3 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index cbd593f7d553..5dd89f5a032f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -405,6 +405,7 @@ static int vm_update_pds(struct amdgpu_vm *vm, struct amdgpu_sync *sync)
>   static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
>   {
>   	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(mem->bo->tbo.bdev);
> +	bool is_vram = mem->bo->tbo.resource->mem_type == TTM_PL_VRAM;
>   	bool coherent = mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_COHERENT;
>   	bool uncached = mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED;
>   	uint32_t mapping_flags;
> @@ -420,7 +421,7 @@ static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
>   	switch (adev->asic_type) {
>   	case CHIP_ARCTURUS:
>   	case CHIP_ALDEBARAN:
> -		if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
> +		if (is_vram) {
>   			if (bo_adev == adev) {
>   				if (uncached)
>   					mapping_flags |= AMDGPU_VM_MTYPE_UC;
> @@ -1236,12 +1237,18 @@ static int update_gpuvm_pte(struct kgd_mem *mem,
>   {
>   	struct amdgpu_bo_va *bo_va = entry->bo_va;
>   	struct amdgpu_device *adev = entry->adev;
> +	uint64_t pte_flags = get_pte_flags(adev, mem);
>   	int ret;
>   
>   	ret = kfd_mem_dmamap_attachment(mem, entry);
>   	if (ret)
>   		return ret;
>   
> +	if (unlikely(entry->pte_flags != pte_flags)) {
> +		amdgpu_vm_bo_update_flags(bo_va, pte_flags);
> +		entry->pte_flags = pte_flags;
> +	}
> +
>   	/* Update the page tables  */
>   	ret = amdgpu_vm_bo_update(adev, bo_va, false);
>   	if (ret) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 59cac347baa3..954a40d5d828 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1862,6 +1862,25 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
>   	}
>   }
>   
> +/**
> + * amdgpu_vm_bo_update_flags - Update mapping flags of invalid mappings
> + *
> + * @bo_va: identifies the BO and VM
> + * @flags: new mapping flags
> + *
> + * The update is only applied to invalid mappings. This allows updating the
> + * mapping flags after a migration to maintain the desired coherence. The next
> + * call to amdgpu_vm_bo_update() will apply the new @flags to the page table.
> + */
> +void amdgpu_vm_bo_update_flags(struct amdgpu_bo_va *bo_va,
> +			       uint64_t flags)
> +{
> +	struct amdgpu_bo_va_mapping *mapping;
> +
> +	list_for_each_entry(mapping, &bo_va->invalids, list)
> +		mapping->flags = flags;
> +}
> +
>   /**
>    * amdgpu_vm_get_block_size - calculate VM page table size as power of two
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 9ecb7f663e19..11793716cd8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -413,6 +413,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>   bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
>   void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
>   			     struct amdgpu_bo *bo, bool evicted);
> +void amdgpu_vm_bo_update_flags(struct amdgpu_bo_va *bo_va, uint64_t flags);
>   uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr);
>   struct amdgpu_bo_va *amdgpu_vm_bo_find(struct amdgpu_vm *vm,
>   				       struct amdgpu_bo *bo);

