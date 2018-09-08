From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Moved fault hash table to amdgpu vm
Date: Sat, 8 Sep 2018 09:16:16 +0200
Message-ID: <bf233da4-5cd9-d7e4-1e9a-fbef3613bfd6@amd.com>
References: <1536290910-6476-1-git-send-email-Oak.Zeng@amd.com>
 <12913b70-925d-2e17-2dc2-491ed8592610@amd.com>
 <546c9911-b7af-03c8-b5e2-f2bb07932c0b@gmail.com>
 <BN6PR12MB1651779BF0B3AE84E1C4430C80000@BN6PR12MB1651.namprd12.prod.outlook.com>
 <89e7515f-53f1-9f10-aeb6-7fc1b8df2702@amd.com>
 <BN6PR12MB1651CA24220B91670A75890C80000@BN6PR12MB1651.namprd12.prod.outlook.com>
 <0e52fe27-716c-f9d3-9b2c-5540825ffcef@amd.com>
 <BN6PR12MB1651CCA8BB73DE64815EB0B280000@BN6PR12MB1651.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1295918396=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1651CCA8BB73DE64815EB0B280000-/b2+HYfkarRSqX7PDniLCgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>, Oak Zeng <zengshanjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>

--===============1295918396==
Content-Type: multipart/alternative;
 boundary="------------4CC820062F59CC991861C077"
Content-Language: en-US

--------------4CC820062F59CC991861C077
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Oak,

> >In other words when you request the address of a PT you get the 
> address where memory management has moved it, not the address where 
> the hardware is processing the fault from.
>
> Do you mean the address in the PT is what vm has mapped and the faulty 
> address need to be mapped in the PT?
>
No, the memory management is pipelined to avoid stalls during eviction.

This means that the state we manage is always the future state, e.g. 
when you walk the page tables in the VM structure you see the state 
after all the running operations completed.

In other words when a page table is pipelined for eviction you see the 
evicted state and not the current executing one.

But what we need for page fault handling is the current state and not 
the future state.

> The amdgpu_vm and amdgpu_vm_pt data structure are invented for the 
> purpose of management of page table BO. Why we need invent extra 
> structure?
We will need something like a double entry accounting for the page 
tables where we both keep the future as well as the current state.

> Think about the normal case of the page fault handling when the 
> process and vm are still alive. In the normal case, the amdgpu_vm 
> structure can meet exactly purpose of page table update.
No, the problem is not if the VM is still alive or dead but rather that 
in the case of an eviction you wouldn't be able to handle page faults 
any more.

> The said extra data structure must look very similar to the 
> amdgpu_vm/vm_pt structure. So the best way is to reuse the existing vm 
> structure, either in normal case or in process termination case.
Completely agree that we will probably need the same structure as the VM 
hierarchy offers, just with another set of information.

> Is it possible to delay the destroy of vm during process termination?
Yeah, thought about that as well. The problem with that is the OOM 
killer and that we are still not able to reliable kill running command 
submissions.

Ok you convinced me that we should probably work on that instead.

E.g. when a process has bound its address space to a VM and exits we 
need to find a way to kill all still executing jobs. We should let the 
UMD handle that case gracefully when they really need this.

Thanks,
Christian.

