Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D46C3DA59
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jul 2024 12:48:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF30710EC26;
	Fri, 19 Jul 2024 12:48:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L6U0Gxx8";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 898AC10EC26
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jul 2024 12:48:36 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4266edee10cso10679635e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jul 2024 05:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721393315; x=1721998115; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ur5V9PD370w0MDzuOYlg0ZPUlm7sBCn9wI5uzffl9VE=;
 b=L6U0Gxx8KhPcMvQACDM5y70ZwmX+/d7VfVagKaKRtnPAHThE+jj63/Nc5LiBf38QfM
 LTbHHC9fTZ+uIsOQTYMx0kN/pDr3mLy08ukIXbImBcrjlZ31CAoha0DaJ94BJ3O663X3
 wl+tbtdKP3apzOSukAlSmuyal/Utksn2fP/tqRGQp0JLJ+CxIh6zHAw5ET2il+MJOXAB
 EgJg89ZKPY7kdDz1yqlkqC8GW2umznAkR6N1FKeV/5WfiNAavGLpUxkZie1Zk5pckAtE
 03+XaGM1NOErbNO2Nmj/VFAhSK5X8OHVLHv4C+AasGK3BeZYQFH0MeTFSvMY31a4yWjr
 X/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721393315; x=1721998115;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ur5V9PD370w0MDzuOYlg0ZPUlm7sBCn9wI5uzffl9VE=;
 b=e/eBagWYZbk3ejJ6gstlGAJUD7ytNz64L1BVW2bvECyEApvbizmdVXsyRHWIdES4Qe
 ah/Ea/74YLiQ/uU2hGfHnV1plj4okbZX+NijRWWt0zX/+BFnHWd8F7bWV44zfECaqT1J
 XJyjo7pUZmp+R3arrXI3cZsQMPPka0i7uSwkvqhwsFgOYANIgV3jB837/uC55X0VtWVQ
 opc8d0+3WI7WTCAdRqi05Z6WoeuO5vJwCgmbUbRnP9zGGBvallWrJ894e9k8s2IR6nYw
 SRm8yry/7nEBSPYQm5CShKUrW9vF7jWsgTjbg4B3CKS2aS6jkP1PsDH3ILKQek8BvX7/
 5r4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX7+hRdeJ3QFMLHaco6OfzmBg7PkxuLIiuk4mWT7IcPdinllV3v1L1FJ817ORqwD6pHLInfGg4sPOWQIHZk+fuX36vu7l2A6xWMeqSsg==
X-Gm-Message-State: AOJu0YyOxcASGFQGG9FOfJiDiFnS8RodP8uTtb6n3hiIubshPLbqzKMx
 H0fjlx25AlxG0CiwSnIchaZIDTfFS6Foh5BjViULTvWBFXM/6yqSek3pO+XW
X-Google-Smtp-Source: AGHT+IEFKt1+HiI7ngn+cnTDOjSf3R8XjXiTxR0tM3ig4RASYsBNnHzOhRZVKtj4qrA62fDqzdJ9dQ==
X-Received: by 2002:a05:600c:1e1c:b0:426:61ef:ec36 with SMTP id
 5b1f17b1804b1-427d724281amr15010035e9.0.1721393314325; 
 Fri, 19 Jul 2024 05:48:34 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a6e91fsm50311025e9.23.2024.07.19.05.48.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jul 2024 05:48:33 -0700 (PDT)
Message-ID: <facfbba7-ac98-4c35-ba4b-a200f305709c@gmail.com>
Date: Fri, 19 Jul 2024 14:48:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: reset vm state machine after gpu reset(vram
 lost)
To: "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240719091921.1213270-1-zhenguo.yin@amd.com>
 <e9f270ef-aacd-4874-b401-e4871c990692@amd.com>
 <MW4PR12MB66832BAB6EA74EDC8556B440E9AD2@MW4PR12MB6683.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <MW4PR12MB66832BAB6EA74EDC8556B440E9AD2@MW4PR12MB6683.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Am 19.07.24 um 11:36 schrieb Yin, ZhenGuo (Chris):
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi, Christian
>
> Why loosing VRAM would result in the vm entity to become invalid?
>
> I think only if there has a fence error appeared(like a pending SDMA job got timedout or cancelled), then the entity vm->delayed will be set as error.
>
> If a gpu reset triggered by a GFX job, and there has no SDMA job in the pending list, the entity won't be set as error.

Good point.

We could potentially change the check in amdgpu_vm_validate() to check 
the VM generation instead of calling drm_sched_entity_error().

But what you do in this patch here absolutely doesn't make any sense at all.

Regards,
Christian.

>
> Best,
> Zhenguo
> Cloud-GPU Core team, SRDC
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Friday, July 19, 2024 5:22 PM
> To: Yin, ZhenGuo (Chris) <ZhenGuo.Yin@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: reset vm state machine after gpu reset(vram lost)
>
> Am 19.07.24 um 11:19 schrieb ZhenGuo Yin:
>> [Why]
>> Page table of compute VM in the VRAM will lost after gpu reset.
>> VRAM won't be restored since compute VM has no shadows.
>>
>> [How]
>> Use higher 32-bit of vm->generation to record a vram_lost_counter.
>> Reset the VM state machine when the counter is not equal to current
>> vram_lost_counter of the device.
> Mhm, that was my original approach as well but we came to the conclusion that this shouldn't be necessary since loosing VRAM would result in the entity to become invalid as well.
>
> Why is that necessary?
>
> Regards,
> Christian.
>
>> Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 10 ++++++++--
>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 3abfa66d72a2..fd7f912816dc 100644
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
>> @@ -467,6 +467,12 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>        struct amdgpu_bo *shadow;
>>        struct amdgpu_bo *bo;
>>        int r;
>> +     uint32_t vram_lost_counter = atomic_read(&adev->vram_lost_counter);
>> +
>> +     if ((vm->generation >> 32) != vram_lost_counter) {
>> +             amdgpu_vm_bo_reset_state_machine(vm);
>> +             vm->generation = (u64)vram_lost_counter << 32 | (vm->generation & 0xFFFFFFFF);
>> +     }
>>
>>        if (drm_sched_entity_error(&vm->delayed)) {
>>                ++vm->generation;
>> @@ -2439,7 +2445,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>        vm->last_update = dma_fence_get_stub();
>>        vm->last_unlocked = dma_fence_get_stub();
>>        vm->last_tlb_flush = dma_fence_get_stub();
>> -     vm->generation = 0;
>> +     vm->generation = (u64)atomic_read(&adev->vram_lost_counter) << 32;
>>
>>        mutex_init(&vm->eviction_lock);
>>        vm->evicting = false;

