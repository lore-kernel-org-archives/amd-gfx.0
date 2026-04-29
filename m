Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B69FF8875
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 20:03:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32C2310F151;
	Wed, 29 Apr 2026 20:03:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="SdEgYyNd";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67E2A10F151
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 20:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aNb49UJ78D7UNISZZR9j6LOgljRFanSrMof4HNayWSk=; b=SdEgYyNdzOEp2b7l/INuGOZBpZ
 Z6ltx7/JJV1BBxw9gJmBLMBi0P6P1ZLtsqnXny+dSqf1D4yhtUw3LijT98vstWpy3VqRlaPx91lm1
 aK7NnnE77JIgqRCXy3DFIeICD+AorK/hr+7fepWbzj8iJf9ncbkLqLYCb/DIJ3v4LsPAsgjcqesEH
 DDtFPp3jQXqx69K0a9GpQPLjGRpZ9441k5YWhBvXhT44T8NjGz1mOVsTgk+JfKY/rhKQ2tSLP8FKB
 1WMw5D1WM4++a9RxOxrLf8xkZrQkjoektKSAzmI5HBzk8OuEFLjlaYRS5sbe20ILihyOTvv+Adr96
 egr4i+bg==;
Received: from [186.208.73.228] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wIB7e-0046da-Kn; Wed, 29 Apr 2026 22:03:02 +0200
Message-ID: <48ae398c-f679-4b35-bd2a-0b4c177cad5c@igalia.com>
Date: Wed, 29 Apr 2026 17:02:57 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
From: Melissa Wen <mwen@igalia.com>
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
Reviewed-by: Melissa Wen <mwen@igalia.com>
>
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
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
> -{
> -	/* TODO: to be implemented */
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

