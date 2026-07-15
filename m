Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3897CC44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 09:53:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D415A10E162;
	Wed, 15 Jul 2026 09:53:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="JrGV1V3w";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CB5010E162
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 09:53:45 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-493c19bad03so46571395e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 02:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1784109223; x=1784714023; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Fd59QixXrhEFMMTjBHesxiX+c9wZlfFVsDk56O14d/A=;
 b=JrGV1V3wv8SuDRqw4GzFMzmzJ5SPm8MgUyNVn3f3zgIbOsRdQgeXytRM5w3vsv5Vto
 8sU+qwsek4f0Or+t1095BWuBfVYvdeehvGxDAEXyWBRW2hrcunykKSW1l1Jk9gAaBZMG
 OQuxrwoKj6wONobUy+ulZ3Wqi6jlySPektBJs9eNT4iHX3KhAkIJIdq12LvIpRdw48fY
 NoRJYjhr9YeAAchTXwfP1Rjd+oivY3DhFiKlWbWbAr8euc9ouGzNwsj2MVTpeRVXY5Sf
 HEvR8+CGbkLPzx2yd9IKCsOcR9pVVxSjn7wnlF5y5Kn9jYtwg/tGUFkZmmocVuL3PfPg
 oRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784109223; x=1784714023;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fd59QixXrhEFMMTjBHesxiX+c9wZlfFVsDk56O14d/A=;
 b=B7N1VCT6b4Pjkz+/+QYWTNLOQuIjXOBdZLIdIEykIdrsHb1o7vsJvH2otNE0ehhzUx
 p+t2csHIUpCajTTd3dDrfO0PEy9UOjbaAHYMA22PDzyWwbFx3JodXfH2ae+GgnIFWJLx
 XCRcu25z6NI6MGE3xUBdMwf/2xGns6hK/Pp+ddlLfobzqou3AoJe6rpdbsXRi4OIevpn
 2p5HDFSkI2d4O3BUSf6gtz+ah6+OihN0/5rzmn2iaGm7RFl/QurteBiCYi3dCQOkKY0E
 neAn9xOJ/oTPAqXlRDCKUXTzTDss4fK1r1xBV84WcvwJVq/dm8cNOiS2aM1YBn9qSrUJ
 74bw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5WYbYnKDMSG+x0eWtG/Ip9PD6F1pUx6NNJEULxp5gpfc/746FOBAAutZcWnD0vU7unKqAysxj@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxojOp/iUIueFWpN2mwVqQfMMGPjnNlQdZY/ixSlG0NwO/LJx3b
 LdXm1sDjCgJENhyKPLU6Zi4MoPYutuMzquv/9OaE7L7EbScN18snyWCz2dwYGVGq/Yg=
X-Gm-Gg: AfdE7ck3U1xu++wHPfUuJRCJD+AZu1mV7oZH5zm6bjSC4eCRiuInV7OzPKDYHFIjn84
 mMtm7sgGKpGw18LYk/+VSPMqx14pwvkOmOddTSwQbiJpNMok/rMLJ9j0tgWhbfPsWCvF8dB0kpI
 P8/rE8ok7NpHa3p6gEk/TJPnLshs7d5Rp/KRMGJW95cn9SRtGPflH8dbtxacpp01+vhggdMvnqA
 FSNO1QAwsFpHtCcS0D7o0x+XA715QG7r28bqGpd/Bsp1qmmEcEjrfoYJA1BDz8iNYLrdgGTlOrS
 JY04HZ9nqt8Y+90LsgETsdjxYQWrdSgpiTHcr3eFCRHYPQsRa9znKrpFxT6m/6lTUSPrb5YPCXy
 Ld5gSRDPz4XDpDfuf6i8q8PLJwyPCXVCpiqv7UI6vKJVEYsB1sq8Ccxs+Smfka0G1F41pCslJ84
 HidroEWYVr1zOPcs1TQfvn6/APue5z/DMmyg==
X-Received: by 2002:a05:600c:b8d:b0:493:f5bf:4dc6 with SMTP id
 5b1f17b1804b1-4953c14ef45mr23551365e9.7.1784109223392; 
 Wed, 15 Jul 2026 02:53:43 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4953c704bfasm44023745e9.2.2026.07.15.02.53.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 02:53:43 -0700 (PDT)
Message-ID: <772fefb0-bb30-4f89-809d-8a63bedead1c@ursulin.net>
Date: Wed, 15 Jul 2026 10:53:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] drm/amdgpu/gfx7: Fixup IP block soft reset
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
 <20260713125838.30607-9-timur.kristof@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260713125838.30607-9-timur.kristof@gmail.com>
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


On 13/07/2026 13:58, Timur Kristóf wrote:
> Use basically the same implementation as GFX8,
> except for the GFX7 specific MQD functions.
> 
> Reset every block using the GRBM, then proceed
> to reset the GRBM and SEM blocks using the SRBM.
> 
> Remove the redundant gfx_v7_0_update_cg() function.
> The soft reset now calls the clock and powergating
> functions of the IP block instead.

