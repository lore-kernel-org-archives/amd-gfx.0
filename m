From: Philip Yang <philip.yang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: use HMM mirror callback to replace mmu
 notifier v4
Date: Wed, 3 Oct 2018 16:31:37 -0400
Message-ID: <bf806477-06b3-61de-fea3-5ad260d92cdd@amd.com>
References: <1536871954-8451-1-git-send-email-Philip.Yang@amd.com>
 <DM5PR12MB17077A78E0F95BFBA57F2E1A92140@DM5PR12MB1707.namprd12.prod.outlook.com>
 <425fe859-c780-48a5-a2c6-c3bf2b9abb38@amd.com>
 <DM5PR12MB17072AE77EB0DE3AD22B8D7892140@DM5PR12MB1707.namprd12.prod.outlook.com>
 <9b427976-f2ff-8ba1-6ebf-588ca95aef80@amd.com>
 <DM5PR12MB17072879EC907150027D6F7892140@DM5PR12MB1707.namprd12.prod.outlook.com>
 <58199419-e20f-4ab0-ac1d-a7eb79f5c6f7@email.android.com>
 <DM5PR12MB1707273AC4B0C03A3BEDF73092140@DM5PR12MB1707.namprd12.prod.outlook.com>
 <1068c389-56fc-4125-ac40-b1ef2d60eabd@email.android.com>
 <DM5PR12MB1707BCD7BFC10EDD594FE90B92140@DM5PR12MB1707.namprd12.prod.outlook.com>
 <11ba3857-9bb0-648e-2806-0533090d9a0a@amd.com>
 <16d1faf6-80a4-dc46-bd2a-9cd475808e98@amd.com>
 <8f9f5703-214f-488d-9cfe-ccc64e8cd009@email.android.com>
 <fe0d429b-5038-a297-e02e-423302544477@amd.com>
 <b8686e6b-0c3e-4feb-afbd-80397aac31a0@email.android.com>
 <09916f9a-3f5f-27ab-01e6-6d77303cf052@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0679816235=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <09916f9a-3f5f-27ab-01e6-6d77303cf052-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Cc: "j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Kuehling,
 Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0679816235==
Content-Type: multipart/alternative;
 boundary="------------73E1B79DB3029D5E6EFAA05C"
Content-Language: en-US

--------------73E1B79DB3029D5E6EFAA05C
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Hi Christian,

Yes, I agree. I am working on patch 2 to replace get_user_page with HMM. 
One problem is in current gfx path, we check if mmu_invalidation 
multiple times in amdgpu_cs_ioctl() path after get_user_page(), 
amdgpu_cs_parser_bos(), amdgpu_cs_list_validate(), and 
amdgpu_cs_submit(). For HMM, hmm_vma_range_done() has to be called once 
and only once after hmm_vma_get_pfns()/hmm_vma_fault(), so I will call 
hmm_vma_range_done() inside amdgpu_cs_submit after holding the mn lock. 
Is my understanding correct?

Philip

