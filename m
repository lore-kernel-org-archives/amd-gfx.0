Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2250FC0032E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Oct 2023 05:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27C9210E555;
	Wed, 25 Oct 2023 05:41:06 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EA5410E554
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 05:41:03 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4079ed65582so41026685e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 22:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698212462; x=1698817262; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vXLTO3T1hgxjJvT7VtITOUmq9R5jiEkU3T3D06zKQAU=;
 b=ivTRjoms6bTc/1AWHOcwo4vR9SjIM0JvHnwx+0Ant3MItE9QXcUrTI2K8VgYJ8fqFp
 l2XEezPKyq2jMiUFHKKofw4mt6T5UvB9X2JDQSyYr32F2s4qtXxEc2q1V064HQMnmPyk
 1cASsR6wDE0SIpLW3RpgqjZF8YBPF9JRrOukFwcjTWz+t/Tu914xI5cruR2uD53XokDX
 QJIZz/UxSFLn+GJ0GLBhDN7sYxEQklhVuk81SRVxyggxm0MXJ8sK2r45MrQCJLnhXOYK
 Yj0ZKSOr8AZ08RzgdsZgXfOZw/VZC460BnF4TzpvDp0YFoTjEGmdN1RLufCwN38X6Cs+
 Ikdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698212462; x=1698817262;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vXLTO3T1hgxjJvT7VtITOUmq9R5jiEkU3T3D06zKQAU=;
 b=ubXBkO3i5Vp+Ng+0KW9KmMvLXuWa6MlwPttvfXYC1/XnPguQxclRTc6aWGRgkx+aVI
 FPtTPhdqmakzf6yR6LGNctHC0nWZakOQXXBVQWkSp3fpvzKJAvI16QIwPoiqdwZZlLDB
 m67NCJXYr2P1ypAIUf7xFwF6bqAECVgPvH9TaISqWcf1fBBPMaH0B27paSmmUNk7di0a
 bXWBoj9VL6Nx1TIJyvkS/9aWb8/7sZozZLIbpFh5V0pDvnaVszLeRpefH9wMc0AcyFwa
 afW12NmQKFx16loWdx2+udIg3RSsAxhomavy9r8QvsapjSwbJyOM6P5UutJuHaAEofAI
 TBag==
X-Gm-Message-State: AOJu0YwGjJ7ix10iWsMzDJJz5q7jPdhexuaCwh6Cw9W0MJz+EcWP/U5e
 R7yRPYXgmiTGvjtEVISYT8w=
X-Google-Smtp-Source: AGHT+IGLsJvzHvb8kw3vQMmJNhiXR5Y57DsAEsiVCU1WkwzQG0mgYW9huVUcBWdUcxrrGvNeSTAeYA==
X-Received: by 2002:a05:600c:19d1:b0:405:3955:5881 with SMTP id
 u17-20020a05600c19d100b0040539555881mr10755123wmq.36.1698212461376; 
 Tue, 24 Oct 2023 22:41:01 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 o30-20020a05600c511e00b004063cd8105csm18527233wms.22.2023.10.24.22.40.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 22:41:00 -0700 (PDT)
Message-ID: <9b890c6d-3f75-4f7f-9e7d-fd99d7fb8942@gmail.com>
Date: Wed, 25 Oct 2023 07:40:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: move buffer funcs setting up a level (v2)
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher <alexdeucher@gmail.com>
References: <dd6969ae-8ba9-43c2-bc50-11277613b27a@amd.com>
 <20231025042403.10222-1-luben.tuikov@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231025042403.10222-1-luben.tuikov@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.10.23 um 06:24 schrieb Luben Tuikov:
> From: Alex Deucher <alexander.deucher@amd.com>
>
> Rather than doing this in the IP code for the SDMA paging
> engine, move it up to the core device level init level.
> This should fix the scheduler init ordering.
>
> v2: Fix checkpatch parens complaint; long lines. (Luben)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Tested-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c   | 21 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h   |  1 +
>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c      |  5 -----
>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c     |  5 -----
>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     |  5 -----
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     | 16 +---------------
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     | 10 +---------
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c     | 10 +---------
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c     | 10 +---------
>   drivers/gpu/drm/amd/amdgpu/si_dma.c        |  5 -----
>   11 files changed, 38 insertions(+), 62 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7ec32b44df052f..47c1e60109c14c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2662,6 +2662,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>   	if (r)
>   		goto init_failed;
>   
> +	amdgpu_sdma_set_buffer_funcs_helper(adev);
> +
>   	/* Don't init kfd if whole hive need to be reset during init */
>   	if (!adev->gmc.xgmi.pending_reset) {
>   		kgd2kfd_init_zone_device(adev);
> @@ -3260,6 +3262,8 @@ int amdgpu_device_ip_suspend(struct amdgpu_device *adev)
>   		amdgpu_virt_request_full_gpu(adev, false);
>   	}
>   
> +	amdgpu_sdma_unset_buffer_funcs_helper(adev);
> +
>   	r = amdgpu_device_ip_suspend_phase1(adev);
>   	if (r)
>   		return r;
> @@ -3449,6 +3453,8 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
>   
>   	r = amdgpu_device_ip_resume_phase2(adev);
>   
> +	amdgpu_sdma_set_buffer_funcs_helper(adev);
> +
>   	return r;
>   }
>   
> @@ -4236,6 +4242,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   	/* disable ras feature must before hw fini */
>   	amdgpu_ras_pre_fini(adev);
>   
> +	amdgpu_sdma_unset_buffer_funcs_helper(adev);
> +
>   	amdgpu_device_ip_fini_early(adev);
>   
>   	amdgpu_irq_fini_hw(adev);
> @@ -4407,6 +4415,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>   
>   	amdgpu_ras_suspend(adev);
>   
> +	amdgpu_sdma_unset_buffer_funcs_helper(adev);
> +
>   	amdgpu_device_ip_suspend_phase1(adev);
>   
>   	if (!adev->in_s0ix)
> @@ -5178,6 +5188,8 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   				if (r)
>   					goto out;
>   
> +				amdgpu_sdma_set_buffer_funcs_helper(tmp_adev);
> +
>   				if (vram_lost)
>   					amdgpu_device_fill_reset_magic(tmp_adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index e8cbc4142d8021..c4d642b06f3c5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -292,6 +292,27 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
>   	return err;
>   }
>   
> +void amdgpu_sdma_set_buffer_funcs_helper(struct amdgpu_device *adev)

 From the functionality and general idea that looks good to me.

But I think both the amdgpu_sdma_set_buffer_funcs_helper() as well the 
existing amdgpu_sdma_unset_buffer_funcs_helper() are just an unnecessary 
extra check when they are not used by the SDMA code.

I think we should just call amdgpu_ttm_set_buffer_funcs_status() 
directly instead.

Regards,
Christian.

