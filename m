Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82B9CCFA07
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 15:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F2BB10E633;
	Tue,  4 Nov 2025 15:45:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="rRvzELIV";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55D2410E633
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 15:45:16 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4298b865f84so2710071f8f.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Nov 2025 07:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1762271115; x=1762875915; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MU3pD6Ak1vTLZlOdxmRnnMcgwMZHtJbCz25e7swEzM0=;
 b=rRvzELIVZjAbtza++vutSQSpZtnpaWXaQmfA/mOmSfnosOsl8+j9fjKa0x3fNpefVp
 No+tbDemI/9bcO3JptYXTkkqDFSQVUDyb91JoPBUI1CBUH95w/xujeovcr/Qax9Xtnrg
 sgF4hNhA/gm+KbGtGZwMlj3i0tsQ7oAl7BtLTRC27iPlBf/y7lashK45+ygwZfHhop7V
 phEqr42HlNmIIHSabYJhJAQ266h66e/ULeg2uLHrnPu2J1fi28whEyVADC0AXBP+yWE8
 OMFXvMR6ER+nV0TVYEExstFi3Uieyp/Ku8YhtFrPAeOdB3zuuHFdR1z+fu3G36txlJmJ
 57wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762271115; x=1762875915;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MU3pD6Ak1vTLZlOdxmRnnMcgwMZHtJbCz25e7swEzM0=;
 b=H9z12NBlp/EHK0kEQJtib/zym5uhF+YHrtPK9xIVPoIF9FDGZ0qbKDpBq/IYfMa8OW
 7Kbp+YcxiNPNUVGMowCEEy1EywUG4Bn28U2w6E2C3uhJeHnuItBXufJt24xKVUwXThpA
 qxHa51/8fpy3Y2y+GcnXpUssFfK5sORojGJa+9uYYHWUtM3d/yPTydfIKaqG/luy/wwm
 KdDLYX515NXlbqZdJfpxbB/vcHFEhjUvbKYjTlhSNoJmfyuiw/LTEiq7HORbLR6vOw8y
 izcyozZyGQS/8pjnXL4TSRX6r7BYhqTm7etzKdU+LhGliXQJXAJL0BY9KdNpXdtnY++V
 Limg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlH5E9As6e9tppeQ+2klk+aPmfyzszgw4EI2TpdJavFjvSfo2iPpBro1T1wA+p7fogHUZlPHRO@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyRZD+oohKDLY/sgKdebir/1BPgoAWVB1bVLGeRlwSuRIEolGUO
 Sr/2kiYyqP2anjtofB6xT9mqtpkjOVrEPURn4C9CGKdfox0SRM9TfaIe6LXKSXt9x8c=
X-Gm-Gg: ASbGncsvH/ZV2oOq2P1JJVQOkWAbRjUjlXbpAX5zaYSODObi05jjQY9FqVw4utLEsvX
 4++p2Ac6gJUhMWVxxA4xUH0EryfQiXx/sE3kFMAsop9S30YkoDvi6iDn0rBK5jASFwRe6yIS3uH
 iB4kmXL61baedMwoP80HRdqku6TgTXmkfqroWzE45UXE5CPVCfikmWzclWO3EYEJkcvA6+IhJ0Z
 ycAjiM/4Id7mdOWn331hxsTwQOSN9S1pZCcGWl86mIAJq9yoIAH9kBLvcOkbkheDAjNKUUtMhOZ
 wBs7RVNQdnI95WNQ3oLMgrQ4d77RZB17nNvAUlHGTdpIS7pFB/UG0a93nkYKTeVfNXegwA168o2
 sbA3QJ1ANVRvbtZS4ylLdoXYYCbWTq9j7AJFVa1fYzM/mkKawPOh6CacGbJgI//HfFq9Lhtp3VV
 8c4iNbsvLdi24VZIdu
X-Google-Smtp-Source: AGHT+IH/lyY8ZmxJ/JN9aGLoK7fGAWyVPaop+WkvcaIXG+D07wyki9kR2f7ofWQihI55IEqTo8vRYw==
X-Received: by 2002:a05:6000:659:20b0:429:d1a8:3fa2 with SMTP id
 ffacd0b85a97d-429d1a84015mr6200886f8f.48.1762271114682; 
 Tue, 04 Nov 2025 07:45:14 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429dc1fdae2sm5385620f8f.41.2025.11.04.07.45.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 07:45:14 -0800 (PST)
Message-ID: <9eaa0f79-1b45-44fd-961e-f6447e538acb@ursulin.net>
Date: Tue, 4 Nov 2025 15:45:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/20] drm/amdgpu: independence for the
 amdgpu_eviction_fence!
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, felix.kuehling@amd.com, matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20251031134442.113648-1-christian.koenig@amd.com>
 <20251031134442.113648-14-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251031134442.113648-14-christian.koenig@amd.com>
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


On 31/10/2025 13:16, Christian König wrote:
> This should allow amdgpu_fences to outlive the amdgpu module.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 3 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h | 1 -
>   2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 23d7d0b0d625..95ee22c43ceb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -167,9 +167,8 @@ amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr)
>   
>   	ev_fence->evf_mgr = evf_mgr;
>   	get_task_comm(ev_fence->timeline_name, current);
> -	spin_lock_init(&ev_fence->lock);
>   	dma_fence_init64(&ev_fence->base, &amdgpu_eviction_fence_ops,
> -			 &ev_fence->lock, evf_mgr->ev_fence_ctx,
> +			 NULL, evf_mgr->ev_fence_ctx,
>   			 atomic_inc_return(&evf_mgr->ev_fence_seq));
>   	return ev_fence;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> index fcd867b7147d..fb70efb54338 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> @@ -27,7 +27,6 @@
>   
>   struct amdgpu_eviction_fence {
>   	struct dma_fence base;
> -	spinlock_t	 lock;
>   	char		 timeline_name[TASK_COMM_LEN];
>   	struct amdgpu_eviction_fence_mgr *evf_mgr;
>   };

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