Does what it says on the tin - matches the gfx8 implementation.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 148 +++++++++++++-------------
>   1 file changed, 76 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 6d52b8710437..825e3d7d5f0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -3618,21 +3618,6 @@ static void gfx_v7_0_enable_mgcg(struct amdgpu_device *adev, bool enable)
>   	}
>   }
>   
> -static void gfx_v7_0_update_cg(struct amdgpu_device *adev,
> -			       bool enable)
> -{
> -	gfx_v7_0_enable_gui_idle_interrupt(adev, false);
> -	/* order matters! */
> -	if (enable) {
> -		gfx_v7_0_enable_mgcg(adev, true);
> -		gfx_v7_0_enable_cgcg(adev, true);
> -	} else {
> -		gfx_v7_0_enable_cgcg(adev, false);
> -		gfx_v7_0_enable_mgcg(adev, false);
> -	}
> -	gfx_v7_0_enable_gui_idle_interrupt(adev, true);
> -}
> -
>   static void gfx_v7_0_enable_sclk_slowdown_on_pu(struct amdgpu_device *adev,
>   						bool enable)
>   {
> @@ -4551,80 +4536,99 @@ static int gfx_v7_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   
>   static int gfx_v7_0_soft_reset(struct amdgpu_ip_block *ip_block)
>   {
> +	struct amdgpu_device *adev = ip_block->adev;
>   	u32 grbm_soft_reset = 0, srbm_soft_reset = 0;
>   	u32 tmp;
> -	struct amdgpu_device *adev = ip_block->adev;
> +	int i;
> +	int r;
>   
> -	/* GRBM_STATUS */
> -	tmp = RREG32(mmGRBM_STATUS);
> -	if (tmp & (GRBM_STATUS__PA_BUSY_MASK | GRBM_STATUS__SC_BUSY_MASK |
> -		   GRBM_STATUS__BCI_BUSY_MASK | GRBM_STATUS__SX_BUSY_MASK |
> -		   GRBM_STATUS__TA_BUSY_MASK | GRBM_STATUS__VGT_BUSY_MASK |
> -		   GRBM_STATUS__DB_BUSY_MASK | GRBM_STATUS__CB_BUSY_MASK |
> -		   GRBM_STATUS__GDS_BUSY_MASK | GRBM_STATUS__SPI_BUSY_MASK |
> -		   GRBM_STATUS__IA_BUSY_MASK | GRBM_STATUS__IA_BUSY_NO_DMA_MASK))
> -		grbm_soft_reset |= GRBM_SOFT_RESET__SOFT_RESET_CP_MASK |
> -			GRBM_SOFT_RESET__SOFT_RESET_GFX_MASK;
> -
> -	if (tmp & (GRBM_STATUS__CP_BUSY_MASK | GRBM_STATUS__CP_COHERENCY_BUSY_MASK)) {
> -		grbm_soft_reset |= GRBM_SOFT_RESET__SOFT_RESET_CP_MASK;
> -		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_GRBM_MASK;
> -	}
> +	grbm_soft_reset =
> +		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_RLC, 1) |
> +		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_GFX, 1) |
> +		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_CP, 1) |
> +		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_CPF, 1) |
> +		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_CPC, 1) |
> +		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_CPG, 1);
> +
> +	srbm_soft_reset =
> +		REG_SET_FIELD(0, SRBM_SOFT_RESET, SOFT_RESET_GRBM, 1) |
> +		REG_SET_FIELD(0, SRBM_SOFT_RESET, SOFT_RESET_SEM, 1);
> +
> +	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> +		struct amdgpu_ring *ring = &adev->gfx.compute_ring[i];
> +
> +		mutex_lock(&adev->srbm_mutex);
> +		cik_srbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
> +		gfx_v7_0_mqd_deactivate(adev, 2);
> +		cik_srbm_select(adev, 0, 0, 0, 0);
> +		mutex_unlock(&adev->srbm_mutex);
>   
> -	/* GRBM_STATUS2 */
> -	tmp = RREG32(mmGRBM_STATUS2);
> -	if (tmp & GRBM_STATUS2__RLC_BUSY_MASK)
> -		grbm_soft_reset |= GRBM_SOFT_RESET__SOFT_RESET_RLC_MASK;
> +		udelay(50);
> +	}
>   
> -	/* SRBM_STATUS */
> -	tmp = RREG32(mmSRBM_STATUS);
> -	if (tmp & SRBM_STATUS__GRBM_RQ_PENDING_MASK)
> -		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_GRBM_MASK;
> +	ip_block->version->funcs->set_clockgating_state(ip_block, AMD_CG_STATE_UNGATE);
> +	ip_block->version->funcs->set_powergating_state(ip_block, AMD_PG_STATE_UNGATE);
> +	ip_block->version->funcs->suspend(ip_block);
>   
>   	if (grbm_soft_reset || srbm_soft_reset) {
> -		/* disable CG/PG */
> -		gfx_v7_0_fini_pg(adev);
> -		gfx_v7_0_update_cg(adev, false);
> +		tmp = RREG32(mmGMCON_DEBUG);
> +		tmp = REG_SET_FIELD(tmp, GMCON_DEBUG, GFX_STALL, 1);
> +		tmp = REG_SET_FIELD(tmp, GMCON_DEBUG, GFX_CLEAR, 1);
> +		WREG32(mmGMCON_DEBUG, tmp);
>   
> -		/* stop the rlc */
> -		adev->gfx.rlc.funcs->stop(adev);
> +		udelay(100);
> +	}
>   
> -		/* Disable GFX parsing/prefetching */
> -		WREG32(mmCP_ME_CNTL, CP_ME_CNTL__ME_HALT_MASK | CP_ME_CNTL__PFP_HALT_MASK | CP_ME_CNTL__CE_HALT_MASK);
> +	if (grbm_soft_reset) {
> +		tmp = RREG32(mmGRBM_SOFT_RESET);
> +		tmp |= grbm_soft_reset;
> +		dev_info(adev->dev, "GRBM_SOFT_RESET=0x%08X\n", tmp);
> +		WREG32(mmGRBM_SOFT_RESET, tmp);
> +		tmp = RREG32(mmGRBM_SOFT_RESET);
>   
> -		/* Disable MEC parsing/prefetching */
> -		WREG32(mmCP_MEC_CNTL, CP_MEC_CNTL__MEC_ME1_HALT_MASK | CP_MEC_CNTL__MEC_ME2_HALT_MASK);
> +		udelay(100);
>   
> -		if (grbm_soft_reset) {
> -			tmp = RREG32(mmGRBM_SOFT_RESET);
> -			tmp |= grbm_soft_reset;
> -			dev_info(adev->dev, "GRBM_SOFT_RESET=0x%08X\n", tmp);
> -			WREG32(mmGRBM_SOFT_RESET, tmp);
> -			tmp = RREG32(mmGRBM_SOFT_RESET);
> +		tmp &= ~grbm_soft_reset;
> +		WREG32(mmGRBM_SOFT_RESET, tmp);
> +		tmp = RREG32(mmGRBM_SOFT_RESET);
>   
> -			udelay(50);
> +		udelay(100);
> +	}
>   
> -			tmp &= ~grbm_soft_reset;
> -			WREG32(mmGRBM_SOFT_RESET, tmp);
> -			tmp = RREG32(mmGRBM_SOFT_RESET);
> -		}
> +	if (srbm_soft_reset) {
> +		tmp = RREG32(mmSRBM_SOFT_RESET);
> +		tmp |= srbm_soft_reset;
> +		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
> +		WREG32(mmSRBM_SOFT_RESET, tmp);
> +		tmp = RREG32(mmSRBM_SOFT_RESET);
>   
> -		if (srbm_soft_reset) {
> -			tmp = RREG32(mmSRBM_SOFT_RESET);
> -			tmp |= srbm_soft_reset;
> -			dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
> -			WREG32(mmSRBM_SOFT_RESET, tmp);
> -			tmp = RREG32(mmSRBM_SOFT_RESET);
> +		udelay(100);
>   
> -			udelay(50);
> +		tmp &= ~srbm_soft_reset;
> +		WREG32(mmSRBM_SOFT_RESET, tmp);
> +		tmp = RREG32(mmSRBM_SOFT_RESET);
>   
> -			tmp &= ~srbm_soft_reset;
> -			WREG32(mmSRBM_SOFT_RESET, tmp);
> -			tmp = RREG32(mmSRBM_SOFT_RESET);
> -		}
> -		/* Wait a little for things to settle down */
> -		udelay(50);
> +		udelay(100);
>   	}
> +
> +	if (grbm_soft_reset || srbm_soft_reset) {
> +		tmp = RREG32(mmGMCON_DEBUG);
> +		tmp = REG_SET_FIELD(tmp, GMCON_DEBUG, GFX_STALL, 0);
> +		tmp = REG_SET_FIELD(tmp, GMCON_DEBUG, GFX_CLEAR, 0);
> +		WREG32(mmGMCON_DEBUG, tmp);
> +	}
> +
> +	/* Wait a little for things to settle down */
> +	udelay(100);
> +
> +	r = ip_block->version->funcs->resume(ip_block);
> +	r |= ip_block->version->funcs->late_init(ip_block);
> +	if (r)
> +		return r;
> +
> +	ip_block->version->funcs->set_clockgating_state(ip_block, AMD_CG_STATE_GATE);
> +	ip_block->version->funcs->set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +
>   	return 0;
>   }
>   

