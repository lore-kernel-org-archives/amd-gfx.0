Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1B4C4167B
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Nov 2023 13:29:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD49110E8A9;
	Thu,  2 Nov 2023 13:29:13 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEAFD10E89E
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Nov 2023 13:29:10 +0000 (UTC)
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2c5b7764016so12662081fa.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Nov 2023 06:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698931749; x=1699536549; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VDLCpJaytQ1IoJJekxyMKlfZWrbrIT9WhMyAdiOSx0g=;
 b=Z6Rbkb7Abx2pMmW31UcVQIURC/WTNYrcsJRULFw75Fo7OAfdTFiD3JLrvhpk01/dfi
 eCs9UJgK6k+x4Lv0x2Smb9VF15dAjhIgh98xABVJ/Z2A5Psvld9HcovOw2A870gcTpLp
 UJJr0c4HvxvpjGahOOjiPTOER5KepBVWe3tbBzV6oqVM5GRMSBzi3eAp/7gyknmf4ma5
 JLApnz+j6hFPnF/cZBkEEYPOCufTfegWNl4OOMSwtrxFx5PpSlWRex/hQKMJ4NlXg6Gi
 Z7mEqJiNgVZjsO8dfxA4IMEXCunpr+eh+UZ9mv4LmtOXZzgyGcHYSg+OQ6+Qmm8nshlt
 Gx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698931749; x=1699536549;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VDLCpJaytQ1IoJJekxyMKlfZWrbrIT9WhMyAdiOSx0g=;
 b=S3g3RtxF1tSrGqx9gWtlAc3xQGD4WzsdTQd2XydKGwOGCMjyBdbB4SrUqCl5aW2G26
 +n4QieBPJWWw1ZK4k2bYk+pK70YR3zEZyKguxH6e3bz4cNU0sjbi5nFyQHmQio7ehGjK
 Aex0TkW7MaWgCES7gtfOhnF04MzNAB2EvuzmcU76AMnNCIL8SqSi5GVN+GZgf7uXBuME
 n1xeVlV+zcFnWdrzcd4/B2jevAcsoK/eztRBi3dUqVTmz1hOVZJmmspoHbFMXQY/pq45
 P0qDxAZQvj95+dsr8D35ntC0+4l6Nh7XyozhSSCrxfWGAtnborDh9QNsw7smXKDTcdOq
 tRyw==
X-Gm-Message-State: AOJu0Yy1Xbtw00j0NDJKvDJksxGWIrlhGITOhHGtD5A8K/NK+njD9krm
 FC4G1aVQsA6Vj9k6tpdRONg5JnVsZwU=
X-Google-Smtp-Source: AGHT+IGeVokY1saTazkhFuPz7OWID8QwjbLmDfcxZeqHSkhM3JjBNOGxqu4dutjw/9tpdmeJT1vVXQ==
X-Received: by 2002:a2e:9ed4:0:b0:2c6:f173:7d90 with SMTP id
 h20-20020a2e9ed4000000b002c6f1737d90mr1494873ljk.12.1698931748866; 
 Thu, 02 Nov 2023 06:29:08 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 j28-20020a05600c1c1c00b003fe15ac0934sm4270021wms.1.2023.11.02.06.29.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Nov 2023 06:29:08 -0700 (PDT)
