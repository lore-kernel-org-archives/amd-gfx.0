Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6461DCCFA04
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 15:01:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D38FB10E272;
	Tue,  4 Nov 2025 15:01:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="NXih5Oou";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC07410E272
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 15:01:20 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4775638d819so3971115e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Nov 2025 07:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1762268479; x=1762873279; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=msn47VShOfNrrQc7tuPanRu3F1JPI2dv1n+qPnPK/cg=;
 b=NXih5OouAEX2vI/ITk44WW5CTU2PLs92RlOZtWFDmMV2AmVSzO7ZF7X9SOMgyv3V7g
 IwoRyOnw6Kdau40NJtFBxkTZUrPJeBsVsWPzExflLPWz8I1qQ1yLbto44ceXtb8Erk5G
 R+MbCRLZi+n4kd/tBi5UwxSwkyZt1DDaB5XuVKAIJH+vgpPWlkrXpXg1SIGcdeoTwCVB
 Eg/vxc9RTRpNLVx7WrfsysEvRj2OMnKJXZqGJUqLdvD/UW5DyPNNNgJY4RbVn4MgU+VT
 gz9c7PNHX4QYMr+XK7J1/cz8QHJFmppriMYFcDYn1KZSNqsUwKDwTxpCWoMNo7b1B8+F
 /wFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762268479; x=1762873279;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=msn47VShOfNrrQc7tuPanRu3F1JPI2dv1n+qPnPK/cg=;
 b=f78eolU0k06a7zW3mkb6WKq5Ar4rahsS5LaYeiLMZ8DG+Ho26B5o9LAXgVUb30h1DQ
 N4t/hmnE21MbcYGtODD4/g5DJcivIK0AMyeSxRFTal5oIkWMs0uhICl0cYoGG6pN3Ive
 jiphL79fdwFGH3ouzW9DkQ5ej9M69q3X0AbR10pUdoFabKrXaPTcY225kDiVqEom4Cmn
 kxVz75IJ7WnGAt9joyNhYeJDOHvzJYoP81+dHVEogSwKeN4Rn1oRhYdyENSeQjhIrz2f
 wD+KozYEqYuSUl7YyLM47X9AvmxsvbOcxCOc3aD9kq1ACEw4WHwAHaeEHZc57X9cn3k6
 tyug==
X-Forwarded-Encrypted: i=1;
 AJvYcCU72zaf7DLkuM01PK4fQdYkA81IztMGucymAKFmPifmKt3HckDrrNW8omtVKZ3y2w6RezladhpY@lists.freedesktop.org
X-Gm-Message-State: AOJu0YygsIC47xtAbpHJm8TGPsQ6TDMjrm2lfnPtm1T7nIPuOnj8OIIW
 40K061OWRls4pzDa2+XGuP1yEnsHRiiRKDOlWH0C3ueI+B1f5ZIIt7Vrlq9mcilJK7o=
X-Gm-Gg: ASbGncsnl8ylnE3F72M+9ELbw2Cblt9fMUWWuD7QprlKuq3kY/ve0cmIRmKuGuG0+TG
 ViKsAzaUd6LpaGaBexnsOl/LbinaRfo+U95/zhIdXtkZcmCcYx1X13A0+dv0vCLN0dtI/62J0D6
 5fTegUzjCzqnTazLoJjHJF5eVqBZQ7Z3fGEWmjkFZCR00wkzuuzH52xGMJ5h8FcxdUnoeTp0inD
 qCs4DhWkjdupEblHKkfwzAt45le/K5X/7so/O32NNGPpLCObJSxmH89m2s+xzrm+vs9sQJ9dW0m
 qhNwtzjitM8jvQPXFE2vJU6yumEHYS5vHNsP/okZCT1hSxPjVEHe+lTfn0xQ+P/p+8OK7KZa7fJ
 ww93EvP74GfNMpdvlYessQKsITGttK44Tx/RNk1MSMSYqqsFwLHglWkWlYWkrlCkfvm9AQsxUY4
 fJawGjpjIWAmhqgLcL
X-Google-Smtp-Source: AGHT+IEwZIonxVU2yBR7raiieFHieCXZ1iH+yDLJH0Y+BNGU4B6hJjyDG2QrCG9C/l3wPcNA4ac70A==
X-Received: by 2002:a05:600c:8706:b0:45f:2922:2aef with SMTP id
 5b1f17b1804b1-477308b0a8bmr191236885e9.28.1762268478926; 
 Tue, 04 Nov 2025 07:01:18 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477558b88f2sm19500475e9.2.2025.11.04.07.01.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 07:01:18 -0800 (PST)
Message-ID: <c9b23fae-cb89-48cb-b9e2-35804bdc7701@ursulin.net>
Date: Tue, 4 Nov 2025 15:01:17 +0000
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

Actually could you check if this could be demoted to static inline? It 
strikes me pointless to export a symbol for such a trivial wrapper.

Regards,

Tvrtko

>   }
>   EXPORT_SYMBOL(dma_fence_get_stub);

