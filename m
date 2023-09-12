Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D751CA0ECA
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Sep 2023 07:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2875610E3A1;
	Tue, 12 Sep 2023 07:49:29 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2AD910E3A1
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Sep 2023 07:49:27 +0000 (UTC)
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-500a398cda5so8769938e87.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Sep 2023 00:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694504966; x=1695109766; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f0UziXyy01FN+IXyLH04zAH++qyGt2HfyUiwINizpLs=;
 b=KwEedj2AwtofFwD76jZLcHLv7xVTo2E8vn0514uG1aKzgjaO6zC7nvklLN32rkf32s
 yrfafZMNQ5hRgwHA0aS5iTAUjEA85F7QV5tPOSIZXnjzzioH1JMdPuh5QiUiPs7zolmN
 tEv/FBTd9Z4OsnDgqkProyQxpsWp7Jw5ZXRNbJBAVUZGFyfiDf/VNTsotjv3ZIHA/+02
 Goxxsaoo3rvKVQ9SyWvsdQf0ejFotFX6XX6U7DCuernDo2X3BEJxwvwXKIxnprrLPYRS
 aQ3qE92XV61rpA1nDenqFwpSKlkO1N8Vb2cL/G9FObkdmrwf8FT/D2rf33+/Pq26D+0N
 6gaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694504966; x=1695109766;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f0UziXyy01FN+IXyLH04zAH++qyGt2HfyUiwINizpLs=;
 b=vgVoOwwKDLd4QHyv61c2J2s6qKElOX8FYWBVrU6RGXxvw3KNGALDJq47kXz4r5PGpY
 NKL+498k+Cr7HibSHqwdIjX76Fvr3hUpKlGl3l4tfrgcig8IVAd+HQ5184ZNAdPa0EZE
 Ofi0blhdMsE7aWwi8RpLAejJYDamPgTrjGTT6Brr9B79EJgPC1gcRGrLpahD544mLRrc
 O7WdW9sTMDDN10cNQ1cFcsEnVg6bY4bg1FvaCa3+wyxa1wUziGlsAZNRIPJzUaCYj21T
 mWatCvxlwgVGLDIDPtp+iz+J4thzR1snjbTwRyflIIBiTgS39bzHcXi4YSGRAzLb1qk6
 tcBg==
X-Gm-Message-State: AOJu0YzI9ZNjOzOio/yh5CytnfYobkPoV/epmnrnepxPaT7wxgehG35n
 vqqxPw4nqKVW68sgRMvQGpni4Tjn5PyJcw==
X-Google-Smtp-Source: AGHT+IHfwocbO6NvKLgazd8gVWsaCvbdEpidiprsWEvziKviexuMepU0okcHcysNSvgPr90tkCwMWQ==
X-Received: by 2002:a05:6512:1313:b0:4fe:1681:9377 with SMTP id
 x19-20020a056512131300b004fe16819377mr11264679lfu.44.1694504965460; 
 Tue, 12 Sep 2023 00:49:25 -0700 (PDT)
Received: from [192.168.178.25] ([185.254.126.42])
 by smtp.gmail.com with ESMTPSA id
 ox13-20020a170907100d00b0099bd7b26639sm6435850ejb.6.2023.09.12.00.49.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 00:49:24 -0700 (PDT)
