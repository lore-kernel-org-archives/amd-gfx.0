Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BC5C25B4F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 07:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3361B10F658;
	Tue, 30 Apr 2024 07:27:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="rNdUwakl";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADA4F10F2DF
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 13:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Soj23M56RiptshTQOQ+wXRqsqH8wSlqc5tn4FwCN1P8=; b=rNdUwaklTfvD4tOnR4JNhmNcGo
 eFrZROoFEEHcC6OEJ3SSywP8H9fuMI9pw3doy72g9EJ5rUsv+quszJwNahKwfQexn8mBaYP4Z2hX5
 HiWLVUICocYvvaDqlLCxfMdcvgxcphEaDb8EBMJSTz/yBQe5OS+ngdL2XRF/HKbGC9FDHtBz14XkA
 9X5IV09T+RvNbsUGIezSZ18/KKsm1O3AUpbpweImECV4pfj+tG7mtCft3g003QPrTL4IuIwq7w00q
 B8Ek8iQax1/Gitq3m/o4Si56vm0V5+eS+eiMrsNrepOBQN5MZtFtS2J4wFmmfFNkSZzgW973bpC9B
 sdh1FIFg==;
Received: from [84.65.0.132] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1s1RDD-001K6m-CV; Mon, 29 Apr 2024 15:38:31 +0200
Message-ID: <7f3f0437-85f0-40ee-a9aa-57586ac55bcf@igalia.com>
Date: Mon, 29 Apr 2024 14:38:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: Reduce mem_type to domain double
 indirection
Content-Language: en-GB
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 kernel-dev@igalia.com
References: <20240426164355.1563-1-tursulin@igalia.com>
 <20240426164355.1563-3-tursulin@igalia.com>
 <5a8ba071-21b7-44de-8473-b82193cfa35d@gmail.com>
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <5a8ba071-21b7-44de-8473-b82193cfa35d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Apr 2024 07:26:58 +0000
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


Hi Christian,

On 29/04/2024 12:03, Christian König wrote:
> Am 26.04.24 um 18:43 schrieb Tvrtko Ursulin:
>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>
>> All apart from AMDGPU_GEM_DOMAIN_GTT memory domains map 1:1 to TTM
>> placements. And the former be either AMDGPU_PL_PREEMPT or TTM_PL_TT,
>> depending on AMDGPU_GEM_CREATE_PREEMPTIBLE.
>>
>> Simplify a few places in the code which convert the TTM placement into
>> a domain by checking against the current placement directly.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>

Thanks! I am however a bit unsure now, read below..

>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  4 +--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 30 ++++++++++-----------
>>   2 files changed, 16 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> index 055ba2ea4c12..ff83f8d8628c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> @@ -165,8 +165,8 @@ static struct sg_table *amdgpu_dma_buf_map(struct 
>> dma_buf_attachment *attach,
>>           if (r)
>>               return ERR_PTR(r);
>> -    } else if (!(amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type) &
>> -             AMDGPU_GEM_DOMAIN_GTT)) {
>> +    } else if (bo->tbo.resource->mem_type != TTM_PL_TT &&
>> +           bo->tbo.resource->mem_type != AMDGPU_PL_PREEMPT) {
>>           return ERR_PTR(-EBUSY);

... this for instance (one hunk below too).

Because what we are discussing in 3/3, 
amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type) does not return a 
valid domain for AMDGPU_PL_PREEMPT. Which could make mentioning it here 
misleading. So I am not really sure what the design is supposed to be.

Is this a weakness in the current code? Maybe best to leave the 
discussion for 3/3.

Regards,

Tvrtko

>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 8bc79924d171..fb984669fc3a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -976,12 +976,12 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo 
>> *bo, u32 domain,
>>       ttm_bo_pin(&bo->tbo);
>> -    domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
>> -    if (domain == AMDGPU_GEM_DOMAIN_VRAM) {
>> +    if (bo->tbo.resource->mem_type == TTM_PL_VRAM) {
>>           atomic64_add(amdgpu_bo_size(bo), &adev->vram_pin_size);
>>           atomic64_add(amdgpu_vram_mgr_bo_visible_size(bo),
>>                    &adev->visible_pin_size);
>> -    } else if (domain == AMDGPU_GEM_DOMAIN_GTT) {
>> +    } else if (bo->tbo.resource->mem_type == TTM_PL_TT ||
>> +           bo->tbo.resource->mem_type == AMDGPU_PL_PREEMPT) {
>>           atomic64_add(amdgpu_bo_size(bo), &adev->gart_pin_size);
>>       }
>> @@ -1280,7 +1280,6 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>>   {
>>       uint64_t size = amdgpu_bo_size(bo);
>>       struct drm_gem_object *obj;
>> -    unsigned int domain;
>>       bool shared;
>>       /* Abort if the BO doesn't currently have a backing store */
>> @@ -1290,21 +1289,21 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>>       obj = &bo->tbo.base;
>>       shared = drm_gem_object_is_shared_for_memory_stats(obj);
>> -    domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
>> -    switch (domain) {
>> -    case AMDGPU_GEM_DOMAIN_VRAM:
>> +    switch (bo->tbo.resource->mem_type) {
>> +    case TTM_PL_VRAM:
>>           stats->vram += size;
>>           if (amdgpu_bo_in_cpu_visible_vram(bo))
>>               stats->visible_vram += size;
>>           if (shared)
>>               stats->vram_shared += size;
>>           break;
>> -    case AMDGPU_GEM_DOMAIN_GTT:
>> +    case TTM_PL_TT:
>> +    case AMDGPU_PL_PREEMPT:
>>           stats->gtt += size;
>>           if (shared)
>>               stats->gtt_shared += size;
>>           break;
>> -    case AMDGPU_GEM_DOMAIN_CPU:
>> +    case TTM_PL_SYSTEM:
>>       default:
>>           stats->cpu += size;
>>           if (shared)
>> @@ -1317,7 +1316,7 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>>           if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
>>               stats->requested_visible_vram += size;
>> -        if (domain != AMDGPU_GEM_DOMAIN_VRAM) {
>> +        if (bo->tbo.resource->mem_type != TTM_PL_VRAM) {
>>               stats->evicted_vram += size;
>>               if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
>>                   stats->evicted_visible_vram += size;
>> @@ -1592,19 +1591,18 @@ u64 amdgpu_bo_print_info(int id, struct 
>> amdgpu_bo *bo, struct seq_file *m)
>>       u64 size;
>>       if (dma_resv_trylock(bo->tbo.base.resv)) {
>> -        unsigned int domain;
>> -        domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
>> -        switch (domain) {
>> -        case AMDGPU_GEM_DOMAIN_VRAM:
>> +        switch (bo->tbo.resource->mem_type) {
>> +        case TTM_PL_VRAM:
>>               if (amdgpu_bo_in_cpu_visible_vram(bo))
>>                   placement = "VRAM VISIBLE";
>>               else
>>                   placement = "VRAM";
>>               break;
>> -        case AMDGPU_GEM_DOMAIN_GTT:
>> +        case TTM_PL_TT:
>> +        case AMDGPU_PL_PREEMPT:
>>               placement = "GTT";
>>               break;
>> -        case AMDGPU_GEM_DOMAIN_CPU:
>> +        case TTM_PL_SYSTEM:
>>           default:
>>               placement = "CPU";
>>               break;
> 
