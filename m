Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E247C4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 12:29:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8F3C10E72B;
	Wed,  8 Nov 2023 12:29:04 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CD9210E72B
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 12:29:03 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4094301d505so50641785e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Nov 2023 04:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699446542; x=1700051342; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7Azcpfm0E6W8E9ufhxs9kFE2o1cvX4iPJFe7ZLcSKOo=;
 b=QG9yIAt9NPwMRuRBYF7CG7oXyRzOn03ub89nFHw6OUKwqjMv7ysuFfP+k1pZg2BV/f
 wu1u95QZSWkbsQMJEUovQRGB4kqJaBbAbZmBJ9dwds6tHoiaXrw66p3IKfMctn7+uKEP
 J+3bHZyOsnORnYOFDxFQ4PF+jL71aTMcU0I1sbPDvkc7o7Abs+vietA+6DGQvcYWKYCU
 xRgKVtfIfPS7fXbh1aFFNOvQBkutlbGNcZ98gFsbbg569vHRIFnT0dEFjNWbFgCRL0oj
 xAwUwRPJlWa59L8La5F+L1ATTsXY13v61lSSrqep0ESs1UIWU1pC/EaeLiPHvpktuTg6
 ks0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699446542; x=1700051342;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Azcpfm0E6W8E9ufhxs9kFE2o1cvX4iPJFe7ZLcSKOo=;
 b=WiwNtvcGmiGrCNKbpNdLpJmZ3Vef3SETBHHlsOVO3FFdWpUYI4y/8zW+FZr+RIYsFf
 TExS6/VMwFyYkgGH+oGVgDNE3Y0IuUHbtLRomESEYUuOrS050b04akihUKVUX0iawIPo
 dD5qAWgnE82jcT2+rjbgUxltn3/wS/uJ55xHohlg6emhs9AqDjD9zAvE0BM+qEoFd2dW
 YoyrgKv4NL1Zk1Jgr0WdbrkRjF4imI/HZNMWCUTYKGOI42cbaJIRY/zKxoOmHP5VLwnb
 4ocH4Bw2Q74LXmngLrPJZZ2PeNco/qwLA+2BOE3QlfGcs7x/H8c04zzOOnnRl13YT+wE
 yiWg==
X-Gm-Message-State: AOJu0YzSEua6vXHz09VO7UeukNK7bmdgeDlFGsHTnRK5LX0sP08CUtjK
 jkH3p3ytra8tL6LgJFBsSX78ZnTsnR865A==
X-Google-Smtp-Source: AGHT+IGly4QTHrAqh5+4+0bEyach/cjP2L7VaB77d1TzC+uS43qkLYQW3Bi0kJjNWCRF+ilMFKUfWQ==
X-Received: by 2002:a7b:c7d1:0:b0:408:4cf1:e9d7 with SMTP id
 z17-20020a7bc7d1000000b004084cf1e9d7mr1583306wmk.20.1699446541474; 
 Wed, 08 Nov 2023 04:29:01 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 q8-20020a05600c46c800b0040776008abdsm19071369wmo.40.2023.11.08.04.29.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 04:29:01 -0800 (PST)
Message-ID: <c3a50dd5-d621-46ac-8cd3-d1fa5bed30bd@gmail.com>
Date: Wed, 8 Nov 2023 13:28:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] drm/amdgpu: New VM state for evicted user BOs
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231107165814.3628510-1-Felix.Kuehling@amd.com>
 <20231107165814.3628510-2-Felix.Kuehling@amd.com>
 <8b63ff39-b1f2-4dc5-970c-29d96c63b18b@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <8b63ff39-b1f2-4dc5-970c-29d96c63b18b@amd.com>
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
Cc: xiaogang.chen@amd.com, ramesh.errabolu@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Not necessary objections to this patch here, but rather how this new 
state is used later on.

The fundamental problem is that re-validating things in 
amdgpu_vm_handle_moved() won't work in all cases.

The general approach for both classic CS IOCTL as well as user queues is 
the following:

1. Grab all the necessary locks
     The VM lock + either everything inside the VM (user queues) or just 
the BOs in the submission (CS IOCTL).

2. Validate everything locked
     It can be that additional BO locks are grabbed for eviction and 
even locked BOs are shuffled around during that.

3. Update the PDEs and PTEs
     This can be done only after validating everything because things 
can still shuffle around during validation.

4. Do your CS or make the userqueu / process runable etc...

5. Attach fences to the locked BOs.

6. Unlock everything again.

I think that is part of the problem why handling all updates in 
amdgpu_vm_handle_moved() for the CS doesn't work and sooner or later you 
might run into the same issue during process restore as well.

If I'm not completely mistaken this should be solvable by moving all 
validation to amdgpu_vm_validate_pt_bos() instead (but let us rename 
that function).

Regards,
Christian.

Am 07.11.23 um 23:11 schrieb Felix Kuehling:
> Hi Christian,
>
> I know you have objected to this patch before. I still think this is 
> the best solution for what I need. I can talk you through my reasoning 
> by email or offline. If I can't convince you, I will need your 
> guidance for a better solution.
>
> Thanks,
>   Felix
>
>
> On 2023-11-07 11:58, Felix Kuehling wrote:
>> Create a new VM state to track user BOs that are in the system domain.
>> In the next patch this will be used do conditionally re-validate them in
>> amdgpu_vm_handle_moved.
>>
>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 +++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  5 ++++-
>>   2 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 1442d97ddd0f..0d685577243c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -232,6 +232,22 @@ static void amdgpu_vm_bo_invalidated(struct 
>> amdgpu_vm_bo_base *vm_bo)
>>       spin_unlock(&vm_bo->vm->status_lock);
>>   }
>>   +/**
>> + * amdgpu_vm_bo_evicted_user - vm_bo is evicted
>> + *
>> + * @vm_bo: vm_bo which is evicted
>> + *
>> + * State for BOs used by user mode queues which are not at the 
>> location they
>> + * should be.
>> + */
>> +static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
>> +{
>> +    vm_bo->moved = true;
>> +    spin_lock(&vm_bo->vm->status_lock);
>> +    list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
>> +    spin_unlock(&vm_bo->vm->status_lock);
>> +}
>> +
>>   /**
>>    * amdgpu_vm_bo_relocated - vm_bo is reloacted
>>    *
>> @@ -2110,6 +2126,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, 
>> struct amdgpu_vm *vm, int32_t xcp
>>       for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
>>           vm->reserved_vmid[i] = NULL;
>>       INIT_LIST_HEAD(&vm->evicted);
>> +    INIT_LIST_HEAD(&vm->evicted_user);
>>       INIT_LIST_HEAD(&vm->relocated);
>>       INIT_LIST_HEAD(&vm->moved);
>>       INIT_LIST_HEAD(&vm->idle);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 12cac06fa289..939d0c2219c0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -286,9 +286,12 @@ struct amdgpu_vm {
>>       /* Lock to protect vm_bo add/del/move on all lists of vm */
>>       spinlock_t        status_lock;
>>   -    /* BOs who needs a validation */
>> +    /* Per VM and PT BOs who needs a validation */
>>       struct list_head    evicted;
>>   +    /* BOs for user mode queues that need a validation */
>> +    struct list_head    evicted_user;
>> +
>>       /* PT BOs which relocated and their parent need an update */
>>       struct list_head    relocated;

