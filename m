Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE541C25B5F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 08:03:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CBA1112261;
	Wed,  1 May 2024 08:03:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="LuqVJ+Fr";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17C0110EE44
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 08:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wxXcFg0w3jW1PpRpjzrrpHM3g/+uOlybUW8rg1cWx+w=; b=LuqVJ+FrUaBLrYJJf5DNFlYwod
 tktpyM4jW8h/N1I4iwSTO9TMpozzsoPQZ4YVTFJsqZnuxdX7VuJlewEf4zLakX0yNeaimEI4uBPtP
 oioADrgtSQj1twBaIfhsk5LjEaeX9WEobxXqQL09qVA0YP+BenrvH5QsLDUiBE0b4qvEawTDiDoKY
 QGXKVl9+IWdYPZs1lRe5MPH45iGQcorJvw7xDm0BKGE5BOZMj/9nWm038Eo2voHkHLg8xJJ1i+T+f
 enQVTPwXVDqTDiO8/rqpH/7SfmbKlAnbuR0+M5npS/aYSd8hvPa1Rs34Ds/pfb3O5OHN2dXuIYrTP
 jXyUpdww==;
Received: from [84.65.0.132] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1s1iq0-001hbt-Vk; Tue, 30 Apr 2024 10:27:44 +0200
Message-ID: <de9eb1d4-f5b4-4c87-874c-0e9889eb26e9@igalia.com>
Date: Tue, 30 Apr 2024 09:27:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: Reduce mem_type to domain double
 indirection
Content-Language: en-GB
To: Felix Kuehling <felix.kuehling@amd.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 kernel-dev@igalia.com
References: <20240429164707.49196-1-tursulin@igalia.com>
 <20240429164707.49196-2-tursulin@igalia.com>
 <08145e84-ab41-428f-bf0b-406c61aab33c@amd.com>
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <08145e84-ab41-428f-bf0b-406c61aab33c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 01 May 2024 08:03:27 +0000
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


On 30/04/2024 01:31, Felix Kuehling wrote:
> 
> On 2024-04-29 12:47, Tvrtko Ursulin wrote:
>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>
>> All apart from AMDGPU_GEM_DOMAIN_GTT memory domains map 1:1 to TTM
>> placements. And the former be either AMDGPU_PL_PREEMPT or TTM_PL_TT,
>> depending on AMDGPU_GEM_CREATE_PREEMPTIBLE.
>>
>> Simplify a few places in the code which convert the TTM placement into
>> a domain by checking against the current placement directly.
>>
>> In the conversion AMDGPU_PL_PREEMPT either does not have to be handled
>> because amdgpu_mem_type_to_domain() cannot return that value anyway.
>>
>> v2:
>>   * Remove AMDGPU_PL_PREEMPT handling.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Reviewed-by: Christian König <christian.koenig@amd.com> # v1
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> 
> I also ran kfdtest on a multi-GPU system just to make sure this didn't 
> break our multi-GPU support. BTW, I had to fix up some things when I 

Excellent thank you!

Btw important thing to stress is that I hope the r-b means not only 
patch is functionaly correct but that you guys actually agree it is an 
improvement. Because I am quite new in your code base so please apply 
strict criteria on my proposals.

> tried to apply your patch to the current amd-staging-drm-next branch. 
> That branch was just rebased on Linux 6.8, so maybe that's part of the 
> reason.

I am conditioned to work against drm-tip so maybe that is one reason, or 
also possibly because now I see I used drm-tip from more than a week ago 
as a base. :( I can rebase and re-send. So amd-staging-drm-next is the 
correct branch?

Regards,

Tvrtko

> 
> 
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  3 +--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 27 +++++++++------------
>>   2 files changed, 12 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> index 055ba2ea4c12..0b3b10d21952 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> @@ -165,8 +165,7 @@ static struct sg_table *amdgpu_dma_buf_map(struct 
>> dma_buf_attachment *attach,
>>           if (r)
>>               return ERR_PTR(r);
>> -    } else if (!(amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type) &
>> -             AMDGPU_GEM_DOMAIN_GTT)) {
>> +    } else if (bo->tbo.resource->mem_type != TTM_PL_TT) {
>>           return ERR_PTR(-EBUSY);
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 8bc79924d171..eb5bd6962560 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -976,12 +976,11 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo 
>> *bo, u32 domain,
>>       ttm_bo_pin(&bo->tbo);
>> -    domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
>> -    if (domain == AMDGPU_GEM_DOMAIN_VRAM) {
>> +    if (bo->tbo.resource->mem_type == TTM_PL_VRAM) {
>>           atomic64_add(amdgpu_bo_size(bo), &adev->vram_pin_size);
>>           atomic64_add(amdgpu_vram_mgr_bo_visible_size(bo),
>>                    &adev->visible_pin_size);
>> -    } else if (domain == AMDGPU_GEM_DOMAIN_GTT) {
>> +    } else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
>>           atomic64_add(amdgpu_bo_size(bo), &adev->gart_pin_size);
>>       }
>> @@ -1280,7 +1279,6 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>>   {
>>       uint64_t size = amdgpu_bo_size(bo);
>>       struct drm_gem_object *obj;
>> -    unsigned int domain;
>>       bool shared;
>>       /* Abort if the BO doesn't currently have a backing store */
>> @@ -1290,21 +1288,20 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
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
>>           stats->gtt += size;
>>           if (shared)
>>               stats->gtt_shared += size;
>>           break;
>> -    case AMDGPU_GEM_DOMAIN_CPU:
>> +    case TTM_PL_SYSTEM:
>>       default:
>>           stats->cpu += size;
>>           if (shared)
>> @@ -1317,7 +1314,7 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>>           if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
>>               stats->requested_visible_vram += size;
>> -        if (domain != AMDGPU_GEM_DOMAIN_VRAM) {
>> +        if (bo->tbo.resource->mem_type != TTM_PL_VRAM) {
>>               stats->evicted_vram += size;
>>               if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
>>                   stats->evicted_visible_vram += size;
>> @@ -1592,19 +1589,17 @@ u64 amdgpu_bo_print_info(int id, struct 
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
>>               placement = "GTT";
>>               break;
>> -        case AMDGPU_GEM_DOMAIN_CPU:
>> +        case TTM_PL_SYSTEM:
>>           default:
>>               placement = "CPU";
>>               break;
