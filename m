Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19EEC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Oct 2023 16:16:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3AC910E334;
	Mon, 30 Oct 2023 16:16:32 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE82C10E334
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Oct 2023 16:16:30 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4079ed65582so34165025e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Oct 2023 09:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698682589; x=1699287389; darn=lists.freedesktop.org;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l8oDWPtVhZ8w4l2yBB4Tfp8ULPUn+cgLDxdjsAVS5k0=;
 b=Tc+fZL8E2y0tEUACwYs3rJkkuMb3Y+/3ELBk9KzXACUsGywHRQtPigcahqzqdEHCV3
 kTmXAY0esybcxg+tI2NePUfNB4IowoCL+otulv2Mc6zWwl3w67cS9vN39tCyQkagpxCs
 KwNYnr+w04otnldEm5hqCJnzHgcuQ963nCN/Ricg43rdIiNjyGTIkde9z3p9ZtdfDQyz
 xnR5LSr38CAtP8WTTXM8rVhMVSL/j7lgZopRXt/DOYs5qG8YERfckr4n34A3G8TSYX0K
 GKwoTsZNeQ3DBD6Z8WuFhQxVRpesggr0/H7+/Mb80PVuLnsvVBil+gp3wtlltfSK4ark
 SoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698682589; x=1699287389;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=l8oDWPtVhZ8w4l2yBB4Tfp8ULPUn+cgLDxdjsAVS5k0=;
 b=PoAshJ4mTkCjTm9rWVCKUh1XuBu3cgIvasYl88vDGpfLwfN+2BUdDLCBFqSpfY4VVq
 SSKngaOLrd/Z9RHchJTqgQNO54no8G6Na47iUF50sHk0EKf0m0q62Aqv4oT1V2qgwMba
 f1Zs0enPFBCXC3iSZe3V7qLrNV2EEKRy8OR9mvs3E8bwzRHs5IhZYGAN3BNd1KdIx2uh
 dqGfLjweGCbhzUfm9/mJz5NrFP50yErPX/v0E6u5oyiDrIRREFwulqLcdpTHBuXSRA65
 Rp38js5ZblLw4x8V7F3JrKOA0K6kJeZ1H6PFs10fzpmUEnPEZ7+Q5x3zrJiHHSyjcdIo
 uNuw==
X-Gm-Message-State: AOJu0YzE9NDTm4HQg+9UjXohSQNe4AINkp0lO5Ga09TbEkugSc44915S
 r+zkYOtVLTHYGZZ+VoGOXI4=
X-Google-Smtp-Source: AGHT+IFA7ZrLarGxHpHdhB3ujsVFWDSvjlEXcbaXS8jGmuHu12dDmnFxGZzyri0xfwcgrK9JZ4HCQQ==
X-Received: by 2002:a05:600c:3106:b0:405:75f0:fd31 with SMTP id
 g6-20020a05600c310600b0040575f0fd31mr8973652wmo.31.1698682589109; 
 Mon, 30 Oct 2023 09:16:29 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a1c770a000000b00405bbfd5d16sm9575945wmi.7.2023.10.30.09.16.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 09:16:28 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------n0jixrNNkQXCDcxzhVG3DC23"
