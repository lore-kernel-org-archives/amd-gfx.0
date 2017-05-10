From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: Support for amdgpu VM update via CPU on large-bar systems
Date: Wed, 10 May 2017 09:23:59 +0200
Message-ID: <1b144623-3315-5dd7-fcc7-3be9e24e0f21@vodafone.de>
References: <DM3PR1201MB103847C11F89904752F962768CEF0@DM3PR1201MB1038.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1134345577=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM3PR1201MB103847C11F89904752F962768CEF0-BBcFnVpqZhWjUUTFdQAMQmrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1134345577==
Content-Type: multipart/alternative;
 boundary="------------5F6E6278A14B1663D8AFC52E"

This is a multi-part message in MIME format.
--------------5F6E6278A14B1663D8AFC52E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Harish,

for the next time please use git send-email to send patches to the 
mailing list.

Looks pretty good in general, but a few notes all over the place.

Patch #1:
> +static bool amdgpu_vm_is_large_bar(struct amdgpu_device *adev)
> +{
> +    if (adev->mc.visible_vram_size > 0 &&
> +            adev->mc.real_vram_size == adev->mc.visible_vram_size)
> +        return true;
> +    return false;
> +}
The visible_vram_size > 0 check looks superfluous. The coding style 
looks off, the second line of the "if" is to far right.

And in general that should rather look like "return 
adev->mc.real_vram_size == adev->mc.visible_vram_size;".

> +    /* CPU update is only supported for large BAR system */
> +    vm->is_vm_update_mode_cpu = (vm_update_mode &&
> +                     amdgpu_vm_is_large_bar(adev));
Mhm, it would be nice if we could enable this for testing even on 
systems with small BAR.

I would rather suggest to make the default value depend on if the BOX 
has a large or small BAR and let the user override the setting.

Additional to that we should limit this to 64bit systems.

> +#define AMDGPU_VM_USE_CPU_UPDATE_FOR_GRAPHICS_MASK (1 << 0)
> +#define AMDGPU_VM_USE_CPU_UPDATE_FOR_COMPUTE_MASK (1 << 1)
Not much of an issue, but the names are a bit long. Maybe use something 
like AMDGPU_VM_USE_CPU_FOR_GFX and AMDGPU_VM_USE_CPU_FOR_COMPUTE.

> +    bool is_vm_update_mode_cpu : 1;
Please no bitmasks when we don't need them.

Patch #2:
> +    u64 flags;
>      unsigned shift = (adev->vm_manager.num_level - level) *
>          adev->vm_manager.block_size;
Reverse tree order.

> +    flags = (vm->is_vm_update_mode_cpu) ?
> +            AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED :
> +            AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
> +            AMDGPU_GEM_CREATE_SHADOW;
> +
> +
...
> - AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
> -                         AMDGPU_GEM_CREATE_SHADOW |
> +                         flags |
>                           AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
>                           AMDGPU_GEM_CREATE_VRAM_CLEARED,

I would rather write it like this:

flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS | AMDGPU_GEM_CREATE_VRAM_CLEARED;
if (vm->is_vm_update_mode_cpu)
     flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
else
     flags |= AMDGPU_GEM_CREATE_NO_CPU_ACCESS | AMDGPU_GEM_CREATE_SHADOW;

> +    mb();
> +    amdgpu_gart_flush_gpu_tlb(params->adev, 0);
You do this for the HDP flush, don't you?

