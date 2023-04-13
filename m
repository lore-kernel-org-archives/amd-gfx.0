Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482BAC77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 11:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B15E410EAC0;
	Thu, 13 Apr 2023 11:07:22 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC6E010EABF
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 11:07:20 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id s2so10546026wra.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 04:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681384039; x=1683976039;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jpdRRTfRkwOokUS0uyF9frV77lqRbe97sd9/9cyoKlM=;
 b=NNt9M8ro1dgGFef2evOTz9EyzS+gtcXWQEH9RGF7hdtGp/CwQoPxNRd372OYkNgR1H
 0EvtZmc7lbl2kLwHG6Y87jEjssyWeIW3sJ3Mzlxj71hgTQyJz2JaPv5LcwfSB3XOUZ8X
 P5L6cl16R3qzFhJF9u/ih1QS1mOCABnOVtr9wohiet+E3QxMFFxOm5xYXnayIkWRN338
 Cw7PuffIxUP+cyOCB0tA8VY6ds9Gyvzvfe6LHi1VXTWffGSX9w/7zPQc9tX7CT4GZmkD
 9Qjw8sx2TvX4Ie+8D84AOs8G2z7BB+ugeAj5LotFfro08UGfeRHbYF40yTJLazDRRAPu
 A8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681384039; x=1683976039;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jpdRRTfRkwOokUS0uyF9frV77lqRbe97sd9/9cyoKlM=;
 b=I8cDeilz3U9kPz21gmqzIw3OGCBhD0nqjoBNgP97tRjjDNwLRozXj8QLhcNQXPtQdz
 NfNny9G+ONQgwCcuJW1NnDudHBjiKk4uSJntyEu4C680wV9wkZc5Zna9olrsN4O3HorR
 wQurglnpcGC22qJ/zzZGlLVY9j5BriS1thxHQnkECh4Po7P5O2v937eGTDECRzDjXPxq
 OS5d8B/EArE52AsJjW2vcpBY9FhEqXPF7SBfrRZubtTK8QWZqCSgP2DF4bJWsPOLBWYI
 uXQRnhZOBvH/KYhu5N8w36uwFQvF5nz8upg4HghIzW9hDDCzwMbBHBHWhW5PrKqMVd98
 2EvQ==
X-Gm-Message-State: AAQBX9dviF/9k2L3sap7fYmWnnAI5M2/ArrAUhnH1GvHYOSxvc19fpt4
 sop1XFWHPE710B3fv0Ek8g8=
X-Google-Smtp-Source: AKy350a8gmPqvYpT1lgedVuDxGH2HJG8VcqE1q4Fl6lUEx8uXQtNL/cmeGaPx6fewRGZULwnA4I15g==
X-Received: by 2002:a5d:58ec:0:b0:2f2:8cdf:b1b2 with SMTP id
 f12-20020a5d58ec000000b002f28cdfb1b2mr1088139wrd.27.1681384039065; 
 Thu, 13 Apr 2023 04:07:19 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 p11-20020a5d458b000000b002efb31d3c24sm1056395wrq.32.2023.04.13.04.07.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Apr 2023 04:07:18 -0700 (PDT)
Message-ID: <bec7cdac-51ec-fa2c-d87e-83c93d19d14a@gmail.com>
Date: Thu, 13 Apr 2023 13:07:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 09/12] drm/amdgpu: use doorbell manager for kfd process
 doorbells
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230412162537.1357-1-shashank.sharma@amd.com>
 <20230412162537.1357-10-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230412162537.1357-10-shashank.sharma@amd.com>
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
Cc: mukul.joshi@amd.com, Felix Kuehling <Felix.Kuehling@amd.com>,
 arvind.yadav@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 12.04.23 um 18:25 schrieb Shashank Sharma:
> This patch:
> - adds a doorbell object in kfd pdd structure.
> - allocates doorbells for a process while creating its pdd.
> - frees the doorbells with pdd destroy.
> - removes previous calls to allocate process doorbells as
>    its not required anymore.
>
> PS: This patch ensures that we don't break the existing KFD
>      functionality, but now KFD userspace library should also
>      create doorbell pages as AMDGPU GEM objects using libdrm
>      functions in userspace. The reference code for the same
>      is available with AMDGPU Usermode queue libdrm MR. Once
>      this is done, we will not need to create process doorbells
>      in kernel.
>
> V2: - Do not use doorbell wrapper API, use amdgpu_bo_create_kernel
>        instead (Alex).
>      - Do not use custom doorbell structure, instead use separate
>        variables for bo and doorbell_bitmap (Alex)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Felix needs to take a look at this, I only understand halve of what's 
going on here.

Feel free to add an Acked-by: Christian König <christian.koenig@amd.com> 
cause the halve I understand looks good.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 13 ----
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |  8 +--
>   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c     | 65 ++++++++++---------
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  9 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 21 +++---
>   .../amd/amdkfd/kfd_process_queue_manager.c    | 22 +++----
>   6 files changed, 64 insertions(+), 74 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 6d291aa6386b..0e40756417e5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -327,12 +327,6 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   		goto err_bind_process;
>   	}
>   
> -	if (!pdd->doorbell_index &&
> -	    kfd_alloc_process_doorbells(dev, &pdd->doorbell_index) < 0) {
> -		err = -ENOMEM;
> -		goto err_alloc_doorbells;
> -	}
> -
>   	/* Starting with GFX11, wptr BOs must be mapped to GART for MES to determine work
>   	 * on unmapped queues for usermode queue oversubscription (no aggregated doorbell)
>   	 */
> @@ -410,7 +404,6 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   	if (wptr_bo)
>   		amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
>   err_wptr_map_gart:
> -err_alloc_doorbells:
>   err_bind_process:
>   err_pdd:
>   	mutex_unlock(&p->mutex);
> @@ -2163,12 +2156,6 @@ static int criu_restore_devices(struct kfd_process *p,
>   			ret = PTR_ERR(pdd);
>   			goto exit;
>   		}
> -
> -		if (!pdd->doorbell_index &&
> -		    kfd_alloc_process_doorbells(pdd->dev, &pdd->doorbell_index) < 0) {
> -			ret = -ENOMEM;
> -			goto exit;
> -		}
>   	}
>   
>   	/*
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index ecb4c3abc629..855bf8ce3f16 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -371,7 +371,7 @@ static int allocate_doorbell(struct qcm_process_device *qpd,
>   			unsigned int found;
>   
>   			found = find_first_zero_bit(qpd->doorbell_bitmap,
> -						KFD_MAX_NUM_OF_QUEUES_PER_PROCESS);
> +						    KFD_MAX_NUM_OF_QUEUES_PER_PROCESS);
>   			if (found >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS) {
>   				pr_debug("No doorbells available");
>   				return -EBUSY;
> @@ -381,9 +381,9 @@ static int allocate_doorbell(struct qcm_process_device *qpd,
>   		}
>   	}
>   
> -	q->properties.doorbell_off =
> -		kfd_get_doorbell_dw_offset_in_bar(dev, qpd_to_pdd(qpd),
> -					  q->doorbell_id);
> +	q->properties.doorbell_off = amdgpu_doorbell_index_on_bar(dev->adev,
> +								  qpd->proc_doorbells,
> +								  q->doorbell_id);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> index 82b4a56b0afc..718cfe9cb4f5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -227,46 +227,47 @@ uint64_t kfd_get_number_elems(struct kfd_dev *kfd)
>   
>   phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd)
>   {
> -	if (!pdd->doorbell_index) {
> -		int r = kfd_alloc_process_doorbells(pdd->dev,
> -						    &pdd->doorbell_index);
> -		if (r < 0)
> -			return 0;
> -	}
> +	struct amdgpu_device *adev = pdd->dev->adev;
> +	uint32_t first_db_index;
>   
> -	return pdd->dev->doorbell_base +
> -		pdd->doorbell_index * kfd_doorbell_process_slice(pdd->dev);
> +	first_db_index = amdgpu_doorbell_index_on_bar(adev, pdd->qpd.proc_doorbells, 0);
> +	return adev->doorbell.base + first_db_index * sizeof(uint32_t);
>   }
>   
> -int kfd_alloc_process_doorbells(struct kfd_dev *kfd, unsigned int *doorbell_index)
> +int kfd_alloc_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *pdd)
>   {
> -	int r = 0;
> -
> -	if (!kfd->shared_resources.enable_mes)
> -		r = ida_simple_get(&kfd->doorbell_ida, 1,
> -				   kfd->max_doorbell_slices, GFP_KERNEL);
> -	else
> -		r = amdgpu_mes_alloc_process_doorbells(
> -				(struct amdgpu_device *)kfd->adev,
> -				doorbell_index);
> +	int r;
> +	struct qcm_process_device *qpd = &pdd->qpd;
>   
> -	if (r > 0)
> -		*doorbell_index = r;
> +	/* Allocate bitmap for dynamic doorbell allocation */
> +	qpd->doorbell_bitmap = bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
> +					     GFP_KERNEL);
> +	if (!qpd->doorbell_bitmap) {
> +		DRM_ERROR("Failed to allocate process doorbell bitmap\n");
> +		return -ENOMEM;
> +	}
>   
> -	if (r < 0)
> -		pr_err("Failed to allocate process doorbells\n");
> +	/* Allocate doorbells for this process */
> +	r = amdgpu_bo_create_kernel(kfd->adev,
> +				    kfd_doorbell_process_slice(kfd),
> +				    PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_DOORBELL,
> +				    &qpd->proc_doorbells,
> +				    NULL,
> +				    NULL);
> +	if (r) {
> +		DRM_ERROR("Failed to allocate process doorbells\n");
> +		bitmap_free(qpd->doorbell_bitmap);
> +		return r;
> +	}
>   
> -	return r;
> +	return 0;
>   }
>   
> -void kfd_free_process_doorbells(struct kfd_dev *kfd, unsigned int doorbell_index)
> +void kfd_free_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *pdd)
>   {
> -	if (doorbell_index) {
> -		if (!kfd->shared_resources.enable_mes)
> -			ida_simple_remove(&kfd->doorbell_ida, doorbell_index);
> -		else
> -			amdgpu_mes_free_process_doorbells(
> -					(struct amdgpu_device *)kfd->adev,
> -					doorbell_index);
> -	}
> +	struct qcm_process_device *qpd = &pdd->qpd;
> +
> +	bitmap_free(qpd->doorbell_bitmap);
> +	amdgpu_bo_free_kernel(&qpd->proc_doorbells, NULL, NULL);
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 0b199eb6dc88..dfff77379acb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -661,7 +661,10 @@ struct qcm_process_device {
>   	uint64_t ib_base;
>   	void *ib_kaddr;
>   
> -	/* doorbell resources per process per device */
> +	/* doorbells for kfd process */
> +	struct amdgpu_bo *proc_doorbells;
> +
> +	/* bitmap for dynamic doorbell allocation from the bo */
>   	unsigned long *doorbell_bitmap;
>   };
>   
> @@ -1009,9 +1012,9 @@ unsigned int kfd_get_doorbell_dw_offset_in_bar(struct kfd_dev *kfd,
>   					unsigned int doorbell_id);
>   phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd);
>   int kfd_alloc_process_doorbells(struct kfd_dev *kfd,
> -				unsigned int *doorbell_index);
> +				 struct kfd_process_device *pdd);
>   void kfd_free_process_doorbells(struct kfd_dev *kfd,
> -				unsigned int doorbell_index);
> +				 struct kfd_process_device *pdd);
>   /* GTT Sub-Allocator */
>   
>   int kfd_gtt_sa_allocate(struct kfd_dev *kfd, unsigned int size,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 51b1683ac5c1..217ff72a97b0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1037,10 +1037,9 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
>   			free_pages((unsigned long)pdd->qpd.cwsr_kaddr,
>   				get_order(KFD_CWSR_TBA_TMA_SIZE));
>   
> -		bitmap_free(pdd->qpd.doorbell_bitmap);
>   		idr_destroy(&pdd->alloc_idr);
>   
> -		kfd_free_process_doorbells(pdd->dev, pdd->doorbell_index);
> +		kfd_free_process_doorbells(pdd->dev, pdd);
>   
>   		if (pdd->dev->shared_resources.enable_mes)
>   			amdgpu_amdkfd_free_gtt_mem(pdd->dev->adev,
> @@ -1453,11 +1452,6 @@ static int init_doorbell_bitmap(struct qcm_process_device *qpd,
>   	if (!KFD_IS_SOC15(dev))
>   		return 0;
>   
> -	qpd->doorbell_bitmap = bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
> -					     GFP_KERNEL);
> -	if (!qpd->doorbell_bitmap)
> -		return -ENOMEM;
> -
>   	/* Mask out doorbells reserved for SDMA, IH, and VCN on SOC15. */
>   	pr_debug("reserved doorbell 0x%03x - 0x%03x\n", range_start, range_end);
>   	pr_debug("reserved doorbell 0x%03x - 0x%03x\n",
> @@ -1499,9 +1493,15 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
>   	if (!pdd)
>   		return NULL;
>   
> +	retval = kfd_alloc_process_doorbells(dev, pdd);
> +	if (retval) {
> +		pr_err("failed to allocate process doorbells\n");
> +		goto err_free_pdd;
> +	}
> +
>   	if (init_doorbell_bitmap(&pdd->qpd, dev)) {
>   		pr_err("Failed to init doorbell for process\n");
> -		goto err_free_pdd;
> +		goto err_free_db;
>   	}
>   
>   	pdd->dev = dev;
> @@ -1529,7 +1529,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
>   						false);
>   		if (retval) {
>   			pr_err("failed to allocate process context bo\n");
> -			goto err_free_pdd;
> +			goto err_free_db;
>   		}
>   		memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
>   	}
> @@ -1541,6 +1541,9 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
>   
>   	return pdd;
>   
> +err_free_db:
> +	kfd_free_process_doorbells(pdd->dev, pdd);
> +
>   err_free_pdd:
>   	kfree(pdd);
>   	return NULL;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 5137476ec18e..6c95586f08a6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -344,17 +344,19 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   		goto err_create_queue;
>   	}
>   
> -	if (q && p_doorbell_offset_in_process)
> +	if (q && p_doorbell_offset_in_process) {
>   		/* Return the doorbell offset within the doorbell page
>   		 * to the caller so it can be passed up to user mode
>   		 * (in bytes).
> -		 * There are always 1024 doorbells per process, so in case
> -		 * of 8-byte doorbells, there are two doorbell pages per
> -		 * process.
> +		 * relative doorbell index = Absolute doorbell index -
> +		 * absolute index of first doorbell in the page.
>   		 */
> -		*p_doorbell_offset_in_process =
> -			(q->properties.doorbell_off * sizeof(uint32_t)) &
> -			(kfd_doorbell_process_slice(dev) - 1);
> +		uint32_t first_db_index = amdgpu_doorbell_index_on_bar(pdd->dev->adev,
> +									pdd->qpd.proc_doorbells, 0);
> +
> +		*p_doorbell_offset_in_process = (q->properties.doorbell_off
> +						- first_db_index) * sizeof(uint32_t);
> +	}
>   
>   	pr_debug("PQM After DQM create queue\n");
>   
> @@ -858,12 +860,6 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>   		goto exit;
>   	}
>   
> -	if (!pdd->doorbell_index &&
> -	    kfd_alloc_process_doorbells(pdd->dev, &pdd->doorbell_index) < 0) {
> -		ret = -ENOMEM;
> -		goto exit;
> -	}
> -
>   	/* data stored in this order: mqd, ctl_stack */
>   	mqd = q_extra_data;
>   	ctl_stack = mqd + q_data->mqd_size;