On 2018-10-02 11:05 AM, Christian König wrote:
> Checking more code and documentation and thinking about it over my 
> vacation I think I have some new conclusions here.
>
> Currently we are using get_user_pages() together with an MMU notifier 
> to guarantee coherent address space view, because get_user_pages() 
> works by grabbing a reference to the pages and ignoring concurrent 
> page table updates.
>
> But HMM uses a different approach by checking the address space for 
> modifications using hmm_vma_range_done() and re-trying when the 
> address space has changed.
>
> Now what you are trying to do is to change that into get_user_pages() 
> and HMM callback and this is what won't work. We can either use 
> get_user_pages() with MMU notifier or we can use HMM for the work, but 
> we can't mix and match.
>
> So my initial guess was correct that we just need to change both sides 
> of the implementation at the same time.
>
> Regards,
> Christian.
>
> Am 28.09.2018 um 17:13 schrieb Koenig, Christian:
>> No it definitely isn't.
>>
>> We have literally worked month on this with the core MM developers.
>>
>> Making sure that we have a consistent page array is absolutely vital 
>> for correct operation.
>>
>> Please also check Jerome's presentation from XDC it also perfectly 
>> explains why this approach won't work correctly.
>>
>> Christian.
>>
>> Am 28.09.2018 17:07 schrieb "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>:
>> For B path, we take mm->mmap_sem, then call hmm_vma_get_pfns() or 
>> get_user_pages(). This is obvious.
>>
>> For A path, mmu notifier 
>> mmu_notifier_invalidate_range_start()/mmu_notifier_invalidate_range_end() 
>> is called in many places, and the calling path is quit complicated 
>> inside mm, it's not obvious. I checked many of the them, for example:
>>
>> do_munmap()
>>   down_write(&mm->mmap_sem)
>>   arch_unmap()
>>     mpx_notify_unmap()...
>>        zap_bt_entries_mapping()
>>          zap_page_range()
>>  up_write(&mm->mmap_sem)
>>
>> void zap_page_range(struct vm_area_struct *vma, unsigned long start,
>>         unsigned long size)
>> {
>>     struct mm_struct *mm = vma->vm_mm;
>>     struct mmu_gather tlb;
>>     unsigned long end = start + size;
>>
>>     lru_add_drain();
>>     tlb_gather_mmu(&tlb, mm, start, end);
>>     update_hiwater_rss(mm);
>>     mmu_notifier_invalidate_range_start(mm, start, end);
>>     for ( ; vma && vma->vm_start < end; vma = vma->vm_next)
>>         unmap_single_vma(&tlb, vma, start, end, NULL);
>>     mmu_notifier_invalidate_range_end(mm, start, end);
>>     tlb_finish_mmu(&tlb, start, end);
>> }
>>
>> So AFAIK it's okay without invalidate_range_end() callback.
>>
>> Regards,
>> Philip
>>
>> On 2018-09-28 01:25 AM, Koenig, Christian wrote:
>>> No, that is incorrect as well :)
>>>
>>> The mmap_sem isn't necessary taken during page table updates.
>>>
>>> What you could do is replace get_user_pages() directly with HMM. If 
>>> I'm not completely mistaken that should work as expected.
>>>
>>> Christian.
>>>
>>> Am 27.09.2018 22:18 schrieb "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>:
>>> I was trying to understand the way how HMM handle this concurrent 
>>> issue and how we handle it in amdgpu_ttm_tt_userptr_needs_pages() 
>>> and amdgpu_ttm_tt_affect_userptr(). HMM uses range->valid flag, we 
>>> use gtt->mmu_invalidations and gtt->last_set_pages. Both use the 
>>> same lock plus flag idea actually.
>>>
>>> Thanks for the information, now I understand fence 
>>> ttm_eu_fence_buffer_objects() put to BOs will block CPU page table 
>>> update. This is another side of this concurrent issue I didn't know.
>>>
>>> I had same worry that it has issue without invalidate_range_end() 
>>> callback as the calling sequence Felix lists. Now I think it's fine 
>>> after taking a look again today because of mm->mmap_sem usage, this 
>>> is my understanding:
>>>
>>> A path:
>>>
>>> down_write(&mm->mmap_sem);
>>> mmu_notifier_invalidate_range_start()
>>>     take_lock()
>>>     release_lock()
>>> CPU page table update
>>> mmu_notifier_invalidate_range_end()
>>> up_write(&mm->mmap_sem);
>>>
>>> B path:
>>>
>>> again:
>>> down_read(&mm->mmap_sem);
>>> hmm_vma_get_pfns()
>>> up_read(&mm->mmap_sem);
>>> ....
>>> ....
>>> take_lock()
>>> if (!hmm_vma_range_done()) {
>>>    release_lock()
>>>    goto again
>>> }
>>> submit command job...
>>> release_lock()
>>>
>>> If you agree, I will submit patch v5 with some minor changes, and 
>>> submit another patch to replace get_user_page() with HMM.
>>>
>>> Regards,
>>> Philip
>>>
>>> On 2018-09-27 11:36 AM, Christian König wrote:
>>>> Yeah, I've read that as well.
>>>>
>>>> My best guess is that we just need to add a call to 
>>>> hmm_vma_range_done() after taking the lock and also replace 
>>>> get_user_pages() with hmm_vma_get_pfns().
>>>>
>>>> But I'm still not 100% sure how all of that is supposed to work 
>>>> together.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>> Am 27.09.2018 um 16:50 schrieb Kuehling, Felix:
>>>>>
>>>>> I think the answer is here: 
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/vm/hmm.rst#n216
>>>>>
>>>>> Regards,
>>>>>
>>>>> Felix
>>>>>
>>>>> *From:*Koenig, Christian
>>>>> *Sent:* Thursday, September 27, 2018 10:30 AM
>>>>> *To:* Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
>>>>> *Cc:* j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; Yang, Philip <Philip.Yang-5C7GfCeVMHo@public.gmane.org>; 
>>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>> *Subject:* RE: [PATCH] drm/amdgpu: use HMM mirror callback to 
>>>>> replace mmu notifier v4
>>>>>
>>>>> At least with get_user_pages() that is perfectly possible.
>>>>>
>>>>> For HMM it could be that this is prevented somehow.
>>>>>
>>>>> Christian.
>>>>>
>>>>> Am 27.09.2018 16:27 schrieb "Kuehling, Felix" 
>>>>> <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org <mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>>:
>>>>>
>>>>> > In this case you can end up accessing pages which are invalidated while 
>>>>> get_user_pages is in process.
>>>>>
>>>>> What’s the sequence of events you have in mind? Something like this?
>>>>>
>>>>>   * Page table is updated and triggers MMU notifier
>>>>>   * amdgpu MMU notifier runs and waits for pending CS to finish
>>>>>     while holding the read lock
>>>>>   * New CS starts just after invalidate_range_start MMU notifier
>>>>>     finishes but before the page table update is done
>>>>>   * get_user_pages returns outdated physical addresses
>>>>>
>>>>> I hope that’s not actually possible and that get_user_pages or 
>>>>> hmm_vma_fault would block until the page table update is done. 
>>>>> That is, invalidate_range_start marks the start of a page table 
>>>>> update, and while that update is in progress, get_user_pages or 
>>>>> hmm_vma_fault block. Jerome, can you comment on that?
>>>>>
>>>>> Thanks,
>>>>>   Felix
>>>>>
>>>>> *From:*Koenig, Christian
>>>>> *Sent:* Thursday, September 27, 2018 9:59 AM
>>>>> *To:* Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org 
>>>>> <mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>>
>>>>> *Cc:* Yang, Philip <Philip.Yang-5C7GfCeVMHo@public.gmane.org 
>>>>> <mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org>>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org 
>>>>> <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Jerome Glisse 
>>>>> <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
>>>>> *Subject:* RE: [PATCH] drm/amdgpu: use HMM mirror callback to 
>>>>> replace mmu notifier v4
>>>>>
>>>>> Yeah I understand that, but again that won't work.
>>>>>
>>>>> In this case you can end up accessing pages which are invalidated 
>>>>> while get_user_pages is in process.
>>>>>
>>>>> Christian.
>>>>>
>>>>> Am 27.09.2018 15:41 schrieb "Kuehling, Felix" 
>>>>> <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org <mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>>:
>>>>>
>>>>> > I’m not planning to change that. I don’t think there is any need to 
>>>>> change it.
>>>>>
>>>>> >
>>>>> > Yeah, but when HMM doesn't provide both the start and the end 
>>>>> hock of the invalidation this way won't work any more.
>>>>> >
>>>>> > So we need to find a solution for this,
>>>>> > Christian.
>>>>>
>>>>> My whole argument is that you don’t need to hold the read lock 
>>>>> until the invalidate_range_end. Just read_lock and read_unlock in 
>>>>> the invalidate_range_start function.
>>>>>
>>>>> Regards,
>>>>>
>>>>>   Felix
>>>>>
>>>>> *From:*Koenig, Christian
>>>>> *Sent:* Thursday, September 27, 2018 9:22 AM
>>>>> *To:* Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org 
>>>>> <mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>>
>>>>> *Cc:* Yang, Philip <Philip.Yang-5C7GfCeVMHo@public.gmane.org 
>>>>> <mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org>>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org 
>>>>> <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Jerome Glisse 
>>>>> <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
>>>>> *Subject:* Re: [PATCH] drm/amdgpu: use HMM mirror callback to 
>>>>> replace mmu notifier v4
>>>>>
>>>>> Am 27.09.2018 um 15:18 schrieb Kuehling, Felix:
>>>>>
>>>>>     > The problem is here:
>>>>>     >
>>>>>
>>>>>     > ttm_eu_fence_buffer_objects(&p->ticket, &p->validated,
>>>>>     p->fence);
>>>>>
>>>>>     > amdgpu_mn_unlock(p->mn);
>>>>>
>>>>>     >
>>>>>     > We need to hold the lock until the fence is added to the
>>>>>     reservation object.
>>>>>     >
>>>>>     > Otherwise somebody could have changed the page tables just
>>>>>     in the moment between the check of
>>>>>     amdgpu_ttm_tt_userptr_needs_pages() and adding the fence to
>>>>>     the reservation object.
>>>>>
>>>>>     I’m not planning to change that. I don’t think there is any
>>>>>     need to change it.
>>>>>
>>>>>
>>>>> Yeah, but when HMM doesn't provide both the start and the end hock 
>>>>> of the invalidation this way won't work any more.
>>>>>
>>>>> So we need to find a solution for this,
>>>>> Christian.
>>>>>
>>>>>     Regards,
>>>>>
>>>>>       Felix
>>>>>
>>>>>     *From:*Koenig, Christian
>>>>>     *Sent:* Thursday, September 27, 2018 7:24 AM
>>>>>     *To:* Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
>>>>>     <mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
>>>>>     *Cc:* Yang, Philip <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
>>>>>     <mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>     <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Jerome Glisse
>>>>>     <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> <mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>>>     *Subject:* Re: [PATCH] drm/amdgpu: use HMM mirror callback to
>>>>>     replace mmu notifier v4
>>>>>
>>>>>     Am 27.09.2018 um 13:08 schrieb Kuehling, Felix:
>>>>>
>>>>>         > We double check that there wasn't any page table
>>>>>         modification while we prepared the submission and restart
>>>>>         the whole process when there actually was some update.
>>>>>         >
>>>>>         > The reason why we need to do this is here:
>>>>>         >
>>>>>
>>>>>         > ttm_eu_fence_buffer_objects(&p->ticket, &p->validated,
>>>>>         p->fence);
>>>>>         > amdgpu_mn_unlock(p->mn);
>>>>>
>>>>>         >
>>>>>         > Only after the new fence is added to the buffer object
>>>>>         we can release the lock so that any invalidation will now
>>>>>         block on our command submission to finish before it
>>>>>         modifies the page table.
>>>>>
>>>>>         I don’t see why this requires holding the read-lock until
>>>>>         invalidate_range_end. amdgpu_ttm_tt_affect_userptr gets
>>>>>         called while the mn read-lock is held in
>>>>>         invalidate_range_start notifier.
>>>>>
>>>>>
>>>>>     That's not related to amdgpu_ttm_tt_affect_userptr(), this
>>>>>     function could actually be called outside the lock.
>>>>>
>>>>>     The problem is here:
>>>>>
>>>>>         ttm_eu_fence_buffer_objects(&p->ticket, &p->validated,
>>>>>         p->fence);
>>>>>
>>>>>         amdgpu_mn_unlock(p->mn);
>>>>>
>>>>>
>>>>>     We need to hold the lock until the fence is added to the
>>>>>     reservation object.
>>>>>
>>>>>     Otherwise somebody could have changed the page tables just in
>>>>>     the moment between the check of
>>>>>     amdgpu_ttm_tt_userptr_needs_pages() and adding the fence to
>>>>>     the reservation object.
>>>>>
>>>>>     Regards,
>>>>>     Christian.
>>>>>
>>>>>
>>>>>         Regards,
>>>>>
>>>>>           Felix
>>>>>
>>>>>         *From:*Koenig, Christian
>>>>>         *Sent:* Thursday, September 27, 2018 5:27 AM
>>>>>         *To:* Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
>>>>>         <mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
>>>>>         *Cc:* Yang, Philip <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
>>>>>         <mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org>;
>>>>>         amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>         <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Jerome Glisse
>>>>>         <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> <mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>>>         *Subject:* Re: [PATCH] drm/amdgpu: use HMM mirror callback
>>>>>         to replace mmu notifier v4
>>>>>
>>>>>         That is correct, but take a look what we do when after
>>>>>         calling the amdgpu_mn_read_lock():
>>>>>
>>>>>
>>>>>                     /* No memory allocation is allowed while
>>>>>             holding the mn lock */
>>>>>                     amdgpu_mn_lock(p->mn);
>>>>>             amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
>>>>>                             struct amdgpu_bo *bo =
>>>>>             ttm_to_amdgpu_bo(e->tv.bo);
>>>>>
>>>>>                             if
>>>>>             (amdgpu_ttm_tt_userptr_needs_pages(bo->tbo.ttm)) {
>>>>>                                     r = -ERESTARTSYS;
>>>>>                                     goto error_abort;
>>>>>                             }
>>>>>                     }
>>>>>
>>>>>
>>>>>         We double check that there wasn't any page table
>>>>>         modification while we prepared the submission and restart
>>>>>         the whole process when there actually was some update.
>>>>>
>>>>>         The reason why we need to do this is here:
>>>>>
>>>>>             ttm_eu_fence_buffer_objects(&p->ticket, &p->validated,
>>>>>             p->fence);
>>>>>             amdgpu_mn_unlock(p->mn);
>>>>>
>>>>>
>>>>>         Only after the new fence is added to the buffer object we
>>>>>         can release the lock so that any invalidation will now
>>>>>         block on our command submission to finish before it
>>>>>         modifies the page table.
>>>>>
>>>>>         The only other option would be to add the fence first and
>>>>>         then check if there was any update to the page tables.
>>>>>
>>>>>         The issue with that approach is that adding a fence can't
>>>>>         be made undone, so if we find that there actually was an
>>>>>         update to the page tables we would need to somehow turn
>>>>>         the CS into a dummy (e.g. overwrite all IBs with NOPs or
>>>>>         something like that) and still submit it.
>>>>>
>>>>>         Not sure if that is actually possible.
>>>>>
>>>>>         Regards,
>>>>>         Christian.
>>>>>
>>>>>         Am 27.09.2018 um 10:47 schrieb Kuehling, Felix:
>>>>>
>>>>>             So back to my previous question:
>>>>>
>>>>>             >> But do we really need another lock for this?
>>>>>             Wouldn't the
>>>>>
>>>>>             >> re-validation of userptr BOs (currently calling
>>>>>             get_user_pages) force
>>>>>
>>>>>             >> synchronization with the ongoing page table
>>>>>             invalidation through the
>>>>>
>>>>>             >> mmap_sem or other MM locks?
>>>>>
>>>>>             >
>>>>>
>>>>>             > No and yes. We don't hold any other locks while
>>>>>             doing command submission, but I expect that HMM has
>>>>>             its own mechanism to prevent that.
>>>>>
>>>>>             >
>>>>>
>>>>>             > Since we don't modify
>>>>>             amdgpu_mn_lock()/amdgpu_mn_unlock() we are certainly
>>>>>             not using this mechanism correctly.
>>>>>
>>>>>             The existing amdgpu_mn_lock/unlock should block the
>>>>>             MMU notifier while a command submission is in
>>>>>             progress. It should also block command submission
>>>>>             while an MMU notifier is in progress.
>>>>>
>>>>>             What we lose with HMM is the ability to hold a
>>>>>             read-lock for the entire duration of the
>>>>>             invalidate_range_start until invalidate_range_end. As
>>>>>             I understand it, that lock is meant to prevent new
>>>>>             command submissions while the page tables are being
>>>>>             updated by the kernel. But my point is, that
>>>>>             get_user_pages or hmm_vma_fault should do the same
>>>>>             kind of thing. Before the command submission can go
>>>>>             ahead, it needs to update the userptr addresses. If
>>>>>             the page tables are still being updated, it will block
>>>>>             there even without holding the amdgpu_mn_read_lock.
>>>>>
>>>>>             Regards,
>>>>>
>>>>>               Felix
>>>>>
>>>>>             *From:* Koenig, Christian
>>>>>             *Sent:* Thursday, September 27, 2018 3:00 AM
>>>>>             *To:* Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
>>>>>             <mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
>>>>>             *Cc:* Yang, Philip <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
>>>>>             <mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org>;
>>>>>             amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>             <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Jerome Glisse
>>>>>             <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> <mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>>>             *Subject:* RE: [PATCH] drm/amdgpu: use HMM mirror
>>>>>             callback to replace mmu notifier v4
>>>>>
>>>>>             No, that won't work. We would still run into lock
>>>>>             inversion problems.
>>>>>
>>>>>             What we could do with the scheduler is to turn
>>>>>             submissions into dummies if we find that the page
>>>>>             tables are now outdated.
>>>>>
>>>>>             But that would be really hacky and I'm not sure if
>>>>>             that would really work in all cases.
>>>>>
>>>>>             Christian.
>>>>>
>>>>>             Am 27.09.2018 08:53 schrieb "Kuehling, Felix"
>>>>>             <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org <mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>>:
>>>>>
>>>>>             I had a chat with Jerome yesterday. He pointed out
>>>>>             that the new blockable parameter can be used to infer
>>>>>             whether the MMU notifier is being called  in a reclaim
>>>>>             operation. So if blockable==true, it should even be
>>>>>             safe to take the BO reservation lock without problems.
>>>>>             I think with that we should be able to remove the
>>>>>             read-write locking completely and go back to locking
>>>>>             (or try-locking for blockable==false) the reservation
>>>>>             locks in the MMU notifier?
>>>>>
>>>>>             Regards,
>>>>>               Felix
>>>>>
>>>>>             -----Original Message-----
>>>>>             From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>             <mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>> On
>>>>>             Behalf Of Christian König
>>>>>             Sent: Saturday, September 15, 2018 3:47 AM
>>>>>             To: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org
>>>>>             <mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>>; Yang, Philip
>>>>>             <Philip.Yang-5C7GfCeVMHo@public.gmane.org <mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org>>;
>>>>>             amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>             <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Jerome Glisse
>>>>>             <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
>>>>>             Subject: Re: [PATCH] drm/amdgpu: use HMM mirror
>>>>>             callback to replace mmu notifier v4
>>>>>
>>>>>             Am 14.09.2018 um 22:21 schrieb Felix Kuehling:
>>>>>             > On 2018-09-14 01:52 PM, Christian König wrote:
>>>>>             >> Am 14.09.2018 um 19:47 schrieb Philip Yang:
>>>>>             >>> On 2018-09-14 03:51 AM, Christian König wrote:
>>>>>             >>>> Am 13.09.2018 um 23:51 schrieb Felix Kuehling:
>>>>>             >>>>> On 2018-09-13 04:52 PM, Philip Yang wrote:
>>>>>             >>>>> [SNIP]
>>>>>             >>>>>>    + amdgpu_mn_read_unlock(amn);
>>>>>             >>>>>> +
>>>>>             >>>>> amdgpu_mn_read_lock/unlock support recursive
>>>>>             locking for multiple
>>>>>             >>>>> overlapping or nested invalidation ranges. But
>>>>>             if you'r locking
>>>>>             >>>>> and unlocking in the same function. Is that
>>>>>             still a concern?
>>>>>             >>> I don't understand the possible recursive case, but
>>>>>             >>> amdgpu_mn_read_lock() still support recursive locking.
>>>>>             >>>> Well the real problem is that unlocking them here
>>>>>             won't work.
>>>>>             >>>>
>>>>>             >>>> We need to hold the lock until we are sure that
>>>>>             the operation which
>>>>>             >>>> updates the page tables is completed.
>>>>>             >>>>
>>>>>             >>> The reason for this change is because hmm mirror has
>>>>>             >>> invalidate_start callback, no invalidate_end callback
>>>>>             >>>
>>>>>             >>> Check mmu_notifier.c and hmm.c again, below is
>>>>>             entire logic to
>>>>>             >>> update CPU page tables and callback:
>>>>>             >>>
>>>>>             >>> mn lock amn->lock is used to protect interval tree
>>>>>             access because
>>>>>             >>> user may submit/register new userptr anytime.
>>>>>             >>> This is same for old and new way.
>>>>>             >>>
>>>>>             >>> step 2 guarantee the GPU operation is done before
>>>>>             updating CPU page
>>>>>             >>> table.
>>>>>             >>>
>>>>>             >>> So I think the change is safe. We don't need hold
>>>>>             mn lock until the
>>>>>             >>> CPU page tables update is completed.
>>>>>             >> No, that isn't even remotely correct. The lock
>>>>>             doesn't protects the
>>>>>             >> interval tree.
>>>>>             >>
>>>>>             >>> Old:
>>>>>             >>>     1. down_read_non_owner(&amn->lock)
>>>>>             >>>     2. loop to handle BOs from node->bos through
>>>>>             interval tree
>>>>>             >>> amn->object nodes
>>>>>             >>>         gfx: wait for pending BOs fence operation
>>>>>             done, mark user
>>>>>             >>> pages dirty
>>>>>             >>>         kfd: evict user queues of the process,
>>>>>             wait for queue
>>>>>             >>> unmap/map operation done
>>>>>             >>>     3. update CPU page tables
>>>>>             >>>     4. up_read(&amn->lock)
>>>>>             >>>
>>>>>             >>> New, switch step 3 and 4
>>>>>             >>>     1. down_read_non_owner(&amn->lock)
>>>>>             >>>     2. loop to handle BOs from node->bos through
>>>>>             interval tree
>>>>>             >>> amn->object nodes
>>>>>             >>>         gfx: wait for pending BOs fence operation
>>>>>             done, mark user
>>>>>             >>> pages dirty
>>>>>             >>>         kfd: evict user queues of the process,
>>>>>             wait for queue
>>>>>             >>> unmap/map operation done
>>>>>             >>>     3. up_read(&amn->lock)
>>>>>             >>>     4. update CPU page tables
>>>>>             >> The lock is there to make sure that we serialize
>>>>>             page table updates
>>>>>             >> with command submission.
>>>>>             > As I understand it, the idea is to prevent command
>>>>>             submission (adding
>>>>>             > new fences to BOs) while a page table invalidation
>>>>>             is in progress.
>>>>>
>>>>>             Yes, exactly.
>>>>>
>>>>>             > But do we really need another lock for this?
>>>>>             Wouldn't the
>>>>>             > re-validation of userptr BOs (currently calling
>>>>>             get_user_pages) force
>>>>>             > synchronization with the ongoing page table
>>>>>             invalidation through the
>>>>>             > mmap_sem or other MM locks?
>>>>>
>>>>>             No and yes. We don't hold any other locks while doing
>>>>>             command submission, but I expect that HMM has its own
>>>>>             mechanism to prevent that.
>>>>>
>>>>>             Since we don't modify
>>>>>             amdgpu_mn_lock()/amdgpu_mn_unlock() we are certainly
>>>>>             not using this mechanism correctly.
>>>>>
>>>>>             Regards,
>>>>>             Christian.
>>>>>             _______________________________________________
>>>>>             amd-gfx mailing list
>>>>>             amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>             <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>>>>>             https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>>>
>>>>
>>>
>>
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>


