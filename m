From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: remove PT BOs when unmapping
Date: Wed, 30 Oct 2019 18:57:06 +0100
Message-ID: <461cc802-e7c5-f968-1cb4-5e55a306e780@gmail.com>
References: <3f4b6803-ec66-44ca-b55a-8bccf4236632@email.android.com>
 <b8ad3c90-42d0-512d-5ba0-af330eab30a1@amd.com>
 <b5d9309e-a32b-8243-8c4d-cfd4e77e09e1@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1058738385=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b5d9309e-a32b-8243-8c4d-cfd4e77e09e1-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Huang, JinHuiEric" <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1058738385==
Content-Type: multipart/alternative;
 boundary="------------C689F9797893CAC97CE41631"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------C689F9797893CAC97CE41631
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

One thing I've forgotten:

What you could maybe do to improve the situation is to join adjacent 
ranges in amdgpu_vm_clear_freed(), but I'm not sure how the chances are 
that the ranges are freed all together.

The only other alternative I can see would be to check the mappings of a 
range in amdgpu_update_ptes() and see if you could walk the tree up if 
the valid flag is not set and there are no mappings left for a page table.

Regards,
Christian.

Am 30.10.19 um 18:42 schrieb Koenig, Christian:
>> The vaild flag doesn't take effect in this function.
> That's irrelevant.
>
> See what amdgpu_vm_update_ptes() does is to first determine the 
> fragment size:
>> amdgpu_vm_fragment(params, frag_start, end, flags, &frag, &frag_end);
>
> Then we walk down the tree:
>>         amdgpu_vm_pt_start(adev, params->vm, start, &cursor);
>>         while (cursor.pfn < end) {
>
> And make sure that the page tables covering the address range are 
> actually allocated:
>>                 r = amdgpu_vm_alloc_pts(params->adev, params->vm, 
>> &cursor);
>
> Then we update the tables with the flags and addresses and free up 
> subsequent tables in the case of huge pages or freed up areas:
>>                         /* Free all child entries */
>>                         while (cursor.pfn < frag_start) {
>>                                 amdgpu_vm_free_pts(adev, params->vm, 
>> &cursor);
>>                                 amdgpu_vm_pt_next(adev, &cursor);
>>                         }
>
> This is the maximum you can free, cause all other page tables are not 
> completely covered by the range and so potentially still in use.
>
> And I have the strong suspicion that this is what your patch is 
> actually doing wrong. In other words you are also freeing page tables 
> which are only partially covered by the range and so potentially still 
> in use.
>
> Since we don't have any tracking how many entries in a page table are 
> currently valid and how many are invalid we actually can't implement 
> what you are trying to do here. So the patch is definitely somehow broken.
>
> Regards,
> Christian.
>
> Am 30.10.19 um 17:55 schrieb Huang, JinHuiEric:
>>
>> The vaild flag doesn't take effect in this function. 
>> amdgpu_vm_alloc_pts() is always executed that only depended on 
>> "cursor.pfn < end". The valid flag has only been checked on here for 
>> asic below GMC v9:
>>
>> if (adev->asic_type < CHIP_VEGA10 &&
>>             (flags & AMDGPU_PTE_VALID))...
>>
>> Regards,
>>
>> Eric
>>
>> On 2019-10-30 12:30 p.m., Koenig, Christian wrote:
>>>
>>>
>>> Am 30.10.2019 17:19 schrieb "Huang, JinHuiEric" 
>>> <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>:
>>>
>>>     I tested it that it saves a lot of vram on KFD big buffer stress
>>>     test. I think there are two reasons:
>>>
>>>     1. Calling amdgpu_vm_update_ptes() during unmapping will
>>>     allocate unnecessary pts, because there is no flag to determine
>>>     if the VA is mapping or unmapping in function
>>>     amdgpu_vm_update_ptes(). It saves the most of memory.
>>>
>>> That's not correct. The valid flag is used for this.
>>>
>>>     2. Intentionally removing those unmapping pts is logical
>>>     expectation, although it is not removing so much pts.
>>>
>>> Well I actually don't see a change to what update_ptes is doing and 
>>> have the strong suspicion that the patch is simply broken.
>>>
>>> You either free page tables which are potentially still in use or 
>>> update_pte doesn't free page tables when the valid but is not set.
>>>
>>> Regards,
>>> Christian.
>>>
>>>
>>>
>>>     Regards,
>>>
>>>     Eric
>>>
>>>     On 2019-10-30 11:57 a.m., Koenig, Christian wrote:
>>>
>>>
>>>
>>>         Am 30.10.2019 16:47 schrieb "Kuehling, Felix"
>>>         <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org> <mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>:
>>>
>>>             On 2019-10-30 9:52 a.m., Christian König wrote:
>>>             > Am 29.10.19 um 21:06 schrieb Huang, JinHuiEric:
>>>             >> The issue is PT BOs are not freed when unmapping VA,
>>>             >> which causes vram usage accumulated is huge in some
>>>             >> memory stress test, such as kfd big buffer stress test.
>>>             >> Function amdgpu_vm_bo_update_mapping() is called by both
>>>             >> amdgpu_vm_bo_update() and amdgpu_vm_clear_freed(). The
>>>             >> solution is replacing amdgpu_vm_bo_update_mapping() in
>>>             >> amdgpu_vm_clear_freed() with removing PT BOs function
>>>             >> to save vram usage.
>>>             >
>>>             > NAK, that is intentional behavior.
>>>             >
>>>             > Otherwise we can run into out of memory situations
>>>             when page tables
>>>             > need to be allocated again under stress.
>>>
>>>             That's a bit arbitrary and inconsistent. We are freeing
>>>             page tables in
>>>             other situations, when a mapping uses huge pages in
>>>             amdgpu_vm_update_ptes. Why not when a mapping is
>>>             destroyed completely?
>>>
>>>             I'm actually a bit surprised that the huge-page handling in
>>>             amdgpu_vm_update_ptes isn't kicking in to free up
>>>             lower-level page
>>>             tables when a BO is unmapped.
>>>
>>>
>>>         Well it does free the lower level, and that is already
>>>         causing problems (that's why I added the reserved space).
>>>
>>>         What we don't do is freeing the higher levels.
>>>
>>>         E.g. when you free a 2MB BO we free the lowest level, if we
>>>         free a 1GB BO we free the two lowest levels etc...
>>>
>>>         The problem with freeing the higher levels is that you don't
>>>         know who is also using this. E.g. we would need to check all
>>>         entries when we unmap one.
>>>
>>>         It's simply not worth it for a maximum saving of 2MB per VM.
>>>
>>>         Writing this I'm actually wondering how you ended up in this
>>>         issue? There shouldn't be much savings from this.
>>>
>>>         Regards,
>>>         Christian.
>>>
>>>
>>>             Regards,
>>>                Felix
>>>
>>>
>>>             >
>>>             > Regards,
>>>             > Christian.
>>>             >
>>>             >>
>>>             >> Change-Id: Ic24e35bff8ca85265b418a642373f189d972a924
>>>             >> Signed-off-by: Eric Huang <JinhuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
>>>             <mailto:JinhuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
>>>             >> ---
>>>             >> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 56
>>>             >> +++++++++++++++++++++++++++++-----
>>>             >>   1 file changed, 48 insertions(+), 8 deletions(-)
>>>             >>
>>>             >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>             >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>             >> index 0f4c3b2..8a480c7 100644
>>>             >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>             >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>             >> @@ -1930,6 +1930,51 @@ static void
>>>             amdgpu_vm_prt_fini(struct
>>>             >> amdgpu_device *adev, struct amdgpu_vm *vm)
>>>             >>   }
>>>             >>     /**
>>>             >> + * amdgpu_vm_remove_ptes - free PT BOs
>>>             >> + *
>>>             >> + * @adev: amdgpu device structure
>>>             >> + * @vm: amdgpu vm structure
>>>             >> + * @start: start of mapped range
>>>             >> + * @end: end of mapped entry
>>>             >> + *
>>>             >> + * Free the page table level.
>>>             >> + */
>>>             >> +static int amdgpu_vm_remove_ptes(struct
>>>             amdgpu_device *adev,
>>>             >> +        struct amdgpu_vm *vm, uint64_t start,
>>>             uint64_t end)
>>>             >> +{
>>>             >> +    struct amdgpu_vm_pt_cursor cursor;
>>>             >> +    unsigned shift, num_entries;
>>>             >> +
>>>             >> + amdgpu_vm_pt_start(adev, vm, start, &cursor);
>>>             >> +    while (cursor.level < AMDGPU_VM_PTB) {
>>>             >> +        if (!amdgpu_vm_pt_descendant(adev, &cursor))
>>>             >> +            return -ENOENT;
>>>             >> +    }
>>>             >> +
>>>             >> +    while (cursor.pfn < end) {
>>>             >> + amdgpu_vm_free_table(cursor.entry);
>>>             >> +        num_entries = amdgpu_vm_num_entries(adev,
>>>             cursor.level - 1);
>>>             >> +
>>>             >> +        if (cursor.entry !=
>>>             &cursor.parent->entries[num_entries - 1]) {
>>>             >> +            /* Next ptb entry */
>>>             >> +            shift = amdgpu_vm_level_shift(adev,
>>>             cursor.level - 1);
>>>             >> + cursor.pfn += 1ULL << shift;
>>>             >> + cursor.pfn &= ~((1ULL << shift) - 1);
>>>             >> + cursor.entry++;
>>>             >> +        } else {
>>>             >> +            /* Next ptb entry in next pd0 entry */
>>>             >> + amdgpu_vm_pt_ancestor(&cursor);
>>>             >> +            shift = amdgpu_vm_level_shift(adev,
>>>             cursor.level - 1);
>>>             >> + cursor.pfn += 1ULL << shift;
>>>             >> + cursor.pfn &= ~((1ULL << shift) - 1);
>>>             >> + amdgpu_vm_pt_descendant(adev, &cursor);
>>>             >> +        }
>>>             >> +    }
>>>             >> +
>>>             >> +    return 0;
>>>             >> +}
>>>             >> +
>>>             >> +/**
>>>             >>    * amdgpu_vm_clear_freed - clear freed BOs in the PT
>>>             >>    *
>>>             >>    * @adev: amdgpu_device pointer
>>>             >> @@ -1949,7 +1994,6 @@ int
>>>             amdgpu_vm_clear_freed(struct amdgpu_device
>>>             >> *adev,
>>>             >> struct dma_fence **fence)
>>>             >>   {
>>>             >>       struct amdgpu_bo_va_mapping *mapping;
>>>             >> -    uint64_t init_pte_value = 0;
>>>             >>       struct dma_fence *f = NULL;
>>>             >>       int r;
>>>             >>   @@ -1958,13 +2002,10 @@ int
>>>             amdgpu_vm_clear_freed(struct
>>>             >> amdgpu_device *adev,
>>>             >>               struct amdgpu_bo_va_mapping, list);
>>>             >> list_del(&mapping->list);
>>>             >>   -        if (vm->pte_support_ats &&
>>>             >> - mapping->start < AMDGPU_GMC_HOLE_START)
>>>             >> - init_pte_value = AMDGPU_PTE_DEFAULT_ATC;
>>>             >> +        r = amdgpu_vm_remove_ptes(adev, vm,
>>>             >> + (mapping->start + 0x1ff) & (~0x1ffll),
>>>             >> + (mapping->last + 1) & (~0x1ffll));
>>>             >>   -        r = amdgpu_vm_bo_update_mapping(adev, vm,
>>>             false, NULL,
>>>             >> - mapping->start, mapping->last,
>>>             >> - init_pte_value, 0, NULL, &f);
>>>             >> amdgpu_vm_free_mapping(adev, vm, mapping, f);
>>>             >>           if (r) {
>>>             >> dma_fence_put(f);
>>>             >> @@ -1980,7 +2021,6 @@ int
>>>             amdgpu_vm_clear_freed(struct amdgpu_device
>>>             >> *adev,
>>>             >>       }
>>>             >>         return 0;
>>>             >> -
>>>             >>   }
>>>             >>     /**
>>>             >
>>>             > _______________________________________________
>>>             > amd-gfx mailing list
>>>             > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>             <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>>>             > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>
>>>
>>>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------C689F9797893CAC97CE41631
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">One thing I've forgotten:<br>
      <br>
      What you could maybe do to improve the situation is to join
      adjacent ranges in amdgpu_vm_clear_freed(), but I'm not sure how
      the chances are that the ranges are freed all together.<br>
      <br>
      The only other alternative I can see would be to check the
      mappings of a range in amdgpu_update_ptes() and see if you could
      walk the tree up if the valid flag is not set and there are no
      mappings left for a page table. <br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 30.10.19 um 18:42 schrieb Koenig, Christian:<br>
    </div>
    <blockquote type="cite"
      cite="mid:b5d9309e-a32b-8243-8c4d-cfd4e77e09e1-5C7GfCeVMHo@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <div class="moz-cite-prefix">
        <blockquote type="cite">The vaild flag doesn't take effect in
          this function.</blockquote>
        That's irrelevant.<br>
        <br>
        See what amdgpu_vm_update_ptes() does is to first determine the
        fragment size:<br>
        <blockquote type="cite">amdgpu_vm_fragment(params, frag_start,
          end, flags, &amp;frag, &amp;frag_end);<br>
        </blockquote>
        <br>
        Then we walk down the tree:<br>
        <blockquote type="cite">        amdgpu_vm_pt_start(adev,
          params-&gt;vm, start, &amp;cursor);<br>
                  while (cursor.pfn &lt; end) {<br>
        </blockquote>
        <br>
        And make sure that the page tables covering the address range
        are actually allocated:<br>
        <blockquote type="cite">                r =
          amdgpu_vm_alloc_pts(params-&gt;adev, params-&gt;vm,
          &amp;cursor);</blockquote>
        <br>
        Then we update the tables with the flags and addresses and free
        up subsequent tables in the case of huge pages or freed up
        areas:<br>
        <blockquote type="cite">                        /* Free all
          child entries */<br>
                                  while (cursor.pfn &lt; frag_start) {<br>
                                          amdgpu_vm_free_pts(adev,
          params-&gt;vm, &amp;cursor);<br>
                                          amdgpu_vm_pt_next(adev,
          &amp;cursor);<br>
                                  }<br>
        </blockquote>
        <br>
        This is the maximum you can free, cause all other page tables
        are not completely covered by the range and so potentially still
        in use.<br>
        <br>
        And I have the strong suspicion that this is what your patch is
        actually doing wrong. In other words you are also freeing page
        tables which are only partially covered by the range and so
        potentially still in use.<br>
        <br>
        Since we don't have any tracking how many entries in a page
        table are currently valid and how many are invalid we actually
        can't implement what you are trying to do here. So the patch is
        definitely somehow broken.<br>
        <br>
        Regards,<br>
        Christian.<br>
        <br>
        Am 30.10.19 um 17:55 schrieb Huang, JinHuiEric:<br>
      </div>
      <blockquote type="cite"
        cite="mid:b8ad3c90-42d0-512d-5ba0-af330eab30a1-5C7GfCeVMHo@public.gmane.org">
        <p>The vaild flag doesn't take effect in this function.
          amdgpu_vm_alloc_pts() is always executed that only depended on
          "cursor.pfn &lt; end". The valid flag has only been checked on
          here for asic below GMC v9:</p>
        <p>if (adev-&gt;asic_type &lt; CHIP_VEGA10 &amp;&amp;<br>
                      (flags &amp; AMDGPU_PTE_VALID))...</p>
        <p>Regards,</p>
        <p>Eric<br>
        </p>
        <div class="moz-cite-prefix">On 2019-10-30 12:30 p.m., Koenig,
          Christian wrote:<br>
        </div>
        <blockquote type="cite"
          cite="mid:3f4b6803-ec66-44ca-b55a-8bccf4236632-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org">
          <div dir="auto">
            <div><br>
              <div class="gmail_extra"><br>
                <div class="gmail_quote">Am 30.10.2019 17:19 schrieb
                  "Huang, JinHuiEric" <a class="moz-txt-link-rfc2396E"
                    href="mailto:JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">
                    &lt;JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org&gt;</a>:<br
                    type="attribution">
                  <blockquote class="quote" style="margin:0 0 0
                    .8ex;border-left:1px #ccc solid;padding-left:1ex">
                    <div>
                      <p>I tested it that it saves a lot of vram on KFD
                        big buffer stress test. I think there are two
                        reasons:</p>
                      <p>1. Calling <font size="2"><span
                            style="font-size:11pt">amdgpu_vm_update_ptes()
                            during unmapping will allocate unnecessary
                            pts, because there is no flag to determine
                            if the VA is mapping or unmapping in
                            function
                          </span></font><br>
                        <font size="2"><span style="font-size:11pt"><font
                              size="2"><span style="font-size:11pt">amdgpu_vm_update_ptes().
                                It saves the most of memory.</span></font></span></font></p>
                    </div>
                  </blockquote>
                </div>
              </div>
            </div>
            <div dir="auto">That's not correct. The valid flag is used
              for this.</div>
            <div dir="auto"><br>
            </div>
            <div dir="auto">
              <div class="gmail_extra">
                <div class="gmail_quote">
                  <blockquote class="quote" style="margin:0 0 0
                    .8ex;border-left:1px #ccc solid;padding-left:1ex">
                    <div>
                      <p><font size="2"><span style="font-size:11pt"><font
                              size="2"><span style="font-size:11pt">2.
                                Intentionally removing those unmapping
                                pts is logical expectation, although it
                                is not removing so much pts.<br>
                              </span></font></span></font></p>
                    </div>
                  </blockquote>
                </div>
              </div>
            </div>
            <div dir="auto">Well I actually don't see a change to what
              update_ptes is doing and have the strong suspicion that
              the patch is simply broken.</div>
            <div dir="auto"><br>
            </div>
            <div dir="auto">You either free page tables which are
              potentially still in use or update_pte doesn't free page
              tables when the valid but is not set.</div>
            <div dir="auto"><br>
            </div>
            <div dir="auto">Regards,</div>
            <div dir="auto">Christian.</div>
            <div dir="auto"><br>
            </div>
            <div dir="auto"><br>
            </div>
            <div dir="auto"><br>
            </div>
            <div dir="auto">
              <div class="gmail_extra">
                <div class="gmail_quote">
                  <blockquote class="quote" style="margin:0 0 0
                    .8ex;border-left:1px #ccc solid;padding-left:1ex">
                    <div>
                      <p><font size="2"><span style="font-size:11pt"><font
                              size="2"><span style="font-size:11pt"></span></font></span></font></p>
                      <p><font size="2"><span style="font-size:11pt"><font
                              size="2"><span style="font-size:11pt">Regards,</span></font></span></font></p>
                      <p><font size="2"><span style="font-size:11pt"><font
                              size="2"><span style="font-size:11pt">Eric<br>
                              </span></font></span></font></p>
                      <div>On 2019-10-30 11:57 a.m., Koenig, Christian
                        wrote:<br>
                      </div>
                      <blockquote>
                        <div dir="auto">
                          <div><br>
                            <div><br>
                              <div class="elided-text">Am 30.10.2019
                                16:47 schrieb "Kuehling, Felix" <a
                                  href="mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org"
                                  moz-do-not-send="true">
                                  &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;</a>:<br
                                  type="attribution">
                                <blockquote style="margin:0 0 0
                                  0.8ex;border-left:1px #ccc
                                  solid;padding-left:1ex">
                                  <div><font size="2"><span
                                        style="font-size:11pt">
                                        <div>On 2019-10-30 9:52 a.m.,
                                          Christian König wrote:<br>
                                          &gt; Am 29.10.19 um 21:06
                                          schrieb Huang, JinHuiEric:<br>
                                          &gt;&gt; The issue is PT BOs
                                          are not freed when unmapping
                                          VA,<br>
                                          &gt;&gt; which causes vram
                                          usage accumulated is huge in
                                          some<br>
                                          &gt;&gt; memory stress test,
                                          such as kfd big buffer stress
                                          test.<br>
                                          &gt;&gt; Function
                                          amdgpu_vm_bo_update_mapping()
                                          is called by both<br>
                                          &gt;&gt; amdgpu_vm_bo_update()
                                          and amdgpu_vm_clear_freed().
                                          The<br>
                                          &gt;&gt; solution is replacing
                                          amdgpu_vm_bo_update_mapping()
                                          in<br>
                                          &gt;&gt;
                                          amdgpu_vm_clear_freed() with
                                          removing PT BOs function<br>
                                          &gt;&gt; to save vram usage.<br>
                                          &gt;<br>
                                          &gt; NAK, that is intentional
                                          behavior.<br>
                                          &gt;<br>
                                          &gt; Otherwise we can run into
                                          out of memory situations when
                                          page tables <br>
                                          &gt; need to be allocated
                                          again under stress.<br>
                                          <br>
                                          That's a bit arbitrary and
                                          inconsistent. We are freeing
                                          page tables in <br>
                                          other situations, when a
                                          mapping uses huge pages in <br>
                                          amdgpu_vm_update_ptes. Why not
                                          when a mapping is destroyed
                                          completely?<br>
                                          <br>
                                          I'm actually a bit surprised
                                          that the huge-page handling in
                                          <br>
                                          amdgpu_vm_update_ptes isn't
                                          kicking in to free up
                                          lower-level page <br>
                                          tables when a BO is unmapped.<br>
                                        </div>
                                      </span></font></div>
                                </blockquote>
                              </div>
                            </div>
                          </div>
                          <div dir="auto"><br>
                          </div>
                          <div dir="auto">Well it does free the lower
                            level, and that is already causing problems
                            (that's why I added the reserved space).</div>
                          <div dir="auto"><br>
                          </div>
                          <div dir="auto">What we don't do is freeing
                            the higher levels.</div>
                          <div dir="auto"><br>
                          </div>
                          <div dir="auto">E.g. when you free a 2MB BO we
                            free the lowest level, if we free a 1GB BO
                            we free the two lowest levels etc...</div>
                          <div dir="auto"><br>
                          </div>
                          <div dir="auto">The problem with freeing the
                            higher levels is that you don't know who is
                            also using this. E.g. we would need to check
                            all entries when we unmap one.</div>
                          <div dir="auto"><br>
                          </div>
                          <div dir="auto">It's simply not worth it for a
                            maximum saving of 2MB per VM.</div>
                          <div dir="auto"><br>
                          </div>
                          <div dir="auto">Writing this I'm actually
                            wondering how you ended up in this issue?
                            There shouldn't be much savings from this.</div>
                          <div dir="auto"><br>
                          </div>
                          <div dir="auto">Regards,</div>
                          <div dir="auto">Christian.</div>
                          <div dir="auto"><br>
                          </div>
                          <div dir="auto">
                            <div>
                              <div class="elided-text">
                                <blockquote style="margin:0 0 0
                                  0.8ex;border-left:1px #ccc
                                  solid;padding-left:1ex">
                                  <div><font size="2"><span
                                        style="font-size:11pt">
                                        <div><br>
                                          Regards,<br>
                                             Felix<br>
                                          <br>
                                          <br>
                                          &gt;<br>
                                          &gt; Regards,<br>
                                          &gt; Christian.<br>
                                          &gt;<br>
                                          &gt;&gt;<br>
                                          &gt;&gt; Change-Id:
                                          Ic24e35bff8ca85265b418a642373f189d972a924<br>
                                          &gt;&gt; Signed-off-by: Eric
                                          Huang <a
                                            href="mailto:JinhuiEric.Huang-5C7GfCeVMHo@public.gmane.org"
                                            moz-do-not-send="true">
&lt;JinhuiEric.Huang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                                          &gt;&gt; ---<br>
                                          &gt;&gt;  
                                          drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
                                          | 56 <br>
                                          &gt;&gt;
                                          +++++++++++++++++++++++++++++-----<br>
                                          &gt;&gt;   1 file changed, 48
                                          insertions(+), 8 deletions(-)<br>
                                          &gt;&gt;<br>
                                          &gt;&gt; diff --git
                                          a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
                                          <br>
                                          &gt;&gt;
                                          b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                                          &gt;&gt; index
                                          0f4c3b2..8a480c7 100644<br>
                                          &gt;&gt; ---
                                          a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                                          &gt;&gt; +++
                                          b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                                          &gt;&gt; @@ -1930,6 +1930,51
                                          @@ static void
                                          amdgpu_vm_prt_fini(struct <br>
                                          &gt;&gt; amdgpu_device *adev,
                                          struct amdgpu_vm *vm)<br>
                                          &gt;&gt;   }<br>
                                          &gt;&gt;     /**<br>
                                          &gt;&gt; + *
                                          amdgpu_vm_remove_ptes - free
                                          PT BOs<br>
                                          &gt;&gt; + *<br>
                                          &gt;&gt; + * @adev: amdgpu
                                          device structure<br>
                                          &gt;&gt; + * @vm: amdgpu vm
                                          structure<br>
                                          &gt;&gt; + * @start: start of
                                          mapped range<br>
                                          &gt;&gt; + * @end: end of
                                          mapped entry<br>
                                          &gt;&gt; + *<br>
                                          &gt;&gt; + * Free the page
                                          table level.<br>
                                          &gt;&gt; + */<br>
                                          &gt;&gt; +static int
                                          amdgpu_vm_remove_ptes(struct
                                          amdgpu_device *adev,<br>
                                          &gt;&gt; +        struct
                                          amdgpu_vm *vm, uint64_t start,
                                          uint64_t end)<br>
                                          &gt;&gt; +{<!-- --><br>
                                          &gt;&gt; +    struct
                                          amdgpu_vm_pt_cursor cursor;<br>
                                          &gt;&gt; +    unsigned shift,
                                          num_entries;<br>
                                          &gt;&gt; +<br>
                                          &gt;&gt; +   
                                          amdgpu_vm_pt_start(adev, vm,
                                          start, &amp;cursor);<br>
                                          &gt;&gt; +    while
                                          (cursor.level &lt;
                                          AMDGPU_VM_PTB) {<!-- --><br>
                                          &gt;&gt; +        if
                                          (!amdgpu_vm_pt_descendant(adev,
                                          &amp;cursor))<br>
                                          &gt;&gt; +            return
                                          -ENOENT;<br>
                                          &gt;&gt; +    }<br>
                                          &gt;&gt; +<br>
                                          &gt;&gt; +    while
                                          (cursor.pfn &lt; end) {<!-- --><br>
                                          &gt;&gt; +       
                                          amdgpu_vm_free_table(cursor.entry);<br>
                                          &gt;&gt; +        num_entries
                                          = amdgpu_vm_num_entries(adev,
                                          cursor.level - 1);<br>
                                          &gt;&gt; +<br>
                                          &gt;&gt; +        if
                                          (cursor.entry !=
                                          &amp;cursor.parent-&gt;entries[num_entries
                                          - 1]) {<!-- --><br>
                                          &gt;&gt; +            /* Next
                                          ptb entry */<br>
                                          &gt;&gt; +            shift =
                                          amdgpu_vm_level_shift(adev,
                                          cursor.level - 1);<br>
                                          &gt;&gt; +           
                                          cursor.pfn += 1ULL &lt;&lt;
                                          shift;<br>
                                          &gt;&gt; +           
                                          cursor.pfn &amp;= ~((1ULL
                                          &lt;&lt; shift) - 1);<br>
                                          &gt;&gt; +           
                                          cursor.entry++;<br>
                                          &gt;&gt; +        } else {<!-- --><br>
                                          &gt;&gt; +            /* Next
                                          ptb entry in next pd0 entry */<br>
                                          &gt;&gt; +           
                                          amdgpu_vm_pt_ancestor(&amp;cursor);<br>
                                          &gt;&gt; +            shift =
                                          amdgpu_vm_level_shift(adev,
                                          cursor.level - 1);<br>
                                          &gt;&gt; +           
                                          cursor.pfn += 1ULL &lt;&lt;
                                          shift;<br>
                                          &gt;&gt; +           
                                          cursor.pfn &amp;= ~((1ULL
                                          &lt;&lt; shift) - 1);<br>
                                          &gt;&gt; +           
                                          amdgpu_vm_pt_descendant(adev,
                                          &amp;cursor);<br>
                                          &gt;&gt; +        }<br>
                                          &gt;&gt; +    }<br>
                                          &gt;&gt; +<br>
                                          &gt;&gt; +    return 0;<br>
                                          &gt;&gt; +}<br>
                                          &gt;&gt; +<br>
                                          &gt;&gt; +/**<br>
                                          &gt;&gt;    *
                                          amdgpu_vm_clear_freed - clear
                                          freed BOs in the PT<br>
                                          &gt;&gt;    *<br>
                                          &gt;&gt;    * @adev:
                                          amdgpu_device pointer<br>
                                          &gt;&gt; @@ -1949,7 +1994,6 @@
                                          int
                                          amdgpu_vm_clear_freed(struct
                                          amdgpu_device <br>
                                          &gt;&gt; *adev,<br>
                                          &gt;&gt;                
                                          struct dma_fence **fence)<br>
                                          &gt;&gt;   {<!-- --><br>
                                          &gt;&gt;       struct
                                          amdgpu_bo_va_mapping *mapping;<br>
                                          &gt;&gt; -    uint64_t
                                          init_pte_value = 0;<br>
                                          &gt;&gt;       struct
                                          dma_fence *f = NULL;<br>
                                          &gt;&gt;       int r;<br>
                                          &gt;&gt;   @@ -1958,13
                                          +2002,10 @@ int
                                          amdgpu_vm_clear_freed(struct <br>
                                          &gt;&gt; amdgpu_device *adev,<br>
                                          &gt;&gt;               struct
                                          amdgpu_bo_va_mapping, list);<br>
                                          &gt;&gt;          
                                          list_del(&amp;mapping-&gt;list);<br>
                                          &gt;&gt;   -        if
                                          (vm-&gt;pte_support_ats
                                          &amp;&amp;<br>
                                          &gt;&gt; -           
                                          mapping-&gt;start &lt;
                                          AMDGPU_GMC_HOLE_START)<br>
                                          &gt;&gt; -           
                                          init_pte_value =
                                          AMDGPU_PTE_DEFAULT_ATC;<br>
                                          &gt;&gt; +        r =
                                          amdgpu_vm_remove_ptes(adev,
                                          vm,<br>
                                          &gt;&gt; +               
                                          (mapping-&gt;start + 0x1ff)
                                          &amp; (~0x1ffll),<br>
                                          &gt;&gt; +               
                                          (mapping-&gt;last + 1) &amp;
                                          (~0x1ffll));<br>
                                          &gt;&gt;   -        r =
                                          amdgpu_vm_bo_update_mapping(adev,
                                          vm, false, NULL,<br>
                                          &gt;&gt;
                                          -                       
                                          mapping-&gt;start,
                                          mapping-&gt;last,<br>
                                          &gt;&gt;
                                          -                       
                                          init_pte_value, 0, NULL,
                                          &amp;f);<br>
                                          &gt;&gt;          
                                          amdgpu_vm_free_mapping(adev,
                                          vm, mapping, f);<br>
                                          &gt;&gt;           if (r) {<!-- --><br>
                                          &gt;&gt;              
                                          dma_fence_put(f);<br>
                                          &gt;&gt; @@ -1980,7 +2021,6 @@
                                          int
                                          amdgpu_vm_clear_freed(struct
                                          amdgpu_device <br>
                                          &gt;&gt; *adev,<br>
                                          &gt;&gt;       }<br>
                                          &gt;&gt;         return 0;<br>
                                          &gt;&gt; -<br>
                                          &gt;&gt;   }<br>
                                          &gt;&gt;     /**<br>
                                          &gt;<br>
                                          &gt;
                                          _______________________________________________<br>
                                          &gt; amd-gfx mailing list<br>
                                          &gt; <a
                                            href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                                            moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                                          &gt; <a
                                            href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                                            moz-do-not-send="true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
                                        </div>
                                      </span></font></div>
                                </blockquote>
                              </div>
                              <br>
                            </div>
                          </div>
                        </div>
                      </blockquote>
                    </div>
                  </blockquote>
                </div>
                <br>
              </div>
            </div>
          </div>
        </blockquote>
      </blockquote>
      <br>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
    </blockquote>
    <br>
  </body>
</html>

--------------C689F9797893CAC97CE41631--

--===============1058738385==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1058738385==--
