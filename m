Return-Path: <SRS0=ju5j=AG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB16C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 08:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28F3C2067D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 08:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqMbrHFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F3C2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCDEE89B67;
	Thu, 25 Jun 2020 08:14:28 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F94C89B67
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2020 08:14:27 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id j4so2377463wrp.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2020 01:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=oHpJ2etFp9myED8aXfIywFXOSaf7yD7sCtOZlo1mtfI=;
 b=EqMbrHFpVRG5zVtec/tO+EYhpl9w/Srhn9yX8Er89yuJ5e7UZiwZgHTw5AJPywjhUw
 fNHOwSCcl8IF5zdp1zlAM5K/XY8s19f2yHx9FoQrcVWd0dFj1fU/MM7sVbbEDME50Ptz
 idVuOqsSoRxlMsCZ9EfVL7hqdeCI9IgiZcqHuDFV+NnelJ3kbINAgpayHmIVbynv/10Z
 eSrtVbzYjXOMWSGUeMJ0A4UzpqV6wrQ9gY1ozXVSXnhF68ZVTzOT3H4i+VQzr0eZRdfQ
 weBHsP/tfNfWGnMomPEcLtIvHccnTD1YyMTZg836+SnRIeS/RhxnZmBwBIhSACZpAjoN
 vojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=oHpJ2etFp9myED8aXfIywFXOSaf7yD7sCtOZlo1mtfI=;
 b=G8zLITRZXkUMqv4iU8nVencSfIP15aR7mciWPfMyMB8HC2XhNLFJzbCE/1LzreITkJ
 MmKYaQ0oJEDfyquzsze+EavClRfs13yc58ahY5YUolFcnFoC7mCg4oDxlrYUILxPQq8m
 u0hTyZUZmEPKumEa6QpBJBCdOFFOhhZVM9DnmE9DG7Mbf0/g5y3ouaRXTGLsoBIV9oXP
 tmVOTjt+SFm0PS6wHnslWm9vLXjHDID+hTPuJe+6mGf+mdq28sk9S2nN+9FqpYPl2T5z
 5VeqvJWIao9SkA3FLkNr+xvc/bJlW7lvwhStRsyxnpAr2QEhtWQ/wpUsb4TCez5LK4wL
 cCdw==
X-Gm-Message-State: AOAM531iufGnZ+9yMKLFDHjHZWRKIOJybYxm1op9aaA+NRvjPbNy4Rft
 k8Ph2F7yrYUL8fTMPTuK8u8=
X-Google-Smtp-Source: ABdhPJwTvCbJYoJJmuSzKj4LdplNyXvg2p1jpZEIbl8FcCRmPLIAtBCAhumKGSXVm/FdTvmrn5PqTQ==
X-Received: by 2002:a5d:6748:: with SMTP id l8mr39109471wrw.347.1593072866129; 
 Thu, 25 Jun 2020 01:14:26 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id h29sm32391298wrc.78.2020.06.25.01.14.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jun 2020 01:14:24 -0700 (PDT)
Subject: Re: [PATCH 2/3] drm/amdgpu: SI support for VCE clock control
To: Alex Jivin <alex.jivin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200624203137.14377-1-alex.jivin@amd.com>
 <20200624203137.14377-2-alex.jivin@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <66ded5e9-1c05-1bcf-ef37-c6d0024cae92@gmail.com>
Date: Thu, 25 Jun 2020 10:14:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200624203137.14377-2-alex.jivin@amd.com>
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

