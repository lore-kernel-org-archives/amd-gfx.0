Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C292EC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 08:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4130910E1E2;
	Thu,  9 Nov 2023 08:16:26 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B1F310E1E2
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 08:16:12 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-408002b5b9fso3708935e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Nov 2023 00:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699517771; x=1700122571; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dPWWvuX9xIb1ZpxftEVNHlnd0VTUKHtRoJCsKoxv+vQ=;
 b=Vx7K3ev9KarpV0jUNkbybB0kHpLYw6b+N1k+PJOBcwepV52cFLemVuFRsH9ZrIwWm9
 grGkBYdU1QyR5ZaAC5rW3J6xXOceiD+3MPaOgWlJBZyv4Ola/PfvlSYo0p03yuohiO3j
 ghhTrhe9P6Ao/fbFsrBpwHP56Xq+JKdqKAln4Qp6CJ5QEeU0rmfG32mg8XIzk7lXeXi3
 hCxU+iAnJY/rgH9Dz+17LZMQS+Xs1RNY0WoR0iL7rNyFlPUuJuXLRzvEjz1feB3b9CwP
 upXkwMNtrSyYbx7QnbpR68Pkag41wHkZtcr74RPYlNeJPVYbZMyR/2OtxZ61QRgL50i4
 ALXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699517771; x=1700122571;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dPWWvuX9xIb1ZpxftEVNHlnd0VTUKHtRoJCsKoxv+vQ=;
 b=jmZZztN+6uxF3H3AgL5GHpGlZQbOBQ0aecw7Gx8N1+J9ml9wKCcSJEU5VekYeWv7cJ
 XrPt+9VzAZ3MsP6dyx7tszCuI6ZuayHDZ/zSTZDK7rlVM3+ljnZdWCidq6dGxVph8Zf5
 mAURkzIDxdSbB52XhT+SJniOfn47sEgM8IzbczZuCCsEf16J/eqp2QBtqD7fag+8nq+B
 WPfuFrfw14UA6ny97mK6l8BBkGBz6mKbGJAeNTQ9P/1zCvKzEu1jaxbdnykO53OA+Q1x
 NRrRzmMkSmtu/x54fTY/4SM6Jgwbkrd6G4vmkgWpPZ4O4mw05gbubDkqeKP/mfbLPT9X
 /Fqg==
X-Gm-Message-State: AOJu0YyYpx+AF1MFDND4dds634fMZQaPipSndIN80GrewubuITpDw6fa
 CNgJRFpKs3r5JwstiDxr29k=
X-Google-Smtp-Source: AGHT+IHIq2KXy/ZhXTPxxf16R4dDmfaWZz+HID09UZZ7xJ3h4/9yAPcB7imkwlSutdBd9M0pn/K2xQ==
X-Received: by 2002:a05:600c:1f8e:b0:409:79cb:1e15 with SMTP id
 je14-20020a05600c1f8e00b0040979cb1e15mr3851698wmb.37.1699517770614; 
 Thu, 09 Nov 2023 00:16:10 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 h7-20020a05600c350700b004090ca6d785sm1296389wmq.2.2023.11.09.00.16.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 00:16:10 -0800 (PST)
