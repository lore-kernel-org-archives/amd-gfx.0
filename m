Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2119AC64ED6
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Feb 2023 09:42:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FBA210E172;
	Mon, 27 Feb 2023 09:42:26 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4153D10E172
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Feb 2023 09:42:25 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id ee7so23218008edb.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Feb 2023 01:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GSUMxWev/xg0+tRcydG2yu44vMBeg1KTAdUAhA7Mgn4=;
 b=fHsegznQrC/bmdQSYJwvWaVXnnUfMUPEpTlFCbENQ4EScyBzIzFjEzU6MWVKM8DTLu
 hnSNtV3m+2uEpR3RZVFG9OcldyzRX9hhXyezdppouS6o50DOXgkLSoDR72LFxe6YlYr0
 8Y4fRkVs+IbHt+59YN826ETtV9j7qtMGlClPsOPg5uu6xJHhRs9KEf/d5CvqjzjBQ9MU
 y2RZD+izjy1yHMV15zqA3Xw2LtkfPkv/HkEf83b6G5GuQd6G+BSeDBAg2mA4oEpRspoH
 yNw4FMMbR7H+iNNlkTF5wkr7pJJOK+OIX9yR6XavX5B4varhfExNFf1YAObPrOfSf36c
 oB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GSUMxWev/xg0+tRcydG2yu44vMBeg1KTAdUAhA7Mgn4=;
 b=CNqHymbgwTqVHSUl3NKfwurm8ZlG1R4LM8lqgdfCYPPzML/mIKy1NRUU2t0kFC8vH3
 7Bz0BPlaWbC2hSVYCIwRoH1xiq0y7J56FmwLq5FjRPlxBcSW0BEmtPSBeMGuvdJtBGxY
 tRYjGNIDzHARDabOvQjq0AoRH1dVVTLut/YspsCtvA5j1CxklN9fy3pCEQuVZaycWucK
 KOnHQlo/8f/VYIhOoLJ3yau1uSRV7vkjSYudJ48DqeZMEzaSIbTDl1OzPgcGQMPdpaKa
 IzlrqvDw/xU+S6VQpiTwPPbRYY8oNzFhPxHNnrinQveAB/s7nwan0fnCWxT8Iat0Qq3g
 W0OA==
X-Gm-Message-State: AO0yUKWv3nufrNLLN9LO8pixfIoZajo6BbuFtgBq5VusZZjwlkYwbfyB
 Uk685rFZWKwVm4y/0gsTRkU=
X-Google-Smtp-Source: AK7set/rGh18KOZ1rsGEJ0XK7VwVHcatjsJYtmzo3K64ZF0aOZp6RMYL+tDjezzmdtAovroL7fXt8A==
X-Received: by 2002:a17:906:4b02:b0:8aa:c143:ffe1 with SMTP id
 y2-20020a1709064b0200b008aac143ffe1mr33820355eju.48.1677490943543; 
 Mon, 27 Feb 2023 01:42:23 -0800 (PST)
Received: from [192.168.178.21] (p5b0ea2e7.dip0.t-ipconnect.de.
 [91.14.162.231]) by smtp.gmail.com with ESMTPSA id
 j30-20020a508a9e000000b004acd42c8be5sm2850791edj.90.2023.02.27.01.42.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Feb 2023 01:42:22 -0800 (PST)
Message-ID: <7c921833-884a-0034-7ede-6bd44fd40750@gmail.com>
Date: Mon, 27 Feb 2023 10:42:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] drm/amdgpu: Synchronize after mapping into a compute
 VM
Content-Language: en-US
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230224233647.847647-1-Felix.Kuehling@amd.com>
 <20230224233647.847647-2-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230224233647.847647-2-Felix.Kuehling@amd.com>
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
Cc: ramesh.errabolu@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.02.23 um 00:36 schrieb Felix Kuehling:
> Compute VMs use user mode queues for command submission. They cannot use
> a CS ioctl to synchronize with pending PTE updates and flush TLBs. Do
> this synchronization in amdgpu_gem_va_ioctl for compute VMs.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 6936cd63df42..7de5057c40ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -601,7 +601,7 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>   static void amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>   				    struct amdgpu_vm *vm,
>   				    struct amdgpu_bo_va *bo_va,
> -				    uint32_t operation)
> +				    uint32_t operation, uint32_t flags)
>   {
>   	int r;
>   
> @@ -620,6 +620,18 @@ static void amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>   	}
>   
>   	r = amdgpu_vm_update_pdes(adev, vm, false);
> +	if (r)
> +		goto error;
> +
> +	if (vm->is_compute_context) {
> +		if (bo_va->last_pt_update)
> +			r = dma_fence_wait(bo_va->last_pt_update, true);
> +		if (!r && vm->last_update)
> +			r = dma_fence_wait(vm->last_update, true);
> +		if (!r)
> +			r = amdgpu_amdkfd_flush_tlb(adev, vm,
> +			    TLB_FLUSH_LEGACY);
> +	}

Mhm, that's not really something we can do here. The GEM VA IOCTL is 
supposed to be async and never block.

Can we do that on the KFD side in some IOCTL instead?

Regards,
Christian.

>   
>   error:
>   	if (r && r != -ERESTARTSYS)
> @@ -789,7 +801,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>   	}
>   	if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && !amdgpu_vm_debug)
>   		amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
> -					args->operation);
> +					args->operation, args->flags);
>   
>   error_backoff:
>   	ttm_eu_backoff_reservation(&ticket, &list);

