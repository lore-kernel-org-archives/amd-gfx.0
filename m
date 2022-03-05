Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418D3C433EF
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Mar 2022 18:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8608F10E199;
	Sat,  5 Mar 2022 18:40:46 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2547910E199
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Mar 2022 18:40:45 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id f8so14667186edf.10
 for <amd-gfx@lists.freedesktop.org>; Sat, 05 Mar 2022 10:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=2rFj/qt69/EY0ukh5VeyVUAVtgaKBPuZxOL2foIVJoQ=;
 b=iVd3S5DyxFnGtPxtSpnq1niEIGD52Wms/OmCddlOlr4E00N15+E31H1fkegxrTOg0e
 0pzQwpM19wsMotca7dGutNe1pUiW5TGhXJeR9Y9++LjOVJA/D5Av6HmOIIbJ3erXK6rN
 mPMNc1cvYsKMXDQYynm6W82sh6aJEoXaqtNn8+msO1j1FKPuncm2Xx5FnI5V9ET+weB/
 NNi4fTuhoWfK12tHHC+4owGDP2cXWCN+y/bBIai5yjiOmti2TSdrk3ok3VHMz8ODHPsX
 BYfee1M7hil5JnJ4OZNrMJv2GqpYNkO6qAf/BL/+iZmi/hxtvo//QMNkLIMJ8K3rPmxq
 vLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=2rFj/qt69/EY0ukh5VeyVUAVtgaKBPuZxOL2foIVJoQ=;
 b=eaP8hHtCkihJ8cOqWTswazxacTt7QYsIpCe6LgW3PpWgUbVTzqoDG4MJsgtU18R6Zs
 oH0cqXIlsF+iI/jLPtOPpQOa0YwguRJCYpQjKCJMnQ8gLI7bU18Hy6rBamNVIi7hWFpd
 I46l1TFZLbR2mlroTi/fjtpbVDIzdm7tqHbMk4aa3fMdYhollYOqX80KVqQOaCyCAPbE
 kGKQnLqeAnWPnTf1xkxzAOUVcmANc6R2Wv7q+zXEWIkDnQW/oSmiSo1feI6yfefP6Fjs
 Kfx8UqZDzY294O+kGl+zM4nTZ8Z4ubRkfHwb1uZN2kpZfNtJm/tCbGyBJ2zhx9AwDFdm
 v7cA==
X-Gm-Message-State: AOAM533VLP+JSf6f1NgPnrErsdumuiGrQtc0Cer1W1L5pRmYCDIKd530
 K21sr0wr56k+/rW7S3i+jyChr4ideYA=
X-Google-Smtp-Source: ABdhPJzHfO8aL4zocsocLhMxwSxHf4pu88L+yX7JxY8asu7I70SVvi+eaB/lT+nSVhKIxghQzmOY7g==
X-Received: by 2002:a05:6402:34d5:b0:416:2f46:48f with SMTP id
 w21-20020a05640234d500b004162f46048fmr1060250edc.88.1646505643405; 
 Sat, 05 Mar 2022 10:40:43 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:586e:39ca:3fcf:db2f?
 ([2a02:908:1252:fb60:586e:39ca:3fcf:db2f])
 by smtp.gmail.com with ESMTPSA id
 gv54-20020a1709072bf600b006da7953530bsm3113572ejc.104.2022.03.05.10.40.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Mar 2022 10:40:42 -0800 (PST)
