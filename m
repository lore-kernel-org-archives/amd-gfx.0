Return-Path: <SRS0=AM0C=PC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0809C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Oct 2021 17:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A725361152
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Oct 2021 17:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A725361152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 314A06E1A4;
	Thu, 14 Oct 2021 17:14:36 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADA3C6E1A4
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Oct 2021 17:14:34 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 n40-20020a05600c3ba800b0030da2439b21so68999wms.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Oct 2021 10:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=jma+RRB/JEjhJnPIEyqcuLNmdQvSz0TeXJF1pp4DlRo=;
 b=GY2xEnlrNE/oAaP6JJgF2ziscv6eCPfF1htI571cc1/zBcK0MlvpNozLH57UfA1n+/
 gpvYXla0sVovFMy7YA3Bl5U7doKcpnTJoIMpNEKfsvMRC/YhyE15jDHJGcti4JkSc3+l
 B/cQOEHm3ZIvgrWia/EqHbLOuGE9g7FxyDg0snQ/gTaRopE9FU2/cI14GKcIUK/Rf8HS
 0+/Y6seEiHhBZm9/plDB+BcgFdPJvuHBa6/rB+F9qwiJgbspyK3dgHqiaua9jI+depxJ
 9EMtj1Gc3nKzsn6mzim7XQMs6/pXkJAHXebQezGw/LyZ83TFVtIqmFKSa908jxXzKmIE
 MEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=jma+RRB/JEjhJnPIEyqcuLNmdQvSz0TeXJF1pp4DlRo=;
 b=iG6TuOdduWFGxsoHfkdFXaKLz4qb11EX8tXLUBxhGD8Roc4yvhGcmTHAwlFhLawpac
 Y2zQ0cXDRbA17cuI9VE4iQOu4s0oSRgXNQmp2FzWFg07k0zud3nAsGAxkbAyxG5mMXmO
 OFJ8PUHZ0MDUyqFnXxclXMpa9SxUC9YNjJEYYkF4h4qLOsedcOAfkNyUhTFPq7/TxSYQ
 p1G5y5tHEvf0Ne43JEDZ1ld9JlCssRozbO/JCltSaQ8BdUwa+DJ+5/8W9PhJzWmMGFeg
 dgaMCxnN6GfzdJkk1j2GIj54jKQdf1jZsNJEEExFP1230noYUS5Ua5nn9Z50PjCTO1DZ
 orHw==
X-Gm-Message-State: AOAM533uX0soKlfjo8hgsQZeiEXs2bNqRtIuPtrD5gyerMP40s/nRat3
 1wA12MKDiFe5EApRzF6AVEQ=
X-Google-Smtp-Source: ABdhPJzuU1HWYte1qkMwYwMJgQnCge6kL7YGSruybDoCVRVQ6vUV3B3zuqPFXVxLAJcj2emfE7m/XQ==
X-Received: by 2002:a1c:29c2:: with SMTP id p185mr20715361wmp.43.1634231673095; 
 Thu, 14 Oct 2021 10:14:33 -0700 (PDT)
Received: from ?IPv6:2a02:8109:333f:edd8:ab97:c24:6a8b:9407?
 ([2a02:8109:333f:edd8:ab97:c24:6a8b:9407])
 by smtp.gmail.com with ESMTPSA id k17sm8991826wmj.0.2021.10.14.10.14.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Oct 2021 10:14:32 -0700 (PDT)
Subject: Re: [PATCH] drm/amdkfd: Separate pinned BOs destruction from general
 routine
To: "Yu, Lang" <Lang.Yu@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>
References: <20211011085837.611326-1-lang.yu@amd.com>
 <9902c8e8-bd54-d750-2030-7065e91201b2@amd.com>
 <DM6PR12MB42503869EEEA54190E29A531FBB89@DM6PR12MB4250.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <41874e7f-305d-7be2-e8ca-a9a69e47c8c6@gmail.com>
Date: Thu, 14 Oct 2021 19:14:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB42503869EEEA54190E29A531FBB89@DM6PR12MB4250.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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

