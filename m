Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB4FCCFA13
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 20:29:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40C5210F16B;
	Wed, 29 Apr 2026 20:29:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="NgglhdCI";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F4E510E041
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 20:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xhXnjOfq219Fqqv/sMHlDeHHR0MKsrW/bdFrYUSMlcI=; b=NgglhdCIqwsVk8Ln3a2rECuOSq
 7SV+Oh626zIftmHzQw6+ts7q2xoZsKGjVZFmMTGEQ2en6rHunVRaoSIfXY4hW1HGNDS/1e8akh1EB
 7/rNDKuQ3VLPqteCIJrca1TBrmyLXuu1b1QbJxlW3KJpWN3I+Bti2sCcpZ2YCo/g+fiGYR0QuNvQv
 aIGHEMDdYe6QjxKdZ9LjcgqjxvzPZS/oXlWIOCbADVrz5FqaypHzGhG9A2gDbhSqeDiWz7JIcX2pB
 vC0AK9UEE7KpkSDRtVzMtR8BcZ4DZ2chHXceTfZunXykkJveQQx6OaPBz+pPOZRRl+csMV7Iy4rC+
 WrrEuWgg==;
Received: from [186.208.73.228] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wIBWv-0047Dt-8q; Wed, 29 Apr 2026 22:29:08 +0200
Message-ID: <b64dbee7-9bfa-4a6c-93af-bfed8c978d0e@igalia.com>
Date: Wed, 29 Apr 2026 17:29:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] drm/amd/display: Delete max_clks_by_state from DCE
 clock manager
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>
References: <20260423191519.73127-1-timur.kristof@gmail.com>
 <20260423191519.73127-7-timur.kristof@gmail.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260423191519.73127-7-timur.kristof@gmail.com>
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



