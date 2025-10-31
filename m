Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646C6CCF9F8
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 11:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0278410EB0B;
	Fri, 31 Oct 2025 11:34:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="KlHpP6UY";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFDFA10EB0B
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 11:34:10 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-3ecde0be34eso2030127f8f.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 04:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1761910449; x=1762515249;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YFoH9dphz22RV4V8e/g5JgWomlWKPQjQuR22oDYHToY=;
 b=KlHpP6UYr5tH8VB8byFnNUJ5cD5acVKEOUmdkq66yWUTBnpxuel7fD4rNjBoNPWYOd
 BFCaxuakfp55O9XHrwO9QBDo8MgOXu8XH21V5MhetsgvNtBn2n502BkZRhASNqHmFxwl
 VVimC53Wbk4M9pxzSx6UX4+DIbBoegC2Pj/otpkFh5fYhU7pncVuWYa7F714iBsgSm7f
 /6SXBdWhWA2HwxVq1nnvgx2zWukkVA0QKX3CFKvl6wwluZiL9aVAJdVTlc5K2LaFjtXT
 J1syxSXVEi8g6UadnTAU+CrVTYh2T2ka8JIbdrxXMEdhkuT78fSk6FHWUY0ljb80fR0R
 1mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761910449; x=1762515249;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YFoH9dphz22RV4V8e/g5JgWomlWKPQjQuR22oDYHToY=;
 b=nbnuMJ4zh3rG6f6/P79lVd6Vj3hI5RNyD3xk7XIMJiECcJdD8q2AW5DVu9eUW0I2Ff
 qEJoXtiACcM990CgOv6+amPxMuXKkWdd3GRFh/S+z597SPjD3wdOgtNAkhZ2LCuWeJUs
 wu2RSpsA5uPbBfuE0aipdw1CNVXSt/Yomhh4ShNLjZrVlwsY7xGEQjPvcHRoD7gts9y/
 aWxWKgxyvfP5R36Kz1CHjJdnMp1SXhnxsQ24lbIUa2bxSNRtqCo+bspZ2yUAVLpAGGhx
 oSXOKNMpeSgkrv33RfVM6XbZkZYGzyFHhGsJuKA7Q7c0GrXfRcoPG8rMz07WwEeLFvpn
 ZtTw==
X-Gm-Message-State: AOJu0YydyTFcofo8mvMokiiUvq0s5vgGu8zNSoGdpCZIru5GS0xaooPp
 tdT75FLjCQhcUimUJH2zEmLT2GlBhNZ5l0Jt5NAN2lpLyttz68/fV1i1lA+tjQjumlE=
X-Gm-Gg: ASbGncsb7a03AFWNYCxKU30UBFp+EVOwIS3SG9pmInQE/6uUIMLY8XRbl3KH/Eq0UgJ
 cvHKePy1cSADKEygZSuA3wXNbrDTit/m1XhAc3Vy7uu+ugVVMXa/VEXbMLAXfyp5IltzCtuhrEx
 3rx9J39k48tTrpaaeKbZrx3XH5VfuZdon0TTKp8V2wBAXKpGJY/F/BLc9FisbPSL/IHDB1KKIv9
 jR7W+obhe7/xDCLIPpy1mSa47tLWtQIG5XqakAT/n6L7J9SFzvwIq+FNsiI2LQnVnPK8IUFK+ys
 9z6Ui0ESw78CfEH4JjoOOGRS4SJMOc3UoXzEaEK/EXEPs41RJEVnPfUeBeqjJqPPTdcqxXuBHwX
 CY0cxAnBPwo1bcmudx01B+q9otwCpa2SuyRzqy0KuYhLEcePwKeVznIl1ay4iUOfRbKiiy92ePu
 /RzwpcBUBAnFeoBFOT46tVcmIAc9APl5o9iaaAGA==