Am 24.06.20 um 22:31 schrieb Alex Jivin:
> Port functionality from the Radeon driver to support
> VCE clock control.
>
> Signed-off-by: Alex Jivin <alex.jivin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h |   9 ++
>   drivers/gpu/drm/amd/amdgpu/si.c     | 126 +++++++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/sid.h    |  31 +++++++
>   3 files changed, 165 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 6c7dd0a707c9..4b5a9a259a21 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1083,6 +1083,15 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>   		tmp_ |= ((val) & ~(mask));			\
>   		WREG32_PLL(reg, tmp_);				\
>   	} while (0)
> +
> +#define WREG32_SMC_P(_Reg, _Val, _Mask)                         \
> +	do {                                                    \
> +		u32 tmp = RREG32_SMC(_Reg);                     \
> +		tmp &= (_Mask);                                 \
> +		tmp |= ((_Val) & ~(_Mask));                     \
> +		WREG32_SMC(_Reg, tmp);                          \
> +	} while (0)
> +
>   #define DREG32_SYS(sqf, adev, reg) seq_printf((sqf), #reg " : 0x%08X\n", amdgpu_device_rreg((adev), (reg), false))
>   #define RREG32_IO(reg) amdgpu_io_rreg(adev, (reg))
>   #define WREG32_IO(reg, v) amdgpu_io_wreg(adev, (reg), (v))
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
> index 93609d69eff2..a5ad48fe502e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -1650,6 +1650,130 @@ static int si_set_uvd_clocks(struct amdgpu_device *adev, u32 vclk, u32 dclk)
>   	return 0;
>   }
>   
> +static int si_vce_send_vcepll_ctlreq(struct amdgpu_device *adev)
> +{
> +	unsigned i;
> +
> +	/* Make sure VCEPLL_CTLREQ is deasserted */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~UPLL_CTLREQ_MASK);
> +
> +	mdelay(10);
> +
> +	/* Assert UPLL_CTLREQ */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, UPLL_CTLREQ_MASK, ~UPLL_CTLREQ_MASK);
> +
> +	/* Wait for CTLACK and CTLACK2 to get asserted */
> +	for (i = 0; i < SI_MAX_CTLACKS_ASSERTION_WAIT; ++i) {
> +		uint32_t mask = UPLL_CTLACK_MASK | UPLL_CTLACK2_MASK;
> +
> +		if ((RREG32_SMC(CG_VCEPLL_FUNC_CNTL) & mask) == mask)
> +			break;
> +		mdelay(10);
> +	}
> +
> +	/* Deassert UPLL_CTLREQ */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~UPLL_CTLREQ_MASK);
> +
> +	if (i == SI_MAX_CTLACKS_ASSERTION_WAIT) {
> +		DRM_ERROR("Timeout setting UVD clocks!\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int si_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
> +{
> +	unsigned fb_div = 0, evclk_div = 0, ecclk_div = 0;
> +	int a;

Why "a"? Was that in radeon as well?

We usually use r or ret for the return/error code of functions.

Christian.

> +
> +	/* Bypass evclk and ecclk with bclk */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL_2,
> +		     EVCLK_SRC_SEL(1) | ECCLK_SRC_SEL(1),
> +		     ~(EVCLK_SRC_SEL_MASK | ECCLK_SRC_SEL_MASK));
> +
> +	/* Put PLL in bypass mode */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_BYPASS_EN_MASK,
> +		     ~VCEPLL_BYPASS_EN_MASK);
> +
> +	if (!evclk || !ecclk) {
> +		/* Keep the Bypass mode, put PLL to sleep */
> +		WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_SLEEP_MASK,
> +			     ~VCEPLL_SLEEP_MASK);
> +		return 0;
> +	}
> +
> +	a = si_calc_upll_dividers(adev, evclk, ecclk, 125000, 250000,
> +				  16384, 0x03FFFFFF, 0, 128, 5,
> +				  &fb_div, &evclk_div, &ecclk_div);
> +	if (a)
> +		return a;
> +
> +	/* Set RESET_ANTI_MUX to 0 */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL_5, 0, ~RESET_ANTI_MUX_MASK);
> +
> +	/* Set VCO_MODE to 1 */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_VCO_MODE_MASK,
> +		     ~VCEPLL_VCO_MODE_MASK);
> +
> +	/* Toggle VCEPLL_SLEEP to 1 then back to 0 */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_SLEEP_MASK,
> +		     ~VCEPLL_SLEEP_MASK);
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~VCEPLL_SLEEP_MASK);
> +
> +	/* Deassert VCEPLL_RESET */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~VCEPLL_RESET_MASK);
> +
> +	mdelay(1);
> +
> +	a = si_vce_send_vcepll_ctlreq(adev);
> +	if (a)
> +		return a;
> +
> +	/* Assert VCEPLL_RESET again */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_RESET_MASK, ~VCEPLL_RESET_MASK);
> +
> +	/* Disable spread spectrum. */
> +	WREG32_SMC_P(CG_VCEPLL_SPREAD_SPECTRUM, 0, ~SSEN_MASK);
> +
> +	/* Set feedback divider */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL_3,
> +		     VCEPLL_FB_DIV(fb_div),
> +		     ~VCEPLL_FB_DIV_MASK);
> +
> +	/* Set ref divider to 0 */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~VCEPLL_REF_DIV_MASK);
> +
> +	/* Set PDIV_A and PDIV_B */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL_2,
> +		     VCEPLL_PDIV_A(evclk_div) | VCEPLL_PDIV_B(ecclk_div),
> +		     ~(VCEPLL_PDIV_A_MASK | VCEPLL_PDIV_B_MASK));
> +
> +	/* Give the PLL some time to settle */
> +	mdelay(15);
> +
> +	/* Deassert PLL_RESET */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~VCEPLL_RESET_MASK);
> +
> +	mdelay(15);
> +
> +	/* Switch from bypass mode to normal mode */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~VCEPLL_BYPASS_EN_MASK);
> +
> +	a = si_vce_send_vcepll_ctlreq(adev);
> +	if (a)
> +		return a;
> +
> +	/* Switch VCLK and DCLK selection */
> +	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL_2,
> +		     EVCLK_SRC_SEL(16) | ECCLK_SRC_SEL(16),
> +		     ~(EVCLK_SRC_SEL_MASK | ECCLK_SRC_SEL_MASK));
> +
> +	mdelay(100);
> +
> +	return 0;
> +}
> +
>   static const struct amdgpu_asic_funcs si_asic_funcs =
>   {
>   	.read_disabled_bios = &si_read_disabled_bios,
> @@ -1660,7 +1784,7 @@ static const struct amdgpu_asic_funcs si_asic_funcs =
>   	.set_vga_state = &si_vga_set_state,
>   	.get_xclk = &si_get_xclk,
>   	.set_uvd_clocks = &si_set_uvd_clocks,
> -	.set_vce_clocks = NULL,
> +	.set_vce_clocks = &si_set_vce_clocks,
>   	.get_pcie_lanes = &si_get_pcie_lanes,
>   	.set_pcie_lanes = &si_set_pcie_lanes,
>   	.get_config_memsize = &si_get_config_memsize,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgpu/sid.h
> index 262da0fc8b2e..a3a966a83981 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sid.h
> +++ b/drivers/gpu/drm/amd/amdgpu/sid.h
> @@ -2461,4 +2461,35 @@
>   
>   #define	MC_VM_FB_OFFSET					0x81a
>   
> +/* Discrete VCE clocks */
> +#define CG_VCEPLL_FUNC_CNTL                             0xc0030600
> +#define    VCEPLL_RESET_MASK                            0x00000001
> +#define    VCEPLL_SLEEP_MASK                            0x00000002
> +#define    VCEPLL_BYPASS_EN_MASK                        0x00000004
> +#define    VCEPLL_CTLREQ_MASK                           0x00000008
> +#define    VCEPLL_VCO_MODE_MASK                         0x00000600
> +#define    VCEPLL_REF_DIV_MASK                          0x003F0000
> +#define    VCEPLL_CTLACK_MASK                           0x40000000
> +#define    VCEPLL_CTLACK2_MASK                          0x80000000
> +
> +#define CG_VCEPLL_FUNC_CNTL_2                           0xc0030601
> +#define    VCEPLL_PDIV_A(x)                             ((x) << 0)
> +#define    VCEPLL_PDIV_A_MASK                           0x0000007F
> +#define    VCEPLL_PDIV_B(x)                             ((x) << 8)
> +#define    VCEPLL_PDIV_B_MASK                           0x00007F00
> +#define    EVCLK_SRC_SEL(x)                             ((x) << 20)
> +#define    EVCLK_SRC_SEL_MASK                           0x01F00000
> +#define    ECCLK_SRC_SEL(x)                             ((x) << 25)
> +#define    ECCLK_SRC_SEL_MASK                           0x3E000000
> +
> +#define CG_VCEPLL_FUNC_CNTL_3                           0xc0030602
> +#define    VCEPLL_FB_DIV(x)                             ((x) << 0)
> +#define    VCEPLL_FB_DIV_MASK                           0x01FFFFFF
> +
> +#define CG_VCEPLL_FUNC_CNTL_4                           0xc0030603
> +
> +#define CG_VCEPLL_FUNC_CNTL_5                           0xc0030604
> +#define CG_VCEPLL_SPREAD_SPECTRUM                       0xc0030606
> +#define    VCEPLL_SSEN_MASK                             0x00000001
> +
>   #endif

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
