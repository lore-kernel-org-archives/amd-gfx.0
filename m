Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902CD606A31E
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lgSlUC7s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E5E310F2D1;
	Tue, 27 Oct 2026 09:03:08 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9087010F2D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 09:03:02 +0000 (UTC)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-3ab4891fc73so34234651fa.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 02:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793091781; x=1793696581; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=euQv5YDygGUXtlgBjwZ5DWk1KVelrAfn6q5pQp2Lgjo=;
 b=lgSlUC7sZEco7jhtpfopLrbmCaOuxGAQM+3ipVZ+GsyaR0SUxUUdcXcxEu25ZHhNfZ
 gZXaqdsfzrbQyCKNfMfeBXFnSmkjoWtJUmKkHHhqmRQpTXj+qmZ6lBpKUOHUkDbt9rEY
 CkZ9uQ8VR4lnYGxQpl4iRqfT4r64vb1OKrS/pVgU4V5jMI4ouBz1pCjFvblYOCGqHUmX
 TA+lwus7ie2nrl0NpyKxnuzIyQEpYfRdmkNQO2yWVxu9qOOUE7xOkY+ntmDkh6rCc2QI
 fuWlzi/IldCCAsDV8R+FW5lkXsAltcTi2Ialdhg53KQ+np1Z/xQ9TChd08iNkqJLlaE5
 yFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793091781; x=1793696581;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=euQv5YDygGUXtlgBjwZ5DWk1KVelrAfn6q5pQp2Lgjo=;
 b=dahfxcxM6ae/iI6YSeMJLAoZ2Qms5HBYoT1mApb256yA1l76yoAXMAa8frwuwm8Idf
 tremYJi2EvT13enSkdPJmaAPcx/oKZyfFvV5Q3GwH4DtG9gGgxLV6G6kuIIWz85rDvvW
 4KsXLxUZ/INVgeW2Tp7d/k32tkYRryekylhI//afADcF9+U6bi7Wf00c52uigbvBNp2C
 VMjzaoAN1nWO7vWo63oLokAxMjeofy5ecs9+WQ1svDXXX7/GDR+itSLLLqukV2Pf8q0+
 P8C1VMvGLOQNyhU4ItG+Dt0lKG+IoZX1ewNE9Rd83RK/fOQVd/ICHMqyevJFOBn7F5gF
 JOAA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQIAYqrRKCdlf/5unRLT4M8PFU2vF7eKjgJlXBaK18u8lav91rhdI3078LHrFgTgD4sS+hOPaL@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ17vf+LJrgpOKX7mBqyd8zAD3wLLtqnDxf7SdFZrPmdTPg07tv
 5EUFrmJ8pyNbNhX+U3NRARtjmKudA4RZGSlAD13wniA+EBhviRuMr5w4
X-Gm-Gg: AYBFou3yAo718/cOhfJYfWvxcdUBml/lHS7KDVHazx1AQBMw2fILR43ROxrE2EZqtG3
 ivJG8V/ffyKvV6jrLAxXmLOEjtUygBq7De9WL0GfiECWCCWaOgOXrQbCMlSmjN4AiGSb5p60I46
 yvbO026k3tm5rNLTYViiU2z5asLCKBzuHhUBviESQhHEWqHFYISFwZi8CtkkatlqEDw9Dm2JpLA
 w5jJ6vx6PphvM6RiOLIvp5/tcLZioR2JIgUKJeHVx2Gmghc4GHB+yxdVtxb2/FacjdcllTCcHJ1
 5hRwUe8q6udacFy/umPuGJDud/1KNDTA7g0ys4tT0nqd3OJMJsgZu/c9Y+QjFn9uK/EH/g/SVkU
 Kk/BKlfGmd/7xm4Arv05HMnlvllcCUW71UNhXTqGLKvM/AmbYS3V4Px5bEIE5Ud6HgsLkfdOkln
 xxi/RFq93+4ws+xV5OpOg86CEK8kjjBCyxg4kichOvQSWvduzhB8zi9p0byyudmvfafZ+RB/Q9W
 BDz/4Zw/hLSGopZEcYNlLSPBPyYxYsqNfsXlbKx3BaiqMwh5UmbNmcdXZSNoPJgSmbXTxQvm9rf
 YcSPeLni
X-Received: by 2002:a05:6512:b91:b0:5bf:a2ce:1a21 with SMTP id
 2adb3069b0e04-5bfb71cba65mr3126051e87.12.1793091779600; 
 Tue, 27 Oct 2026 02:02:59 -0700 (PDT)
