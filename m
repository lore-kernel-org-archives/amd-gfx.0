Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C6DC2BABC
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 07:54:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7884820730
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 07:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TblSAd0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7884820730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 322BB6E580;
	Tue,  7 Apr 2020 07:54:05 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 463A96E580
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 07:54:04 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id r26so774814wmh.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Apr 2020 00:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=3IkR+HYNGphAf9yIw0nyH4zktjw6zPgAzTotJxkauvE=;
 b=TblSAd0PmQ4HlNp10dN6QWAMaybhnVlTKeJG3P10NiTfddvexGWRMNiEGPg4QlMwPH
 XyozCUKS0y932frbNT2v04Cer64EOD242zcajWUpcKJHtKpFqN8bMvLIM1ZSjFaycyzC
 ySq2e2n8rO7PfpUMx5IeATg4LPdsFAFxX83w/IQ3XZtS72V8xu503F/wEFM+T5WKqc+6
 2y2phnEi68KRFuGirwiZnFLTBXPynmosrpk9rk1kI0G0k1LJP2iT1I4krokDbJbXkR7B
 wQILLi8oqIJf4qGbd3ivF2bpTbnAwHPRMjkZ7Nlvs1E8ZqIy9VJAHo8vJwIbvq0uT0qG
 0CtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=3IkR+HYNGphAf9yIw0nyH4zktjw6zPgAzTotJxkauvE=;
 b=KL+yuCb1yElr5ewA+jYnHidZ48VFo/lmHXBLaFWRdlKGgp7GAjJTBklIZe46ux73vV
 YPczgeQ4yqMNRisqqORsQXgmpJ2soO0VPBRctxav5JmSKgnRg4rg3xksyJ9ubVtogJ74
 mK8yFeKgPL3Im7mjAB8L1gacTjA0jxfwYz4GayupoFRKxjHLXXi3n8bjFfBqbvWK7tMi
 NyISr4oL6MLGHVBfK92wlEAh+Vjj1cgG6dwAJJNfDQTFG7XCdD7Onhjxh+ipbRb5dTV4
 FOC7TIVGtP0wdzohuSeaE6/Ae0CWPrsWXq6ZNaGsI43FjgNqIYq735Bevux0IwT9lblR
 6JiQ==
X-Gm-Message-State: AGi0PuaKysO7xy7VcXnm6b+XwzZgd0J9/sazJvgDQ9mVMlk4Gmm/9ylp
 dSxMwMrM2X8rKp+EN0x+5OkTbgbL
X-Google-Smtp-Source: APiQypJe0keHTzMTdh8JW9QzWbhifuZMhDcN/Ie1GQ3wocK+ynutSPbz3QXsSkWRBl4G67BaHKEa+A==
X-Received: by 2002:a1c:a7c4:: with SMTP id q187mr1090597wme.56.1586246042732; 
 Tue, 07 Apr 2020 00:54:02 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id j31sm23511084wre.36.2020.04.07.00.54.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 07 Apr 2020 00:54:02 -0700 (PDT)
Subject: Re: [PATCH 1/3] Revert "drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset
 in gpu reset"
To: Jack Zhang <Jack.Zhang1@amd.com>, amd-gfx@lists.freedesktop.org
References: <1586245949-31138-1-git-send-email-Jack.Zhang1@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <5e7c5070-bf94-9d61-db37-078eb2832f5c@gmail.com>
Date: Tue, 7 Apr 2020 09:54:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1586245949-31138-1-git-send-email-Jack.Zhang1@amd.com>
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

Am 07.04.20 um 09:52 schrieb Jack Zhang:
> This reverts commit 8a468ab2d75a6b0bacfb5da6a9036642436fc666.

You need to give a reason for the revert and the SIgned-of-by line is 
missing.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c | 3 ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  | 3 ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 2 --
>   3 files changed, 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index bdc1f5a..4ec6d0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -543,9 +543,6 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
>   	uint32_t temp;
>   	struct v10_compute_mqd *m = get_mqd(mqd);
>   
> -	if (amdgpu_sriov_vf(adev) && adev->in_gpu_reset)
> -		return 0;
> -
>   #if 0
>   	unsigned long flags;
>   	int retry;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index c2562d6..df841c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -541,9 +541,6 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd, void *mqd,
>   	uint32_t temp;
>   	struct v9_mqd *m = get_mqd(mqd);
>   
> -	if (amdgpu_sriov_vf(adev) && adev->in_gpu_reset)
> -		return 0;
> -
>   	if (adev->in_gpu_reset)
>   		return -EIO;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2e1f955..d94eff9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3852,8 +3852,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>   	if (r)
>   		return r;
>   
> -	amdgpu_amdkfd_pre_reset(adev);
> -
>   	/* Resume IP prior to SMC */
>   	r = amdgpu_device_ip_reinit_early_sriov(adev);
>   	if (r)

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
