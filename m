Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E5FFED3C9
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 14:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB22B10F5A8;
	Fri, 24 Apr 2026 14:19:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="lHLeo3k6";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30C7910F5A8
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 14:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
 To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oEFEPo1h9NXVrcr8a8UK8q/4AoIr3Tz99mdMHrhUp2o=; b=lHLeo3k6Oe2bLXuW57ExCZZRQt
 aGMSCaEe6A2aTkd2R72CLLsykph6vYE1Dozxs+vyp0kuu4fE9nvpML7cKbMYk1Qkzu3a+U9Yk7Gow
 jhQkxz3neg0n2+f6p2h6UU+7cAtWN58JotxbXIK5psRNG5mG+NZHJXbOngO/qaSs3yQnjvyJqUH9V
 PdwDk6Whz0dDmna5TpelTfHAfM15G0JWwDX8wXmQOj00gfnOqd13ik1MRdRFmdKXK8pVkBE1VSOHh
 W9fxHDwwyOqwLrNrS1ve8I9QD9726BNTs/UkBVfx1Im+t8E+3pjsz2Kl6HiZJgrIdd9xEte50SYui
 3eapi/xw==;
Received: from [186.208.73.228] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wGHNc-001d6c-Gi; Fri, 24 Apr 2026 16:19:39 +0200
Message-ID: <1abaa821-5477-4bfb-9731-9820f303f22f@igalia.com>
Date: Fri, 24 Apr 2026 11:19:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Melissa Wen <mwen@igalia.com>
Subject: Re: [PATCH 01/14] drm/amd/display: Delete unimplemented
 dm_pp_apply_power_level_change_request()
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>
References: <20260423191519.73127-1-timur.kristof@gmail.com>
 <20260423191519.73127-2-timur.kristof@gmail.com>
