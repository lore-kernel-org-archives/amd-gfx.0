Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9190FC27C65
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0064210E6B0;
	Tue, 11 Jun 2024 16:24:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="LrkN03a1";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18FEC10E6BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:24:03 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4218314a6c7so21324995e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 09:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1718123041; x=1718727841;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z6CHZGE+wy4ZoQyKUm2qp2H54h9bUZZQYZ+SkV0No/c=;
 b=LrkN03a1YEbQYtwWqT5FrLxfecbTdz6bQgh+rY2M/zmbbWoId5TO8jBfo/zLJH0VfS
 8h2BKqPf3+uSmr0uZOgAUg47gVtYwkc+litfUaWfB4pT++/B9rjQrrUk47cHeNl1ofy+
 aWaIoA0FkDccjOft5CnGzh3zVoVs7dxMB5Z00gc2TBJYlUvyK2hlztkHlIGNf9D7+M3N
 jfdsDb17MH+AYDkML1Nd4f+rNfvE4Xk3Iq4EeYMJemLZipAHeS5yfEMQbP4aRGd67kEW
 VfGu7AIwbrklHTMbhsIjWVbTBH34NlQpFR6j7QxeiHjAHIiHcXjkOAhiaxIr1yjUYcHS
 u80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718123041; x=1718727841;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z6CHZGE+wy4ZoQyKUm2qp2H54h9bUZZQYZ+SkV0No/c=;
 b=IHBRq6sp7wZJo3ocFtg3U1R6JvBYRd2HlDT24hObYpxN0HZoeVrA8R9et2lqRSoS8t
 gSmj3T2IbtsbGM3xyt3KiU5e8DorGreNz8/TjeevLR1JDFy77NVGptREhvn652A4LIxI
 Y8+ygabBEuFJTRC3+uhtl7G6jLpHLu4aT7b3zjpEV/aehK6NfDcsHHhfcdtB4IraNpS0
 E+Iqq4S3qwR1Q9ufyE6YyLqjg2/l7PCnB5ocfnKXCvXBVBireFWiq5p7KcrtDv4Hj+o5
 FjBOARXK3UaHgD9CdASYqfd9ItIVoqAlr+cIIcOgKYqUKZNHK+7mMS5KloqD7Dtg5/Av
 sqEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEwwBtSAsyGbABO8B5Y2AIF8IZnpqGgmyIsPw0vM9rg3mlA+FuskwFeGofVwqMRVzr1VfqlusPr6NY7QCWGqDYSIYIi6HKriMvd2pMww==
X-Gm-Message-State: AOJu0YxUzCc+X4HpVxtU6wG2HiEjBaLQ2h8rKVjgWqY26zWjRAaIUjGW
 bdcInfRHxQ38cQtC7/RIL/xr6nTLDHSs1tZhC8+ETLjyPMTaL7GIiOpdgixaTGI=
X-Google-Smtp-Source: AGHT+IEI4RaNArbghhgLb91r20ZDGNgGv6sm2aDR+Th+mwxcpKZA1yCRzyt1cfB+PQkBnSzjCgM0KQ==
X-Received: by 2002:a05:6000:1f83:b0:35f:283e:9504 with SMTP id
 ffacd0b85a97d-35f283e9617mr4380890f8f.42.1718123041441; 
 Tue, 11 Jun 2024 09:24:01 -0700 (PDT)
Received: from [192.168.0.101] ([84.69.19.168])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f301dfc52sm1295150f8f.82.2024.06.11.09.24.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jun 2024 09:24:01 -0700 (PDT)
Message-ID: <b2c68930-b165-4d78-84d5-52415923e648@ursulin.net>
Date: Tue, 11 Jun 2024 17:24:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] drm/amdgpu: always enable move threshold for BOs
Content-Language: en-GB
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 friedrich.vock@gmx.de
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20240604160503.43359-1-christian.koenig@amd.com>
 <20240604160503.43359-6-christian.koenig@amd.com>
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20240604160503.43359-6-christian.koenig@amd.com>
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


Hi Christian,

