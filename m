Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACCDCA0FF0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Sep 2025 09:02:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9301310E3D8;
	Mon,  1 Sep 2025 09:02:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="XVjtta+0";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EB3310E3D8
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Sep 2025 09:02:05 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-45b7c01a708so12813785e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Sep 2025 02:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1756717324; x=1757322124;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q8RPXBLC5ldsUqsxVQXK6DmVHhHHPKbMvb74af34BlQ=;
 b=XVjtta+0LrEF30O7r5FoaQvLIyIAia8z3soYD9XBE2MbInIfcVCOfhom1halrA24Es
 RVffkOmbmmSU9mukHwQc6t14rykIGxIvMv1A+C6F81WMBQnwjgNa9ErEwY+lAwVGyGKu
 WAc5rdX2eszqiJIgPSFEg7rOzgRoKI3v+9XaYQp7tlEdSxR4P9rhSqj5+vZUmvOn5m1H
 xTy02Zz4GYIiw5VsmoJL7o2m/iy8mNxwSCua2l8L1ouf4oSRSIDD0zPK4KYqEaZAHj+m
 mEgon97z/LlZt1lzr3IprVISOkCG2mHtGK0dD2Ine5WAEaQEJF9sN6yaBlKPVyMr9bFt
 asFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756717324; x=1757322124;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q8RPXBLC5ldsUqsxVQXK6DmVHhHHPKbMvb74af34BlQ=;
 b=azzF0cD9/zc5TekJLrnEK1uEKx5EwRlaPBEDaCsIXpfhmOWAR8xmhZNRneLf7io21p
 WE/I54InEK7J9yVIj0Og/TGJ4KDdwTW9Pl9TPIZF/3FoiwnZq5pvdYKiJBPU/2yCysOM
 oQzONPsbnoS3zBGCHfNAIhKMgXciPuEhiEyKR6bjS39pDVelnmVktkkiYF9AeawE1Bb0
 oJaxvKBOyzW8aPCiKm8aGFEJdVpmkKJSkXcK2brRdz3ODFzf7FTTxENFJKZYKUD0WuJv
 wSA2//hiC60+CHLZB35qFzjAZum+ON0cUuY4L5UKov0vN+330XkqxFccDP9E74E66rPP
 prGA==
X-Gm-Message-State: AOJu0YwZlEP4fpvO0W/nDwuGNQHNm11WGJf2kg5gG01Wqb7MtclJJIEO
 XxD8WLi8msLOGSK6zjGLY+bbT6j8TVvan5K5I0WZO8UJj+WIthkxb8DqdbtEXh+6mTs=
X-Gm-Gg: ASbGncuS2EhwFr7e8X7gqYy6FOnl0bSFlgJJDtRL6tCfEULjprYADdKiQM1+NFZUBoF
 rUe4xH8Vvmap+AIG/rRg2tnnf6xEvTP/T99L/gmOyQFQVCsDvsZHohbfNn8psSh+3oAsr4KrPWL
 ZCgmRbGx9zn5bPEnNDmqPJLAPUE3pSjwcWiBX6mMIKnCddD1jzaJhaLjPe4Uxy3Yt89276mKgN5
 RJVfuaeLSq90wSLz5kIsrffepx+Cn1iNigOm7mEzEc3G+pjdiqoPhKmz3uYvTVsn883nSCwiKcW
 KxR+stDWDt8Rqge57iB56vwtNKIIKLCXPsTkTbWdqrVNmUBbjo5W2o9AWD0NXwsAxyrNCm3xm66
 MAVuPO4ZMmm5PstDIxG6Ka2VsiLR9XRfMwSeVCvf/p6Fxmw==
X-Google-Smtp-Source: AGHT+IFATa0P1gj9ZG+bFpTTF/PDbmIBdrStL6Ztg7iLjcDRq2nyWpFsCTfBKuh9T9aPaqNoKufiSQ==
X-Received: by 2002:a05:600c:1d06:b0:45b:6275:42cc with SMTP id
 5b1f17b1804b1-45b8557a3f7mr54828095e9.28.1756717323313; 
 Mon, 01 Sep 2025 02:02:03 -0700 (PDT)
