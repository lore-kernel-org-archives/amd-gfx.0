From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 7/7] drm/amdgpu: enable huge page handling in the VM
Date: Wed, 24 May 2017 17:28:59 +0800
Message-ID: <5925525B.4060409@amd.com>
References: <1495012972-20698-1-git-send-email-deathsimple@vodafone.de>
 <1495012972-20698-7-git-send-email-deathsimple@vodafone.de>
 <591D3164.7070105@amd.com> <5efe2316-b0bb-799b-345e-120c040237ae@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1828422463=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5efe2316-b0bb-799b-345e-120c040237ae-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1828422463==
Content-Type: multipart/alternative;
	boundary="------------090308030909040508020109"

--------------090308030909040508020109
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit



On 2017年05月24日 17:15, Christian König wrote:
> Am 18.05.2017 um 07:30 schrieb zhoucm1:
>>
>>
>> On 2017年05月17日 17:22, Christian König wrote:
>>> [SNIP]
>>> +    /* In the case of a mixed PT the PDE must point to it*/
>>> +    if (p->adev->asic_type < CHIP_VEGA10 ||
>>> +        nptes != AMDGPU_VM_PTE_COUNT(p->adev) ||
>>> +        p->func != amdgpu_vm_do_set_ptes ||
>>> +        !(flags & AMDGPU_PTE_VALID)) {
>>> +
>>> +        pt = (*bo)->tbo.mem.start << PAGE_SHIFT;
>>> +        pt = amdgpu_gart_get_vm_pde(p->adev, pt);
>>> +        flags = AMDGPU_PTE_VALID;
>> This case should be handled when updating levels, so return directly?
>
> The problem is that when we switch from huge page back to a normal 
> mapping because the BO was evicted we also need to reset the PDE.
>
>>> +    } else {
>>> +        pt = amdgpu_gart_get_vm_pde(p->adev, dst);
>>> +        flags |= AMDGPU_PDE_PTE;
>>> +    }
>>>   -    return entry->bo;
>>> +    if (entry->addr == pt &&
>>> +        entry->huge_page == !!(flags & AMDGPU_PDE_PTE))
>>> +        return 0;
>>> +
>>> +    entry->addr = pt;
>>> +    entry->huge_page = !!(flags & AMDGPU_PDE_PTE);
>>> +
>>> +    if (parent->bo->shadow) {
>>> +        pd_addr = amdgpu_bo_gpu_offset(parent->bo->shadow);
>>> +        pde = pd_addr + pt_idx * 8;
>>> +        amdgpu_vm_do_set_ptes(p, pde, pt, 1, 0, flags);
>> From the spec "any pde in the chain can itself take on the format of 
>> a PTE and point directly to an aligned block of logical address space 
>> by setting the P bit.",
>> So here should pass addr into PDE instead of pt.
>
> The pt variable was overwritten with the address a few lines above. 
> The code was indeed hard to understand, so I've fixed it.
this isn't my mean, if I understand spec correctly, it should be 
amdgpu_vm_do_set_ptes(p, pde, addr, 1, 0, flags);

>
>>> +    }
>>> +
>>> +    pd_addr = amdgpu_bo_gpu_offset(parent->bo);
>>> +    pde = pd_addr + pt_idx * 8;
>>> +    amdgpu_vm_do_set_ptes(p, pde, pt, 1, 0, flags);
>> Should pass addr into PDE instead of pt as well.
>>
>>
>>> +    return 0;
>>>   }
>>>     /**
>>> @@ -1194,14 +1237,20 @@ static int amdgpu_vm_update_ptes(struct 
>>> amdgpu_pte_update_params *params,
>>>       uint64_t addr, pe_start;
>>>       struct amdgpu_bo *pt;
>>>       unsigned nptes;
>>> +    int r;
>>>         /* walk over the address space and update the page tables */
>>>       for (addr = start; addr < end; addr += nptes) {
>>> -        pt = amdgpu_vm_get_pt(params, addr);
>>> -        if (!pt) {
>>> -            pr_err("PT not found, aborting update_ptes\n");
>>> -            return -EINVAL;
>>> -        }
>>> +
>>> +        if ((addr & ~mask) == (end & ~mask))
>>> +            nptes = end - addr;
>>> +        else
>>> +            nptes = AMDGPU_VM_PTE_COUNT(adev) - (addr & mask);
>>> +
>>> +        r = amdgpu_vm_handle_huge_pages(params, addr, nptes,
>>> +                        dst, flags, &pt);
>> If huge page happens, its sub PTEs don't need to update more, they 
>> cannot be indexed by page table when that PDE is PTE, right?
>
> Right, but I wasn't sure if we don't need them for something. So I've 
> kept the update for now.
>
> Going to try dropping this today.
>
>> Btw: Is this BigK which people often said?
>
> Yes and no. I can explain more internally if you like.
Welcome.

Regards,
David Zhou
>
> Regards,
> Christian.
>
>>
>> Regards,
>> David Zhou
>>> +        if (r)
>>> +            return r;
>>>             if (params->shadow) {
>>>               if (!pt->shadow)
>>> @@ -1209,11 +1258,6 @@ static int amdgpu_vm_update_ptes(struct 
>>> amdgpu_pte_update_params *params,
>>>               pt = pt->shadow;
>>>           }
>>>   -        if ((addr & ~mask) == (end & ~mask))
>>> -            nptes = end - addr;
>>> -        else
>>> -            nptes = AMDGPU_VM_PTE_COUNT(adev) - (addr & mask);
>>> -
>>>           pe_start = amdgpu_bo_gpu_offset(pt);
>>>           pe_start += (addr & mask) * 8;
>>>   @@ -1353,6 +1397,9 @@ static int 
>>> amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>>>       /* padding, etc. */
>>>       ndw = 64;
>>>   +    /* one PDE write for each huge page */
>>> +    ndw += ((nptes >> adev->vm_manager.block_size) + 1) * 7;
>>> +
>>>       if (src) {
>>>           /* only copy commands needed */
>>>           ndw += ncmds * 7;
>>> @@ -1437,6 +1484,7 @@ static int amdgpu_vm_bo_update_mapping(struct 
>>> amdgpu_device *adev,
>>>     error_free:
>>>       amdgpu_job_free(job);
>>> +    amdgpu_vm_invalidate_level(&vm->root);
>>>       return r;
>>>   }
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index afe9073..1c5e0ce 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -68,6 +68,9 @@ struct amdgpu_bo_list_entry;
>>>   /* TILED for VEGA10, reserved for older ASICs  */
>>>   #define AMDGPU_PTE_PRT        (1ULL << 51)
>>>   +/* PDE is handled as PTE for VEGA10 */
>>> +#define AMDGPU_PDE_PTE        (1ULL << 54)
>>> +
>>>   /* VEGA10 only */
>>>   #define AMDGPU_PTE_MTYPE(a)    ((uint64_t)a << 57)
>>>   #define AMDGPU_PTE_MTYPE_MASK    AMDGPU_PTE_MTYPE(3ULL)
>>> @@ -90,6 +93,7 @@ struct amdgpu_bo_list_entry;
>>>   struct amdgpu_vm_pt {
>>>       struct amdgpu_bo    *bo;
>>>       uint64_t        addr;
>>> +    bool            huge_page;
>>>         /* array of page tables, one for each directory entry */
>>>       struct amdgpu_vm_pt    *entries;
>>
>


--------------090308030909040508020109
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2017年05月24日 17:15, Christian König
      wrote:<br>
    </div>
    <blockquote
      cite="mid:5efe2316-b0bb-799b-345e-120c040237ae-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
      type="cite">Am 18.05.2017 um 07:30 schrieb zhoucm1:
      <br>
      <blockquote type="cite">
        <br>
        <br>
        On 2017年05月17日 17:22, Christian König wrote:
        <br>
        <blockquote type="cite">[SNIP]
          <br>
          +    /* In the case of a mixed PT the PDE must point to it*/
          <br>
          +    if (p-&gt;adev-&gt;asic_type &lt; CHIP_VEGA10 ||
          <br>
          +        nptes != AMDGPU_VM_PTE_COUNT(p-&gt;adev) ||
          <br>
          +        p-&gt;func != amdgpu_vm_do_set_ptes ||
          <br>
          +        !(flags &amp; AMDGPU_PTE_VALID)) {
          <br>
          +
          <br>
          +        pt = (*bo)-&gt;tbo.mem.start &lt;&lt; PAGE_SHIFT;
          <br>
          +        pt = amdgpu_gart_get_vm_pde(p-&gt;adev, pt);
          <br>
          +        flags = AMDGPU_PTE_VALID;
          <br>
        </blockquote>
        This case should be handled when updating levels, so return
        directly?
        <br>
      </blockquote>
      <br>
      The problem is that when we switch from huge page back to a normal
      mapping because the BO was evicted we also need to reset the PDE.
      <br>
      <br>
      <blockquote type="cite">
        <blockquote type="cite">+    } else {
          <br>
          +        pt = amdgpu_gart_get_vm_pde(p-&gt;adev, dst);
          <br>
          +        flags |= AMDGPU_PDE_PTE;
          <br>
          +    }
          <br>
            -    return entry-&gt;bo;
          <br>
          +    if (entry-&gt;addr == pt &amp;&amp;
          <br>
          +        entry-&gt;huge_page == !!(flags &amp;
          AMDGPU_PDE_PTE))
          <br>
          +        return 0;
          <br>
          +
          <br>
          +    entry-&gt;addr = pt;
          <br>
          +    entry-&gt;huge_page = !!(flags &amp; AMDGPU_PDE_PTE);
          <br>
          +
          <br>
          +    if (parent-&gt;bo-&gt;shadow) {
          <br>
          +        pd_addr =
          amdgpu_bo_gpu_offset(parent-&gt;bo-&gt;shadow);
          <br>
          +        pde = pd_addr + pt_idx * 8;
          <br>
          +        amdgpu_vm_do_set_ptes(p, pde, pt, 1, 0, flags);
          <br>
        </blockquote>
        From the spec "any pde in the chain can itself take on the
        format of a PTE and point directly to <font color="#ff0000">an
          aligned block of logical address space</font> by setting the P
        bit.",
        <br>
        So here should pass addr into PDE instead of pt.
        <br>
      </blockquote>
      <br>
      The pt variable was overwritten with the address a few lines
      above. The code was indeed hard to understand, so I've fixed it.
      <br>
    </blockquote>
    this isn't my mean, if I understand spec correctly, it should be
    amdgpu_vm_do_set_ptes(p, pde, <font color="#ff0000">addr</font>, 1,
    0, flags);<br>
    <br>
    <blockquote
      cite="mid:5efe2316-b0bb-799b-345e-120c040237ae-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
      type="cite">
      <br>
      <blockquote type="cite">
        <blockquote type="cite">+    }
          <br>
          +
          <br>
          +    pd_addr = amdgpu_bo_gpu_offset(parent-&gt;bo);
          <br>
          +    pde = pd_addr + pt_idx * 8;
          <br>
          +    amdgpu_vm_do_set_ptes(p, pde, pt, 1, 0, flags);
          <br>
        </blockquote>
        Should pass addr into PDE instead of pt as well.
        <br>
        <br>
        <br>
        <blockquote type="cite">+    return 0;
          <br>
            }
          <br>
              /**
          <br>
          @@ -1194,14 +1237,20 @@ static int
          amdgpu_vm_update_ptes(struct amdgpu_pte_update_params *params,
          <br>
                uint64_t addr, pe_start;
          <br>
                struct amdgpu_bo *pt;
          <br>
                unsigned nptes;
          <br>
          +    int r;
          <br>
                  /* walk over the address space and update the page
          tables */
          <br>
                for (addr = start; addr &lt; end; addr += nptes) {
          <br>
          -        pt = amdgpu_vm_get_pt(params, addr);
          <br>
          -        if (!pt) {
          <br>
          -            pr_err("PT not found, aborting update_ptes\n");
          <br>
          -            return -EINVAL;
          <br>
          -        }
          <br>
          +
          <br>
          +        if ((addr &amp; ~mask) == (end &amp; ~mask))
          <br>
          +            nptes = end - addr;
          <br>
          +        else
          <br>
          +            nptes = AMDGPU_VM_PTE_COUNT(adev) - (addr &amp;
          mask);
          <br>
          +
          <br>
          +        r = amdgpu_vm_handle_huge_pages(params, addr, nptes,
          <br>
          +                        dst, flags, &amp;pt);
          <br>
        </blockquote>
        If huge page happens, its sub PTEs don't need to update more,
        they cannot be indexed by page table when that PDE is PTE,
        right?
        <br>
      </blockquote>
      <br>
      Right, but I wasn't sure if we don't need them for something. So
      I've kept the update for now.
      <br>
      <br>
      Going to try dropping this today.
      <br>
      <br>
      <blockquote type="cite">Btw: Is this BigK which people often said?
        <br>
      </blockquote>
      <br>
      Yes and no. I can explain more internally if you like.
      <br>
    </blockquote>
    Welcome.<br>
    <br>
    Regards,<br>
    David Zhou<br>
    <blockquote
      cite="mid:5efe2316-b0bb-799b-345e-120c040237ae-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
      type="cite">
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Regards,
        <br>
        David Zhou
        <br>
        <blockquote type="cite">+        if (r)
          <br>
          +            return r;
          <br>
                      if (params-&gt;shadow) {
          <br>
                        if (!pt-&gt;shadow)
          <br>
          @@ -1209,11 +1258,6 @@ static int amdgpu_vm_update_ptes(struct
          amdgpu_pte_update_params *params,
          <br>
                        pt = pt-&gt;shadow;
          <br>
                    }
          <br>
            -        if ((addr &amp; ~mask) == (end &amp; ~mask))
          <br>
          -            nptes = end - addr;
          <br>
          -        else
          <br>
          -            nptes = AMDGPU_VM_PTE_COUNT(adev) - (addr &amp;
          mask);
          <br>
          -
          <br>
                    pe_start = amdgpu_bo_gpu_offset(pt);
          <br>
                    pe_start += (addr &amp; mask) * 8;
          <br>
            @@ -1353,6 +1397,9 @@ static int
          amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
          <br>
                /* padding, etc. */
          <br>
                ndw = 64;
          <br>
            +    /* one PDE write for each huge page */
          <br>
          +    ndw += ((nptes &gt;&gt; adev-&gt;vm_manager.block_size) +
          1) * 7;
          <br>
          +
          <br>
                if (src) {
          <br>
                    /* only copy commands needed */
          <br>
                    ndw += ncmds * 7;
          <br>
          @@ -1437,6 +1484,7 @@ static int
          amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
          <br>
              error_free:
          <br>
                amdgpu_job_free(job);
          <br>
          +    amdgpu_vm_invalidate_level(&amp;vm-&gt;root);
          <br>
                return r;
          <br>
            }
          <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
          <br>
          index afe9073..1c5e0ce 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
          <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
          <br>
          @@ -68,6 +68,9 @@ struct amdgpu_bo_list_entry;
          <br>
            /* TILED for VEGA10, reserved for older ASICs  */
          <br>
            #define AMDGPU_PTE_PRT        (1ULL &lt;&lt; 51)
          <br>
            +/* PDE is handled as PTE for VEGA10 */
          <br>
          +#define AMDGPU_PDE_PTE        (1ULL &lt;&lt; 54)
          <br>
          +
          <br>
            /* VEGA10 only */
          <br>
            #define AMDGPU_PTE_MTYPE(a)    ((uint64_t)a &lt;&lt; 57)
          <br>
            #define AMDGPU_PTE_MTYPE_MASK    AMDGPU_PTE_MTYPE(3ULL)
          <br>
          @@ -90,6 +93,7 @@ struct amdgpu_bo_list_entry;
          <br>
            struct amdgpu_vm_pt {
          <br>
                struct amdgpu_bo    *bo;
          <br>
                uint64_t        addr;
          <br>
          +    bool            huge_page;
          <br>
                  /* array of page tables, one for each directory entry
          */
          <br>
                struct amdgpu_vm_pt    *entries;
          <br>
        </blockquote>
        <br>
      </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------090308030909040508020109--

--===============1828422463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1828422463==--
