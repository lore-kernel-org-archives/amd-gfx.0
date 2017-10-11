From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: TDR and VRAM lost handling in KMD:
Date: Wed, 11 Oct 2017 11:02:47 +0200
Message-ID: <7a7a1830-5457-ea68-44dc-f88eb1e0a8fe@amd.com>
References: <BLUPR12MB0449785160E34EA9369C5E23844A0@BLUPR12MB0449.namprd12.prod.outlook.com>
 <b5c5f6c9-07e2-4688-8ffc-3929bfc59366@amd.com>
 <BLUPR12MB044911DFCB510022605DD38A844A0@BLUPR12MB0449.namprd12.prod.outlook.com>
 <DM5PR12MB1292D21FC5438AEA8FCF9F64FF4A0@DM5PR12MB1292.namprd12.prod.outlook.com>
 <BLUPR12MB0449287A92DF8D3EB30BE6A6844A0@BLUPR12MB0449.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0120759384=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB0449287A92DF8D3EB30BE6A6844A0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "Haehnle, Nicolai" <Nicolai.Haehnle-5C7GfCeVMHo@public.gmane.org>, "Olsak, Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Ramirez, Alejandro" <Alejandro.Ramirez-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Filipas,
 Mario" <Mario.Filipas-5C7GfCeVMHo@public.gmane.org>, "Ding, Pixel" <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>, "Li,
 Bingley" <Bingley.Li-5C7GfCeVMHo@public.gmane.org>, "Jiang, Jerry (SW)" <Jerry.Jiang-5C7GfCeVMHo@public.gmane.org>

--===============0120759384==
Content-Type: multipart/alternative;
 boundary="------------43102E1E54431C52DCB882A3"
Content-Language: en-US

--------------43102E1E54431C52DCB882A3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

> [ML] I think context is better than entity, because for example if you 
> only block entity_0 of context and allow entity_N run, that means the 
> dependency between entities are broken (e.g. page table updates in
>
> Sdma entity pass but gfx submit in GFX entity blocked, not make sense 
> to me)
>
> We’d better either block the whole context or let not…
>
Page table updates are not part of any context.

So I think the only thing we can do is to mark the entity as not 
scheduled any more.

> 1.Kick out all jobs in this “guilty” ctx’s KFIFO queue, and set all 
> their fence status to “*ECANCELED*”
>
> Setting ECANCELED should be ok. But I think we should do this when we 
> try to run the jobs and not during GPU reset.
>
> [ML] without deep thought and expritment, I’m not sure the difference 
> between them, but kick it out in gpu_reset routine is more efficient,
>
I really don't think so. Kicking them out during gpu_reset sounds racy 
to me once more.

And marking them canceled when we try to run them has the clear 
advantage that all dependencies are meet first.

> ML: KMD mark all contexts as guilty is because that way we can unify 
> our IOCTL behavior: e.g. for IOCTL only block “guilty”context , no 
> need to worry about vram-lost-counter anymore, that’s a implementation 
> style. I don’t think it is related with UMD layer,
>
I don't think that this is a good idea. Instead when you want to unify 
the behavior we should use the vram_lost_counter as marker for the 
guilty context.

Regards,
Christian.

