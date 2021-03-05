Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87EBC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:17:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC5E6509F
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC5E6509F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 000EE6EC41;
	Fri,  5 Mar 2021 20:17:37 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 733996EC41
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 20:17:36 +0000 (UTC)
Received: by mail-qt1-x82e.google.com with SMTP id d11so2751387qtx.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Mar 2021 12:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=4FJde4ytKq2aQ5EpqAAgCZyZ7Sv3RtFxePnKwXZML1E=;
 b=u76OZafDf4HAX1ZHA9c27sqmATCajzynHdxBHVWq/lGLXOVAndM0StRk7EA6HavQDk
 U3tlY+J5xY4/6wGW6ZL2zXJ4xotz3kcHqKm8du9gnORERr4DSi6BgLQp1xpnRPvtT+J6
 kbeGkZEMeS0vdpfC4izKW5aCdtps9Q+vgLiLHov3ZwgikeKgRPoyoKQhkfrKR3cXpc6X
 5RZO/XTW/WAKncR1D5hIX+8I1nXsMMtAI5EsF24DENmjCMRc1yV0AcwGLiJnUAH5lqSU
 wgFqAGXNrVdR0PTDMNnXPbH9aozV+cDb4B8GfU/bzdQYiDHg9F7N/xJEqJNZV3S057cz
 6qQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=4FJde4ytKq2aQ5EpqAAgCZyZ7Sv3RtFxePnKwXZML1E=;
 b=W8jgunO8urTNAIHJTbt4sKQuSooFxdWUIZS4Xm74uqzatLWN7s7Rncv+RW6a+cmqB8
 e6hAi7tikV8kZ+wtJ9V7q7xF6PvJLb7ntgwMqvPeNDgxogojdhp/8yf3SAZpPq7GdKk2
 jUVh5PFCy4uDUVjlONSWnVfweiB9Xhkj7+H8tnuT46CqEXkP6JXpw/fEO96TxNrsDW/8
 yEMLQ5IccR4RG00oFokYaUhg3PuwiWSm/y5ASTdwFiTT9LvoVwz55S+fO5qFRihRlpgt
 equcTujT6ekucextRQV3InGHl1FWicW1Ndi9qNPDOBM7l0grvhp5nlYFDsZoxHSJmTR2
 m0+Q==
X-Gm-Message-State: AOAM533Kpz7GIEQekawhODa8OfPYa1IodTBaBn4JCB/Q7k+aRkUvGBrD
 sv56Fsf79W/cCXAZ4IyJ3eI=
X-Google-Smtp-Source: ABdhPJy6xSvwu3AQ1SaeclhNxzYS9VLiVPMqQsDx1rgYL0UfSDZ6Zz/WPV/1AP0SI5h9lYu6Sx9G1w==
X-Received: by 2002:ac8:43d3:: with SMTP id w19mr2221785qtn.221.1614975455639; 
 Fri, 05 Mar 2021 12:17:35 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:ee4e:e545:33e0:7359?
 ([2a02:908:1252:fb60:ee4e:e545:33e0:7359])
 by smtp.gmail.com with ESMTPSA id n77sm2547453qkn.128.2021.03.05.12.17.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 12:17:35 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: add ih waiter on process until checkpoint
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210305201121.55036-1-jonathan.kim@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c740e996-2c45-c512-aff1-722c90b0e450@gmail.com>
Date: Fri, 5 Mar 2021 21:17:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210305201121.55036-1-jonathan.kim@amd.com>
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
Cc: Philip.Yang@amd.com, Felix.Kuehling@amd.com, Christian.Koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 05.03.21 um 21:11 schrieb Jonathan Kim:
> Add IH function to allow caller to wait until ring entries are processed
> until the checkpoint write pointer.
>
> This will be primarily used by HMM to drain pending page fault interrupts
> before memory unmap to prevent HMM from handling stale interrupts.
>
> v2: Update title and description to clarify use.
> Add rptr/wptr wrap counter checks to guarantee ring entries are processed
> until the checkpoint.

First of all as I said please use a wait_event, busy waiting is a clear NAK.

>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 68 +++++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h |  2 +
>   2 files changed, 69 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> index dc852af4f3b7..954518b4fb79 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> @@ -22,7 +22,7 @@
>    */
>   
>   #include <linux/dma-mapping.h>
> -
> +#include <linux/processor.h>
>   #include "amdgpu.h"
>   #include "amdgpu_ih.h"
>   
> @@ -160,6 +160,72 @@ void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
>   	}
>   }
>   
> +/**
> + * amdgpu_ih_wait_on_checkpoint_process - wait to process IVs up to checkpoint
> + *
> + * @adev: amdgpu_device pointer
> + * @ih: ih ring to process
> + *
> + * Used to ensure ring has processed IVs up to the checkpoint write pointer.
> + */
> +int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
> +					struct amdgpu_ih_ring *ih)
> +{
> +	u64 rptr_check, wptr_check, rptr_wrap = 0, wptr_wrap = 0;
> +	u32 prev_rptr, prev_wptr;
> +
> +	if (!ih->enabled || adev->shutdown)
> +		return -ENODEV;
> +
> +	prev_wptr = amdgpu_ih_get_wptr(adev, ih);
> +	/* Order wptr with rptr. */
> +	rmb();
> +	prev_rptr = READ_ONCE(ih->rptr);
> +	rptr_check = prev_rptr | (rptr_wrap << 32);
> +	wptr_check = prev_wptr | (wptr_wrap << 32);

Hui what? That check doesn't even make remotely sense to me.

Christian.

> +
> +	spin_begin();
> +	while (true) {
> +		bool rptr_wrapped = false, wptr_wrapped = false;
> +		u32 rptr, wptr;
> +
> +		spin_cpu_relax();
> +
> +		/* Update wptr checkpoint/wrap count compare. */
> +		wptr = amdgpu_ih_get_wptr(adev, ih);
> +		if (wptr < prev_wptr) {
> +			wptr_wrap++;
> +			wptr_check = wptr | (wptr_wrap << 32);
> +			wptr_wrapped = true;
> +		}
> +		prev_wptr = wptr;
> +
> +		/* Order wptr with rptr. */
> +		rmb();
> +
> +		/* Update rptr/wrap count compare. */
> +		rptr = READ_ONCE(ih->rptr);
> +		if (rptr < prev_rptr) {
> +			rptr_wrap++;
> +			rptr_wrapped = true;
> +		}
> +		rptr_check = rptr | (rptr_wrap << 32);
> +		prev_rptr = rptr;
> +
> +		/* Wrapping occurred so restart. */
> +		if (rptr_wrapped || wptr_wrapped)
> +			continue;
> +
> +		/* Exit on reaching or passing checkpoint. */
> +		if (rptr_check >= wptr_check &&
> +					rptr >= (wptr_check & ih->ptr_mask))
> +			break;
> +	}
> +	spin_end();
> +
> +	return 0;
> +}
> +
>   /**
>    * amdgpu_ih_process - interrupt handler
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> index 6ed4a85fc7c3..6817f0a812d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> @@ -87,6 +87,8 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
>   void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>   void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
>   			  unsigned int num_dw);
> +int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
> +					struct amdgpu_ih_ring *ih);
>   int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>   void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
>   				struct amdgpu_ih_ring *ih,

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