Message-ID: <b4c31eb4-eded-49f4-b518-e6fb67d65e68@gmail.com>
Date: Thu, 9 Nov 2023 09:16:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] drm/amdkfd: Import DMABufs for interop through DRM
Content-Language: en-US
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231107165814.3628510-1-Felix.Kuehling@amd.com>
 <20231107165814.3628510-5-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231107165814.3628510-5-Felix.Kuehling@amd.com>
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
Cc: xiaogang.chen@amd.com, ramesh.errabolu@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 07.11.23 um 17:58 schrieb Felix Kuehling:
> Use drm_gem_prime_fd_to_handle to import DMABufs for interop. This
> ensures that a GEM handle is created on import and that obj->dma_buf
> will be set and remain set as long as the object is imported into KFD.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  9 ++-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 64 +++++++++++++------
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 15 ++---
>   3 files changed, 52 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 4caf8cece028..88a0e0734270 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -318,11 +318,10 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
>   					    struct dma_fence **ef);
>   int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
>   					      struct kfd_vm_fault_info *info);
> -int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
> -				      struct dma_buf *dmabuf,
> -				      uint64_t va, void *drm_priv,
> -				      struct kgd_mem **mem, uint64_t *size,
> -				      uint64_t *mmap_offset);
> +int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device *adev, int fd,
> +					 uint64_t va, void *drm_priv,
> +					 struct kgd_mem **mem, uint64_t *size,
> +					 uint64_t *mmap_offset);
>   int amdgpu_amdkfd_gpuvm_export_dmabuf(struct kgd_mem *mem,
>   				      struct dma_buf **dmabuf);
>   void amdgpu_amdkfd_debug_mem_fence(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 4bb8b5fd7598..1077de8bced2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2006,8 +2006,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   
>   	/* Free the BO*/
>   	drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
> -	if (!mem->is_imported)
> -		drm_gem_handle_delete(adev->kfd.client.file, mem->gem_handle);
> +	drm_gem_handle_delete(adev->kfd.client.file, mem->gem_handle);
>   	if (mem->dmabuf) {
>   		dma_buf_put(mem->dmabuf);
>   		mem->dmabuf = NULL;
> @@ -2363,34 +2362,26 @@ int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
> -				      struct dma_buf *dma_buf,
> -				      uint64_t va, void *drm_priv,
> -				      struct kgd_mem **mem, uint64_t *size,
> -				      uint64_t *mmap_offset)
> +static int import_obj_create(struct amdgpu_device *adev,
> +			     struct dma_buf *dma_buf,
> +			     struct drm_gem_object *obj,
> +			     uint64_t va, void *drm_priv,
> +			     struct kgd_mem **mem, uint64_t *size,
> +			     uint64_t *mmap_offset)
>   {
>   	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
> -	struct drm_gem_object *obj;
>   	struct amdgpu_bo *bo;
>   	int ret;
>   
> -	obj = amdgpu_gem_prime_import(adev_to_drm(adev), dma_buf);
> -	if (IS_ERR(obj))
> -		return PTR_ERR(obj);
> -
>   	bo = gem_to_amdgpu_bo(obj);
>   	if (!(bo->preferred_domains & (AMDGPU_GEM_DOMAIN_VRAM |
> -				    AMDGPU_GEM_DOMAIN_GTT))) {
> +				    AMDGPU_GEM_DOMAIN_GTT)))
>   		/* Only VRAM and GTT BOs are supported */
> -		ret = -EINVAL;
> -		goto err_put_obj;
> -	}
> +		return -EINVAL;
>   
>   	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
> -	if (!*mem) {
> -		ret = -ENOMEM;
> -		goto err_put_obj;
> -	}
> +	if (!*mem)
> +		return -ENOMEM;
>   
>   	ret = drm_vma_node_allow(&obj->vma_node, drm_priv);
>   	if (ret)
> @@ -2440,8 +2431,41 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
>   	drm_vma_node_revoke(&obj->vma_node, drm_priv);
>   err_free_mem:
>   	kfree(*mem);
> +	return ret;
> +}
> +
> +int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device *adev, int fd,
> +					 uint64_t va, void *drm_priv,
> +					 struct kgd_mem **mem, uint64_t *size,
> +					 uint64_t *mmap_offset)
> +{
> +	struct drm_gem_object *obj;
> +	uint32_t handle;
> +	int ret;
> +
> +	ret = drm_gem_prime_fd_to_handle(&adev->ddev, adev->kfd.client.file, fd,
> +					 &handle);
> +	if (ret)
> +		return ret;
> +	obj = drm_gem_object_lookup(adev->kfd.client.file, handle);
> +	if (!obj) {
> +		ret = -EINVAL;
> +		goto err_release_handle;
> +	}
> +
> +	ret = import_obj_create(adev, obj->dma_buf, obj, va, drm_priv, mem, size,
> +				mmap_offset);
> +	if (ret)
> +		goto err_put_obj;
> +
> +	(*mem)->gem_handle = handle;
> +
> +	return 0;
> +
>   err_put_obj:
>   	drm_gem_object_put(obj);
> +err_release_handle:
> +	drm_gem_handle_delete(adev->kfd.client.file, handle);
>   	return ret;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 4417a9863cd0..1a2e9f564b7f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1564,16 +1564,11 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
>   {
>   	struct kfd_ioctl_import_dmabuf_args *args = data;
>   	struct kfd_process_device *pdd;
> -	struct dma_buf *dmabuf;
>   	int idr_handle;
>   	uint64_t size;
>   	void *mem;
>   	int r;
>   
> -	dmabuf = dma_buf_get(args->dmabuf_fd);
> -	if (IS_ERR(dmabuf))
> -		return PTR_ERR(dmabuf);
> -
>   	mutex_lock(&p->mutex);
>   	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
>   	if (!pdd) {
> @@ -1587,10 +1582,10 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
>   		goto err_unlock;
>   	}
>   
> -	r = amdgpu_amdkfd_gpuvm_import_dmabuf(pdd->dev->adev, dmabuf,
> -					      args->va_addr, pdd->drm_priv,
> -					      (struct kgd_mem **)&mem, &size,
> -					      NULL);
> +	r = amdgpu_amdkfd_gpuvm_import_dmabuf_fd(pdd->dev->adev, args->dmabuf_fd,
> +						 args->va_addr, pdd->drm_priv,
> +						 (struct kgd_mem **)&mem, &size,
> +						 NULL);
>   	if (r)
>   		goto err_unlock;
>   
> @@ -1601,7 +1596,6 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
>   	}
>   
>   	mutex_unlock(&p->mutex);
> -	dma_buf_put(dmabuf);
>   
>   	args->handle = MAKE_HANDLE(args->gpu_id, idr_handle);
>   
> @@ -1612,7 +1606,6 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
>   					       pdd->drm_priv, NULL);
>   err_unlock:
>   	mutex_unlock(&p->mutex);
> -	dma_buf_put(dmabuf);
>   	return r;
>   }
>   

