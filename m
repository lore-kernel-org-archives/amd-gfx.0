Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B864C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jul 2024 09:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21FED10E536;
	Tue, 23 Jul 2024 09:48:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UzCiWAZ7";
	dkim-atps=neutral
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EEDF10E539
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jul 2024 09:48:23 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-52efd855adbso3689719e87.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jul 2024 02:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721728101; x=1722332901; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JW59qZFQgCC31wbEwUCtuQQuQBLlM6wWfVTdXY5t1+k=;
 b=UzCiWAZ7vMpU0wJeJUYebns22bPqYcr0qQK0OxYZ4g67r+6S+6O5iDNXjDu60nM1q0
 Q+kHj45P8aOOdAF6kT+V4HA7yGGiHF7hq4b8c1b9SSX3lnuXcvdrDuRmvPrYChhZEBUN
 NMeOmuyhlyHlyHSvbTig+JZQ+pge12m88NLGwAZ5xV1IvxORTmBh0tPw41JK0f5lLQPh
 b17CcWblHxLyUBZINf7LNnnJ7FPKGB/w6WXli8zTeEXS+ungLPPKbm0JJHz1ZWcuMFjn
 cgnNThZG0F5SD/mSoHPtzPW8/jygF6/eSz/RdykSE7RABaUJMsNqMxiPuOtHr8vF8LXv
 hmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721728101; x=1722332901;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JW59qZFQgCC31wbEwUCtuQQuQBLlM6wWfVTdXY5t1+k=;
 b=awtyfi3zuSBKMfyuzXNm9JhVE3TCCV8mtOgbrWvGIAliKTO13Ntb1m6ZBf0WBcJ7aY
 x7YOR83bPstm+QbHkKAJZsrfyYnlNST0EbyuZ67GL5o5s1ZcVG/G/RbLVIIgQhdKbXie
 YiGFuyo3XrhMQK8F1qct0YzUOnPivqzEuEhyOclPF4GznkFpuYo+UhEVdEmED2oHpszf
 O0GHAPQ6IcVSq1XPNVoikE5ZtXzbP0xAF//ckHyUKeqNMKQ6OISi6269irORNeOLV8Dn
 486wOWN+8GAnNlnTDj6gyAfBH8ZXADDHp8RHVtakmz3DUsR2rsvv/MRTh7o46vwyJ/qX
 1ohA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyDDWA/v8vJ7CBsP7KnZum8R+u2NyRgtTXg6U6ubxlM0Ckc+O5X/vWZ45XHotzHuaYZStY6/p+tnMEbj/cVtqUP8YfBYkwElPL2ZsWig==
X-Gm-Message-State: AOJu0YzZ4H9u7VuqcBWkaCKG/Cx/1NE1l64TWIpjwK7osiBqxkMljj/L
 tCVKqzBBJQJIi8uORmF5/Sbt/tc4pwW1MmmzAXXozPLzoOr5VEBu
X-Google-Smtp-Source: AGHT+IEFQmyNIW61txFcSeGVWUPGZtsOcAmUn9+5NHPHaFzolJrKw/obfpyIKm00uO/17HJWcRWI0A==
X-Received: by 2002:a05:6512:23a3:b0:52c:c032:538d with SMTP id
 2adb3069b0e04-52fc404b854mr1586764e87.27.1721728100363; 
 Tue, 23 Jul 2024 02:48:20 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68fa17csm166916785e9.2.2024.07.23.02.48.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 02:48:19 -0700 (PDT)
Message-ID: <ec978c23-b465-4315-88f9-eaddfb14c148@gmail.com>
Date: Tue, 23 Jul 2024 11:48:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: reset vm state machine after gpu
 reset(vram lost)
To: "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20240723030548.1283366-1-zhenguo.yin@amd.com>
 <5ceac529-39cd-4095-8193-e30932f37dac@gmail.com>
 <MW4PR12MB668323C00301AC048424BF43E9A92@MW4PR12MB6683.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <MW4PR12MB668323C00301AC048424BF43E9A92@MW4PR12MB6683.namprd12.prod.outlook.com>
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

Am 23.07.24 um 11:04 schrieb Yin, ZhenGuo (Chris):
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Christian
>
> I prepared this patch because we met a page fault after gpu reset in SRIOV triggered by quark.
> After investigation, I found that the page table did not get restored after gpu reset.
> I just tried to use vm_update_mode=0 to disable VM update by CPU, and this issue still exists.