> +            dev_warn(adev->dev, "Page table update using CPU failed. 
> Fallback to SDMA\n");
NACK, if kmapping the BO fails we most likely are either out of memory 
or out of address space.

Falling back to the SDMA doesn't make the situation better, just return 
a proper error code here.

> +            /* Wait for BO to be free. SDMA could be clearing it */
> +            amdgpu_sync_create(&sync);
> +            amdgpu_sync_resv(adev, &sync, parent->bo->tbo.resv,
> +                     AMDGPU_FENCE_OWNER_VM);
> +            amdgpu_sync_wait(&sync);
> +            amdgpu_sync_free(&sync);
Superfluous and a bit incorrect, amdgpu_bo_kmap already calls 
reservation_object_wait_timeout_rcu() but only for the exclusive fence.

You probably ran into problems because of pipelined evictions, so that 
should be fixed in amdgpu_bo_kmap() instead.

> -  amdgpu_vm_do_set_ptes(&params,
> -                                  last_shadow,
> -                                  pt_addr, count,
> -                                  incr,
> -                                  AMDGPU_PTE_VALID);
> -
> -                amdgpu_vm_do_set_ptes(&params, last_pde,
> -                              pt_addr, count, incr,
> -                              AMDGPU_PTE_VALID);
> +                    params.func(&params,
> +                            last_shadow,
> +                            pt_addr, count,
> +                            incr,
> +                            AMDGPU_PTE_VALID);
> +
> +                params.func(&params, last_pde,
> +                        pt_addr, count, incr,
> +                        AMDGPU_PTE_VALID);
Might be a good idea to separate that into a cleanup patch.

Patch #3: Looks good to me and is Reviewed-by: Christian König 
<christian.koenig-5C7GfCeVMHo@public.gmane.org>.

Please move that one to the beginning of the series and/or commit it 
directly to amd-staging-4.9.

Patch #4:
> +    /* The next three are used during VM update by CPU */
> +    bool update_by_cpu;
We can distinguish that as well by looking at the function pointer, 
don't we?

> +        dev_warn(adev->dev,
> +             "CPU update of VM failed. Fallback to SDMA\n");
> +
> +        /* Reset params for SDMA fallback path */
> +        params.update_by_cpu = false;
> +        params.pages_addr = NULL;
> +        params.kptr = NULL;
> +        params.func = NULL;
Again completely drop the SDMA fallback path.

Regards,
Christian.

Am 09.05.2017 um 20:34 schrieb Kasiviswanathan, Harish:
> Hi,
>
> Please review the patch set that supports amdgpu VM update via CPU. This feature provides improved performance for compute (HSA) where mapping / unmapping is carried out (by Kernel) independent of command submissions (done directly by user space). This version doesn't support shadow copy of VM page tables for CPU based update.
>
> Best Regards,
> Harish
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------5F6E6278A14B1663D8AFC52E
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Harish,<br>
      <br>
      for the next time please use git send-email to send patches to the
      mailing list.<br>
      <br>
      Looks pretty good in general, but a few notes all over the place.<br>
      <br>
      Patch #1:<br>
      <blockquote type="cite">+static bool amdgpu_vm_is_large_bar(struct
        amdgpu_device *adev)<br>
        +{<br>
        +    if (adev-&gt;mc.visible_vram_size &gt; 0 &amp;&amp;<br>
        +            adev-&gt;mc.real_vram_size ==
        adev-&gt;mc.visible_vram_size)<br>
        +        return true;<br>
        +    return false;<br>
        +}<br>
      </blockquote>
      The visible_vram_size &gt; 0 check looks superfluous. The coding
      style looks off, the second line of the "if" is to far right.<br>
      <br>
      And in general that should rather look like "return
      adev-&gt;mc.real_vram_size == adev-&gt;mc.visible_vram_size;".<br>
      <br>
      <blockquote type="cite">+    /* CPU update is only supported for
        large BAR system */<br>
        +    vm-&gt;is_vm_update_mode_cpu = (vm_update_mode &amp;&amp;<br>
        +                     amdgpu_vm_is_large_bar(adev));</blockquote>
      Mhm, it would be nice if we could enable this for testing even on
      systems with small BAR.<br>
      <br>
      I would rather suggest to make the default value depend on if the
      BOX has a large or small BAR and let the user override the
      setting.<br>
      <br>
      Additional to that we should limit this to 64bit systems.<br>
      <br>
      <blockquote type="cite">+#define
        AMDGPU_VM_USE_CPU_UPDATE_FOR_GRAPHICS_MASK (1 &lt;&lt; 0)<br>
        +#define AMDGPU_VM_USE_CPU_UPDATE_FOR_COMPUTE_MASK (1 &lt;&lt;
        1)</blockquote>
      Not much of an issue, but the names are a bit long. Maybe use
      something like AMDGPU_VM_USE_CPU_FOR_GFX and
      AMDGPU_VM_USE_CPU_FOR_COMPUTE.<br>
      <br>
      <blockquote type="cite">+    bool                   
        is_vm_update_mode_cpu : 1;</blockquote>
      Please no bitmasks when we don't need them.<br>
      <br>
      Patch #2:<br>
      <blockquote type="cite">+    u64 flags;<br>
             unsigned shift = (adev-&gt;vm_manager.num_level - level) *<br>
                 adev-&gt;vm_manager.block_size;<br>
      </blockquote>
      Reverse tree order.<br>
      <br>
      <blockquote type="cite">+    flags =
        (vm-&gt;is_vm_update_mode_cpu) ?<br>
        +            AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED :<br>
        +            AMDGPU_GEM_CREATE_NO_CPU_ACCESS |<br>
        +            AMDGPU_GEM_CREATE_SHADOW;<br>
        +<br>
        +<br>
      </blockquote>
      ...<br>
      <blockquote type="cite">-                        
        AMDGPU_GEM_CREATE_NO_CPU_ACCESS |<br>
        -                         AMDGPU_GEM_CREATE_SHADOW |<br>
        +                         flags |<br>
                                  AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |<br>
                                  AMDGPU_GEM_CREATE_VRAM_CLEARED,</blockquote>
      <br>
      I would rather write it like this:<br>
      <br>
      flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
      AMDGPU_GEM_CREATE_VRAM_CLEARED;<br>
      if (vm-&gt;is_vm_update_mode_cpu)<br>
          flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;<br>
      else<br>
          flags |= AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
      AMDGPU_GEM_CREATE_SHADOW;<br>
      <br>
      <blockquote type="cite">+    mb();<br>
        +    amdgpu_gart_flush_gpu_tlb(params-&gt;adev, 0);<br>
      </blockquote>
      You do this for the HDP flush, don't you?<br>
      <br>
      <blockquote type="cite">+            dev_warn(adev-&gt;dev, "Page
        table update using CPU failed. Fallback to SDMA\n");<br>
      </blockquote>
      NACK, if kmapping the BO fails we most likely are either out of
      memory or out of address space.<br>
      <br>
      Falling back to the SDMA doesn't make the situation better, just
      return a proper error code here.<br>
      <br>
      <blockquote type="cite">+            /* Wait for BO to be free.
        SDMA could be clearing it */<br>
        +            amdgpu_sync_create(&amp;sync);<br>
        +            amdgpu_sync_resv(adev, &amp;sync,
        parent-&gt;bo-&gt;tbo.resv,<br>
        +                     AMDGPU_FENCE_OWNER_VM);<br>
        +            amdgpu_sync_wait(&amp;sync);<br>
        +            amdgpu_sync_free(&amp;sync);</blockquote>
      Superfluous and a bit incorrect, amdgpu_bo_kmap already calls
      reservation_object_wait_timeout_rcu() but only for the exclusive
      fence.<br>
      <br>
      You probably ran into problems because of pipelined evictions, so
      that should be fixed in amdgpu_bo_kmap() instead.<br>
      <br>
      <blockquote type="cite">-                  
         amdgpu_vm_do_set_ptes(&amp;params,<br>
        -                                  last_shadow,<br>
        -                                  pt_addr, count,<br>
        -                                  incr,<br>
        -                                  AMDGPU_PTE_VALID);<br>
        -<br>
        -                amdgpu_vm_do_set_ptes(&amp;params, last_pde,<br>
        -                              pt_addr, count, incr,<br>
        -                              AMDGPU_PTE_VALID);<br>
        +                    params.func(&amp;params,<br>
        +                            last_shadow,<br>
        +                            pt_addr, count,<br>
        +                            incr,<br>
        +                            AMDGPU_PTE_VALID);<br>
        +<br>
        +                params.func(&amp;params, last_pde,<br>
        +                        pt_addr, count, incr,<br>
        +                        AMDGPU_PTE_VALID);</blockquote>
      Might be a good idea to separate that into a cleanup patch.<br>
      <br>
      Patch #3: Looks good to me and is Reviewed-by: Christian König
      <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>.<br>
      <br>
      Please move that one to the beginning of the series and/or commit
      it directly to amd-staging-4.9.<br>
      <br>
      Patch #4:<br>
      <blockquote type="cite">+    /* The next three are used during VM
        update by CPU */<br>
        +    bool update_by_cpu;</blockquote>
      We can distinguish that as well by looking at the function
      pointer, don't we?<br>
      <br>
      <blockquote type="cite">+        dev_warn(adev-&gt;dev,<br>
        +             "CPU update of VM failed. Fallback to SDMA\n");<br>
        +<br>
        +        /* Reset params for SDMA fallback path */<br>
        +        params.update_by_cpu = false;<br>
        +        params.pages_addr = NULL;<br>
        +        params.kptr = NULL;<br>
        +        params.func = NULL;</blockquote>
      Again completely drop the SDMA fallback path.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 09.05.2017 um 20:34 schrieb Kasiviswanathan, Harish:<br>
    </div>
    <blockquote
cite="mid:DM3PR1201MB103847C11F89904752F962768CEF0-BBcFnVpqZhWjUUTFdQAMQmrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org"
      type="cite">
      <pre wrap="">Hi,

Please review the patch set that supports amdgpu VM update via CPU. This feature provides improved performance for compute (HSA) where mapping / unmapping is carried out (by Kernel) independent of command submissions (done directly by user space). This version doesn't support shadow copy of VM page tables for CPU based update.

Best Regards,
Harish

</pre>
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

--------------5F6E6278A14B1663D8AFC52E--

--===============1134345577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1134345577==--