X-Google-Smtp-Source: AGHT+IFNuI6XvXz/21/93Z9Xgap5O6+X30C1xltgLrY/68Kwz6eDPhNHCzKd1IK+3yhpTrYGeQozvQ==
X-Received: by 2002:a05:6000:615:b0:429:bc68:6ca0 with SMTP id
 ffacd0b85a97d-429bc686fd5mr3075065f8f.4.1761910448985; 
 Fri, 31 Oct 2025 04:34:08 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47732ff8004sm28524355e9.15.2025.10.31.04.34.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 04:34:08 -0700 (PDT)
Message-ID: <a95987d2-c696-4e3d-9b9f-a76aa70489a3@ursulin.net>
Date: Fri, 31 Oct 2025 11:34:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/amdgpu: increment sched score on entity
 selection
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20251030091118.4864-1-pierre-eric.pelloux-prayer@amd.com>
 <20251030091118.4864-2-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251030091118.4864-2-pierre-eric.pelloux-prayer@amd.com>
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


On 30/10/2025 09:11, Pierre-Eric Pelloux-Prayer wrote:
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
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 23 +++++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
>   2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index f5d5c45ddc0d..953c81c928c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -209,6 +209,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   	struct amdgpu_ctx_entity *entity;
>   	enum drm_sched_priority drm_prio;
>   	unsigned int hw_prio, num_scheds;
> +	struct amdgpu_ring *aring;
>   	int32_t ctx_prio;
>   	int r;
>   
> @@ -236,14 +237,16 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   		r = amdgpu_xcp_select_scheds(adev, hw_ip, hw_prio, fpriv,
>   						&num_scheds, &scheds);
>   		if (r)
> -			goto cleanup_entity;
> +			goto error_free_entity;

It would be best to split this out as a standalone patch. It is not a 
bug due kzalloc and DRM scheduler not doing anything with it in 
drm_sched_fini but still it would be best practice.

>   	}
>   
> -	/* disable load balance if the hw engine retains context among dependent jobs */
> -	if (hw_ip == AMDGPU_HW_IP_VCN_ENC ||
> -	    hw_ip == AMDGPU_HW_IP_VCN_DEC ||
> -	    hw_ip == AMDGPU_HW_IP_UVD_ENC ||
> -	    hw_ip == AMDGPU_HW_IP_UVD) {
> +	sched = scheds[0];
> +	aring = container_of(sched, struct amdgpu_ring, sched);
> +
> +	if (aring->funcs->engine_retains_context) {
> +		/* Disable load balancing between multiple schedulers if the hw
> +		 * engine retains context among dependent jobs.
> +		 */
>   		sched = drm_sched_pick_best(scheds, num_scheds);
>   		scheds = &sched;
>   		num_scheds = 1;
> @@ -258,6 +261,11 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   	if (cmpxchg(&ctx->entities[hw_ip][ring], NULL, entity))
>   		goto cleanup_entity;
>   
> +	if (aring->funcs->engine_retains_context) {
> +		entity->sched_score = sched->score;

Here is would always be sched->score == aring->sched_score, right?

If so it would probably be good to either add that assert, or even to 
just fetch it from there. Otherwise it can look potentially concerning 
to be fishing out the pointer from scheduler internals.

The rest looks good to me.

Regards,

Tvrtko

> +		atomic_inc(entity->sched_score);
> +	}
> +
>   	return 0;
>   
>   cleanup_entity:
> @@ -514,6 +522,9 @@ static void amdgpu_ctx_do_release(struct kref *ref)
>   			if (!ctx->entities[i][j])
>   				continue;
>   
> +			if (ctx->entities[i][j]->sched_score)
> +				atomic_dec(ctx->entities[i][j]->sched_score);
> +
>   			drm_sched_entity_destroy(&ctx->entities[i][j]->entity);
>   		}
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index 090dfe86f75b..f7b44f96f374 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -39,6 +39,7 @@ struct amdgpu_ctx_entity {
>   	uint32_t		hw_ip;
>   	uint64_t		sequence;
>   	struct drm_sched_entity	entity;
> +	atomic_t		*sched_score;
>   	struct dma_fence	*fences[];
>   };
>   

