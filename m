Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780B8CA0EDC
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 22:11:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 024BE10E002;
	Tue, 12 Aug 2025 22:11:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="fAGQm3sE";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27CD610E002
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 22:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cdRRvfBljJ3TyvrAAGB7tE+yTvq4knEomABhA2J3tbo=; b=fAGQm3sEWnN2PEfvBsPq2J1U+M
 g/enz9kV48LddyTHbbD1sZeOZNOhecmP/lzz+HxRV7lF/ubRSSr6NfrUw/rIOHqjM/l0s9RziR20J
 mLwu3Ke5KU6FrfhfVne4a6GewvzxntunzUn/FXg5aY651pXhQxc9s/q6aRDScQe7WQXsmEdx2ivhr
 T7D4Vejx4ddaIOXfHqKZuGlXQ8b1KdQ9F04keD7PjNe+SDPSra/bbc77JclaBxaMyV3hktFdPsyOH
 hr/m5/ZTbdsrwN/YIIOvIib2t2ZO8zziHXzcMbGvTuOWqZdAEATp9xOdFTqlAOBNkllBy+As9Sob4
 AI9gBMsg==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1ulxDN-00DQEG-IQ; Wed, 13 Aug 2025 00:11:29 +0200
Date: Tue, 12 Aug 2025 16:11:25 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Hung <alex.hung@amd.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH 1/7] drm/amd/display: Don't overclock DCE 6 by 15%
Message-ID: <kgj7drsqx2rrpina4wkmp6t5ibubcoszsvzeelkcfoixkjybcq@adevfxi2x6jr>
References: <20250731094352.29528-1-timur.kristof@gmail.com>
 <20250731094352.29528-2-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250731094352.29528-2-timur.kristof@gmail.com>
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
> The extra 15% clock was added as a workaround for a Polaris issue
> which uses DCE 11, and should not have been used on DCE 6 which
> is already hardcoded to the highest possible display clock.
> Unfortunately, the extra 15% was mistakenly copied and kept
> even on code paths which don't affect Polaris.
> 
> This commit fixes that and also adds a check to make sure
> not to exceed the maximum DCE 6 display clock.
> 
> Fixes: 8cd61c313d8b ("drm/amd/display: Raise dispclk value for Polaris")
> Fixes: dc88b4a684d2 ("drm/amd/display: make clk mgr soc specific")
> Fixes: 3ecb3b794e2c ("drm/amd/display: dc/clk_mgr: add support for SI parts (v2)")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  .../gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c  | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> index 0267644717b2..cfd7309f2c6a 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> @@ -123,11 +123,9 @@ static void dce60_update_clocks(struct clk_mgr *clk_mgr_base,
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

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com> 

-- 
Rodrigo Siqueira
