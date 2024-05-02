Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F57AC4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 15:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A26E210E68F;
	Thu,  2 May 2024 15:18:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EucgtJOe";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8012710E4C6
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 15:18:16 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-41b782405bbso48716665e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 May 2024 08:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714663094; x=1715267894; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gKXkYydHuSQ6PNOQJnFAwd0xmj+iZNOJ7lyy+u+g5Ng=;
 b=EucgtJOefIO2FuU27TBHm8IUpkZjZIxfsPfOZ/XGuyMAED0tE5TbwFGhxIAyMB7wUX
 Xp+qJM0rtnGngHtoKk+bJOso+s47a+LMtszdSJrTwmMFshCEXfDU9nrnHAn++LHryoF8
 bmYSn08OMi4CzeTuctRWlBqlO/GDgGkd1ARQxlFKTNV2wPGrsxVyPvr7ekCbb6d/Gx2W
 z5LsIyE7IfKumVm6CJ63q+rSaORnRZ9YCp91JDUs58bwfnzbaL12YhsrqdfRXCMbV9+o
 DYk45oNLJBozAq205bbIDSXM1e/7BZwwQwUHg2VVDXU8Zk5HI4FcoQb2AkDJ/cpIVLbx
 5Ltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714663094; x=1715267894;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gKXkYydHuSQ6PNOQJnFAwd0xmj+iZNOJ7lyy+u+g5Ng=;
 b=RYNVZmPwEGaD4EGoLAGp6Z7aF561IgDEzcCvFIZ/fPb5keozgaE27MoaS363r5M/91
 iW8x4DYlU0+6jkk8QHXV4fSKcoZJ49DVUl1pCCn0/U2bzXgw4hFxMnkgB3ivR22jq0wU
 ENuI7Au3BivloHaFTy5f76TSUm2r7brTqsufbTT7ykmqpXbtFDxZwF7maTFYb8fmb/jD
 zZpUuv7X6KfiJr22ZCNoYY1NiyEPHrBuDuvEaOirqfoOE4HkOquBTwnqFrpKDKExmPK5
 PY11YFlxqFefv1bpLCcSiGllLogjnbRcaQ2j2JTMg227QZx9o9mfTECyRo0Gnhuo69Fm
 8fSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/72x13FwC2gMaZbZk04T0a6//UK9yjCJt4rYFc3L7yrAVPL9iMRTRPvg5tHodBbZaDCYflH7SXNI3IxhZ+cirHAgwNMCCbyDFj9qsjA==
X-Gm-Message-State: AOJu0YyCqD/+auQ6OvACna5Iu1e/Ee98pqTWy9TEzzjQarHSck5zhM5W
 nDVXdlGJhUkJamfXND0RdBZjztwOBHUoLywegG4Z2r8FuAGYRRFW
X-Google-Smtp-Source: AGHT+IGn+Hm1EBLg4g9/7sXlgM+2GX5HVI82/yeq6yaLQ0i/XTb2ZvczrT94xlCrTDike7MpEEyLHw==
X-Received: by 2002:a05:600c:4f81:b0:419:f3f9:8ee3 with SMTP id
 n1-20020a05600c4f8100b00419f3f98ee3mr50504wmq.5.1714663094330; 
 Thu, 02 May 2024 08:18:14 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c19d100b004186eb69a55sm2279356wmq.25.2024.05.02.08.18.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 08:18:13 -0700 (PDT)
Message-ID: <c493094b-a5d2-43a0-937a-75accba93136@gmail.com>
Date: Thu, 2 May 2024 17:18:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 08/14] drm/amdgpu: map wptr BO into GART
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Arvind Yadav <arvind.yadav@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-9-shashank.sharma@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240426134810.1250-9-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Am 26.04.24 um 15:48 schrieb Shashank Sharma:
> To support oversubscription, MES FW expects WPTR BOs to
> be mapped into GART, before they are submitted to usermode
> queues. This patch adds a function for the same.
>
> V4: fix the wptr value before mapping lookup (Bas, Christian).
>
> V5: Addressed review comments from Christian:
>      - Either pin object or allocate from GART, but not both.
>      - All the handling must be done with the VM locks held.
>
> V7: Addressed review comments from Christian:
>      - Do not take vm->eviction_lock
>      - Use amdgpu_bo_gpu_offset to get the wptr_bo GPU offset
>
> V8: Rebase
> V9: Changed the function names from gfx_v11* to mes_v11*
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>

