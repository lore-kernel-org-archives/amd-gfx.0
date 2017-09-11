From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix VM sync with always valid BOs v2
Date: Mon, 11 Sep 2017 14:00:05 +0200
Message-ID: <0566390d-8378-f214-ef64-30b1784f454a@vodafone.de>
References: <1505116409-9815-1-git-send-email-deathsimple@vodafone.de>
 <5430f286-3089-1be2-98d3-a0a89eb67aee@amd.com>
 <ba49e14c-8f05-1f1f-1798-2705237b87b0@vodafone.de>
 <7f5bb679-7385-135e-dc10-d40ba391f082@amd.com>
 <98b9088c-c2e1-8f4e-552b-d6db06ca0047@vodafone.de>
 <MWHPR1201MB0127808E4B24F827F3B82019FD680@MWHPR1201MB0127.namprd12.prod.outlook.com>
 <MWHPR1201MB0206240AA6FA420B2EDA5677B4680@MWHPR1201MB0206.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0662128086=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR1201MB0206240AA6FA420B2EDA5677B4680-3iK1xFAIwjrUF/YbdlDdgWrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "He, Roger" <Hongbo.He-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0662128086==
Content-Type: multipart/alternative;
 boundary="------------252D22FB0DEB007F25357A61"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------252D22FB0DEB007F25357A61
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Ok then we have a misunderstanding here. This applies to all per VM BOs, 
not just kernel BOs.

It's just that as long as the per VM BOs aren't used the handling is 
still correct and we don't have any updates to UMD BOs we implicitly 
wait on.

Sorry I should have waited a bit more, but since it is a very rather 
urgent bug fix I've already pushed it with Rogers rb.

Regards,
Christian.

