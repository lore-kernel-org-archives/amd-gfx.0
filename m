Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044F3C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 15:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B9E110EF14;
	Wed, 12 Jan 2022 15:54:01 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7319910EF09
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 15:54:00 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 35-20020a9d08a6000000b00579cd5e605eso3061049otf.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 07:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+u14c/536iv/vLiNBW4Ci4ntFEjiLW39KFsSbilMnf8=;
 b=ARAyNhA0aHdJpaBFoRnuDWXuQfifJOcIVS4h9mEWmrhWIII//grRtnKWJrz/BhO5HB
 pF7/3fEJefBzwOzUi+Au965UvENXLUXQwGIodao4uZpKT2/tHgjzcEidVDmwnx17cXfh
 184d6dPNGsyWSYfIseud0oEWxKxsKZTqG1aMfmRwDNTh6mcb264mZtNv6DuKhAWQD1fs
 lNyzRvYjfCQGW2l52vP/egWbC8JlEoxI7m/BrZ0adl5cWLekR/TIF/yuMhHwmrZzz78M
 o9T56TqSuHUtajCjTej47nLob/FmH1Kv8kTU0rwJP6R0/EtC3FyM/uT0hzVdAgy+9cEx
 iLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+u14c/536iv/vLiNBW4Ci4ntFEjiLW39KFsSbilMnf8=;
 b=m1qJSo3oIJ78tmoRAZfUL15qETR4LyeWgmqEvG4eP5xhSnV4v7CYRrymAhs+7t3hR6
 yZtBraeg2ErmJFja90bCFGB4qpr6EAE9kIy1VnOH9KCtygG+UpJI5GkE7XuvlyOsrDtt
 oKyTEpo+xUFkRAMvy9Fv4Ldu4ch+NWFUI/+JZi4DxRgmJoi3ldYUAuJtDdNIzOj9xadS
 KiCQX/Y6iW8idBk+2ho1bAdXIvCoWTvhwcPGLhQRXAhPO82PENXxg7G//Wiha0XQawHw
 snRZkGECwiwy4RLuuuTkduTwkBkFgeEFQfVdjQVFgjh8IA02U7x2T0dHPWJYU1xKpr5O
 fX0g==
X-Gm-Message-State: AOAM532U6h6o6RxauaaMPQZ/AFTENSEyMkuCZ8MY6A2DxZM8ZJY5VkdK
 LpdlnwqgOimt7qj8uSSCf3Bzj64j3/u0VzGgXwI=
X-Google-Smtp-Source: ABdhPJzz0CBpXcehWY0qr+IO7xSPZSgRMPuWMaL4annX4ZtJiGNoQTRYqv3cJc1ugNBPPFSG1SqxGj1A5XGwaxbFodA=
X-Received: by 2002:a9d:6043:: with SMTP id v3mr254263otj.357.1642002838409;
 Wed, 12 Jan 2022 07:53:58 -0800 (PST)
MIME-Version: 1.0
References: <20220112142727.16295-1-harry.wentland@amd.com>
 <20220112142727.16295-3-harry.wentland@amd.com>
