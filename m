Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3FFC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 15:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6655010E1D5;
	Wed, 19 Jan 2022 15:52:53 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF69610E1D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 15:52:51 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 25-20020a05600c231900b003497473a9c4so15020617wmo.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 07:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=7MCXxYSQOmZ3OoCOTB8BhQUtdRKxWCtkQgr2GT/szNw=;
 b=YUZIEIFJGuPL2ug+aK3YwgMTGTG03fBehJAuVhgx+X2+pvuMnI5wKBnsDcK/B4COfx
 rtUc9e23/P83QfW5ULdj9yl5mdxTxCe0CR3ROflOuFv/fFF5T+kVVVTreT0nWwtN35Em
 VvDRPilu3t8zozA1ELnrUICgCko5Hh93BTD8/akez4bv//42PAFfoRxiTUmVgD5V+riv
 AemF1Sznt/Pa4McijQDSlx0IosYoEwdCx7GshaKitc+e5Cf6Y4jdKxEuNRw1wyBklgI7
 j0SLlxeXDRGEDsakVjcYpTRqRLdSPH3c8oGN8aMSvUkeeKaut9uFrYC6naf2F7SWsKmJ
 rN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=7MCXxYSQOmZ3OoCOTB8BhQUtdRKxWCtkQgr2GT/szNw=;
 b=oLAxE0xgyEvqc3AjLDsps0/CgSt123SrlK1SxOsLWThsKtaZpXva6SzJg0kUCuvzGU
 geycIDlcAozfsSa9+SoZ9vao0g40NQWglyfPQP+/VVqqk/BwhwyHhs9Ji53XEp4faohy
 I10DbWXlWg1Fc9774Ttfnr0OVUP2GjSZRznha2TCzRtI3HuRgyJbdXFr5931g/U6MrJN
 k3ps9PiNZzDmWs2ReMHFScnmmlGmS8jyFLRXPi8S5FApywtk0rif6yuwy+3NwVPnoWBw
 SnIByiO9eucmoQhO1wx9gg/ycTSHMmnEEeYzOOUeqQ3pqH8Qq1AV0TaL4q1cIGb+RDRI
 pUAA==
X-Gm-Message-State: AOAM530D39TY1qzO8KsYWpgYaXcvnUjLrFmDYgkaP5pIUJDRd23uC5EL
 v53pCDsm2N4sGyicnWLkJP0=
X-Google-Smtp-Source: ABdhPJyBJ8j/HA8Ru1ORHq45eafi4jQ0Fgj85jz9iNnjLa3s2ph94Q1NQGWNezPdu0PxQSeJjMymVQ==
X-Received: by 2002:a7b:ce17:: with SMTP id m23mr4070755wmc.141.1642607570439; 
 Wed, 19 Jan 2022 07:52:50 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:e02a:2696:8337:7b12?
 ([2a02:908:1252:fb60:e02a:2696:8337:7b12])
 by smtp.gmail.com with ESMTPSA id i18sm147282wrq.96.2022.01.19.07.52.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jan 2022 07:52:50 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: fix broken debug sdma vram access function
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220119154736.113984-1-jonathan.kim@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <f94276e7-1ebb-fed5-5584-b601a9cc0505@gmail.com>
Date: Wed, 19 Jan 2022 16:52:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220119154736.113984-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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
Cc: Felix.Kuehling@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 19.01.22 um 16:47 schrieb Jonathan Kim:
> Debug VRAM access through SDMA has several broken parts resulting in
> silent MMIO fallback.
>
> BO kernel creation takes the location of the cpu addr pointer, not
> the pointer itself for address kmap.
>
> drm_dev_enter return true on success so change access check.
>
> The source BO is reserved but not pinned so find the address using the
> cursor offset relative to its memory domain start.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index b489cd8abe31..0a2e8e355eaa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1436,6 +1436,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
>   {
>   	struct amdgpu_bo *abo = ttm_to_amdgpu_bo(bo);
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(abo->tbo.bdev);
> +	struct amdgpu_res_cursor src_mm;
>   	struct amdgpu_job *job;
>   	struct dma_fence *fence;
>   	uint64_t src_addr, dst_addr;
> @@ -1448,9 +1449,8 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
>   	if (!adev->mman.sdma_access_ptr)
>   		return -EACCES;
>   
> -	r = drm_dev_enter(adev_to_drm(adev), &idx);
> -	if (r)
> -		return r;
> +	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +		return -ENODEV;
>   
>   	if (write)
>   		memcpy(adev->mman.sdma_access_ptr, buf, len);
> @@ -1460,7 +1460,8 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
>   	if (r)
>   		goto out;
>   
> -	src_addr = amdgpu_bo_gpu_offset(abo);
> +	amdgpu_res_first(abo->tbo.resource, offset, len, &src_mm);
> +	src_addr = amdgpu_ttm_domain_start(adev, bo->resource->mem_type) + src_mm.start;
>   	dst_addr = amdgpu_bo_gpu_offset(adev->mman.sdma_access_bo);
>   	if (write)
>   		swap(src_addr, dst_addr);
> @@ -1858,7 +1859,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
>   				AMDGPU_GEM_DOMAIN_GTT,
>   				&adev->mman.sdma_access_bo, NULL,
> -				adev->mman.sdma_access_ptr))
> +				&adev->mman.sdma_access_ptr))
>   		DRM_WARN("Debug VRAM access will use slowpath MM access\n");
>   
>   	return 0;
> @@ -1882,6 +1883,8 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>   	if (adev->mman.stolen_reserved_size)
>   		amdgpu_bo_free_kernel(&adev->mman.stolen_reserved_memory,
>   				      NULL, NULL);
> +	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
> +					&adev->mman.sdma_access_ptr);
>   	amdgpu_ttm_fw_reserve_vram_fini(adev);
>   
>   	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> @@ -1901,8 +1904,6 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>   	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
>   	ttm_device_fini(&adev->mman.bdev);
>   	adev->mman.initialized = false;
> -	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
> -					&adev->mman.sdma_access_ptr);
>   	DRM_INFO("amdgpu: ttm finalized\n");
>   }
>   

