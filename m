Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4491EC25B48
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 06:06:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE29410E764;
	Thu, 26 Oct 2023 06:06:55 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9EBE10E764
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 06:06:53 +0000 (UTC)
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c515527310so6974541fa.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 23:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698300412; x=1698905212; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TIszNxHiju3qruj3kc1ktBnamAW1fw8Ko329FMb5p58=;
 b=lVPWoWwxy1JwcFP5jXoj+2ZlL3XohMA04TFEVgclM5YudwO8lVOblYcKrIGvihiXOH
 X9wiWrgF0v1buvoJLDruaqWC7jdeuzPsQTMf0S+ky1Jmcf3vqpN6B+Mglqv0D9lakkNP
 NsHgsh3Rlca9nr3UWFR49oWlS3jlC8FLnH0rql4Dax0tj4HiL0Nv5GKa618yiPRg6vOq
 xzR8X7eKGz7/eP2LTXlh7ZQfZqwtCdSvdN99MxIEoUh3Rm1p5eTc0MCpkhcOs4BSgEdx
 HDOhvlI179RN9fB15o+NzwwH2iOxblsCwpXQbRbKnuadSFHCAArSUcXFtBF0pVdrQfI1
 tVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698300412; x=1698905212;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TIszNxHiju3qruj3kc1ktBnamAW1fw8Ko329FMb5p58=;
 b=dyZI0ZLDjCuKOWxrE+t/MXdET6Yty8fNff/ED4K5JDvFZBE2sxsUomSNR1Oh2Gfikr
 mezKFQEFlcjnScxQ9TZb9y0bcWwskHh0MnS+OUKyHZ+FVdWPvDkzH7iNFOng8vTUbruY
 pT9x0FObU8pZQH6Sa2w8fVXRLNtqKioAdGHZUetrv3Z6XQE1Y1KsY8P0uuPztL0HMOaZ
 Q5/54r0+ztWKZj5rZAcfR9kgL3GFE6rJEAOXiU8HopBFQWASSjGC+nP5x7V0iYxEcUbA
 I0+cImTb/C+q4rqezwZ3/8DOvlC51WyZG+rl8ebnhO3svTMhpyAV7WBdmpR4VG0iOFoY
 unUQ==
X-Gm-Message-State: AOJu0YzwibnQw3n4IQ21UH9q5F2jIimBbOD0++0dShFn6HSK7r5N4VkR
 0el1eiAthGjmxYp6K9dEfX0=
X-Google-Smtp-Source: AGHT+IFNJpWeJPclpWU/uxK5MIHfXuy0mI69waMCi6rVUmZE3ftXaxRD7ugttMHt5iNaCCgNJGxTmg==
X-Received: by 2002:a2e:9904:0:b0:2c5:a6e:4bcc with SMTP id
 v4-20020a2e9904000000b002c50a6e4bccmr12721677lji.39.1698300411643; 
 Wed, 25 Oct 2023 23:06:51 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 o19-20020a05600c511300b003fe15ac0934sm1915602wms.1.2023.10.25.23.06.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 23:06:51 -0700 (PDT)
Message-ID: <530aac57-5561-4d1d-879a-93b108e5c8c2@gmail.com>
Date: Thu, 26 Oct 2023 08:06:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/amdgpu: Acquire ttm locks for dmaunmap
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231024192043.400319-1-David.Francis@amd.com>
 <ebed6ec6-df71-479a-9604-aaf507b340a5@gmail.com>
 <d2d2b06a-6b88-4340-be70-3473d25b833e@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <d2d2b06a-6b88-4340-be70-3473d25b833e@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.10.23 um 20:45 schrieb Felix Kuehling:
> On 2023-10-25 02:12, Christian König wrote:
>> Am 24.10.23 um 21:20 schrieb David Francis:
>>> dmaunmap can call ttm_bo_validate, which expects the
>>> ttm dma_resv to be held.
>>
>> Well first of all the dma_resv object isn't related to TTM.
>>
>>>
>>> Acquire the locks in amdgpu_amdkfd_gpuvm_dmaunmap_mem.
>>>
>>> Because the dmaunmap step can now fail, two new numbers
>>> need to be tracked. n_dmaunmap_success tracks the number
>>> of devices that have completed dmaunmap. If a device fails
>>> to dmaunmap due to a signal interrupt, n_dmaunmap_bos tracks
>>> the number of bos on that device that were successfully
>>> dmaunmapped.
>>>
>>> Track those values in struct kgd_mem.
>>>
>>> This failure can also cause the sync_memory step of the ioctl
>>> to be repeated; it is idempotent, so this should not cause any issues.
>>>
>>> Signed-off-by: David Francis <David.Francis@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  6 ++++-
>>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 23 
>>> +++++++++++++++----
>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 19 ++++++++++-----
>>>   3 files changed, 37 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> index 3ad8dc523b42..c60564ec4312 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> @@ -86,6 +86,10 @@ struct kgd_mem {
>>>         bool aql_queue;
>>>       bool is_imported;
>>> +
>>> +    /* Used to track successful dmaunmap across retries in unmap 
>>> ioctl */
>>> +    uint32_t n_dmaunmap_success;
>>> +    uint32_t n_dmaunmap_bos;
>>>   };
>>>     /* KFD Memory Eviction */
>>> @@ -302,7 +306,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct 
>>> amdgpu_device *adev,
>>>                         struct kgd_mem *mem, void *drm_priv);
>>>   int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>>>           struct amdgpu_device *adev, struct kgd_mem *mem, void 
>>> *drm_priv);
>>> -void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void 
>>> *drm_priv);
>>> +int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void 
>>> *drm_priv);
>>>   int amdgpu_amdkfd_gpuvm_sync_memory(
>>>           struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
>>>   int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 54f31a420229..c431132d7cc1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -2102,21 +2102,36 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>>>       return ret;
>>>   }
>>>   -void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void 
>>> *drm_priv)
>>> +int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void 
>>> *drm_priv)
>>>   {
>>>       struct kfd_mem_attachment *entry;
>>>       struct amdgpu_vm *vm;
>>> +    int ret;
>>> +    int i = 0;
>>>         vm = drm_priv_to_vm(drm_priv);
>>>         mutex_lock(&mem->lock);
>>>         list_for_each_entry(entry, &mem->attachments, list) {
>>> -        if (entry->bo_va->base.vm == vm)
>>> -            kfd_mem_dmaunmap_attachment(mem, entry);
>>> -    }
>>> +        if (i >= mem->n_dmaunmap_bos) {
>>> +            ret = amdgpu_bo_reserve(entry->bo_va->base.bo, false);
>>> +            if (ret) {
>>> +                mem->n_dmaunmap_bos = i;
>>> +                goto out;
>>> +            }
>>> +
>>> +            if (entry->bo_va->base.vm == vm)
>>> +                kfd_mem_dmaunmap_attachment(mem, entry);
>>>   + amdgpu_bo_unreserve(entry->bo_va->base.bo);
>>> +        }
>>> +        i++;
>>> +    }
>>
>> WOW, big NAK to that!
>>
>> You are essentially re-inventing the locking multiple BOs at the same 
>> time, please don't do that. Instead use dma_exec or ttm_exec_buf for 
>> that.
>
> I don't think that's the intention here. We're not locking multiple 
> BOs at the same time. The purpose of all this counting is to safely 
> handle ioctl restart for signal handling without dmaunmapping the same 
> thing twice.

Well, it's not mandatory to lock multiple BOs at the same time but it 
solves the problem that this shouldn't be interrupted.

>
> That said, I'm not a fan of this counting approach either and 
> suggested a simpler way of doing this by adding a flag in the 
> kfd_mem_attachment structure.

When we look strictly at the rules for IOCTLs and restarting them then 
that counting approach is not really allowed either.

Kernel operations should either completely fail, fully complete or 
explicitly return how much they completed (e.g. how many bytes 
transferred for example). That we only partially complete and track that 
state inside the kernel is usually a no-go.

