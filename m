Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0099FCCD1AB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 07:29:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E87710E9EF;
	Fri, 24 Oct 2025 07:29:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="2bQQ8qkV";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AFAE10E9ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 07:29:53 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-427060bc0f5so940899f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 00:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1761290992; x=1761895792;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aF/u/q9kbdo6CwcaSzIK0ty5c6Xv+ybqJNfYM8rphuY=;
 b=2bQQ8qkVbJ8IgFHVjYBTNh8aY5V+F5Qxpj/E3k6q1NhOqiojTePwP4tnn0q1RmxqIK
 ubqq5EX7HkapNcBaMNTmBDkaR1El4Fbssbchlasu6Gu/v3T5Vm4UMZYEG6JMn9wwA1iw
 MUUN6ub+8Fz07a//wBW+sUpBTz7XPFuWK1S6aadsf67aK/BNb74OsYJnjQKn/ufEDw9A
 aujHXMvQg4HlYbjL8PAf8KcfjBO0f4l4DphxiA64oGOEM0pTiAfazbQow3Svn8SQvjZA
 iJdWFHsnnDsx4GG8RoMxAlwr7L6chG+c1xBCEdbHD6FvsL6qNPfAgdQNlR6NiFlDppaX
 2v3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761290992; x=1761895792;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aF/u/q9kbdo6CwcaSzIK0ty5c6Xv+ybqJNfYM8rphuY=;
 b=dg5xIJmyqbP9ldUwzcUSF5riQiX/xyRk5bryolceuNtfMLZ1s3Glzw/qR2xH3Gonmr
 9LfgEWoN16XcnW1+1TnbgtJokciEvKQJzo1cEZjWJVKvb2lCV7xkc9+77BPAS7RS1MHQ
 z8qofHXMjkd8RcFg7fLHkbXoNZxATw52WFcjxyt1OUEex1O4emxL1d2X16R1QyRREcF6
 i/l0gVkEDXHE74aqUYSEgN8YRNKwBz+2jvGBUQ0eZdKUYC/oRU4z5SYvNoho2glPtnsX
 Vr6Isq/uPxJLIiBAf5bi24dIndvCsSyUKjMXXa0IgtJkKBV5aJI1vDPhyS0UzblCapxZ
 E5ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt2DadoM6aOKpU7CoAVMmRcFoK/6lcyDKkE8NA0d6Dm5BFxYUcmEcWwjDLakmZpEhhZU3bzcGn@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx+RVogW6hqw04ydPtASXhCm6XWsf6IB/tRIouSb/xeIeXL2IDG
 gphNpiQKTBx8gBEC+gY0tonaqsdMUQqU7clh/r4YFFsaAHvKMPiFNCMaYJ3i9PaJhxg=
X-Gm-Gg: ASbGncsn+ngyqrqYTxDFXs7p7/pWXuKVgXM1fU0dDDACzClI9i98rf7X6okQvbZnG8u
 wTL/mKYqse7+v0QXKkjXYQKzpoPtU2Bv0s1ug9z21EWF2p1mntyWagpAp35ZsRbC54aSVFAmQsr
 Axrmmrc67EipfcdEi8Gwf5oLZ5C6YrzwGph+lurHWwCZ2bCHDdwc0k/NoxFG5QrHEmpsAnKRLXi
 CZQKhskITtuc5ycXf5zPvvGWWGGcBaqnVQLPORWSbxeL93TMe1lieA1KzAXXKze6wReyhbEASHK
 0JIKCq0lMgPhVRWzkhB9SAk9ol7upKkCc0BuDKOE9mMGbCMxGRkRJfvJdBiN8DaofOQU1ZUQqgD
 88TvYiawVDY/bBM0q9eiIKVgGNSwkuScJb9YRU6VucnGfw656gNg18SfgkTs80GiUdWET287H1x
 cpO58RMTXWqcXzFoKZGbpHf2I4gw==
X-Google-Smtp-Source: AGHT+IEu1zD0i6VYfaEoWTqQsLYOKir+KR+V+WwdpuYMDYKL6mx+z6MRmKD/LjQoCrHs35cjDrcY9g==
X-Received: by 2002:a05:6000:2486:b0:425:7c1b:9344 with SMTP id
 ffacd0b85a97d-429907091femr1119587f8f.15.1761290991721; 
 Fri, 24 Oct 2025 00:29:51 -0700 (PDT)
Received: from [192.168.0.101] ([90.242.12.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898adf78sm8327823f8f.32.2025.10.24.00.29.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 00:29:51 -0700 (PDT)
Message-ID: <67c24e3c-299d-44aa-af7b-7d45b7e3b391@ursulin.net>
Date: Fri, 24 Oct 2025 08:29:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] dma-buf: rework stub fence initialisation
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20251013143502.1655-1-christian.koenig@amd.com>
 <20251013143502.1655-3-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251013143502.1655-3-christian.koenig@amd.com>
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


On 13/10/2025 14:48, Christian König wrote:
> Instead of doing this on the first call of the function just initialize
> the stub fence during kernel load.
> 
> This has the clear advantage of lower overhead and also doesn't rely on
> the ops to not be NULL any more.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/dma-buf/dma-fence.c | 32 +++++++++++++++-----------------
>   1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index f0539c73ed57..51ee13d005bc 100644
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
> +	dma_fence_signal_locked(&dma_fence_stub);

Kernel test robot reports lockdep_assert_held(fence->lock) inside here. 
Probably just copy and paste error, at least I don't see a reason why 
dma_fence_signal couldn't be called.

Regards,

Tvrtko

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

