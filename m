Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B010C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 17:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A8F110E1C9;
	Thu,  8 Dec 2022 17:39:12 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D121C10E1CE
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Dec 2022 17:39:04 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id c17so2757769edj.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Dec 2022 09:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d+a9kHqiOx304/89Cuq+vt8BgMxqqkJqtY7YY0a7drs=;
 b=dK+uPzNMvd9sdwRK6Bd4HrqozV8B53HeTUQljshI15wJC/ElD3jIgc99Ce6iqmmGt1
 1G23OdRAwnVp91cJmRdVjLTdXN7jPMgASz3xfjYbRIG+SidA9ED78U6Lbcm2B+qyrUhT
 BSUd430FwtP6+ULC6ANubs6yT3b5R2pcGjMtwn9PMwNFwEn7ShhvKMBt/mF6JW+fIxbr
 NKoE9YiNyLn8qsg/iB+pic5ktMDULaSMg0eLiajZQ0uFnpqBbQo3hirwmo+tqe2kBY/Z
 UHkCSqfauplm/Mf1YwmPGjlCGZCJpCDAL8MuU2P6iYPRUDjhuEWM4Rb0RDaORWVIL/WP
 h+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d+a9kHqiOx304/89Cuq+vt8BgMxqqkJqtY7YY0a7drs=;
 b=uoyfx/l3QdwCGsQwDJkM+0zCYAoLHvizNfiYe3QLEqueOKTWpW2KuEEWTzTiYc52eM
 LWBnsKFlG5JwZZzj27HykCkzzgZRTpM2zl+eoG9AKiQqNrGeaDsvDB9ZyMSkW25RGtOr
 S/H9lSRrdQz7cSJUCv9MxP3vF+JeqmzCEiofJ+wk9fAGUAk2rgai91VRlDgdRO6xj7zM
 kYHyMs/roZ72rpRCuOVyi7ZTUge0LTaxrBPvT5gIIaKvLFHa9dt8izFl7at/w9WXlO0B
 VknG58KlnfhDl/h3ZLrJgp6btnQdUVzU1V2p56C3krXCnnNykXWqwd60uU8xyfPjVZSa
 Kvzw==
X-Gm-Message-State: ANoB5plDKFFDPVVJcKL8E7/036tu7p7Dv1XYu+LQLMfFRiJayW1THAEp
 ScY2Jg1GLrYiDJLOZvnGiFg=
X-Google-Smtp-Source: AA0mqf5j7sxF3k0pUtj+kgiLpYLFUa3d8wxwrxuClZFPooBdG1Tcy60+4kP7pm3HBYk41g5rw1B2hQ==
X-Received: by 2002:a05:6402:4507:b0:467:205b:723d with SMTP id
 ez7-20020a056402450700b00467205b723dmr4758782edb.69.1670521142667; 
 Thu, 08 Dec 2022 09:39:02 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:172d:b6f5:d270:8dd2?
 ([2a02:908:1256:79a0:172d:b6f5:d270:8dd2])
 by smtp.gmail.com with ESMTPSA id
 v18-20020a170906293200b007b9269a0423sm10002385ejd.172.2022.12.08.09.39.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Dec 2022 09:39:02 -0800 (PST)
Message-ID: <26c430bb-5de9-2306-5ba3-45482c8dc44f@gmail.com>
Date: Thu, 8 Dec 2022 18:39:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Another circular lock dependency involving fs-reclaim and
 drm_buddy
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <5fb7e577-e17e-c791-c107-2424b80ea853@amd.com>
 <eb075cb2-1649-e149-6f53-c86a30f9fffd@amd.com>
 <ee07b373-9de2-faac-320c-ee7b15048cd9@amd.com>
 <dd4979da-6abd-ba02-8840-d59b78a3020d@amd.com>
 <917226e7-9e62-9cda-9f9b-eff4ce5a90c0@amd.com>
 <2df5f87e-fbf4-2364-fab6-7e3dbd4e5361@amd.com>
 <7064f6ad-f180-0514-7ca4-0e240142bc28@amd.com>
 <cff19c5c-3c2a-33ab-043e-5d4836613669@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <cff19c5c-3c2a-33ab-043e-5d4836613669@amd.com>
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