Am 07.09.2018 um 23:52 schrieb Zeng, Oak:
>
> Hi Christian,
>
> See comments inline
>
> Thanks,
>
> Oak
>
> *From:*Koenig, Christian
> *Sent:* Monday, September 10, 2018 7:44 AM
> *To:* Zeng, Oak <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>; Oak Zeng <zengshanjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; 
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Yang, Philip <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
> *Subject:* Re: [PATCH 1/2] drm/amdgpu: Moved fault hash table to amdgpu vm
>
> >The VM doesn't know that information either.
>
> Yes, VM doesn’t know the information. More specifically I meant we 
> need VM data structure to update PTs during page fault handling. For 
> example, we walk the 4 level page table (the first level is pointed by 
> vm->root) to figure out the entries need to be filled, allocate page 
> table entry Bos if necessary, allocate physical page for the faulty 
> address, setup 4 level page table for the faulty virtual address to 
> pointing to the allocated physical page.
>
> >In other words when you request the address of a PT you get the 
> address where memory management has moved it, not the address where 
> the hardware is processing the fault from.
>
> Do you mean the address in the PT is what vm has mapped and the faulty 
> address need to be mapped in the PT?
>
>
>
> I see only a few possible solutions for that:
> >1. We use an extra structure in the kernel driver which holds the 
> current address of the PTs and is feed by memory management when 
> buffers move around.
>
> The amdgpu_vm and amdgpu_vm_pt data structure are invented for the 
> purpose of management of page table BO. Why we need invent extra 
> structure? Think about the normal case of the page fault handling when 
> the process and vm are still alive. In the normal case, the amdgpu_vm 
> structure can meet exactly purpose of page table update.
>
> The said extra data structure must look very similar to the 
> amdgpu_vm/vm_pt structure. So the best way is to reuse the existing vm 
> structure, either in normal case or in process termination case. Is it 
> possible to delay the destroy of vm during process termination?
>
>
> >2. We change the SDMA firmware to do the walk for us and update the 
> PTEs based on the information in the page directory.
>
> As the page table BO need to be freed later. You still need to manage 
> them in the driver. SDMA FW can walk and update but it need 
> information from driver side. Driver still need a similar struct like 
> amdgpu_vm.
>
>
> >3. We use the UTCL walker to get us to the correct address which is 
> then updated with the SDMA.
> I don’t quite understand your point here. What do you mean by “correct 
> address”? Do you mean the physical address to be filled to the page 
> table? If this is your meaning, how UTCL2 knows this information – the 
> physical address has to be allocated/validated through driver.
>
>
> Regards,
> Christian.
>
> Am 07.09.2018 um 17:30 schrieb Zeng, Oak:
>
>     Without a VM, how can you get the physical address of the faulty
>     virtual address? Where this information should be hold?
>
>     Thanks,
>
>     Oak
>
>     *From:*Koenig, Christian
>     *Sent:* Monday, September 10, 2018 7:20 AM
>     *To:* Zeng, Oak <Oak.Zeng-5C7GfCeVMHo@public.gmane.org> <mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org>; Oak
>     Zeng <zengshanjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> <mailto:zengshanjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>;
>     amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>     <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Yang, Philip
>     <Philip.Yang-5C7GfCeVMHo@public.gmane.org> <mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org>
>     *Subject:* Re: [PATCH 1/2] drm/amdgpu: Moved fault hash table to
>     amdgpu vm
>
>         Am I right that the handling of page fault need a valid VM?
>
>     No, exactly that view is incorrect.
>
>     The VM is meant to be a memory management structure of page tables
>     and is completely pointless fault processing because it represent
>     the future state of the page tables and not the current one.
>
>     What we need for fault processing is a new structure build around
>     PASIDs which is feed by the with addresses when page tables are
>     moved around.
>
>     Alternatively I hope that we can use the SDMA to walk the page
>     tables and update the required entries by just using the address.
>
>     Regards,
>     Christian.
>
>     Am 07.09.2018 um 16:55 schrieb Zeng, Oak:
>
>         Hi Christian,
>
>         What is the value of delay the destroy of hash to after vm is
>         destroyed? Since vm is destroyed, you basically don’t have
>         enough information to paging in the correct page to gpuvm. Am
>         I right that the handling of page fault need a valid VM? For
>         example, you need the VM to get the corresponding physical
>         address of the faulty page.
>
>         After vm is destroyed, the retry interrupt can be directly
>         discard as you can’t find vm through pasid. You can think this
>         is also one kind of prescreen.
>
>         So I am stand for the point that, there is no need to delay
>         the destroy of hash to after vm is destroyed. Prescreening
>         hash can be destroyed at the time of vm_fini.
>
>         Thanks,
>
>         Oak
>
>         *From:*Christian König <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>         <mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>         *Sent:* Friday, September 07, 2018 4:39 AM
>         *To:* Zeng, Oak <Oak.Zeng-5C7GfCeVMHo@public.gmane.org> <mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org>;
>         Oak Zeng <zengshanjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>         <mailto:zengshanjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>         <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>         *Cc:* Zeng, Oak <Oak.Zeng-5C7GfCeVMHo@public.gmane.org> <mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
>         *Subject:* Re: [PATCH 1/2] drm/amdgpu: Moved fault hash table
>         to amdgpu vm
>
>         Hi Oak,
>
>         yeah, but this is still a NAK. Making the hash per PASID was
>         not a suggestion but rather a must have.
>
>         The VM structures must be destroyed while the processing is
>         still ongoing, or otherwise we would not have a clean OOM
>         handling.
>
>         The IDR for PASID lockup can be put into amdgpu_ids.c, you can
>         just replace the IDA already used there with an IDR.
>
>         Since the PASID is already freed up delayed we should have the
>         grace period for interrupt processing included. If that still
>         isn't sufficient we can still add some delayed work for this.
>
>         Regards,
>         Christian.
>
>         Am 07.09.2018 um 06:16 schrieb ozeng:
>
>             Hi Christian,
>
>             In this implementation, fault hash is made per vm, not per
>             pasid as suggested, based on below considerations:
>
>               * Delay the destroy of hash introduces more effort like
>                 how to set the proper grace period after which no
>                 retry interrupt will be generated. We want to avoid
>                 those complication if we can.
>               * The  problem of the per vm implementation is that it
>                 is hard to delay the destroy of fault hash, because
>                 when vm is destroyed, prescreen function won't be able
>                 to retrieve the fault hash. But in this case, the
>                 prescreen function can either let the interrupt go
>                 through (to gmc) or ignore it. From this perspective,
>                 it is not very necessary to delay the destroy of hash
>                 table.
>               * On the other hand, since ASICs after vega10 have the
>                 HW CAM feature. So the SW IV prescreen is only useful
>                 for vega10. For all the HW implemented CAM, we can
>                 consider the delayed CAM acknowledgment.
>               * Making it per pasid need to introduce another idr to
>                 correlate pasid and hash table - where to put the idr?
>                 You will have to make it a global variable which is
>                 not very desirable.
>
>             The main purpose of this patch is to solve the
>             inter-process lock issue (when hash table is full), while
>             still keep codes simple.
>
>             Also with this patch, the faults kfifo is not necessary
>             any more. See patch 2.
>
>             Regards,
>
>             Oak
>
>             On 09/06/2018 11:28 PM, Oak Zeng wrote:
>
>                 In stead of share one fault hash table per device, make it
>
>                 per vm. This can avoid inter-process lock issue when fault
>
>                 hash table is full.
>
>                   
>
>                 Change-Id: I5d1281b7c41eddc8e26113e010516557588d3708
>
>                 Signed-off-by: Oak Zeng<Oak.Zeng-5C7GfCeVMHo@public.gmane.org> <mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
>
>                 Suggested-by: Christian Konig<Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
>                 <mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
>
>                 Suggested-by: Felix Kuehling<Felix.Kuehling-5C7GfCeVMHo@public.gmane.org> <mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
>
>                 ---
>
>                   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c |  75 ------------------------
>
>                   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h |  10 ----
>
>                   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 102 ++++++++++++++++++++++++++++++++-
>
>                   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  12 ++++
>
>                   drivers/gpu/drm/amd/amdgpu/vega10_ih.c |  38 +++++-------
>
>                   5 files changed, 127 insertions(+), 110 deletions(-)
>
>                   
>
>                 diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>
>                 index 06373d4..4ed8621 100644
>
>                 --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>
>                 +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>
>                 @@ -197,78 +197,3 @@ int amdgpu_ih_process(struct amdgpu_device *adev)
>
>                     return IRQ_HANDLED;
>
>                   }
>
>                   
>
>                 -/**
>
>                 - * amdgpu_ih_add_fault - Add a page fault record
>
>                 - *
>
>                 - * @adev: amdgpu device pointer
>
>                 - * @key: 64-bit encoding of PASID and address
>
>                 - *
>
>                 - * This should be called when a retry page fault interrupt is
>
>                 - * received. If this is a new page fault, it will be added to a hash
>
>                 - * table. The return value indicates whether this is a new fault, or
>
>                 - * a fault that was already known and is already being handled.
>
>                 - *
>
>                 - * If there are too many pending page faults, this will fail. Retry
>
>                 - * interrupts should be ignored in this case until there is enough
>
>                 - * free space.
>
>                 - *
>
>                 - * Returns 0 if the fault was added, 1 if the fault was already known,
>
>                 - * -ENOSPC if there are too many pending faults.
>
>                 - */
>
>                 -int amdgpu_ih_add_fault(struct amdgpu_device *adev, u64 key)
>
>                 -{
>
>                 -  unsigned long flags;
>
>                 -  int r = -ENOSPC;
>
>                 -
>
>                 -  if (WARN_ON_ONCE(!adev->irq.ih.faults))
>
>                 -          /* Should be allocated in <IP>_ih_sw_init on GPUs that
>
>                 -           * support retry faults and require retry filtering.
>
>                 -           */
>
>                 -          return r;
>
>                 -
>
>                 -  spin_lock_irqsave(&adev->irq.ih.faults->lock, flags);
>
>                 -
>
>                 -  /* Only let the hash table fill up to 50% for best performance */
>
>                 -  if (adev->irq.ih.faults->count >= (1 << (AMDGPU_PAGEFAULT_HASH_BITS-1)))
>
>                 -          goto unlock_out;
>
>                 -
>
>                 -  r = chash_table_copy_in(&adev->irq.ih.faults->hash, key, NULL);
>
>                 -  if (!r)
>
>                 -          adev->irq.ih.faults->count++;
>
>                 -
>
>                 -  /* chash_table_copy_in should never fail unless we're losing count */
>
>                 -  WARN_ON_ONCE(r < 0);
>
>                 -
>
>                 -unlock_out:
>
>                 -  spin_unlock_irqrestore(&adev->irq.ih.faults->lock, flags);
>
>                 -  return r;
>
>                 -}
>
>                 -
>
>                 -/**
>
>                 - * amdgpu_ih_clear_fault - Remove a page fault record
>
>                 - *
>
>                 - * @adev: amdgpu device pointer
>
>                 - * @key: 64-bit encoding of PASID and address
>
>                 - *
>
>                 - * This should be called when a page fault has been handled. Any
>
>                 - * future interrupt with this key will be processed as a new
>
>                 - * page fault.
>
>                 - */
>
>                 -void amdgpu_ih_clear_fault(struct amdgpu_device *adev, u64 key)
>
>                 -{
>
>                 -  unsigned long flags;
>
>                 -  int r;
>
>                 -
>
>                 -  if (!adev->irq.ih.faults)
>
>                 -          return;
>
>                 -
>
>                 -  spin_lock_irqsave(&adev->irq.ih.faults->lock, flags);
>
>                 -
>
>                 -  r = chash_table_remove(&adev->irq.ih.faults->hash, key, NULL);
>
>                 -  if (!WARN_ON_ONCE(r < 0)) {
>
>                 -          adev->irq.ih.faults->count--;
>
>                 -          WARN_ON_ONCE(adev->irq.ih.faults->count < 0);
>
>                 -  }
>
>                 -
>
>                 -  spin_unlock_irqrestore(&adev->irq.ih.faults->lock, flags);
>
>                 -}
>
>                 diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>
>                 index a23e1c0..f411ffb 100644
>
>                 --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>
>                 +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
>
>                 @@ -32,13 +32,6 @@ struct amdgpu_device;
>
>                   #define AMDGPU_IH_CLIENTID_LEGACY 0
>
>                   #define AMDGPU_IH_CLIENTID_MAX SOC15_IH_CLIENTID_MAX
>
>                   
>
>                 -#define AMDGPU_PAGEFAULT_HASH_BITS 8
>
>                 -struct amdgpu_retryfault_hashtable {
>
>                 -  DECLARE_CHASH_TABLE(hash, AMDGPU_PAGEFAULT_HASH_BITS, 8, 0);
>
>                 -  spinlock_t     lock;
>
>                 -  int            count;
>
>                 -};
>
>                 -
>
>                   /*
>
>                    * R6xx+ IH ring
>
>                    */
>
>                 @@ -57,7 +50,6 @@ struct amdgpu_ih_ring {
>
>                     bool                   use_doorbell;
>
>                     bool                   use_bus_addr;
>
>                     dma_addr_t             rb_dma_addr; /* only used when use_bus_addr = true */
>
>                 -  struct amdgpu_retryfault_hashtable *faults;
>
>                   };
>
>                   
>
>                   #define AMDGPU_IH_SRC_DATA_MAX_SIZE_DW 4
>
>                 @@ -95,7 +87,5 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, unsigned ring_size,
>
>                                     bool use_bus_addr);
>
>                   void amdgpu_ih_ring_fini(struct amdgpu_device *adev);
>
>                   int amdgpu_ih_process(struct amdgpu_device *adev);
>
>                 -int amdgpu_ih_add_fault(struct amdgpu_device *adev, u64 key);
>
>                 -void amdgpu_ih_clear_fault(struct amdgpu_device *adev, u64 key);
>
>                   
>
>                   #endif
>
>                 diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>
>                 index 1d7e3c1..8b220e9 100644
>
>                 --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>
>                 +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>
>                 @@ -2692,6 +2692,22 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
>
>                              adev->vm_manager.fragment_size);
>
>                   }
>
>                   
>
>                 +static struct amdgpu_retryfault_hashtable *init_fault_hash(void)
>
>                 +{
>
>                 +  struct amdgpu_retryfault_hashtable *fault_hash;
>
>                 +
>
>                 +  fault_hash = kmalloc(sizeof(*fault_hash), GFP_KERNEL);
>
>                 +  if (!fault_hash)
>
>                 +          return fault_hash;
>
>                 +
>
>                 +  INIT_CHASH_TABLE(fault_hash->hash,
>
>                 +                  AMDGPU_PAGEFAULT_HASH_BITS, 8, 0);
>
>                 +  spin_lock_init(&fault_hash->lock);
>
>                 +  fault_hash->count = 0;
>
>                 +
>
>                 +  return fault_hash;
>
>                 +}
>
>                 +
>
>                   /**
>
>                    * amdgpu_vm_init - initialize a vm instance
>
>                    *
>
>                 @@ -2780,6 +2796,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>
>                             vm->pasid = pasid;
>
>                     }
>
>                   
>
>                 +  vm->fault_hash = init_fault_hash();
>
>                 +  if (!vm->fault_hash) {
>
>                 +          r = -ENOMEM;
>
>                 +          goto error_free_root;
>
>                 +  }
>
>                 +
>
>                     INIT_KFIFO(vm->faults);
>
>                     vm->fault_credit = 16;
>
>                   
>
>                 @@ -2973,7 +2995,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>
>                   
>
>                     /* Clear pending page faults from IH when the VM is destroyed */
>
>                     while (kfifo_get(&vm->faults, &fault))
>
>                 -          amdgpu_ih_clear_fault(adev, fault);
>
>                 +          amdgpu_vm_clear_fault(vm->fault_hash, fault);
>
>                   
>
>                     if (vm->pasid) {
>
>                             unsigned long flags;
>
>                 @@ -2983,6 +3005,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>
>                             spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>
>                     }
>
>                   
>
>                 +  kfree(vm->fault_hash);
>
>                 +  vm->fault_hash = NULL;
>
>                 +
>
>                     drm_sched_entity_destroy(&vm->entity);
>
>                   
>
>                     if (!RB_EMPTY_ROOT(&vm->va.rb_root)) {
>
>                 @@ -3183,3 +3208,78 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
>
>                             }
>
>                     }
>
>                   }
>
>                 +
>
>                 +/**
>
>                 + * amdgpu_vm_add_fault - Add a page fault record to fault hash table
>
>                 + *
>
>                 + * @fault_hash: fault hash table
>
>                 + * @key: 64-bit encoding of PASID and address
>
>                 + *
>
>                 + * This should be called when a retry page fault interrupt is
>
>                 + * received. If this is a new page fault, it will be added to a hash
>
>                 + * table. The return value indicates whether this is a new fault, or
>
>                 + * a fault that was already known and is already being handled.
>
>                 + *
>
>                 + * If there are too many pending page faults, this will fail. Retry
>
>                 + * interrupts should be ignored in this case until there is enough
>
>                 + * free space.
>
>                 + *
>
>                 + * Returns 0 if the fault was added, 1 if the fault was already known,
>
>                 + * -ENOSPC if there are too many pending faults.
>
>                 + */
>
>                 +int amdgpu_vm_add_fault(struct amdgpu_retryfault_hashtable *fault_hash, u64 key)
>
>                 +{
>
>                 +  unsigned long flags;
>
>                 +  int r = -ENOSPC;
>
>                 +
>
>                 +  if (WARN_ON_ONCE(!fault_hash))
>
>                 +          /* Should be allocated in amdgpu_vm_init
>
>                 +           */
>
>                 +          return r;
>
>                 +
>
>                 +  spin_lock_irqsave(&fault_hash->lock, flags);
>
>                 +
>
>                 +  /* Only let the hash table fill up to 50% for best performance */
>
>                 +  if (fault_hash->count >= (1 << (AMDGPU_PAGEFAULT_HASH_BITS-1)))
>
>                 +          goto unlock_out;
>
>                 +
>
>                 +  r = chash_table_copy_in(&fault_hash->hash, key, NULL);
>
>                 +  if (!r)
>
>                 +          fault_hash->count++;
>
>                 +
>
>                 +  /* chash_table_copy_in should never fail unless we're losing count */
>
>                 +  WARN_ON_ONCE(r < 0);
>
>                 +
>
>                 +unlock_out:
>
>                 +  spin_unlock_irqrestore(&fault_hash->lock, flags);
>
>                 +  return r;
>
>                 +}
>
>                 +
>
>                 +/**
>
>                 + * amdgpu_vm_clear_fault - Remove a page fault record
>
>                 + *
>
>                 + * @fault_hash: fault hash table
>
>                 + * @key: 64-bit encoding of PASID and address
>
>                 + *
>
>                 + * This should be called when a page fault has been handled. Any
>
>                 + * future interrupt with this key will be processed as a new
>
>                 + * page fault.
>
>                 + */
>
>                 +void amdgpu_vm_clear_fault(struct amdgpu_retryfault_hashtable *fault_hash, u64 key)
>
>                 +{
>
>                 +  unsigned long flags;
>
>                 +  int r;
>
>                 +
>
>                 +  if (!fault_hash)
>
>                 +          return;
>
>                 +
>
>                 +  spin_lock_irqsave(&fault_hash->lock, flags);
>
>                 +
>
>                 +  r = chash_table_remove(&fault_hash->hash, key, NULL);
>
>                 +  if (!WARN_ON_ONCE(r < 0)) {
>
>                 +          fault_hash->count--;
>
>                 +          WARN_ON_ONCE(fault_hash->count < 0);
>
>                 +  }
>
>                 +
>
>                 +  spin_unlock_irqrestore(&fault_hash->lock, flags);
>
>                 +}
>
>                 diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>
>                 index e275ee7..6eb1da1 100644
>
>                 --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>
>                 +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>
>                 @@ -178,6 +178,13 @@ struct amdgpu_task_info {
>
>                     pid_t   tgid;
>
>                   };
>
>                   
>
>                 +#define AMDGPU_PAGEFAULT_HASH_BITS 8
>
>                 +struct amdgpu_retryfault_hashtable {
>
>                 +  DECLARE_CHASH_TABLE(hash, AMDGPU_PAGEFAULT_HASH_BITS, 8, 0);
>
>                 +  spinlock_t     lock;
>
>                 +  int            count;
>
>                 +};
>
>                 +
>
>                   struct amdgpu_vm {
>
>                     /* tree of virtual addresses mapped */
>
>                     struct rb_root_cached  va;
>
>                 @@ -240,6 +247,7 @@ struct amdgpu_vm {
>
>                     struct ttm_lru_bulk_move lru_bulk_move;
>
>                     /* mark whether can do the bulk move */
>
>                     bool                   bulk_moveable;
>
>                 +  struct amdgpu_retryfault_hashtable *fault_hash;
>
>                   };
>
>                   
>
>                   struct amdgpu_vm_manager {
>
>                 @@ -355,4 +363,8 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
>
>                   void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
>
>                                            struct amdgpu_vm *vm);
>
>                   
>
>                 +int amdgpu_vm_add_fault(struct amdgpu_retryfault_hashtable *fault_hash, u64 key);
>
>                 +
>
>                 +void amdgpu_vm_clear_fault(struct amdgpu_retryfault_hashtable *fault_hash, u64 key);
>
>                 +
>
>                   #endif
>
>                 diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>
>                 index 5ae5ed2..acbe5a7 100644
>
>                 --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>
>                 +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>
>                 @@ -265,35 +265,36 @@ static bool vega10_ih_prescreen_iv(struct amdgpu_device *adev)
>
>                             return true;
>
>                     }
>
>                   
>
>                 -  addr = ((u64)(dw5 & 0xf) << 44) | ((u64)dw4 << 12);
>
>                 -  key = AMDGPU_VM_FAULT(pasid, addr);
>
>                 -  r = amdgpu_ih_add_fault(adev, key);
>
>                 -
>
>                 -  /* Hash table is full or the fault is already being processed,
>
>                 -   * ignore further page faults
>
>                 -   */
>
>                 -  if (r != 0)
>
>                 -          goto ignore_iv;
>
>                 -
>
>                     /* Track retry faults in per-VM fault FIFO. */
>
>                     spin_lock(&adev->vm_manager.pasid_lock);
>
>                     vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
>
>                 +  addr = ((u64)(dw5 & 0xf) << 44) | ((u64)dw4 << 12);
>
>                 +  key = AMDGPU_VM_FAULT(pasid, addr);
>
>                     if (!vm) {
>
>                             /* VM not found, process it normally */
>
>                             spin_unlock(&adev->vm_manager.pasid_lock);
>
>                 -          amdgpu_ih_clear_fault(adev, key);
>
>                             return true;
>
>                 +  } else {
>
>                 +          r = amdgpu_vm_add_fault(vm->fault_hash, key);
>
>                 +
>
>                 +          /* Hash table is full or the fault is already being processed,
>
>                 +           * ignore further page faults
>
>                 +           */
>
>                 +          if (r != 0) {
>
>                 +                  spin_unlock(&adev->vm_manager.pasid_lock);
>
>                 +                  goto ignore_iv;
>
>                 +          }
>
>                     }
>
>                     /* No locking required with single writer and single reader */
>
>                     r = kfifo_put(&vm->faults, key);
>
>                     if (!r) {
>
>                             /* FIFO is full. Ignore it until there is space */
>
>                 +          amdgpu_vm_clear_fault(vm->fault_hash, key);
>
>                             spin_unlock(&adev->vm_manager.pasid_lock);
>
>                 -          amdgpu_ih_clear_fault(adev, key);
>
>                             goto ignore_iv;
>
>                     }
>
>                 -  spin_unlock(&adev->vm_manager.pasid_lock);
>
>                   
>
>                 +  spin_unlock(&adev->vm_manager.pasid_lock);
>
>                     /* It's the first fault for this address, process it normally */
>
>                     return true;
>
>                   
>
>                 @@ -386,14 +387,6 @@ static int vega10_ih_sw_init(void *handle)
>
>                     adev->irq.ih.use_doorbell = true;
>
>                     adev->irq.ih.doorbell_index = AMDGPU_DOORBELL64_IH << 1;
>
>                   
>
>                 -  adev->irq.ih.faults = kmalloc(sizeof(*adev->irq.ih.faults), GFP_KERNEL);
>
>                 -  if (!adev->irq.ih.faults)
>
>                 -          return -ENOMEM;
>
>                 -  INIT_CHASH_TABLE(adev->irq.ih.faults->hash,
>
>                 -                   AMDGPU_PAGEFAULT_HASH_BITS, 8, 0);
>
>                 -  spin_lock_init(&adev->irq.ih.faults->lock);
>
>                 -  adev->irq.ih.faults->count = 0;
>
>                 -
>
>                     r = amdgpu_irq_init(adev);
>
>                   
>
>                     return r;
>
>                 @@ -406,9 +399,6 @@ static int vega10_ih_sw_fini(void *handle)
>
>                     amdgpu_irq_fini(adev);
>
>                     amdgpu_ih_ring_fini(adev);
>
>                   
>
>                 -  kfree(adev->irq.ih.faults);
>
>                 -  adev->irq.ih.faults = NULL;
>
>                 -
>
>                     return 0;
>
>                   }
>
>                   
>
>
>
>
>
>
>
>             _______________________________________________
>
>             amd-gfx mailing list
>
>             amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>             <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>
>             https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>


