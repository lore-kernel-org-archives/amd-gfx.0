From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/5] drm/amdgpu: Refactor GPU reset for XGMI hive case.
Date: Mon, 26 Nov 2018 20:34:12 +0100
Message-ID: <8926e597-03dc-a4cf-c18a-31eed3084e14@gmail.com>
References: <1542823821-15631-1-git-send-email-andrey.grodzovsky@amd.com>
 <1542823821-15631-6-git-send-email-andrey.grodzovsky@amd.com>
 <ef758cf9-9e27-9807-4e25-47148782249e@amd.com>
 <5f257299-4833-82b7-83ec-75bf02c4e441@amd.com>
 <8e9f51a4-7f0a-c435-c507-34eea96e0b08@gmail.com>
 <9e016b33-6c94-b1cb-cdcd-b68b91436e90@amd.com>
 <0f048ac9-1247-8d87-d8c8-5a249e24cdcb@gmail.com>
 <329e176f-ab36-fc79-8646-484975ebb8c3@amd.com>
 <71b1c9db-68ec-d4bf-d125-1aed69769fc1@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0490957686=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <71b1c9db-68ec-d4bf-d125-1aed69769fc1-5C7GfCeVMHo@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Liu,
 Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============0490957686==
Content-Type: multipart/alternative;
 boundary="------------D7241465BCCF1FB2EBAC27BA"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------D7241465BCCF1FB2EBAC27BA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

> What I mean is - should we get rid of dma_fence_add/remove_callback 
> logic in drm_sched_job_timedout and do it for each driver in between
>
> scheduler deactivation  and activation back ?
>

Yes, exactly. That's the reason why I already have a revert for the 
patch and remove the dance from drm_sched_job_timedout again.

Christian.


Am 26.11.18 um 20:28 schrieb Grodzovsky, Andrey:
>
>
> Actually, after looking again at drm_sched_job_timedout  from which 
> the amdgpu_device_gpu_recover will be called I see that we already 
> disconnect all the pending scheduler fences from the HW fence, including
> the guilty job. I also see that in drm_sched_job_timedout 
> job_list_lock is released before calling sched->ops->timedout_job and 
> then required after, so new jobs can slip into ring_mirror_list in 
> between.
>
> And also i will end up going over the ring_mirror_list twice, once 
> from amdgpu_device_post_asic_reset and later from 
> drm_sched_job_timedout - this might cause double fence processing.
>
> Isn't it more correct only do the disconnect from HW fence after the 
> schedules have been stopped and connect back before we restart the 
> schedulers (as you pointed out here before)
>
> What I mean is - should we get rid of dma_fence_add/remove_callback 
> logic in drm_sched_job_timedout and do it for each driver in between
>
> scheduler deactivation  and activation back ?
>
> Andrey
>
>
> On 11/22/2018 02:56 PM, Grodzovsky, Andrey wrote:
>>>>> Additional to that I would try improve the pre, middle, post handling
>>>>> towards checking if we made some progress in between.
>>>>>
>>>>> In other words we stop all schedulers in the pre handling and
>>>>> disconnect the scheduler fences from the hardware fence like I did in
>>>>> patch "drm/sched: fix timeout handling v2".
>>>>>
>>>>> Then before we do the actual reset in the middle handling we check if
>>>>> the offending job has completed or at least made some progress in the
>>>>> meantime.
>>>> I understand how to check if the job completed - if it's fence already
>>>> signaled, but how do I test if the job made 'at least some progress' ?
>>> Good question. Maybe we can somehow query from the hardware the number
>>> of primitives or pixels processed so far and then compare after a moment?
>> I will check on this later. In the mean while I will update the code
>> with the proposed per hive locking and I will add the check if the
>> guilty job completed before ASIC reset skipping the reset if it's did.
>>
>> Andrey
>>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------D7241465BCCF1FB2EBAC27BA
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite">
        <p>What I mean is - should we get rid of
          dma_fence_add/remove_callback logic in drm_sched_job_timedout
          and do it for each driver in between
          <br>
        </p>
        <p>scheduler deactivation  and activation back ?</p>
      </blockquote>
      <br>
      Yes, exactly. That's the reason why I already have a revert for
      the patch and remove the dance from drm_sched_job_timedout again.<br>
      <br>
      Christian.<br>
      <br>
      <br>
      Am 26.11.18 um 20:28 schrieb Grodzovsky, Andrey:<br>
    </div>
    <blockquote type="cite"
      cite="mid:71b1c9db-68ec-d4bf-d125-1aed69769fc1-5C7GfCeVMHo@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <p><br>
        Actually, after looking again at drm_sched_job_timedout  from
        which the amdgpu_device_gpu_recover will be called I see that we
        already disconnect all the pending scheduler fences from the HW
        fence, including<br>
        the guilty job. I also see that in drm_sched_job_timedout
        job_list_lock is released before calling
        sched-&gt;ops-&gt;timedout_job and then required after, so new
        jobs can slip into ring_mirror_list in between.
        <br>
      </p>
      <p>And also i will end up going over the ring_mirror_list twice,
        once from amdgpu_device_post_asic_reset and later from
        drm_sched_job_timedout - this might cause double fence
        processing.<br>
      </p>
      <p>Isn't it more correct only do the disconnect from HW fence
        after the schedules have been stopped and connect back before we
        restart the schedulers (as you pointed out here before)
        <br>
      </p>
      <p>What I mean is - should we get rid of
        dma_fence_add/remove_callback logic in drm_sched_job_timedout
        and do it for each driver in between
        <br>
      </p>
      <p>scheduler deactivation  and activation back ?</p>
      <p>Andrey<br>
      </p>
      <br>
      <div class="moz-cite-prefix">On 11/22/2018 02:56 PM, Grodzovsky,
        Andrey wrote:<br>
      </div>
      <blockquote type="cite"
        cite="mid:329e176f-ab36-fc79-8646-484975ebb8c3-5C7GfCeVMHo@public.gmane.org">
        <blockquote type="cite" style="color: #000000;">
          <blockquote type="cite" style="color: #000000;">
            <blockquote type="cite" style="color: #000000;">
              <pre wrap="">Additional to that I would try improve the pre, middle, post handling
towards checking if we made some progress in between.

In other words we stop all schedulers in the pre handling and
disconnect the scheduler fences from the hardware fence like I did in
patch "drm/sched: fix timeout handling v2".

Then before we do the actual reset in the middle handling we check if
the offending job has completed or at least made some progress in the
meantime.
</pre>
            </blockquote>
            <pre wrap="">I understand how to check if the job completed - if it's fence already
signaled, but how do I test if the job made 'at least some progress' ?
</pre>
          </blockquote>
          <pre wrap="">Good question. Maybe we can somehow query from the hardware the number 
of primitives or pixels processed so far and then compare after a moment?
</pre>
        </blockquote>
        <pre wrap="">I will check on this later. In the mean while I will update the code 
with the proposed per hive locking and I will add the check if the 
guilty job completed before ASIC reset skipping the reset if it's did.

Andrey

</pre>
      </blockquote>
      <br>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------D7241465BCCF1FB2EBAC27BA--

--===============0490957686==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0490957686==--