Message-ID: <5c573f4d-0fa8-5c01-67fe-c33a79a6f89c@gmail.com>
Date: Sat, 5 Mar 2022 19:40:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 09/10] drm/amdgpu: add gang submit backend
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org, Marek.Olsak@amd.com
References: <20220303082308.38217-1-christian.koenig@amd.com>
 <20220303082308.38217-10-christian.koenig@amd.com>
 <9bf49ccf-09a9-15d5-5591-ee2164c07f3c@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <9bf49ccf-09a9-15d5-5591-ee2164c07f3c@amd.com>
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 04.03.22 um 18:10 schrieb Andrey Grodzovsky:
>
> On 2022-03-03 03:23, Christian König wrote:
>> Allows submitting jobs as gang which needs to run on multiple
>> engines at the same time.
>>
>> Basic idea is that we have a global gang submit fence representing 
>> when the
>> gang leader is finally pushed to run on the hardware last.
>>
>> Jobs submitted as gang are never re-submitted in case of a GPU reset 
>> since this
>> won't work and will just deadlock the hardware immediately again.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 34 ++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 28 ++++++++++++++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |  3 ++
>>   4 files changed, 66 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 7f447ed7a67f..a664d43d7502 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -852,6 +852,7 @@ struct amdgpu_device {
>>       u64                fence_context;
>>       unsigned            num_rings;
>>       struct amdgpu_ring        *rings[AMDGPU_MAX_RINGS];
>> +    struct dma_fence __rcu        *gang_submit;
>>       bool                ib_pool_ready;
>>       struct amdgpu_sa_manager    ib_pools[AMDGPU_IB_POOL_MAX];
>>       struct amdgpu_sched 
>> gpu_sched[AMDGPU_HW_IP_NUM][AMDGPU_RING_PRIO_MAX];
>> @@ -1233,6 +1234,8 @@ void amdgpu_device_invalidate_hdp(struct 
>> amdgpu_device *adev,
>>           struct amdgpu_ring *ring);
>>     void amdgpu_device_halt(struct amdgpu_device *adev);
>> +struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
>> +                        struct dma_fence *gang);
>>     /* atpx handler */
>>   #if defined(CONFIG_VGA_SWITCHEROO)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index d78141e2c509..a116b8c08827 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3512,6 +3512,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>       adev->gmc.gart_size = 512 * 1024 * 1024;
>>       adev->accel_working = false;
>>       adev->num_rings = 0;
>> +    RCU_INIT_POINTER(adev->gang_submit, dma_fence_get_stub());
>>       adev->mman.buffer_funcs = NULL;
>>       adev->mman.buffer_funcs_ring = NULL;
>>       adev->vm_manager.vm_pte_funcs = NULL;
>> @@ -3989,6 +3990,7 @@ void amdgpu_device_fini_sw(struct amdgpu_device 
>> *adev)
>>       release_firmware(adev->firmware.gpu_info_fw);
>>       adev->firmware.gpu_info_fw = NULL;
>>       adev->accel_working = false;
>> + dma_fence_put(rcu_dereference_protected(adev->gang_submit, true));
>>         amdgpu_reset_fini(adev);
>>   @@ -5744,3 +5746,35 @@ void amdgpu_device_halt(struct amdgpu_device 
>> *adev)
>>       pci_disable_device(pdev);
>>       pci_wait_for_pending_transaction(pdev);
>>   }
>> +
>> +/**
>> + * amdgpu_device_switch_gang - switch to a new gang
>> + * @adev: amdgpu_device pointer
>> + * @gang: the gang to switch to
>> + *
>> + * Try to switch to a new gang or return a reference to the current 
>> gang if that
>> + * isn't possible.
>> + * Returns: Either NULL if we switched correctly or a reference to 
>> the existing
>> + * gang.
>> + */
>> +struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
>> +                        struct dma_fence *gang)
>> +{
>> +    struct dma_fence *old = NULL;
>> +
>> +    do {
>> +        dma_fence_put(old);
>> +        old = dma_fence_get_rcu_safe(&adev->gang_submit);
>> +
>> +        if (old == gang)
>> +            break;
>> +
>> +        if (!dma_fence_is_signaled(old))
>> +            return old;
>> +
>> +    } while (cmpxchg((struct dma_fence __force **)&adev->gang_submit,
>> +             old, gang) != old);
>> +
>> +    dma_fence_put(old);
>> +    return NULL;
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> index e07ceae36a5c..059e11c7898c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> @@ -169,11 +169,29 @@ static void amdgpu_job_free_cb(struct 
>> drm_sched_job *s_job)
>>           kfree(job);
>>   }
>>   +void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
>> +                struct amdgpu_job *leader)
>> +{
>> +    struct dma_fence *fence = &leader->base.s_fence->scheduled;
>> +
>> +    WARN_ON(job->gang_submit);
>> +
>> +    /*
>> +     * Don't add a reference when we are the gang leader to avoid 
>> circle
>> +     * dependency.
>> +     */
>> +    if (job != leader)
>> +        dma_fence_get(fence);
>> +    job->gang_submit = fence;
>> +}
>> +
>>   void amdgpu_job_free(struct amdgpu_job *job)
>>   {
>>       amdgpu_job_free_resources(job);
>>       amdgpu_sync_free(&job->sync);
>>       amdgpu_sync_free(&job->sched_sync);
>> +    if (job->gang_submit != &job->base.s_fence->scheduled)
>> +        dma_fence_put(job->gang_submit);
>>         /* only put the hw fence if has embedded fence */
>>       if (job->hw_fence.ops != NULL)
>> @@ -247,12 +265,16 @@ static struct dma_fence 
>> *amdgpu_job_dependency(struct drm_sched_job *sched_job,
>>           fence = amdgpu_sync_get_fence(&job->sync);
>>       }
>>   +    if (!fence && !job->gang_submit)
>> +        fence = amdgpu_device_switch_gang(ring->adev, 
>> job->gang_submit);
>> +
>
>
> Why job->gang_submit should be NULL in the check above ? Don't you 
> want to switch to an actual new gang fence here ?
> Jobs that don't have gang_submit fence set are not gang jobs anyway 
> and we don't care for this dependency
> for them right ?

Well exactly that's the point. That a job is not part of a gang submit 
is signaled by setting the pointer to NULL.

If we don't check for NULL here we would just crash.

Christian.

>
> Andrey
>
>
>>       return fence;
>>   }
>>     static struct dma_fence *amdgpu_job_run(struct drm_sched_job 
>> *sched_job)
>>   {
>>       struct amdgpu_ring *ring = to_amdgpu_ring(sched_job->sched);
>> +    struct amdgpu_device *adev = ring->adev;
>>       struct dma_fence *fence = NULL, *finished;
>>       struct amdgpu_job *job;
>>       int r = 0;
>> @@ -264,8 +286,10 @@ static struct dma_fence *amdgpu_job_run(struct 
>> drm_sched_job *sched_job)
>>         trace_amdgpu_sched_run_job(job);
>>   -    if (job->vram_lost_counter != 
>> atomic_read(&ring->adev->vram_lost_counter))
>> -        dma_fence_set_error(finished, -ECANCELED);/* skip IB as well 
>> if VRAM lost */
>> +    /* Skip job if VRAM is lost and never resubmit gangs */
>> +    if (job->vram_lost_counter != 
>> atomic_read(&adev->vram_lost_counter) ||
>> +        (job->job_run_counter && job->gang_submit))
>> +        dma_fence_set_error(finished, -ECANCELED);
>>         if (finished->error < 0) {
>>           DRM_INFO("Skip scheduling IBs!\n");
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> index 0bab8fe0d419..615328130615 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> @@ -51,6 +51,7 @@ struct amdgpu_job {
>>       struct amdgpu_sync    sched_sync;
>>       struct dma_fence    hw_fence;
>>       struct dma_fence    *external_hw_fence;
>> +    struct dma_fence    *gang_submit;
>>       uint32_t        preamble_status;
>>       uint32_t                preemption_status;
>>       bool                    vm_needs_flush;
>> @@ -80,6 +81,8 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device 
>> *adev, unsigned size,
>>   void amdgpu_job_set_resources(struct amdgpu_job *job, struct 
>> amdgpu_bo *gds,
>>                     struct amdgpu_bo *gws, struct amdgpu_bo *oa);
>>   void amdgpu_job_free_resources(struct amdgpu_job *job);
>> +void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
>> +                struct amdgpu_job *leader);
>>   void amdgpu_job_free(struct amdgpu_job *job);
>>   int amdgpu_job_submit(struct amdgpu_job *job, struct 
>> drm_sched_entity *entity,
>>                 void *owner, struct dma_fence **f);

