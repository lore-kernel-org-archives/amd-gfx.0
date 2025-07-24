Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C17C83F26
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jul 2025 22:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C02010E087;
	Thu, 24 Jul 2025 22:55:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="KgRkbwC+";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7494E10E087
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Jul 2025 22:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TLn8hC4ZIzSyMzOS1/Axps8J3gUxGsoi1AGqGVBEtts=; b=KgRkbwC+MYyd8Q9QEJ4BtEoO6m
 ugkms/kpRjCJgyij0ZoqIcaB3Wwfl/F/b5g+Ci7sh4JY5VEbKPF4NKG1qDX13v2d5yjVwN6lVXWdh
 5CucTQlGgEemYrsJUiTplKwEmKuTKPI6iXHSMOF+YA/yqqR82hxfFtCcPEHWNPC1bE8SWHhtOqiAc
 Ftm0PE/hSUMqiHP+ZBJ+nEhr33ihBhekRMiRGms1ud3PQ3GzXNvQicuciD3CRz2KAuA9xEJSy3CKK
 x043jJk4JXCSOwBzwDqPyLKNoSfBmcRRFV8RRXVw6wHMm7HJB1jNNgeSSDRvNY5invqGlyPSo7eGF
 l8eTX+gA==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uf4qO-003PtM-30; Fri, 25 Jul 2025 00:55:20 +0200
Date: Thu, 24 Jul 2025 16:55:16 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 3/3] drm/amd/display: Fix DCE 6.0 and 6.4 PLL programming.
Message-ID: <fdnwuxecubaix24rwqrknv4lwjvnd255opfqd36cator42criq@7lkoni6sqx77>
References: <20250722155830.67401-1-timur.kristof@gmail.com>
 <20250722155830.67401-4-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250722155830.67401-4-timur.kristof@gmail.com>
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

On 07/22, Timur Kristóf wrote:
> Apparently, both DCE 6.0 and 6.4 have 3 PLLs, but PLL0 can only
> be used for DP. Make sure to initialize the correct amount of PLLs
> in DC for these DCE versions and use PLL0 only for DP.
> 
> Also, on DCE 6.0 and 6.4, the PLL0 needs to be powered on at
> initialization as opposed to DCE 6.1 and 7.x which use a different
> clock source for DFS.
> 
> The following functions were used as reference from the	old
> radeon driver implementation of	DCE 6.x:
> - radeon_atom_pick_pll
> - atombios_crtc_set_disp_eng_pll
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |  5 +++
>  .../dc/resource/dce60/dce60_resource.c        | 34 +++++++++++--------
>  2 files changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> index 26feefbb8990..f5ad0a177038 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> @@ -245,6 +245,11 @@ int dce_set_clock(
>  	pxl_clk_params.target_pixel_clock_100hz = requested_clk_khz * 10;
>  	pxl_clk_params.pll_id = CLOCK_SOURCE_ID_DFS;
>  
> +	/* DCE 6.0, DCE 6.4: engine clock is the same as PLL0 */
> +	if (clk_mgr_base->ctx->dce_version == DCE_VERSION_6_0 ||
> +	    clk_mgr_base->ctx->dce_version == DCE_VERSION_6_4)
> +		pxl_clk_params.pll_id = CLOCK_SOURCE_ID_PLL0;
> +
>  	if (clk_mgr_dce->dfs_bypass_active)
>  		pxl_clk_params.flags.SET_DISPCLK_DFS_BYPASS = true;
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> index 58b59d52dc9d..53b60044653f 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> @@ -373,7 +373,7 @@ static const struct resource_caps res_cap = {
>  		.num_timing_generator = 6,
>  		.num_audio = 6,
>  		.num_stream_encoder = 6,
> -		.num_pll = 2,
> +		.num_pll = 3,
>  		.num_ddc = 6,
>  };
>  
> @@ -389,7 +389,7 @@ static const struct resource_caps res_cap_64 = {
>  		.num_timing_generator = 2,
>  		.num_audio = 2,
>  		.num_stream_encoder = 2,
> -		.num_pll = 2,
> +		.num_pll = 3,
>  		.num_ddc = 2,
>  };
>  
> @@ -973,21 +973,24 @@ static bool dce60_construct(
>  
>  	if (bp->fw_info_valid && bp->fw_info.external_clock_source_frequency_for_dp != 0) {
>  		pool->base.dp_clock_source =
> -				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_EXTERNAL, NULL, true);
> +			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_EXTERNAL, NULL, true);
>  
> +		/* DCE 6.0 and 6.4: PLL0 can only be used with DP. Don't initialize it here. */
>  		pool->base.clock_sources[0] =
> -				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL0, &clk_src_regs[0], false);
> +			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[1], false);
>  		pool->base.clock_sources[1] =
> -				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[1], false);
> +			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL2, &clk_src_regs[2], false);
>  		pool->base.clk_src_count = 2;
>  
>  	} else {
>  		pool->base.dp_clock_source =
> -				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL0, &clk_src_regs[0], true);
> +			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL0, &clk_src_regs[0], true);
>  
>  		pool->base.clock_sources[0] =
> -				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[1], false);
> -		pool->base.clk_src_count = 1;
> +			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[1], false);
> +		pool->base.clock_sources[1] =
> +			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL2, &clk_src_regs[2], false);
> +		pool->base.clk_src_count = 2;
>  	}
>  
>  	if (pool->base.dp_clock_source == NULL) {
> @@ -1365,21 +1368,24 @@ static bool dce64_construct(
>  
>  	if (bp->fw_info_valid && bp->fw_info.external_clock_source_frequency_for_dp != 0) {
>  		pool->base.dp_clock_source =
> -				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_EXTERNAL, NULL, true);
> +			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_EXTERNAL, NULL, true);
>  
> +		/* DCE 6.0 and 6.4: PLL0 can only be used with DP. Don't initialize it here. */
>  		pool->base.clock_sources[0] =
> -				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[0], false);
> +			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[1], false);
>  		pool->base.clock_sources[1] =
> -				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL2, &clk_src_regs[1], false);
> +			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL2, &clk_src_regs[2], false);
>  		pool->base.clk_src_count = 2;
>  
>  	} else {
>  		pool->base.dp_clock_source =
> -				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[0], true);
> +			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL0, &clk_src_regs[0], true);
>  
>  		pool->base.clock_sources[0] =
> -				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL2, &clk_src_regs[1], false);
> -		pool->base.clk_src_count = 1;
> +			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[1], false);
> +		pool->base.clock_sources[1] =
> +			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL2, &clk_src_regs[2], false);
> +		pool->base.clk_src_count = 2;
>  	}
>  
>  	if (pool->base.dp_clock_source == NULL) {
> -- 
> 2.50.1
>

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>

Again, I'm adding other displays folks for further review.

Thanks 

-- 
Rodrigo Siqueira
