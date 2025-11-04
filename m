Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43F2CCFA04
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 15:05:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6022810E283;
	Tue,  4 Nov 2025 15:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="efGzd0Z/";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EAE210E401
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 15:05:51 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-47112edf9f7so45723705e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Nov 2025 07:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1762268749; x=1762873549; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AlvoX2iNCnI6J0QF0/fbI3mWGM7eomLwPcxMgnHgE+s=;
 b=efGzd0Z/EzAhF1s23ifLv1yvoyTvGdnPfkpjBMAmJ/XXv0mCMkorZKjwApkiM+xuKG
 YvXREJS2Fg92L0yihWGoI4lEj0ht9z9QHVUvqCI5mJw219+V2J5b9JN9Ikf40ZmoBIyh
 r1U6HlwO8kuh+pmWYNKyTtwmE2EP8zbvFmScbE4clNHe3hdzMnSEoLxty8/LKZO5jXXj
 cEEwMYLVQ9zQJrPoDqgskWWuhE+VgUmThkqwHoaZRbUG/6hZn8jTSrS/cZbpDn7XyBoE
 va5VqskEDUgGWLJ+RiKGwz6kPycDTjdx+QPInmSz4qXJbWHgJnyS5j4+vZJ3ZvmUTyWN
 EutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762268749; x=1762873549;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AlvoX2iNCnI6J0QF0/fbI3mWGM7eomLwPcxMgnHgE+s=;
 b=EtBQUyHzrHoemwK2pR01G7t2OYUEP1xvgfvEK+EC29tonm8/PLLYDWYF0CNwJt52/H
 Gt96XXUljW6V4aFKrlqoP9I2WlUB/WPlRP3jr8mtT141SieiRUJoWEdAJ+dEfdPaYhAq
 OfnzUujP9SQybNbDw1fUB1X7Jwwq3g7r9PDylNfXFwKiwTTCkaiPxw/s4P6ZxWX+Qny+
 dls2cnxqrXkR5W7omrWZBhfOjFN/gDtd233ocJ41diefQNXDu2j5SRrq3WCJExIRsy/i
 0DLxAPD3nj7xDhrOhFjUjNAMsch3EBrvm/3bkIBuOVLMzQGvaBDrS8V9+R3HI7yKqjVW
 P2dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjw4PQpETDEMyBmiqNIH6xxks/LBy9E+EjTGzO04vaRebIC6x2rmJytZFZPgHeMy27vz4UQi7R@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzoZaPnLGsLn6o4AquHzB7n/CgUjkbsgrNatCT0JZvnEGJWcpyX
 TzlnfWQ8PpH17mhAmstQxhCMAf+Lz2GfD1GqxDDS9r/jZ2liEhwoLr6BtXLtKz4C9TQ=
X-Gm-Gg: ASbGnctdgV8hzk5GDbgyPEoWFKW+MRi9wI5ft0etr7QTRVU/VamY1/ggKw3w8xliM9V
 OtijI0t+IpTPZyYbxVN0ik+eIVpYZ6rEt4B50BNRTOcda4ObrjkLXnyPrPfEWfEi43S4S/EumDE
 wLE1SwMYa7z0fcUQYblg97gNEro7fr8hI8+EmPJpr2p6tkwSYmImDb+DlM2ip7ZiP/wUBCZ6Kqh
 qWtet2DXbxiSl4BEE3s96Gccby5wMoJdHqDWtt9IN1VY7bicKWUHNyFtUftT7ztaPWPtFv6csgR
 OJ+XhpqjFnW77sF4R9how5rGGVyzMieZcQMTl5u/I6fPiFdoRoZ+57DmNGYpbNB84hulv4XKHRT
 EdAgCbWqwxn10FQRjo8vYlmvhFLja9wl8C7WMVeUxQVFqDA7lnxbQd3IsO6MVhd4PlqA14S3MOs
 FuxdUJ/+yCrIpMv43p
X-Google-Smtp-Source: AGHT+IE4uSgi6DaJG7/TnMZJ3RvykIHu+AT5e2DgQc/XYdPH4m3Do18Xs2kqXknHeNPsU8Lv4WNFuQ==
X-Received: by 2002:a05:600c:45d3:b0:471:1716:11c4 with SMTP id
 5b1f17b1804b1-477308c263amr188249945e9.34.1762268749096; 
 Tue, 04 Nov 2025 07:05:49 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c383c20sm223253835e9.12.2025.11.04.07.05.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 07:05:48 -0800 (PST)
Message-ID: <ef721c8f-977d-4c10-90a9-379c3b86a3db@ursulin.net>
Date: Tue, 4 Nov 2025 15:05:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/20] dma-buf: use inline lock for the stub fence
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, felix.kuehling@amd.com, matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20251031134442.113648-1-christian.koenig@amd.com>
 <20251031134442.113648-7-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251031134442.113648-7-christian.koenig@amd.com>
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
>   drivers/dma-buf/dma-fence.c | 20 ++++----------------
>   1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index f9d7439275d1..0dbd2f641f37 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -24,7 +24,6 @@ EXPORT_TRACEPOINT_SYMBOL(dma_fence_emit);
>   EXPORT_TRACEPOINT_SYMBOL(dma_fence_enable_signal);
>   EXPORT_TRACEPOINT_SYMBOL(dma_fence_signaled);
>   
> -static DEFINE_SPINLOCK(dma_fence_stub_lock);
>   static struct dma_fence dma_fence_stub;
>   
>   /*
> @@ -123,12 +122,8 @@ static const struct dma_fence_ops dma_fence_stub_ops = {
>   
>   static int __init dma_fence_init_stub(void)
>   {
> -	dma_fence_init(&dma_fence_stub, &dma_fence_stub_ops,
> -		       &dma_fence_stub_lock, 0, 0);
> -
> -	set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
> -		&dma_fence_stub.flags);
> -
> +	dma_fence_init(&dma_fence_stub, &dma_fence_stub_ops, NULL, 0, 0);
> +	set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT, &dma_fence_stub.flags);
>   	dma_fence_signal(&dma_fence_stub);
>   	return 0;
>   }
> @@ -160,16 +155,9 @@ struct dma_fence *dma_fence_allocate_private_stub(ktime_t timestamp)
>   	if (fence == NULL)
>   		return NULL;
>   
> -	dma_fence_init(fence,
> -		       &dma_fence_stub_ops,
> -		       &dma_fence_stub_lock,
> -		       0, 0);
> -
> -	set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
> -		&fence->flags);
> -
> +	dma_fence_init(fence, &dma_fence_stub_ops, NULL, 0, 0);
> +	set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT, &fence->flags);
>   	dma_fence_signal_timestamp(fence, timestamp);
> -
>   	return fence;
>   }
>   EXPORT_SYMBOL(dma_fence_allocate_private_stub);

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