Received: from [10.254.154.15] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e412cc164sm20182069f8f.7.2026.10.27.02.02.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2026 02:02:59 -0700 (PDT)
Message-ID: <b48ff49c-e645-423f-b8a3-7d4b156c2732@gmail.com>
Date: Tue, 27 Oct 2026 10:02:58 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdkfd: Get foreign dma-buf info
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261023144813.1220394-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20261023144813.1220394-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/23/26 16:48, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
> 
> When import a dma-buf into kfd driver the dma-buf can be exported from amdgpu
> driver or another driver/component(foreign).
> 
> Current kfd driver can't handle foreign dma-buf at AMDKFD_IOC_GET_DMABUF_INFO.
> When a foreign dma-buf is imported into kfd driver(ex udmabuf) it becomes a
> normal kfd buf that can be exported, then imported in same or another amdgpu
> device. That requires kfd drive to get new exported dma-buf info before it is
> imported.

Yeah again absolutely clear NAK to that!

Re-exporting the imported DMA-buf this way is *clearly* not allowed!

What you can do is to re-export the original DMA-buf so that you get the same fd you would get from the original exporter.

In other words you can then also ask the original exporter for that information.

Regards,
Christian.

> 
> Extend kfd_ioctl_get_dmabuf_info to handle args->dmabuf_fd that was originally
> exported by foreign component.
> 
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  3 ++
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 47 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 11 ++++-
>  3 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index e3da382ceb3c..170f0ea0b78a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -347,6 +347,9 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device *adev, int fd,
>  					 uint64_t va, void *drm_priv,
>  					 struct kgd_mem **mem, uint64_t *size,
>  					 uint64_t *mmap_offset);
> +int amdgpu_amdkfd_gpuvm_imported_dmabuf_info(void *kgd_info, int fd,
> +					     uint64_t *size, uint32_t *flags,
> +					     uint32_t *gpu_id);
>  int amdgpu_amdkfd_gpuvm_export_dmabuf(struct kgd_mem *mem,
>  				      struct dma_buf **dmabuf);
>  void amdgpu_amdkfd_debug_mem_fence(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index a5d1d83ee5d3..b7fea3a2f5ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2452,6 +2452,53 @@ static int import_obj_create(struct amdgpu_device *adev,
>  	return ret;
>  }
>  
> +int amdgpu_amdkfd_gpuvm_imported_dmabuf_info(void *kgd_info, int fd,
> +					     uint64_t *size, uint32_t *flags,
> +					     uint32_t *gpu_id)
> +{
> +	struct amdkfd_process_info *info = kgd_info;
> +	struct dma_buf *dma_buf;
> +	struct kgd_mem *mem;
> +	int ret = -EINVAL;
> +
> +	if (!info)
> +		return -EINVAL;
> +
> +	dma_buf = dma_buf_get(fd);
> +	if (IS_ERR(dma_buf))
> +		return PTR_ERR(dma_buf);
> +
> +	mutex_lock(&info->lock);
> +	list_for_each_entry(mem, &info->kfd_bo_list, validate_list) {
> +		struct amdgpu_device *bo_adev;
> +		struct kfd_dev *kfd;
> +		int8_t xcp_id;
> +
> +		if (!mem->is_imported || mem->dmabuf != dma_buf)
> +			continue;
> +
> +		if (size)
> +			*size = amdgpu_bo_size(mem->bo);
> +		if (flags)
> +			*flags = mem->alloc_flags;
> +		if (gpu_id) {
> +			bo_adev = amdgpu_ttm_adev(mem->bo->tbo.bdev);
> +			kfd = bo_adev->kfd.dev;
> +			xcp_id = mem->bo->xcp_id;
> +			if (kfd && xcp_id >= 0 && xcp_id < kfd->num_nodes &&
> +			    kfd->nodes[xcp_id])
> +				*gpu_id = kfd->nodes[xcp_id]->id;
> +			else if (kfd && kfd->num_nodes && kfd->nodes[0])
> +				*gpu_id = kfd->nodes[0]->id;
> +		}
> +		ret = 0;
> +		break;
> +	}
> +	mutex_unlock(&info->lock);
> +	dma_buf_put(dma_buf);
> +	return ret;
> +}
> +
>  int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device *adev, int fd,
>  					 uint64_t va, void *drm_priv,
>  					 struct kgd_mem **mem, uint64_t *size,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 1d86ddfd6bde..9ca20331e815 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1595,8 +1595,17 @@ static int kfd_ioctl_get_dmabuf_info(struct file *filep,
>  					  &dmabuf_adev, &args->size,
>  					  &metadata_buffer, args->metadata_size,
>  					  &args->metadata_size, &flags, &xcp_id);
> -	if (r)
> +	if (r) {
> +		/* Foreign dma-buf: report it when this process imported it. */
> +		r = amdgpu_amdkfd_gpuvm_imported_dmabuf_info(p->kgd_process_info,
> +							     args->dmabuf_fd,
> +							     &args->size,
> +							     &args->flags,
> +							     &args->gpu_id);
> +		if (!r)
> +			args->metadata_size = 0;
>  		goto exit;
> +	}
>  
>  	if (xcp_id >= 0)
>  		args->gpu_id = dmabuf_adev->kfd.dev->nodes[xcp_id]->id;

