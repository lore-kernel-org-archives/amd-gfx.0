Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E1DC433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 07:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B48F613EA
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 07:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B48F613EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2159F6ED94;
	Fri,  7 May 2021 07:18:33 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3A716ED94
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 07:18:31 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id u3so12019407eja.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 May 2021 00:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=X00z2snTNu6KX+OB+JIpoy4vMjxUM1te7Jr812HevRQ=;
 b=S6AKd0WrQr3zj8Kg5vB+bePZX+CJPnBpQLfntnDUh0M+wlhBTRIwfdO1FbjFxLLhje
 QPxjvVvYXm9ckEGxbnYfXOU5kevV2qZrhvcZjCOih1bNh0TjVOVnTW1LhUsOk4VnURv2
 Eu2ZVA4lKQB6uwVETr2QQrA3COF0m3dMZWfWE2W3OvQPHLPYTeMMdTXuXY6cNdZgJeSA
 JBj20gDUK7JTwRGLytKDA6SiqtotYcpT9SzmLsvN70TRmtjQOT1umXfO2lANt2lI27DM
 y3zTym5xc7QouDKgtkoUda0NWdvmc2uoTg/T54UccE8lhcJq1qxWLXUwi8uJ8N/ETwAI
 ZhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=X00z2snTNu6KX+OB+JIpoy4vMjxUM1te7Jr812HevRQ=;
 b=erTuWnSD6PE15T9f4RgBa5AixBqLJ+ITZuCzmICT1ShRIx70R61tzT/xN3w2V9TjaM
 3xbgQ/SwY+UTJiQgr1v4cz2MY8ygWx/NlAvswVPD3YsiBpufLdBOAZngQNVNoKtocN6B
 QRGNYGzoGDbd4/LGylq60T98/vlf9nHn9uSA0oAv8xPIV9+ms4Z20/T+Ha9x333x8P5f
 08sLytSMxDePaB7HFsxhRpBoclbCEDhqyw1IXza0bVTVV03hUAqxg+uORd1wPpZUss0W
 3+3eK30h0CKkA1/LRxlmH4pUK9uBwWj5kYLjomPa3zsxms8NH5bm6IlTAG1O9gFjWcOr
 0tWw==
X-Gm-Message-State: AOAM5338At4qGPNmP5HlHqAAl2wAa5++I73wg847vqSsV2MgFkPcb0qn
 jU7erHOEsRzAD/jZx79sm/I3CwJg3oA=
X-Google-Smtp-Source: ABdhPJzCCUGQU7wsHKN0OEfeE4XVN5T1MeuQlfUNvT8VhxfNXEj5szivl5nWjAaVA2+NiYxfY87dxw==
X-Received: by 2002:a17:907:161f:: with SMTP id
 hb31mr8489470ejc.514.1620371910317; 
 Fri, 07 May 2021 00:18:30 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:a0e9:d905:7efe:322d?
 ([2a02:908:1252:fb60:a0e9:d905:7efe:322d])
 by smtp.gmail.com with ESMTPSA id dk13sm3493959edb.34.2021.05.07.00.18.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 May 2021 00:18:29 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/amdgpu: fix fence calculation
To: David M Nieto <david.nieto@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210506223733.28058-1-david.nieto@amd.com>
 <20210506223733.28058-3-david.nieto@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c1b6f68f-4b96-8752-c406-564e2b98ce41@gmail.com>
Date: Fri, 7 May 2021 09:18:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210506223733.28058-3-david.nieto@amd.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 07.05.21 um 00:37 schrieb David M Nieto:
> The proper metric for fence utilization over several
> contexts is an harmonic mean, but such calculation is
> prohibitive in kernel space, so the code approximates it.
>
> Because the approximation diverges when one context has a
> very small ratio compared with the other context, this change
> filter out ratios smaller that 0.01%
>
> Signed-off-by: David M Nieto <david.nieto@amd.com>
> Change-Id: I5b6e0ce5f489a5f55855d35354a6a3653e9d613b
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 9036c93b4a0c..a26496735080 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -689,6 +689,8 @@ void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdgpu_ctx_entity *cen
>   	}
>   }
>   
> +#define FENCE_USAGE_MIN_RATIO(max, total) (max > 16384ULL*total)

An AMDGPU_CTX_ prefix looks appropriate here and defines should be at 
the beginning of the file.

> +
>   ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
>   		uint32_t idx, uint64_t *elapsed)
>   {
> @@ -697,17 +699,29 @@ ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
>   	uint32_t id;
>   	struct amdgpu_ctx_entity *centity;
>   	ktime_t total = 0, max = 0;
> +	ktime_t ttotal = 0, tmax = 0;
> +
>   
>   	if (idx >= AMDGPU_MAX_ENTITY_NUM)
>   		return 0;
>   	idp = &mgr->ctx_handles;
>   	mutex_lock(&mgr->lock);
>   	idr_for_each_entry(idp, ctx, id) {
> +		ttotal = tmax = ktime_set(0, 0);

Rather define the variable in the loop in the first place.

>   		if (!ctx->entities[hwip][idx])
>   			continue;
>   
>   		centity = ctx->entities[hwip][idx];
> -		amdgpu_ctx_fence_time(ctx, centity, &total, &max);
> +		amdgpu_ctx_fence_time(ctx, centity, &ttotal, &tmax);
> +
> +		/* Harmonic mean approximation diverges for very small
> +		 * values. If ratio < 0.01% ignore
> +		 */
> +		if (FENCE_USAGE_MIN_RATIO(tmax, ttotal))
> +			continue;
> +
> +		total = ktime_add(total, ttotal);
> +		max = ktime_after(tmax, max) ? tmax : max;
>   	}
>   
>   	mutex_unlock(&mgr->lock);
> @@ -716,3 +730,5 @@ ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
>   
>   	return total;
>   }
> +
> +#undef FENCE_USAGE_MIN_RATIO

Please don't undef macros if not necessary.



_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