Content-Language: en-US
In-Reply-To: <20260423191519.73127-2-timur.kristof@gmail.com>
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
> dm_pp_apply_power_level_change_request() was called from old
> DCE clock manager implementations on DCE6, 8, 10, 11.2
> but has not been implemented ever since the beginning of DC.
>
> Affected GPUs have been working fine without that implementation
> for many years. Let's delete it now.
>
> Signed-off-by: Timur Kristóf<timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c | 8 --------
>   .../gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c  | 9 ---------
>   .../drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c   | 9 ---------
>   .../drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c   | 9 ---------
>   drivers/gpu/drm/amd/display/dc/dm_services.h             | 4 ----
>   5 files changed, 39 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> index 11b2ea6edf953..17f42201ab862 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> @@ -417,14 +417,6 @@ bool dm_pp_notify_wm_clock_changes(
>   	return false;
>   }
>   
> -bool dm_pp_apply_power_level_change_request(
> -	const struct dc_context *ctx,
> -	struct dm_pp_power_level_change_request *level_change_req)
Hi Timur,
> -{
> -	/* TODO: to be implemented */
I feel a little uneasy about removing all this infrastructure with this 
series, as AFAIU, it could be avoided by implementing this TODO (?)
Any idea if AMD has this code somewhere that could be upstreamed, or did 
it end up in the firmware?

BTW, Looks like `struct dm_pp_power_level_change_request` also becomes 
unused with this change, right?

Melissa
> -	return false;
> -}
> -
>   bool dm_pp_apply_clock_for_voltage_request(
>   	const struct dc_context *ctx,
>   	struct dm_pp_clock_for_voltage_req *clock_for_voltage_req)
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> index 6d41df52d7c9b..ffb70120362e7 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> @@ -431,19 +431,10 @@ static void dce_update_clocks(struct clk_mgr *clk_mgr_base,
>   			bool safe_to_lower)
>   {
>   	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
> -	struct dm_pp_power_level_change_request level_change_req;
>   	const int max_disp_clk =
>   		clk_mgr_dce->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
>   	int patched_disp_clk = MIN(max_disp_clk, context->bw_ctx.bw.dce.dispclk_khz);
>   
> -	level_change_req.power_level = dce_get_required_clocks_state(clk_mgr_base, context);
> -	/* get max clock state from PPLIB */
> -	if ((level_change_req.power_level < clk_mgr_dce->cur_min_clks_state && safe_to_lower)
> -			|| level_change_req.power_level > clk_mgr_dce->cur_min_clks_state) {
> -		if (dm_pp_apply_power_level_change_request(clk_mgr_base->ctx, &level_change_req))
> -			clk_mgr_dce->cur_min_clks_state = level_change_req.power_level;
> -	}
> -
>   	if (should_set_clock(safe_to_lower, patched_disp_clk, clk_mgr_base->clks.dispclk_khz)) {
>   		patched_disp_clk = dce_set_clock(clk_mgr_base, patched_disp_clk);
>   		clk_mgr_base->clks.dispclk_khz = patched_disp_clk;
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
> index 13296c6ec08f4..ae922f1a31ff8 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
> @@ -257,21 +257,12 @@ static void dce11_update_clocks(struct clk_mgr *clk_mgr_base,
>   			bool safe_to_lower)
>   {
>   	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
> -	struct dm_pp_power_level_change_request level_change_req;
>   	int patched_disp_clk = context->bw_ctx.bw.dce.dispclk_khz;
>   
>   	/*TODO: W/A for dal3 linux, investigate why this works */
>   	if (!clk_mgr_dce->dfs_bypass_active)
>   		patched_disp_clk = patched_disp_clk * 115 / 100;
>   
> -	level_change_req.power_level = dce_get_required_clocks_state(clk_mgr_base, context);
> -	/* get max clock state from PPLIB */
> -	if ((level_change_req.power_level < clk_mgr_dce->cur_min_clks_state && safe_to_lower)
> -			|| level_change_req.power_level > clk_mgr_dce->cur_min_clks_state) {
> -		if (dm_pp_apply_power_level_change_request(clk_mgr_base->ctx, &level_change_req))
> -			clk_mgr_dce->cur_min_clks_state = level_change_req.power_level;
> -	}
> -
>   	if (should_set_clock(safe_to_lower, patched_disp_clk, clk_mgr_base->clks.dispclk_khz)) {
>   		context->bw_ctx.bw.dce.dispclk_khz = dce_set_clock(clk_mgr_base, patched_disp_clk);
>   		clk_mgr_base->clks.dispclk_khz = patched_disp_clk;
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
> index 1f36ad8a7de46..48393c69735b6 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
> @@ -193,21 +193,12 @@ static void dce112_update_clocks(struct clk_mgr *clk_mgr_base,
>   			bool safe_to_lower)
>   {
>   	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
> -	struct dm_pp_power_level_change_request level_change_req;
>   	int patched_disp_clk = context->bw_ctx.bw.dce.dispclk_khz;
>   
>   	/*TODO: W/A for dal3 linux, investigate why this works */
>   	if (!clk_mgr_dce->dfs_bypass_active)
>   		patched_disp_clk = patched_disp_clk * 115 / 100;
>   
> -	level_change_req.power_level = dce_get_required_clocks_state(clk_mgr_base, context);
> -	/* get max clock state from PPLIB */
> -	if ((level_change_req.power_level < clk_mgr_dce->cur_min_clks_state && safe_to_lower)
> -			|| level_change_req.power_level > clk_mgr_dce->cur_min_clks_state) {
> -		if (dm_pp_apply_power_level_change_request(clk_mgr_base->ctx, &level_change_req))
> -			clk_mgr_dce->cur_min_clks_state = level_change_req.power_level;
> -	}
> -
>   	if (should_set_clock(safe_to_lower, patched_disp_clk, clk_mgr_base->clks.dispclk_khz)) {
>   		patched_disp_clk = dce112_set_clock(clk_mgr_base, patched_disp_clk);
>   		clk_mgr_base->clks.dispclk_khz = patched_disp_clk;
> diff --git a/drivers/gpu/drm/amd/display/dc/dm_services.h b/drivers/gpu/drm/amd/display/dc/dm_services.h
> index fbbf9c757b3c3..1395d36bfabe9 100644
> --- a/drivers/gpu/drm/amd/display/dc/dm_services.h
> +++ b/drivers/gpu/drm/amd/display/dc/dm_services.h
> @@ -224,10 +224,6 @@ bool dm_pp_apply_display_requirements(
>   	const struct dc_context *ctx,
>   	const struct dm_pp_display_configuration *pp_display_cfg);
>   
> -bool dm_pp_apply_power_level_change_request(
> -	const struct dc_context *ctx,
> -	struct dm_pp_power_level_change_request *level_change_req);
> -
>   bool dm_pp_apply_clock_for_voltage_request(
>   	const struct dc_context *ctx,
>   	struct dm_pp_clock_for_voltage_req *clock_for_voltage_req);

