Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820B1CD4F49
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Sep 2023 10:08:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E74910E647;
	Fri, 22 Sep 2023 10:08:21 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 907DB10E647
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Sep 2023 10:08:18 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31fe2c8db0dso1710189f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Sep 2023 03:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695377297; x=1695982097; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dkAMFxewOWn6NW9oqRVsKtegLWOte/ZGcoljHOVz9OQ=;
 b=gnDbJCBvWR/5avXdd0Lm0IB9I573gcXwuo4BIEkfSYASInFu0/G1SYySRlc8RbEZMI
 YGZ5RuakPSCmykLhZslPL8UbluL9Nlljg8B3hUXLT20kENApbekqhdzbLgCCsV+pJwaU
 Lsn5+6xV9BO6jx2samgKOOEU+6kz+uIbjcJjNiajGJIJ/LfKSyBNV9c4oi5WPUWg+C1L
 OD56NyEfxU3fHacW+UwPHla3UNm99In9NCU0EEZFDXOOxenZ5VNPxniCJKvXTZl+6jZ+
 JKAUhXMnC4MkebJsyCVz6aZd/izUSZAlXl4RK10yEV2WvF8PPL7Y1b8LyIua9bl6dSSn
 zd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695377297; x=1695982097;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dkAMFxewOWn6NW9oqRVsKtegLWOte/ZGcoljHOVz9OQ=;
 b=dvq1Y9AMhMrzejiGEmhrX+QAiJVR10WjC5r3YWDhXt7m+tjcpMVdSNqO2L2uO+O8K5
 C4cABAMOKsjVW6LFdMO00nVSw6K5SuLMwtge033Cg1myIEIY3yPenvZ9VzTztzSQoOZO
 xteIaOzPuJToyN42mei4DMJV8/Vag9y50VoO5iTdN22KnNjSDQz3qM15sIIURTEDfkWv
 8ZoHKQBohugq+7J8i/3VT02eh0Y4CKqxUu2lb1gULNhKvyDWRbqRSJ8HzIXyHP1Mwceo
 F176EiEY0tz6oOnMwQM3xeidaNSlTXSHWZwNo4ocbjGnsXmSw8KQYumOsv5wOeP63TAv
 /RsA==
X-Gm-Message-State: AOJu0YxJYxMBmxnmB7Va3pB5u93gO1TNzbLspSGKaKMWCDDE79v8nSUb
 BTh3zpFmtUmFlsDFb927y6Q=
X-Google-Smtp-Source: AGHT+IFibNCxEqpj10LyJq+urkzO4JNLVKAnfKRzye8SblO51QmgQcwi+hWJJKTC54WbIe/PM0laIQ==
X-Received: by 2002:adf:f407:0:b0:317:6849:2d39 with SMTP id
 g7-20020adff407000000b0031768492d39mr7045924wro.10.1695377296732; 
 Fri, 22 Sep 2023 03:08:16 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 a8-20020a056000100800b003197efd1e7bsm4010346wrx.114.2023.09.22.03.08.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 03:08:16 -0700 (PDT)
Message-ID: <ffde15c9-f2a2-6998-b421-ae60a1613da1@gmail.com>
Date: Fri, 22 Sep 2023 12:08:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/3] drm/amdgpu/gmc: set a default disable value for AGP
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230921141300.415876-1-alexander.deucher@amd.com>
 <20230921141300.415876-2-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230921141300.415876-2-alexander.deucher@amd.com>
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