On 23/04/2026 16:15, Timur Kristóf wrote:
> It was not used by anything anymore.
>
> Note that the parts of DC that need this information actually
> already query it from the pplib and don't use the hardcoded
> information from max_clks_by_state.
>
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 71 -------------------
>   .../dc/clk_mgr/dce110/dce110_clk_mgr.c        | 16 -----
>   .../dc/clk_mgr/dce112/dce112_clk_mgr.c        | 17 -----
>   .../dc/clk_mgr/dce120/dce120_clk_mgr.c        | 16 -----
>   .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  2 -
>   5 files changed, 122 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> index bef9a72f3382f..4303a42a7fe37 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> @@ -62,32 +62,6 @@ static const struct clk_mgr_mask disp_clk_mask = {
>   		CLK_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(_MASK)
>   };
>   
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
> -/* Max clock values for each state indexed by "enum clocks_state": */
> -static const struct state_dependent_clocks dce80_max_clks_by_state[] = {
> -/* ClocksStateInvalid - should not be used */
> -{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
> -/* ClocksStateUltraLow - not expected to be used for DCE 8.0 */
> -{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
> -/* ClocksStateLow */
> -{ .display_clk_khz = 352000, .pixel_clk_khz = 330000},
> -/* ClocksStateNominal */
> -{ .display_clk_khz = 625000, .pixel_clk_khz = 400000 },
> -/* ClocksStatePerformance */
> -{ .display_clk_khz = 625000, .pixel_clk_khz = 400000 } };
Can you drop the whole `struct state_dependent_clocks` as well?
> -
>   int dentist_get_divider_from_did(int did)
>   {
>   	if (did < DENTIST_BASE_DID_1)
> @@ -268,7 +242,6 @@ static void dce_clock_read_integrated_info(struct clk_mgr_internal *clk_mgr_dce)
>   {
>   	struct dc_debug_options *debug = &clk_mgr_dce->base.ctx->dc->debug;
>   	struct dc_bios *bp = clk_mgr_dce->base.ctx->dc_bios;
> -	int i;
>   
>   	if (bp->integrated_info)
>   		clk_mgr_dce->base.dentist_vco_freq_khz = bp->integrated_info->dentist_vco_freq;
> @@ -278,40 +251,6 @@ static void dce_clock_read_integrated_info(struct clk_mgr_internal *clk_mgr_dce)
>   			clk_mgr_dce->base.dentist_vco_freq_khz = 3600000;
>   	}
>   
> -	/*update the maximum display clock for each power state*/
> -	for (i = 0; i < NUMBER_OF_DISP_CLK_VOLTAGE; ++i) {
> -		enum dm_pp_clocks_state clk_state = DM_PP_CLOCKS_STATE_INVALID;
> -
> -		switch (i) {
> -		case 0:
> -			clk_state = DM_PP_CLOCKS_STATE_ULTRA_LOW;
> -			break;
> -
> -		case 1:
> -			clk_state = DM_PP_CLOCKS_STATE_LOW;
> -			break;
> -
> -		case 2:
> -			clk_state = DM_PP_CLOCKS_STATE_NOMINAL;
> -			break;
> -
> -		case 3:
> -			clk_state = DM_PP_CLOCKS_STATE_PERFORMANCE;
> -			break;
> -
> -		default:
> -			clk_state = DM_PP_CLOCKS_STATE_INVALID;
> -			break;
> -		}
> -
> -		/*Do not allow bad VBIOS/SBIOS to override with invalid values,
> -		 * check for > 100MHz*/
> -		if (bp->integrated_info)
> -			if (bp->integrated_info->disp_clk_voltage[i].max_supported_clk >= 100000)
> -				clk_mgr_dce->max_clks_by_state[clk_state].display_clk_khz =
> -					bp->integrated_info->disp_clk_voltage[i].max_supported_clk;
> -	}
> -
>   	if (!debug->disable_dfs_bypass && bp->integrated_info)
>   		if (bp->integrated_info->gpu_cap_info & DFS_BYPASS_ENABLE)
>   			clk_mgr_dce->dfs_bypass_enabled = true;
> @@ -419,16 +358,6 @@ void dce_clk_mgr_construct(
>   {
>   	struct clk_mgr *base = &clk_mgr->base;
>   
> -	if (ctx->dce_version <= DCE_VERSION_6_4)
> -		memcpy(clk_mgr->max_clks_by_state,
> -			dce60_max_clks_by_state,
> -			sizeof(dce60_max_clks_by_state));
> -	else
> -		memcpy(clk_mgr->max_clks_by_state,
> -			dce80_max_clks_by_state,
> -			sizeof(dce80_max_clks_by_state));
> -
> -
>   	base->ctx = ctx;
>   	base->funcs = &dce_funcs;
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
> index ae922f1a31ff8..6144c03e14207 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
> @@ -51,18 +51,6 @@ static const struct clk_mgr_mask disp_clk_mask = {
>   		CLK_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(_MASK)
>   };
>   
> -static const struct state_dependent_clocks dce110_max_clks_by_state[] = {
> -/*ClocksStateInvalid - should not be used*/
> -{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
> -/*ClocksStateUltraLow - currently by HW design team not supposed to be used*/
> -{ .display_clk_khz = 352000, .pixel_clk_khz = 330000 },
> -/*ClocksStateLow*/
> -{ .display_clk_khz = 352000, .pixel_clk_khz = 330000 },
> -/*ClocksStateNominal*/
> -{ .display_clk_khz = 467000, .pixel_clk_khz = 400000 },
> -/*ClocksStatePerformance*/
> -{ .display_clk_khz = 643000, .pixel_clk_khz = 400000 } };
> -
>   static int determine_sclk_from_bounding_box(
>   		const struct dc *dc,
>   		int required_sclk)
> @@ -281,10 +269,6 @@ void dce110_clk_mgr_construct(
>   {
>   	dce_clk_mgr_construct(ctx, clk_mgr);
>   
> -	memcpy(clk_mgr->max_clks_by_state,
> -		dce110_max_clks_by_state,
> -		sizeof(dce110_max_clks_by_state));
> -
>   	clk_mgr->regs = &disp_clk_regs;
>   	clk_mgr->clk_mgr_shift = &disp_clk_shift;
>   	clk_mgr->clk_mgr_mask = &disp_clk_mask;
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
> index 0f3f8df4df96a..08ed6f88025fa 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
> @@ -53,19 +53,6 @@ static const struct clk_mgr_mask disp_clk_mask = {
>   		CLK_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(_MASK)
>   };
>   
> -static const struct state_dependent_clocks dce112_max_clks_by_state[] = {
> -/*ClocksStateInvalid - should not be used*/
> -{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
> -/*ClocksStateUltraLow - currently by HW design team not supposed to be used*/
> -{ .display_clk_khz = 389189, .pixel_clk_khz = 346672 },
> -/*ClocksStateLow*/
> -{ .display_clk_khz = 459000, .pixel_clk_khz = 400000 },
> -/*ClocksStateNominal*/
> -{ .display_clk_khz = 667000, .pixel_clk_khz = 600000 },
> -/*ClocksStatePerformance*/
> -{ .display_clk_khz = 1132000, .pixel_clk_khz = 600000 } };
> -
> -
>   //TODO: remove use the two broken down functions
>   int dce112_set_clock(struct clk_mgr *clk_mgr_base, int requested_clk_khz)
>   {
> @@ -202,10 +189,6 @@ void dce112_clk_mgr_construct(
>   {
>   	dce_clk_mgr_construct(ctx, clk_mgr);
>   
> -	memcpy(clk_mgr->max_clks_by_state,
> -		dce112_max_clks_by_state,
> -		sizeof(dce112_max_clks_by_state));
> -
>   	clk_mgr->regs = &disp_clk_regs;
>   	clk_mgr->clk_mgr_shift = &disp_clk_shift;
>   	clk_mgr->clk_mgr_mask = &disp_clk_mask;
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce120/dce120_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce120/dce120_clk_mgr.c
> index c9ba7b3fd2c32..f8ef3a4710fc2 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce120/dce120_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce120/dce120_clk_mgr.c
> @@ -32,18 +32,6 @@
>   #include "dce100/dce_clk_mgr.h"
>   #include "dce120/dce120_hwseq.h"
>   
> -static const struct state_dependent_clocks dce120_max_clks_by_state[] = {
> -/*ClocksStateInvalid - should not be used*/
> -{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
> -/*ClocksStateUltraLow - currently by HW design team not supposed to be used*/
> -{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
> -/*ClocksStateLow*/
> -{ .display_clk_khz = 460000, .pixel_clk_khz = 400000 },
> -/*ClocksStateNominal*/
> -{ .display_clk_khz = 670000, .pixel_clk_khz = 600000 },
> -/*ClocksStatePerformance*/
> -{ .display_clk_khz = 1133000, .pixel_clk_khz = 600000 } };
> -
>   /**
>    * dce121_clock_patch_xgmi_ss_info() - Save XGMI spread spectrum info
>    * @clk_mgr_dce: clock manager internal structure
> @@ -129,10 +117,6 @@ void dce120_clk_mgr_construct(struct dc_context *ctx, struct clk_mgr_internal *c
>   {
>   	dce_clk_mgr_construct(ctx, clk_mgr);
>   
> -	memcpy(clk_mgr->max_clks_by_state,
> -		dce120_max_clks_by_state,
> -		sizeof(dce120_max_clks_by_state));
> -
>   	clk_mgr->base.dprefclk_khz = 600000;
>   	clk_mgr->base.funcs = &dce120_funcs;
>   }
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
> index e01bf6bd7f3f4..5accf076a3747 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
> @@ -429,8 +429,6 @@ struct clk_mgr_internal {
>   	const struct clk_mgr_shift *clk_mgr_shift;
>   	const struct clk_mgr_mask *clk_mgr_mask;
>   
> -	struct state_dependent_clocks max_clks_by_state[DM_PP_CLOCKS_MAX_STATES];
> -
>   	/*TODO: figure out which of the below fields should be here vs in asic specific portion */
>   	/* Cache the status of DFS-bypass feature*/
>   	bool dfs_bypass_enabled;