--------------73E1B79DB3029D5E6EFAA05C
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Christian,<br>
      <br>
      Yes, I agree. I am working on patch 2 to replace get_user_page
      with HMM. One problem is in current gfx path, we check if
      mmu_invalidation multiple times in amdgpu_cs_ioctl() path after
      get_user_page(), amdgpu_cs_parser_bos(),
      amdgpu_cs_list_validate(), and amdgpu_cs_submit(). For HMM,
      hmm_vma_range_done() has to be called once and only once after
      hmm_vma_get_pfns()/hmm_vma_fault(), so I will call
      hmm_vma_range_done() inside amdgpu_cs_submit after holding the mn
      lock. Is my understanding correct?<br>
      <br>
      Philip<br>
      <br>
      On 2018-10-02 11:05 AM, Christian König wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:09916f9a-3f5f-27ab-01e6-6d77303cf052-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <div class="moz-cite-prefix">Checking more code and documentation
        and thinking about it over my vacation I think I have some new
        conclusions here.<br>
        <br>
        Currently we are using get_user_pages() together with an MMU
        notifier to guarantee coherent address space view, because
        get_user_pages() works by grabbing a reference to the pages and
        ignoring concurrent page table updates.<br>
        <br>
        But HMM uses a different approach by checking the address space
        for modifications using hmm_vma_range_done() and re-trying when
        the address space has changed.<br>
        <br>
        Now what you are trying to do is to change that into
        get_user_pages() and HMM callback and this is what won't work.
        We can either use get_user_pages() with MMU notifier or we can
        use HMM for the work, but we can't mix and match.<br>
        <br>
        So my initial guess was correct that we just need to change both
        sides of the implementation at the same time.<br>
        <br>
        Regards,<br>
        Christian.<br>
        <br>
        Am 28.09.2018 um 17:13 schrieb Koenig, Christian:<br>
      </div>
      <blockquote type="cite"
        cite="mid:b8686e6b-0c3e-4feb-afbd-80397aac31a0-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org">
        <meta content="text/html; charset=Windows-1252">
        <div dir="auto">No it definitely isn't.
          <div dir="auto"><br>
          </div>
          <div dir="auto">We have literally worked month on this with
            the core MM developers.</div>
          <div dir="auto"><br>
          </div>
          <div dir="auto">Making sure that we have a consistent page
            array is absolutely vital for correct operation.</div>
          <div dir="auto"><br>
          </div>
          <div dir="auto">Please also check Jerome's presentation from
            XDC it also perfectly explains why this approach won't work
            correctly.</div>
          <div dir="auto"><br>
          </div>
          <div dir="auto">Christian.</div>
        </div>
        <div class="gmail_extra"><br>
          <div class="gmail_quote">Am 28.09.2018 17:07 schrieb "Yang,
            Philip" <a class="moz-txt-link-rfc2396E"
              href="mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">&lt;Philip.Yang-5C7GfCeVMHo@public.gmane.org&gt;</a>:<br
              type="attribution">
          </div>
        </div>
        <div>
          <div class="moz-cite-prefix">For B path, we take
            mm-&gt;mmap_sem, then call hmm_vma_get_pfns() or
            get_user_pages(). This is obvious.<br>
            <br>
            For A path, mmu notifier
