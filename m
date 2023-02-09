Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5189EC61DA4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Feb 2023 08:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D319910E94C;
	Thu,  9 Feb 2023 08:32:34 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D67C10E94C
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Feb 2023 08:32:33 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id y1so979086wru.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Feb 2023 00:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kQhi1um3sy6Y5FCRe7ndpfZbPeZtnXxwGMwowuVgSqk=;
 b=RTqYrMMoOa4mHBdnNfyXk116kiAdwDaJYmZIg9wbZLpuPPyMrDdfqNSshTR9PljuY2
 lrCkX+wTi9DX1gAfykRt56gqkBx56unyp/VHv0SHZvGPzSGHIQFyFjkIWnyhlXtVzLR0
 fs3FWRx1C3Yx7pjozsirW83HgG1Etu3FGCqdgRUL+PS3lDBQ2+mWTm33WQ2zc3HL29Qk
 srPfE3mWCZaxTu/dmYlpFHXHZCvUXfAwRIeDtSKDWVyQTcO1sG6EFI2IE68F6OLrzS83
 NEjxOha9fySWAFjGFD3g9OwrlPibWawLkiwl9sWb1ReFWuzAsNL0E4m9l7mbthH4JKuX
 HdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kQhi1um3sy6Y5FCRe7ndpfZbPeZtnXxwGMwowuVgSqk=;
 b=H03mPYmyDTvRZ1m1Ep4mRW9EUBoIf9d15GLTudgejhvzt6fDr0X7GZ7s/cyGxZHL92
 hLsbCjYEdz6Dtahrj3vtQd0MU29NnGEQ3X5Yf+DEklkbSO2OmWlpfkQO+ZaYaPVlS6Zh
 eyKuvIO9rh5pqYHmuLDRqd9x6IhNiNj8zthHEUGtAWPDzUZQ2Vjqj2IEiF35JHHvANMh
 YlHGoR4Pxdm2FEfDTFLaww780CY2RKJozYKDAKRml9vp5vIMkLcF/tfL+J8uCpt7kFun
 aBlpJnvIc1NKwk9uRKVMULgCKspyL0B1ASB5DjyDv3/Yz9qvC6tkO6Il4X8nSYuQtnxY
 AL4A==
X-Gm-Message-State: AO0yUKVgWy1oyK0kBGXh3E0neQMfA4CSgFtaXM0gmPQZzH1olxkeiqHQ
 MeDGWOPPHOuGgQuCWdsMkyQG8/koffA=
X-Google-Smtp-Source: AK7set8uJl0wKwK0RDWfF5yDupyLh5Y7P6jed5sP2Q1Y0cDbr8UpDnuWwo8X2DY5CdLAFiUnlRru1g==
X-Received: by 2002:a5d:6449:0:b0:2c4:5e6:bde0 with SMTP id
 d9-20020a5d6449000000b002c405e6bde0mr5025140wrw.12.1675931551785; 
 Thu, 09 Feb 2023 00:32:31 -0800 (PST)
Received: from [192.168.178.21] (p5b0ea2e7.dip0.t-ipconnect.de.
 [91.14.162.231]) by smtp.gmail.com with ESMTPSA id
 y1-20020a5d6201000000b002c3ea5ebc73sm630421wru.101.2023.02.09.00.32.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Feb 2023 00:32:31 -0800 (PST)
Message-ID: <6b8ada8d-ac36-7a47-fdef-3be571653dd2@gmail.com>
Date: Thu, 9 Feb 2023 09:32:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] drm/amdgpu/gmc11: fix system aperture set when AGP is
 enabled
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230209044616.560657-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230209044616.560657-1-alexander.deucher@amd.com>
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

Am 09.02.23 um 05:46 schrieb Alex Deucher:
> Need to cover both FB and AGP apertures.
>
> Fixes: c6eafee038ed ("Revert "Revert "drm/amdgpu/gmc11: enable AGP aperture""")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c  | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c   | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c | 4 ++--
>   4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> index 7c069010ca9a..be0d0f47415e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> @@ -159,9 +159,9 @@ static void gfxhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
>   
>   	/* Program the system aperture low logical page number. */
>   	WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
> -		     adev->gmc.vram_start >> 18);
> +		     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
>   	WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
> -		     adev->gmc.vram_end >> 18);
> +		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
>   
>   	/* Set default page address. */
>   	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> index 923fc09bc8fc..164948c50ac3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> @@ -184,9 +184,9 @@ static void mmhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
>   
>   	/* Program the system aperture low logical page number. */
>   	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
> -		     adev->gmc.vram_start >> 18);
> +		     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
>   	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
> -		     adev->gmc.vram_end >> 18);
> +		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
>   
>   	/* Set default page address. */
>   	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start +
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
> index c8d478f2afdc..26509b6b8c24 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
> @@ -183,9 +183,9 @@ static void mmhub_v3_0_1_init_system_aperture_regs(struct amdgpu_device *adev)
>   	 */
>   	/* Program the system aperture low logical page number. */
>   	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
> -		     adev->gmc.vram_start >> 18);
> +		     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
>   	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
> -		     adev->gmc.vram_end >> 18);
> +		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
>   
>   	/* Set default page address. */
>   	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start +
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
> index 51580302ec42..26abbc6a47ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
> @@ -175,9 +175,9 @@ static void mmhub_v3_0_2_init_system_aperture_regs(struct amdgpu_device *adev)
>   		 */
>   		/* Program the system aperture low logical page number. */
>   		WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
> -			     adev->gmc.vram_start >> 18);
> +			     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
>   		WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
> -			     adev->gmc.vram_end >> 18);
> +			     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
>   	}
>   
>   	/* Set default page address. */

