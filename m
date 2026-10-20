Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18392606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 13:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=ef1fcmbh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A651E10E255;
	Tue, 20 Oct 2026 13:22:14 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6D0A10E255
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 13:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:Message-ID:Subject:Cc:To
 :From:Date:MIME-Version:From:Reply-To;
 bh=vFywBtlIjqHuzRWO3k+buecmmPKXAdF8CUBV+1fHj8U=; b=ef1fcmbh81sAKA6oPQz0rN9JpM
 kzGi+u8Dz7d8E7si1eUuIFjHZMugtwx4ufZpSaRCcTacCJj54FMZ+rmg7jIxKLryTkqpItGh2XAdo
 s0nIOVt+7J47NGmqXvXdOB0E047tOs0vB8cIvhCy1pQgncHk/jhMbek4n5R+eslrAYLfh5FM0iis/
 6qJjJgrhKToxZUz9BvJstdNK0/suPfD/p5sOoECiwBC5ZNgzqS5REaNlSZKGtshtgSqk5Q2AYQEmW
 aPZNcz67sioQ+HaL8EQuvagpo5+FaFe3sx9cOtQODmZZr4MntYdPUd9DVbCNrVmGUUbPqOyD6QJ5z
 jEKzjuLg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJ9n4-004bpQ-Ut; Tue, 20 Oct 2026 15:22:06 +0200
Received: from webmail.service.igalia.com ([192.168.21.45])
 by mail.igalia.com with esmtp (Exim) id 1xJ9n2-0000000575m-1rDJ;
 Tue, 20 Oct 2026 15:22:06 +0200
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
 by webmail.service.igalia.com with esmtp (Exim 4.98.2)
 (envelope-from <mwen@igalia.com>) id 1xJ9n2-0000000B1rT-1Gtl;
 Tue, 20 Oct 2026 15:22:04 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Tue, 20 Oct 2026 12:22:04 -0100
From: Melissa Wen <mwen@igalia.com>
To: Roman.Li@amd.com
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler
 <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, James Lin
 <PingLei.Lin@amd.com>, Chenyu Chen <Chen-Yu.Chen@amd.com>, Rafal Ostrowski
 <rafal.ostrowski@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: Re: [PATCH 06/17] drm/amd/display: Refactor DMUB fast lock sequencing
In-Reply-To: <20261002193240.3441018-7-Roman.Li@amd.com>
References: <20261002193240.3441018-1-Roman.Li@amd.com>
 <20261002193240.3441018-7-Roman.Li@amd.com>
Message-ID: <158f249b3c9430a847f405bd02f0489c@igalia.com>
X-Sender: mwen@igalia.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -48
X-Spam-Bar: ----
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 02-10-2026 18:32, Roman.Li@amd.com wrote:
> From: Rafal Ostrowski <rafal.ostrowski@amd.com>
> 
> [WHY]
> Resolve fast-lock policy before execution and avoid queuing no-op
> steps. Remove duplicated per-ASIC command construction.
> 
> [HOW]
> Use one fast-lock opcode, parameter structure and executor.
> Capture the service handle and precomputed Inbox0 command.
> Keep separate SubVP and generic capability hooks and preserve
> the lock manager's original support and split feature gates.
> Retain the unused SubVP enumerator and existing opcode values.

Hey,

This patch caused white flashes on Framework 13 Pro Ryzen™ AI 9 HX 370
(DCN 3.5) on KDE at 60Hz and Adaptive sync: Never.

The white flashes stop when disabling Replay (dcdegugmask 0x400) or
when avoiding the usage of refactored DMUB lock control by reverting
these two lines in the dcn35_funcs (that were introduced by this patch):

+	.dmub_hw_control_lock = dcn35_dmub_hw_control_lock,
+	.is_dmub_hw_lock_supported = dcn35_is_dmub_hw_lock_supported,

I wonder if you guys already noticed this and if there is any proposed
fix that I can test, or should I send a patch reverting these change at
least for DCN 3.5 and 3.5.1?

Best Regards,

Melissa

