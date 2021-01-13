Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1983C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 14:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 173D923382
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 14:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173D923382
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4ABB6E9EA;
	Wed, 13 Jan 2021 14:03:09 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B54D6E9EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 14:03:08 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id c7so2020517edv.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 06:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=mzMqE9SZFapTozQHoV2213EV+yMYxVWHU/CalxzeUts=;
 b=Xt9oXrFB9MgPEz6HpfS8lKmOmQwdit7BNeYWSS9TzD+xLL/zcbLU7mv1Q3IknDJagR
 z5M4cmSRvwwNzTGo4p029ZYKxPcxw2ExMyka1lykEN6i5+Pr69nvn/PE25TN5PGWdztX
 m0LBFMcx1YaOsr7SOaEC/ijnsYs1nLNz3H4M+qFwOsKlKGA4ACEW6QJYP4DgMY9onHmt
 bcXtso7D98Uw9KKCGrWFfPDF0y8sdHYKw0cwMd8TmnC5oCl77RLKcslHdwwWDax+GWCR
 KRMb4K5Bm0K1wiN8Q/HKEfQp5MfH2EhjNCCeqpFATQy5mq8DuzKTPz/9pERcvWSv5tnH
 Eodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=mzMqE9SZFapTozQHoV2213EV+yMYxVWHU/CalxzeUts=;
 b=f1feD9QLcOHr/2Wi4ujVCrYW5MOe8uS0l8JDEBk5MGW5prXvIcIi5/w+b2j0nh28PO
 TUI74iGzdnbgiAvWOE0GUqOUyJSrsfQghp1ojcBWM3zsdtoQKELQpBxa9JGsfFCrQ9uG
 ER5wvNU00c0hgruypI5Gk7JRiQw59vtsJr1w0LpbcjQcFo2SqGmEov/lIzMEK/Ys7cSH
 7gFrg4nExB3/WQ7BJaouxF5nc7jGAOFGU2qZ2K+N5bJ9GDeAaFUT8Z9dli313EOk410z
 FuK/fjElG609672veggF9R730qcenigiYb/7eh87dzsUgwMtIANZU5YNG3yKfC67ApHu
 09zA==
X-Gm-Message-State: AOAM5304oAZaEGIXtNBo+7d5087fIl3AbMpwY2NQnPm0LYnkI5DLPZyX
 TYDYUD4veKEt7AS9QlKmIL5N66DeK/k=
X-Google-Smtp-Source: ABdhPJyvKEdZ2vdAx8LT5PxbcA679cWeRlCjhFr9OWUrAcMCIDk5LgcheUe0gmyA8xGP9s9gz7G4Cg==
X-Received: by 2002:a05:6402:45:: with SMTP id
 f5mr1862672edu.273.1610546586386; 
 Wed, 13 Jan 2021 06:03:06 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id g25sm773541ejf.15.2021.01.13.06.03.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 06:03:05 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: change the fence ring wait timeout
To: Roy Sun <Roy.Sun@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210113063612.31468-1-Roy.Sun@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <318aa468-c009-8edf-d6bd-8408ee79c42e@gmail.com>
Date: Wed, 13 Jan 2021 15:03:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210113063612.31468-1-Roy.Sun@amd.com>
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.01.21 um 07:36 schrieb Roy Sun:
> This fix bug where when the engine hang, the fence ring will wait without quit and cause kernel crash

NAK, this blocking is intentional unlimited because otherwise we will 
cause a memory corruption.

What is the actual bug you are trying to fix here?

Regards,
Christian.

>
> Signed-off-by: Roy Sun <Roy.Sun@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 48 ++++++++++++++++++++---
>   1 file changed, 43 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 6b0aeee61b8b..738ea65077ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -41,6 +41,8 @@
>   #include "amdgpu.h"
>   #include "amdgpu_trace.h"
>   
> +#define AMDGPU_FENCE_TIMEOUT  msecs_to_jiffies(1000)
> +#define AMDGPU_FENCE_GFX_XGMI_TIMEOUT msecs_to_jiffies(2000)
>   /*
>    * Fences
>    * Fences mark an event in the GPUs pipeline and are used
> @@ -104,6 +106,38 @@ static void amdgpu_fence_write(struct amdgpu_ring *ring, u32 seq)
>   		*drv->cpu_addr = cpu_to_le32(seq);
>   }
>   
> +/**
> + * amdgpu_fence_wait_timeout - get the fence wait timeout
> + *
> + * @ring: ring the fence is associated with
> + *
> + * Returns the value of the fence wait timeout.
> + */
> +long amdgpu_fence_wait_timeout(struct amdgpu_ring *ring)
> +{
> +	long tmo_gfx, tmo_mm, tmo;
> +	struct amdgpu_device *adev = ring->adev;
> +	tmo_mm = tmo_gfx = AMDGPU_FENCE_TIMEOUT;
> +	if (amdgpu_sriov_vf(adev)) {
> +		tmo_mm = 8 * AMDGPU_FENCE_TIMEOUT;
> +	}
> +	if (amdgpu_sriov_runtime(adev)) {
> +		tmo_gfx = 8 * AMDGPU_FENCE_TIMEOUT;
> +	} else if (adev->gmc.xgmi.hive_id) {
> +		tmo_gfx = AMDGPU_FENCE_GFX_XGMI_TIMEOUT;
> +	}
> +	if (ring->funcs->type == AMDGPU_RING_TYPE_UVD ||
> +		ring->funcs->type == AMDGPU_RING_TYPE_VCE ||
> +		ring->funcs->type == AMDGPU_RING_TYPE_UVD_ENC ||
> +		ring->funcs->type == AMDGPU_RING_TYPE_VCN_DEC ||
> +		ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC ||
> +		ring->funcs->type == AMDGPU_RING_TYPE_VCN_JPEG)
> +		tmo = tmo_mm;
> +	else
> +		tmo = tmo_gfx;
> +	return tmo;
> +}
> +
>   /**
>    * amdgpu_fence_read - read a fence value
>    *
> @@ -166,10 +200,12 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>   		rcu_read_unlock();
>   
>   		if (old) {
> -			r = dma_fence_wait(old, false);
> +			long timeout;
> +			timeout = amdgpu_fence_wait_timeout(ring);
> +			r = dma_fence_wait_timeout(old, false, timeout);
>   			dma_fence_put(old);
>   			if (r)
> -				return r;
> +				return r < 0 ? r : 0;
>   		}
>   	}
>   
> @@ -343,10 +379,12 @@ int amdgpu_fence_wait_empty(struct amdgpu_ring *ring)
>   		return 0;
>   	}
>   	rcu_read_unlock();
> -
> -	r = dma_fence_wait(fence, false);
> +	
> +	long timeout;
> +	timeout = amdgpu_fence_wait_timeout(ring);
> +	r = dma_fence_wait_timeout(fence, false, timeout);
>   	dma_fence_put(fence);
> -	return r;
> +	return r < 0 ? r : 0;
>   }
>   
>   /**

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
