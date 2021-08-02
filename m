Return-Path: <SRS0=SMOw=MZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AE8C4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 06:56:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09D9160F11
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 06:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 09D9160F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A488489BCD;
	Mon,  2 Aug 2021 06:56:31 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A68489BCD
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Aug 2021 06:56:30 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id b7so20176294wri.8
 for <amd-gfx@lists.freedesktop.org>; Sun, 01 Aug 2021 23:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=yeSVxj7EF0cPl932g2XuUfW6GP4JL0o1D9Bzv1O3HdY=;
 b=MupxM240GzH9TSMfJOYjqHbwFDJG5tT3Wfp/fyeP6VquhnkvbT6Quy+ZrS8daRKWSK
 ATsWwgprYlcGWWS5u1gggf8Qb2zC9Y2uBvyty0SnQt7g5S6qOd47XczapLH3p2zxo2oZ
 sGlW3VR8MTNLhqMCEnn0UyONUD6FVzfLy6KSX2iF+oLrEb2ES3XWj146/HNDS5bMzA3E
 dnchZyIRUmn+SoDRgr3eZQvejeydEgFLhI6PDevXK+iVYgdDVB0suN2/j5qOXgqTHgn/
 b7xiHWtcDmUdVsyXb5+o5hjCbRK5WuHy5gL36Ks1Trzf7rb5TwnZh6yFYcPWM7qo9mf2
 7+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=yeSVxj7EF0cPl932g2XuUfW6GP4JL0o1D9Bzv1O3HdY=;
 b=VurU35GuW/gC0Wz8FJsPJhg9njCLoGNXx/JhyhcBKX9OUSrQjcYikcitSc20vgM+mb
 l0yni96Wjalp3vvsU3hYvgq2gC6UROkTc0UPSk+hgNtDE1OJjUhcf1TGflSzuRdDRBHa
 RLkQKS0n6J2LWtLWwIbcrinzf6i+xGm8zghFnwCyCGXjQwBKmFtEHkooObO+sZa6t5GW
 UQdhEN0ndII7z1rWML+pfHOwFgLLVecR1+Unq/wBsu2ranXr+nzDezknw2hkOc1DTOaq
 7fj0VcIPetCKTbgtMzDFWIJNkEhOFofYz0/xlIoqJfVwFhXUiK9W/XAETswN96Z9vGnO
 HUwQ==
X-Gm-Message-State: AOAM533iQ600aTn0qd/DM5ddBayxAnpNqXPg3mDoS/ipnMM0CHTR9HOD
 ZmB0+6xBB+yyExz58DgSbyk=
X-Google-Smtp-Source: ABdhPJycPZCp9CO5gO7pRhfZbplvb6+ZB5o+KbvBGTxUfUeZzLlMb/IedWoHnTbXGE9DolnMbJwjLw==
X-Received: by 2002:a5d:4688:: with SMTP id u8mr15900103wrq.65.1627887388826; 
 Sun, 01 Aug 2021 23:56:28 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:765:cc03:c018:5233?
 ([2a02:908:1252:fb60:765:cc03:c018:5233])
 by smtp.gmail.com with ESMTPSA id t17sm10073185wru.94.2021.08.01.23.56.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Aug 2021 23:56:28 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: avoid over-handle of fence driver fini in s3
 test (v2)
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 Likun.Gao@amd.com, christian.koenig@amd.com, Hawking.Zhang@amd.com,
 alexander.deucher@amd.com
References: <20210802051602.23822-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b7218d98-9eb1-2d41-157a-bc417ef496ab@gmail.com>
Date: Mon, 2 Aug 2021 08:56:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210802051602.23822-1-guchun.chen@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 02.08.21 um 07:16 schrieb Guchun Chen:
> In amdgpu_fence_driver_hw_fini, no need to call drm_sched_fini to stop
> scheduler in s3 test, otherwise, fence related failure will arrive
> after resume. To fix this and for a better clean up, move drm_sched_fini
> from fence_hw_fini to fence_sw_fini, as it's part of driver shutdown, and
> should never be called in hw_fini.
>
> v2: rename amdgpu_fence_driver_init to amdgpu_fence_driver_sw_init,
> to keep sw_init and sw_fini paired.
>
> Fixes: cd87a6dcf6af drm/amdgpu: adjust fence driver enable sequence
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

It's a bit ambiguous now what fence_drv.initialized means, but I think 
we can live with that for now.

Patch is Reviewed-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 ++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 12 +++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  4 ++--
>   3 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b1d2dc39e8be..9e53ff851496 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3646,9 +3646,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   
>   fence_driver_init:
>   	/* Fence driver */
> -	r = amdgpu_fence_driver_init(adev);
> +	r = amdgpu_fence_driver_sw_init(adev);
>   	if (r) {
> -		dev_err(adev->dev, "amdgpu_fence_driver_init failed\n");
> +		dev_err(adev->dev, "amdgpu_fence_driver_sw_init failed\n");
>   		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_FENCE_INIT_FAIL, 0, 0);
>   		goto failed;
>   	}
> @@ -3988,7 +3988,6 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>   	}
>   	amdgpu_fence_driver_hw_init(adev);
>   
> -
>   	r = amdgpu_device_ip_late_init(adev);
>   	if (r)
>   		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 49c5c7331c53..7495911516c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -498,7 +498,7 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>   }
>   
>   /**
> - * amdgpu_fence_driver_init - init the fence driver
> + * amdgpu_fence_driver_sw_init - init the fence driver
>    * for all possible rings.
>    *
>    * @adev: amdgpu device pointer
> @@ -509,13 +509,13 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>    * amdgpu_fence_driver_start_ring().
>    * Returns 0 for success.
>    */
> -int amdgpu_fence_driver_init(struct amdgpu_device *adev)
> +int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev)
>   {
>   	return 0;
>   }
>   
>   /**
> - * amdgpu_fence_driver_fini - tear down the fence driver
> + * amdgpu_fence_driver_hw_fini - tear down the fence driver
>    * for all possible rings.
>    *
>    * @adev: amdgpu device pointer
> @@ -531,8 +531,7 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
>   
>   		if (!ring || !ring->fence_drv.initialized)
>   			continue;
> -		if (!ring->no_scheduler)
> -			drm_sched_fini(&ring->sched);
> +
>   		/* You can't wait for HW to signal if it's gone */
>   		if (!drm_dev_is_unplugged(&adev->ddev))
>   			r = amdgpu_fence_wait_empty(ring);
> @@ -560,6 +559,9 @@ void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev)
>   		if (!ring || !ring->fence_drv.initialized)
>   			continue;
>   
> +		if (!ring->no_scheduler)
> +			drm_sched_fini(&ring->sched);
> +
>   		for (j = 0; j <= ring->fence_drv.num_fences_mask; ++j)
>   			dma_fence_put(ring->fence_drv.fences[j]);
>   		kfree(ring->fence_drv.fences);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 27adffa7658d..9c11ced4312c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -106,7 +106,6 @@ struct amdgpu_fence_driver {
>   	struct dma_fence		**fences;
>   };
>   
> -int amdgpu_fence_driver_init(struct amdgpu_device *adev);
>   void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
>   
>   int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
> @@ -115,9 +114,10 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>   int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
>   				   struct amdgpu_irq_src *irq_src,
>   				   unsigned irq_type);
> +void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
>   void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
> +int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
>   void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
> -void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
>   int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence,
>   		      unsigned flags);
>   int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,