In-Reply-To: <20220112142727.16295-3-harry.wentland@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Jan 2022 10:53:47 -0500
Message-ID: <CADnq5_MVeUXy1R=N5W92afEQujNffPuaFWcGPH1YD9gfiu=RBw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/display: Fix for otg synchronization logic
To: Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mustapha Ghaddar <mustapha.ghaddar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 12, 2022 at 9:28 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
>
> [Why]
> During otg sync trigger, plane states are used to decide whether the otg
> is already synchronized or not. There are scenarions when otgs are
> disabled without plane state getting disabled and in such case the otg is
> excluded from synchronization.
>
> [How]
> Introduced pipe_idx_syncd in pipe_ctx that tracks each otgs master pipe.
> When a otg is disabled/enabled, pipe_idx_syncd is reset to itself.
> On sync trigger, pipe_idx_syncd is checked to decide whether a otg is
> already synchronized and the otg is further included or excluded from
> synchronization.
>
> v2:
>   Don't drop is_blanked logic
>
> Reviewed-by: Jun Lei <Jun.Lei@amd.com>
> Reviewed-by: Mustapha Ghaddar <mustapha.ghaddar@amd.com>
> Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> Signed-off-by: meenakshikumar somasundaram <meenakshikumar.somasundaram@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Cc: torvalds@linux-foundation.org

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c      | 40 +++++++++-----
>  .../gpu/drm/amd/display/dc/core/dc_resource.c | 54 +++++++++++++++++++
>  drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
>  .../display/dc/dce110/dce110_hw_sequencer.c   |  8 +++
>  .../drm/amd/display/dc/dcn31/dcn31_resource.c |  3 ++
>  .../gpu/drm/amd/display/dc/inc/core_types.h   |  1 +
>  drivers/gpu/drm/amd/display/dc/inc/resource.h | 11 ++++
>  7 files changed, 105 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 01c8849b9db2..6f5528d34093 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1404,20 +1404,34 @@ static void program_timing_sync(
>                                 status->timing_sync_info.master = false;
>
>                 }
> -               /* remove any other unblanked pipes as they have already been synced */
> -               for (j = j + 1; j < group_size; j++) {
> -                       bool is_blanked;
>
> -                       if (pipe_set[j]->stream_res.opp->funcs->dpg_is_blanked)
> -                               is_blanked =
> -                                       pipe_set[j]->stream_res.opp->funcs->dpg_is_blanked(pipe_set[j]->stream_res.opp);
> -                       else
> -                               is_blanked =
> -                                       pipe_set[j]->stream_res.tg->funcs->is_blanked(pipe_set[j]->stream_res.tg);
> -                       if (!is_blanked) {
> -                               group_size--;
> -                               pipe_set[j] = pipe_set[group_size];
> -                               j--;
> +               /* remove any other pipes that are already been synced */
> +               if (dc->config.use_pipe_ctx_sync_logic) {
> +                       /* check pipe's syncd to decide which pipe to be removed */
> +                       for (j = 1; j < group_size; j++) {
> +                               if (pipe_set[j]->pipe_idx_syncd == pipe_set[0]->pipe_idx_syncd) {
> +                                       group_size--;
> +                                       pipe_set[j] = pipe_set[group_size];
> +                                       j--;
> +                               } else
> +                                       /* link slave pipe's syncd with master pipe */
> +                                       pipe_set[j]->pipe_idx_syncd = pipe_set[0]->pipe_idx_syncd;
> +                       }
> +               } else {
> +                       for (j = j + 1; j < group_size; j++) {
> +                               bool is_blanked;
> +
> +                               if (pipe_set[j]->stream_res.opp->funcs->dpg_is_blanked)
> +                                       is_blanked =
> +                                               pipe_set[j]->stream_res.opp->funcs->dpg_is_blanked(pipe_set[j]->stream_res.opp);
> +                               else
> +                                       is_blanked =
> +                                               pipe_set[j]->stream_res.tg->funcs->is_blanked(pipe_set[j]->stream_res.tg);
> +                               if (!is_blanked) {
> +                                       group_size--;
> +                                       pipe_set[j] = pipe_set[group_size];
> +                                       j--;
> +                               }
>                         }
>                 }
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index d4ff6cc6b8d9..b3912ff9dc91 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -3217,6 +3217,60 @@ struct hpo_dp_link_encoder *resource_get_hpo_dp_link_enc_for_det_lt(
>  }
>  #endif
>
> +void reset_syncd_pipes_from_disabled_pipes(struct dc *dc,
> +               struct dc_state *context)
> +{
> +       int i, j;
> +       struct pipe_ctx *pipe_ctx_old, *pipe_ctx, *pipe_ctx_syncd;
> +
> +       /* If pipe backend is reset, need to reset pipe syncd status */
> +       for (i = 0; i < dc->res_pool->pipe_count; i++) {
> +               pipe_ctx_old =  &dc->current_state->res_ctx.pipe_ctx[i];
> +               pipe_ctx = &context->res_ctx.pipe_ctx[i];
> +
> +               if (!pipe_ctx_old->stream)
> +                       continue;
> +
> +               if (pipe_ctx_old->top_pipe || pipe_ctx_old->prev_odm_pipe)
> +                       continue;
> +
> +               if (!pipe_ctx->stream ||
> +                               pipe_need_reprogram(pipe_ctx_old, pipe_ctx)) {
> +
> +                       /* Reset all the syncd pipes from the disabled pipe */
> +                       for (j = 0; j < dc->res_pool->pipe_count; j++) {
> +                               pipe_ctx_syncd = &context->res_ctx.pipe_ctx[j];
> +                               if ((GET_PIPE_SYNCD_FROM_PIPE(pipe_ctx_syncd) == pipe_ctx_old->pipe_idx) ||
> +                                       !IS_PIPE_SYNCD_VALID(pipe_ctx_syncd))
> +                                       SET_PIPE_SYNCD_TO_PIPE(pipe_ctx_syncd, j);
> +                       }
> +               }
> +       }
> +}
> +
> +void check_syncd_pipes_for_disabled_master_pipe(struct dc *dc,
> +       struct dc_state *context,
> +       uint8_t disabled_master_pipe_idx)
> +{
> +       int i;
> +       struct pipe_ctx *pipe_ctx, *pipe_ctx_check;
> +
> +       pipe_ctx = &context->res_ctx.pipe_ctx[disabled_master_pipe_idx];
> +       if ((GET_PIPE_SYNCD_FROM_PIPE(pipe_ctx) != disabled_master_pipe_idx) ||
> +               !IS_PIPE_SYNCD_VALID(pipe_ctx))
> +               SET_PIPE_SYNCD_TO_PIPE(pipe_ctx, disabled_master_pipe_idx);
> +
> +       /* for the pipe disabled, check if any slave pipe exists and assert */
> +       for (i = 0; i < dc->res_pool->pipe_count; i++) {
> +               pipe_ctx_check = &context->res_ctx.pipe_ctx[i];
> +
> +               if ((GET_PIPE_SYNCD_FROM_PIPE(pipe_ctx_check) == disabled_master_pipe_idx) &&
> +                       IS_PIPE_SYNCD_VALID(pipe_ctx_check) && (i != disabled_master_pipe_idx))
> +                       DC_ERR("DC: Failure: pipe_idx[%d] syncd with disabled master pipe_idx[%d]\n",
> +                               i, disabled_master_pipe_idx);
> +       }
> +}
> +
>  uint8_t resource_transmitter_to_phy_idx(const struct dc *dc, enum transmitter transmitter)
>  {
>         /* TODO - get transmitter to phy idx mapping from DMUB */
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index da2c78ce14d6..288e7b01f561 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -344,6 +344,7 @@ struct dc_config {
>         uint8_t  vblank_alignment_max_frame_time_diff;
>         bool is_asymmetric_memory;
>         bool is_single_rank_dimm;
> +       bool use_pipe_ctx_sync_logic;
>  };
>
>  enum visual_confirm {
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> index 78192ecba102..f1593186e964 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> @@ -1566,6 +1566,10 @@ static enum dc_status apply_single_controller_ctx_to_hw(
>                                 &pipe_ctx->stream->audio_info);
>         }
>
> +       /* make sure no pipes syncd to the pipe being enabled */
> +       if (!pipe_ctx->stream->apply_seamless_boot_optimization && dc->config.use_pipe_ctx_sync_logic)
> +               check_syncd_pipes_for_disabled_master_pipe(dc, context, pipe_ctx->pipe_idx);
> +
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>         /* DCN3.1 FPGA Workaround
>          * Need to enable HPO DP Stream Encoder before setting OTG master enable.
> @@ -2297,6 +2301,10 @@ enum dc_status dce110_apply_ctx_to_hw(
>         enum dc_status status;
>         int i;
>
> +       /* reset syncd pipes from disabled pipes */
> +       if (dc->config.use_pipe_ctx_sync_logic)
> +               reset_syncd_pipes_from_disabled_pipes(dc, context);
> +
>         /* Reset old context */
>         /* look up the targets that have been removed since last commit */
>         hws->funcs.reset_hw_ctx_wrap(dc, context);
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> index 1f1c158658ac..40778c05f9b3 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> @@ -2254,6 +2254,9 @@ static bool dcn31_resource_construct(
>         dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
>         dc->caps.color.mpc.ocsc = 1;
>
> +       /* Use pipe context based otg sync logic */
> +       dc->config.use_pipe_ctx_sync_logic = true;
> +
>         /* read VBIOS LTTPR caps */
>         {
>                 if (ctx->dc_bios->funcs->get_lttpr_caps) {
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
> index 890280026e69..943240e2809e 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
> @@ -382,6 +382,7 @@ struct pipe_ctx {
>         struct pll_settings pll_settings;
>
>         uint8_t pipe_idx;
> +       uint8_t pipe_idx_syncd;
>
>         struct pipe_ctx *top_pipe;
>         struct pipe_ctx *bottom_pipe;
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
> index 4249bf306e09..dbfe6690ded8 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
> @@ -34,6 +34,10 @@
>  #define MEMORY_TYPE_HBM 2
>
>
> +#define IS_PIPE_SYNCD_VALID(pipe) ((((pipe)->pipe_idx_syncd) & 0x80)?1:0)
> +#define GET_PIPE_SYNCD_FROM_PIPE(pipe) ((pipe)->pipe_idx_syncd & 0x7F)
> +#define SET_PIPE_SYNCD_TO_PIPE(pipe, pipe_syncd) ((pipe)->pipe_idx_syncd = (0x80 | pipe_syncd))
> +
>  enum dce_version resource_parse_asic_id(
>                 struct hw_asic_id asic_id);
>
> @@ -208,6 +212,13 @@ struct hpo_dp_link_encoder *resource_get_hpo_dp_link_enc_for_det_lt(
>                 const struct dc_link *link);
>  #endif
>
> +void reset_syncd_pipes_from_disabled_pipes(struct dc *dc,
> +       struct dc_state *context);
> +
> +void check_syncd_pipes_for_disabled_master_pipe(struct dc *dc,
> +       struct dc_state *context,
> +       uint8_t disabled_master_pipe_idx);
> +
>  uint8_t resource_transmitter_to_phy_idx(const struct dc *dc, enum transmitter transmitter);
>
>  #endif /* DRIVERS_GPU_DRM_AMD_DC_DEV_DC_INC_RESOURCE_H_ */
> --
> 2.34.1
>
