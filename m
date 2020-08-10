Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116BEC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 11:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC8A20709
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 11:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXHzuKVn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC8A20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C5A36E391;
	Mon, 10 Aug 2020 11:34:12 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBAC36E391
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 11:34:10 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id r2so7815809wrs.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 04:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=HQctqz+jnZYXDEJMfhuA+xT00ae0ozeKflpHc50o3Hc=;
 b=AXHzuKVn5OCvZoxDzG8Ek0SNqYEw0gtof53oe9HxdOIG15gPWFH84F54LoauYiD/tb
 rHeZPHoppZpim9dvKJTP7WtvoOCJF6MO493kGlUpIvy4OqGJC07ya/L4RwS3T+hypkkd
 6ntBHnVLf8hMSgNxJzYDClFlvK5I+9SO+uQyewhqePgmihTYgRjnaflbSEOvGzYsUjOJ
 Nrs0pd4NEHwjrAqy/QVQEHjrTR9YHmUc37/v3jYFh6c3oW8A6MzVhE2RGW+F4tbtMSaV
 6WKxzuuB2LJ6Z28LBJTtyudsd5L37VyPF/1RTvTixPzVjZItxibD53k4XxnvxGNYipNg
 fveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=HQctqz+jnZYXDEJMfhuA+xT00ae0ozeKflpHc50o3Hc=;
 b=RdiHkXqih+RezLOBbFPvbthqdm+W6DQRFDNixYiGyUbTqq/4GbXy0L1M7cCCGL4fE9
 L8hRbeMwpBzLsK/a7cLACHKtCmID3SCo54XysuQvwop0ECKpQnVZAJfUEQ33vqeKe8T9
 VY5PE+95GYp+/pys0MqfcTFaSq0wDnqboA3+rBrn6Spp5DsdEcv6hLhEkn7J08bVR5j8
 G5c1hKCrL4w4fSMXj4ryK+MZzIdKtBu7QEV0o2iMiUiiMvElioBiZK/a1GYoI2huyR/F
 T7VtM4S0bETS1Grbty1uP3R0+sOJBlxp8DG0XG5Eb52o9F0P63JvRJfujskc2NBRSWqt
 anXw==
X-Gm-Message-State: AOAM5336EYzODN2qyWywBASvSHOcjMpRK3or7rb9EyGt4dkbuk3gogxe
 z54LqiWU/Mt9ycdqiD6AzMHNcrok
X-Google-Smtp-Source: ABdhPJx4n81wb1E3qMZmVtJOI2Yx35xDNe4R0/5mHGBmgR7S4mbnCyscoS/l8Rl/flw8v7TL0iSWXg==
X-Received: by 2002:a5d:4ad1:: with SMTP id y17mr25801384wrs.132.1597059249434; 
 Mon, 10 Aug 2020 04:34:09 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id c14sm20416721wrw.85.2020.08.10.04.34.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2020 04:34:08 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: fix reload KMD hang on GFX10 KIQ
To: Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1597031967-25513-1-git-send-email-Monk.Liu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <de13b0bc-09e5-aa1c-f635-6605e2ee160d@gmail.com>
Date: Mon, 10 Aug 2020 13:34:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597031967-25513-1-git-send-email-Monk.Liu@amd.com>
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.08.20 um 05:59 schrieb Monk Liu:
> GFX10 KIQ will hang if we try below steps:
> modprobe amdgpu
> rmmod amdgpu
> modprobe amdgpu sched_hw_submission=4
>
> Due to KIQ is always living there even after KMD unloaded
> thus when doing the realod KIQ will crash upon its register
> being programed by different values with the previous loading
> (the config like HQD addr, ring size, is easily changed if we alter
> the sched_hw_submission)
>
> the fix is we must inactive KIQ first before touching any
> of its registgers
>
> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 622f442..0702c94 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -6435,6 +6435,10 @@ static int gfx_v10_0_kiq_init_register(struct amdgpu_ring *ring)
>   	struct v10_compute_mqd *mqd = ring->mqd_ptr;
>   	int j;
>   
> +	/* inactivate the queue */
> +	if (amdgpu_sriov_vf(adev))

Could you think of any reason why we shouldn't do this on bare metal as 
well?

I mean it can't hurt to be extra careful even if the KIQ shouldn't be 
running.

Christian.

> +		WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, 0);
> +
>   	/* disable wptr polling */
>   	WREG32_FIELD15(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