Received: from [192.168.0.101] ([84.66.36.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b8efb280csm9195665e9.3.2025.09.01.02.02.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 02:02:02 -0700 (PDT)
Message-ID: <a05bb414-4dd1-4cbe-aa1a-beaea2d056aa@ursulin.net>
Date: Mon, 1 Sep 2025 10:02:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu: increment share sched score on entity
 selection
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250822134348.6819-1-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20250822134348.6819-1-pierre-eric.pelloux-prayer@amd.com>
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


On 22/08/2025 14:43, Pierre-Eric Pelloux-Prayer wrote:
> For hw engines that can't load balance jobs, entities are
> "statically" load balanced: on their first submit, they select
> the best scheduler based on its score.
> The score is made up of 2 parts:
> * the job queue depth (how much jobs are executing/waiting)
> * the number of entities assigned
> 
> The second part is only relevant for the static load balance:
> it's a way to consider how many entities are attached to this
> scheduler, knowing that if they ever submit jobs they will go
> to this one.
> 
> For rings that can load balance jobs freely, idle entities
> aren't a concern and shouldn't impact the scheduler's decisions.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 23 ++++++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
>   2 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index f5d5c45ddc0d..4a078d2d98c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -206,9 +206,11 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   {
>   	struct drm_gpu_scheduler **scheds = NULL, *sched = NULL;
>   	struct amdgpu_device *adev = ctx->mgr->adev;
> +	bool static_load_balancing = false;
>   	struct amdgpu_ctx_entity *entity;
>   	enum drm_sched_priority drm_prio;
>   	unsigned int hw_prio, num_scheds;
> +	struct amdgpu_ring *aring;
>   	int32_t ctx_prio;
>   	int r;
>   
> @@ -236,17 +238,22 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   		r = amdgpu_xcp_select_scheds(adev, hw_ip, hw_prio, fpriv,
>   						&num_scheds, &scheds);
>   		if (r)
> -			goto cleanup_entity;
> +			goto error_free_entity;

Indeed, previously this was calling drm_sched_entity_fini() before 
drm_sched_entity_init() and it only worked because of kzalloc.

>   	}
>   
>   	/* disable load balance if the hw engine retains context among dependent jobs */
> -	if (hw_ip == AMDGPU_HW_IP_VCN_ENC ||
> -	    hw_ip == AMDGPU_HW_IP_VCN_DEC ||
> -	    hw_ip == AMDGPU_HW_IP_UVD_ENC ||
> -	    hw_ip == AMDGPU_HW_IP_UVD) {
> +	static_load_balancing = hw_ip == AMDGPU_HW_IP_VCN_ENC ||
> +				hw_ip == AMDGPU_HW_IP_VCN_DEC ||
> +				hw_ip == AMDGPU_HW_IP_UVD_ENC ||
> +				hw_ip == AMDGPU_HW_IP_UVD;
> +
> +	if (static_load_balancing) {
>   		sched = drm_sched_pick_best(scheds, num_scheds);
>   		scheds = &sched;
>   		num_scheds = 1;
> +		aring = container_of(sched, struct amdgpu_ring, sched);
> +		entity->sched_ring_score = aring->sched_score;
> +		atomic_inc(entity->sched_ring_score);

If we were to bike-shed we could find a way to avoid the new local 
variables. Keeping the if as is and assign to entity->sched_ring_score 
directly, and then checking for that on the cleanup path. Still works 
due kzalloc. Or if relying on kzalloc is not desired, at least bool 
static_load_balance could be replaced by re-naming the aring local as 
static_aring and using it like the name suggests.

Could also move the atomic_inc to the success path to avoid having to 
add code to error unwind.

Both cases are I think equally racy in the sense that parallel 
amdgpu_ctx_init_entity invocations can all pick the same sched. But that 
is true today AFAICT because score is not incremented until later in the 
job submit process.

I suppose one way to make the assignment more robust would be to 
"rotate" (or randomize) the sched list atomically before calling 
drm_sched_pick_best. Thoughts?

Regards,

Tvrtko

>   	}
>   
>   	r = drm_sched_entity_init(&entity->entity, drm_prio, scheds, num_scheds,
> @@ -264,6 +271,9 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   	drm_sched_entity_fini(&entity->entity);
>   
>   error_free_entity:
> +	if (static_load_balancing)
> +		atomic_dec(entity->sched_ring_score);
> +
>   	kfree(entity);
>   
>   	return r;
> @@ -514,6 +524,9 @@ static void amdgpu_ctx_do_release(struct kref *ref)
>   			if (!ctx->entities[i][j])
>   				continue;
>   
> +			if (ctx->entities[i][j]->sched_ring_score)
> +				atomic_dec(ctx->entities[i][j]->sched_ring_score);
> +
>   			drm_sched_entity_destroy(&ctx->entities[i][j]->entity);
>   		}
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index 090dfe86f75b..076a0e165ce0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -39,6 +39,7 @@ struct amdgpu_ctx_entity {
>   	uint32_t		hw_ip;
>   	uint64_t		sequence;
>   	struct drm_sched_entity	entity;
> +	atomic_t		*sched_ring_score;
>   	struct dma_fence	*fences[];
>   };
>   

