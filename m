Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AC0C25B76
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 11:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFD8F10E246;
	Mon,  3 Jun 2024 11:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="jwUenI5A";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="sn9mt4DD";
	dkim-atps=neutral
Received: from bunu.damsy.net (bunu.damsy.net [51.159.160.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5311310E246
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 11:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202404r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1717415541;
 bh=H1FYKEMBJZr0qxGrjqFHHD6
 SEmLDyHd9DEe5+MjnZTM=; b=jwUenI5AgBzmMyD8Xx5I2SK6+GYmfXuDynRIsghpbtCfcD6jtJ
 VMZ3mkxIvrkZRR1eY9DZ8fMJ7NK1NzLXw9E2ISjs9Wd1rmNI57HH5pFzBKFeXGHfQVlhQubvxBQ
 2UYyXay6OPeSjg4ns7LDjhtmy1QJ74Fb+CCOql84DGDfH8p+qEsPX/MJ56/no1gY2tWgz8GhwCm
 iUZdASfkesKsmjHCOzT/v248QlIPF7fXS9aVkml7GrCL52zSEV4cxFgVSrfXhLSV/eOfgdAMxUD
 VHpQ7k596UQUg3ewBq9A1RbzxMB55SoIja72UipGa69NoAYW/WGeLe2TXRB+voVG8ig==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202404e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1717415541; bh=H1FYKEMBJZr0qxGrjqFHHD6
 SEmLDyHd9DEe5+MjnZTM=; b=sn9mt4DDcd7knYkIUhLpXhIL6toAQdLDQ2803oA2+bsB4PI8wA
 DhdqnYiDuD5Z4V2eTaeQtJYHfeJhozGOKQDQ==;
Message-ID: <011928f3-ae86-4506-a9a5-1ced96032f34@damsy.net>
Date: Mon, 3 Jun 2024 13:52:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] amdgpu: add the amdgpu_vm ptr in the vm_bo_map/unmap
 events
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20240603084729.15135-1-pierre-eric.pelloux-prayer@amd.com>
 <beb3e657-3834-4c80-b854-cdb5ba4ca534@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <beb3e657-3834-4c80-b854-cdb5ba4ca534@amd.com>
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

Hi Christia,

Le 03/06/2024 à 11:58, Christian König a écrit :
> Am 03.06.24 um 10:46 schrieb Pierre-Eric Pelloux-Prayer:
>> These 2 traces events are tied to a specific VM so in order for them
>> to be useful for a tool we need to trace the amdgpu_vm as well.
> 
> The bo_va already contains the VM pointer the map/unmap operation 
> belongs to.
> 

Indeed, I've missed that. I'll fix that in v2.

>>
>> Signed-off-by: Pierre-Eric Pelloux-Prayer 
>> <pierre-eric.pelloux-prayer@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 20 ++++++++++++--------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  8 ++++----
>>   2 files changed, 16 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> index f539b1d00234..c84050d318d6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> @@ -243,10 +243,11 @@ TRACE_EVENT(amdgpu_vm_grab_id,
>>   );
>>   TRACE_EVENT(amdgpu_vm_bo_map,
>> -        TP_PROTO(struct amdgpu_bo_va *bo_va,
>> +        TP_PROTO(struct amdgpu_vm *vm, struct amdgpu_bo_va *bo_va,
>>                struct amdgpu_bo_va_mapping *mapping),
>> -        TP_ARGS(bo_va, mapping),
>> +        TP_ARGS(vm, bo_va, mapping),
>>           TP_STRUCT__entry(
>> +                 __field(struct amdgpu_vm *, vm)
>>                    __field(struct amdgpu_bo *, bo)
>>                    __field(long, start)
>>                    __field(long, last)
>> @@ -255,22 +256,24 @@ TRACE_EVENT(amdgpu_vm_bo_map,
>>                    ),
>>           TP_fast_assign(
>> +               __entry->vm = vm;
>>                  __entry->bo = bo_va ? bo_va->base.bo : NULL;
>>                  __entry->start = mapping->start;
>>                  __entry->last = mapping->last;
>>                  __entry->offset = mapping->offset;
>>                  __entry->flags = mapping->flags;
>>                  ),
>> -        TP_printk("bo=%p, start=%lx, last=%lx, offset=%010llx, 
>> flags=%llx",
>> -              __entry->bo, __entry->start, __entry->last,
>> +        TP_printk("vm=%p bo=%p, start=%lx, last=%lx, offset=%010llx, 
>> flags=%llx",
>> +              __entry->vm, __entry->bo, __entry->start, __entry->last,
>>                 __entry->offset, __entry->flags)
>>   );
>>   TRACE_EVENT(amdgpu_vm_bo_unmap,
>> -        TP_PROTO(struct amdgpu_bo_va *bo_va,
>> +        TP_PROTO(struct amdgpu_vm *vm, struct amdgpu_bo_va *bo_va,
>>                struct amdgpu_bo_va_mapping *mapping),
>> -        TP_ARGS(bo_va, mapping),
>> +        TP_ARGS(vm, bo_va, mapping),
>>           TP_STRUCT__entry(
>> +                 __field(struct amdgpu_vm *, vm)
>>                    __field(struct amdgpu_bo *, bo)
>>                    __field(long, start)
>>                    __field(long, last)
>> @@ -279,14 +282,15 @@ TRACE_EVENT(amdgpu_vm_bo_unmap,
>>                    ),
>>           TP_fast_assign(
>> +               __entry->vm = vm;
>>                  __entry->bo = bo_va ? bo_va->base.bo : NULL;
>>                  __entry->start = mapping->start;
>>                  __entry->last = mapping->last;
>>                  __entry->offset = mapping->offset;
>>                  __entry->flags = mapping->flags;
>>                  ),
>> -        TP_printk("bo=%p, start=%lx, last=%lx, offset=%010llx, 
>> flags=%llx",
>> -              __entry->bo, __entry->start, __entry->last,
>> +        TP_printk("vm=%p bo=%p, start=%lx, last=%lx, offset=%010llx, 
>> flags=%llx",
>> +              __entry->vm, __entry->bo, __entry->start, __entry->last,
>>                 __entry->offset, __entry->flags)
>>   );
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 3abfa66d72a2..e04928d2e26a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1642,7 +1642,7 @@ static void amdgpu_vm_bo_insert_map(struct 
>> amdgpu_device *adev,
>>       if (amdgpu_vm_is_bo_always_valid(vm, bo) && !bo_va->base.moved)
>>           amdgpu_vm_bo_moved(&bo_va->base);
>> -    trace_amdgpu_vm_bo_map(bo_va, mapping);
>> +    trace_amdgpu_vm_bo_map(vm, bo_va, mapping);
>>   }
>>   /* Validate operation parameters to prevent potential abuse */
>> @@ -1834,7 +1834,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
>>       list_del(&mapping->list);
>>       amdgpu_vm_it_remove(mapping, &vm->va);
>>       mapping->bo_va = NULL;
>> -    trace_amdgpu_vm_bo_unmap(bo_va, mapping);
>> +    trace_amdgpu_vm_bo_unmap(vm, bo_va, mapping);
>>       if (valid)
>>           list_add(&mapping->list, &vm->freed);
>> @@ -1929,7 +1929,7 @@ int amdgpu_vm_bo_clear_mappings(struct 
>> amdgpu_device *adev,
>>           tmp->bo_va = NULL;
>>           list_add(&tmp->list, &vm->freed);
>> -        trace_amdgpu_vm_bo_unmap(NULL, tmp);
>> +        trace_amdgpu_vm_bo_unmap(vm, NULL, tmp);
> 
> That bo_va is NULL here is probably a bug and should be fixed.

Would something like this work?

     trace_amdgpu_vm_bo_unmap(tmp->bo_va, tmp);
     tmp->bo_va = NULL;
     list_add(&tmp->list, &vm->freed);

Thanks,
Pierre-Eric


> 
> Regards,
> Christian.
> 
>>       }
>>       /* Insert partial mapping before the range */
>> @@ -2056,7 +2056,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>>           list_del(&mapping->list);
>>           amdgpu_vm_it_remove(mapping, &vm->va);
>>           mapping->bo_va = NULL;
>> -        trace_amdgpu_vm_bo_unmap(bo_va, mapping);
>> +        trace_amdgpu_vm_bo_unmap(vm, bo_va, mapping);
>>           list_add(&mapping->list, &vm->freed);
>>       }
>>       list_for_each_entry_safe(mapping, next, &bo_va->invalids, list) {