--------------4CC820062F59CC991861C077
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Oak,<br>
      <br>
      <blockquote type="cite"><span style="color:windowtext">&gt;</span>In
        other words when you request the address of a PT you get the
        address where memory management has moved it, not the address
        where the hardware is processing the fault from.<span
          style="color:windowtext"></span>
        <p class="MsoListParagraph" style="margin-left:0in"><span
            style="color:windowtext">Do you mean the address in the PT
            is what vm has mapped and the faulty address need to be
            mapped in the PT?</span></p>
      </blockquote>
      No, the memory management is pipelined to avoid stalls during
      eviction.<br>
      <br>
      This means that the state we manage is always the future state,
      e.g. when you walk the page tables in the VM structure you see the
      state after all the running operations completed.<br>
      <br>
      In other words when a page table is pipelined for eviction you see
      the evicted state and not the current executing one.<br>
      <br>
      But what we need for page fault handling is the current state and
      not the future state.<br>
      <br>
      <blockquote type="cite"><span style="color:windowtext">The
          amdgpu_vm and amdgpu_vm_pt data structure are invented for the
          purpose of management of page table BO. Why we need invent
          extra structure?</span></blockquote>
      We will need something like a double entry accounting for the page
      tables where we both keep the future as well as the current state.<br>
      <br>
      <blockquote type="cite"><span style="color:windowtext">Think about
          the normal case of the page fault handling when the process
          and vm are still alive. In the normal case, the amdgpu_vm
          structure can meet exactly purpose of page table update.</span></blockquote>
      No, the problem is not if the VM is still alive or dead but rather
      that in the case of an eviction you wouldn't be able to handle
      page faults any more.<br>
      <br>
      <blockquote type="cite"><span style="color:windowtext">The said
          extra data structure must look very similar to the
          amdgpu_vm/vm_pt structure. So the best way is to reuse the
          existing vm structure, either in normal case or in process
          termination case.</span></blockquote>
      Completely agree that we will probably need the same structure as
      the VM hierarchy offers, just with another set of information.<br>
      <br>
      <blockquote type="cite"><span style="color:windowtext">Is it
          possible to delay the destroy of vm during process
          termination?</span></blockquote>
      Yeah, thought about that as well. The problem with that is the OOM
      killer and that we are still not able to reliable kill running
      command submissions.<br>
      <br>
      Ok you convinced me that we should probably work on that instead.<br>
      <br>
      E.g. when a process has bound its address space to a VM and exits
      we need to find a way to kill all still executing jobs. We should
      let the UMD handle that case gracefully when they really need
      this.<br>
      <br>
      Thanks,<br>
      Christian.<br>
      <br>
      Am 07.09.2018 um 23:52 schrieb Zeng, Oak:<br>
    </div>
    <blockquote type="cite"
