Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE53C3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 13:34:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 735E610E9C1;
	Thu, 10 Apr 2025 13:34:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SisBzGyQ";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CECD210E9C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 13:33:54 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-39c1efc4577so426496f8f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 06:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744292033; x=1744896833; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l5GCSq4BKRvR05oRoQmxaBBMFsnOW+wIYitM2GVY2rA=;
 b=SisBzGyQxBxLQb8qtQknnqZFi6PTnjBTEhXoxcjKFZ+fsbez0LT04XShOkgltrA+7Q
 Ht/LwYoAH+Mva6GTKie2CMPBuydoMMW8z1ohb47O9p5RRr682vmTa1vODmBxSZSwXBeN
 q4uSV1oAvTjSHri/fM19XfGT1vdcSFBVJcuKgPG/Xo4MLPr6OT5v9nR0QB2smu1lcERt
 AW67IktsrrkIK2Fagb5OIkB36TxaS+RQ/hTDi+I37BknML4P9VM6XgN8ooPn87rsvy0+
 MUSVNQdrunXVSjoTvPRz3HCJA/xwuph2abihERFBrgKfQ52yAgjfBXQCYX4W9/7frjCX
 BUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744292033; x=1744896833;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l5GCSq4BKRvR05oRoQmxaBBMFsnOW+wIYitM2GVY2rA=;
 b=VSSxJWVjxSGhnqa1lxw41m2mhZkJXdUiE4DLIsmoVNXS1cF+hBkKSGtyagU338+Qow
 kxr86t2ZUwVHRoFSGsAcNsOoude4QVEGSSpv9tTRJ7D/HJWMstbKaknkfoRAg1GLLVRe
 DoMJN/XSx6OrTu1crmIjYadamSJ24Y3tQpg70WQkCLAuc6ea+5XhRK7cz3arKbErlUty
 Y+kKF+cXeSuTFsn3cbqN840DrzyHwDLBbBuTU0jtoPg7VkBLuP6PZhbetTJsU+iYepXs
 Vdh0by4+FkyJ/jKdR7mi/c/I9Nmv3WkCdx5FD0HO7NbuIKBl2dHFoC/9KF41T9PwBkxX
 HerQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAkCL3PB5l5LCEvowPkxiaiw/+dHrQIwL/2/kYKyTSMjU329i5con7ko1yimo4zEBM1vbhdCCH@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyHakZbNK7WC0auWnIRFPTRnlmWfy9qXabFHxbZmixzTKqCpEo3
 nqxJ0T4Z1XUdnc4eZ9QYeL0T8pp7jM6lySgJrEkNY2y4H7x4/RqR6aimPCLg
X-Gm-Gg: ASbGncswusKQ1C8IjRgq+cyerJqIZSL9ixVfIB05kwc6Z6+4AlMarpATaOqsTiUpQd2
 mr2kYeSxM7LwoCihdqtrhm+jsiBZyLuUrqMspaOdarj76ezT7O1iBJ3GjMuVtcmYYXnlR8b3PcV
 ORWCws+TModOanW05CfII4/EPsHaVnsJyQRJYJN/F+mXhgDMLBUH7eb4Q6OoYIVpU8LkH3EiW73
 l/OsS7YtYCRiyzf8ptBfjSR1kg25iY19IVH+iOEDjA0Buh0kI5F/Uvau0j/Px8Nq7Cq2Q9bFVwX
 z+FWdTAR9sX12Ng0/HMBehLtHgES80saKVpNVdN8O8gyUHOKWgJcKvTPq+ZlDhnOjuAhmA==
X-Google-Smtp-Source: AGHT+IEvB2CgxwHLttYfDbsw2p3lcm5/zKU3xmc+ar+U+HDWv1T+3HlCqbOwTqtV5kFnUa1FrQLdEw==
X-Received: by 2002:a05:6000:1845:b0:39c:1257:feb9 with SMTP id
 ffacd0b85a97d-39d8f4efda7mr2551212f8f.57.1744292032975; 
 Thu, 10 Apr 2025 06:33:52 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d89362fcbsm4726553f8f.5.2025.04.10.06.33.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 06:33:52 -0700 (PDT)
