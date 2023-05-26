Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C495C77B7A
	for <amd-gfx@archiver.kernel.org>; Fri, 26 May 2023 07:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12ACD10E186;
	Fri, 26 May 2023 07:36:28 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BCFD10E186
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 May 2023 07:36:26 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-30a1fdde3d6so356977f8f.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 May 2023 00:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685086584; x=1687678584;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=urPBCDCBgOCMa6PsFgFh/szt7StOPYkBEfy3mW7fKfE=;
 b=qOHkOljrSwNLVFym89LbvQ9+SPRrlH4bSNyJvbjsjd431lTMmtp4CfW8CFtmwZmslI
 GaPQFR4hVxcxKbl0rxxC/RrMkQWvsPPzxv0BsqLbWEdJWOWSM1vIXQxDnY3kreCd3eQH
 GjZBsgiZHadXFhlZXr7igUnSaCa7XXumZ/5loU4vTx9wadxA8a7jHAj/0nwIyMQrHvF0
 8wO+m7TnWaY7+KiwY28DpG+zlSpuJeCgt8XxXzywv/7O+P80A4TPZ6PbSgP4CZKqG8bw
 7K0KERL8NB+oXpV04DsFKYfvBUEL1SNhn203bW1hJ+9PB7pfoqgls9Gl1JmmwQLrWjsH
 PmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685086584; x=1687678584;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=urPBCDCBgOCMa6PsFgFh/szt7StOPYkBEfy3mW7fKfE=;
 b=TbwgwL60NujbaDy2Dobij3zVNK53HiJFwAUMv59tF4riVBL11hGfLgH2yb9qmRrfVK
 rzmg0Qx2sAhIiGHZyXLxBaByQQL0PjE1mCsb3eAzPDzKGaso7Rq3pTaTTPdh4xgUh4Y4
 eulZ6NIwxnm0R3u5eAmU6q852F7L++gqzUOQpHEfu1yY4ars5yNDelE7Td4L4JS9H8Yk
 P6yBGv/sHMtSPY44T+CfGI35CQrOOc5qi04wuOmFieT43ZNH/kAcsUgBnlTJJdUrgovm
 GBnSguC/QAF+Ajb2u1TRZaXgig9G/XEhwnikDeIJ4OBjYSDtmILa/jHLpfWCbZrs+coB
 xOiQ==
X-Gm-Message-State: AC+VfDyb4rO6a3X7hN1awcRsGoGX8qHqMBIAlsh68NEP5FgxDGNoTy+w
 mRMUdmQVHKK0vGbwSwEwoS8dPYcblY0=
X-Google-Smtp-Source: ACHHUZ774pqOgzC2RD/qiha+17tm4m+0lacdnw242Lwh3K217zMQWfynmsxO9R/4+w22tVjKbDpxtg==
X-Received: by 2002:adf:f0c5:0:b0:309:4100:7dde with SMTP id
 x5-20020adff0c5000000b0030941007ddemr562514wro.28.1685086583761; 
 Fri, 26 May 2023 00:36:23 -0700 (PDT)
Received: from ?IPV6:2a00:e180:15f5:d00:c60a:fb98:931:83c4?
 ([2a00:e180:15f5:d00:c60a:fb98:931:83c4])
 by smtp.gmail.com with ESMTPSA id
 t6-20020adff606000000b0030632833e74sm4175199wrp.11.2023.05.26.00.36.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 00:36:23 -0700 (PDT)
Message-ID: <4ec70816-e10d-1668-e3f4-cbf76f09506e@gmail.com>
Date: Fri, 26 May 2023 09:36:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: add a flag to indicate if a VM is attached to
 fpriv
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, hawking.zhang@amd.com, lijo.lazar@amd.com,
 Philip.Yang@amd.com, Felix.Kuehling@amd.com
References: <20230524092326.1941139-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230524092326.1941139-1-guchun.chen@amd.com>
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

Am 24.05.23 um 11:23 schrieb Guchun Chen:
> Recent code stores xcp_id to amdgpu bo for accounting memory
> usage or find correct KFD node, and this xcp_id is from file
> private data after opening device. However, not all VMs are
> attached to this fpriv structure like the case in amdgpu_mes_self_test.
> So add a flag to differentiate the cases. Otherwise, KASAN will
> complain out of bound access.

The VM code shouldn't touch the fpriv in any way possible in the first 
place.

Instead we should provide the xcp_id during amdgpu_vm_init() and use it 
to allocate the root PD. All other PDs/PTs should then just use the 
xcp_id from the root PD.

Christian.

