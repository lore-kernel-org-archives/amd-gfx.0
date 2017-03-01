From: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Add support for high priority scheduling in amdgpu
Date: Wed, 1 Mar 2017 12:13:47 -0500
Message-ID: <ddeb4a53-ec4f-9a87-9323-897c571b1634@gmail.com>
References: <1488320089-22035-1-git-send-email-andresx7@gmail.com>
 <25194b1a-4756-e1ad-f597-17063a14eb4c@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0239279643=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <25194b1a-4756-e1ad-f597-17063a14eb4c-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============0239279643==
Content-Type: multipart/alternative;
 boundary="------------586716D98F2902224FE48FDA"

This is a multi-part message in MIME format.
--------------586716D98F2902224FE48FDA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/1/2017 6:42 AM, Christian König wrote:
> Patches #1-#14 are Acked-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>.
>
> Patch #15:
>
> Not sure if that is a good idea or not, need to take a closer look 
> after digging through the rest.
>
> In general the HW IP is just for the IOCTL API and not for internal 
> use inside the driver.
I'll drop this patch and use ring->funcs->type instead.
>
> Patch #16:
>
> Really nice :) I don't have time to look into it in detail, but you 
> have one misconception I like to point out:
>> The queue manager maintains a per-file descriptor map of user ring ids
>> to amdgpu_ring pointers. Once a map is created it is permanent (this is
>> required to maintain FIFO execution guarantees for a ring).
> Actually we don't have a FIFO execution guarantee per ring. We only 
> have that per context.

Agreed. I'm using pretty imprecise terminology here which can be 
confusing. I wanted to be more precise than "context", because two 
amdgpu_cs_request submissions to the same context but with a different 
ring field can execute out of order.

I think s/ring/context's ring/ should be enough to clarify here if you 
think so as well.

>
> E.g. commands from different context can execute at the same time and 
> out of order.
>
> Making this per file is ok for now, but you should keep in mind that 
> we might want to change that sooner or later.
>
> Patch #17 & #18 need to take a closer look when I have more time, but 
> the comments from others sounded valid to me as well.
>
> Patch #19: Raising and lowering the priority of a ring during command 
> submission doesn't sound like a good idea to me.
I'm not really sure what would be a better time than at command submission.

If it was just SPI priorities we could have static partitioning of 
rings, some high priority and some regular, etc. But that approach 
reduces the number of rings
>
> The way you currently have it implemented would also raise the 
> priority of already running jobs on the same ring. Keep in mind that 
> everything is pipelined here.
That is actually intentional. If there is work already on the ring with 
lower priority we don't want the high priority work to have to wait for 
it to finish executing at regular priority. Therefore the work that has 
already been commited to the ring inherits the higher priority level.

I agree this isn't ideal, which is why the LRU ring mapping policy is 
there to make sure this doesn't happen often.
>
> Additional to that you can't have a fence callback in the job 
> structure, cause the job structure is freed by the same fence as well. 
> So it can happen that you access freed up memory (but only for a very 
> short period of time).
Any strong preference for either 1) refcounting the job structure, or 2) 
allocating a new piece of memory to store the callback parameters?

