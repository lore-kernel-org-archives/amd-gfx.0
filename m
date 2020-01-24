Return-Path: <SRS0=Oth2=3N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6298C2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 12:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B35EF20708
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 12:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZshFfXQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35EF20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A4D96E372;
	Fri, 24 Jan 2020 12:56:10 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FADD6E372
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2020 12:56:09 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id p17so1629963wmb.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2020 04:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=78TsXvdModqDVA1hvmyxNRN4IYqhFGsfn0Ydu4Hqj/k=;
 b=ZshFfXQ7wwlRuZfM4L5k6VIENgxwwfmPHK9tfZ4nFCIlZVfu2VKYuIy42e/Nxr/Rvi
 tdoyeNdcFptnFKeEuhVhrcD26jArGUpbUWC0f+Yzma5AE6Bw5U5SH7mNE+R1KSubtqMh
 kbm4/8RA/v1XK/OtqjW9iqUWllkn3GajJgypteaVIr0uk7CowrMf2xMaiEOdpexviLSt
 p+eb9D/90OycGDxvZ3AV0wqo0wJ6HoWpwQ9H/5C+mYl0G5blA/OalwzDOKs2fo/b8+Mv
 nf+9ir+3CMzP4xI86n9Pmvka2uEEz4vqyLftt51bW2wO35Z1NSWTpCjWXMi9/ZEYJRo7
 Mlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=78TsXvdModqDVA1hvmyxNRN4IYqhFGsfn0Ydu4Hqj/k=;
 b=QSQfBXr61p8EGxrpnC/CcrnIlVETf/Pvw1SKbvvdyxELJnGmWFAwGqeSQR9vzOHWFB
 ylaWDTjgT9ogRqtjt2+fnjgE6o4WFkdQBg4GVMlmzMSWkOGXgAYcHriXFPLaVwa2enfz
 U6RYgoLUgBehYWdePV9q0FMfrJIEcctascisWsgUC7G6bXeNgY5WLMwcRj5mhL1cpoNL
 lEnmOCNT/kdrhN91TE0GcmA2zmy6Pn+DLdI5h9CDQP9Atbtfr1T2dglz32yeI7nZ6mPJ
 st0yP3XxlQkQK5UHelb9Jy+fjBm1k2t7nA6u3PYk7ghRbqqteqd8l0cun6u9lSy8OBD8
 vvAQ==
X-Gm-Message-State: APjAAAUaiTWaDeVSrsOd8zp3lszvDHJWJb/q02BKJtbzY4m9fwOnhtlH
 yTay7sEPEHXlsr4P3SCUyQI=
X-Google-Smtp-Source: APXvYqzutqPXEJeiKuNTZuZAx5jszu0Sk3yd6sb/Y+4/JnK+oXz/59Bw1obwS7DeA5MW9Cg7cGfYbQ==
X-Received: by 2002:a1c:1f56:: with SMTP id f83mr3225907wmf.93.1579870567695; 
 Fri, 24 Jan 2020 04:56:07 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id f207sm8037640wme.9.2020.01.24.04.56.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 24 Jan 2020 04:56:07 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: allocate entities on demand
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200124115311.8037-1-nirmoy.das@amd.com>
 <20200124124149.4420-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2051b4e3-0ae0-999a-6161-284c9c5862b0@gmail.com>
