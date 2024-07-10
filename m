Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6235AC3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 07:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15BA410E697;
	Wed, 10 Jul 2024 07:17:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bQVGIq84";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C24A10E697
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 07:17:13 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-426636ef8c9so22201595e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 00:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720595832; x=1721200632; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wg04qNSytuGZZpB4CDhOQ1svJ8+Yn21SyDAiRLXQxCw=;
 b=bQVGIq84HTJGiTRM8XmfHV6IesQEl4GXyTaySiyJJACyzPSgyjglzuN166y/mt2WdL
 X3SVYYL0vDsBw10RXvG3b52/3bZskyOBUuc6CMYCQ1FmOJ1jArYv3HTfAqjVPmmnexv5
 8jVlYyiYmKrDiRSmsWni0+dAAdpqvuuO/wDkC43P3DPJ1IRNYXtDvjC3zasYq3ywxHcm
 ZrbsSadLV0EaugxAQs/LgIekBV0F8JGFc9Wxkh1FP7wrLAvxpGNaG/t+xIuTrvXa1zjX
 xEfJizIzFs4MeGK76/7OiQ58MbGkvNPapk1SRBdvnowzknYUcMzf+lECuZx12mpU5gUs
 xcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720595832; x=1721200632;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wg04qNSytuGZZpB4CDhOQ1svJ8+Yn21SyDAiRLXQxCw=;
 b=apcy5Q8Zwo00nItt/q9uwxpGG0sq8q75GSvoXKJfi58lYEtPvdcs72BwFPtZ1izw9j
 ujA407JJQoC39m4g7X6n10V70t2AVcmGBCUERvz9dtALlQ92dxsnzyRkJSPXJbPLa8Vc
 FiowawwI8VqPrXsqPgA7sG6qs0nvwaGM/EypgSl5ZyTMZn2k9sdapjorJBQiG2dV5/bu
 C/5kZB1spXXXQWoj7FgmGQ5Odk1tjfcuCUj9jS20G9wwLm8ca/fvo0OcJpOWLKKhkMNl
 OfjoGRHywprm54d0MYzK6M8JK/bkDED1PthDhrZ09/69t3LMBWf3VYAZVuIT6D9A+Wlx
 ofxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCYqDuj+hGAr+AQIvnMQtUYxFr4ZlICmbqrCaSiGQz5QukrO1gXRODPWAF8AoDJfuWAzDMnradw6/iIldZAvJClyF1o+Ih+xHghc2sFA==
X-Gm-Message-State: AOJu0Yy5866O3Px2NVPehE+IJ/gfgGa55JcmKPS1h4+ksIeyrDLVnaEP
 83xoPp6X0+u4TCF4P00eQoQF7XVlJPSu/MEmndrZaybmLLAUkpl8
X-Google-Smtp-Source: AGHT+IEzCm9jMxwJFsbF9A3Era88R/0wMtRNC766QxScP8pdlYCaiuma08jnT9vMg3368V4nQ4K7OQ==
X-Received: by 2002:a05:6000:12c9:b0:367:8c22:5b7a with SMTP id
 ffacd0b85a97d-367cea7331dmr3171936f8f.22.1720595831087; 
 Wed, 10 Jul 2024 00:17:11 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde891cesm4498529f8f.62.2024.07.10.00.17.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 00:17:10 -0700 (PDT)
Message-ID: <0e79392e-1e82-4602-8ebb-2dc9d31e001c@gmail.com>
Date: Wed, 10 Jul 2024 09:17:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: set start timestamp of fence in the right
 place
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20240710003101.1645322-1-jiadong.zhu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240710003101.1645322-1-jiadong.zhu@amd.com>
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

Am 10.07.24 um 02:31 schrieb jiadong.zhu@amd.com:
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>
> The job's embedded fence is dma_fence which shall not be conversed
> to amdgpu_fence.

Good catch.

> The start timestamp shall be saved on job for
> hw_fence.

But NAK to that approach. Why do we need the start time here in the 
first place?

Regards,
Christian.

>
> v2: optimize get_fence_start_time.

>
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 31 ++++++++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h   |  3 +++
>   2 files changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 2f24a6aa13bf..72bb007e48c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -88,6 +88,31 @@ static inline struct amdgpu_fence *to_amdgpu_fence(struct dma_fence *f)
>   	return NULL;
>   }
>   
> +static inline void set_fence_start_time(struct dma_fence *f, ktime_t start_timestamp)
> +{
> +	if (f->ops == &amdgpu_fence_ops) {
> +		struct amdgpu_fence *__f = container_of(f, struct amdgpu_fence, base);
> +
> +		__f->start_timestamp = start_timestamp;
> +	} else if (f->ops == &amdgpu_job_fence_ops) {
> +		struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence);
> +
> +		job->start_timestamp = start_timestamp;
> +	}
> +}
> +
> +static inline ktime_t get_fence_start_time(struct dma_fence *f)
> +{
> +	if (unlikely(f->ops == &amdgpu_fence_ops)) {
> +		struct amdgpu_fence *__f = container_of(f, struct amdgpu_fence, base);
> +
> +		return __f->start_timestamp;
> +	}
> +	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence);
> +
> +	return job->start_timestamp;
> +}
> +
>   /**
>    * amdgpu_fence_write - write a fence value
>    *
> @@ -197,7 +222,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
>   		}
>   	}
>   
> -	to_amdgpu_fence(fence)->start_timestamp = ktime_get();
> +	set_fence_start_time(fence, ktime_get());
>   
>   	/* This function can't be called concurrently anyway, otherwise
>   	 * emitting the fence would mess up the hardware ring buffer.
> @@ -428,7 +453,7 @@ u64 amdgpu_fence_last_unsignaled_time_us(struct amdgpu_ring *ring)
>   		return 0;
>   
>   	return ktime_us_delta(ktime_get(),
> -		to_amdgpu_fence(fence)->start_timestamp);
> +		get_fence_start_time(fence));
>   }
>   
>   /**
> @@ -451,7 +476,7 @@ void amdgpu_fence_update_start_timestamp(struct amdgpu_ring *ring, uint32_t seq,
>   	if (!fence)
>   		return;
>   
> -	to_amdgpu_fence(fence)->start_timestamp = timestamp;
> +	set_fence_start_time(fence, timestamp);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index a963a25ddd62..3a73fe11a1ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -73,6 +73,9 @@ struct amdgpu_job {
>   	uint64_t		gds_va;
>   	bool			init_shadow;
>   
> +	/* start timestamp for hw_fence*/
> +	ktime_t			start_timestamp;
> +
>   	/* job_run_counter >= 1 means a resubmit job */
>   	uint32_t		job_run_counter;
>   