Am 14.10.21 um 12:14 schrieb Yu, Lang:
> [AMD Official Use Only]
>
>
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Wednesday, October 13, 2021 11:25 PM
>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@amd.com>
>> Subject: Re: [PATCH] drm/amdkfd: Separate pinned BOs destruction from
>> general routine
>>
>> Am 2021-10-11 um 4:58 a.m. schrieb Lang Yu:
>>> Currently, all kfd BOs use same destruction routine. But pinned BOs
>>> are not unpinned properly. Separate them from general routine.
>>>
>>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>> I think the general idea is right. However, we need another safeguard for the
>> signal BO, which is allocated by user mode and can be freed by user mode at
>> any time. We can solve this in one of two ways:
>>
>> 1. Add special handling for the signal BO in
>>     kfd_ioctl_free_memory_of_gpu to kunmap the BO and make sure the
>>     signal handling code is aware of it
>> 2. Fail kfd_ioctl_free_memory_of_gpu for signal BOs and only allow them
>>     to be destroyed at process termination
>>
>> I think #2 is easier, and is consistent with what current user mode does.
> Will add safeguard to prevent that according to #2.

Well, exactly that are the things why upstream people insisted on this :)

Sounds like the best solution to me as well.

Thanks for taking care of this,
Christian.

>   
>> A few more comment inline ...
>>
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   2 +
>>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  10 ++
>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |   3 +
>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   3 +
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 125 ++++++++++++++---
>> -
>>>   5 files changed, 114 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> index 69de31754907..751557af09bb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> @@ -279,6 +279,8 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
>>>   		struct kgd_dev *kgd, struct kgd_mem *mem, bool intr);  int
>>> amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_dev *kgd,
>>>   		struct kgd_mem *mem, void **kptr, uint64_t *size);
>>> +void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct
>> kgd_dev
>>> +*kgd, struct kgd_mem *mem);
>>> +
>>>   int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
>>>   					    struct dma_fence **ef);
>>>   int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct kgd_dev *kgd, diff
>>> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 054c1a224def..6acc78b02bdc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -1871,6 +1871,16 @@ int
>> amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_dev *kgd,
>>>   	return ret;
>>>   }
>>>
>>> +void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct
>> kgd_dev
>>> +*kgd, struct kgd_mem *mem) {
>>> +	struct amdgpu_bo *bo = mem->bo;
>>> +
>>> +	amdgpu_bo_reserve(bo, true);
>>> +	amdgpu_bo_kunmap(bo);
>>> +	amdgpu_bo_unpin(bo);
>>> +	amdgpu_bo_unreserve(bo);
>>> +}
>>> +
>>>   int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct kgd_dev *kgd,
>>>   					      struct kfd_vm_fault_info *mem)
>> { diff --git
>>> a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> index f1e7edeb4e6b..0db48ac10fde 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> @@ -1051,6 +1051,9 @@ static int kfd_ioctl_create_event(struct file *filp,
>> struct kfd_process *p,
>>>   			pr_err("Failed to set event page\n");
>> Need to kunmap the signal BO here.
> Will kunmap it here.
>
>>>   			return err;
>>>   		}
>>> +
>>> +		p->signal_handle = args->event_page_offset;
>>> +
>>>   	}
>>>
>>>   	err = kfd_event_create(filp, p, args->event_type, diff --git
>>> a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index 6d8f9bb2d905..30f08f1606bb 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -608,12 +608,14 @@ struct qcm_process_device {
>>>   	uint32_t sh_hidden_private_base;
>>>
>>>   	/* CWSR memory */
>>> +	struct kgd_mem *cwsr_mem;
>>>   	void *cwsr_kaddr;
>>>   	uint64_t cwsr_base;
>>>   	uint64_t tba_addr;
>>>   	uint64_t tma_addr;
>>>
>>>   	/* IB memory */
>>> +	struct kgd_mem *ib_mem;
>>>   	uint64_t ib_base;
>>>   	void *ib_kaddr;
>>>
>>> @@ -808,6 +810,7 @@ struct kfd_process {
>>>   	/* Event ID allocator and lookup */
>>>   	struct idr event_idr;
>>>   	/* Event page */
>>> +	u64 signal_handle;
>>>   	struct kfd_signal_page *signal_page;
>>>   	size_t signal_mapped_size;
>>>   	size_t signal_event_count;
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index 21ec8a18cad2..c024f2e2efaa 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -72,6 +72,8 @@ static int kfd_process_init_cwsr_apu(struct
>>> kfd_process *p, struct file *filep);  static void
>>> evict_process_worker(struct work_struct *work);  static void
>>> restore_process_worker(struct work_struct *work);
>>>
>>> +static void kfd_process_device_destroy_cwsr_dgpu(struct
>>> +kfd_process_device *pdd);
>>> +
>>>   struct kfd_procfs_tree {
>>>   	struct kobject *kobj;
>>>   };
>>> @@ -685,10 +687,15 @@ void kfd_process_destroy_wq(void)  }
>>>
>>>   static void kfd_process_free_gpuvm(struct kgd_mem *mem,
>>> -			struct kfd_process_device *pdd)
>>> +			struct kfd_process_device *pdd, void *kptr)
>>>   {
>>>   	struct kfd_dev *dev = pdd->dev;
>>>
>>> +	if (kptr) {
>>> +		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(dev-
>>> kgd, mem);
>>> +		kptr = NULL;
>>> +	}
>>> +
>>>   	amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(dev->kgd,
>> mem, pdd->drm_priv);
>>>   	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd, mem,
>> pdd->drm_priv,
>>>   					       NULL);
>>> @@ -702,63 +709,46 @@ static void kfd_process_free_gpuvm(struct
>> kgd_mem *mem,
>>>    */
>>>   static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
>>>   				   uint64_t gpu_va, uint32_t size,
>>> -				   uint32_t flags, void **kptr)
>>> +				   uint32_t flags, struct kgd_mem **mem, void
>> **kptr)
>>>   {
>>>   	struct kfd_dev *kdev = pdd->dev;
>>> -	struct kgd_mem *mem = NULL;
>>> -	int handle;
>>>   	int err;
>>>
>>>   	err = amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(kdev->kgd,
>> gpu_va, size,
>>> -						 pdd->drm_priv, &mem, NULL,
>> flags);
>>> +						 pdd->drm_priv, mem, NULL,
>> flags);
>>>   	if (err)
>>>   		goto err_alloc_mem;
>>>
>>> -	err = amdgpu_amdkfd_gpuvm_map_memory_to_gpu(kdev->kgd,
>> mem,
>>> +	err = amdgpu_amdkfd_gpuvm_map_memory_to_gpu(kdev->kgd,
>> *mem,
>>>   			pdd->drm_priv, NULL);
>>>   	if (err)
>>>   		goto err_map_mem;
>>>
>>> -	err = amdgpu_amdkfd_gpuvm_sync_memory(kdev->kgd, mem,
>> true);
>>> +	err = amdgpu_amdkfd_gpuvm_sync_memory(kdev->kgd, *mem,
>> true);
>>>   	if (err) {
>>>   		pr_debug("Sync memory failed, wait interrupted by user
>> signal\n");
>>>   		goto sync_memory_failed;
>>>   	}
>>>
>>> -	/* Create an obj handle so kfd_process_device_remove_obj_handle
>>> -	 * will take care of the bo removal when the process finishes.
>>> -	 * We do not need to take p->mutex, because the process is just
>>> -	 * created and the ioctls have not had the chance to run.
>>> -	 */
>>> -	handle = kfd_process_device_create_obj_handle(pdd, mem);
>>> -
>>> -	if (handle < 0) {
>>> -		err = handle;
>>> -		goto free_gpuvm;
>>> -	}
>>> -
>>>   	if (kptr) {
>>>   		err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(kdev-
>>> kgd,
>>> -				(struct kgd_mem *)mem, kptr, NULL);
>>> +				(struct kgd_mem *)*mem, kptr, NULL);
>>>   		if (err) {
>>>   			pr_debug("Map GTT BO to kernel failed\n");
>>> -			goto free_obj_handle;
>>> +			goto sync_memory_failed;
>>>   		}
>>>   	}
>>>
>>>   	return err;
>>>
>>> -free_obj_handle:
>>> -	kfd_process_device_remove_obj_handle(pdd, handle);
>>> -free_gpuvm:
>>>   sync_memory_failed:
>>> -	kfd_process_free_gpuvm(mem, pdd);
>>> -	return err;
>>> +	amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(kdev->kgd,
>> *mem,
>>> +pdd->drm_priv);
>>>
>>>   err_map_mem:
>>> -	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(kdev->kgd, mem,
>> pdd->drm_priv,
>>> +	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(kdev->kgd, *mem,
>>> +pdd->drm_priv,
>>>   					       NULL);
>>>   err_alloc_mem:
>>> +	*mem = NULL;
>>>   	*kptr = NULL;
>>>   	return err;
>>>   }
>>> @@ -776,6 +766,7 @@ static int
>> kfd_process_device_reserve_ib_mem(struct kfd_process_device *pdd)
>>>   			KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE |
>>>   			KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE |
>>>   			KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
>>> +	struct kgd_mem *mem;
>>>   	void *kaddr;
>>>   	int ret;
>>>
>>> @@ -784,15 +775,26 @@ static int
>>> kfd_process_device_reserve_ib_mem(struct kfd_process_device *pdd)
>>>
>>>   	/* ib_base is only set for dGPU */
>>>   	ret = kfd_process_alloc_gpuvm(pdd, qpd->ib_base, PAGE_SIZE, flags,
>>> -				      &kaddr);
>>> +				      &mem, &kaddr);
>>>   	if (ret)
>>>   		return ret;
>>>
>>> +	qpd->ib_mem = mem;
>>>   	qpd->ib_kaddr = kaddr;
>>>
>>>   	return 0;
>>>   }
>>>
>>> +static void kfd_process_device_destroy_ib_mem(struct
>>> +kfd_process_device *pdd) {
>>> +	struct qcm_process_device *qpd = &pdd->qpd;
>>> +
>>> +	if (!qpd->ib_kaddr || !qpd->ib_base)
>>> +		return;
>>> +
>>> +	kfd_process_free_gpuvm(qpd->ib_mem, pdd, qpd->ib_kaddr); }
>>> +
>>>   struct kfd_process *kfd_create_process(struct file *filep)  {
>>>   	struct kfd_process *process;
>>> @@ -947,6 +949,52 @@ static void kfd_process_device_free_bos(struct
>> kfd_process_device *pdd)
>>>   	}
>>>   }
>>>
>>> +static void kfd_process_free_signal_bo(struct kfd_process *p) {
>>> +	struct kfd_process_device *pdd;
>>> +	struct kfd_dev *kdev;
>>> +	void *mem;
>>> +	int i;
>>> +
>>> +	kdev = kfd_device_by_id(GET_GPU_ID(p->signal_handle));
>>> +	if (!kdev)
>>> +		return;
>>> +
>>> +	mutex_lock(&p->mutex);
>>> +
>>> +	pdd = kfd_get_process_device_data(kdev, p);
>>> +	if (!pdd) {
>>> +		mutex_unlock(&p->mutex);
>>> +		return;
>>> +	}
>>> +
>>> +	mem = kfd_process_device_translate_handle(
>>> +		pdd, GET_IDR_HANDLE(p->signal_handle));
>>> +	if (!mem) {
>>> +		mutex_unlock(&p->mutex);
>>> +		return;
>>> +	}
>>> +
>>> +	mutex_unlock(&p->mutex);
>>> +
>>> +	for (i = 0; i < p->n_pdds; i++) {
>>> +		struct kfd_process_device *peer_pdd = p->pdds[i];
>>> +
>>> +		if (!peer_pdd->drm_priv)
>>> +			continue;
>>> +		amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>>> +				peer_pdd->dev->kgd, mem, peer_pdd-
>>> drm_priv);
>>> +	}
>>> +
>>> +	amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(kdev->kgd,
>> mem);
>>
>> I think you only need to do the kunmap here. You can leave
>> "unmap_memory_from_gpu" and "free_memory_of_gpu" and
>> "remove_obj_handle"
>> to be done in the regular kfd_process_free_outstanding_kfd_bos to avoid
>> duplicating that code.
> Good idea. Will just kunmap it here.
>>> +
>>> +	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(kdev->kgd, mem,
>>> +		pdd->drm_priv, NULL);
>>> +
>>> +	kfd_process_device_remove_obj_handle(pdd,
>>> +		GET_IDR_HANDLE(p->signal_handle));
>>> +}
>>> +
>>>   static void kfd_process_free_outstanding_kfd_bos(struct kfd_process
>>> *p)  {
>>>   	int i;
>>> @@ -965,6 +1013,9 @@ static void kfd_process_destroy_pdds(struct
>> kfd_process *p)
>>>   		pr_debug("Releasing pdd (topology id %d) for process (pasid
>> 0x%x)\n",
>>>   				pdd->dev->id, p->pasid);
>>>
>>> +		kfd_process_device_destroy_cwsr_dgpu(pdd);
>>> +		kfd_process_device_destroy_ib_mem(pdd);
>>> +
>>>   		if (pdd->drm_file) {
>>>   			amdgpu_amdkfd_gpuvm_release_process_vm(
>>>   					pdd->dev->kgd, pdd->drm_priv);
>>> @@ -1049,9 +1100,11 @@ static void kfd_process_wq_release(struct
>>> work_struct *work)  {
>>>   	struct kfd_process *p = container_of(work, struct kfd_process,
>>>   					     release_work);
>>> +
>>>   	kfd_process_remove_sysfs(p);
>>>   	kfd_iommu_unbind_process(p);
>>>
>>> +	kfd_process_free_signal_bo(p);
>>>   	kfd_process_free_outstanding_kfd_bos(p);
>>>   	svm_range_list_fini(p);
>>>
>>> @@ -1066,6 +1119,7 @@ static void kfd_process_wq_release(struct
>> work_struct *work)
>>>   	put_task_struct(p->lead_thread);
>>>
>>>   	kfree(p);
>>> +
>> Unnecessary, trailing whitespace.
> Will remove it.
>
> Regards,
> Lang
>
>> Regards,
>>    Felix
>>
>>
>>>   }
>>>
>>>   static void kfd_process_ref_release(struct kref *ref) @@ -1198,6
>>> +1252,7 @@ static int kfd_process_device_init_cwsr_dgpu(struct
>> kfd_process_device *pdd)
>>>   	uint32_t flags = KFD_IOC_ALLOC_MEM_FLAGS_GTT
>>>   			| KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE
>>>   			| KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
>>> +	struct kgd_mem *mem;
>>>   	void *kaddr;
>>>   	int ret;
>>>
>>> @@ -1206,10 +1261,11 @@ static int
>>> kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
>>>
>>>   	/* cwsr_base is only set for dGPU */
>>>   	ret = kfd_process_alloc_gpuvm(pdd, qpd->cwsr_base,
>>> -				      KFD_CWSR_TBA_TMA_SIZE, flags, &kaddr);
>>> +				      KFD_CWSR_TBA_TMA_SIZE, flags, &mem,
>> &kaddr);
>>>   	if (ret)
>>>   		return ret;
>>>
>>> +	qpd->cwsr_mem = mem;
>>>   	qpd->cwsr_kaddr = kaddr;
>>>   	qpd->tba_addr = qpd->cwsr_base;
>>>
>>> @@ -1222,6 +1278,17 @@ static int
>> kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
>>>   	return 0;
>>>   }
>>>
>>> +static void kfd_process_device_destroy_cwsr_dgpu(struct
>>> +kfd_process_device *pdd) {
>>> +	struct kfd_dev *dev = pdd->dev;
>>> +	struct qcm_process_device *qpd = &pdd->qpd;
>>> +
>>> +	if (!dev->cwsr_enabled || !qpd->cwsr_kaddr || !qpd->cwsr_base)
>>> +		return;
>>> +
>>> +	kfd_process_free_gpuvm(qpd->cwsr_mem, pdd, qpd->cwsr_kaddr); }
>>> +
>>>   void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
>>>   				  uint64_t tba_addr,
>>>   				  uint64_t tma_addr)

