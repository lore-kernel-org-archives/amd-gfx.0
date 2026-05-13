Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27CFCD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 21:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3350610F072;
	Wed, 13 May 2026 21:18:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DpneW860";
	dkim-atps=neutral
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 335F410F072
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 21:18:46 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-8b1f2b7f1bcso82056276d6.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778707125; x=1779311925; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LhDjW3I5Y8P1uIeQFjEbnKo3t3FqwD71SQiFBw91vTk=;
 b=DpneW860HkM1B6ozhjl7KsTQa1srQE8Dd5lQFASOxTidLsVs2LO2K8iFmj0VaMUz+a
 ur1efX8s175E18/rrEqS1fvlsEQAAepv8lsHXw0Fvr/a94IQ49iv/UEckbc7VuIVLHtJ
 +DRktC5p1bkibB6PDzipHqoB7qMaIhe6eUMC/6gh9vKF06FpTp4es2i5c4V878/E0E5G
 +YpMYF55XQKnFpke+to+ji87rRThMCIYozoGBCENxKPRW8UZrX2LqhW30eOYpMfexGWC
 8oFF+7fiY7fZSjh5TnmbMLt8whNrEP2fta9NV3auDkgCw4WOt/db4FANUccHy8LM9xyM
 Ic7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778707125; x=1779311925;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LhDjW3I5Y8P1uIeQFjEbnKo3t3FqwD71SQiFBw91vTk=;
 b=lG3VOYUQIXSOBc7fdrr1slx/B6eueTn6sG/wPDIwLHFWUroHe/KYFwXFkruOy5ARqW
 Y2mMvSUlnsUBeqWPt9v5GKkY7rC+6GKxHQCUhlnwyMsMMciVoA/rQODF/cNpLbguSo6d
 Tlz+h9+N95IgqfiZZoJmHLAi45lgdCOCxTCoCn77z6hcPPymmwcpfecYnN7QTMzsq+yz
 K+4D/hL/OrKGvU/tKRPs5IBXyeDeNCLCf3e9Nfy0XHstyBcw6BNi61jTXdRVCwH32zeX
 kbkpvWPxPQ7O4i2JBAEEwWN6Z6KKIP6QGJuMZ/knivrgJsXcrgAUq32IHqDcLl9v+g/G
 hr5A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8gc/4eD2zmBpdBTdggkS8m0OQsfPweFjOmjEOhlmWE8mcdqNjPLnUTUUcEq8ssiPQxeNchyf84@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzEW9cbNwfEKyEHyFE4GnInQFCmuT60+xlwBzC03U+EhyFi4hgO
 moVrzUt2ET8mZhujN3g5oGYiPeXi2Ct5PC3ljSTo/YuAk9FYXlcainRR
X-Gm-Gg: Acq92OEIbqLDmVGwNcitjlVZ8bmTzjRkJU6M4bbnUIyN+WZXOVqkK+xKJ4mP2qdt+qZ
 MK+zFvFOnCPjM+Pf7VImYU1nMQ1PedKi1TIie+CEoS3r26Zix/YtN3zr59Kir49JQiyzidvqVxd
 L7LpqOuyWXIGBic+224KZ5Dm+0B5ePiaFcnxeP0+6hH/HBt2eXpera+XfKdtT8y+6vBr77xdT3C
 8TtPXmyiejiAvmGhXtJkZs1cp4Tt3dZ5pyNcnn7euAxvgCc1AxHtfl4WC/UyahcgDy5E7hYyC2E
 e9Jyvb57slPQOHG3zKoOXw61GTs0VdbcojRih2EVOOxWjjFvAwcYVHA4VHBBw+wE8F4RRYOi5Jj
 shBYhvRhUESI/M82GljisAjhL0XsMEzzgRjrsw+/pRNgbe4Ls3mGk43GYPWDe4FPQaS8KWtBjXa
 HyPdQzRoXZs1XBs+7RAbpIZj5VMRt9NeU=
X-Received: by 2002:a05:6214:4801:b0:8ba:d36a:8b0c with SMTP id
 6a1803df08f44-8c8fbd05f71mr16533066d6.12.1778707124817; 
 Wed, 13 May 2026 14:18:44 -0700 (PDT)
Received: from [192.168.1.100] ([32.220.111.111])
 by smtp.googlemail.com with ESMTPSA id
 6a1803df08f44-8c90c161928sm6139136d6.44.2026.05.13.14.18.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 14:18:44 -0700 (PDT)
Message-ID: <7233fc9c-a654-4969-b10c-2b89d6bc4fd2@gmail.com>
Date: Wed, 13 May 2026 17:18:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] drm/amdgpu/vce2: Fix VCE 2 firmware size and offsets
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>
References: <20260513200416.35631-1-timur.kristof@gmail.com>
 <20260513200416.35631-9-timur.kristof@gmail.com>
Content-Language: en-US
From: John Olender <john.olender@gmail.com>
In-Reply-To: <20260513200416.35631-9-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 5/13/26 4:04 PM, Timur Kristóf wrote:
> The VCPU BO contains the actual FW at an offset, but
> it was not calculated into the VCPU BO size.
> Subtract this from the FW size to make sure there is
> no out of bounds access.
> 
> Additionally, increase the VCE_V2_0_DATA_SIZE to
> have extra space after the VCE handles.
> 
> Also increase the data size used for each VCE handle.
> The FW needs 23744 bytes, use 24K to be safe.
> 
> This fixes VM faults when using VCE 2.
> 
> Cc: John Olender <john.olender@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4802
> Fixes: e98226221467 ("drm/amdgpu: recalculate VCE firmware BO size")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>

Looks to be effective on both Kaveri and Hawaii against a wide range of
test input sizes.

Thanks,
John

> ---
>  drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> index db149eda6204..3a6fc8604108 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -37,9 +37,14 @@
>  #include "oss/oss_2_0_d.h"
>  #include "oss/oss_2_0_sh_mask.h"
>  
> +
> +/* Use 24K to be safe. The FW supposedly only requires 23744 bytes. */
> +#define VCE_V2_0_DATA_ENTRY_SIZE (24 * 1024)
> +
>  #define VCE_V2_0_FW_SIZE	(256 * 1024)
>  #define VCE_V2_0_STACK_SIZE	(64 * 1024)
> -#define VCE_V2_0_DATA_SIZE	(23552 * AMDGPU_MAX_VCE_HANDLES)
> +#define VCE_V2_0_DATA_SIZE	(VCE_V2_0_DATA_ENTRY_SIZE * (AMDGPU_MAX_VCE_HANDLES + 1))
> +
>  #define VCE_STATUS_VCPU_REPORT_FW_LOADED_MASK	0x02
>  
>  static void vce_v2_0_set_ring_funcs(struct amdgpu_device *adev);
> @@ -183,7 +188,7 @@ static void vce_v2_0_mc_resume(struct amdgpu_device *adev)
>  	WREG32(mmVCE_LMI_VCPU_CACHE_40BIT_BAR, (adev->vce.gpu_addr >> 8));
>  
>  	offset = AMDGPU_VCE_FIRMWARE_OFFSET;
> -	size = VCE_V2_0_FW_SIZE;
> +	size = VCE_V2_0_FW_SIZE - AMDGPU_VCE_FIRMWARE_OFFSET;
>  	WREG32(mmVCE_VCPU_CACHE_OFFSET0, offset & 0x7fffffff);
>  	WREG32(mmVCE_VCPU_CACHE_SIZE0, size);
>  

