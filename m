From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: use HMM mirror callback to replace mmu
 notifier v4
Date: Thu, 27 Sep 2018 17:36:05 +0200
Message-ID: <11ba3857-9bb0-648e-2806-0533090d9a0a@amd.com>
References: <1536871954-8451-1-git-send-email-Philip.Yang@amd.com>
 <e4cf7212-4340-8639-c8c1-057e4d1083f0@amd.com>
 <DM5PR12MB17078469EB6D3AF1D53B788992140@DM5PR12MB1707.namprd12.prod.outlook.com>
 <a76b71ac-4b5b-45d7-b48b-6d0e4a7e7524@email.android.com>
 <DM5PR12MB1707D5E46617B2936F800F1992140@DM5PR12MB1707.namprd12.prod.outlook.com>
 <d752c19b-6d2e-c7c1-1cd7-651e25b8f708@amd.com>
 <DM5PR12MB17077A78E0F95BFBA57F2E1A92140@DM5PR12MB1707.namprd12.prod.outlook.com>
 <425fe859-c780-48a5-a2c6-c3bf2b9abb38@amd.com>
 <DM5PR12MB17072AE77EB0DE3AD22B8D7892140@DM5PR12MB1707.namprd12.prod.outlook.com>
 <9b427976-f2ff-8ba1-6ebf-588ca95aef80@amd.com>
 <DM5PR12MB17072879EC907150027D6F7892140@DM5PR12MB1707.namprd12.prod.outlook.com>
 <58199419-e20f-4ab0-ac1d-a7eb79f5c6f7@email.android.com>
 <DM5PR12MB1707273AC4B0C03A3BEDF73092140@DM5PR12MB1707.namprd12.prod.outlook.com>
 <1068c389-56fc-4125-ac40-b1ef2d60eabd@email.android.com>
 <DM5PR12MB1707BCD7BFC10EDD594FE90B92140@DM5PR12MB1707.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0388167700=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB1707BCD7BFC10EDD594FE90B92140-2J9CzHegvk9TCtO+SvGBKwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
Cc: "j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0388167700==
Content-Type: multipart/alternative;
 boundary="------------1C053D5C9BD0F04DD26B224D"
Content-Language: en-US

--------------1C053D5C9BD0F04DD26B224D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Yeah, I've read that as well.

My best guess is that we just need to add a call to hmm_vma_range_done() 
after taking the lock and also replace get_user_pages() with 
hmm_vma_get_pfns().

But I'm still not 100% sure how all of that is supposed to work together.

Regards,
Christian.

Am 27.09.2018 um 16:50 schrieb Kuehling, Felix:
>
> I think the answer is here: 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/vm/hmm.rst#n216
>
> Regards,
>
>   Felix
>
> *From:*Koenig, Christian
> *Sent:* Thursday, September 27, 2018 10:30 AM
> *To:* Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
> *Cc:* j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; Yang, Philip <Philip.Yang-5C7GfCeVMHo@public.gmane.org>; 
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* RE: [PATCH] drm/amdgpu: use HMM mirror callback to replace 
> mmu notifier v4
>
> At least with get_user_pages() that is perfectly possible.
>
> For HMM it could be that this is prevented somehow.
>
> Christian.
>
> Am 27.09.2018 16:27 schrieb "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org 
> <mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>>:
>
> > In this case you can end up accessing pages which are invalidated while 
> get_user_pages is in process.
>
> What’s the sequence of events you have in mind? Something like this?
>
>   * Page table is updated and triggers MMU notifier
>   * amdgpu MMU notifier runs and waits for pending CS to finish while
>     holding the read lock
>   * New CS starts just after invalidate_range_start MMU notifier
>     finishes but before the page table update is done
>   * get_user_pages returns outdated physical addresses
>
> I hope that’s not actually possible and that get_user_pages or 
> hmm_vma_fault would block until the page table update is done. That 
> is, invalidate_range_start marks the start of a page table update, and 
> while that update is in progress, get_user_pages or hmm_vma_fault 
> block. Jerome, can you comment on that?
>
> Thanks,
>   Felix
>
> *From:*Koenig, Christian
> *Sent:* Thursday, September 27, 2018 9:59 AM
> *To:* Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org 
> <mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>>
> *Cc:* Yang, Philip <Philip.Yang-5C7GfCeVMHo@public.gmane.org <mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org>>; 
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; 
> Jerome Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
> *Subject:* RE: [PATCH] drm/amdgpu: use HMM mirror callback to replace 
> mmu notifier v4
>
> Yeah I understand that, but again that won't work.
>
> In this case you can end up accessing pages which are invalidated 
> while get_user_pages is in process.
>
> Christian.
>
> Am 27.09.2018 15:41 schrieb "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org 
> <mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>>:
>
> > I’m not planning to change that. I don’t think there is any need to 
> change it.
>
> >
> > Yeah, but when HMM doesn't provide both the start and the end hock 
> of the invalidation this way won't work any more.
> >
> > So we need to find a solution for this,
> > Christian.
>
> My whole argument is that you don’t need to hold the read lock until 
> the invalidate_range_end. Just read_lock and read_unlock in the 
> invalidate_range_start function.
>
> Regards,
>
> Felix
>
> *From:*Koenig, Christian
> *Sent:* Thursday, September 27, 2018 9:22 AM
> *To:* Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org 
> <mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>>
> *Cc:* Yang, Philip <Philip.Yang-5C7GfCeVMHo@public.gmane.org <mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org>>; 
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; 
> Jerome Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
> *Subject:* Re: [PATCH] drm/amdgpu: use HMM mirror callback to replace 
> mmu notifier v4
>
> Am 27.09.2018 um 15:18 schrieb Kuehling, Felix:
>
>     > The problem is here:
>     >
>
>     > ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
>
>     > amdgpu_mn_unlock(p->mn);
>
>     >
>     > We need to hold the lock until the fence is added to the
>     reservation object.
>     >
>     > Otherwise somebody could have changed the page tables just in
>     the moment between the check of
>     amdgpu_ttm_tt_userptr_needs_pages() and adding the fence to the
>     reservation object.
>
>     I’m not planning to change that. I don’t think there is any need
>     to change it.
>
>
> Yeah, but when HMM doesn't provide both the start and the end hock of 
> the invalidation this way won't work any more.
>
> So we need to find a solution for this,
> Christian.
>
>     Regards,
>
>     Felix
>
>     *From:*Koenig, Christian
>     *Sent:* Thursday, September 27, 2018 7:24 AM
>     *To:* Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
>     <mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
>     *Cc:* Yang, Philip <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
>     <mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>     <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Jerome Glisse
>     <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> <mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>     *Subject:* Re: [PATCH] drm/amdgpu: use HMM mirror callback to
>     replace mmu notifier v4
>
>     Am 27.09.2018 um 13:08 schrieb Kuehling, Felix:
>
>         > We double check that there wasn't any page table
>         modification while we prepared the submission and restart the
>         whole process when there actually was some update.
>         >
>         > The reason why we need to do this is here:
>         >
>
>         > ttm_eu_fence_buffer_objects(&p->ticket, &p->validated,
>         p->fence);
>         >        amdgpu_mn_unlock(p->mn);
>
>         >
>         > Only after the new fence is added to the buffer object we
>         can release the lock so that any invalidation will now block
>         on our command submission to finish before it modifies the
>         page table.
>
>         I don’t see why this requires holding the read-lock until
>         invalidate_range_end. amdgpu_ttm_tt_affect_userptr gets called
>         while the mn read-lock is held in invalidate_range_start notifier.
>
>
>     That's not related to amdgpu_ttm_tt_affect_userptr(), this
>     function could actually be called outside the lock.
>
>     The problem is here:
>
>         ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
>
>         amdgpu_mn_unlock(p->mn);
>
>
>     We need to hold the lock until the fence is added to the
>     reservation object.
>
>     Otherwise somebody could have changed the page tables just in the
>     moment between the check of amdgpu_ttm_tt_userptr_needs_pages()
>     and adding the fence to the reservation object.
>
>     Regards,
>     Christian.
>
>
>         Regards,
>
>         Felix
>
>         *From:*Koenig, Christian
>         *Sent:* Thursday, September 27, 2018 5:27 AM
>         *To:* Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
>         <mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
>         *Cc:* Yang, Philip <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
>         <mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>         <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Jerome Glisse
>         <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> <mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>         *Subject:* Re: [PATCH] drm/amdgpu: use HMM mirror callback to
>         replace mmu notifier v4
>
>         That is correct, but take a look what we do when after calling
>         the amdgpu_mn_read_lock():
>
>
>                     /* No memory allocation is allowed while holding
>             the mn lock */
>                     amdgpu_mn_lock(p->mn);
>             amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
>                             struct amdgpu_bo *bo =
>             ttm_to_amdgpu_bo(e->tv.bo);
>
>                             if
>             (amdgpu_ttm_tt_userptr_needs_pages(bo->tbo.ttm)) {
>                                     r = -ERESTARTSYS;
>                                     goto error_abort;
>                             }
>                     }
>
>
>         We double check that there wasn't any page table modification
>         while we prepared the submission and restart the whole process
>         when there actually was some update.
>
>         The reason why we need to do this is here:
>
>             ttm_eu_fence_buffer_objects(&p->ticket, &p->validated,
>             p->fence);
>                     amdgpu_mn_unlock(p->mn);
>
>
>         Only after the new fence is added to the buffer object we can
>         release the lock so that any invalidation will now block on
>         our command submission to finish before it modifies the page
>         table.
>
>         The only other option would be to add the fence first and then
>         check if there was any update to the page tables.
>
>         The issue with that approach is that adding a fence can't be
>         made undone, so if we find that there actually was an update
>         to the page tables we would need to somehow turn the CS into a
>         dummy (e.g. overwrite all IBs with NOPs or something like
>         that) and still submit it.
>
>         Not sure if that is actually possible.
>
>         Regards,
>         Christian.
>
>         Am 27.09.2018 um 10:47 schrieb Kuehling, Felix:
>
>             So back to my previous question:
>
>             >> But do we really need another lock for this? Wouldn't the
>
>             >> re-validation of userptr BOs (currently calling
>             get_user_pages) force
>
>             >> synchronization with the ongoing page table
>             invalidation through the
>
>             >> mmap_sem or other MM locks?
>
>             >
>
>             > No and yes. We don't hold any other locks while doing
>             command submission, but I expect that HMM has its own
>             mechanism to prevent that.
>
>             >
>
>             > Since we don't modify
>             amdgpu_mn_lock()/amdgpu_mn_unlock() we are certainly not
>             using this mechanism correctly.
>
>             The existing amdgpu_mn_lock/unlock should block the MMU
>             notifier while a command submission is in progress. It
>             should also block command submission while an MMU notifier
>             is in progress.
>
>             What we lose with HMM is the ability to hold a read-lock
>             for the entire duration of the invalidate_range_start
>             until invalidate_range_end. As I understand it, that lock
>             is meant to prevent new command submissions while the page
>             tables are being updated by the kernel. But my point is,
>             that get_user_pages or hmm_vma_fault should do the same
>             kind of thing. Before the command submission can go ahead,
>             it needs to update the userptr addresses. If the page
>             tables are still being updated, it will block there even
>             without holding the amdgpu_mn_read_lock.
>
>             Regards,
>
>               Felix
>
>             *From:* Koenig, Christian
>             *Sent:* Thursday, September 27, 2018 3:00 AM
>             *To:* Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
>             <mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
>             *Cc:* Yang, Philip <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
>             <mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org>;
>             amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>             <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Jerome Glisse
>             <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> <mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>             *Subject:* RE: [PATCH] drm/amdgpu: use HMM mirror callback
>             to replace mmu notifier v4
>
>             No, that won't work. We would still run into lock
>             inversion problems.
>
>             What we could do with the scheduler is to turn submissions
>             into dummies if we find that the page tables are now outdated.
>
>             But that would be really hacky and I'm not sure if that
>             would really work in all cases.
>
>             Christian.
>
>             Am 27.09.2018 08:53 schrieb "Kuehling, Felix"
>             <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org <mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>>:
>
>             I had a chat with Jerome yesterday. He pointed out that
>             the new blockable parameter can be used to infer whether
>             the MMU notifier is being called  in a reclaim operation.
>             So if blockable==true, it should even be safe to take the
>             BO reservation lock without problems. I think with that we
>             should be able to remove the read-write locking completely
>             and go back to locking (or try-locking for
>             blockable==false) the reservation locks in the MMU notifier?
>
>             Regards,
>               Felix
>
>             -----Original Message-----
>             From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>             <mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>> On Behalf
>             Of Christian König
>             Sent: Saturday, September 15, 2018 3:47 AM
>             To: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org
>             <mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>>; Yang, Philip
>             <Philip.Yang-5C7GfCeVMHo@public.gmane.org <mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org>>;
>             amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>             <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Jerome Glisse
>             <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
>             Subject: Re: [PATCH] drm/amdgpu: use HMM mirror callback
>             to replace mmu notifier v4
>
>             Am 14.09.2018 um 22:21 schrieb Felix Kuehling:
>             > On 2018-09-14 01:52 PM, Christian König wrote:
>             >> Am 14.09.2018 um 19:47 schrieb Philip Yang:
>             >>> On 2018-09-14 03:51 AM, Christian König wrote:
>             >>>> Am 13.09.2018 um 23:51 schrieb Felix Kuehling:
>             >>>>> On 2018-09-13 04:52 PM, Philip Yang wrote:
>             >>>>> [SNIP]
>             >>>>>>    + amdgpu_mn_read_unlock(amn);
>             >>>>>> +
>             >>>>> amdgpu_mn_read_lock/unlock support recursive locking
>             for multiple
>             >>>>> overlapping or nested invalidation ranges. But if
>             you'r locking
>             >>>>> and unlocking in the same function. Is that still a
>             concern?
>             >>> I don't understand the possible recursive case, but
>             >>> amdgpu_mn_read_lock() still support recursive locking.
>             >>>> Well the real problem is that unlocking them here
>             won't work.
>             >>>>
>             >>>> We need to hold the lock until we are sure that the
>             operation which
>             >>>> updates the page tables is completed.
>             >>>>
>             >>> The reason for this change is because hmm mirror has
>             >>> invalidate_start callback, no invalidate_end callback
>             >>>
>             >>> Check mmu_notifier.c and hmm.c again, below is entire
>             logic to
>             >>> update CPU page tables and callback:
>             >>>
>             >>> mn lock amn->lock is used to protect interval tree
>             access because
>             >>> user may submit/register new userptr anytime.
>             >>> This is same for old and new way.
>             >>>
>             >>> step 2 guarantee the GPU operation is done before
>             updating CPU page
>             >>> table.
>             >>>
>             >>> So I think the change is safe. We don't need hold mn
>             lock until the
>             >>> CPU page tables update is completed.
>             >> No, that isn't even remotely correct. The lock doesn't
>             protects the
>             >> interval tree.
>             >>
>             >>> Old:
>             >>>     1. down_read_non_owner(&amn->lock)
>             >>>     2. loop to handle BOs from node->bos through
>             interval tree
>             >>> amn->object nodes
>             >>>         gfx: wait for pending BOs fence operation
>             done, mark user
>             >>> pages dirty
>             >>>         kfd: evict user queues of the process, wait
>             for queue
>             >>> unmap/map operation done
>             >>>     3. update CPU page tables
>             >>>     4. up_read(&amn->lock)
>             >>>
>             >>> New, switch step 3 and 4
>             >>>     1. down_read_non_owner(&amn->lock)
>             >>>     2. loop to handle BOs from node->bos through
>             interval tree
>             >>> amn->object nodes
>             >>>         gfx: wait for pending BOs fence operation
>             done, mark user
>             >>> pages dirty
>             >>>         kfd: evict user queues of the process, wait
>             for queue
>             >>> unmap/map operation done
>             >>>     3. up_read(&amn->lock)
>             >>>     4. update CPU page tables
>             >> The lock is there to make sure that we serialize page
>             table updates
>             >> with command submission.
>             > As I understand it, the idea is to prevent command
>             submission (adding
>             > new fences to BOs) while a page table invalidation is in
>             progress.
>
>             Yes, exactly.
>
>             > But do we really need another lock for this? Wouldn't the
>             > re-validation of userptr BOs (currently calling
>             get_user_pages) force
>             > synchronization with the ongoing page table invalidation
>             through the
>             > mmap_sem or other MM locks?
>
>             No and yes. We don't hold any other locks while doing
>             command submission, but I expect that HMM has its own
>             mechanism to prevent that.
>
>             Since we don't modify amdgpu_mn_lock()/amdgpu_mn_unlock()
>             we are certainly not using this mechanism correctly.
>
>             Regards,
>             Christian.
>             _______________________________________________
>             amd-gfx mailing list
>             amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>             <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>             https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>


