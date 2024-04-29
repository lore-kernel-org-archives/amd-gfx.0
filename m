Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E11C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 11:03:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C60CD10E8B3;
	Mon, 29 Apr 2024 11:03:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ezNOThbL";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13E8010E8B3
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 11:03:33 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-346406a5fb9so3679638f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 04:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714388611; x=1714993411; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7w2a9kD1iSL73IWVnAF67scfMjWLQ6gdNIzY+8GdOVc=;
 b=ezNOThbL1STE2fAFCbu3WzUnzAlO2UyNhWvvCQYJt4fPEOIbBvXCXKTqhxAEaEnq90
 LXyC/F5EZVvtk6bfz0Tm18i7wa6+6u/d6sOxYX2dSfTKLdTqOoi4KaCQJ9WaRC7ZbZhs
 tniLv65pOX9Ooi9F6USaGqSOTaaRmi9ifSNmHNg5MGajkfcYIrtOpn/TDH5lJ4UnBpjx
 w4U7HhJabMqi8/+f1/gh62La5uatcBp1hVrQNEvR0QBaFrhqN543DpZJHnKoE8HndAXq
 50o22apFM4+RpVurSEAzPF3l2ehohRYPldAyLFglhw1j4FnysO/ZlvUFdR5wtRmis2gS
 4zOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714388611; x=1714993411;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7w2a9kD1iSL73IWVnAF67scfMjWLQ6gdNIzY+8GdOVc=;
 b=FUTi1kFBuGWmydzqA643zVftijnHcVljCZ9dM0tVDdCJ89fwgi9rCyA4hOADZYZJ32
 FXT0XP3SNPe1AVgZUBZw2mzaSqi3hZwKkH17gQ2HOCSJ1TM0+yTYYsnA90O9Ye0Rrow0
 sKYWWaM672qJfJRjajI7KEFuZvPk/VuCcv/CY+ngMiCIfqJWxIEzee73eGiD52vnJcrb
 kqBNAgu5SiZi5TfeqKe+C/cybkGyjvoYozOSjxJ2Aa651LzlLn4klctwilFKGSjnnmnW
 k5gLlNOVsBzyyh9mXvqt/Gm+CXiTCozG8Vb0WmZpRtFSwLyaWcNJYyicLEQ4J9cWEzUf
 8hhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnc41gEGjCziorRj+sDatmMQCvnXoj8jjmk6HNi5GdxeMey9TpsF80mlcH3maXEt0alDEOmHMYf6efeHb9UdbfQcZITZms86Gx2aGcKQ==
X-Gm-Message-State: AOJu0YxdwWss9vsIvcRs9HZYLo7XdJ5x4pU+5Kuk8nT6oAcpa5JuPRTH
 9Xn+rbqxCyl7DjLpQvAYCQEYOF7IF5tgZxhs4UVG79z2tIGw6ucs
X-Google-Smtp-Source: AGHT+IH8AKVD8LxOv18XgtNrU/TVqvR96pUz1OB3JjIT75x+s6OAmX60+MSyeWL7VBalaurQkTPmlg==
X-Received: by 2002:a05:6000:b0e:b0:34c:dbf5:f513 with SMTP id
 dj14-20020a0560000b0e00b0034cdbf5f513mr2466293wrb.6.1714388611116; 
 Mon, 29 Apr 2024 04:03:31 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 x2-20020adfdd82000000b0034c78bba70bsm7381776wrl.72.2024.04.29.04.03.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 04:03:30 -0700 (PDT)
Message-ID: <5a8ba071-21b7-44de-8473-b82193cfa35d@gmail.com>
Date: Mon, 29 Apr 2024 13:03:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: Reduce mem_type to domain double
 indirection
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: <20240426164355.1563-1-tursulin@igalia.com>
 <20240426164355.1563-3-tursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240426164355.1563-3-tursulin@igalia.com>
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