Am 08.12.22 um 17:28 schrieb Felix Kuehling:
> Am 2022-12-08 um 10:44 schrieb Christian König:
>> Am 08.12.22 um 16:19 schrieb Felix Kuehling:
>>> Am 2022-12-08 um 07:32 schrieb Christian König:
>>>> Hi Felix,
>>>>
>>>> digging though the code I think I know now how we can solve this.
>>>>
>>>> The lock which needs to protect the validity of the pages is the 
>>>> vm->eviction_lock, cause this one is what serializes the updates of 
>>>> our page table.
>>>>
>>>> This means that the amdgpu_vm_update_range() function needs to be 
>>>> extended further with enough information to check the HMM sequence 
>>>> after grabbing the eviction lock.
>>>
>>> I don't see how taking one more lock helps resolve a lock dependency 
>>> issue. Right now the vm->eviction lock is not in the dependency 
>>> cycle at all.
>>>
>>> Do you mean we should use the vm->eviction lock instead of the 
>>> prange->lock to serialize page table updates with MMU notifiers?
>>
>> Exactly that, yes.
>>
>>> I don't see how that solves the problem either. It just changes the 
>>> lock that's involved in the cycle here. And it contradicts the 
>>> previous change made by Philip, who removet vm->eviction lock from 
>>> the cycle by dropping it just before potentially allocating page 
>>> tables.
>>
>> Yeah, and that change solves our issue.
>>
>>>
>>> The fundamental problem, as I understand it, is that we need to hold 
>>> the same lock in the MMU notifier and while updating page tables.
>>
>> No, that's what I meant initially. This is the wrong way to see it.
>>
>> What we need is a lock which serializes page tables updates and at 
>> the same time is independent of allocating page tables.
>>
>> After taking this lock we need to validate the addresses we want to 
>> write into the page tables before doing so.
>>
>> So the resulting sequence for validation should be:
>>
>> seq = mmu_interval_read_begin();
>> hmm_range_fault(pages);
>> amdgpu_vm_update_range(... pages, seq...)
>> {
>>     ....
>>     amdgpu_vm_eviction_lock();
>>     if (mmu_interval_read_retry(seq))
>>         return -EAGAIN;
>>     ...
>>     amdgpu_vm_pt_alloc()
>>     {
>>         amdgpu_vm_eviction_unlock();
>>         ....
>>         amdgpu_vm_eviction_lock();
>>         if (mmu_interval_read_retry(seq);
>>             return -EAGAIN;
>>     }
>>     amdgpu_vm_eviction_unlock();
>> }
>>
>>
>> That's the only way I can see how we can actually make this work.
>
> OK. I think that's a good way to move the memory allocation out of the 
> critical section. And it also makes the critical section smaller. One 
> potential problematic issue is, that we can make multiple calls to 
> amdgpu_vm_update_range for one hmm_range when some pages are in 
> different locations (system memory or VRAM). We'd have to separate the 
> mmu_interval_read_retry from freeing the hmm_range, which is currently 
> done together in amdgpu_hmm_range_get_pages_done.

Well never said that this would be easy. It just seems to be the most 
doable solution.

>
> I'd have to think through any other locking implications to our MMU 
> notifier and other places that need to serialize with MMU notifiers. 
> We may not be able to use the vm->eviction lock everywhere. We'll 
> probably still want to take prange->lock in our MMU notifier.

You need the prange->lock for the state management of the prange object, 
but that should essentially be separated from the PTEs.

But I would go as far as saying that with recoverable page faults we 
don't need the status in the range any more.

We just update the PTEs based on the invalidation requests and page 
faults. The range would then just be used to check the validity of page 
faults.

> Another alternative would be to pass the lock into 
> amdgpu_vm_update_range as a parameter. This would allow for more 
> fine-grained locking per range, rather than per-VM.

And I'm pretty sure exactly that won't work. We need to serialize all 
PTE updates, otherwise you end up in hell again when you free a range 
and immediately allocate a new one at the same location.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> Regards,
>> Christian.
>>
>>
>>> That makes it difficult to allocate memory during page table updates 
>>> because we cannot allow reclaim. Any lock taken during memory 
>>> allocation gets drawn into the cycle, in this case the 
>>> vram_mgr->lock. Unless we find a way to move page table allocation 
>>> out of that critical section, we can never do reclaim while holding 
>>> vram_mgr->lock.
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>>
>>>> Or am I missing something here?
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>> Am 06.12.22 um 16:57 schrieb Christian König:
>>>>> Am 06.12.22 um 16:14 schrieb Felix Kuehling:
>>>>>> Am 2022-12-06 um 03:20 schrieb Christian König:
>>>>>>> Hi Felix,
>>>>>>>
>>>>>>> to be honest I think the whole approach you take here and 
>>>>>>> unmapping the range with the lock held is highly problematic.
>>>>>>>
>>>>>>> Essentially unmapping is something which can run concurrently 
>>>>>>> with other operations and should never be blocked by such a 
>>>>>>> lock. In other words it is perfectly valid for an unmap to run 
>>>>>>> while another processor tries to map the same range.
>>>>>>
>>>>>> I strongly disagree. When an MMU notifier invalidates a virtual 
>>>>>> address range, it must guarantee that the device will not access 
>>>>>> the current physical location of the invalidated range any more. 
>>>>>> Without the lock, another processor could easily overwrite the 
>>>>>> invalidated PTEs with valid (but outdated) addresses that the MMU 
>>>>>> notifier just removed.
>>>>>>
>>>>>> This is the relevant paragraph in the HMM doc:
>>>>>>
>>>>>>    [example of driver updating its page table ...]
>>>>>>           take_lock(driver->update);
>>>>>>           if (mmu_interval_read_retry(&ni, range.notifier_seq) {
>>>>>>               release_lock(driver->update);
>>>>>>               goto again;
>>>>>>           }
>>>>>>
>>>>>>           /* Use pfns array content to update device page table,
>>>>>>            * under the update lock */
>>>>>>
>>>>>>           release_lock(driver->update);
>>>>>>           return 0;
>>>>>>      }
>>>>>>
>>>>>>    The driver->update lock is the same lock that the driver takes
>>>>>>    inside its
>>>>>>    invalidate() callback. That lock must be held before calling
>>>>>>    mmu_interval_read_retry() to avoid any race with a concurrent CPU
>>>>>>    page table
>>>>>>    update.
>>>>>
>>>>>
>>>>> There is something massively missing here since that won't work at 
>>>>> all.
>>>>>
>>>>> The problem is that we can't allocate memory nor fault pages while 
>>>>> any lock is held which is also held inside the invalidation 
>>>>> callback of the MMU notifier.
>>>>>
>>>>> Updating the PTEs will always need memory, e.g. we can't guarantee 
>>>>> that we won't allocate page tables. Otherwise dynamic allocating 
>>>>> tables won't work any more.
>>>>>
>>>>>>>
>>>>>>> That's why the same page fault can occur multiple times until 
>>>>>>> the page tables are up to date.
>>>>>>>
>>>>>>> When you get an MMU notification that range A->B is invalidated 
>>>>>>> you trigger invalidation of range A->B inside the GPUVM address 
>>>>>>> space as well and that's completely independent what's mapped 
>>>>>>> there.
>>>>>>
>>>>>> Not exactly. Because we're in a shared virtual address space, we 
>>>>>> know exactly what's mapped there.
>>>>>
>>>>> Yeah, but that's irrelevant. We are not allowed to use this 
>>>>> information, cause otherwise we run exactly into the described 
>>>>> issues again.
>>>>>
>>>>>> If the MMU notifier invalidates it, we have to coordinate with it 
>>>>>> to make sure we don't write incorrect addresses into those PTEs. 
>>>>>> In the example above, holding the lock guarantees that a 
>>>>>> concurrent MMU notifier will not return until after it has 
>>>>>> overwritten the PTEs we just updated. Alternatively 
>>>>>> mmu_interval_read_retry fails, which means the MMU notifier got 
>>>>>> there first and we have to get updated addresses with 
>>>>>> hmm_range_fault. Either way, the page table ends up with PTEs 
>>>>>> with V=0 before the MMU notifier returns.
>>>>>>
>>>>>> Without holding the lock while writing the page table, we could 
>>>>>> end up with a mix of valid (V=1, but outdated address) and 
>>>>>> invalid PTEs when there is a concurrent validation and 
>>>>>> invalidation of the same virtual address range.
>>>>>
>>>>> Yeah, I see the problem now as well. But I can't come up with any 
>>>>> way to solve this.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>>   Felix
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> Invalidating the mappings and eventually scheduling that they 
>>>>>>> are re-created is a separate step which should come independent 
>>>>>>> of this if I'm not completely mistaken.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>> Am 06.12.22 um 01:04 schrieb Felix Kuehling:
>>>>>>>> We fixed a similar issue with Philip's patch "drm/amdgpu: Drop 
>>>>>>>> eviction lock when allocating PT BO", but there was another one 
>>>>>>>> hiding underneath that (see the log below). The problem is, 
>>>>>>>> that we're still allocating page tables while holding the 
>>>>>>>> prange->lock in the kfd_svm code, which is also held in MMU 
>>>>>>>> notifiers. This creates a lock dependency between the 
>>>>>>>> vram_mgr->lock and fs-reclaim.
>>>>>>>>
>>>>>>>> There are three ways around this:
>>>>>>>>
>>>>>>>>  * Do the page table mapping outside prange->lock (creates a race,
>>>>>>>>    contradicts advice in Documentation/vm/hmm.rst)
>>>>>>>>  * Avoid all page table allocation in amdgpu_vm_update_range (i.e.
>>>>>>>>    allocate page tables ahead of time somehow)
>>>>>>>>  * Wrap vram_mgr->lock with memalloc_noreclaim_save/restore 
>>>>>>>> (may cause
>>>>>>>>    memory allocations to fail in drm_buddy under memory pressure)
>>>>>>>>
>>>>>>>> I only mention the first one for completeness. It's not a valid 
>>>>>>>> solution. Neither of the remaining two options are particularly 
>>>>>>>> appealing either.
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>>   Felix
>>>>>>>>
>>>>>>>>
>>>>>>>> [   83.979486] 
>>>>>>>> ======================================================
>>>>>>>> [   83.986583] WARNING: possible circular locking dependency 
>>>>>>>> detected
>>>>>>>> [   83.993643] 5.19.0-kfd-fkuehlin #75 Not tainted
>>>>>>>> [   83.999044] 
>>>>>>>> ------------------------------------------------------
>>>>>>>> [   84.006088] kfdtest/3453 is trying to acquire lock:
>>>>>>>> [   84.011820] ffff9a998561e210 (&prange->lock){+.+.}-{3:3}, 
>>>>>>>> at: svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
>>>>>>>> [   84.023911]
>>>>>>>>                but task is already holding lock:
>>>>>>>> [   84.031608] ffffffffbcd929c0 
>>>>>>>> (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: 
>>>>>>>> unmap_vmas+0x5/0x170
>>>>>>>> [   84.041992]
>>>>>>>>                which lock already depends on the new lock.
>>>>>>>>
>>>>>>>> [   84.052785]
>>>>>>>>                the existing dependency chain (in reverse order) 
>>>>>>>> is:
>>>>>>>> [   84.061993]
>>>>>>>>                -> #3 
>>>>>>>> (mmu_notifier_invalidate_range_start){+.+.}-{0:0}:
>>>>>>>> [   84.071548]        fs_reclaim_acquire+0x6d/0xd0
>>>>>>>> [   84.076941] kmem_cache_alloc_trace+0x34/0x760
>>>>>>>> [   84.082766] alloc_workqueue_attrs+0x1b/0x50
>>>>>>>> [   84.088411]        workqueue_init+0x88/0x318
>>>>>>>> [   84.093533] kernel_init_freeable+0x134/0x28f
>>>>>>>> [   84.099258]        kernel_init+0x16/0x130
>>>>>>>> [   84.104107]        ret_from_fork+0x1f/0x30
>>>>>>>> [   84.109038]
>>>>>>>>                -> #2 (fs_reclaim){+.+.}-{0:0}:
>>>>>>>> [   84.116348]        fs_reclaim_acquire+0xa1/0xd0
>>>>>>>> [   84.121697]        kmem_cache_alloc+0x2c/0x760
>>>>>>>> [   84.126948] drm_block_alloc.isra.0+0x27/0x50 [drm_buddy]
>>>>>>>> [   84.133679]        split_block+0x4d/0x140 [drm_buddy]
>>>>>>>> [   84.139539] drm_buddy_alloc_blocks+0x385/0x580 [drm_buddy]
>>>>>>>> [   84.146435] amdgpu_vram_mgr_new+0x213/0x4f0 [amdgpu]
>>>>>>>> [   84.153399]        ttm_resource_alloc+0x31/0x80 [ttm]
>>>>>>>> [   84.159366]        ttm_bo_mem_space+0x8f/0x230 [ttm]
>>>>>>>> [   84.165169]        ttm_bo_validate+0xc5/0x170 [ttm]
>>>>>>>> [   84.170872] ttm_bo_init_reserved+0x1a6/0x230 [ttm]
>>>>>>>> [   84.177075]        amdgpu_bo_create+0x1a0/0x510 [amdgpu]
>>>>>>>> [   84.183600] amdgpu_bo_create_reserved+0x188/0x1e0 [amdgpu]
>>>>>>>> [   84.190803] amdgpu_bo_create_kernel_at+0x64/0x200 [amdgpu]
>>>>>>>> [   84.197994]        amdgpu_ttm_init+0x420/0x4c0 [amdgpu]
>>>>>>>> [   84.204301]        gmc_v10_0_sw_init+0x33a/0x530 [amdgpu]
>>>>>>>> [   84.210813] amdgpu_device_init.cold+0x10d4/0x17a1 [amdgpu]
>>>>>>>> [   84.218077] amdgpu_driver_load_kms+0x15/0x110 [amdgpu]
>>>>>>>> [   84.224919]        amdgpu_pci_probe+0x142/0x350 [amdgpu]
>>>>>>>> [   84.231313]        local_pci_probe+0x40/0x80
>>>>>>>> [   84.236437]        work_for_cpu_fn+0x10/0x20
>>>>>>>> [   84.241500]        process_one_work+0x270/0x5a0
>>>>>>>> [   84.246805]        worker_thread+0x203/0x3c0
>>>>>>>> [   84.251828]        kthread+0xea/0x110
>>>>>>>> [   84.256229]        ret_from_fork+0x1f/0x30
>>>>>>>> [   84.261061]
>>>>>>>>                -> #1 (&mgr->lock){+.+.}-{3:3}:
>>>>>>>> [   84.268156]        __mutex_lock+0x9a/0xf30
>>>>>>>> [   84.272967] amdgpu_vram_mgr_new+0x14a/0x4f0 [amdgpu]
>>>>>>>> [   84.279752]        ttm_resource_alloc+0x31/0x80 [ttm]
>>>>>>>> [   84.285602]        ttm_bo_mem_space+0x8f/0x230 [ttm]
>>>>>>>> [   84.291321]        ttm_bo_validate+0xc5/0x170 [ttm]
>>>>>>>> [   84.296939] ttm_bo_init_reserved+0xe2/0x230 [ttm]
>>>>>>>> [   84.302969]        amdgpu_bo_create+0x1a0/0x510 [amdgpu]
>>>>>>>> [   84.309297]        amdgpu_bo_create_vm+0x2e/0x80 [amdgpu]
>>>>>>>> [   84.315656]        amdgpu_vm_pt_create+0xf5/0x270 [amdgpu]
>>>>>>>> [   84.322090] amdgpu_vm_ptes_update+0x6c4/0x8f0 [amdgpu]
>>>>>>>> [   84.328793] amdgpu_vm_update_range+0x29b/0x730 [amdgpu]
>>>>>>>> [   84.335537] svm_range_validate_and_map+0xc78/0x1390 [amdgpu]
>>>>>>>> [   84.342734] svm_range_set_attr+0xc74/0x1170 [amdgpu]
>>>>>>>> [   84.349222]        kfd_ioctl+0x189/0x5c0 [amdgpu]
>>>>>>>> [   84.354808]        __x64_sys_ioctl+0x80/0xb0
>>>>>>>> [   84.359738]        do_syscall_64+0x35/0x80
>>>>>>>> [   84.364481] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>>>>>> [   84.370687]
>>>>>>>>                -> #0 (&prange->lock){+.+.}-{3:3}:
>>>>>>>> [   84.377864]        __lock_acquire+0x12ed/0x27e0
>>>>>>>> [   84.383027]        lock_acquire+0xca/0x2e0
>>>>>>>> [   84.387759]        __mutex_lock+0x9a/0xf30
>>>>>>>> [   84.392491] svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>>>>>>> [amdgpu]
>>>>>>>> [   84.400345] __mmu_notifier_invalidate_range_start+0x1d3/0x230
>>>>>>>> [   84.407410]        unmap_vmas+0x162/0x170
>>>>>>>> [   84.412126]        unmap_region+0xa8/0x110
>>>>>>>> [   84.416905]        __do_munmap+0x209/0x4f0
>>>>>>>> [   84.421680]        __vm_munmap+0x78/0x120
>>>>>>>> [   84.426365]        __x64_sys_munmap+0x17/0x20
>>>>>>>> [   84.431392]        do_syscall_64+0x35/0x80
>>>>>>>> [   84.436164] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>>>>>> [   84.442405]
>>>>>>>>                other info that might help us debug this:
>>>>>>>>
>>>>>>>> [   84.452431] Chain exists of:
>>>>>>>>                  &prange->lock --> fs_reclaim --> 
>>>>>>>> mmu_notifier_invalidate_range_start
>>>>>>>>
>>>>>>>> [   84.466395]  Possible unsafe locking scenario:
>>>>>>>>
>>>>>>>> [   84.473720]        CPU0                    CPU1
>>>>>>>> [   84.479020]        ----                    ----
>>>>>>>> [   84.484296] lock(mmu_notifier_invalidate_range_start);
>>>>>>>> [   84.490333] lock(fs_reclaim);
>>>>>>>> [   84.496705] lock(mmu_notifier_invalidate_range_start);
>>>>>>>> [   84.505246]   lock(&prange->lock);
>>>>>>>> [   84.509361]
>>>>>>>>                 *** DEADLOCK ***
>>>>>>>>
>>>>>>>> [   84.517360] 2 locks held by kfdtest/3453:
>>>>>>>> [   84.522060]  #0: ffff9a99821ec4a8 
>>>>>>>> (&mm->mmap_lock#2){++++}-{3:3}, at: __do_munmap+0x417/0x4f0
>>>>>>>> [   84.531287]  #1: ffffffffbcd929c0 
>>>>>>>> (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: 
>>>>>>>> unmap_vmas+0x5/0x170
>>>>>>>> [   84.541896]
>>>>>>>>                stack backtrace:
>>>>>>>> [   84.547630] CPU: 3 PID: 3453 Comm: kfdtest Not tainted 
>>>>>>>> 5.19.0-kfd-fkuehlin #75
>>>>>>>> [   84.555537] Hardware name: To Be Filled By O.E.M. To Be 
>>>>>>>> Filled By O.E.M./EPYCD8-2T, BIOS P2.60 04/10/2020
>>>>>>>> [   84.565788] Call Trace:
>>>>>>>> [   84.568925]  <TASK>
>>>>>>>> [   84.571702]  dump_stack_lvl+0x45/0x59
>>>>>>>> [   84.576034]  check_noncircular+0xfe/0x110
>>>>>>>> [   84.580715]  ? kernel_text_address+0x6d/0xe0
>>>>>>>> [   84.585652]  __lock_acquire+0x12ed/0x27e0
>>>>>>>> [   84.590340]  lock_acquire+0xca/0x2e0
>>>>>>>> [   84.594595]  ? 
>>>>>>>> svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
>>>>>>>> [   84.602338]  __mutex_lock+0x9a/0xf30
>>>>>>>> [   84.606714]  ? 
>>>>>>>> svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
>>>>>>>> [   84.614262]  ? 
>>>>>>>> svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
>>>>>>>> [   84.621806]  ? 
>>>>>>>> svm_range_cpu_invalidate_pagetables+0x90/0x5e0 [amdgpu]
>>>>>>>> [   84.629353] svm_range_cpu_invalidate_pagetables+0x90/0x5e0 
>>>>>>>> [amdgpu]
>>>>>>>> [   84.636742]  ? lock_release+0x139/0x2b0
>>>>>>>> [   84.641374] __mmu_notifier_invalidate_range_start+0x1d3/0x230
>>>>>>>> [   84.647976]  unmap_vmas+0x162/0x170
>>>>>>>> [   84.652203]  unmap_region+0xa8/0x110
>>>>>>>> [   84.656503]  __do_munmap+0x209/0x4f0
>>>>>>>> [   84.660792]  __vm_munmap+0x78/0x120
>>>>>>>> [   84.664977]  __x64_sys_munmap+0x17/0x20
>>>>>>>> [   84.669499]  do_syscall_64+0x35/0x80
>>>>>>>> [   84.673755] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>>>>>> [   84.679485] RIP: 0033:0x7f32872eb97b
>>>>>>>> [   84.683738] Code: 8b 15 19 35 0d 00 f7 d8 64 89 02 48 c7 c0 
>>>>>>>> ff ff ff ff eb 89 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 
>>>>>>>> b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e5 
>>>>>>>> 34 0d 00 f7 d8 64 89 01 48
>>>>>>>> [   84.703915] RSP: 002b:00007fffb06c4508 EFLAGS: 00000246 
>>>>>>>> ORIG_RAX: 000000000000000b
>>>>>>>> [   84.712205] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 
>>>>>>>> 00007f32872eb97b
>>>>>>>> [   84.720072] RDX: 0000000004000000 RSI: 0000000004000000 RDI: 
>>>>>>>> 00007f32831ae000
>>>>>>>> [   84.727944] RBP: 00007fffb06c4750 R08: 00007fffb06c4548 R09: 
>>>>>>>> 000055e7570ad230
>>>>>>>> [   84.735809] R10: 000055e757088010 R11: 0000000000000246 R12: 
>>>>>>>> 000055e75453cefa
>>>>>>>> [   84.743688] R13: 0000000000000000 R14: 0000000000000021 R15: 
>>>>>>>> 0000000000000000
>>>>>>>> [   84.751584]  </TASK>
>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>
>>>>
>>

