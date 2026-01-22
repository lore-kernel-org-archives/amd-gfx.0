Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D75C44500
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 08:56:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E40E810E94D;
	Thu, 22 Jan 2026 08:56:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="FPRBbvez";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D09FA10E94D
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 08:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5nRp3zPLNXixKxLbO60c6keyTuLMOKAHt+Lwg2Frp5k=; b=FPRBbvezJ5USO/A+lQahi23Zgu
 rx5L260WtpI6Y09X2JzOHVzaS0yV3+OUNA1xjagV1CGY6m8JYFBZEXgTg5JrHjMjzaRhTPA3yVjni
 mM22I0+EQF9IBmnPuX6zQ0GOE0ZzmIABpXmHiSFTs9oFHL4W6hyugMAU7LQPsPo2aiqGSf02iwf/V
 bAT2iYwzhuc5awPzm11YTshTkY1RpQuFPdpaQ1TuGxS3iE9ooXXpOUpw2aNcxv9yDb4/t7lLETMgj
 YPIeN7rQh3bb/stfBQYzdX2IFqHMbgEv9PQk0rJxqkFU4h5qGKFKvYZ7zGU94/3MbVj5or5omUxd8
 x0vTMJHA==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1viqUN-008NFk-2m; Thu, 22 Jan 2026 09:56:27 +0100
Message-ID: <1dc6b09f-563a-480a-a884-101271302367@igalia.com>
Date: Thu, 22 Jan 2026 08:56:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/12] drm/amdgpu: Consolidate ctx put
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20260112102244.63308-1-tvrtko.ursulin@igalia.com>
 <20260112102244.63308-9-tvrtko.ursulin@igalia.com>
 <4a57e7f6-0722-411f-a37f-24d1f5d6f0e8@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <4a57e7f6-0722-411f-a37f-24d1f5d6f0e8@amd.com>
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


On 12/01/2026 13:32, Christian König wrote:
> On 1/12/26 11:22, Tvrtko Ursulin wrote:
>> Currently there are two flavours of the context reference count
>> destructor:
>>
>>   - amdgpu_ctx_do_release(), used from kref_put from places where the code
>>     thinks context may have been used, or is in active use, and;
>>   - amdgpu_ctx_fini(), used when code is sure context entities have already
>>     been idled.
>>
>> Since amdgpu_ctx_do_release() calls amdgpu_ctx_fini() after having idled
>> and destroyed the scheduler entities, we can consolidate the two into a
>> single function.
>>
>> Functional difference is that now drm_sched_entity_destroy() is called on
>> context manager shutdown (file close), where previously it was
>> drm_sched_entity_fini(). But the former is a superset of the latter, and
>> during file close the flush method is also called, which calls
>> drm_sched_entity_flush(), which is also called by
>> drm_sched_entity_destroy(). And as it is safe to attempt to flush a never
>> used entity, or flush it twice, there is actually no functional change.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Suggested-by: Christian König <christian.koenig@amd.com>
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>
> 
> Looks like this was the last patch to review. I will pick up the set and try to push it to amd-staging-drm-next.

Gentle reminder if we could try to validate the series via 
amd-staging-drm-next.

Also, what could I do on my end to get more confidence some edge case is 
not broken? Run the IGT tests? Is there an useful testlist which can be 
used with the IGT runner or that is not used on the AMD side?

Regards,

Tvrtko

