Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDCAC25B73
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 07:27:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E54C910F40F;
	Tue, 30 Apr 2024 07:26:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="RLbZYyeE";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39EC210F566
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 16:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vL96ezukWRT/Dl7UOn7mdUCeARKIoqSIwl0N78e8gtc=; b=RLbZYyeEteKYc8wU02zNu0uyPz
 qzZMbIe/g3UBej79xD3CN3wcBhU3jJwKk+9TxHd4+SF8FP5dSiksbbktGjrG40q2HT1kRkHhmX6RK
 ABfGfMbiFCpg92K44opeSEz1ETBjsd3RTFt2eSdSG+X7tPYasiJjo3OU80oUqvYDzLCT3ZkV/s6IT
 M2FKoYeYk3tmstwAfu/lphG8IdTs0vir1FdRyTULkrBYWEp/4ZYqnzaAz+yqz+z2aprXWuO8PSJQI
 dcdyMaomFXf+2mPNX/r5HBHiVGUs5FXsd8Pj7770H4Q878KOo8bNS8qBr2s7WU3FQp4NijRi/DFRg
 Lef8AEYw==;
Received: from [84.65.0.132] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1s1UE5-001O0i-3A; Mon, 29 Apr 2024 18:51:36 +0200
Message-ID: <f8a39b74-1b94-435b-b38e-00bb8dda3d10@igalia.com>
Date: Mon, 29 Apr 2024 17:51:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Fix pinned GART area accounting and
 fdinfo reporting
Content-Language: en-GB
To: Felix Kuehling <felix.kuehling@amd.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 kernel-dev@igalia.com
References: <20240426164355.1563-1-tursulin@igalia.com>
 <20240426164355.1563-4-tursulin@igalia.com>
 <a60dede1-8e81-4c79-8058-257391930621@amd.com>
 <fe80a8db-3ece-4818-8b23-2ccf5293a6c2@igalia.com>
 <fa1f5d0f-700c-42cc-81bb-69702abb5b91@amd.com>
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <fa1f5d0f-700c-42cc-81bb-69702abb5b91@amd.com>
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


On 29/04/2024 15:43, Felix Kuehling wrote:
> On 2024-04-29 5:43, Tvrtko Ursulin wrote:
>>
>> On 26/04/2024 23:24, Felix Kuehling wrote:
>>>
>>> On 2024-04-26 12:43, Tvrtko Ursulin wrote:
>>>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>
>>>> When commit b453e42a6e8b ("drm/amdgpu: Add new placement for 
>>>> preemptible
>>>> SG BOs") added a new TTM region it missed to notice the conceptual
>>>> imbalance in GART pin size accounting as done in amdgpu_bo_pin/unpin.
>>>>
>>>> That imbalance leads to such objects getting accounted against the
>>>> resource, but are not un-accounted when unpinned.
>>>
>>> AMDGPU_PL_PREEMPT is mostly used for userptr BOs, which cannot be 
>>> pinned. In any case you should make sure that the accounting is 
>>> consistent between amdgpu_bo_pin_restricted and amdgpu_bo_unpin. This 
>>> patch breaks that consistency.
>>
>> You mean amdgpu_bo_pin(_restricted) and amdgpu_bo_unpin do not run for 
>> such objects, or something else?
> 
> Right. amdgpu_bo_pin_restricted will return an error for userptr BOs:
> 
>          if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm))
>                  return -EPERM;

Ah I missed that, thank you!

