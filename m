Return-Path: <SRS0=Ny8F=5J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBCDC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 18:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 087662076F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 18:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hatUi2pg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087662076F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C910A896EB;
	Tue, 24 Mar 2020 18:41:40 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1BA1896EB
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 18:41:39 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id z5so163612wml.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 11:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=XK5a0u1xcXNDDNcqwdMsvfuvV/iS2SB/k1Iloew9pFQ=;
 b=hatUi2pgpg+5+bI5LxDjw0XssxXK5/SC2F6wJuLPNnuM4vbKJsi2esjnCQoo9NCLan
 1w2Iv0b5y9GM97KhfVX9sC07oxQZ3hqxW5utunVVWOcrNTmFMStuTFdLkotFvIox088V
 SkbHPfXnWmvtpCIH/IvxGWf/UoxlWfjQhi9l41D1h0wiJWzMeYNB2FPeLDuJjkKqVjcc
 GDhFoPXEe5iJ1yuTeGHO+uJ6NsueCJbU93uyciI8Kj5ZVoFRfLE//swZbYcZEpM7TfZN
 4332nBSYWszjEsoWRaww3TIAhNx7006lHNw7yiVD3VeMAUVTF5QxrXkPjy/vUB57OYtl
 kreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=XK5a0u1xcXNDDNcqwdMsvfuvV/iS2SB/k1Iloew9pFQ=;
 b=EHpxSOk8tvN1nF9ClyNU9/kSmSPrFzMglO93GufdkgwgL4wP4nkkGeL6Fyid9pJj79
 6GSAjmTf6ypnj5a/rP9DvH5Ql277dfAhgvcBXVsnSrHUGegiJyz2LV7jHYOLSXtS8afE
 ArBDLhjxQfiy6INcCPXvGgbsvFiJ2gVTgzoAKasyxJsMEjC9pJqf6FLNKwN1fMY0VKPH
 +BFQ6DQKSQnmjyi5XXKPdyeZ9QJR4YibvuRogH/50xmA4ZpmPjgOEPE6htzkjo6qXY2X
 /R0WLVCG9CTOj/dkH39ZYd4KeHP8gZ5JY6ZFh9IwpEWi8V/fHxT0n3W7bRyDAcQhvgDW
 Tfaw==
X-Gm-Message-State: ANhLgQ1nTbnNWKctmw2+FLI52e4DAeHuIZ1mtXuPxpLoergvMzCm7UxL
 Ab4qXU0es6QcWnn/GzzrtD8=
X-Google-Smtp-Source: ADFU+vuimhJZg4gpTaEUb3gLWI59pfkf0/MVsYxvzfvtRpQCXcPSWl7XtxdFZVM0jpUiuWK+zJQypw==
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr7194207wma.20.1585075297061; 
 Tue, 24 Mar 2020 11:41:37 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id e9sm29823579wrw.30.2020.03.24.11.41.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 24 Mar 2020 11:41:36 -0700 (PDT)
Subject: Re: [RFC PATCH 1/1] drm/amdgpu: rework sched_list generation
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200324114010.104796-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <41048a10-4ff9-b69d-8f3e-247b4e925d06@gmail.com>
Date: Tue, 24 Mar 2020 19:41:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200324114010.104796-1-nirmoy.das@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: alexander.deucher@amd.com, ray.huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 24.03.20 um 12:40 schrieb Nirmoy Das:
> Generate HW IP's sched_list in amdgpu_ring_init() instead of
> amdgpu_ctx.c. This makes amdgpu_ctx_init_compute_sched(),
> ring.has_high_prio and amdgpu_ctx_init_sched() unnecessary.
> This patch also stores sched_list for all HW IPs in one big
> array in struct amdgpu_device which makes amdgpu_ctx_init_entity()
> much more leaner.

Well good start, a few style nit picks below. But in general no time 
right now to review this deeply.

