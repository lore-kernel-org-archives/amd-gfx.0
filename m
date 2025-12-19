Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065D5D711D6
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 08:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B88110E1BB;
	Fri, 19 Dec 2025 08:49:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="gP3pkjOV";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54C0710E1BB
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 08:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3qjsaNV+R1HFpCU0J8FtzdCgzkFJZxB6LjwF/VWv/hg=; b=gP3pkjOVtQ2L+y4UKAlHyeEIpw
 /y3MB9bU6Us28+l6twF3DzLQYNkFvG/xmhcSkW6JLq9AGiFR6BlxC7bNMLdfw1hKT9c/bAGsQeEEd
 DUPMszTlfOFeLTXHZ05AnWuVCNWjwHvGDzy62pec+xX6r7iwHg2ihNjjl3pwZ9TwGZa6hgL7EoPzl
 aFjAN0q6VaYOa2fWxxY6PerDqeDY4es7ITsU16mLyeo7pOFQ+EFzeYIP/2LW+nd4vFPnQC4hgEPLz
 nNiXTURY4wlMr6aV8LEYJ/KWYdyApxH3m71P3OPBhDwTZ0nnSkxGHEhX26oRDX4ooJuEcOavCzevz
 jxjU9W8A==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1vWWAx-00EYjV-K0; Fri, 19 Dec 2025 09:49:27 +0100
Message-ID: <77760000-32c3-4df4-8b92-ce51022165dd@igalia.com>
Date: Fri, 19 Dec 2025 08:49:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/5] drm/amdgpu: Convert context manager to xarray
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20251218150405.80502-1-tvrtko.ursulin@igalia.com>
 <20251218150405.80502-5-tvrtko.ursulin@igalia.com>
 <831aea45-f75c-4432-9045-cf44d8f7fc17@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <831aea45-f75c-4432-9045-cf44d8f7fc17@amd.com>
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


On 19/12/2025 08:28, Christian König wrote:
> On 12/18/25 16:04, Tvrtko Ursulin wrote:
>> IDR is deprecated so let's convert the context manager to xarray.
>>
>> In doing so we remove the context manager mutex and switch call sites
>> which required the guarantee context cannot go away while they walk the
>> list of context, or otherwise operate on them, to use reference counting.
>>
>> This allows us to use the built in xarray spinlock for all operations and
>> just temporarily drop it when we need to call sleeping functions.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   | 117 ++++++++--------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h   |   5 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c |   8 +-
>>   3 files changed, 49 insertions(+), 81 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> index afedea02188d..ee1464f8751a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> @@ -484,22 +484,17 @@ static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
>>   	if (!ctx)
>>   		return -ENOMEM;
>>   
>> -	mutex_lock(&mgr->lock);
>> -	r = idr_alloc(&mgr->ctx_handles, ctx, 1, AMDGPU_VM_MAX_NUM_CTX, GFP_KERNEL);
>> -	if (r < 0) {
>> -		mutex_unlock(&mgr->lock);
>> -		kfree(ctx);
>> -		return r;
>> -	}
>> -
>> -	*id = (uint32_t)r;
>>   	r = amdgpu_ctx_init(mgr, priority, filp, ctx);
>>   	if (r) {
>> -		idr_remove(&mgr->ctx_handles, *id);
>> -		*id = 0;
>>   		kfree(ctx);
>> +		return r;
>>   	}
>> -	mutex_unlock(&mgr->lock);
>> +
>> +	r = xa_alloc(&mgr->ctx_handles, id, ctx,
>> +		     XA_LIMIT(1, AMDGPU_VM_MAX_NUM_CTX - 1), GFP_KERNEL);
> 
> Please drop the AMDGPU_VM_MAX_NUM_CTX define as well. That is just a totally pointless limitation.

So xa_limit_32b ?

> 
>> +	if (r)
>> +		kref_put(&ctx->refcount, amdgpu_ctx_fini);
>> +
> 
> While at it you should probably clean up the unecessary differenciation between amdgpu_ctx_fini and amdgpu_ctx__do_release as well.

