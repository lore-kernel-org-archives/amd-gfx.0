Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDF5C001E0
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 11:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B62B910E04C;
	Mon, 23 Oct 2023 11:59:14 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A59810E04C
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 11:59:12 +0000 (UTC)
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c5056059e0so48444231fa.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 04:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698062351; x=1698667151; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NOdJTy76EgrffaaFi/33OgxkTXEC4VhHkOGOq2uSdWo=;
 b=XawoUQz6dTQFNDkHMbnsh6tcj56CvVN+2IsJ/l1hw07BXJ/pwsmE5RHdYhRQ4+OMsq
 lLWadCd7E7ceKqdiBGFc8aNECGprl2VPR8Y9nPq3LsVsPv/nYXXn5eT5HhvVEJPNI+Ov
 P9E+mTD5TC69JarJ1ISY2uSaKzK2zC6Zs/90GXsKXBwFUQuioqKOYz3Qw7cOTVkugTPm
 1u5LyzCsytLwR95J22ro9mo4sUL2V5VqKFBq/gdYVQkwpnpdzMHD+ddZG3Ik6+jn30Sk
 5bBzmolSjyxK64g7LIFlD553icodWQZQGvErODTSExT61nB6TWtltoXbJ1ajXLtMD9mA
 90hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698062351; x=1698667151;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NOdJTy76EgrffaaFi/33OgxkTXEC4VhHkOGOq2uSdWo=;
 b=RsU3iw7+ekA5k/wZ1zN8CK/0tn/VuW52PUG7SbFnnPdYRKc8yN1YXKpZyyQOQJK0AI
 LsbiY8mbKAUrXasgQu9MFUAFKMswPN5GwBqVehlmq80c6BNpD9Ur+QrxLBWenNYlqnr0
 Sst3OBJ4MIz7uXbF1T37rdSPsaypUBo6jQ0PTYruui1yF4iqsm3+BVUi6o6mqvPah1zs
 fZMKguzzeEbAWhbxs2rVBwT7ZzKxYXqKwplvmWoDfikDibo3FsK98yasuzVonGEAKIAW
 1f7EqDDTnMsGdkBnhosSTz5MXjypjoLKBbf/jasdalhcceIOeLUcUWexNDqiIPS9VVol
 La7Q==
X-Gm-Message-State: AOJu0YzRJN0l3GoY6QXMccWHM9jIKHZvoa2iABEd9FjCFq9X5BH4kPw8
 LTxyJIQl/NI+V7O0KkLs3L5uiB3B0VgnPA==
X-Google-Smtp-Source: AGHT+IETLoRlFssUI+1yijhw2tLUUP+h9UJ6Emmah4ILWRi+vtNpk+ZzEBVP9f8hrR58I/jM6XyLkg==
X-Received: by 2002:a05:651c:2124:b0:2c5:1aae:400d with SMTP id
 a36-20020a05651c212400b002c51aae400dmr8077931ljq.22.1698062350546; 
 Mon, 23 Oct 2023 04:59:10 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a05600c499100b0040772138bb7sm13931627wmp.2.2023.10.23.04.59.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 04:59:10 -0700 (PDT)
Message-ID: <13446e2a-6498-4d7f-9a29-f2532c7a902e@gmail.com>
Date: Mon, 23 Oct 2023 13:59:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: handle the return for sync wait
Content-Language: en-US
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231020095911.591988-1-Emily.Deng@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231020095911.591988-1-Emily.Deng@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 20.10.23 um 11:59 schrieb Emily Deng:
> Add error handling for amdgpu_sync_wait.
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for this one.

Going to discuss with Felix later today what we do with the timeout.

Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 ++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c          | 6 +++++-
>   2 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 54f31a420229..3011c191d7dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2668,7 +2668,7 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
>   
>   unreserve_out:
>   	ttm_eu_backoff_reservation(&ticket, &resv_list);
> -	amdgpu_sync_wait(&sync, false);
> +	ret = amdgpu_sync_wait(&sync, false);
>   	amdgpu_sync_free(&sync);
>   out_free:
>   	kfree(pd_bo_list_entries);
> @@ -2939,8 +2939,11 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
>   	}
>   
>   	/* Wait for validate and PT updates to finish */
> -	amdgpu_sync_wait(&sync_obj, false);
> -
> +	ret = amdgpu_sync_wait(&sync_obj, false);
> +	if (ret) {
> +		pr_err("Failed to wait for validate and PT updates to finish\n");
> +		goto validate_map_fail;
> +	}
>   	/* Release old eviction fence and create new one, because fence only
>   	 * goes from unsignaled to signaled, fence cannot be reused.
>   	 * Use context and mm from the old fence.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 70fe3b39c004..a63139277583 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1153,7 +1153,11 @@ int amdgpu_mes_ctx_map_meta_data(struct amdgpu_device *adev,
>   	}
>   	amdgpu_sync_fence(&sync, vm->last_update);
>   
> -	amdgpu_sync_wait(&sync, false);
> +	r = amdgpu_sync_wait(&sync, false);
> +	if (r) {
> +		DRM_ERROR("failed to wait sync\n");
> +		goto error;
> +	}
>   	ttm_eu_backoff_reservation(&ticket, &list);
>   
>   	amdgpu_sync_free(&sync);