Am 21.09.23 um 16:12 schrieb Alex Deucher:
> To disable AGP, the start needs to be set to a higher
> value than the end.  Set a default disable value for
> the AGP aperture and allow the IP specific GMC code
> to enable it selectively be calling amdgpu_gmc_agp_location().
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       | 27 +++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  3 +++
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |  4 +--
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  4 +--
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  4 +--
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  3 ++-
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
>   10 files changed, 37 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index c7793db6d098..d0653f5ba8a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -315,14 +315,6 @@ void amdgpu_gmc_agp_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
>   	const uint64_t sixteen_gb_mask = ~(sixteen_gb - 1);
>   	u64 size_af, size_bf;
>   
> -	if (amdgpu_sriov_vf(adev)) {
> -		mc->agp_start = 0xffffffffffff;
> -		mc->agp_end = 0x0;
> -		mc->agp_size = 0;
> -
> -		return;
> -	}
> -
>   	if (mc->fb_start > mc->gart_start) {
>   		size_bf = (mc->fb_start & sixteen_gb_mask) -
>   			ALIGN(mc->gart_end + 1, sixteen_gb);
> @@ -346,6 +338,25 @@ void amdgpu_gmc_agp_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
>   			mc->agp_size >> 20, mc->agp_start, mc->agp_end);
>   }
>   
> +/**
> + * amdgpu_gmc_set_agp_default - Set the default AGP aperture value.
> + * @adev: amdgpu device structure holding all necessary information
> + * @mc: memory controller structure holding memory information
> + *
> + * To disable the AGP aperture, you need to set the start to a larger
> + * value than the end.  This function sets the default value which
> + * can then be overridden using amdgpu_gmc_agp_location() if you want
> + * to enable the AGP aperture on a specific chip.
> + *
> + */
> +void amdgpu_gmc_set_agp_default(struct amdgpu_device *adev,
> +				struct amdgpu_gmc *mc)
> +{
> +	mc->agp_start = 0xffffffffffff;
> +	mc->agp_end = 0;
> +	mc->agp_size = 0;
> +}
> +
>   /**
>    * amdgpu_gmc_fault_key - get hask key from vm fault address and pasid
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index fdc25cd559b6..49a28379fc79 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -392,6 +392,8 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev,
>   			      struct amdgpu_gmc *mc);
>   void amdgpu_gmc_agp_location(struct amdgpu_device *adev,
>   			     struct amdgpu_gmc *mc);
> +void amdgpu_gmc_set_agp_default(struct amdgpu_device *adev,
> +				struct amdgpu_gmc *mc);
>   bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev,
>   			      struct amdgpu_ih_ring *ih, uint64_t addr,
>   			      uint16_t pasid, uint64_t timestamp);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index cef920a93924..0dcb6c36b02c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1062,6 +1062,9 @@ static const char * const amdgpu_vram_names[] = {
>    */
>   int amdgpu_bo_init(struct amdgpu_device *adev)
>   {
> +	/* set the default AGP aperture state */
> +	amdgpu_gmc_set_agp_default(adev, &adev->gmc);
> +
>   	/* On A+A platform, VRAM can be mapped as WB */
>   	if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu) {
>   		/* reserve PAT memory space to WC for VRAM */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index e582073b57c8..e6f76cd19c94 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -780,7 +780,8 @@ static void gmc_v10_0_vram_gtt_location(struct amdgpu_device *adev,
>   
>   	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
>   	amdgpu_gmc_gart_location(adev, mc);
> -	amdgpu_gmc_agp_location(adev, mc);
> +	if (!amdgpu_sriov_vf(adev))
> +		amdgpu_gmc_agp_location(adev, mc);
>   
>   	/* base offset of vram pages */
>   	adev->vm_manager.vram_base_offset = adev->gfxhub.funcs->get_mc_fb_offset(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 69f65e9c4f93..0bd7de1488f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -689,7 +689,8 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_device *adev,
>   
>   	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
>   	amdgpu_gmc_gart_location(adev, mc);
> -	amdgpu_gmc_agp_location(adev, mc);
> +	if (!amdgpu_sriov_vf(adev))
> +		amdgpu_gmc_agp_location(adev, mc);
>   
>   	/* base offset of vram pages */
>   	if (amdgpu_sriov_vf(adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 07579fa26fa3..3f31f268e0eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -253,8 +253,8 @@ static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
>   	WREG32(mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR,
>   	       adev->mem_scratch.gpu_addr >> 12);
>   	WREG32(mmMC_VM_AGP_BASE, 0);
> -	WREG32(mmMC_VM_AGP_TOP, 0);
> -	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
> +	WREG32(mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 22);
> +	WREG32(mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 22);
>   
>   	if (gmc_v6_0_wait_for_idle((void *)adev))
>   		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index e77e5593e1ab..e5e64366a814 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -288,8 +288,8 @@ static void gmc_v7_0_mc_program(struct amdgpu_device *adev)
>   	WREG32(mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR,
>   	       adev->mem_scratch.gpu_addr >> 12);
>   	WREG32(mmMC_VM_AGP_BASE, 0);
> -	WREG32(mmMC_VM_AGP_TOP, 0);
> -	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
> +	WREG32(mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 22);
> +	WREG32(mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 22);
>   	if (gmc_v7_0_wait_for_idle((void *)adev))
>   		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 6acf649469dd..4be407bbb7c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -473,8 +473,8 @@ static void gmc_v8_0_mc_program(struct amdgpu_device *adev)
>   	}
>   
>   	WREG32(mmMC_VM_AGP_BASE, 0);
> -	WREG32(mmMC_VM_AGP_TOP, 0);
> -	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
> +	WREG32(mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 22);
> +	WREG32(mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 22);
>   	if (gmc_v8_0_wait_for_idle((void *)adev))
>   		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 2936a0fb7527..e5588408f4a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1696,7 +1696,8 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
>   	} else {
>   		amdgpu_gmc_vram_location(adev, mc, base);
>   		amdgpu_gmc_gart_location(adev, mc);
> -		amdgpu_gmc_agp_location(adev, mc);
> +		if (!amdgpu_sriov_vf(adev))
> +			amdgpu_gmc_agp_location(adev, mc);
>   	}
>   	/* base offset of vram pages */
>   	adev->vm_manager.vram_base_offset = adev->gfxhub.funcs->get_mc_fb_offset(adev);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 2e4a8bdbf50e..c2cb4b4cd2d7 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1255,7 +1255,7 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
>   	agp_top = adev->gmc.agp_end >> 24;
>   
>   	/* AGP aperture is disabled */
> -	if (agp_bot == agp_top) {
> +	if (agp_bot > agp_top) {
>   		logical_addr_low = adev->gmc.fb_start >> 18;
>   		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
>   			/*