Message-ID: <39374cfe-9c98-46bc-8b3d-196e50a65839@gmail.com>
Date: Mon, 30 Oct 2023 17:16:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm/amdkfd: Run restore_workers on freezable WQs
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231027223911.2640763-1-Felix.Kuehling@amd.com>
 <8e81a28a-5d50-44df-b441-6ceb2133c5e9@amd.com>
 <da7010c1-6b11-41f6-986d-796539073451@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <da7010c1-6b11-41f6-986d-796539073451@amd.com>
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
Cc: emily.deng@amd.com, xinhui.pan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------n0jixrNNkQXCDcxzhVG3DC23
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.10.23 um 16:16 schrieb Felix Kuehling:
> On 2023-10-30 4:23, Christian König wrote:
>> Am 28.10.23 um 00:39 schrieb Felix Kuehling:
>>> Make restore workers freezable so we don't have to explicitly flush 
>>> them
>>> in suspend and GPU reset code paths, and we don't accidentally try to
>>> restore BOs while the GPU is suspended. Not having to flush 
>>> restore_work
>>> also helps avoid lock/fence dependencies in the GPU reset case where 
>>> we're
>>> not allowed to wait for fences.
>>>
>>> This is an RFC and request for testing. I have not tested this 
>>> myself yet.
>>> My notes below:
>>>
>>> Restore work won't be frozen during GPU reset. Does it matter? 
>>> Queues will
>>> stay evicted until resume in any case. But restore_work may be in 
>>> trouble
>>> if it gets run in the middle of a GPU reset. In that case, if anything
>>> fails, it will just reschedule itself, so should be fine as long as it
>>> doesn't interfere with the reset itself (respects any mechanisms in 
>>> place
>>> to prevent HW access during the reset).
>>>
>>> What HW access does restore_work perform:
>>> - migrating buffers: uses GPU scheduler, should be suspended during 
>>> reset
>>> - TLB flushes in userptr restore worker: not called directly, relies on
>>>    HWS to flush TLBs on VMID attachment
>>> - TLB flushes in SVM restore worker: Does TLB flush in the mapping code
>>> - Resuming user mode queues: should not happen while GPU reset keeps 
>>> queue
>>>    eviction counter elevated
>>> Ergo: Except for the SVM case, it's OK to not flush restore work before
>>> GPU resets. I'll need to rethink the interaction of SVM restore_work 
>>> with
>>> GPU resets.
>>
>> It also sounds like the restore work is some high level work and 
>> shouldn't interact with the lower level GPU reset.
>
> That was my hope as well. Just trying to think through to make sure 
> I'm not making any incorrect assumptions.
>
> Do you know if there is anything preventing a TLB flush using MMIO 
> from messing up a GPU reset in progress? That's the only thing in the 
> SVM restore work that tries to touch HW directly.
>

The TLB invalidations should be protected from GPU reset influence after 
I reworked TLB flush.

So I think we are save here.

