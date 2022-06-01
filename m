Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54421C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 11:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6B0C10E193;
	Wed,  1 Jun 2022 11:46:11 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADC2F10E193
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 11:46:10 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id rq11so3205614ejc.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jun 2022 04:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=7ez1Cz5LjQAM/AeWfj0a7zDkditFeTExrZBJgLnaRy0=;
 b=CIVbOtkyKCUOVmoP6X5JJbkaTWyXUBdXJj1HIp/+KRepedPx3pCvd/ZY4baXuyUyzn
 hZ1/w9hWMyPFmLs7eKhY+Z2UYUTaovQp8aUxOQp00rpaOWQo2khGx/ERnH/En1DtnTWg
 DLUoYziq9hB5l3ObgtG074qawf0HNqYCCe2PzfP84/XcoeVIA8JlPd1lEw7Hfuu7/9vW
 OJu9jfKDdQigWrSw2yptJw8TgzstlCh4yTT5aZuJm8jKQD73+4ik8zKWgWlSz6IdO+Dt
 PpSG1LXxFElsv3x58tzYFvgEaJF1DHag6J67Kd+LrThJYbEKvowqBysu0WVi9Hnk/zGd
 HFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=7ez1Cz5LjQAM/AeWfj0a7zDkditFeTExrZBJgLnaRy0=;
 b=IsWIOo67TizutqCXlUKjxifp2dj8SeZtHgKiu5GcUEWnGZR+AKII2MTAI595GK1Ggd
 p66/tIhgxjtONiycqlYOw2HU1hi4/O2cKqufcDHBmMkoVC1TELO5ie8zC1k1gGEnYcMV
 3yt8VD9xG6c5Rq+Tohs6l7hkDjszo6kwaHrHXLsWvrhKdVbXvKRei0GLZGE+f2jnWKgP
 JazRKUw4dcrdF0EPbglMfFSg9iACMn9Ips096ElEm4N5PrpzaYQuG8zc6/mUD8Mic6S6
 idSItNqHEm/7jdc2bpfzoHaUuJ+Z85UYSE/nCeMvhCk3QhIVDpkTLJaee5/ZwNi7/8KV
 Th1g==
X-Gm-Message-State: AOAM530ZdzDQmt9iSABXcsrzZirwkEJdDNxZj6kg6KNkWKx4GTj5odUD
 NjN8jKg/57wyC/htoTY73TFy5g8uXTg=
X-Google-Smtp-Source: ABdhPJx8GIB9PkcfBM+MRll+mwRRtjEWBBw9soOSY0AAJCV7AQcGpUCl7v5d0y9mRKQGHuP6qlaOWA==
X-Received: by 2002:a17:906:58c9:b0:6fd:f4fe:800a with SMTP id
 e9-20020a17090658c900b006fdf4fe800amr57790961ejs.285.1654083969052; 
 Wed, 01 Jun 2022 04:46:09 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea02f.dip0.t-ipconnect.de. [91.14.160.47])
 by smtp.gmail.com with ESMTPSA id
 f1-20020a056402160100b0042de839eb2csm829060edv.27.2022.06.01.04.46.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jun 2022 04:46:08 -0700 (PDT)
Message-ID: <78fbe2eb-13a0-0dd5-085b-2f62ac113db6@gmail.com>
Date: Wed, 1 Jun 2022 13:46:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] drm/amdgpu/gmc11: enable AGP aperture
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220526175835.3044451-1-alexander.deucher@amd.com>
 <20220526175835.3044451-2-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220526175835.3044451-2-alexander.deucher@amd.com>
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

Am 26.05.22 um 19:58 schrieb Alex Deucher:
> Enable the AGP aperture on chips with GMC v11.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c  | 7 ++++---
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c    | 1 +
>   drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c   | 6 +++---
>   drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c | 6 +++---
>   4 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> index 5eccaa2c7ca0..f99d7641bb21 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> @@ -154,10 +154,11 @@ static void gfxhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
>   {
>   	uint64_t value;
>   
> -	/* Disable AGP. */
> +	/* Program the AGP BAR */
>   	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
> -	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_TOP, 0);
> -	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BOT, 0x00FFFFFF);
> +	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
> +	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
> +
>   
>   	/* Program the system aperture low logical page number. */
>   	WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index b6daa4146dd3..635103c7e2a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -654,6 +654,7 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_device *adev,
>   
>   	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
>   	amdgpu_gmc_gart_location(adev, mc);
> +	amdgpu_gmc_agp_location(adev, mc);
>   
>   	/* base offset of vram pages */
>   	adev->vm_manager.vram_base_offset = adev->mmhub.funcs->get_mc_fb_offset(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> index bc11b2de37ae..4926fa82c1c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> @@ -169,10 +169,10 @@ static void mmhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
>   	uint64_t value;
>   	uint32_t tmp;
>   
> -	/* Disable AGP. */
> +	/* Program the AGP BAR */
>   	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE, 0);
> -	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, 0);
> -	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, 0x00FFFFFF);
> +	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
> +	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
>   
>   	if (!amdgpu_sriov_vf(adev)) {
>   		/*
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
> index 770be0a8f7ce..5e5b884d8357 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
> @@ -162,10 +162,10 @@ static void mmhub_v3_0_2_init_system_aperture_regs(struct amdgpu_device *adev)
>   	uint64_t value;
>   	uint32_t tmp;
>   
> -	/* Disable AGP. */
> +	/* Program the AGP BAR */
>   	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE, 0);
> -	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, 0);
> -	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, 0x00FFFFFF);
> +	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
> +	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
>   
>   	if (!amdgpu_sriov_vf(adev)) {
>   		/*

