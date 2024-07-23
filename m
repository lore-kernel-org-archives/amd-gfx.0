Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901E0C3DA63
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jul 2024 09:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E949010E53B;
	Tue, 23 Jul 2024 09:51:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GyyTGeKo";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F5310E53B
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jul 2024 09:51:45 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-367990aaef3so2810964f8f.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jul 2024 02:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721728304; x=1722333104; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yMNXfxeP/9XznZQ1+Uws4ps6oPuRhlSqSPFGwQdIR2A=;
 b=GyyTGeKoy4GRwVeLrzEWYAdlslvk+Z0aFJczODWyaIMZPd1eZaBLbnMKTnFH4LgkF/
 Nnc4K6izMYNjxZuQ64oBZLXItoRHoIW8kulksm0iAS30NJpy9fNKLA6IKytZVDYxsbW4
 jNGHMRVmfeHp+E5jwIfjXryC+8kCwIYWtKTxHJzsx3h6x56+GNTk4+38JHoIssyc5RiK
 FlgbQXU8l0gFnt7djejmaWquVt/pWkprlxMDA4Wzkm7323ac3+QRdwsqPLDGg9PgHqk2
 Zf8ztRDswXMgSRZ08mDzo/082gr9ERKQNjAmCC9WPgnwFWcy946g807BbFhr/FeVfXho
 Qovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721728304; x=1722333104;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yMNXfxeP/9XznZQ1+Uws4ps6oPuRhlSqSPFGwQdIR2A=;
 b=WRqL5GqNVNOuDXAU+2OCynZYQFqHRn2GaqMX+XIknLp7EsK7IbGubANnHdMphT35OH
 TBGncdhXtZ48jBjubeiHCPYm5OO5QqZDmMO2d4SgtAz9ecu4b0P3WC+jrI7PM55DLKZa
 J1vuJHVBwwipE8rEVrzf4kQzjAIIBucx4UlWQvPS6awnOMj43fgtFhaeH/m1fY9/rR1R
 MnNfm5bFPCg3FgpYmhAf2LJeUJBmvYMw/gnpXjjqMARMP83mqyBVKkKbBwQIZq8H+ZAe
 DYWoPC7PeLTEhZ6MRW46LIIcKD/mA9WLzxaLQ/l+kwtQmMor9O0tovcL39QMwG65BMIC
 Fp5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJkZwcXsR7MUfeAiWteG7NkpLWNWjAQzwJpD4R4FbjLQAuzSccP8/l1vSOcVCBZ6DWW/7v3NVVVqF5kp+m+/1Z8RY9XA7LB3JyzmMamA==
X-Gm-Message-State: AOJu0YyHdJHeQs8+W5iM/Wz5cHj4wuQH6byuSVdNyQ2do4LiLSnXJxA0
 T2vjlCkA6gmkGEbmMWnG2GFx/goFz3Wxxt8AjDnQrAXtoZWwenkC
X-Google-Smtp-Source: AGHT+IFB3/dym9CH9Q7KlgZhgAeOBs4NuWf3Rle8bbIL8arrI2ZjNf130MOTUJHpWtRM8GkzkhTzvg==
X-Received: by 2002:a5d:42cd:0:b0:368:6b29:a551 with SMTP id
 ffacd0b85a97d-369debfe409mr1790813f8f.1.1721728303474; 
 Tue, 23 Jul 2024 02:51:43 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787cec60sm11012759f8f.79.2024.07.23.02.51.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 02:51:43 -0700 (PDT)
Message-ID: <819b0b26-f5cb-4928-aa25-f8a652c93ac5@gmail.com>
Date: Tue, 23 Jul 2024 11:51:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: reset vm state machine after gpu
 reset(vram lost)
To: ZhenGuo Yin <zhenguo.yin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com
References: <20240723030548.1283366-1-zhenguo.yin@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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

In general please sort the longer lines first.

And use amdgpu_vm_generation(adev, vm) here to get the new generation value.

>   
> -	if (drm_sched_entity_error(&vm->delayed)) {
> -		++vm->generation;
> +	if (vm->generation != amdgpu_vm_generation(adev, vm)) {
> +		if (drm_sched_entity_error(&vm->delayed))
> +			++vm->generation;
> +		vm->generation = (u64)vram_lost_counter << 32 | (vm->generation & 0xFFFFFFFF);

And then test and assign that new generation value here.

>   		amdgpu_vm_bo_reset_state_machine(vm);
>   		amdgpu_vm_fini_entities(vm);
>   		r = amdgpu_vm_init_entities(adev, vm);
> @@ -2439,7 +2442,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	vm->last_update = dma_fence_get_stub();
>   	vm->last_unlocked = dma_fence_get_stub();
>   	vm->last_tlb_flush = dma_fence_get_stub();
> -	vm->generation = 0;
> +	vm->generation = (u64)atomic_read(&adev->vram_lost_counter) << 32;

Use amdgpu_vm_generation(adev, NULL) to initialize this.

Regards,
Christian.

>   
>   	mutex_init(&vm->eviction_lock);
>   	vm->evicting = false;

