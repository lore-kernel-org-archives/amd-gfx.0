Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2584EC25B75
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 14:12:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 571298876A;
	Mon,  3 Jun 2024 14:12:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xc0wuMSC";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC4D410E03E
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 14:12:34 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4213485697fso19117275e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Jun 2024 07:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717423953; x=1718028753; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UkK+eF5Q/NqH60Bf5kH/gsval1BEoBZi8NNQ23naJ60=;
 b=Xc0wuMSCSyuU0FtwUls+Rt86xfVtabShXlcjayfndy9PLSVFLAvbBDmBNFwCIGvtgc
 C1SGtd3oKJjf5Gqq+4mqF239AIYpnNGN33oPO1l428DoD8Hf4ArxVXciI2m40naGbjMb
 cc2o78YUrxj7QYM7RmzCAf0b0yl8tGawJfZnZmbQRdVhdwWKOcd/fN3whQkQ1zYE2hiW
 Nd+g6Krev9Y0H7CjSANE3TrCgNuxNE9MIhjnOKbn7QSPboAz4E+nGIOhl4Shpa9ueKKU
 2C8w3oZtAInn9viA5AKlHt8VVOrmI2OKE0QYpFGHHlScMfy8yVUYG04N2ME9sqEc4s77
 p6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717423953; x=1718028753;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UkK+eF5Q/NqH60Bf5kH/gsval1BEoBZi8NNQ23naJ60=;
 b=H2AI+teRsFcXptNvOSR0nA0Say0Ovuc1PQi7QtIoEd8hdUyJC7DtJeTjO2SlH8DOMu
 WGe9D2BZ1Uk3njmdS2NFYwoMWt3p1/OEHKNucTOLv6ezZqwXrqeg/V7huKVOnJyd193M
 L0vZjzk80Q7xeLVV8omp4P9Eg/fy/eaTVtBzlkIQMi+0BMHFZ1+pnEJ5NgYc4iZ8ki2s
 SdPRzwLtHYp4qTFJDWrMCe7nnwrugvaQLUFWNR4jc0zczDNLFPl2Olf6XAK2t+NQnMnS
 qSJd0EKcI7Xp0sKbpZBDe8TE9c9veqDoM1M5PtYTuMEBcsqB8ANPUVkXhxNgP1F3rWew
 BY+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKCXDklJ5L7StoQSVKDd6hYsr4Qpbbpp5mMKVTB79CrGY3YgQg2X9t/UweKkDDGqKQrWzjT5GER4hWZY18JqNH7JJYAjMp+KRnlp+FnA==
X-Gm-Message-State: AOJu0YzO0WOmZJ0d6vWCPpXtDYHVHpB7SwZbNK/S0l2WVpYgxc/Tic8L
 dw003V7t1IpdSjpbH7BeXYwszOFgfrmuDmZD4vAuiO64VWy0lES+
X-Google-Smtp-Source: AGHT+IHnJtFrQB4EoY1WweDH0c7LEmjGx/h9x8qDzOP/QBx3TtffvtFbabBxappCqsdQVcvW3CWAWQ==
X-Received: by 2002:a05:600c:a04:b0:421:1f68:f80c with SMTP id
 5b1f17b1804b1-4212e0a537bmr78396285e9.25.1717423952944; 
 Mon, 03 Jun 2024 07:12:32 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42138ec47eesm64597695e9.23.2024.06.03.07.12.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 07:12:32 -0700 (PDT)
Message-ID: <4e1ae4fb-472a-40a6-a26d-7f9aff709057@gmail.com>
Date: Mon, 3 Jun 2024 16:12:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] amdgpu: add the amdgpu_vm ptr in the vm_bo_map/unmap
 events
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20240603084729.15135-1-pierre-eric.pelloux-prayer@amd.com>
 <beb3e657-3834-4c80-b854-cdb5ba4ca534@amd.com>
 <011928f3-ae86-4506-a9a5-1ced96032f34@damsy.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <011928f3-ae86-4506-a9a5-1ced96032f34@damsy.net>
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

