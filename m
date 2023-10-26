Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0911C25B67
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 05:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84B6210E75D;
	Thu, 26 Oct 2023 05:52:40 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ED1710E75D
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 05:52:38 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40790b0a224so3835615e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 22:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698299557; x=1698904357; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3ZZrlheeP5eNpLZ8bK9u4rN5PGkaPcKetS7zJfJmEnk=;
 b=iI9ckOsNdIGBox0W8ZSTjT4OJXPeBSgEN0EqOxXJe4hXkf1bMCD6N3u1BU1yPcPO1U
 gUE7dNY+VB/bZ95nbOh45KWiXI8P4Ot4gR9Yb04ESYh7D2nSL4XM2GDh7NTWWhmJcruW
 7fBA0VmxWoIJenYNJeTipirs6r0d84M9r8mY314OTftmo7M14KIomeCHV/Oi4cv3ZOLG
 NAT6xUTqip4+veVztTphYAPW7eKU89mtyaU3mBut7tnB1+TAv/awY8fBrAFLJA4pOXk2
 A86o4Rl37Q1icINcz2xiUdYroZCW0+zPv95ee4Rgvy2y05WuGVUeDFv22SX8kXY0UAWo
 bQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698299557; x=1698904357;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3ZZrlheeP5eNpLZ8bK9u4rN5PGkaPcKetS7zJfJmEnk=;
 b=JJNrZ9IDKTYV32fCa6axbzfksAw1oAuDmmygPi1NR4GUsV8H32r++OKQFL382hQiLT
 jPh8sMw3PPgZhenGeCt/5EhTrpLGFJo2ISoKXEvexChBWrLs+bZDF48x/LGST4ytivMV
 haqYRmFD2+H6CCzwI3+goZTjTDdHfA8W7SycbElRSRv44HnqMC19EX/H5a8xwYl1Cg1E
 B3LSIk+d3MLJ21hjzZJ2WLWT+SdASn7b2PedgIBxR9O8pJ/Uxlr8mhjff/7bMkn9lLbk
 R9PBaBpnRU2QgGuPJTj2bu7To2bbtZN2Wd0Bcddmvhe/9O6RVYhkgHpGFSursH0l8iK5
 HqBQ==
X-Gm-Message-State: AOJu0Yw/hRMTjAjJ1C3XCk97PSd96E+nQ31kEgOwKfwsoKV+56dJVOi+
 UaYPpYaW86s6azg80pJtPoxEbEsgDAgXVA==
X-Google-Smtp-Source: AGHT+IGp+zoMBwC59XMGl1l2Kj3TZaDRPxV3iT5/j6T5vqY8uYTaQGTSLDJUrSdEcp3u/CGcKjYrIg==
X-Received: by 2002:a05:600c:4ece:b0:408:3ab3:a05e with SMTP id
 g14-20020a05600c4ece00b004083ab3a05emr13888295wmq.38.1698299556548; 
 Wed, 25 Oct 2023 22:52:36 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 v13-20020a05600c470d00b00407460234f9sm1550009wmo.21.2023.10.25.22.52.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 22:52:35 -0700 (PDT)
Message-ID: <96db9e3d-4636-4da4-b4d1-ca3f5fd8d887@gmail.com>
Date: Thu, 26 Oct 2023 07:52:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: move buffer funcs setting up a level
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231025171928.3318505-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231025171928.3318505-1-alexander.deucher@amd.com>
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
Cc: Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.10.23 um 19:19 schrieb Alex Deucher:
> Rather than doing this in the IP code for the SDMA paging
> engine, move it up to the core device level init level.
> This should fix the scheduler init ordering.
>
> v2: drop extra parens
> v3: drop SDMA helpers
>
> Tested-by: Luben Tuikov <luben.tuikov@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

