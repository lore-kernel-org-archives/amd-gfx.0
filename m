Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0C4C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 07:53:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C11616EA
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 07:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C11616EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97D416E9EC;
	Tue, 11 May 2021 07:53:09 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C9CC6E9EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 07:53:07 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id gx5so28332826ejb.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 00:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=51ZxcDul76x9F48wcTcaVhODYpThqlbV4Ao6IscdMzI=;
 b=TXw0YOHk/h/nD7aCTPHVkiZDB4ge80QAs4lbEcNsOSCR324effQ0HFH0X1eqMQmcJQ
 2SVEUeRQrbvcAbqOkDv9wcLSQaFe11gAXbiV8dTrlzkxv/XV6IWc5sw8Wurg4KquECQv
 87Sb4Zk5MuiP+28Mwy7FEUCysLZkcOfxx5Mlp2iABXMVDHjgjnvnEF6Amk4dawn/kalM
 3M0VX3T6aIRJiFGNbY6YmOZgWynY7eE4thJl0naa2CVgDrY58MDRDCFxHfm5UK78I9BW
 RQOLqeMl1hahkVAfODe+KDOXokpAB6e088yAb5ewf/m9kfiDJAfcEWat1ymCoXXfNdfN
 +k5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=51ZxcDul76x9F48wcTcaVhODYpThqlbV4Ao6IscdMzI=;
 b=hDQ4V5jb5oFVGh2HZkDb0Qa0lg8tY3HN6RqEHST2clr210BEK4IUo00N0mpi23EpGt
 tNzJF8FiK0bDPMruDce7ausHPdx09zQHCUv8JQuGpuxgYLaN4VM0fejg/heoX0NKJO4s
 QGi72WKF8V52nideL4VMCpGkFJ7iYpHFy47G5bXJhQopEGzpUaPsWtd1NS0qLXFWURWU
 xIOKIAxcWVN1r/C6zc01yhUFCwanAxrT6AERihUCIBfFABiIgVqLqSq7X/T1wle+QzSu
 maMWw8loNVUkmZZvQkL/K9U/Pi00/+n+0yd9wARAtfEmVioytsYhKkLHIWv+yunN+RnD
 6RIQ==
X-Gm-Message-State: AOAM533BssghdCVAH1e0aOh+bqmOPxuBEWgQ7/r0e2AmAVDio7NPd29V
 vBX3JedJdAcJclY9XFcr8WGsVnQYtGw=
X-Google-Smtp-Source: ABdhPJzrAP3e7Xwa4ThXLCvjZMge8lUVF7w2mpmtr5LtVVRGbYbtZG3fX/hXJbuHtP/TLuzW3KiHrQ==
X-Received: by 2002:a17:906:aac5:: with SMTP id
 kt5mr30569129ejb.414.1620719586391; 
 Tue, 11 May 2021 00:53:06 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:c3ab:ee01:d547:2c4e?
 ([2a02:908:1252:fb60:c3ab:ee01:d547:2c4e])
 by smtp.gmail.com with ESMTPSA id i25sm9039677eje.6.2021.05.11.00.53.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 May 2021 00:53:06 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/amdgpu: fix fence calculation
To: David M Nieto <david.nieto@amd.com>, amd-gfx@lists.freedesktop.org
References: <c1b6f68f-4b96-8752-c406-564e2b98ce41@gmail.com>
 <20210510202915.30502-1-david.nieto@amd.com>
 <20210510202915.30502-2-david.nieto@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <7579fa92-ad25-323a-0c41-ac07ac47fa42@gmail.com>
Date: Tue, 11 May 2021 09:53:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210510202915.30502-2-david.nieto@amd.com>
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

Am 10.05.21 um 22:29 schrieb David M Nieto:
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
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 13 ++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
>   2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 9036c93b4a0c..89ee464b9424 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -698,16 +698,27 @@ ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
>   	struct amdgpu_ctx_entity *centity;
>   	ktime_t total = 0, max = 0;
>   
> +

Unrelated white space change.

>   	if (idx >= AMDGPU_MAX_ENTITY_NUM)
>   		return 0;
>   	idp = &mgr->ctx_handles;
>   	mutex_lock(&mgr->lock);
>   	idr_for_each_entry(idp, ctx, id) {
> +		ktime_t ttotal = tmax = ktime_set(0, 0);

There should be a blank line between decleration and code and please 
don't initialize local variables if it isn't necessary.

Christian.

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
> +		if (AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(tmax, ttotal))
> +			continue;
> +
> +		total = ktime_add(total, ttotal);
> +		max = ktime_after(tmax, max) ? tmax : max;
>   	}
>   
>   	mutex_unlock(&mgr->lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index 10dcf59a5c6b..3541dfb059ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -30,6 +30,7 @@ struct drm_file;
>   struct amdgpu_fpriv;
>   
>   #define AMDGPU_MAX_ENTITY_NUM 4
> +#define AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(max, total) (max > 16384ULL*total)
>   
>   struct amdgpu_ctx_entity {
>   	uint64_t		sequence;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