> Patches #20-#22 are Acked-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>.
>
> Regards,
> Christian.
>
> Am 28.02.2017 um 23:14 schrieb Andres Rodriguez:
>> This patch series introduces a mechanism that allows users with 
>> sufficient
>> privileges to categorize their work as "high priority". A userspace 
>> app can
>> create a high priority amdgpu context, where any work submitted to 
>> this context
>> will receive preferential treatment over any other work.
>>
>> High priority contexts will be scheduled ahead of other contexts by 
>> the sw gpu
>> scheduler. This functionality is generic for all HW blocks.
>>
>> Optionally, a ring can implement a set_priority() function that allows
>> programming HW specific features to elevate a ring's priority.
>>
>> This patch series implements set_priority() for gfx8 compute rings. 
>> It takes
>> advantage of SPI scheduling and CU reservation to provide improved frame
>> latencies for high priority contexts.
>>
>> For compute + compute scenarios we get near perfect scheduling 
>> latency. E.g.
>> one high priority ComputeParticles + one low priority ComputeParticles:
>>      - High priority ComputeParticles: 2.0-2.6 ms/frame
>>      - Regular ComputeParticles: 35.2-68.5 ms/frame
>>
>> For compute + gfx scenarios the high priority compute application does
>> experience some latency variance. However, the variance has smaller 
>> bounds and
>> a smalled deviation then without high priority scheduling.
>>
>> Following is a graph of the frame time experienced by a high priority 
>> compute
>> app in 4 different scenarios to exemplify the compute + gfx latency 
>> variance:
>>      - ComputeParticles: this scenario invloves running the compute 
>> particles
>>        sample on its own.
>>      - +SSAO: Previous scenario with the addition of running the ssao 
>> sample
>>        application that clogs the GFX ring with constant work.
>>      - +SPI Priority: Previous scenario with the addition of SPI 
>> priority
>>        programming for compute rings.
>>      - +CU Reserve: Previous scenario with the addition of dynamic CU
>>        reservation for compute rings.
>>
>> Graph link:
>> https://plot.ly/~lostgoat/9/
>>
>> As seen above, high priority contexts for compute allow us to 
>> schedule work
>> with enhanced confidence of completion latency under high GPU loads. 
>> This
>> property will be important for VR reprojection workloads.
>>
>> Note: The first part of this series is a resend of "Change queue/pipe 
>> split
>> between amdkfd and amdgpu" with the following changes:
>>      - Fixed kfdtest on Kaveri due to shift overflow. Refer to: 
>> "drm/amdkfdallow
>>        split HQD on per-queue granularity v3"
>>      - Used Felix's suggestions for a simplified HQD programming 
>> sequence
>>      - Added a workaround for a Tonga HW bug during HQD programming
>>
>> This series is also available at:
>> https://github.com/lostgoat/linux/tree/wip-high-priority
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>


