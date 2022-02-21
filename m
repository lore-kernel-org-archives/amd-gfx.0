Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A12FC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 10:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 581E010E306;
	Mon, 21 Feb 2022 10:59:47 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7014710E3A7
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 10:59:46 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id h15so11519439edv.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 02:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=mUdNpXHwwYbl0lQ2OQCwIVMjnOn+wVcs0MPRAAYZCY4=;
 b=TNMwILEynJznu7VGiry2LPjib7iu8Dr1Qo5vCGZYVwe8TOD5V1VHKStJy2zeLkMfHB
 KxRoeddMf3zEt4W4pOnkCoXkpWP8iH5UIJ1tCopMAOdYSVrautO6QNiP/RPuyWNn84RK
 0o2rcSOeYA2L/YDmyKC7pNsGbeccCeE1/LQdN9Dz7Z4up+eMTCtS5Hz7QCKj8W9J7/Cr
 /Alj+mFtJLg/OMlXmObwKuq+5NjehsmtoP/QsZjYE1tyR0gjkrTFmQ6xOz4Ggqnx+ptM
 a8aZHO2MTBZslGvi9fMuZo+hXQlUW4hBtAC9BiJgdclt8kom0/LaTWvT/m83K5J1CMK8
 lJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=mUdNpXHwwYbl0lQ2OQCwIVMjnOn+wVcs0MPRAAYZCY4=;
 b=Ovd+RZNAu7GClAWR1/t3HfFbYNahtrz2buC8TbPC4sw5GZwEBGObt2wLzvmvZw/Vhj
 2yytcy0FPfkooYWZpxhE/jdg68gyGwifjToQjDBWuMmzrUsGVj/fOx0qFWYs/75RckGU
 0qD95bmRr+s8AKJ0uq5jjyhfU6R4cPI3o+an1X4XPt80H4zX8LW9cmxPMfBsijZNF8WN
 c9iqo0RI/jq6DpAJ797MjFw/xgjjDH2r1+/664/Qi/E0QnsdvC2sO9uLKZXlxC1tO2yH
 tTXQpZg4JT30JoJ5YhhnpUYBZl5TXkiFfA6Ocv7u/PG5JfyyQXD1F6SRDbZCAB9sTNcZ
 txvg==
X-Gm-Message-State: AOAM532JrYeAXoI66rd/moB93Pc0XsPTkUUMzRxs+PjdeA26CJVsvnTb
 il4QGn3F7XOGemUSXf0h1do=
X-Google-Smtp-Source: ABdhPJwyWD8UZT1cH1hlijCzpjrZg82/MWbVJpyRSJXD5y4XpOh2pU+rIzIaP0pt8R6XaHbTg48CXg==
X-Received: by 2002:a05:6402:198:b0:410:83e3:21d7 with SMTP id
 r24-20020a056402019800b0041083e321d7mr20989259edv.159.1645441184768; 
 Mon, 21 Feb 2022 02:59:44 -0800 (PST)
Received: from [192.168.178.21] (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id 5sm8658247edx.32.2022.02.21.02.59.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Feb 2022 02:59:44 -0800 (PST)
Message-ID: <857111a1-c8a9-4b05-aa06-cbca68761a25@gmail.com>
Date: Mon, 21 Feb 2022 11:59:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/7] drm/amdgpu/benchmark: use dev_info rather than DRM
 macros for logging
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220218222603.25470-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220218222603.25470-1-alexander.deucher@amd.com>
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

Am 18.02.22 um 23:25 schrieb Alex Deucher:
> So we can tell which output goes to which device when multiple GPUs
> are present.  Also while we are here, convert DRM_ERROR to dev_info.
> The error cases are not critical.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for the entire 
series.

As a follow up we should probably replace the create, reserve, pin, 
alloc_gart dance in amdgpu_benchmark_move() with a call to 
amdgpu_bo_create_kernel() and amdgpu_bo_free_kernel().

And using ktime() instead of jiffies would protect us against wrap 
arounds in amdgpu_benchmark_do_move().

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> index 313517f7cf10..b38783278a99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> @@ -56,13 +56,15 @@ static int amdgpu_benchmark_do_move(struct amdgpu_device *adev, unsigned size,
>   }
>   
>   
> -static void amdgpu_benchmark_log_results(int n, unsigned size,
> +static void amdgpu_benchmark_log_results(struct amdgpu_device *adev,
> +					 int n, unsigned size,
>   					 unsigned int time,
>   					 unsigned sdomain, unsigned ddomain,
>   					 char *kind)
>   {
>   	unsigned int throughput = (n * (size >> 10)) / time;
> -	DRM_INFO("amdgpu: %s %u bo moves of %u kB from"
> +
> +	dev_info(adev->dev, "amdgpu: %s %u bo moves of %u kB from"
>   		 " %d to %d in %u ms, throughput: %u Mb/s or %u MB/s\n",
>   		 kind, n, size >> 10, sdomain, ddomain, time,
>   		 throughput * 8, throughput);
> @@ -131,14 +133,14 @@ static void amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned size,
>   		if (time < 0)
>   			goto out_cleanup;
>   		if (time > 0)
> -			amdgpu_benchmark_log_results(n, size, time,
> +			amdgpu_benchmark_log_results(adev, n, size, time,
>   						     sdomain, ddomain, "dma");
>   	}
>   
>   out_cleanup:
>   	/* Check error value now. The value can be overwritten when clean up.*/
>   	if (r) {
> -		DRM_ERROR("Error while benchmarking BO move.\n");
> +		dev_info(adev->dev, "Error while benchmarking BO move.\n");
>   	}
>   
>   	if (sobj) {
> @@ -239,6 +241,6 @@ void amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
>   		break;
>   
>   	default:
> -		DRM_ERROR("Unknown benchmark\n");
> +		dev_info(adev->dev, "Unknown benchmark\n");
>   	}
>   }

