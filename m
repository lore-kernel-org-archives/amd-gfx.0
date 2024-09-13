Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4A5FA3723
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Sep 2024 07:33:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5CD210E832;
	Fri, 13 Sep 2024 07:33:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SMj4HslW";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6B5810E832
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Sep 2024 07:33:01 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3770320574aso1289486f8f.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Sep 2024 00:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726212780; x=1726817580; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4ZSdVnFkgUIZhA9kPHtX2ZnFf063BdJxRzVVAk5H9Wc=;
 b=SMj4HslWpoIvSRbbHSvB8ssbx1zVHlJxPDCSYEfqa1EuPcO0KADqquiHTfCo+vZU3L
 WO+kY7yD2D0kCKzlDT24oP35Hkzsfnj71Fe6BfoQnEZ5Fnpvxse4kYPr1bNfvzkbzCPR
 bC5WtHXsyLCcSNEq0T3a34I0VWV+GIg0CixUJ/uNj4fyq7OJ2DmX8V2tR8eKD0Cv6hut
 dR5KIVdRoyybhv2VLHayf2XqUGJuMjwhCd6V8AtdsfkDYkuLO0bacGNmrwXT6kVPBhf5
 EFy1JD4IQpMst2kYDiAvLJwPADuS4a69y6PPpTd8gIKZZJgr8X7zGcOpYlEubnLKAPhO
 m+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726212780; x=1726817580;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4ZSdVnFkgUIZhA9kPHtX2ZnFf063BdJxRzVVAk5H9Wc=;
 b=FuiXXACumw6fOJTbppJPQv7xcyFuZwCy2Fq1nplcHu9OeZUGv+VGVaON7HIQBGHt0L
 HltCvKkh7tmFzTbcAPPaBYzsoArxjl35DzcFtGl40vBpW3aJJG/mmysYiyPidyGz+rHn
 cB/FxfV+NZ1Q75TbHA3Ht1S0NZEnRqByc75wtNK74Psd1Dv3V+xl05qLSOZUUiqbKJqW
 aozPwSHA9eDQmC8zf/qiNOXErZTTaSvXY9PEFfpbIDMj0fix55qUPOvH3iC4x9Mu9sKH
 TqLhHHeEfXrC5AErt37wIucu9P63LLrExzWAQA04qbupyGgojvnkAy7fcg6Yp32BTbjN
 gocQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXggIz4V+jFJxqtA/aUQzUVpbXg2Ts5w2VpOa5Bm516UTjISFPFNJpmAdUN9ZfcBvvohfQtW0f+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzbhvfssIDgaV36qG/HRk6zmi98+vlp2zx/ULehrSNt1GqW61+v
 QI18PeBoiUDvapmDRzqAUGFijHkx6miV/chPahMdNZpCVtDwCahgyKT7MPhI
X-Google-Smtp-Source: AGHT+IHG1qPwpeVBFbRale+tQY+YWJ00cDTziSCT3RSIWEvlVASdCFVvhwoSmRq17HUJArQEEf6cgw==
X-Received: by 2002:a5d:5266:0:b0:368:71bc:2b0c with SMTP id
 ffacd0b85a97d-378c2cfed41mr3334716f8f.10.1726212779196; 
 Fri, 13 Sep 2024 00:32:59 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3789566550asm16045927f8f.35.2024.09.13.00.32.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2024 00:32:58 -0700 (PDT)
Message-ID: <94434478-f562-4f05-a56f-c9451ff56c49@gmail.com>
Date: Fri, 13 Sep 2024 09:32:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] drm/amdgpu: stop tracking visible memory stats
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com
Cc: Alexander.Deucher@amd.com
References: <20240911151329.9438-1-Yunxiang.Li@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240911151329.9438-1-Yunxiang.Li@amd.com>
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

