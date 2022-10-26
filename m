Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B0FC38A2D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 07:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 549F610E1C5;
	Wed, 26 Oct 2022 07:19:10 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8642210E1C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 07:19:05 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id kt23so13337499ejc.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 00:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jI9GupryLaN//4NChkDRDNYsYniK4U+U8sYNC0iLBNo=;
 b=J4qHZCw6K6SvnQ4oSVokVqMyyyhHusAO4uXUrzVW0pyPLR6Nc5FTSe7AaMmESV1W/e
 7wq7KixfhE3amJAqQztOMsru9Ogmk8nYPgZyPHRa7BP87gtEEUMl8DvHDi65jm66iCMB
 IefZsIRknURzTZxs6c3RA/YAk3U/Mvxr/FbvfW8gNiAUaHkJiNaE7oCHbRSWW1/jQ7GQ
 P2ehr88vTBMCEFtEDyLVLlSaZt3fm3obITimTd6m4ITFln61yzHk3mLEAmEi9jvI/rKK
 LcvnRuuhdZ64yvvaQpxa0/lS41JeR6yfflyoC/BuT2xrA0FbI0LEOTuZu0XV+IcU7Qhx
 w5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jI9GupryLaN//4NChkDRDNYsYniK4U+U8sYNC0iLBNo=;
 b=rMOFe6gbaxHoaTY6Gfqq/cgg14QM5ZqQ5snt+qWky+NxmdsHQjKJAZ5ZkCXWH2ic2G
 z8aFG/54Eh8aN/uCt25nXpLj9GxhrVgP9ceFoe61kWacZY3Gcr/AFb0coMTJhJcGBRBb
 S3zkrahCycrLjcHr0VoQfVakzsQfStrbPkIQ5Z0VAAvZn5NlDE/sh2Jiw4poLQbyh8Mj
 p4KxG0fsXUysQ5l7pkCDmAt2WKLTgsIKcjyyO8gxV/TZrdPo1U1yQgPArP9y0OIyMX1l
 glO0qAKzd+J+JnkVb/574eSCGkn44SYKrJmMtbC+fsiOh/9goUaNqy5qAxFsbFyVBNzz
 nrYg==
X-Gm-Message-State: ACrzQf0RNMY4J/WgXTrvmCVwmcY8plG2kX9Cj5PhukAE3lSVvJzbbOWE
 Mzl5PQJCx+trFrIl7rQycyc=
X-Google-Smtp-Source: AMsMyM4UczNypusupes9ZqdZRDLfRRY87IVo3CB/jRsB/LFflUtFiIKc/4LDq0dnQLORSiJFUC2T5w==
X-Received: by 2002:a17:907:94c3:b0:78e:2866:f89f with SMTP id
 dn3-20020a17090794c300b0078e2866f89fmr35461291ejc.617.1666768743907; 
 Wed, 26 Oct 2022 00:19:03 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:c59:1cd2:2bf0:d02b?
 ([2a02:908:1256:79a0:c59:1cd2:2bf0:d02b])
 by smtp.gmail.com with ESMTPSA id
 r25-20020a170906281900b0077205dd15basm2520196ejc.66.2022.10.26.00.19.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Oct 2022 00:19:03 -0700 (PDT)
Message-ID: <98e9c34b-a240-1a42-175c-0f3136df89f5@gmail.com>
Date: Wed, 26 Oct 2022 09:19:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] drm/amd/display: move remaining FPU code to dml
 folder
Content-Language: en-US
To: Ao Zhong <hacc1225@gmail.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <8055465a-4a0e-722b-c436-f39d6818ec73@amd.com>
 <20221025211746.16276-1-hacc1225@gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221025211746.16276-1-hacc1225@gmail.com>
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
Cc: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.10.22 um 23:17 schrieb Ao Zhong:
> In the process of enabling DCN support for arm64, I found that the
> dcn10_resource_construct_fp function in dcn10/dcn10_resource.c still
> needs to use FPU. This will cause compilation to fail on ARM64 platforms
> because -mgeneral-regs-only is enabled by default to disable the
> hardware FPU. So move dcn10_resource_construct_fp from dcn10 folder to
> dml/dcn10 folder to enable hardware FPU for that function.

Of hand that looks good to me, but our display team needs to take a look.

Feel free to add an Acked-by: Christian König <christian.koenig@amd.com> 
for the series.

While at it could you make sure that checkpatch.pl doesn't has anything 
to complain about the moved code?

Thanks for the help,
Christian.

