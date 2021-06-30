Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F2BC11F65
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 09:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B54C61D0D
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 09:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B54C61D0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D328A89083;
	Wed, 30 Jun 2021 09:20:39 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBACC89083
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 09:20:38 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id m1so2206553edq.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 02:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=63+a1bsMx3GD1//mZ42lIYSEPhNH4GaWQBk7Zzabeo4=;
 b=viMGUjAwiPE6TK46toNArsA4fMO7T0/m/i8hwPbGWJ8U+NaHxfDqKq5WTqfH9vj+Uh
 Wq1Uij9NDVjC2nva//SPceuukw6j/XZR9PgEPJn1t/PmaJ7MfLHddwmaP/ccCkkeFXrM
 KhJJ9OOpEDFfsr0Ucqiuu1giZ677SQBl9UjtihMTyWjwo4tN6VzhbiFi4d/EYGSV9OgW
 K1ERGHChuCAlG0VhWpksxxMwcNJ5orh+IsbCD27UyAyPScR8wYIrz1GOzxcuFlul4R3e
 oBewZ4dkH+3EDSGUd2zRe+MkyB0B3Gij/qYMM4UYJ1znUu2xoplZKyuHUC0bt2KdxAzV
 o7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=63+a1bsMx3GD1//mZ42lIYSEPhNH4GaWQBk7Zzabeo4=;
 b=oKvj3hM5qvIb389Dtzcvqw2OiX5XClfOyLQ53QgFFFO2cPLl5lXBTWsfQDM5BUPKzq
 SDw+i22F9SMCPULE6mMBRjlD0hDtBdIihowQe61AYQ8n7h9FqvEC2ONrvHewnjOvO7n1
 pEirqUGvXBMZ54HRZDmuepexS6nfmOpTzARvf6meiuW5VM3N87guVygptVmpGPqQME30
 YfpYFexOaQhbc+KNpPgOGC3YthcuT6TYDc2ss9290B3G46c2q/llhRH12XmDrU4+hiNA
 R/YseEDKCvh7dXxE7h6eOfPpeg3YolwZtLp3BsrWhlsYDOkLXgr8xhW3smZQGLpLT8bc
 x7oA==
X-Gm-Message-State: AOAM5339peaWCWEYRrrvPqCIAdsmCMWcd6VIl7L4kkxBbfklDepthAKd
 k5s8uHGc4M8mGBl2KSbiIBo=
X-Google-Smtp-Source: ABdhPJy1KvJMBlBvff9nk2WShIt2/vgkUyBA3I46mxTdva8M7a3kpFUT/sY1uPgeGE2K0q4MhvBjzA==
X-Received: by 2002:a05:6402:268f:: with SMTP id
 w15mr42290379edd.228.1625044837443; 
 Wed, 30 Jun 2021 02:20:37 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:fd79:22d7:4c21:2421?
 ([2a02:908:1252:fb60:fd79:22d7:4c21:2421])
 by smtp.gmail.com with ESMTPSA id lv10sm6512097ejb.8.2021.06.30.02.20.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jun 2021 02:20:36 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amdgpu: Read clock counter via MMIO to reduce
 delay
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210629100129.1913032-1-YuBiao.Wang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <70d0a944-9af7-9d17-3df1-b35b865e0e70@gmail.com>
Date: Wed, 30 Jun 2021 11:20:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629100129.1913032-1-YuBiao.Wang@amd.com>
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 29.06.21 um 12:01 schrieb YuBiao Wang:
> [Why]
> GPU timing counters are read via KIQ under sriov, which will introduce
> a delay.
>
> [How]
> It could be directly read by MMIO.
>
> v2: Add additional check to prevent carryover issue.
> v3: Only check for carryover for once to prevent performance issue.
>
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
> Acked-by: Horace Chen <horace.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index ff7e9f49040e..82a5b7ab8dc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7610,6 +7610,7 @@ static int gfx_v10_0_soft_reset(void *handle)
>   static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
>   {
>   	uint64_t clock;
> +	uint64_t clock_lo, clock_hi, hi_check;

You could put that on one line.

>   
>   	amdgpu_gfx_off_ctrl(adev, false);
>   	mutex_lock(&adev->gfx.gpu_clock_mutex);
> @@ -7620,8 +7621,15 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
>   			((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Vangogh) << 32ULL);
>   		break;
>   	default:
> -		clock = (uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER) |
> -			((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER) << 32ULL);
> +		clock_hi = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER);
> +		clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER);
> +		hi_check = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER);
> +		// If carryover happens, update lower count again.

That is obvious and doesn't need a comment, but what you should comment 
is how unlikely a carry over is.

E.g. something like carry over only happens every x clock cycles which 
are roughly ~y days/weeks/month etc...

And as Monk noted as well please use kernel style comments.

Regards,
Christian.

> +		if (hi_check != clock_hi) {
> +			clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER);
> +			clock_hi = hi_check;
> +		}
> +		clock = (uint64_t)clock_lo | ((uint64_t)clock_hi << 32ULL);
>   		break;
>   	}
>   	mutex_unlock(&adev->gfx.gpu_clock_mutex);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
