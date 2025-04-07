Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B790C36010
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 12:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32C7910E43F;
	Mon,  7 Apr 2025 12:14:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TmNirDU0";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88D3310E43F
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 12:14:57 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-39727fe912cso1828900f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Apr 2025 05:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744028096; x=1744632896; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tm7tWjFWp9yQ4QnKo7mnz5RtEwktlZ6v2AHHQQ5fU7c=;
 b=TmNirDU0XhJh1xucovfPpx3n/3DT2bKcbjEhHRCfwyI058Ub/t86yRZ7Y9YY9YHwgb
 E/f6CzMHnV9rjwkiOMNvZ9bbL9goXykj4Oz+I9bhvH6BEb0xJXl3Wzw2orN+agZx83iT
 8+dnQ5Ll7Sxu+5gMOiWJ7G5PhVTJem4bzBrs7PIxHkPukCI9CQ0jbefNmxi22FkNdufz
 ha85L5ZesFeXOHXrjmvJbVM9VvP/Ua8N4IXR6dyWb/9dF9ZvtsEvcpQzSyovOJ9PZluz
 Sx4XdZQgB1H23F92LgfLObtzt6Xel3Ecqwh2KW9qZXFnwkFGa/i69mlUvnTfREd4AjW2
 TSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744028096; x=1744632896;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tm7tWjFWp9yQ4QnKo7mnz5RtEwktlZ6v2AHHQQ5fU7c=;
 b=Av1bmtDRicvtEoTc/AYDKb+ax4aFbmQ1gSZfqanxxaX6MaIBH+6JzmLJONlDb9V9Wu
 RqjCA5b1jSxS3xa2TkEmtdTyVWaLuNCTjKrYsqxMZkKqQMzXtm6CmzFAcOMMZZ2W4/6N
 a7gmCDmfSG1R51DMjoxTUO7gdam4bdvHMymIOkXzu43bUwwq4TC/6cQgf3DXWdtQnHRy
 NTUdVXcmojzNdlN0hgDSmzgIelSPOtaXSvJj009Tbc67TssIi5gAWtijMXSTQvr/6nS4
 A+xODun5/DzykGl0BEU1fEIBHDmADECrAZTW2TG1ZJU3dIZNyFQMSQV26LaZlVvHrJjI
 kgmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJLw7cSIHp2/czuf7SsWkXgpmOvGhc2fRnR/9fjHrl68ftyKBGz4aIU2kNBqunzgLBf3iErjMT@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgLf38c5ld/2eA7t0QFRLtrWasHspMRaYD9DELaOelCfeMfQbf
 p1UHdiGs3Zpk9BTZjS5b+a/gjeL+qS7QBFOrUZ6lHFaRFMvEVL6W
X-Gm-Gg: ASbGncuyi8Wukyi1NzO/X1iaVOUz5tfVmc8vutr/cBnpsfKjPWZtBN+Rdq4keGfpw0x
 /MoaCVLFhJzLCmzMBhHIzYeoH3rXXXXS0O7XaVBiFykQATF8CIEKQ1d7Fkgcf3YCxSOyw4hQ+hq
 MCH+PID1F6ppySuZVDAMHGEazA4aPvoFyRZFNFKrOracKsOdrcgN/jPjPrlOokp+7reAgrCrgUI
 I/aK3tFAFVlg9ENRb8Z27aw+9OJOHpLUL9gp+sfYA8ZX26QdhHzKCxXkJC0fbdCKPmLdns+ovRD
 I1we0Y1bJyJfwvC+2PmX6sSZUS3qD8GvT1dlQKjcv5vIU5OzHGzBTFPKRq9gT6FWnAGsa0qs7Q=
 =
X-Google-Smtp-Source: AGHT+IHaZWcxS3rqRt1pCKgccprSEKmXeXFep3dwNo+yH8uWA6cJTFYo+2EKbzjsV1asfqw50T664Q==
X-Received: by 2002:a05:6000:2cd:b0:39c:266c:423 with SMTP id
 ffacd0b85a97d-39d6fb684dbmr6965656f8f.0.1744028095793; 
 Mon, 07 Apr 2025 05:14:55 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30096896sm12059055f8f.19.2025.04.07.05.14.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 05:14:55 -0700 (PDT)
