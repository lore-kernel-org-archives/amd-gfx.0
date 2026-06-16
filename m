Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993FBCD98D2
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 08:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43ECD10E88C;
	Tue, 16 Jun 2026 08:02:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="V7H2zlF2";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3041910E88C
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 08:02:48 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6930f7e83b1so6929362a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 01:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1781596967; x=1782201767; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OGCR0BPytXf3/IFxuRcxyewMDwJKfbRFWjkHXdfVjXI=;
 b=V7H2zlF2WCGwPdEFSByrA/DdhLYvajiCNFeuS9ZZug29ysxshSgbFc+B3R+8pnfk+C
 GXPURh3N5h0JtP8wK4y7r/mOCeIXEpz3qgbhTKcwGa9BWcWm/kSaRF44iG6dkxewUtD/
 3TFPFdLPBrx9KQmKdElohxCI4Nb2/JnE3UzvP4V4ZoehROiPn19C/3jbqgXpJ3JhiIJA
 W3+LzfeehKrnix8Ndh8Ioj5nN8PKZlPdB6u0fIP4DiTVgF8dgV6FYOsj8kLSouBlu4P5
 u++vc4DbJVv0FjxIV9C7YSnVlTT8ranSz4NJhDmkvIPPDXqvlMewxHDrZ1NnybbXVuIW
 tcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781596967; x=1782201767;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OGCR0BPytXf3/IFxuRcxyewMDwJKfbRFWjkHXdfVjXI=;
 b=p+Tq8MdLa5m0SDdoF7oBTnklN7jczFvPsn8KJ8ULiZB7i+IEwSbcZejTESU0H+BTzl
 3Vxrw/FqZqZbAi2j/WiURBMiNqy2Wx35fb8BAKW7FOiPqucDLwl4fNDX9l6fSVpr8TeM
 6VlSiXhTR633Go7NAZfyblOSwkR4MJ/s+KIOt0D9sFA+9LgLQhx4Y3i7MVV73B/yPqRG
 ClL7f7w4lT57RYQLPWqcxH9Pdl4xMwEkYfNI46XgO/aX6cUwqCOLZRpuBzIsaDReu0MQ
 +ZNB/onf15xeAYe/5brQ/vOXj7b9uEZjgDddnIEZq9WxIfc2sounbhP7T2nUjbTQ/6LI
 U07w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/018Iy5RlEdYTYUUFwTcPcUNHSH/iI/nG0hKPUa4Dw2bOSm0k8ASMnSpWg8Pjq+d0WVtuQx41U@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1Vj5UH/tCRY3OL/4lUXzfzS2Iz8aRB0jJD+xN6NIRzFCYE6RE
 FlsZIWI5OI3eUXIUHAr6yP6RV5sX0BV8hEt6UWDKvtZAPKGJmWMqtPTyBDOhO0O/u9I=
X-Gm-Gg: Acq92OHX8ZUpv/s6Gw/4XrdMYJzDABHy8LAHA95TVnJ1cvTFjYWjCJ2qgYQfMJ0zvV0
 gCVY0wmXMPFngICdPPngSZCCQr5k8fb8eB1gS0hyoiidVN9ub2pGpGnGojBM6oLiZ2vLSHLGLP5
 5yY3C9Tb6uuBJra4jrrO9COs/h8VYxqjeYZK6fL6T0KwzqNqJB/VLHb2IUta14uZBVqXdo82vzu
 0sBz5L9MyDjVHt1XriZnGN8WWQoJgyVbb2KhK8al4oBa8HjT32WUzIImONOq/iP78SMwE4n/AZM
 b5Okpto24y/ZWsfIWNbY9jr9uzh0evW5wG7RMn7/CF48L0lfmnMcS2rT3pmKkOf/kWzI51Mah+m
 MrFjU5QlgbmfYxBgu9zhGfb/BgNJWWtcfDYZbKlQ3NKMwf4tBnJXfO67sVrCOPQLc9MtEqd8Bks
 QK/B9msvw22jAAV98dWQGEm+OeihxyrAs0u3GosHyOeK7m