>
> Signed-off-by: Ao Zhong <hacc1225@gmail.com>
> ---
>   .../drm/amd/display/dc/dcn10/dcn10_resource.c | 44 +------------------
>   .../drm/amd/display/dc/dml/dcn10/dcn10_fpu.c  | 38 ++++++++++++++++
>   .../drm/amd/display/dc/dml/dcn10/dcn10_fpu.h  |  2 +
>   3 files changed, 42 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> index 56d30baf12df..6bfac8088ab0 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> @@ -1295,47 +1295,6 @@ static uint32_t read_pipe_fuses(struct dc_context *ctx)
>   	return value;
>   }
>   
> -/*
> - * Some architectures don't support soft-float (e.g. aarch64), on those
> - * this function has to be called with hardfloat enabled, make sure not
> - * to inline it so whatever fp stuff is done stays inside
> - */
> -static noinline void dcn10_resource_construct_fp(
> -	struct dc *dc)
> -{
> -	if (dc->ctx->dce_version == DCN_VERSION_1_01) {
> -		struct dcn_soc_bounding_box *dcn_soc = dc->dcn_soc;
> -		struct dcn_ip_params *dcn_ip = dc->dcn_ip;
> -		struct display_mode_lib *dml = &dc->dml;
> -
> -		dml->ip.max_num_dpp = 3;
> -		/* TODO how to handle 23.84? */
> -		dcn_soc->dram_clock_change_latency = 23;
> -		dcn_ip->max_num_dpp = 3;
> -	}
> -	if (ASICREV_IS_RV1_F0(dc->ctx->asic_id.hw_internal_rev)) {
> -		dc->dcn_soc->urgent_latency = 3;
> -		dc->debug.disable_dmcu = true;
> -		dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 41.60f;
> -	}
> -
> -
> -	dc->dcn_soc->number_of_channels = dc->ctx->asic_id.vram_width / ddr4_dram_width;
> -	ASSERT(dc->dcn_soc->number_of_channels < 3);
> -	if (dc->dcn_soc->number_of_channels == 0)/*old sbios bug*/
> -		dc->dcn_soc->number_of_channels = 2;
> -
> -	if (dc->dcn_soc->number_of_channels == 1) {
> -		dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 19.2f;
> -		dc->dcn_soc->fabric_and_dram_bandwidth_vnom0p8 = 17.066f;
> -		dc->dcn_soc->fabric_and_dram_bandwidth_vmid0p72 = 14.933f;
> -		dc->dcn_soc->fabric_and_dram_bandwidth_vmin0p65 = 12.8f;
> -		if (ASICREV_IS_RV1_F0(dc->ctx->asic_id.hw_internal_rev)) {
> -			dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 20.80f;
> -		}
> -	}
> -}
> -
>   static bool verify_clock_values(struct dm_pp_clock_levels_with_voltage *clks)
>   {
>   	int i;
> @@ -1510,8 +1469,9 @@ static bool dcn10_resource_construct(
>   	memcpy(dc->dcn_ip, &dcn10_ip_defaults, sizeof(dcn10_ip_defaults));
>   	memcpy(dc->dcn_soc, &dcn10_soc_defaults, sizeof(dcn10_soc_defaults));
>   
> -	/* Other architectures we build for build this with soft-float */
> +	DC_FP_START();
>   	dcn10_resource_construct_fp(dc);
> +	DC_FP_END();
>   
>   	if (!dc->config.is_vmin_only_asic)
>   		if (ASICREV_IS_RAVEN2(dc->ctx->asic_id.hw_internal_rev))
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c
> index 99644d896222..8b5e6fff5444 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c
> @@ -27,6 +27,8 @@
>   #include "dcn10/dcn10_resource.h"
>   
>   #include "dcn10_fpu.h"
> +#include "resource.h"
> +#include "amdgpu_dm/dc_fpu.h"
>   
>   /**
>    * DOC: DCN10 FPU manipulation Overview
> @@ -121,3 +123,39 @@ struct _vcs_dpi_soc_bounding_box_st dcn1_0_soc = {
>   	.writeback_dram_clock_change_latency_us = 23.0,
>   	.return_bus_width_bytes = 64,
>   };
> +
> +void dcn10_resource_construct_fp(struct dc *dc)
> +{
> +	dc_assert_fp_enabled();
> +	if (dc->ctx->dce_version == DCN_VERSION_1_01) {
> +		struct dcn_soc_bounding_box *dcn_soc = dc->dcn_soc;
> +		struct dcn_ip_params *dcn_ip = dc->dcn_ip;
> +		struct display_mode_lib *dml = &dc->dml;
> +
> +		dml->ip.max_num_dpp = 3;
> +		/* TODO how to handle 23.84? */
> +		dcn_soc->dram_clock_change_latency = 23;
> +		dcn_ip->max_num_dpp = 3;
> +	}
> +	if (ASICREV_IS_RV1_F0(dc->ctx->asic_id.hw_internal_rev)) {
> +		dc->dcn_soc->urgent_latency = 3;
> +		dc->debug.disable_dmcu = true;
> +		dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 41.60f;
> +	}
> +
> +
> +	dc->dcn_soc->number_of_channels = dc->ctx->asic_id.vram_width / ddr4_dram_width;
> +	ASSERT(dc->dcn_soc->number_of_channels < 3);
> +	if (dc->dcn_soc->number_of_channels == 0)/*old sbios bug*/
> +		dc->dcn_soc->number_of_channels = 2;
> +
> +	if (dc->dcn_soc->number_of_channels == 1) {
> +		dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 19.2f;
> +		dc->dcn_soc->fabric_and_dram_bandwidth_vnom0p8 = 17.066f;
> +		dc->dcn_soc->fabric_and_dram_bandwidth_vmid0p72 = 14.933f;
> +		dc->dcn_soc->fabric_and_dram_bandwidth_vmin0p65 = 12.8f;
> +		if (ASICREV_IS_RV1_F0(dc->ctx->asic_id.hw_internal_rev)) {
> +			dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 20.80f;
> +		}
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h
> index e74ed4b4ce5b..63219ecd8478 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h
> @@ -27,4 +27,6 @@
>   #ifndef __DCN10_FPU_H__
>   #define __DCN10_FPU_H__
>   
> +void dcn10_resource_construct_fp(struct dc *dc);
> +
>   #endif /* __DCN20_FPU_H__ */

