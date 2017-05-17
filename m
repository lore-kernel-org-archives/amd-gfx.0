From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 4/5] drm/amdgpu: Support page directory update via CPU
Date: Wed, 17 May 2017 10:59:47 +0200
Message-ID: <5205d253-430d-daac-ed1e-5c5ace9e909b@vodafone.de>
References: <1494883923-25876-1-git-send-email-Harish.Kasiviswanathan@amd.com>
 <1494883923-25876-4-git-send-email-Harish.Kasiviswanathan@amd.com>
 <591A68D7.80009@amd.com>
 <CY1PR1201MB1034A467A20010323B44EAEC8CE60@CY1PR1201MB1034.namprd12.prod.outlook.com>
 <591BAD6C.2070605@amd.com> <bec8a5a3-7d62-2ff5-96b9-2c03afec1483@vodafone.de>
 <591C0F9E.2030800@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0550997522=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <591C0F9E.2030800-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, "Kasiviswanathan, Harish" <Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0550997522==
Content-Type: multipart/alternative;
 boundary="------------0F9AE189A9A9A99A6B5EA329"

This is a multi-part message in MIME format.
--------------0F9AE189A9A9A99A6B5EA329
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.05.2017 um 10:53 schrieb zhoucm1:
>
>
> On 2017年05月17日 16:48, Christian König wrote:
>> Am 17.05.2017 um 03:54 schrieb zhoucm1:
>>>
>>>
>>> On 2017年05月17日 05:02, Kasiviswanathan, Harish wrote:
>>>>
>>>>
>>>> -----Original Message-----
>>>> From: Zhou, David(ChunMing)
>>>> Sent: Monday, May 15, 2017 10:50 PM
>>>> To: Kasiviswanathan, Harish <Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org>; 
>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>> Subject: Re: [PATCH 4/5] drm/amdgpu: Support page directory update 
>>>> via CPU
>>>>
>>>>
>>>>
>>>> On 2017年05月16日 05:32, Harish Kasiviswanathan wrote:
>>>> > If amdgpu.vm_update_context param is set to use CPU, then Page
>>>> > Directories will be updated by CPU instead of SDMA
>>>> >
>>>> > Signed-off-by: Harish Kasiviswanathan 
>>>> <Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org>
>>>> > ---
>>>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 151 
>>>> ++++++++++++++++++++++++---------
>>>> >   1 file changed, 109 insertions(+), 42 deletions(-)
>>>> >
>>>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> > index 9c89cb2..d72a624 100644
>>>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> > @@ -271,6 +271,7 @@ static int amdgpu_vm_alloc_levels(struct 
>>>> amdgpu_device *adev,
>>>> >                                  uint64_t saddr, uint64_t eaddr,
>>>> >                                  unsigned level)
>>>> >   {
>>>> > +     u64 flags;
>>>> >        unsigned shift = (adev->vm_manager.num_level - level) *
>>>> >                adev->vm_manager.block_size;
>>>> >        unsigned pt_idx, from, to;
>>>> > @@ -299,6 +300,14 @@ static int amdgpu_vm_alloc_levels(struct 
>>>> amdgpu_device *adev,
>>>> >        saddr = saddr & ((1 << shift) - 1);
>>>> >        eaddr = eaddr & ((1 << shift) - 1);
>>>> >
>>>> > +     flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
>>>> > + AMDGPU_GEM_CREATE_VRAM_CLEARED;
>>>> > +     if (vm->use_cpu_for_update)
>>>> > +             flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>>>> I think shadow flag is need for CPU case as well, which is used to
>>>> backup VM bo and meaningful when gpu reset.
>>>> same comment for pd bo.
>>>>
>>>> [HK]: Yes support for shadow BOs are desirable and it could be 
>>>> implemented as a separate commit. For supporting shadow BOs the 
>>>> caller should explicitly add shadow BOs into 
>>>> ttm_eu_reserve_buffer(..) to remove the BO from TTM swap list or 
>>>> ttm_bo_kmap has to be modified. This implementation for CPU update 
>>>> of VM page tables is mainly for KFD usage. Graphics will use for 
>>>> experimental and testing purpose. From KFD's view point shadow BO 
>>>> are not useful because if GPU is reset then all queue information 
>>>> is lost (since submissions are done by user space) and it is not 
>>>> possible to recover.
>>> Either way is fine to me.
>>
>> Actually I'm thinking about if we shouldn't completely drop the 
>> shadow handling.
>>
>> When VRAM is lost we now completely drop all jobs, so for new jobs we 
>> can recreate the page table content from the VM structures as well.
> For KGD, I agree. if their process is using both KGD and KFD, I still 
> think shadow bo is needed.
>
>>
>> When VRAM is not lost we don't need to restore the page tables.
> In fact, our 'vram lost' detection isn't critical, I was told by other 
> team, they encountered case that just some part vram is lost. So 
> restoring page table seems still need for vram isn't lost.

Ok, random VRAM corruption caused by a GPU reset is a good argument. So 
we should keep this feature.

Regards,
Christian.

>
> Regards,
> David Zhou
>>
>> What do you think?
>
>> Regards,
>> Christian.
>>
>>>
>>> David Zhou
>>>>
>>>> Regards,
>>>> David Zhou
>>>> > +     else
>>>> > +             flags |= (AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
>>>> > + AMDGPU_GEM_CREATE_SHADOW);
>>>> > +
>>>> >        /* walk over the address space and allocate the page tables */
>>>> >        for (pt_idx = from; pt_idx <= to; ++pt_idx) {
>>>> >                struct reservation_object *resv = 
>>>> vm->root.bo->tbo.resv;
>>>> > @@ -310,10 +319,7 @@ static int amdgpu_vm_alloc_levels(struct 
>>>> amdgpu_device *adev,
>>>> > amdgpu_vm_bo_size(adev, level),
>>>> > AMDGPU_GPU_PAGE_SIZE, true,
>>>> > AMDGPU_GEM_DOMAIN_VRAM,
>>>> > - AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
>>>> > - AMDGPU_GEM_CREATE_SHADOW |
>>>> > - AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
>>>> > - AMDGPU_GEM_CREATE_VRAM_CLEARED,
>>>> > +                                          flags,
>>>> >                                             NULL, resv, &pt);
>>>> >                        if (r)
>>>> >                                return r;
>>>> > @@ -952,6 +958,43 @@ static uint64_t amdgpu_vm_map_gart(const 
>>>> dma_addr_t *pages_addr, uint64_t addr)
>>>> >        return result;
>>>> >   }
>>>> >
>>>> > +/**
>>>> > + * amdgpu_vm_cpu_set_ptes - helper to update page tables via CPU
>>>> > + *
>>>> > + * @params: see amdgpu_pte_update_params definition
>>>> > + * @pe: kmap addr of the page entry
>>>> > + * @addr: dst addr to write into pe
>>>> > + * @count: number of page entries to update
>>>> > + * @incr: increase next addr by incr bytes
>>>> > + * @flags: hw access flags
>>>> > + */
>>>> > +static void amdgpu_vm_cpu_set_ptes(struct 
>>>> amdgpu_pte_update_params *params,
>>>> > +                                uint64_t pe, uint64_t addr,
>>>> > +                                unsigned count, uint32_t incr,
>>>> > +                                uint64_t flags)
>>>> > +{
>>>> > +     unsigned int i;
>>>> > +
>>>> > +     for (i = 0; i < count; i++) {
>>>> > + amdgpu_gart_set_pte_pde(params->adev, (void *)pe,
>>>> > +                                     i, addr, flags);
>>>> > +             addr += incr;
>>>> > +     }
>>>> > +
>>>> > +     mb();
>>>> > +     amdgpu_gart_flush_gpu_tlb(params->adev, 0);
>>>> > +}
>>>> > +
>>>> > +static void amdgpu_vm_bo_wait(struct amdgpu_device *adev, struct 
>>>> amdgpu_bo *bo)
>>>> > +{
>>>> > +     struct amdgpu_sync sync;
>>>> > +
>>>> > +     amdgpu_sync_create(&sync);
>>>> > +     amdgpu_sync_resv(adev, &sync, bo->tbo.resv, 
>>>> AMDGPU_FENCE_OWNER_VM);
>>>> > +     amdgpu_sync_wait(&sync);
>>>> > +     amdgpu_sync_free(&sync);
>>>> > +}
>>>> > +
>>>> >   /*
>>>> >    * amdgpu_vm_update_level - update a single level in the hierarchy
>>>> >    *
>>>> > @@ -981,34 +1024,50 @@ static int amdgpu_vm_update_level(struct 
>>>> amdgpu_device *adev,
>>>> >
>>>> >        if (!parent->entries)
>>>> >                return 0;
>>>> > -     ring = container_of(vm->entity.sched, struct amdgpu_ring, 
>>>> sched);
>>>> >
>>>> > -     /* padding, etc. */
>>>> > -     ndw = 64;
>>>> > +     memset(&params, 0, sizeof(params));
>>>> > +     params.adev = adev;
>>>> > +     shadow = parent->bo->shadow;
>>>> >
>>>> > -     /* assume the worst case */
>>>> > -     ndw += parent->last_entry_used * 6;
>>>> > +     WARN_ON(vm->use_cpu_for_update && shadow);
>>>> > +     if (vm->use_cpu_for_update && !shadow) {
>>>> > +             r = amdgpu_bo_kmap(parent->bo, (void **)&pd_addr);
>>>> > +             if (r)
>>>> > +                     return r;
>>>> > +             amdgpu_vm_bo_wait(adev, parent->bo);
>>>> > +             params.func = amdgpu_vm_cpu_set_ptes;
>>>> > +     } else {
>>>> > +             if (shadow) {
>>>> > +                     r = amdgpu_ttm_bind(&shadow->tbo, 
>>>> &shadow->tbo.mem);
>>>> > +                     if (r)
>>>> > +                             return r;
>>>> > +             }
>>>> > +             ring = container_of(vm->entity.sched, struct 
>>>> amdgpu_ring,
>>>> > +                                 sched);
>>>> >
>>>> > -     pd_addr = amdgpu_bo_gpu_offset(parent->bo);
>>>> > +             /* padding, etc. */
>>>> > +             ndw = 64;
>>>> >
>>>> > -     shadow = parent->bo->shadow;
>>>> > -     if (shadow) {
>>>> > -             r = amdgpu_ttm_bind(&shadow->tbo, &shadow->tbo.mem);
>>>> > +             /* assume the worst case */
>>>> > +             ndw += parent->last_entry_used * 6;
>>>> > +
>>>> > +             pd_addr = amdgpu_bo_gpu_offset(parent->bo);
>>>> > +
>>>> > +             if (shadow) {
>>>> > +                     shadow_addr = amdgpu_bo_gpu_offset(shadow);
>>>> > +                     ndw *= 2;
>>>> > +             } else {
>>>> > +                     shadow_addr = 0;
>>>> > +             }
>>>> > +
>>>> > +             r = amdgpu_job_alloc_with_ib(adev, ndw * 4, &job);
>>>> >                if (r)
>>>> >                        return r;
>>>> > -             shadow_addr = amdgpu_bo_gpu_offset(shadow);
>>>> > -             ndw *= 2;
>>>> > -     } else {
>>>> > -             shadow_addr = 0;
>>>> > -     }
>>>> >
>>>> > -     r = amdgpu_job_alloc_with_ib(adev, ndw * 4, &job);
>>>> > -     if (r)
>>>> > -             return r;
>>>> > +             params.ib = &job->ibs[0];
>>>> > +             params.func = amdgpu_vm_do_set_ptes;
>>>> > +     }
>>>> >
>>>> > -     memset(&params, 0, sizeof(params));
>>>> > -     params.adev = adev;
>>>> > -     params.ib = &job->ibs[0];
>>>> >
>>>> >        /* walk over the address space and update the directory */
>>>> >        for (pt_idx = 0; pt_idx <= parent->last_entry_used; 
>>>> ++pt_idx) {
>>>> > @@ -1043,15 +1102,15 @@ static int amdgpu_vm_update_level(struct 
>>>> amdgpu_device *adev,
>>>> > amdgpu_vm_adjust_mc_addr(adev, last_pt);
>>>> >
>>>> >                                if (shadow)
>>>> > - amdgpu_vm_do_set_ptes(&params,
>>>> > - last_shadow,
>>>> > - pt_addr, count,
>>>> > - incr,
>>>> > - AMDGPU_PTE_VALID);
>>>> > -
>>>> > - amdgpu_vm_do_set_ptes(&params, last_pde,
>>>> > - pt_addr, count, incr,
>>>> > - AMDGPU_PTE_VALID);
>>>> > + params.func(&params,
>>>> > + last_shadow,
>>>> > + pt_addr, count,
>>>> > + incr,
>>>> > + AMDGPU_PTE_VALID);
>>>> > +
>>>> > + params.func(&params, last_pde,
>>>> > + pt_addr, count, incr,
>>>> > + AMDGPU_PTE_VALID);
>>>> >                        }
>>>> >
>>>> >                        count = 1;
>>>> > @@ -1067,14 +1126,16 @@ static int amdgpu_vm_update_level(struct 
>>>> amdgpu_device *adev,
>>>> >                uint64_t pt_addr = amdgpu_vm_adjust_mc_addr(adev, 
>>>> last_pt);
>>>> >
>>>> >                if (vm->root.bo->shadow)
>>>> > - amdgpu_vm_do_set_ptes(&params, last_shadow, pt_addr,
>>>> > - count, incr, AMDGPU_PTE_VALID);
>>>> > +                     params.func(&params, last_shadow, pt_addr,
>>>> > +                                 count, incr, AMDGPU_PTE_VALID);
>>>> >
>>>> > -             amdgpu_vm_do_set_ptes(&params, last_pde, pt_addr,
>>>> > -                                   count, incr, AMDGPU_PTE_VALID);
>>>> > +             params.func(&params, last_pde, pt_addr,
>>>> > +                         count, incr, AMDGPU_PTE_VALID);
>>>> >        }
>>>> >
>>>> > -     if (params.ib->length_dw == 0) {
>>>> > +     if (params.func == amdgpu_vm_cpu_set_ptes)
>>>> > +             amdgpu_bo_kunmap(parent->bo);
>>>> > +     else if (params.ib->length_dw == 0) {
>>>> >                amdgpu_job_free(job);
>>>> >        } else {
>>>> >                amdgpu_ring_pad_ib(ring, params.ib);
>>>> > @@ -2309,6 +2370,7 @@ int amdgpu_vm_init(struct amdgpu_device 
>>>> *adev, struct amdgpu_vm *vm,
>>>> >        struct amdgpu_ring *ring;
>>>> >        struct amd_sched_rq *rq;
>>>> >        int r, i;
>>>> > +     u64 flags;
>>>> >
>>>> >        vm->va = RB_ROOT;
>>>> >        vm->client_id = 
>>>> atomic64_inc_return(&adev->vm_manager.client_counter);
>>>> > @@ -2342,12 +2404,17 @@ int amdgpu_vm_init(struct amdgpu_device 
>>>> *adev, struct amdgpu_vm *vm,
>>>> >                  "CPU update of VM recommended only for large BAR 
>>>> system\n");
>>>> >        vm->last_dir_update = NULL;
>>>> >
>>>> > +     flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
>>>> > + AMDGPU_GEM_CREATE_VRAM_CLEARED;
>>>> > +     if (vm->use_cpu_for_update)
>>>> > +             flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>>>> > +     else
>>>> > +             flags |= (AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
>>>> > + AMDGPU_GEM_CREATE_SHADOW);
>>>> > +
>>>> >        r = amdgpu_bo_create(adev, amdgpu_vm_bo_size(adev, 0), 
>>>> align, true,
>>>> > AMDGPU_GEM_DOMAIN_VRAM,
>>>> > - AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
>>>> > - AMDGPU_GEM_CREATE_SHADOW |
>>>> > - AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
>>>> > - AMDGPU_GEM_CREATE_VRAM_CLEARED,
>>>> > +                          flags,
>>>> >                             NULL, NULL, &vm->root.bo);
>>>> >        if (r)
>>>> >                goto error_free_sched_entity;
>>>>
>>>
>>>
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>>
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------0F9AE189A9A9A99A6B5EA329
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 17.05.2017 um 10:53 schrieb zhoucm1:<br>
    </div>
    <blockquote cite="mid:591C0F9E.2030800-5C7GfCeVMHo@public.gmane.org" type="cite">
      <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
      <br>
      <br>
      <div class="moz-cite-prefix">On 2017年05月17日 16:48, Christian König
        wrote:<br>
      </div>
      <blockquote
        cite="mid:bec8a5a3-7d62-2ff5-96b9-2c03afec1483-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
        type="cite">
        <meta http-equiv="Content-Type" content="text/html;
          charset=utf-8">
        <div class="moz-cite-prefix">Am 17.05.2017 um 03:54 schrieb
          zhoucm1:<br>
        </div>
        <blockquote cite="mid:591BAD6C.2070605-5C7GfCeVMHo@public.gmane.org" type="cite"> <br>
          <br>
          <div class="moz-cite-prefix">On 2017年05月17日 05:02,
            Kasiviswanathan, Harish wrote:<br>
          </div>
          <blockquote
cite="mid:CY1PR1201MB1034A467A20010323B44EAEC8CE60-JBJ/M6OpXY+irIVeHNVyQ2rFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org"
            type="cite">
            <meta name="Generator" content="Microsoft Exchange Server">
            <!-- converted from text -->
            <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
            <font size="2"><span style="font-size:10pt;">
                <div class="PlainText"><br>
                  <br>
                  -----Original Message-----<br>
                  From: Zhou, David(ChunMing) <br>
                  Sent: Monday, May 15, 2017 10:50 PM<br>
                  To: Kasiviswanathan, Harish <a moz-do-not-send="true"
                    class="moz-txt-link-rfc2396E"
                    href="mailto:Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org">&lt;Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                  <a moz-do-not-send="true"
                    class="moz-txt-link-abbreviated"
                    href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  Subject: Re: [PATCH 4/5] drm/amdgpu: Support page
                  directory update via CPU<br>
                  <br>
                  <br>
                  <br>
                  On 2017年05月16日 05:32, Harish Kasiviswanathan wrote:<br>
                  &gt; If amdgpu.vm_update_context param is set to use
                  CPU, then Page<br>
                  &gt; Directories will be updated by CPU instead of
                  SDMA<br>
                  &gt;<br>
                  &gt; Signed-off-by: Harish Kasiviswanathan <a
                    moz-do-not-send="true" class="moz-txt-link-rfc2396E"
                    href="mailto:Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org">&lt;Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  &gt; ---<br>
                  &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 151
                  ++++++++++++++++++++++++---------<br>
                  &gt;   1 file changed, 109 insertions(+), 42
                  deletions(-)<br>
                  &gt;<br>
                  &gt; diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                  &gt; index 9c89cb2..d72a624 100644<br>
                  &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                  &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                  &gt; @@ -271,6 +271,7 @@ static int
                  amdgpu_vm_alloc_levels(struct amdgpu_device *adev,<br>
                  &gt;                                  uint64_t saddr,
                  uint64_t eaddr,<br>
                  &gt;                                  unsigned level)<br>
                  &gt;   {<br>
                  &gt; +     u64 flags;<br>
                  &gt;        unsigned shift =
                  (adev-&gt;vm_manager.num_level - level) *<br>
                  &gt;                adev-&gt;vm_manager.block_size;<br>
                  &gt;        unsigned pt_idx, from, to;<br>
                  &gt; @@ -299,6 +300,14 @@ static int
                  amdgpu_vm_alloc_levels(struct amdgpu_device *adev,<br>
                  &gt;        saddr = saddr &amp; ((1 &lt;&lt; shift) -
                  1);<br>
                  &gt;        eaddr = eaddr &amp; ((1 &lt;&lt; shift) -
                  1);<br>
                  &gt;   <br>
                  &gt; +     flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |<br>
                  &gt; +                    
                  AMDGPU_GEM_CREATE_VRAM_CLEARED;<br>
                  &gt; +     if (vm-&gt;use_cpu_for_update)<br>
                  &gt; +             flags |=
                  AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;<br>
                  I think shadow flag is need for CPU case as well,
                  which is used to <br>
                  backup VM bo and meaningful when gpu reset.<br>
                  same comment for pd bo.<br>
                  <br>
                  [HK]: Yes support for shadow BOs are desirable and it
                  could be implemented as a separate commit. For
                  supporting shadow BOs the caller should explicitly add
                  shadow BOs into ttm_eu_reserve_buffer(..) to remove
                  the BO from TTM swap list or ttm_bo_kmap has to be
                  modified. This implementation for CPU update of VM
                  page tables is mainly for KFD usage. Graphics will use
                  for experimental and testing purpose. From KFD's view
                  point shadow BO are not useful because if GPU is reset
                  then all queue information is lost (since submissions
                  are done by user space) and it is not possible to
                  recover.<br>
                </div>
              </span></font></blockquote>
          <font size="2">Either way is fine to me.<br>
          </font></blockquote>
        <br>
        Actually I'm thinking about if we shouldn't completely drop the
        shadow handling.<br>
        <br>
        When VRAM is lost we now completely drop all jobs, so for new
        jobs we can recreate the page table content from the VM
        structures as well.<br>
      </blockquote>
      For KGD, I agree. if their process is using both KGD and KFD, I
      still think shadow bo is needed.<br>
      <br>
      <blockquote
        cite="mid:bec8a5a3-7d62-2ff5-96b9-2c03afec1483-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
        type="cite"> <br>
        When VRAM is not lost we don't need to restore the page tables.<br>
      </blockquote>
      In fact, our 'vram lost' detection isn't critical, I was told by
      other team, they encountered case that just some part vram is
      lost. So restoring page table seems still need for vram isn't
      lost.<br>
    </blockquote>
    <br>
    Ok, random VRAM corruption caused by a GPU reset is a good argument.
    So we should keep this feature.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote cite="mid:591C0F9E.2030800-5C7GfCeVMHo@public.gmane.org" type="cite"> <br>
      Regards,<br>
      David Zhou<br>
      <blockquote
        cite="mid:bec8a5a3-7d62-2ff5-96b9-2c03afec1483-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
        type="cite"> <br>
        What do you think?<br>
      </blockquote>
      <br>
      <blockquote
        cite="mid:bec8a5a3-7d62-2ff5-96b9-2c03afec1483-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
        type="cite"> Regards,<br>
        Christian.<br>
        <br>
        <blockquote cite="mid:591BAD6C.2070605-5C7GfCeVMHo@public.gmane.org" type="cite"><font
            size="2"> <br>
            David Zhou<br>
          </font>
          <blockquote
cite="mid:CY1PR1201MB1034A467A20010323B44EAEC8CE60-JBJ/M6OpXY+irIVeHNVyQ2rFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org"
            type="cite"><font size="2"><span style="font-size:10pt;">
                <div class="PlainText"> <br>
                  Regards,<br>
                  David Zhou<br>
                  &gt; +     else<br>
                  &gt; +             flags |=
                  (AMDGPU_GEM_CREATE_NO_CPU_ACCESS |<br>
                  &gt; +                            
                  AMDGPU_GEM_CREATE_SHADOW);<br>
                  &gt; +<br>
                  &gt;        /* walk over the address space and
                  allocate the page tables */<br>
                  &gt;        for (pt_idx = from; pt_idx &lt;= to;
                  ++pt_idx) {<br>
                  &gt;                struct reservation_object *resv =
                  vm-&gt;root.bo-&gt;tbo.resv;<br>
                  &gt; @@ -310,10 +319,7 @@ static int
                  amdgpu_vm_alloc_levels(struct amdgpu_device *adev,<br>
                  &gt;                                            
                  amdgpu_vm_bo_size(adev, level),<br>
                  &gt;                                            
                  AMDGPU_GPU_PAGE_SIZE, true,<br>
                  &gt;                                            
                  AMDGPU_GEM_DOMAIN_VRAM,<br>
                  &gt; -                                         
                  AMDGPU_GEM_CREATE_NO_CPU_ACCESS |<br>
                  &gt; -                                         
                  AMDGPU_GEM_CREATE_SHADOW |<br>
                  &gt; -                                         
                  AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |<br>
                  &gt; -                                         
                  AMDGPU_GEM_CREATE_VRAM_CLEARED,<br>
                  &gt; +                                          flags,<br>
                  &gt;                                             NULL,
                  resv, &amp;pt);<br>
                  &gt;                        if (r)<br>
                  &gt;                                return r;<br>
                  &gt; @@ -952,6 +958,43 @@ static uint64_t
                  amdgpu_vm_map_gart(const dma_addr_t *pages_addr,
                  uint64_t addr)<br>
                  &gt;        return result;<br>
                  &gt;   }<br>
                  &gt;   <br>
                  &gt; +/**<br>
                  &gt; + * amdgpu_vm_cpu_set_ptes - helper to update
                  page tables via CPU<br>
                  &gt; + *<br>
                  &gt; + * @params: see amdgpu_pte_update_params
                  definition<br>
                  &gt; + * @pe: kmap addr of the page entry<br>
                  &gt; + * @addr: dst addr to write into pe<br>
                  &gt; + * @count: number of page entries to update<br>
                  &gt; + * @incr: increase next addr by incr bytes<br>
                  &gt; + * @flags: hw access flags<br>
                  &gt; + */<br>
                  &gt; +static void amdgpu_vm_cpu_set_ptes(struct
                  amdgpu_pte_update_params *params,<br>
                  &gt; +                                uint64_t pe,
                  uint64_t addr,<br>
                  &gt; +                                unsigned count,
                  uint32_t incr,<br>
                  &gt; +                                uint64_t flags)<br>
                  &gt; +{<br>
                  &gt; +     unsigned int i;<br>
                  &gt; +<br>
                  &gt; +     for (i = 0; i &lt; count; i++) {<br>
                  &gt; +            
                  amdgpu_gart_set_pte_pde(params-&gt;adev, (void *)pe,<br>
                  &gt; +                                     i, addr,
                  flags);<br>
                  &gt; +             addr += incr;<br>
                  &gt; +     }<br>
                  &gt; +<br>
                  &gt; +     mb();<br>
                  &gt; +     amdgpu_gart_flush_gpu_tlb(params-&gt;adev,
                  0);<br>
                  &gt; +}<br>
                  &gt; +<br>
                  &gt; +static void amdgpu_vm_bo_wait(struct
                  amdgpu_device *adev, struct amdgpu_bo *bo)<br>
                  &gt; +{<br>
                  &gt; +     struct amdgpu_sync sync;<br>
                  &gt; +<br>
                  &gt; +     amdgpu_sync_create(&amp;sync);<br>
                  &gt; +     amdgpu_sync_resv(adev, &amp;sync,
                  bo-&gt;tbo.resv, AMDGPU_FENCE_OWNER_VM);<br>
                  &gt; +     amdgpu_sync_wait(&amp;sync);<br>
                  &gt; +     amdgpu_sync_free(&amp;sync);<br>
                  &gt; +}<br>
                  &gt; +<br>
                  &gt;   /*<br>
                  &gt;    * amdgpu_vm_update_level - update a single
                  level in the hierarchy<br>
                  &gt;    *<br>
                  &gt; @@ -981,34 +1024,50 @@ static int
                  amdgpu_vm_update_level(struct amdgpu_device *adev,<br>
                  &gt;   <br>
                  &gt;        if (!parent-&gt;entries)<br>
                  &gt;                return 0;<br>
                  &gt; -     ring = container_of(vm-&gt;entity.sched,
                  struct amdgpu_ring, sched);<br>
                  &gt;   <br>
                  &gt; -     /* padding, etc. */<br>
                  &gt; -     ndw = 64;<br>
                  &gt; +     memset(&amp;params, 0, sizeof(params));<br>
                  &gt; +     params.adev = adev;<br>
                  &gt; +     shadow = parent-&gt;bo-&gt;shadow;<br>
                  &gt;   <br>
                  &gt; -     /* assume the worst case */<br>
                  &gt; -     ndw += parent-&gt;last_entry_used * 6;<br>
                  &gt; +     WARN_ON(vm-&gt;use_cpu_for_update
                  &amp;&amp; shadow);<br>
                  &gt; +     if (vm-&gt;use_cpu_for_update &amp;&amp;
                  !shadow) {<br>
                  &gt; +             r = amdgpu_bo_kmap(parent-&gt;bo,
                  (void **)&amp;pd_addr);<br>
                  &gt; +             if (r)<br>
                  &gt; +                     return r;<br>
                  &gt; +             amdgpu_vm_bo_wait(adev,
                  parent-&gt;bo);<br>
                  &gt; +             params.func =
                  amdgpu_vm_cpu_set_ptes;<br>
                  &gt; +     } else {<br>
                  &gt; +             if (shadow) {<br>
                  &gt; +                     r =
                  amdgpu_ttm_bind(&amp;shadow-&gt;tbo,
                  &amp;shadow-&gt;tbo.mem);<br>
                  &gt; +                     if (r)<br>
                  &gt; +                             return r;<br>
                  &gt; +             }<br>
                  &gt; +             ring =
                  container_of(vm-&gt;entity.sched, struct amdgpu_ring,<br>
                  &gt; +                                 sched);<br>
                  &gt;   <br>
                  &gt; -     pd_addr =
                  amdgpu_bo_gpu_offset(parent-&gt;bo);<br>
                  &gt; +             /* padding, etc. */<br>
                  &gt; +             ndw = 64;<br>
                  &gt;   <br>
                  &gt; -     shadow = parent-&gt;bo-&gt;shadow;<br>
                  &gt; -     if (shadow) {<br>
                  &gt; -             r =
                  amdgpu_ttm_bind(&amp;shadow-&gt;tbo,
                  &amp;shadow-&gt;tbo.mem);<br>
                  &gt; +             /* assume the worst case */<br>
                  &gt; +             ndw += parent-&gt;last_entry_used *
                  6;<br>
                  &gt; +<br>
                  &gt; +             pd_addr =
                  amdgpu_bo_gpu_offset(parent-&gt;bo);<br>
                  &gt; +<br>
                  &gt; +             if (shadow) {<br>
                  &gt; +                     shadow_addr =
                  amdgpu_bo_gpu_offset(shadow);<br>
                  &gt; +                     ndw *= 2;<br>
                  &gt; +             } else {<br>
                  &gt; +                     shadow_addr = 0;<br>
                  &gt; +             }<br>
                  &gt; +<br>
                  &gt; +             r = amdgpu_job_alloc_with_ib(adev,
                  ndw * 4, &amp;job);<br>
                  &gt;                if (r)<br>
                  &gt;                        return r;<br>
                  &gt; -             shadow_addr =
                  amdgpu_bo_gpu_offset(shadow);<br>
                  &gt; -             ndw *= 2;<br>
                  &gt; -     } else {<br>
                  &gt; -             shadow_addr = 0;<br>
                  &gt; -     }<br>
                  &gt;   <br>
                  &gt; -     r = amdgpu_job_alloc_with_ib(adev, ndw * 4,
                  &amp;job);<br>
                  &gt; -     if (r)<br>
                  &gt; -             return r;<br>
                  &gt; +             params.ib = &amp;job-&gt;ibs[0];<br>
                  &gt; +             params.func =
                  amdgpu_vm_do_set_ptes;<br>
                  &gt; +     }<br>
                  &gt;   <br>
                  &gt; -     memset(&amp;params, 0, sizeof(params));<br>
                  &gt; -     params.adev = adev;<br>
                  &gt; -     params.ib = &amp;job-&gt;ibs[0];<br>
                  &gt;   <br>
                  &gt;        /* walk over the address space and update
                  the directory */<br>
                  &gt;        for (pt_idx = 0; pt_idx &lt;=
                  parent-&gt;last_entry_used; ++pt_idx) {<br>
                  &gt; @@ -1043,15 +1102,15 @@ static int
                  amdgpu_vm_update_level(struct amdgpu_device *adev,<br>
                  &gt;                                       
                  amdgpu_vm_adjust_mc_addr(adev, last_pt);<br>
                  &gt;   <br>
                  &gt;                                if (shadow)<br>
                  &gt; -                                    
                  amdgpu_vm_do_set_ptes(&amp;params,<br>
                  &gt;
                  -                                                          
                  last_shadow,<br>
                  &gt;
                  -                                                          
                  pt_addr, count,<br>
                  &gt;
                  -                                                          
                  incr,<br>
                  &gt;
                  -                                                          
                  AMDGPU_PTE_VALID);<br>
                  &gt; -<br>
                  &gt; -                            
                  amdgpu_vm_do_set_ptes(&amp;params, last_pde,<br>
                  &gt;
                  -                                                  
                  pt_addr, count, incr,<br>
                  &gt;
                  -                                                  
                  AMDGPU_PTE_VALID);<br>
                  &gt; +                                    
                  params.func(&amp;params,<br>
                  &gt; +                                                
                  last_shadow,<br>
                  &gt; +                                                
                  pt_addr, count,<br>
                  &gt; +                                                
                  incr,<br>
                  &gt; +                                                
                  AMDGPU_PTE_VALID);<br>
                  &gt; +<br>
                  &gt; +                            
                  params.func(&amp;params, last_pde,<br>
                  &gt; +                                        
                  pt_addr, count, incr,<br>
                  &gt; +                                        
                  AMDGPU_PTE_VALID);<br>
                  &gt;                        }<br>
                  &gt;   <br>
                  &gt;                        count = 1;<br>
                  &gt; @@ -1067,14 +1126,16 @@ static int
                  amdgpu_vm_update_level(struct amdgpu_device *adev,<br>
                  &gt;                uint64_t pt_addr =
                  amdgpu_vm_adjust_mc_addr(adev, last_pt);<br>
                  &gt;   <br>
                  &gt;                if (vm-&gt;root.bo-&gt;shadow)<br>
                  &gt; -                    
                  amdgpu_vm_do_set_ptes(&amp;params, last_shadow,
                  pt_addr,<br>
                  &gt; -                                          
                  count, incr, AMDGPU_PTE_VALID);<br>
                  &gt; +                     params.func(&amp;params,
                  last_shadow, pt_addr,<br>
                  &gt; +                                 count, incr,
                  AMDGPU_PTE_VALID);<br>
                  &gt;   <br>
                  &gt; -             amdgpu_vm_do_set_ptes(&amp;params,
                  last_pde, pt_addr,<br>
                  &gt; -                                   count, incr,
                  AMDGPU_PTE_VALID);<br>
                  &gt; +             params.func(&amp;params, last_pde,
                  pt_addr,<br>
                  &gt; +                         count, incr,
                  AMDGPU_PTE_VALID);<br>
                  &gt;        }<br>
                  &gt;   <br>
                  &gt; -     if (params.ib-&gt;length_dw == 0) {<br>
                  &gt; +     if (params.func == amdgpu_vm_cpu_set_ptes)<br>
                  &gt; +             amdgpu_bo_kunmap(parent-&gt;bo);<br>
                  &gt; +     else if (params.ib-&gt;length_dw == 0) {<br>
                  &gt;                amdgpu_job_free(job);<br>
                  &gt;        } else {<br>
                  &gt;                amdgpu_ring_pad_ib(ring,
                  params.ib);<br>
                  &gt; @@ -2309,6 +2370,7 @@ int amdgpu_vm_init(struct
                  amdgpu_device *adev, struct amdgpu_vm *vm,<br>
                  &gt;        struct amdgpu_ring *ring;<br>
                  &gt;        struct amd_sched_rq *rq;<br>
                  &gt;        int r, i;<br>
                  &gt; +     u64 flags;<br>
                  &gt;   <br>
                  &gt;        vm-&gt;va = RB_ROOT;<br>
                  &gt;        vm-&gt;client_id =
                  atomic64_inc_return(&amp;adev-&gt;vm_manager.client_counter);<br>
                  &gt; @@ -2342,12 +2404,17 @@ int amdgpu_vm_init(struct
                  amdgpu_device *adev, struct amdgpu_vm *vm,<br>
                  &gt;                  "CPU update of VM recommended
                  only for large BAR system\n");<br>
                  &gt;        vm-&gt;last_dir_update = NULL;<br>
                  &gt;   <br>
                  &gt; +     flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |<br>
                  &gt; +                    
                  AMDGPU_GEM_CREATE_VRAM_CLEARED;<br>
                  &gt; +     if (vm-&gt;use_cpu_for_update)<br>
                  &gt; +             flags |=
                  AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;<br>
                  &gt; +     else<br>
                  &gt; +             flags |=
                  (AMDGPU_GEM_CREATE_NO_CPU_ACCESS |<br>
                  &gt; +                            
                  AMDGPU_GEM_CREATE_SHADOW);<br>
                  &gt; +<br>
                  &gt;        r = amdgpu_bo_create(adev,
                  amdgpu_vm_bo_size(adev, 0), align, true,<br>
                  &gt;                            
                  AMDGPU_GEM_DOMAIN_VRAM,<br>
                  &gt; -                         
                  AMDGPU_GEM_CREATE_NO_CPU_ACCESS |<br>
                  &gt; -                         
                  AMDGPU_GEM_CREATE_SHADOW |<br>
                  &gt; -                         
                  AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |<br>
                  &gt; -                         
                  AMDGPU_GEM_CREATE_VRAM_CLEARED,<br>
                  &gt; +                          flags,<br>
                  &gt;                             NULL, NULL,
                  &amp;vm-&gt;root.bo);<br>
                  &gt;        if (r)<br>
                  &gt;                goto error_free_sched_entity;<br>
                  <br>
                </div>
              </span></font> </blockquote>
          <br>
          <br>
          <fieldset class="mimeAttachmentHeader"></fieldset>
          <br>
          <pre wrap="">_______________________________________________
amd-gfx mailing list
<a moz-do-not-send="true" class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a moz-do-not-send="true" class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
        </blockquote>
        <p><br>
        </p>
        <br>
        <fieldset class="mimeAttachmentHeader"></fieldset>
        <br>
        <pre wrap="">_______________________________________________
amd-gfx mailing list
<a moz-do-not-send="true" class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a moz-do-not-send="true" class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
      </blockquote>
      <br>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------0F9AE189A9A9A99A6B5EA329--

--===============0550997522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0550997522==--
