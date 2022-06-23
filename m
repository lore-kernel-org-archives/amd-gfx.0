Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1856C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jun 2022 07:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8945E113B94;
	Thu, 23 Jun 2022 07:10:54 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 724A3113B92
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jun 2022 07:10:53 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id m1so18803551wrb.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jun 2022 00:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=3yYlyI4mOPXPVPGbOaBUagfVfJcwA32y+cm+BhkQw2c=;
 b=DeRiLDs4hlATBaaQ45mug3tqHj5KdvxGy9KKB3yZX2mqftRsIxjWUdPpML7KBFE3VD
 Zg26a5fpljpjTiGx3VUIezeyuOR0Nbn7S1GWeH9jqUYbQE62PdaqWHWzk9kuFcYr7YvA
 zSeABvgEJhld0U6zaWsrysE973txMN8qeIu6zdnwi/2BjFRp0jqthdA3UpGsU4nC06BZ
 pYX6IxhUjrcZ9kBxezISm0shl61UOniCrjO+QdtK54mDbXWqjhe2tR5PIOLoXNCeR03o
 HK8Cas8bBVZUvN/ekftHssrhY0SvZNwl2rvxJR6cVtsj6BdGx6kV2Wl0fXdXXsi6f/mg
 szsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=3yYlyI4mOPXPVPGbOaBUagfVfJcwA32y+cm+BhkQw2c=;
 b=Y3pWrp1BGrxgDQZ3tc4GS8271VYNii7PyofGPtrKb4EIhgIF3wvQ7wGb3uWkM7F7tQ
 djSXESGswzZeAlLDlxsHqSzIwxq+i0UPULQV2FO4gdQyfIZflpPyQrQc3IE/nudROA74
 TrwTHSPL7XUbrsKryoAOjB6E8JTAH51XS5ItnU0Ckq8JEsUgT05fUDOCZDPujzzvUphn
 c+xtd5HRz7gbX930RVGGXHoCZom+mZaYOXYV9Uuw5/aFDY52A8n1mwsh+PbVgFSIbATl
 1WXABISCRM8Lw3DFTzu/XOSZ8+mzjXQCtihuXAR30hTqXkpuCpkaNZFeUxH4uLl5kBVY
 xnsg==
X-Gm-Message-State: AJIora+AggiGVGQxBro1PbNbrKcXc0I5k4qUm/wuw+UZvCoNWobszEbK
 6H32H/Q5HGB+hLnGzTNqYq9hLZ65Xys=
X-Google-Smtp-Source: AGRyM1sxPm/p5dZz0SrG9jlR1BM/eTUWOikUoEdtBaRu9ivhP3nuXsdX8/fYgiEnlFDaGS6BMgb1eg==
X-Received: by 2002:a5d:67cf:0:b0:21b:9fb8:e6d6 with SMTP id
 n15-20020a5d67cf000000b0021b9fb8e6d6mr6718715wrw.205.1655968251827; 
 Thu, 23 Jun 2022 00:10:51 -0700 (PDT)
Received: from [192.168.178.21] (p57b0bd9f.dip0.t-ipconnect.de.
 [87.176.189.159]) by smtp.gmail.com with ESMTPSA id
 o19-20020a05600c511300b0039c7dbafa7asm2052626wms.19.2022.06.23.00.10.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jun 2022 00:10:51 -0700 (PDT)
Message-ID: <8e854228-32cd-971d-a887-0c19b9bee3b4@gmail.com>
Date: Thu, 23 Jun 2022 09:10:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 2/3] drm/amdkfd: Enable GFX11 usermode queue
 oversubscription
