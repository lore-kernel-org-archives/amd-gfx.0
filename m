Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4146BC55184
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 12:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D50C010E53B;
	Mon,  3 Aug 2026 12:42:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rGkA3m6G";
	dkim-atps=neutral
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE52910E53B
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 12:42:39 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-5b2a44a3b66so3421262e87.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Aug 2026 05:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785760958; x=1786365758; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4a6EFR3c9Hm98MzOuywkinyV1rwge3XCyszO0z/Lr4M=;
 b=rGkA3m6G4gB3Y4RYdp40RzQf4gRokaz4kqblilMk9myImhSgodPqiPH8mrNNmWs05T
 9pFZScn5/068jjhcFdmpuWbj35fpjUHp6ttkS2RfTXMRqj1I+RboXfbWq7E3bLm2VHsM
 jSoRS7S8WARIgS83k4AZhTv6GLDolE0QcTat+vOHXW9Z0XGU7EGd5tiYs4GTlf8lU73a
 +Vhv4ssnV+OCdsfQ+V3ineVTISnAlikv8UPf/9zyBgXexarnFIcNhL9K2RABL3mg/2hn
 xzZrKIp4JcYcyy2WJ/6yYuvRMdCdk7PrUuPnMgvYZUKYVyQ9VJYODid8xMuQRbxks7wE
 MOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785760958; x=1786365758;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4a6EFR3c9Hm98MzOuywkinyV1rwge3XCyszO0z/Lr4M=;
 b=gvjfdFdmLedt7pNaJD0fw6zzCvE6AcK+OhkUk3SRB5vaB+q5tEhXiR7Hm5hdWPfCEg
 Q2gGKFLI/IcqcnzIkN7/9LjHlSoG8AzMaJMueG+vumVW1jTNZE2epBuZOezlCVDHsrF1
 TCuM0zPpE1p/eK24Le9N5NkMQXX+bdO30ZA6Ak8p/r+WhytQxPe7WqVWzT7JOaZKodFI
 ZGmyNmGltmH5RkZ64CaYVI3K8JScypdCrjc4PBGC46WBBoVbLnM/X3Rzri6mY2tTEluN
 lGGfRyo4exaQN5YPE5iuzBmITHoEwekdCXS/o0BOih/uS97qYA4vArYybchNfn1HaOuv
 YMng==
X-Gm-Message-State: AOJu0YxrjhPchl3VhYEeB2nJvFivyWv0kUhhnBIsO08xtnU0FAmSSTOv
 JdIzmAf/sX9h2mzNcLYzrrs8KDwj5hMScqO5FBmYuQWC1y+/spY7eRQXBuQHXN5U
X-Gm-Gg: AR+sD10uyqzkAGe5vIwKmmpxst7xCGq9JxaEAVngTcRMO1eef8DWFZjVole3jvMbyAY
 IIakZdzev36h3e7zU/TtuUkA8J1aiNkKytSFnSPJJzP1ZpnHwe/ufdL9Kc8ptgTAB2t8mmseT/a
 KQVFosTBZX9MYdyhirS/z6v1NrL2xz+PWHgtTDY/+peMQI6gZV78qPyI6VRmaYJc1MoBV0bnkfD
 CuJo8Bbh+4pWVefCKrqSQ5KELv3yPQODrsAsZyHsMWSnEiVNesTlDO078kdtxbIp774bcX+l1d3
 huW1mJBuaEXmbO+nMBnjwPza6qnBQb/gN6iigQfeMo9GE+n6Pwz3t6hiZyfpA/jzayzf6ePZkhj
 g4emxYKbq4688gbo/wo6wlJGd7dzTCLB+3ovD++oh136C/90ruu/kxiNVQJv7Rw8JLaQMERuJp7
 KvuZA1r0tWc7oMcSXzwrJBl4U7OPXDOFUHsahB3bJq0awo+Xcznmznqy65emM077gin+OGrq8sN
 h14Ej0V+vVAKfsgFNqZ6ThgUDxgwUGpjfaGQrtUKPvMiV8=
X-Received: by 2002:a05:6512:3e1e:b0:5ae:b861:ac27 with SMTP id
 2adb3069b0e04-5b2e4f21cb2mr2011066e87.18.1785760957567; 
 Mon, 03 Aug 2026 05:42:37 -0700 (PDT)
