Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB29C3DA64
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jul 2024 07:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBAA610E440;
	Tue, 23 Jul 2024 07:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NmOHjmxI";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72EFF10E440
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jul 2024 07:13:20 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4266fd395eeso36850495e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jul 2024 00:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721718799; x=1722323599; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BRaoS9R3+YQqkQYkE86eLCaWOiK+7SDj911EOPflRk4=;
 b=NmOHjmxIDu2PA0yXsD9vtPIKoRjsAU2Awmro7X0twNWtnfh1ZgtbQES/UBTFspptwV
 ApwhuqV9sTxxCwvUDYXezyBlqe8VLLhYGptywYHFK1y0QP9TNJUd0vo+azJ6WCn/1PQH
 4j6tx/RpKnw1La9bHp2N0GoPVksrAWwzU5xq8i2ZDtSJzaRscYaXW/XWVncuJ7nzjYnv
 qazjTUBEuEqVm9StW3S9xF2pAEia5QLqDM6ezAEIlsLQLR8DC4DhQqCkK17uL2ULJnGy
 99bzYqHlTD002qcq7mNg4xWyhPP/MTU22BCacwFvvGI0xKYqYO7qiMuj57GjF6DKAQ7f
 nH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721718799; x=1722323599;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BRaoS9R3+YQqkQYkE86eLCaWOiK+7SDj911EOPflRk4=;
 b=lVfh1VjKRLNHXFIPhfGk9fyK0rvpSMaoRUunJz34fW3DSlVegttz4wXxFA8bBjkfJz
 wARetkC6TUJsY7HtQQsa8P1CtnNwiM9Q9k8SzlxAyP+AECfJTquX97xi9dkahiJg0jQ4
 R78trLaYJtmrycvKcfBCLcrbPGtWkZeNUfQuarrSF9g19vjDiR56ckimDngMR2a4cpV6
 +Axy8Lbm8TgKywXM/V2CI3WIxKsyf01FT52iH+VgJcm4za6WEjksdDp42y3dZlL+gC4B
 P4d5bCUWX2A2RpIMd13fsHcRc71a/UzeqOhKw2tlcGx2WByRUsLAPtEnJRtOYf3HqJrp
 9mcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhTZAf0KO51IM5geI7YxLVut2skgNI2I0gRpwe6HZ62pZ9+j1/AXSPq5PrQErdvN395Jfi/wuBtpXXr5KlFCr5S5GqKxJBghyhwNCXQQ==
X-Gm-Message-State: AOJu0Yy+fzYUrVfziFdID7M5ztCvAj0sgy0Q6ZupaWDIZzHpspfU73l8
 363XJxi4oL3c/IxwTYOh2vgsckFuLr3A0AmDRzU2ussG0V8/biFj
X-Google-Smtp-Source: AGHT+IFN9nFdgdd3FTxw3zOo5OzEtwOn6QdDuzVM3q8BzKQIsw1l2aXY1wt2KpQzOc4kz47XuVJkvA==
X-Received: by 2002:a05:600c:4e0b:b0:426:6960:34b0 with SMTP id
 5b1f17b1804b1-427dc548427mr54849995e9.14.1721718798217; 
 Tue, 23 Jul 2024 00:13:18 -0700 (PDT)
Received: from [192.168.178.25] ([185.254.126.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a7218esm180128905e9.25.2024.07.23.00.13.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 00:13:17 -0700 (PDT)
Message-ID: <5ceac529-39cd-4095-8193-e30932f37dac@gmail.com>
Date: Tue, 23 Jul 2024 09:13:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: reset vm state machine after gpu
 reset(vram lost)
To: ZhenGuo Yin <zhenguo.yin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240723030548.1283366-1-zhenguo.yin@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: =?UTF-8?B?J0NocmlzdGlhbiBLw7ZuaWcn?= <christian.koenig@amd.com>
In-Reply-To: <20240723030548.1283366-1-zhenguo.yin@amd.com>
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

Am 23.07.24 um 05:05 schrieb ZhenGuo Yin:
> [Why]
> Page table of compute VM in the VRAM will lost after gpu reset.
> VRAM won't be restored since compute VM has no shadows.
>
> [How]
> Use higher 32-bit of vm->generation to record a vram_lost_counter.
> Reset the VM state machine when vm->genertaion is not equal to
> re-generation token.
>
> v2: Check vm->generation instead of calling drm_sched_entity_error
> in amdgpu_vm_validate.

I've just double checked the logic again and as far as I can see this 
patch here is still completely superfluous.

When VRAM is lost any submission using the VM entity will fail and so 
result in a new page table generation.

What isn't handled are CPU based page table updates, but for those we 
could potentially change the condition inside the CPU page tables code.

Regards,
Christian.

>
> Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3abfa66d72a2..9e2f84c166e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -434,7 +434,7 @@ uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	if (!vm)
>   		return result;
>   
> -	result += vm->generation;
> +	result += (vm->generation & 0xFFFFFFFF);
>   	/* Add one if the page tables will be re-generated on next CS */
>   	if (drm_sched_entity_error(&vm->delayed))
>   		++result;
> @@ -467,9 +467,12 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	struct amdgpu_bo *shadow;
>   	struct amdgpu_bo *bo;
>   	int r;
> +	uint32_t vram_lost_counter = atomic_read(&adev->vram_lost_counter);
>   
> -	if (drm_sched_entity_error(&vm->delayed)) {
> -		++vm->generation;
> +	if (vm->generation != amdgpu_vm_generation(adev, vm)) {
> +		if (drm_sched_entity_error(&vm->delayed))
> +			++vm->generation;
> +		vm->generation = (u64)vram_lost_counter << 32 | (vm->generation & 0xFFFFFFFF);
>   		amdgpu_vm_bo_reset_state_machine(vm);
>   		amdgpu_vm_fini_entities(vm);
>   		r = amdgpu_vm_init_entities(adev, vm);
> @@ -2439,7 +2442,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	vm->last_update = dma_fence_get_stub();
>   	vm->last_unlocked = dma_fence_get_stub();
>   	vm->last_tlb_flush = dma_fence_get_stub();
> -	vm->generation = 0;
> +	vm->generation = (u64)atomic_read(&adev->vram_lost_counter) << 32;
>   
>   	mutex_init(&vm->eviction_lock);
>   	vm->evicting = false;

