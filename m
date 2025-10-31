Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB48CCF9F8
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 14:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 027A710EBC0;
	Fri, 31 Oct 2025 14:05:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="ttVLCXdM";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17C7E10EBC2
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 14:05:33 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-426f1574a14so1525311f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 07:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1761919532; x=1762524332;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=26q/n1I6RBOpvKVgbrEI7Ev5SGuxVTHG/ajFD1B6wJ0=;
 b=ttVLCXdMOudbi1V147OsLBcLLSorjuYQUMTuTLASC/03OlOfQ0E9hxnCZZHgDBnJ1g
 4x2zze+6LTC//VAJ4I3x375ad0hZcUStD9nJ5bK0PvVAMkQqXcYOebDuSyXoIWw51Ra1
 o4V5G6E2GrX0EDiCA2/CYwZs7KRtiZhOgosdKlpoJcHsBRXCy8zBfQTnZ7lsxpO1kChs
 /yHYwtLwcHNZM7/9n61Tcysf5Y7b/j5+TU0ezgRa0ksBJOfCsHhz+rxY+rr7qXbitzzm
 croBesC/coAwwIvOi5s9QBeSakiV4pGds4syhBEnoZO6MiQ+1DPiPQlnfxaOjy9HwswH
 5yYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761919532; x=1762524332;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=26q/n1I6RBOpvKVgbrEI7Ev5SGuxVTHG/ajFD1B6wJ0=;
 b=RJtuYr0Z6sol27NfTeiV7FCwMxCtkXS3kQ60ziAvQDSfMtjXJii8zwo93sDc7+QUPx
 QjZ1XHPyhrLuIVuPwZ9t+onCrFOAD/53zsgPI5ksLV4JW5fqW9WpKGn1i2yfqHxR9yiY
 qaV4AbqfYbBB83GWbjeE7QoW/W9fnJDBl7wCis+xBkBl7RMcrIzXc79tEUzd9QT8/3A5
 w7TcobgGuwXJqvB41NhVZDVWJeeTtZ30kZSNLBn5xn/8an88mL/mGcyiKZHAEk930FI+
 9jUOwU06Klqc8TytqSPzync43bCBbaNM9eNNv0+s7fkJYUvCpDMh+1hKj3HEmghDHQ7Y
 HDZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAgjFzHjIb7FnJPQN4Bv1TAEEd1qX+VuVUGaztCYvBsyeJeaPxMqScK85FTDaLxmmdffFTfQn9@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwrNVMGWVchUbjZtYseC7crX6eaEmDB8kQ28CV1L1i/G5BEzgAt
 qUP/TxE3xYW3gTtJPjVMxSoqSrfGTl0avV7Q4dreL3TaXte/pSFz39+pqblm4rGxNLY=
X-Gm-Gg: ASbGnct6fVitFuwrp29iT6+jyqcTtXbVuoJKGTLQxhyyFT/MoxVXgATV/WePnkXoq2h
 CJM0e4Zt9U0RIL5Sf9o9RYSln5qp+uziG/vQc6PsMat/u/Xr9m5q0RE0ODdl1hBEyaH+jmvH624
 WYhtW9rt+sUp2a7eVVBMHRab9aNyB9nEls0WGrOBHf1RytzBUjfGz0SeoxYzA7S4oyoGbNVMpVe
 zaj4/lwuNc9NVWG24pJnzc4Hj9rRb1BbpFKAsFpXdeaK2acnKEQLRJl4LnArkX2JTTnCnvNfYEx
 9OOithle8f/fVALyKv1/CwrQ6sFqxhEiARirpbjswMPLe4AV2M+YuKLjRWTS5vXDjr7F+tXCyLz
 Bmw0ZLpPZ/BFEeOmYxn+h+AVYAVokctFGT8GBIM/mFyJwBKF2Wkm2Frz8rDvrqwhIROApuzt9X6
 8bCpX/Cii11QZIUMHt
X-Google-Smtp-Source: AGHT+IHRXGxdN00gjHYB/wISljDMfev6Cerd7KMtURx15FbCZW3YAN2LNQu20a90KoH33jsYry/2VQ==
X-Received: by 2002:a05:6000:2905:b0:427:9d7:8720 with SMTP id
 ffacd0b85a97d-429bd68312amr3011484f8f.24.1761919531578; 
 Fri, 31 Oct 2025 07:05:31 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c13f62d0sm3802771f8f.44.2025.10.31.07.05.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 07:05:31 -0700 (PDT)
Message-ID: <3975467c-3293-4e65-a729-703c7f819bad@ursulin.net>
Date: Fri, 31 Oct 2025 14:05:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] dma-buf: rework stub fence initialisation v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, felix.kuehling@amd.com, matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20251031134442.113648-1-christian.koenig@amd.com>
 <20251031134442.113648-3-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251031134442.113648-3-christian.koenig@amd.com>
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
> Instead of doing this on the first call of the function just initialize
> the stub fence during kernel load.
> 
> This has the clear advantage of lower overhead and also doesn't rely on
> the ops to not be NULL any more.
> 
> v2: use correct signal function
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

> ---
>   drivers/dma-buf/dma-fence.c | 32 +++++++++++++++-----------------
>   1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index cfa6ddcc1278..b229d96f551c 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -121,29 +121,27 @@ static const struct dma_fence_ops dma_fence_stub_ops = {
>   	.get_timeline_name = dma_fence_stub_get_name,
>   };
>   
> +static int __init dma_fence_init_stub(void)
> +{
> +	dma_fence_init(&dma_fence_stub, &dma_fence_stub_ops,
> +		       &dma_fence_stub_lock, 0, 0);
> +
> +	set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
> +		&dma_fence_stub.flags);
> +
> +	dma_fence_signal(&dma_fence_stub);
> +	return 0;
> +}
> +subsys_initcall(dma_fence_init_stub);
> +
>   /**
>    * dma_fence_get_stub - return a signaled fence
>    *
> - * Return a stub fence which is already signaled. The fence's
> - * timestamp corresponds to the first time after boot this
> - * function is called.
> + * Return a stub fence which is already signaled. The fence's timestamp
> + * corresponds to the initialisation time of the linux kernel.
>    */
>   struct dma_fence *dma_fence_get_stub(void)
>   {
> -	spin_lock(&dma_fence_stub_lock);
> -	if (!dma_fence_stub.ops) {
> -		dma_fence_init(&dma_fence_stub,
> -			       &dma_fence_stub_ops,
> -			       &dma_fence_stub_lock,
> -			       0, 0);
> -
> -		set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
> -			&dma_fence_stub.flags);
> -
> -		dma_fence_signal_locked(&dma_fence_stub);
> -	}
> -	spin_unlock(&dma_fence_stub_lock);
> -
>   	return dma_fence_get(&dma_fence_stub);
>   }
>   EXPORT_SYMBOL(dma_fence_get_stub);

