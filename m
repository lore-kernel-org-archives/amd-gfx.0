Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3505CDB47E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 07:30:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4392E10E58E;
	Fri, 20 Oct 2023 07:30:16 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B78410E58E
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 07:30:14 +0000 (UTC)
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c504a5e1deso8142731fa.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 00:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697787012; x=1698391812; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mACylIWPFs17fZAx84BB0GCDubM1o6lwvur17WbWvb8=;
 b=Dq7L2xNerVaBETaUOVy7la8Ubb81zdTx4vAUPWnzxfsmhZBJIwD/DKeZLx7A1RusYG
 Ej/oezECHVmfg+X5xio1kxeGnHzEnUpdaToLTwlnJ19hBK4q9Jks9iziE4icViEyRfAA
 /MtuInixSzQEbnooTmv7UcPKSzZb0pakgaFpKyu7WH/u+Bcoo109yTyb3UsNTnmZR60P
 wEZsKMyUG24iPsXLg57VRxSZWjiuwuuW5WUXukelePCdY5iJWq5f4LEgMoEP7xDFroDi
 2tuZT7IkLQRMNhc99o72/QVTaniqxm054ZEydO2Wuj9ZuUSzkOYXkZurOIEDs4xD9zCf
 LLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697787012; x=1698391812;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mACylIWPFs17fZAx84BB0GCDubM1o6lwvur17WbWvb8=;
 b=YonAk2vz67j9HbZHj5KV6FJFOjMDHnr2zpaLX4F0GnbFTHmXVf1Cvz1Y/cI38o5nal
 MF6bFWDZFttGTeg83mht0y/pEv3hgW0FS+bcTrtmc/IOBb0b4oDkbeF3fwyPYnfevjc2
 NvXvJ+Rvnyu20EpKQne/ZZbQQAJTnHJ9xbKK7yZddAWWWcziGzvE3geBjd+o1ro78Uxp
 OGy/Sj9H5l9YnVSos5BhWybpxh+8ipfh7+w3k7qyYBjXm4i5jlPpaX7asDY3qSCbOE3X
 ExgdYitqVOzFBNYQ18Y1cwWXC/kWPJvh8LSIGvXp9nw0sehy7SePbbaxyl1jGLUbBFaI
 PUWw==
X-Gm-Message-State: AOJu0Yya8uyvAEAXdv34wBOv3ihuEl93bilScjuDfSu7hsogkQwGt9g7
 m1FEypmxo/fQy/7VODFWLf0=
X-Google-Smtp-Source: AGHT+IFI+d6xPiLrGt0RNZTVnq8gMsFbCNOqnmo2+tyo5cH5tQHO8PkfT45sMINE7MIu4J6v0bnPpg==
X-Received: by 2002:a2e:a543:0:b0:2bf:7905:12c3 with SMTP id
 e3-20020a2ea543000000b002bf790512c3mr826612ljn.40.1697787012108; 
 Fri, 20 Oct 2023 00:30:12 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 g16-20020a05600c311000b0040651505684sm1462880wmo.29.2023.10.20.00.30.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 00:30:11 -0700 (PDT)
Message-ID: <c587f79c-30ce-479a-ab0a-d985eca0b2c4@gmail.com>
Date: Fri, 20 Oct 2023 09:30:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: handle the return for sync wait
Content-Language: en-US
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231020061307.588900-1-Emily.Deng@amd.com>
 <20231020061307.588900-2-Emily.Deng@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231020061307.588900-2-Emily.Deng@amd.com>
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

Am 20.10.23 um 08:13 schrieb Emily Deng:

You need a patch description and this patch here needs to come first and 
not second.

Christian.

> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
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

