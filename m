Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6233C07CA9
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Nov 2023 14:08:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28D0010E548;
	Tue, 28 Nov 2023 14:08:31 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F050910E548
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Nov 2023 14:08:27 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32dff08bbdbso3719218f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Nov 2023 06:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701180506; x=1701785306; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JVBux2vZyV6n5xB1/Fmfsi2lyr37PWOkxhM5iwkid3U=;
 b=Oyya5RBYJL0ZLQn36atWbkoz1ORryqw8H8V51srH926i1nvWf+aN0/YovJCZJAEMPS
 85tgkBZOpg0Ke3uSYB4k2bcGapn6aiGiv5Eok5CxSNy/TGXj+BVTeZGl2GsM056CHO1d
 nx2r9OPv/EOJrRkI9oVpx5wDg8lXFDP6EU2XicWBwurAGY8mqRWnFXfvtd6S4oLvi66G
 TwDuktgAVPv5jeEHieYLp7xoqWn/O9DVWiXGNgoyLH63Xzu+0QbJhZJyB/HeB1ZlXBiI
 Dq53DnDqmgyjaZ9jjYMq/U8u53KipozV5HBx2hJbqiw7oaa3o/bh+W7t5OUSbcajipMo
 TpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701180506; x=1701785306;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JVBux2vZyV6n5xB1/Fmfsi2lyr37PWOkxhM5iwkid3U=;
 b=J0cgmF9sWIozUk4xMrGBdm0q5FlPeHXTpt8fpKqnu5j/1dGGlz6f9GzpqdcGV2LmTF
 rq1JVSS6jJCQxd+Etm6boqBiYpWumvkw6wLS+KYF6ePn2WUiO7aPVy+RaJVB8jedK7fY
 NFdKmGXSydiZoZVkyzRoEtsAz91MIAnzPYSFAaMopmDhOwyBz/kBOnsPvOXSCEg+FA/o
 oI0kg8jph0nVqNMsWScuQwvoQXM6rpyuhwTkAQbXjdwTqGXSOW4cm3Hlg1PxOqk4LCFd
 wbcoJs6ADXO9jAQdjk7hMWfmaAZ59bslMNdFowE8SDu7w+UZNYuadkpgbvUEa9rdh8oT
 e3SA==
X-Gm-Message-State: AOJu0Yyfj0VkbdTstOj1NbPgJv7nhuraNEKBL3/W4S9/Wcz1EK/ju+yC
 yMN/5G+KikyKgWAivyTNKTQ=
X-Google-Smtp-Source: AGHT+IGRLb3kLDHzMHokPPEC/x3dx6N/p0LwIf0Yiw9GLUvLmMUAPDRhdHSfYEtWm1KhH9SCSpCISA==
X-Received: by 2002:adf:a490:0:b0:332:e616:ed4f with SMTP id
 g16-20020adfa490000000b00332e616ed4fmr9917371wrb.42.1701180506175; 
 Tue, 28 Nov 2023 06:08:26 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 c9-20020adfef49000000b0032fb7b4f191sm15166864wrp.91.2023.11.28.06.08.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 06:08:25 -0800 (PST)
Message-ID: <a42a4321-9dce-4c76-9578-8ea665b874f8@gmail.com>
Date: Tue, 28 Nov 2023 15:08:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add shared fdinfo stats
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231117195626.13599-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231117195626.13599-1-alexander.deucher@amd.com>
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

Am 17.11.23 um 20:56 schrieb Alex Deucher:
> Add shared stats.  Useful for seeing shared memory.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  4 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 11 +++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  6 ++++++
>   3 files changed, 21 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> index 5706b282a0c7..c7df7fa3459f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> @@ -97,6 +97,10 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
>   		   stats.requested_visible_vram/1024UL);
>   	drm_printf(p, "amd-requested-gtt:\t%llu KiB\n",
>   		   stats.requested_gtt/1024UL);
> +	drm_printf(p, "drm-shared-vram:\t%llu KiB\n", stats.vram_shared/1024UL);
> +	drm_printf(p, "drm-shared-gtt:\t%llu KiB\n", stats.gtt_shared/1024UL);
> +	drm_printf(p, "drm-shared-cpu:\t%llu KiB\n", stats.cpu_shared/1024UL);
> +
>   	for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
>   		if (!usage[hw_ip])
>   			continue;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index d79b4ca1ecfc..c24f7b2c04c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1287,25 +1287,36 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>   			  struct amdgpu_mem_stats *stats)
>   {
>   	uint64_t size = amdgpu_bo_size(bo);
> +	struct drm_gem_object *obj;
>   	unsigned int domain;
> +	bool shared;
>   
>   	/* Abort if the BO doesn't currently have a backing store */
>   	if (!bo->tbo.resource)
>   		return;
>   
> +	obj = &bo->tbo.base;
> +	shared = obj->handle_count > 1;

Interesting approach but I don't think that this is correct.

The handle_count is basically how many GEM handles are there for BO, so 
for example it doesn't catch sharing things with V4L.

What we should probably rather do is to take a look if 
bo->tbo.base.dma_buf is NULL or not.

Regards,
Christian.


> +
>   	domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
>   	switch (domain) {
>   	case AMDGPU_GEM_DOMAIN_VRAM:
>   		stats->vram += size;
>   		if (amdgpu_bo_in_cpu_visible_vram(bo))
>   			stats->visible_vram += size;
> +		if (shared)
> +			stats->vram_shared += size;
>   		break;
>   	case AMDGPU_GEM_DOMAIN_GTT:
>   		stats->gtt += size;
> +		if (shared)
> +			stats->gtt_shared += size;
>   		break;
>   	case AMDGPU_GEM_DOMAIN_CPU:
>   	default:
>   		stats->cpu += size;
> +		if (shared)
> +			stats->cpu_shared += size;
>   		break;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index d28e21baef16..0503af75dc26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -138,12 +138,18 @@ struct amdgpu_bo_vm {
>   struct amdgpu_mem_stats {
>   	/* current VRAM usage, includes visible VRAM */
>   	uint64_t vram;
> +	/* current shared VRAM usage, includes visible VRAM */
> +	uint64_t vram_shared;
>   	/* current visible VRAM usage */
>   	uint64_t visible_vram;
>   	/* current GTT usage */
>   	uint64_t gtt;
> +	/* current shared GTT usage */
> +	uint64_t gtt_shared;
>   	/* current system memory usage */
>   	uint64_t cpu;
> +	/* current shared system memory usage */
> +	uint64_t cpu_shared;
>   	/* sum of evicted buffers, includes visible VRAM */
>   	uint64_t evicted_vram;
>   	/* sum of evicted buffers due to CPU access */

