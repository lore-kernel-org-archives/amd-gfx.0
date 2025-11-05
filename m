Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC6FCCF9F8
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 08:51:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2940510E6D4;
	Wed,  5 Nov 2025 08:51:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="mkG9K73+";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D776B10E6E1
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 08:51:01 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47728f914a4so33325055e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Nov 2025 00:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1762332660; x=1762937460; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZqrfLNaeW4zRp1Nqycj52VNAutRSKSMWa7wsuT4zALE=;
 b=mkG9K73+yY0KjED9oSQjPHvxmpx5ziosUwdAnUv+9PwHUPShV9S1pxjI5f7xUMtr/S
 r41dPsM28ciXd30IHViU/DNS8GqLrskpjE1zc5cs0Cks8EdQZ6bvSi4AGXAAlwmDgg9/
 EET+WYn5Lj9+K7KIoIJu+YWBxEF/MVRk8H2T8mOn1M5l1gWeOhj4GHDibzON8A+ZrRms
 LPW4qaPVo6zXIFaZz3A5ZNo667g+DN9whSXeplw+GVaHGz1IZz3qWQVomGgGOZDYVdl/
 /6TU9wGrglQvc67UnZFLXujPEiw5GCd6iPOFYbRWgzm2mAOeaATiYnVk6RKfIE9tjBU0
 ZOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762332660; x=1762937460;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZqrfLNaeW4zRp1Nqycj52VNAutRSKSMWa7wsuT4zALE=;
 b=Qdfd9fLYaN7ppHKgJUgBCj3JX1EHg85MpSmvcGh8tWtnscXkc6hRgxjXsP+fc/eriq
 cKqF3H9QvUBL3pIypR4HiH8cJr3wmIIGuu0d6DtR0O+FMVo5QUWmY1KUbhK0i9NFULfo
 r68DvAA7LBCEAG7MvBP2/3ThKnkmdEdeDDWtirx75vV4ZVBdt0SziT0rAdc96l1UdI9E
 uEpvsn9g2FmpXqDDoU62klmmsbSkXvfaX3KaHwETuBMfTFt9Mp4ufLHJy54Nj88sCoTC
 S6P5K+fpks03pF8+qIJjdRWG8BGYKpA+1zheYT66FQaY/ZB6JgPaH9lVyv9e6UYF99O6
 j8vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOjrTNEa/2V0DNCVDCHIli1p5jXdPFTMwALMLL/umOoxvNwJq8E9A5XoXQ9SumfBT8En6xK59a@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAyw3qaDYn36YMYMVSKRWGExX8iIF/7ld18Zg6s4/Unn97hfhT
 DDWegXt8M4/stL0BMxX5cmK337ekUoJF3DvCWqsPVPcroX6v0i8yvZ/xKVs9X/F4Ylc=
X-Gm-Gg: ASbGncu6J3V/8RyuQQRZ57jmYaQMk8o0Y7aj7iMb6OJORoJSyHvqfSPOM7Wgm8+107i
 t/sM7uq6jcJzPyM2JH1w8s2SkkSfrUI0tZ5w0c3/D4quzf9iufgiSIywA+I9vnZ4tLFpI77UWrh
 TLoiFKB7yKtXGB9zkjJ5rvTBaO2cDYWdpzVR/CVukYeQzcrDuPeYqdouslN3TlsTqtAXEgW9gWJ
 lNF49umfCiv5J/R0fqdb8nk5BRZHF38U5ajY9GHqFODIhK1DlxToRynpzcHheCLxuD5YwmuZCSJ
 70EqlyiO1bIOrdWftu6BD9Y+USROaBtQLAyxtCbWSeO0vpMshn7nAtuahLFwU0CSWvhtIhxy+pU
 7aFvLIT2z3Xw1lhk35+3gQwAeiBJTugk6CcGUV8U5FIf1f3anbJQREwbYSBTuRBh1Dn3xUrGYIM
 cTw0EuLlgixl7sz+NU
X-Google-Smtp-Source: AGHT+IGrfzg1Xg1wO/TlDu/ofoMy7oHHfU0dL1Jh0wnlLA5yJV193tgyEZ3rX1xlHwdfKHaOr7sizA==
X-Received: by 2002:a5d:584b:0:b0:426:d5a0:bac8 with SMTP id
 ffacd0b85a97d-429e331283emr2153847f8f.56.1762332660049; 
 Wed, 05 Nov 2025 00:51:00 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429dc1fbeadsm9159995f8f.37.2025.11.05.00.50.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 00:50:59 -0800 (PST)
Message-ID: <a695ca43-b5e8-4461-a419-798661e41197@ursulin.net>
Date: Wed, 5 Nov 2025 08:50:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/20] dma-buf: use inline lock for the dma-fence-array
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, felix.kuehling@amd.com, matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20251031134442.113648-1-christian.koenig@amd.com>
 <20251031134442.113648-8-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251031134442.113648-8-christian.koenig@amd.com>
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
> Just as proof of concept and minor cleanup.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/dma-buf/dma-fence-array.c | 5 ++---
>   include/linux/dma-fence-array.h   | 1 -
>   2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence-array.c b/drivers/dma-buf/dma-fence-array.c
> index 6657d4b30af9..c2119a8049fe 100644
> --- a/drivers/dma-buf/dma-fence-array.c
> +++ b/drivers/dma-buf/dma-fence-array.c
> @@ -204,9 +204,8 @@ void dma_fence_array_init(struct dma_fence_array *array,
>   
>   	array->num_fences = num_fences;
>   
> -	spin_lock_init(&array->lock);
> -	dma_fence_init(&array->base, &dma_fence_array_ops, &array->lock,
> -		       context, seqno);
> +	dma_fence_init(&array->base, &dma_fence_array_ops, NULL, context,
> +		       seqno);
>   	init_irq_work(&array->work, irq_dma_fence_array_work);
>   
>   	atomic_set(&array->num_pending, signal_on_any ? 1 : num_fences);
> diff --git a/include/linux/dma-fence-array.h b/include/linux/dma-fence-array.h
> index 079b3dec0a16..370b3d2bba37 100644
> --- a/include/linux/dma-fence-array.h
> +++ b/include/linux/dma-fence-array.h
> @@ -38,7 +38,6 @@ struct dma_fence_array_cb {
>   struct dma_fence_array {
>   	struct dma_fence base;
>   
> -	spinlock_t lock;
>   	unsigned num_fences;
>   	atomic_t num_pending;
>   	struct dma_fence **fences;

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