--------------1C053D5C9BD0F04DD26B224D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Yeah, I've read that as well.<br>
      <br>
      My best guess is that we just need to add a call to
      hmm_vma_range_done() after taking the lock and also replace
      get_user_pages() with hmm_vma_get_pfns().<br>
      <br>
      But I'm still not 100% sure how all of that is supposed to work
      together.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 27.09.2018 um 16:50 schrieb Kuehling, Felix:<br>
    </div>
    <blockquote type="cite"
cite="mid:DM5PR12MB1707BCD7BFC10EDD594FE90B92140-2J9CzHegvk9TCtO+SvGBKwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:Consolas;
	color:black;}
p.msonormal00, li.msonormal00, div.msonormal00
	{mso-style-name:msonormal0;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msonormal000, li.msonormal000, div.msonormal000
	{mso-style-name:msonormal00;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
p.emailquote, li.emailquote, div.emailquote
	{mso-style-name:emailquote;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:1.0pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
p.msochpdefault, li.msochpdefault, div.msochpdefault
	{mso-style-name:msochpdefault;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
span.plaintextchar0
	{mso-style-name:plaintextchar;
	font-family:Consolas;
	color:black;}
span.plaintextchar00
	{mso-style-name:plaintextchar0;
	font-family:"Calibri",sans-serif;}
span.emailstyle22
	{mso-style-name:emailstyle22;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.emailstyle23
	{mso-style-name:emailstyle23;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.emailstyle24
	{mso-style-name:emailstyle24;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.emailstyle25
	{mso-style-name:emailstyle25;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.emailstyle30
	{mso-style-name:emailstyle30;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle33
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:378866647;
	mso-list-template-ids:-897658016;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal"><span style="color:windowtext">I think the
            answer is here: <a
href="https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/vm/hmm.rst#n216"
              moz-do-not-send="true">
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/vm/hmm.rst#n216</a><o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:windowtext"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span style="color:windowtext">Regards,<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:windowtext">  Felix<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:windowtext"><o:p> </o:p></span></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b><span style="color:windowtext">From:</span></b><span
                style="color:windowtext"> Koenig, Christian
                <br>
                <b>Sent:</b> Thursday, September 27, 2018 10:30 AM<br>
                <b>To:</b> Kuehling, Felix
                <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org">&lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                <b>Cc:</b> <a class="moz-txt-link-abbreviated" href="mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>; Yang, Philip
                <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org">&lt;Philip.Yang-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <b>Subject:</b> RE: [PATCH] drm/amdgpu: use HMM mirror
                callback to replace mmu notifier v4<o:p></o:p></span></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p> </o:p></p>
        <div>
          <p class="MsoNormal"><span style="color:windowtext">At least
              with get_user_pages() that is perfectly possible.
              <o:p></o:p></span></p>
          <div>
            <p class="MsoNormal"><span style="color:windowtext"><o:p> </o:p></span></p>
          </div>
          <div>
            <p class="MsoNormal"><span style="color:windowtext">For HMM
                it could be that this is prevented somehow.<o:p></o:p></span></p>
          </div>
          <div>
            <p class="MsoNormal"><span style="color:windowtext"><o:p> </o:p></span></p>
          </div>
          <div>
            <p class="MsoNormal"><span style="color:windowtext">Christian.<o:p></o:p></span></p>
          </div>
        </div>
        <div>
          <p class="MsoNormal"><span style="color:windowtext"><o:p> </o:p></span></p>
          <div>
            <p class="MsoNormal"><span style="color:windowtext">Am
                27.09.2018 16:27 schrieb "Kuehling, Felix" &lt;<a
                  href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org"
                  moz-do-not-send="true">Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt;:<o:p></o:p></span></p>
          </div>
        </div>
        <div>
          <div>
            <p class="MsoNormal"><span style="color:windowtext">&gt; In
                this case you can end up accessing pages which are
                invalidated while get_user_pages is in process.</span><o:p></o:p></p>
            <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
            <p class="MsoNormal"><span style="color:windowtext">What’s
                the sequence of events you have in mind? Something like
                this?</span><o:p></o:p></p>
            <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
            <ul style="margin-top:0in" type="disc">
              <li class="MsoListParagraph"
                style="color:windowtext;margin-left:0in;mso-list:l0
                level1 lfo1">
                Page table is updated and triggers MMU notifier<o:p></o:p></li>
              <li class="MsoListParagraph"
                style="color:windowtext;margin-left:0in;mso-list:l0
                level1 lfo1">
                amdgpu MMU notifier runs and waits for pending CS to
                finish while holding the read lock<o:p></o:p></li>
              <li class="MsoListParagraph"
                style="color:windowtext;margin-left:0in;mso-list:l0
                level1 lfo1">
                New CS starts just after invalidate_range_start MMU
                notifier finishes but before the page table update is
                done<o:p></o:p></li>
              <li class="MsoListParagraph"
                style="color:windowtext;margin-left:0in;mso-list:l0
                level1 lfo1">
                get_user_pages returns outdated physical addresses<o:p></o:p></li>
            </ul>
            <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
            <p class="MsoNormal"><span style="color:windowtext">I hope
                that’s not actually possible and that get_user_pages or
                hmm_vma_fault would block until the page table update is
                done. That is, invalidate_range_start marks the start of
                a page table update, and while that update is in
                progress, get_user_pages or hmm_vma_fault block. Jerome,
                can you comment on that?</span><o:p></o:p></p>
            <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
            <p class="MsoNormal"><span style="color:windowtext">Thanks,<br>
                  Felix</span><o:p></o:p></p>
            <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
            <div>
              <div style="border:none;border-top:solid #E1E1E1
                1.0pt;padding:3.0pt 0in 0in 0in">
                <p class="MsoNormal"><b><span style="color:windowtext">From:</span></b><span
                    style="color:windowtext"> Koenig, Christian
                    <br>
                    <b>Sent:</b> Thursday, September 27, 2018 9:59 AM<br>
                    <b>To:</b> Kuehling, Felix &lt;<a
                      href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
                    <b>Cc:</b> Yang, Philip &lt;<a
                      href="mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">Philip.Yang-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                    <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                      moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
                    Jerome Glisse &lt;<a
                      href="mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                      moz-do-not-send="true">j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
                    <b>Subject:</b> RE: [PATCH] drm/amdgpu: use HMM
                    mirror callback to replace mmu notifier v4</span><o:p></o:p></p>
              </div>
            </div>
            <p class="MsoNormal"> <o:p></o:p></p>
            <div>
              <p class="MsoNormal"><span style="color:windowtext">Yeah I
                  understand that, but again that won't work.
                </span><o:p></o:p></p>
              <div>
                <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="color:windowtext">In
                    this case you can end up accessing pages which are
                    invalidated while get_user_pages is in process.</span><o:p></o:p></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
              </div>
              <div>
                <p class="MsoNormal"><span style="color:windowtext">Christian.</span><o:p></o:p></p>
              </div>
            </div>
            <div>
              <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
              <div>
                <p class="MsoNormal"><span style="color:windowtext">Am
                    27.09.2018 15:41 schrieb "Kuehling, Felix" &lt;<a
                      href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt;:</span><o:p></o:p></p>
              </div>
            </div>
            <div>
              <div>
                <p class="MsoNormal"><span style="color:windowtext">&gt;
                    I’m not planning to change that. I don’t think there
                    is any need to change it.</span><o:p></o:p></p>
                <p class="MsoNormal">&gt;<br>
                  &gt; Yeah, but when HMM doesn't provide both the start
                  and the end hock of the invalidation this way won't
                  work any more.<br>
                  &gt;<br>
                  &gt; So we need to find a solution for this,<br>
                  &gt; Christian.<o:p></o:p></p>
                <p class="MsoNormal"> <o:p></o:p></p>
                <p class="MsoNormal">My whole argument is that you don’t
                  need to hold the read lock until the
                  invalidate_range_end. Just read_lock and read_unlock
                  in the invalidate_range_start function.<o:p></o:p></p>
                <p class="MsoNormal"> <o:p></o:p></p>
                <p class="MsoNormal">Regards,<o:p></o:p></p>
                <p class="MsoNormal" style="margin-bottom:12.0pt"> 
                  Felix<o:p></o:p></p>
                <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
                <div>
                  <div style="border:none;border-top:solid #E1E1E1
                    1.0pt;padding:3.0pt 0in 0in 0in">
                    <p class="MsoNormal"><b><span
                          style="color:windowtext">From:</span></b><span
                        style="color:windowtext"> Koenig, Christian
                        <br>
                        <b>Sent:</b> Thursday, September 27, 2018 9:22
                        AM<br>
                        <b>To:</b> Kuehling, Felix &lt;<a
                          href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org"
                          moz-do-not-send="true">Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
                        <b>Cc:</b> Yang, Philip &lt;<a
                          href="mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org"
                          moz-do-not-send="true">Philip.Yang-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                        <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                          moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
                        Jerome Glisse &lt;<a
                          href="mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                          moz-do-not-send="true">j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
                        <b>Subject:</b> Re: [PATCH] drm/amdgpu: use HMM
                        mirror callback to replace mmu notifier v4</span><o:p></o:p></p>
                  </div>
                </div>
                <p class="MsoNormal"> <o:p></o:p></p>
                <div>
                  <p class="MsoNormal">Am 27.09.2018 um 15:18 schrieb
                    Kuehling, Felix:<o:p></o:p></p>
                </div>
                <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                  <p class="MsoNormal">&gt; The problem is here:<br>
                    &gt;<o:p></o:p></p>
                  <p class="MsoNormal">&gt;
                    ttm_eu_fence_buffer_objects(&amp;p-&gt;ticket,
                    &amp;p-&gt;validated, p-&gt;fence);<o:p></o:p></p>
                  <p class="MsoNormal">&gt; amdgpu_mn_unlock(p-&gt;mn);
                    <o:p></o:p></p>
                  <p class="MsoNormal" style="margin-bottom:12.0pt">&gt;<br>
                    &gt; We need to hold the lock until the fence is
                    added to the reservation object.<br>
                    &gt;<br>
                    &gt; Otherwise somebody could have changed the page
                    tables just in the moment between the check of
                    amdgpu_ttm_tt_userptr_needs_pages() and adding the
                    fence to the reservation object.<o:p></o:p></p>
                  <p class="MsoNormal"><span style="color:windowtext">I’m
                      not planning to change that. I don’t think there
                      is any need to change it.</span><o:p></o:p></p>
                </blockquote>
                <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
                  Yeah, but when HMM doesn't provide both the start and
                  the end hock of the invalidation this way won't work
                  any more.<br>
                  <br>
                  So we need to find a solution for this,<br>
                  Christian.<o:p></o:p></p>
                <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                  <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
                  <p class="MsoNormal"><span style="color:windowtext">Regards,</span><o:p></o:p></p>
                  <p class="MsoNormal"><span style="color:windowtext"> 
                      Felix</span><o:p></o:p></p>
                  <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
                  <div>
                    <div style="border:none;border-top:solid #E1E1E1
                      1.0pt;padding:3.0pt 0in 0in 0in">
                      <p class="MsoNormal"><b><span
                            style="color:windowtext">From:</span></b><span
                          style="color:windowtext"> Koenig, Christian
                          <br>
                          <b>Sent:</b> Thursday, September 27, 2018 7:24
                          AM<br>
                          <b>To:</b> Kuehling, Felix <a
                            href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org"
                            moz-do-not-send="true">&lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                          <b>Cc:</b> Yang, Philip <a
                            href="mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org"
                            moz-do-not-send="true">&lt;Philip.Yang-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                          <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                            moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
                          Jerome Glisse
                          <a href="mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                            moz-do-not-send="true">&lt;j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
                          <b>Subject:</b> Re: [PATCH] drm/amdgpu: use
                          HMM mirror callback to replace mmu notifier v4</span><o:p></o:p></p>
                    </div>
                  </div>
                  <p class="MsoNormal"> <o:p></o:p></p>
                  <div>
                    <p class="MsoNormal">Am 27.09.2018 um 13:08 schrieb
                      Kuehling, Felix:<o:p></o:p></p>
                  </div>
                  <blockquote
                    style="margin-top:5.0pt;margin-bottom:5.0pt">
                    <p class="MsoNormal">&gt; We double check that there
                      wasn't any page table modification while we
                      prepared the submission and restart the whole
                      process when there actually was some update.<br>
                      &gt;<br>
                      &gt; The reason why we need to do this is here:<br>
                      &gt;<o:p></o:p></p>
                    <p class="MsoNormal">&gt;       
                      ttm_eu_fence_buffer_objects(&amp;p-&gt;ticket,
                      &amp;p-&gt;validated, p-&gt;fence);<br>
                      &gt;        amdgpu_mn_unlock(p-&gt;mn);<o:p></o:p></p>
                    <p class="MsoNormal" style="margin-bottom:12.0pt">&gt;<br>
                      &gt; Only after the new fence is added to the
                      buffer object we can release the lock so that any
                      invalidation will now block on our command
                      submission to finish before it modifies the page
                      table.<br>
                      <br>
                      <o:p></o:p></p>
                    <p class="MsoNormal"><span style="color:windowtext">I
                        don’t see why this requires holding the
                        read-lock until invalidate_range_end.
                        amdgpu_ttm_tt_affect_userptr gets called while
                        the mn read-lock is held in
                        invalidate_range_start notifier.</span><o:p></o:p></p>
                  </blockquote>
                  <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
                    That's not related to
                    amdgpu_ttm_tt_affect_userptr(), this function could
                    actually be called outside the lock.<br>
                    <br>
                    The problem is here:<o:p></o:p></p>
                  <blockquote
                    style="margin-top:5.0pt;margin-bottom:5.0pt">
                    <p class="MsoNormal">ttm_eu_fence_buffer_objects(&amp;p-&gt;ticket,
                      &amp;p-&gt;validated, p-&gt;fence);<o:p></o:p></p>
                  </blockquote>
                  <blockquote
                    style="margin-top:5.0pt;margin-bottom:5.0pt">
                    <p class="MsoNormal">amdgpu_mn_unlock(p-&gt;mn); <o:p></o:p></p>
                  </blockquote>
                  <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
                    We need to hold the lock until the fence is added to
                    the reservation object.<br>
                    <br>
                    Otherwise somebody could have changed the page
                    tables just in the moment between the check of
                    amdgpu_ttm_tt_userptr_needs_pages() and adding the
                    fence to the reservation object.<br>
                    <br>
                    Regards,<br>
                    Christian.<br>
                    <br>
                    <br>
                    <o:p></o:p></p>
                  <blockquote
                    style="margin-top:5.0pt;margin-bottom:5.0pt">
                    <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
                    <p class="MsoNormal"><span style="color:windowtext">Regards,</span><o:p></o:p></p>
                    <p class="MsoNormal"><span style="color:windowtext"> 
                        Felix</span><o:p></o:p></p>
                    <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
                    <div>
                      <div style="border:none;border-top:solid #E1E1E1
                        1.0pt;padding:3.0pt 0in 0in 0in">
                        <p class="MsoNormal"><b><span
                              style="color:windowtext">From:</span></b><span
                            style="color:windowtext"> Koenig, Christian
                            <br>
                            <b>Sent:</b> Thursday, September 27, 2018
                            5:27 AM<br>
                            <b>To:</b> Kuehling, Felix <a
                              href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org"
                              moz-do-not-send="true">&lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                            <b>Cc:</b> Yang, Philip <a
                              href="mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org"
                              moz-do-not-send="true">&lt;Philip.Yang-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                            <a
                              href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                              moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
                            Jerome Glisse
                            <a href="mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                              moz-do-not-send="true">&lt;j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
                            <b>Subject:</b> Re: [PATCH] drm/amdgpu: use
                            HMM mirror callback to replace mmu notifier
                            v4</span><o:p></o:p></p>
                      </div>
                    </div>
                    <p class="MsoNormal"> <o:p></o:p></p>
                    <div>
                      <p class="MsoNormal" style="margin-bottom:12.0pt">That
                        is correct, but take a look what we do when
                        after calling the amdgpu_mn_read_lock():<br>
                        <br>
                        <br>
                        <o:p></o:p></p>
                      <blockquote
                        style="margin-top:5.0pt;margin-bottom:5.0pt">
                        <p class="MsoNormal">        /* No memory
                          allocation is allowed while holding the mn
                          lock */<br>
                                  amdgpu_mn_lock(p-&gt;mn);<br>
                                 
                          amdgpu_bo_list_for_each_userptr_entry(e,
                          p-&gt;bo_list) {<br>
                                          struct amdgpu_bo *bo =
                          ttm_to_amdgpu_bo(e-&gt;tv.bo);<br>
                          <br>
                                          if
                          (amdgpu_ttm_tt_userptr_needs_pages(bo-&gt;tbo.ttm))
                          {<br>
                                                  r = -ERESTARTSYS;<br>
                                                  goto error_abort;<br>
                                          }<br>
                                  }<o:p></o:p></p>
                      </blockquote>
                      <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
                        We double check that there wasn't any page table
                        modification while we prepared the submission
                        and restart the whole process when there
                        actually was some update.<br>
                        <br>
                        The reason why we need to do this is here:<br>
                        <br>
                        <o:p></o:p></p>
                      <blockquote
                        style="margin-top:5.0pt;margin-bottom:5.0pt">
                        <p class="MsoNormal">       
                          ttm_eu_fence_buffer_objects(&amp;p-&gt;ticket,
                          &amp;p-&gt;validated, p-&gt;fence);<br>
                                  amdgpu_mn_unlock(p-&gt;mn);<o:p></o:p></p>
                      </blockquote>
                      <p class="MsoNormal"><br>
                        Only after the new fence is added to the buffer
                        object we can release the lock so that any
                        invalidation will now block on our command
                        submission to finish before it modifies the page
                        table.<br>
                        <br>
                        The only other option would be to add the fence
                        first and then check if there was any update to
                        the page tables.<br>
                        <br>
                        The issue with that approach is that adding a
                        fence can't be made undone, so if we find that
                        there actually was an update to the page tables
                        we would need to somehow turn the CS into a
                        dummy (e.g. overwrite all IBs with NOPs or
                        something like that) and still submit it.<br>
                        <br>
                        Not sure if that is actually possible.<br>
                        <br>
                        Regards,<br>
                        Christian.<br>
                        <br>
                        Am 27.09.2018 um 10:47 schrieb Kuehling, Felix:<o:p></o:p></p>
                    </div>
                    <blockquote
                      style="margin-top:5.0pt;margin-bottom:5.0pt">
                      <p class="MsoNormal">So back to my previous
                        question:<o:p></o:p></p>
                      <p class="MsoPlainText"> <o:p></o:p></p>
                      <p class="MsoPlainText">&gt;&gt; But do we really
                        need another lock for this? Wouldn't the
                        <o:p></o:p></p>
                      <p class="MsoPlainText">&gt;&gt; re-validation of
                        userptr BOs (currently calling get_user_pages)
                        force
                        <o:p></o:p></p>
                      <p class="MsoPlainText">&gt;&gt; synchronization
                        with the ongoing page table invalidation through
                        the
                        <o:p></o:p></p>
                      <p class="MsoPlainText">&gt;&gt; mmap_sem or other
                        MM locks?<o:p></o:p></p>
                      <p class="MsoPlainText">&gt; <o:p></o:p></p>
                      <p class="MsoPlainText">&gt; No and yes. We don't
                        hold any other locks while doing command
                        submission, but I expect that HMM has its own
                        mechanism to prevent that.<o:p></o:p></p>
                      <p class="MsoPlainText">&gt; <o:p></o:p></p>
                      <p class="MsoPlainText">&gt; Since we don't modify
                        amdgpu_mn_lock()/amdgpu_mn_unlock() we are
                        certainly not using this mechanism correctly.<o:p></o:p></p>
                      <p class="MsoNormal"> <o:p></o:p></p>
                      <p class="MsoNormal">The existing
                        amdgpu_mn_lock/unlock should block the MMU
                        notifier while a command submission is in
                        progress. It should also block command
                        submission while an MMU notifier is in progress.<o:p></o:p></p>
                      <p class="MsoNormal"> <o:p></o:p></p>
                      <p class="MsoNormal">What we lose with HMM is the
                        ability to hold a read-lock for the entire
                        duration of the invalidate_range_start until
                        invalidate_range_end. As I understand it, that
                        lock is meant to prevent new command submissions
                        while the page tables are being updated by the
                        kernel. But my point is, that get_user_pages or
                        hmm_vma_fault should do the same kind of thing.
                        Before the command submission can go ahead, it
                        needs to update the userptr addresses. If the
                        page tables are still being updated, it will
                        block there even without holding the
                        amdgpu_mn_read_lock.<o:p></o:p></p>
                      <p class="MsoNormal"> <o:p></o:p></p>
                      <p class="MsoNormal">Regards,<o:p></o:p></p>
                      <p class="MsoNormal">  Felix<o:p></o:p></p>
                      <p class="MsoNormal"> <o:p></o:p></p>
                      <div>
                        <div style="border:none;border-top:solid #E1E1E1
                          1.0pt;padding:3.0pt 0in 0in 0in">
                          <p class="MsoNormal"><b>From:</b> Koenig,
                            Christian <br>
                            <b>Sent:</b> Thursday, September 27, 2018
                            3:00 AM<br>
                            <b>To:</b> Kuehling, Felix <a
                              href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org"
                              moz-do-not-send="true">&lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                            <b>Cc:</b> Yang, Philip <a
                              href="mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org"
                              moz-do-not-send="true">&lt;Philip.Yang-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                            <a
                              href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                              moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
                            Jerome Glisse
                            <a href="mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                              moz-do-not-send="true">&lt;j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
                            <b>Subject:</b> RE: [PATCH] drm/amdgpu: use
                            HMM mirror callback to replace mmu notifier
                            v4<o:p></o:p></p>
                        </div>
                      </div>
                      <p class="MsoNormal"> <o:p></o:p></p>
                      <div>
                        <div>
                          <p class="MsoNormal">No, that won't work. We
                            would still run into lock inversion
                            problems.<o:p></o:p></p>
                          <div>
                            <p class="MsoNormal"> <o:p></o:p></p>
                          </div>
                          <div>
                            <p class="MsoNormal">What we could do with
                              the scheduler is to turn submissions into
                              dummies if we find that the page tables
                              are now outdated.<o:p></o:p></p>
                          </div>
                          <div>
                            <p class="MsoNormal"> <o:p></o:p></p>
                          </div>
                          <div>
                            <p class="MsoNormal">But that would be
                              really hacky and I'm not sure if that
                              would really work in all cases.<o:p></o:p></p>
                          </div>
                          <div>
                            <p class="MsoNormal"> <o:p></o:p></p>
                          </div>
                          <div>
                            <p class="MsoNormal">Christian.<o:p></o:p></p>
                          </div>
                        </div>
                        <div>
                          <p class="MsoNormal"> <o:p></o:p></p>
                          <div>
                            <p class="MsoNormal">Am 27.09.2018 08:53
                              schrieb "Kuehling, Felix" &lt;<a
                                href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org"
                                moz-do-not-send="true">Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt;:<o:p></o:p></p>
                          </div>
                        </div>
                      </div>
                      <div>
                        <p class="MsoNormal">I had a chat with Jerome
                          yesterday. He pointed out that the new
                          blockable parameter can be used to infer
                          whether the MMU notifier is being called  in a
                          reclaim operation. So if blockable==true, it
                          should even be safe to take the BO reservation
                          lock without problems. I think with that we
                          should be able to remove the read-write
                          locking completely and go back to locking (or
                          try-locking for blockable==false) the
                          reservation locks in the MMU notifier?<br>
                          <br>
                          Regards,<br>
                            Felix<br>
                          <br>
                          -----Original Message-----<br>
                          From: amd-gfx &lt;<a
                            href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                            moz-do-not-send="true">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;
                          On Behalf Of Christian König<br>
                          Sent: Saturday, September 15, 2018 3:47 AM<br>
                          To: Kuehling, Felix &lt;<a
                            href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org"
                            moz-do-not-send="true">Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                          Yang, Philip &lt;<a
                            href="mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org"
                            moz-do-not-send="true">Philip.Yang-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                          <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                            moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
                          Jerome Glisse &lt;<a
                            href="mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                            moz-do-not-send="true">j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
                          Subject: Re: [PATCH] drm/amdgpu: use HMM
                          mirror callback to replace mmu notifier v4<br>
                          <br>
                          Am 14.09.2018 um 22:21 schrieb Felix Kuehling:<br>
                          &gt; On 2018-09-14 01:52 PM, Christian König
                          wrote:<br>
                          &gt;&gt; Am 14.09.2018 um 19:47 schrieb Philip
                          Yang:<br>
                          &gt;&gt;&gt; On 2018-09-14 03:51 AM, Christian
                          König wrote:<br>
                          &gt;&gt;&gt;&gt; Am 13.09.2018 um 23:51
                          schrieb Felix Kuehling:<br>
                          &gt;&gt;&gt;&gt;&gt; On 2018-09-13 04:52 PM,
                          Philip Yang wrote:<br>
                          &gt;&gt;&gt;&gt;&gt; [SNIP]<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;    +   
                          amdgpu_mn_read_unlock(amn);<br>
                          &gt;&gt;&gt;&gt;&gt;&gt; +<br>
                          &gt;&gt;&gt;&gt;&gt;
                          amdgpu_mn_read_lock/unlock support recursive
                          locking for multiple <br>
                          &gt;&gt;&gt;&gt;&gt; overlapping or nested
                          invalidation ranges. But if you'r locking <br>
                          &gt;&gt;&gt;&gt;&gt; and unlocking in the same
                          function. Is that still a concern?<br>
                          &gt;&gt;&gt; I don't understand the possible
                          recursive case, but<br>
                          &gt;&gt;&gt; amdgpu_mn_read_lock() still
                          support recursive locking.<br>
                          &gt;&gt;&gt;&gt; Well the real problem is that
                          unlocking them here won't work.<br>
                          &gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt; We need to hold the lock
                          until we are sure that the operation which <br>
                          &gt;&gt;&gt;&gt; updates the page tables is
                          completed.<br>
                          &gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt; The reason for this change is
                          because hmm mirror has <br>
                          &gt;&gt;&gt; invalidate_start callback, no
                          invalidate_end callback<br>
                          &gt;&gt;&gt;<br>
                          &gt;&gt;&gt; Check mmu_notifier.c and hmm.c
                          again, below is entire logic to <br>
                          &gt;&gt;&gt; update CPU page tables and
                          callback:<br>
                          &gt;&gt;&gt;<br>
                          &gt;&gt;&gt; mn lock amn-&gt;lock is used to
                          protect interval tree access because <br>
                          &gt;&gt;&gt; user may submit/register new
                          userptr anytime.<br>
                          &gt;&gt;&gt; This is same for old and new way.<br>
                          &gt;&gt;&gt;<br>
                          &gt;&gt;&gt; step 2 guarantee the GPU
                          operation is done before updating CPU page <br>
                          &gt;&gt;&gt; table.<br>
                          &gt;&gt;&gt;<br>
                          &gt;&gt;&gt; So I think the change is safe. We
                          don't need hold mn lock until the <br>
                          &gt;&gt;&gt; CPU page tables update is
                          completed.<br>
                          &gt;&gt; No, that isn't even remotely correct.
                          The lock doesn't protects the <br>
                          &gt;&gt; interval tree.<br>
                          &gt;&gt;<br>
                          &gt;&gt;&gt; Old:<br>
                          &gt;&gt;&gt;     1.
                          down_read_non_owner(&amp;amn-&gt;lock)<br>
                          &gt;&gt;&gt;     2. loop to handle BOs from
                          node-&gt;bos through interval tree<br>
                          &gt;&gt;&gt; amn-&gt;object nodes<br>
                          &gt;&gt;&gt;         gfx: wait for pending BOs
                          fence operation done, mark user <br>
                          &gt;&gt;&gt; pages dirty<br>
                          &gt;&gt;&gt;         kfd: evict user queues of
                          the process, wait for queue <br>
                          &gt;&gt;&gt; unmap/map operation done<br>
                          &gt;&gt;&gt;     3. update CPU page tables<br>
                          &gt;&gt;&gt;     4. up_read(&amp;amn-&gt;lock)<br>
                          &gt;&gt;&gt;<br>
                          &gt;&gt;&gt; New, switch step 3 and 4<br>
                          &gt;&gt;&gt;     1.
                          down_read_non_owner(&amp;amn-&gt;lock)<br>
                          &gt;&gt;&gt;     2. loop to handle BOs from
                          node-&gt;bos through interval tree<br>
                          &gt;&gt;&gt; amn-&gt;object nodes<br>
                          &gt;&gt;&gt;         gfx: wait for pending BOs
                          fence operation done, mark user <br>
                          &gt;&gt;&gt; pages dirty<br>
                          &gt;&gt;&gt;         kfd: evict user queues of
                          the process, wait for queue <br>
                          &gt;&gt;&gt; unmap/map operation done<br>
                          &gt;&gt;&gt;     3. up_read(&amp;amn-&gt;lock)<br>
                          &gt;&gt;&gt;     4. update CPU page tables<br>
                          &gt;&gt; The lock is there to make sure that
                          we serialize page table updates <br>
                          &gt;&gt; with command submission.<br>
                          &gt; As I understand it, the idea is to
                          prevent command submission (adding <br>
                          &gt; new fences to BOs) while a page table
                          invalidation is in progress.<br>
                          <br>
                          Yes, exactly.<br>
                          <br>
                          &gt; But do we really need another lock for
                          this? Wouldn't the <br>
                          &gt; re-validation of userptr BOs (currently
                          calling get_user_pages) force <br>
                          &gt; synchronization with the ongoing page
                          table invalidation through the <br>
                          &gt; mmap_sem or other MM locks?<br>
                          <br>
                          No and yes. We don't hold any other locks
                          while doing command submission, but I expect
                          that HMM has its own mechanism to prevent
                          that.<br>
                          <br>
                          Since we don't modify
                          amdgpu_mn_lock()/amdgpu_mn_unlock() we are
                          certainly not using this mechanism correctly.<br>
                          <br>
                          Regards,<br>
                          Christian.<br>
_______________________________________________<br>
                          amd-gfx mailing list<br>
                          <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                            moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                          <a
                            href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                            moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></p>
                      </div>
                    </blockquote>
                    <p class="MsoNormal"> <o:p></o:p></p>
                  </blockquote>
                  <p class="MsoNormal"> <o:p></o:p></p>
                </blockquote>
                <p class="MsoNormal"> <o:p></o:p></p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------1C053D5C9BD0F04DD26B224D--

--===============0388167700==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0388167700==--