> +{
> +	struct amdgpu_ring *sdma;
> +	int i;
> +
> +	for (i = 0; i < adev->sdma.num_instances; i++) {
> +		if (adev->sdma.has_page_queue) {
> +			sdma = &adev->sdma.instance[i].page;
> +			if (adev->mman.buffer_funcs_ring == sdma && sdma->sched.ready) {
> +				amdgpu_ttm_set_buffer_funcs_status(adev, true);
> +				break;
> +			}
> +		}
> +		sdma = &adev->sdma.instance[i].ring;
> +		if (adev->mman.buffer_funcs_ring == sdma && sdma->sched.ready) {
> +			amdgpu_ttm_set_buffer_funcs_status(adev, true);
> +			break;
> +		}
> +	}
> +}
> +
>   void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ring *sdma;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 513ac22120c1fa..33209593e97461 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -169,6 +169,7 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev, u32 instance,
>   			       bool duplicate);
>   void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
>           bool duplicate);
> +void amdgpu_sdma_set_buffer_funcs_helper(struct amdgpu_device *adev);
>   void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_device *adev);
>   int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> index ee5dce6f604369..a3fccc4c1f4375 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> @@ -308,8 +308,6 @@ static void cik_sdma_gfx_stop(struct amdgpu_device *adev)
>   	u32 rb_cntl;
>   	int i;
>   
> -	amdgpu_sdma_unset_buffer_funcs_helper(adev);
> -
>   	for (i = 0; i < adev->sdma.num_instances; i++) {
>   		rb_cntl = RREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i]);
>   		rb_cntl &= ~SDMA0_GFX_RB_CNTL__RB_ENABLE_MASK;
> @@ -498,9 +496,6 @@ static int cik_sdma_gfx_resume(struct amdgpu_device *adev)
>   		r = amdgpu_ring_test_helper(ring);
>   		if (r)
>   			return r;
> -
> -		if (adev->mman.buffer_funcs_ring == ring)
> -			amdgpu_ttm_set_buffer_funcs_status(adev, true);
>   	}
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> index b58a13bd75db8f..45377a1752503b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -339,8 +339,6 @@ static void sdma_v2_4_gfx_stop(struct amdgpu_device *adev)
>   	u32 rb_cntl, ib_cntl;
>   	int i;
>   
> -	amdgpu_sdma_unset_buffer_funcs_helper(adev);
> -
>   	for (i = 0; i < adev->sdma.num_instances; i++) {
>   		rb_cntl = RREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i]);
>   		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
> @@ -474,9 +472,6 @@ static int sdma_v2_4_gfx_resume(struct amdgpu_device *adev)
>   		r = amdgpu_ring_test_helper(ring);
>   		if (r)
>   			return r;
> -
> -		if (adev->mman.buffer_funcs_ring == ring)
> -			amdgpu_ttm_set_buffer_funcs_status(adev, true);
>   	}
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> index c5ea32687eb5e8..2ad615be4bb3d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -513,8 +513,6 @@ static void sdma_v3_0_gfx_stop(struct amdgpu_device *adev)
>   	u32 rb_cntl, ib_cntl;
>   	int i;
>   
> -	amdgpu_sdma_unset_buffer_funcs_helper(adev);
> -
>   	for (i = 0; i < adev->sdma.num_instances; i++) {
>   		rb_cntl = RREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i]);
>   		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
> @@ -746,9 +744,6 @@ static int sdma_v3_0_gfx_resume(struct amdgpu_device *adev)
>   		r = amdgpu_ring_test_helper(ring);
>   		if (r)
>   			return r;
> -
> -		if (adev->mman.buffer_funcs_ring == ring)
> -			amdgpu_ttm_set_buffer_funcs_status(adev, true);
>   	}
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 683d51ae4bf10c..3d68dd5523c65a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -877,8 +877,6 @@ static void sdma_v4_0_gfx_enable(struct amdgpu_device *adev, bool enable)
>   	u32 rb_cntl, ib_cntl;
>   	int i;
>   
> -	amdgpu_sdma_unset_buffer_funcs_helper(adev);
> -
>   	for (i = 0; i < adev->sdma.num_instances; i++) {
>   		rb_cntl = RREG32_SDMA(i, mmSDMA0_GFX_RB_CNTL);
>   		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, enable ? 1 : 0);
> @@ -913,8 +911,6 @@ static void sdma_v4_0_page_stop(struct amdgpu_device *adev)
>   	u32 rb_cntl, ib_cntl;
>   	int i;
>   
> -	amdgpu_sdma_unset_buffer_funcs_helper(adev);
> -
>   	for (i = 0; i < adev->sdma.num_instances; i++) {
>   		rb_cntl = RREG32_SDMA(i, mmSDMA0_PAGE_RB_CNTL);
>   		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_PAGE_RB_CNTL,
> @@ -1402,13 +1398,7 @@ static int sdma_v4_0_start(struct amdgpu_device *adev)
>   			r = amdgpu_ring_test_helper(page);
>   			if (r)
>   				return r;
> -
> -			if (adev->mman.buffer_funcs_ring == page)
> -				amdgpu_ttm_set_buffer_funcs_status(adev, true);
>   		}
> -
> -		if (adev->mman.buffer_funcs_ring == ring)
> -			amdgpu_ttm_set_buffer_funcs_status(adev, true);
>   	}
>   
>   	return r;
> @@ -1921,11 +1911,8 @@ static int sdma_v4_0_hw_fini(void *handle)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	int i;
>   
> -	if (amdgpu_sriov_vf(adev)) {
> -		/* disable the scheduler for SDMA */
> -		amdgpu_sdma_unset_buffer_funcs_helper(adev);
> +	if (amdgpu_sriov_vf(adev))
>   		return 0;
> -	}
>   
>   	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
>   		for (i = 0; i < adev->sdma.num_instances; i++) {
> @@ -1964,7 +1951,6 @@ static int sdma_v4_0_resume(void *handle)
>   	if (adev->in_s0ix) {
>   		sdma_v4_0_enable(adev, true);
>   		sdma_v4_0_gfx_enable(adev, true);
> -		amdgpu_ttm_set_buffer_funcs_status(adev, true);
>   		return 0;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index c1ff5eda89619f..3c485e5a531a0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -559,8 +559,6 @@ static void sdma_v5_0_gfx_stop(struct amdgpu_device *adev)
>   	u32 rb_cntl, ib_cntl;
>   	int i;
>   
> -	amdgpu_sdma_unset_buffer_funcs_helper(adev);
> -
>   	for (i = 0; i < adev->sdma.num_instances; i++) {
>   		rb_cntl = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
>   		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
> @@ -825,9 +823,6 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
>   		r = amdgpu_ring_test_helper(ring);
>   		if (r)
>   			return r;
> -
> -		if (adev->mman.buffer_funcs_ring == ring)
> -			amdgpu_ttm_set_buffer_funcs_status(adev, true);
>   	}
>   
>   	return 0;
> @@ -1426,11 +1421,8 @@ static int sdma_v5_0_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	if (amdgpu_sriov_vf(adev)) {
> -		/* disable the scheduler for SDMA */
> -		amdgpu_sdma_unset_buffer_funcs_helper(adev);
> +	if (amdgpu_sriov_vf(adev))
>   		return 0;
> -	}
>   
>   	sdma_v5_0_ctx_switch_enable(adev, false);
>   	sdma_v5_0_enable(adev, false);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 7d1e57189c8c69..83c240f741b519 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -364,8 +364,6 @@ static void sdma_v5_2_gfx_stop(struct amdgpu_device *adev)
>   	u32 rb_cntl, ib_cntl;
>   	int i;
>   
> -	amdgpu_sdma_unset_buffer_funcs_helper(adev);
> -
>   	for (i = 0; i < adev->sdma.num_instances; i++) {
>   		rb_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
>   		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
> @@ -625,9 +623,6 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
>   		r = amdgpu_ring_test_helper(ring);
>   		if (r)
>   			return r;
> -
> -		if (adev->mman.buffer_funcs_ring == ring)
> -			amdgpu_ttm_set_buffer_funcs_status(adev, true);
>   	}
>   
>   	return 0;
> @@ -1284,11 +1279,8 @@ static int sdma_v5_2_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	if (amdgpu_sriov_vf(adev)) {
> -		/* disable the scheduler for SDMA */
> -		amdgpu_sdma_unset_buffer_funcs_helper(adev);
> +	if (amdgpu_sriov_vf(adev))
>   		return 0;
> -	}
>   
>   	sdma_v5_2_ctx_switch_enable(adev, false);
>   	sdma_v5_2_enable(adev, false);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 7e4d5188cbfa85..3c7ddd219de850 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -348,8 +348,6 @@ static void sdma_v6_0_gfx_stop(struct amdgpu_device *adev)
>   	u32 rb_cntl, ib_cntl;
>   	int i;
>   
> -	amdgpu_sdma_unset_buffer_funcs_helper(adev);
> -
>   	for (i = 0; i < adev->sdma.num_instances; i++) {
>   		rb_cntl = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL));
>   		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_ENABLE, 0);
> @@ -561,9 +559,6 @@ static int sdma_v6_0_gfx_resume(struct amdgpu_device *adev)
>   		r = amdgpu_ring_test_helper(ring);
>   		if (r)
>   			return r;
> -
> -		if (adev->mman.buffer_funcs_ring == ring)
> -			amdgpu_ttm_set_buffer_funcs_status(adev, true);
>   	}
>   
>   	return 0;
> @@ -1308,11 +1303,8 @@ static int sdma_v6_0_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	if (amdgpu_sriov_vf(adev)) {
> -		/* disable the scheduler for SDMA */
> -		amdgpu_sdma_unset_buffer_funcs_helper(adev);
> +	if (amdgpu_sriov_vf(adev))
>   		return 0;
> -	}
>   
>   	sdma_v6_0_ctxempty_int_enable(adev, false);
>   	sdma_v6_0_enable(adev, false);
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> index 42c4547f32ec9c..9aa0e11ee67327 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> @@ -115,8 +115,6 @@ static void si_dma_stop(struct amdgpu_device *adev)
>   	u32 rb_cntl;
>   	unsigned i;
>   
> -	amdgpu_sdma_unset_buffer_funcs_helper(adev);
> -
>   	for (i = 0; i < adev->sdma.num_instances; i++) {
>   		/* dma0 */
>   		rb_cntl = RREG32(DMA_RB_CNTL + sdma_offsets[i]);
> @@ -177,9 +175,6 @@ static int si_dma_start(struct amdgpu_device *adev)
>   		r = amdgpu_ring_test_helper(ring);
>   		if (r)
>   			return r;
> -
> -		if (adev->mman.buffer_funcs_ring == ring)
> -			amdgpu_ttm_set_buffer_funcs_status(adev, true);
>   	}
>   
>   	return 0;
>
> base-commit: fefaa6c51e990dc8e5142729accef661f475a731

