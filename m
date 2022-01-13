Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7E1C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 12:12:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1719410FA53;
	Thu, 13 Jan 2022 12:12:38 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8124710FA53
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 12:12:37 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id x4so9704785wru.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 04:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=KEFEnyrW8Pye+0+F4Z5gXIwzcIhrmqnB8sfc8Zuwm5g=;
 b=GffY+HDKbq01AojPLvlPnYEkyHQmXSeVZrHhPe1l2deqwFhjfiwcAYphsGGsJR7KLu
 E8P+B79rLLU39UX+mYlGu23989qrZME7XOAuWaBvnlmjJeH7DVs1pjLMrTwylTZNyMi7
 gpTwc0jT1oWrDGE0dpMMmW3r7HYDRSKwcMZ2qm4U6MLNQYFTA4sGtpAXGCOetpRTDOf6
 WpsA48g+4X34vZNul9IkGCAKqpBYeDR50pxaHcOX2W+NXwSaM4u50vulxGGGg4zYzy9p
 FCRlRfAoFTPKwvCUpNQzc4NKut976S6+S4JF4pqNl85EuWxfYpySS38NJN9dwu/rxRZH
 X7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=KEFEnyrW8Pye+0+F4Z5gXIwzcIhrmqnB8sfc8Zuwm5g=;
 b=innG6EOXzr9/Uoo6V/px/0ztpRO+Sbn23MAUHzEJ5d5jPoO+pKnHrDokHW5IZEwJ+D
 pe3BZV0Z2w6Ittb0p/rgvPDeu/JH77FYZeBLEnXLsPlZSw9Cca/E3jtDF6Dm4Bzx1Ss/
 zUM+M7r4iALQqQu1VPiqNAK9c5MGl3g+7xQPx3mN1M+qoM56/G5VHYyXIjqfOMGX2wyR
 pEDt5WlvBsQm/yIutl/xuGDnVK/h4ol8wuq6LnBel1pfQO3pN1SI05Ckfc+XoELM/B4X
 l4ikV0QXAg3YlUVCnrM4zMDZrbLaAwtwe7EtteCtn8QVVN6XnXYOtfHZUcVDff1Kypvf
 qzwA==
X-Gm-Message-State: AOAM5327M2w9lnNOpuqQ2Lr7Nm7uB1sXPw324WqGdB19YBeD+AwVMi88
 yDsOMt+9D2Kkgx0PBQv6Vbk23xeJyJY=
X-Google-Smtp-Source: ABdhPJxJsmq5YQSVCYHQmam8M8EKcA5eR5jtmAsc26sMY3Apm4aHEefa1IcDQC6YTxYHnuA8um9vlw==
X-Received: by 2002:a5d:6903:: with SMTP id t3mr3645710wru.353.1642075955947; 
 Thu, 13 Jan 2022 04:12:35 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:9abc:3441:98f2:35bf?
 ([2a02:908:1252:fb60:9abc:3441:98f2:35bf])
 by smtp.gmail.com with ESMTPSA id a2sm3281483wri.17.2022.01.13.04.12.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jan 2022 04:12:35 -0800 (PST)
Subject: Re: [PATCH 1/1] drm/amdgpu: move bo_va ref counting to internal funcs
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220113120635.7475-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2d7964c4-9d90-25df-4234-6fbe0d66c174@gmail.com>
Date: Thu, 13 Jan 2022 13:12:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220113120635.7475-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 13.01.22 um 13:06 schrieb Nirmoy Das:
> GEM code should not deal with struct amdgpu_bo_va's ref_count.
> Move ref counting to amdgpu_vm.c.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 11 +++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 38 +++++++++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  2 ++
>   3 files changed, 42 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 4a11a2f4fa73..691f0a879c90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -176,12 +176,9 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>   	if (r)
>   		return r;
>   
> -	bo_va = amdgpu_vm_bo_find(vm, abo);
> -	if (!bo_va) {
> -		bo_va = amdgpu_vm_bo_add(adev, vm, abo);
> -	} else {
> -		++bo_va->ref_count;
> -	}
> +	if (!amdgpu_vm_bo_get(vm, abo))
> +		amdgpu_vm_bo_add(adev, vm, abo);
> +
>   	amdgpu_bo_unreserve(abo);
>   	return 0;
>   }
> @@ -218,7 +215,7 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>   		return;
>   	}
>   	bo_va = amdgpu_vm_bo_find(vm, bo);
> -	if (!bo_va || --bo_va->ref_count)
> +	if (!bo_va)
>   		goto out_unlock;
>   
>   	amdgpu_vm_bo_rmv(adev, bo_va);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index b23cb463b106..9d60de6a6697 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1290,16 +1290,49 @@ struct amdgpu_bo_va *amdgpu_vm_bo_find(struct amdgpu_vm *vm,
>   				       struct amdgpu_bo *bo)
>   {
>   	struct amdgpu_vm_bo_base *base;
> +	struct amdgpu_bo_va *bo_va = NULL;
>   
>   	for (base = bo->vm_bo; base; base = base->next) {
>   		if (base->vm != vm)
>   			continue;
>   
> -		return container_of(base, struct amdgpu_bo_va, base);
> +		bo_va = container_of(base, struct amdgpu_bo_va, base);
>   	}
> -	return NULL;
> +
> +	if (bo_va && bo_va->ref_count <= 0)
> +		return NULL;
> +
> +	return bo_va;
>   }
>   
> +/**
> + * amdgpu_vm_bo_get - find the bo_va for a specific vm & bo and increase
> + * the ref_count
> + *
> + * @vm: requested vm
> + * @bo: requested buffer object
> + *
> + * Find @bo inside the requested vm.
> + * Search inside the @bos vm list for the requested vm
> + * Returns the found bo_va with +1 ref_count or NULL if none is found
> + *
> + * Object has to be reserved!
> + *
> + * Returns:
> + * Found bo_va or NULL.
> + */
> +struct amdgpu_bo_va *amdgpu_vm_bo_get(struct amdgpu_vm *vm,
> +				      struct amdgpu_bo *bo)
> +{
> +	struct amdgpu_bo_va *bo_va = amdgpu_vm_bo_find(vm, bo);
> +
> +	if (bo_va)
> +		++bo_va->ref_count;
> +
> +	return bo_va;
> +}
> +
> +
>   /**
>    * amdgpu_vm_map_gart - Resolve gart mapping of addr
>    *
> @@ -2704,6 +2737,7 @@ void amdgpu_vm_bo_rmv(struct amdgpu_device *adev,
>   	if (bo && bo_va->is_xgmi)
>   		amdgpu_xgmi_set_pstate(adev, AMDGPU_XGMI_PSTATE_MIN);
>   
> +	--bo_va->ref_count;
>   	kfree(bo_va);

That here won't work, you are removing and freeing the bo_va even if the 
refcount is not zero yet.

I suggest to have a matching amdgpu_vm_bo_put() function instead.

Regards,
Christian.

>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 85fcfb8c5efd..6d936fb1b934 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -415,6 +415,8 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
>   uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr);
>   struct amdgpu_bo_va *amdgpu_vm_bo_find(struct amdgpu_vm *vm,
>   				       struct amdgpu_bo *bo);
> +struct amdgpu_bo_va *amdgpu_vm_bo_get(struct amdgpu_vm *vm,
> +				       struct amdgpu_bo *bo);
>   struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
>   				      struct amdgpu_vm *vm,
>   				      struct amdgpu_bo *bo);

