Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BF2C33C9E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 16:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49276222C3
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 16:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b980/FxG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49276222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2010789B18;
	Tue, 14 Jan 2020 16:01:19 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 125B289B18
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 16:01:18 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id q6so12654792wro.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 08:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=s6pkhEzr79OzVRNpMqQHQ8XqyTVTetJleofitEIx4oY=;
 b=b980/FxGQAbJKpSokqtU8yDP/GFYVBjiI3l9d4jeV0ONwM+xeKrCwdM7dBbWLn+jIr
 n4hFTzfpKm1f+5H5uu/Cfc3QY5xza5b0qHq3GeaPhhDay3Ee8Ao/wMLa6P2MrnXRY96C
 yOxHN9Unr3ZEXbokFjyYkP9H6o938F6QQ4QEQW41AUjMKbT5KyDSNpe6stInt92TPT+y
 lBAfQdAUXavvPUfmkpTQF+3Lzg6Xo1KlPa2ql+s6hHNwGOcBLsJXblOWZRj7sTB1822K
 z0fj3FLhREHZg2iIRKZx8iSczuf8N//GrDN7UXYS3DBVOMelIqtAP4KaS7YQGy+QFtY3
 OxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=s6pkhEzr79OzVRNpMqQHQ8XqyTVTetJleofitEIx4oY=;
 b=RZOSPqBuCGHiy8X3cApBQAJJHZu+TUNTV48BzixHt5OARablTuMFeNrPw+zoRw9XvI
 P8t4yLF0194G8cyFo6AtURzHfMYL0Ll20MYDh0WH+jq9CgRGMo4cCe+eMokLFjp2s67x
 qs1y95HsxTsjjpJsdrbZQJvJuUMh2fMNKtz05AN31qJZUTebHDtdL61lzjFwKp0Q8hEN
 Sg1pTNWKig37xhYWnkt5IiVODDVNe+dEp4UdYocQxY5DmZlkyKgskWcHk2cX+fyTBKoI
 Td+MkVtKTlhC58CZyaQsW6SoaLpUoaRjtItiXpYYe0grPOSuT/sfm+8RamC3hB3FWF1M
 OMDw==
X-Gm-Message-State: APjAAAUFGeNLPKowBiGLdH81hUM/GXoebBo8lZgOjx23jgcmwHYq58iI
 eeQIHIF00Q1130TcUBZ5JMM=
X-Google-Smtp-Source: APXvYqxVbQabmRsDKiig1U+1VCDMeF9GsTy2dvqjnHj473ibw14jfgDIi8O+Rq4C/QrMTp+uV9+daQ==
X-Received: by 2002:adf:e984:: with SMTP id h4mr25373266wrm.275.1579017676694; 
 Tue, 14 Jan 2020 08:01:16 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id n67sm19893714wmf.46.2020.01.14.08.01.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Jan 2020 08:01:16 -0800 (PST)
Subject: Re: [PATCH] drm/scheduler: fix race condition in load balancer
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200114154339.3519-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <5deb3805-f7e8-3d0d-4259-a3be1c5d3cf5@gmail.com>
Date: Tue, 14 Jan 2020 17:01:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200114154339.3519-1-nirmoy.das@amd.com>
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
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.01.20 um 16:43 schrieb Nirmoy Das:
> Jobs submitted in an entity should execute in the order those jobs
> are submitted. We make sure that by checking entity->job_queue in
> drm_sched_entity_select_rq() so that we don't loadbalance jobs within
> an entity.
>
> But because we update entity->job_queue later in drm_sched_entity_push_job(),
> there remains a open window when it is possibe that entity->rq might get
> updated by drm_sched_entity_select_rq() which should not be allowed.

NAK, concurrent calls to 
drm_sched_job_init()/drm_sched_entity_push_job() are not allowed in the 
first place or otherwise we mess up the fence sequence order and risk 
memory corruption.

>
> Changes in this part also improves job distribution.
> Below are test results after running amdgpu_test from mesa drm
>
> Before this patch:
>
> sched_name     num of many times it got scheduled
> =========      ==================================
> sdma0          314
> sdma1          32
> comp_1.0.0     56
> comp_1.1.0     0
> comp_1.1.1     0
> comp_1.2.0     0
> comp_1.2.1     0
> comp_1.3.0     0
> comp_1.3.1     0
>
> After this patch:
>
> sched_name     num of many times it got scheduled
> =========      ==================================
>   sdma1          243
>   sdma0          164
>   comp_1.0.1     14
>   comp_1.1.0     11
>   comp_1.1.1     10
>   comp_1.2.0     15
>   comp_1.2.1     14
>   comp_1.3.0     10
>   comp_1.3.1     10

Well that is still rather nice to have, why does that happen?

Christian.

>
> Fixes: 35e160e781a048 (drm/scheduler: change entities rq even earlier)
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> Reported-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>   drivers/gpu/drm/scheduler/sched_entity.c | 9 +++++++--
>   drivers/gpu/drm/scheduler/sched_main.c   | 1 +
>   include/drm/gpu_scheduler.h              | 1 +
>   3 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index 2e3a058fc239..8414e084b6ac 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -67,6 +67,7 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
>   	entity->priority = priority;
>   	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;
>   	entity->last_scheduled = NULL;
> +	entity->loadbalance_on = true;
>   
>   	if(num_sched_list)
>   		entity->rq = &sched_list[0]->sched_rq[entity->priority];
> @@ -447,6 +448,9 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
>   	entity->last_scheduled = dma_fence_get(&sched_job->s_fence->finished);
>   
>   	spsc_queue_pop(&entity->job_queue);
> +	if (!spsc_queue_count(&entity->job_queue))
> +		entity->loadbalance_on = true;
> +
>   	return sched_job;
>   }
>   
> @@ -463,7 +467,8 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
>   	struct dma_fence *fence;
>   	struct drm_sched_rq *rq;
>   
> -	if (spsc_queue_count(&entity->job_queue) || entity->num_sched_list <= 1)
> +	atomic_inc(&entity->rq->sched->num_jobs);
> +	if ((entity->num_sched_list <= 1) || !entity->loadbalance_on)
>   		return;
>   
>   	fence = READ_ONCE(entity->last_scheduled);
> @@ -477,6 +482,7 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
>   		entity->rq = rq;
>   	}
>   
> +	entity->loadbalance_on = false;
>   	spin_unlock(&entity->rq_lock);
>   }
>   
> @@ -498,7 +504,6 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job,
>   	bool first;
>   
>   	trace_drm_sched_job(sched_job, entity);
> -	atomic_inc(&entity->rq->sched->num_jobs);
>   	WRITE_ONCE(entity->last_user, current->group_leader);
>   	first = spsc_queue_push(&entity->job_queue, &sched_job->queue_node);
>   
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 3fad5876a13f..00fdc350134e 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -562,6 +562,7 @@ int drm_sched_job_init(struct drm_sched_job *job,
>   		return -ENOENT;
>   
>   	sched = entity->rq->sched;
> +	atomic_inc(&entity->rq->sched->num_jobs);
>   
>   	job->sched = sched;
>   	job->entity = entity;
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 96a1a1b7526e..a5190869d323 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -97,6 +97,7 @@ struct drm_sched_entity {
>   	struct dma_fence                *last_scheduled;
>   	struct task_struct		*last_user;
>   	bool 				stopped;
> +	bool				loadbalance_on;
>   	struct completion		entity_idle;
>   };
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