> 
> Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
> Signed-off-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
> Signed-off-by: Roman Li <roman.li@amd.com>
> ---
>  .../drm/amd/display/dc/core/dc_hw_sequencer.c | 103 +++++++++++-------
>  .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |  12 +-
>  .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  18 +--
>  .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |   2 +-
>  .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   2 +-
>  .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  28 ++---
>  .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   2 +-
>  .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   2 +
>  .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   2 +
>  .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  16 +--
>  .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   2 +-
>  .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   2 +-
>  .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |  16 +--
>  .../amd/display/dc/hwss/dcn42/dcn42_hwseq.h   |   2 +-
>  .../amd/display/dc/hwss/dcn42/dcn42_init.c    |   2 +-
>  .../amd/display/dc/hwss/dcn60/dcn60_init.c    |   2 +-
>  .../drm/amd/display/dc/hwss/hw_sequencer.h    |  22 ++--
>  17 files changed, 106 insertions(+), 129 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> index 4e75eb3e3dab..47efe05fe9bb 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> @@ -43,6 +43,51 @@
>  #include "link_service.h"
>  #include "custom_float.h"
>  
> +static union dmub_inbox0_cmd_lock_hw hwss_build_dmub_lock_command(bool lock)
> +{
> +	union dmub_inbox0_cmd_lock_hw command = { 0 };
> +
> +	command.bits.command_code = DMUB_INBOX0_CMD__HW_LOCK;
> +	command.bits.hw_lock_client = HW_LOCK_CLIENT_DRIVER;
> +	command.bits.lock = lock;
> +	command.bits.should_release = !lock;
> +
> +	return command;
> +}
> +
> +void hwss_add_dmub_hw_control_lock_fast(struct block_sequence_state *seq_state,
> +		struct dc *dc, bool lock)
> +{
> +	struct dmub_hw_control_lock_fast_params *params;
> +
> +	if (!seq_state || !seq_state->steps || !seq_state->num_steps || !dc || !dc->ctx ||
> +			!dc->ctx->dmub_srv || !dc->ctx->dmub_srv->dmub ||
> +			*seq_state->num_steps >= MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
> +		/* Dropping a lock or unlock step can leave the pair unbalanced. */
> +		ASSERT(!seq_state || !seq_state->num_steps ||
> +				*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE);
> +		return;
> +	}
> +
> +	params = &seq_state->steps[*seq_state->num_steps].params.dmub_hw_control_lock_fast_params;
> +	params->dmub_srv = dc->ctx->dmub_srv;
> +	params->command = hwss_build_dmub_lock_command(lock);
> +	seq_state->steps[(*seq_state->num_steps)++].func = DMUB_HW_CONTROL_LOCK_FAST;
> +}
> +
> +void hwss_dmub_hw_control_lock_fast(union block_sequence_params *params)
> +{
> +	struct dmub_hw_control_lock_fast_params *p;
> +
> +	if (!params)
> +		return;
> +
> +	p = &params->dmub_hw_control_lock_fast_params;
> +
> +	if (p->dmub_srv && p->dmub_srv->dmub)
> +		dmub_hw_lock_mgr_inbox0_cmd(p->dmub_srv, p->command);
> +}
> +
>  #define MAX_NUM_MCACHE 8
>  
>  /* used as index in array of black_color_format */
> @@ -1207,27 +1252,21 @@ void hwss_build_fast_sequence(struct dc *dc,
>  		block_sequence[*num_steps].func = HUBP_WAIT_FOR_DCC_META_PROP;
>  		(*num_steps)++;
>  	}
> -	if (dc->hwss.subvp_pipe_control_lock_fast) {
> -		block_sequence[*num_steps].params.subvp_pipe_control_lock_fast_params.dc = dc;
> -		block_sequence[*num_steps].params.subvp_pipe_control_lock_fast_params.lock = true;
> -		block_sequence[*num_steps].params.subvp_pipe_control_lock_fast_params.subvp_immediate_flip =
> -				plane->flip_immediate && stream_status->mall_stream_config.type == SUBVP_MAIN;
> -		block_sequence[*num_steps].func = DMUB_SUBVP_PIPE_CONTROL_LOCK_FAST;
> -		(*num_steps)++;
> -	}
> -	if (dc->hwss.dmub_hw_control_lock_fast) {
> -		is_dmub_lock_required = dc_state_is_fams2_in_use(dc, context) ||
> -					dmub_hw_lock_mgr_does_link_require_lock(dc, stream->link);
>  
> -		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.dc = dc;
> -		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.lock = true;
> -		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.is_required = is_dmub_lock_required;
> -		block_sequence[*num_steps].func = DMUB_HW_CONTROL_LOCK_FAST;
> -		(*num_steps)++;
> +	if (plane->flip_immediate && stream_status->mall_stream_config.type == SUBVP_MAIN &&
> +			dc->hwss.is_subvp_hw_lock_supported && dc->hwss.is_subvp_hw_lock_supported(dc))
> +		is_dmub_lock_required = true;
> +
> +	if (dc->hwss.is_dmub_hw_lock_supported && dc->hwss.is_dmub_hw_lock_supported(dc)) {
> +		/* is_dmub_lock_required is reused by the matching unlock step below. */
> +		is_dmub_lock_required |= dc_state_is_fams2_in_use(dc, context) ||
> +					dmub_hw_lock_mgr_does_link_require_lock(dc, stream->link);
>  	}
> -	hwss_add_optc_pipe_control_lock(
> -			&(struct block_sequence_state){ block_sequence, num_steps },
> -			dc, pipe_ctx, true);
> +
> +	if (is_dmub_lock_required)
> +		hwss_add_dmub_hw_control_lock_fast(&seq_state, dc, true);
> +
> +	hwss_add_optc_pipe_control_lock(&seq_state, dc, pipe_ctx, true);
>  
>  	for (i = 0; i < dmub_cmd_count; i++) {
>  		block_sequence[*num_steps].params.send_dmcub_cmd_params.ctx = dc->ctx;
> @@ -1622,24 +1661,9 @@ void hwss_build_fast_sequence(struct dc *dc,
>  		current_pipe = current_pipe->next_odm_pipe;
>  	}
>  
> -	hwss_add_optc_pipe_control_lock(
> -			&(struct block_sequence_state){ block_sequence, num_steps },
> -			dc, pipe_ctx, false);
> -	if (dc->hwss.subvp_pipe_control_lock_fast) {
> -		block_sequence[*num_steps].params.subvp_pipe_control_lock_fast_params.dc = dc;
> -		block_sequence[*num_steps].params.subvp_pipe_control_lock_fast_params.lock = false;
> -		block_sequence[*num_steps].params.subvp_pipe_control_lock_fast_params.subvp_immediate_flip =
> -				plane->flip_immediate && stream_status->mall_stream_config.type == SUBVP_MAIN;
> -		block_sequence[*num_steps].func = DMUB_SUBVP_PIPE_CONTROL_LOCK_FAST;
> -		(*num_steps)++;
> -	}
> -	if (dc->hwss.dmub_hw_control_lock_fast) {
> -		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.dc = dc;
> -		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.lock = false;
> -		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.is_required = is_dmub_lock_required;
> -		block_sequence[*num_steps].func = DMUB_HW_CONTROL_LOCK_FAST;
> -		(*num_steps)++;
> -	}
> +	hwss_add_optc_pipe_control_lock(&seq_state, dc, pipe_ctx, false);
> +	if (is_dmub_lock_required)
> +		hwss_add_dmub_hw_control_lock_fast(&seq_state, dc, false);
>  
>  	current_pipe = pipe_ctx;
>  	while (current_pipe) {
> @@ -1677,9 +1701,6 @@ void hwss_execute_sequence(struct dc *dc,
>  		params = &(block_sequence[i].params);
>  		switch (block_sequence[i].func) {
>  
> -		case DMUB_SUBVP_PIPE_CONTROL_LOCK_FAST:
> -			dc->hwss.subvp_pipe_control_lock_fast(params);
> -			break;
>  		case TG_LOCK:
>  			dc->hwss.tg_lock(&params->tg_lock_params);
>  			break;
> @@ -1774,7 +1795,7 @@ void hwss_execute_sequence(struct dc *dc,
>  			dc->hwss.wait_for_dcc_meta_propagation(params->wait_for_dcc_meta_propagation_params.delay);
>  			break;
>  		case DMUB_HW_CONTROL_LOCK_FAST:
> -			dc->hwss.dmub_hw_control_lock_fast(params);
> +			hwss_dmub_hw_control_lock_fast(params);
>  			break;
>  		case HUBP_PROGRAM_SURFACE_CONFIG:
>  			hwss_program_surface_config(params);
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
> index 2ac1485a3438..f5ff61a2e89e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
> @@ -30,17 +30,17 @@
>  
>  static bool dmub_hw_lock_has_inbox0_lock(const struct dc *dc)
>  {
> -	return dc->ctx && dc->ctx->dmub_srv &&
> -	       dc->hwss.dmub_hw_control_lock &&
> -	       dc->hwss.dmub_hw_control_lock_fast &&
> -	       dc->ctx->dmub_srv->dmub->meta_info.feature_bits.bits.inbox0_lock_support;
> +	return dc && dc->ctx && dc->ctx->dmub_srv && dc->ctx->dmub_srv->dmub &&
> +		dc->hwss.dmub_hw_control_lock &&
> +		dc->hwss.is_dmub_hw_lock_supported &&
> +		dc->ctx->dmub_srv->dmub->meta_info.feature_bits.bits.inbox0_lock_support;
>  }
>  
>  static bool dmub_hw_lock_has_inbox0_lock_split(const struct dc *dc)
>  {
> -	return dc->ctx && dc->ctx->dmub_srv &&
> +	return dc && dc->ctx && dc->ctx->dmub_srv && dc->ctx->dmub_srv->dmub &&
>  		dc->hwss.dmub_hw_control_lock &&
> -		dc->hwss.dmub_hw_control_lock_fast &&
> +		dc->hwss.is_dmub_hw_lock_supported &&
>  		dc->ctx->dmub_srv->dmub->meta_info.feature_bits.bits.inbox0_lock_split;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> index 8e45ad4191c7..10361f3b6122 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> @@ -425,22 +425,10 @@ void dcn32_subvp_pipe_control_lock(struct dc *dc,
>  	}
>  }
>  
> -void dcn32_subvp_pipe_control_lock_fast(union block_sequence_params *params)
> +bool dcn32_is_subvp_hw_lock_supported(const struct dc *dc)
>  {
> -	struct dc *dc = params->subvp_pipe_control_lock_fast_params.dc;
> -	bool lock = params->subvp_pipe_control_lock_fast_params.lock;
> -	bool subvp_immediate_flip = params->subvp_pipe_control_lock_fast_params.subvp_immediate_flip;
> -
> -	// Don't need to lock for DRR VSYNC flips -- FW will wait for DRR pending update cleared.
> -	if (subvp_immediate_flip) {
> -		union dmub_inbox0_cmd_lock_hw hw_lock_cmd = { 0 };
> -
> -		hw_lock_cmd.bits.command_code = DMUB_INBOX0_CMD__HW_LOCK;
> -		hw_lock_cmd.bits.hw_lock_client = HW_LOCK_CLIENT_DRIVER;
> -		hw_lock_cmd.bits.lock = lock;
> -		hw_lock_cmd.bits.should_release = !lock;
> -		dmub_hw_lock_mgr_inbox0_cmd(dc->ctx->dmub_srv, hw_lock_cmd);
> -	}
> +	/* SubVP inbox0 lock has no firmware feature gate on this generation. */
> +	return dc && dc->ctx && dc->ctx->dmub_srv && dc->ctx->dmub_srv->dmub;
>  }
>  
>  bool dcn32_set_mpc_shaper_3dlut(struct dpp *dpp, struct mpc *mpc,
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
> index c85ff14596af..734727015b3f 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
> @@ -82,7 +82,7 @@ void dcn32_subvp_pipe_control_lock(struct dc *dc,
>  		struct pipe_ctx *top_pipe_to_program,
>  		bool subvp_prev_use);
>  
> -void dcn32_subvp_pipe_control_lock_fast(union block_sequence_params *params);
> +bool dcn32_is_subvp_hw_lock_supported(const struct dc *dc);
>  
>  void dcn32_unblank_stream(struct pipe_ctx *pipe_ctx,
>  		struct dc_link_settings *link_settings);
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
> index 9d3c7b40b21f..b755df909871 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
> @@ -118,7 +118,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
>  	.disable_phantom_streams = dcn32_disable_phantom_streams,
>  	.subvp_pipe_control_lock = dcn32_subvp_pipe_control_lock,
>  	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
> -	.subvp_pipe_control_lock_fast = dcn32_subvp_pipe_control_lock_fast,
> +	.is_subvp_hw_lock_supported = dcn32_is_subvp_hw_lock_supported,
>  	.update_phantom_vp_position = dcn32_update_phantom_vp_position,
>  	.update_dsc_pg = dcn32_update_dsc_pg,
>  	.apply_update_flags_for_phantom = dcn32_apply_update_flags_for_phantom,
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
> index 41abfff6cf47..f2bf7d1ca4f7 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
> @@ -1855,11 +1855,7 @@ bool dcn35_dmub_hw_control_lock(struct dc *dc, struct dc_state *context, bool lo
>  {
>  	union dmub_inbox0_cmd_lock_hw hw_lock_cmd = { 0 };
>  
> -	if (!dc->ctx || !dc->ctx->dmub_srv)
> -		return false;
> -
> -	/* if not support inbox0 lock, would not use inbox0 lock mechanism  */
> -	if (!dc->ctx->dmub_srv->dmub->meta_info.feature_bits.bits.inbox0_lock_support)
> +	if (!dcn35_is_dmub_hw_lock_supported(dc))
>  		return false;
>  
>  	if (lock) {
> @@ -1877,22 +1873,12 @@ bool dcn35_dmub_hw_control_lock(struct dc *dc, struct dc_state *context, bool lo
>  	return true;
>  }
>  
> -void dcn35_dmub_hw_control_lock_fast(union block_sequence_params *params)
> +bool dcn35_is_dmub_hw_lock_supported(const struct dc *dc)
>  {
> -	struct dc *dc = params->dmub_hw_control_lock_fast_params.dc;
> -	bool lock = params->dmub_hw_control_lock_fast_params.lock;
> -
> -	/* if not support inbox0 lock, would not use inbox0 lock mechanism  */
> -	if (!dc->ctx->dmub_srv->dmub->meta_info.feature_bits.bits.inbox0_lock_support)
> -		return;
> -
> -	if (params->dmub_hw_control_lock_fast_params.is_required) {
> -		union dmub_inbox0_cmd_lock_hw hw_lock_cmd = { 0 };
> +	if (!dc || !dc->ctx || !dc->ctx->dmub_srv || !dc->ctx->dmub_srv->dmub)
> +		return false;
>  
> -		hw_lock_cmd.bits.command_code = DMUB_INBOX0_CMD__HW_LOCK;
> -		hw_lock_cmd.bits.hw_lock_client = HW_LOCK_CLIENT_DRIVER;
> -		hw_lock_cmd.bits.lock = lock;
> -		hw_lock_cmd.bits.should_release = !lock;
> -		dmub_hw_lock_mgr_inbox0_cmd(dc->ctx->dmub_srv, hw_lock_cmd);
> -	}
> +	/* if not support inbox0 lock, would not use inbox0 lock mechanism */
> +	return dc->ctx->dmub_srv->dmub->meta_info.feature_bits.bits.inbox0_lock_support != 0;
>  }
> +
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
> index d47f7232f863..96b836b2ae71 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
> @@ -120,6 +120,6 @@ void dcn35_disable_link_output(struct dc_link *link,
>  		const struct link_resource *link_res,
>  		enum signal_type signal);
>  bool dcn35_dmub_hw_control_lock(struct dc *dc, struct dc_state *context, bool lock);
> -void dcn35_dmub_hw_control_lock_fast(union block_sequence_params *params);
> +bool dcn35_is_dmub_hw_lock_supported(const struct dc *dc);
>  
>  #endif /* __DC_HWSS_DCN35_H__ */
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
> index b1933a80fc47..f8c8ab12bdf9 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
> @@ -137,6 +137,8 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
>  	.update_dchubp_dpp = dcn20_update_dchubp_dpp,
>  	.post_unlock_reset_opp = dcn20_post_unlock_reset_opp,
>  	.get_underflow_debug_data = dcn30_get_underflow_debug_data,
> +	.dmub_hw_control_lock = dcn35_dmub_hw_control_lock,
> +	.is_dmub_hw_lock_supported = dcn35_is_dmub_hw_lock_supported,
>  };
>  
>  static const struct hwseq_private_funcs dcn35_private_funcs = {
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
> index dbd8480b9e05..82a8d87f9428 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
> @@ -126,6 +126,8 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
>  	.calculate_pix_rate_divider = dcn32_calculate_pix_rate_divider,
>  	.setup_hpo_hw_control = dcn35_setup_hpo_hw_control,
>  	.get_underflow_debug_data = dcn30_get_underflow_debug_data,
> +	.dmub_hw_control_lock = dcn35_dmub_hw_control_lock,
> +	.is_dmub_hw_lock_supported = dcn35_is_dmub_hw_lock_supported,
>  };
>  
>  static const struct hwseq_private_funcs dcn351_private_funcs = {
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
> index 73f969fd1b33..379902bdef0a 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
> @@ -1635,20 +1635,10 @@ bool dcn401_dmub_hw_control_lock(struct dc *dc,
>  	return true;
>  }
>  
> -void dcn401_dmub_hw_control_lock_fast(union block_sequence_params *params)
> +bool dcn401_is_dmub_hw_lock_supported(const struct dc *dc)
>  {
> -	struct dc *dc = params->dmub_hw_control_lock_fast_params.dc;
> -	bool lock = params->dmub_hw_control_lock_fast_params.lock;
> -
> -	if (params->dmub_hw_control_lock_fast_params.is_required) {
> -		union dmub_inbox0_cmd_lock_hw hw_lock_cmd = { 0 };
> -
> -		hw_lock_cmd.bits.command_code = DMUB_INBOX0_CMD__HW_LOCK;
> -		hw_lock_cmd.bits.hw_lock_client = HW_LOCK_CLIENT_DRIVER;
> -		hw_lock_cmd.bits.lock = lock;
> -		hw_lock_cmd.bits.should_release = !lock;
> -		dmub_hw_lock_mgr_inbox0_cmd(dc->ctx->dmub_srv, hw_lock_cmd);
> -	}
> +	/* Inbox0 HW lock is unconditionally available on this generation. */
> +	return dc && dc->ctx && dc->ctx->dmub_srv && dc->ctx->dmub_srv->dmub;
>  }
>  
>  void dcn401_fams2_update_config(struct dc *dc, struct dc_state *context, bool enable)
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
> index 66a0fc8de8ba..ecaeb192bca3 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
> @@ -87,7 +87,7 @@ bool dcn401_dmub_hw_control_lock(struct dc *dc,
>  		struct dc_state *context,
>  		bool lock);
>  void dcn401_fams2_update_config(struct dc *dc, struct dc_state *context, bool enable);
> -void dcn401_dmub_hw_control_lock_fast(union block_sequence_params *params);
> +bool dcn401_is_dmub_hw_lock_supported(const struct dc *dc);
>  void dcn401_unblank_stream(struct pipe_ctx *pipe_ctx, struct dc_link_settings *link_settings);
>  void dcn401_hardware_release(struct dc *dc);
>  void dcn401_update_odm(struct dc *dc, struct dc_state *context,
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
> index 2d3c46c4e00c..1a387e52218d 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
> @@ -111,7 +111,7 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
>  	.is_pipe_topology_transition_seamless = dcn32_is_pipe_topology_transition_seamless,
>  	.dmub_hw_control_lock = dcn401_dmub_hw_control_lock,
>  	.fams2_update_config = dcn401_fams2_update_config,
> -	.dmub_hw_control_lock_fast = dcn401_dmub_hw_control_lock_fast,
> +	.is_dmub_hw_lock_supported = dcn401_is_dmub_hw_lock_supported,
>  	.program_outstanding_updates = dcn401_program_outstanding_updates,
>  	.wait_for_all_pending_updates = dcn30_wait_for_all_pending_updates,
>  	.detect_pipe_changes = dcn401_detect_pipe_changes,
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
> index 21c3d108abe9..34bfe62296e6 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
> @@ -1212,20 +1212,10 @@ bool dcn42_dmub_hw_control_lock(struct dc *dc, struct dc_state *context, bool lo
>  	return true;
>  }
>  
> -void dcn42_dmub_hw_control_lock_fast(union block_sequence_params *params)
> +bool dcn42_is_dmub_hw_lock_supported(const struct dc *dc)
>  {
> -	struct dc *dc = params->dmub_hw_control_lock_fast_params.dc;
> -	bool lock = params->dmub_hw_control_lock_fast_params.lock;
> -
> -	/* Use helper to check PSR/Replay for the given stream in fast path */
> -	if (params->dmub_hw_control_lock_fast_params.is_required) {
> -		union dmub_inbox0_cmd_lock_hw hw_lock_cmd = { 0 };
> -		hw_lock_cmd.bits.command_code = DMUB_INBOX0_CMD__HW_LOCK;
> -		hw_lock_cmd.bits.hw_lock_client = HW_LOCK_CLIENT_DRIVER;
> -		hw_lock_cmd.bits.lock = lock;
> -		hw_lock_cmd.bits.should_release = !lock;
> -		dmub_hw_lock_mgr_inbox0_cmd(dc->ctx->dmub_srv, hw_lock_cmd);
> -	}
> +	/* Inbox0 HW lock is unconditionally available on this generation. */
> +	return dc && dc->ctx && dc->ctx->dmub_srv && dc->ctx->dmub_srv->dmub;
>  }
>  
>  /* In headless boot cases, DIG may be turned
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h
> index 31b92274a2f5..2e5523617f29 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h
> @@ -44,7 +44,7 @@ void dcn42_hw_block_power_up(struct dc *dc,
>  void dcn42_root_clock_control(struct dc *dc,
>  		struct pg_block_update *update_state, bool power_on);
>  bool dcn42_dmub_hw_control_lock(struct dc *dc, struct dc_state *context, bool lock);
> -void dcn42_dmub_hw_control_lock_fast(union block_sequence_params *params);
> +bool dcn42_is_dmub_hw_lock_supported(const struct dc *dc);
>  void dcn42_setup_stereo(struct pipe_ctx *pipe_ctx, struct dc *dc);
>  void dcn42_power_down_on_boot(struct dc *dc);
>  #endif
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
> index a28149411821..775da50e945e 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
> @@ -111,7 +111,7 @@ static const struct hw_sequencer_funcs dcn42_funcs = {
>  	.is_pipe_topology_transition_seamless = dcn32_is_pipe_topology_transition_seamless,
>  	.dmub_hw_control_lock = dcn42_dmub_hw_control_lock,
>  	.fams2_update_config = dcn401_fams2_update_config,
> -	.dmub_hw_control_lock_fast = dcn42_dmub_hw_control_lock_fast,
> +	.is_dmub_hw_lock_supported = dcn42_is_dmub_hw_lock_supported,
>  	.program_outstanding_updates = dcn401_program_outstanding_updates,
>  	.wait_for_all_pending_updates = dcn30_wait_for_all_pending_updates,
>  	.detect_pipe_changes = dcn401_detect_pipe_changes,
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
> index c89051a542cb..80125c3596ce 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
> @@ -113,7 +113,7 @@ static const struct hw_sequencer_funcs dcn60_funcs = {
>  	.is_pipe_topology_transition_seamless = dcn32_is_pipe_topology_transition_seamless,
>  	.dmub_hw_control_lock = dcn401_dmub_hw_control_lock,
>  	.fams2_update_config = dcn401_fams2_update_config,
> -	.dmub_hw_control_lock_fast = dcn401_dmub_hw_control_lock_fast,
> +	.is_dmub_hw_lock_supported = dcn401_is_dmub_hw_lock_supported,
>  	.program_outstanding_updates = dcn401_program_outstanding_updates,
>  	.wait_for_all_pending_updates = dcn30_wait_for_all_pending_updates,
>  	.detect_pipe_changes = dcn401_detect_pipe_changes,
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
> index de7a12c706ac..a1b994edf80a 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
> @@ -35,6 +35,7 @@
>  #include "inc/hw/dchubbub.h"
>  #include "dsc/dsc.h"
>  #include "link_service_types.h"
> +#include "dmub/inc/dmub_cmd.h"
>  
>  struct pipe_ctx;
>  struct dc_state;
> @@ -62,11 +63,6 @@ struct hpo_frl_stream_encoder;
>  struct link_training_settings;
>  struct dc_link;
>  struct dc_crtc_timing;
> -struct subvp_pipe_control_lock_fast_params {
> -	struct dc *dc;
> -	bool lock;
> -	bool subvp_immediate_flip;
> -};
>  
>  struct tg_lock_params {
>  	struct dc *dc;
> @@ -216,9 +212,8 @@ struct wait_for_dcc_meta_propagation_params {
>  };
>  
>  struct dmub_hw_control_lock_fast_params {
> -	struct dc *dc;
> -	bool is_required;
> -	bool lock;
> +	struct dc_dmub_srv *dmub_srv;
> +	union dmub_inbox0_cmd_lock_hw command;
>  };
>  
>  struct program_surface_config_params {
> @@ -1051,7 +1046,6 @@ struct link_set_dpms_on_params {
>  
>  union block_sequence_params {
>  	struct update_plane_addr_params update_plane_addr_params;
> -	struct subvp_pipe_control_lock_fast_params subvp_pipe_control_lock_fast_params;
>  	struct tg_lock_params tg_lock_params;
>  	struct tg_3dlut_wa_unlock_params tg_3dlut_wa_unlock_params;
>  	struct set_flip_control_gsl_params set_flip_control_gsl_params;
> @@ -1222,7 +1216,7 @@ union block_sequence_params {
>  };
>  
>  enum block_sequence_func {
> -	DMUB_SUBVP_PIPE_CONTROL_LOCK_FAST = 0,
> +	DMUB_SUBVP_PIPE_CONTROL_LOCK_FAST = 0, /* not used */
>  	TG_LOCK,
>  	TG_3DLUT_WA_UNLOCK,
>  	HUBP_SET_FLIP_CONTROL_GSL,
> @@ -1656,7 +1650,7 @@ struct hw_sequencer_funcs {
>  			bool should_lock_all_pipes,
>  			struct pipe_ctx *top_pipe_to_program,
>  			bool subvp_prev_use);
> -	void (*subvp_pipe_control_lock_fast)(union block_sequence_params *params);
> +	bool (*is_subvp_hw_lock_supported)(const struct dc *dc);
>  
>  	void (*z10_restore)(const struct dc *dc);
>  	void (*z10_save_init)(struct dc *dc);
> @@ -1702,7 +1696,7 @@ struct hw_sequencer_funcs {
>  	void (*fams2_update_config)(struct dc *dc,
>  			struct dc_state *context,
>  			bool enable);
> -	void (*dmub_hw_control_lock_fast)(union block_sequence_params *params);
> +	bool (*is_dmub_hw_lock_supported)(const struct dc *dc);
>  	void (*set_long_vtotal)(struct pipe_ctx **pipe_ctx, int num_pipes, uint32_t v_total_min, uint32_t v_total_max);
>  	void (*program_outstanding_updates)(struct dc *dc,
>  			struct dc_state *context);
> @@ -2803,4 +2797,8 @@ void hwss_add_hubbub_program_compbuf_segments(struct block_sequence_state *seq_s
>  		unsigned int compbuf_size,
>  		bool safe_to_lower);
>  
> +void hwss_dmub_hw_control_lock_fast(union block_sequence_params *params);
> +void hwss_add_dmub_hw_control_lock_fast(struct block_sequence_state *seq_state,
> +		struct dc *dc, bool lock);
> +
>  #endif /* __DC_HW_SEQUENCER_H__ */