Am 11.10.2017 um 10:48 schrieb Liu, Monk:
>
> On "guilty": "guilty" is a term that's used by APIs (e.g. OpenGL), so 
> it's reasonable to use it. However, it /does not/ make sense to mark 
> idle contexts as "guilty" just because VRAM is lost. VRAM lost is a 
> perfect example where the driver should report context lost to 
> applications with the "innocent" flag for contexts that were idle at 
> the time of reset. The only context(s) that should be reported as 
> "guilty" (or perhaps "unknown" in some cases) are the ones that were 
> executing at the time of reset.
>
> ML: KMD mark all contexts as guilty is because that way we can unify 
> our IOCTL behavior: e.g. for IOCTL only block “guilty”context , no 
> need to worry about vram-lost-counter anymore, that’s a implementation 
> style. I don’t think it is related with UMD layer,
>
> For UMD the gl-context isn’t aware of by KMD, so UMD can implement it 
> own “guilty” gl-context if you want.
>
> If KMD doesn’t mark all ctx as guilty after VRAM lost, can you 
> illustrate what rule KMD should obey to check in KMS IOCTL like 
> cs_sumbit ?? let’s see which way better
>
> *From:*Haehnle, Nicolai
> *Sent:* Wednesday, October 11, 2017 4:41 PM
> *To:* Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>; Koenig, Christian 
> <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>; Olsak, Marek <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>; 
> Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
> *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Ding, Pixel <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>; 
> Jiang, Jerry (SW) <Jerry.Jiang-5C7GfCeVMHo@public.gmane.org>; Li, Bingley 
> <Bingley.Li-5C7GfCeVMHo@public.gmane.org>; Ramirez, Alejandro <Alejandro.Ramirez-5C7GfCeVMHo@public.gmane.org>; 
> Filipas, Mario <Mario.Filipas-5C7GfCeVMHo@public.gmane.org>
> *Subject:* Re: TDR and VRAM lost handling in KMD:
>
> From a Mesa perspective, this almost all sounds reasonable to me.
>
> On "guilty": "guilty" is a term that's used by APIs (e.g. OpenGL), so 
> it's reasonable to use it. However, it /does not/ make sense to mark 
> idle contexts as "guilty" just because VRAM is lost. VRAM lost is a 
> perfect example where the driver should report context lost to 
> applications with the "innocent" flag for contexts that were idle at 
> the time of reset. The only context(s) that should be reported as 
> "guilty" (or perhaps "unknown" in some cases) are the ones that were 
> executing at the time of reset.
>
> On whether the whole context is marked as guilty from a user space 
> perspective, it would simply be nice for user space to get consistent 
> answers. It would be a bit odd if we could e.g. succeed in submitting 
> an SDMA job after a GFX job was rejected. This would point in favor of 
> marking the entire context as guilty (although that could happen 
> lazily instead of at reset time). On the other hand, if that's too big 
> a burden for the kernel implementation I'm sure we can live without it.
>
> Cheers,
>
> Nicolai
>
> ------------------------------------------------------------------------
>
> *From:*Liu, Monk
> *Sent:* Wednesday, October 11, 2017 10:15:40 AM
> *To:* Koenig, Christian; Haehnle, Nicolai; Olsak, Marek; Deucher, 
> Alexander
> *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org 
> <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Ding, Pixel; Jiang, Jerry 
> (SW); Li, Bingley; Ramirez, Alejandro; Filipas, Mario
> *Subject:* RE: TDR and VRAM lost handling in KMD:
>
> 1.Set its fence error status to “*ETIME*”,
>
> No, as I already explained ETIME is for synchronous operation.
>
> In other words when we return ETIME from the wait IOCTL it would mean 
> that the waiting has somehow timed out, but not the job we waited for.
>
> Please use ECANCELED as well or some other error code when we find 
> that we need to distinct the timedout job from the canceled ones 
> (probably a good idea, but I'm not sure).
>
> [ML] I’m okay if you insist not to use ETIME
>
> 1.Find the entity/ctx behind this job, and set this ctx as “*guilty*”
>
> Not sure. Do we want to set the whole context as guilty or just the 
> entity?
>
> Setting the whole contexts as guilty sounds racy to me.
>
> BTW: We should use a different name than "guilty", maybe just "bool 
> canceled;" ?
>
> [ML] I think context is better than entity, because for example if you 
> only block entity_0 of context and allow entity_N run, that means the 
> dependency between entities are broken (e.g. page table updates in
>
> Sdma entity pass but gfx submit in GFX entity blocked, not make sense 
> to me)
>
> We’d better either block the whole context or let not…
>
> 1.Kick out all jobs in this “guilty” ctx’s KFIFO queue, and set all 
> their fence status to “*ECANCELED*”
>
> Setting ECANCELED should be ok. But I think we should do this when we 
> try to run the jobs and not during GPU reset.
>
> [ML] without deep thought and expritment, I’m not sure the difference 
> between them, but kick it out in gpu_reset routine is more efficient,
>
> Otherwise you need to check context/entity guilty flag in run_job 
> routine …and you need to it for every context/entity, I don’t see why
>
> We don’t just kickout all of them in gpu_reset stage ….
>
> a)Iterate over all living ctx, and set all ctx as “*guilty*” since 
> VRAM lost actually ruins all VRAM contents
>
> No, that shouldn't be done by comparing the counters. Iterating over 
> all contexts is way to much overhead.
>
> [ML] because I want to make KMS IOCTL rules clean, like they don’t 
> need to differentiate VRAM lost or not, they only interested in if the 
> context is guilty or not, and block
>
> Submit for guilty ones.
>
> *Can you give more details of your idea? And better the detail 
> implement in cs_submit, I want to see how you want to block submit 
> without checking context guilty flag*
>
> a)Kick out all jobs in all ctx’s KFIFO queue, and set all their fence 
> status to “*ECANCELDED*”
>
> Yes and no, that should be done when we try to run the jobs and not 
> during GPU reset.
>
> [ML] again, kicking out them in gpu reset routine is high efficient, 
> otherwise you need check on every job in run_job()
>
> Besides, can you illustrate the detail implementation ?
>
> Yes and no, dma_fence_get_status() is some specific handling for 
> sync_file debugging (no idea why that made it into the common fence code).
>
> It was replaced by putting the error code directly into the fence, so 
> just reading that one after waiting should be ok.
>
> Maybe we should fix dma_fence_get_status() to do the right thing for this?
>
> [ML] yeah, that’s too confusing, the name sound really the one I want 
> to use, we should change it…
>
> *But look into the implement, I don**’t see why we cannot use it ? it 
> also finally return the fence->error *
>
> *From:*Koenig, Christian
> *Sent:* Wednesday, October 11, 2017 3:21 PM
> *To:* Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org <mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>>; Haehnle, 
> Nicolai <Nicolai.Haehnle-5C7GfCeVMHo@public.gmane.org <mailto:Nicolai.Haehnle-5C7GfCeVMHo@public.gmane.org>>; 
> Olsak, Marek <Marek.Olsak-5C7GfCeVMHo@public.gmane.org <mailto:Marek.Olsak-5C7GfCeVMHo@public.gmane.org>>; 
> Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org 
> <mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>>
> *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org 
> <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Ding, Pixel 
> <Pixel.Ding-5C7GfCeVMHo@public.gmane.org <mailto:Pixel.Ding-5C7GfCeVMHo@public.gmane.org>>; Jiang, Jerry (SW) 
> <Jerry.Jiang-5C7GfCeVMHo@public.gmane.org <mailto:Jerry.Jiang-5C7GfCeVMHo@public.gmane.org>>; Li, Bingley 
> <Bingley.Li-5C7GfCeVMHo@public.gmane.org <mailto:Bingley.Li-5C7GfCeVMHo@public.gmane.org>>; Ramirez, Alejandro 
> <Alejandro.Ramirez-5C7GfCeVMHo@public.gmane.org <mailto:Alejandro.Ramirez-5C7GfCeVMHo@public.gmane.org>>; 
> Filipas, Mario <Mario.Filipas-5C7GfCeVMHo@public.gmane.org <mailto:Mario.Filipas-5C7GfCeVMHo@public.gmane.org>>
> *Subject:* Re: TDR and VRAM lost handling in KMD:
>
> See inline:
>
> Am 11.10.2017 um 07:33 schrieb Liu, Monk:
>
>     Hi Christian & Nicolai,
>
>     We need to achieve some agreements on what should MESA/UMD do and
>     what should KMD do, *please give your comments with “okay” or “No”
>     and your idea on below items,*
>
>     ?When a job timed out (set from lockup_timeout kernel parameter),
>     What KMD should do in TDR routine :
>
>     1.Update adev->*gpu_reset_counter*, and stop scheduler first,
>     (*gpu_reset_counter* is used to force vm flush after GPU reset,
>     out of this thread’s scope so no more discussion on it)
>
> Okay.
>
>     2.Set its fence error status to “*ETIME*”,
>
> No, as I already explained ETIME is for synchronous operation.
>
> In other words when we return ETIME from the wait IOCTL it would mean 
> that the waiting has somehow timed out, but not the job we waited for.
>
> Please use ECANCELED as well or some other error code when we find 
> that we need to distinct the timedout job from the canceled ones 
> (probably a good idea, but I'm not sure).
>
>     3.Find the entity/ctx behind this job, and set this ctx as “*guilty*”
>
> Not sure. Do we want to set the whole context as guilty or just the 
> entity?
>
> Setting the whole contexts as guilty sounds racy to me.
>
> BTW: We should use a different name than "guilty", maybe just "bool 
> canceled;" ?
>
>     4.Kick out this job from scheduler’s mirror list, so this job
>     won’t get re-scheduled to ring anymore.
>
> Okay.
>
>     5.Kick out all jobs in this “guilty” ctx’s KFIFO queue, and set
>     all their fence status to “*ECANCELED*”
>
> Setting ECANCELED should be ok. But I think we should do this when we 
> try to run the jobs and not during GPU reset.
>
>     6.Force signal all fences that get kicked out by above two
>     steps,*otherwise UMD will block forever if waiting on those fences*
>
> Okay.
>
>     7.Do gpu reset, which is can be some callbacks to let bare-metal
>     and SR-IOV implement with their favor style
>
> Okay.
>
>     8.After reset, KMD need to aware if the VRAM lost happens or not,
>     bare-metal can implement some function to judge, while for SR-IOV
>     I prefer to read it from GIM side (for initial version we consider
>     it’s always VRAM lost, till GIM side change aligned)
>
> Okay.
>
>     9.If VRAM lost not hit, continue, otherwise:
>
>     a)Update adev->*vram_lost_counter*,
>
> Okay.
>
>     b)Iterate over all living ctx, and set all ctx as “*guilty*” since
>     VRAM lost actually ruins all VRAM contents
>
> No, that shouldn't be done by comparing the counters. Iterating over 
> all contexts is way to much overhead.
>
>     c)Kick out all jobs in all ctx’s KFIFO queue, and set all their
>     fence status to “*ECANCELDED*”
>
> Yes and no, that should be done when we try to run the jobs and not 
> during GPU reset.
>
>     10.Do GTT recovery and VRAM page tables/entries recovery
>     (optional, do we need it ???)
>
> Yes, that is still needed. As Nicolai explained we can't be sure that 
> VRAM is still 100% correct even when it isn't cleared.
>
>     11.Re-schedule all JOBs remains in mirror list to ring again and
>     restart scheduler (for VRAM lost case, no JOB will re-scheduled)
>
> Okay.
>
>     ?For cs_wait() IOCTL:
>
>     After it found fence signaled, it should check with
>     *“dma_fence_get_status” *to see if there is error there,
>
>     And return the error status of fence
>
> Yes and no, dma_fence_get_status() is some specific handling for 
> sync_file debugging (no idea why that made it into the common fence code).
>
> It was replaced by putting the error code directly into the fence, so 
> just reading that one after waiting should be ok.
>
> Maybe we should fix dma_fence_get_status() to do the right thing for this?
>
>     ?For cs_wait_fences() IOCTL:
>
>     Similar with above approach
>
>     ?For cs_submit() IOCTL:
>
>     It need to check if current ctx been marked as “*guilty*” and
>     return “*ECANCELED*” if so
>
>     ?Introduce a new IOCTL to let UMD query *vram_lost_counter*:
>
>     This way, UMD can also block app from submitting, like @Nicolai
>     mentioned, we can cache one copy of *vram_lost_counter* when
>     enumerate physical device, and deny all
>
>     gl-context from submitting if the counter queried bigger than that
>     one cached in physical device. (looks a little overkill to me, but
>     easy to implement )
>
>     UMD can also return error to APP when creating gl-context if found
>     current queried*vram_lost_counter *bigger than that one cached in
>     physical device.
>
> Okay. Already have a patch for this, please review that one if you 
> haven't already done so.
>
> Regards,
> Christian.
>
>     BTW: I realized that gl-context is a little different with
>     kernel’s context. Because for kernel. BO is not related with
>     context but only with FD, while in UMD, BO have a backend
>
>     gl-context, so block submitting in UMD layer is also needed
>     although KMD will do its job as bottom line
>
>     ?Basically “vram_lost_counter” is exposure by kernel to let UMD
>     take the control of robust extension feature, it will be UMD’s
>     call to move, KMD only deny “guilty” context from submitting
>
>     Need your feedback, thx
>
>     We’d better make TDR feature landed ASAP
>
>     BR Monk
>


