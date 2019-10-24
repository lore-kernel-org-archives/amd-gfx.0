From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: guard ib scheduling while in reset
Date: Thu, 24 Oct 2019 18:30:05 +0200
Message-ID: <d573688c-0997-1928-0c56-b60a29ff7fde@gmail.com>
References: <1571914692-9430-1-git-send-email-shirish.s@amd.com>
 <23ea615d-5ef4-d0b3-a0ec-6fae67b102f2@gmail.com>
 <f3be329d-d350-c821-00b7-d94858335796@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1920156788=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f3be329d-d350-c821-00b7-d94858335796-5C7GfCeVMHo@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1920156788==
Content-Type: multipart/alternative;
 boundary="------------622BFDAF81EADBEC8F7B1A70"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------622BFDAF81EADBEC8F7B1A70
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 24.10.19 um 17:06 schrieb Grodzovsky, Andrey:
>
>
> On 10/24/19 7:01 AM, Christian König wrote:
>> Am 24.10.19 um 12:58 schrieb S, Shirish:
>>> [Why]
>>> Upon GPU reset, kernel cleans up already submitted jobs
>>> via drm_sched_cleanup_jobs.
>>> This schedules ib's via drm_sched_main()->run_job, leading to
>>> race condition of rings being ready or not, since during reset
>>> rings may be suspended.
>>
>> NAK, exactly that's what should not happen.
>>
>> The scheduler should be suspend while a GPU reset is in progress.
>>
>> So you are running into a completely different race here.
>>
>> Please sync up with Andrey how this was able to happen.
>>
>> Regards,
>> Christian.
>
>
> Shirish - Christian makes a good point - note that in 
> amdgpu_device_gpu_recover drm_sched_stop which stop all the scheduler 
> threads is called way before we suspend the HW in 
> amdgpu_device_pre_asic_reset->amdgpu_device_ip_suspend where SDMA 
> suspension is happening and where the HW ring marked as not ready - 
> please provide call stack for when you hit [drm:amdgpu_job_run] 
> *ERROR* Error scheduling IBs (-22) to identify the code path which 
> tried to submit the SDMA IB
>

Well the most likely cause of this is that the hardware failed to resume 
after the reset.

Christian.