X-Received: by 2002:a17:907:1caa:b0:bd5:1ad4:cd73 with SMTP id
 a640c23a62f3a-c0416d02af1mr179129866b.2.1781596966030; 
 Tue, 16 Jun 2026 01:02:46 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb522167dsm592010166b.25.2026.06.16.01.02.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 01:02:45 -0700 (PDT)
Message-ID: <c08e20bc-ab15-4de8-8eb4-e01c090868d4@ursulin.net>
Date: Tue, 16 Jun 2026 09:02:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] drm/amdgpu/gfxhub: Enable retry fault interrupts when
 needed
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Amir Shetaia <Amir.Shetaia@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>
References: <20260525114507.24566-1-timur.kristof@gmail.com>
 <20260525114507.24566-6-timur.kristof@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260525114507.24566-6-timur.kristof@gmail.com>
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


On 25/05/2026 12:45, Timur Kristóf wrote:
> Enable retry fault interrupts when initializing the GFXHUB
> system aperture registers according to whether retrying
> page faults is enabled in amdgpu (ie. amdgpu.noretry=0).
> 
> Needs to be done for each GFXHUB version at once,
> because none of them actually enabled this interrupt.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 9 +++++++--
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 9 +++++++--
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    | 9 +++++++--
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    | 2 ++
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 9 +++++++--
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    | 9 +++++++--
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 9 +++++++--
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  | 9 +++++++--
>   8 files changed, 51 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> index 652eea6eae4a..ef20eafd59ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> @@ -155,6 +155,7 @@ static void gfxhub_v11_5_0_init_gart_aperture_regs(struct amdgpu_device *adev)
>   static void gfxhub_v11_5_0_init_system_aperture_regs(struct amdgpu_device *adev)
>   {
>   	uint64_t value;
> +	u32 tmp;
>   
>   	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
>   	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
> @@ -180,8 +181,12 @@ static void gfxhub_v11_5_0_init_system_aperture_regs(struct amdgpu_device *adev)
>   	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
>   		     (u32)((u64)adev->dummy_page_addr >> 44));
>   
> -	WREG32_FIELD15_PREREG(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
> -		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> +				 ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> +				 ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
> +	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);

As a side note, I have two patches which shrink these register access 
macros considerably:

https://patchwork.freedesktop.org/patch/720726/?series=165432&rev=1

Going back to this patch, a question - how do gfxhub ip versions relate 
to the default set from gc ip versions in amdgpu_gmc_noretry_set()? I am 
wondering on which platforms, if any, do at this point in the series, 
retry fault interrupts get enabled where they previously were not.

Regards,

Tvrtko

