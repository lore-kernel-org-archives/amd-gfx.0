Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABC7C0044D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 18:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEFD520691
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 18:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lbh92w2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFD520691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD6256E9D1;
	Wed, 11 Mar 2020 18:03:05 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21CA16E9D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 18:03:04 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id 6so3108969wmi.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 11:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=bN+qHDpMpiyJr1Uu6LG4Bjg6jjGdEMfRmzjACOEH7WM=;
 b=Lbh92w2RQ3nU5NeahfuVW3GST2siEOJXr7/p+bR8hDPwv533wagb4xjAhOGc7BVw9R
 07ioXTohfigQVsFQ78ft16juIIBrjf5DRUSRS58LfGrr/Uiv1nzdvXLis2byUAwsNEQE
 HW7WGQuRw/WegUizWc0tYRd5W4CpDJYDldrKUBEsohouVnn46eWXRVNSmAzvNfXZyn5M
 UR2eaa/PN0jQvKOiNGvxIqOV3/HVk5G8pGN7Ef6fjha6Ti8UskWPnWyf8r0a7+bMk0MF
 lKVYQ+0dZdOSNeXdiTtZhl5P/QiFXRtWf0DgCp3uHVUOHVQjET9OL2L03xt5uc5QRftO
 5ong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=bN+qHDpMpiyJr1Uu6LG4Bjg6jjGdEMfRmzjACOEH7WM=;
 b=JgFjcoBJ+K5lzOTL0EdEax5ZbY8XI0BAHVc1sAPyXwR+VkRbPyfzO5f7wWjKwdLNU8
 3U5AL+tcdn3MdRiDCN7IxWws112WdttlUbSeGrXzv0iWczL8Xr6xLPz1XcG0BU1F9hvS
 1nwmUp9H6dJbPTHfRu6cFmXBldaWk5Szwqna4UMlqlWON1rvDamMgglwQd5vGQIR4ydh
 ucgoH0nXpKUIuHsnP3fxw1syMo0zvt2R0vuuH6W2t1a3mkr7JhAIn8TgtyRqv+TwYZL9
 0J9XqkayVoVFk3pijSt4d4z/izb7Au8K4lXj9knoJg0mfVzK90QpnDlMk5th/v//g6b7
 Juog==
X-Gm-Message-State: ANhLgQ04I6Tr2PEygMUvs4sNJTSAsJSva6VD2XZcUgQ0czY0tJUSJKPX
 4bJyRaN/Pm0o9L3aMKCDpEdhD0uv
X-Google-Smtp-Source: ADFU+vt9Bmm3wEb9xnxSOw1DyFC8ocnuCLCqmI1fFOolQEGVG7qDuz9bKN+f81RzIZbNVWJnuSSAow==
X-Received: by 2002:a7b:c08a:: with SMTP id r10mr4738809wmh.130.1583949782732; 
 Wed, 11 Mar 2020 11:03:02 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id a26sm9380783wmm.18.2020.03.11.11.03.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Mar 2020 11:03:02 -0700 (PDT)
Subject: Re: [RFC PATCH 2/2] drm/amdgpu: disable gpu load balancer for vcn jobs
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200311171809.7115-1-nirmoy.das@amd.com>
 <20200311171809.7115-2-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <09a20385-ef17-f2df-bd0b-ca60bb82cbcc@gmail.com>
Date: Wed, 11 Mar 2020 19:03:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200311171809.7115-2-nirmoy.das@amd.com>
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
Cc: Boyuan.Zhang@amd.com, nirmoy.das@amd.com, alexander.deucher@amd.com,
 James.Zhu@amd.com, Leo.Liu@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 11.03.20 um 18:18 schrieb Nirmoy Das:
> VCN HW  doesn't support dynamic load balance on multiple
> instances for a context. This modifies the entity's sched_list
> to a sched_list consist of only one drm scheduler.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 25 +++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c |  1 +
>   4 files changed, 29 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 8304d0c87899..00032093d8a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1257,6 +1257,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   	priority = job->base.s_priority;
>   	drm_sched_entity_push_job(&job->base, entity);
>   
> +	amdgpu_ctx_limit_load_balance(entity);
>   	amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
>   
>   	ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index fa575bdc03c8..57b49188306d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -139,6 +139,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, const u32 hw_ip, const
>   	if (r)
>   		goto error_free_entity;
>   
> +	entity->hw_ip = hw_ip;
>   	ctx->entities[hw_ip][ring] = entity;
>   	return 0;
>   
> @@ -559,6 +560,30 @@ void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
>   	}
>   }
>   
> +static void limit_vcn_load_balance(struct amdgpu_ctx_entity *centity)
> +{
> +	struct drm_gpu_scheduler **scheds = &centity->entity.rq->sched;
> +
> +	if (drm_sched_entity_num_jobs(&centity->entity) == 1)

That check doesn't work correctly, the job might actually already be 
processed when we hit here.

> +		drm_sched_entity_modify_sched(&centity->entity, scheds, 1);

Just always update the scheduler here.

> +
> +}
> +
> +void amdgpu_ctx_limit_load_balance(struct drm_sched_entity *entity)
> +{
> +	struct amdgpu_ctx_entity *centity = to_amdgpu_ctx_entity(entity);
> +
> +	if (!centity)
> +		return;

That check looks superfluous to me.

> +
> +	switch (centity->hw_ip) {

Better get the ring from entity->rq->sched instead.

> +	case AMDGPU_HW_IP_VCN_DEC:
> +	case AMDGPU_HW_IP_VCN_ENC:

Maybe better to make that a flag in the ring functions, but this way 
works as well.

Regards,
Christian.

> +		limit_vcn_load_balance(centity);
> +	}
> +
> +}
> +
>   int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx,
>   			       struct drm_sched_entity *entity)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index de490f183af2..d52d8d562d77 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -33,6 +33,7 @@ struct amdgpu_fpriv;
>   
>   struct amdgpu_ctx_entity {
>   	uint64_t		sequence;
> +	uint32_t		hw_ip;
>   	struct drm_sched_entity	entity;
>   	struct dma_fence	*fences[];
>   };
> @@ -90,5 +91,6 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);
>   
>   void amdgpu_ctx_init_sched(struct amdgpu_device *adev);
>   
> +void amdgpu_ctx_limit_load_balance(struct drm_sched_entity *entity);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 4981e443a884..955d12bc89ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -154,6 +154,7 @@ int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
>   	amdgpu_job_free_resources(job);
>   	priority = job->base.s_priority;
>   	drm_sched_entity_push_job(&job->base, entity);
> +	amdgpu_ctx_limit_load_balance(entity);
>   
>   	return 0;
>   }

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