--------------43102E1E54431C52DCB882A3
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite"><span
          style="font-size:12.0pt;font-family:SimSun" lang="EN-US"></span>
        <p class="MsoNormal"><span
            style="font-size:12.0pt;font-family:SimSun" lang="EN-US">[ML]
            I think context is better than entity, because for example
            if you only block entity_0 of context and allow entity_N
            run, that means the dependency between entities are broken
            (e.g. page table updates in </span></p>
        <p class="MsoNormal"><span
            style="font-size:12.0pt;font-family:SimSun" lang="EN-US">Sdma
            entity pass but gfx submit in GFX entity blocked, not make
            sense to me)</span></p>
        <p class="MsoNormal"><span
            style="font-size:12.0pt;font-family:SimSun" lang="EN-US">We</span><span
            style="font-size:12.0pt;font-family:SimSun">’<span
              lang="EN-US">d better either block the whole context or
              let not</span>…
          </span></p>
      </blockquote>
      Page table updates are not part of any context.<br>
      <br>
      So I think the only thing we can do is to mark the entity as not
      scheduled any more.<br>
      <br>
      <blockquote type="cite"><span
          style="font-size:12.0pt;font-family:SimSun" lang="EN-US"></span>
        <p class="MsoListParagraph"
          style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l1
          level1 lfo6">
          <span lang="EN-US"><span style="mso-list:Ignore">1.<span
                style="font:7.0pt &quot;Times New Roman&quot;">       
              </span></span></span><span lang="EN-US">Kick out all jobs
            in this “guilty” ctx’s KFIFO queue, and set all their fence
            status to “<b>ECANCELED</b>”</span></p>
        <p class="MsoNormal"><span
            style="font-size:12.0pt;font-family:SimSun" lang="EN-US">Setting
            ECANCELED should be ok. But I think we should do this when
            we try to run the jobs and not during GPU reset.</span></p>
        <p class="MsoNormal"><span
            style="font-size:12.0pt;font-family:SimSun" lang="EN-US"> </span></p>
        <p class="MsoNormal"><span
            style="font-size:12.0pt;font-family:SimSun" lang="EN-US">[ML]
            without deep thought and expritment, I</span><span
            style="font-size:12.0pt;font-family:SimSun">’<span
              lang="EN-US">m not sure the difference between them, but
              kick it out in gpu_reset routine is more efficient, </span></span></p>
      </blockquote>
      I really don't think so. Kicking them out during gpu_reset sounds
      racy to me once more.<br>
      <br>
      And marking them canceled when we try to run them has the clear
      advantage that all dependencies are meet first.<br>
      <br>
      <blockquote type="cite">
        <p class="MsoNormal"><span
            style="font-family:DengXian;color:windowtext" lang="EN-US">ML:
            KMD mark all contexts as guilty is because that way we can
            unify our IOCTL behavior: e.g. for IOCTL only block
            “guilty”context , no need to worry about vram-lost-counter
            anymore, that’s a implementation style. I don’t think it is
            related with UMD layer,</span></p>
        <span style="font-family:DengXian;color:windowtext" lang="EN-US"></span></blockquote>
      I don't think that this is a good idea. Instead when you want to
      unify the behavior we should use the vram_lost_counter as marker
      for the guilty context.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 11.10.2017 um 10:48 schrieb Liu, Monk:<br>
    </div>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449287A92DF8D3EB30BE6A6844A0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
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
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:??;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.5pt;
	font-family:??;
	color:black;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:21.0pt;
	font-size:10.5pt;
	font-family:??;
	color:black;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:??;
	color:black;}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:??;
	color:windowtext;}
span.EmailStyle20
	{mso-style-type:personal;
	font-family:??;
	color:windowtext;}
span.EmailStyle23
	{mso-style-type:personal-reply;
	font-family:DengXian;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:65107788;
	mso-list-type:hybrid;
	mso-list-template-ids:1024615094 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:21.0pt;
	text-indent:-21.0pt;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%2\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:63.0pt;
	text-indent:-21.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%5\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:126.0pt;
	text-indent:-21.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%8\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:189.0pt;
	text-indent:-21.0pt;}