Message-ID: <824f66b8-7dc7-9141-801c-a290164d7c11@gmail.com>
Date: Tue, 12 Sep 2023 09:49:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 02/11] drm/amdgpu: rework gmc_v10_0_flush_gpu_tlb
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230905060415.1400-1-christian.koenig@amd.com>
 <20230905060415.1400-3-christian.koenig@amd.com>
 <bd980fec-3844-1338-7ef1-20c41481e33d@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <bd980fec-3844-1338-7ef1-20c41481e33d@amd.com>
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
Cc: shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.09.23 um 21:30 schrieb Felix Kuehling:
> On 2023-09-05 02:04, Christian König wrote:
>> Move the SDMA workaround necessary for Navi 1x into a higher layer.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  48 +++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |   5 +-
>>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c |   3 +
>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 159 ++++++-----------------
>>   4 files changed, 97 insertions(+), 118 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> index d78bd9732543..857051093900 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -575,6 +575,54 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct 
>> amdgpu_device *adev)
>>       return 0;
>>   }
>>   +void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t 
>> vmid,
>> +                  uint32_t vmhub, uint32_t flush_type)
>> +{
>> +    struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
>> +    struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
>> +    struct dma_fence *fence;
>> +    struct amdgpu_job *job;
>> +    int r;
>> +
>> +    if (!hub->sdma_invalidation_workaround || vmid ||
>
> The "|| vmid" part of the condition is new. AFAICT, the workaround was 
> applied to all VMIDs before this patch. Is this change intentional?

Yes, applying the workaround to anything else than VMID0 never worked in 
the first place.

Always using the KIQ on Navi 1x looked a bit like avoiding that problem.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>> + !adev->mman.buffer_funcs_enabled ||
>> +        !adev->ib_pool_ready || amdgpu_in_reset(adev) ||
>> +        !ring->sched.ready) {
>> +        adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid, vmhub,
>> +                           flush_type);
>> +        return;
>> +    }
>> +
>> +    /* The SDMA on Navi 1x has a bug which can theoretically result 
>> in memory
>> +     * corruption if an invalidation happens at the same time as an VA
>> +     * translation. Avoid this by doing the invalidation from the SDMA
>> +     * itself at least for GART.
>> +     */
>> +    mutex_lock(&adev->mman.gtt_window_lock);
>> +    r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.high_pr,
>> +                     AMDGPU_FENCE_OWNER_UNDEFINED,
>> +                     16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
>> +                     &job);
>> +    if (r)
>> +        goto error_alloc;
>> +
>> +    job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
>> +    job->vm_needs_flush = true;
>> +    job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
>> +    amdgpu_ring_pad_ib(ring, &job->ibs[0]);
>> +    fence = amdgpu_job_submit(job);
>> +    mutex_unlock(&adev->mman.gtt_window_lock);
>> +
>> +    dma_fence_wait(fence, false);
>> +    dma_fence_put(fence);
>> +
>> +    return;
>> +
>> +error_alloc:
>> +    mutex_unlock(&adev->mman.gtt_window_lock);
>> +    DRM_ERROR("Error flushing GPU TLB using the SDMA (%d)!\n", r);
>> +}
>> +
>>   /**
>>    * amdgpu_gmc_tmz_set -- check and set if a device supports TMZ
>>    * @adev: amdgpu_device pointer
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> index fdc25cd559b6..9e7df2f69123 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> @@ -117,6 +117,8 @@ struct amdgpu_vmhub {
>>         uint32_t    vm_contexts_disable;
>>   +    bool        sdma_invalidation_workaround;
>> +
>>       const struct amdgpu_vmhub_funcs *vmhub_funcs;
>>   };
>>   @@ -335,7 +337,6 @@ struct amdgpu_gmc {
>>       u64 noretry_flags;
>>   };
>>   -#define amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, type) 
>> ((adev)->gmc.gmc_funcs->flush_gpu_tlb((adev), (vmid), (vmhub), (type)))
>>   #define amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, type, allhub, 
>> inst) \
>>       ((adev)->gmc.gmc_funcs->flush_gpu_tlb_pasid \
>>       ((adev), (pasid), (type), (allhub), (inst)))
>> @@ -401,6 +402,8 @@ int amdgpu_gmc_ras_sw_init(struct amdgpu_device 
>> *adev);
>>   int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev);
>>   void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
>>   int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
>> +void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t 
>> vmid,
>> +                  uint32_t vmhub, uint32_t flush_type);
>>     extern void amdgpu_gmc_tmz_set(struct amdgpu_device *adev);
>>   extern void amdgpu_gmc_noretry_set(struct amdgpu_device *adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
>> index a041c6c970e1..8521c45e8f38 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
>> @@ -471,6 +471,9 @@ static void gfxhub_v2_0_init(struct amdgpu_device 
>> *adev)
>> GCVM_CONTEXT1_CNTL__WRITE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
>> GCVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
>>   +    /* TODO: This is only needed on some Navi 1x revisions */
>> +    hub->sdma_invalidation_workaround = true;
>> +
>>       hub->vmhub_funcs = &gfxhub_v2_0_vmhub_funcs;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index fa87a85e1017..1f70c57bcd69 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -230,20 +230,49 @@ static bool 
>> gmc_v10_0_get_atc_vmid_pasid_mapping_info(
>>    * by the amdgpu vm/hsa code.
>>    */
>>   -static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, 
>> uint32_t vmid,
>> -                   unsigned int vmhub, uint32_t flush_type)
>> +/**
>> + * gmc_v10_0_flush_gpu_tlb - gart tlb flush callback
>> + *
>> + * @adev: amdgpu_device pointer
>> + * @vmid: vm instance to flush
>> + * @vmhub: vmhub type
>> + * @flush_type: the flush type
>> + *
>> + * Flush the TLB for the requested page table.
>> + */
>> +static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, 
>> uint32_t vmid,
>> +                    uint32_t vmhub, uint32_t flush_type)
>>   {
>>       bool use_semaphore = gmc_v10_0_use_invalidate_semaphore(adev, 
>> vmhub);
>>       struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
>>       u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, 
>> flush_type);
>> -    u32 tmp;
>>       /* Use register 17 for GART */
>>       const unsigned int eng = 17;
>> -    unsigned int i;
>>       unsigned char hub_ip = 0;
>> +    u32 sem, req, ack;
>> +    unsigned int i;
>> +    u32 tmp;
>>   -    hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ?
>> -           GC_HWIP : MMHUB_HWIP;
>> +    sem = hub->vm_inv_eng0_sem + hub->eng_distance * eng;
>> +    req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
>> +    ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
>> +
>> +    /* flush hdp cache */
>> +    adev->hdp.funcs->flush_hdp(adev, NULL);
>> +
>> +    /* For SRIOV run time, driver shouldn't access the register 
>> through MMIO
>> +     * Directly use kiq to do the vm invalidation instead
>> +     */
>> +    if (adev->gfx.kiq[0].ring.sched.ready && !adev->enable_mes &&
>> +        (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
>> +        down_read_trylock(&adev->reset_domain->sem)) {
>> +        amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
>> +                1 << vmid);
>> +        up_read(&adev->reset_domain->sem);
>> +        return;
>> +    }
>> +
>> +    hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ? GC_HWIP : MMHUB_HWIP;
>>         spin_lock(&adev->gmc.invalidate_lock);
>>       /*
>> @@ -257,9 +286,7 @@ static void gmc_v10_0_flush_vm_hub(struct 
>> amdgpu_device *adev, uint32_t vmid,
>>       if (use_semaphore) {
>>           for (i = 0; i < adev->usec_timeout; i++) {
>>               /* a read return value of 1 means semaphore acuqire */
>> -            tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem +
>> -                     hub->eng_distance * eng, hub_ip);
>> -
>> +            tmp = RREG32_RLC_NO_KIQ(sem, hub_ip);
>>               if (tmp & 0x1)
>>                   break;
>>               udelay(1);
>> @@ -269,9 +296,7 @@ static void gmc_v10_0_flush_vm_hub(struct 
>> amdgpu_device *adev, uint32_t vmid,
>>               DRM_ERROR("Timeout waiting for sem acquire in VM 
>> flush!\n");
>>       }
>>   -    WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req +
>> -              hub->eng_distance * eng,
>> -              inv_req, hub_ip);
>> +    WREG32_RLC_NO_KIQ(req, inv_req, hub_ip);
>>         /*
>>        * Issue a dummy read to wait for the ACK register to be cleared
>> @@ -279,14 +304,11 @@ static void gmc_v10_0_flush_vm_hub(struct 
>> amdgpu_device *adev, uint32_t vmid,
>>        */
>>       if ((vmhub == AMDGPU_GFXHUB(0)) &&
>>           (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 3, 0)))
>> -        RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req +
>> -                  hub->eng_distance * eng, hub_ip);
>> +        RREG32_RLC_NO_KIQ(req, hub_ip);
>>         /* Wait for ACK with a delay.*/
>>       for (i = 0; i < adev->usec_timeout; i++) {
>> -        tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_ack +
>> -                  hub->eng_distance * eng, hub_ip);
>> -
>> +        tmp = RREG32_RLC_NO_KIQ(ack, hub_ip);
>>           tmp &= 1 << vmid;
>>           if (tmp)
>>               break;
>> @@ -296,109 +318,12 @@ static void gmc_v10_0_flush_vm_hub(struct 
>> amdgpu_device *adev, uint32_t vmid,
>>         /* TODO: It needs to continue working on debugging with 
>> semaphore for GFXHUB as well. */
>>       if (use_semaphore)
>> -        /*
>> -         * add semaphore release after invalidation,
>> -         * write with 0 means semaphore release
>> -         */
>> -        WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem +
>> -                  hub->eng_distance * eng, 0, hub_ip);
>> +        WREG32_RLC_NO_KIQ(sem, 0, hub_ip);
>>         spin_unlock(&adev->gmc.invalidate_lock);
>>   -    if (i < adev->usec_timeout)
>> -        return;
>> -
>> -    DRM_ERROR("Timeout waiting for VM flush hub: %d!\n", vmhub);
>> -}
>> -
>> -/**
>> - * gmc_v10_0_flush_gpu_tlb - gart tlb flush callback
>> - *
>> - * @adev: amdgpu_device pointer
>> - * @vmid: vm instance to flush
>> - * @vmhub: vmhub type
>> - * @flush_type: the flush type
>> - *
>> - * Flush the TLB for the requested page table.
>> - */
>> -static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, 
>> uint32_t vmid,
>> -                    uint32_t vmhub, uint32_t flush_type)
>> -{
>> -    struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
>> -    struct dma_fence *fence;
>> -    struct amdgpu_job *job;
>> -
>> -    int r;
>> -
>> -    /* flush hdp cache */
>> -    adev->hdp.funcs->flush_hdp(adev, NULL);
>> -
>> -    /* For SRIOV run time, driver shouldn't access the register 
>> through MMIO
>> -     * Directly use kiq to do the vm invalidation instead
>> -     */
>> -    if (adev->gfx.kiq[0].ring.sched.ready && !adev->enable_mes &&
>> -        (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
>> -        down_read_trylock(&adev->reset_domain->sem)) {
>> -        struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
>> -        const unsigned int eng = 17;
>> -        u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, 
>> flush_type);
>> -        u32 req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
>> -        u32 ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
>> -
>> -        amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
>> -                1 << vmid);
>> -
>> -        up_read(&adev->reset_domain->sem);
>> -        return;
>> -    }
>> -
>> -    mutex_lock(&adev->mman.gtt_window_lock);
>> -
>> -    if (vmhub == AMDGPU_MMHUB0(0)) {
>> -        gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_MMHUB0(0), 0);
>> -        mutex_unlock(&adev->mman.gtt_window_lock);
>> -        return;
>> -    }
>> -
>> -    BUG_ON(vmhub != AMDGPU_GFXHUB(0));
>> -
>> -    if (!adev->mman.buffer_funcs_enabled ||
>> -        !adev->ib_pool_ready ||
>> -        amdgpu_in_reset(adev) ||
>> -        ring->sched.ready == false) {
>> -        gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_GFXHUB(0), 0);
>> -        mutex_unlock(&adev->mman.gtt_window_lock);
>> -        return;
>> -    }
>> -
>> -    /* The SDMA on Navi has a bug which can theoretically result in 
>> memory
>> -     * corruption if an invalidation happens at the same time as an VA
>> -     * translation. Avoid this by doing the invalidation from the SDMA
>> -     * itself.
>> -     */
>> -    r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.high_pr,
>> -                     AMDGPU_FENCE_OWNER_UNDEFINED,
>> -                     16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
>> -                     &job);
>> -    if (r)
>> -        goto error_alloc;
>> -
>> -    job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
>> -    job->vm_needs_flush = true;
>> -    job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
>> -    amdgpu_ring_pad_ib(ring, &job->ibs[0]);
>> -    fence = amdgpu_job_submit(job);
>> -
>> -    mutex_unlock(&adev->mman.gtt_window_lock);
>> -
>> -    dma_fence_wait(fence, false);
>> -    dma_fence_put(fence);
>> -
>> -    return;
>> -
>> -error_alloc:
>> -    mutex_unlock(&adev->mman.gtt_window_lock);
>> -    DRM_ERROR("Error flushing GPU TLB using the SDMA (%d)!\n", r);
>> +    if (i >= adev->usec_timeout)
>> +        DRM_ERROR("Timeout waiting for VM flush hub: %d!\n", vmhub);
>>   }
>>     /**