Right, those are very confusing indeed, so I happily will give that a go.

> 
>>   	return r;
>>   }
>>   
>> @@ -523,14 +518,11 @@ static void amdgpu_ctx_do_release(struct kref *ref)
>>   
>>   static int amdgpu_ctx_free(struct amdgpu_fpriv *fpriv, uint32_t id)
>>   {
>> -	struct amdgpu_ctx_mgr *mgr = &fpriv->ctx_mgr;
>>   	struct amdgpu_ctx *ctx;
>>   
>> -	mutex_lock(&mgr->lock);
>> -	ctx = idr_remove(&mgr->ctx_handles, id);
>> -	if (ctx)
>> -		kref_put(&ctx->refcount, amdgpu_ctx_do_release);
>> -	mutex_unlock(&mgr->lock);
>> +	ctx = xa_erase(&fpriv->ctx_mgr.ctx_handles, id);
>> +	amdgpu_ctx_put(ctx);
>> +
>>   	return ctx ? 0 : -EINVAL;
>>   }
>>   
>> @@ -539,20 +531,12 @@ static int amdgpu_ctx_query(struct amdgpu_device *adev,
>>   			    union drm_amdgpu_ctx_out *out)
>>   {
>>   	struct amdgpu_ctx *ctx;
>> -	struct amdgpu_ctx_mgr *mgr;
>>   	unsigned reset_counter;
>>   
>> -	if (!fpriv)
>> +	ctx = amdgpu_ctx_get(fpriv, id);
>> +	if (!ctx)
>>   		return -EINVAL;
>>   
>> -	mgr = &fpriv->ctx_mgr;
>> -	mutex_lock(&mgr->lock);
>> -	ctx = idr_find(&mgr->ctx_handles, id);
>> -	if (!ctx) {
>> -		mutex_unlock(&mgr->lock);
>> -		return -EINVAL;
>> -	}
>> -
>>   	/* TODO: these two are always zero */
>>   	out->state.flags = 0x0;
>>   	out->state.hangs = 0x0;
>> @@ -566,7 +550,8 @@ static int amdgpu_ctx_query(struct amdgpu_device *adev,
>>   		out->state.reset_status = AMDGPU_CTX_UNKNOWN_RESET;
>>   	ctx->reset_counter_query = reset_counter;
>>   
>> -	mutex_unlock(&mgr->lock);
>> +	amdgpu_ctx_put(ctx);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -578,19 +563,11 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
>>   {
>>   	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>>   	struct amdgpu_ctx *ctx;
>> -	struct amdgpu_ctx_mgr *mgr;
>>   
>> -	if (!fpriv)
>> +	ctx = amdgpu_ctx_get(fpriv, id);
>> +	if (!ctx)
>>   		return -EINVAL;
>>   
>> -	mgr = &fpriv->ctx_mgr;
>> -	mutex_lock(&mgr->lock);
>> -	ctx = idr_find(&mgr->ctx_handles, id);
>> -	if (!ctx) {
>> -		mutex_unlock(&mgr->lock);
>> -		return -EINVAL;
>> -	}
>> -
>>   	out->state.flags = 0x0;
>>   	out->state.hangs = 0x0;
>>   
>> @@ -630,7 +607,8 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
>>   				      msecs_to_jiffies(AMDGPU_RAS_COUNTE_DELAY_MS));
>>   	}
>>   
>> -	mutex_unlock(&mgr->lock);
>> +	amdgpu_ctx_put(ctx);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -639,26 +617,18 @@ static int amdgpu_ctx_stable_pstate(struct amdgpu_device *adev,
>>   				    bool set, u32 *stable_pstate)
>>   {
>>   	struct amdgpu_ctx *ctx;
>> -	struct amdgpu_ctx_mgr *mgr;
>>   	int r;
>>   
>> -	if (!fpriv)
>> +	ctx = amdgpu_ctx_get(fpriv, id);
>> +	if (!ctx)
>>   		return -EINVAL;
>>   
>> -	mgr = &fpriv->ctx_mgr;
>> -	mutex_lock(&mgr->lock);
>> -	ctx = idr_find(&mgr->ctx_handles, id);
>> -	if (!ctx) {
>> -		mutex_unlock(&mgr->lock);
>> -		return -EINVAL;
>> -	}
>> -
>>   	if (set)
>>   		r = amdgpu_ctx_set_stable_pstate(ctx, *stable_pstate);
>>   	else
>>   		r = amdgpu_ctx_get_stable_pstate(ctx, stable_pstate);
>>   
>> -	mutex_unlock(&mgr->lock);
>> +	amdgpu_ctx_put(ctx);
>>   	return r;
>>   }
>>   
>> @@ -737,11 +707,11 @@ struct amdgpu_ctx *amdgpu_ctx_get(struct amdgpu_fpriv *fpriv, uint32_t id)
>>   
>>   	mgr = &fpriv->ctx_mgr;
>>   
>> -	mutex_lock(&mgr->lock);
>> -	ctx = idr_find(&mgr->ctx_handles, id);
>> +	xa_lock(&mgr->ctx_handles);
>> +	ctx = xa_load(&mgr->ctx_handles, id);
>>   	if (ctx)
>>   		kref_get(&ctx->refcount);
>> -	mutex_unlock(&mgr->lock);
>> +	xa_unlock(&mgr->ctx_handles);
>>   	return ctx;
>>   }
>>   
>> @@ -886,8 +856,7 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr,
>>   	unsigned int i;
>>   
>>   	mgr->adev = adev;
>> -	mutex_init(&mgr->lock);
>> -	idr_init_base(&mgr->ctx_handles, 1);
>> +	xa_init_flags(&mgr->ctx_handles, XA_FLAGS_ALLOC1);
>>   
>>   	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
>>   		atomic64_set(&mgr->time_spend[i], 0);
>> @@ -896,13 +865,14 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr,
>>   long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
>>   {
>>   	struct amdgpu_ctx *ctx;
>> -	struct idr *idp;
>> -	uint32_t id, i, j;
>> +	unsigned long id;
>> +	uint32_t i, j;
>>   
>> -	idp = &mgr->ctx_handles;
>> -
>> -	mutex_lock(&mgr->lock);
>> -	idr_for_each_entry(idp, ctx, id) {
>> +	xa_lock(&mgr->ctx_handles);
>> +	xa_for_each(&mgr->ctx_handles, id, ctx) {
>> +		if (!kref_get_unless_zero(&ctx->refcount))
> 
> This should be pointless, why not use kfre_get instead?

True, don't know what I was thinking.

> 
>> +			continue;
>> +		xa_unlock(&mgr->ctx_handles);
>>   		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
>>   			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
>>   				struct drm_sched_entity *entity;
>> @@ -914,20 +884,20 @@ long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
>>   				timeout = drm_sched_entity_flush(entity, timeout);
>>   			}
>>   		}
>> +		amdgpu_ctx_put(ctx);
>> +		xa_lock(&mgr->ctx_handles);
>>   	}
>> -	mutex_unlock(&mgr->lock);
>> +	xa_unlock(&mgr->ctx_handles);
>>   	return timeout;
>>   }
>>   
>>   static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>>   {
>>   	struct amdgpu_ctx *ctx;
>> -	struct idr *idp;
>> -	uint32_t id, i, j;
>> +	unsigned long id;
>> +	uint32_t i, j;
>>   
>> -	idp = &mgr->ctx_handles;
>> -
>> -	idr_for_each_entry(idp, ctx, id) {
>> +	xa_for_each(&mgr->ctx_handles, id, ctx) {
> 
>>   		if (kref_read(&ctx->refcount) != 1) {
>>   			DRM_ERROR("ctx %p is still alive\n", ctx);
>>   			continue;
> 
> Please drop that check as well. It just leads to memory leaks and errors should anything go wrong and so only make things worse.
> 
> We can have something like WARN_ON_ONCE(kref_read(&ctx->refcount) != 1) here, but I think that is superflous as well.

Hm, you mean leaving the entity around while the rest of the file gets 
closed causes other problems ie. this is not enough to turn crashes into 
memory leaks?

Regards,

Tvrtko

> 
> Regards,
> Christian.
> 
>> @@ -951,8 +921,7 @@ static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>>   void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
>>   {
>>   	amdgpu_ctx_mgr_entity_fini(mgr);
>> -	idr_destroy(&mgr->ctx_handles);
>> -	mutex_destroy(&mgr->lock);
>> +	xa_destroy(&mgr->ctx_handles);
>>   }
>>   
>>   void amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr,
>> @@ -960,21 +929,21 @@ void amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr,
>>   {
>>   	struct amdgpu_ctx *ctx;
>>   	unsigned int hw_ip, i;
>> -	uint32_t id;
>> +	unsigned long id;
>>   
>>   	/*
>>   	 * This is a little bit racy because it can be that a ctx or a fence are
>>   	 * destroyed just in the moment we try to account them. But that is ok
>>   	 * since exactly that case is explicitely allowed by the interface.
>>   	 */
>> -	mutex_lock(&mgr->lock);
>>   	for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
>>   		uint64_t ns = atomic64_read(&mgr->time_spend[hw_ip]);
>>   
>>   		usage[hw_ip] = ns_to_ktime(ns);
>>   	}
>>   
>> -	idr_for_each_entry(&mgr->ctx_handles, ctx, id) {
>> +	xa_lock(&mgr->ctx_handles);
>> +	xa_for_each(&mgr->ctx_handles, id, ctx) {
>>   		for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
>>   			for (i = 0; i < amdgpu_ctx_num_entities[hw_ip]; ++i) {
>>   				struct amdgpu_ctx_entity *centity;
>> @@ -988,5 +957,5 @@ void amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr,
>>   			}
>>   		}
>>   	}
>> -	mutex_unlock(&mgr->lock);
>> +	xa_unlock(&mgr->ctx_handles);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> index 090dfe86f75b..d073cffa455d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> @@ -25,6 +25,7 @@
>>   
>>   #include <linux/ktime.h>
>>   #include <linux/types.h>
>> +#include <linux/xarray.h>
>>   
>>   #include "amdgpu_ring.h"
>>   
>> @@ -62,9 +63,7 @@ struct amdgpu_ctx {
>>   
>>   struct amdgpu_ctx_mgr {
>>   	struct amdgpu_device	*adev;
>> -	struct mutex		lock;
>> -	/* protected by lock */
>> -	struct idr		ctx_handles;
>> +	struct xarray		ctx_handles;
>>   	atomic64_t		time_spend[AMDGPU_HW_IP_NUM];
>>   };
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>> index 341beec59537..471d27b2db01 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>> @@ -39,7 +39,7 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
>>   	struct amdgpu_fpriv *fpriv;
>>   	struct amdgpu_ctx_mgr *mgr;
>>   	struct amdgpu_ctx *ctx;
>> -	uint32_t id;
>> +	unsigned long id;
>>   	int r;
>>   
>>   	if (fd_empty(f))
>> @@ -50,10 +50,10 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
>>   		return r;
>>   
>>   	mgr = &fpriv->ctx_mgr;
>> -	mutex_lock(&mgr->lock);
>> -	idr_for_each_entry(&mgr->ctx_handles, ctx, id)
>> +	xa_lock(&mgr->ctx_handles);
>> +	xa_for_each(&mgr->ctx_handles, id, ctx)
>>   		amdgpu_ctx_priority_override(ctx, priority);
>> -	mutex_unlock(&mgr->lock);
>> +	xa_unlock(&mgr->ctx_handles);
>>   
>>   	return 0;
>>   }
> 

