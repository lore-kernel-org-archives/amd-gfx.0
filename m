Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4482EC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Nov 2022 15:39:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3FE310E15D;
	Thu, 10 Nov 2022 15:39:11 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4064510E15D
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Nov 2022 15:39:06 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id BAEDA619C2;
 Thu, 10 Nov 2022 15:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5269AC433C1;
 Thu, 10 Nov 2022 15:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1668094745;
 bh=8DTgyfI8LLWUcv16sI62PXZd5elojIuSg3xCFA7lxIc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KszZd77mDZfYVzAA6+8qVTtUhA6CW5qT1YJskVodw/2iHNuGC4VqHLjQpg9kwpUk2
 9/JgdpXKgM2mNvJOMlIvoz+4H7TG5KKaxlRYDXb8LKjV5Yosnflc6AEgRnjAUH5zgM
 MxX7Of/fmO0QTjaK5ZuARhQLFcPeaNZCzYMkomWo+dKIidS5czikU9QqekWqG5d+6U
 i4/TujDDtMz8Ab5yzb52HEAlkKFg80mma4cwsitTAjjWp6Xbtba6LN9oTPOv0ZfHPI
 OmcI+qnTsv1FB8GLm9z3gTcE9NzBhG/eCPdpLvXRmsju3L3ASTSf9YXyGrEF5mYcKG
 XqTCAQP1QTB8A==
Date: Thu, 10 Nov 2022 08:39:02 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Alan Liu <HaoPing.Liu@amd.com>
Subject: Re: [PATCH 11/22] drm/amd/display: Disable phantom OTG after enable
 for plane disable
Message-ID: <Y20bFlEcKX3gbge8@dev-arch.thelio-3990X>
References: <20221102160117.506511-1-HaoPing.Liu@amd.com>
 <20221102160117.506511-12-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102160117.506511-12-HaoPing.Liu@amd.com>
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alan,

On Thu, Nov 03, 2022 at 12:01:06AM +0800, Alan Liu wrote:
> From: Alvin Lee <Alvin.Lee2@amd.com>
> 
> [Description]
> - Need to disable phantom OTG after it's enabled
>   in order to restore it to it's original state.
> - If it's enabled and then an MCLK switch comes in
>   we may not prefetch the correct data since the phantom
>   OTG could already be in the middle of the frame.
> 
> Reviewed-by: Jun Lei <Jun.Lei@amd.com>
> Acked-by: Alan Liu <HaoPing.Liu@amd.com>
> Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c           | 14 +++++++++++++-
>  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c  |  8 ++++++++
>  .../drm/amd/display/dc/inc/hw/timing_generator.h   |  1 +
>  3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index da808996e21d..9c3704c4d7e4 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1055,6 +1055,7 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
>  	struct dc_state *dangling_context = dc_create_state(dc);
>  	struct dc_state *current_ctx;
>  	struct pipe_ctx *pipe;
> +	struct timing_generator *tg;
>  
>  	if (dangling_context == NULL)
>  		return;
> @@ -1098,6 +1099,7 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
>  
>  		if (should_disable && old_stream) {
>  			pipe = &dc->current_state->res_ctx.pipe_ctx[i];
> +			tg = pipe->stream_res.tg;
>  			/* When disabling plane for a phantom pipe, we must turn on the
>  			 * phantom OTG so the disable programming gets the double buffer
>  			 * update. Otherwise the pipe will be left in a partially disabled
> @@ -1105,7 +1107,8 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
>  			 * again for different use.
>  			 */
>  			if (old_stream->mall_stream_config.type == SUBVP_PHANTOM) {
> -				pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
> +				if (tg->funcs->enable_crtc)
> +					tg->funcs->enable_crtc(tg);
>  			}
>  			dc_rem_all_planes_for_stream(dc, old_stream, dangling_context);
>  			disable_all_writeback_pipes_for_stream(dc, old_stream, dangling_context);
> @@ -1122,6 +1125,15 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
>  				dc->hwss.interdependent_update_lock(dc, dc->current_state, false);
>  				dc->hwss.post_unlock_program_front_end(dc, dangling_context);
>  			}
> +			/* We need to put the phantom OTG back into it's default (disabled) state or we
> +			 * can get corruption when transition from one SubVP config to a different one.
> +			 * The OTG is set to disable on falling edge of VUPDATE so the plane disable
> +			 * will still get it's double buffer update.
> +			 */
> +			if (old_stream->mall_stream_config.type == SUBVP_PHANTOM) {
> +				if (tg->funcs->disable_phantom_crtc)
> +					tg->funcs->disable_phantom_crtc(tg);
> +			}
>  		}
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
> index 2b33eeb213e2..2ee798965bc2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
> @@ -167,6 +167,13 @@ static void optc32_phantom_crtc_post_enable(struct timing_generator *optc)
>  	REG_WAIT(OTG_CLOCK_CONTROL, OTG_BUSY, 0, 1, 100000);
>  }
>  
> +static void optc32_disable_phantom_otg(struct timing_generator *optc)
> +{
> +	struct optc *optc1 = DCN10TG_FROM_TG(optc);
> +
> +	REG_UPDATE(OTG_CONTROL, OTG_MASTER_EN, 0);
> +}
> +
>  static void optc32_set_odm_bypass(struct timing_generator *optc,
>  		const struct dc_crtc_timing *dc_crtc_timing)
>  {
> @@ -260,6 +267,7 @@ static struct timing_generator_funcs dcn32_tg_funcs = {
>  		.enable_crtc = optc32_enable_crtc,
>  		.disable_crtc = optc32_disable_crtc,
>  		.phantom_crtc_post_enable = optc32_phantom_crtc_post_enable,
> +		.disable_phantom_crtc = optc32_disable_phantom_otg,
>  		/* used by enable_timing_synchronization. Not need for FPGA */
>  		.is_counter_moving = optc1_is_counter_moving,
>  		.get_position = optc1_get_position,
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> index 65f18f9dad34..43eb61961e0f 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> @@ -184,6 +184,7 @@ struct timing_generator_funcs {
>  	bool (*disable_crtc)(struct timing_generator *tg);
>  #ifdef CONFIG_DRM_AMD_DC_DCN
>  	void (*phantom_crtc_post_enable)(struct timing_generator *tg);
> +	void (*disable_phantom_crtc)(struct timing_generator *tg);
>  #endif
>  	bool (*immediate_disable_crtc)(struct timing_generator *tg);
>  	bool (*is_counter_moving)(struct timing_generator *tg);
> -- 
> 2.25.1
> 
> 

This breaks the build without CONFIG_DRM_AMD_DC_DCN:

  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1134:20: error: no member named 'disable_phantom_crtc' in 'struct timing_generator_funcs'
                                  if (tg->funcs->disable_phantom_crtc)
                                      ~~~~~~~~~  ^
  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:1135:17: error: no member named 'disable_phantom_crtc' in 'struct timing_generator_funcs'
                                          tg->funcs->disable_phantom_crtc(tg);
                                          ~~~~~~~~~  ^
  2 errors generated.

Cheers,
Nathan