On 04/06/2024 17:05, Christian König wrote:
> This should prevent buffer moves when the threshold is reached during
> CS.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     | 36 ++++++++--------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 22 +++++++++----
>   2 files changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index ec888fc6ead8..9a217932a4fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -784,7 +784,6 @@ static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
>   		.no_wait_gpu = false,
>   		.resv = bo->tbo.base.resv
>   	};
> -	uint32_t domain;
>   	int r;
>   
>   	if (bo->tbo.pin_count)
> @@ -796,37 +795,28 @@ static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
>   	if (p->bytes_moved < p->bytes_moved_threshold &&
>   	    (!bo->tbo.base.dma_buf ||
>   	    list_empty(&bo->tbo.base.dma_buf->attachments))) {
> +
> +		/* And don't move a CPU_ACCESS_REQUIRED BO to limited
> +		 * visible VRAM if we've depleted our allowance to do
> +		 * that.
> +		 */
>   		if (!amdgpu_gmc_vram_full_visible(&adev->gmc) &&
> -		    (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)) {
> -			/* And don't move a CPU_ACCESS_REQUIRED BO to limited
> -			 * visible VRAM if we've depleted our allowance to do
> -			 * that.
> -			 */
> -			if (p->bytes_moved_vis < p->bytes_moved_vis_threshold)
> -				domain = bo->preferred_domains;
> -			else
> -				domain = bo->allowed_domains;
> -		} else {
> -			domain = bo->preferred_domains;
> -		}
> -	} else {
> -		domain = bo->allowed_domains;
> +		    (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED) &&
> +		    p->bytes_moved_vis < p->bytes_moved_vis_threshold)
> +			ctx.move_threshold = p->bytes_moved_vis_threshold -
> +				p->bytes_moved_vis;
> +		else
> +			ctx.move_threshold = p->bytes_moved_vis_threshold -
> +				p->bytes_moved;
>   	}
>   
> -retry:
> -	amdgpu_bo_placement_from_domain(bo, domain);
> +	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
>   	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>   
>   	p->bytes_moved += ctx.bytes_moved;
>   	if (!amdgpu_gmc_vram_full_visible(&adev->gmc) &&
>   	    amdgpu_res_cpu_visible(adev, bo->tbo.resource))
>   		p->bytes_moved_vis += ctx.bytes_moved;
> -
> -	if (unlikely(r == -ENOMEM) && domain != bo->allowed_domains) {
> -		domain = bo->allowed_domains;
> -		goto retry;
> -	}
> -
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 8c92065c2d52..cae1a5420c58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -168,13 +168,23 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
>   			abo->flags & AMDGPU_GEM_CREATE_PREEMPTIBLE ?
>   			AMDGPU_PL_PREEMPT : TTM_PL_TT;
>   		places[c].flags = 0;
> -		/*
> -		 * When GTT is just an alternative to VRAM make sure that we
> -		 * only use it as fallback and still try to fill up VRAM first.
> -		 */
> +
>   		if (domain & abo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM &&
> -		    !(adev->flags & AMD_IS_APU))
> -			places[c].flags |= TTM_PL_FLAG_FALLBACK;
> +		    !(adev->flags & AMD_IS_APU)) {
> +			/*
> +			 * When GTT is just an alternative to VRAM make sure that we
> +			 * only use it as fallback and still try to fill up VRAM first.
> +			*/
> +			if (abo->preferred_domains & AMDGPU_GEM_DOMAIN_GTT)
> +				places[c].flags |= TTM_PL_FLAG_FALLBACK;
> +
> +			/*
> +			 * Enable GTT when the threshold of moved bytes is
> +			 * reached. This prevents any non essential buffer move
> +			 * when the links are already saturated.
> +			 */
> +			places[c].flags |= TTM_PL_FLAG_MOVE_THRESHOLD;
> +		}

For the APU case I *think* this works, but for discrete I am not sure yet.

As a side note and disclaimer, the TTM "resource compatible" logic has a 
half-life of about one week in my brain until I need to almost re-figure 
it all out. I don't know if it just me, but I find it really 
non-intuitive and almost like double, triple, or even quadruple negation 
way of thinking about things.

It is not helping that with this proposal you set threshold on just one 
of the possible object placements which further increases the asymmetry. 
For me intuitive thing would be that thresholds apply to the act of 
changing the current placement directly. Not indirectly via playing with 
one of the placement flags dynamically.

Anyway, lets see.. So you set TTM_PL_FLAG_MOVE_THRESHOLD and 
TTM_PL_FLAG_FALLBACK on the GTT placement, with the logic that it will 
be considered compatible while under the migration budget?

(Side note, the fact both flags are set I also find very difficult to 
mentally model.)

Say a buffer was evicted to GTT already. What then brings it back to VRAM?

The first subsequent ttm_bo_validate pass (!evicting) says GTT is fine 
(applicable) while ctx->bytes_moved < ctx->move_threshold, no? Isn't 
that the opposite of what would be required and causes nothing to be 
migrated back in? What am I missing?

Regards,

Tvrtko