>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 148 ++++-----------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |   3 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   2 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |   5 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h   |   2 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |  11 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  28 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h   |   2 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h    |   4 -
>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c      |   3 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  13 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c      |   5 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      |   5 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  11 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  13 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c     |   3 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c     |   3 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c     |   3 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c     |   3 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     |   3 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |   6 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     |   3 +-
>   drivers/gpu/drm/amd/amdgpu/si_dma.c        |   3 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c      |   3 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c      |   3 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c      |   7 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c      |   6 +-
>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c      |   2 +-
>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c      |   3 +-
>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c      |   3 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c      |   6 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c      |   6 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c      |   6 +-
>   35 files changed, 131 insertions(+), 203 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 7dd74253e7b6..ac2ab2933e12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -984,6 +984,10 @@ struct amdgpu_device {
>   	char				product_number[16];
>   	char				product_name[32];
>   	char				serial[16];
> +
> +	/* drm scheduler list */
> +	struct drm_gpu_scheduler	*ctx_scheds[AMDGPU_HW_IP_NUM][AMDGPU_RING_PRIO_MAX][AMDGPU_MAX_COMPUTE_RINGS];
> +	uint32_t			ctx_num_scheds[AMDGPU_HW_IP_NUM][AMDGPU_RING_PRIO_MAX];
>   };
>   
>   static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *bdev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 6ed36a2c5f73..24e98d674570 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -72,6 +72,15 @@ static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_compute_prio(enum drm_sch
>   	}
>   }
>   
> +static unsigned int amdgpu_ctx_sched_prio_to_hw_prio(enum drm_sched_priority prio,
> +						     const int hw_ip)
> +{
> +	if (hw_ip == AMDGPU_HW_IP_COMPUTE)
> +		return amdgpu_ctx_sched_prio_to_compute_prio(prio);
> +
> +	return AMDGPU_RING_PRIO_DEFAULT;
> +}
> +
>   static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, const u32 hw_ip, const u32 ring)
>   {
>   	struct amdgpu_device *adev = ctx->adev;
> @@ -90,52 +99,19 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, const u32 hw_ip, const
>   	entity->sequence = 1;
>   	priority = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
>   				ctx->init_priority : ctx->override_priority;
> -	switch (hw_ip) {
> -	case AMDGPU_HW_IP_GFX:
> -		sched = &adev->gfx.gfx_ring[0].sched;
> -		scheds = &sched;
> -		num_scheds = 1;
> -		break;
> -	case AMDGPU_HW_IP_COMPUTE:
> -		hw_prio = amdgpu_ctx_sched_prio_to_compute_prio(priority);
> -		scheds = adev->gfx.compute_prio_sched[hw_prio];
> -		num_scheds = adev->gfx.num_compute_sched[hw_prio];
> -		break;
> -	case AMDGPU_HW_IP_DMA:
> -		scheds = adev->sdma.sdma_sched;
> -		num_scheds = adev->sdma.num_sdma_sched;
> -		break;
> -	case AMDGPU_HW_IP_UVD:
> -		sched = &adev->uvd.inst[0].ring.sched;
> -		scheds = &sched;
> -		num_scheds = 1;
> -		break;
> -	case AMDGPU_HW_IP_VCE:
> -		sched = &adev->vce.ring[0].sched;
> -		scheds = &sched;
> -		num_scheds = 1;
> -		break;
> -	case AMDGPU_HW_IP_UVD_ENC:
> -		sched = &adev->uvd.inst[0].ring_enc[0].sched;
> -		scheds = &sched;
> -		num_scheds = 1;
> -		break;
> -	case AMDGPU_HW_IP_VCN_DEC:
> -		sched = drm_sched_pick_best(adev->vcn.vcn_dec_sched,
> -					    adev->vcn.num_vcn_dec_sched);
> -		scheds = &sched;
> -		num_scheds = 1;
> -		break;
> -	case AMDGPU_HW_IP_VCN_ENC:
> -		sched = drm_sched_pick_best(adev->vcn.vcn_enc_sched,
> -					    adev->vcn.num_vcn_enc_sched);
> +	hw_prio = amdgpu_ctx_sched_prio_to_hw_prio(priority, hw_ip);
> +	/* set to default prio if sched_list is NULL */
> +	if (!adev->ctx_scheds[hw_ip][hw_prio][0]) {
> +		hw_prio = AMDGPU_RING_PRIO_DEFAULT;
> +	}

This shouldn't have a {} as long as it is only a single line.

And since we have the same functionality below as well it might be a 
good idea to have a function for this.



> +
> +	scheds = adev->ctx_scheds[hw_ip][hw_prio];
> +	num_scheds = adev->ctx_num_scheds[hw_ip][hw_prio];
> +
> +	if (hw_ip == AMDGPU_HW_IP_VCN_ENC || hw_ip == AMDGPU_HW_IP_VCN_DEC) {
> +		sched = drm_sched_pick_best(scheds, num_scheds);
>   		scheds = &sched;
>   		num_scheds = 1;
> -		break;
> -	case AMDGPU_HW_IP_VCN_JPEG:
> -		scheds = adev->jpeg.jpeg_sched;
> -		num_scheds =  adev->jpeg.num_jpeg_sched;
> -		break;
>   	}
>   
>   	r = drm_sched_entity_init(&entity->entity, priority, scheds, num_scheds,
> @@ -178,7 +154,6 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
>   	ctx->override_priority = DRM_SCHED_PRIORITY_UNSET;
>   
>   	return 0;
> -
>   }
>   
>   static void amdgpu_ctx_fini_entity(struct amdgpu_ctx_entity *entity)
> @@ -535,8 +510,12 @@ static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
>   	/* set hw priority */
>   	if (hw_ip == AMDGPU_HW_IP_COMPUTE) {
>   		hw_prio = amdgpu_ctx_sched_prio_to_compute_prio(priority);
> -		scheds = adev->gfx.compute_prio_sched[hw_prio];
> -		num_scheds = adev->gfx.num_compute_sched[hw_prio];
> +		/* set to default prio if sched_list is NULL */
> +		if (!adev->ctx_scheds[hw_ip][hw_prio][0]) {
> +			hw_prio = AMDGPU_RING_PRIO_DEFAULT;
> +		}
> +		scheds = adev->ctx_scheds[hw_ip][hw_prio];
> +		num_scheds = adev->ctx_num_scheds[hw_ip][hw_prio];
>   		drm_sched_entity_modify_sched(&aentity->entity, scheds,
>   					      num_scheds);
>   	}
> @@ -665,78 +644,3 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
>   	idr_destroy(&mgr->ctx_handles);
>   	mutex_destroy(&mgr->lock);
>   }
> -
> -
> -static void amdgpu_ctx_init_compute_sched(struct amdgpu_device *adev)
> -{
> -	int num_compute_sched_normal = 0;
> -	int num_compute_sched_high = AMDGPU_MAX_COMPUTE_RINGS - 1;
> -	int i;
> -
> -	/* use one drm sched array, gfx.compute_sched to store both high and
> -	 * normal priority drm compute schedulers */
> -	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -		if (!adev->gfx.compute_ring[i].has_high_prio)
> -			adev->gfx.compute_sched[num_compute_sched_normal++] =
> -				&adev->gfx.compute_ring[i].sched;
> -		else
> -			adev->gfx.compute_sched[num_compute_sched_high--] =
> -				&adev->gfx.compute_ring[i].sched;
> -	}
> -
> -	/* compute ring only has two priority for now */
> -	i = AMDGPU_GFX_PIPE_PRIO_NORMAL;
> -	adev->gfx.compute_prio_sched[i] = &adev->gfx.compute_sched[0];
> -	adev->gfx.num_compute_sched[i] = num_compute_sched_normal;
> -
> -	i = AMDGPU_GFX_PIPE_PRIO_HIGH;
> -	if (num_compute_sched_high == (AMDGPU_MAX_COMPUTE_RINGS - 1)) {
> -		/* When compute has no high priority rings then use */
> -		/* normal priority sched array */
> -		adev->gfx.compute_prio_sched[i] = &adev->gfx.compute_sched[0];
> -		adev->gfx.num_compute_sched[i] = num_compute_sched_normal;
> -	} else {
> -		adev->gfx.compute_prio_sched[i] =
> -			&adev->gfx.compute_sched[num_compute_sched_high - 1];
> -		adev->gfx.num_compute_sched[i] =
> -			adev->gfx.num_compute_rings - num_compute_sched_normal;
> -	}
> -}
> -
> -void amdgpu_ctx_init_sched(struct amdgpu_device *adev)
> -{
> -	int i, j;
> -
> -	amdgpu_ctx_init_compute_sched(adev);
> -	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> -		adev->gfx.gfx_sched[i] = &adev->gfx.gfx_ring[i].sched;
> -		adev->gfx.num_gfx_sched++;
> -	}
> -
> -	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		adev->sdma.sdma_sched[i] = &adev->sdma.instance[i].ring.sched;
> -		adev->sdma.num_sdma_sched++;
> -	}
> -
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> -		adev->vcn.vcn_dec_sched[adev->vcn.num_vcn_dec_sched++] =
> -			&adev->vcn.inst[i].ring_dec.sched;
> -	}
> -
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> -		for (j = 0; j < adev->vcn.num_enc_rings; ++j)
> -			adev->vcn.vcn_enc_sched[adev->vcn.num_vcn_enc_sched++] =
> -				&adev->vcn.inst[i].ring_enc[j].sched;
> -	}
> -
> -	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> -		if (adev->jpeg.harvest_config & (1 << i))
> -			continue;
> -		adev->jpeg.jpeg_sched[adev->jpeg.num_jpeg_sched++] =
> -			&adev->jpeg.inst[i].ring_dec.sched;
> -	}
> -}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index de490f183af2..f54e10314661 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -88,7 +88,4 @@ void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr);
>   long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout);
>   void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);
>   
> -void amdgpu_ctx_init_sched(struct amdgpu_device *adev);
> -
> -
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e55dbcd18b95..85bc1875be37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3188,8 +3188,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   			adev->gfx.config.max_cu_per_sh,
>   			adev->gfx.cu_info.number);
>   
> -	amdgpu_ctx_init_sched(adev);
> -
>   	adev->accel_working = true;
>   
>   	amdgpu_vm_check_compute_bug(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 6b9c9193cdfa..92f2e59056c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -320,7 +320,8 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
>   	ring->eop_gpu_addr = kiq->eop_gpu_addr;
>   	sprintf(ring->name, "kiq_%d.%d.%d", ring->me, ring->pipe, ring->queue);
>   	r = amdgpu_ring_init(adev, ring, 1024,
> -			     irq, AMDGPU_CP_KIQ_IRQ_DRIVER0);
> +			     irq, AMDGPU_CP_KIQ_IRQ_DRIVER0,
> +			     AMDGPU_RING_PRIO_DEFAULT);
>   	if (r)
>   		dev_warn(adev->dev, "(%d) failed to init kiq ring\n", r);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 5825692d07e4..634746829024 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -286,13 +286,8 @@ struct amdgpu_gfx {
>   	bool				me_fw_write_wait;
>   	bool				cp_fw_write_wait;
>   	struct amdgpu_ring		gfx_ring[AMDGPU_MAX_GFX_RINGS];
> -	struct drm_gpu_scheduler	*gfx_sched[AMDGPU_MAX_GFX_RINGS];
> -	uint32_t			num_gfx_sched;
>   	unsigned			num_gfx_rings;
>   	struct amdgpu_ring		compute_ring[AMDGPU_MAX_COMPUTE_RINGS];
> -	struct drm_gpu_scheduler        **compute_prio_sched[AMDGPU_GFX_PIPE_PRIO_MAX];
> -	struct drm_gpu_scheduler	*compute_sched[AMDGPU_MAX_COMPUTE_RINGS];
> -	uint32_t                        num_compute_sched[AMDGPU_GFX_PIPE_PRIO_MAX];
>   	unsigned			num_compute_rings;
>   	struct amdgpu_irq_src		eop_irq;
>   	struct amdgpu_irq_src		priv_reg_irq;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> index bd9ef9cc86de..5131a0a1bc8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> @@ -43,8 +43,6 @@ struct amdgpu_jpeg {
>   	uint8_t	num_jpeg_inst;
>   	struct amdgpu_jpeg_inst inst[AMDGPU_MAX_JPEG_INSTANCES];
>   	struct amdgpu_jpeg_reg internal;
> -	struct drm_gpu_scheduler *jpeg_sched[AMDGPU_MAX_JPEG_INSTANCES];
> -	uint32_t num_jpeg_sched;
>   	unsigned harvest_config;
>   	struct delayed_work idle_work;
>   	enum amd_powergating_state cur_state;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index a7e1d0425ed0..e2d4478b28b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -162,11 +162,12 @@ void amdgpu_ring_undo(struct amdgpu_ring *ring)
>    * Returns 0 on success, error on failure.
>    */
>   int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
> -		     unsigned max_dw, struct amdgpu_irq_src *irq_src,
> -		     unsigned irq_type)
> +		     unsigned int max_dw, struct amdgpu_irq_src *irq_src,
> +		     unsigned int irq_type, unsigned int hw_prio)
>   {
>   	int r, i;
>   	int sched_hw_submission = amdgpu_sched_hw_submission;
> +	int *num_sched;
>   
>   	/* Set the hw submission limit higher for KIQ because
>   	 * it's used for a number of gfx/compute tasks by both
> @@ -258,6 +259,12 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>   	ring->priority = DRM_SCHED_PRIORITY_NORMAL;
>   	mutex_init(&ring->priority_mutex);
>   
> +	if (ring->funcs->type != AMDGPU_RING_TYPE_KIQ) {
> +		num_sched = &adev->ctx_num_scheds[ring->funcs->type][hw_prio];
> +		adev->ctx_scheds[ring->funcs->type][hw_prio][(*num_sched)++] =
> +			&ring->sched;
> +	}
> +
>   	for (i = 0; i < DRM_SCHED_PRIORITY_MAX; ++i)
>   		atomic_set(&ring->num_jobs[i], 0);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 448c76cbf3ed..b45cc204a906 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -35,6 +35,9 @@
>   #define AMDGPU_MAX_VCE_RINGS		3
>   #define AMDGPU_MAX_UVD_ENC_RINGS	2
>   
> +#define AMDGPU_RING_PRIO_DEFAULT	1
> +#define AMDGPU_RING_PRIO_MAX		AMDGPU_GFX_PIPE_PRIO_MAX
> +
>   /* some special values for the owner field */
>   #define AMDGPU_FENCE_OWNER_UNDEFINED	((void *)0ul)
>   #define AMDGPU_FENCE_OWNER_VM		((void *)1ul)
> @@ -47,16 +50,16 @@
>   #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring, sched)
>   
>   enum amdgpu_ring_type {
> -	AMDGPU_RING_TYPE_GFX,
> -	AMDGPU_RING_TYPE_COMPUTE,
> -	AMDGPU_RING_TYPE_SDMA,
> -	AMDGPU_RING_TYPE_UVD,
> -	AMDGPU_RING_TYPE_VCE,
> -	AMDGPU_RING_TYPE_KIQ,
> -	AMDGPU_RING_TYPE_UVD_ENC,
> -	AMDGPU_RING_TYPE_VCN_DEC,
> -	AMDGPU_RING_TYPE_VCN_ENC,
> -	AMDGPU_RING_TYPE_VCN_JPEG
> +	AMDGPU_RING_TYPE_GFX      = AMDGPU_HW_IP_GFX,
> +	AMDGPU_RING_TYPE_COMPUTE  = AMDGPU_HW_IP_COMPUTE,
> +	AMDGPU_RING_TYPE_SDMA     = AMDGPU_HW_IP_DMA,
> +	AMDGPU_RING_TYPE_UVD      = AMDGPU_HW_IP_UVD,
> +	AMDGPU_RING_TYPE_VCE      = AMDGPU_HW_IP_VCE,
> +	AMDGPU_RING_TYPE_UVD_ENC  = AMDGPU_HW_IP_UVD_ENC,
> +	AMDGPU_RING_TYPE_VCN_DEC  = AMDGPU_HW_IP_VCN_DEC,
> +	AMDGPU_RING_TYPE_VCN_ENC  = AMDGPU_HW_IP_VCN_ENC,
> +	AMDGPU_RING_TYPE_VCN_JPEG = AMDGPU_HW_IP_VCN_JPEG,

I'm not sure if this will work correctly. At least initially we 
intentionally had that a separate enums.

Christian.

> +	AMDGPU_RING_TYPE_KIQ
>   };
>   
>   struct amdgpu_device;
> @@ -220,7 +223,6 @@ struct amdgpu_ring {
>   	struct mutex		priority_mutex;
>   	/* protected by priority_mutex */
>   	int			priority;
> -	bool			has_high_prio;
>   
>   #if defined(CONFIG_DEBUG_FS)
>   	struct dentry *ent;
> @@ -258,8 +260,8 @@ void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
>   void amdgpu_ring_commit(struct amdgpu_ring *ring);
>   void amdgpu_ring_undo(struct amdgpu_ring *ring);
>   int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
> -		     unsigned ring_size, struct amdgpu_irq_src *irq_src,
> -		     unsigned irq_type);
> +		     unsigned int ring_size, struct amdgpu_irq_src *irq_src,
> +		     unsigned int irq_type, unsigned int prio);
>   void amdgpu_ring_fini(struct amdgpu_ring *ring);
>   void amdgpu_ring_emit_reg_write_reg_wait_helper(struct amdgpu_ring *ring,
>   						uint32_t reg0, uint32_t val0,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 2f4412e030a4..e5b8fb8e75c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -61,8 +61,6 @@ struct amdgpu_sdma_ras_funcs {
>   
>   struct amdgpu_sdma {
>   	struct amdgpu_sdma_instance instance[AMDGPU_MAX_SDMA_INSTANCES];
> -	struct drm_gpu_scheduler    *sdma_sched[AMDGPU_MAX_SDMA_INSTANCES];
> -	uint32_t		    num_sdma_sched;
>   	struct amdgpu_irq_src	trap_irq;
>   	struct amdgpu_irq_src	illegal_inst_irq;
>   	struct amdgpu_irq_src	ecc_irq;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 6fe057329de2..2d0633d5515f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -196,10 +196,6 @@ struct amdgpu_vcn {
>   	uint8_t	num_vcn_inst;
>   	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
>   	struct amdgpu_vcn_reg	 internal;
> -	struct drm_gpu_scheduler *vcn_enc_sched[AMDGPU_MAX_VCN_ENC_RINGS];
> -	struct drm_gpu_scheduler *vcn_dec_sched[AMDGPU_MAX_VCN_INSTANCES];
> -	uint32_t		 num_vcn_enc_sched;
> -	uint32_t		 num_vcn_dec_sched;
>   
>   	unsigned	harvest_config;
>   	int (*pause_dpg_mode)(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> index 4274ccf765de..e9d3c18812bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> @@ -980,7 +980,8 @@ static int cik_sdma_sw_init(void *handle)
>   				     &adev->sdma.trap_irq,
>   				     (i == 0) ?
>   				     AMDGPU_SDMA_IRQ_INSTANCE0 :
> -				     AMDGPU_SDMA_IRQ_INSTANCE1);
> +				     AMDGPU_SDMA_IRQ_INSTANCE1,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 7f9ac1a14e6f..b43c13acc77d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -1298,7 +1298,7 @@ static int gfx_v10_0_gfx_ring_init(struct amdgpu_device *adev, int ring_id,
>   
>   	irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + ring->pipe;
>   	r = amdgpu_ring_init(adev, ring, 1024,
> -			     &adev->gfx.eop_irq, irq_type);
> +			     &adev->gfx.eop_irq, irq_type, AMDGPU_RING_PRIO_DEFAULT);
>   	if (r)
>   		return r;
>   	return 0;
> @@ -1309,7 +1309,8 @@ static int gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>   {
>   	int r;
>   	unsigned irq_type;
> -	struct amdgpu_ring *ring = &adev->gfx.compute_ring[ring_id];
> +	struct amdgpu_ring *ring;
> +	int hw_prio;
>   
>   	ring = &adev->gfx.compute_ring[ring_id];
>   
> @@ -1328,10 +1329,11 @@ static int gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>   	irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
>   		+ ((ring->me - 1) * adev->gfx.mec.num_pipe_per_mec)
>   		+ ring->pipe;
> -
> +	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue) ?
> +			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_GFX_PIPE_PRIO_NORMAL;
>   	/* type-2 packets are deprecated on MEC, use type-3 instead */
>   	r = amdgpu_ring_init(adev, ring, 1024,
> -			     &adev->gfx.eop_irq, irq_type);
> +			     &adev->gfx.eop_irq, irq_type, hw_prio);
>   	if (r)
>   		return r;
>   
> @@ -3268,11 +3270,8 @@ static void gfx_v10_0_compute_mqd_set_priority(struct amdgpu_ring *ring, struct
>   	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>   		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
>   			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
> -			ring->has_high_prio = true;
>   			mqd->cp_hqd_queue_priority =
>   				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
> -		} else {
> -			ring->has_high_prio = false;
>   		}
>   	}
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> index 31f44d05e606..652fe562bccb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -3114,7 +3114,8 @@ static int gfx_v6_0_sw_init(void *handle)
>   		ring->ring_obj = NULL;
>   		sprintf(ring->name, "gfx");
>   		r = amdgpu_ring_init(adev, ring, 1024,
> -				     &adev->gfx.eop_irq, AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP);
> +				     &adev->gfx.eop_irq, AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>   		if (r)
>   			return r;
>   	}
> @@ -3136,7 +3137,7 @@ static int gfx_v6_0_sw_init(void *handle)
>   		sprintf(ring->name, "comp_%d.%d.%d", ring->me, ring->pipe, ring->queue);
>   		irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP + ring->pipe;
>   		r = amdgpu_ring_init(adev, ring, 1024,
> -				     &adev->gfx.eop_irq, irq_type);
> +				     &adev->gfx.eop_irq, irq_type, AMDGPU_RING_PRIO_DEFAULT);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 733d398c61cc..9869ad6286b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -4439,7 +4439,7 @@ static int gfx_v7_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>   
>   	/* type-2 packets are deprecated on MEC, use type-3 instead */
>   	r = amdgpu_ring_init(adev, ring, 1024,
> -			&adev->gfx.eop_irq, irq_type);
> +			&adev->gfx.eop_irq, irq_type, AMDGPU_RING_PRIO_DEFAULT);
>   	if (r)
>   		return r;
>   
> @@ -4511,7 +4511,8 @@ static int gfx_v7_0_sw_init(void *handle)
>   		ring->ring_obj = NULL;
>   		sprintf(ring->name, "gfx");
>   		r = amdgpu_ring_init(adev, ring, 1024,
> -				     &adev->gfx.eop_irq, AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP);
> +				     &adev->gfx.eop_irq, AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index fc32586ef80b..9a6a9e64b4b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -1892,6 +1892,7 @@ static int gfx_v8_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>   	int r;
>   	unsigned irq_type;
>   	struct amdgpu_ring *ring = &adev->gfx.compute_ring[ring_id];
> +	int hw_prio;
>   
>   	ring = &adev->gfx.compute_ring[ring_id];
>   
> @@ -1911,9 +1912,11 @@ static int gfx_v8_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>   		+ ((ring->me - 1) * adev->gfx.mec.num_pipe_per_mec)
>   		+ ring->pipe;
>   
> +	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue) ?
> +			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_RING_PRIO_DEFAULT;
>   	/* type-2 packets are deprecated on MEC, use type-3 instead */
>   	r = amdgpu_ring_init(adev, ring, 1024,
> -			&adev->gfx.eop_irq, irq_type);
> +			&adev->gfx.eop_irq, irq_type, hw_prio);
>   	if (r)
>   		return r;
>   
> @@ -2017,7 +2020,8 @@ static int gfx_v8_0_sw_init(void *handle)
>   		}
>   
>   		r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq,
> -				     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP);
> +				     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>   		if (r)
>   			return r;
>   	}
> @@ -4437,11 +4441,8 @@ static void gfx_v8_0_mqd_set_priority(struct amdgpu_ring *ring, struct vi_mqd *m
>   	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>   		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
>   			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
> -			ring->has_high_prio = true;
>   			mqd->cp_hqd_queue_priority =
>   				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
> -		} else {
> -			ring->has_high_prio = false;
>   		}
>   	}
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index fb567cf5671b..6d5596199c09 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2193,6 +2193,7 @@ static int gfx_v9_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>   	int r;
>   	unsigned irq_type;
>   	struct amdgpu_ring *ring = &adev->gfx.compute_ring[ring_id];
> +	int hw_prio;
>   
>   	ring = &adev->gfx.compute_ring[ring_id];
>   
> @@ -2211,10 +2212,11 @@ static int gfx_v9_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>   	irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
>   		+ ((ring->me - 1) * adev->gfx.mec.num_pipe_per_mec)
>   		+ ring->pipe;
> -
> +	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue) ?
> +			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_GFX_PIPE_PRIO_NORMAL;
>   	/* type-2 packets are deprecated on MEC, use type-3 instead */
>   	r = amdgpu_ring_init(adev, ring, 1024,
> -			     &adev->gfx.eop_irq, irq_type);
> +			     &adev->gfx.eop_irq, irq_type, hw_prio);
>   	if (r)
>   		return r;
>   
> @@ -2308,7 +2310,9 @@ static int gfx_v9_0_sw_init(void *handle)
>   		ring->use_doorbell = true;
>   		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
>   		r = amdgpu_ring_init(adev, ring, 1024,
> -				     &adev->gfx.eop_irq, AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP);
> +				     &adev->gfx.eop_irq,
> +				     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>   		if (r)
>   			return r;
>   	}
> @@ -3381,11 +3385,8 @@ static void gfx_v9_0_mqd_set_priority(struct amdgpu_ring *ring, struct v9_mqd *m
>   	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>   		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
>   			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
> -			ring->has_high_prio = true;
>   			mqd->cp_hqd_queue_priority =
>   				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
> -		} else {
> -			ring->has_high_prio = false;
>   		}
>   	}
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> index 0debfd9f428c..0105519a856f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> @@ -480,7 +480,8 @@ int jpeg_v1_0_sw_init(void *handle)
>   
>   	ring = &adev->jpeg.inst->ring_dec;
>   	sprintf(ring->name, "jpeg_dec");
> -	r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0);
> +	r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
> +			     AMDGPU_RING_PRIO_DEFAULT);
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index 6173951db7b4..ff759beac775 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -106,7 +106,8 @@ static int jpeg_v2_0_sw_init(void *handle)
>   	ring->use_doorbell = true;
>   	ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1;
>   	sprintf(ring->name, "jpeg_dec");
> -	r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0);
> +	r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
> +			     AMDGPU_RING_PRIO_DEFAULT);
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index c04c2078a7c1..54f66926f0d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -118,7 +118,8 @@ static int jpeg_v2_5_sw_init(void *handle)
>   		ring->use_doorbell = true;
>   		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + 8 * i;
>   		sprintf(ring->name, "jpeg_dec_%d", i);
> -		r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst[i].irq, 0);
> +		r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst[i].irq, 0,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>   		if (r)
>   			return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> index fd7fa6082563..3d498ce02f48 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -874,7 +874,8 @@ static int sdma_v2_4_sw_init(void *handle)
>   				     &adev->sdma.trap_irq,
>   				     (i == 0) ?
>   				     AMDGPU_SDMA_IRQ_INSTANCE0 :
> -				     AMDGPU_SDMA_IRQ_INSTANCE1);
> +				     AMDGPU_SDMA_IRQ_INSTANCE1,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> index 4a8a7f0f3a9c..40a011145c5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -1158,7 +1158,8 @@ static int sdma_v3_0_sw_init(void *handle)
>   				     &adev->sdma.trap_irq,
>   				     (i == 0) ?
>   				     AMDGPU_SDMA_IRQ_INSTANCE0 :
> -				     AMDGPU_SDMA_IRQ_INSTANCE1);
> +				     AMDGPU_SDMA_IRQ_INSTANCE1,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index fc664ec6b5fd..6a3d3f88d766 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -1848,7 +1848,8 @@ static int sdma_v4_0_sw_init(void *handle)
>   
>   		sprintf(ring->name, "sdma%d", i);
>   		r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
> -				     AMDGPU_SDMA_IRQ_INSTANCE0 + i);
> +				     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>   		if (r)
>   			return r;
>   
> @@ -1866,7 +1867,8 @@ static int sdma_v4_0_sw_init(void *handle)
>   			sprintf(ring->name, "page%d", i);
>   			r = amdgpu_ring_init(adev, ring, 1024,
>   					     &adev->sdma.trap_irq,
> -					     AMDGPU_SDMA_IRQ_INSTANCE0 + i);
> +					     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
> +					     AMDGPU_RING_PRIO_DEFAULT);
>   			if (r)
>   				return r;
>   		}
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 013e9c05bba5..346cde366600 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1236,7 +1236,8 @@ static int sdma_v5_0_sw_init(void *handle)
>   				     &adev->sdma.trap_irq,
>   				     (i == 0) ?
>   				     AMDGPU_SDMA_IRQ_INSTANCE0 :
> -				     AMDGPU_SDMA_IRQ_INSTANCE1);
> +				     AMDGPU_SDMA_IRQ_INSTANCE1,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> index 7f64d73043cf..90fb8c4ec13c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> @@ -504,7 +504,8 @@ static int si_dma_sw_init(void *handle)
>   				     &adev->sdma.trap_irq,
>   				     (i == 0) ?
>   				     AMDGPU_SDMA_IRQ_INSTANCE0 :
> -				     AMDGPU_SDMA_IRQ_INSTANCE1);
> +				     AMDGPU_SDMA_IRQ_INSTANCE1,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> index 82abd8e728ab..489062e020a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> @@ -118,7 +118,8 @@ static int uvd_v4_2_sw_init(void *handle)
>   
>   	ring = &adev->uvd.inst->ring;
>   	sprintf(ring->name, "uvd");
> -	r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst->irq, 0);
> +	r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst->irq, 0,
> +			     AMDGPU_RING_PRIO_DEFAULT);
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> index 0fa8aae2d78e..6385734eb902 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> @@ -116,7 +116,8 @@ static int uvd_v5_0_sw_init(void *handle)
>   
>   	ring = &adev->uvd.inst->ring;
>   	sprintf(ring->name, "uvd");
> -	r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst->irq, 0);
> +	r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst->irq, 0,
> +			     AMDGPU_RING_PRIO_DEFAULT);
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index e0aadcaf6c8b..df5c22b18f85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -416,7 +416,8 @@ static int uvd_v6_0_sw_init(void *handle)
>   
>   	ring = &adev->uvd.inst->ring;
>   	sprintf(ring->name, "uvd");
> -	r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst->irq, 0);
> +	r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst->irq, 0,
> +			     AMDGPU_RING_PRIO_DEFAULT);
>   	if (r)
>   		return r;
>   
> @@ -428,7 +429,9 @@ static int uvd_v6_0_sw_init(void *handle)
>   		for (i = 0; i < adev->uvd.num_enc_rings; ++i) {
>   			ring = &adev->uvd.inst->ring_enc[i];
>   			sprintf(ring->name, "uvd_enc%d", i);
> -			r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst->irq, 0);
> +			r = amdgpu_ring_init(adev, ring, 512,
> +					     &adev->uvd.inst->irq, 0,
> +					     AMDGPU_RING_PRIO_DEFAULT);
>   			if (r)
>   				return r;
>   		}
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> index 0995378d8263..52ab47edf891 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -450,7 +450,8 @@ static int uvd_v7_0_sw_init(void *handle)
>   		if (!amdgpu_sriov_vf(adev)) {
>   			ring = &adev->uvd.inst[j].ring;
>   			sprintf(ring->name, "uvd_%d", ring->me);
> -			r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst[j].irq, 0);
> +			r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst[j].irq, 0,
> +					     AMDGPU_RING_PRIO_DEFAULT);
>   			if (r)
>   				return r;
>   		}
> @@ -469,7 +470,8 @@ static int uvd_v7_0_sw_init(void *handle)
>   				else
>   					ring->doorbell_index = adev->doorbell_index.uvd_vce.uvd_ring2_3 * 2 + 1;
>   			}
> -			r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst[j].irq, 0);
> +			r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst[j].irq, 0,
> +					     AMDGPU_RING_PRIO_DEFAULT);
>   			if (r)
>   				return r;
>   		}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> index b6837fcfdba7..74c9f567bcd6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -434,7 +434,7 @@ static int vce_v2_0_sw_init(void *handle)
>   		ring = &adev->vce.ring[i];
>   		sprintf(ring->name, "vce%d", i);
>   		r = amdgpu_ring_init(adev, ring, 512,
> -				     &adev->vce.irq, 0);
> +				     &adev->vce.irq, 0, AMDGPU_RING_PRIO_DEFAULT);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index 217db187207c..6d9108fa22e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -442,7 +442,8 @@ static int vce_v3_0_sw_init(void *handle)
>   	for (i = 0; i < adev->vce.num_rings; i++) {
>   		ring = &adev->vce.ring[i];
>   		sprintf(ring->name, "vce%d", i);
> -		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0);
> +		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> index 3fd102efb7af..188d4d98c9b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> @@ -476,7 +476,8 @@ static int vce_v4_0_sw_init(void *handle)
>   			else
>   				ring->doorbell_index = adev->doorbell_index.uvd_vce.vce_ring2_3 * 2 + 1;
>   		}
> -		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0);
> +		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 09b0572b838d..ba54b5b9b9de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -127,7 +127,8 @@ static int vcn_v1_0_sw_init(void *handle)
>   
>   	ring = &adev->vcn.inst->ring_dec;
>   	sprintf(ring->name, "vcn_dec");
> -	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0);
> +	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
> +			     AMDGPU_RING_PRIO_DEFAULT);
>   	if (r)
>   		return r;
>   
> @@ -145,7 +146,8 @@ static int vcn_v1_0_sw_init(void *handle)
>   	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>   		ring = &adev->vcn.inst->ring_enc[i];
>   		sprintf(ring->name, "vcn_enc%d", i);
> -		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0);
> +		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index ec8091a661df..11d4d559328a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -133,7 +133,8 @@ static int vcn_v2_0_sw_init(void *handle)
>   	ring->doorbell_index = adev->doorbell_index.vcn.vcn_ring0_1 << 1;
>   
>   	sprintf(ring->name, "vcn_dec");
> -	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0);
> +	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
> +			     AMDGPU_RING_PRIO_DEFAULT);
>   	if (r)
>   		return r;
>   
> @@ -163,7 +164,8 @@ static int vcn_v2_0_sw_init(void *handle)
>   		else
>   			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + i;
>   		sprintf(ring->name, "vcn_enc%d", i);
> -		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0);
> +		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index c6363f5ad564..aeefee796cd1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -191,7 +191,8 @@ static int vcn_v2_5_sw_init(void *handle)
>   		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
>   				(amdgpu_sriov_vf(adev) ? 2*j : 8*j);
>   		sprintf(ring->name, "vcn_dec_%d", j);
> -		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[j].irq, 0);
> +		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[j].irq, 0,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>   		if (r)
>   			return r;
>   
> @@ -203,7 +204,8 @@ static int vcn_v2_5_sw_init(void *handle)
>   					(amdgpu_sriov_vf(adev) ? (1 + i + 2*j) : (2 + i + 8*j));
>   
>   			sprintf(ring->name, "vcn_enc_%d.%d", j, i);
> -			r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[j].irq, 0);
> +			r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[j].irq, 0,
> +					     AMDGPU_RING_PRIO_DEFAULT);
>   			if (r)
>   				return r;
>   		}

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