mmu_notifier_invalidate_range_start()/mmu_notifier_invalidate_range_end()
            is called in many places, and the calling path is quit
            complicated inside mm, it's not obvious. I checked many of
            the them, for example:<br>
            <br>
            do_munmap()   <br>
              down_write(&amp;mm-&gt;mmap_sem)<br>
              arch_unmap()<br>
                mpx_notify_unmap()...<br>
                   zap_bt_entries_mapping()<br>
                     zap_page_range()<br>
             up_write(&amp;mm-&gt;mmap_sem)<br>
            <br>
            void zap_page_range(struct vm_area_struct *vma, unsigned
            long start,<br>
                    unsigned long size)<br>
            {<br>
                struct mm_struct *mm = vma-&gt;vm_mm;<br>
                struct mmu_gather tlb;<br>
                unsigned long end = start + size;<br>
            <br>
                lru_add_drain();<br>
                tlb_gather_mmu(&amp;tlb, mm, start, end);<br>
                update_hiwater_rss(mm);<br>
                mmu_notifier_invalidate_range_start(mm, start, end);<br>
                for ( ; vma &amp;&amp; vma-&gt;vm_start &lt; end; vma =
            vma-&gt;vm_next)<br>
                    unmap_single_vma(&amp;tlb, vma, start, end, NULL);<br>
                mmu_notifier_invalidate_range_end(mm, start, end);<br>
                tlb_finish_mmu(&amp;tlb, start, end);<br>
            }<br>
             <br>
            So AFAIK it's okay without invalidate_range_end() callback.
            <br>
                     <br>
            Regards,<br>
            Philip<br>
            <br>
            On 2018-09-28 01:25 AM, Koenig, Christian wrote:<br>
          </div>
          <blockquote type="cite">
            <meta content="text/html; charset=utf-8">
            <div dir="auto">No, that is incorrect as well :)
              <div dir="auto"><br>
              </div>
              <div dir="auto">The mmap_sem isn't necessary taken during
                page table updates.</div>
              <div dir="auto"><br>
              </div>
              <div dir="auto">What you could do is replace
                get_user_pages() directly with HMM. If I'm not
                completely mistaken that should work as expected.</div>
              <div dir="auto"><br>
              </div>
              <div dir="auto">Christian.</div>
            </div>
            <div class="gmail_extra"><br>
              <div class="gmail_quote">Am 27.09.2018 22:18 schrieb
                "Yang, Philip" <a class="moz-txt-link-rfc2396E"
                  href="mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org"
                  moz-do-not-send="true"> &lt;Philip.Yang-5C7GfCeVMHo@public.gmane.org&gt;</a>:<br
                  type="attribution">
              </div>
            </div>
            <div>
              <div class="moz-cite-prefix">I was trying to understand
                the way how HMM handle this concurrent issue and how we
                handle it in amdgpu_ttm_tt_userptr_needs_pages() and 
                amdgpu_ttm_tt_affect_userptr(). HMM uses range-&gt;valid
                flag, we use gtt-&gt;mmu_invalidations and
                gtt-&gt;last_set_pages. Both use the same lock plus flag
                idea actually.<br>
                <br>
                Thanks for the information, now I understand fence
                ttm_eu_fence_buffer_objects() put to BOs will block CPU
                page table update. This is another side of this
                concurrent issue I didn't know.<br>
                <br>
                I had same worry that it has issue without
                invalidate_range_end() callback as the calling sequence
                Felix lists. Now I think it's fine after taking a look
                again today because of mm-&gt;mmap_sem usage, this is my
                understanding:<br>
                <br>
                A path:<br>
                <br>
                down_write(&amp;mm-&gt;mmap_sem);<br>
                mmu_notifier_invalidate_range_start()<br>
                    take_lock()<br>
                    release_lock()<br>
                CPU page table update<br>
                mmu_notifier_invalidate_range_end()<br>
                up_write(&amp;mm-&gt;mmap_sem);<br>
                <br>
                B path:<br>
                <br>
                again: <br>
                down_read(&amp;mm-&gt;mmap_sem);<br>
                hmm_vma_get_pfns()<br>
                up_read(&amp;mm-&gt;mmap_sem);<br>
                ....<br>
                ....<br>
                take_lock()<br>
                if (!hmm_vma_range_done()) {<br>
                   release_lock()<br>
                   goto again<br>
                }<br>
                submit command job...<br>
                release_lock()<br>
                <br>
                If you agree, I will submit patch v5 with some minor
                changes, and submit another patch to replace
                get_user_page() with HMM.<br>
                 <br>
                Regards,<br>
                Philip  <br>
                <br>
                On 2018-09-27 11:36 AM, Christian König wrote:<br>
              </div>
              <blockquote type="cite">
                <div class="moz-cite-prefix">Yeah, I've read that as
                  well.<br>
                  <br>
                  My best guess is that we just need to add a call to
                  hmm_vma_range_done() after taking the lock and also
                  replace get_user_pages() with hmm_vma_get_pfns().<br>
                  <br>
                  But I'm still not 100% sure how all of that is
                  supposed to work together.<br>
                  <br>
                  Regards,<br>
                  Christian.<br>
                  <br>
                  Am 27.09.2018 um 16:50 schrieb Kuehling, Felix:<br>
                </div>
                <blockquote type="cite">
                  <meta name="Generator" content="Microsoft Word 15
                    (filtered medium)">
                  <style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