>>
>> If they run, then at the end of pin there is:
>>
>>      domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
>> ...
>>      } else if (domain == AMDGPU_GEM_DOMAIN_GTT) {
>>          atomic64_add(amdgpu_bo_size(bo), &adev->gart_pin_size);
> 
> You changed that in your patch 2:
> 
> -    } else if (domain == AMDGPU_GEM_DOMAIN_GTT) {
> +    } else if (bo->tbo.resource->mem_type == TTM_PL_TT ||
> +           bo->tbo.resource->mem_type == AMDGPU_PL_PREEMPT) {
>           atomic64_add(amdgpu_bo_size(bo), &adev->gart_pin_size);
>       }
> 
> I was suggesting you just change this in patch 2 like this, so it 
> matches what's done on unpin:
> 
> -    } else if (domain == AMDGPU_GEM_DOMAIN_GTT) {
> +    } else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
>           atomic64_add(amdgpu_bo_size(bo), &adev->gart_pin_size);
>       }
> 
> 
>>
>> And unpin has no handling for AMDGPU_PL_PREEMPT.
>>
>> Ah I see.. does it rely on amdgpu_mem_type_to_domain returning 0 for 
>> AMDGPU_PL_PREEMPT? My confusion was I misread the pinning check as 
>> checking the domain as stored in the bo at creation time.
>>
>> Although I am still confused by the statement userptr BOs are not 
>> pinned. It is not needed to map them via GART on AMD hardware for GPU 
>> to be able to access them?
>>>> Fix by extending the accounting criteria in amdgpu_bo_unpin.
>>>>
>>>> What also aappears needs fixing is not reporting their size from the
>>>> amdgpu_bo_get_memory, which is used to implement fdinfo stats, so 
>>>> they are
>>>> not mixed with the regular userspace created and driver owned objects.
>>>
>>> I think that's true. It's a very fine distinction. AMDGPU_PL_PREEMPT 
>>> does use system memory and it is GPU accessible, just like GTT. The 
>>> only difference is, that it's not subject to the GTT limits because 
>>> their eviction is handled by callbacks other than TTM evictions and 
>>> doesn't need to wait for fences.
>>
>> As in you think those two hunks of the patch are correct?
> 
> Yes. It seems, Christian agrees but wants to show preemptible memory 
> separately in debugfs instead of not showing it at all.

Okay, I've posted a respin with a name 'PREEMPTIBLE' to start the naming 
discussion. :)

If I did not get confused again, it is only the last patch in the series 
moves the reporting for those objects from 'CPU' to this new label.

This is because both the current code:

                domain = 
amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
                switch (domain) {
...
                default:
                         placement = "CPU";
                         break;

And with my 2/3:

                switch (bo->tbo.resource->mem_type) {
...
                case TTM_PL_SYSTEM:
                default:
                         placement = "CPU";
                         break;

They end up in the CPU bucket. Things only change with 3/3:

Regards,

Tvrtko

> 
> Regards,
>    Felix
> 
> 
>>
>> Regards,
>>
>> Tvrtko
>>
>>
>>> Regards,
>>>    Felix
>>>
>>>
>>>>
>>>> And also amdgpu_bo_print_info for debugfs reporting.
>>>>
>>>> Note that the patch depends on the previous one which broke down the
>>>> relevant checks from the domain based to placement based.
>>>>
>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>> Fixes: b453e42a6e8b ("drm/amdgpu: Add new placement for preemptible 
>>>> SG BOs")
>>>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>>>> Cc: Christian König <christian.koenig@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 5 ++---
>>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> index fb984669fc3a..5a2bbc793953 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> @@ -1032,7 +1032,8 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>>>>           atomic64_sub(amdgpu_bo_size(bo), &adev->vram_pin_size);
>>>>           atomic64_sub(amdgpu_vram_mgr_bo_visible_size(bo),
>>>>                    &adev->visible_pin_size);
>>>> -    } else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
>>>> +    } else if (bo->tbo.resource->mem_type == TTM_PL_TT ||
>>>> +           bo->tbo.resource->mem_type == AMDGPU_PL_PREEMPT) {
>>>>           atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
>>>>       }
>>>> @@ -1298,7 +1299,6 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>>>>               stats->vram_shared += size;
>>>>           break;
>>>>       case TTM_PL_TT:
>>>> -    case AMDGPU_PL_PREEMPT:
>>>>           stats->gtt += size;
>>>>           if (shared)
>>>>               stats->gtt_shared += size;
>>>> @@ -1599,7 +1599,6 @@ u64 amdgpu_bo_print_info(int id, struct 
>>>> amdgpu_bo *bo, struct seq_file *m)
>>>>                   placement = "VRAM";
>>>>               break;
>>>>           case TTM_PL_TT:
>>>> -        case AMDGPU_PL_PREEMPT:
>>>>               placement = "GTT";
>>>>               break;
>>>>           case TTM_PL_SYSTEM:
