Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18342CCFA03
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 10:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FD6910E870;
	Thu,  6 Nov 2025 10:00:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="RSQ6VQfh";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2100210E86F
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 10:00:17 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-477549b3082so6663105e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Nov 2025 02:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1762423215; x=1763028015; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4/Zq2ZMLTkW/3rjXrb4929ZqxG9YuHUsxu8QuLD1NzA=;
 b=RSQ6VQfh/AYyEpTQhCp8huyTeIe2Wf1Z0LYy3NDgv90L/dRow0FSyfO5MEdvLXXPMJ
 Ur5G4BPRCrULQKTI9eCqbdKw9WNKrLcSyHj4jMtD1I8773JqAcAFXSZ45guyz5MANcOB
 XzXvAPYcXL2tS6ghol3PFwcdasbA/hf65X9gzfOB3+89scu2opj1HgVqGQOkmCZjFzkD
 GL0/zKF0q6jb37QCdDVLYGoNyFw8dxsLasULD1Vm53TgoR2cy7O3z2YO4OcQf+gxw/gV
 s6L9Kbg+U7dcUkYgN0s1UmKlcH70nZaUK8C7UatAVIRhKy/nSEW7aafj0xO2UzW0Mvt+
 k2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762423215; x=1763028015;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4/Zq2ZMLTkW/3rjXrb4929ZqxG9YuHUsxu8QuLD1NzA=;
 b=xIRdAnJI2WWH7o+XgWteD+aJRyerFtB/twjEvSEFYqETjFbdljtqjs6OBwRwhaumXm
 0/cHwBvTjfQHv7aiK5yCjEmC90F5EwwN9dFRX9dfWLbYZEzvSKbDSqlZJEyHKOPSVa9S
 mH5vbwI4Wjl8RzqHj9P7LDZOyJ93NidNmwyXFJnHA251kcsVyr2nB5arhpXbFFSYL53O
 ipav28RaR5RBzeFyHUBUzpCbk1RhBht0ABo+05nr1NyZreu7aaSFAj2K2SUk/O+FJho7
 fi9zMKTXDAZ21ODHaWPjXPuJus3Rkt/RQ+lRfNKV3jw/MLqHru7gVb+ZBTmn4l1fKhg9
 +LqA==
X-Gm-Message-State: AOJu0YxqcRCS+ecoePF1xp7VJlQ0l2O2JsP3fxk6e4JjV02Cq2Xs4yOc
 KYTSlJLWGw2WoUwj2T0YeNmtJfsTGEO4eBgyXKQAvZhdlu/ye9EtgdVxHNbrR17dgCQ=
X-Gm-Gg: ASbGncsxu6AVMJmluRvTCXCvPSCv9Khp/+eo2TfpMvA6a2QWiPIndqTVRXWtr/sOo0x
 mzhhjlerH8VQI9lzEPelb+7kXgeVB+USMgQA1SkO2TTJk2Fpsa6nuAddCgpg74SuB+5JRpGQ9mB
 u/dkHuswDsH0itZvymha92zPaQxF7zNH7M7EAvfKgFdjEg3Lgf1UGCUlYNOSOBra8ws/8Zc/Sfd
 U64HeZ0BJGohif/NAph/fofK2Kv+T9EQ9wPfUpTnGMpyymudYYAI+XCMAWn3fZJ378ThR7HNr+x
 ivqrsRvUgQ2bhORf01hTMrIVN2yup1kvKnTyOUfEJ0c1B6t2e3bMiE/GvyMAnYbZf57kyJ49Pcb
 7oofTkuM8Azlrf6WRpnQ/P8i190kFA3CmdlWoFm26Hf1pcGYTjyG4o586eu6jHqsmPVZBJ9YXoJ
 2+M3WYpstciMw1TpSKQA0kOeGg6Z4=
X-Google-Smtp-Source: AGHT+IEZKVyRG59cakGUG/uu7olGLVJjMN0xfbpmUq5+ampqbuf/q1ePNFMJ6cguRcdgyKCUSlBC+w==
X-Received: by 2002:a05:6000:210c:b0:429:8daa:c6b1 with SMTP id
 ffacd0b85a97d-429e3308887mr4652869f8f.38.1762423214827; 
 Thu, 06 Nov 2025 02:00:14 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429eb41102bsm4118122f8f.17.2025.11.06.02.00.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 02:00:14 -0800 (PST)
Message-ID: <9e5abc5f-1948-4b18-8485-6540f84cdfd8@ursulin.net>
Date: Thu, 6 Nov 2025 10:00:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] drm/amdgpu: increment sched score on entity
 selection
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20251106093933.18859-1-pierre-eric.pelloux-prayer@amd.com>
 <20251106093933.18859-3-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251106093933.18859-3-pierre-eric.pelloux-prayer@amd.com>
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


On 06/11/2025 09:39, Pierre-Eric Pelloux-Prayer wrote:
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
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 21 ++++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
>   2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index afedea02188d..953c81c928c1 100644
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
> @@ -239,11 +240,13 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   			goto error_free_entity;
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
> +		atomic_inc(entity->sched_score);

Maybe you missed it, in the last round I asked this:

"""
Here is would always be sched->score == aring->sched_score, right?

If so it would probably be good to either add that assert, or even to 
just fetch it from there. Otherwise it can look potentially concerning 
to be fishing out the pointer from scheduler internals.

The rest looks good to me.
"""

Because grabbing a pointer from drm_sched->score and storing it in AMD 
entity can look scary, since sched->score can be scheduler owned.

Hence I was suggesting to either fish it out from aring->sched_score. If 
it is true that they are always the same atomic_t at this point.

Regards,

Tvrtko

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

