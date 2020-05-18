Return-Path: <SRS0=VEb6=7A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A92C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2020 07:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0669207D8
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2020 07:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A36alXdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0669207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 678CD6E03F;
	Mon, 18 May 2020 07:31:32 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81AC46E03F
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2020 07:31:31 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id u188so9050631wmu.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2020 00:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=pYNHCvBvVLgXvoEo9239dkwiEOJwCF6nuzVmFHcI8bY=;
 b=A36alXdSUA75zvrTEk8qRg5XKxw9DMjxxoO0dBLe902oWAiIrlPvkbg7osvBgx/wkP
 Ge14Wk8ufvb9PhS3472CGQRjGUMUJiYum4Xill51SP6AlE4FPIZminsmyg8kEyoxZWsN
 O3h56+BSAW8rpImAx6ILUa6hHnk9eBzBNoPtxocCShT4c9yNAvTLBr+GipvQOwF52Sa3
 rHy2osAKaisNjl2x49sopyRAbDX9k1DC5HkORG3VL8hK2yogpVwSXbdGlTC8sxaXlbDu
 cFhOOv2dixEHQLB1l5BR0UbioPU0tOdyljBx8M2CrdfCnMTFj2Zewkaf7EHJphYXSsrO
 K8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=pYNHCvBvVLgXvoEo9239dkwiEOJwCF6nuzVmFHcI8bY=;
 b=h9dHbc5S+kvVlA8y8QApcy2qaaCHG9DctEpa6uFdpMlGLu4rVEtVzgQ0kVtmSNBOhz
 6+myUhG1R3Li96i67Ce8rsvARNiTKV1eNUWoQBwkz8BUVYeO5p+JvjXGhxwGuS1LpqIQ
 9ElemPxS/6kUAH9efNw1YagFm7Xm/ISFEKBXT0wwexYKIJNUFLUsGlah+XNspTB0xUqg
 u6/MqvV0xKKqj288fzZg9z1K79w53OEk1n1A+BG+mV/5QnWsPsgJZH37Q1guVAp3+ZqU
 /0/fR/l+4JCRhnWT8fsru1s1FLglOOXZxgpAsrjMBaM6T9EpNVA6dl8i/lAmBqXAf6iH
 Q9VQ==
X-Gm-Message-State: AOAM533DNkFgOCmKPPKZd/D1R22S6C7HipBwW5tpL9JxaVkI1Iw6o4gH
 N8z4uUoXcoQLIdUSbS0NLEs=
X-Google-Smtp-Source: ABdhPJwmPl4vDzv66f5WWG9TtETBZ5fEGf0JW6F1CbeGXJGDQyLZL3wzYm//kSn/FjPKn9VJmb0tVA==
X-Received: by 2002:a05:600c:22d3:: with SMTP id
 19mr18882182wmg.161.1589787090129; 
 Mon, 18 May 2020 00:31:30 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id b65sm16234208wmc.30.2020.05.18.00.31.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 May 2020 00:31:29 -0700 (PDT)
Subject: Re: [PATCH 3/3] drm/amdgpu: add apu flags
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200515183135.626855-1-alexander.deucher@amd.com>
 <20200515183135.626855-3-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8d61a078-4a9e-4e78-3037-6198827e69ef@gmail.com>
Date: Mon, 18 May 2020 09:31:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200515183135.626855-3-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.05.20 um 20:31 schrieb Alex Deucher:
> Add some APU flags to simplify handling of different APU
> variants.  It's easier to understand the special cases
> if we use names flags rather than checking device ids and
> silicon revisions.

Wouldn't it be easier and cleaner to add CHIP_RAVEN2 and CHIP_PICASSO 
instead?

We could keep the detection as it is and just change the asic_type in 
soc15_common_early_init().

Christian.

