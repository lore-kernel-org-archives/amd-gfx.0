Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17ACC54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Sep 2022 12:22:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D35D89919;
	Tue, 20 Sep 2022 12:22:52 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90A8589919
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 12:22:47 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id y5so4032483wrh.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 05:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=3HA+ozobCyZqw0NYY5/a0S4rfpHyYZsZhpMBBngP3lQ=;
 b=eUkozf8LUlwP0YdwgXkfE8PHqEnzdHZ1OiE+TlK5EpD/Lj89mrbIhIe+gBT0qF6kg3
 1m2u7M2Xovv7X7ew1xyCAYCgEqY3hbABj6stCgiuPfpOwKGF+7XvYvKtF4XqO6lbs7NF
 +SnAwWs+an//UGrIceR2xkx3gZlZscjHS57hpGLDVxIG3BJo3jpPHCY+JBaNCUkkqdrk
 ysQezleja3CTFAloMEJSuYoPZ2TG3s0bHFmd5WXav5Iv7PXP6foCGKdDGJmG41TA3qs2
 AB1MRi5X3u6X3TX4R3la5NQGKgrOruD6Fdd2WUzuQzHDu6buaz7JkBi5yY2ZQZOPA1V+
 aBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=3HA+ozobCyZqw0NYY5/a0S4rfpHyYZsZhpMBBngP3lQ=;
 b=hj+2pW9N7gWxRAryED+K/DxIKJCKU8Pdp8wgm3XtznLsDFaOIAtuH0eH+LZk0FX/rm
 4WMTz5nHwZ1EyVlhk4cx7XN16J7skwwCdczpFYMWU4/A6IyPoTOtxWENW+ztr0BNfj+E
 YnPWr4xBwPimL8wBa5JDID/v0Na80sVZF36ku3j8xkVbhSj4zKX2GU4LVUhjRb43zCzw
 1Ul1/qZQ9EZfMDa0fqmBcCVSaIQ8hl1yFtCnvHAsOez+SU7njUXNHry833s4czgme0yi
 TIAaTu7wL8bfJxrTgMcvKvPugsRsANJfZ8rWrf+mhWS0GCIkR66hxPvVDA5MUoRP/0yp
 62tQ==
X-Gm-Message-State: ACrzQf1+R2d5dtkIv0XI32q2iCG2aBUTiFYLZ/qUnoYG+5WH0omVTRJ5
 7ge3xqHDXie7phBLvDr0/sY=
X-Google-Smtp-Source: AMsMyM7Cu03rb9K6ElQSGOC4p3+hS/CM7E/cqL9/v92UwGCxAl1wsy/unbd/qK+LSnvpOvB9hAt87g==
X-Received: by 2002:adf:f804:0:b0:228:62fd:6e9a with SMTP id
 s4-20020adff804000000b0022862fd6e9amr14206066wrp.697.1663676566032; 
 Tue, 20 Sep 2022 05:22:46 -0700 (PDT)
Received: from [192.168.178.21] (p4fc20ebf.dip0.t-ipconnect.de.
 [79.194.14.191]) by smtp.gmail.com with ESMTPSA id
 f6-20020adff586000000b0022a403954c3sm1607239wro.42.2022.09.20.05.22.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Sep 2022 05:22:45 -0700 (PDT)
Message-ID: <b83ef4d5-98be-3d82-152b-c0dcff5540d6@gmail.com>
Date: Tue, 20 Sep 2022 14:22:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
Content-Language: en-US
To: "Zhao, Victor" <Victor.Zhao@amd.com>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220914101025.366954-1-Victor.Zhao@amd.com>
 <DM6PR12MB4340D28D9D23472D571727D7FA499@DM6PR12MB4340.namprd12.prod.outlook.com>
 <1ea8528f-fb55-e8b1-73c8-bf8935f9870c@amd.com>
 <DM6PR12MB434047014434C43396BB2D31FA499@DM6PR12MB4340.namprd12.prod.outlook.com>
 <e7eadc0d-c9a6-8a12-bbd7-5dd3277a7754@amd.com>
 <fc7f7d5f-3d63-234f-1864-ab365d6e338d@amd.com>
 <378f971b-9ee6-5fb3-4143-f20b873d0b4b@amd.com>
 <3ee47f74-fca4-f78c-9235-972d4543d880@amd.com>
 <d4fff5a6-833a-161f-d86e-b17cb9d9382c@amd.com>
 <DM6PR12MB4340BA5F434240E73E5E5F8CFA4B9@DM6PR12MB4340.namprd12.prod.outlook.com>
 <69b2ffb7-b216-9f7a-a248-4e3d2ee4908f@amd.com>
 <DM6PR12MB434020F8F005F204EEC42A41FA4C9@DM6PR12MB4340.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DM6PR12MB434020F8F005F204EEC42A41FA4C9@DM6PR12MB4340.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Victor,