Message-ID: <38054743-089a-4ae7-ad46-1e58fa294421@gmail.com>
Date: Thu, 10 Apr 2025 15:33:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: cleanup amdgpu_vm_flush v5
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250409104500.2169-1-christian.koenig@amd.com>
 <965773b6-40fd-481e-8699-ae7234cc1934@amd.com>
 <c2270a3b-943d-477d-9220-593e05631d82@amd.com>
 <65d607ab-3d65-4d08-9ac2-49f3228b195b@amd.com>
 <16c1d7dd-848c-4c5f-8581-c5d784029ee0@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <16c1d7dd-848c-4c5f-8581-c5d784029ee0@amd.com>
Content-Type: text/plain; charset=UTF-8
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.04.25 um 05:52 schrieb SRINIVASAN SHANMUGAM:
>
> On 4/9/2025 7:16 PM, SRINIVASAN SHANMUGAM wrote:
>>
>> On 4/9/2025 7:11 PM, SRINIVASAN SHANMUGAM wrote:
>>>
>>> On 4/9/2025 6:45 PM, SRINIVASAN SHANMUGAM wrote:
>>>>
>>>> On 4/9/2025 4:15 PM, Christian König wrote:
>>>>> This reverts commit c2cc3648ba517a6c270500b5447d5a1efdad5936. Turned out
>>>>> that this has some negative consequences for some workloads. Instead check
>>>>> if the cleaner shader should run directly.
>>>>>
>>>>> While at it remove amdgpu_vm_need_pipeline_sync(), we also check again
>>>>> if the VMID has seen a GPU reset since last use and the gds switch
>>>>> setiing can be handled more simply as well.
>>>>>
>>>>> Also remove some duplicate checks and re-order and document the code.
>>>>>
>>>>> v2: restructure the while function
>>>>> v3: fix logic error pointed out by Srini
>>>>> v4: fix typo in comment, fix crash caused by incorrect check
>>>>> v5: once more fix the logic
>>>>>
>>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>>> Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |  6 +-
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 94 ++++++++++----------------
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  5 +-
>>>>>   3 files changed, 39 insertions(+), 66 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>>> index 802743efa3b3..30b58772598c 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>>> @@ -189,10 +189,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>>>>       }
>>>>>         need_ctx_switch = ring->current_ctx != fence_ctx;
>>>>> -    if (ring->funcs->emit_pipeline_sync && job &&
>>>>> -        ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
>>>>> -         need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, job))) {
>>>>> -
>>>>> +    if ((job && (tmp = amdgpu_sync_get_fence(&job->explicit_sync))) ||
>>>>
>>>>
>>>> Direct assignment in if condition looks like may not be allowed, may be can we split this logic , something like below:?

You can do direct assignment in if condition if you put it into an extra (), but I agree that we should clean that up at some point.

Just not in this patch here since that is unrelated.

>>>>
>>>> /* Check if job is present and get the fence */
>>>> if (job) {
>>>>     tmp = amdgpu_sync_get_fence(&job->explicit_sync);
>>>> }
>>>>
>>>> /* Check if pipe sync is needed */
>>>> if ((tmp || (amdgpu_sriov_vf(adev) && need_ctx_switch))) {
>>>>     need_pipe_sync = true;
>>>>
>>>>
>>>>> +         (amdgpu_sriov_vf(adev) && need_ctx_switch)) {
>>>>>           need_pipe_sync = true;
>>>>>             if (tmp)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> index b5ddfcbbc9fc..8e99dbd70968 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> @@ -596,37 +596,6 @@ void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev)
>>>>>       }
>>>>>   }
>>>>>   -/**
>>>>> - * amdgpu_vm_need_pipeline_sync - Check if pipe sync is needed for job.
>>>>> - *
>>>>> - * @ring: ring on which the job will be submitted
>>>>> - * @job: job to submit
>>>>> - *
>>>>> - * Returns:
>>>>> - * True if sync is needed.
>>>>> - */
>>>>> -bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>>>>> -                  struct amdgpu_job *job)
>>>>> -{
>>>>> -    struct amdgpu_device *adev = ring->adev;
>>>>> -    unsigned vmhub = ring->vm_hub;
>>>>> -    struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>>>>> -
>>>>> -    if (job->vmid == 0)
>>>>> -        return false;
>>>>> -
>>>>> -    if (job->vm_needs_flush || ring->has_compute_vm_bug)
>>>>> -        return true;
>>>>> -
>>>>> -    if (ring->funcs->emit_gds_switch && job->gds_switch_needed)
>>>>> -        return true;
>>>>> -
>>>>> -    if (amdgpu_vmid_had_gpu_reset(adev, &id_mgr->ids[job->vmid]))
>>>>> -        return true;
>>>>> -
>>>>> -    return false;
>>>>> -}
>>>>> -
>>>>>   /**
>>>>>    * amdgpu_vm_flush - hardware flush the vm
>>>>>    *
>>>>> @@ -647,43 +616,49 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>>>>       unsigned vmhub = ring->vm_hub;
>>>>>       struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>>>>>       struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
>>>>> -    bool spm_update_needed = job->spm_update_needed;
>>>>> -    bool gds_switch_needed = ring->funcs->emit_gds_switch &&
>>>>> -        job->gds_switch_needed;
>>>>> -    bool vm_flush_needed = job->vm_needs_flush;
>>>>> -    bool cleaner_shader_needed = false;
>>>>> -    bool pasid_mapping_needed = false;
>>>>> -    struct dma_fence *fence = NULL;
>>>>> +    bool gds_switch_needed, vm_flush_needed, spm_update_needed,
>>>>> +         cleaner_shader_needed
>>>>
>>>>
>>>> I think, should we initialize the "cleaner_shader_needed" here, cleaner_shader_needed = false?
>>>>
>>>
>>> or somehow, try to move below to here?
>>>
>>> "     cleaner_shader_needed = adev->gfx.enable_cleaner_shader &&
>>>          ring->funcs->emit_cleaner_shader && job->base.s_fence &&
>>>          &job->base.s_fence->scheduled == isolation->spearhead;"?

Oh, yeah that's a good idea going to add that.

>>>
>>>>
>>>>> , pasid_mapping_needed;
>>>>> +    struct dma_fence *fence;
>>>>>       unsigned int patch;
>>>>>       int r;
>>>>>   +    /* First of all figure out what needs to be done */
>>>>>       if (amdgpu_vmid_had_gpu_reset(adev, id)) {
>>>>> +        need_pipe_sync = true;
>>>>>           gds_switch_needed = true;
>>>>>           vm_flush_needed = true;
>>>>>           pasid_mapping_needed = true;
>>>>>           spm_update_needed = true;
>>>>> +    } else {
>>>>> +        gds_switch_needed = job->gds_switch_needed;
>>>>> +        vm_flush_needed = job->vm_needs_flush;
>>>>> +        mutex_lock(&id_mgr->lock);
>>>>> +        pasid_mapping_needed = id->pasid != job->pasid ||
>>>>> +            !id->pasid_mapping ||
>>>>> +            !dma_fence_is_signaled(id->pasid_mapping);
>>>>> +        mutex_unlock(&id_mgr->lock);
>>>>> +        spm_update_needed = job->spm_update_needed;
>>>>> +        need_pipe_sync |= ring->has_compute_vm_bug || vm_flush_needed ||
>>>>> +            cleaner_shader_needed 
>>
>> Sorry here pls:
>>
>> "     cleaner_shader_needed = adev->gfx.enable_cleaner_shader &&
>>          ring->funcs->emit_cleaner_shader && job->base.s_fence &&
>>          &job->base.s_fence->scheduled == isolation->spearhead;"?
>>
>>
>>>>> || gds_switch_needed;
>>>>>       }
>>>>>   -    mutex_lock(&id_mgr->lock);
>>>>> -    if (id->pasid != job->pasid || !id->pasid_mapping ||
>>>>> -        !dma_fence_is_signaled(id->pasid_mapping))
>>>>> -        pasid_mapping_needed = true;
>>>>> -    mutex_unlock(&id_mgr->lock);
>>>>> -
>>>>> +    need_pipe_sync &= !!ring->funcs->emit_pipeline_sync;
>>>>>       gds_switch_needed &= !!ring->funcs->emit_gds_switch;
>>>>>       vm_flush_needed &= !!ring->funcs->emit_vm_flush &&
>>>>>               job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
>>>>>       pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
>>>>>           ring->funcs->emit_wreg;
>>>>> +    spm_update_needed &= !!adev->gfx.rlc.funcs->update_spm_vmid;
>>>>>         cleaner_shader_needed = adev->gfx.enable_cleaner_shader &&
>>>>>           ring->funcs->emit_cleaner_shader && job->base.s_fence &&
>>>>>           &job->base.s_fence->scheduled == isolation->spearhead;
>>>>>         if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
>>>>> -        !cleaner_shader_needed)
>>>>> +        !cleaner_shader_needed && !spm_update_needed)
>
>
> Here do we need to explicitly add this  "&& !spm_update_needed" check here along with the other checks pls? cz pipeline_sync is independent of "spm_update"?