Date: Fri, 24 Jan 2020 13:56:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200124124149.4420-1-nirmoy.das@amd.com>
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 24.01.20 um 13:41 schrieb Nirmoy Das:
> Currently we pre-allocate entities and fences for all the HW IPs on
> context creation and some of which are might never be used.
>
> This patch tries to resolve entity/fences wastage by creating entity
> only when needed.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 232 +++++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |   3 +-
>   2 files changed, 124 insertions(+), 111 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 05c2af61e7de..df7a18f12b8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -42,19 +42,12 @@ const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM] = {
>   	[AMDGPU_HW_IP_VCN_JPEG]	=	1,
>   };
>   
> -static int amdgpu_ctx_total_num_entities(void)
> -{
> -	unsigned i, num_entities = 0;
> -
> -	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
> -		num_entities += amdgpu_ctx_num_entities[i];
> -
> -	return num_entities;
> -}
> -
>   static int amdgpu_ctx_priority_permit(struct drm_file *filp,
>   				      enum drm_sched_priority priority)
>   {
> +	if (priority < 0 || priority >= DRM_SCHED_PRIORITY_MAX)
> +		return -EINVAL;
> +
>   	/* NORMAL and below are accessible by everyone */
>   	if (priority <= DRM_SCHED_PRIORITY_NORMAL)
>   		return 0;
> @@ -68,64 +61,35 @@ static int amdgpu_ctx_priority_permit(struct drm_file *filp,
>   	return -EACCES;
>   }
>   
> -static int amdgpu_ctx_init(struct amdgpu_device *adev,
> -			   enum drm_sched_priority priority,
> -			   struct drm_file *filp,
> -			   struct amdgpu_ctx *ctx)
> +static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, const u32 hw_ip, const u32 ring)
>   {
> -	unsigned num_entities = amdgpu_ctx_total_num_entities();
> -	unsigned i, j;
> +	struct amdgpu_device *adev = ctx->adev;
> +	struct amdgpu_ctx_entity *entity;
> +	struct drm_gpu_scheduler **scheds;
> +	struct drm_gpu_scheduler *sched;
> +	unsigned num_scheds = 0;
> +	enum drm_sched_priority priority;
>   	int r;
>   
> -	if (priority < 0 || priority >= DRM_SCHED_PRIORITY_MAX)
> -		return -EINVAL;
> -
> -	r = amdgpu_ctx_priority_permit(filp, priority);
> -	if (r)
> -		return r;
>   
> -	memset(ctx, 0, sizeof(*ctx));
> -	ctx->adev = adev;
> +	ctx->entities[hw_ip][ring] = kcalloc(1, sizeof(struct amdgpu_ctx_entity),
> +					     GFP_KERNEL);
> +	if (!ctx->entities[hw_ip][ring])
> +		return  -ENOMEM;
>   
> +	entity = ctx->entities[hw_ip][ring];
>   
> -	ctx->entities[0] = kcalloc(num_entities,
> -				   sizeof(struct amdgpu_ctx_entity),
> -				   GFP_KERNEL);
> -	if (!ctx->entities[0])
> -		return -ENOMEM;
> -
> -
> -	for (i = 0; i < num_entities; ++i) {
> -		struct amdgpu_ctx_entity *entity = &ctx->entities[0][i];
> -
> -		entity->sequence = 1;
> -		entity->fences = kcalloc(amdgpu_sched_jobs,
> -					 sizeof(struct dma_fence*), GFP_KERNEL);
> -		if (!entity->fences) {
> -			r = -ENOMEM;
> -			goto error_cleanup_memory;
> -		}
> +	entity->sequence = 1;
> +	entity->fences = kcalloc(amdgpu_sched_jobs,
> +				 sizeof(struct dma_fence*), GFP_KERNEL);

It would be rather nice to have to allocate the fences array together 
with the entity.

Take a look at struct dma_resv_list and the function 
dma_resv_list_alloc() on how to do this.

Apart from that the patch now looks like a nice cleanup to me, but I 
need to fully read it from top till bottom once more.

Regards,
Christian.

> +	if (!entity->fences) {
> +		r = -ENOMEM;
> +		goto error_free_entity;
>   	}
> -	for (i = 1; i < AMDGPU_HW_IP_NUM; ++i)
> -		ctx->entities[i] = ctx->entities[i - 1] +
> -			amdgpu_ctx_num_entities[i - 1];
> -
> -	kref_init(&ctx->refcount);
> -	spin_lock_init(&ctx->ring_lock);
> -	mutex_init(&ctx->lock);
>   
> -	ctx->reset_counter = atomic_read(&adev->gpu_reset_counter);
> -	ctx->reset_counter_query = ctx->reset_counter;
> -	ctx->vram_lost_counter = atomic_read(&adev->vram_lost_counter);
> -	ctx->init_priority = priority;
> -	ctx->override_priority = DRM_SCHED_PRIORITY_UNSET;
> -
> -	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> -		struct drm_gpu_scheduler **scheds;
> -		struct drm_gpu_scheduler *sched;
> -		unsigned num_scheds = 0;
> -
> -		switch (i) {
> +	priority = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
> +				ctx->init_priority : ctx->override_priority;
> +	switch (hw_ip) {
>   		case AMDGPU_HW_IP_GFX:
>   			sched = &adev->gfx.gfx_ring[0].sched;
>   			scheds = &sched;
> @@ -166,57 +130,82 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
>   			scheds = adev->jpeg.jpeg_sched;
>   			num_scheds =  adev->jpeg.num_jpeg_sched;
>   			break;
> -		}
> -
> -		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j)
> -			r = drm_sched_entity_init(&ctx->entities[i][j].entity,
> -						  priority, scheds,
> -						  num_scheds, &ctx->guilty);
> -		if (r)
> -			goto error_cleanup_entities;
>   	}
>   
> +	r = drm_sched_entity_init(&ctx->entities[hw_ip][ring]->entity,
> +				  priority, scheds,
> +				  num_scheds, &ctx->guilty);
> +	if (r)
> +		goto error_free_entity;
> +
>   	return 0;
>   
> -error_cleanup_entities:
> -	for (i = 0; i < num_entities; ++i)
> -		drm_sched_entity_destroy(&ctx->entities[0][i].entity);
> +error_free_entity:
> +	kfree(ctx->entities[hw_ip][ring]);
> +	return r;
> +}
> +
> +static int amdgpu_ctx_init(struct amdgpu_device *adev,
> +			   enum drm_sched_priority priority,
> +			   struct drm_file *filp,
> +			   struct amdgpu_ctx *ctx)
> +{
> +	int r;
>   
> -error_cleanup_memory:
> -	for (i = 0; i < num_entities; ++i) {
> -		struct amdgpu_ctx_entity *entity = &ctx->entities[0][i];
> +	r = amdgpu_ctx_priority_permit(filp, priority);
> +	if (r)
> +		return r;
>   
> -		kfree(entity->fences);
> -		entity->fences = NULL;
> -	}
> +	memset(ctx, 0, sizeof(*ctx));
> +
> +	ctx->adev = adev;
> +
> +	kref_init(&ctx->refcount);
> +	spin_lock_init(&ctx->ring_lock);
> +	mutex_init(&ctx->lock);
> +
> +	ctx->reset_counter = atomic_read(&adev->gpu_reset_counter);
> +	ctx->reset_counter_query = ctx->reset_counter;
> +	ctx->vram_lost_counter = atomic_read(&adev->vram_lost_counter);
> +	ctx->init_priority = priority;
> +	ctx->override_priority = DRM_SCHED_PRIORITY_UNSET;
> +
> +	return 0;
>   
> -	kfree(ctx->entities[0]);
> -	ctx->entities[0] = NULL;
> -	return r;
>   }
>   
>   static void amdgpu_ctx_fini(struct kref *ref)
>   {
>   	struct amdgpu_ctx *ctx = container_of(ref, struct amdgpu_ctx, refcount);
> -	unsigned num_entities = amdgpu_ctx_total_num_entities();
>   	struct amdgpu_device *adev = ctx->adev;
> -	unsigned i, j;
> +	unsigned i, j, k;
>   
>   	if (!adev)
>   		return;
>   
> -	for (i = 0; i < num_entities; ++i) {
> -		struct amdgpu_ctx_entity *entity = &ctx->entities[0][i];
> +	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> +		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> +			struct amdgpu_ctx_entity *entity;
> +
> +			if (!ctx->entities[i] || !ctx->entities[i][j])
> +				continue;
> +
> +			entity = ctx->entities[i][j];
> +			if (!entity->fences)
> +				continue;
>   
> -		for (j = 0; j < amdgpu_sched_jobs; ++j)
> -			dma_fence_put(entity->fences[j]);
> +			for (k = 0; k < amdgpu_sched_jobs; ++k)
> +				dma_fence_put(entity->fences[k]);
>   
> -		kfree(entity->fences);
> +			kfree(entity->fences);
> +			entity->fences = NULL;
> +
> +			kfree(entity);
> +			ctx->entities[i][j] = NULL;
> +		}
>   	}
>   
> -	kfree(ctx->entities[0]);
>   	mutex_destroy(&ctx->lock);
> -
>   	kfree(ctx);
>   }
>   
> @@ -239,7 +228,11 @@ int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
>   		return -EINVAL;
>   	}
>   
> -	*entity = &ctx->entities[hw_ip][ring].entity;
> +	if (!ctx->entities[hw_ip][ring])
> +		amdgpu_ctx_init_entity(ctx, hw_ip, ring);
> +
> +
> +	*entity = &ctx->entities[hw_ip][ring]->entity;
>   	return 0;
>   }
>   
> @@ -279,14 +272,17 @@ static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
>   static void amdgpu_ctx_do_release(struct kref *ref)
>   {
>   	struct amdgpu_ctx *ctx;
> -	unsigned num_entities;
> -	u32 i;
> +	u32 i, j;
>   
>   	ctx = container_of(ref, struct amdgpu_ctx, refcount);
> +	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> +		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> +			if (!ctx->entities[i][j])
> +				continue;
>   
> -	num_entities = amdgpu_ctx_total_num_entities();
> -	for (i = 0; i < num_entities; i++)
> -		drm_sched_entity_destroy(&ctx->entities[0][i].entity);
> +			drm_sched_entity_destroy(&ctx->entities[i][j]->entity);
> +		}
> +	}
>   
>   	amdgpu_ctx_fini(ref);
>   }
> @@ -516,19 +512,23 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
>   void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
>   				  enum drm_sched_priority priority)
>   {
> -	unsigned num_entities = amdgpu_ctx_total_num_entities();
>   	enum drm_sched_priority ctx_prio;
> -	unsigned i;
> +	unsigned i, j;
>   
>   	ctx->override_priority = priority;
>   
>   	ctx_prio = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
>   			ctx->init_priority : ctx->override_priority;
> +	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> +		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> +			struct drm_sched_entity *entity;
>   
> -	for (i = 0; i < num_entities; i++) {
> -		struct drm_sched_entity *entity = &ctx->entities[0][i].entity;
> +			if (!ctx->entities[i][j])
> +				continue;
>   
> -		drm_sched_entity_set_priority(entity, ctx_prio);
> +			entity = &ctx->entities[i][j]->entity;
> +			drm_sched_entity_set_priority(entity, ctx_prio);
> +		}
>   	}
>   }
>   
> @@ -564,20 +564,24 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr)
>   
>   long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
>   {
> -	unsigned num_entities = amdgpu_ctx_total_num_entities();
>   	struct amdgpu_ctx *ctx;
>   	struct idr *idp;
> -	uint32_t id, i;
> +	uint32_t id, i, j;
>   
>   	idp = &mgr->ctx_handles;
>   
>   	mutex_lock(&mgr->lock);
>   	idr_for_each_entry(idp, ctx, id) {
> -		for (i = 0; i < num_entities; i++) {
> -			struct drm_sched_entity *entity;
> +		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> +			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> +				struct drm_sched_entity *entity;
> +
> +				if (!ctx->entities[i][j])
> +					continue;
>   
> -			entity = &ctx->entities[0][i].entity;
> -			timeout = drm_sched_entity_flush(entity, timeout);
> +				entity = &ctx->entities[i][j]->entity;
> +				timeout = drm_sched_entity_flush(entity, timeout);
> +			}
>   		}
>   	}
>   	mutex_unlock(&mgr->lock);
> @@ -586,10 +590,9 @@ long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
>   
>   void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>   {
> -	unsigned num_entities = amdgpu_ctx_total_num_entities();
>   	struct amdgpu_ctx *ctx;
>   	struct idr *idp;
> -	uint32_t id, i;
> +	uint32_t id, i, j;
>   
>   	idp = &mgr->ctx_handles;
>   
> @@ -599,8 +602,17 @@ void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>   			continue;
>   		}
>   
> -		for (i = 0; i < num_entities; i++)
> -			drm_sched_entity_fini(&ctx->entities[0][i].entity);
> +		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> +			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> +				struct drm_sched_entity *entity;
> +
> +				if (!ctx->entities[i][j])
> +					continue;
> +
> +				entity = &ctx->entities[i][j]->entity;
> +				drm_sched_entity_fini(entity);
> +			}
> +		}
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index a6cd9d4b078c..e67e522e1922 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -29,6 +29,7 @@ struct drm_device;
>   struct drm_file;
>   struct amdgpu_fpriv;
>   
> +#define AMDGPU_MAX_ENTITY_NUM 4
>   struct amdgpu_ctx_entity {
>   	uint64_t		sequence;
>   	struct dma_fence	**fences;
> @@ -42,7 +43,7 @@ struct amdgpu_ctx {
>   	unsigned			reset_counter_query;
>   	uint32_t			vram_lost_counter;
>   	spinlock_t			ring_lock;
> -	struct amdgpu_ctx_entity	*entities[AMDGPU_HW_IP_NUM];
> +	struct amdgpu_ctx_entity	*entities[AMDGPU_HW_IP_NUM][AMDGPU_MAX_ENTITY_NUM];
>   	bool				preamble_presented;
>   	enum drm_sched_priority		init_priority;
>   	enum drm_sched_priority		override_priority;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
