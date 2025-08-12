Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3356ACA0EDC
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 22:32:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D308810E197;
	Tue, 12 Aug 2025 22:32:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="d88+8RsS";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B24410E197
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 22:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YLnqQhaoLMZpfHtlP14ZPe9gWjZNFSLrXzqj4guovEA=; b=d88+8RsS4ccvyBb5ec+kQjRONz
 KwFt5RdQcXNvcSACyUDiwDfXs10dC//gaHDEpZ6GVZqsJkTuRcLV+dTCDEoWsXNsARZH+Mpv2Cfwl
 IjbKO9C8y9fQTAEzoTQM3UYwVURVJrt51mu/17IkBRftJLEumlqyvI/jjvcINU9lcyTI5MrBxogcp
 iuW0ho1N3b0Z9dG6QNPw3MvLU1NN7pyTpubDL8MRQY7vzGWlkp9k7pSRRWVr8mvcyAU5kOLAbwEW4
 O0MpL0oStMDN5vwmYsBaEP9FD4CSDESMnGohKB24s5WYDo2Qcf7DPB4r5/EjGbykkmWzfkqWGoVWR
 JqzFUtfw==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1ulxXN-00DQaE-Kv; Wed, 13 Aug 2025 00:32:10 +0200
Date: Tue, 12 Aug 2025 16:32:06 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Hung <alex.hung@amd.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH 3/7] drm/amd/display: Find first CRTC and its line time
 in dce110_fill_display_configs
Message-ID: <qykbkw3xyj7esqzhrfnh6nlubs7m27ditv4zd6jxiuoekhthnz@vrojyhtydw47>
References: <20250731094352.29528-1-timur.kristof@gmail.com>
 <20250731094352.29528-4-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250731094352.29528-4-timur.kristof@gmail.com>
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
> dce110_fill_display_configs is shared between DCE 6-11, and
> finding the first CRTC and its line time is relevant to DCE 6 too.
> Move the code to find it from DCE 11 specific code.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  .../dc/clk_mgr/dce110/dce110_clk_mgr.c        | 30 ++++++++++++-------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
> index f8409453434c..baeac8f1c04f 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
> @@ -120,9 +120,12 @@ void dce110_fill_display_configs(
>  	const struct dc_state *context,
>  	struct dm_pp_display_configuration *pp_display_cfg)
>  {
> +	struct dc *dc = context->clk_mgr->ctx->dc;
>  	int j;
>  	int num_cfgs = 0;
>  
> +	pp_display_cfg->crtc_index = dc->res_pool->res_cap->num_timing_generator;
> +
>  	for (j = 0; j < context->stream_count; j++) {
>  		int k;
>  
> @@ -164,6 +167,23 @@ void dce110_fill_display_configs(
>  		cfg->v_refresh /= stream->timing.h_total;
>  		cfg->v_refresh = (cfg->v_refresh + stream->timing.v_total / 2)
>  							/ stream->timing.v_total;
> +
> +		/* Find first CRTC index and calculate its line time.
> +		 * This is necessary for DPM on SI GPUs.
> +		 */
> +		if (cfg->pipe_idx < pp_display_cfg->crtc_index) {
> +			const struct dc_crtc_timing *timing =
> +				&context->streams[0]->timing;
> +
> +			pp_display_cfg->crtc_index = cfg->pipe_idx;
> +			pp_display_cfg->line_time_in_us =
> +				timing->h_total * 10000 / timing->pix_clk_100hz;
> +		}
> +	}
> +
> +	if (!num_cfgs) {
> +		pp_display_cfg->crtc_index = 0;
> +		pp_display_cfg->line_time_in_us = 0;
>  	}
>  
>  	pp_display_cfg->display_count = num_cfgs;
> @@ -232,16 +252,6 @@ void dce11_pplib_apply_display_requirements(
>  
>  	dce110_fill_display_configs(context, pp_display_cfg);
>  
> -	/* TODO: is this still applicable?*/
> -	if (pp_display_cfg->display_count == 1) {
> -		const struct dc_crtc_timing *timing =
> -			&context->streams[0]->timing;
> -
> -		pp_display_cfg->crtc_index =
> -			pp_display_cfg->disp_configs[0].pipe_idx;
> -		pp_display_cfg->line_time_in_us = timing->h_total * 10000 / timing->pix_clk_100hz;
> -	}
> -
>  	if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, sizeof(*pp_display_cfg)) !=  0)
>  		dm_pp_apply_display_requirements(dc->ctx, pp_display_cfg);
>  }
> -- 
> 2.50.1
>

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com> 

-- 
Rodrigo Siqueira