It isn't really necessary I think, but it shouldn't hurt either. Going to add that.

Thanks,
Christian.

>
>
>>>>>           return 0;
>>>>>   +    /* Then actually prepare the submission frame */
>>>>>       amdgpu_ring_ib_begin(ring);
>>>>>       if (ring->funcs->init_cond_exec)
>>>>>           patch = amdgpu_ring_init_cond_exec(ring,
>>>>> @@ -703,23 +678,34 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>>>>       if (pasid_mapping_needed)
>>>>>           amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
>>>>>   -    if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
>>>>> +    if (spm_update_needed)
>>>>>           adev->gfx.rlc.funcs->update_spm_vmid(adev, ring, job->vmid);
>>>>>   -    if (ring->funcs->emit_gds_switch &&
>>>>> -        gds_switch_needed) {
>>>>> +    if (gds_switch_needed)
>>>>>           amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>>>>>                           job->gds_size, job->gws_base,
>>>>>                           job->gws_size, job->oa_base,
>>>>>                           job->oa_size);
>>>>> -    }
>>>>>         if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
>>>>>           r = amdgpu_fence_emit(ring, &fence, NULL, 0);
>>>>>           if (r)
>>>>>               return r;
>>>>> +    } else {
>>>>> +        fence = NULL;
>>>>> +    }
>>>>> +
>>>>> +    amdgpu_ring_patch_cond_exec(ring, patch);
>>>>> +
>>>>> +    /* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC */
>>>>> +    if (ring->funcs->emit_switch_buffer) {
>>>>> +        amdgpu_ring_emit_switch_buffer(ring);
>>>>> +        amdgpu_ring_emit_switch_buffer(ring);
>>>>>       }
>>>>>   +    amdgpu_ring_ib_end(ring);
>>>>> +
>>>>> +    /* And finally remember what the ring has executed */
>>>>>       if (vm_flush_needed) {
>>>>>           mutex_lock(&id_mgr->lock);
>>>>>           dma_fence_put(id->last_flush);
>>>>> @@ -749,16 +735,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>>>> mutex_unlock(&adev->enforce_isolation_mutex);
>>>>>       }
>>>>>       dma_fence_put(fence);
>>>>> -
>>>>> -    amdgpu_ring_patch_cond_exec(ring, patch);
>>>>> -
>>>>> -    /* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC */
>>>>> -    if (ring->funcs->emit_switch_buffer) {
>>>>> -        amdgpu_ring_emit_switch_buffer(ring);
>>>>> -        amdgpu_ring_emit_switch_buffer(ring);
>>>>> -    }
>>>>> -
>>>>> -    amdgpu_ring_ib_end(ring);
>>>>>       return 0;
>>>>>   }
>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> index daa2f9b33620..e9ecdb96bafa 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> @@ -493,7 +493,8 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>>>                  struct ww_acquire_ctx *ticket,
>>>>>                  int (*callback)(void *p, struct amdgpu_bo *bo),
>>>>>                  void *param);
>>>>> -int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
>>>>> +int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>>>> +            bool need_pipe_sync);
>>>>>   int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>>>>                 struct amdgpu_vm *vm, bool immediate);
>>>>>   int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>>>>> @@ -550,8 +551,6 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
>>>>>                  uint32_t fragment_size_default, unsigned max_level,
>>>>>                  unsigned max_bits);
>>>>>   int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>>>>> -bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>>>>> -                  struct amdgpu_job *job);
>>>>>   void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
>>>>>     struct amdgpu_task_info *