>>
>>>
>>> What about cancelling p->eviction_work? Eviction work would normally be
>>> needed to signal eviction fences, but we're doing that explicitly in
>>> suspend_all_processes. Does eviction_work wait for fences anywhere? 
>>> Yes,
>>> indirectly by flushing restore_work. So we should not try to cancel it
>>> during a GPU reset.
>>>
>>> Problem: accessing p->ef concurrently in evict_process_worker and
>>> suspend_all_processes. Need a spinlock to use and update it safely.
>>> Problem: What if evict_process_worker gets stuck in flushing 
>>> restore_work?
>>> We can skip all of that if p->ef is NULL (which it is during the 
>>> reset).
>>> Even if it gets stuck, it's no problem if the reset doesn't depend 
>>> on it.
>>> It should get unstuck after the reset.
>>>
>>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>> ---
>>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  9 ++--
>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 49 
>>> +++++++++++++------
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  4 +-
>>>   4 files changed, 44 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 54f31a420229..89e632257663 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -1644,7 +1644,8 @@ int amdgpu_amdkfd_criu_resume(void *p)
>>>           goto out_unlock;
>>>       }
>>>       WRITE_ONCE(pinfo->block_mmu_notifications, false);
>>> - schedule_delayed_work(&pinfo->restore_userptr_work, 0);
>>> +    queue_delayed_work(system_freezable_wq,
>>> +               &pinfo->restore_userptr_work, 0);
>>>     out_unlock:
>>>       mutex_unlock(&pinfo->lock);
>>> @@ -2458,7 +2459,8 @@ int amdgpu_amdkfd_evict_userptr(struct 
>>> mmu_interval_notifier *mni,
>>>                          KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
>>>           if (r)
>>>               pr_err("Failed to quiesce KFD\n");
>>> - schedule_delayed_work(&process_info->restore_userptr_work,
>>> +        queue_delayed_work(system_freezable_wq,
>>> +            &process_info->restore_userptr_work,
>>> msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
>>>       }
>>>       mutex_unlock(&process_info->notifier_lock);
>>> @@ -2793,7 +2795,8 @@ static void 
>>> amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>>>         /* If validation failed, reschedule another attempt */
>>>       if (evicted_bos) {
>>> - schedule_delayed_work(&process_info->restore_userptr_work,
>>> +        queue_delayed_work(system_freezable_wq,
>>> +            &process_info->restore_userptr_work,
>>> msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
>>>             kfd_smi_event_queue_restore_rescheduled(mm);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index 9cc32f577e38..cf017d027fee 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -919,6 +919,7 @@ struct kfd_process {
>>>        * during restore
>>>        */
>>>       struct dma_fence *ef;
>>> +    spinlock_t ef_lock;
>>>         /* Work items for evicting and restoring BOs */
>>>       struct delayed_work eviction_work;
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index fbf053001af9..a07cba58ec5e 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -664,7 +664,8 @@ int kfd_process_create_wq(void)
>>>       if (!kfd_process_wq)
>>>           kfd_process_wq = alloc_workqueue("kfd_process_wq", 0, 0);
>>>       if (!kfd_restore_wq)
>>> -        kfd_restore_wq = alloc_ordered_workqueue("kfd_restore_wq", 0);
>>> +        kfd_restore_wq = alloc_ordered_workqueue("kfd_restore_wq",
>>> +                             WQ_FREEZABLE);
>>>         if (!kfd_process_wq || !kfd_restore_wq) {
>>>           kfd_process_destroy_wq();
>>> @@ -1460,6 +1461,7 @@ static struct kfd_process 
>>> *create_process(const struct task_struct *thread)
>>>         kref_init(&process->ref);
>>>       mutex_init(&process->mutex);
>>> +    spin_lock_init(&process->ef_lock);
>>>       process->mm = thread->mm;
>>>       process->lead_thread = thread->group_leader;
>>>       process->n_pdds = 0;
>>> @@ -1904,6 +1906,19 @@ kfd_process_gpuid_from_node(struct 
>>> kfd_process *p, struct kfd_node *node,
>>>       return -EINVAL;
>>>   }
>>>   +static void signal_eviction_fence(struct kfd_process *p)
>>> +{
>>> +    spin_lock(&p->ef_lock);
>>> +    if (!p->ef)
>>> +        goto unlock_out;
>>> +    dma_fence_signal(p->ef);
>>
>> This needs to grab the internal lock of the eviction fence, I'm not 
>> sure that has correct ordering with the newly added ef_lock.
>
> Hmm, the only thing we could get a circular lock dependency would be, 
> if we took the p->ef_lock in a fence callback. I don't think that ever 
> happens, because even the eviction work runs on a worker thread 
> (exactly to avoid such lock dependency issues).
>
> Anyway, I could try to move the fence_signal out of the critical 
> section. The lock is only there to ensure that exactly one process 
> signals and frees the fence.
>

So basically either the eviction worker or the GPU reset could signal 
this fence.

In that case I think it would be simpler to grab the reset lock in the 
eviction worker to protect against a concurrent reset.

Regards,
Christian.

> 	spin_lock(&p->ef_lock);
> 	ef = p->ef;
> 	WRITE_ONCE(p->ef, NULL);
> 	spin_unlock(&p->ef_lock);
> 	if (ef) {
> 		dma_fence_signal(ef);
> 		dma_fence_put(ef);
> 	}
>
>
>>
>>> +    dma_fence_put(p->ef);
>>> +    WRITE_ONCE(p->ef, NULL);
>>> +
>>> +unlock_out:
>>> +    spin_unlock(&p->ef_lock);
>>> +}
>>> +
>>>   static void evict_process_worker(struct work_struct *work)
>>>   {
>>>       int ret;
>>> @@ -1916,8 +1931,11 @@ static void evict_process_worker(struct 
>>> work_struct *work)
>>>        * lifetime of this thread, kfd_process p will be valid
>>>        */
>>>       p = container_of(dwork, struct kfd_process, eviction_work);
>>> -    WARN_ONCE(p->last_eviction_seqno != p->ef->seqno,
>>> -          "Eviction fence mismatch\n");
>>> +    /* If the eviction fence is not valid, we're probably in a suspend
>>> +     * or GPU reset cycle. There is nothing to do in this case.
>>> +     */
>>> +    if (!READ_ONCE(p->ef))
>>> +        return;
>>
>> This evict process work is high level I don't think it should have 
>> any dependency on the GPU reset.
>
> Right. This is not here to avoid issues, just a short-cut to avoid 
> unnecessary work.
>
> Regards,
>   Felix
>
>
>>
>> Regards,
>> Christian.
>>
>>>         /* Narrow window of overlap between restore and evict work
>>>        * item is possible. Once amdgpu_amdkfd_gpuvm_restore_process_bos
>>> @@ -1930,9 +1948,7 @@ static void evict_process_worker(struct 
>>> work_struct *work)
>>>       pr_debug("Started evicting pasid 0x%x\n", p->pasid);
>>>       ret = kfd_process_evict_queues(p, 
>>> KFD_QUEUE_EVICTION_TRIGGER_TTM);
>>>       if (!ret) {
>>> -        dma_fence_signal(p->ef);
>>> -        dma_fence_put(p->ef);
>>> -        p->ef = NULL;
>>> +        signal_eviction_fence(p);
>>>           queue_delayed_work(kfd_restore_wq, &p->restore_work,
>>>                   msecs_to_jiffies(PROCESS_RESTORE_TIME_MS));
>>>   @@ -1967,9 +1983,19 @@ static void restore_process_worker(struct 
>>> work_struct *work)
>>>         p->last_restore_timestamp = get_jiffies_64();
>>>       /* VMs may not have been acquired yet during debugging. */
>>> -    if (p->kgd_process_info)
>>> +    if (p->kgd_process_info) {
>>> +        struct dma_fence *ef = NULL;
>>> +
>>>           ret = 
>>> amdgpu_amdkfd_gpuvm_restore_process_bos(p->kgd_process_info,
>>> -                                 &p->ef);
>>> +                                 &ef);
>>> +        if (!ret) {
>>> +            spin_lock(&p->ef_lock);
>>> +            WARN_ONCE(p->ef, "Eviction fence is not NULL");
>>> +            WRITE_ONCE(p->ef, ef);
>>> +            spin_unlock(&p->ef_lock);
>>> +        }
>>> +    }
>>> +
>>>       if (ret) {
>>>           pr_debug("Failed to restore BOs of pasid 0x%x, retry after 
>>> %d ms\n",
>>>                p->pasid, PROCESS_BACK_OFF_TIME_MS);
>>> @@ -1994,14 +2020,9 @@ void kfd_suspend_all_processes(void)
>>>         WARN(debug_evictions, "Evicting all processes");
>>>       hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>>> -        cancel_delayed_work_sync(&p->eviction_work);
>>> -        flush_delayed_work(&p->restore_work);
>>> -
>>>           if (kfd_process_evict_queues(p, 
>>> KFD_QUEUE_EVICTION_TRIGGER_SUSPEND))
>>>               pr_err("Failed to suspend process 0x%x\n", p->pasid);
>>> -        dma_fence_signal(p->ef);
>>> -        dma_fence_put(p->ef);
>>> -        p->ef = NULL;
>>> +        signal_eviction_fence(p);
>>>       }
>>>       srcu_read_unlock(&kfd_processes_srcu, idx);
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index fe937670c927..aa6c34127be9 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -1869,7 +1869,7 @@ static void svm_range_restore_work(struct 
>>> work_struct *work)
>>>       /* If validation failed, reschedule another attempt */
>>>       if (evicted_ranges) {
>>>           pr_debug("reschedule to restore svm range\n");
>>> -        schedule_delayed_work(&svms->restore_work,
>>> +        queue_delayed_work(system_freezable_wq, &svms->restore_work,
>>> msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
>>>             kfd_smi_event_queue_restore_rescheduled(mm);
>>> @@ -1945,7 +1945,7 @@ svm_range_evict(struct svm_range *prange, 
>>> struct mm_struct *mm,
>>>               pr_debug("failed to quiesce KFD\n");
>>>             pr_debug("schedule to restore svm %p ranges\n", svms);
>>> -        schedule_delayed_work(&svms->restore_work,
>>> +        queue_delayed_work(system_freezable_wq, &svms->restore_work,
>>> msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
>>>       } else {
>>>           unsigned long s, l;
>>

--------------n0jixrNNkQXCDcxzhVG3DC23
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 30.10.23 um 16:16 schrieb Felix Kuehling:<br>
    <blockquote type="cite"
      cite="mid:da7010c1-6b11-41f6-986d-796539073451@amd.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <div class="moz-cite-prefix">On 2023-10-30 4:23, Christian König
        wrote:<br>
      </div>
      <blockquote type="cite"
        cite="mid:8e81a28a-5d50-44df-b441-6ceb2133c5e9@amd.com">Am
        28.10.23 um 00:39 schrieb Felix Kuehling: <br>
        <blockquote type="cite">Make restore workers freezable so we
          don't have to explicitly flush them <br>
          in suspend and GPU reset code paths, and we don't accidentally
          try to <br>
          restore BOs while the GPU is suspended. Not having to flush
          restore_work <br>
          also helps avoid lock/fence dependencies in the GPU reset case
          where we're <br>
          not allowed to wait for fences. <br>
          <br>
          This is an RFC and request for testing. I have not tested this
          myself yet. <br>
          My notes below: <br>
          <br>
          Restore work won't be frozen during GPU reset. Does it matter?
          Queues will <br>
          stay evicted until resume in any case. But restore_work may be
          in trouble <br>
          if it gets run in the middle of a GPU reset. In that case, if
          anything <br>
          fails, it will just reschedule itself, so should be fine as
          long as it <br>
          doesn't interfere with the reset itself (respects any
          mechanisms in place <br>
          to prevent HW access during the reset). <br>
          <br>
          What HW access does restore_work perform: <br>
          - migrating buffers: uses GPU scheduler, should be suspended
          during reset <br>
          - TLB flushes in userptr restore worker: not called directly,
          relies on <br>
             HWS to flush TLBs on VMID attachment <br>
          - TLB flushes in SVM restore worker: Does TLB flush in the
          mapping code <br>
          - Resuming user mode queues: should not happen while GPU reset
          keeps queue <br>
             eviction counter elevated <br>
          Ergo: Except for the SVM case, it's OK to not flush restore
          work before <br>
          GPU resets. I'll need to rethink the interaction of SVM
          restore_work with <br>
          GPU resets. <br>
        </blockquote>
        <br>
        It also sounds like the restore work is some high level work and
        shouldn't interact with the lower level GPU reset. <br>
      </blockquote>
      <p>That was my hope as well. Just trying to think through to make
        sure I'm not making any incorrect assumptions.</p>
      <p>Do you know if there is anything preventing a TLB flush using
        MMIO from messing up a GPU reset in progress? That's the only
        thing in the SVM restore work that tries to touch HW directly.<br>
      </p>
    </blockquote>
    <br>
    The TLB invalidations should be protected from GPU reset influence
    after I reworked TLB flush.<br>
    <br>
    So I think we are save here.<br>
    <br>
    <blockquote type="cite"
      cite="mid:da7010c1-6b11-41f6-986d-796539073451@amd.com">
      <p> </p>
      <blockquote type="cite"
        cite="mid:8e81a28a-5d50-44df-b441-6ceb2133c5e9@amd.com"> <br>
        <blockquote type="cite"> <br>
          What about cancelling p-&gt;eviction_work? Eviction work would
          normally be <br>
          needed to signal eviction fences, but we're doing that
          explicitly in <br>
          suspend_all_processes. Does eviction_work wait for fences
          anywhere? Yes, <br>
          indirectly by flushing restore_work. So we should not try to
          cancel it <br>
          during a GPU reset. <br>
          <br>
          Problem: accessing p-&gt;ef concurrently in
          evict_process_worker and <br>
          suspend_all_processes. Need a spinlock to use and update it
          safely. <br>
          Problem: What if evict_process_worker gets stuck in flushing
          restore_work? <br>
          We can skip all of that if p-&gt;ef is NULL (which it is
          during the reset). <br>
          Even if it gets stuck, it's no problem if the reset doesn't
          depend on it. <br>
          It should get unstuck after the reset. <br>
          <br>
          Signed-off-by: Felix Kuehling <a
            class="moz-txt-link-rfc2396E"
            href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a>
          <br>
          --- <br>
            .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  9 ++-- <br>
            drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 + <br>
            drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 49
          +++++++++++++------ <br>
            drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  4 +- <br>
            4 files changed, 44 insertions(+), 19 deletions(-) <br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c <br>
          index 54f31a420229..89e632257663 100644 <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c <br>
          @@ -1644,7 +1644,8 @@ int amdgpu_amdkfd_criu_resume(void *p) <br>
                    goto out_unlock; <br>
                } <br>
                WRITE_ONCE(pinfo-&gt;block_mmu_notifications, false); <br>
          -   
          schedule_delayed_work(&amp;pinfo-&gt;restore_userptr_work, 0);
          <br>
          +    queue_delayed_work(system_freezable_wq, <br>
          +               &amp;pinfo-&gt;restore_userptr_work, 0); <br>
              out_unlock: <br>
                mutex_unlock(&amp;pinfo-&gt;lock); <br>
          @@ -2458,7 +2459,8 @@ int amdgpu_amdkfd_evict_userptr(struct
          mmu_interval_notifier *mni, <br>
                                   KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
          <br>
                    if (r) <br>
                        pr_err("Failed to quiesce KFD\n"); <br>
          -       
          schedule_delayed_work(&amp;process_info-&gt;restore_userptr_work,
          <br>
          +        queue_delayed_work(system_freezable_wq, <br>
          +            &amp;process_info-&gt;restore_userptr_work, <br>
                       
          msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS)); <br>
                } <br>
                mutex_unlock(&amp;process_info-&gt;notifier_lock); <br>
          @@ -2793,7 +2795,8 @@ static void
          amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
          <br>
                  /* If validation failed, reschedule another attempt */
          <br>
                if (evicted_bos) { <br>
          -       
          schedule_delayed_work(&amp;process_info-&gt;restore_userptr_work,
          <br>
          +        queue_delayed_work(system_freezable_wq, <br>
          +            &amp;process_info-&gt;restore_userptr_work, <br>
                       
          msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS)); <br>
                      kfd_smi_event_queue_restore_rescheduled(mm); <br>
          diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
          b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h <br>
          index 9cc32f577e38..cf017d027fee 100644 <br>
          --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h <br>
          +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h <br>
          @@ -919,6 +919,7 @@ struct kfd_process { <br>
                 * during restore <br>
                 */ <br>
                struct dma_fence *ef; <br>
          +    spinlock_t ef_lock; <br>
                  /* Work items for evicting and restoring BOs */ <br>
                struct delayed_work eviction_work; <br>
          diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
          b/drivers/gpu/drm/amd/amdkfd/kfd_process.c <br>
          index fbf053001af9..a07cba58ec5e 100644 <br>
          --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c <br>
          +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c <br>
          @@ -664,7 +664,8 @@ int kfd_process_create_wq(void) <br>
                if (!kfd_process_wq) <br>
                    kfd_process_wq = alloc_workqueue("kfd_process_wq",
          0, 0); <br>
                if (!kfd_restore_wq) <br>
          -        kfd_restore_wq =
          alloc_ordered_workqueue("kfd_restore_wq", 0); <br>
          +        kfd_restore_wq =
          alloc_ordered_workqueue("kfd_restore_wq", <br>
          +                             WQ_FREEZABLE); <br>
                  if (!kfd_process_wq || !kfd_restore_wq) { <br>
                    kfd_process_destroy_wq(); <br>
          @@ -1460,6 +1461,7 @@ static struct kfd_process
          *create_process(const struct task_struct *thread) <br>
                  kref_init(&amp;process-&gt;ref); <br>
                mutex_init(&amp;process-&gt;mutex); <br>
          +    spin_lock_init(&amp;process-&gt;ef_lock); <br>
                process-&gt;mm = thread-&gt;mm; <br>
                process-&gt;lead_thread = thread-&gt;group_leader; <br>
                process-&gt;n_pdds = 0; <br>
          @@ -1904,6 +1906,19 @@ kfd_process_gpuid_from_node(struct
          kfd_process *p, struct kfd_node *node, <br>
                return -EINVAL; <br>
            } <br>
            +static void signal_eviction_fence(struct kfd_process *p) <br>
          +{ <br>
          +    spin_lock(&amp;p-&gt;ef_lock); <br>
          +    if (!p-&gt;ef) <br>
          +        goto unlock_out; <br>
          +    dma_fence_signal(p-&gt;ef); <br>
        </blockquote>
        <br>
        This needs to grab the internal lock of the eviction fence, I'm
        not sure that has correct ordering with the newly added ef_lock.
        <br>
      </blockquote>
      <p>Hmm, the only thing we could get a circular lock dependency
        would be, if we took the p-&gt;ef_lock in a fence callback. I
        don't think that ever happens, because even the eviction work
        runs on a worker thread (exactly to avoid such lock dependency
        issues).</p>
      <p>Anyway, I could try to move the fence_signal out of the
        critical section. The lock is only there to ensure that exactly
        one process signals and frees the fence.</p>
    </blockquote>
    <br>
    So basically either the eviction worker or the GPU reset could
    signal this fence.<br>
    <br>
    In that case I think it would be simpler to grab the reset lock in
    the eviction worker to protect against a concurrent reset.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:da7010c1-6b11-41f6-986d-796539073451@amd.com">
      <pre>	spin_lock(&amp;p-&gt;ef_lock);
	ef = p-&gt;ef;
	WRITE_ONCE(p-&gt;ef, NULL);
	spin_unlock(&amp;p-&gt;ef_lock);
	if (ef) {
		dma_fence_signal(ef);
		dma_fence_put(ef);
	}
</pre>
      <p><br>
      </p>
      <blockquote type="cite"
        cite="mid:8e81a28a-5d50-44df-b441-6ceb2133c5e9@amd.com"> <br>
        <blockquote type="cite">+    dma_fence_put(p-&gt;ef); <br>
          +    WRITE_ONCE(p-&gt;ef, NULL); <br>
          + <br>
          +unlock_out: <br>
          +    spin_unlock(&amp;p-&gt;ef_lock); <br>
          +} <br>
          + <br>
            static void evict_process_worker(struct work_struct *work) <br>
            { <br>
                int ret; <br>
          @@ -1916,8 +1931,11 @@ static void evict_process_worker(struct
          work_struct *work) <br>
                 * lifetime of this thread, kfd_process p will be valid
          <br>
                 */ <br>
                p = container_of(dwork, struct kfd_process,
          eviction_work); <br>
          -    WARN_ONCE(p-&gt;last_eviction_seqno !=
          p-&gt;ef-&gt;seqno, <br>
          -          "Eviction fence mismatch\n"); <br>
          +    /* If the eviction fence is not valid, we're probably in
          a suspend <br>
          +     * or GPU reset cycle. There is nothing to do in this
          case. <br>
          +     */ <br>
          +    if (!READ_ONCE(p-&gt;ef)) <br>
          +        return; <br>
        </blockquote>
        <br>
        This evict process work is high level I don't think it should
        have any dependency on the GPU reset. <br>
      </blockquote>
      <p>Right. This is not here to avoid issues, just a short-cut to
        avoid unnecessary work.</p>
      <p>Regards,<br>
          Felix<br>
      </p>
      <p><br>
      </p>
      <blockquote type="cite"
        cite="mid:8e81a28a-5d50-44df-b441-6ceb2133c5e9@amd.com"> <br>
        Regards, <br>
        Christian. <br>
        <br>
        <blockquote type="cite">        /* Narrow window of overlap
          between restore and evict work <br>
                 * item is possible. Once
          amdgpu_amdkfd_gpuvm_restore_process_bos <br>
          @@ -1930,9 +1948,7 @@ static void evict_process_worker(struct
          work_struct *work) <br>
                pr_debug("Started evicting pasid 0x%x\n", p-&gt;pasid);
          <br>
                ret = kfd_process_evict_queues(p,
          KFD_QUEUE_EVICTION_TRIGGER_TTM); <br>
                if (!ret) { <br>
          -        dma_fence_signal(p-&gt;ef); <br>
          -        dma_fence_put(p-&gt;ef); <br>
          -        p-&gt;ef = NULL; <br>
          +        signal_eviction_fence(p); <br>
                    queue_delayed_work(kfd_restore_wq,
          &amp;p-&gt;restore_work, <br>
                            msecs_to_jiffies(PROCESS_RESTORE_TIME_MS));
          <br>
            @@ -1967,9 +1983,19 @@ static void
          restore_process_worker(struct work_struct *work) <br>
                  p-&gt;last_restore_timestamp = get_jiffies_64(); <br>
                /* VMs may not have been acquired yet during debugging.
          */ <br>
          -    if (p-&gt;kgd_process_info) <br>
          +    if (p-&gt;kgd_process_info) { <br>
          +        struct dma_fence *ef = NULL; <br>
          + <br>
                    ret =
          amdgpu_amdkfd_gpuvm_restore_process_bos(p-&gt;kgd_process_info,
          <br>
          -                                 &amp;p-&gt;ef); <br>
          +                                 &amp;ef); <br>
          +        if (!ret) { <br>
          +            spin_lock(&amp;p-&gt;ef_lock); <br>
          +            WARN_ONCE(p-&gt;ef, "Eviction fence is not
          NULL"); <br>
          +            WRITE_ONCE(p-&gt;ef, ef); <br>
          +            spin_unlock(&amp;p-&gt;ef_lock); <br>
          +        } <br>
          +    } <br>
          + <br>
                if (ret) { <br>
                    pr_debug("Failed to restore BOs of pasid 0x%x, retry
          after %d ms\n", <br>
                         p-&gt;pasid, PROCESS_BACK_OFF_TIME_MS); <br>
          @@ -1994,14 +2020,9 @@ void kfd_suspend_all_processes(void) <br>
                  WARN(debug_evictions, "Evicting all processes"); <br>
                hash_for_each_rcu(kfd_processes_table, temp, p,
          kfd_processes) { <br>
          -        cancel_delayed_work_sync(&amp;p-&gt;eviction_work); <br>
          -        flush_delayed_work(&amp;p-&gt;restore_work); <br>
          - <br>
                    if (kfd_process_evict_queues(p,
          KFD_QUEUE_EVICTION_TRIGGER_SUSPEND)) <br>
                        pr_err("Failed to suspend process 0x%x\n",
          p-&gt;pasid); <br>
          -        dma_fence_signal(p-&gt;ef); <br>
          -        dma_fence_put(p-&gt;ef); <br>
          -        p-&gt;ef = NULL; <br>
          +        signal_eviction_fence(p); <br>
                } <br>
                srcu_read_unlock(&amp;kfd_processes_srcu, idx); <br>
            } <br>
          diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c <br>
          index fe937670c927..aa6c34127be9 100644 <br>
          --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c <br>
          +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c <br>
          @@ -1869,7 +1869,7 @@ static void
          svm_range_restore_work(struct work_struct *work) <br>
                /* If validation failed, reschedule another attempt */ <br>
                if (evicted_ranges) { <br>
                    pr_debug("reschedule to restore svm range\n"); <br>
          -        schedule_delayed_work(&amp;svms-&gt;restore_work, <br>
          +        queue_delayed_work(system_freezable_wq,
          &amp;svms-&gt;restore_work, <br>
                       
          msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS)); <br>
                      kfd_smi_event_queue_restore_rescheduled(mm); <br>
          @@ -1945,7 +1945,7 @@ svm_range_evict(struct svm_range
          *prange, struct mm_struct *mm, <br>
                        pr_debug("failed to quiesce KFD\n"); <br>
                      pr_debug("schedule to restore svm %p ranges\n",
          svms); <br>
          -        schedule_delayed_work(&amp;svms-&gt;restore_work, <br>
          +        queue_delayed_work(system_freezable_wq,
          &amp;svms-&gt;restore_work, <br>
                       
          msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS)); <br>
                } else { <br>
                    unsigned long s, l; <br>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------n0jixrNNkQXCDcxzhVG3DC23--