yes that behavior is mandatory. We can't rely on all engines always 
sending valid fence numbers.

Regards,
Christian.

Am 20.09.22 um 12:22 schrieb Zhao, Victor:
> [AMD Official Use Only - General]
>
> Hi @Koenig, Christian,
>
> About the change 'drm/amdgpu: sanitize fence numbers', do you know if this vce issue still exists? Can we change fence process back?
>
> Hi @Grodzovsky, Andrey,
>
> So looks like close irq is possibly the most appropriate fix for this issue for now? Please help review this part.
>
>
> Thanks,
> Victor
>
>
>
> -----Original Message-----
> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Sent: Monday, September 19, 2022 11:04 PM
> To: Zhao, Victor <Victor.Zhao@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deng, Emily <Emily.Deng@amd.com>
> Subject: Re: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
>
> I don't know if issue still exist but it worth checking with Christian who wrote this patch.
>
> Andrey
>
>
> On 2022-09-16 23:31, Zhao, Victor wrote:
>> [AMD Official Use Only - General]
>>
>> Hi Andrey,
>>
>> Yes, moving irq disable can fix the issue. Change in amdgpu_fence_process is just want to make sure driver can correct itself from an overflow situation. Didn’t know about the previous issue there.
>>
>> Do you know if the issue still exists? Or is it on VCE only?
>>
>>
>> Thanks,
>> Victor
>>
>>
>>
>> -----Original Message-----
>> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
>> Sent: Friday, September 16, 2022 9:50 PM
>> To: Koenig, Christian <Christian.Koenig@amd.com>; Zhao, Victor
>> <Victor.Zhao@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deng, Emily <Emily.Deng@amd.com>
>> Subject: Re: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
>>
>>
>> On 2022-09-16 01:18, Christian König wrote:
>>> Am 15.09.22 um 22:37 schrieb Andrey Grodzovsky:
>>>> On 2022-09-15 15:26, Christian König wrote:
>>>>> Am 15.09.22 um 20:29 schrieb Andrey Grodzovsky:
>>>>>> On 2022-09-15 06:09, Zhao, Victor wrote:
>>>>>>> [AMD Official Use Only - General]
>>>>>>>
>>>>>>> Hi Christian,
>>>>>>>
>>>>>>> The test sequence is executing a compute engine hang while
>>>>>>> running a lot of containers submitting gfx jobs. We have advanced
>>>>>>> tdr mode and mode2 reset enabled on driver.
>>>>>>> When a compute hang job timeout happens, the 2 jobs on the gfx
>>>>>>> pending list maybe signaled after drm_sched_stop. So they will
>>>>>>> not be removed from pending list but have the
>>>>>>> DMA_FENCE_FLAG_SIGNALED_BIT set.
>>>>>>> At the amdgpu_device_recheck_guilty_jobs step, the first job will
>>>>>>> be rerun and removed from pending list.
>>>>>>> At the resubmit setp, the second job (with signaled bit) will be
>>>>>>> resubmitted. Since it still has signaled bit, drm_sched_job_done
>>>>>>> will be called directly. This decrease the hw_rq_count which
>>>>>>> allows more jobs emitted but did not clean fence_drv rcu ptr.
>>>>>>> This results in an overflow in the fence_drv. Since we will use
>>>>>>> num_fences_mask in amdgpu_fence_process, when overflow happens,
>>>>>>> the signal of some job will be skipped which result in an
>>>>>>> infinite wait for the fence_drv rcu ptr.
>>>>>>>
>>>>>>> So close irq before sched_stop could avoid signal jobs after
>>>>>>> drm_sched_stop. And signal job one by one in fence_process
>>>>>>> instead of using a mask will handle the overflow situation.
>>>>>>>
>>>>>>> Another fix could be skip submitting jobs which already signaled
>>>>>>> during resubmit stage, which may look cleaner.
>>>>>>>
>>>>>>> Please help give some advice.
>>>>>> How about the code bellow  instead ? The real problem is that we
>>>>>> reuse a dma fence twice which is not according to fma fence
>>>>>> design, so maybe this can help ?
>>>>>>
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>> index 8adeb7469f1e..033f0ae16784 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>> @@ -164,6 +164,10 @@ int amdgpu_fence_emit(struct amdgpu_ring
>>>>>> *ring, struct dma_fence **f, struct amd
>>>>>>           if (job && job->job_run_counter) {
>>>>>>                   /* reinit seq for resubmitted jobs */
>>>>>>                   fence->seqno = seq;
>>>>>> +
>>>>>> +               /* For resubmitted job clear the singled bit */
>>>>>> +               celar_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
>>>>>> &fence->flags);
>>>>>> +
>>>>> Upstream will pretty much kill you for that.
>>>>>
>>>>> Re-setting a fence from a signaled to an unsignaled state is a
>>>>> massive no-go.
>>>>>
>>>>> Christian.
>>>> Is it worse then doing fence->seqno = seq; ? This is already a huge
>>>> hack , no ?
>>> No, it's as equally bad. I don't think we can do either.
>>>
>>> Christian.
>> And all those ugly hack are there because we reuse a dma_fence (hw_fence embedded into the job) and correct me if I am wrong but I don't think dma_fence is ever supposed to be reused.
>>
>> So maybe like Victor suggested we should move close and flush irq before sched_stop - this in my opinion should solve the issue, but Victor - why then you still need the change in amdgpu_fence_process ? You will not have the overflow situation because by moving irq_disable before stop any job that signaled will be removed from the scheduler pending list anyway. Also not that this change reverts 'drm/amdgpu: sanitize fence numbers' and could reintroduce that bug.
>>
>> Andrey
>>
>>
>>>> Andrey
>>>>
>>>>
>>>>>>                   /* TO be inline with external fence creation and
>>>>>> other drivers */
>>>>>>                   dma_fence_get(fence);
>>>>>>           } else {
>>>>>>
>>>>>>
>>>>>> Andrey
>>>>>>
>>>>>>
>>>>>>> Thanks,
>>>>>>> Victor
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>>>> Sent: Thursday, September 15, 2022 2:32 PM
>>>>>>> To: Zhao, Victor <Victor.Zhao@amd.com>;
>>>>>>> amd-gfx@lists.freedesktop.org; Grodzovsky, Andrey
>>>>>>> <Andrey.Grodzovsky@amd.com>
>>>>>>> Cc: Deng, Emily <Emily.Deng@amd.com>
>>>>>>> Subject: Re: [PATCH 1/2] drm/amdgpu: fix deadlock caused by
>>>>>>> overflow
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Am 15.09.22 um 06:02 schrieb Zhao, Victor:
>>>>>>>> [AMD Official Use Only - General]
>>>>>>>>
>>>>>>>> Ping.
>>>>>>>>
>>>>>>>> Hi @Koenig, Christian and @Grodzovsky, Andrey,
>>>>>>>>
>>>>>>>> We found some reset related issues during stress test on the
>>>>>>>> sequence. Please help give some comments.
>>>>>>>>
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Victor
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Victor Zhao <Victor.Zhao@amd.com>
>>>>>>>> Sent: Wednesday, September 14, 2022 6:10 PM
>>>>>>>> To: amd-gfx@lists.freedesktop.org
>>>>>>>> Cc: Deng, Emily <Emily.Deng@amd.com>; Grodzovsky, Andrey
>>>>>>>> <Andrey.Grodzovsky@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>
>>>>>>>> Subject: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
>>>>>>>>
>>>>>>>> [background]
>>>>>>>> For a gpu recovery caused by a hang on one ring (e.g. compute),
>>>>>>>> jobs from another ring (e.g. gfx) may continue signaling during
>>>>>>>> drm_sched_stop stage. The signal bit will not be cleared.
>>>>>>>>
>>>>>>>> At the resubmit stage after recovery, the job with hw fence
>>>>>>>> signaled bit set will call job done directly instead go through
>>>>>>>> fence process.
>>>>>>>> This makes the hw_rq_count decrease but rcu fence pointer not
>>>>>>>> cleared yet.
>>>>>>>>
>>>>>>>> Then overflow happens in the fence driver slots and some jobs
>>>>>>>> may be skipped and leave the rcu pointer not cleared which makes
>>>>>>>> an infinite wait for the slot on the next fence emitted.
>>>>>>>>
>>>>>>>> This infinite wait cause a job timeout on the emitting job. And
>>>>>>>> driver will stuck at the its sched stop step because
>>>>>>>> kthread_park cannot be done.
>>>>>>>>
>>>>>>>> [how]
>>>>>>>> 1. move amdgpu_fence_driver_isr_toggle earlier to close
>>>>>>>> interrupt before drm sched stop 2. handle all fences in fence
>>>>>>>> process to aviod skip when overflow happens
>>>>>>>>
>>>>>>>> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
>>>>>>>> ---
>>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16
>>>>>>>> +++++++++++++--- drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c |  6
>>>>>>>> +-----
>>>>>>>>      2 files changed, 14 insertions(+), 8 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> index 943c9e750575..c0cfae52f12b 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> @@ -4610,8 +4610,6 @@ int amdgpu_device_pre_asic_reset(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>              amdgpu_virt_fini_data_exchange(adev);
>>>>>>>>          }
>>>>>>>>      -    amdgpu_fence_driver_isr_toggle(adev, true);
>>>>>>>> -
>>>>>>>>          /* block all schedulers and reset given job's ring */
>>>>>>>>          for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>>>>>>>              struct amdgpu_ring *ring = adev->rings[i]; @@
>>>>>>>> -5214,6
>>>>>>>> +5212,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device
>>>>>>>> +*adev,
>>>>>>>> amdgpu_device_ip_need_full_reset(tmp_adev))
>>>>>>>>                  amdgpu_ras_suspend(tmp_adev);
>>>>>>>>      +        amdgpu_fence_driver_isr_toggle(tmp_adev, true);
>>>>>>>> +
>>>>>>>>              for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>>>>>>>                  struct amdgpu_ring *ring = tmp_adev->rings[i];
>>>>>>>>      @@ -5228,8 +5228,12 @@ int amdgpu_device_gpu_recover(struct
>>>>>>>> amdgpu_device *adev, atomic_inc(&tmp_adev->gpu_reset_counter);
>>>>>>>>          }
>>>>>>>>      -    if (need_emergency_restart)
>>>>>>>> +    if (need_emergency_restart) {
>>>>>>>> +        list_for_each_entry (tmp_adev, device_list_handle,
>>>>>>>> reset_list) {
>>>>>>>> +            amdgpu_fence_driver_isr_toggle(tmp_adev, false);
>>>>>>>> +        }
>>>>>>>>              goto skip_sched_resume;
>>>>>>>> +    }
>>>>>>>>             /*
>>>>>>>>           * Must check guilty signal here since after this point
>>>>>>>> all old @@ -5240,6 +5244,9 @@ int
>>>>>>>> amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>>>>>>>          if (job && dma_fence_is_signaled(&job->hw_fence)) {
>>>>>>>>              job_signaled = true;
>>>>>>>>              dev_info(adev->dev, "Guilty job already signaled,
>>>>>>>> skipping HW reset");
>>>>>>>> +        list_for_each_entry (tmp_adev, device_list_handle,
>>>>>>>> reset_list) {
>>>>>>>> +            amdgpu_fence_driver_isr_toggle(tmp_adev, false);
>>>>>>>> +        }
>>>>>>>>              goto skip_hw_reset;
>>>>>>>>          }
>>>>>>>>      @@ -5276,6 +5283,7 @@ int amdgpu_device_gpu_recover(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>              if (r && r == -EAGAIN) {
>>>>>>>>                  set_bit(AMDGPU_SKIP_MODE2_RESET,
>>>>>>>> &reset_context->flags);
>>>>>>>>                  adev->asic_reset_res = 0;
>>>>>>>> +            amdgpu_fence_driver_isr_toggle(adev, true);
>>>>>>>>                  goto retry;
>>>>>>>>              }
>>>>>>>>          }
>>>>>>>> @@ -5711,6 +5719,8 @@ pci_ers_result_t
>>>>>>>> amdgpu_pci_slot_reset(struct pci_dev *pdev)
>>>>>>>>          set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
>>>>>>>>          set_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
>>>>>>>>      +    amdgpu_fence_driver_isr_toggle(adev, true);
>>>>>>>> +
>>>>>>>>          adev->no_hw_access = true;
>>>>>>>>          r = amdgpu_device_pre_asic_reset(adev, &reset_context);
>>>>>>>>          adev->no_hw_access = false; diff --git
>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>>> index 8adeb7469f1e..65a877e1a7fc 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>>> @@ -287,15 +287,11 @@ bool amdgpu_fence_process(struct
>>>>>>>> amdgpu_ring *ring)
>>>>>>>>          if (unlikely(seq == last_seq))
>>>>>>>>              return false;
>>>>>>>>      -    last_seq &= drv->num_fences_mask;
>>>>>>>> -    seq &= drv->num_fences_mask;
>>>>>>>> -
>>>>>>>>          do {
>>>>>>>>              struct dma_fence *fence, **ptr;
>>>>>>>>                 ++last_seq;
>>>>>>>> -        last_seq &= drv->num_fences_mask;
>>>>>>>> -        ptr = &drv->fences[last_seq];
>>>>>>>> +        ptr = &drv->fences[last_seq & drv->num_fences_mask];
>>>>>>>>                 /* There is always exactly one thread signaling
>>>>>>>> this fence slot */
>>>>>>>>              fence = rcu_dereference_protected(*ptr, 1);
>>>>>>> Those changes here doesn't seem to make sense. Please explain
>>>>>>> further why that is necessary.
>>>>>>>
>>>>>>> Christian.
>>>>>>>
>>>>>>>> --
>>>>>>>> 2.25.1