Message-ID: <e43dc724-0ede-4b3b-abd9-5654cf1ccb9d@gmail.com>
Date: Mon, 7 Apr 2025 14:14:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: cleanup amdgpu_vm_flush v3
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250404141607.1451-1-christian.koenig@amd.com>
 <20250404141607.1451-2-christian.koenig@amd.com>
 <5e33847e-de9a-4635-98cb-dbec36653042@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <5e33847e-de9a-4635-98cb-dbec36653042@amd.com>
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

Am 05.04.25 um 09:32 schrieb SRINIVASAN SHANMUGAM:
>
> On 4/4/2025 7:46 PM, Christian König wrote:
>> This reverts commit c2cc3648ba517a6c270500b5447d5a1efdad5936. Turned out
>> that this has some negative consequences for some workloads. Instead check
>> if the cleaner shader should run directly.
>>
>> While at it remove amdgpu_vm_need_pipeline_sync(), we also check again
>> if the VMID has seen a GPU reset since last use and the gds switch
>> setiing can be handled more simply as well.
>>
>> Also remove some duplicate checks and re-order and document the code.
>>
>> v2: restructure the while function
>> v3: fix logic error pointed out by Srini
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |  3 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 92 +++++++++-----------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  5 +-
>>   3 files changed, 36 insertions(+), 64 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> index 802743efa3b3..ff2ca984279a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> @@ -191,8 +191,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>       need_ctx_switch = ring->current_ctx != fence_ctx;
>>       if (ring->funcs->emit_pipeline_sync && job &&
>>           ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
>> -         need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, job))) {
>> -
>> +         (amdgpu_sriov_vf(adev) && need_ctx_switch))) {
>>           need_pipe_sync = true;
>>             if (tmp)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index b5ddfcbbc9fc..e6d7db8d40cd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -596,37 +596,6 @@ void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev)
>>       }
>>   }
>>   -/**
>> - * amdgpu_vm_need_pipeline_sync - Check if pipe sync is needed for job.
>> - *
>> - * @ring: ring on which the job will be submitted
>> - * @job: job to submit
>> - *
>> - * Returns:
>> - * True if sync is needed.
>> - */
>> -bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>> -                  struct amdgpu_job *job)
>> -{
>> -    struct amdgpu_device *adev = ring->adev;
>> -    unsigned vmhub = ring->vm_hub;
>> -    struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>> -
>> -    if (job->vmid == 0)
>> -        return false;
>> -
>> -    if (job->vm_needs_flush || ring->has_compute_vm_bug)
>> -        return true;
>> -
>> -    if (ring->funcs->emit_gds_switch && job->gds_switch_needed)
>> -        return true;
>> -
>> -    if (amdgpu_vmid_had_gpu_reset(adev, &id_mgr->ids[job->vmid]))
>> -        return true;
>> -
>> -    return false;
>> -}
>> -
>>   /**
>>    * amdgpu_vm_flush - hardware flush the vm
>>    *
>> @@ -647,29 +616,31 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>       unsigned vmhub = ring->vm_hub;
>>       struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>>       struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
>> -    bool spm_update_needed = job->spm_update_needed;
>> -    bool gds_switch_needed = ring->funcs->emit_gds_switch &&
>> -        job->gds_switch_needed;
>> -    bool vm_flush_needed = job->vm_needs_flush;
>> -    bool cleaner_shader_needed = false;
>> -    bool pasid_mapping_needed = false;
>> -    struct dma_fence *fence = NULL;
>> +    bool gds_switch_needed, vm_flush_needed, spm_update_needed,
>> +         cleaner_shader_needed, pasid_mapping_needed;
>> +    struct dma_fence *fence;
>>       unsigned int patch;
>>       int r;
>>   +    /* First of all figure out what needs to be done */
>>       if (amdgpu_vmid_had_gpu_reset(adev, id)) {
>> +        need_pipe_sync = true;
>>           gds_switch_needed = true;
>>           vm_flush_needed = true;
>>           pasid_mapping_needed = true;
>>           spm_update_needed = true;
>> +    } else {
>> +        need_pipe_sync |= ring->has_compute_vm_bug;
>> +        gds_switch_needed = job->gds_switch_needed;
>
>
> *[1]:* Should we need to check along with "ring->funcs->emit_gds_switch"
> ie., "ring->funcs->emit_gds_switch && job->gds_switch_needed;" here?

No, see below.

>
>
>> +        vm_flush_needed = job->vm_needs_flush;
>> +        mutex_lock(&id_mgr->lock);
>> +        if (id->pasid != job->pasid || !id->pasid_mapping ||
>> +            !dma_fence_is_signaled(id->pasid_mapping))
>> +            pasid_mapping_needed = true;
>> +        mutex_unlock(&id_mgr->lock);
>> +        spm_update_needed = job->spm_update_needed;
>>       }
>>   -    mutex_lock(&id_mgr->lock);
>> -    if (id->pasid != job->pasid || !id->pasid_mapping ||
>> -        !dma_fence_is_signaled(id->pasid_mapping))
>> -        pasid_mapping_needed = true;
>> -    mutex_unlock(&id_mgr->lock);
>> -
>>       gds_switch_needed &= !!ring->funcs->emit_gds_switch;