--------------586716D98F2902224FE48FDA
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 3/1/2017 6:42 AM, Christian König
      wrote:<br>
    </div>
    <blockquote
      cite="mid:25194b1a-4756-e1ad-f597-17063a14eb4c-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
      type="cite">Patches #1-#14 are Acked-by: Christian König <a
        class="moz-txt-link-rfc2396E"
        href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>.
      <br>
      <br>
      Patch #15: <br>
      <br>
      Not sure if that is a good idea or not, need to take a closer look
      after digging through the rest. <br>
      <br>
      In general the HW IP is just for the IOCTL API and not for
      internal use inside the driver. <br>
    </blockquote>
    I'll drop this patch and use ring-&gt;funcs-&gt;type instead.<br>
    <blockquote
      cite="mid:25194b1a-4756-e1ad-f597-17063a14eb4c-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
      type="cite"> <br>
      Patch #16: <br>
      <br>
      Really nice :) I don't have time to look into it in detail, but
      you have one misconception I like to point out: <br>
      <blockquote type="cite">The queue manager maintains a per-file
        descriptor map of user ring ids <br>
        to amdgpu_ring pointers. Once a map is created it is permanent
        (this is <br>
        required to maintain FIFO execution guarantees for a ring). <br>
      </blockquote>
      Actually we don't have a FIFO execution guarantee per ring. We
      only have that per context. <br>
    </blockquote>
    <br>
    Agreed. I'm using pretty imprecise terminology here which can be
    confusing. I wanted to be more precise than "context", because two
    amdgpu_cs_request submissions to the same context but with a
    different ring field can execute out of order.<br>
    <br>
    I think s/ring/context's ring/ should be enough to clarify here if
    you think so as well.<br>
    <br>
    <blockquote
      cite="mid:25194b1a-4756-e1ad-f597-17063a14eb4c-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
      type="cite"> <br>
      E.g. commands from different context can execute at the same time
      and out of order. <br>
      <br>
      Making this per file is ok for now, but you should keep in mind
      that we might want to change that sooner or later. <br>
      <br>
      Patch #17 &amp; #18 need to take a closer look when I have more
      time, but the comments from others sounded valid to me as well. <br>
      <br>
      Patch #19: Raising and lowering the priority of a ring during
      command submission doesn't sound like a good idea to me. <br>
    </blockquote>
    I'm not really sure what would be a better time than at command
    submission.<br>
    <br>
    If it was just SPI priorities we could have static partitioning of
    rings, some high priority and some regular, etc. But that approach
    reduces the number of rings<br>
    <blockquote
      cite="mid:25194b1a-4756-e1ad-f597-17063a14eb4c-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
      type="cite"> <br>
      The way you currently have it implemented would also raise the
      priority of already running jobs on the same ring. Keep in mind
      that everything is pipelined here. <br>
    </blockquote>
    That is actually intentional. If there is work already on the ring
    with lower priority we don't want the high priority work to have to
    wait for it to finish executing at regular priority. Therefore the
    work that has already been commited to the ring inherits the higher
    priority level.<br>
    <br>
    I agree this isn't ideal, which is why the LRU ring mapping policy
    is there to make sure this doesn't happen often.<br>
    <blockquote
      cite="mid:25194b1a-4756-e1ad-f597-17063a14eb4c-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
      type="cite"> <br>
      Additional to that you can't have a fence callback in the job
      structure, cause the job structure is freed by the same fence as
      well. So it can happen that you access freed up memory (but only
      for a very short period of time). <br>
    </blockquote>
    Any strong preference for either 1) refcounting the job structure,
    or 2) allocating a new piece of memory to store the callback
    parameters?<br>
    <br>
    <blockquote
      cite="mid:25194b1a-4756-e1ad-f597-17063a14eb4c-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
      type="cite"> Patches #20-#22 are Acked-by: Christian König <a
        class="moz-txt-link-rfc2396E"
        href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>.
      <br>
      <br>
      Regards, <br>
      Christian. <br>
      <br>
      Am 28.02.2017 um 23:14 schrieb Andres Rodriguez: <br>
      <blockquote type="cite">This patch series introduces a mechanism
        that allows users with sufficient <br>
        privileges to categorize their work as "high priority". A
        userspace app can <br>
        create a high priority amdgpu context, where any work submitted
        to this context <br>
        will receive preferential treatment over any other work. <br>
        <br>
        High priority contexts will be scheduled ahead of other contexts
        by the sw gpu <br>
        scheduler. This functionality is generic for all HW blocks. <br>
        <br>
        Optionally, a ring can implement a set_priority() function that
        allows <br>
        programming HW specific features to elevate a ring's priority. <br>
        <br>
        This patch series implements set_priority() for gfx8 compute
        rings. It takes <br>
        advantage of SPI scheduling and CU reservation to provide
        improved frame <br>
        latencies for high priority contexts. <br>
        <br>
        For compute + compute scenarios we get near perfect scheduling
        latency. E.g. <br>
        one high priority ComputeParticles + one low priority
        ComputeParticles: <br>
             - High priority ComputeParticles: 2.0-2.6 ms/frame <br>
             - Regular ComputeParticles: 35.2-68.5 ms/frame <br>
        <br>
        For compute + gfx scenarios the high priority compute
        application does <br>
        experience some latency variance. However, the variance has
        smaller bounds and <br>
        a smalled deviation then without high priority scheduling. <br>
        <br>
        Following is a graph of the frame time experienced by a high
        priority compute <br>
        app in 4 different scenarios to exemplify the compute + gfx
        latency variance: <br>
             - ComputeParticles: this scenario invloves running the
        compute particles <br>
               sample on its own. <br>
             - +SSAO: Previous scenario with the addition of running the
        ssao sample <br>
               application that clogs the GFX ring with constant work. <br>
             - +SPI Priority: Previous scenario with the addition of SPI
        priority <br>
               programming for compute rings. <br>
             - +CU Reserve: Previous scenario with the addition of
        dynamic CU <br>
               reservation for compute rings. <br>
        <br>
        Graph link: <br>
        <a class="moz-txt-link-freetext"
          href="https://plot.ly/%7Elostgoat/9/">https://plot.ly/~lostgoat/9/</a>
        <br>
        <br>
        As seen above, high priority contexts for compute allow us to
        schedule work <br>
        with enhanced confidence of completion latency under high GPU
        loads. This <br>
        property will be important for VR reprojection workloads. <br>
        <br>
        Note: The first part of this series is a resend of "Change
        queue/pipe split <br>
        between amdkfd and amdgpu" with the following changes: <br>
             - Fixed kfdtest on Kaveri due to shift overflow. Refer to:
        "drm/amdkfdallow <br>
               split HQD on per-queue granularity v3" <br>
             - Used Felix's suggestions for a simplified HQD programming
        sequence <br>
             - Added a workaround for a Tonga HW bug during HQD
        programming <br>
        <br>
        This series is also available at: <br>
        <a class="moz-txt-link-freetext"
          href="https://github.com/lostgoat/linux/tree/wip-high-priority">https://github.com/lostgoat/linux/tree/wip-high-priority</a>
        <br>
        <br>
        _______________________________________________ <br>
        amd-gfx mailing list <br>
        <a class="moz-txt-link-abbreviated"
          href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
        <br>
        <a class="moz-txt-link-freetext"
          href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
        <br>
      </blockquote>
      <br>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------586716D98F2902224FE48FDA--

--===============0239279643==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0239279643==--