@font-face
	{font-family:Consolas}
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black}
p.msonormal0, li.msonormal0, div.msonormal0
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
span.PlainTextChar
	{font-family:Consolas;
	color:black}
p.msonormal00, li.msonormal00, div.msonormal00
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
p.msonormal000, li.msonormal000, div.msonormal000
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black}
p.emailquote, li.emailquote, div.emailquote
	{margin-right:0in;
	margin-left:1.0pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black}
p.msochpdefault, li.msochpdefault, div.msochpdefault
	{margin-right:0in;
	margin-left:0in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif}
span.plaintextchar0
	{font-family:Consolas;
	color:black}
span.plaintextchar00
	{font-family:"Calibri",sans-serif}
span.emailstyle22
	{font-family:"Calibri",sans-serif;
	color:windowtext}
span.emailstyle23
	{font-family:"Calibri",sans-serif;
	color:windowtext}
span.emailstyle24
	{font-family:"Calibri",sans-serif;
	color:windowtext}
span.emailstyle25
	{font-family:"Calibri",sans-serif;
	color:windowtext}
span.emailstyle30
	{font-family:"Calibri",sans-serif;
	color:windowtext}
span.EmailStyle33
	{font-family:"Calibri",sans-serif;
	color:windowtext}
.MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
ol
	{margin-bottom:0in}
ul
	{margin-bottom:0in}
-->
</style>
                  <div class="WordSection1">
                    <p class="MsoNormal"><span style="color:windowtext">I
                        think the answer is here: <a