@list l1
	{mso-list-id:387386877;
	mso-list-type:hybrid;
	mso-list-template-ids:1024615094 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:21.0pt;
	text-indent:-21.0pt;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%2\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:63.0pt;
	text-indent:-21.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%5\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:126.0pt;
	text-indent:-21.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%8\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:189.0pt;
	text-indent:-21.0pt;}
@list l2
	{mso-list-id:697632068;
	mso-list-type:hybrid;
	mso-list-template-ids:448443560 67698689 67698691 67698693 67698689 67698691 67698693 67698689 67698691 67698693;}
@list l2:level1
	{mso-level-number-format:bullet;
	mso-level-text:?;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:21.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level2
	{mso-level-number-format:bullet;
	mso-level-text:?;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level3
	{mso-level-number-format:bullet;
	mso-level-text:?;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:63.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level4
	{mso-level-number-format:bullet;
	mso-level-text:?;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level5
	{mso-level-number-format:bullet;
	mso-level-text:?;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level6
	{mso-level-number-format:bullet;
	mso-level-text:?;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:126.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level7
	{mso-level-number-format:bullet;
	mso-level-text:?;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level8
	{mso-level-number-format:bullet;
	mso-level-text:?;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level9
	{mso-level-number-format:bullet;
	mso-level-text:?;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:189.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l3
	{mso-list-id:1298757877;
	mso-list-type:hybrid;
	mso-list-template-ids:1024615094 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l3:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:21.0pt;
	text-indent:-21.0pt;}
@list l3:level2
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%2\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;}
@list l3:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:63.0pt;
	text-indent:-21.0pt;}
@list l3:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;}
@list l3:level5
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%5\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;}
@list l3:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:126.0pt;
	text-indent:-21.0pt;}
@list l3:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;}
@list l3:level8
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%8\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;}
@list l3:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:189.0pt;
	text-indent:-21.0pt;}
@list l4
	{mso-list-id:1671643712;
	mso-list-type:hybrid;
	mso-list-template-ids:1024615094 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l4:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:21.0pt;
	text-indent:-21.0pt;}
@list l4:level2
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%2\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;}
@list l4:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:63.0pt;
	text-indent:-21.0pt;}
@list l4:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;}
@list l4:level5
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%5\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;}
@list l4:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:126.0pt;
	text-indent:-21.0pt;}
@list l4:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;}
@list l4:level8
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%8\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;}
@list l4:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:189.0pt;
	text-indent:-21.0pt;}
@list l5
	{mso-list-id:1679431240;
	mso-list-type:hybrid;
	mso-list-template-ids:1024615094 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l5:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:21.0pt;
	text-indent:-21.0pt;}
@list l5:level2
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%2\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;}
@list l5:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:63.0pt;
	text-indent:-21.0pt;}
@list l5:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;}
@list l5:level5
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%5\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;}
@list l5:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:126.0pt;
	text-indent:-21.0pt;}
@list l5:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;}
@list l5:level8
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%8\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;}
@list l5:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:189.0pt;
	text-indent:-21.0pt;}
@list l6
	{mso-list-id:1765762926;
	mso-list-type:hybrid;
	mso-list-template-ids:1024615094 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l6:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:21.0pt;
	text-indent:-21.0pt;}
@list l6:level2
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%2\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;}
@list l6:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:63.0pt;
	text-indent:-21.0pt;}
@list l6:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;}
@list l6:level5
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%5\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;}
@list l6:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:126.0pt;
	text-indent:-21.0pt;}
@list l6:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;}
@list l6:level8
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%8\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;}
@list l6:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:189.0pt;
	text-indent:-21.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p><span style="font-size:12.0pt;color:black" lang="EN-US"><o:p> </o:p></span></p>
        <p><span style="font-size:12.0pt;color:black" lang="EN-US">On
            "guilty": "guilty" is a term that's used by APIs (e.g.
            OpenGL), so it's reasonable to use it. However, it
            <i>does not</i> make sense to mark idle contexts as "guilty"
            just because VRAM is lost. VRAM lost is a perfect example
            where the driver should report context lost to applications
            with the "innocent" flag for contexts that were idle at the
            time of reset. The only context(s) that should be reported
            as "guilty" (or perhaps "unknown" in some cases) are the
            ones that were executing at the time of reset.<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:DengXian;color:windowtext" lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:DengXian;color:windowtext" lang="EN-US">ML:
            KMD mark all contexts as guilty is because that way we can
            unify our IOCTL behavior: e.g. for IOCTL only block
            “guilty”context , no need to worry about vram-lost-counter
            anymore, that’s a implementation style. I don’t think it is
            related with UMD layer,<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:DengXian;color:windowtext" lang="EN-US">For
            UMD the gl-context isn’t aware of by KMD, so UMD can
            implement it own “guilty” gl-context if you want.<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:DengXian;color:windowtext" lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:DengXian;color:windowtext" lang="EN-US">If
            KMD doesn’t mark all ctx as guilty after VRAM lost, can you
            illustrate what rule KMD should obey to check in KMS IOCTL
            like cs_sumbit ?? let’s see which way better
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:DengXian;color:windowtext" lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:DengXian;color:windowtext" lang="EN-US"><o:p> </o:p></span></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0cm 0cm 0cm">
            <p class="MsoNormal" style="text-align:left" align="left"><b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext"
                  lang="EN-US">From:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext"
                lang="EN-US"> Haehnle, Nicolai <br>
                <b>Sent:</b> Wednesday, October 11, 2017 4:41 PM<br>
                <b>To:</b> Liu, Monk <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>; Koenig,
                Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org">&lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>; Olsak, Marek
                <a class="moz-txt-link-rfc2396E" href="mailto:Marek.Olsak-5C7GfCeVMHo@public.gmane.org">&lt;Marek.Olsak-5C7GfCeVMHo@public.gmane.org&gt;</a>; Deucher, Alexander
                <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">&lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                <b>Cc:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Ding, Pixel
                <a class="moz-txt-link-rfc2396E" href="mailto:Pixel.Ding-5C7GfCeVMHo@public.gmane.org">&lt;Pixel.Ding-5C7GfCeVMHo@public.gmane.org&gt;</a>; Jiang, Jerry (SW)
                <a class="moz-txt-link-rfc2396E" href="mailto:Jerry.Jiang-5C7GfCeVMHo@public.gmane.org">&lt;Jerry.Jiang-5C7GfCeVMHo@public.gmane.org&gt;</a>; Li, Bingley
                <a class="moz-txt-link-rfc2396E" href="mailto:Bingley.Li-5C7GfCeVMHo@public.gmane.org">&lt;Bingley.Li-5C7GfCeVMHo@public.gmane.org&gt;</a>; Ramirez, Alejandro
                <a class="moz-txt-link-rfc2396E" href="mailto:Alejandro.Ramirez-5C7GfCeVMHo@public.gmane.org">&lt;Alejandro.Ramirez-5C7GfCeVMHo@public.gmane.org&gt;</a>; Filipas, Mario
                <a class="moz-txt-link-rfc2396E" href="mailto:Mario.Filipas-5C7GfCeVMHo@public.gmane.org">&lt;Mario.Filipas-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                <b>Subject:</b> Re: TDR and VRAM lost handling in KMD:<o:p></o:p></span></p>
          </div>
        </div>
        <p class="MsoNormal" style="text-align:left" align="left"><span
            lang="EN-US"><o:p> </o:p></span></p>
        <div id="divtagdefaultwrapper">
          <p><span style="font-size:12.0pt;color:black" lang="EN-US">From
              a Mesa perspective, this almost all sounds reasonable to
              me.<o:p></o:p></span></p>
          <p><span style="font-size:12.0pt;color:black" lang="EN-US"><o:p> </o:p></span></p>
          <p><span style="font-size:12.0pt;color:black" lang="EN-US">On
              "guilty": "guilty" is a term that's used by APIs (e.g.
              OpenGL), so it's reasonable to use it. However, it
              <i>does not</i> make sense to mark idle contexts as
              "guilty" just because VRAM is lost. VRAM lost is a perfect
              example where the driver should report context lost to
              applications with the "innocent" flag for contexts that
              were idle at the time of reset. The only context(s) that
              should be reported as "guilty" (or perhaps "unknown" in
              some cases) are the ones that were executing at the time
              of reset.<o:p></o:p></span></p>
          <p class="MsoNormal" style="text-align:left" align="left"><span