>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h             |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c      |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c     |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c         |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c           | 16 ++++++++--------
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c           |  5 ++---
>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c         |  2 +-
>   drivers/gpu/drm/amd/amdgpu/psp_v10_0.c          |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c          |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/soc15.c              | 17 +++++++++++++----
>   drivers/gpu/drm/amd/include/amd_shared.h        |  7 +++++++
>   .../gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c   |  3 +--
>   .../gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c |  3 ++-
>   14 files changed, 47 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 4a03a24348f4..2a73364f4da4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -738,6 +738,7 @@ struct amdgpu_device {
>   	uint32_t			rev_id;
>   	uint32_t			external_rev_id;
>   	unsigned long			flags;
> +	unsigned long			apu_flags;
>   	int				usec_timeout;
>   	const struct amdgpu_asic_funcs	*asic_funcs;
>   	bool				shutdown;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a3a58e9f9e9c..d81b79f9b009 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1567,9 +1567,9 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
>   		chip_name = "vega12";
>   		break;
>   	case CHIP_RAVEN:
> -		if (adev->rev_id >= 8)
> +		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
>   			chip_name = "raven2";
> -		else if (adev->pdev->device == 0x15d8)
> +		else if (adev->apu_flags & AMD_APU_IS_PICASSO)
>   			chip_name = "picasso";
>   		else
>   			chip_name = "raven";
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 84cee27cd7ef..f7143d927b6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -523,7 +523,8 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
>   			break;
>   		case CHIP_RAVEN:
>   			/* enable S/G on PCO and RV2 */
> -			if (adev->rev_id >= 0x8 || adev->pdev->device == 0x15d8)
> +			if ((adev->apu_flags & AMD_APU_IS_RAVEN2) ||
> +			    (adev->apu_flags & AMD_APU_IS_PICASSO))
>   				domain |= AMDGPU_GEM_DOMAIN_GTT;
>   			break;
>   		default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 2de99b441601..2badbc0355f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -70,9 +70,9 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>   
>   	switch (adev->asic_type) {
>   	case CHIP_RAVEN:
> -		if (adev->rev_id >= 8)
> +		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
>   			fw_name = FIRMWARE_RAVEN2;
> -		else if (adev->pdev->device == 0x15d8)
> +		else if (adev->apu_flags & AMD_APU_IS_PICASSO)
>   			fw_name = FIRMWARE_PICASSO;
>   		else
>   			fw_name = FIRMWARE_RAVEN;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 1573ac1f03b2..711e9dd19705 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -959,7 +959,7 @@ static void gfx_v9_0_init_golden_registers(struct amdgpu_device *adev)
>   	case CHIP_RAVEN:
>   		soc15_program_register_sequence(adev, golden_settings_gc_9_1,
>   						ARRAY_SIZE(golden_settings_gc_9_1));
> -		if (adev->rev_id >= 8)
> +		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
>   			soc15_program_register_sequence(adev,
>   							golden_settings_gc_9_1_rv2,
>   							ARRAY_SIZE(golden_settings_gc_9_1_rv2));
> @@ -1274,7 +1274,8 @@ static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
>   	case CHIP_VEGA20:
>   		break;
>   	case CHIP_RAVEN:
> -		if (!(adev->rev_id >= 0x8 || adev->pdev->device == 0x15d8) &&
> +		if (!((adev->apu_flags & AMD_APU_IS_RAVEN2) ||
> +		      (adev->apu_flags & AMD_APU_IS_PICASSO)) &&
>   		    ((!is_raven_kicker(adev) &&
>   		      adev->gfx.rlc_fw_version < 531) ||
>   		     (adev->gfx.rlc_feature_version < 1) ||
> @@ -1617,9 +1618,9 @@ static int gfx_v9_0_init_microcode(struct amdgpu_device *adev)
>   		chip_name = "vega20";
>   		break;
>   	case CHIP_RAVEN:
> -		if (adev->rev_id >= 8)
> +		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
>   			chip_name = "raven2";
> -		else if (adev->pdev->device == 0x15d8)
> +		else if (adev->apu_flags & AMD_APU_IS_PICASSO)
>   			chip_name = "picasso";
>   		else
>   			chip_name = "raven";
> @@ -2119,7 +2120,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
>   		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
>   		adev->gfx.config.sc_hiz_tile_fifo_size = 0x30;
>   		adev->gfx.config.sc_earlyz_tile_fifo_size = 0x4C0;
> -		if (adev->rev_id >= 8)
> +		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
>   			gb_addr_config = RAVEN2_GB_ADDR_CONFIG_GOLDEN;
>   		else
>   			gb_addr_config = RAVEN_GB_ADDR_CONFIG_GOLDEN;
> @@ -2968,8 +2969,7 @@ static void gfx_v9_0_init_pg(struct amdgpu_device *adev)
>   	 */
>   	if (adev->gfx.rlc.is_rlc_v2_1) {
>   		if (adev->asic_type == CHIP_VEGA12 ||
> -		    (adev->asic_type == CHIP_RAVEN &&
> -		     adev->rev_id >= 8))
> +		    (adev->apu_flags & AMD_APU_IS_RAVEN2))
>   			gfx_v9_1_init_rlc_save_restore_list(adev);
>   		gfx_v9_0_enable_save_restore_machine(adev);
>   	}
> @@ -6881,7 +6881,7 @@ static void gfx_v9_0_set_gds_init(struct amdgpu_device *adev)
>   		adev->gds.gds_compute_max_wave_id = 0x27f;
>   		break;
>   	case CHIP_RAVEN:
> -		if (adev->rev_id >= 0x8)
> +		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
>   			adev->gds.gds_compute_max_wave_id = 0x77; /* raven2 */
>   		else
>   			adev->gds.gds_compute_max_wave_id = 0x15f; /* raven1 */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> index 1a2f18b908fe..6682b843bafe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> @@ -80,7 +80,7 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
>   		WREG32_SOC15_RLC(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR,
>   			min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
>   
> -		if (adev->asic_type == CHIP_RAVEN && adev->rev_id >= 0x8)
> +		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
>   			/*
>   			* Raven2 has a HW issue that it is unable to use the
>   			* vram which is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR.
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 055ecba754ff..11e93a82131d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -441,9 +441,8 @@ static bool gmc_v9_0_use_invalidate_semaphore(struct amdgpu_device *adev,
>   	return ((vmhub == AMDGPU_MMHUB_0 ||
>   		 vmhub == AMDGPU_MMHUB_1) &&
>   		(!amdgpu_sriov_vf(adev)) &&
> -		(!(adev->asic_type == CHIP_RAVEN &&
> -		   adev->rev_id < 0x8 &&
> -		   adev->pdev->device == 0x15d8)));
> +		(!(!(adev->apu_flags & AMD_APU_IS_RAVEN2) &&
> +		   (adev->apu_flags & AMD_APU_IS_PICASSO))));
>   }
>   
>   static bool gmc_v9_0_get_atc_vmid_pasid_mapping_info(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> index bd2d2b8d1f42..405767208a4d 100755
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> @@ -96,7 +96,7 @@ static void mmhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
>   	WREG32_SOC15(MMHUB, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR,
>   		     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
>   
> -	if (adev->asic_type == CHIP_RAVEN && adev->rev_id >= 0x8)
> +	if (adev->apu_flags & AMD_APU_IS_RAVEN2)
>   		/*
>   		 * Raven2 has a HW issue that it is unable to use the vram which
>   		 * is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR. So here is the
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> index 90727cfb4447..d7f92634eba2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> @@ -55,9 +55,9 @@ static int psp_v10_0_init_microcode(struct psp_context *psp)
>   
>   	switch (adev->asic_type) {
>   	case CHIP_RAVEN:
> -		if (adev->rev_id >= 0x8)
> +		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
>   			chip_name = "raven2";
> -		else if (adev->pdev->device == 0x15d8)
> +		else if (adev->apu_flags & AMD_APU_IS_PICASSO)
>   			chip_name = "picasso";
>   		else
>   			chip_name = "raven";
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 12a77b31fad2..9077507b425a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -486,7 +486,7 @@ static void sdma_v4_0_init_golden_registers(struct amdgpu_device *adev)
>   		soc15_program_register_sequence(adev,
>   						golden_settings_sdma_4_1,
>   						ARRAY_SIZE(golden_settings_sdma_4_1));
> -		if (adev->rev_id >= 8)
> +		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
>   			soc15_program_register_sequence(adev,
>   							golden_settings_sdma_rv2,
>   							ARRAY_SIZE(golden_settings_sdma_rv2));
> @@ -575,9 +575,9 @@ static int sdma_v4_0_init_microcode(struct amdgpu_device *adev)
>   		chip_name = "vega20";
>   		break;
>   	case CHIP_RAVEN:
> -		if (adev->rev_id >= 8)
> +		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
>   			chip_name = "raven2";
> -		else if (adev->pdev->device == 0x15d8)
> +		else if (adev->apu_flags & AMD_APU_IS_PICASSO)
>   			chip_name = "picasso";
>   		else
>   			chip_name = "raven";
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 58a440a15525..c7c9e07962b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -564,7 +564,8 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
>   static int soc15_asic_reset(struct amdgpu_device *adev)
>   {
>   	/* original raven doesn't have full asic reset */
> -	if (adev->pdev->device == 0x15dd && adev->rev_id < 0x8)
> +	if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
> +	    !(adev->apu_flags & AMD_APU_IS_RAVEN2))
>   		return 0;
>   
>   	switch (soc15_asic_reset_method(adev)) {
> @@ -1129,16 +1130,23 @@ static int soc15_common_early_init(void *handle)
>   		break;
>   	case CHIP_RAVEN:
>   		adev->asic_funcs = &soc15_asic_funcs;
> +		if (adev->pdev->device == 0x15dd)
> +			adev->apu_flags |= AMD_APU_IS_RAVEN;
> +		if (adev->pdev->device == 0x15d8)
> +			adev->apu_flags |= AMD_APU_IS_PICASSO;
>   		if (adev->rev_id >= 0x8)
> +			adev->apu_flags |= AMD_APU_IS_RAVEN2;
> +
> +		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
>   			adev->external_rev_id = adev->rev_id + 0x79;
> -		else if (adev->pdev->device == 0x15d8)
> +		else if (adev->apu_flags & AMD_APU_IS_PICASSO)
>   			adev->external_rev_id = adev->rev_id + 0x41;
>   		else if (adev->rev_id == 1)
>   			adev->external_rev_id = adev->rev_id + 0x20;
>   		else
>   			adev->external_rev_id = adev->rev_id + 0x01;
>   
> -		if (adev->rev_id >= 0x8) {
> +		if (adev->apu_flags & AMD_APU_IS_RAVEN2) {
>   			adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
>   				AMD_CG_SUPPORT_GFX_MGLS |
>   				AMD_CG_SUPPORT_GFX_CP_LS |
> @@ -1156,7 +1164,7 @@ static int soc15_common_early_init(void *handle)
>   				AMD_CG_SUPPORT_VCN_MGCG;
>   
>   			adev->pg_flags = AMD_PG_SUPPORT_SDMA | AMD_PG_SUPPORT_VCN;
> -		} else if (adev->pdev->device == 0x15d8) {
> +		} else if (adev->apu_flags & AMD_APU_IS_PICASSO) {
>   			adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
>   				AMD_CG_SUPPORT_GFX_MGLS |
>   				AMD_CG_SUPPORT_GFX_CP_LS |
> @@ -1222,6 +1230,7 @@ static int soc15_common_early_init(void *handle)
>   		break;
>   	case CHIP_RENOIR:
>   		adev->asic_funcs = &soc15_asic_funcs;
> +		adev->apu_flags |= AMD_APU_IS_RENOIR;
>   		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
>   				 AMD_CG_SUPPORT_GFX_MGLS |
>   				 AMD_CG_SUPPORT_GFX_3D_CGCG |
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index d655a76bedc6..258e41890a15 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -40,6 +40,13 @@ enum amd_chip_flags {
>   	AMD_EXP_HW_SUPPORT = 0x00080000UL,
>   };
>   
> +enum amd_apu_flags {
> +	AMD_APU_IS_RAVEN = 0x00000001UL,
> +	AMD_APU_IS_RAVEN2 = 0x00000002UL,
> +	AMD_APU_IS_PICASSO = 0x00000004UL,
> +	AMD_APU_IS_RENOIR = 0x00000008UL,
> +};
> +
>   enum amd_ip_block_type {
>   	AMD_IP_BLOCK_TYPE_COMMON,
>   	AMD_IP_BLOCK_TYPE_GMC,
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> index 4f8c1b85e688..246bb9ac557d 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1304,8 +1304,7 @@ static int smu10_get_power_profile_mode(struct pp_hwmgr *hwmgr, char *buf)
>   static bool smu10_is_raven1_refresh(struct pp_hwmgr *hwmgr)
>   {
>   	struct amdgpu_device *adev = hwmgr->adev;
> -	if ((adev->asic_type == CHIP_RAVEN) &&
> -	    (adev->rev_id != 0x15d8) &&
> +	if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
>   	    (hwmgr->smu_version >= 0x41e2b))
>   		return true;
>   	else
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
> index 801ba9ca6094..ea2279bb8cbf 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
> @@ -226,7 +226,8 @@ static int smu10_start_smu(struct pp_hwmgr *hwmgr)
>   	smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetSmuVersion, &hwmgr->smu_version);
>   	adev->pm.fw_version = hwmgr->smu_version >> 8;
>   
> -	if (adev->rev_id < 0x8 && adev->pdev->device != 0x15d8 &&
> +	if (!(adev->apu_flags & AMD_APU_IS_RAVEN2) &&
> +	    (adev->apu_flags & AMD_APU_IS_RAVEN) &&
>   	    adev->pm.fw_version < 0x1e45)
>   		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