href="https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/vm/hmm.rst#n216"
                          moz-do-not-send="true">
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/vm/hmm.rst#n216</a></span></p>
                    <p class="MsoNormal"><span style="color:windowtext"> </span></p>
                    <p class="MsoNormal"><span style="color:windowtext">Regards,</span></p>
                    <p class="MsoNormal"><span style="color:windowtext"> 
                        Felix</span></p>
                    <p class="MsoNormal"><span style="color:windowtext"> </span></p>
                    <div>
                      <div style="border:none; border-top:solid #E1E1E1
                        1.0pt; padding:3.0pt 0in 0in 0in">
                        <p class="MsoNormal"><b><span
                              style="color:windowtext">From:</span></b><span
                            style="color:windowtext"> Koenig, Christian
                            <br>
                            <b>Sent:</b> Thursday, September 27, 2018
                            10:30 AM<br>
                            <b>To:</b> Kuehling, Felix <a
                              class="moz-txt-link-rfc2396E"
                              href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org"
                              moz-do-not-send="true">
                              &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                            <b>Cc:</b> <a
                              class="moz-txt-link-abbreviated"
                              href="mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                              moz-do-not-send="true">j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>;
                            Yang, Philip <a
                              class="moz-txt-link-rfc2396E"
                              href="mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org"
                              moz-do-not-send="true">&lt;Philip.Yang-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                            <a class="moz-txt-link-abbreviated"
                              href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                              moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                            <b>Subject:</b> RE: [PATCH] drm/amdgpu: use
                            HMM mirror callback to replace mmu notifier
                            v4</span></p>
                      </div>
                    </div>
                    <p class="MsoNormal"> </p>
                    <div>
                      <p class="MsoNormal"><span
                          style="color:windowtext">At least with
                          get_user_pages() that is perfectly possible. </span></p>
                      <div>
                        <p class="MsoNormal"><span
                            style="color:windowtext"> </span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span
                            style="color:windowtext">For HMM it could be
                            that this is prevented somehow.</span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span
                            style="color:windowtext"> </span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span
                            style="color:windowtext">Christian.</span></p>
                      </div>
                    </div>
                    <div>
                      <p class="MsoNormal"><span
                          style="color:windowtext"> </span></p>
                      <div>
                        <p class="MsoNormal"><span
                            style="color:windowtext">Am 27.09.2018 16:27
                            schrieb "Kuehling, Felix" &lt;<a
                              href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org"
                              moz-do-not-send="true">Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt;:</span></p>
                      </div>
                    </div>
                    <div>
                      <div>
                        <p class="MsoNormal"><span
                            style="color:windowtext">&gt; In this case
                            you can end up accessing pages which are
                            invalidated while get_user_pages is in
                            process.</span></p>
                        <p class="MsoNormal"><span
                            style="color:windowtext"> </span></p>
                        <p class="MsoNormal"><span
                            style="color:windowtext">What’s the sequence
                            of events you have in mind? Something like
                            this?</span></p>
                        <p class="MsoNormal"><span
                            style="color:windowtext"> </span></p>
                        <ul style="margin-top:0in" type="disc">
                          <li class="MsoListParagraph"
                            style="color:windowtext; margin-left:0in">Page
                            table is updated and triggers MMU notifier </li>
                          <li class="MsoListParagraph"
                            style="color:windowtext; margin-left:0in">amdgpu
                            MMU notifier runs and waits for pending CS
                            to finish while holding the read lock </li>
                          <li class="MsoListParagraph"
                            style="color:windowtext; margin-left:0in">New
                            CS starts just after invalidate_range_start
                            MMU notifier finishes but before the page
                            table update is done </li>
                          <li class="MsoListParagraph"
                            style="color:windowtext; margin-left:0in">get_user_pages
                            returns outdated physical addresses </li>
                        </ul>
                        <p class="MsoNormal"><span
                            style="color:windowtext"> </span></p>
                        <p class="MsoNormal"><span
                            style="color:windowtext">I hope that’s not
                            actually possible and that get_user_pages or
                            hmm_vma_fault would block until the page
                            table update is done. That is,
                            invalidate_range_start marks the start of a
                            page table update, and while that update is
                            in progress, get_user_pages or hmm_vma_fault
                            block. Jerome, can you comment on that?</span></p>
                        <p class="MsoNormal"><span
                            style="color:windowtext"> </span></p>
                        <p class="MsoNormal"><span
                            style="color:windowtext">Thanks,<br>
                              Felix</span></p>
                        <p class="MsoNormal"><span
                            style="color:windowtext"> </span></p>
                        <div>
                          <div style="border:none; border-top:solid
                            #E1E1E1 1.0pt; padding:3.0pt 0in 0in 0in">
                            <p class="MsoNormal"><b><span
                                  style="color:windowtext">From:</span></b><span
                                style="color:windowtext"> Koenig,
                                Christian <br>
                                <b>Sent:</b> Thursday, September 27,
                                2018 9:59 AM<br>
                                <b>To:</b> Kuehling, Felix &lt;<a
                                  href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org"
                                  moz-do-not-send="true">Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
                                <b>Cc:</b> Yang, Philip &lt;<a
                                  href="mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org"
                                  moz-do-not-send="true">Philip.Yang-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                                <a
                                  href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                                  moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
                                Jerome Glisse &lt;<a
                                  href="mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                                  moz-do-not-send="true">j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
                                <b>Subject:</b> RE: [PATCH] drm/amdgpu:
                                use HMM mirror callback to replace mmu
                                notifier v4</span></p>
                          </div>
                        </div>
                        <p class="MsoNormal"> </p>
                        <div>
                          <p class="MsoNormal"><span
                              style="color:windowtext">Yeah I understand
                              that, but again that won't work. </span></p>
                          <div>
                            <p class="MsoNormal"><span
                                style="color:windowtext"> </span></p>
                          </div>
                          <div>
                            <p class="MsoNormal"><span
                                style="color:windowtext">In this case
                                you can end up accessing pages which are
                                invalidated while get_user_pages is in
                                process.</span></p>
                          </div>
                          <div>
                            <p class="MsoNormal"><span
                                style="color:windowtext"> </span></p>
                          </div>
                          <div>
                            <p class="MsoNormal"><span
                                style="color:windowtext">Christian.</span></p>
                          </div>
                        </div>
                        <div>
                          <p class="MsoNormal"><span
                              style="color:windowtext"> </span></p>
                          <div>
                            <p class="MsoNormal"><span
                                style="color:windowtext">Am 27.09.2018
                                15:41 schrieb "Kuehling, Felix" &lt;<a
                                  href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org"
                                  moz-do-not-send="true">Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt;:</span></p>
                          </div>
                        </div>
                        <div>
                          <div>
                            <p class="MsoNormal"><span
                                style="color:windowtext">&gt; I’m not
                                planning to change that. I don’t think
                                there is any need to change it.</span></p>
                            <p class="MsoNormal">&gt;<br>
                              &gt; Yeah, but when HMM doesn't provide
                              both the start and the end hock of the
                              invalidation this way won't work any more.<br>
                              &gt;<br>
                              &gt; So we need to find a solution for
                              this,<br>
                              &gt; Christian.</p>
                            <p class="MsoNormal"> </p>
                            <p class="MsoNormal">My whole argument is
                              that you don’t need to hold the read lock
                              until the invalidate_range_end. Just
                              read_lock and read_unlock in the
                              invalidate_range_start function.</p>
                            <p class="MsoNormal"> </p>
                            <p class="MsoNormal">Regards,</p>
                            <p class="MsoNormal"
                              style="margin-bottom:12.0pt">  Felix</p>
                            <p class="MsoNormal"><span
                                style="color:windowtext"> </span></p>
                            <div>
                              <div style="border:none; border-top:solid
                                #E1E1E1 1.0pt; padding:3.0pt 0in 0in
                                0in">
                                <p class="MsoNormal"><b><span
                                      style="color:windowtext">From:</span></b><span
                                    style="color:windowtext"> Koenig,
                                    Christian <br>
                                    <b>Sent:</b> Thursday, September 27,
                                    2018 9:22 AM<br>
                                    <b>To:</b> Kuehling, Felix &lt;<a
                                      href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org"
                                      moz-do-not-send="true">Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
                                    <b>Cc:</b> Yang, Philip &lt;<a
                                      href="mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org"
                                      moz-do-not-send="true">Philip.Yang-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                                    <a
                                      href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                                      moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
                                    Jerome Glisse &lt;<a
                                      href="mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                                      moz-do-not-send="true">j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
                                    <b>Subject:</b> Re: [PATCH]
                                    drm/amdgpu: use HMM mirror callback
                                    to replace mmu notifier v4</span></p>
                              </div>
                            </div>
                            <p class="MsoNormal"> </p>
                            <div>
                              <p class="MsoNormal">Am 27.09.2018 um
                                15:18 schrieb Kuehling, Felix:</p>
                            </div>
                            <blockquote style="margin-top:5.0pt;
                              margin-bottom:5.0pt">
                              <p class="MsoNormal">&gt; The problem is
                                here:<br>
                                &gt;</p>
                              <p class="MsoNormal">&gt;
                                ttm_eu_fence_buffer_objects(&amp;p-&gt;ticket,
                                &amp;p-&gt;validated, p-&gt;fence);</p>
                              <p class="MsoNormal">&gt;
                                amdgpu_mn_unlock(p-&gt;mn); </p>
                              <p class="MsoNormal"
                                style="margin-bottom:12.0pt">&gt;<br>
                                &gt; We need to hold the lock until the
                                fence is added to the reservation
                                object.<br>
                                &gt;<br>
                                &gt; Otherwise somebody could have
                                changed the page tables just in the
                                moment between the check of
                                amdgpu_ttm_tt_userptr_needs_pages() and
                                adding the fence to the reservation
                                object.</p>
                              <p class="MsoNormal"><span
                                  style="color:windowtext">I’m not
                                  planning to change that. I don’t think
                                  there is any need to change it.</span></p>
                            </blockquote>
                            <p class="MsoNormal"
                              style="margin-bottom:12.0pt"><br>
                              Yeah, but when HMM doesn't provide both
                              the start and the end hock of the
                              invalidation this way won't work any more.<br>
                              <br>
                              So we need to find a solution for this,<br>
                              Christian.</p>
                            <blockquote style="margin-top:5.0pt;
                              margin-bottom:5.0pt">
                              <p class="MsoNormal"><span
                                  style="color:windowtext"> </span></p>
                              <p class="MsoNormal"><span
                                  style="color:windowtext">Regards,</span></p>
                              <p class="MsoNormal"><span
                                  style="color:windowtext">  Felix</span></p>
                              <p class="MsoNormal"><span
                                  style="color:windowtext"> </span></p>
                              <div>
                                <div style="border:none;
                                  border-top:solid #E1E1E1 1.0pt;
                                  padding:3.0pt 0in 0in 0in">
                                  <p class="MsoNormal"><b><span
                                        style="color:windowtext">From:</span></b><span
                                      style="color:windowtext"> Koenig,
                                      Christian <br>
                                      <b>Sent:</b> Thursday, September
                                      27, 2018 7:24 AM<br>
                                      <b>To:</b> Kuehling, Felix <a
                                        href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org"
                                        moz-do-not-send="true">&lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                                      <b>Cc:</b> Yang, Philip <a
                                        href="mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org"
                                        moz-do-not-send="true">&lt;Philip.Yang-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                                      <a
                                        href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                                        moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
                                      Jerome Glisse <a
                                        href="mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                                        moz-do-not-send="true">&lt;j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
                                      <b>Subject:</b> Re: [PATCH]
                                      drm/amdgpu: use HMM mirror
                                      callback to replace mmu notifier
                                      v4</span></p>
                                </div>
                              </div>
                              <p class="MsoNormal"> </p>
                              <div>
                                <p class="MsoNormal">Am 27.09.2018 um
                                  13:08 schrieb Kuehling, Felix:</p>
                              </div>
                              <blockquote style="margin-top:5.0pt;
                                margin-bottom:5.0pt">
                                <p class="MsoNormal">&gt; We double
                                  check that there wasn't any page table
                                  modification while we prepared the
                                  submission and restart the whole
                                  process when there actually was some
                                  update.<br>
                                  &gt;<br>
                                  &gt; The reason why we need to do this
                                  is here:<br>
                                  &gt;</p>
                                <p class="MsoNormal">&gt;       
                                  ttm_eu_fence_buffer_objects(&amp;p-&gt;ticket,
                                  &amp;p-&gt;validated, p-&gt;fence);<br>
                                  &gt;       
                                  amdgpu_mn_unlock(p-&gt;mn);</p>
                                <p class="MsoNormal"
                                  style="margin-bottom:12.0pt">&gt;<br>
                                  &gt; Only after the new fence is added
                                  to the buffer object we can release
                                  the lock so that any invalidation will
                                  now block on our command submission to
                                  finish before it modifies the page
                                  table.<br>
                                  <br>
                                </p>
                                <p class="MsoNormal"><span
                                    style="color:windowtext">I don’t see
                                    why this requires holding the
                                    read-lock until
                                    invalidate_range_end.
                                    amdgpu_ttm_tt_affect_userptr gets
                                    called while the mn read-lock is
                                    held in invalidate_range_start
                                    notifier.</span></p>
                              </blockquote>
                              <p class="MsoNormal"
                                style="margin-bottom:12.0pt"><br>
                                That's not related to
                                amdgpu_ttm_tt_affect_userptr(), this
                                function could actually be called
                                outside the lock.<br>
                                <br>
                                The problem is here:</p>
                              <blockquote style="margin-top:5.0pt;
                                margin-bottom:5.0pt">
                                <p class="MsoNormal">ttm_eu_fence_buffer_objects(&amp;p-&gt;ticket,
                                  &amp;p-&gt;validated, p-&gt;fence);</p>
                              </blockquote>
                              <blockquote style="margin-top:5.0pt;
                                margin-bottom:5.0pt">
                                <p class="MsoNormal">amdgpu_mn_unlock(p-&gt;mn);
                                </p>
                              </blockquote>
                              <p class="MsoNormal"
                                style="margin-bottom:12.0pt"><br>
                                We need to hold the lock until the fence
                                is added to the reservation object.<br>
                                <br>
                                Otherwise somebody could have changed
                                the page tables just in the moment
                                between the check of
                                amdgpu_ttm_tt_userptr_needs_pages() and
                                adding the fence to the reservation
                                object.<br>
                                <br>
                                Regards,<br>
                                Christian.<br>
                                <br>
                                <br>
                              </p>
                              <blockquote style="margin-top:5.0pt;
                                margin-bottom:5.0pt">
                                <p class="MsoNormal"><span
                                    style="color:windowtext"> </span></p>
                                <p class="MsoNormal"><span
                                    style="color:windowtext">Regards,</span></p>
                                <p class="MsoNormal"><span
                                    style="color:windowtext">  Felix</span></p>
                                <p class="MsoNormal"><span
                                    style="color:windowtext"> </span></p>
                                <div>
                                  <div style="border:none;
                                    border-top:solid #E1E1E1 1.0pt;
                                    padding:3.0pt 0in 0in 0in">
                                    <p class="MsoNormal"><b><span
                                          style="color:windowtext">From:</span></b><span
                                        style="color:windowtext">
                                        Koenig, Christian <br>
                                        <b>Sent:</b> Thursday, September
                                        27, 2018 5:27 AM<br>
                                        <b>To:</b> Kuehling, Felix <a
                                          href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org"
                                          moz-do-not-send="true">&lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                                        <b>Cc:</b> Yang, Philip <a
                                          href="mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org"
                                          moz-do-not-send="true">&lt;Philip.Yang-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                                        <a
                                          href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                                          moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
                                        Jerome Glisse <a
                                          href="mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                                          moz-do-not-send="true">&lt;j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
                                        <b>Subject:</b> Re: [PATCH]
                                        drm/amdgpu: use HMM mirror
                                        callback to replace mmu notifier
                                        v4</span></p>
                                  </div>
                                </div>
                                <p class="MsoNormal"> </p>
                                <div>
                                  <p class="MsoNormal"
                                    style="margin-bottom:12.0pt">That is
                                    correct, but take a look what we do
                                    when after calling the
                                    amdgpu_mn_read_lock():<br>
                                    <br>
                                    <br>
                                  </p>
                                  <blockquote style="margin-top:5.0pt;
                                    margin-bottom:5.0pt">
                                    <p class="MsoNormal">        /* No
                                      memory allocation is allowed while
                                      holding the mn lock */<br>
                                              amdgpu_mn_lock(p-&gt;mn);<br>
                                             
                                      amdgpu_bo_list_for_each_userptr_entry(e,
                                      p-&gt;bo_list) {<br>
                                                      struct amdgpu_bo
                                      *bo =
                                      ttm_to_amdgpu_bo(e-&gt;tv.bo);<br>
                                      <br>
                                                      if
                                      (amdgpu_ttm_tt_userptr_needs_pages(bo-&gt;tbo.ttm))
                                      {<br>
                                                              r =
                                      -ERESTARTSYS;<br>
                                                              goto
                                      error_abort;<br>
                                                      }<br>
                                              }</p>
                                  </blockquote>
                                  <p class="MsoNormal"
                                    style="margin-bottom:12.0pt"><br>
                                    We double check that there wasn't
                                    any page table modification while we
                                    prepared the submission and restart
                                    the whole process when there
                                    actually was some update.<br>
                                    <br>
                                    The reason why we need to do this is
                                    here:<br>
                                    <br>
                                  </p>
                                  <blockquote style="margin-top:5.0pt;
                                    margin-bottom:5.0pt">
                                    <p class="MsoNormal">       
                                      ttm_eu_fence_buffer_objects(&amp;p-&gt;ticket,
                                      &amp;p-&gt;validated,
                                      p-&gt;fence);<br>
                                             
                                      amdgpu_mn_unlock(p-&gt;mn);</p>
                                  </blockquote>
                                  <p class="MsoNormal"><br>
                                    Only after the new fence is added to
                                    the buffer object we can release the
                                    lock so that any invalidation will
                                    now block on our command submission
                                    to finish before it modifies the
                                    page table.<br>
                                    <br>
                                    The only other option would be to
                                    add the fence first and then check
                                    if there was any update to the page
                                    tables.<br>
                                    <br>
                                    The issue with that approach is that
                                    adding a fence can't be made undone,
                                    so if we find that there actually
                                    was an update to the page tables we
                                    would need to somehow turn the CS
                                    into a dummy (e.g. overwrite all IBs
                                    with NOPs or something like that)
                                    and still submit it.<br>
                                    <br>
                                    Not sure if that is actually
                                    possible.<br>
                                    <br>
                                    Regards,<br>
                                    Christian.<br>
                                    <br>
                                    Am 27.09.2018 um 10:47 schrieb
                                    Kuehling, Felix:</p>
                                </div>
                                <blockquote style="margin-top:5.0pt;
                                  margin-bottom:5.0pt">
                                  <p class="MsoNormal">So back to my
                                    previous question:</p>
                                  <p class="MsoPlainText"> </p>
                                  <p class="MsoPlainText">&gt;&gt; But
                                    do we really need another lock for
                                    this? Wouldn't the </p>
                                  <p class="MsoPlainText">&gt;&gt;
                                    re-validation of userptr BOs
                                    (currently calling get_user_pages)
                                    force </p>
                                  <p class="MsoPlainText">&gt;&gt;
                                    synchronization with the ongoing
                                    page table invalidation through the
                                  </p>
                                  <p class="MsoPlainText">&gt;&gt;
                                    mmap_sem or other MM locks?</p>
                                  <p class="MsoPlainText">&gt; </p>
                                  <p class="MsoPlainText">&gt; No and
                                    yes. We don't hold any other locks
                                    while doing command submission, but
                                    I expect that HMM has its own
                                    mechanism to prevent that.</p>
                                  <p class="MsoPlainText">&gt; </p>
                                  <p class="MsoPlainText">&gt; Since we
                                    don't modify
                                    amdgpu_mn_lock()/amdgpu_mn_unlock()
                                    we are certainly not using this
                                    mechanism correctly.</p>
                                  <p class="MsoNormal"> </p>
                                  <p class="MsoNormal">The existing
                                    amdgpu_mn_lock/unlock should block
                                    the MMU notifier while a command
                                    submission is in progress. It should
                                    also block command submission while
                                    an MMU notifier is in progress.</p>
                                  <p class="MsoNormal"> </p>
                                  <p class="MsoNormal">What we lose with
                                    HMM is the ability to hold a
                                    read-lock for the entire duration of
                                    the invalidate_range_start until
                                    invalidate_range_end. As I
                                    understand it, that lock is meant to
                                    prevent new command submissions
                                    while the page tables are being
                                    updated by the kernel. But my point
                                    is, that get_user_pages or
                                    hmm_vma_fault should do the same
                                    kind of thing. Before the command
                                    submission can go ahead, it needs to
                                    update the userptr addresses. If the
                                    page tables are still being updated,
                                    it will block there even without
                                    holding the amdgpu_mn_read_lock.</p>
                                  <p class="MsoNormal"> </p>
                                  <p class="MsoNormal">Regards,</p>
                                  <p class="MsoNormal">  Felix</p>
                                  <p class="MsoNormal"> </p>
                                  <div>
                                    <div style="border:none;
                                      border-top:solid #E1E1E1 1.0pt;
                                      padding:3.0pt 0in 0in 0in">
                                      <p class="MsoNormal"><b>From:</b>
                                        Koenig, Christian <br>
                                        <b>Sent:</b> Thursday, September
                                        27, 2018 3:00 AM<br>
                                        <b>To:</b> Kuehling, Felix <a
                                          href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org"
                                          moz-do-not-send="true">&lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                                        <b>Cc:</b> Yang, Philip <a
                                          href="mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org"
                                          moz-do-not-send="true">&lt;Philip.Yang-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                                        <a
                                          href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                                          moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
                                        Jerome Glisse <a
                                          href="mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                                          moz-do-not-send="true">&lt;j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
                                        <b>Subject:</b> RE: [PATCH]
                                        drm/amdgpu: use HMM mirror
                                        callback to replace mmu notifier
                                        v4</p>
                                    </div>
                                  </div>
                                  <p class="MsoNormal"> </p>
                                  <div>
                                    <div>
                                      <p class="MsoNormal">No, that
                                        won't work. We would still run
                                        into lock inversion problems.</p>
                                      <div>
                                        <p class="MsoNormal"> </p>
                                      </div>
                                      <div>
                                        <p class="MsoNormal">What we
                                          could do with the scheduler is
                                          to turn submissions into
                                          dummies if we find that the
                                          page tables are now outdated.</p>
                                      </div>
                                      <div>
                                        <p class="MsoNormal"> </p>
                                      </div>
                                      <div>
                                        <p class="MsoNormal">But that
                                          would be really hacky and I'm
                                          not sure if that would really
                                          work in all cases.</p>
                                      </div>
                                      <div>
                                        <p class="MsoNormal"> </p>
                                      </div>
                                      <div>
                                        <p class="MsoNormal">Christian.</p>
                                      </div>
                                    </div>
                                    <div>
                                      <p class="MsoNormal"> </p>
                                      <div>
                                        <p class="MsoNormal">Am
                                          27.09.2018 08:53 schrieb
                                          "Kuehling, Felix" &lt;<a
                                            href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org"
                                            moz-do-not-send="true">Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt;:</p>
                                      </div>
                                    </div>
                                  </div>
                                  <div>
                                    <p class="MsoNormal">I had a chat
                                      with Jerome yesterday. He pointed
                                      out that the new blockable
                                      parameter can be used to infer
                                      whether the MMU notifier is being
                                      called  in a reclaim operation. So
                                      if blockable==true, it should even
                                      be safe to take the BO reservation
                                      lock without problems. I think
                                      with that we should be able to
                                      remove the read-write locking
                                      completely and go back to locking
                                      (or try-locking for
                                      blockable==false) the reservation
                                      locks in the MMU notifier?<br>
                                      <br>
                                      Regards,<br>
                                        Felix<br>
                                      <br>
                                      -----Original Message-----<br>
                                      From: amd-gfx &lt;<a
                                        href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                                        moz-do-not-send="true">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;
                                      On Behalf Of Christian König<br>
                                      Sent: Saturday, September 15, 2018
                                      3:47 AM<br>
                                      To: Kuehling, Felix &lt;<a
                                        href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org"
                                        moz-do-not-send="true">Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                                      Yang, Philip &lt;<a
                                        href="mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org"
                                        moz-do-not-send="true">Philip.Yang-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                                      <a
                                        href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                                        moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
                                      Jerome Glisse &lt;<a
                                        href="mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                                        moz-do-not-send="true">j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
                                      Subject: Re: [PATCH] drm/amdgpu:
                                      use HMM mirror callback to replace
                                      mmu notifier v4<br>
                                      <br>
                                      Am 14.09.2018 um 22:21 schrieb
                                      Felix Kuehling:<br>
                                      &gt; On 2018-09-14 01:52 PM,
                                      Christian König wrote:<br>
                                      &gt;&gt; Am 14.09.2018 um 19:47
                                      schrieb Philip Yang:<br>
                                      &gt;&gt;&gt; On 2018-09-14 03:51
                                      AM, Christian König wrote:<br>
                                      &gt;&gt;&gt;&gt; Am 13.09.2018 um
                                      23:51 schrieb Felix Kuehling:<br>
                                      &gt;&gt;&gt;&gt;&gt; On 2018-09-13
                                      04:52 PM, Philip Yang wrote:<br>
                                      &gt;&gt;&gt;&gt;&gt; [SNIP]<br>
                                      &gt;&gt;&gt;&gt;&gt;&gt;    +   
                                      amdgpu_mn_read_unlock(amn);<br>
                                      &gt;&gt;&gt;&gt;&gt;&gt; +<br>
                                      &gt;&gt;&gt;&gt;&gt;
                                      amdgpu_mn_read_lock/unlock support
                                      recursive locking for multiple <br>
                                      &gt;&gt;&gt;&gt;&gt; overlapping
                                      or nested invalidation ranges. But
                                      if you'r locking <br>
                                      &gt;&gt;&gt;&gt;&gt; and unlocking
                                      in the same function. Is that
                                      still a concern?<br>
                                      &gt;&gt;&gt; I don't understand
                                      the possible recursive case, but<br>
                                      &gt;&gt;&gt; amdgpu_mn_read_lock()
                                      still support recursive locking.<br>
                                      &gt;&gt;&gt;&gt; Well the real
                                      problem is that unlocking them
                                      here won't work.<br>
                                      &gt;&gt;&gt;&gt;<br>
                                      &gt;&gt;&gt;&gt; We need to hold
                                      the lock until we are sure that
                                      the operation which <br>
                                      &gt;&gt;&gt;&gt; updates the page
                                      tables is completed.<br>
                                      &gt;&gt;&gt;&gt;<br>
                                      &gt;&gt;&gt; The reason for this
                                      change is because hmm mirror has <br>
                                      &gt;&gt;&gt; invalidate_start
                                      callback, no invalidate_end
                                      callback<br>
                                      &gt;&gt;&gt;<br>
                                      &gt;&gt;&gt; Check mmu_notifier.c
                                      and hmm.c again, below is entire
                                      logic to <br>
                                      &gt;&gt;&gt; update CPU page
                                      tables and callback:<br>
                                      &gt;&gt;&gt;<br>
                                      &gt;&gt;&gt; mn lock amn-&gt;lock
                                      is used to protect interval tree
                                      access because <br>
                                      &gt;&gt;&gt; user may
                                      submit/register new userptr
                                      anytime.<br>
                                      &gt;&gt;&gt; This is same for old
                                      and new way.<br>
                                      &gt;&gt;&gt;<br>
                                      &gt;&gt;&gt; step 2 guarantee the
                                      GPU operation is done before
                                      updating CPU page <br>
                                      &gt;&gt;&gt; table.<br>
                                      &gt;&gt;&gt;<br>
                                      &gt;&gt;&gt; So I think the change
                                      is safe. We don't need hold mn
                                      lock until the <br>
                                      &gt;&gt;&gt; CPU page tables
                                      update is completed.<br>
                                      &gt;&gt; No, that isn't even
                                      remotely correct. The lock doesn't
                                      protects the <br>
                                      &gt;&gt; interval tree.<br>
                                      &gt;&gt;<br>
                                      &gt;&gt;&gt; Old:<br>
                                      &gt;&gt;&gt;     1.
                                      down_read_non_owner(&amp;amn-&gt;lock)<br>
                                      &gt;&gt;&gt;     2. loop to handle
                                      BOs from node-&gt;bos through
                                      interval tree<br>
                                      &gt;&gt;&gt; amn-&gt;object nodes<br>
                                      &gt;&gt;&gt;         gfx: wait for
                                      pending BOs fence operation done,
                                      mark user <br>
                                      &gt;&gt;&gt; pages dirty<br>
                                      &gt;&gt;&gt;         kfd: evict
                                      user queues of the process, wait
                                      for queue <br>
                                      &gt;&gt;&gt; unmap/map operation
                                      done<br>
                                      &gt;&gt;&gt;     3. update CPU
                                      page tables<br>
                                      &gt;&gt;&gt;     4.
                                      up_read(&amp;amn-&gt;lock)<br>
                                      &gt;&gt;&gt;<br>
                                      &gt;&gt;&gt; New, switch step 3
                                      and 4<br>
                                      &gt;&gt;&gt;     1.
                                      down_read_non_owner(&amp;amn-&gt;lock)<br>
                                      &gt;&gt;&gt;     2. loop to handle
                                      BOs from node-&gt;bos through
                                      interval tree<br>
                                      &gt;&gt;&gt; amn-&gt;object nodes<br>
                                      &gt;&gt;&gt;         gfx: wait for
                                      pending BOs fence operation done,
                                      mark user <br>
                                      &gt;&gt;&gt; pages dirty<br>
                                      &gt;&gt;&gt;         kfd: evict
                                      user queues of the process, wait
                                      for queue <br>
                                      &gt;&gt;&gt; unmap/map operation
                                      done<br>
                                      &gt;&gt;&gt;     3.
                                      up_read(&amp;amn-&gt;lock)<br>
                                      &gt;&gt;&gt;     4. update CPU
                                      page tables<br>
                                      &gt;&gt; The lock is there to make
                                      sure that we serialize page table
                                      updates <br>
                                      &gt;&gt; with command submission.<br>
                                      &gt; As I understand it, the idea
                                      is to prevent command submission
                                      (adding <br>
                                      &gt; new fences to BOs) while a
                                      page table invalidation is in
                                      progress.<br>
                                      <br>
                                      Yes, exactly.<br>
                                      <br>
                                      &gt; But do we really need another
                                      lock for this? Wouldn't the <br>
                                      &gt; re-validation of userptr BOs
                                      (currently calling get_user_pages)
                                      force <br>
                                      &gt; synchronization with the
                                      ongoing page table invalidation
                                      through the <br>
                                      &gt; mmap_sem or other MM locks?<br>
                                      <br>
                                      No and yes. We don't hold any
                                      other locks while doing command
                                      submission, but I expect that HMM
                                      has its own mechanism to prevent
                                      that.<br>
                                      <br>
                                      Since we don't modify
                                      amdgpu_mn_lock()/amdgpu_mn_unlock()
                                      we are certainly not using this
                                      mechanism correctly.<br>
                                      <br>
                                      Regards,<br>
                                      Christian.<br>
_______________________________________________<br>
                                      amd-gfx mailing list<br>
                                      <a
                                        href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                                        moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                                      <a
                                        href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                                        moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></p>
                                  </div>
                                </blockquote>
                                <p class="MsoNormal"> </p>
                              </blockquote>
                              <p class="MsoNormal"> </p>
                            </blockquote>
                            <p class="MsoNormal"> </p>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </blockquote>
                <br>
              </blockquote>
              <br>
            </div>
          </blockquote>
          <br>
        </div>
        <br>
        <fieldset class="mimeAttachmentHeader"></fieldset>
        <br>
        <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
      </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------73E1B79DB3029D5E6EFAA05C--

--===============0679816235==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0679816235==--
