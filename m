Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D64CCFA04
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 15:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13E4A10E613;
	Tue,  4 Nov 2025 15:08:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="QrlfZRyO";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9F0B10E286
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 15:08:41 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-47755de027eso5814635e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Nov 2025 07:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1762268920; x=1762873720; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ax824KU+9wsxsDKXRp3PjC1q8aQfyOXHPnK899GD2dI=;
 b=QrlfZRyOW/6m7/FKI1mHbwsRb8chWC60L8VMex9yhEbSZnRpCl4MhWwN62pRJr6e4z
 FgmcocOp/570x771Kt2IukEQLbonnubA0R8KgIXyCJdA5+I40VrzZ5LtA8wNtabrzmPb
 3+JNnn1iZZcR20HXQD9e2Bf9CSryGS8igDAriD/7baxpGSyNRQfYeg149imsic42Ep3z
 lC96+fvAa6mnlWOahZBpok1YIgybyl/NFaHkLi69TGovYe9R/aOqAh5K8dvl8pNLPTdE
 KSy9fdfT2Mj+jCzAepPdeGBeXsC0V19TvSEPZBdURk40fqPXhQ6QwFcHbZWoBi4y+XnU
 fxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762268920; x=1762873720;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ax824KU+9wsxsDKXRp3PjC1q8aQfyOXHPnK899GD2dI=;
 b=s/xR//EgTPb2H5+1mRtInGFGOa6KgtGGxRW/wZ2Dj3G3TsF57scpZBw+BQyInzKXCH
 mbP7V8QOKTi1CfXAs8ZqEKYd+Gj+4vel4r8ytZBzTbT8vDNb1D8QaJcouYlR6N8ymXjp
 GPCJUl5JPYwrxVA85TjmbAJKHaD0SEYm0W7jfntDUwWLmXWTg46Q2VKnrGJj6S9U17vr
 Z+nekh2pgYekwBXKT+3sEPHP2ieC6TsVPZtmHUStaqfaAmh2NCMt8Zwd1Qyy2dnO866h
 oQzBaYPjui7Ln1IktxWKV7F6Vz59y9bwQlMvGlDkUdYMQI905pc5Xs2pn853qhuYtjbM
 FK7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJDHqB2BMWvGOEUTqELfaHS0yxf8QpmRrcjxO9O1mao1ueHne77TXHFApsoa4Qoh+dZSI5O/m2@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTLIZ1ObFbU0ySBSwOGt3MZQ+J/Ja1zTPEyW6tzWQwHiO1VErJ
 oYZYhytnCNV2115z5a5ts0E67XacRfbt7m+urqt/tuelM0rRXeSKrs3Q9rxc1K3MFvPU4TO50GD
 5mQY5
X-Gm-Gg: ASbGncvyAU/SJZEXYeD43d4YeRQ6K8OW9IMfLiHH2uu8/N9hHsAGEX6UmhrUM4BlyeP
 Lse6n8EYBhMufjdwsbcDhcM0uRyy407438S0wW2mw9fIN7DR+V0e9QwS46jxwsCBfGNWiJEJuu2
 xf9iTz5lk9SXtUxxCjfZWbZalWHw970QDRNFTlqSeNo3oFN3OGX+gXEAXDq868n3rfAFvRNesz/
 oJBcRYjU/yjFem9xySBk4Syz7Dh1k+DNe3lPyQWYGbuo7AIJ1Cx7yDuTDwpSSHi2ltHoZ+1MHvf
 rjVclVnVnz6QFY1t9ufUqqiQu+eB5mnQtYCBtIMt3RNQuxT80rGoNwD9JGhUlBGBAA+m+2ZCKEq
 bXvwLJN0nW0wnQUQ1wBcUo4LTO+xA1uoPbHZzsVKaCyrm55g1ven/H42Omjxr81q3Yf6h/11eaf
 4StzR/TnXe1TgKCYSqJO5rpEC7TTU=
X-Google-Smtp-Source: AGHT+IHku0vFSTOQAss9pX0uFHJllX7SMUpkALVq4aS9aE0PpSxbkhz2Xqt+7Ls3QVl5xPhuzdzdfg==
X-Received: by 2002:a05:600c:8b43:b0:477:1af2:f40a with SMTP id
 5b1f17b1804b1-4773b1d39e0mr116333055e9.17.1762268920104; 
 Tue, 04 Nov 2025 07:08:40 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477558c4edasm19612035e9.5.2025.11.04.07.08.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 07:08:38 -0800 (PST)
Message-ID: <32c5cb46-9f90-40de-bb38-cd2d6419812d@ursulin.net>
Date: Tue, 4 Nov 2025 15:08:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/20] dma-buf: use inline lock for the dma-fence-chain
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, felix.kuehling@amd.com, matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20251031134442.113648-1-christian.koenig@amd.com>
 <20251031134442.113648-9-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251031134442.113648-9-christian.koenig@amd.com>
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
>   drivers/dma-buf/dma-fence-chain.c | 3 +--
>   include/linux/dma-fence-chain.h   | 1 -
>   2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence-chain.c b/drivers/dma-buf/dma-fence-chain.c
> index a8a90acf4f34..a707792b6025 100644
> --- a/drivers/dma-buf/dma-fence-chain.c
> +++ b/drivers/dma-buf/dma-fence-chain.c
> @@ -245,7 +245,6 @@ void dma_fence_chain_init(struct dma_fence_chain *chain,
>   	struct dma_fence_chain *prev_chain = to_dma_fence_chain(prev);
>   	uint64_t context;
>   
> -	spin_lock_init(&chain->lock);
>   	rcu_assign_pointer(chain->prev, prev);
>   	chain->fence = fence;
>   	chain->prev_seqno = 0;
> @@ -261,7 +260,7 @@ void dma_fence_chain_init(struct dma_fence_chain *chain,
>   			seqno = max(prev->seqno, seqno);
>   	}
>   
> -	dma_fence_init64(&chain->base, &dma_fence_chain_ops, &chain->lock,
> +	dma_fence_init64(&chain->base, &dma_fence_chain_ops, NULL,
>   			 context, seqno);
>   
>   	/*
> diff --git a/include/linux/dma-fence-chain.h b/include/linux/dma-fence-chain.h
> index 68c3c1e41014..d39ce7a2e599 100644
> --- a/include/linux/dma-fence-chain.h
> +++ b/include/linux/dma-fence-chain.h
> @@ -46,7 +46,6 @@ struct dma_fence_chain {
>   		 */
>   		struct irq_work work;
>   	};
> -	spinlock_t lock;
>   };
>   
>   

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