Am 03.06.24 um 13:52 schrieb Pierre-Eric Pelloux-Prayer:
> Hi Christia,
>
> Le 03/06/2024 à 11:58, Christian König a écrit :
>> Am 03.06.24 um 10:46 schrieb Pierre-Eric Pelloux-Prayer:
>>> These 2 traces events are tied to a specific VM so in order for them
>>> to be useful for a tool we need to trace the amdgpu_vm as well.
>>
>> The bo_va already contains the VM pointer the map/unmap operation 
>> belongs to.
>>
>
> Indeed, I've missed that. I'll fix that in v2.
>
>>>
>>> Signed-off-by: Pierre-Eric Pelloux-Prayer 
>>> <pierre-eric.pelloux-prayer@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 20 ++++++++++++--------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  8 ++++----
>>>   2 files changed, 16 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> index f539b1d00234..c84050d318d6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> @@ -243,10 +243,11 @@ TRACE_EVENT(amdgpu_vm_grab_id,
>>>   );
>>>   TRACE_EVENT(amdgpu_vm_bo_map,
>>> -        TP_PROTO(struct amdgpu_bo_va *bo_va,
>>> +        TP_PROTO(struct amdgpu_vm *vm, struct amdgpu_bo_va *bo_va,
>>>                struct amdgpu_bo_va_mapping *mapping),
>>> -        TP_ARGS(bo_va, mapping),
>>> +        TP_ARGS(vm, bo_va, mapping),
>>>           TP_STRUCT__entry(
>>> +                 __field(struct amdgpu_vm *, vm)
>>>                    __field(struct amdgpu_bo *, bo)
>>>                    __field(long, start)
>>>                    __field(long, last)
>>> @@ -255,22 +256,24 @@ TRACE_EVENT(amdgpu_vm_bo_map,
>>>                    ),
>>>           TP_fast_assign(
>>> +               __entry->vm = vm;
>>>                  __entry->bo = bo_va ? bo_va->base.bo : NULL;
>>>                  __entry->start = mapping->start;
>>>                  __entry->last = mapping->last;
>>>                  __entry->offset = mapping->offset;
>>>                  __entry->flags = mapping->flags;
>>>                  ),
>>> -        TP_printk("bo=%p, start=%lx, last=%lx, offset=%010llx, 
>>> flags=%llx",
>>> -              __entry->bo, __entry->start, __entry->last,
>>> +        TP_printk("vm=%p bo=%p, start=%lx, last=%lx, 
>>> offset=%010llx, flags=%llx",
>>> +              __entry->vm, __entry->bo, __entry->start, __entry->last,
>>>                 __entry->offset, __entry->flags)
>>>   );
>>>   TRACE_EVENT(amdgpu_vm_bo_unmap,
>>> -        TP_PROTO(struct amdgpu_bo_va *bo_va,
>>> +        TP_PROTO(struct amdgpu_vm *vm, struct amdgpu_bo_va *bo_va,
>>>                struct amdgpu_bo_va_mapping *mapping),
>>> -        TP_ARGS(bo_va, mapping),
>>> +        TP_ARGS(vm, bo_va, mapping),
>>>           TP_STRUCT__entry(
>>> +                 __field(struct amdgpu_vm *, vm)
>>>                    __field(struct amdgpu_bo *, bo)
>>>                    __field(long, start)
>>>                    __field(long, last)
>>> @@ -279,14 +282,15 @@ TRACE_EVENT(amdgpu_vm_bo_unmap,
>>>                    ),
>>>           TP_fast_assign(
>>> +               __entry->vm = vm;
>>>                  __entry->bo = bo_va ? bo_va->base.bo : NULL;
>>>                  __entry->start = mapping->start;
>>>                  __entry->last = mapping->last;
>>>                  __entry->offset = mapping->offset;
>>>                  __entry->flags = mapping->flags;
>>>                  ),
>>> -        TP_printk("bo=%p, start=%lx, last=%lx, offset=%010llx, 
>>> flags=%llx",
>>> -              __entry->bo, __entry->start, __entry->last,
>>> +        TP_printk("vm=%p bo=%p, start=%lx, last=%lx, 
>>> offset=%010llx, flags=%llx",
>>> +              __entry->vm, __entry->bo, __entry->start, __entry->last,
>>>                 __entry->offset, __entry->flags)
>>>   );
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 3abfa66d72a2..e04928d2e26a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -1642,7 +1642,7 @@ static void amdgpu_vm_bo_insert_map(struct 
>>> amdgpu_device *adev,
>>>       if (amdgpu_vm_is_bo_always_valid(vm, bo) && !bo_va->base.moved)
>>>           amdgpu_vm_bo_moved(&bo_va->base);
>>> -    trace_amdgpu_vm_bo_map(bo_va, mapping);
>>> +    trace_amdgpu_vm_bo_map(vm, bo_va, mapping);
>>>   }
>>>   /* Validate operation parameters to prevent potential abuse */
>>> @@ -1834,7 +1834,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device 
>>> *adev,
>>>       list_del(&mapping->list);
>>>       amdgpu_vm_it_remove(mapping, &vm->va);
>>>       mapping->bo_va = NULL;
>>> -    trace_amdgpu_vm_bo_unmap(bo_va, mapping);
>>> +    trace_amdgpu_vm_bo_unmap(vm, bo_va, mapping);
>>>       if (valid)
>>>           list_add(&mapping->list, &vm->freed);
>>> @@ -1929,7 +1929,7 @@ int amdgpu_vm_bo_clear_mappings(struct 
>>> amdgpu_device *adev,
>>>           tmp->bo_va = NULL;
>>>           list_add(&tmp->list, &vm->freed);
>>> -        trace_amdgpu_vm_bo_unmap(NULL, tmp);
>>> +        trace_amdgpu_vm_bo_unmap(vm, NULL, tmp);
>>
>> That bo_va is NULL here is probably a bug and should be fixed.
>
> Would something like this work?
>
>     trace_amdgpu_vm_bo_unmap(tmp->bo_va, tmp);
>     tmp->bo_va = NULL;
>     list_add(&tmp->list, &vm->freed);

It's not 100% accurate because only parts of the mapping is unmapped, 
but yes I think that should work.

Regards,
Christian.

>
> Thanks,
> Pierre-Eric
>
>
>>
>> Regards,
>> Christian.
>>
>>>       }
>>>       /* Insert partial mapping before the range */
>>> @@ -2056,7 +2056,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>>>           list_del(&mapping->list);
>>>           amdgpu_vm_it_remove(mapping, &vm->va);
>>>           mapping->bo_va = NULL;
>>> -        trace_amdgpu_vm_bo_unmap(bo_va, mapping);
>>> +        trace_amdgpu_vm_bo_unmap(vm, bo_va, mapping);
>>>           list_add(&mapping->list, &vm->freed);
>>>       }
>>>       list_for_each_entry_safe(mapping, next, &bo_va->invalids, list) {

