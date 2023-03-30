Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB9EC74A5B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 06:12:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B35B810E075;
	Thu, 30 Mar 2023 06:12:32 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C228310E075
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 06:12:30 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id eh3so72143921edb.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 23:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680156749;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mW+3rjXdQhBI0E/nMPmpItDgB0kZ5r1zwYP20GUT5xI=;
 b=o9kdwxtujmQ3VkEBzH5otiQeu1xNF4s9jlEQC7sZEbcveEop8ykZlpyYRYKHlWnDwt
 xS9ls2u/eHXV7zus7VlHp0stsZuC4/6AsecZd8EFshe3Lq2f9LfnA+eAOds54EyNWQ3X
 YH0hlzFXC9qmXtJaF5dvhLQqZRxXjeA1KZcR7tEjRSco0FfH1xH+bc4G3bF1GqdArQSO
 2G3mRPfipvZq4zi+TpqrT0CajJcyPWSA9FdFGuV/kqldGp+W0ol5Ty4f1xHmlu4Tiv4Q
 3iPH9lJZYNnaaph0A6IVzuctOc/ZwSiw9CT1ob1k3Hfi4azSX4/9QyPVro2GwUL5xNgH
 EIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680156749;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mW+3rjXdQhBI0E/nMPmpItDgB0kZ5r1zwYP20GUT5xI=;
 b=g1GcAXinQRAlQ+rnqmetSCjdTIQ/lh9Lu+3l2jlT45kYr1FKYWpDkKDgjh0O+iZOXB
 rb67rztLVGd0r572cE4ulRAn/O1gjN0DPog48B7BUmqKRKD15Ya7LRZSSSpeJTW1+rc8
 lC1PGoiBVw0J8+PIR+DNlDIRjiCefus1CdEH6thMcIljXmdbDv+yratf9zxn0ieSnuCS
 EGJqkEQtmvLjmCagJsXKC1e4ZvHRA3R2OfmYeD0bPc1L4f/I+cHQzcSPFOPVZvyiqRrg
 Cq/w/i0XV6yD8pnsEe/mUBka1Rr5sRJzpFN6OFuhFCPo2SWhcIMmvkc7sgdpcfa5gSlT
 ptSA==
X-Gm-Message-State: AAQBX9cEpb621tzIfNnsL3u9muCIDN06iEuLxYQpqeIpQwzCjcQZTYZA
 bSbkvZMZfvyEhpZvhQnxwF1mh4eK280=
X-Google-Smtp-Source: AKy350b8bsvapuFnefjtlu/UcGMcUgsiGzO2yebv7TRwC19m+IJa0KkUOjy//oMYCXOx58D8jOad9A==
X-Received: by 2002:a17:907:75d5:b0:932:6601:4910 with SMTP id
 jl21-20020a17090775d500b0093266014910mr20933890ejc.54.1680156748698; 
 Wed, 29 Mar 2023 23:12:28 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 r9-20020a1709061ba900b009474ee5de37sm398883ejg.143.2023.03.29.23.12.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Mar 2023 23:12:28 -0700 (PDT)