Am 11.09.24 um 17:13 schrieb Yunxiang Li:
> Since on modern systems all of vram can be made visible anyways, to
> simplify the new implementation, drops tracking how much memory is
> visible for now. If this is still needed we can add it back on top of
> the new implementation.
>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  6 ------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 11 +----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 14 ++++----------
>   3 files changed, 5 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> index c7df7fa3459f..9a40ff5c6dd3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> @@ -85,16 +85,10 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
>   	drm_printf(p, "drm-memory-vram:\t%llu KiB\n", stats.vram/1024UL);
>   	drm_printf(p, "drm-memory-gtt: \t%llu KiB\n", stats.gtt/1024UL);
>   	drm_printf(p, "drm-memory-cpu: \t%llu KiB\n", stats.cpu/1024UL);
> -	drm_printf(p, "amd-memory-visible-vram:\t%llu KiB\n",
> -		   stats.visible_vram/1024UL);
>   	drm_printf(p, "amd-evicted-vram:\t%llu KiB\n",
>   		   stats.evicted_vram/1024UL);
> -	drm_printf(p, "amd-evicted-visible-vram:\t%llu KiB\n",
> -		   stats.evicted_visible_vram/1024UL);
>   	drm_printf(p, "amd-requested-vram:\t%llu KiB\n",
>   		   stats.requested_vram/1024UL);
> -	drm_printf(p, "amd-requested-visible-vram:\t%llu KiB\n",
> -		   stats.requested_visible_vram/1024UL);
>   	drm_printf(p, "amd-requested-gtt:\t%llu KiB\n",
>   		   stats.requested_gtt/1024UL);
>   	drm_printf(p, "drm-shared-vram:\t%llu KiB\n", stats.vram_shared/1024UL);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 6faeb9e4a572..bcf25c7e85e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1282,7 +1282,6 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
>   void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>   			  struct amdgpu_mem_stats *stats)
>   {
> -	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>   	struct ttm_resource *res = bo->tbo.resource;
>   	uint64_t size = amdgpu_bo_size(bo);
>   	struct drm_gem_object *obj;
> @@ -1298,8 +1297,6 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>   	switch (res->mem_type) {
>   	case TTM_PL_VRAM:
>   		stats->vram += size;
> -		if (amdgpu_res_cpu_visible(adev, res))
> -			stats->visible_vram += size;
>   		if (shared)
>   			stats->vram_shared += size;
>   		break;
> @@ -1318,14 +1315,8 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>   
>   	if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
>   		stats->requested_vram += size;
> -		if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
> -			stats->requested_visible_vram += size;
> -
> -		if (res->mem_type != TTM_PL_VRAM) {
> +		if (res->mem_type != TTM_PL_VRAM)
>   			stats->evicted_vram += size;
> -			if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
> -				stats->evicted_visible_vram += size;
> -		}
>   	} else if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_GTT) {
>   		stats->requested_gtt += size;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index d7e27957013f..e14b4fbb486e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -142,12 +142,10 @@ struct amdgpu_bo_vm {
>   };
>   
>   struct amdgpu_mem_stats {
> -	/* current VRAM usage, includes visible VRAM */
> +	/* current VRAM usage */
>   	uint64_t vram;
> -	/* current shared VRAM usage, includes visible VRAM */
> +	/* current shared VRAM usage */
>   	uint64_t vram_shared;
> -	/* current visible VRAM usage */
> -	uint64_t visible_vram;
>   	/* current GTT usage */
>   	uint64_t gtt;
>   	/* current shared GTT usage */
> @@ -156,14 +154,10 @@ struct amdgpu_mem_stats {
>   	uint64_t cpu;
>   	/* current shared system memory usage */
>   	uint64_t cpu_shared;
> -	/* sum of evicted buffers, includes visible VRAM */
> +	/* sum of evicted buffers */
>   	uint64_t evicted_vram;
> -	/* sum of evicted buffers due to CPU access */
> -	uint64_t evicted_visible_vram;
> -	/* how much userspace asked for, includes vis.VRAM */
> -	uint64_t requested_vram;
>   	/* how much userspace asked for */
> -	uint64_t requested_visible_vram;
> +	uint64_t requested_vram;
>   	/* how much userspace asked for */
>   	uint64_t requested_gtt;
>   };

