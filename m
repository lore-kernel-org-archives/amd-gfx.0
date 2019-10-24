Return-Path: <SRS0=Gnzf=YR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C64CA9EAF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 16:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B9D20650
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 16:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B9D20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39DC06E488;
	Thu, 24 Oct 2019 16:30:12 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A28596E488
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2019 16:30:10 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id n15so16017207wrw.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2019 09:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language;
 bh=c7PSbSORHY5ZBBhplN3aw7fhAR9ipfgT874mndiNylE=;
 b=S8Wy7ANbzJX3mIVFfYHbqL7UklJouMxUhQNmD9AEKyvul8XllEiBoVB39u4yrnhNFO
 7uurBDwdYscgJtGgeFtgHLKjyCQNR/i0duDbJ+QUOaTjPgGt4Ku/JZTopXoxxhRhLhr9
 74ffC8ussNGEen7UKEK4+rmv8tNDjYYw4zejhUdCuShlzBRqrhFFDj7ENfFjuNoaoA8C
 Sg9uVEeYC2lEafRmD5G/NxNlVXzJyLdKhN96qQV3wi2p3/Vto4EbCdpyxII2RdE452qC
 oyyIrVg39zy/xAVwnKpj+eN/DTdJ2jJCx+C9OKUkVDrFFkemAtqBMVftMXMxafE7Uqgk
 sGUw==
X-Gm-Message-State: APjAAAUharCCu2hqOl7tVMgEg57TN3EgMXRN4lYAWiwSExsPk0sRPAiJ
 jmo96tuqu+ucOVgRyWAzcCa62VXa
X-Google-Smtp-Source: APXvYqzAt/VAvh4+AJOzn49bT371TYmNN6uzxetViDUjzeYDeQcCSA7R3FUtx+hOHRKj9L5KJpJf6A==
X-Received: by 2002:a5d:6747:: with SMTP id l7mr4486309wrw.328.1571934609017; 
 Thu, 24 Oct 2019 09:30:09 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id h3sm11589793wrt.88.2019.10.24.09.30.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 09:30:07 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: guard ib scheduling while in reset
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "S, Shirish" <Shirish.S@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <1571914692-9430-1-git-send-email-shirish.s@amd.com>
 <23ea615d-5ef4-d0b3-a0ec-6fae67b102f2@gmail.com>
 <f3be329d-d350-c821-00b7-d94858335796@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d573688c-0997-1928-0c56-b60a29ff7fde@gmail.com>
Date: Thu, 24 Oct 2019 18:30:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f3be329d-d350-c821-00b7-d94858335796@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=c7PSbSORHY5ZBBhplN3aw7fhAR9ipfgT874mndiNylE=;
 b=BhGMHxqkYucR/DoqK8Ii7pPOWo1+hEg8o0zVUuufqe88qb2RhZwnkDIxmfOOUQLIgN
 iKJJRDAk/MsecDkduDiCAJ6OaX4+qp1X7IQ/pOZWfUJWIXCf+uyLT5oYmFMjDKoHa9E4
 BWgTJRKZGtq0n7MJUV3bjcLwveIU5i/lkTp7sB2W/R0YuquAPhPaJxdvGfB5LMx2QYRC
 ChYLvB5qL5RTku63Rx28E827w9axqmobELxxI3p5fcE1TPkAifdCcT8TN58BYRN4BSgs
 1qlht63oTfwLeij9Edjogcjm3nW9unQOdikq+Huyd8oIF7W72SLi6AFQvUhJmPfncyEs
 +JrA==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Reply-To: christian.koenig@amd.com
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1920156788=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191024163005.L3zTkN0x0I_u9UwEekM5JfQo753lcpAi9_1s6aaOcUk@z>

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
>>> Signed-off-by: Shirish S <shirish.s@amd.com>
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
> amd-gfx@lists.freedesktop.org
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
      cite="mid:f3be329d-d350-c821-00b7-d94858335796@amd.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 10/24/19 7:01 AM, Christian König
        wrote:<br>
      </div>
      <blockquote type="cite"
        cite="mid:23ea615d-5ef4-d0b3-a0ec-6fae67b102f2@gmail.com">
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
      cite="mid:f3be329d-d350-c821-00b7-d94858335796@amd.com">
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
        cite="mid:23ea615d-5ef4-d0b3-a0ec-6fae67b102f2@gmail.com">
        <br>
        <blockquote type="cite"><br>
          [How] <br>
          make GPU reset's amdgpu_device_ip_resume_phase2() &amp; <br>
          amdgpu_ib_schedule() in amdgpu_job_run() mutually exclusive. <br>
          <br>
          Signed-off-by: Shirish S <a class="moz-txt-link-rfc2396E"
            href="mailto:shirish.s@amd.com" moz-do-not-send="true">
            &lt;shirish.s@amd.com&gt;</a> <br>
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
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
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