Content-Language: en-US
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220622153656.174491-2-Graham.Sider@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220622153656.174491-2-Graham.Sider@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 22.06.22 um 17:36 schrieb Graham Sider:
> Starting with GFX11, MES requires wptr BOs to be GTT allocated/mapped to
> GART for usermode queues in order to support oversubscription. In the
> case that work is submitted to an unmapped queue, MES must have a GART
> wptr address to determine whether the queue should be mapped.
>
> This change is accompanied with changes in MES and is applicable for
> MES_API_VERSION >= 2.
>
> v3:
> - Use amdgpu_vm_bo_lookup_mapping for wptr_bo mapping lookup
> - Move wptr_bo refcount increment to amdgpu_amdkfd_map_gtt_bo_to_gart
> - Remove list_del_init from amdgpu_amdkfd_map_gtt_bo_to_gart
> - Cleanup/fix create_queue wptr_bo error handling
> v4:
> - Add MES version shift/mask defines to amdgpu_mes.h
> - Change version check from MES_VERSION to MES_API_VERSION
> - Add check in kfd_ioctl_create_queue before wptr bo pin/GART map to
> ensure bo is a single page.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> Reviewed-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 48 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  7 +++
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 45 ++++++++++++++++-
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |  9 +++-
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  2 +
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 ++
>   .../amd/amdkfd/kfd_process_queue_manager.c    | 20 +++++---
>   8 files changed, 127 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 648c031942e9..b25b41f50213 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -286,6 +286,8 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
>   					     void **kptr, uint64_t *size);
>   void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
>   
> +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo);
> +
>   int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
>   					    struct dma_fence **ef);
>   int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index afd6e6923189..615ac2895d62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2148,6 +2148,54 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
>   	return ret;
>   }
>   
> +/**
> + * amdgpu_amdkfd_map_gtt_bo_to_gart - Map BO to GART and increment reference count
> + * @adev: Device to which allocated BO belongs
> + * @bo: Buffer object to be mapped
> + *
> + * Before return, bo reference count is incremented. To release the reference and unpin/
> + * unmap the BO, call amdgpu_amdkfd_free_gtt_mem.
> + */
> +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo)
> +{
> +	int ret;
> +
> +	ret = amdgpu_bo_reserve(bo, true);
> +	if (ret) {
> +		pr_err("Failed to reserve bo. ret %d\n", ret);
> +		goto err_reserve_bo_failed;
> +	}
> +
> +	ret = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
> +	if (ret) {
> +		pr_err("Failed to pin bo. ret %d\n", ret);
> +		goto err_pin_bo_failed;
> +	}
> +
> +	ret = amdgpu_ttm_alloc_gart(&bo->tbo);
> +	if (ret) {
> +		pr_err("Failed to bind bo to GART. ret %d\n", ret);
> +		goto err_map_bo_gart_failed;
> +	}
> +
> +	amdgpu_amdkfd_remove_eviction_fence(
> +		bo, bo->kfd_bo->process_info->eviction_fence);
> +
> +	amdgpu_bo_unreserve(bo);
> +
> +	bo = amdgpu_bo_ref(bo);
> +
> +	return 0;
> +
> +err_map_bo_gart_failed:
> +	amdgpu_bo_unpin(bo);
> +err_pin_bo_failed:
> +	amdgpu_bo_unreserve(bo);
> +err_reserve_bo_failed:
> +
> +	return ret;
> +}
> +
>   /** amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel() - Map a GTT BO for kernel CPU access
>    *
>    * @mem: Buffer object to be mapped for CPU access
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index be4b51a5b5c7..137a2cc2e807 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -32,6 +32,13 @@
>   #define AMDGPU_MES_MAX_GFX_PIPES            2
>   #define AMDGPU_MES_MAX_SDMA_PIPES           2
>   
> +#define AMDGPU_MES_API_VERSION_SHIFT	12
> +#define AMDGPU_MES_FEAT_VERSION_SHIFT	24
> +
> +#define AMDGPU_MES_VERSION_MASK		0x00000fff
> +#define AMDGPU_MES_API_VERSION_MASK	0x00fff000
> +#define AMDGPU_MES_FEAT_VERSION_MASK	0xff000000
> +
>   enum amdgpu_mes_priority_level {
>   	AMDGPU_MES_PRIORITY_LEVEL_LOW       = 0,
>   	AMDGPU_MES_PRIORITY_LEVEL_NORMAL    = 1,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 625e837f0119..a0246b4bae6b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -299,6 +299,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   	struct kfd_process_device *pdd;
>   	struct queue_properties q_properties;
>   	uint32_t doorbell_offset_in_process = 0;
> +	struct amdgpu_bo *wptr_bo = NULL;
>   
>   	memset(&q_properties, 0, sizeof(struct queue_properties));
>   
> @@ -326,12 +327,49 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   		goto err_bind_process;
>   	}
>   
> +	/* Starting with GFX11, wptr BOs must be mapped to GART for MES to determine work
> +	 * on unmapped queues for usermode queue oversubscription (no aggregated doorbell)
> +	 */
> +	if (dev->shared_resources.enable_mes &&
> +			((dev->adev->mes.sched_version & AMDGPU_MES_API_VERSION_MASK)
> +			>> AMDGPU_MES_API_VERSION_SHIFT) >= 2) {
> +		struct amdgpu_bo_va_mapping *wptr_mapping;
> +		struct amdgpu_vm *wptr_vm;
> +
> +		wptr_vm = drm_priv_to_vm(pdd->drm_priv);
> +		err = amdgpu_bo_reserve(wptr_vm->root.bo, false);
> +		if (err)
> +			goto err_wptr_map_gart;
> +
> +		wptr_mapping = amdgpu_vm_bo_lookup_mapping(
> +				wptr_vm, args->write_pointer_address >> PAGE_SHIFT);
> +		amdgpu_bo_unreserve(wptr_vm->root.bo);
> +		if (!wptr_mapping) {
> +			pr_err("Failed to lookup wptr bo\n");
> +			err = -EINVAL;
> +			goto err_wptr_map_gart;
> +		}
> +
> +		wptr_bo = wptr_mapping->bo_va->base.bo;
> +		if (wptr_bo->tbo.base.size > PAGE_SIZE) {
> +			pr_err("Requested GART mapping for wptr bo larger than one page\n");
> +			err = -EINVAL;
> +			goto err_wptr_map_gart;
> +		}
> +
> +		err = amdgpu_amdkfd_map_gtt_bo_to_gart(dev->adev, wptr_bo);
> +		if (err) {
> +			pr_err("Failed to map wptr bo to GART\n");
> +			goto err_wptr_map_gart;
> +		}
> +	}
> +
>   	pr_debug("Creating queue for PASID 0x%x on gpu 0x%x\n",
>   			p->pasid,
>   			dev->id);
>   
> -	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id, NULL, NULL, NULL,
> -			&doorbell_offset_in_process);
> +	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id, wptr_bo,
> +			NULL, NULL, NULL, &doorbell_offset_in_process);
>   	if (err != 0)
>   		goto err_create_queue;
>   
> @@ -363,6 +401,9 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   	return 0;
>   
>   err_create_queue:
> +	if (wptr_bo)
> +		amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
> +err_wptr_map_gart:
>   err_bind_process:
>   err_pdd:
>   	mutex_unlock(&p->mutex);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 213246a5b4e4..299927a4959b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -177,6 +177,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
>   	struct mes_add_queue_input queue_input;
>   	int r, queue_type;
> +	uint64_t wptr_addr_off;
>   
>   	if (dqm->is_hws_hang)
>   		return -EIO;
> @@ -196,7 +197,13 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   					AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>   	queue_input.doorbell_offset = q->properties.doorbell_off;
>   	queue_input.mqd_addr = q->gart_mqd_addr;
> -	queue_input.wptr_addr = (uint64_t)q->properties.write_ptr;
> +
> +	if (q->wptr_bo) {
> +		wptr_addr_off = (uint64_t)q->properties.write_ptr - (uint64_t)q->wptr_bo->kfd_bo->va;
> +		queue_input.wptr_addr = ((uint64_t)q->wptr_bo->tbo.resource->start << PAGE_SHIFT) + wptr_addr_off;
> +	} else
> +		queue_input.wptr_addr = (uint64_t)q->properties.write_ptr;
> +
>   	queue_input.paging = false;
>   	queue_input.tba_addr = qpd->tba_addr;
>   	queue_input.tma_addr = qpd->tma_addr;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index 4e0387f591be..b8e14c2cc295 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -377,6 +377,8 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>   	m->sdmax_rlcx_rb_base_hi = upper_32_bits(q->queue_address >> 8);
>   	m->sdmax_rlcx_rb_rptr_addr_lo = lower_32_bits((uint64_t)q->read_ptr);
>   	m->sdmax_rlcx_rb_rptr_addr_hi = upper_32_bits((uint64_t)q->read_ptr);
> +	m->sdmax_rlcx_rb_wptr_poll_addr_lo = lower_32_bits((uint64_t)q->write_ptr);
> +	m->sdmax_rlcx_rb_wptr_poll_addr_hi = upper_32_bits((uint64_t)q->write_ptr);
>   	m->sdmax_rlcx_doorbell_offset =
>   		q->doorbell_off << SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 91e5fa56f0a2..59ba50ce54d3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -570,6 +570,8 @@ struct queue {
>   	void *gang_ctx_bo;
>   	uint64_t gang_ctx_gpu_addr;
>   	void *gang_ctx_cpu_ptr;
> +
> +	struct amdgpu_bo *wptr_bo;
>   };
>   
>   enum KFD_MQD_TYPE {
> @@ -1205,6 +1207,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   			    struct file *f,
>   			    struct queue_properties *properties,
>   			    unsigned int *qid,
> +			    struct amdgpu_bo *wptr_bo,
>   			    const struct kfd_criu_queue_priv_data *q_data,
>   			    const void *restore_mqd,
>   			    const void *restore_ctl_stack,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 99f2a6412201..8db58348de98 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -180,7 +180,8 @@ void pqm_uninit(struct process_queue_manager *pqm)
>   static int init_user_queue(struct process_queue_manager *pqm,
>   				struct kfd_dev *dev, struct queue **q,
>   				struct queue_properties *q_properties,
> -				struct file *f, unsigned int qid)
> +				struct file *f, struct amdgpu_bo *wptr_bo,
> +				unsigned int qid)
>   {
>   	int retval;
>   
> @@ -210,6 +211,7 @@ static int init_user_queue(struct process_queue_manager *pqm,
>   			goto cleanup;
>   		}
>   		memset((*q)->gang_ctx_cpu_ptr, 0, AMDGPU_MES_GANG_CTX_SIZE);
> +		(*q)->wptr_bo = wptr_bo;
>   	}
>   
>   	pr_debug("PQM After init queue");
> @@ -226,6 +228,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   			    struct file *f,
>   			    struct queue_properties *properties,
>   			    unsigned int *qid,
> +			    struct amdgpu_bo *wptr_bo,
>   			    const struct kfd_criu_queue_priv_data *q_data,
>   			    const void *restore_mqd,
>   			    const void *restore_ctl_stack,
> @@ -288,7 +291,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   		 * allocate_sdma_queue() in create_queue() has the
>   		 * corresponding check logic.
>   		 */
> -		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
> +		retval = init_user_queue(pqm, dev, &q, properties, f, wptr_bo, *qid);
>   		if (retval != 0)
>   			goto err_create_queue;
>   		pqn->q = q;
> @@ -309,7 +312,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   			goto err_create_queue;
>   		}
>   
> -		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
> +		retval = init_user_queue(pqm, dev, &q, properties, f, wptr_bo, *qid);
>   		if (retval != 0)
>   			goto err_create_queue;
>   		pqn->q = q;
> @@ -435,10 +438,15 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>   			pdd->qpd.num_gws = 0;
>   		}
>   
> -		if (dev->shared_resources.enable_mes)
> +		if (dev->shared_resources.enable_mes) {
>   			amdgpu_amdkfd_free_gtt_mem(dev->adev,
>   						   pqn->q->gang_ctx_bo);
> -		kfd_procfs_del_queue(pqn->q);
> +			if (pqn->q->wptr_bo)
> +				amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
> +
> +			kfd_procfs_del_queue(pqn->q);
> +
> +		}
>   		uninit_queue(pqn->q);
>   	}
>   
> @@ -844,7 +852,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>   
>   	print_queue_properties(&qp);
>   
> -	ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp, &queue_id, q_data, mqd, ctl_stack,
> +	ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp, &queue_id, NULL, q_data, mqd, ctl_stack,
>   				NULL);
>   	if (ret) {
>   		pr_err("Failed to create new queue err:%d\n", ret);