Message-ID: <7ca23a78-c6c1-4273-8fd3-33525b310758@gmail.com>
Date: Thu, 2 Nov 2023 14:29:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Use drm_exec for seq64 bo lock
Content-Language: en-US
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231101162602.4122-1-Arunpravin.PaneerSelvam@amd.com>
 <20231101162602.4122-2-Arunpravin.PaneerSelvam@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231101162602.4122-2-Arunpravin.PaneerSelvam@amd.com>
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 01.11.23 um 17:26 schrieb Arunpravin Paneer Selvam:
> Replace seq64 bo lock sequences with drm_exec.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 73 ++++++++++-------------
>   1 file changed, 33 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> index 63d8b68023be..810f7637096e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> @@ -25,6 +25,8 @@
>   #include "amdgpu.h"
>   #include "amdgpu_seq64.h"
>   
> +#include <drm/drm_exec.h>
> +
>   /**
>    * DOC: amdgpu_seq64
>    *
> @@ -68,11 +70,8 @@ static inline u64 amdgpu_seq64_get_va_base(struct amdgpu_device *adev)
>   int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		     struct amdgpu_bo_va **bo_va)
>   {
> -	struct ttm_validate_buffer seq64_tv;
> -	struct amdgpu_bo_list_entry pd;
> -	struct ww_acquire_ctx ticket;
> -	struct list_head list;
>   	struct amdgpu_bo *bo;
> +	struct drm_exec exec;
>   	u64 seq64_addr;
>   	int r;
>   
> @@ -80,23 +79,20 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	if (!bo)
>   		return -EINVAL;
>   
> -	INIT_LIST_HEAD(&list);
> -	INIT_LIST_HEAD(&seq64_tv.head);
> -
> -	seq64_tv.bo = &bo->tbo;
> -	seq64_tv.num_shared = 1;
> -
> -	list_add(&seq64_tv.head, &list);
> -	amdgpu_vm_get_pd_bo(vm, &list, &pd);
> -
> -	r = ttm_eu_reserve_buffers(&ticket, &list, true, NULL);
> -	if (r)
> -		return r;
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
> +	drm_exec_until_all_locked(&exec) {
> +		r = amdgpu_vm_lock_pd(vm, &exec, 0);
> +		if (likely(!r))
> +			r = drm_exec_lock_obj(&exec, &bo->tbo.base);
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(r))
> +			goto error;
> +	}
>   
>   	*bo_va = amdgpu_vm_bo_add(adev, vm, bo);
>   	if (!*bo_va) {
>   		r = -ENOMEM;
> -		goto error_vm;
> +		goto error;
>   	}
>   
>   	seq64_addr = amdgpu_seq64_get_va_base(adev);
> @@ -104,23 +100,19 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			     AMDGPU_PTE_READABLE);
>   	if (r) {
>   		DRM_ERROR("failed to do bo_map on userq sem, err=%d\n", r);
> -		goto error_map;
> +		amdgpu_vm_bo_del(adev, *bo_va);
> +		goto error;
>   	}
>   
>   	r = amdgpu_vm_bo_update(adev, *bo_va, false);
>   	if (r) {
>   		DRM_ERROR("failed to do vm_bo_update on userq sem\n");
> -		goto error_map;
> +		amdgpu_vm_bo_del(adev, *bo_va);
> +		goto error;
>   	}
>   
> -	ttm_eu_backoff_reservation(&ticket, &list);
> -
> -	return 0;
> -
> -error_map:
> -	amdgpu_vm_bo_del(adev, *bo_va);
> -error_vm:
> -	ttm_eu_backoff_reservation(&ticket, &list);
> +error:
> +	drm_exec_fini(&exec);
>   	return r;
>   }
>   
> @@ -134,12 +126,10 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>    */
>   void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *fpriv)
>   {
> -	struct ttm_validate_buffer seq64_tv;
> -	struct amdgpu_bo_list_entry pd;
> -	struct ww_acquire_ctx ticket;
> -	struct list_head list;
>   	struct amdgpu_vm *vm;
>   	struct amdgpu_bo *bo;
> +	struct drm_exec exec;
> +	int r;
>   
>   	if (!fpriv->seq64_va)
>   		return;
> @@ -149,20 +139,23 @@ void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *fpriv)
>   		return;
>   
>   	vm = &fpriv->vm;
> -	INIT_LIST_HEAD(&list);
> -	INIT_LIST_HEAD(&seq64_tv.head);
>   
> -	seq64_tv.bo = &bo->tbo;
> -	seq64_tv.num_shared = 1;
> -
> -	list_add(&seq64_tv.head, &list);
> -	amdgpu_vm_get_pd_bo(vm, &list, &pd);
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
> +	drm_exec_until_all_locked(&exec) {
> +		r = amdgpu_vm_lock_pd(vm, &exec, 0);
> +		if (likely(!r))
> +			r = drm_exec_lock_obj(&exec, &bo->tbo.base);
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(r))
> +			goto error;
> +	}
>   
> -	ttm_eu_reserve_buffers(&ticket, &list, false, NULL);
>   	amdgpu_vm_bo_del(adev, fpriv->seq64_va);
> -	ttm_eu_backoff_reservation(&ticket, &list);
>   
>   	fpriv->seq64_va = NULL;
> +
> +error:
> +	drm_exec_fini(&exec);
>   }
>   
>   /**