> Andrey
>
>
>>
>>>
>>> [How]
>>> make GPU reset's amdgpu_device_ip_resume_phase2() &
>>> amdgpu_ib_schedule() in amdgpu_job_run() mutually exclusive.
>>>
>>> Signed-off-by: Shirish S <shirish.s-5C7GfCeVMHo@public.gmane.org>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 2 ++
>>>   3 files changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index f4d9041..7b07a47b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -973,6 +973,7 @@ struct amdgpu_device {
>>>       bool                            in_gpu_reset;
>>>       enum pp_mp1_state               mp1_state;
>>>       struct mutex  lock_reset;
>>> +    struct mutex  lock_ib_sched;
>>>       struct amdgpu_doorbell_index doorbell_index;
>>>         int asic_reset_res;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 676cad1..63cad74 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -2759,6 +2759,7 @@ int amdgpu_device_init(struct amdgpu_device 
>>> *adev,
>>>       mutex_init(&adev->virt.vf_errors.lock);
>>>       hash_init(adev->mn_hash);
>>>       mutex_init(&adev->lock_reset);
>>> +    mutex_init(&adev->lock_ib_sched);
>>>       mutex_init(&adev->virt.dpm_mutex);
>>>       mutex_init(&adev->psp.mutex);
>>>   @@ -3795,7 +3796,9 @@ static int amdgpu_do_asic_reset(struct 
>>> amdgpu_hive_info *hive,
>>>                   if (r)
>>>                       return r;
>>>   + mutex_lock(&tmp_adev->lock_ib_sched);
>>>                   r = amdgpu_device_ip_resume_phase2(tmp_adev);
>>> + mutex_unlock(&tmp_adev->lock_ib_sched);
>>>                   if (r)
>>>                       goto out;
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> index e1bad99..cd6082d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> @@ -233,8 +233,10 @@ static struct dma_fence *amdgpu_job_run(struct 
>>> drm_sched_job *sched_job)
>>>       if (finished->error < 0) {
>>>           DRM_INFO("Skip scheduling IBs!\n");
>>>       } else {
>>> +        mutex_lock(&ring->adev->lock_ib_sched);
>>>           r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
>>>                          &fence);
>>> +        mutex_unlock(&ring->adev->lock_ib_sched);
>>>           if (r)
>>>               DRM_ERROR("Error scheduling IBs (%d)\n", r);
>>>       }
>>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------622BFDAF81EADBEC8F7B1A70
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 24.10.19 um 17:06 schrieb
      Grodzovsky, Andrey:<br>
    </div>
    <blockquote type="cite"
      cite="mid:f3be329d-d350-c821-00b7-d94858335796-5C7GfCeVMHo@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 10/24/19 7:01 AM, Christian König
        wrote:<br>
      </div>
      <blockquote type="cite"
        cite="mid:23ea615d-5ef4-d0b3-a0ec-6fae67b102f2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">
        Am 24.10.19 um 12:58 schrieb S, Shirish: <br>
        <blockquote type="cite">[Why] <br>
          Upon GPU reset, kernel cleans up already submitted jobs <br>
          via drm_sched_cleanup_jobs. <br>
          This schedules ib's via drm_sched_main()-&gt;run_job, leading
          to <br>
          race condition of rings being ready or not, since during reset
          <br>
          rings may be suspended. <br>
        </blockquote>
        <br>
        NAK, exactly that's what should not happen. <br>
        <br>
        The scheduler should be suspend while a GPU reset is in
        progress. <br>
        <br>
        So you are running into a completely different race here. <br>
        <br>
        Please sync up with Andrey how this was able to happen. <br>
        <br>
        Regards, <br>
        Christian. <br>
      </blockquote>
      <p><br>
      </p>
      <p>Shirish - Christian makes a good point - note that in
        amdgpu_device_gpu_recover drm_sched_stop which stop all the
        scheduler threads is called way before we suspend the HW in
        amdgpu_device_pre_asic_reset-&gt;amdgpu_device_ip_suspend where
        SDMA suspension is happening and where the HW ring marked as not
        ready - please provide call stack for when you hit
        <span style="color: rgb(51, 51, 51); font-family: Arial,
          sans-serif; font-size: 14px; font-style: normal;
          font-variant-ligatures: normal; font-variant-caps: normal;
          font-weight: 400; letter-spacing: normal; orphans: 2;
          text-align: start; text-indent: 0px; text-transform: none;
          white-space: normal; widows: 2; word-spacing: 0px;
          -webkit-text-stroke-width: 0px; background-color: rgb(245,
          245, 245); text-decoration-style: initial;
          text-decoration-color: initial; display: inline !important;
          float: none;">
          [drm:amdgpu_job_run] *ERROR* Error scheduling IBs (-22) to
          identify the code path which tried to submit the SDMA IB<br>
        </span></p>
    </blockquote>
    <br>
    Well the most likely cause of this is that the hardware failed to
    resume after the reset.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:f3be329d-d350-c821-00b7-d94858335796-5C7GfCeVMHo@public.gmane.org">
      <p><span style="color: rgb(51, 51, 51); font-family: Arial,
          sans-serif; font-size: 14px; font-style: normal;
          font-variant-ligatures: normal; font-variant-caps: normal;
          font-weight: 400; letter-spacing: normal; orphans: 2;
          text-align: start; text-indent: 0px; text-transform: none;
          white-space: normal; widows: 2; word-spacing: 0px;
          -webkit-text-stroke-width: 0px; background-color: rgb(245,
          245, 245); text-decoration-style: initial;
          text-decoration-color: initial; display: inline !important;
          float: none;">
        </span></p>
      <p><span style="color: rgb(51, 51, 51); font-family: Arial,
          sans-serif; font-size: 14px; font-style: normal;
          font-variant-ligatures: normal; font-variant-caps: normal;
          font-weight: 400; letter-spacing: normal; orphans: 2;
          text-align: start; text-indent: 0px; text-transform: none;
          white-space: normal; widows: 2; word-spacing: 0px;
          -webkit-text-stroke-width: 0px; background-color: rgb(245,
          245, 245); text-decoration-style: initial;
          text-decoration-color: initial; display: inline !important;
          float: none;">Andrey</span></p>
      <p><span style="color: rgb(51, 51, 51); font-family: Arial,
          sans-serif; font-size: 14px; font-style: normal;
          font-variant-ligatures: normal; font-variant-caps: normal;
          font-weight: 400; letter-spacing: normal; orphans: 2;
          text-align: start; text-indent: 0px; text-transform: none;
          white-space: normal; widows: 2; word-spacing: 0px;
          -webkit-text-stroke-width: 0px; background-color: rgb(245,
          245, 245); text-decoration-style: initial;
          text-decoration-color: initial; display: inline !important;
          float: none;"><br>
        </span></p>
      <blockquote type="cite"
        cite="mid:23ea615d-5ef4-d0b3-a0ec-6fae67b102f2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">
        <br>
        <blockquote type="cite"><br>
          [How] <br>
          make GPU reset's amdgpu_device_ip_resume_phase2() &amp; <br>
          amdgpu_ib_schedule() in amdgpu_job_run() mutually exclusive. <br>
          <br>
          Signed-off-by: Shirish S <a class="moz-txt-link-rfc2396E"
            href="mailto:shirish.s-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">
            &lt;shirish.s-5C7GfCeVMHo@public.gmane.org&gt;</a> <br>
          --- <br>
            drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 + <br>
            drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++ <br>
            drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 2 ++ <br>
            3 files changed, 6 insertions(+) <br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
          b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
          <br>
          index f4d9041..7b07a47b 100644 <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
          @@ -973,6 +973,7 @@ struct amdgpu_device { <br>
                bool                            in_gpu_reset; <br>
                enum pp_mp1_state               mp1_state; <br>
                struct mutex  lock_reset; <br>
          +    struct mutex  lock_ib_sched; <br>
                struct amdgpu_doorbell_index doorbell_index; <br>
                  int asic_reset_res; <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
          <br>
          index 676cad1..63cad74 100644 <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c <br>
          @@ -2759,6 +2759,7 @@ int amdgpu_device_init(struct
          amdgpu_device *adev, <br>
                mutex_init(&amp;adev-&gt;virt.vf_errors.lock); <br>
                hash_init(adev-&gt;mn_hash); <br>
                mutex_init(&amp;adev-&gt;lock_reset); <br>
          +    mutex_init(&amp;adev-&gt;lock_ib_sched); <br>
                mutex_init(&amp;adev-&gt;virt.dpm_mutex); <br>
                mutex_init(&amp;adev-&gt;psp.mutex); <br>
            @@ -3795,7 +3796,9 @@ static int amdgpu_do_asic_reset(struct
          amdgpu_hive_info *hive,
          <br>
                            if (r) <br>
                                return r; <br>
            +               
          mutex_lock(&amp;tmp_adev-&gt;lock_ib_sched); <br>
                            r =
          amdgpu_device_ip_resume_phase2(tmp_adev); <br>
          +               
          mutex_unlock(&amp;tmp_adev-&gt;lock_ib_sched); <br>
                            if (r) <br>
                                goto out; <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
          <br>
          index e1bad99..cd6082d 100644 <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c <br>
          @@ -233,8 +233,10 @@ static struct dma_fence
          *amdgpu_job_run(struct drm_sched_job *sched_job)
          <br>
                if (finished-&gt;error &lt; 0) { <br>
                    DRM_INFO("Skip scheduling IBs!\n"); <br>
                } else { <br>
          +        mutex_lock(&amp;ring-&gt;adev-&gt;lock_ib_sched); <br>
                    r = amdgpu_ib_schedule(ring, job-&gt;num_ibs,
          job-&gt;ibs, job, <br>
                                   &amp;fence); <br>
          +        mutex_unlock(&amp;ring-&gt;adev-&gt;lock_ib_sched); <br>
                    if (r) <br>
                        DRM_ERROR("Error scheduling IBs (%d)\n", r); <br>
                } <br>
        </blockquote>
        <br>
      </blockquote>
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

--------------622BFDAF81EADBEC8F7B1A70--

--===============1920156788==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1920156788==--