That said is it possible that userspace tries to do this operation 
twice? If yes what happens?

For this local problem the alternative to using drm_exec or ttm_exec_* 
would be to use non-interruptible waits#.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> This also avoids all the fail handling.
>>
>> Regards,
>> Christian.
>>
>>> +    mem->n_dmaunmap_bos = 0;
>>> +out:
>>>       mutex_unlock(&mem->lock);
>>> +    return ret;
>>>   }
>>>     int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> index 06988cf1db51..66dee67ad859 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> @@ -1366,7 +1366,7 @@ static int 
>>> kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>>>   {
>>>       struct kfd_ioctl_unmap_memory_from_gpu_args *args = data;
>>>       struct kfd_process_device *pdd, *peer_pdd;
>>> -    void *mem;
>>> +    struct kgd_mem *mem;
>>>       long err = 0;
>>>       uint32_t *devices_arr = NULL, i;
>>>       bool flush_tlb;
>>> @@ -1400,7 +1400,7 @@ static int 
>>> kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>>>           goto bind_process_to_device_failed;
>>>       }
>>>   -    mem = kfd_process_device_translate_handle(pdd,
>>> +    mem = (struct kgd_mem *)kfd_process_device_translate_handle(pdd,
>>>                           GET_IDR_HANDLE(args->handle));
>>>       if (!mem) {
>>>           err = -ENOMEM;
>>> @@ -1414,7 +1414,7 @@ static int 
>>> kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>>>               goto get_mem_obj_from_handle_failed;
>>>           }
>>>           err = amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>>> -            peer_pdd->dev->adev, (struct kgd_mem *)mem, 
>>> peer_pdd->drm_priv);
>>> +            peer_pdd->dev->adev, mem, peer_pdd->drm_priv);
>>>           if (err) {
>>>               pr_err("Failed to unmap from gpu %d/%d\n",
>>>                      i, args->n_devices);
>>> @@ -1426,7 +1426,7 @@ static int 
>>> kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>>>       flush_tlb = kfd_flush_tlb_after_unmap(pdd->dev->kfd);
>>>       if (flush_tlb) {
>>>           err = amdgpu_amdkfd_gpuvm_sync_memory(pdd->dev->adev,
>>> -                (struct kgd_mem *) mem, true);
>>> +                mem, true);
>>>           if (err) {
>>>               pr_debug("Sync memory failed, wait interrupted by user 
>>> signal\n");
>>>               goto sync_memory_failed;
>>> @@ -1434,7 +1434,7 @@ static int 
>>> kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>>>       }
>>>         /* Flush TLBs after waiting for the page table updates to 
>>> complete */
>>> -    for (i = 0; i < args->n_devices; i++) {
>>> +    for (i = mem->n_dmaunmap_success; i < args->n_devices; i++) {
>>>           peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
>>>           if (WARN_ON_ONCE(!peer_pdd))
>>>               continue;
>>> @@ -1442,8 +1442,14 @@ static int 
>>> kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>>>               kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
>>>             /* Remove dma mapping after tlb flush to avoid 
>>> IO_PAGE_FAULT */
>>> -        amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv);
>>> +        err = amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, 
>>> peer_pdd->drm_priv);
>>> +        if (err) {
>>> +            pr_debug("DMA unmapping failed, acquire interrupted by 
>>> user signal\n");
>>> +            goto dmaunmap_failed;
>>> +        }
>>> +        mem->n_dmaunmap_success = i+1;
>>>       }
>>> +    mem->n_dmaunmap_success = 0;
>>>         mutex_unlock(&p->mutex);
>>>   @@ -1455,6 +1461,7 @@ static int 
>>> kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>>>   get_mem_obj_from_handle_failed:
>>>   unmap_memory_from_gpu_failed:
>>>   sync_memory_failed:
>>> +dmaunmap_failed:
>>>       mutex_unlock(&p->mutex);
>>>   copy_from_user_failed:
>>>       kfree(devices_arr);
>>

