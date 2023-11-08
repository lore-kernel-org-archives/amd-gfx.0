Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB6FC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 12:11:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B759E10E722;
	Wed,  8 Nov 2023 12:11:26 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE08A10E722
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 12:11:25 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40842752c6eso51970695e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Nov 2023 04:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699445484; x=1700050284; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cjpwgYBQjeyXJ4v0vjisG8HweEQXKWGfHIwB6sWVN/Q=;
 b=VqdnzAgkkdZ0YUX40Cr5FIzMRU1bBs6rJN/K26H5XAAaz9JkrO0WsCJgJgEiM9rYzF
 26krmDySoSq9mTYCsBU22cBOUxTY+UeHZAUlwPSstBIDBms+oYBZ4MM7O78DIGt/Y0sr
 F+HUKx7FMx6xKNvxooMUQPdv/ZwTthXhJZ2IHMvHFcb8tQUT1oLEksvl2/PnwVG3Wo/a
 J5AgbGZ5TeaDk8B0HoLEangN1d+l7YhwMQ9j8/zUJTFbjBosFE+IpEj3V1JtWTBHRuio
 Hm4EOVScuKBIQH2IfXFYbNHFwkOP0VUSjwUMZzm1dFnz9bGIJrTyjakWV8NPqeV0eT9d
 HafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699445484; x=1700050284;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cjpwgYBQjeyXJ4v0vjisG8HweEQXKWGfHIwB6sWVN/Q=;
 b=Rr1EbM6t7ka82X4LDRLpohZq4j5Z5veV5T/go8NCZr1WI4thxxglxaXapjFako9Cp1
 VmmPXMvKLSrZw8pZzB9pDU+RhbSAoiZGI1BhYa5GeABfEqDR4KiEviBoHiRnA4IOpPr9
 KLtQiuXHoRZJlSpB5d4ZIQGMU5k31o49i+uQEzc1XnocUWmhWG6q7EJIzRqtZpbNOQ5B
 OypOQURLr5KWZjjnz51VkyeCB+snKcVH8gXP9mLo69vLnFNh54ITaTNX+FZ2e7YlXSqN
 fWV8XYlTJcPle7IaRigzP+xL6aKYoS/TbUzW9CeBrFzIDgZ0+JiaxiblT6waBzQf2CI+
 wNSA==
X-Gm-Message-State: AOJu0YzNfOUB+JxgArMcqG8NJbUXI5AmVwQTHaIP804i49nPhJIXJuH3
 hnw10TEEHmA4Mcp54LZ/FCUnsY2StQK3eQ==
X-Google-Smtp-Source: AGHT+IEz/MF7GhC7g6xHinYX+IUvacVKWaweNtHu3NeY31GHTzK+sXUM3n+u2uIYS4Qg4Q3s3lh96w==
X-Received: by 2002:a05:600c:3c94:b0:408:3c9e:44b7 with SMTP id
 bg20-20020a05600c3c9400b004083c9e44b7mr1499013wmb.3.1699445483823; 
 Wed, 08 Nov 2023 04:11:23 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 g20-20020a05600c4ed400b003fee8793911sm19429938wmq.44.2023.11.08.04.11.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 04:11:15 -0800 (PST)
Message-ID: <bc2d5c54-6571-4555-9dd5-4f023465ca86@gmail.com>
Date: Wed, 8 Nov 2023 13:11:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/amdgpu: Fix possible null pointer dereference
Content-Language: en-US
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231107165814.3628510-1-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231107165814.3628510-1-Felix.Kuehling@amd.com>
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
> mem = bo->tbo.resource may be NULL in amdgpu_vm_bo_update.
>
> Fixes: 180253782038 ("drm/ttm: stop allocating dummy resources during BO creation")
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 7b2a7c9156f0..1442d97ddd0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1015,8 +1015,8 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   				bo = gem_to_amdgpu_bo(gobj);
>   		}
>   		mem = bo->tbo.resource;
> -		if (mem->mem_type == TTM_PL_TT ||
> -		    mem->mem_type == AMDGPU_PL_PREEMPT)
> +		if (mem && (mem->mem_type == TTM_PL_TT ||
> +			    mem->mem_type == AMDGPU_PL_PREEMPT))
>   			pages_addr = bo->tbo.ttm->dma_address;
>   	}
>   