CPU based page table updates are not supported under SRIOV.

>
> -[Christian] When VRAM is lost any submission using the VM entity will fail and so result in a new page table generation.
> I believe that you are referring this piece of code in function amdgpu_job_run():
>          /* Skip job if VRAM is lost and never resubmit gangs */
>          if (job->generation != amdgpu_vm_generation(adev, job->vm) ||
>              (job->job_run_counter && job->gang_submit))
>                  dma_fence_set_error(finished, -ECANCELED);
>
> I agree that the submission from the old ctx will be set as ECANCELED and be skipped.
> But if the application then creates a new ctx and submit a new job, both new_ctx->generation and new_job->generation will be initiated as the updated one.
>          ctx->generation = amdgpu_vm_generation(mgr->adev, &fpriv->vm);
>          (*job)->generation = amdgpu_vm_generation(adev, vm);
> And the job will be executed, hence there will be a page fault due to VRAM lost.
>
> Please correct me if I have some misunderstanding.
> I still can not see why any submission using the VM entity will fail due to VRAM lost.

Ah! My assumption was that you will also always have a VM page table job 
which would be canceled.

But that isn't the case, instead you have only a context which is 
re-created.

In that case the approach here is valid, but let me comment on the patch 
itself.

Regards,
Christian.

>
> Best,
> Zhenguo
> Cloud-GPU Core team, SRDC
>
> -----Original Message-----
> From: Christian König <ckoenig.leichtzumerken@gmail.com>
> Sent: Tuesday, July 23, 2024 3:13 PM
> To: Yin, ZhenGuo (Chris) <ZhenGuo.Yin@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian <Christian.Koenig@amd.com>
> Subject: Re: [PATCH v2] drm/amdgpu: reset vm state machine after gpu reset(vram lost)
>
> Am 23.07.24 um 05:05 schrieb ZhenGuo Yin:
>> [Why]
>> Page table of compute VM in the VRAM will lost after gpu reset.
>> VRAM won't be restored since compute VM has no shadows.
>>
>> [How]
>> Use higher 32-bit of vm->generation to record a vram_lost_counter.
>> Reset the VM state machine when vm->genertaion is not equal to
>> re-generation token.
>>
>> v2: Check vm->generation instead of calling drm_sched_entity_error in
>> amdgpu_vm_validate.
> I've just double checked the logic again and as far as I can see this patch here is still completely superfluous.
>
> When VRAM is lost any submission using the VM entity will fail and so result in a new page table generation.
>
> What isn't handled are CPU based page table updates, but for those we could potentially change the condition inside the CPU page tables code.
>
> Regards,
> Christian.
>
>> Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 11 +++++++----
>>    1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 3abfa66d72a2..9e2f84c166e7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -434,7 +434,7 @@ uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>        if (!vm)
>>                return result;
>>
>> -     result += vm->generation;
>> +     result += (vm->generation & 0xFFFFFFFF);
>>        /* Add one if the page tables will be re-generated on next CS */
>>        if (drm_sched_entity_error(&vm->delayed))
>>                ++result;
>> @@ -467,9 +467,12 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>        struct amdgpu_bo *shadow;
>>        struct amdgpu_bo *bo;
>>        int r;
>> +     uint32_t vram_lost_counter = atomic_read(&adev->vram_lost_counter);
>>
>> -     if (drm_sched_entity_error(&vm->delayed)) {
>> -             ++vm->generation;
>> +     if (vm->generation != amdgpu_vm_generation(adev, vm)) {
>> +             if (drm_sched_entity_error(&vm->delayed))
>> +                     ++vm->generation;
>> +             vm->generation = (u64)vram_lost_counter << 32 | (vm->generation &
>> +0xFFFFFFFF);
>>                amdgpu_vm_bo_reset_state_machine(vm);
>>                amdgpu_vm_fini_entities(vm);
>>                r = amdgpu_vm_init_entities(adev, vm); @@ -2439,7 +2442,7 @@ int
>> amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>        vm->last_update = dma_fence_get_stub();
>>        vm->last_unlocked = dma_fence_get_stub();
>>        vm->last_tlb_flush = dma_fence_get_stub();
>> -     vm->generation = 0;
>> +     vm->generation = (u64)atomic_read(&adev->vram_lost_counter) << 32;
>>
>>        mutex_init(&vm->eviction_lock);
>>        vm->evicting = false;

