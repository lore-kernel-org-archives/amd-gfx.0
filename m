Return-Path: <SRS0=ZtFC=PY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36DFC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 07:12:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C92A61250
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 07:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7C92A61250
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F37A26E043;
	Fri,  5 Nov 2021 07:12:00 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF82C6E043
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Nov 2021 07:11:59 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id d24so12284252wra.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Nov 2021 00:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=eLpXRjES2Kwf7Q710Ki8UyjLtUmOsB4GT0amPnD3jIo=;
 b=eC3w4ykcur6JEaKeeZvJ59dqq7BSJgkYoUdR94LjbPSDr0qPUzJw3e6pH8NGSQe8R5
 NMkKorYtmeR7IlUwn8tYc/eozroCQTIPr+RghIZc+2c/fG/fxuXg3h/tjGvtAsqsc5UB
 R+o9bKrIowuhyHLi6h/tb2rkN3/WY1BwHqP4XunhIGFpe0FR8nSF/5SiQkQqFewDqkCO
 //yParWHhsYUTtEoSHoUlDHCk3vdWKsM0UsTrPpAROCf5rG8HZIEL5QcDKee+t8FLupR
 A369XF5PZL+Yd4UAz6nASDh2QM0bjexNs0yal916c1S7+dStwu7wZszcKpWtDHp8CaSi
 htEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=eLpXRjES2Kwf7Q710Ki8UyjLtUmOsB4GT0amPnD3jIo=;
 b=CCr3+ieR6yfWgwycFN/sVa+fLobkLmRu+Aa6knsZu9T7X7o3SxbVIu1dUf/zB7mM+2
 z/u/yWe6GjFJMHopIE8fds6Xe08bgfMrLPYufZB+W0q5UDsCyX8dGt3DLSqOzrfvWzsG
 RFJxbLy+X5n32RHwGXYxxEP2X947XyjWm+EaeFrmbqJpORnDvkrURuFfIkqoOYvWeIY6
 1I/blR3tRsZy5jMs3ZCAPkL+zMULrBk7ydDFUd0OaN2iOujCnAIHnFBVhEC8e9mOIgik
 8KFRq5sx/t7BkJbe8wPV0XuUjbtHcmnu67lDssYzsVr+YLlH3grXNGUBEZoYRfUaMUSM
 AMOw==
X-Gm-Message-State: AOAM530iTEJ49iN4s6+oSN9u9ocR6QqS5w4Ty9fKD0p5r3SDaxClf2kH
 65WQzXK60NCS8NSyoBRprjY=
X-Google-Smtp-Source: ABdhPJzILs3GVVcMtoCc8WDG7I0RaToN4PrYQsOauL4zyUBoTJ9H64o4HqepruKuft8vNkJsQt04+g==
X-Received: by 2002:a05:6000:2af:: with SMTP id
 l15mr73607614wry.296.1636096317065; 
 Fri, 05 Nov 2021 00:11:57 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id j8sm6832280wrh.16.2021.11.05.00.11.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Nov 2021 00:11:56 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amdgpu: Fix dangling kfd_bo pointer for shared BOs
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211104230513.1531770-1-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <f00ff936-6a81-b630-9d13-35ad6040a4a1@gmail.com>
Date: Fri, 5 Nov 2021 08:11:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211104230513.1531770-1-Felix.Kuehling@amd.com>
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
Cc: ramesh.errabolu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 05.11.21 um 00:05 schrieb Felix Kuehling:
> If a kfd_bo was shared (e.g. a dmabuf export), the original kfd_bo may be
> freed when the amdgpu_bo still lives on. Free the kfd_bo struct in the
> release_notify callback then the amdgpu_bo is freed.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 +++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c       |  2 +-
>   3 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 4accd584886b..5f658823a637 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -307,7 +307,7 @@ void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev);
>   void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
>   void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>   				struct amdgpu_vm *vm);
> -void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo);
> +void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo);
>   void amdgpu_amdkfd_reserve_system_mem(uint64_t size);
>   #else
>   static inline
> @@ -322,7 +322,7 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>   }
>   
>   static inline
> -void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo)
> +void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
>   {
>   }
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 5174762f0b46..94fccf0b47ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -201,7 +201,7 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
>   	spin_unlock(&kfd_mem_limit.mem_limit_lock);
>   }
>   
> -void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo)
> +void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>   	u32 domain = bo->preferred_domains;
> @@ -213,6 +213,8 @@ void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo)
>   	}
>   
>   	unreserve_mem_limit(adev, amdgpu_bo_size(bo), domain, sg);
> +
> +	kfree(bo->kfd_bo);
>   }
>   
>   
> @@ -1599,9 +1601,13 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   	drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
>   	if (mem->dmabuf)
>   		dma_buf_put(mem->dmabuf);
> -	drm_gem_object_put(&mem->bo->tbo.base);
>   	mutex_destroy(&mem->lock);
> -	kfree(mem);
> +
> +	/* If this releases the last reference, it will end up calling
> +	 * amdgpu_amdkfd_release_notify and kfree the mem struct. That's why
> +	 * this needs to be the last call here.
> +	 */
> +	drm_gem_object_put(&mem->bo->tbo.base);
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 6b25982a9077..156002db24e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1279,7 +1279,7 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>   	abo = ttm_to_amdgpu_bo(bo);
>   
>   	if (abo->kfd_bo)
> -		amdgpu_amdkfd_unreserve_memory_limit(abo);
> +		amdgpu_amdkfd_release_notify(abo);
>   
>   	/* We only remove the fence if the resv has individualized. */
>   	WARN_ON_ONCE(bo->type == ttm_bo_type_kernel