I don't know of hand if the high level function really cover everything, 
so only Acked-by: Christian König <christian.koenig@amd.com> for now.

Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c   | 21 ---------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h   |  1 -
>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c      |  5 -----
>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c     |  5 -----
>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     |  5 -----
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     | 16 +---------------
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     | 10 +---------
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c     | 10 +---------
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c     | 10 +---------
>   drivers/gpu/drm/amd/amdgpu/si_dma.c        |  5 -----
>   11 files changed, 19 insertions(+), 84 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2031a467b721..5c90080e93ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2662,6 +2662,9 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>   	if (r)
>   		goto init_failed;
>   
> +	if (adev->mman.buffer_funcs_ring->sched.ready)
> +		amdgpu_ttm_set_buffer_funcs_status(adev, true);
> +
>   	/* Don't init kfd if whole hive need to be reset during init */
>   	if (!adev->gmc.xgmi.pending_reset) {
>   		kgd2kfd_init_zone_device(adev);
> @@ -3260,6 +3263,8 @@ int amdgpu_device_ip_suspend(struct amdgpu_device *adev)
>   		amdgpu_virt_request_full_gpu(adev, false);
>   	}
>   
> +	amdgpu_ttm_set_buffer_funcs_status(adev, false);
> +
>   	r = amdgpu_device_ip_suspend_phase1(adev);
>   	if (r)
>   		return r;
> @@ -3449,6 +3454,9 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
>   
>   	r = amdgpu_device_ip_resume_phase2(adev);
>   
> +	if (adev->mman.buffer_funcs_ring->sched.ready)
> +		amdgpu_ttm_set_buffer_funcs_status(adev, true);
> +
>   	return r;
>   }
>   
> @@ -4236,6 +4244,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   	/* disable ras feature must before hw fini */
>   	amdgpu_ras_pre_fini(adev);
>   
> +	amdgpu_ttm_set_buffer_funcs_status(adev, false);
> +
>   	amdgpu_device_ip_fini_early(adev);
>   
>   	amdgpu_irq_fini_hw(adev);
> @@ -4407,6 +4417,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>   
>   	amdgpu_ras_suspend(adev);
>   
> +	amdgpu_ttm_set_buffer_funcs_status(adev, false);
> +
>   	amdgpu_device_ip_suspend_phase1(adev);
>   
>   	if (!adev->in_s0ix)
> @@ -5178,6 +5190,9 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   				if (r)
>   					goto out;
>   
> +				if (tmp_adev->mman.buffer_funcs_ring->sched.ready)
> +					amdgpu_ttm_set_buffer_funcs_status(tmp_adev, true);
> +
>   				if (vram_lost)
>   					amdgpu_device_fill_reset_magic(tmp_adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index e8cbc4142d80..1d9d187de6ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -292,27 +292,6 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
>   	return err;
>   }
>   
> -void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_device *adev)
> -{
> -	struct amdgpu_ring *sdma;
> -	int i;
> -
> -	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		if (adev->sdma.has_page_queue) {
> -			sdma = &adev->sdma.instance[i].page;
> -			if (adev->mman.buffer_funcs_ring == sdma) {
> -				amdgpu_ttm_set_buffer_funcs_status(adev, false);
> -				break;
> -			}
> -		}
> -		sdma = &adev->sdma.instance[i].ring;
> -		if (adev->mman.buffer_funcs_ring == sdma) {
> -			amdgpu_ttm_set_buffer_funcs_status(adev, false);
> -			break;
> -		}
> -	}
> -}
> -
>   int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev)
>   {
>   	int err = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 513ac22120c1..173a2a308078 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -169,7 +169,6 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev, u32 instance,
>   			       bool duplicate);
>   void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
>           bool duplicate);
> -void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_device *adev);
>   int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> index ee5dce6f6043..a3fccc4c1f43 100644
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
> index b58a13bd75db..45377a175250 100644
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
> index c5ea32687eb5..2ad615be4bb3 100644
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
> index 683d51ae4bf1..3d68dd5523c6 100644
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
> index be5d099c9898..c78027ebdcb9 100644
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
> index a3e8b10c071c..2e35f3571774 100644
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
> index 445a34549d2c..1c6ff511f501 100644
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
> index 42c4547f32ec..9aa0e11ee673 100644
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

