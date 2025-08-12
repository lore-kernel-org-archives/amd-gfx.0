Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A332CA0EDC
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 22:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9211B10E008;
	Tue, 12 Aug 2025 22:18:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="HOyJDpXy";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C8F910E008
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 22:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ssqIHVaNNgsHYGUqLYg4Z6mUg1+JldOaQTNaPiR0Wo8=; b=HOyJDpXyxCYy1FOhRHU7eBkr0r
 dgmFPGauz2AxL6S4veZ9gWeUWwc9Y3dwBjymuOD0aB84/4rVuSFjlJj2PVRk0BnDipIr/xImAJ/xG
 ESI02/oOMYdsibAZkQ8zIqjdR2umwf0NsmHMMUvzpk9u7K8yRDNWeRTygKwV4hV+yaIGgZUpfTulJ
 zO1WGOy2q3sgQ7q2YUflog87+t63jvmp0Drva5sRXPW43BE8Z39ISDL+Kf9v6kxlMdDV3HKwmeXFG
 SqnITfg3J1viITOlkr4itiLGFXtjHs+u0fwuMeZHHyqduchwXZuGUf5jC9Dm/kOWK73FQH0vAG5Ga
 py+edPyg==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1ulxKB-00DQMS-IH; Wed, 13 Aug 2025 00:18:31 +0200
Date: Tue, 12 Aug 2025 16:18:28 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Hung <alex.hung@amd.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: Re: [PATCH 2/7] drm/amd/display: Adjust DCE 8-10 clock, don't
 overclock by 15%
Message-ID: <2ubkjplfooxbord3xqrogfjdjrea2v23py2r26clc7pdlmzg25@3ka54wmipmf7>
References: <20250731094352.29528-1-timur.kristof@gmail.com>
 <20250731094352.29528-3-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250731094352.29528-3-timur.kristof@gmail.com>
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

On 07/31, Timur Kristóf wrote:
> Adjust the nominal (and performance) clocks for DCE 8-10,
> and set them to 625 MHz, which is the value used by the legacy
> display code in amdgpu_atombios_get_clock_info.
> 
> This was tested with Hawaii, Tonga and Fiji.
> These GPUs can output 4K 60Hz (10-bit depth) at 625 MHz.
> 
> The extra 15% clock was added as a workaround for a Polaris issue
> which uses DCE 11, and should not have been used on DCE 8-10 which
> are already hardcoded to the highest possible display clock.
> Unfortunately, the extra 15% was mistakenly copied and kept
> even on code paths which don't affect Polaris.
> 
> This commit fixes that and also	adds a check to	make sure
> not to exceed the maximum DCE 8-10 display clock.
> 
> Fixes: 8cd61c313d8b ("drm/amd/display: Raise dispclk value for Polaris")
> Fixes: dc88b4a684d2 ("drm/amd/display: make clk mgr soc specific")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> 
> x
> ---
>  .../drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c  | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> index 26feefbb8990..69e9540f553b 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> @@ -72,9 +72,9 @@ static const struct state_dependent_clocks dce80_max_clks_by_state[] = {
>  /* ClocksStateLow */
>  { .display_clk_khz = 352000, .pixel_clk_khz = 330000},
>  /* ClocksStateNominal */
> -{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 },
> +{ .display_clk_khz = 625000, .pixel_clk_khz = 400000 },
>  /* ClocksStatePerformance */
> -{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 } };
> +{ .display_clk_khz = 625000, .pixel_clk_khz = 400000 } };
>  
>  int dentist_get_divider_from_did(int did)
>  {
> @@ -400,11 +400,9 @@ static void dce_update_clocks(struct clk_mgr *clk_mgr_base,
>  {
>  	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
>  	struct dm_pp_power_level_change_request level_change_req;
> -	int patched_disp_clk = context->bw_ctx.bw.dce.dispclk_khz;
> -
> -	/*TODO: W/A for dal3 linux, investigate why this works */
> -	if (!clk_mgr_dce->dfs_bypass_active)
> -		patched_disp_clk = patched_disp_clk * 115 / 100;
> +	const int max_disp_clk =
> +		clk_mgr_dce->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
> +	int patched_disp_clk = MIN(max_disp_clk, context->bw_ctx.bw.dce.dispclk_khz);
>  
>  	level_change_req.power_level = dce_get_required_clocks_state(clk_mgr_base, context);
>  	/* get max clock state from PPLIB */
> -- 
> 2.50.1
>

Very nice patch.

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com> 

-- 
Rodrigo Siqueira
