Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB82C47077
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jan 2024 20:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1918810E0DD;
	Tue, 16 Jan 2024 20:01:29 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D299510E0DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 20:01:27 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-40e779f030aso14332695e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 12:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705435226; x=1706040026; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QbI30yIvA3hwPkYHCBulroLTEcWOdeCwVYNm9AYd4+8=;
 b=iB5peKdxpaFjC6T3xV5yTCLfJHXZGnpCaIXcACain95pee39MG7wa28fzwlR+nR1qx
 7i3JHXcjIO0sJcQ/0O0+6sewdGPBTN/Tg0B6RTSjDZvv+HEgG3TcjNHP+KvBzAcAhQnO
 FxUx0PaZSRQLA91I0RpzgBRJV3gTKlOQfArHOxbBXU8JAXXa0nzNaDt4LHDhshyD34WU
 A/TSkB+sDGU8PVqGR/2l6yV2oajAdvaYBGr4dBeF+OwJrJfzZ1SQGAf3PWR909gWKPnL
 g/L6fzDB9efHGtiNntBi+0FymO3Pqgxm/dmQOy53edWkN4QB0wXCkAeoNfzvr5dWyjxM
 yNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705435226; x=1706040026;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QbI30yIvA3hwPkYHCBulroLTEcWOdeCwVYNm9AYd4+8=;
 b=Qch3yX68lS62JfPMc9FWu3md2mM4XIyc51EcS1wuGd/x+ihEfJxhEWbu7MkLgY58AK
 SCS97QKT1GwIzZkLpqsm9bgYV4qRiNBVuh8wwLFVjo/33B4oeqbhgBBzoQJBH2W29ZJ0
 3omWRW9HUSCxf/WaO7gQnT/GAZLjIgKjgpYGW59o0wwRRPJW4ZGM7Nx+vMNMc2y2qVo6
 PSDo6FSy0AtRsrEhuvcre1FLhI1+AXGNCbYW331CYcdmRWWLbsJSTwLBQKp8f4osMxOS
 nrqpUPjWG7gcDc0W5WSbYmoUCSjs0yfTPli033Ow26mRP57Ey3ul5WGAtuXo3z3MJYT9
 vi6Q==
X-Gm-Message-State: AOJu0YwAcCmoC0u8YrXwO9DgVnR7qHUPbYru7hfVOYmzPg4oWslwSTtG
 SQXAVeBE/G+GmOdYOkzFlCO/z8rQ/rT/Hw==
X-Google-Smtp-Source: AGHT+IE7Vp1/CZ61/a3OXsG8hh0n6zC5M5AydT2bfzm7b1tzJLkmXiibvG2NqFOi1AZjMUWv9sbEjQ==
X-Received: by 2002:a05:600c:3644:b0:40e:474f:94d8 with SMTP id
 y4-20020a05600c364400b0040e474f94d8mr3934409wmq.177.1705435226104; 
 Tue, 16 Jan 2024 12:00:26 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 bi15-20020a05600c3d8f00b0040e83eac47fsm3333679wmb.5.2024.01.16.12.00.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 12:00:25 -0800 (PST)
Message-ID: <3b257f67-9e7a-4df4-91e0-4c70276cd9b8@gmail.com>
Date: Tue, 16 Jan 2024 21:00:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Remove unnecessary NULL check
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240115225727.1287832-1-felix.kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240115225727.1287832-1-felix.kuehling@amd.com>
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.01.24 um 23:57 schrieb Felix Kuehling:
> A static checker pointed out, that bo_va->base.bo was already derefenced
> earlier in the same scope. Therefore this check is unnecessary here.
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: 79e7fdec71f2 ("drm/amdgpu: Auto-validate DMABuf imports in compute VMs")
> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 77d015ebb201..b7f07cc52b1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1477,7 +1477,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   		/* Remember evicted DMABuf imports in compute VMs for later
>   		 * validation
>   		 */
> -		if (vm->is_compute_context && bo_va->base.bo &&
> +		if (vm->is_compute_context &&
>   		    bo_va->base.bo->tbo.base.import_attach &&
>   		    (!bo_va->base.bo->tbo.resource ||
>   		     bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))