Received: from timur-hyperion.localnet (5401D2B5.dsl.pool.telekom.hu.
 [84.1.210.181]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2e2441e96sm1989844e87.42.2026.08.03.05.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 05:42:37 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Alex Hung <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>,
 Chenyu Chen <Chen-Yu.Chen@amd.com>, Tomasz Siemek <tomasz.siemek@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: Re: [PATCH 12/70] drm/amd/display: Refactor
 DPP_SET_OUTPUT_TRANSFER_FUNC to drop pipe_ctx
Date: Mon, 03 Aug 2026 14:42:34 +0200
Message-ID: <yu6s9AQzQHipen51Vb4sUw@gmail.com>
In-Reply-To: <20260715134432.1975118-13-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
 <20260715134432.1975118-13-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Wednesday, July 15, 2026 3:37:22=E2=80=AFPM Central European Summer Time=
 Wayne Lin=20
wrote:
> From: Tomasz Siemek <tomasz.siemek@amd.com>
>=20
> [why]
> Pipe_ctx shouldn't be passed as block sequence block parameter.
>=20
> [how]
> Adjust arguments for set_output_transfer_func and implementations.

Hi,

This commit regresses all Vega and older GPUs.
I've just submitted a fix here:
https://lists.freedesktop.org/archives/amd-gfx/2026-August/149757.html
Please review.

Thanks & best regards,
Timur

>=20
> Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
> Signed-off-by: Tomasz Siemek <tomasz.siemek@amd.com>
> Signed-off-by: Wayne Lin <wayne.lin@amd.com>
> ---
>  .../drm/amd/display/dc/core/dc_hw_sequencer.c | 50 ++++++++++++++-----
>  .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  9 ++--
>  .../amd/display/dc/hwss/dce60/dce60_hwseq.c   |  2 +-
>  .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 11 ++--
>  .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |  3 +-
>  .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 20 +++++---
>  .../amd/display/dc/hwss/dcn20/dcn20_hwseq.h   |  3 +-
>  .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   | 31 ++++++------
>  .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |  4 +-
>  .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 31 ++++++------
>  .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |  8 ++-
>  .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 22 ++++----
>  .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |  4 +-
>  .../drm/amd/display/dc/hwss/hw_sequencer.h    | 11 ++--
>  .../display/dc/hwss/hw_sequencer_private.h    |  6 +--
>  15 files changed, 119 insertions(+), 96 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c index
> 4f30d9ac4a0d..6002175420a0 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> @@ -1111,10 +1111,16 @@ void hwss_build_fast_sequence(struct dc *dc,
>  					(*num_steps)++;
>  				}
>  			}
> -			if (hws->funcs.set_output_transfer_func &&
> current_mpc_pipe->stream->update_flags.bits.out_tf) {
> -			=09
block_sequence[*num_steps].params.set_output_transfer_func_params.dc =3D
> dc;
> -			=09
block_sequence[*num_steps].params.set_output_transfer_func_params.pipe
> _ctx =3D current_mpc_pipe;
> -			=09
block_sequence[*num_steps].params.set_output_transfer_func_params.stre
> am =3D current_mpc_pipe->stream; +			if
> (current_mpc_pipe->stream->update_flags.bits.out_tf) {
> +				struct=20
set_output_transfer_func_params *otf_params =3D
> +				=09
&block_sequence[*num_steps].params.set_output_transfer_func_params;
> +
> +				otf_params->dpp =3D=20
current_mpc_pipe->plane_res.dpp;
> +				otf_params->xfm =3D=20
current_mpc_pipe->plane_res.xfm;
> +				otf_params->mpc =3D dc->res_pool-
>mpc;
> +				otf_params->mpcc_id =3D=20
current_mpc_pipe->plane_res.hubp->inst;
> +				otf_params->is_top_pipe =3D=20
resource_is_pipe_type(pipe_ctx, OPP_HEAD);
> +				otf_params->stream =3D=20
current_mpc_pipe->stream;
>  				block_sequence[*num_steps].func =3D=20
DPP_SET_OUTPUT_TRANSFER_FUNC;
>  				(*num_steps)++;
>  			}
> @@ -1271,9 +1277,7 @@ void hwss_execute_sequence(struct dc *dc,
>  			hwss_program_manual_trigger(params);
>  			break;
>  		case DPP_SET_OUTPUT_TRANSFER_FUNC:
> -			hws->funcs.set_output_transfer_func(params-
>set_output_transfer_func_par
> ams.dc, -					params-
>set_output_transfer_func_params.pipe_ctx,
> -					params-
>set_output_transfer_func_params.stream);
> +			hws->funcs.set_output_transfer_func(&params-
>set_output_transfer_func_pa
> rams); break;
>  		case MPC_UPDATE_VISUAL_CONFIRM:
>  			dc->hwss.update_visual_confirm_color(params-
>update_visual_confirm_param
> s.dc, @@ -1829,19 +1833,39 @@ void
> hwss_add_optc_program_manual_trigger(struct block_sequence_state *seq_sta=
te
> * Helper function to add DPP set output transfer function to block sequen=
ce
> */
>  void hwss_add_dpp_set_output_transfer_func(struct block_sequence_state
> *seq_state, -		struct dc *dc,
> -		struct pipe_ctx *pipe_ctx,
> -		struct dc_stream_state *stream)
> +		struct dc *dc, struct pipe_ctx *pipe_ctx)
>  {
>  	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
> -		seq_state->steps[*seq_state-
>num_steps].params.set_output_transfer_func_p
> arams.dc =3D dc;
> -		seq_state->steps[*seq_state-
>num_steps].params.set_output_transfer_func_
> params.pipe_ctx =3D pipe_ctx;
> -		seq_state->steps[*seq_state-
>num_steps].params.set_output_transfer_func_
> params.stream =3D stream;
> +		seq_state->steps[*seq_state-
>num_steps].params.set_output_transfer_func_
> params =3D +		(struct set_output_transfer_func_params) {
> +			.xfm =3D pipe_ctx->plane_res.xfm,
> +			.dpp =3D pipe_ctx->plane_res.dpp,
> +			.mpc =3D dc->res_pool->mpc,
> +			.mpcc_id =3D pipe_ctx->plane_res.hubp->inst,
> +			.is_top_pipe =3D=20
resource_is_pipe_type(pipe_ctx, OPP_HEAD),
> +			.stream =3D pipe_ctx->stream,
> +		};
>  		seq_state->steps[*seq_state->num_steps].func =3D
> DPP_SET_OUTPUT_TRANSFER_FUNC; (*seq_state->num_steps)++;
>  	}
>  }
>=20
> +void hwss_set_output_transfer_func(struct dc *dc, struct pipe_ctx
> *pipe_ctx) +{
> +	if (dc->hwseq->funcs.set_output_transfer_func) {
> +		dc->hwseq->funcs.set_output_transfer_func(
> +			&(struct set_output_transfer_func_params) {
> +				.xfm =3D pipe_ctx->plane_res.xfm,
> +				.dpp =3D pipe_ctx->plane_res.dpp,
> +				.mpc =3D dc->res_pool->mpc,
> +				.mpcc_id =3D pipe_ctx-
>plane_res.hubp->inst,
> +				.is_top_pipe =3D=20
resource_is_pipe_type(pipe_ctx, OPP_HEAD),
> +				.stream =3D pipe_ctx->stream,
> +			}
> +		);
> +	}
> +}
> +
>  /*
>   * Helper function to add MPC update visual confirm to block sequence
>   */
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c index
> 74b046ab3bc3..4830a0d94177 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> @@ -607,11 +607,10 @@ dce110_translate_regamma_to_hw_format(const struct
> dc_transfer_func *output_tf, }
>=20
>  static bool
> -dce110_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
> -				const struct dc_stream_state=20
*stream)
> +dce110_set_output_transfer_func(struct set_output_transfer_func_params
> *params) {
> -	(void)dc;
> -	struct transform *xfm =3D pipe_ctx->plane_res.xfm;
> +	struct transform *xfm =3D params->xfm;
> +	const struct dc_stream_state *stream =3D params->stream;
>=20
>  	xfm->funcs->opp_power_on_regamma_lut(xfm, true);
>  	xfm->regamma_params.hw_points_num =3D GAMMA_HW_POINTS_NUM;
> @@ -3181,7 +3180,7 @@ static void dce110_program_front_end_for_pipe(
>  		hws->funcs.set_input_transfer_func(dc, pipe_ctx,=20
pipe_ctx->plane_state);
>=20
>  	if (pipe_ctx->plane_state->update_bits.full_update)
> -		hws->funcs.set_output_transfer_func(dc, pipe_ctx,=20
pipe_ctx->stream);
> +		hwss_set_output_transfer_func(dc, pipe_ctx);
>=20
>  	DC_LOG_SURFACE(
>  			"Pipe:%d %p: addr hi:0x%x, "
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce60/dce60_hwseq.c
> b/drivers/gpu/drm/amd/display/dc/hwss/dce60/dce60_hwseq.c index
> 26aa303b8237..221996b348ab 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce60/dce60_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce60/dce60_hwseq.c
> @@ -338,7 +338,7 @@ dce60_program_front_end_for_pipe(
>  		hws->funcs.set_input_transfer_func(dc, pipe_ctx,=20
pipe_ctx->plane_state);
>=20
>  	if (pipe_ctx->plane_state->update_bits.full_update)
> -		hws->funcs.set_output_transfer_func(dc, pipe_ctx,=20
pipe_ctx->stream);
> +		hwss_set_output_transfer_func(dc, pipe_ctx);
>=20
>  	DC_LOG_SURFACE(
>  			"Pipe:%d %p: addr hi:0x%x, "
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c index
> 8c636698d6d4..3be0bde5aea1 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> @@ -2154,10 +2154,11 @@ static void log_tf(struct dc_context *ctx,
>  	}
>  }
>=20
> -bool dcn10_set_output_transfer_func(struct dc *dc, struct pipe_ctx
> *pipe_ctx, -				const struct dc_stream_state=20
*stream)
> +bool dcn10_set_output_transfer_func(struct set_output_transfer_func_para=
ms
> *params) {
> -	struct dpp *dpp =3D pipe_ctx->plane_res.dpp;
> +	struct dpp *dpp =3D params->dpp;
> +	const struct dc_stream_state *stream =3D params->stream;
> +	struct dc *dc;
>=20
>  	if (!stream)
>  		return false;
> @@ -2165,6 +2166,8 @@ bool dcn10_set_output_transfer_func(struct dc *dc,
> struct pipe_ctx *pipe_ctx, if (dpp =3D=3D NULL)
>  		return false;
>=20
> +	dc =3D dpp->ctx->dc;
> +
>  	dpp->regamma_params.hw_points_num =3D GAMMA_HW_POINTS_NUM;
>=20
>  	if (stream->out_transfer_func.type =3D=3D TF_TYPE_PREDEFINED &&
> @@ -3301,7 +3304,7 @@ void dcn10_program_pipe(
>  	 * doing heavy calculation and programming
>  	 */
>  	if (pipe_ctx->plane_state->update_bits.full_update)
> -		hws->funcs.set_output_transfer_func(dc, pipe_ctx,=20
pipe_ctx->stream);
> +		hwss_set_output_transfer_func(dc, pipe_ctx);
>  }
>=20
>  void dcn10_wait_for_pending_cleared(struct dc *dc,
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
> b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h index
> 162972dfdbe8..2cb674ba54e1 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
> @@ -73,8 +73,7 @@ void dcn10_program_output_csc(struct dc *dc,
>  		enum dc_color_space colorspace,
>  		uint16_t *matrix,
>  		int opp_id);
> -bool dcn10_set_output_transfer_func(struct dc *dc, struct pipe_ctx
> *pipe_ctx, -				const struct dc_stream_state=20
*stream);
> +bool dcn10_set_output_transfer_func(struct set_output_transfer_func_para=
ms
> *params); bool dcn10_set_input_transfer_func(struct dc *dc, struct pipe_c=
tx
> *pipe_ctx, const struct dc_plane_state *plane_state);
>  void dcn10_update_plane_addr(const struct dc *dc, struct pipe_ctx
> *pipe_ctx); diff --git
> a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c index
> 83794d5b838c..98778d5e114e 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> @@ -1019,26 +1019,30 @@ void dcn20_program_output_csc(struct dc *dc,
>  	}
>  }
>=20
> -bool dcn20_set_output_transfer_func(struct dc *dc, struct pipe_ctx
> *pipe_ctx, -				const struct dc_stream_state=20
*stream)
> +bool dcn20_set_output_transfer_func(struct set_output_transfer_func_para=
ms
> *otf_params) {
> -	int mpcc_id =3D pipe_ctx->plane_res.hubp->inst;
> -	struct mpc *mpc =3D pipe_ctx->stream_res.opp->ctx->dc->res_pool-
>mpc;
> +	struct dpp *dpp =3D otf_params->dpp;
> +	struct mpc *mpc =3D otf_params->mpc;
> +	int mpcc_id =3D otf_params->mpcc_id;
> +	bool is_top_pipe =3D otf_params->is_top_pipe;
> +	const struct dc_stream_state *stream =3D otf_params->stream;
> +	struct dc *dc =3D dpp->ctx->dc;
>  	const struct pwl_params *params =3D NULL;
> +
>  	/*
>  	 * program OGAM only for the top pipe
>  	 * if there is a pipe split then fix diagnostic is required:
>  	 * how to pass OGAM parameter for stream.
>  	 * if programming for all pipes is required then remove condition
> -	 * pipe_ctx->top_pipe =3D=3D NULL ,but then fix the diagnostic.
> +	 * is_top_pipe ,but then fix the diagnostic.
>  	 */
>  	if (mpc->funcs->power_on_mpc_mem_pwr)
>  		mpc->funcs->power_on_mpc_mem_pwr(mpc, mpcc_id, true);
> -	if (pipe_ctx->top_pipe =3D=3D NULL
> +	if (is_top_pipe
>  			&& mpc->funcs->set_output_gamma) {
>  		if (stream->out_transfer_func.type =3D=3D TF_TYPE_HWPWL)
>  			params =3D &stream->out_transfer_func.pwl;
> -		else if (pipe_ctx->stream->out_transfer_func.type =3D=3D
> +		else if (stream->out_transfer_func.type =3D=3D
>  			TF_TYPE_DISTRIBUTED_POINTS &&
>  			cm_helper_translate_curve_to_hw_format(dc-
>ctx,
>  			&stream->out_transfer_func,
> @@ -1991,7 +1995,7 @@ static void dcn20_program_pipe(
>  	if (pipe_ctx->update_flags.bits.enable ||
>  	    pipe_ctx->update_flags.bits.plane_changed ||
>  	    pipe_ctx->stream->update_flags.bits.out_tf)
> -		hws->funcs.set_output_transfer_func(dc, pipe_ctx,=20
pipe_ctx->stream);
> +		hwss_set_output_transfer_func(dc, pipe_ctx);
>=20
>  	/* If the pipe has been enabled or has a different opp, we
>  	 * should reprogram the fmt. This deals with cases where
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
> b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h index
> 9d1ad3b29ca5..749348d3c793 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
> @@ -44,8 +44,7 @@ void dcn20_update_plane_addr(const struct dc *dc, struct
> pipe_ctx *pipe_ctx); void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx
> *pipe_ctx); bool dcn20_set_input_transfer_func(struct dc *dc, struct
> pipe_ctx *pipe_ctx, const struct dc_plane_state *plane_state);
> -bool dcn20_set_output_transfer_func(struct dc *dc, struct pipe_ctx
> *pipe_ctx, -			const struct dc_stream_state *stream);
> +bool dcn20_set_output_transfer_func(struct set_output_transfer_func_para=
ms
> *params); void dcn20_program_output_csc(struct dc *dc,
>  		struct pipe_ctx *pipe_ctx,
>  		enum dc_color_space colorspace,
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c index
> 82a662efa49f..59184e146fc9 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> @@ -256,13 +256,10 @@ bool dcn30_set_blend_lut(
>  	return result;
>  }
>=20
> -static bool dcn30_set_mpc_shaper_3dlut(struct pipe_ctx *pipe_ctx,
> -				       const struct=20
dc_stream_state *stream)
> +static bool dcn30_set_mpc_shaper_3dlut(struct dpp *dpp, struct mpc *mpc,
> +				       int mpcc_id, const struct=20
dc_stream_state *stream)
>  {
> -	struct dpp *dpp_base =3D pipe_ctx->plane_res.dpp;
> -	int mpcc_id =3D pipe_ctx->plane_res.hubp->inst;
> -	struct dc *dc =3D pipe_ctx->stream->ctx->dc;
> -	struct mpc *mpc =3D pipe_ctx->stream_res.opp->ctx->dc->res_pool-
>mpc;
> +	struct dc *dc =3D dpp->ctx->dc;
>  	bool result =3D false;
>  	uint32_t acquired_rmu =3D 0;
>  	int mpcc_id_projected =3D 0;
> @@ -274,8 +271,8 @@ static bool dcn30_set_mpc_shaper_3dlut(struct pipe_ctx
> *pipe_ctx, shaper_lut =3D &stream->func_shaper->pwl;
>  		} else if (stream->func_shaper->type =3D=3D=20
TF_TYPE_DISTRIBUTED_POINTS) {
>  		=09
cm_helper_translate_curve_to_hw_format(stream->ctx, stream->func_shaper,
> -							      =20
&dpp_base->shaper_params, true);
> -			shaper_lut =3D &dpp_base->shaper_params;
> +							      =20
&dpp->shaper_params, true);
> +			shaper_lut =3D &dpp->shaper_params;
>  		}
>  	}
>=20
> @@ -398,23 +395,25 @@ void dcn30_program_gamut_remap(struct
> program_gamut_remap_params *params) mpc->funcs->set_gamut_remap(mpc,
> mpcc_id, &mpc_adjust);
>  }
>=20
> -bool dcn30_set_output_transfer_func(struct dc *dc,
> -				struct pipe_ctx *pipe_ctx,
> -				const struct dc_stream_state=20
*stream)
> +bool dcn30_set_output_transfer_func(struct set_output_transfer_func_para=
ms
> *otf_params) {
> -	int mpcc_id =3D pipe_ctx->plane_res.hubp->inst;
> -	struct mpc *mpc =3D pipe_ctx->stream_res.opp->ctx->dc->res_pool-
>mpc;
> +	struct dpp *dpp =3D otf_params->dpp;
> +	struct mpc *mpc =3D otf_params->mpc;
> +	int mpcc_id =3D otf_params->mpcc_id;
> +	bool is_top_pipe =3D otf_params->is_top_pipe;
> +	const struct dc_stream_state *stream =3D otf_params->stream;
> +	struct dc *dc =3D dpp->ctx->dc;
>  	const struct pwl_params *params =3D NULL;
>  	bool ret =3D false;
>=20
>  	/* program OGAM or 3DLUT only for the top pipe*/
> -	if (pipe_ctx->top_pipe =3D=3D NULL) {
> +	if (is_top_pipe) {
>  		/*program rmu shaper and 3dlut in MPC*/
> -		ret =3D dcn30_set_mpc_shaper_3dlut(pipe_ctx, stream);
> +		ret =3D dcn30_set_mpc_shaper_3dlut(dpp, mpc, mpcc_id,=20
stream);
>  		if (ret =3D=3D false && mpc->funcs->set_output_gamma) {
>  			if (stream->out_transfer_func.type =3D=3D=20
TF_TYPE_HWPWL)
>  				params =3D &stream-
>out_transfer_func.pwl;
> -			else if (pipe_ctx->stream-
>out_transfer_func.type =3D=3D
> +			else if (stream->out_transfer_func.type =3D=3D
>  				=09
TF_TYPE_DISTRIBUTED_POINTS &&
>  				=09
cm3_helper_translate_curve_to_hw_format(stream->ctx,
>  					&stream-
>out_transfer_func,
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
> b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h index
> 4182cf399424..0399642076eb 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
> @@ -65,9 +65,7 @@ bool dcn30_set_input_transfer_func(struct dc *dc,
>=20
>  void dcn30_program_gamut_remap(struct program_gamut_remap_params *params=
);
>=20
> -bool dcn30_set_output_transfer_func(struct dc *dc,
> -				struct pipe_ctx *pipe_ctx,
> -				const struct dc_stream_state=20
*stream);
> +bool dcn30_set_output_transfer_func(struct set_output_transfer_func_para=
ms
> *params); void dcn30_set_avmute(struct pipe_ctx *pipe_ctx, bool enable);
>  void dcn30_update_info_frame(struct pipe_ctx *pipe_ctx);
>  void dcn30_program_dmdata_engine(struct pipe_ctx *pipe_ctx);
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c index
> c2ea25927765..c5f6eb482f07 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> @@ -443,13 +443,10 @@ void dcn32_subvp_pipe_control_lock_fast(union
> block_sequence_params *params) }
>  }
>=20
> -bool dcn32_set_mpc_shaper_3dlut(
> -	struct pipe_ctx *pipe_ctx, const struct dc_stream_state *stream)
> +bool dcn32_set_mpc_shaper_3dlut(struct dpp *dpp, struct mpc *mpc,
> +	int mpcc_id, const struct dc_stream_state *stream)
>  {
> -	struct dpp *dpp_base =3D pipe_ctx->plane_res.dpp;
> -	int mpcc_id =3D pipe_ctx->plane_res.hubp->inst;
> -	struct dc *dc =3D pipe_ctx->stream->ctx->dc;
> -	struct mpc *mpc =3D pipe_ctx->stream_res.opp->ctx->dc->res_pool-
>mpc;
> +	struct dc *dc =3D dpp->ctx->dc;
>  	bool result =3D false;
>=20
>  	const struct pwl_params *shaper_lut =3D NULL;
> @@ -460,8 +457,8 @@ bool dcn32_set_mpc_shaper_3dlut(
>  		else if (stream->func_shaper->type =3D=3D=20
TF_TYPE_DISTRIBUTED_POINTS) {
>  		=09
cm_helper_translate_curve_to_hw_format(stream->ctx,
>  					stream->func_shaper,
> -					&dpp_base-
>shaper_params, true);
> -			shaper_lut =3D &dpp_base->shaper_params;
> +					&dpp->shaper_params,=20
true);
> +			shaper_lut =3D &dpp->shaper_params;
>  		}
>  	}
>=20
> @@ -566,24 +563,24 @@ bool dcn32_set_input_transfer_func(struct dc *dc,
>  	return result;
>  }
>=20
> -bool dcn32_set_output_transfer_func(struct dc *dc,
> -				struct pipe_ctx *pipe_ctx,
> -				const struct dc_stream_state=20
*stream)
> +bool dcn32_set_output_transfer_func(struct set_output_transfer_func_para=
ms
> *otf_params) {
> -	(void)dc;
> -	int mpcc_id =3D pipe_ctx->plane_res.hubp->inst;
> -	struct mpc *mpc =3D pipe_ctx->stream_res.opp->ctx->dc->res_pool-
>mpc;
> +	struct dpp *dpp =3D otf_params->dpp;
> +	struct mpc *mpc =3D otf_params->mpc;
> +	int mpcc_id =3D otf_params->mpcc_id;
> +	bool is_top_pipe =3D otf_params->is_top_pipe;
> +	const struct dc_stream_state *stream =3D otf_params->stream;
>  	const struct pwl_params *params =3D NULL;
>  	bool ret =3D false;
>=20
>  	/* program OGAM or 3DLUT only for the top pipe*/
> -	if (resource_is_pipe_type(pipe_ctx, OPP_HEAD)) {
> +	if (is_top_pipe) {
>  		/*program shaper and 3dlut in MPC*/
> -		ret =3D dcn32_set_mpc_shaper_3dlut(pipe_ctx, stream);
> +		ret =3D dcn32_set_mpc_shaper_3dlut(dpp, mpc, mpcc_id,=20
stream);
>  		if (ret =3D=3D false && mpc->funcs->set_output_gamma) {
>  			if (stream->out_transfer_func.type =3D=3D=20
TF_TYPE_HWPWL)
>  				params =3D &stream-
>out_transfer_func.pwl;
> -			else if (pipe_ctx->stream-
>out_transfer_func.type =3D=3D
> +			else if (stream->out_transfer_func.type =3D=3D
>  				=09
TF_TYPE_DISTRIBUTED_POINTS &&
>  				=09
cm3_helper_translate_curve_to_hw_format(stream->ctx,
>  					&stream-
>out_transfer_func,
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
> b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h index
> 0303a5953673..090d94d38343 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
> @@ -54,12 +54,10 @@ bool dcn32_set_input_transfer_func(struct dc *dc,
>  				struct pipe_ctx *pipe_ctx,
>  				const struct dc_plane_state=20
*plane_state);
>=20
> -bool dcn32_set_mpc_shaper_3dlut(
> -	struct pipe_ctx *pipe_ctx, const struct dc_stream_state *stream);
> +bool dcn32_set_mpc_shaper_3dlut(struct dpp *dpp_base, struct mpc *mpc,
> +	int mpcc_id, const struct dc_stream_state *stream);
>=20
> -bool dcn32_set_output_transfer_func(struct dc *dc,
> -				struct pipe_ctx *pipe_ctx,
> -				const struct dc_stream_state=20
*stream);
> +bool dcn32_set_output_transfer_func(struct set_output_transfer_func_para=
ms
> *params);
>=20
>  void dcn32_init_hw(struct dc *dc);
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
> b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c index
> 5c1ba5d88c7a..161ef57ebce1 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
> @@ -696,24 +696,24 @@ bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
>  	return result;
>  }
>=20
> -bool dcn401_set_output_transfer_func(struct dc *dc,
> -				struct pipe_ctx *pipe_ctx,
> -				const struct dc_stream_state=20
*stream)
> +bool dcn401_set_output_transfer_func(struct set_output_transfer_func_par=
ams
> *otf_params) {
> -	(void)dc;
> -	int mpcc_id =3D pipe_ctx->plane_res.hubp->inst;
> -	struct mpc *mpc =3D pipe_ctx->stream_res.opp->ctx->dc->res_pool-
>mpc;
> +	struct dpp *dpp =3D otf_params->dpp;
> +	struct mpc *mpc =3D otf_params->mpc;
> +	int mpcc_id =3D otf_params->mpcc_id;
> +	bool is_top_pipe =3D otf_params->is_top_pipe;
> +	const struct dc_stream_state *stream =3D otf_params->stream;
>  	const struct pwl_params *params =3D NULL;
>  	bool ret =3D false;
>=20
>  	/* program OGAM or 3DLUT only for the top pipe*/
> -	if (resource_is_pipe_type(pipe_ctx, OPP_HEAD)) {
> +	if (is_top_pipe) {
>  		/*program shaper and 3dlut in MPC*/
> -		ret =3D dcn32_set_mpc_shaper_3dlut(pipe_ctx, stream);
> +		ret =3D dcn32_set_mpc_shaper_3dlut(dpp, mpc, mpcc_id,=20
stream);
>  		if (ret =3D=3D false && mpc->funcs->set_output_gamma) {
>  			if (stream->out_transfer_func.type =3D=3D=20
TF_TYPE_HWPWL)
>  				params =3D &stream-
>out_transfer_func.pwl;
> -			else if (pipe_ctx->stream-
>out_transfer_func.type =3D=3D
> +			else if (stream->out_transfer_func.type =3D=3D
>  				=09
TF_TYPE_DISTRIBUTED_POINTS &&
>  				=09
cm3_helper_translate_curve_to_hw_format(stream->ctx,
>  					&stream-
>out_transfer_func,
> @@ -2397,7 +2397,7 @@ void dcn401_program_pipe(
>  	if (pipe_ctx->update_flags.bits.enable ||
>  	    pipe_ctx->update_flags.bits.plane_changed ||
>  	    pipe_ctx->stream->update_flags.bits.out_tf)
> -		hws->funcs.set_output_transfer_func(dc, pipe_ctx,=20
pipe_ctx->stream);
> +		hwss_set_output_transfer_func(dc, pipe_ctx);
>=20
>  	/* If the pipe has been enabled or has a different opp, we
>  	 * should reprogram the fmt. This deals with cases where
> @@ -2555,7 +2555,7 @@ void dcn401_program_pipe_sequence(
>  	if (pipe_ctx->update_flags.bits.enable ||
>  			pipe_ctx->update_flags.bits.plane_changed ||
>  			pipe_ctx->stream->update_flags.bits.out_tf) {
> -		hwss_add_dpp_set_output_transfer_func(seq_state, dc,=20
pipe_ctx,
> pipe_ctx->stream); +	=09
hwss_add_dpp_set_output_transfer_func(seq_state, dc,
> pipe_ctx); }
>=20
>  	/* If the pipe has been enabled or has a different opp, we
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
> b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h index
> 6d2e93149811..f90e25243ead 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
> @@ -38,9 +38,7 @@ void dcn401_init_hw(struct dc *dc);
>=20
>  bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
>  				const struct dc_plane_state=20
*plane_state);
> -bool dcn401_set_output_transfer_func(struct dc *dc,
> -				struct pipe_ctx *pipe_ctx,
> -				const struct dc_stream_state=20
*stream);
> +bool dcn401_set_output_transfer_func(struct set_output_transfer_func_par=
ams
> *params); void dcn401_trigger_3dlut_dma_load(struct dc *dc,
>  				struct pipe_ctx *pipe_ctx);
>  void dcn401_calculate_dccg_tmds_div_value(struct pipe_ctx *pipe_ctx,
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
> b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h index
> d8398b39a119..e8bf96a7d63a 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
> @@ -138,8 +138,11 @@ struct program_bias_and_scale_params {
>  };
>=20
>  struct set_output_transfer_func_params {
> -	struct dc *dc;
> -	struct pipe_ctx *pipe_ctx;
> +	struct transform *xfm;
> +	struct dpp *dpp;
> +	struct mpc *mpc;
> +	int mpcc_id;
> +	bool is_top_pipe;
>  	const struct dc_stream_state *stream;
>  };
>=20
> @@ -1993,7 +1996,9 @@ void hwss_add_optc_program_manual_trigger(struct
> block_sequence_state *seq_state struct pipe_ctx *pipe_ctx);
>=20
>  void hwss_add_dpp_set_output_transfer_func(struct block_sequence_state
> *seq_state, -		struct dc *dc, struct pipe_ctx *pipe_ctx,=20
struct
> dc_stream_state *stream); +		struct dc *dc, struct pipe_ctx=20
*pipe_ctx);
> +
> +void hwss_set_output_transfer_func(struct dc *dc, struct pipe_ctx
> *pipe_ctx);
>=20
>  void hwss_add_mpc_update_visual_confirm(struct block_sequence_state
> *seq_state, struct dc *dc, struct pipe_ctx *pipe_ctx, int mpcc_id);
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
> b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h index
> b4956893ae9a..31ace62a37d9 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
> @@ -67,6 +67,8 @@ struct dc_phy_addr_space_config;
>  struct dc_virtual_addr_space_config;
>  struct hubp;
>  struct dpp;
> +struct transform;
> +struct mpc;
>  struct dce_hwseq;
>  struct timing_generator;
>  struct tg_color;
> @@ -92,9 +94,7 @@ struct hwseq_private_funcs {
>  	bool (*set_input_transfer_func)(struct dc *dc,
>  				struct pipe_ctx *pipe_ctx,
>  				const struct dc_plane_state=20
*plane_state);
> -	bool (*set_output_transfer_func)(struct dc *dc,
> -				struct pipe_ctx *pipe_ctx,
> -				const struct dc_stream_state=20
*stream);
> +	bool (*set_output_transfer_func)(struct=20
set_output_transfer_func_params
> *params); void (*power_down)(struct dc *dc);
>  	void (*enable_display_pipe_clock_gating)(struct dc_context *ctx,
>  					bool clock_gating);