>   }
>   
>   static void gfxhub_v11_5_0_init_tlb_regs(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> index 6cbf837d50dd..ec3ff4dec674 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> @@ -158,6 +158,7 @@ static void gfxhub_v12_0_init_gart_aperture_regs(struct amdgpu_device *adev)
>   static void gfxhub_v12_0_init_system_aperture_regs(struct amdgpu_device *adev)
>   {
>   	uint64_t value;
> +	u32 tmp;
>   
>   	/* Program the AGP BAR */
>   	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
> @@ -184,8 +185,12 @@ static void gfxhub_v12_0_init_system_aperture_regs(struct amdgpu_device *adev)
>   	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
>   		     (u32)((u64)adev->dummy_page_addr >> 44));
>   
> -	WREG32_FIELD15_PREREG(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
> -		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> +				 ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> +				 ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
> +	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
>   }
>   
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> index bfe247b1a333..27d7f7cb903f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> @@ -91,6 +91,7 @@ static void gfxhub_v1_0_init_gart_aperture_regs(struct amdgpu_device *adev)
>   static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
>   {
>   	uint64_t value;
> +	u32 tmp;
>   
>   	if (!amdgpu_sriov_vf(adev) || adev->asic_type <= CHIP_VEGA10) {
>   		/* Program the AGP BAR */
> @@ -134,8 +135,12 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
>   		WREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
>   			     (u32)((u64)adev->dummy_page_addr >> 44));
>   
> -		WREG32_FIELD15(GC, 0, VM_L2_PROTECTION_FAULT_CNTL2,
> -			       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +		tmp = RREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL2);
> +		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
> +					 ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
> +					 ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
> +		WREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL2, tmp);
>   	}
>   
>   	/* In the case squeezing vram into GART aperture, we don't use
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> index fbdf46070b38..ed9a64bc5aaa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> @@ -176,6 +176,8 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct amdgpu_device *adev,
>   			tmp = RREG32_SOC15(GC, GET_INST(GC, i), regVM_L2_PROTECTION_FAULT_CNTL2);
>   			tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
>   					    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +			tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
> +					    ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
>   			WREG32_SOC15(GC, GET_INST(GC, i), regVM_L2_PROTECTION_FAULT_CNTL2, tmp);
>   		}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> index 9ea593e2c719..152b2735d360 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> @@ -151,6 +151,7 @@ static void gfxhub_v2_0_init_gart_aperture_regs(struct amdgpu_device *adev)
>   static void gfxhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
>   {
>   	uint64_t value;
> +	u32 tmp;
>   
>   	if (!amdgpu_sriov_vf(adev)) {
>   		/* Program the AGP BAR */
> @@ -178,8 +179,12 @@ static void gfxhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
>   	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
>   		     (u32)((u64)adev->dummy_page_addr >> 44));
>   
> -	WREG32_FIELD15(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
> -		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> +				 ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> +				 ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
> +	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
>   }
>   
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> index 30b90d35abd0..83c2ddbbd292 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> @@ -154,6 +154,7 @@ static void gfxhub_v2_1_init_gart_aperture_regs(struct amdgpu_device *adev)
>   static void gfxhub_v2_1_init_system_aperture_regs(struct amdgpu_device *adev)
>   {
>   	uint64_t value;
> +	u32 tmp;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		return;
> @@ -182,8 +183,12 @@ static void gfxhub_v2_1_init_system_aperture_regs(struct amdgpu_device *adev)
>   	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
>   		     (u32)((u64)adev->dummy_page_addr >> 44));
>   
> -	WREG32_FIELD15(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
> -		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> +				 ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> +				 ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
> +	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
>   }
>   
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> index 9e6a6e13dec0..90bbb2fe4884 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> @@ -150,6 +150,7 @@ static void gfxhub_v3_0_init_gart_aperture_regs(struct amdgpu_device *adev)
>   static void gfxhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
>   {
>   	uint64_t value;
> +	u32 tmp;
>   
>   	/* Program the AGP BAR */
>   	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
> @@ -176,8 +177,12 @@ static void gfxhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
>   	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
>   		     (u32)((u64)adev->dummy_page_addr >> 44));
>   
> -	WREG32_FIELD15_PREREG(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
> -		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> +				 ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> +				 ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
> +	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
>   }
>   
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> index b3b1085c7cd3..1b3c067ab48c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> @@ -153,6 +153,7 @@ static void gfxhub_v3_0_3_init_gart_aperture_regs(struct amdgpu_device *adev)
>   static void gfxhub_v3_0_3_init_system_aperture_regs(struct amdgpu_device *adev)
>   {
>   	uint64_t value;
> +	u32 tmp;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		return;
> @@ -181,8 +182,12 @@ static void gfxhub_v3_0_3_init_system_aperture_regs(struct amdgpu_device *adev)
>   	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
>   		     (u32)((u64)adev->dummy_page_addr >> 44));
>   
> -	WREG32_FIELD15_PREREG(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
> -		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> +				 ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> +	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> +				 ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
> +	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
>   }
>   
>   