Am 11.09.2017 um 13:42 schrieb Zhou, David(ChunMing):
> My mean is you should add a condition in code to check if BO is kernel BO or not. I expect V3.
>
> Regards,
> David
>
> 发自坚果 Pro
>
> He, Roger <Hongbo.He-5C7GfCeVMHo@public.gmane.org> 于 2017年9月11日 下午6:57写道：
>
> Reviewed-by: Roger He <Hongbo.He-5C7GfCeVMHo@public.gmane.org>
>
> Thanks
> Roger(Hongbo.He)
> -----Original Message-----
> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf 
> Of Christian K?nig
> Sent: Monday, September 11, 2017 6:53 PM
> To: Zhou, David(ChunMing) <David1.Zhou-5C7GfCeVMHo@public.gmane.org>; 
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Subject: Re: [PATCH] drm/amdgpu: fix VM sync with always valid BOs v2
>
> Am 11.09.2017 um 11:10 schrieb zhoucm1:
> >
> >
> > On 2017年09月11日 17:04, Christian König wrote:
> >>> NAK, as Roger pointed, the performance of Vulkan Dota2 drops from
> >>> 72fps to 24fps.
> >>>
> >>> This patches will kill Per-vm-BO advantages, even drop to 1/3 of
> >>> previous non-per-vm-bo.
> >>
> >> This is irrelevant and actually a foreseen consequence of per VM BOs.
> >>
> >> If the performance drops is in-acceptable then the UMD shouldn't use
> >> this feature.
> > I got your mean, if UMD doesn't use this feature, then all BOs should
> > be kernel only, then this change should only be limited to kernel VM
> > BOs, not include UMD BOs.
> > With this limitation, I think the change also can fix your issue.
>
> Correct, yes. Can I get your rb or ab now? We need to get this fixed asap.
>
> Thanks,
> Christian.
>
> >
> > Regards,
> > David Zhou
> >>
> >>> all moved and relocated fence have already synced, we just need to
> >>> catch the va mapping but which is CS itself required, as my proposal
> >>> in another thread, we maybe need to expand va_ioctl to return
> >>> mapping fence to UMD, then UMD passes it to CS as dependency.
> >>
> >> That can be an addition to the existing handling, but first of all
> >> the current state must be corrected.
> >>
> >> There are at least two bug reports on the open driver fixed by this,
> >> so please review.
> >>
> >> Thanks,
> >> Christian.
> >>
> >> Am 11.09.2017 um 10:59 schrieb zhoucm1:
> >>> NAK, as Roger pointed, the performance of Vulkan Dota2 drops from
> >>> 72fps to 24fps.
> >>>
> >>> This patches will kill Per-vm-BO advantages, even drop to 1/3 of
> >>> previous non-per-vm-bo.
> >>>
> >>> all moved and relocated fence have already synced, we just need to
> >>> catch the va mapping but which is CS itself required, as my proposal
> >>> in another thread, we maybe need to expand va_ioctl to return
> >>> mapping fence to UMD, then UMD passes it to CS as dependency.
> >>>
> >>>
> >>> Regards,
> >>>
> >>> David Zhou
> >>>
> >>>
> >>> On 2017年09月11日 15:53, Christian König wrote:
> >>>> From: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> >>>>
> >>>> All users of a VM must always wait for updates with always valid
> >>>> BOs to be completed.
> >>>>
> >>>> v2: remove debugging leftovers, rename struct member
> >>>>
> >>>> Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> >>>> ---
> >>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 10 ++++++----
> >>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 15 ++++++++++-----
> >>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
> >>>>   3 files changed, 17 insertions(+), 10 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> >>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> >>>> index 8aa37e0..4681dcc 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> >>>> @@ -752,10 +752,6 @@ static int amdgpu_bo_vm_update_pte(struct
> >>>> amdgpu_cs_parser *p)
> >>>>       if (r)
> >>>>           return r;
> >>>>   -    r = amdgpu_sync_fence(adev, &p->job->sync,
> >>>> vm->last_dir_update);
> >>>> -    if (r)
> >>>> -        return r;
> >>>> -
> >>>>       r = amdgpu_vm_clear_freed(adev, vm, NULL);
> >>>>       if (r)
> >>>>           return r;
> >>>> @@ -810,6 +806,12 @@ static int amdgpu_bo_vm_update_pte(struct
> >>>> amdgpu_cs_parser *p)
> >>>>       }
> >>>>         r = amdgpu_vm_handle_moved(adev, vm, &p->job->sync);
> >>>> +    if (r)
> >>>> +        return r;
> >>>> +
> >>>> +    r = amdgpu_sync_fence(adev, &p->job->sync, vm->last_update);
> >>>> +    if (r)
> >>>> +        return r;
> >>>>         if (amdgpu_vm_debug && p->bo_list) {
> >>>>           /* Invalidate all BOs to test for userspace bugs */ diff
> >>>> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>>> index 55f1ecb..5042f09 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>>> @@ -1140,9 +1140,8 @@ static int amdgpu_vm_update_level(struct
> >>>> amdgpu_device *adev,
> >>>>                   goto error_free;
> >>>> amdgpu_bo_fence(parent->base.bo, fence, true);
> >>>> - dma_fence_put(vm->last_dir_update);
> >>>> -            vm->last_dir_update = dma_fence_get(fence);
> >>>> -            dma_fence_put(fence);
> >>>> + dma_fence_put(vm->last_update);
> >>>> +            vm->last_update = fence;
> >>>>           }
> >>>>       }
> >>>>   @@ -1803,6 +1802,12 @@ int amdgpu_vm_bo_update(struct
> >>>> amdgpu_device *adev,
> >>>> trace_amdgpu_vm_bo_mapping(mapping);
> >>>>       }
> >>>>   +    if (bo_va->base.bo &&
> >>>> +        bo_va->base.bo->tbo.resv == vm->root.base.bo->tbo.resv) {
> >>>> +        dma_fence_put(vm->last_update);
> >>>> +        vm->last_update = dma_fence_get(bo_va->last_pt_update);
> >>>> +    }
> >>>> +
> >>>>       return 0;
> >>>>   }
> >>>>   @@ -2586,7 +2591,7 @@ int amdgpu_vm_init(struct amdgpu_device
> >>>> *adev, struct amdgpu_vm *vm,
> >>>>                vm->use_cpu_for_update ? "CPU" : "SDMA");
> >>>>       WARN_ONCE((vm->use_cpu_for_update &
> >>>> !amdgpu_vm_is_large_bar(adev)),
> >>>>             "CPU update of VM recommended only for large BAR
> >>>> system\n");
> >>>> -    vm->last_dir_update = NULL;
> >>>> +    vm->last_update = NULL;
> >>>>         flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
> >>>> AMDGPU_GEM_CREATE_VRAM_CLEARED; @@ -2692,7 +2697,7 @@
> >>>> void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm
> >>>> *vm)
> >>>>       }
> >>>> amdgpu_vm_free_levels(&vm->root);
> >>>> -    dma_fence_put(vm->last_dir_update);
> >>>> +    dma_fence_put(vm->last_update);
> >>>>       for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
> >>>> amdgpu_vm_free_reserved_vmid(adev, vm, i);
> >>>>   }
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> >>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> >>>> index c1accd1..cb6a622 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> >>>> @@ -140,7 +140,7 @@ struct amdgpu_vm {
> >>>>         /* contains the page directory */
> >>>>       struct amdgpu_vm_pt     root;
> >>>> -    struct dma_fence    *last_dir_update;
> >>>> +    struct dma_fence    *last_update;
> >>>>         /* protecting freed */
> >>>>       spinlock_t        freed_lock;
> >>>
> >>> _______________________________________________
> >>> amd-gfx mailing list
> >>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >>
> >>
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------252D22FB0DEB007F25357A61
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Ok then we have a misunderstanding
      here. This applies to all per VM BOs, not just kernel BOs.<br>
      <br>
      It's just that as long as the per VM BOs aren't used the handling
      is still correct and we don't have any updates to UMD BOs we
      implicitly wait on.<br>
      <br>
      Sorry I should have waited a bit more, but since it is a very
      rather urgent bug fix I've already pushed it with Rogers rb.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 11.09.2017 um 13:42 schrieb Zhou, David(ChunMing):<br>
    </div>
    <blockquote type="cite"
cite="mid:MWHPR1201MB0206240AA6FA420B2EDA5677B4680-3iK1xFAIwjrUF/YbdlDdgWrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Exchange Server">
      <!-- converted from text -->
      <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
      <div>My mean is you should add a condition in code to check if BO is kernel BO or not. I expect V3.<br>
        <br>
        Regards,<br>
        David<br>
        <br>
        <p dir="ltr" style="display:inline"><span style="color:#888888"><span
              style="font-size:0.81em">发自坚果 Pro</span></span></p>
        <style type="text/css">
<!--
* body
	{padding:0 16px 30px!important;
	margin:0!important;
	background-color:#ffffff;
	line-height:1.4;
	word-wrap:break-word;
	word-break:normal}
div
	{word-wrap:break-word;
	word-break:normal}
p
	{word-wrap:break-word;
	word-break:normal;
	text-indent:0pt!important}
span
	{word-wrap:break-word;
	word-break:normal}
a
	{word-wrap:break-word;
	word-break:normal}
td
	{word-wrap:break-word;
	word-break:break-all}
-->
</style>
        <div class="x_quote">
          <div style="margin:0 0px; font-size:105%"><font
              style="line-height:1.4" color="#629140"><span>He, Roger
                <a class="moz-txt-link-rfc2396E" href="mailto:Hongbo.He-5C7GfCeVMHo@public.gmane.org">&lt;Hongbo.He-5C7GfCeVMHo@public.gmane.org&gt;</a> 于 2017年9月11日 下午6:57写道：</span></font></div>
          <br type="attribution">
        </div>
      </div>
      <font size="2"><span style="font-size:10pt;">
          <div class="PlainText">Reviewed-by: Roger He
            <a class="moz-txt-link-rfc2396E" href="mailto:Hongbo.He-5C7GfCeVMHo@public.gmane.org">&lt;Hongbo.He-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            <br>
            Thanks<br>
            Roger(Hongbo.He)<br>
            -----Original Message-----<br>
            From: amd-gfx [<a
              href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
              moz-do-not-send="true">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]
            On Behalf Of Christian K?nig<br>
            Sent: Monday, September 11, 2017 6:53 PM<br>
            To: Zhou, David(ChunMing) <a class="moz-txt-link-rfc2396E" href="mailto:David1.Zhou-5C7GfCeVMHo@public.gmane.org">&lt;David1.Zhou-5C7GfCeVMHo@public.gmane.org&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            Subject: Re: [PATCH] drm/amdgpu: fix VM sync with always
            valid BOs v2<br>
            <br>
            Am 11.09.2017 um 11:10 schrieb zhoucm1:<br>
            &gt;<br>
            &gt;<br>
            &gt; On 2017年09月11日 17:04, Christian König wrote:<br>
            &gt;&gt;&gt; NAK, as Roger pointed, the performance of
            Vulkan Dota2 drops from <br>
            &gt;&gt;&gt; 72fps to 24fps.<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; This patches will kill Per-vm-BO advantages,
            even drop to 1/3 of <br>
            &gt;&gt;&gt; previous non-per-vm-bo.<br>
            &gt;&gt;<br>
            &gt;&gt; This is irrelevant and actually a foreseen
            consequence of per VM BOs.<br>
            &gt;&gt;<br>
            &gt;&gt; If the performance drops is in-acceptable then the
            UMD shouldn't use <br>
            &gt;&gt; this feature.<br>
            &gt; I got your mean, if UMD doesn't use this feature, then
            all BOs should <br>
            &gt; be kernel only, then this change should only be limited
            to kernel VM <br>
            &gt; BOs, not include UMD BOs.<br>
            &gt; With this limitation, I think the change also can fix
            your issue.<br>
            <br>
            Correct, yes. Can I get your rb or ab now? We need to get
            this fixed asap.<br>
            <br>
            Thanks,<br>
            Christian.<br>
            <br>
            &gt;<br>
            &gt; Regards,<br>
            &gt; David Zhou<br>
            &gt;&gt;<br>
            &gt;&gt;&gt; all moved and relocated fence have already
            synced, we just need to <br>
            &gt;&gt;&gt; catch the va mapping but which is CS itself
            required, as my proposal <br>
            &gt;&gt;&gt; in another thread, we maybe need to expand
            va_ioctl to return <br>
            &gt;&gt;&gt; mapping fence to UMD, then UMD passes it to CS
            as dependency.<br>
            &gt;&gt;<br>
            &gt;&gt; That can be an addition to the existing handling,
            but first of all <br>
            &gt;&gt; the current state must be corrected.<br>
            &gt;&gt;<br>
            &gt;&gt; There are at least two bug reports on the open
            driver fixed by this, <br>
            &gt;&gt; so please review.<br>
            &gt;&gt;<br>
            &gt;&gt; Thanks,<br>
            &gt;&gt; Christian.<br>
            &gt;&gt;<br>
            &gt;&gt; Am 11.09.2017 um 10:59 schrieb zhoucm1:<br>
            &gt;&gt;&gt; NAK, as Roger pointed, the performance of
            Vulkan Dota2 drops from <br>
            &gt;&gt;&gt; 72fps to 24fps.<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; This patches will kill Per-vm-BO advantages,
            even drop to 1/3 of <br>
            &gt;&gt;&gt; previous non-per-vm-bo.<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; all moved and relocated fence have already
            synced, we just need to <br>
            &gt;&gt;&gt; catch the va mapping but which is CS itself
            required, as my proposal <br>
            &gt;&gt;&gt; in another thread, we maybe need to expand
            va_ioctl to return <br>
            &gt;&gt;&gt; mapping fence to UMD, then UMD passes it to CS
            as dependency.<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; Regards,<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; David Zhou<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; On 2017年09月11日 15:53, Christian König wrote:<br>
            &gt;&gt;&gt;&gt; From: Christian König
            <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            &gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt; All users of a VM must always wait for
            updates with always valid <br>
            &gt;&gt;&gt;&gt; BOs to be completed.<br>
            &gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt; v2: remove debugging leftovers, rename
            struct member<br>
            &gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt; Signed-off-by: Christian König
            <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            &gt;&gt;&gt;&gt; ---<br>
            &gt;&gt;&gt;&gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |
            10 ++++++----<br>
            &gt;&gt;&gt;&gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |
            15 ++++++++++-----<br>
            &gt;&gt;&gt;&gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 
            2 +-<br>
            &gt;&gt;&gt;&gt;   3 files changed, 17 insertions(+), 10
            deletions(-)<br>
            &gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt; diff --git
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
            &gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
            &gt;&gt;&gt;&gt; index 8aa37e0..4681dcc 100644<br>
            &gt;&gt;&gt;&gt; ---
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
            &gt;&gt;&gt;&gt; +++
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
            &gt;&gt;&gt;&gt; @@ -752,10 +752,6 @@ static int
            amdgpu_bo_vm_update_pte(struct <br>
            &gt;&gt;&gt;&gt; amdgpu_cs_parser *p)<br>
            &gt;&gt;&gt;&gt;       if (r)<br>
            &gt;&gt;&gt;&gt;           return r;<br>
            &gt;&gt;&gt;&gt;   -    r = amdgpu_sync_fence(adev,
            &amp;p-&gt;job-&gt;sync, <br>
            &gt;&gt;&gt;&gt; vm-&gt;last_dir_update);<br>
            &gt;&gt;&gt;&gt; -    if (r)<br>
            &gt;&gt;&gt;&gt; -        return r;<br>
            &gt;&gt;&gt;&gt; -<br>
            &gt;&gt;&gt;&gt;       r = amdgpu_vm_clear_freed(adev, vm,
            NULL);<br>
            &gt;&gt;&gt;&gt;       if (r)<br>
            &gt;&gt;&gt;&gt;           return r;<br>
            &gt;&gt;&gt;&gt; @@ -810,6 +806,12 @@ static int
            amdgpu_bo_vm_update_pte(struct <br>
            &gt;&gt;&gt;&gt; amdgpu_cs_parser *p)<br>
            &gt;&gt;&gt;&gt;       }<br>
            &gt;&gt;&gt;&gt;         r = amdgpu_vm_handle_moved(adev,
            vm, &amp;p-&gt;job-&gt;sync);<br>
            &gt;&gt;&gt;&gt; +    if (r)<br>
            &gt;&gt;&gt;&gt; +        return r;<br>
            &gt;&gt;&gt;&gt; +<br>
            &gt;&gt;&gt;&gt; +    r = amdgpu_sync_fence(adev,
            &amp;p-&gt;job-&gt;sync, vm-&gt;last_update);<br>
            &gt;&gt;&gt;&gt; +    if (r)<br>
            &gt;&gt;&gt;&gt; +        return r;<br>
            &gt;&gt;&gt;&gt;         if (amdgpu_vm_debug &amp;&amp;
            p-&gt;bo_list) {<br>
            &gt;&gt;&gt;&gt;           /* Invalidate all BOs to test for
            userspace bugs */ diff <br>
            &gt;&gt;&gt;&gt; --git
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
            &gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
            &gt;&gt;&gt;&gt; index 55f1ecb..5042f09 100644<br>
            &gt;&gt;&gt;&gt; ---
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
            &gt;&gt;&gt;&gt; +++
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
            &gt;&gt;&gt;&gt; @@ -1140,9 +1140,8 @@ static int
            amdgpu_vm_update_level(struct <br>
            &gt;&gt;&gt;&gt; amdgpu_device *adev,<br>
            &gt;&gt;&gt;&gt;                   goto error_free;<br>
            &gt;&gt;&gt;&gt;                
            amdgpu_bo_fence(parent-&gt;base.bo, fence, true);<br>
            &gt;&gt;&gt;&gt; -           
            dma_fence_put(vm-&gt;last_dir_update);<br>
            &gt;&gt;&gt;&gt; -            vm-&gt;last_dir_update =
            dma_fence_get(fence);<br>
            &gt;&gt;&gt;&gt; -            dma_fence_put(fence);<br>
            &gt;&gt;&gt;&gt; +           
            dma_fence_put(vm-&gt;last_update);<br>
            &gt;&gt;&gt;&gt; +            vm-&gt;last_update = fence;<br>
            &gt;&gt;&gt;&gt;           }<br>
            &gt;&gt;&gt;&gt;       }<br>
            &gt;&gt;&gt;&gt;   @@ -1803,6 +1802,12 @@ int
            amdgpu_vm_bo_update(struct <br>
            &gt;&gt;&gt;&gt; amdgpu_device *adev,<br>
            &gt;&gt;&gt;&gt;              
            trace_amdgpu_vm_bo_mapping(mapping);<br>
            &gt;&gt;&gt;&gt;       }<br>
            &gt;&gt;&gt;&gt;   +    if (bo_va-&gt;base.bo &amp;&amp;<br>
            &gt;&gt;&gt;&gt; +        bo_va-&gt;base.bo-&gt;tbo.resv ==
            vm-&gt;root.base.bo-&gt;tbo.resv) {<br>
            &gt;&gt;&gt;&gt; +        dma_fence_put(vm-&gt;last_update);<br>
            &gt;&gt;&gt;&gt; +        vm-&gt;last_update =
            dma_fence_get(bo_va-&gt;last_pt_update);<br>
            &gt;&gt;&gt;&gt; +    }<br>
            &gt;&gt;&gt;&gt; +<br>
            &gt;&gt;&gt;&gt;       return 0;<br>
            &gt;&gt;&gt;&gt;   }<br>
            &gt;&gt;&gt;&gt;   @@ -2586,7 +2591,7 @@ int
            amdgpu_vm_init(struct amdgpu_device <br>
            &gt;&gt;&gt;&gt; *adev, struct amdgpu_vm *vm,<br>
            &gt;&gt;&gt;&gt;                vm-&gt;use_cpu_for_update ?
            "CPU" : "SDMA");<br>
            &gt;&gt;&gt;&gt;       WARN_ONCE((vm-&gt;use_cpu_for_update
            &amp; <br>
            &gt;&gt;&gt;&gt; !amdgpu_vm_is_large_bar(adev)),<br>
            &gt;&gt;&gt;&gt;             "CPU update of VM recommended
            only for large BAR <br>
            &gt;&gt;&gt;&gt; system\n");<br>
            &gt;&gt;&gt;&gt; -    vm-&gt;last_dir_update = NULL;<br>
            &gt;&gt;&gt;&gt; +    vm-&gt;last_update = NULL;<br>
            &gt;&gt;&gt;&gt;         flags =
            AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |<br>
            &gt;&gt;&gt;&gt;              
            AMDGPU_GEM_CREATE_VRAM_CLEARED; @@ -2692,7 +2697,7 @@ <br>
            &gt;&gt;&gt;&gt; void amdgpu_vm_fini(struct amdgpu_device
            *adev, struct amdgpu_vm <br>
            &gt;&gt;&gt;&gt; *vm)<br>
            &gt;&gt;&gt;&gt;       }<br>
            &gt;&gt;&gt;&gt;        
            amdgpu_vm_free_levels(&amp;vm-&gt;root);<br>
            &gt;&gt;&gt;&gt; -    dma_fence_put(vm-&gt;last_dir_update);<br>
            &gt;&gt;&gt;&gt; +    dma_fence_put(vm-&gt;last_update);<br>
            &gt;&gt;&gt;&gt;       for (i = 0; i &lt; AMDGPU_MAX_VMHUBS;
            i++)<br>
            &gt;&gt;&gt;&gt;          
            amdgpu_vm_free_reserved_vmid(adev, vm, i);<br>
            &gt;&gt;&gt;&gt;   }<br>
            &gt;&gt;&gt;&gt; diff --git
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
            &gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
            &gt;&gt;&gt;&gt; index c1accd1..cb6a622 100644<br>
            &gt;&gt;&gt;&gt; ---
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
            &gt;&gt;&gt;&gt; +++
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
            &gt;&gt;&gt;&gt; @@ -140,7 +140,7 @@ struct amdgpu_vm {<br>
            &gt;&gt;&gt;&gt;         /* contains the page directory */<br>
            &gt;&gt;&gt;&gt;       struct amdgpu_vm_pt     root;<br>
            &gt;&gt;&gt;&gt; -    struct dma_fence    *last_dir_update;<br>
            &gt;&gt;&gt;&gt; +    struct dma_fence    *last_update;<br>
            &gt;&gt;&gt;&gt;         /* protecting freed */<br>
            &gt;&gt;&gt;&gt;       spinlock_t        freed_lock;<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; _______________________________________________<br>
            &gt;&gt;&gt; amd-gfx mailing list<br>
            &gt;&gt;&gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            &gt;&gt;&gt; <a
              href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
              moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
            &gt;&gt;<br>
            &gt;&gt;<br>
            &gt;<br>
            &gt; _______________________________________________<br>
            &gt; amd-gfx mailing list<br>
            &gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            &gt; <a
              href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
              moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
            <br>
            <br>
            _______________________________________________<br>
            amd-gfx mailing list<br>
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            <a
              href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
              moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
          </div>
        </span></font>
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

--------------252D22FB0DEB007F25357A61--

--===============0662128086==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0662128086==--
