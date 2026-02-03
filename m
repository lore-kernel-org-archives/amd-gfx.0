Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AF7E8B37E
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 23:46:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 868D710E26B;
	Tue,  3 Feb 2026 23:46:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="bVwTz9MQ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4176210E26B
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 23:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zwK9I2mSHxTsQtOH/JdcYc+kjuv66+E8Dc1VxnLgUHQ=; b=bVwTz9MQMBlCb7i9lPBFawNmWg
 4dqCZaHYgZ1habzxKHtmRMQzkFLjrHBwozvFVUmFdrID/mgcexMARfNNBJo12HiE5sb5akBW2Wcr6
 nsTtp3U0IpfyjhoZQpCa0540rsdJ/GbyTqkefLTzcH7PxuM4qc4EfPdWo+ZSy4m9iqD0OJRomrSeJ
 PoJdi5RyrxCYSzITXpLHwtTRVtq6wr//QO8febYWXt+TOyoxrwUxCVH8SlDkTmiv37426y+hYeFlA
 ernqMwWnrrUnVzpQQtZahJxRaTTBm/IFT43AR2/SKe17J2BhdasImBG2tyXiCA4mchHvHTzACId6k
 EPPWL0cQ==;
Received: from d198-53-218-11.abhsia.telus.net ([198.53.218.11] helo=atmagalia)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vnQ5m-00DSdH-3b; Wed, 04 Feb 2026 00:45:58 +0100
Date: Tue, 3 Feb 2026 16:45:53 -0700
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com, 
 Leo Li <sunpeng.li@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: Re: [PATCH 4/5] drm/amd/display: Handle DCE 6 in dce_clk_mgr.c
Message-ID: <aYKImlkN3rQ4je_Z@atmagalia>
References: <20260118173150.19790-1-timur.kristof@gmail.com>
 <20260118173150.19790-5-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260118173150.19790-5-timur.kristof@gmail.com>
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