Am 26.04.24 um 18:43 schrieb Tvrtko Ursulin:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> All apart from AMDGPU_GEM_DOMAIN_GTT memory domains map 1:1 to TTM
> placements. And the former be either AMDGPU_PL_PREEMPT or TTM_PL_TT,
> depending on AMDGPU_GEM_CREATE_PREEMPTIBLE.
>
> Simplify a few places in the code which convert the TTM placement into
> a domain by checking against the current placement directly.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  4 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 30 ++++++++++-----------
>   2 files changed, 16 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 055ba2ea4c12..ff83f8d8628c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -165,8 +165,8 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>   		if (r)
>   			return ERR_PTR(r);
>   
> -	} else if (!(amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type) &
> -		     AMDGPU_GEM_DOMAIN_GTT)) {
> +	} else if (bo->tbo.resource->mem_type != TTM_PL_TT &&
> +		   bo->tbo.resource->mem_type != AMDGPU_PL_PREEMPT) {
>   		return ERR_PTR(-EBUSY);
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 8bc79924d171..fb984669fc3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -976,12 +976,12 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>   
>   	ttm_bo_pin(&bo->tbo);
>   
> -	domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
> -	if (domain == AMDGPU_GEM_DOMAIN_VRAM) {
> +	if (bo->tbo.resource->mem_type == TTM_PL_VRAM) {
>   		atomic64_add(amdgpu_bo_size(bo), &adev->vram_pin_size);
>   		atomic64_add(amdgpu_vram_mgr_bo_visible_size(bo),
>   			     &adev->visible_pin_size);
> -	} else if (domain == AMDGPU_GEM_DOMAIN_GTT) {
> +	} else if (bo->tbo.resource->mem_type == TTM_PL_TT ||
> +		   bo->tbo.resource->mem_type == AMDGPU_PL_PREEMPT) {
>   		atomic64_add(amdgpu_bo_size(bo), &adev->gart_pin_size);
>   	}
>   
> @@ -1280,7 +1280,6 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>   {
>   	uint64_t size = amdgpu_bo_size(bo);
>   	struct drm_gem_object *obj;
> -	unsigned int domain;
>   	bool shared;
>   
>   	/* Abort if the BO doesn't currently have a backing store */
> @@ -1290,21 +1289,21 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>   	obj = &bo->tbo.base;
>   	shared = drm_gem_object_is_shared_for_memory_stats(obj);
>   
> -	domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
> -	switch (domain) {
> -	case AMDGPU_GEM_DOMAIN_VRAM:
> +	switch (bo->tbo.resource->mem_type) {
> +	case TTM_PL_VRAM:
>   		stats->vram += size;
>   		if (amdgpu_bo_in_cpu_visible_vram(bo))
>   			stats->visible_vram += size;
>   		if (shared)
>   			stats->vram_shared += size;
>   		break;
> -	case AMDGPU_GEM_DOMAIN_GTT:
> +	case TTM_PL_TT:
> +	case AMDGPU_PL_PREEMPT:
>   		stats->gtt += size;
>   		if (shared)
>   			stats->gtt_shared += size;
>   		break;
> -	case AMDGPU_GEM_DOMAIN_CPU:
> +	case TTM_PL_SYSTEM:
>   	default:
>   		stats->cpu += size;
>   		if (shared)
> @@ -1317,7 +1316,7 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>   		if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
>   			stats->requested_visible_vram += size;
>   
> -		if (domain != AMDGPU_GEM_DOMAIN_VRAM) {
> +		if (bo->tbo.resource->mem_type != TTM_PL_VRAM) {
>   			stats->evicted_vram += size;
>   			if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
>   				stats->evicted_visible_vram += size;
> @@ -1592,19 +1591,18 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
>   	u64 size;
>   
>   	if (dma_resv_trylock(bo->tbo.base.resv)) {
> -		unsigned int domain;
> -		domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
> -		switch (domain) {
> -		case AMDGPU_GEM_DOMAIN_VRAM:
> +		switch (bo->tbo.resource->mem_type) {
> +		case TTM_PL_VRAM:
>   			if (amdgpu_bo_in_cpu_visible_vram(bo))
>   				placement = "VRAM VISIBLE";
>   			else
>   				placement = "VRAM";
>   			break;
> -		case AMDGPU_GEM_DOMAIN_GTT:
> +		case TTM_PL_TT:
> +		case AMDGPU_PL_PREEMPT:
>   			placement = "GTT";
>   			break;
> -		case AMDGPU_GEM_DOMAIN_CPU:
> +		case TTM_PL_SYSTEM:
>   		default:
>   			placement = "CPU";
>   			break;