That check is here.

>>       vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
>>               job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
>> @@ -681,15 +652,17 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>           &job->base.s_fence->scheduled == isolation->spearhead;
>>         if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
>> -        !cleaner_shader_needed)
>> +        !cleaner_shader_needed && !spm_update_needed)
>>           return 0;
>>   +    /* Then aktually prepare the submission frame */
>
>
> *[2]:* Could you pls correct the typo?

Mhm, I thought I already did that.

Ok, going to fix it now.

>
>
>>       amdgpu_ring_ib_begin(ring);
>>       if (ring->funcs->init_cond_exec)
>>           patch = amdgpu_ring_init_cond_exec(ring,
>>                              ring->cond_exe_gpu_addr);
>>   -    if (need_pipe_sync)
>> +    if (need_pipe_sync || vm_flush_needed || cleaner_shader_needed ||
>> +        gds_switch_needed)
>
>
> *[3]:* Can we check even for *spm_update_needed* alongside the other conditions, that might need Pipeline Sync here?, Cz in an environment where multiple jobs might be accessing or modifying shared data (especially in gang submissions), ensuring that all operations (including SPM updates) are completed before executing further commands, to prevent using stale or invalid data.

No, the SPM update is intentionally left out here since those shouldn't interfere with the pipeline sync.

Regards,
Christian.

>
>
>>           amdgpu_ring_emit_pipeline_sync(ring);
>>         if (cleaner_shader_needed)
>> @@ -706,20 +679,31 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>       if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
>>           adev->gfx.rlc.funcs->update_spm_vmid(adev, ring, job->vmid);
>>   -    if (ring->funcs->emit_gds_switch &&
>> -        gds_switch_needed) {
>> +    if (gds_switch_needed)
>>           amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>>                           job->gds_size, job->gws_base,
>>                           job->gws_size, job->oa_base,
>>                           job->oa_size);
>> -    }
>>         if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
>>           r = amdgpu_fence_emit(ring, &fence, NULL, 0);
>>           if (r)
>>               return r;
>> +    } else {
>> +        fence = NULL;
>> +    }
>> +
>> +    amdgpu_ring_patch_cond_exec(ring, patch);
>> +
>> +    /* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC */
>> +    if (ring->funcs->emit_switch_buffer) {
>> +        amdgpu_ring_emit_switch_buffer(ring);
>> +        amdgpu_ring_emit_switch_buffer(ring);
>>       }
>>   +    amdgpu_ring_ib_end(ring);
>> +
>> +    /* And finally remember what the ring has executed */
>>       if (vm_flush_needed) {
>>           mutex_lock(&id_mgr->lock);
>>           dma_fence_put(id->last_flush);
>> @@ -749,16 +733,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>           mutex_unlock(&adev->enforce_isolation_mutex);
>>       }
>>       dma_fence_put(fence);
>> -
>> -    amdgpu_ring_patch_cond_exec(ring, patch);
>> -
>> -    /* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC */
>> -    if (ring->funcs->emit_switch_buffer) {
>> -        amdgpu_ring_emit_switch_buffer(ring);
>> -        amdgpu_ring_emit_switch_buffer(ring);
>> -    }
>> -
>> -    amdgpu_ring_ib_end(ring);
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index daa2f9b33620..e9ecdb96bafa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -493,7 +493,8 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>                  struct ww_acquire_ctx *ticket,
>>                  int (*callback)(void *p, struct amdgpu_bo *bo),
>>                  void *param);
>> -int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
>> +int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>> +            bool need_pipe_sync);
>>   int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>                 struct amdgpu_vm *vm, bool immediate);
>>   int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>> @@ -550,8 +551,6 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
>>                  uint32_t fragment_size_default, unsigned max_level,
>>                  unsigned max_bits);
>>   int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>> -bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>> -                  struct amdgpu_job *job);
>>   void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
>>     struct amdgpu_task_info *

