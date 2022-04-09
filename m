Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD2FC433EF
	for <amd-gfx@archiver.kernel.org>; Sat,  9 Apr 2022 20:10:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ECB810E409;
	Sat,  9 Apr 2022 20:10:41 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE21610E409
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 Apr 2022 20:10:38 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae90c.dynamic.kabel-deutschland.de
 [95.90.233.12])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0F87F61EA1928;
 Sat,  9 Apr 2022 22:10:37 +0200 (CEST)
Message-ID: <72ddfa04-0861-8dbc-0397-52c33b6c8391@molgen.mpg.de>
Date: Sat, 9 Apr 2022 22:10:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 12/20] drm/amd/display: Add odm seamless boot support
Content-Language: en-US
To: Pavle Kotarac <Pavle.Kotarac@amd.com>, Duncan Ma <duncan.ma@amd.com>
References: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
 <20220408171911.601615-13-Pavle.Kotarac@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220408171911.601615-13-Pavle.Kotarac@amd.com>
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Pavle, dear Duncan,


Thank you for the patch.

Am 08.04.22 um 19:19 schrieb Pavle Kotarac:
> From: Duncan Ma <Duncan.Ma@amd.com>
> 
> [WHY]
> Implement changes to transition from Pre-OS odm to

What is odm/ODM? Original Device Manufacturer?

> Post-OS odm support. Seamless boot case is also
> considered.

Please answer the question Why? better.

What is Post-OS odm support? Why are change to the transition needed?

What is seamless boot? Please add references.

> 
> [HOW]
> Revised validation logic when marking for seamless
> boot.

How is it revised exactly?

> Init resources accordingly when Pre-OS has
> odm enabled. Reset odm and det size when transitioning
> Pre-OS odm to Post-OS non-odm to avoid corruption.
> Apply logic to set odm accordingly upon commit.

I looked through the diff, but would love a more elaborate description 
of the implementation.

How was and can this tested?

Please reflow for 75 characters per line as textwidth.

> Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
> Signed-off-by: "Duncan Ma" <duncan.ma@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc.c      | 13 +++
>   .../gpu/drm/amd/display/dc/core/dc_resource.c | 82 ++++++++++++-------
>   drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
>   drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 +
>   .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 21 +++++
>   .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.c | 21 +++++
>   .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.h |  2 +
>   .../amd/display/dc/inc/hw/timing_generator.h  |  2 +
>   8 files changed, 115 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index c436db416708..c2fcd67bcc4d 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1569,11 +1569,24 @@ bool dc_validate_boot_timing(const struct dc *dc,
>   
>   	if (dc_is_dp_signal(link->connector_signal)) {
>   		unsigned int pix_clk_100hz;
> +		uint32_t numOdmPipes = 1;

Maybe add a comment, that the type is due to `get_optc_source` signature.

Why initialize it? get_optc_source seems to always assign a value to the 
passed variable.

Why CamelCase?

> +		uint32_t id_src[4] = {0};
>   
>   		dc->res_pool->dp_clock_source->funcs->get_pixel_clk_frequency_100hz(
>   			dc->res_pool->dp_clock_source,
>   			tg_inst, &pix_clk_100hz);
>   
> +		if (tg->funcs->get_optc_source)
> +			tg->funcs->get_optc_source(tg,
> +						&numOdmPipes, &id_src[0], &id_src[1]);
> +
> +		if (numOdmPipes == 2)
> +			pix_clk_100hz *= 2;
> +		if (numOdmPipes == 4)
> +			pix_clk_100hz *= 4;
> +
> +		// Note: In rare cases, HW pixclk may differ from crtc's pixclk
> +		// slightly due to rounding issues in 10 kHz units.

The comment could be added in a separate patch, and also the values be 
logged if they are different.

>   		if (crtc_timing->pix_clk_100hz != pix_clk_100hz)
>   			return false;
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index f5777a71f2f1..f292303b75a5 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -2120,6 +2120,8 @@ static int acquire_resource_from_hw_enabled_state(
>   {
>   	struct dc_link *link = stream->link;
>   	unsigned int i, inst, tg_inst = 0;
> +	uint32_t numPipes = 1;

Why CamelCase?

> +	uint32_t id_src[4] = {0};
>   
>   	/* Check for enabled DIG to identify enabled display */
>   	if (!link->link_enc->funcs->is_dig_enabled(link->link_enc))
> @@ -2148,38 +2150,62 @@ static int acquire_resource_from_hw_enabled_state(
>   	if (!res_ctx->pipe_ctx[tg_inst].stream) {
>   		struct pipe_ctx *pipe_ctx = &res_ctx->pipe_ctx[tg_inst];
>   
> -		pipe_ctx->stream_res.tg = pool->timing_generators[tg_inst];
> -		pipe_ctx->plane_res.mi = pool->mis[tg_inst];
> -		pipe_ctx->plane_res.hubp = pool->hubps[tg_inst];
> -		pipe_ctx->plane_res.ipp = pool->ipps[tg_inst];
> -		pipe_ctx->plane_res.xfm = pool->transforms[tg_inst];
> -		pipe_ctx->plane_res.dpp = pool->dpps[tg_inst];
> -		pipe_ctx->stream_res.opp = pool->opps[tg_inst];
> -
> -		if (pool->dpps[tg_inst]) {
> -			pipe_ctx->plane_res.mpcc_inst = pool->dpps[tg_inst]->inst;
> -
> -			// Read DPP->MPCC->OPP Pipe from HW State
> -			if (pool->mpc->funcs->read_mpcc_state) {
> -				struct mpcc_state s = {0};
> -
> -				pool->mpc->funcs->read_mpcc_state(pool->mpc, pipe_ctx->plane_res.mpcc_inst, &s);
> -
> -				if (s.dpp_id < MAX_MPCC)
> -					pool->mpc->mpcc_array[pipe_ctx->plane_res.mpcc_inst].dpp_id = s.dpp_id;
> -
> -				if (s.bot_mpcc_id < MAX_MPCC)
> -					pool->mpc->mpcc_array[pipe_ctx->plane_res.mpcc_inst].mpcc_bot =
> -							&pool->mpc->mpcc_array[s.bot_mpcc_id];
> +		id_src[0] = tg_inst;
> +
> +		if (pipe_ctx->stream_res.tg->funcs->get_optc_source)
> +			pipe_ctx->stream_res.tg->funcs->get_optc_source(pipe_ctx->stream_res.tg,
> +					&numPipes, &id_src[0], &id_src[1]);
> +
> +		for (i = 0; i < numPipes; i++) {
> +			//Check if src id invalid

Missing space.

> +			if (id_src[i] == 0xf)
> +				return -1;
> +
> +			pipe_ctx->stream_res.tg = pool->timing_generators[tg_inst];
> +			pipe_ctx->plane_res.mi = pool->mis[id_src[i]];
> +			pipe_ctx->plane_res.hubp = pool->hubps[id_src[i]];
> +			pipe_ctx->plane_res.ipp = pool->ipps[id_src[i]];
> +			pipe_ctx->plane_res.xfm = pool->transforms[id_src[i]];
> +			pipe_ctx->plane_res.dpp = pool->dpps[id_src[i]];
> +			pipe_ctx->stream_res.opp = pool->opps[id_src[i]];
> +
> +			if (pool->dpps[id_src[i]]) {
> +				pipe_ctx->plane_res.mpcc_inst = pool->dpps[id_src[i]]->inst;
> +
> +				if (pool->mpc->funcs->read_mpcc_state) {
> +					struct mpcc_state s = {0};
> +					pool->mpc->funcs->read_mpcc_state(pool->mpc, pipe_ctx->plane_res.mpcc_inst, &s);
> +					if (s.dpp_id < MAX_MPCC)
> +						pool->mpc->mpcc_array[pipe_ctx->plane_res.mpcc_inst].dpp_id =
> +								s.dpp_id;
> +					if (s.bot_mpcc_id < MAX_MPCC)
> +						pool->mpc->mpcc_array[pipe_ctx->plane_res.mpcc_inst].mpcc_bot =
> +								&pool->mpc->mpcc_array[s.bot_mpcc_id];
> +					if (s.opp_id < MAX_OPP)
> +						pipe_ctx->stream_res.opp->mpc_tree_params.opp_id = s.opp_id;
> +				}
> +			}
> +			pipe_ctx->pipe_idx = id_src[i];
>   
> -				if (s.opp_id < MAX_OPP)
> -					pipe_ctx->stream_res.opp->mpc_tree_params.opp_id = s.opp_id;
> +			if (id_src[i] >= pool->timing_generator_count) {
> +				id_src[i] = pool->timing_generator_count - 1;
> +				pipe_ctx->stream_res.tg = pool->timing_generators[id_src[i]];
> +				pipe_ctx->stream_res.opp = pool->opps[id_src[i]];
>   			}
> +
> +			pipe_ctx->stream = stream;
>   		}
> -		pipe_ctx->pipe_idx = tg_inst;
>   
> -		pipe_ctx->stream = stream;
> -		return tg_inst;
> +		if (numPipes == 2) {
> +			stream->apply_boot_odm_mode = dm_odm_combine_policy_2to1;
> +			res_ctx->pipe_ctx[id_src[0]].next_odm_pipe = &res_ctx->pipe_ctx[id_src[1]];
> +			res_ctx->pipe_ctx[id_src[0]].prev_odm_pipe = NULL;
> +			res_ctx->pipe_ctx[id_src[1]].next_odm_pipe = NULL;
> +			res_ctx->pipe_ctx[id_src[1]].prev_odm_pipe = &res_ctx->pipe_ctx[id_src[0]];
> +		} else
> +			stream->apply_boot_odm_mode = dm_odm_combine_mode_disabled;

Missing curly braces. Didn’t `scripts/checkpatch.pl` find that?

> +
> +		return id_src[0];
>   	}
>   
>   	return -1;
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index e723553f9c5a..863d90bec61b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -666,6 +666,7 @@ struct dc_debug_options {
>   	uint32_t edid_read_retry_times;
>   	bool remove_disconnect_edp;
>   	unsigned int force_odm_combine; //bit vector based on otg inst
> +	unsigned int seamless_boot_odm_combine;

Please add a comment, what this does. Why `combine`?

>   #if defined(CONFIG_DRM_AMD_DC_DCN)
>   	unsigned int force_odm_combine_4to1; //bit vector based on otg inst
>   	bool disable_z9_mpc;
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
> index c4168c11257c..580420c3eedc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
> @@ -246,6 +246,7 @@ struct dc_stream_state {
>   
>   	bool apply_edp_fast_boot_optimization;
>   	bool apply_seamless_boot_optimization;
> +	uint32_t apply_boot_odm_mode;

The name sounds like a boolean?

>   
>   	uint32_t stream_id;
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index 328569ad2bd6..283bc42d2fc7 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -1259,6 +1259,7 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
>   {
>   	int i;
>   	struct dce_hwseq *hws = dc->hwseq;
> +	struct hubbub *hubbub = dc->res_pool->hubbub;
>   	bool can_apply_seamless_boot = false;
>   
>   	for (i = 0; i < context->stream_count; i++) {
> @@ -1294,6 +1295,21 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
>   		}
>   	}
>   
> +	/* Reset det size */
> +	for (i = 0; i < dc->res_pool->pipe_count; i++) {
> +		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
> +		struct hubp *hubp = dc->res_pool->hubps[i];
> +
> +		/* Do not need to reset for seamless boot */

Comment is redundand to the code. Either remove, or add datasheet 
section or something different as a comment.

> +		if (pipe_ctx->stream != NULL && can_apply_seamless_boot)
> +			continue;
> +
> +		if (hubbub && hubp) {
> +			if (hubbub->funcs->program_det_size)
> +				hubbub->funcs->program_det_size(hubbub, hubp->inst, 0);
> +		}
> +	}
> +
>   	/* num_opp will be equal to number of mpcc */
>   	for (i = 0; i < dc->res_pool->res_cap->num_opp; i++) {
>   		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
> @@ -1359,6 +1375,11 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
>   		pipe_ctx->stream_res.tg = NULL;
>   		pipe_ctx->plane_res.hubp = NULL;
>   
> +		if (tg->funcs->is_tg_enabled(tg)) {
> +			if (tg->funcs->init_odm)
> +				tg->funcs->init_odm(tg);
> +		}
> +
>   		tg->funcs->tg_init(tg);
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
> index 10f897b1cb63..c51f7dca94f8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
> @@ -213,6 +213,26 @@ void optc31_set_drr(
>   	}
>   }
>   
> +void optc3_init_odm(struct timing_generator *optc)
> +{
> +	struct optc *optc1 = DCN10TG_FROM_TG(optc);
> +
> +	REG_SET_5(OPTC_DATA_SOURCE_SELECT, 0,
> +			OPTC_NUM_OF_INPUT_SEGMENT, 0,
> +			OPTC_SEG0_SRC_SEL, optc->inst,
> +			OPTC_SEG1_SRC_SEL, 0xf,
> +			OPTC_SEG2_SRC_SEL, 0xf,
> +			OPTC_SEG3_SRC_SEL, 0xf
> +			);
> +
> +	REG_SET(OTG_H_TIMING_CNTL, 0,
> +			OTG_H_TIMING_DIV_MODE, 0);
> +
> +	REG_SET(OPTC_MEMORY_CONFIG, 0,
> +			OPTC_MEM_SEL, 0);
> +	optc1->opp_count = 1;
> +}
> +
>   static struct timing_generator_funcs dcn31_tg_funcs = {
>   		.validate_timing = optc1_validate_timing,
>   		.program_timing = optc1_program_timing,
> @@ -272,6 +292,7 @@ static struct timing_generator_funcs dcn31_tg_funcs = {
>   		.program_manual_trigger = optc2_program_manual_trigger,
>   		.setup_manual_trigger = optc2_setup_manual_trigger,
>   		.get_hw_timing = optc1_get_hw_timing,
> +		.init_odm = optc3_init_odm,
>   };
>   
>   void dcn31_timing_generator_init(struct optc *optc1)
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
> index a37b16040c1d..9e881f2ce74b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
> @@ -258,4 +258,6 @@ void dcn31_timing_generator_init(struct optc *optc1);
>   
>   void optc31_set_drr(struct timing_generator *optc, const struct drr_params *params);
>   
> +void optc3_init_odm(struct timing_generator *optc);
> +
>   #endif /* __DC_OPTC_DCN31_H__ */
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> index 59a704781e34..554d2e33bd7f 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> @@ -310,6 +310,8 @@ struct timing_generator_funcs {
>   			uint32_t slave_pixel_clock_100Hz,
>   			uint8_t master_clock_divider,
>   			uint8_t slave_clock_divider);
> +
> +	void (*init_odm)(struct timing_generator *tg);
>   };
>   
>   #endif
