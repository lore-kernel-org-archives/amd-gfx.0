Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8910ACA0EDC
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 22:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3264410E64D;
	Tue, 12 Aug 2025 22:39:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Pbza4e8Y";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABAD210E64D
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 22:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kg/n1eZVDrkZImQzzHM85QvcoETYEiAQPJgtSbMacS4=; b=Pbza4e8YrLG8VC8m2EooY21ciN
 PpJVuR34rGcpjxAInmk743ddkFjQFXSe6w7sirG9RKUhFZWLIZfPSuv78GcgbA7FAqW8OxpBx5H5L
 PIpUtzSleYH0Sr+YpQxA36ROKKVi3F5kA57fiYukEUur3V3hy0H7AgEuAlklBKGKdYL2f6oOFtrSm
 uA6A4Bi3gX+Bh3B2t1lQkj2gLuaRqQOCF3RxgwrxX/Gm84G6pP6Fp62xzHS2WUkk+lWkB+owRXD20
 kH7SUlIQxev26AWNYt9obwLAjQt02ds2RKZBP5XHtQ/cGWz6SgYKnFFq99MwKwDNHkuwGplOvBKeA
 E9z1/Rcg==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1ulxeU-00DQgF-VV; Wed, 13 Aug 2025 00:39:31 +0200
Date: Tue, 12 Aug 2025 16:39:28 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 4/7] drm/amd/display: Fill display clock and vblank time
 in dce110_fill_display_configs
Message-ID: <s42h7f5liphxfwglikpb7sgcsqnew7s22xieztoy3exy266366@tfso4xdthi75>
References: <20250731094352.29528-1-timur.kristof@gmail.com>
 <20250731094352.29528-5-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250731094352.29528-5-timur.kristof@gmail.com>
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
> Also needed by DCE 6.
> This way the code that gathers this info can be shared between
> different DCE versions and doesn't have to be repeated.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  .../drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c    |  2 --
>  .../drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c | 10 +++-------
>  .../drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c   |  2 --
>  3 files changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> index 69e9540f553b..17a8b46b0818 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> @@ -386,8 +386,6 @@ static void dce_pplib_apply_display_requirements(
>  {
>  	struct dm_pp_display_configuration *pp_display_cfg = &context->pp_display_cfg;
>  
> -	pp_display_cfg->avail_mclk_switch_time_us = dce110_get_min_vblank_time_us(context);
> -
>  	dce110_fill_display_configs(context, pp_display_cfg);
>  
>  	if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, sizeof(*pp_display_cfg)) !=  0)
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
> index baeac8f1c04f..13cf415e38e5 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
> @@ -124,6 +124,9 @@ void dce110_fill_display_configs(
>  	int j;
>  	int num_cfgs = 0;
>  
> +	pp_display_cfg->avail_mclk_switch_time_us = dce110_get_min_vblank_time_us(context);
> +	pp_display_cfg->disp_clk_khz = dc->clk_mgr->clks.dispclk_khz;
> +	pp_display_cfg->avail_mclk_switch_time_in_disp_active_us = 0;
>  	pp_display_cfg->crtc_index = dc->res_pool->res_cap->num_timing_generator;
>  
>  	for (j = 0; j < context->stream_count; j++) {
> @@ -243,13 +246,6 @@ void dce11_pplib_apply_display_requirements(
>  	pp_display_cfg->min_engine_clock_deep_sleep_khz
>  			= context->bw_ctx.bw.dce.sclk_deep_sleep_khz;
>  
> -	pp_display_cfg->avail_mclk_switch_time_us =
> -						dce110_get_min_vblank_time_us(context);
> -	/* TODO: dce11.2*/
> -	pp_display_cfg->avail_mclk_switch_time_in_disp_active_us = 0;
> -
> -	pp_display_cfg->disp_clk_khz = dc->clk_mgr->clks.dispclk_khz;
> -
>  	dce110_fill_display_configs(context, pp_display_cfg);
>  
>  	if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, sizeof(*pp_display_cfg)) !=  0)
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> index cfd7309f2c6a..7044b437fe9d 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> @@ -109,8 +109,6 @@ static void dce60_pplib_apply_display_requirements(
>  {
>  	struct dm_pp_display_configuration *pp_display_cfg = &context->pp_display_cfg;
>  
> -	pp_display_cfg->avail_mclk_switch_time_us = dce110_get_min_vblank_time_us(context);
> -
>  	dce110_fill_display_configs(context, pp_display_cfg);
>  
>  	if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, sizeof(*pp_display_cfg)) !=  0)
> -- 
> 2.50.1
>

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com> 

-- 
Rodrigo Siqueira