The patch itself looks good, but this really need the eviction fence to 
work properly.

Otherwise it can be that the BO mapped into the GART is evicted at some 
point.

Christian.

> ---
>   .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 77 +++++++++++++++++++
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
>   2 files changed, 78 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> index 8d2cd61af26b..37b80626e792 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> @@ -30,6 +30,74 @@
>   #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>   #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
>   
> +static int
> +mes_v11_0_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo)
> +{
> +	int ret;
> +
> +	ret = amdgpu_bo_reserve(bo, true);
> +	if (ret) {
> +		DRM_ERROR("Failed to reserve bo. ret %d\n", ret);
> +		goto err_reserve_bo_failed;
> +	}
> +
> +	ret = amdgpu_ttm_alloc_gart(&bo->tbo);
> +	if (ret) {
> +		DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
> +		goto err_map_bo_gart_failed;
> +	}
> +
> +	amdgpu_bo_unreserve(bo);
> +	bo = amdgpu_bo_ref(bo);
> +
> +	return 0;
> +
> +err_map_bo_gart_failed:
> +	amdgpu_bo_unreserve(bo);
> +err_reserve_bo_failed:
> +	return ret;
> +}
> +
> +static int
> +mes_v11_0_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
> +			      struct amdgpu_usermode_queue *queue,
> +			      uint64_t wptr)
> +{
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	struct amdgpu_bo_va_mapping *wptr_mapping;
> +	struct amdgpu_vm *wptr_vm;
> +	struct amdgpu_userq_obj *wptr_obj = &queue->wptr_obj;
> +	int ret;
> +
> +	wptr_vm = queue->vm;
> +	ret = amdgpu_bo_reserve(wptr_vm->root.bo, false);
> +	if (ret)
> +		return ret;
> +
> +	wptr &= AMDGPU_GMC_HOLE_MASK;
> +	wptr_mapping = amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> PAGE_SHIFT);
> +	amdgpu_bo_unreserve(wptr_vm->root.bo);
> +	if (!wptr_mapping) {
> +		DRM_ERROR("Failed to lookup wptr bo\n");
> +		return -EINVAL;
> +	}
> +
> +	wptr_obj->obj = wptr_mapping->bo_va->base.bo;
> +	if (wptr_obj->obj->tbo.base.size > PAGE_SIZE) {
> +		DRM_ERROR("Requested GART mapping for wptr bo larger than one page\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = mes_v11_0_map_gtt_bo_to_gart(adev, wptr_obj->obj);
> +	if (ret) {
> +		DRM_ERROR("Failed to map wptr bo to GART\n");
> +		return ret;
> +	}
> +
> +	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset_no_check(wptr_obj->obj);
> +	return 0;
> +}
> +
>   static int mes_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
>   			       struct amdgpu_usermode_queue *queue,
>   			       struct amdgpu_mqd_prop *userq_props)
> @@ -61,6 +129,7 @@ static int mes_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
>   	queue_input.queue_size = userq_props->queue_size >> 2;
>   	queue_input.doorbell_offset = userq_props->doorbell_index;
>   	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
> +	queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
>   
>   	amdgpu_mes_lock(&adev->mes);
>   	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
> @@ -187,6 +256,13 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>   		goto free_mqd;
>   	}
>   
> +	/* FW expects WPTR BOs to be mapped into GART */
> +	r = mes_v11_0_create_wptr_mapping(uq_mgr, queue, userq_props->wptr_gpu_addr);
> +	if (r) {
> +		DRM_ERROR("Failed to create WPTR mapping\n");
> +		goto free_ctx;
> +	}
> +
>   	/* Map userqueue into FW using MES */
>   	r = mes_v11_0_userq_map(uq_mgr, queue, userq_props);
>   	if (r) {
> @@ -216,6 +292,7 @@ mes_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
>   			    struct amdgpu_usermode_queue *queue)
>   {
>   	mes_v11_0_userq_unmap(uq_mgr, queue);
> +	amdgpu_bo_unref(&queue->wptr_obj.obj);
>   	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
>   	kfree(queue->userq_prop);
>   	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index 643f31474bd8..ffe8a3d73756 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -45,6 +45,7 @@ struct amdgpu_usermode_queue {
>   	struct amdgpu_vm	*vm;
>   	struct amdgpu_userq_obj mqd;
>   	struct amdgpu_userq_obj fw_obj;
> +	struct amdgpu_userq_obj wptr_obj;
>   };
>   
>   struct amdgpu_userq_funcs {

