Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A7BC87FCA
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 23:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B08710E189;
	Thu,  7 Aug 2025 23:31:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="aMPAiBvr";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ADAF10E189
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 23:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fQZVVEVI1AsfI9un4ymt8KPJEt8BWLqqpgOOJ/67hqE=; b=aMPAiBvrLE+iHi2W6eiQ/bQdgy
 FERSoWxLpFHJx6S9yDTuAzn/dMOQfwSs+WT0CLfIBBhHmOfa9MThwr9UZHGUCMTJIziKPPtrCI0VN
 0+UM6QItK+d4BUpwPdNzls2awp1PQIRzct7lN5aXM49d9dBdTcLtbdBgmsT1qXVFmatfpGKxoKCOM
 80KUOa5usYKCeEvst54lZKoyPljW7WSnxelMJr1C/5B50CebM6BPfRVoeF4/IwHXOpR9F5vtqhnZ3
 VRDRjSPy3ouEbQIeq1nRdVxSlMXi2zX13caDM+YRL0IY0xQ7feE+ES8yE0Dva98uIPPRst5eKXJjV
 fE0wOKrg==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1ukA4s-00BF8a-H0; Fri, 08 Aug 2025 01:31:18 +0200
Date: Thu, 7 Aug 2025 17:31:14 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix DP audio DTO1 clock source on DCE 6.
Message-ID: <xmdk2cncflqglv7jn5yrzkhhvnth5fxp6ekv7lnp5ruzpinhkv@5rxk6sj7fosd>
References: <20250802155153.6432-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250802155153.6432-1-timur.kristof@gmail.com>
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

On 08/02, Timur Kristóf wrote:
> On DCE 6, DP audio was not working. However, it worked when an
> HDMI monitor was also plugged in.
> 
> Looking at dce_aud_wall_dto_setup it seems that the main
> difference is that we use DTO1 when only DP is plugged in.
> 
> When programming DTO1, it uses audio_dto_source_clock_in_khz
> which is set from get_dp_ref_freq_khz
> 
> The dce60_get_dp_ref_freq_khz implementation looks incorrect,
> because DENTIST_DISPCLK_CNTL seems to be always zero on DCE 6,
> so it isn't usable.
> I compared dce60_get_dp_ref_freq_khz to the legacy display code,
> specifically dce_v6_0_audio_set_dto, and it turns out that in
> case of DCE 6, it needs to use the display clock. With that,
> DP audio started working on Pitcairn, Oland and Cape Verde.
> 
> However, it still didn't work on Tahiti. Despite having the
> same DCE version, Tahiti seems to have a different audio device.
> After some trial and error I realized that it works with the
> default display clock as reported by the VBIOS, not the current
> display clock.
> 
> The patch was tested on all four SI GPUs:
> 
> * Pitcairn (DCE 6.0)
> * Oland (DCE 6.4)
> * Cape Verde (DCE 6.0)
> * Tahiti (DCE 6.0 but different)
> 
> The testing was done on Samsung Odyssey G7 LS28BG700EPXEN on
> each of the above GPUs, at the following settings:
> 
> * 4K 60 Hz
> * 1080p 60 Hz
> * 1080p 144 Hz
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  .../display/dc/clk_mgr/dce60/dce60_clk_mgr.c  | 21 ++++++-------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> index 0267644717b2..883591706db9 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> @@ -83,22 +83,13 @@ static const struct state_dependent_clocks dce60_max_clks_by_state[] = {
>  static int dce60_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
>  {
>  	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
> -	int dprefclk_wdivider;
> -	int dp_ref_clk_khz;
> -	int target_div;
> +	struct dc_context *ctx = clk_mgr_base->ctx;
> +	int dp_ref_clk_khz = 0;
>  
> -	/* DCE6 has no DPREFCLK_CNTL to read DP Reference Clock source */
> -
> -	/* Read the mmDENTIST_DISPCLK_CNTL to get the currently
> -	 * programmed DID DENTIST_DPREFCLK_WDIVIDER*/
> -	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DPREFCLK_WDIVIDER, &dprefclk_wdivider);
> -
> -	/* Convert DENTIST_DPREFCLK_WDIVIDERto actual divider*/
> -	target_div = dentist_get_divider_from_did(dprefclk_wdivider);
> -
> -	/* Calculate the current DFS clock, in kHz.*/
> -	dp_ref_clk_khz = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
> -		* clk_mgr->base.dentist_vco_freq_khz) / target_div;
> +	if (ASIC_REV_IS_TAHITI_P(ctx->asic_id.hw_internal_rev))
> +		dp_ref_clk_khz = ctx->dc_bios->fw_info.default_display_engine_pll_frequency;
> +	else
> +		dp_ref_clk_khz = clk_mgr_base->clks.dispclk_khz;
>  
>  	return dce_adjust_dp_ref_freq_for_ss(clk_mgr, dp_ref_clk_khz);
>  }
> -- 
> 2.50.1
>

Very nice patch! I checked the mentioned functions, and it looks correct
to me.

I added other display folks for further review/validation. It could be a
good idea to include this patch in the next week's promotion.

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>

Thanks

-- 
Rodrigo Siqueira
