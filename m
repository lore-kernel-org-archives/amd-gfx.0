Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CD5CF58C8
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 12:32:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4C7A10E315;
	Thu, 26 Sep 2024 12:32:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Oef+/Hx8";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8856810E315
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 12:32:53 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-37ccfada422so373823f8f.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 05:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727353972; x=1727958772; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VT/k1O56pz6Fr0oE9HA29Kyof9pT15go0AwqjiY4gao=;
 b=Oef+/Hx8bqG3cAEbcsSFFO9V1PKDD8w4BVapmHWVriJ5va8w4ijLOxsZ9wCf4imixw
 YgpTH620WB+4lhaFs8szcNDH1b13QfdNj7L6kYZADaOPnZaxdsbjw/+aS9uWf3QMKk+r
 E53xZfPCpSR/VF9m99Nf+HYqD1Jss+rpYnBb2FNnow9YHEk4GSMkObns7r2loyP7zfVK
 UMnjdoolvXdfn5EBBgKDCUJEJTNTj6ilcS8yXTICCnfXm10POGM7phlsrmY2St8nqfBa
 H8L4kpq9hLu2RLxozsiPGP1jDfmViWsTD+dIrzOeMcXnN6PTtSi7viAyXbMsK3tC/8FZ
 bRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727353972; x=1727958772;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VT/k1O56pz6Fr0oE9HA29Kyof9pT15go0AwqjiY4gao=;
 b=oEeoPGQY7PrqjVM0as0KcrBq7n+R8r3NBU28iBcm+cSC1FGtpaDlAHC+K2cLaA6LyJ
 aI+Zr+AzkkUMICeOsebnV5jKpmHxnKA5PhpSmiYl6IeEc3YRPJ4gb0585nTTW49LFGc0
 q7bO9dr8FClMqrmdVKS2DF2tnQyA/hOJisj+rQivUKMYM6U908bp/gI4DCfxCl43b8Q4
 kdcWwRRTyz9XTbNK8v9CHzp/eFB18SPEz5eEn07YRyKvkSnG1pwiwlJOdFAcbBt59+Ib
 t2XAXHREZWpW+8OhGHpr5Bh7W45vs+AzGWeZ1rcK2ggX+xFexK/Q+p7FZ7tvoAwOJqh7
 6PHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQEuByZXm33hdn6nFiQKooMDAp8y4/smydkz14iGNPy5TvXLOdNwaLhp6Y2MBVLB7s5zVIbWHe@lists.freedesktop.org
X-Gm-Message-State: AOJu0YywKXbMBWf5l7rUX8WZ9m0tlPpifw/Vnn8HKjC0ClHX3tJjX9mx
 x50fFyOMTK5I3Q4e8SiBnzT2R3RpMkT3h+5bUCJU5TMTIBblOxGm9Ykab5ps
X-Google-Smtp-Source: AGHT+IFfkpeHU7Puaz4Y0KLJrr8hMBXw5WmfELu1b8dYactzJ/IEXeopS5St827nWBJaQ+pihyE2ig==
X-Received: by 2002:a05:6000:1449:b0:37c:d179:2f73 with SMTP id
 ffacd0b85a97d-37cd17930acmr1290469f8f.13.1727353971349; 
 Thu, 26 Sep 2024 05:32:51 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e969f1a76sm45764385e9.12.2024.09.26.05.32.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2024 05:32:50 -0700 (PDT)
Message-ID: <64119b68-12d0-4bc3-890e-edf809cb68df@gmail.com>
Date: Thu, 26 Sep 2024 14:32:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/08] drm/amdgpu: add vm root BO lock before accessing
 the vm
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com
References: <20240925195928.142001-1-Arunpravin.PaneerSelvam@amd.com>
 <20240925195928.142001-8-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240925195928.142001-8-Arunpravin.PaneerSelvam@amd.com>
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

Am 25.09.24 um 21:59 schrieb Arunpravin Paneer Selvam:
> Add a vm root BO lock before accessing the userqueue VM.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 43429661f62d..52722b738316 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -320,7 +320,6 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
>   /**
>    * amdgpu_userq_fence_read_wptr - Read the userq wptr value
>    *
> - * @filp: drm file private data structure
>    * @queue: user mode queue structure pointer
>    * @wptr: write pointer value
>    *
> @@ -330,23 +329,27 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
>    *
>    * Returns wptr value on success, error on failure.
>    */
> -static int amdgpu_userq_fence_read_wptr(struct drm_file *filp,
> -					struct amdgpu_usermode_queue *queue,
> +static int amdgpu_userq_fence_read_wptr(struct amdgpu_usermode_queue *queue,
>   					u64 *wptr)
>   {
> -	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>   	struct amdgpu_bo_va_mapping *mapping;
> -	struct amdgpu_vm *vm = &fpriv->vm;
>   	struct amdgpu_bo *bo;
>   	u64 addr, *ptr;
>   	int r;
>   
> +	r = amdgpu_bo_reserve(queue->vm->root.bo, false);
> +	if (r)
> +		return r;
> +
>   	addr = queue->userq_prop->wptr_gpu_addr;
>   	addr &= AMDGPU_GMC_HOLE_MASK;
>   
> -	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr >> PAGE_SHIFT);
> -	if (!mapping)
> +	mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, addr >> PAGE_SHIFT);
> +	amdgpu_bo_unreserve(queue->vm->root.bo);

You need to keep the VM locked until you are done with the mapping. 
Otherwise the mapping could be released at any time.

Regards,
Christian.

> +	if (!mapping) {
> +		DRM_ERROR("Failed to lookup amdgpu_bo_va_mapping\n");
>   		return -EINVAL;
> +	}
>   
>   	bo = mapping->bo_va->base.bo;

If you only need the BO then grab a temporary BO reference here, drop 
the VM lock and acquire the BO.

When you are done with everything just drop the BO lock and then the 
temporary BO reference.

Regards,
Christian.

>   	r = amdgpu_bo_reserve(bo, true);
> @@ -448,7 +451,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   		goto exec_fini;
>   	}
>   
> -	r = amdgpu_userq_fence_read_wptr(filp, queue, &wptr);
> +	r = amdgpu_userq_fence_read_wptr(queue, &wptr);
>   	if (r)
>   		goto exec_fini;
>   