>
> [   77.292314] BUG: KASAN: slab-out-of-bounds in amdgpu_vm_pt_create+0x17e/0x4b0 [amdgpu]
> [   77.293845] Read of size 4 at addr ffff888102c48a48 by task modprobe/1069
> [   77.294146] Call Trace:
> [   77.294178]  <TASK>
> [   77.294208]  dump_stack_lvl+0x49/0x63
> [   77.294260]  print_report+0x16f/0x4a6
> [   77.294307]  ? amdgpu_vm_pt_create+0x17e/0x4b0 [amdgpu]
> [   77.295979]  ? kasan_complete_mode_report_info+0x3c/0x200
> [   77.296057]  ? amdgpu_vm_pt_create+0x17e/0x4b0 [amdgpu]
> [   77.297556]  kasan_report+0xb4/0x130
> [   77.297609]  ? amdgpu_vm_pt_create+0x17e/0x4b0 [amdgpu]
> [   77.299202]  __asan_load4+0x6f/0x90
> [   77.299272]  amdgpu_vm_pt_create+0x17e/0x4b0 [amdgpu]
> [   77.300796]  ? amdgpu_init+0x6e/0x1000 [amdgpu]
> [   77.302222]  ? amdgpu_vm_pt_clear+0x750/0x750 [amdgpu]
> [   77.303721]  ? preempt_count_sub+0x18/0xc0
> [   77.303786]  amdgpu_vm_init+0x39e/0x870 [amdgpu]
> [   77.305186]  ? amdgpu_vm_wait_idle+0x90/0x90 [amdgpu]
> [   77.306683]  ? kasan_set_track+0x25/0x30
> [   77.306737]  ? kasan_save_alloc_info+0x1b/0x30
> [   77.306795]  ? __kasan_kmalloc+0x87/0xa0
> [   77.306852]  amdgpu_mes_self_test+0x169/0x620 [amdgpu]
>
> Fixes: ffc6deb773f7("drm/amdkfd: Store xcp partition id to amdgpu bo")
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  5 ++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  5 ++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 12 +++++++++---
>   5 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 41d047e5de69..79b80f9233db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1229,7 +1229,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>   		pasid = 0;
>   	}
>   
> -	r = amdgpu_vm_init(adev, &fpriv->vm);
> +	r = amdgpu_vm_init(adev, &fpriv->vm, true);
>   	if (r)
>   		goto error_pasid;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 49bb6c03d606..3be5219edf88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1345,7 +1345,7 @@ int amdgpu_mes_self_test(struct amdgpu_device *adev)
>   		goto error_pasid;
>   	}
>   
> -	r = amdgpu_vm_init(adev, vm);
> +	r = amdgpu_vm_init(adev, vm, false);
>   	if (r) {
>   		DRM_ERROR("failed to initialize vm\n");
>   		goto error_pasid;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 37b9d8a8dbec..47ffaa1526a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2099,13 +2099,15 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
>    *
>    * @adev: amdgpu_device pointer
>    * @vm: requested vm
> + * @vm_attach_to_fpriv: flag to tell if vm is attached to file private data
>    *
>    * Init @vm fields.
>    *
>    * Returns:
>    * 0 for success, error for failure.
>    */
> -int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
> +int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +		   bool vm_attach_to_fpriv)
>   {
>   	struct amdgpu_bo *root_bo;
>   	struct amdgpu_bo_vm *root;
> @@ -2131,6 +2133,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   
>   	vm->pte_support_ats = false;
>   	vm->is_compute_context = false;
> +	vm->vm_attach_to_fpriv = vm_attach_to_fpriv;
>   
>   	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
>   				    AMDGPU_VM_USE_CPU_FOR_GFX);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index d551fca1780e..62ed14b1fc16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -333,6 +333,9 @@ struct amdgpu_vm {
>   	/* Flag to indicate if VM is used for compute */
>   	bool			is_compute_context;
>   
> +	/* Flag to tell if VM is attached to file private data */
> +	bool vm_attach_to_fpriv;
> +
>   	/* Memory partition number, -1 means any partition */
>   	int8_t			mem_id;
>   };
> @@ -392,7 +395,7 @@ int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			u32 pasid);
>   
>   long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
> -int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm);
> +int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, bool vm_attach_to_fpriv);
>   int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>   void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>   void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index cc3b1b596e56..16b3350aa896 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -502,7 +502,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			int level, bool immediate, struct amdgpu_bo_vm **vmbo)
>   {
> -	struct amdgpu_fpriv *fpriv = container_of(vm, struct amdgpu_fpriv, vm);
> +	struct amdgpu_fpriv *fpriv;
>   	struct amdgpu_bo_param bp;
>   	struct amdgpu_bo *bo;
>   	struct dma_resv *resv;
> @@ -535,7 +535,10 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	bp.type = ttm_bo_type_kernel;
>   	bp.no_wait_gpu = immediate;
> -	bp.xcp_id_plus1 = fpriv->xcp_id == ~0 ? 0 : fpriv->xcp_id + 1;
> +	if (vm->vm_attach_to_fpriv) {
> +		fpriv = container_of(vm, struct amdgpu_fpriv, vm);
> +		bp.xcp_id_plus1 = fpriv->xcp_id == ~0 ? 0 : fpriv->xcp_id + 1;
> +	}
>   
>   	if (vm->root.bo)
>   		bp.resv = vm->root.bo->tbo.base.resv;
> @@ -561,7 +564,10 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	bp.type = ttm_bo_type_kernel;
>   	bp.resv = bo->tbo.base.resv;
>   	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> -	bp.xcp_id_plus1 = fpriv->xcp_id == ~0 ? 0 : fpriv->xcp_id + 1;
> +	if (vm->vm_attach_to_fpriv) {
> +		fpriv = container_of(vm, struct amdgpu_fpriv, vm);
> +		bp.xcp_id_plus1 = fpriv->xcp_id == ~0 ? 0 : fpriv->xcp_id + 1;
> +	}
>   
>   	r = amdgpu_bo_create(adev, &bp, &(*vmbo)->shadow);
>   

