Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C22BC10F1A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 May 2024 09:16:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9010B10F41D;
	Tue,  7 May 2024 09:16:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="FkPXy9m7";
	dkim-atps=neutral
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com
 [209.85.208.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 206D710F41D
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 09:16:53 +0000 (UTC)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-2e3e18c240fso8214961fa.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 May 2024 02:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1715073411; x=1715678211;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hBj6w0jqFTWdnT41X5aan/KzESgTvDM0SfS/Lh1coyQ=;
 b=FkPXy9m7HsTmH7wA8nPCKvr9g8Y6e8kwlxt2NrOIx1yQwVQpKrtShWXVcc+l9e8r92
 230fc8QtfSM5dhJ5o0uIaI3frDtUhBPVofS9L0UkBZeN4Zt2+hK2IdfwS5IkNltF61dz
 SgYShPhuYNt+VCRiEdSuK0tHUR6BqwmaCzhNRekMXn9/a+oLMY2EH7oupa1rTHlEDXNH
 bQ5tr823THQboV0m/DyGGGyD3PiYWpHHYoqe27pfXjaKABX2uSbNCRwb3WWjqaNBzhOW
 it6w1zQSV2G0R58x/l4Tmn3ESzqm99har9TBOF3zTxgiqKcCWCvzHbty+fMYBXlDv2L3
 J9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715073411; x=1715678211;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hBj6w0jqFTWdnT41X5aan/KzESgTvDM0SfS/Lh1coyQ=;
 b=QQ9Dv/kQqzyVJQ1a8WGH8lGt9UOZUmGf60amHSG+ux0Ujo3LibwvTyalkdz/PMxLL1
 1STRTWXZ8cS+BNjsrv6XvvMjHZyvN4Ue+piJCPIXOnP5B2ffihjAp+Mjz7r9N6QbpeWz
 R6tiLAT2v7DAFQjZSX1S5f/vvX9k25Wbg2gGRvLXXqC5btIjoRIFMxQW5xuKhg26R4MA
 vDQTeQFNmmhnSsrnvdiR8RfOpH54d2tajGhRPK6tz1D8kePirhHIDSZQfSfql81Dnur4
 v9vUheurGZ0XL44NYOao+CNBDyDMwgxLfqC6DVNnjq74c5YgGN1FyZ97X+pUM+e/eKbD
 58KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9VOMuIpugdub4cvC6lUWcOS++hPch/9bpuefJetXWbibsulN8UtWuD9UHKNDnXpzUQlvbWq2geXY5Hbk9p6bZgMUF32IIv1a9UkJQgw==
X-Gm-Message-State: AOJu0YyDVs3hSxhrk3x5lnQCPTSJZdC6CnxyXF0m40NrfVmdaAnXh5Ry
 nQOiNEbiHtwXprDFyPpliuIQbgswk5XLzBonuK+9ERU/PLaMLETtCvIRDqzuwbU=
X-Google-Smtp-Source: AGHT+IFgcg2caN+3kF1UaOdwdZmnbAIM1gMJdPvWY/ZJmMvILHaV0xyCvmbE+bwb4RT1i/YNNgRU1Q==
X-Received: by 2002:a05:6512:6cf:b0:51e:f70c:88ec with SMTP id
 u15-20020a05651206cf00b0051ef70c88ecmr13341599lff.16.1715073410904; 
 Tue, 07 May 2024 02:16:50 -0700 (PDT)
Received: from [192.168.0.101] ([84.69.19.168])
 by smtp.gmail.com with ESMTPSA id
 n44-20020a05600c502c00b004146e58cc35sm22894401wmr.46.2024.05.07.02.16.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 02:16:50 -0700 (PDT)
Message-ID: <a21bd1b3-e590-4f59-b086-8cc4346dd225@ursulin.net>
Date: Tue, 7 May 2024 10:16:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] drm/amdgpu: Use drm_print_memory_stats helper from
 fdinfo
Content-Language: en-GB
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Rob Clark <robdclark@chromium.org>
References: <20240506165959.50648-1-tursulin@igalia.com>
 <20240506165959.50648-6-tursulin@igalia.com>
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20240506165959.50648-6-tursulin@igalia.com>
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