On 01/18, Timur Kristóf wrote:
> dce60_clk_mgr was basically identical to dce_clk_mgr other than
> a few minor details. They can be all handled in the same file,
> reducing duplicated code and easing the maintenance burden for
> old DCE versions.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  12 +-
>  .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |  64 ++++++--
>  .../display/dc/clk_mgr/dce60/dce60_clk_mgr.c  | 142 ------------------
>  .../display/dc/clk_mgr/dce60/dce60_clk_mgr.h  |  36 -----
>  4 files changed, 52 insertions(+), 202 deletions(-)
>  delete mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
>  delete mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.h
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> index 15cf13ec5302..9206eb8b0365 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> @@ -34,7 +34,6 @@
>  #include "dce110/dce110_clk_mgr.h"
>  #include "dce112/dce112_clk_mgr.h"
>  #include "dce120/dce120_clk_mgr.h"
> -#include "dce60/dce60_clk_mgr.h"
>  #include "dcn10/rv1_clk_mgr.h"
>  #include "dcn10/rv2_clk_mgr.h"
>  #include "dcn20/dcn20_clk_mgr.h"
> @@ -150,16 +149,7 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
>  
>  	switch (asic_id.chip_family) {
>  #if defined(CONFIG_DRM_AMD_DC_SI)
> -	case FAMILY_SI: {
> -		struct clk_mgr_internal *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
> -
> -		if (clk_mgr == NULL) {
> -			BREAK_TO_DEBUGGER();
> -			return NULL;
> -		}
> -		dce60_clk_mgr_construct(ctx, clk_mgr);
> -		return &clk_mgr->base;
> -	}
> +	case FAMILY_SI:
>  #endif
>  	case FAMILY_CI:
>  	case FAMILY_KV: {
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> index 6131ede2db7a..d02d03c154b3 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> @@ -62,6 +62,18 @@ static const struct clk_mgr_mask disp_clk_mask = {
>  		CLK_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(_MASK)
>  };
>  
> +/* Max clock values for each state indexed by "enum clocks_state": */
> +static const struct state_dependent_clocks dce60_max_clks_by_state[] = {
> +/* ClocksStateInvalid - should not be used */
> +{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
> +/* ClocksStateUltraLow - not expected to be used for DCE 6.0 */
> +{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
> +/* ClocksStateLow */
> +{ .display_clk_khz = 352000, .pixel_clk_khz = 330000},
> +/* ClocksStateNominal */
> +{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 },
> +/* ClocksStatePerformance */
> +{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 } };
>  
>  /* Max clock values for each state indexed by "enum clocks_state": */
>  static const struct state_dependent_clocks dce80_max_clks_by_state[] = {
> @@ -126,8 +138,25 @@ int dce_adjust_dp_ref_freq_for_ss(struct clk_mgr_internal *clk_mgr_dce, int dp_r
>  	return dp_ref_clk_khz;
>  }
>  
> +static int dce60_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
> +{
> +	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
> +	struct dc_context *ctx = clk_mgr_base->ctx;
> +	int dp_ref_clk_khz = 0;
> +
> +	if (ASIC_REV_IS_TAHITI_P(ctx->asic_id.hw_internal_rev))
> +		dp_ref_clk_khz = ctx->dc_bios->fw_info.default_display_engine_pll_frequency;
> +	else
> +		dp_ref_clk_khz = clk_mgr_base->clks.dispclk_khz;
> +
> +	return dce_adjust_dp_ref_freq_for_ss(clk_mgr, dp_ref_clk_khz);
> +}
> +
>  int dce_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
>  {
> +	if (clk_mgr_base->ctx->dce_version <= DCE_VERSION_6_4)
> +		return dce60_get_dp_ref_freq_khz(clk_mgr_base);
> +
>  	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
>  	int dprefclk_wdivider;
>  	int dprefclk_src_sel;
> @@ -441,27 +470,37 @@ void dce_clk_mgr_construct(
>  	struct clk_mgr *base = &clk_mgr->base;
>  	struct dm_pp_static_clock_info static_clk_info = {0};
>  
> -	memcpy(clk_mgr->max_clks_by_state,
> -		dce80_max_clks_by_state,
> -		sizeof(dce80_max_clks_by_state));
> +	if (ctx->dce_version <= DCE_VERSION_6_4)
> +		memcpy(clk_mgr->max_clks_by_state,
> +			dce60_max_clks_by_state,
> +			sizeof(dce60_max_clks_by_state));
> +	else
> +		memcpy(clk_mgr->max_clks_by_state,
> +			dce80_max_clks_by_state,
> +			sizeof(dce80_max_clks_by_state));
> +
>  
>  	base->ctx = ctx;
>  	base->funcs = &dce_funcs;
>  
> -	clk_mgr->regs = &disp_clk_regs;
> -	clk_mgr->clk_mgr_shift = &disp_clk_shift;
> -	clk_mgr->clk_mgr_mask = &disp_clk_mask;
> -	clk_mgr->dfs_bypass_disp_clk = 0;
> +	if (ctx->dce_version >= DCE_VERSION_8_0) {
> +		clk_mgr->regs = &disp_clk_regs;
> +		clk_mgr->clk_mgr_shift = &disp_clk_shift;
> +		clk_mgr->clk_mgr_mask = &disp_clk_mask;
> +	}
>  
> +	clk_mgr->dfs_bypass_disp_clk = 0;
>  	clk_mgr->dprefclk_ss_percentage = 0;
>  	clk_mgr->dprefclk_ss_divider = 1000;
>  	clk_mgr->ss_on_dprefclk = false;
>  
> -	if (dm_pp_get_static_clocks(ctx, &static_clk_info))
> -		clk_mgr->max_clks_state = static_clk_info.max_clocks_state;
> -	else
> -		clk_mgr->max_clks_state = DM_PP_CLOCKS_STATE_NOMINAL;
> -	clk_mgr->cur_min_clks_state = DM_PP_CLOCKS_STATE_INVALID;
> +	if (ctx->dce_version >= DCE_VERSION_8_0) {
> +		if (dm_pp_get_static_clocks(ctx, &static_clk_info))
> +			clk_mgr->max_clks_state = static_clk_info.max_clocks_state;
> +		else
> +			clk_mgr->max_clks_state = DM_PP_CLOCKS_STATE_NOMINAL;
> +		clk_mgr->cur_min_clks_state = DM_PP_CLOCKS_STATE_INVALID;
> +	}
>  
>  	base->clks.max_supported_dispclk_khz =
>  		clk_mgr->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
> @@ -469,4 +508,3 @@ void dce_clk_mgr_construct(
>  	dce_clock_read_integrated_info(clk_mgr);
>  	dce_clock_read_ss_info(clk_mgr);
>  }
> -
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> deleted file mode 100644
> index 1fdf344efe1a..000000000000
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> +++ /dev/null
> @@ -1,142 +0,0 @@
> -/*
> - * Copyright 2020 Mauro Rossi <issor.oruam@gmail.com>
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the "Software"),
> - * to deal in the Software without restriction, including without limitation
> - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - * Authors: AMD
> - *
> - */
> -
> -
> -#include "dccg.h"
> -#include "clk_mgr_internal.h"
> -#include "dce100/dce_clk_mgr.h"
> -#include "dce110/dce110_clk_mgr.h"
> -#include "dce60_clk_mgr.h"
> -#include "reg_helper.h"
> -#include "dmcu.h"
> -#include "core_types.h"
> -#include "dal_asic_id.h"
> -
> -/*
> - * Currently the register shifts and masks in this file are used for dce60
> - * which has no DPREFCLK_CNTL register
> - * TODO: remove this when DENTIST_DISPCLK_CNTL
> - * is moved to dccg, where it belongs
> - */
> -#include "dce/dce_6_0_d.h"
> -#include "dce/dce_6_0_sh_mask.h"
> -
> -/* Max clock values for each state indexed by "enum clocks_state": */
> -static const struct state_dependent_clocks dce60_max_clks_by_state[] = {
> -/* ClocksStateInvalid - should not be used */
> -{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
> -/* ClocksStateUltraLow - not expected to be used for DCE 6.0 */
> -{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
> -/* ClocksStateLow */
> -{ .display_clk_khz = 352000, .pixel_clk_khz = 330000},
> -/* ClocksStateNominal */
> -{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 },
> -/* ClocksStatePerformance */
> -{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 } };
> -
> -static int dce60_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
> -{
> -	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
> -	struct dc_context *ctx = clk_mgr_base->ctx;
> -	int dp_ref_clk_khz = 0;
> -
> -	if (ASIC_REV_IS_TAHITI_P(ctx->asic_id.hw_internal_rev))
> -		dp_ref_clk_khz = ctx->dc_bios->fw_info.default_display_engine_pll_frequency;
> -	else
> -		dp_ref_clk_khz = clk_mgr_base->clks.dispclk_khz;
> -
> -	return dce_adjust_dp_ref_freq_for_ss(clk_mgr, dp_ref_clk_khz);
> -}
> -
> -static void dce60_pplib_apply_display_requirements(
> -	struct dc *dc,
> -	struct dc_state *context)
> -{
> -	struct dm_pp_display_configuration *pp_display_cfg = &context->pp_display_cfg;
> -
> -	dce110_fill_display_configs(context, pp_display_cfg);
> -
> -	if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, sizeof(*pp_display_cfg)) !=  0)
> -		dm_pp_apply_display_requirements(dc->ctx, pp_display_cfg);
> -}
> -
> -static void dce60_update_clocks(struct clk_mgr *clk_mgr_base,
> -			struct dc_state *context,
> -			bool safe_to_lower)
> -{
> -	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
> -	struct dm_pp_power_level_change_request level_change_req;
> -	const int max_disp_clk =
> -		clk_mgr_dce->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
> -	int patched_disp_clk = MIN(max_disp_clk, context->bw_ctx.bw.dce.dispclk_khz);
> -
> -	level_change_req.power_level = dce_get_required_clocks_state(clk_mgr_base, context);
> -	/* get max clock state from PPLIB */
> -	if ((level_change_req.power_level < clk_mgr_dce->cur_min_clks_state && safe_to_lower)
> -			|| level_change_req.power_level > clk_mgr_dce->cur_min_clks_state) {
> -		if (dm_pp_apply_power_level_change_request(clk_mgr_base->ctx, &level_change_req))
> -			clk_mgr_dce->cur_min_clks_state = level_change_req.power_level;
> -	}
> -
> -	if (should_set_clock(safe_to_lower, patched_disp_clk, clk_mgr_base->clks.dispclk_khz)) {
> -		patched_disp_clk = dce_set_clock(clk_mgr_base, patched_disp_clk);
> -		clk_mgr_base->clks.dispclk_khz = patched_disp_clk;
> -	}
> -	dce60_pplib_apply_display_requirements(clk_mgr_base->ctx->dc, context);
> -}
> -
> -
> -
> -
> -
> -
> -
> -
> -static struct clk_mgr_funcs dce60_funcs = {
> -	.get_dp_ref_clk_frequency = dce60_get_dp_ref_freq_khz,
> -	.update_clocks = dce60_update_clocks
> -};
> -
> -void dce60_clk_mgr_construct(
> -		struct dc_context *ctx,
> -		struct clk_mgr_internal *clk_mgr)
> -{
> -	struct clk_mgr *base = &clk_mgr->base;
> -
> -	dce_clk_mgr_construct(ctx, clk_mgr);
> -
> -	memcpy(clk_mgr->max_clks_by_state,
> -		dce60_max_clks_by_state,
> -		sizeof(dce60_max_clks_by_state));
> -
> -	clk_mgr->regs = NULL;
> -	clk_mgr->clk_mgr_shift = NULL;
> -	clk_mgr->clk_mgr_mask = NULL;
> -	clk_mgr->base.funcs = &dce60_funcs;
> -
> -	base->clks.max_supported_dispclk_khz =
> -		clk_mgr->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
> -}
> -
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.h
> deleted file mode 100644
> index eca3e5168089..000000000000
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.h
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -/*
> - * Copyright 2020 Mauro Rossi <issor.oruam@gmail.com>
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the "Software"),
> - * to deal in the Software without restriction, including without limitation
> - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - * Authors: AMD
> - *
> - */
> -
> -
> -#ifndef DAL_DC_DCE_DCE60_CLK_MGR_H_
> -#define DAL_DC_DCE_DCE60_CLK_MGR_H_
> -
> -#include "dc.h"
> -
> -void dce60_clk_mgr_construct(
> -		struct dc_context *ctx,
> -		struct clk_mgr_internal *clk_mgr_dce);
> -
> -#endif /* DAL_DC_DCE_DCE60_CLK_MGR_H_ */
> -- 
> 2.52.0
>

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com> 

-- 
Rodrigo Siqueira