cite="mid:BN6PR12MB1651CCA8BB73DE64815EB0B280000-/b2+HYfkarRSqX7PDniLCgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
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
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";
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
	font-family:"Calibri",sans-serif;
	color:black;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;
	color:black;}
span.EmailStyle20
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
span.EmailStyle21
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
span.EmailStyle23
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
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
	{mso-list-id:1524241316;
	mso-list-template-ids:1236684714;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1
	{mso-list-id:1627153682;
	mso-list-template-ids:2090215794;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2
	{mso-list-id:1719469588;
	mso-list-type:hybrid;
	mso-list-template-ids:-303134234 1230275120 67698691 67698693 67698689 67698691 67698693 67698689 67698691 67698693;}
@list l2:level1
	{mso-level-start-at:8;
	mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;
	mso-fareast-font-family:"Times New Roman";
	mso-bidi-font-family:Calibri;}
@list l2:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l2:level3
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l2:level4
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l2:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l2:level6
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l2:level7
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l2:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l2:level9
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
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
        <p class="MsoNormal"><span style="color:windowtext">Hi
            Christian,<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:windowtext"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span style="color:windowtext">See comments
            inline<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:windowtext"><o:p> </o:p></span></p>
        <div>
          <p class="MsoNormal"><span style="color:windowtext">Thanks,<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="color:windowtext">Oak<o:p></o:p></span></p>
        </div>
        <p class="MsoNormal"><span style="color:windowtext"><o:p> </o:p></span></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b><span style="color:windowtext">From:</span></b><span
                style="color:windowtext"> Koenig, Christian
                <br>
                <b>Sent:</b> Monday, September 10, 2018 7:44 AM<br>
                <b>To:</b> Zeng, Oak <a class="moz-txt-link-rfc2396E" href="mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org">&lt;Oak.Zeng-5C7GfCeVMHo@public.gmane.org&gt;</a>; Oak Zeng
                <a class="moz-txt-link-rfc2396E" href="mailto:zengshanjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;zengshanjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>;
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Yang, Philip
                <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org">&lt;Philip.Yang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                <b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: Moved fault
                hash table to amdgpu vm<o:p></o:p></span></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p> </o:p></p>
        <div>
          <p class="MsoNormal"><span style="color:windowtext">&gt;</span>The
            VM doesn't know that information either.<span
              style="color:windowtext"><o:p></o:p></span></p>
          <p class="MsoNormal"><span style="color:windowtext"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span style="color:windowtext">Yes, VM
              doesn’t know the information. More specifically I meant we
              need VM data structure to update PTs during page fault
              handling. For example, we walk the 4 level page table (the
              first level is pointed by vm-&gt;root) to figure out the
              entries need to be filled, allocate page table entry Bos
              if necessary, allocate physical page for the faulty
              address, setup 4 level page table for the faulty virtual
              address to pointing to the allocated physical page.</span><br>
            <br>
            <span style="color:windowtext">&gt;</span>In other words
            when you request the address of a PT you get the address
            where memory management has moved it, not the address where
            the hardware is processing the fault from.<span
              style="color:windowtext"><o:p></o:p></span></p>
          <p class="MsoListParagraph" style="margin-left:0in"><span
              style="color:windowtext">Do you mean the address in the PT
              is what vm has mapped and the faulty address need to be
              mapped in the PT?<o:p></o:p></span></p>
          <p class="MsoNormal"><br>
            <br>
            I see only a few possible solutions for that:<br>
            <span style="color:windowtext">&gt;</span>1. We use an extra
            structure in the kernel driver which holds the current
            address of the PTs and is feed by memory management when
            buffers move around.<span style="color:windowtext"><o:p></o:p></span></p>
          <p class="MsoNormal"><span style="color:windowtext">The
              amdgpu_vm and amdgpu_vm_pt data structure are invented for
              the purpose of management of page table BO. Why we need
              invent extra structure? Think about the normal case of the
              page fault handling when the process and vm are still
              alive. In the normal case, the amdgpu_vm structure can
              meet exactly purpose of page table update.<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="color:windowtext"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span style="color:windowtext">The said
              extra data structure must look very similar to the
              amdgpu_vm/vm_pt structure. So the best way is to reuse the
              existing vm structure, either in normal case or in process
              termination case. Is it possible to delay the destroy of
              vm during process termination?<o:p></o:p></span></p>
          <p class="MsoNormal"><br>
            <span style="color:windowtext">&gt;</span>2. We change the
            SDMA firmware to do the walk for us and update the PTEs
            based on the information in the page directory.<span
              style="color:windowtext"><o:p></o:p></span></p>
          <p class="MsoNormal"><span style="color:windowtext">As the
              page table BO need to be freed later. You still need to
              manage them in the driver. SDMA FW can walk and update but
              it need information from driver side. Driver still need a
              similar struct like amdgpu_vm.<o:p></o:p></span></p>
          <p class="MsoNormal"><br>
            <span style="color:windowtext">&gt;</span>3. We use the UTCL
            walker to get us to the correct address which is then
            updated with the SDMA.<br>
            <span style="color:windowtext">I don’t quite understand your
              point here. What do you mean by “correct address”? Do you
              mean the physical address to be filled to the page table?
              If this is your meaning, how UTCL2 knows this information
              – the physical address has to be allocated/validated
              through driver.<o:p></o:p></span></p>
          <p class="MsoNormal"><span style="color:windowtext"><o:p> </o:p></span></p>
          <p class="MsoNormal"><br>
            Regards,<br>
            Christian.<br>
            <br>
            Am 07.09.2018 um 17:30 schrieb Zeng, Oak:<o:p></o:p></p>
        </div>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <p class="MsoNormal"><span style="color:windowtext">Without a
              VM, how can you get the physical address of the faulty
              virtual address? Where this information should be hold?</span><o:p></o:p></p>
          <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
          <div>
            <p class="MsoNormal"><span style="color:windowtext">Thanks,</span><o:p></o:p></p>
            <p class="MsoNormal"><span style="color:windowtext">Oak</span><o:p></o:p></p>
          </div>
          <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b><span style="color:windowtext">From:</span></b><span
                  style="color:windowtext"> Koenig, Christian
                  <br>
                  <b>Sent:</b> Monday, September 10, 2018 7:20 AM<br>
                  <b>To:</b> Zeng, Oak <a
                    href="mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">&lt;Oak.Zeng-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                  Oak Zeng
                  <a href="mailto:zengshanjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                    moz-do-not-send="true">&lt;zengshanjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>;
                  <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                    moz-do-not-send="true">
                    amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Yang, Philip <a
                    href="mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">
                    &lt;Philip.Yang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  <b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: Moved
                  fault hash table to amdgpu vm</span><o:p></o:p></p>
            </div>
          </div>
          <p class="MsoNormal"> <o:p></o:p></p>
          <div>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <p class="MsoNormal"><span style="color:windowtext">Am I
                  right that the handling of page fault need a valid VM?
                </span><o:p></o:p></p>
            </blockquote>
            <p class="MsoNormal">No, exactly that view is incorrect.<br>
              <br>
              The VM is meant to be a memory management structure of
              page tables and is completely pointless fault processing
              because it represent the future state of the page tables
              and not the current one.<br>
              <br>
              What we need for fault processing is a new structure build
              around PASIDs which is feed by the with addresses when
              page tables are moved around.<br>
              <br>
              Alternatively I hope that we can use the SDMA to walk the
              page tables and update the required entries by just using
              the address.<br>
              <br>
              Regards,<br>
              Christian.<br>
              <br>
              Am 07.09.2018 um 16:55 schrieb Zeng, Oak:<o:p></o:p></p>
          </div>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoNormal"><span style="color:windowtext">Hi
                Christian,</span><o:p></o:p></p>
            <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
            <p class="MsoNormal"><span style="color:windowtext">What is
                the value of delay the destroy of hash to after vm is
                destroyed? Since vm is destroyed, you basically don’t
                have enough information to paging in the correct page to
                gpuvm. Am I right that the handling of page fault need a
                valid VM? For example, you need the VM to get the
                corresponding physical address of the faulty page.
              </span><o:p></o:p></p>
            <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
            <p class="MsoNormal"><span style="color:windowtext">After vm
                is destroyed, the retry interrupt can be directly
                discard as you can’t find vm through pasid. You can
                think this is also one kind of prescreen.
              </span><o:p></o:p></p>
            <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
            <p class="MsoNormal"><span style="color:windowtext">So I am
                stand for the point that, there is no need to delay the
                destroy of hash to after vm is destroyed. Prescreening
                hash can be destroyed at the time of vm_fini.</span><o:p></o:p></p>
            <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
            <div>
              <p class="MsoNormal"><span style="color:windowtext">Thanks,</span><o:p></o:p></p>
              <p class="MsoNormal"><span style="color:windowtext">Oak</span><o:p></o:p></p>
            </div>
            <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
            <div>
              <div style="border:none;border-top:solid #E1E1E1
                1.0pt;padding:3.0pt 0in 0in 0in">
                <p class="MsoNormal"><b><span style="color:windowtext">From:</span></b><span
                    style="color:windowtext"> Christian König
                    <a href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                      moz-do-not-send="true">&lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>
                    <br>
                    <b>Sent:</b> Friday, September 07, 2018 4:39 AM<br>
                    <b>To:</b> Zeng, Oak <a
                      href="mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">&lt;Oak.Zeng-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                    Oak Zeng
                    <a href="mailto:zengshanjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                      moz-do-not-send="true">&lt;zengshanjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>;
                    <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                      moz-do-not-send="true">
                      amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                    <b>Cc:</b> Zeng, Oak <a
                      href="mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">&lt;Oak.Zeng-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                    <b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: Moved
                    fault hash table to amdgpu vm</span><o:p></o:p></p>
              </div>
            </div>
            <p class="MsoNormal"> <o:p></o:p></p>
            <div>
              <p class="MsoNormal">Hi Oak,<br>
                <br>
                yeah, but this is still a NAK. Making the hash per PASID
                was not a suggestion but rather a must have.<br>
                <br>
                The VM structures must be destroyed while the processing
                is still ongoing, or otherwise we would not have a clean
                OOM handling.<br>
                <br>
                The IDR for PASID lockup can be put into amdgpu_ids.c,
                you can just replace the IDA already used there with an
                IDR.<br>
                <br>
                Since the PASID is already freed up delayed we should
                have the grace period for interrupt processing included.
                If that still isn't sufficient we can still add some
                delayed work for this.<br>
                <br>
                Regards,<br>
                Christian.<br>
                <br>
                Am 07.09.2018 um 06:16 schrieb ozeng:<o:p></o:p></p>
            </div>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <p>Hi Christian, <o:p></o:p></p>
              <p>In this implementation, fault hash is made per vm, not
                per pasid as suggested, based on below considerations:<o:p></o:p></p>
              <ul type="disc">
                <li class="MsoNormal"
                  style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto;mso-list:l0
                  level1 lfo3">
                  Delay the destroy of hash introduces more effort like
                  how to set the proper grace period after which no
                  retry interrupt will be generated. We want to avoid
                  those complication if we can.
                  <o:p></o:p></li>
                <li class="MsoNormal"
                  style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto;mso-list:l0
                  level1 lfo3">
                  The  problem of the per vm implementation is that it
                  is hard to delay the destroy of fault hash, because
                  when vm is destroyed, prescreen function won't be able
                  to retrieve the fault hash. But in this case, the
                  prescreen function can either let the interrupt go
                  through (to gmc) or ignore it. From this perspective,
                  it is not very necessary to delay the destroy of hash
                  table.
                  <o:p></o:p></li>
                <li class="MsoNormal"
                  style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto;mso-list:l0
                  level1 lfo3">
                  On the other hand, since ASICs after vega10 have the
                  HW CAM feature. So the SW IV prescreen is only useful
                  for vega10. For all the HW implemented CAM, we can
                  consider the delayed CAM acknowledgment.
                  <o:p></o:p></li>
                <li class="MsoNormal"
                  style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto;mso-list:l0
                  level1 lfo3">
                  Making it per pasid need to introduce another idr to
                  correlate pasid and hash table - where to put the idr?
                  You will have to make it a global variable which is
                  not very desirable.
                  <o:p></o:p></li>
              </ul>
              <p>The main purpose of this patch is to solve the
                inter-process lock issue (when hash table is full),
                while still keep codes simple.<o:p></o:p></p>
              <p>Also with this patch, the faults kfifo is not necessary
                any more. See patch 2.
                <o:p></o:p></p>
              <p>Regards,<o:p></o:p></p>
              <p>Oak<o:p></o:p></p>
              <p class="MsoNormal"> <o:p></o:p></p>
              <div>
                <p class="MsoNormal">On 09/06/2018 11:28 PM, Oak Zeng
                  wrote:<o:p></o:p></p>
              </div>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <pre>In stead of share one fault hash table per device, make it<o:p></o:p></pre>
                <pre>per vm. This can avoid inter-process lock issue when fault<o:p></o:p></pre>
                <pre>hash table is full.<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre>Change-Id: I5d1281b7c41eddc8e26113e010516557588d3708<o:p></o:p></pre>
                <pre>Signed-off-by: Oak Zeng <a href="mailto:Oak.Zeng-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">&lt;Oak.Zeng-5C7GfCeVMHo@public.gmane.org&gt;</a><o:p></o:p></pre>
                <pre>Suggested-by: Christian Konig <a href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">&lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><o:p></o:p></pre>
                <pre>Suggested-by: Felix Kuehling <a href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">&lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;</a><o:p></o:p></pre>
                <pre>---<o:p></o:p></pre>
                <pre> drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c |  75 ------------------------<o:p></o:p></pre>
                <pre> drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h |  10 ----<o:p></o:p></pre>
                <pre> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 102 ++++++++++++++++++++++++++++++++-<o:p></o:p></pre>
                <pre> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  12 ++++<o:p></o:p></pre>
                <pre> drivers/gpu/drm/amd/amdgpu/vega10_ih.c |  38 +++++-------<o:p></o:p></pre>
                <pre> 5 files changed, 127 insertions(+), 110 deletions(-)<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c<o:p></o:p></pre>
                <pre>index 06373d4..4ed8621 100644<o:p></o:p></pre>
                <pre>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c<o:p></o:p></pre>
                <pre>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c<o:p></o:p></pre>
                <pre>@@ -197,78 +197,3 @@ int amdgpu_ih_process(struct amdgpu_device *adev)<o:p></o:p></pre>
                <pre>   return IRQ_HANDLED;<o:p></o:p></pre>
                <pre> }<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre>-/**<o:p></o:p></pre>
                <pre>- * amdgpu_ih_add_fault - Add a page fault record<o:p></o:p></pre>
                <pre>- *<o:p></o:p></pre>
                <pre>- * @adev: amdgpu device pointer<o:p></o:p></pre>
                <pre>- * @key: 64-bit encoding of PASID and address<o:p></o:p></pre>
                <pre>- *<o:p></o:p></pre>
                <pre>- * This should be called when a retry page fault interrupt is<o:p></o:p></pre>
                <pre>- * received. If this is a new page fault, it will be added to a hash<o:p></o:p></pre>
                <pre>- * table. The return value indicates whether this is a new fault, or<o:p></o:p></pre>
                <pre>- * a fault that was already known and is already being handled.<o:p></o:p></pre>
                <pre>- *<o:p></o:p></pre>
                <pre>- * If there are too many pending page faults, this will fail. Retry<o:p></o:p></pre>
                <pre>- * interrupts should be ignored in this case until there is enough<o:p></o:p></pre>
                <pre>- * free space.<o:p></o:p></pre>
                <pre>- *<o:p></o:p></pre>
                <pre>- * Returns 0 if the fault was added, 1 if the fault was already known,<o:p></o:p></pre>
                <pre>- * -ENOSPC if there are too many pending faults.<o:p></o:p></pre>
                <pre>- */<o:p></o:p></pre>
                <pre>-int amdgpu_ih_add_fault(struct amdgpu_device *adev, u64 key)<o:p></o:p></pre>
                <pre>-{<o:p></o:p></pre>
                <pre>-  unsigned long flags;<o:p></o:p></pre>
                <pre>-  int r = -ENOSPC;<o:p></o:p></pre>
                <pre>-<o:p></o:p></pre>
                <pre>-  if (WARN_ON_ONCE(!adev-&gt;irq.ih.faults))<o:p></o:p></pre>
                <pre>-          /* Should be allocated in &lt;IP&gt;_ih_sw_init on GPUs that<o:p></o:p></pre>
                <pre>-           * support retry faults and require retry filtering.<o:p></o:p></pre>
                <pre>-           */<o:p></o:p></pre>
                <pre>-          return r;<o:p></o:p></pre>
                <pre>-<o:p></o:p></pre>
                <pre>-  spin_lock_irqsave(&amp;adev-&gt;irq.ih.faults-&gt;lock, flags);<o:p></o:p></pre>
                <pre>-<o:p></o:p></pre>
                <pre>-  /* Only let the hash table fill up to 50% for best performance */<o:p></o:p></pre>
                <pre>-  if (adev-&gt;irq.ih.faults-&gt;count &gt;= (1 &lt;&lt; (AMDGPU_PAGEFAULT_HASH_BITS-1)))<o:p></o:p></pre>
                <pre>-          goto unlock_out;<o:p></o:p></pre>
                <pre>-<o:p></o:p></pre>
                <pre>-  r = chash_table_copy_in(&amp;adev-&gt;irq.ih.faults-&gt;hash, key, NULL);<o:p></o:p></pre>
                <pre>-  if (!r)<o:p></o:p></pre>
                <pre>-          adev-&gt;irq.ih.faults-&gt;count++;<o:p></o:p></pre>
                <pre>-<o:p></o:p></pre>
                <pre>-  /* chash_table_copy_in should never fail unless we're losing count */<o:p></o:p></pre>
                <pre>-  WARN_ON_ONCE(r &lt; 0);<o:p></o:p></pre>
                <pre>-<o:p></o:p></pre>
                <pre>-unlock_out:<o:p></o:p></pre>
                <pre>-  spin_unlock_irqrestore(&amp;adev-&gt;irq.ih.faults-&gt;lock, flags);<o:p></o:p></pre>
                <pre>-  return r;<o:p></o:p></pre>
                <pre>-}<o:p></o:p></pre>
                <pre>-<o:p></o:p></pre>
                <pre>-/**<o:p></o:p></pre>
                <pre>- * amdgpu_ih_clear_fault - Remove a page fault record<o:p></o:p></pre>
                <pre>- *<o:p></o:p></pre>
                <pre>- * @adev: amdgpu device pointer<o:p></o:p></pre>
                <pre>- * @key: 64-bit encoding of PASID and address<o:p></o:p></pre>
                <pre>- *<o:p></o:p></pre>
                <pre>- * This should be called when a page fault has been handled. Any<o:p></o:p></pre>
                <pre>- * future interrupt with this key will be processed as a new<o:p></o:p></pre>
                <pre>- * page fault.<o:p></o:p></pre>
                <pre>- */<o:p></o:p></pre>
                <pre>-void amdgpu_ih_clear_fault(struct amdgpu_device *adev, u64 key)<o:p></o:p></pre>
                <pre>-{<o:p></o:p></pre>
                <pre>-  unsigned long flags;<o:p></o:p></pre>
                <pre>-  int r;<o:p></o:p></pre>
                <pre>-<o:p></o:p></pre>
                <pre>-  if (!adev-&gt;irq.ih.faults)<o:p></o:p></pre>
                <pre>-          return;<o:p></o:p></pre>
                <pre>-<o:p></o:p></pre>
                <pre>-  spin_lock_irqsave(&amp;adev-&gt;irq.ih.faults-&gt;lock, flags);<o:p></o:p></pre>
                <pre>-<o:p></o:p></pre>
                <pre>-  r = chash_table_remove(&amp;adev-&gt;irq.ih.faults-&gt;hash, key, NULL);<o:p></o:p></pre>
                <pre>-  if (!WARN_ON_ONCE(r &lt; 0)) {<o:p></o:p></pre>
                <pre>-          adev-&gt;irq.ih.faults-&gt;count--;<o:p></o:p></pre>
                <pre>-          WARN_ON_ONCE(adev-&gt;irq.ih.faults-&gt;count &lt; 0);<o:p></o:p></pre>
                <pre>-  }<o:p></o:p></pre>
                <pre>-<o:p></o:p></pre>
                <pre>-  spin_unlock_irqrestore(&amp;adev-&gt;irq.ih.faults-&gt;lock, flags);<o:p></o:p></pre>
                <pre>-}<o:p></o:p></pre>
                <pre>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h<o:p></o:p></pre>
                <pre>index a23e1c0..f411ffb 100644<o:p></o:p></pre>
                <pre>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h<o:p></o:p></pre>
                <pre>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h<o:p></o:p></pre>
                <pre>@@ -32,13 +32,6 @@ struct amdgpu_device;<o:p></o:p></pre>
                <pre> #define AMDGPU_IH_CLIENTID_LEGACY 0<o:p></o:p></pre>
                <pre> #define AMDGPU_IH_CLIENTID_MAX SOC15_IH_CLIENTID_MAX<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre>-#define AMDGPU_PAGEFAULT_HASH_BITS 8<o:p></o:p></pre>
                <pre>-struct amdgpu_retryfault_hashtable {<o:p></o:p></pre>
                <pre>-  DECLARE_CHASH_TABLE(hash, AMDGPU_PAGEFAULT_HASH_BITS, 8, 0);<o:p></o:p></pre>
                <pre>-  spinlock_t     lock;<o:p></o:p></pre>
                <pre>-  int            count;<o:p></o:p></pre>
                <pre>-};<o:p></o:p></pre>
                <pre>-<o:p></o:p></pre>
                <pre> /*<o:p></o:p></pre>
                <pre>  * R6xx+ IH ring<o:p></o:p></pre>
                <pre>  */<o:p></o:p></pre>
                <pre>@@ -57,7 +50,6 @@ struct amdgpu_ih_ring {<o:p></o:p></pre>
                <pre>   bool                   use_doorbell;<o:p></o:p></pre>
                <pre>   bool                   use_bus_addr;<o:p></o:p></pre>
                <pre>   dma_addr_t             rb_dma_addr; /* only used when use_bus_addr = true */<o:p></o:p></pre>
                <pre>-  struct amdgpu_retryfault_hashtable *faults;<o:p></o:p></pre>
                <pre> };<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre> #define AMDGPU_IH_SRC_DATA_MAX_SIZE_DW 4<o:p></o:p></pre>
                <pre>@@ -95,7 +87,5 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, unsigned ring_size,<o:p></o:p></pre>
                <pre>                   bool use_bus_addr);<o:p></o:p></pre>
                <pre> void amdgpu_ih_ring_fini(struct amdgpu_device *adev);<o:p></o:p></pre>
                <pre> int amdgpu_ih_process(struct amdgpu_device *adev);<o:p></o:p></pre>
                <pre>-int amdgpu_ih_add_fault(struct amdgpu_device *adev, u64 key);<o:p></o:p></pre>
                <pre>-void amdgpu_ih_clear_fault(struct amdgpu_device *adev, u64 key);<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre> #endif<o:p></o:p></pre>
                <pre>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<o:p></o:p></pre>
                <pre>index 1d7e3c1..8b220e9 100644<o:p></o:p></pre>
                <pre>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<o:p></o:p></pre>
                <pre>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<o:p></o:p></pre>
                <pre>@@ -2692,6 +2692,22 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,<o:p></o:p></pre>
                <pre>            adev-&gt;vm_manager.fragment_size);<o:p></o:p></pre>
                <pre> }<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre>+static struct amdgpu_retryfault_hashtable *init_fault_hash(void)<o:p></o:p></pre>
                <pre>+{<o:p></o:p></pre>
                <pre>+  struct amdgpu_retryfault_hashtable *fault_hash;<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre>+  fault_hash = kmalloc(sizeof(*fault_hash), GFP_KERNEL);<o:p></o:p></pre>
                <pre>+  if (!fault_hash)<o:p></o:p></pre>
                <pre>+          return fault_hash;<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre>+  INIT_CHASH_TABLE(fault_hash-&gt;hash,<o:p></o:p></pre>
                <pre>+                  AMDGPU_PAGEFAULT_HASH_BITS, 8, 0);<o:p></o:p></pre>
                <pre>+  spin_lock_init(&amp;fault_hash-&gt;lock);<o:p></o:p></pre>
                <pre>+  fault_hash-&gt;count = 0;<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre>+  return fault_hash;<o:p></o:p></pre>
                <pre>+}<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre> /**<o:p></o:p></pre>
                <pre>  * amdgpu_vm_init - initialize a vm instance<o:p></o:p></pre>
                <pre>  *<o:p></o:p></pre>
                <pre>@@ -2780,6 +2796,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,<o:p></o:p></pre>
                <pre>           vm-&gt;pasid = pasid;<o:p></o:p></pre>
                <pre>   }<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre>+  vm-&gt;fault_hash = init_fault_hash();<o:p></o:p></pre>
                <pre>+  if (!vm-&gt;fault_hash) {<o:p></o:p></pre>
                <pre>+          r = -ENOMEM;<o:p></o:p></pre>
                <pre>+          goto error_free_root;<o:p></o:p></pre>
                <pre>+  }<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre>   INIT_KFIFO(vm-&gt;faults);<o:p></o:p></pre>
                <pre>   vm-&gt;fault_credit = 16;<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre>@@ -2973,7 +2995,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre>   /* Clear pending page faults from IH when the VM is destroyed */<o:p></o:p></pre>
                <pre>   while (kfifo_get(&amp;vm-&gt;faults, &amp;fault))<o:p></o:p></pre>
                <pre>-          amdgpu_ih_clear_fault(adev, fault);<o:p></o:p></pre>
                <pre>+          amdgpu_vm_clear_fault(vm-&gt;fault_hash, fault);<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre>   if (vm-&gt;pasid) {<o:p></o:p></pre>
                <pre>           unsigned long flags;<o:p></o:p></pre>
                <pre>@@ -2983,6 +3005,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)<o:p></o:p></pre>
                <pre>           spin_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasid_lock, flags);<o:p></o:p></pre>
                <pre>   }<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre>+  kfree(vm-&gt;fault_hash);<o:p></o:p></pre>
                <pre>+  vm-&gt;fault_hash = NULL;<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre>   drm_sched_entity_destroy(&amp;vm-&gt;entity);<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre>   if (!RB_EMPTY_ROOT(&amp;vm-&gt;va.rb_root)) {<o:p></o:p></pre>
                <pre>@@ -3183,3 +3208,78 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)<o:p></o:p></pre>
                <pre>           }<o:p></o:p></pre>
                <pre>   }<o:p></o:p></pre>
                <pre> }<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre>+/**<o:p></o:p></pre>
                <pre>+ * amdgpu_vm_add_fault - Add a page fault record to fault hash table<o:p></o:p></pre>
                <pre>+ *<o:p></o:p></pre>
                <pre>+ * @fault_hash: fault hash table<o:p></o:p></pre>
                <pre>+ * @key: 64-bit encoding of PASID and address<o:p></o:p></pre>
                <pre>+ *<o:p></o:p></pre>
                <pre>+ * This should be called when a retry page fault interrupt is<o:p></o:p></pre>
                <pre>+ * received. If this is a new page fault, it will be added to a hash<o:p></o:p></pre>
                <pre>+ * table. The return value indicates whether this is a new fault, or<o:p></o:p></pre>
                <pre>+ * a fault that was already known and is already being handled.<o:p></o:p></pre>
                <pre>+ *<o:p></o:p></pre>
                <pre>+ * If there are too many pending page faults, this will fail. Retry<o:p></o:p></pre>
                <pre>+ * interrupts should be ignored in this case until there is enough<o:p></o:p></pre>
                <pre>+ * free space.<o:p></o:p></pre>
                <pre>+ *<o:p></o:p></pre>
                <pre>+ * Returns 0 if the fault was added, 1 if the fault was already known,<o:p></o:p></pre>
                <pre>+ * -ENOSPC if there are too many pending faults.<o:p></o:p></pre>
                <pre>+ */<o:p></o:p></pre>
                <pre>+int amdgpu_vm_add_fault(struct amdgpu_retryfault_hashtable *fault_hash, u64 key)<o:p></o:p></pre>
                <pre>+{<o:p></o:p></pre>
                <pre>+  unsigned long flags;<o:p></o:p></pre>
                <pre>+  int r = -ENOSPC;<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre>+  if (WARN_ON_ONCE(!fault_hash))<o:p></o:p></pre>
                <pre>+          /* Should be allocated in amdgpu_vm_init<o:p></o:p></pre>
                <pre>+           */<o:p></o:p></pre>
                <pre>+          return r;<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre>+  spin_lock_irqsave(&amp;fault_hash-&gt;lock, flags);<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre>+  /* Only let the hash table fill up to 50% for best performance */<o:p></o:p></pre>
                <pre>+  if (fault_hash-&gt;count &gt;= (1 &lt;&lt; (AMDGPU_PAGEFAULT_HASH_BITS-1)))<o:p></o:p></pre>
                <pre>+          goto unlock_out;<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre>+  r = chash_table_copy_in(&amp;fault_hash-&gt;hash, key, NULL);<o:p></o:p></pre>
                <pre>+  if (!r)<o:p></o:p></pre>
                <pre>+          fault_hash-&gt;count++;<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre>+  /* chash_table_copy_in should never fail unless we're losing count */<o:p></o:p></pre>
                <pre>+  WARN_ON_ONCE(r &lt; 0);<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre>+unlock_out:<o:p></o:p></pre>
                <pre>+  spin_unlock_irqrestore(&amp;fault_hash-&gt;lock, flags);<o:p></o:p></pre>
                <pre>+  return r;<o:p></o:p></pre>
                <pre>+}<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre>+/**<o:p></o:p></pre>
                <pre>+ * amdgpu_vm_clear_fault - Remove a page fault record<o:p></o:p></pre>
                <pre>+ *<o:p></o:p></pre>
                <pre>+ * @fault_hash: fault hash table<o:p></o:p></pre>
                <pre>+ * @key: 64-bit encoding of PASID and address<o:p></o:p></pre>
                <pre>+ *<o:p></o:p></pre>
                <pre>+ * This should be called when a page fault has been handled. Any<o:p></o:p></pre>
                <pre>+ * future interrupt with this key will be processed as a new<o:p></o:p></pre>
                <pre>+ * page fault.<o:p></o:p></pre>
                <pre>+ */<o:p></o:p></pre>
                <pre>+void amdgpu_vm_clear_fault(struct amdgpu_retryfault_hashtable *fault_hash, u64 key)<o:p></o:p></pre>
                <pre>+{<o:p></o:p></pre>
                <pre>+  unsigned long flags;<o:p></o:p></pre>
                <pre>+  int r;<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre>+  if (!fault_hash)<o:p></o:p></pre>
                <pre>+          return;<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre>+  spin_lock_irqsave(&amp;fault_hash-&gt;lock, flags);<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre>+  r = chash_table_remove(&amp;fault_hash-&gt;hash, key, NULL);<o:p></o:p></pre>
                <pre>+  if (!WARN_ON_ONCE(r &lt; 0)) {<o:p></o:p></pre>
                <pre>+          fault_hash-&gt;count--;<o:p></o:p></pre>
                <pre>+          WARN_ON_ONCE(fault_hash-&gt;count &lt; 0);<o:p></o:p></pre>
                <pre>+  }<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre>+  spin_unlock_irqrestore(&amp;fault_hash-&gt;lock, flags);<o:p></o:p></pre>
                <pre>+}<o:p></o:p></pre>
                <pre>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<o:p></o:p></pre>
                <pre>index e275ee7..6eb1da1 100644<o:p></o:p></pre>
                <pre>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<o:p></o:p></pre>
                <pre>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<o:p></o:p></pre>
                <pre>@@ -178,6 +178,13 @@ struct amdgpu_task_info {<o:p></o:p></pre>
                <pre>   pid_t   tgid;<o:p></o:p></pre>
                <pre> };<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre>+#define AMDGPU_PAGEFAULT_HASH_BITS 8<o:p></o:p></pre>
                <pre>+struct amdgpu_retryfault_hashtable {<o:p></o:p></pre>
                <pre>+  DECLARE_CHASH_TABLE(hash, AMDGPU_PAGEFAULT_HASH_BITS, 8, 0);<o:p></o:p></pre>
                <pre>+  spinlock_t     lock;<o:p></o:p></pre>
                <pre>+  int            count;<o:p></o:p></pre>
                <pre>+};<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre> struct amdgpu_vm {<o:p></o:p></pre>
                <pre>   /* tree of virtual addresses mapped */<o:p></o:p></pre>
                <pre>   struct rb_root_cached  va;<o:p></o:p></pre>
                <pre>@@ -240,6 +247,7 @@ struct amdgpu_vm {<o:p></o:p></pre>
                <pre>   struct ttm_lru_bulk_move lru_bulk_move;<o:p></o:p></pre>
                <pre>   /* mark whether can do the bulk move */<o:p></o:p></pre>
                <pre>   bool                   bulk_moveable;<o:p></o:p></pre>
                <pre>+  struct amdgpu_retryfault_hashtable *fault_hash;<o:p></o:p></pre>
                <pre> };<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre> struct amdgpu_vm_manager {<o:p></o:p></pre>
                <pre>@@ -355,4 +363,8 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);<o:p></o:p></pre>
                <pre> void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,<o:p></o:p></pre>
                <pre>                          struct amdgpu_vm *vm);<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre>+int amdgpu_vm_add_fault(struct amdgpu_retryfault_hashtable *fault_hash, u64 key);<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre>+void amdgpu_vm_clear_fault(struct amdgpu_retryfault_hashtable *fault_hash, u64 key);<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre> #endif<o:p></o:p></pre>
                <pre>diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c<o:p></o:p></pre>
                <pre>index 5ae5ed2..acbe5a7 100644<o:p></o:p></pre>
                <pre>--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c<o:p></o:p></pre>
                <pre>+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c<o:p></o:p></pre>
                <pre>@@ -265,35 +265,36 @@ static bool vega10_ih_prescreen_iv(struct amdgpu_device *adev)<o:p></o:p></pre>
                <pre>           return true;<o:p></o:p></pre>
                <pre>   }<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre>-  addr = ((u64)(dw5 &amp; 0xf) &lt;&lt; 44) | ((u64)dw4 &lt;&lt; 12);<o:p></o:p></pre>
                <pre>-  key = AMDGPU_VM_FAULT(pasid, addr);<o:p></o:p></pre>
                <pre>-  r = amdgpu_ih_add_fault(adev, key);<o:p></o:p></pre>
                <pre>-<o:p></o:p></pre>
                <pre>-  /* Hash table is full or the fault is already being processed,<o:p></o:p></pre>
                <pre>-   * ignore further page faults<o:p></o:p></pre>
                <pre>-   */<o:p></o:p></pre>
                <pre>-  if (r != 0)<o:p></o:p></pre>
                <pre>-          goto ignore_iv;<o:p></o:p></pre>
                <pre>-<o:p></o:p></pre>
                <pre>   /* Track retry faults in per-VM fault FIFO. */<o:p></o:p></pre>
                <pre>   spin_lock(&amp;adev-&gt;vm_manager.pasid_lock);<o:p></o:p></pre>
                <pre>   vm = idr_find(&amp;adev-&gt;vm_manager.pasid_idr, pasid);<o:p></o:p></pre>
                <pre>+  addr = ((u64)(dw5 &amp; 0xf) &lt;&lt; 44) | ((u64)dw4 &lt;&lt; 12);<o:p></o:p></pre>
                <pre>+  key = AMDGPU_VM_FAULT(pasid, addr);<o:p></o:p></pre>
                <pre>   if (!vm) {<o:p></o:p></pre>
                <pre>           /* VM not found, process it normally */<o:p></o:p></pre>
                <pre>           spin_unlock(&amp;adev-&gt;vm_manager.pasid_lock);<o:p></o:p></pre>
                <pre>-          amdgpu_ih_clear_fault(adev, key);<o:p></o:p></pre>
                <pre>           return true;<o:p></o:p></pre>
                <pre>+  } else {<o:p></o:p></pre>
                <pre>+          r = amdgpu_vm_add_fault(vm-&gt;fault_hash, key);<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre>+          /* Hash table is full or the fault is already being processed,<o:p></o:p></pre>
                <pre>+           * ignore further page faults<o:p></o:p></pre>
                <pre>+           */<o:p></o:p></pre>
                <pre>+          if (r != 0) {<o:p></o:p></pre>
                <pre>+                  spin_unlock(&amp;adev-&gt;vm_manager.pasid_lock);<o:p></o:p></pre>
                <pre>+                  goto ignore_iv;<o:p></o:p></pre>
                <pre>+          }<o:p></o:p></pre>
                <pre>   }<o:p></o:p></pre>
                <pre>   /* No locking required with single writer and single reader */<o:p></o:p></pre>
                <pre>   r = kfifo_put(&amp;vm-&gt;faults, key);<o:p></o:p></pre>
                <pre>   if (!r) {<o:p></o:p></pre>
                <pre>           /* FIFO is full. Ignore it until there is space */<o:p></o:p></pre>
                <pre>+          amdgpu_vm_clear_fault(vm-&gt;fault_hash, key);<o:p></o:p></pre>
                <pre>           spin_unlock(&amp;adev-&gt;vm_manager.pasid_lock);<o:p></o:p></pre>
                <pre>-          amdgpu_ih_clear_fault(adev, key);<o:p></o:p></pre>
                <pre>           goto ignore_iv;<o:p></o:p></pre>
                <pre>   }<o:p></o:p></pre>
                <pre>-  spin_unlock(&amp;adev-&gt;vm_manager.pasid_lock);<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre>+  spin_unlock(&amp;adev-&gt;vm_manager.pasid_lock);<o:p></o:p></pre>
                <pre>   /* It's the first fault for this address, process it normally */<o:p></o:p></pre>
                <pre>   return true;<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre>@@ -386,14 +387,6 @@ static int vega10_ih_sw_init(void *handle)<o:p></o:p></pre>
                <pre>   adev-&gt;irq.ih.use_doorbell = true;<o:p></o:p></pre>
                <pre>   adev-&gt;irq.ih.doorbell_index = AMDGPU_DOORBELL64_IH &lt;&lt; 1;<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre>-  adev-&gt;irq.ih.faults = kmalloc(sizeof(*adev-&gt;irq.ih.faults), GFP_KERNEL);<o:p></o:p></pre>
                <pre>-  if (!adev-&gt;irq.ih.faults)<o:p></o:p></pre>
                <pre>-          return -ENOMEM;<o:p></o:p></pre>
                <pre>-  INIT_CHASH_TABLE(adev-&gt;irq.ih.faults-&gt;hash,<o:p></o:p></pre>
                <pre>-                   AMDGPU_PAGEFAULT_HASH_BITS, 8, 0);<o:p></o:p></pre>
                <pre>-  spin_lock_init(&amp;adev-&gt;irq.ih.faults-&gt;lock);<o:p></o:p></pre>
                <pre>-  adev-&gt;irq.ih.faults-&gt;count = 0;<o:p></o:p></pre>
                <pre>-<o:p></o:p></pre>
                <pre>   r = amdgpu_irq_init(adev);<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre>   return r;<o:p></o:p></pre>
                <pre>@@ -406,9 +399,6 @@ static int vega10_ih_sw_fini(void *handle)<o:p></o:p></pre>
                <pre>   amdgpu_irq_fini(adev);<o:p></o:p></pre>
                <pre>   amdgpu_ih_ring_fini(adev);<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre>-  kfree(adev-&gt;irq.ih.faults);<o:p></o:p></pre>
                <pre>-  adev-&gt;irq.ih.faults = NULL;<o:p></o:p></pre>
                <pre>-<o:p></o:p></pre>
                <pre>   return 0;<o:p></o:p></pre>
                <pre> }<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
              </blockquote>
              <p class="MsoNormal"><br>
                <br>
                <br>
                <br>
                <br>
                <br>
                <o:p></o:p></p>
              <pre>_______________________________________________<o:p></o:p></pre>
              <pre>amd-gfx mailing list<o:p></o:p></pre>
              <pre><a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><o:p></o:p></pre>
              <pre><a href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></pre>
            </blockquote>
            <p class="MsoNormal"> <o:p></o:p></p>
          </blockquote>
          <p class="MsoNormal"> <o:p></o:p></p>
        </blockquote>
        <p class="MsoNormal"><o:p> </o:p></p>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------4CC820062F59CC991861C077--

--===============1295918396==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1295918396==--