On 06/05/2024 17:59, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> Convert fdinfo memory stats to use the common drm_print_memory_stats
> helper.
> 
> This achieves alignment with the common keys as documented in
> drm-usage-stats.rst, adding specifically drm-total- key the driver was
> missing until now.
> 
> Additionally I made the code stop skipping total size for objects which
> currently do not have a backing store, and I added resident and active
> reporting.
> 
> Legacy keys have been preserved, with the outlook of only potentially
> removing only the drm-memory- when the time gets right.
> 
> The example output now looks like this:
> 
>   pos:	0
>   flags:	02100002
>   mnt_id:	24
>   ino:	1204
>   drm-driver:	amdgpu
>   drm-client-id:	30
>   drm-pdev:	0000:04:00.0
>   pasid:	32785
>   drm-total-cpu:	0
>   drm-shared-cpu:	0
>   drm-active-cpu:	0
>   drm-resident-cpu:	0
>   drm-total-gtt:	22 MiB
>   drm-shared-gtt:	0
>   drm-active-gtt:	10 MiB
>   drm-resident-gtt:	22 MiB
>   drm-total-vram:	544428 KiB
>   drm-shared-vram:	13584 KiB
>   drm-active-vram:	260356 KiB
>   drm-resident-vram:	544428 KiB
>   drm-memory-vram:	544428 KiB
>   drm-memory-gtt: 	22528 KiB
>   drm-memory-cpu: 	0 KiB
>   amd-memory-visible-vram:	544428 KiB
>   amd-evicted-vram:	0 KiB
>   amd-evicted-visible-vram:	0 KiB
>   amd-requested-vram:	544428 KiB
>   amd-requested-visible-vram:	90112 KiB
>   amd-requested-gtt:	22528 KiB
>   drm-engine-gfx:	39456116802 ns
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 47 +++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 94 ++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 35 +++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 20 ++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  3 +-
>   6 files changed, 116 insertions(+), 84 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> index c7df7fa3459f..1422ea642ad0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> @@ -59,18 +59,21 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
>   	struct amdgpu_fpriv *fpriv = file->driver_priv;
>   	struct amdgpu_vm *vm = &fpriv->vm;
>   
> -	struct amdgpu_mem_stats stats;
> +	struct amdgpu_mem_stats stats[__AMDGPU_PL_LAST + 1] = { };
>   	ktime_t usage[AMDGPU_HW_IP_NUM];
> -	unsigned int hw_ip;
> +	const char *pl_name[] = {
> +		[TTM_PL_VRAM] = "vram",
> +		[TTM_PL_TT] = "gtt",
> +		[TTM_PL_SYSTEM] = "cpu",
> +	};
> +	unsigned int hw_ip, i;
>   	int ret;
>   
> -	memset(&stats, 0, sizeof(stats));
> -
>   	ret = amdgpu_bo_reserve(vm->root.bo, false);
>   	if (ret)
>   		return;
>   
> -	amdgpu_vm_get_memory(vm, &stats);
> +	amdgpu_vm_get_memory(vm, stats, ARRAY_SIZE(stats));
>   	amdgpu_bo_unreserve(vm->root.bo);
>   
>   	amdgpu_ctx_mgr_usage(&fpriv->ctx_mgr, usage);
> @@ -82,24 +85,34 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
>   	 */
>   
>   	drm_printf(p, "pasid:\t%u\n", fpriv->vm.pasid);
> -	drm_printf(p, "drm-memory-vram:\t%llu KiB\n", stats.vram/1024UL);
> -	drm_printf(p, "drm-memory-gtt: \t%llu KiB\n", stats.gtt/1024UL);
> -	drm_printf(p, "drm-memory-cpu: \t%llu KiB\n", stats.cpu/1024UL);
> +
> +	for (i = 0; i < TTM_PL_PRIV; i++)
> +		drm_print_memory_stats(p,
> +				       &stats[i].drm,
> +				       DRM_GEM_OBJECT_RESIDENT,
> +				       pl_name[i]);
> +
> +	/* Legacy amdgpu keys, alias to drm-total-memory-: */
> +	drm_printf(p, "drm-memory-vram:\t%llu KiB\n",
> +		   stats[TTM_PL_VRAM].total/1024UL);
> +	drm_printf(p, "drm-memory-gtt: \t%llu KiB\n",
> +		   stats[TTM_PL_TT].total/1024UL);
> +	drm_printf(p, "drm-memory-cpu: \t%llu KiB\n",
> +		   stats[TTM_PL_SYSTEM].total/1024UL);
> +
> +	/* Amdgpu specific memory accounting keys: */
>   	drm_printf(p, "amd-memory-visible-vram:\t%llu KiB\n",
> -		   stats.visible_vram/1024UL);
> +		   stats[TTM_PL_VRAM].visible/1024UL);
>   	drm_printf(p, "amd-evicted-vram:\t%llu KiB\n",
> -		   stats.evicted_vram/1024UL);
> +		   stats[TTM_PL_VRAM].evicted/1024UL);
>   	drm_printf(p, "amd-evicted-visible-vram:\t%llu KiB\n",
> -		   stats.evicted_visible_vram/1024UL);
> +		   stats[TTM_PL_VRAM].evicted_visible/1024UL);
>   	drm_printf(p, "amd-requested-vram:\t%llu KiB\n",
> -		   stats.requested_vram/1024UL);
> +		   stats[TTM_PL_VRAM].requested/1024UL);
>   	drm_printf(p, "amd-requested-visible-vram:\t%llu KiB\n",
> -		   stats.requested_visible_vram/1024UL);
> +		   stats[TTM_PL_VRAM].requested_visible/1024UL);
>   	drm_printf(p, "amd-requested-gtt:\t%llu KiB\n",
> -		   stats.requested_gtt/1024UL);
> -	drm_printf(p, "drm-shared-vram:\t%llu KiB\n", stats.vram_shared/1024UL);
> -	drm_printf(p, "drm-shared-gtt:\t%llu KiB\n", stats.gtt_shared/1024UL);
> -	drm_printf(p, "drm-shared-cpu:\t%llu KiB\n", stats.cpu_shared/1024UL);
> +		   stats[TTM_PL_TT].requested/1024UL);
>   
>   	for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
>   		if (!usage[hw_ip])
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index fa5227a4aac2..50b7e7c0ce50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1286,54 +1286,84 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
>   }
>   
>   void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
> -			  struct amdgpu_mem_stats *stats)
> +			  struct amdgpu_mem_stats *stats,
> +			  unsigned int sz)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>   	struct ttm_resource *res = bo->tbo.resource;
> +	struct drm_gem_object *obj = &bo->tbo.base;
>   	uint64_t size = amdgpu_bo_size(bo);
> -	struct drm_gem_object *obj;
> -	bool shared;
> +	unsigned int type;
>   
> -	/* Abort if the BO doesn't currently have a backing store */
> -	if (!res)
> +	if (!res) {

Some time after sending I realized actually because of this check, 
existing drm-memory- in amdgpu could be more like drm-resident- and not 
drm-total-.

Does that make sense? Should I go "back to the drawing board" with 4/5 
and document the aliasing between two different keys? (And respin this 
patch too in that case.)

Regards,

Tvrtko

> +		const unsigned int domain_to_pl[] = {
> +			[ilog2(AMDGPU_GEM_DOMAIN_CPU)]	    = TTM_PL_SYSTEM,
> +			[ilog2(AMDGPU_GEM_DOMAIN_GTT)]	    = TTM_PL_TT,
> +			[ilog2(AMDGPU_GEM_DOMAIN_VRAM)]	    = TTM_PL_VRAM,
> +			[ilog2(AMDGPU_GEM_DOMAIN_GDS)]	    = AMDGPU_PL_GDS,
> +			[ilog2(AMDGPU_GEM_DOMAIN_GWS)]	    = AMDGPU_PL_GWS,
> +			[ilog2(AMDGPU_GEM_DOMAIN_OA)]	    = AMDGPU_PL_OA,
> +			[ilog2(AMDGPU_GEM_DOMAIN_DOORBELL)] = AMDGPU_PL_DOORBELL,
> +		};
> +		/*
> +		 * If no backing store use one of the preferred domain for basic
> +		 * stats. We take the MSB since that should give a reasonable
> +		 * view.
> +		 */
> +		BUILD_BUG_ON(TTM_PL_VRAM < TTM_PL_TT ||
> +			     TTM_PL_VRAM < TTM_PL_SYSTEM);
> +		type = fls(bo->preferred_domains & AMDGPU_GEM_DOMAIN_MASK);
> +		if (!type)
> +			return;
> +		type--;
> +		if (type >= ARRAY_SIZE(domain_to_pl))
> +			return;
> +		type = domain_to_pl[type];
> +	} else {
> +		switch (res->mem_type) {
> +		case TTM_PL_VRAM:
> +		case TTM_PL_TT:
> +		case TTM_PL_SYSTEM:
> +			type = res->mem_type;
> +			break;
> +		default:
> +			/* Squash into 'cpu' to keep the existing userspace view. */
> +			type = TTM_PL_SYSTEM;
> +			break;
> +		}
> +	}
> +
> +	if (drm_WARN_ON(&adev->ddev, type >= sz))
>   		return;
>   
> -	obj = &bo->tbo.base;
> -	shared = drm_gem_object_is_shared_for_memory_stats(obj);
> +	stats[type].total += size;
> +	if (drm_gem_object_is_shared_for_memory_stats(obj))
> +		stats[type].drm.shared += size;
> +	else
> +		stats[type].drm.private += size;
>   
> -	switch (res->mem_type) {
> -	case TTM_PL_VRAM:
> -		stats->vram += size;
> -		if (amdgpu_res_cpu_visible(adev, res))
> -			stats->visible_vram += size;
> -		if (shared)
> -			stats->vram_shared += size;
> -		break;
> -	case TTM_PL_TT:
> -		stats->gtt += size;
> -		if (shared)
> -			stats->gtt_shared += size;
> -		break;
> -	case TTM_PL_SYSTEM:
> -	default:
> -		stats->cpu += size;
> -		if (shared)
> -			stats->cpu_shared += size;
> -		break;
> +	if (res) {
> +		stats[type].drm.resident += size;
> +
> +		if (!dma_resv_test_signaled(obj->resv, DMA_RESV_USAGE_BOOKKEEP))
> +			stats[type].drm.active += size;
> +
> +		if (type == TTM_PL_VRAM && amdgpu_res_cpu_visible(adev, res))
> +			stats[type].visible += size;
>   	}
>   
>   	if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
> -		stats->requested_vram += size;
> +		stats[TTM_PL_VRAM].requested += size;
>   		if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
> -			stats->requested_visible_vram += size;
> +			stats[TTM_PL_VRAM].requested_visible += size;
>   
> -		if (res->mem_type != TTM_PL_VRAM) {
> -			stats->evicted_vram += size;
> +		if (type != TTM_PL_VRAM) {
> +			stats[TTM_PL_VRAM].evicted += size;
>   			if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
> -				stats->evicted_visible_vram += size;
> +				stats[TTM_PL_VRAM].evicted_visible += size;
>   		}
>   	} else if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_GTT) {
> -		stats->requested_gtt += size;
> +		stats[TTM_PL_TT].requested += size;
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index bc42ccbde659..44774584a29f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -136,30 +136,14 @@ struct amdgpu_bo_vm {
>   };
>   
>   struct amdgpu_mem_stats {
> -	/* current VRAM usage, includes visible VRAM */
> -	uint64_t vram;
> -	/* current shared VRAM usage, includes visible VRAM */
> -	uint64_t vram_shared;
> -	/* current visible VRAM usage */
> -	uint64_t visible_vram;
> -	/* current GTT usage */
> -	uint64_t gtt;
> -	/* current shared GTT usage */
> -	uint64_t gtt_shared;
> -	/* current system memory usage */
> -	uint64_t cpu;
> -	/* current shared system memory usage */
> -	uint64_t cpu_shared;
> -	/* sum of evicted buffers, includes visible VRAM */
> -	uint64_t evicted_vram;
> -	/* sum of evicted buffers due to CPU access */
> -	uint64_t evicted_visible_vram;
> -	/* how much userspace asked for, includes vis.VRAM */
> -	uint64_t requested_vram;
> -	/* how much userspace asked for */
> -	uint64_t requested_visible_vram;
> -	/* how much userspace asked for */
> -	uint64_t requested_gtt;
> +	struct drm_memory_stats drm;
> +
> +	uint64_t total;
> +	uint64_t visible;
> +	uint64_t evicted;
> +	uint64_t evicted_visible;
> +	uint64_t requested;
> +	uint64_t requested_visible;
>   };
>   
>   static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct ttm_buffer_object *tbo)
> @@ -342,7 +326,8 @@ int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
>   u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
>   u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
>   void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
> -			  struct amdgpu_mem_stats *stats);
> +			  struct amdgpu_mem_stats *stats,
> +			  unsigned int size);
>   void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo_vm *vmbo);
>   int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow,
>   			     struct dma_fence **fence);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index b6f53129dea3..ab95c43ff596 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -34,6 +34,7 @@
>   #define AMDGPU_PL_OA		(TTM_PL_PRIV + 2)
>   #define AMDGPU_PL_PREEMPT	(TTM_PL_PRIV + 3)
>   #define AMDGPU_PL_DOORBELL	(TTM_PL_PRIV + 4)
> +#define __AMDGPU_PL_LAST	(TTM_PL_PRIV + 4)
>   
>   #define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
>   #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 9ccb9814874c..6bddd43604bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1089,7 +1089,8 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   }
>   
>   static void amdgpu_vm_bo_get_memory(struct amdgpu_bo_va *bo_va,
> -				    struct amdgpu_mem_stats *stats)
> +				    struct amdgpu_mem_stats *stats,
> +				    unsigned int size)
>   {
>   	struct amdgpu_vm *vm = bo_va->base.vm;
>   	struct amdgpu_bo *bo = bo_va->base.bo;
> @@ -1105,34 +1106,35 @@ static void amdgpu_vm_bo_get_memory(struct amdgpu_bo_va *bo_va,
>   	    !dma_resv_trylock(bo->tbo.base.resv))
>   		return;
>   
> -	amdgpu_bo_get_memory(bo, stats);
> +	amdgpu_bo_get_memory(bo, stats, size);
>   	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
>   		dma_resv_unlock(bo->tbo.base.resv);
>   }
>   
>   void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
> -			  struct amdgpu_mem_stats *stats)
> +			  struct amdgpu_mem_stats *stats,
> +			  unsigned int size)
>   {
>   	struct amdgpu_bo_va *bo_va, *tmp;
>   
>   	spin_lock(&vm->status_lock);
>   	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status)
> -		amdgpu_vm_bo_get_memory(bo_va, stats);
> +		amdgpu_vm_bo_get_memory(bo_va, stats, size);
>   
>   	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status)
> -		amdgpu_vm_bo_get_memory(bo_va, stats);
> +		amdgpu_vm_bo_get_memory(bo_va, stats, size);
>   
>   	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status)
> -		amdgpu_vm_bo_get_memory(bo_va, stats);
> +		amdgpu_vm_bo_get_memory(bo_va, stats, size);
>   
>   	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status)
> -		amdgpu_vm_bo_get_memory(bo_va, stats);
> +		amdgpu_vm_bo_get_memory(bo_va, stats, size);
>   
>   	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status)
> -		amdgpu_vm_bo_get_memory(bo_va, stats);
> +		amdgpu_vm_bo_get_memory(bo_va, stats, size);
>   
>   	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status)
> -		amdgpu_vm_bo_get_memory(bo_va, stats);
> +		amdgpu_vm_bo_get_memory(bo_va, stats, size);
>   	spin_unlock(&vm->status_lock);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index ec688a47dec1..9759d5bdf8e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -537,7 +537,8 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
>   void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
>   				struct amdgpu_vm *vm);
>   void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
> -			  struct amdgpu_mem_stats *stats);
> +			  struct amdgpu_mem_stats *stats,
> +			  unsigned int size);
>   
>   int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		       struct amdgpu_bo_vm *vmbo, bool immediate);