style="font-size:12.0pt;font-family:&quot;Calibri&quot;,sans-serif"
              lang="EN-US"><o:p> </o:p></span></p>
          <p><span style="font-size:12.0pt;color:black" lang="EN-US">On
              whether the whole context is marked as guilty from a user
              space perspective, it would simply be nice for user space
              to get consistent answers. It would be a bit odd if we
              could e.g. succeed in submitting an SDMA job after a GFX
              job was rejected. This would point in favor of marking the
              entire context as guilty (although that could happen
              lazily instead of at reset time). On the other hand, if
              that's too big a burden for the kernel implementation I'm
              sure we can live without it.<o:p></o:p></span></p>
          <p><span style="font-size:12.0pt;color:black" lang="EN-US"><o:p> </o:p></span></p>
          <p><span style="font-size:12.0pt;color:black" lang="EN-US">Cheers,<o:p></o:p></span></p>
          <p><span style="font-size:12.0pt;color:black" lang="EN-US">Nicolai<o:p></o:p></span></p>
        </div>
        <div class="MsoNormal" style="text-align:center" align="center"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext"
            lang="EN-US">
            <hr size="3" align="center" width="98%">
          </span></div>
        <div id="divRplyFwdMsg">
          <p class="MsoNormal" style="text-align:left" align="left"><b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                lang="EN-US">From:</span></b><span
              style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
              lang="EN-US"> Liu, Monk<br>
              <b>Sent:</b> Wednesday, October 11, 2017 10:15:40 AM<br>
              <b>To:</b> Koenig, Christian; Haehnle, Nicolai; Olsak,
              Marek; Deucher, Alexander<br>
              <b>Cc:</b> <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
              Ding, Pixel; Jiang, Jerry (SW); Li, Bingley; Ramirez,
              Alejandro; Filipas, Mario<br>
              <b>Subject:</b> RE: TDR and VRAM lost handling in KMD:</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext"
              lang="EN-US">
              <o:p></o:p></span></p>
          <div>
            <p class="MsoNormal" style="text-align:left" align="left"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext"
                lang="EN-US"> <o:p></o:p></span></p>
          </div>
        </div>
        <div>
          <p class="MsoListParagraph"
            style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l0
            level1 lfo2">
            <!--[if !supportLists]--><span lang="EN-US"><span
                style="mso-list:Ignore">1.<span style="font:7.0pt
                  &quot;Times New Roman&quot;">       
                </span></span></span><!--[endif]--><span lang="EN-US">Set
              its fence error status to “<b>ETIME</b>”,<o:p></o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">No,
              as I already explained ETIME is for synchronous operation.<br>
              <br>
              In other words when we return ETIME from the wait IOCTL it
              would mean that the waiting has somehow timed out, but not
              the job we waited for.<br>
              <br>
              Please use ECANCELED as well or some other error code when
              we find that we need to distinct the timedout job from the
              canceled ones (probably a good idea, but I'm not sure).<o:p></o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">[ML]
              I</span><span style="font-size:12.0pt;font-family:SimSun">’<span
                lang="EN-US">m okay if you insist not to use ETIME<o:p></o:p></span></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoListParagraph"
            style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l4
            level1 lfo4">
            <!--[if !supportLists]--><span lang="EN-US"><span
                style="mso-list:Ignore">1.<span style="font:7.0pt
                  &quot;Times New Roman&quot;">       
                </span></span></span><!--[endif]--><span lang="EN-US">Find
              the entity/ctx behind this job, and set this ctx as “<b>guilty</b>”<o:p></o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">Not
              sure. Do we want to set the whole context as guilty or
              just the entity?<br>
              <br>
              Setting the whole contexts as guilty sounds racy to me.<br>
              <br>
              BTW: We should use a different name than "guilty", maybe
              just "bool canceled;" ?<o:p></o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">[ML]
              I think context is better than entity, because for example
              if you only block entity_0 of context and allow entity_N
              run, that means the dependency between entities are broken
              (e.g. page table updates in <o:p></o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">Sdma
              entity pass but gfx submit in GFX entity blocked, not make
              sense to me)<o:p></o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">We</span><span
              style="font-size:12.0pt;font-family:SimSun">’<span
                lang="EN-US">d better either block the whole context or
                let not</span>…
              <span lang="EN-US"><o:p></o:p></span></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoListParagraph"
            style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l1
            level1 lfo6">
            <!--[if !supportLists]--><span lang="EN-US"><span
                style="mso-list:Ignore">1.<span style="font:7.0pt
                  &quot;Times New Roman&quot;">       
                </span></span></span><!--[endif]--><span lang="EN-US">Kick
              out all jobs in this “guilty” ctx’s KFIFO queue, and set
              all their fence status to “<b>ECANCELED</b>”<o:p></o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">Setting
              ECANCELED should be ok. But I think we should do this when
              we try to run the jobs and not during GPU reset.<o:p></o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">[ML]
              without deep thought and expritment, I</span><span
              style="font-size:12.0pt;font-family:SimSun">’<span
                lang="EN-US">m not sure the difference between them, but
                kick it out in gpu_reset routine is more efficient, <o:p></o:p></span></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">Otherwise
              you need to check context/entity guilty flag in run_job
              routine
            </span><span style="font-size:12.0pt;font-family:SimSun">…<span
                lang="EN-US"> and you need to it for every
                context/entity, I don</span>’<span lang="EN-US">t see
                why
                <o:p></o:p></span></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">We
              don</span><span
              style="font-size:12.0pt;font-family:SimSun">’<span
                lang="EN-US">t just kickout all of them in gpu_reset
                stage
              </span>…<span lang="EN-US">.<o:p></o:p></span></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoListParagraph"
            style="margin-left:42.0pt;text-indent:-21.0pt;mso-list:l3
            level2 lfo8">
            <!--[if !supportLists]--><span lang="EN-US"><span
                style="mso-list:Ignore">a)<span style="font:7.0pt
                  &quot;Times New Roman&quot;">      
                </span></span></span><!--[endif]--><span lang="EN-US">Iterate
              over all living ctx, and set all ctx as “<b>guilty</b>”
              since VRAM lost actually ruins all VRAM contents<o:p></o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">No,
              that shouldn't be done by comparing the counters.
              Iterating over all contexts is way to much overhead.<o:p></o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">[ML]
              because I want to make KMS IOCTL rules clean, like they
              don</span><span
              style="font-size:12.0pt;font-family:SimSun">’<span
                lang="EN-US">t need to differentiate VRAM lost or not,
                they only interested in if the context is guilty or not,
                and block<o:p></o:p></span></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">Submit
              for guilty ones.
              <o:p></o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoNormal"><b><span
                style="font-size:12.0pt;font-family:SimSun" lang="EN-US">Can
                you give more details of your idea? And better the
                detail implement in cs_submit, I want to see how you
                want to block submit without checking context guilty
                flag<o:p></o:p></span></b></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoListParagraph"
            style="margin-left:42.0pt;text-indent:-21.0pt;mso-list:l5
            level2 lfo10">
            <!--[if !supportLists]--><span lang="EN-US"><span
                style="mso-list:Ignore">a)<span style="font:7.0pt
                  &quot;Times New Roman&quot;">      
                </span></span></span><!--[endif]--><span lang="EN-US">Kick
              out all jobs in all ctx’s KFIFO queue, and set all their
              fence status to “<b>ECANCELDED</b>”<o:p></o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">Yes
              and no, that should be done when we try to run the jobs
              and not during GPU reset.<o:p></o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">[ML]
              again, kicking out them in gpu reset routine is high
              efficient, otherwise you need check on every job in
              run_job()<o:p></o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">Besides,
              can you illustrate the detail implementation ?<o:p></o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">Yes
              and no, dma_fence_get_status() is some specific handling
              for sync_file debugging (no idea why that made it into the
              common fence code).<br>
              <br>
              It was replaced by putting the error code directly into
              the fence, so just reading that one after waiting should
              be ok.<br>
              <br>
              Maybe we should fix dma_fence_get_status() to do the right
              thing for this?<o:p></o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">[ML]
              yeah, that</span><span
              style="font-size:12.0pt;font-family:SimSun">’<span
                lang="EN-US">s too confusing, the name sound really the
                one I want to use, we should change it</span>…<span
                lang="EN-US"><o:p></o:p></span></span></p>
          <p class="MsoNormal"><b><span
                style="font-size:12.0pt;font-family:SimSun" lang="EN-US">But
                look into the implement, I don</span></b><b><span
                style="font-size:12.0pt;font-family:SimSun">’<span
                  lang="EN-US">t see why we cannot use it ? it also
                  finally return the fence-&gt;error <o:p></o:p></span></span></b></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span style="color:windowtext"
              lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span style="color:windowtext"
              lang="EN-US"><o:p> </o:p></span></p>
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0cm 0cm 0cm">
              <p class="MsoNormal" style="text-align:left" align="left"><b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext"
                    lang="EN-US">From:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext"
                  lang="EN-US"> Koenig, Christian <br>
                  <b>Sent:</b> Wednesday, October 11, 2017 3:21 PM<br>
                  <b>To:</b> Liu, Monk &lt;<a
                    href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">Monk.Liu-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                  Haehnle, Nicolai &lt;<a
                    href="mailto:Nicolai.Haehnle-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">Nicolai.Haehnle-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                  Olsak, Marek &lt;<a href="mailto:Marek.Olsak-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">Marek.Olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                  Deucher, Alexander &lt;<a
                    href="mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
                  <b>Cc:</b> <a
                    href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                    moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
                  Ding, Pixel &lt;<a href="mailto:Pixel.Ding-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">Pixel.Ding-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                  Jiang, Jerry (SW) &lt;<a
                    href="mailto:Jerry.Jiang-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">Jerry.Jiang-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                  Li, Bingley &lt;<a href="mailto:Bingley.Li-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">Bingley.Li-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                  Ramirez, Alejandro &lt;<a
                    href="mailto:Alejandro.Ramirez-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">Alejandro.Ramirez-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                  Filipas, Mario &lt;<a
                    href="mailto:Mario.Filipas-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">Mario.Filipas-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
                  <b>Subject:</b> Re: TDR and VRAM lost handling in KMD:<o:p></o:p></span></p>
            </div>
          </div>
          <p class="MsoNormal" style="text-align:left" align="left"><span
              lang="EN-US"><o:p> </o:p></span></p>
          <div>
            <p class="MsoNormal" style="text-align:left" align="left"><span
                lang="EN-US">See inline:<br>
                <br>
                Am 11.10.2017 um 07:33 schrieb Liu, Monk:</span><span
                style="font-size:12.0pt" lang="EN-US"><o:p></o:p></span></p>
          </div>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoNormal"><span lang="EN-US">Hi Christian &amp;
                Nicolai,<o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US">We need to achieve
                some agreements on what should MESA/UMD do and what
                should KMD do,
                <b>please give your comments with “okay” or “No” and
                  your idea on below items,</b><o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
            <p class="MsoListParagraph"
              style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l2
              level1 lfo12">
              <!--[if !supportLists]--><span
                style="font-family:Wingdings" lang="EN-US"><span
                  style="mso-list:Ignore">?<span style="font:7.0pt
                    &quot;Times New Roman&quot;"> 
                  </span></span></span><!--[endif]--><span lang="EN-US">When
                a job timed out (set from lockup_timeout kernel
                parameter), What KMD should do in TDR routine :<o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
            <p class="MsoListParagraph"
              style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l6
              level1 lfo14">
              <!--[if !supportLists]--><span lang="EN-US"><span
                  style="mso-list:Ignore">1.<span style="font:7.0pt
                    &quot;Times New Roman&quot;">       
                  </span></span></span><!--[endif]--><span lang="EN-US">Update
                adev-&gt;<b>gpu_reset_counter</b>, and stop scheduler
                first, (<b>gpu_reset_counter</b> is used to force vm
                flush after GPU reset, out of this thread’s scope so no
                more discussion on it)<o:p></o:p></span></p>
          </blockquote>
          <p class="MsoNormal"
            style="margin-bottom:12.0pt;text-align:left" align="left"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">Okay.<br>
              <br>
              <o:p></o:p></span></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoListParagraph"
              style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l6
              level1 lfo14">
              <!--[if !supportLists]--><span lang="EN-US"><span
                  style="mso-list:Ignore">2.<span style="font:7.0pt
                    &quot;Times New Roman&quot;">       
                  </span></span></span><!--[endif]--><span lang="EN-US">Set
                its fence error status to “<b>ETIME</b>”,<o:p></o:p></span></p>
          </blockquote>
          <p class="MsoNormal"
            style="margin-bottom:12.0pt;text-align:left" align="left"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">No,
              as I already explained ETIME is for synchronous operation.<br>
              <br>
              In other words when we return ETIME from the wait IOCTL it
              would mean that the waiting has somehow timed out, but not
              the job we waited for.<br>
              <br>
              Please use ECANCELED as well or some other error code when
              we find that we need to distinct the timedout job from the
              canceled ones (probably a good idea, but I'm not sure).<br>
              <br>
              <o:p></o:p></span></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoListParagraph"
              style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l6
              level1 lfo14">
              <!--[if !supportLists]--><span lang="EN-US"><span
                  style="mso-list:Ignore">3.<span style="font:7.0pt
                    &quot;Times New Roman&quot;">       
                  </span></span></span><!--[endif]--><span lang="EN-US">Find
                the entity/ctx behind this job, and set this ctx as “<b>guilty</b>”<o:p></o:p></span></p>
          </blockquote>
          <p class="MsoNormal"
            style="margin-bottom:12.0pt;text-align:left" align="left"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">Not
              sure. Do we want to set the whole context as guilty or
              just the entity?<br>
              <br>
              Setting the whole contexts as guilty sounds racy to me.<br>
              <br>
              BTW: We should use a different name than "guilty", maybe
              just "bool canceled;" ?<br>
              <br>
              <o:p></o:p></span></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoListParagraph"
              style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l6
              level1 lfo14">
              <!--[if !supportLists]--><span lang="EN-US"><span
                  style="mso-list:Ignore">4.<span style="font:7.0pt
                    &quot;Times New Roman&quot;">       
                  </span></span></span><!--[endif]--><span lang="EN-US">Kick
                out this job from scheduler’s mirror list, so this job
                won’t get re-scheduled to ring anymore.<o:p></o:p></span></p>
          </blockquote>
          <p class="MsoNormal"
            style="margin-bottom:12.0pt;text-align:left" align="left"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">Okay.<br>
              <br>
              <o:p></o:p></span></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoListParagraph"
              style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l6
              level1 lfo14">
              <!--[if !supportLists]--><span lang="EN-US"><span
                  style="mso-list:Ignore">5.<span style="font:7.0pt
                    &quot;Times New Roman&quot;">       
                  </span></span></span><!--[endif]--><span lang="EN-US">Kick
                out all jobs in this “guilty” ctx’s KFIFO queue, and set
                all their fence status to “<b>ECANCELED</b>”<o:p></o:p></span></p>
          </blockquote>
          <p class="MsoNormal"
            style="margin-bottom:12.0pt;text-align:left" align="left"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">Setting
              ECANCELED should be ok. But I think we should do this when
              we try to run the jobs and not during GPU reset.<br>
              <br>
              <o:p></o:p></span></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoListParagraph"
              style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l6
              level1 lfo14">
              <!--[if !supportLists]--><span lang="EN-US"><span
                  style="mso-list:Ignore">6.<span style="font:7.0pt
                    &quot;Times New Roman&quot;">       
                  </span></span></span><!--[endif]--><span lang="EN-US">Force
                signal all fences that get kicked out by above two
                steps,<b> otherwise UMD will block forever if waiting on
                  those fences</b><o:p></o:p></span></p>
          </blockquote>
          <p class="MsoNormal"
            style="margin-bottom:12.0pt;text-align:left" align="left"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">Okay.<br>
              <br>
              <o:p></o:p></span></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoListParagraph"
              style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l6
              level1 lfo14">
              <!--[if !supportLists]--><span lang="EN-US"><span
                  style="mso-list:Ignore">7.<span style="font:7.0pt
                    &quot;Times New Roman&quot;">       
                  </span></span></span><!--[endif]--><span lang="EN-US">Do
                gpu reset, which is can be some callbacks to let
                bare-metal and SR-IOV implement with their favor style
                <o:p></o:p></span></p>
          </blockquote>
          <p class="MsoNormal"
            style="margin-bottom:12.0pt;text-align:left" align="left"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">Okay.<br>
              <br>
              <o:p></o:p></span></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoListParagraph"
              style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l6
              level1 lfo14">
              <!--[if !supportLists]--><span lang="EN-US"><span
                  style="mso-list:Ignore">8.<span style="font:7.0pt
                    &quot;Times New Roman&quot;">       
                  </span></span></span><!--[endif]--><span lang="EN-US">After
                reset, KMD need to aware if the VRAM lost happens or
                not, bare-metal can implement some function to judge,
                while for SR-IOV I prefer to read it from GIM side (for
                initial version we consider it’s always VRAM lost, till
                GIM side change aligned)<o:p></o:p></span></p>
          </blockquote>
          <p class="MsoNormal"
            style="margin-bottom:12.0pt;text-align:left" align="left"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">Okay.<br>
              <br>
              <o:p></o:p></span></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoListParagraph"
              style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l6
              level1 lfo14">
              <!--[if !supportLists]--><span lang="EN-US"><span
                  style="mso-list:Ignore">9.<span style="font:7.0pt
                    &quot;Times New Roman&quot;">       
                  </span></span></span><!--[endif]--><span lang="EN-US">If
                VRAM lost not hit, continue, otherwise:<o:p></o:p></span></p>
            <p class="MsoListParagraph"
              style="margin-left:42.0pt;text-indent:-21.0pt;mso-list:l6
              level2 lfo14">
              <!--[if !supportLists]--><span lang="EN-US"><span
                  style="mso-list:Ignore">a)<span style="font:7.0pt
                    &quot;Times New Roman&quot;">      
                  </span></span></span><!--[endif]--><span lang="EN-US">Update
                adev-&gt;<b>vram_lost_counter</b>,<o:p></o:p></span></p>
          </blockquote>
          <p class="MsoNormal"
            style="margin-bottom:12.0pt;text-align:left" align="left"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">Okay.<br>
              <br>
              <o:p></o:p></span></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoListParagraph"
              style="margin-left:42.0pt;text-indent:-21.0pt;mso-list:l6
              level2 lfo14">
              <!--[if !supportLists]--><span lang="EN-US"><span
                  style="mso-list:Ignore">b)<span style="font:7.0pt
                    &quot;Times New Roman&quot;">      
                  </span></span></span><!--[endif]--><span lang="EN-US">Iterate
                over all living ctx, and set all ctx as “<b>guilty</b>”
                since VRAM lost actually ruins all VRAM contents<o:p></o:p></span></p>
          </blockquote>
          <p class="MsoNormal"
            style="margin-bottom:12.0pt;text-align:left" align="left"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">No,
              that shouldn't be done by comparing the counters.
              Iterating over all contexts is way to much overhead.<br>
              <br>
              <o:p></o:p></span></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoListParagraph"
              style="margin-left:42.0pt;text-indent:-21.0pt;mso-list:l6
              level2 lfo14">
              <!--[if !supportLists]--><span lang="EN-US"><span
                  style="mso-list:Ignore">c)<span style="font:7.0pt
                    &quot;Times New Roman&quot;">       
                  </span></span></span><!--[endif]--><span lang="EN-US">Kick
                out all jobs in all ctx’s KFIFO queue, and set all their
                fence status to “<b>ECANCELDED</b>”<o:p></o:p></span></p>
          </blockquote>
          <p class="MsoNormal"
            style="margin-bottom:12.0pt;text-align:left" align="left"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">Yes
              and no, that should be done when we try to run the jobs
              and not during GPU reset.<br>
              <br>
              <o:p></o:p></span></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoListParagraph"
              style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l6
              level1 lfo14">
              <!--[if !supportLists]--><span lang="EN-US"><span
                  style="mso-list:Ignore">10.<span style="font:7.0pt
                    &quot;Times New Roman&quot;">    
                  </span></span></span><!--[endif]--><span lang="EN-US">Do
                GTT recovery and VRAM page tables/entries recovery
                (optional, do we need it ???)<o:p></o:p></span></p>
          </blockquote>
          <p class="MsoNormal"
            style="margin-bottom:12.0pt;text-align:left" align="left"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">Yes,
              that is still needed. As Nicolai explained we can't be
              sure that VRAM is still 100% correct even when it isn't
              cleared.<br>
              <br>
              <o:p></o:p></span></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoListParagraph"
              style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l6
              level1 lfo14">
              <!--[if !supportLists]--><span lang="EN-US"><span
                  style="mso-list:Ignore">11.<span style="font:7.0pt
                    &quot;Times New Roman&quot;">    
                  </span></span></span><!--[endif]--><span lang="EN-US">Re-schedule
                all JOBs remains in mirror list to ring again and
                restart scheduler (for VRAM lost case, no JOB will
                re-scheduled)<o:p></o:p></span></p>
          </blockquote>
          <p class="MsoNormal"
            style="margin-bottom:12.0pt;text-align:left" align="left"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">Okay.<br>
              <br>
              <o:p></o:p></span></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
            <p class="MsoListParagraph"
              style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l2
              level1 lfo12">
              <!--[if !supportLists]--><span
                style="font-family:Wingdings" lang="EN-US"><span
                  style="mso-list:Ignore">?<span style="font:7.0pt
                    &quot;Times New Roman&quot;"> 
                  </span></span></span><!--[endif]--><span lang="EN-US">For
                cs_wait() IOCTL:<o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US">After it found fence
                signaled, it should check with
                <b>“dma_fence_get_status” </b>to see if there is error
                there,<o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US">And return the error
                status of fence<o:p></o:p></span></p>
          </blockquote>
          <p class="MsoNormal"
            style="margin-bottom:12.0pt;text-align:left" align="left"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">Yes
              and no, dma_fence_get_status() is some specific handling
              for sync_file debugging (no idea why that made it into the
              common fence code).<br>
              <br>
              It was replaced by putting the error code directly into
              the fence, so just reading that one after waiting should
              be ok.<br>
              <br>
              Maybe we should fix dma_fence_get_status() to do the right
              thing for this?<br>
              <br>
              <o:p></o:p></span></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
            <p class="MsoListParagraph"
              style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l2
              level1 lfo12">
              <!--[if !supportLists]--><span
                style="font-family:Wingdings" lang="EN-US"><span
                  style="mso-list:Ignore">?<span style="font:7.0pt
                    &quot;Times New Roman&quot;"> 
                  </span></span></span><!--[endif]--><span lang="EN-US">For
                cs_wait_fences() IOCTL:<o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US">Similar with above
                approach<o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
            <p class="MsoListParagraph"
              style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l2
              level1 lfo12">
              <!--[if !supportLists]--><span
                style="font-family:Wingdings" lang="EN-US"><span
                  style="mso-list:Ignore">?<span style="font:7.0pt
                    &quot;Times New Roman&quot;"> 
                  </span></span></span><!--[endif]--><span lang="EN-US">For
                cs_submit() IOCTL:<o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US">It need to check if
                current ctx been marked as “<b>guilty</b>” and return “<b>ECANCELED</b>”
                if so<o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
            <p class="MsoListParagraph"
              style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l2
              level1 lfo12">
              <!--[if !supportLists]--><span
                style="font-family:Wingdings" lang="EN-US"><span
                  style="mso-list:Ignore">?<span style="font:7.0pt
                    &quot;Times New Roman&quot;"> 
                  </span></span></span><!--[endif]--><span lang="EN-US">Introduce
                a new IOCTL to let UMD query
                <b>vram_lost_counter</b>:<o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US">This way, UMD can
                also block app from submitting, like @Nicolai mentioned,
                we can cache one copy of
                <b>vram_lost_counter</b> when enumerate physical device,
                and deny all <o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US">gl-context from
                submitting if the counter queried bigger than that one
                cached in physical device. (looks a little overkill to
                me, but easy to implement )
                <o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US">UMD can also return
                error to APP when creating gl-context if found current
                queried<b> vram_lost_counter
                </b>bigger than that one cached in physical device.<o:p></o:p></span></p>
          </blockquote>
          <p class="MsoNormal"
            style="margin-bottom:12.0pt;text-align:left" align="left"><span
              style="font-size:12.0pt;font-family:SimSun" lang="EN-US">Okay.
              Already have a patch for this, please review that one if
              you haven't already done so.<br>
              <br>
              Regards,<br>
              Christian.<br>
              <br>
              <o:p></o:p></span></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US">BTW: I realized that
                gl-context is a little different with kernel’s context.
                Because for kernel. BO is not related with context but
                only with FD, while in UMD, BO have a backend<o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US">gl-context, so block
                submitting in UMD layer is also needed although KMD will
                do its job as bottom line
                <o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
            <p class="MsoListParagraph"
              style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l2
              level1 lfo12">
              <!--[if !supportLists]--><span
                style="font-family:Wingdings" lang="EN-US"><span
                  style="mso-list:Ignore">?<span style="font:7.0pt
                    &quot;Times New Roman&quot;"> 
                  </span></span></span><!--[endif]--><span lang="EN-US">Basically
                “vram_lost_counter” is exposure by kernel to let UMD
                take the control of robust extension feature, it will be
                UMD’s call to move, KMD only deny “guilty” context from
                submitting<o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US">Need your feedback,
                thx<o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US">We’d better make TDR
                feature landed ASAP<o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US">BR Monk<o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
          </blockquote>
          <p><span lang="EN-US"><o:p> </o:p></span></p>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------43102E1E54431C52DCB882A3--

--===============0120759384==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0120759384==--