Message-ID: <06cfb048-5349-9e96-ebd2-7adbbb66ebc5@gmail.com>
Date: Thu, 30 Mar 2023 08:12:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 04/13] drm/amdgpu: add gfx shadow CS IOCTL support
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329152521.1980681-1-alexander.deucher@amd.com>
 <20230329152521.1980681-5-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230329152521.1980681-5-alexander.deucher@amd.com>
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 29.03.23 um 17:25 schrieb Alex Deucher:
> From: Christian König <christian.koenig@amd.com>
>
> Add support for submitting the shadow update packet
> when submitting an IB.  Needed for MCBP on GFX11.
>
> v2: update API for CSA (Alex)
> v3: fix ordering; SET_Q_PREEMPTION_MODE most come before COND_EXEC
>      Add missing check for AMDGPU_CHUNK_ID_CP_GFX_SHADOW in
>      amdgpu_cs_pass1()
>      Only initialize shadow on first use
>      (Alex)
> v4: Pass parameters rather than job to new ring callback (Alex)
> v5: squash in change to call SET_Q_PREEMPTION_MODE/COND_EXEC
>      before RELEASE_MEM to complete the UMDs use of the shadow (Alex)
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   | 26 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 29 +++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  6 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  3 +++
>   4 files changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 47763ac0d14a..41bd3a1a1989 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -281,6 +281,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>   		case AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES:
>   		case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT:
>   		case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:
> +		case AMDGPU_CHUNK_ID_CP_GFX_SHADOW:
>   			break;
>   
>   		default:
> @@ -583,6 +584,26 @@ static int amdgpu_cs_p2_syncobj_timeline_signal(struct amdgpu_cs_parser *p,
>   	return 0;
>   }
>   
> +static int amdgpu_cs_p2_shadow(struct amdgpu_cs_parser *p,
> +			       struct amdgpu_cs_chunk *chunk)
> +{
> +	struct drm_amdgpu_cs_chunk_cp_gfx_shadow *shadow = chunk->kdata;
> +	int i;
> +
> +	if (shadow->flags & ~AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW)
> +		return -EINVAL;
> +
> +	for (i = 0; i < p->gang_size; ++i) {
> +		p->jobs[i]->shadow_va = shadow->shadow_va;
> +		p->jobs[i]->csa_va = shadow->csa_va;
> +		p->jobs[i]->gds_va = shadow->gds_va;
> +		p->jobs[i]->init_shadow =
> +			shadow->flags & AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW;
> +	}
> +
> +	return 0;
> +}
> +
>   static int amdgpu_cs_pass2(struct amdgpu_cs_parser *p)
>   {
>   	unsigned int ce_preempt = 0, de_preempt = 0;
> @@ -625,6 +646,11 @@ static int amdgpu_cs_pass2(struct amdgpu_cs_parser *p)
>   			if (r)
>   				return r;
>   			break;
> +		case AMDGPU_CHUNK_ID_CP_GFX_SHADOW:
> +			r = amdgpu_cs_p2_shadow(p, chunk);
> +			if (r)
> +				return r;
> +			break;
>   		}
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index bcccc348dbe2..9bee630eb0c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -136,7 +136,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   	uint64_t fence_ctx;
>   	uint32_t status = 0, alloc_size;
>   	unsigned fence_flags = 0;
> -	bool secure;
> +	bool secure, init_shadow;
> +	u64 shadow_va, csa_va, gds_va;
> +	int vmid = AMDGPU_JOB_GET_VMID(job);
>   
>   	unsigned i;
>   	int r = 0;
> @@ -150,9 +152,17 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   		vm = job->vm;
>   		fence_ctx = job->base.s_fence ?
>   			job->base.s_fence->scheduled.context : 0;
> +		shadow_va = job->shadow_va;
> +		csa_va = job->csa_va;
> +		gds_va = job->gds_va;
> +		init_shadow = job->init_shadow;
>   	} else {
>   		vm = NULL;
>   		fence_ctx = 0;
> +		shadow_va = 0;
> +		csa_va = 0;
> +		gds_va = 0;
> +		init_shadow = false;
>   	}
>   
>   	if (!ring->sched.ready && !ring->is_mes_queue) {
> @@ -212,6 +222,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   	}
>   
>   	amdgpu_ring_ib_begin(ring);
> +
> +	if (job && ring->funcs->emit_gfx_shadow)
> +		amdgpu_ring_emit_gfx_shadow(ring, shadow_va, csa_va, gds_va,
> +					    init_shadow, vmid);
> +
>   	if (job && ring->funcs->init_cond_exec)
>   		patch_offset = amdgpu_ring_init_cond_exec(ring);
>   
> @@ -263,6 +278,18 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   				       fence_flags | AMDGPU_FENCE_FLAG_64BIT);
>   	}
>   
> +	if (ring->funcs->emit_gfx_shadow) {
> +		amdgpu_ring_emit_gfx_shadow(ring, 0, 0, 0, false, 0);
> +
> +		if (ring->funcs->init_cond_exec) {
> +			unsigned ce_offset = ~0;
> +
> +			ce_offset = amdgpu_ring_init_cond_exec(ring);
> +			if (ce_offset != ~0 && ring->funcs->patch_cond_exec)
> +				amdgpu_ring_patch_cond_exec(ring, ce_offset);
> +		}
> +	}
> +
>   	r = amdgpu_fence_emit(ring, f, job, fence_flags);
>   	if (r) {
>   		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 52f2e313ea17..3f9804f956c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -67,6 +67,12 @@ struct amdgpu_job {
>   	uint64_t		uf_addr;
>   	uint64_t		uf_sequence;
>   
> +	/* virtual addresses for shadow/GDS/CSA */
> +	uint64_t		shadow_va;
> +	uint64_t		csa_va;
> +	uint64_t		gds_va;
> +	bool			init_shadow;

Doesn't the job has a flags field for stuff like that? Or was that the IB?

Apart from that looks good to me.

> +
>   	/* job_run_counter >= 1 means a resubmit job */
>   	uint32_t		job_run_counter;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 3989e755a5b4..7942cb62e52c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -212,6 +212,8 @@ struct amdgpu_ring_funcs {
>   	void (*end_use)(struct amdgpu_ring *ring);
>   	void (*emit_switch_buffer) (struct amdgpu_ring *ring);
>   	void (*emit_cntxcntl) (struct amdgpu_ring *ring, uint32_t flags);
> +	void (*emit_gfx_shadow)(struct amdgpu_ring *ring, u64 shadow_va, u64 csa_va,
> +				u64 gds_va, bool init_shadow, int vmid);
>   	void (*emit_rreg)(struct amdgpu_ring *ring, uint32_t reg,
>   			  uint32_t reg_val_offs);
>   	void (*emit_wreg)(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
> @@ -307,6 +309,7 @@ struct amdgpu_ring {
>   #define amdgpu_ring_emit_hdp_flush(r) (r)->funcs->emit_hdp_flush((r))
>   #define amdgpu_ring_emit_switch_buffer(r) (r)->funcs->emit_switch_buffer((r))
>   #define amdgpu_ring_emit_cntxcntl(r, d) (r)->funcs->emit_cntxcntl((r), (d))
> +#define amdgpu_ring_emit_gfx_shadow(r, s, c, g, i, v) (r)->funcs->emit_gfx_shadow((r), (s), (c), (g), (i), (v))
>   #define amdgpu_ring_emit_rreg(r, d, o) (r)->funcs->emit_rreg((r), (d), (o))
>   #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r), (d), (v))
>   #define amdgpu_ring_emit_reg_wait(r, d, v, m) (r)->funcs->emit_reg_wait((r), (d), (v), (m))

