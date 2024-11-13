Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC63D462A6
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 14:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5BA210E708;
	Wed, 13 Nov 2024 14:04:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="edeDH+sF";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 650CF10E6C3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 10:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gq6Eayza14Hch8vY0yv4ho9QxzPHtdC8sA1sAkxvos0=; b=edeDH+sFZA2faR3c5o6zHCJA5M
 x8BOp6x7kqAIFYIepmilAalIwgU+Dw3xlqDBV8NnUP0/YRaCRtS7GPWMcP+i6ynxHgSba3cFgOuly
 zJpLPnZzosuTqC6sMTbF3E6k8pEc/caof1WhUgeS/AtBNSt0443Yf5a0RMXo6S4vGQX/wXdWh32ao
 HXPFi3oev8R2I8GhmWjnHYj0vQsHqHvhd3Ld/xOqgBN85GwWvEY8W94UEjcM90NHTbDzwemk5m/Ne
 4mVWj8q0xpJmpdJlQ2gttK+bQ/7phV2bonP8Rk4Gz88OTSIdtHyZ4S6x7bmJKbJLirEO2p9qsbemc
 GQZ7BHpw==;
Received: from [90.241.98.187] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1tBAYY-006Hq2-RB; Wed, 13 Nov 2024 11:25:02 +0100
Message-ID: <cc63f0ef-e152-49fc-90d9-ca695a8918f3@igalia.com>
Date: Wed, 13 Nov 2024 10:25:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/4] drm/amdgpu: track bo memory stats at runtime
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20241110154152.592-1-Yunxiang.Li@amd.com>
 <20241110154152.592-5-Yunxiang.Li@amd.com>
 <5d1c88a5-9802-4bb7-b76a-5e501847ced1@gmail.com>
 <SA1PR12MB85998D24DDB5EB93AE88E5A1ED592@SA1PR12MB8599.namprd12.prod.outlook.com>
 <92be210e-b552-45ee-9322-1944a4bfd325@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <92be210e-b552-45ee-9322-1944a4bfd325@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 Nov 2024 14:04:26 +0000
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


On 13/11/2024 08:49, Christian König wrote:
> Am 12.11.24 um 19:16 schrieb Li, Yunxiang (Teddy):
>> [Public]
>>
>>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>>> Sent: Tuesday, November 12, 2024 5:54
>>> Am 10.11.24 um 16:41 schrieb Yunxiang Li:
>>>> @@ -310,6 +311,92 @@ static void 
>>>> amdgpu_vm_bo_reset_state_machine(struct
>>> amdgpu_vm *vm)
>>>>      spin_unlock(&vm->status_lock);
>>>>    }
>>>>
>>>> +/**
>>>> + * amdgpu_vm_update_shared - helper to update shared memory stat
>>>> + * @base: base structure for tracking BO usage in a VM
>>>> + * @sign: if we should add (+1) or subtract (-1) from the shared stat
>>>> + *
>>>> + * Takes the vm status_lock and updates the shared memory stat. If
>>>> +the basic
>>>> + * stat changed (e.g. buffer was moved) amdgpu_vm_update_stats need
>>>> +to be called
>>>> + * as well.
>>>> + */
>>>> +static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base,
>>>> +int sign) {
>>>> +   struct amdgpu_vm *vm = base->vm;
>>>> +   struct amdgpu_bo *bo = base->bo;
>>>> +   struct ttm_resource *res;
>>>> +   int64_t size;
>>>> +   uint32_t type;
>>>> +
>>>> +   if (!vm || !bo)
>>>> +           return;
>>>> +
>>>> +   size = sign * amdgpu_bo_size(bo);
>>>> +   res = bo->tbo.resource;
>>>> +   type = res ? res->mem_type : amdgpu_bo_get_preferred_placement(bo);
>>> Again, it's a clear NAK from my side to do stuff like that.
>>>
>>> When there isn't any backing store the BO should *not* be accounted 
>>> to anything.
>> I don't have a preference either way, but I think it should be a 
>> separate discussion to properly define what drm-total- means.

Total must show the total size of all BOs which exist even if they don't 
currently have a backing store. That's how drm-usage-stats.rst defines 
the field and that is how all the other drivers work.

>>>> +   type = res ? res->mem_type : amdgpu_bo_get_preferred_placement(bo);
>>>> +   shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
>>>> +
>>>> +   if (type >= __AMDGPU_PL_LAST)
>>>> +           return;
>>>> +
>>>> +   spin_lock(&vm->status_lock);
>>>> +
>>>> +   if (shared)
>>>> +           vm->stats[type].drm.shared += size;
>>>> +   else
>>>> +           vm->stats[type].drm.private += size;
>>>> +   if (res)
>>>> +           vm->stats[type].drm.resident += size;
>>>> +   if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
>>>> +           vm->stats[type].drm.purgeable += size;
>>>> +
>>>> +   if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
>>>> +           vm->stats[TTM_PL_VRAM].requested += size;
>>>> +           if (type != TTM_PL_VRAM)
>>>> +                   vm->stats[TTM_PL_VRAM].evicted += size;
>>> Again that is incorrect. BOs can be created with VRAM|GTT as their 
>>> placement.
>>>
>>> If such a BO is placed into GTT that doesn't mean it is evicted.
>> In that case, do we count BO with VRAM|GTT in both VRAM and GTT's 
>> .requested field? and if they are not in either, they go in both 
>> .evicted field?
> 
> Oh, good question depends on the definition of the requested field.
> 
> Accounting it to VRAM.evicted while GTT placement is desirable as well 
> is certainly not correct.
> 
>  From my understanding they should go into the VRAM request, but not 
> account to evicted. But Tvrtko might see that differently.

Semantics of requested and evicted are kind of amdgpu 'legacy' thing. So 
the question is whether or not they should keep matching. Originally 
they were like this (I will edit out parts which deal with CPU visible 
for ease of comparison, and which have since been removed anyway):

        if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
                stats->requested_vram += size;
                if (res->mem_type != TTM_PL_VRAM)
                         stats->evicted_vram += size;
         } else if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_GTT) {
                stats->requested_gtt += size;
         }

