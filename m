Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C04EC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 11:50:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB2ED10E3CB;
	Tue, 22 Feb 2022 11:50:03 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09A7010E3CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 11:50:03 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id d10so42063700eje.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 03:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=B3N9fAo9yqamA4JcsUjI2YUNeRJgpT3fmAUPXC1Rrls=;
 b=Ku4eQcv+gn+9Si3ciXcHp5zXm1I9cmY5+HvOJoeG0w0ZeHf/YV60a4eYW3vc0CTejS
 vR0iDROYVrHdZzja0OvA5QPCJ40NDdShj2CXHd/Yb8uE7RxiMQbESYUoUUUQaHshX9/m
 Dnn7ikgf58cko5GvBJAWnqZq2p96ewL0upF5lh1lTf3D+gqwDDj/S8QuprzCgzN+lXUp
 CTZTGz8fiz0/nWPAzcpSkXCfzVISHFUo27dqbJncypdB2/gyqByQdF6Tn7XsDPV0BGC5
 2JzECBMcHFvoa7KNjLOULI33MKvCdNWSy9+FMANG2GIafb1g/nEG/srF38UPnLAqSs+t
 Xx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=B3N9fAo9yqamA4JcsUjI2YUNeRJgpT3fmAUPXC1Rrls=;
 b=yKVYxIueo5Pe/xJVkx33kJQ0dWJos0eC1UD/W7keUpu2mgxNzatzAXO/b7PnGi2M+H
 A+wagMqAJkTRsgxtD46fFo88b8kkvcKlAzWT/X8WS1bUFTTOwVnXVNN8zphKIFRuCu/Y
 ZNkUH557hOQqSzm/XB4RPRmKwAnDbQW6B9kYMsAAE3WGCTIv+SZu4LRgbhKA2v640Q5c
 ErFjASI8dOFscad8v9wEUYFEVJ8jpOJSlHeixom3rNmVYJgXPJTIVf7hvQ8uTIMqZaui
 NIG9tPN0SXC9yYq8sCGQ7Id+Ra2+DfvAlxhDN7NE6E2Uwv18bP/o+qk6ikYuHks5ut2w
 nURA==
X-Gm-Message-State: AOAM532SieJU9VOf4SU9ZtNHpJai1Hn79JKluayzYgQ6sViFOK5/YmkO
 ZGdmESmnr13S4luseolu227/Iu8Apbs=
X-Google-Smtp-Source: ABdhPJy+cUY2p57dfjBLtO6cGsKxvj9sXJkLU5k3DrFMP+BsYDQhTT1pss5V7r2IfCA8xjlNiaAvwA==
X-Received: by 2002:a17:906:b0f:b0:6ce:e79:75c2 with SMTP id
 u15-20020a1709060b0f00b006ce0e7975c2mr19193003ejg.668.1645530601332; 
 Tue, 22 Feb 2022 03:50:01 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:21b6:6d72:8af6:ec7c?
 ([2a02:908:1252:fb60:21b6:6d72:8af6:ec7c])
 by smtp.gmail.com with ESMTPSA id gj7sm6113047ejc.90.2022.02.22.03.50.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Feb 2022 03:50:00 -0800 (PST)
Message-ID: <53383490-0d28-0787-0d2f-783ad3877219@gmail.com>
Date: Tue, 22 Feb 2022 12:49:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] drm/amdgpu: use kernel BO API for benchmark buffer
 management
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220221223030.5672-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220221223030.5672-1-alexander.deucher@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 21.02.22 um 23:30 schrieb Alex Deucher:
> Simplifies the code quite a bit.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for the series.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 78 ++++---------------
>   1 file changed, 17 insertions(+), 61 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> index 4f3cdd8cfb6a..92a2ffefe62e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> @@ -75,57 +75,25 @@ static int amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned size,
>   {
>   	struct amdgpu_bo *dobj = NULL;
>   	struct amdgpu_bo *sobj = NULL;
> -	struct amdgpu_bo_param bp;
>   	uint64_t saddr, daddr;
>   	int r, n;
>   
> -	memset(&bp, 0, sizeof(bp));
> -	bp.size = size;
> -	bp.byte_align = PAGE_SIZE;
> -	bp.domain = sdomain;
> -	bp.flags = 0;
> -	bp.type = ttm_bo_type_kernel;
> -	bp.resv = NULL;
> -	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> -
>   	n = AMDGPU_BENCHMARK_ITERATIONS;
> -	r = amdgpu_bo_create(adev, &bp, &sobj);
> -	if (r) {
> -		goto out_cleanup;
> -	}
> -	r = amdgpu_bo_reserve(sobj, false);
> -	if (unlikely(r != 0))
> -		goto out_cleanup;
> -	r = amdgpu_bo_pin(sobj, sdomain);
> -	if (r) {
> -		amdgpu_bo_unreserve(sobj);
> -		goto out_cleanup;
> -	}
> -	r = amdgpu_ttm_alloc_gart(&sobj->tbo);
> -	amdgpu_bo_unreserve(sobj);
> -	if (r) {
> -		goto out_cleanup;
> -	}
> -	saddr = amdgpu_bo_gpu_offset(sobj);
> -	bp.domain = ddomain;
> -	r = amdgpu_bo_create(adev, &bp, &dobj);
> -	if (r) {
> -		goto out_cleanup;
> -	}
> -	r = amdgpu_bo_reserve(dobj, false);
> -	if (unlikely(r != 0))
> +
> +	r = amdgpu_bo_create_kernel(adev, size,
> +				    PAGE_SIZE, sdomain,
> +				    &sobj,
> +				    &saddr,
> +				    NULL);
> +	if (r)
>   		goto out_cleanup;
> -	r = amdgpu_bo_pin(dobj, ddomain);
> -	if (r) {
> -		amdgpu_bo_unreserve(sobj);
> +	r = amdgpu_bo_create_kernel(adev, size,
> +				    PAGE_SIZE, ddomain,
> +				    &dobj,
> +				    &daddr,
> +				    NULL);
> +	if (r)
>   		goto out_cleanup;
> -	}
> -	r = amdgpu_ttm_alloc_gart(&dobj->tbo);
> -	amdgpu_bo_unreserve(dobj);
> -	if (r) {
> -		goto out_cleanup;
> -	}
> -	daddr = amdgpu_bo_gpu_offset(dobj);
>   
>   	if (adev->mman.buffer_funcs) {
>   		r = amdgpu_benchmark_do_move(adev, size, saddr, daddr, n);
> @@ -141,22 +109,10 @@ static int amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned size,
>   	if (r < 0)
>   		dev_info(adev->dev, "Error while benchmarking BO move.\n");
>   
> -	if (sobj) {
> -		r = amdgpu_bo_reserve(sobj, true);
> -		if (likely(r == 0)) {
> -			amdgpu_bo_unpin(sobj);
> -			amdgpu_bo_unreserve(sobj);
> -		}
> -		amdgpu_bo_unref(&sobj);
> -	}
> -	if (dobj) {
> -		r = amdgpu_bo_reserve(dobj, true);
> -		if (likely(r == 0)) {
> -			amdgpu_bo_unpin(dobj);
> -			amdgpu_bo_unreserve(dobj);
> -		}
> -		amdgpu_bo_unref(&dobj);
> -	}
> +	if (sobj)
> +		amdgpu_bo_free_kernel(&sobj, &saddr, NULL);
> +	if (dobj)
> +		amdgpu_bo_free_kernel(&dobj, &daddr, NULL);
>   	return r;
>   }
>   