>> ---
>> v2:
>>   * Use separate variable for drm_dev_enter for readability.
>>
>> v3:
>>   * Keep amdgpu_ctx_fini_entity as a separate function.
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 54 ++++---------------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  9 ++++-
>>   2 files changed, 15 insertions(+), 48 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> index 325833ed2571..cc69ad0f03d5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> @@ -284,6 +284,8 @@ static ktime_t amdgpu_ctx_fini_entity(struct amdgpu_device *adev,
>>   	if (!entity)
>>   		return res;
>>   
>> +	drm_sched_entity_destroy(&entity->entity);
>> +
>>   	for (i = 0; i < amdgpu_sched_jobs; ++i) {
>>   		res = ktime_add(res, amdgpu_ctx_fence_time(entity->fences[i]));
>>   		dma_fence_put(entity->fences[i]);
>> @@ -409,7 +411,7 @@ static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
>>   	return r;
>>   }
>>   
>> -static void amdgpu_ctx_fini(struct kref *ref)
>> +void amdgpu_ctx_fini(struct kref *ref)
>>   {
>>   	struct amdgpu_ctx *ctx = container_of(ref, struct amdgpu_ctx, refcount);
>>   	struct amdgpu_ctx_mgr *mgr = ctx->mgr;
>> @@ -508,24 +510,6 @@ static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
>>   	return r;
>>   }
>>   
>> -static void amdgpu_ctx_do_release(struct kref *ref)
>> -{
>> -	struct amdgpu_ctx *ctx;
>> -	u32 i, j;
>> -
>> -	ctx = container_of(ref, struct amdgpu_ctx, refcount);
>> -	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
>> -		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
>> -			if (!ctx->entities[i][j])
>> -				continue;
>> -
>> -			drm_sched_entity_destroy(&ctx->entities[i][j]->entity);
>> -		}
>> -	}
>> -
>> -	amdgpu_ctx_fini(ref);
>> -}
>> -
>>   static int amdgpu_ctx_free(struct amdgpu_fpriv *fpriv, uint32_t id)
>>   {
>>   	struct amdgpu_ctx_mgr *mgr = &fpriv->ctx_mgr;
>> @@ -533,8 +517,7 @@ static int amdgpu_ctx_free(struct amdgpu_fpriv *fpriv, uint32_t id)
>>   
>>   	mutex_lock(&mgr->lock);
>>   	ctx = idr_remove(&mgr->ctx_handles, id);
>> -	if (ctx)
>> -		kref_put(&ctx->refcount, amdgpu_ctx_do_release);
>> +	amdgpu_ctx_put(ctx);
>>   	mutex_unlock(&mgr->lock);
>>   	return ctx ? 0 : -EINVAL;
>>   }
>> @@ -750,15 +733,6 @@ struct amdgpu_ctx *amdgpu_ctx_get(struct amdgpu_fpriv *fpriv, uint32_t id)
>>   	return ctx;
>>   }
>>   
>> -int amdgpu_ctx_put(struct amdgpu_ctx *ctx)
>> -{
>> -	if (ctx == NULL)
>> -		return -EINVAL;
>> -
>> -	kref_put(&ctx->refcount, amdgpu_ctx_do_release);
>> -	return 0;
>> -}
>> -
>>   uint64_t amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
>>   			      struct drm_sched_entity *entity,
>>   			      struct dma_fence *fence)
>> @@ -927,29 +901,15 @@ long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
>>   static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>>   {
>>   	struct amdgpu_ctx *ctx;
>> -	struct idr *idp;
>> -	uint32_t id, i, j;
>> +	uint32_t id;
>>   
>> -	idp = &mgr->ctx_handles;
>> -
>> -	idr_for_each_entry(idp, ctx, id) {
>> +	idr_for_each_entry(&mgr->ctx_handles, ctx, id) {
>>   		if (kref_read(&ctx->refcount) != 1) {
>>   			DRM_ERROR("ctx %p is still alive\n", ctx);
>>   			continue;
>>   		}
>>   
>> -		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
>> -			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
>> -				struct drm_sched_entity *entity;
>> -
>> -				if (!ctx->entities[i][j])
>> -					continue;
>> -
>> -				entity = &ctx->entities[i][j]->entity;
>> -				drm_sched_entity_fini(entity);
>> -			}
>> -		}
>> -		kref_put(&ctx->refcount, amdgpu_ctx_fini);
>> +		amdgpu_ctx_put(ctx);
>>   	}
>>   }
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> index cf8d700a22fe..b1fa7fe74569 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> @@ -70,7 +70,14 @@ struct amdgpu_ctx_mgr {
>>   extern const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM];
>>   
>>   struct amdgpu_ctx *amdgpu_ctx_get(struct amdgpu_fpriv *fpriv, uint32_t id);
>> -int amdgpu_ctx_put(struct amdgpu_ctx *ctx);
>> +
>> +void amdgpu_ctx_fini(struct kref *kref);
>> +
>> +static inline void amdgpu_ctx_put(struct amdgpu_ctx *ctx)
>> +{
>> +	if (ctx)
>> +		kref_put(&ctx->refcount, amdgpu_ctx_fini);
>> +}
>>   
>>   int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
>>   			  u32 ring, struct drm_sched_entity **entity);
> 