So the part about accounting as evicted with dual preferred placement 
was there from the start.

Then after my changes:

         if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
                 stats[TTM_PL_VRAM].requested += size;
                 if (type != TTM_PL_VRAM) {
                         stats[TTM_PL_VRAM].evicted += size;
                 }
         } else if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_GTT) {
                 stats[TTM_PL_TT].requested += size;
         }

I mostly kept the same semantics.

Teddy's version keeps it the same:

	if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
		vm->stats[TTM_PL_VRAM].requested += size;
		if (type != TTM_PL_VRAM)
			vm->stats[TTM_PL_VRAM].evicted += size;
	} else if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_GTT) {
		vm->stats[TTM_PL_TT].requested += size;
	}

If no AMD tools depend on the legacy semantics for evicted/requested we 
can change them. There is some overlap with the standard keys anyway and 
the fact preferred mask is unordered made the original behaviour a bit 
presumptuous to begin with. In summary I think it depends on whether we 
need to keep the legacy semantics, or even the keys themselves.

Regards,

Tvrtko

>>>> @@ -2612,7 +2707,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev,
>>>> struct amdgpu_vm *vm)
>>>>
>>>>      root = amdgpu_bo_ref(vm->root.bo);
>>>>      amdgpu_bo_reserve(root, true);
>>>> -   amdgpu_vm_put_task_info(vm->task_info);
>>>>      amdgpu_vm_set_pasid(adev, vm, 0);
>>>>      dma_fence_wait(vm->last_unlocked, false);
>>>>      dma_fence_put(vm->last_unlocked);
>>>> @@ -2660,6 +2754,15 @@ void amdgpu_vm_fini(struct amdgpu_device *adev,
>>> struct amdgpu_vm *vm)
>>>>              }
>>>>      }
>>>>
>>>> +   if (!amdgpu_vm_stats_is_zero(vm)) {
>>>> +           struct amdgpu_task_info *ti = vm->task_info;
>>>> +
>>>> +           dev_warn(adev->dev,
>>>> +                    "VM memory stats for proc %s(%d) task %s(%d) is 
>>>> non-zero
>>> when fini\n",
>>>> +                    ti->process_name, ti->pid, ti->task_name, 
>>>> ti->tgid);
>>>> +   }
>>>> +
>>>> +   amdgpu_vm_put_task_info(vm->task_info);
>>> Please don't move the call to amdgpu_vm_put_task_info().
>> Is keeping the task_info alive a hazard here? I could copy out the 
>> info, it just seemed a bit wasteful.
> 
> Ah, now I see why you have moved that.
> 
> IIRC we need to free up the task info before releasing the PASID, but 
> that info might be outdated. Need to check the code.
> 
> Does it work if you move the message further up or does the root PD then 
> break your neck because it isn't released yet?
> 
> Thanks,
> Christian.
> 
>>
>> Regards,
>> Teddy
> 
