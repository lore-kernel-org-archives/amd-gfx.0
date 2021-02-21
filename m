Return-Path: <SRS0=BX2n=HX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4444EC433DB
	for <amd-gfx@archiver.kernel.org>; Sun, 21 Feb 2021 06:21:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDB6D64E29
	for <amd-gfx@archiver.kernel.org>; Sun, 21 Feb 2021 06:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB6D64E29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C8826E8F9;
	Sun, 21 Feb 2021 06:21:19 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEDDE6E8F9
 for <amd-gfx@lists.freedesktop.org>; Sun, 21 Feb 2021 06:21:17 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id z5so1400295pfe.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Feb 2021 22:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7j+8pd6XDlPN+tBKR5rwdKEV/2Mh/r9HZ0kGEIOHub0=;
 b=XYwnFAVX3OIu/KNYeg+FNes5ZfXO+LE7JajYWQDskW7YEZKjU+wtlCAIljaAF8crUS
 cBt16t8xV+fo4GO230mOkAdiZauXG+EAql2IiK4phuiuE/YHBepaoVzFYGOrhrVP63Tr
 3RkrmKbTiC+ogeiTTpxALdaG4wQyr+cCGnsotyxTu1N14XyOfLiDy1RsA8oFPYIUbaAw
 CtRRamVGLo73kdbNkzXkWteqIOv/26/miFELA4y2pTrv1PnYv+aJB9lIC3NKJgFTgfOx
 dgsBh12AFBj5EEH6HMgJ3/FzPQC11Ph3Yo6dZjcANB52hg1uJbwvOfjHP7oCfPmz1oPQ
 3bdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7j+8pd6XDlPN+tBKR5rwdKEV/2Mh/r9HZ0kGEIOHub0=;
 b=GgInFXn64KYyqdDmWBwMNwIBxvx1cPVnlnlXsDP2hdj0Vx7CBDc4fwq9zog3dnRmck
 wlyR6OERn+wUQ+buR1fFsHmOR9JleZCv9D+Gn47zBYEP952jx0g5NLIHmJUywg3+7x9l
 XO9YkQbziaE6FZb4K5e3WC6PdXsrLlp8e3/IE6MvPbdhzCwxoBDvpf0ZgbJD7+kfMXYn
 s3YhJeiRzrSNzyjSuRyGFO7RYnuLUmlgdMRcufkC+rXrcdF1MqXJ7lZ0r6u9UP+7/5Mk
 DkQLHZg/pjHzQnOD/YiRYjjYinnOMsGeEhiJI20AHBqJ/oRzydUOHpzId39IyEgcqJeO
 ZypQ==
X-Gm-Message-State: AOAM533yjSIx4UjaUnQNDPZTJlGoaNsUijbOWAXO7jTs/h4A5+MOpWYv
 gkLAogEkuUWfg+f3V7HxK7ZukpBEQpyaTIRjOwc=
X-Google-Smtp-Source: ABdhPJwbpeZSpX7NPxvPmmbYdkbitUUz96B9pi5M82aD3ZZfQCRrFYACTV7SWnq6Tz+Rx7t3OXAYWzTwEy0LLqS5kws=
X-Received: by 2002:aa7:910c:0:b029:1ed:ef1:81b with SMTP id
 12-20020aa7910c0000b02901ed0ef1081bmr14866564pfh.49.1613888476894; Sat, 20
 Feb 2021 22:21:16 -0800 (PST)
MIME-Version: 1.0
References: <20210219221612.1713328-1-bindu.r@amd.com>
 <20210219221612.1713328-9-bindu.r@amd.com>
In-Reply-To: <20210219221612.1713328-9-bindu.r@amd.com>
From: =?UTF-8?Q?Nils_Wallm=C3=A9nius?= <nils.wallmenius@gmail.com>
Date: Sun, 21 Feb 2021 07:21:06 +0100
Message-ID: <CA+nq7Dv1q1ncUZzSV=Art-etybyL+Ztx64=9uMYgVZiTsympHA@mail.gmail.com>
Subject: Re: [PATCH 08/13] drm/amd/display: Synchronize displays with
 different timings
To: Bindu Ramamurthy <bindu.r@amd.com>
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, amd-gfx@lists.freedesktop.org,
 Anson.Jacob@amd.com, Vladimir Stempen <vladimir.stempen@amd.com>,
 Aurabindo.Pillai@amd.com, Harry.Wentland@amd.com
Content-Type: multipart/mixed; boundary="===============0384258010=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0384258010==
Content-Type: multipart/alternative; boundary="0000000000005f597905bbd2b113"

--0000000000005f597905bbd2b113
Content-Type: text/plain; charset="UTF-8"

Hi Bindu, an inline comment below.

Den fre 19 feb. 2021 23:16Bindu Ramamurthy <bindu.r@amd.com> skrev:

> From: Vladimir Stempen <vladimir.stempen@amd.com>
>
> [why]
>  Vendor based fan noise improvement
>
> [how]
> Report timing synchronizable when DP streams time frame
> difference is less than 0.05 percent. Adjust DP  DTOs and
> sync displays using  MASTER_UPDATE_LOCK_DB_X_Y
>
> Signed-off-by: Vladimir Stempen <vladimir.stempen@amd.com>
> Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c      |  28 ++-
>  .../gpu/drm/amd/display/dc/core/dc_resource.c |  43 ++++
>  drivers/gpu/drm/amd/display/dc/dc.h           |   3 +
>  drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   1 +
>  drivers/gpu/drm/amd/display/dc/dc_stream.h    |   3 +
>  .../drm/amd/display/dc/dce/dce_clock_source.c |  52 +++-
>  .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 225 ++++++++++++++++++
>  .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   5 +
>  .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |   2 +
>  .../display/dc/dcn10/dcn10_stream_encoder.c   |   1 -
>  .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   1 +
>  .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c | 123 ++++++++++
>  .../drm/amd/display/dc/dcn20/dcn20_resource.c |   8 +-
>  .../dc/dcn30/dcn30_dio_stream_encoder.c       |   1 -
>  .../gpu/drm/amd/display/dc/inc/clock_source.h |   5 +
>  .../amd/display/dc/inc/hw/timing_generator.h  |  12 +
>  .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   3 +
>  drivers/gpu/drm/amd/display/dc/inc/resource.h |   4 +
>  18 files changed, 505 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c
> b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 2f56fa2c0bf4..39df5d2c0108 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1102,6 +1102,7 @@ static void program_timing_sync(
>
>         for (i = 0; i < pipe_count; i++) {
>                 int group_size = 1;
> +               enum timing_synchronization_type sync_type =
> NOT_SYNCHRONIZABLE;
>                 struct pipe_ctx *pipe_set[MAX_PIPES];
>
>                 if (!unsynced_pipes[i])
> @@ -1116,10 +1117,22 @@ static void program_timing_sync(
>                 for (j = i + 1; j < pipe_count; j++) {
>                         if (!unsynced_pipes[j])
>                                 continue;
> -
> -                       if (resource_are_streams_timing_synchronizable(
> +                       if (sync_type != TIMING_SYNCHRONIZABLE &&
> +                               dc->hwss.enable_vblanks_synchronization &&
> +
>  unsynced_pipes[j]->stream_res.tg->funcs->align_vblanks &&
> +                               resource_are_vblanks_synchronizable(
> +                                       unsynced_pipes[j]->stream,
> +                                       pipe_set[0]->stream)) {
> +                               sync_type = VBLANK_SYNCHRONIZABLE;
> +                               pipe_set[group_size] = unsynced_pipes[j];
> +                               unsynced_pipes[j] = NULL;
> +                               group_size++;
> +                       } else
> +                       if (sync_type != VBLANK_SYNCHRONIZABLE &&
> +                               resource_are_streams_timing_synchronizable(
>                                         unsynced_pipes[j]->stream,
>                                         pipe_set[0]->stream)) {
> +                               sync_type = TIMING_SYNCHRONIZABLE;
>                                 pipe_set[group_size] = unsynced_pipes[j];
>                                 unsynced_pipes[j] = NULL;
>                                 group_size++;
> @@ -1145,7 +1158,6 @@ static void program_timing_sync(
>                         }
>                 }
>
> -
>                 for (k = 0; k < group_size; k++) {
>                         struct dc_stream_status *status =
> dc_stream_get_status_from_state(ctx, pipe_set[k]->stream);
>
> @@ -1175,8 +1187,14 @@ static void program_timing_sync(
>                 }
>
>                 if (group_size > 1) {
> -                       dc->hwss.enable_timing_synchronization(
> -                               dc, group_index, group_size, pipe_set);
> +                       if (sync_type == TIMING_SYNCHRONIZABLE) {
> +                               dc->hwss.enable_timing_synchronization(
> +                                       dc, group_index, group_size,
> pipe_set);
> +                       } else
> +                               if (sync_type == VBLANK_SYNCHRONIZABLE) {
> +                               dc->hwss.enable_vblanks_synchronization(
> +                                       dc, group_index, group_size,
> pipe_set);
> +                               }
>                         group_index++;
>                 }
>                 num_group++;
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index 0c26c2ade782..0241c9d96d7a 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -417,6 +417,49 @@ int resource_get_clock_source_reference(
>         return -1;
>  }
>
> +bool resource_are_vblanks_synchronizable(
> +       struct dc_stream_state *stream1,
> +       struct dc_stream_state *stream2)
> +{
> +       uint32_t base60_refresh_rates[] = {10, 20, 5};
> +       uint8_t i;
> +       uint8_t rr_count =
> sizeof(base60_refresh_rates)/sizeof(base60_refresh_rates[0]);
> +       int64_t frame_time_diff;
> +
> +       if (stream1->ctx->dc->config.vblank_alignment_dto_params &&
> +
>  stream1->ctx->dc->config.vblank_alignment_max_frame_time_diff > 0 &&
> +               dc_is_dp_signal(stream1->signal) &&
> +               dc_is_dp_signal(stream2->signal) &&
> +               false == stream1->has_non_synchronizable_pclk &&
> +               false == stream2->has_non_synchronizable_pclk &&
> +               stream1->timing.flags.VBLANK_SYNCHRONIZABLE &&
> +               stream2->timing.flags.VBLANK_SYNCHRONIZABLE) {
> +               /* disable refresh rates higher than 60Hz for now */
> +               if
> (stream1->timing.pix_clk_100hz*100/stream1->timing.h_total/
> +                               stream1->timing.v_total > 60)
> +                       return false;
> +               if
> (stream2->timing.pix_clk_100hz*100/stream2->timing.h_total/
> +                               stream2->timing.v_total > 60)
> +                       return false;
> +               frame_time_diff = (int64_t)10000 *
> +                       stream1->timing.h_total *
> +                       stream1->timing.v_total *
> +                       stream2->timing.pix_clk_100hz /
> +                       stream1->timing.pix_clk_100hz /
> +                       stream2->timing.h_total /
> +                       stream2->timing.v_total;
> +               for (i = 0; i < rr_count; i++) {
> +                       int64_t diff = (frame_time_diff *
> base60_refresh_rates[i]) / 10 - 10000;
> +
> +                       if (diff < 0)
> +                               diff = -diff;
> +                       if (diff <
> stream1->ctx->dc->config.vblank_alignment_max_frame_time_diff)
> +                               return true;
> +               }
> +       }
> +       return false;
> +}
> +
>  bool resource_are_streams_timing_synchronizable(
>         struct dc_stream_state *stream1,
>         struct dc_stream_state *stream2)
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h
> b/drivers/gpu/drm/amd/display/dc/dc.h
> index a10daf6655f9..9e631980fa1b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -301,6 +301,8 @@ struct dc_config {
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>         bool clamp_min_dcfclk;
>  #endif
> +       uint64_t vblank_alignment_dto_params;
> +       uint8_t  vblank_alignment_max_frame_time_diff;
>  };
>
>  enum visual_confirm {
> @@ -528,6 +530,7 @@ struct dc_debug_options {
>         bool disable_dsc;
>         bool enable_dram_clock_change_one_display_vactive;
>         union mem_low_power_enable_options enable_mem_low_power;
> +       bool force_vblank_alignment;
>  };
>
>  struct dc_debug_data {
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
> b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
> index b41e6367b15e..48d3ed97ead9 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
> @@ -705,6 +705,7 @@ struct dc_crtc_timing_flags {
>  #ifndef TRIM_FSFT
>         uint32_t FAST_TRANSPORT: 1;
>  #endif
> +       uint32_t VBLANK_SYNCHRONIZABLE: 1;
>  };
>
>  enum dc_timing_3d_format {
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h
> b/drivers/gpu/drm/amd/display/dc/dc_stream.h
> index e243c01b9672..7fa998f97e7a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
> @@ -228,6 +228,9 @@ struct dc_stream_state {
>         uint32_t stream_id;
>         bool is_dsc_enabled;
>         union stream_update_flags update_flags;
> +
> +       bool has_non_synchronizable_pclk;
> +       bool vblank_synchronized;
>  };
>
>  #define ABM_LEVEL_IMMEDIATE_DISABLE 255
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> index dec58b3c42e4..6f47f9bab5ee 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> @@ -1002,15 +1002,27 @@ static bool get_pixel_clk_frequency_100hz(
>  {
>         struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(clock_source);
>         unsigned int clock_hz = 0;
> +       unsigned int modulo_hz = 0;
>
>         if (clock_source->id == CLOCK_SOURCE_ID_DP_DTO) {
>                 clock_hz = REG_READ(PHASE[inst]);
>
> -               /* NOTE: There is agreement with VBIOS here that MODULO is
> -                * programmed equal to DPREFCLK, in which case PHASE will
> be
> -                * equivalent to pixel clock.
> -                */
> -               *pixel_clk_khz = clock_hz / 100;
> +               if
> (clock_source->ctx->dc->hwss.enable_vblanks_synchronization &&
> +
>  clock_source->ctx->dc->config.vblank_alignment_max_frame_time_diff > 0) {
> +                       /* NOTE: In case VBLANK syncronization is enabled,
> MODULO may
> +                        * not be programmed equal to DPREFCLK
> +                        */
> +                       modulo_hz = REG_READ(MODULO[inst]);
> +                       *pixel_clk_khz = ((uint64_t)clock_hz*
> +
>  clock_source->ctx->dc->clk_mgr->dprefclk_khz*10)/
> +                               modulo_hz;
> +               } else {
> +                       /* NOTE: There is agreement with VBIOS here that
> MODULO is
> +                        * programmed equal to DPREFCLK, in which case
> PHASE will be
> +                        * equivalent to pixel clock.
> +                        */
> +                       *pixel_clk_khz = clock_hz / 100;
> +               }
>                 return true;
>         }
>
> @@ -1074,8 +1086,35 @@ static bool dcn20_program_pix_clk(
>                 struct pixel_clk_params *pix_clk_params,
>                 struct pll_settings *pll_settings)
>  {
> +       struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(clock_source);
> +       unsigned int inst = pix_clk_params->controller_id -
> CONTROLLER_ID_D0;
> +
>         dce112_program_pix_clk(clock_source, pix_clk_params, pll_settings);
>
> +       if (clock_source->ctx->dc->hwss.enable_vblanks_synchronization &&
> +
>  clock_source->ctx->dc->config.vblank_alignment_max_frame_time_diff > 0) {
> +               /* NOTE: In case VBLANK syncronization is enabled,
> +                * we need to set modulo to default DPREFCLK first
> +                * dce112_program_pix_clk does not set default DPREFCLK
> +                */
> +               REG_WRITE(MODULO[inst],
> +                       clock_source->ctx->dc->clk_mgr->dprefclk_khz*1000);
> +       }
> +       return true;
> +}
> +
> +static bool dcn20_override_dp_pix_clk(
> +               struct clock_source *clock_source,
> +               unsigned int inst,
> +               unsigned int pixel_clk,
> +               unsigned int ref_clk)
> +{
> +       struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(clock_source);
> +
> +       REG_UPDATE(PIXEL_RATE_CNTL[inst], DP_DTO0_ENABLE, 0);
> +       REG_WRITE(PHASE[inst], pixel_clk);
> +       REG_WRITE(MODULO[inst], ref_clk);
> +       REG_UPDATE(PIXEL_RATE_CNTL[inst], DP_DTO0_ENABLE, 1);
>         return true;
>  }
>
> @@ -1083,7 +1122,8 @@ static const struct clock_source_funcs
> dcn20_clk_src_funcs = {
>         .cs_power_down = dce110_clock_source_power_down,
>         .program_pix_clk = dcn20_program_pix_clk,
>         .get_pix_clk_dividers = dce112_get_pix_clk_dividers,
> -       .get_pixel_clk_frequency_100hz = get_pixel_clk_frequency_100hz
> +       .get_pixel_clk_frequency_100hz = get_pixel_clk_frequency_100hz,
> +       .override_dp_pix_clk = dcn20_override_dp_pix_clk
>  };
>
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index 89912bb5014f..669cee48b0b5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -1851,6 +1851,225 @@ static bool wait_for_reset_trigger_to_occur(
>         return rc;
>  }
>
> +uint64_t reduceSizeAndFraction(
> +       uint64_t *numerator,
> +       uint64_t *denominator,
> +       bool checkUint32Bounary)
> +{
> +       int i;
> +       bool ret = checkUint32Bounary == false;
> +       uint64_t max_int32 = 0xffffffff;
> +       uint64_t num, denom;
> +       uint16_t prime_numbers[] = {
> +               2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43,
> +               47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103,
> +               107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163,
> +               167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227,
> +               229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281,
> +               283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353,
> +               359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421,
> +               431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487,
> +               491, 499, 503, 509, 521, 523, 541, 547, 557, 563, 569,
> +               571, 577, 587, 593, 599, 601, 607, 613, 617, 619, 631,
> +               641, 643, 647, 653, 659, 661, 673, 677, 683, 691, 701,
> +               709, 719, 727, 733, 739, 743, 751, 757, 761, 769, 773,
> +               787, 797, 809, 811, 821, 823, 827, 829, 839, 853, 857,
> +               859, 863, 877, 881, 883, 887, 907, 911, 919, 929, 937,
> +               941, 947, 953, 967, 971, 977, 983, 991, 997};
> +       int count = ARRAY_SIZE(prime_numbers)/sizeof(prime_numbers[0]);
>

ARRAY_SIZE gives the number of elements, so this will limit iteration to
the first half of the prime_numbers array. Btw, the array can be "static
const".

BR
Nils

--0000000000005f597905bbd2b113
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9ImF1dG8iPjxkaXY+SGkgQmluZHUsIGFuIGlubGluZSBjb21tZW50IGJlbG93Ljxi
cj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFp
bF9hdHRyIj5EZW4gZnJlIDE5IGZlYi4gMjAyMSAyMzoxNkJpbmR1IFJhbWFtdXJ0aHkgJmx0Ozxh
IGhyZWY9Im1haWx0bzpiaW5kdS5yQGFtZC5jb20iPmJpbmR1LnJAYW1kLmNvbTwvYT4mZ3Q7IHNr
cmV2Ojxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4
Ij5Gcm9tOiBWbGFkaW1pciBTdGVtcGVuICZsdDs8YSBocmVmPSJtYWlsdG86dmxhZGltaXIuc3Rl
bXBlbkBhbWQuY29tIiB0YXJnZXQ9Il9ibGFuayIgcmVsPSJub3JlZmVycmVyIj52bGFkaW1pci5z
dGVtcGVuQGFtZC5jb208L2E+Jmd0Ozxicj4NCjxicj4NClt3aHldPGJyPg0KwqBWZW5kb3IgYmFz
ZWQgZmFuIG5vaXNlIGltcHJvdmVtZW50PGJyPg0KPGJyPg0KW2hvd108YnI+DQpSZXBvcnQgdGlt
aW5nIHN5bmNocm9uaXphYmxlIHdoZW4gRFAgc3RyZWFtcyB0aW1lIGZyYW1lPGJyPg0KZGlmZmVy
ZW5jZSBpcyBsZXNzIHRoYW4gMC4wNSBwZXJjZW50LiBBZGp1c3QgRFDCoCBEVE9zIGFuZDxicj4N
CnN5bmMgZGlzcGxheXMgdXNpbmfCoCBNQVNURVJfVVBEQVRFX0xPQ0tfREJfWF9ZPGJyPg0KPGJy
Pg0KU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU3RlbXBlbiAmbHQ7PGEgaHJlZj0ibWFpbHRvOnZs
YWRpbWlyLnN0ZW1wZW5AYW1kLmNvbSIgdGFyZ2V0PSJfYmxhbmsiIHJlbD0ibm9yZWZlcnJlciI+
dmxhZGltaXIuc3RlbXBlbkBhbWQuY29tPC9hPiZndDs8YnI+DQpBY2tlZC1ieTogQmluZHUgUmFt
YW11cnRoeSAmbHQ7PGEgaHJlZj0ibWFpbHRvOmJpbmR1LnJAYW1kLmNvbSIgdGFyZ2V0PSJfYmxh
bmsiIHJlbD0ibm9yZWZlcnJlciI+YmluZHUuckBhbWQuY29tPC9hPiZndDs8YnI+DQotLS08YnI+
DQrCoGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmPCoCDCoCDCoCB8wqAg
MjggKystPGJyPg0KwqAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX3Jlc291cmNl
LmMgfMKgIDQzICsrKys8YnI+DQrCoGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kYy5o
wqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAzICs8YnI+DQrCoGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kY19od190eXBlcy5owqAgfMKgIMKgMSArPGJyPg0KwqBkcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZGNfc3RyZWFtLmjCoCDCoCB8wqAgwqAzICs8YnI+DQrCoC4uLi9kcm0v
YW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9jbG9ja19zb3VyY2UuYyB8wqAgNTIgKysrLTxicj4NCsKg
Li4uL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX2h3X3NlcXVlbmNlci5jIHwgMjI1ICsrKysr
KysrKysrKysrKysrKzxicj4NCsKgLi4uL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX2h3X3Nl
cXVlbmNlci5oIHzCoCDCoDUgKzxicj4NCsKgLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNu
MTAvZGNuMTBfb3B0Yy5oIHzCoCDCoDIgKzxicj4NCsKgLi4uL2Rpc3BsYXkvZGMvZGNuMTAvZGNu
MTBfc3RyZWFtX2VuY29kZXIuY8KgIMKgfMKgIMKgMSAtPGJyPg0KwqAuLi4vZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY24yMC9kY24yMF9pbml0LmMgfMKgIMKgMSArPGJyPg0KwqAuLi4vZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9vcHRjLmMgfCAxMjMgKysrKysrKysrKzxicj4N
CsKgLi4uL2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jIHzCoCDCoDgg
Ky08YnI+DQrCoC4uLi9kYy9kY24zMC9kY24zMF9kaW9fc3RyZWFtX2VuY29kZXIuY8KgIMKgIMKg
IMKgfMKgIMKgMSAtPGJyPg0KwqAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9pbmMvY2xvY2tf
c291cmNlLmggfMKgIMKgNSArPGJyPg0KwqAuLi4vYW1kL2Rpc3BsYXkvZGMvaW5jL2h3L3RpbWlu
Z19nZW5lcmF0b3IuaMKgIHzCoCAxMiArPGJyPg0KwqAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9pbmMvaHdfc2VxdWVuY2VyLmggfMKgIMKgMyArPGJyPg0KwqBkcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvaW5jL3Jlc291cmNlLmggfMKgIMKgNCArPGJyPg0KwqAxOCBmaWxlcyBjaGFu
Z2VkLCA1MDUgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pPGJyPg0KPGJyPg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jPGJyPg0KaW5kZXggMmY1NmZhMmMwYmY0
Li4zOWRmNWQyYzAxMDggMTAwNjQ0PGJyPg0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2NvcmUvZGMuYzxicj4NCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9jb3JlL2RjLmM8YnI+DQpAQCAtMTEwMiw2ICsxMTAyLDcgQEAgc3RhdGljIHZvaWQgcHJvZ3Jh
bV90aW1pbmdfc3luYyg8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBmb3IgKGkgPSAwOyBpICZsdDsg
cGlwZV9jb3VudDsgaSsrKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaW50IGdyb3Vw
X3NpemUgPSAxOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVudW0gdGltaW5nX3N5bmNo
cm9uaXphdGlvbl90eXBlIHN5bmNfdHlwZSA9IE5PVF9TWU5DSFJPTklaQUJMRTs8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBzdHJ1Y3QgcGlwZV9jdHggKnBpcGVfc2V0W01BWF9QSVBFU107
PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKCF1bnN5bmNlZF9waXBlc1tp
XSk8YnI+DQpAQCAtMTExNiwxMCArMTExNywyMiBAQCBzdGF0aWMgdm9pZCBwcm9ncmFtX3RpbWlu
Z19zeW5jKDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZvciAoaiA9IGkgKyAxOyBqICZs
dDsgcGlwZV9jb3VudDsgaisrKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgaWYgKCF1bnN5bmNlZF9waXBlc1tqXSk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjb250aW51ZTs8YnI+DQotPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJlc291cmNlX2FyZV9zdHJlYW1zX3RpbWlu
Z19zeW5jaHJvbml6YWJsZSg8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpZiAoc3luY190eXBlICE9IFRJTUlOR19TWU5DSFJPTklaQUJMRSAmYW1wOyZhbXA7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGMtJmd0O2h3
c3MuZW5hYmxlX3ZibGFua3Nfc3luY2hyb25pemF0aW9uICZhbXA7JmFtcDs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1bnN5bmNlZF9waXBlc1tq
XS0mZ3Q7c3RyZWFtX3Jlcy50Zy0mZ3Q7ZnVuY3MtJmd0O2FsaWduX3ZibGFua3MgJmFtcDsmYW1w
Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJl
c291cmNlX2FyZV92YmxhbmtzX3N5bmNocm9uaXphYmxlKDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHVuc3luY2VkX3BpcGVz
W2pdLSZndDtzdHJlYW0sPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcGlwZV9zZXRbMF0tJmd0O3N0cmVhbSkpIHs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzeW5jX3R5cGUg
PSBWQkxBTktfU1lOQ0hST05JWkFCTEU7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgcGlwZV9zZXRbZ3JvdXBfc2l6ZV0gPSB1bnN5bmNlZF9waXBl
c1tqXTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqB1bnN5bmNlZF9waXBlc1tqXSA9IE5VTEw7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ3JvdXBfc2l6ZSsrOzxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0gZWxzZTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGlmIChzeW5jX3R5cGUgIT0gVkJMQU5LX1NZTkNIUk9OSVpBQkxFICZhbXA7
JmFtcDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqByZXNvdXJjZV9hcmVfc3RyZWFtc190aW1pbmdfc3luY2hyb25pemFibGUoPGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdW5z
eW5jZWRfcGlwZXNbal0tJmd0O3N0cmVhbSw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwaXBlX3NldFswXS0mZ3Q7c3RyZWFt
KSkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHN5bmNfdHlwZSA9IFRJTUlOR19TWU5DSFJPTklaQUJMRTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwaXBlX3NldFtncm91cF9zaXplXSA9IHVu
c3luY2VkX3BpcGVzW2pdOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHVuc3luY2VkX3BpcGVzW2pdID0gTlVMTDs8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBncm91cF9zaXplKys7PGJyPg0KQEAg
LTExNDUsNyArMTE1OCw2IEBAIHN0YXRpYyB2b2lkIHByb2dyYW1fdGltaW5nX3N5bmMoPGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIH08YnI+DQo8YnI+DQotPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZm9y
IChrID0gMDsgayAmbHQ7IGdyb3VwX3NpemU7IGsrKykgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHN0cnVjdCBkY19zdHJlYW1fc3RhdHVzICpzdGF0dXMgPSBkY19z
dHJlYW1fZ2V0X3N0YXR1c19mcm9tX3N0YXRlKGN0eCwgcGlwZV9zZXRba10tJmd0O3N0cmVhbSk7
PGJyPg0KPGJyPg0KQEAgLTExNzUsOCArMTE4NywxNCBAQCBzdGF0aWMgdm9pZCBwcm9ncmFtX3Rp
bWluZ19zeW5jKDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+DQo8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoZ3JvdXBfc2l6ZSAmZ3Q7IDEpIHs8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkYy0mZ3Q7aHdzcy5lbmFibGVfdGltaW5nX3N5
bmNocm9uaXphdGlvbig8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBkYywgZ3JvdXBfaW5kZXgsIGdyb3VwX3NpemUsIHBpcGVfc2V0KTs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoc3luY190eXBlID09IFRJTUlO
R19TWU5DSFJPTklaQUJMRSkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGRjLSZndDtod3NzLmVuYWJsZV90aW1pbmdfc3luY2hyb25pemF0aW9u
KDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGRjLCBncm91cF9pbmRleCwgZ3JvdXBfc2l6ZSwgcGlwZV9zZXQpOzxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0gZWxzZTxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChzeW5jX3R5cGUgPT0gVkJM
QU5LX1NZTkNIUk9OSVpBQkxFKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgZGMtJmd0O2h3c3MuZW5hYmxlX3ZibGFua3Nfc3luY2hyb25pemF0
aW9uKDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGRjLCBncm91cF9pbmRleCwgZ3JvdXBfc2l6ZSwgcGlwZV9zZXQpOzxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBncm91cF9pbmRleCsrOzxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBudW1f
Z3JvdXArKzs8YnI+DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2NvcmUvZGNfcmVzb3VyY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3Jl
L2RjX3Jlc291cmNlLmM8YnI+DQppbmRleCAwYzI2YzJhZGU3ODIuLjAyNDFjOWQ5NmQ3YSAxMDA2
NDQ8YnI+DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19yZXNv
dXJjZS5jPGJyPg0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNf
cmVzb3VyY2UuYzxicj4NCkBAIC00MTcsNiArNDE3LDQ5IEBAIGludCByZXNvdXJjZV9nZXRfY2xv
Y2tfc291cmNlX3JlZmVyZW5jZSg8YnI+DQrCoCDCoCDCoCDCoCByZXR1cm4gLTE7PGJyPg0KwqB9
PGJyPg0KPGJyPg0KK2Jvb2wgcmVzb3VyY2VfYXJlX3ZibGFua3Nfc3luY2hyb25pemFibGUoPGJy
Pg0KK8KgIMKgIMKgIMKgc3RydWN0IGRjX3N0cmVhbV9zdGF0ZSAqc3RyZWFtMSw8YnI+DQorwqAg
wqAgwqAgwqBzdHJ1Y3QgZGNfc3RyZWFtX3N0YXRlICpzdHJlYW0yKTxicj4NCit7PGJyPg0KK8Kg
IMKgIMKgIMKgdWludDMyX3QgYmFzZTYwX3JlZnJlc2hfcmF0ZXNbXSA9IHsxMCwgMjAsIDV9Ozxi
cj4NCivCoCDCoCDCoCDCoHVpbnQ4X3QgaTs8YnI+DQorwqAgwqAgwqAgwqB1aW50OF90IHJyX2Nv
dW50ID0gc2l6ZW9mKGJhc2U2MF9yZWZyZXNoX3JhdGVzKS9zaXplb2YoYmFzZTYwX3JlZnJlc2hf
cmF0ZXNbMF0pOzxicj4NCivCoCDCoCDCoCDCoGludDY0X3QgZnJhbWVfdGltZV9kaWZmOzxicj4N
Cis8YnI+DQorwqAgwqAgwqAgwqBpZiAoc3RyZWFtMS0mZ3Q7Y3R4LSZndDtkYy0mZ3Q7Y29uZmln
LnZibGFua19hbGlnbm1lbnRfZHRvX3BhcmFtcyAmYW1wOyZhbXA7PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgc3RyZWFtMS0mZ3Q7Y3R4LSZndDtkYy0mZ3Q7Y29uZmlnLnZibGFua19hbGln
bm1lbnRfbWF4X2ZyYW1lX3RpbWVfZGlmZiAmZ3Q7IDAgJmFtcDsmYW1wOzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGRjX2lzX2RwX3NpZ25hbChzdHJlYW0xLSZndDtzaWduYWwpICZhbXA7
JmFtcDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkY19pc19kcF9zaWduYWwoc3RyZWFt
Mi0mZ3Q7c2lnbmFsKSAmYW1wOyZhbXA7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZmFs
c2UgPT0gc3RyZWFtMS0mZ3Q7aGFzX25vbl9zeW5jaHJvbml6YWJsZV9wY2xrICZhbXA7JmFtcDs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmYWxzZSA9PSBzdHJlYW0yLSZndDtoYXNfbm9u
X3N5bmNocm9uaXphYmxlX3BjbGsgJmFtcDsmYW1wOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHN0cmVhbTEtJmd0O3RpbWluZy5mbGFncy5WQkxBTktfU1lOQ0hST05JWkFCTEUgJmFtcDsm
YW1wOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cmVhbTItJmd0O3RpbWluZy5mbGFn
cy5WQkxBTktfU1lOQ0hST05JWkFCTEUpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAv
KiBkaXNhYmxlIHJlZnJlc2ggcmF0ZXMgaGlnaGVyIHRoYW4gNjBIeiBmb3Igbm93ICovPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHN0cmVhbTEtJmd0O3RpbWluZy5waXhfY2xrXzEw
MGh6KjEwMC9zdHJlYW0xLSZndDt0aW1pbmcuaF90b3RhbC88YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJlYW0xLSZndDt0aW1pbmcudl90b3Rh
bCAmZ3Q7IDYwKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVy
biBmYWxzZTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoc3RyZWFtMi0mZ3Q7dGlt
aW5nLnBpeF9jbGtfMTAwaHoqMTAwL3N0cmVhbTItJmd0O3RpbWluZy5oX3RvdGFsLzxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cmVhbTItJmd0
O3RpbWluZy52X3RvdGFsICZndDsgNjApPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcmV0dXJuIGZhbHNlOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZyYW1l
X3RpbWVfZGlmZiA9IChpbnQ2NF90KTEwMDAwICo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBzdHJlYW0xLSZndDt0aW1pbmcuaF90b3RhbCAqPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RyZWFtMS0mZ3Q7dGltaW5nLnZfdG90YWwgKjxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cmVhbTItJmd0O3RpbWlu
Zy5waXhfY2xrXzEwMGh6IC88YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBzdHJlYW0xLSZndDt0aW1pbmcucGl4X2Nsa18xMDBoeiAvPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RyZWFtMi0mZ3Q7dGltaW5nLmhfdG90YWwgLzxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cmVhbTItJmd0O3RpbWluZy52X3Rv
dGFsOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZvciAoaSA9IDA7IGkgJmx0OyBycl9j
b3VudDsgaSsrKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaW50
NjRfdCBkaWZmID0gKGZyYW1lX3RpbWVfZGlmZiAqIGJhc2U2MF9yZWZyZXNoX3JhdGVzW2ldKSAv
IDEwIC0gMTAwMDA7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlmIChkaWZmICZsdDsgMCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBkaWZmID0gLWRpZmY7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgaWYgKGRpZmYgJmx0OyBzdHJlYW0xLSZndDtjdHgtJmd0O2RjLSZndDtj
b25maWcudmJsYW5rX2FsaWdubWVudF9tYXhfZnJhbWVfdGltZV9kaWZmKTxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiB0cnVlOzxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKg
IMKgIMKgcmV0dXJuIGZhbHNlOzxicj4NCit9PGJyPg0KKzxicj4NCsKgYm9vbCByZXNvdXJjZV9h
cmVfc3RyZWFtc190aW1pbmdfc3luY2hyb25pemFibGUoPGJyPg0KwqAgwqAgwqAgwqAgc3RydWN0
IGRjX3N0cmVhbV9zdGF0ZSAqc3RyZWFtMSw8YnI+DQrCoCDCoCDCoCDCoCBzdHJ1Y3QgZGNfc3Ry
ZWFtX3N0YXRlICpzdHJlYW0yKTxicj4NCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGMuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kYy5oPGJy
Pg0KaW5kZXggYTEwZGFmNjY1NWY5Li45ZTYzMTk4MGZhMWIgMTAwNjQ0PGJyPg0KLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmg8YnI+DQorKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZGMuaDxicj4NCkBAIC0zMDEsNiArMzAxLDggQEAgc3RydWN0IGRj
X2NvbmZpZyB7PGJyPg0KwqAjaWYgZGVmaW5lZChDT05GSUdfRFJNX0FNRF9EQ19EQ04pPGJyPg0K
wqAgwqAgwqAgwqAgYm9vbCBjbGFtcF9taW5fZGNmY2xrOzxicj4NCsKgI2VuZGlmPGJyPg0KK8Kg
IMKgIMKgIMKgdWludDY0X3QgdmJsYW5rX2FsaWdubWVudF9kdG9fcGFyYW1zOzxicj4NCivCoCDC
oCDCoCDCoHVpbnQ4X3TCoCB2YmxhbmtfYWxpZ25tZW50X21heF9mcmFtZV90aW1lX2RpZmY7PGJy
Pg0KwqB9Ozxicj4NCjxicj4NCsKgZW51bSB2aXN1YWxfY29uZmlybSB7PGJyPg0KQEAgLTUyOCw2
ICs1MzAsNyBAQCBzdHJ1Y3QgZGNfZGVidWdfb3B0aW9ucyB7PGJyPg0KwqAgwqAgwqAgwqAgYm9v
bCBkaXNhYmxlX2RzYzs8YnI+DQrCoCDCoCDCoCDCoCBib29sIGVuYWJsZV9kcmFtX2Nsb2NrX2No
YW5nZV9vbmVfZGlzcGxheV92YWN0aXZlOzxicj4NCsKgIMKgIMKgIMKgIHVuaW9uIG1lbV9sb3df
cG93ZXJfZW5hYmxlX29wdGlvbnMgZW5hYmxlX21lbV9sb3dfcG93ZXI7PGJyPg0KK8KgIMKgIMKg
IMKgYm9vbCBmb3JjZV92YmxhbmtfYWxpZ25tZW50Ozxicj4NCsKgfTs8YnI+DQo8YnI+DQrCoHN0
cnVjdCBkY19kZWJ1Z19kYXRhIHs8YnI+DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2RjX2h3X3R5cGVzLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvZGNfaHdfdHlwZXMuaDxicj4NCmluZGV4IGI0MWU2MzY3YjE1ZS4uNDhkM2VkOTdlYWQ5IDEw
MDY0NDxicj4NCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY19od190eXBl
cy5oPGJyPg0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX2h3X3R5cGVz
Lmg8YnI+DQpAQCAtNzA1LDYgKzcwNSw3IEBAIHN0cnVjdCBkY19jcnRjX3RpbWluZ19mbGFncyB7
PGJyPg0KwqAjaWZuZGVmIFRSSU1fRlNGVDxicj4NCsKgIMKgIMKgIMKgIHVpbnQzMl90IEZBU1Rf
VFJBTlNQT1JUOiAxOzxicj4NCsKgI2VuZGlmPGJyPg0KK8KgIMKgIMKgIMKgdWludDMyX3QgVkJM
QU5LX1NZTkNIUk9OSVpBQkxFOiAxOzxicj4NCsKgfTs8YnI+DQo8YnI+DQrCoGVudW0gZGNfdGlt
aW5nXzNkX2Zvcm1hdCB7PGJyPg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kY19zdHJlYW0uaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY19z
dHJlYW0uaDxicj4NCmluZGV4IGUyNDNjMDFiOTY3Mi4uN2ZhOTk4Zjk3ZTdhIDEwMDY0NDxicj4N
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY19zdHJlYW0uaDxicj4NCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY19zdHJlYW0uaDxicj4NCkBAIC0y
MjgsNiArMjI4LDkgQEAgc3RydWN0IGRjX3N0cmVhbV9zdGF0ZSB7PGJyPg0KwqAgwqAgwqAgwqAg
dWludDMyX3Qgc3RyZWFtX2lkOzxicj4NCsKgIMKgIMKgIMKgIGJvb2wgaXNfZHNjX2VuYWJsZWQ7
PGJyPg0KwqAgwqAgwqAgwqAgdW5pb24gc3RyZWFtX3VwZGF0ZV9mbGFncyB1cGRhdGVfZmxhZ3M7
PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGJvb2wgaGFzX25vbl9zeW5jaHJvbml6YWJsZV9wY2xr
Ozxicj4NCivCoCDCoCDCoCDCoGJvb2wgdmJsYW5rX3N5bmNocm9uaXplZDs8YnI+DQrCoH07PGJy
Pg0KPGJyPg0KwqAjZGVmaW5lIEFCTV9MRVZFTF9JTU1FRElBVEVfRElTQUJMRSAyNTU8YnI+DQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfY2xvY2tf
c291cmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9jbG9ja19z
b3VyY2UuYzxicj4NCmluZGV4IGRlYzU4YjNjNDJlNC4uNmY0N2Y5YmFiNWVlIDEwMDY0NDxicj4N
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2Nsb2NrX3NvdXJj
ZS5jPGJyPg0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfY2xv
Y2tfc291cmNlLmM8YnI+DQpAQCAtMTAwMiwxNSArMTAwMiwyNyBAQCBzdGF0aWMgYm9vbCBnZXRf
cGl4ZWxfY2xrX2ZyZXF1ZW5jeV8xMDBoeig8YnI+DQrCoHs8YnI+DQrCoCDCoCDCoCDCoCBzdHJ1
Y3QgZGNlMTEwX2Nsa19zcmMgKmNsa19zcmMgPSBUT19EQ0UxMTBfQ0xLX1NSQyhjbG9ja19zb3Vy
Y2UpOzxicj4NCsKgIMKgIMKgIMKgIHVuc2lnbmVkIGludCBjbG9ja19oeiA9IDA7PGJyPg0KK8Kg
IMKgIMKgIMKgdW5zaWduZWQgaW50IG1vZHVsb19oeiA9IDA7PGJyPg0KPGJyPg0KwqAgwqAgwqAg
wqAgaWYgKGNsb2NrX3NvdXJjZS0mZ3Q7aWQgPT0gQ0xPQ0tfU09VUkNFX0lEX0RQX0RUTykgezxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNsb2NrX2h6ID0gUkVHX1JFQUQoUEhBU0VbaW5z
dF0pOzxicj4NCjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIE5PVEU6IFRoZXJlIGlz
IGFncmVlbWVudCB3aXRoIFZCSU9TIGhlcmUgdGhhdCBNT0RVTE8gaXM8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgKiBwcm9ncmFtbWVkIGVxdWFsIHRvIERQUkVGQ0xLLCBpbiB3aGljaCBj
YXNlIFBIQVNFIHdpbGwgYmU8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiBlcXVpdmFs
ZW50IHRvIHBpeGVsIGNsb2NrLjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqLzxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCpwaXhlbF9jbGtfa2h6ID0gY2xvY2tfaHogLyAxMDA7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGNsb2NrX3NvdXJjZS0mZ3Q7Y3R4LSZn
dDtkYy0mZ3Q7aHdzcy5lbmFibGVfdmJsYW5rc19zeW5jaHJvbml6YXRpb24gJmFtcDsmYW1wOzxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNsb2NrX3NvdXJjZS0mZ3Q7
Y3R4LSZndDtkYy0mZ3Q7Y29uZmlnLnZibGFua19hbGlnbm1lbnRfbWF4X2ZyYW1lX3RpbWVfZGlm
ZiAmZ3Q7IDApIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBO
T1RFOiBJbiBjYXNlIFZCTEFOSyBzeW5jcm9uaXphdGlvbiBpcyBlbmFibGVkLCBNT0RVTE8gbWF5
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICogbm90IGJlIHByb2dy
YW1tZWQgZXF1YWwgdG8gRFBSRUZDTEs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgKi88YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtb2R1
bG9faHogPSBSRUdfUkVBRChNT0RVTE9baW5zdF0pOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCpwaXhlbF9jbGtfa2h6ID0gKCh1aW50NjRfdCljbG9ja19oeio8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjbG9ja19z
b3VyY2UtJmd0O2N0eC0mZ3Q7ZGMtJmd0O2Nsa19tZ3ItJmd0O2RwcmVmY2xrX2toeioxMCkvPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbW9kdWxv
X2h6Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0gZWxzZSB7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogTk9URTogVGhlcmUgaXMgYWdyZWVtZW50IHdp
dGggVkJJT1MgaGVyZSB0aGF0IE1PRFVMTyBpczxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCAqIHByb2dyYW1tZWQgZXF1YWwgdG8gRFBSRUZDTEssIGluIHdoaWNoIGNh
c2UgUEhBU0Ugd2lsbCBiZTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCAqIGVxdWl2YWxlbnQgdG8gcGl4ZWwgY2xvY2suPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgICovPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgKnBpeGVsX2Nsa19raHogPSBjbG9ja19oeiAvIDEwMDs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqB9PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIHRydWU7PGJyPg0K
wqAgwqAgwqAgwqAgfTxicj4NCjxicj4NCkBAIC0xMDc0LDggKzEwODYsMzUgQEAgc3RhdGljIGJv
b2wgZGNuMjBfcHJvZ3JhbV9waXhfY2xrKDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0
cnVjdCBwaXhlbF9jbGtfcGFyYW1zICpwaXhfY2xrX3BhcmFtcyw8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBzdHJ1Y3QgcGxsX3NldHRpbmdzICpwbGxfc2V0dGluZ3MpPGJyPg0KwqB7PGJy
Pg0KK8KgIMKgIMKgIMKgc3RydWN0IGRjZTExMF9jbGtfc3JjICpjbGtfc3JjID0gVE9fRENFMTEw
X0NMS19TUkMoY2xvY2tfc291cmNlKTs8YnI+DQorwqAgwqAgwqAgwqB1bnNpZ25lZCBpbnQgaW5z
dCA9IHBpeF9jbGtfcGFyYW1zLSZndDtjb250cm9sbGVyX2lkIC0gQ09OVFJPTExFUl9JRF9EMDs8
YnI+DQorPGJyPg0KwqAgwqAgwqAgwqAgZGNlMTEyX3Byb2dyYW1fcGl4X2NsayhjbG9ja19zb3Vy
Y2UsIHBpeF9jbGtfcGFyYW1zLCBwbGxfc2V0dGluZ3MpOzxicj4NCjxicj4NCivCoCDCoCDCoCDC
oGlmIChjbG9ja19zb3VyY2UtJmd0O2N0eC0mZ3Q7ZGMtJmd0O2h3c3MuZW5hYmxlX3ZibGFua3Nf
c3luY2hyb25pemF0aW9uICZhbXA7JmFtcDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBjbG9ja19zb3VyY2UtJmd0O2N0eC0mZ3Q7ZGMtJmd0O2NvbmZpZy52Ymxhbmtf
YWxpZ25tZW50X21heF9mcmFtZV90aW1lX2RpZmYgJmd0OyAwKSB7PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgLyogTk9URTogSW4gY2FzZSBWQkxBTksgc3luY3Jvbml6YXRpb24gaXMgZW5h
YmxlZCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKiB3ZSBuZWVkIHRvIHNldCBtb2R1
bG8gdG8gZGVmYXVsdCBEUFJFRkNMSyBmaXJzdDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCAqIGRjZTExMl9wcm9ncmFtX3BpeF9jbGsgZG9lcyBub3Qgc2V0IGRlZmF1bHQgRFBSRUZDTEs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKi88YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBSRUdfV1JJVEUoTU9EVUxPW2luc3RdLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGNsb2NrX3NvdXJjZS0mZ3Q7Y3R4LSZndDtkYy0mZ3Q7Y2xrX21nci0mZ3Q7
ZHByZWZjbGtfa2h6KjEwMDApOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqBy
ZXR1cm4gdHJ1ZTs8YnI+DQorfTxicj4NCis8YnI+DQorc3RhdGljIGJvb2wgZGNuMjBfb3ZlcnJp
ZGVfZHBfcGl4X2Nsayg8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJ1Y3QgY2xvY2tf
c291cmNlICpjbG9ja19zb3VyY2UsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdW5zaWdu
ZWQgaW50IGluc3QsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdW5zaWduZWQgaW50IHBp
eGVsX2Nsayw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1bnNpZ25lZCBpbnQgcmVmX2Ns
ayk8YnI+DQorezxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBkY2UxMTBfY2xrX3NyYyAqY2xrX3Ny
YyA9IFRPX0RDRTExMF9DTEtfU1JDKGNsb2NrX3NvdXJjZSk7PGJyPg0KKzxicj4NCivCoCDCoCDC
oCDCoFJFR19VUERBVEUoUElYRUxfUkFURV9DTlRMW2luc3RdLCBEUF9EVE8wX0VOQUJMRSwgMCk7
PGJyPg0KK8KgIMKgIMKgIMKgUkVHX1dSSVRFKFBIQVNFW2luc3RdLCBwaXhlbF9jbGspOzxicj4N
CivCoCDCoCDCoCDCoFJFR19XUklURShNT0RVTE9baW5zdF0sIHJlZl9jbGspOzxicj4NCivCoCDC
oCDCoCDCoFJFR19VUERBVEUoUElYRUxfUkFURV9DTlRMW2luc3RdLCBEUF9EVE8wX0VOQUJMRSwg
MSk7PGJyPg0KwqAgwqAgwqAgwqAgcmV0dXJuIHRydWU7PGJyPg0KwqB9PGJyPg0KPGJyPg0KQEAg
LTEwODMsNyArMTEyMiw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgY2xvY2tfc291cmNlX2Z1bmNz
IGRjbjIwX2Nsa19zcmNfZnVuY3MgPSB7PGJyPg0KwqAgwqAgwqAgwqAgLmNzX3Bvd2VyX2Rvd24g
PSBkY2UxMTBfY2xvY2tfc291cmNlX3Bvd2VyX2Rvd24sPGJyPg0KwqAgwqAgwqAgwqAgLnByb2dy
YW1fcGl4X2NsayA9IGRjbjIwX3Byb2dyYW1fcGl4X2Nsayw8YnI+DQrCoCDCoCDCoCDCoCAuZ2V0
X3BpeF9jbGtfZGl2aWRlcnMgPSBkY2UxMTJfZ2V0X3BpeF9jbGtfZGl2aWRlcnMsPGJyPg0KLcKg
IMKgIMKgIMKgLmdldF9waXhlbF9jbGtfZnJlcXVlbmN5XzEwMGh6ID0gZ2V0X3BpeGVsX2Nsa19m
cmVxdWVuY3lfMTAwaHo8YnI+DQorwqAgwqAgwqAgwqAuZ2V0X3BpeGVsX2Nsa19mcmVxdWVuY3lf
MTAwaHogPSBnZXRfcGl4ZWxfY2xrX2ZyZXF1ZW5jeV8xMDBoeiw8YnI+DQorwqAgwqAgwqAgwqAu
b3ZlcnJpZGVfZHBfcGl4X2NsayA9IGRjbjIwX292ZXJyaWRlX2RwX3BpeF9jbGs8YnI+DQrCoH07
PGJyPg0KPGJyPg0KwqAjaWYgZGVmaW5lZChDT05GSUdfRFJNX0FNRF9EQ19EQ04pPGJyPg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9od19z
ZXF1ZW5jZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9o
d19zZXF1ZW5jZXIuYzxicj4NCmluZGV4IDg5OTEyYmI1MDE0Zi4uNjY5Y2VlNDhiMGI1IDEwMDY0
NDxicj4NCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9o
d19zZXF1ZW5jZXIuYzxicj4NCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9k
Y24xMC9kY24xMF9od19zZXF1ZW5jZXIuYzxicj4NCkBAIC0xODUxLDYgKzE4NTEsMjI1IEBAIHN0
YXRpYyBib29sIHdhaXRfZm9yX3Jlc2V0X3RyaWdnZXJfdG9fb2NjdXIoPGJyPg0KwqAgwqAgwqAg
wqAgcmV0dXJuIHJjOzxicj4NCsKgfTxicj4NCjxicj4NCit1aW50NjRfdCByZWR1Y2VTaXplQW5k
RnJhY3Rpb24oPGJyPg0KK8KgIMKgIMKgIMKgdWludDY0X3QgKm51bWVyYXRvciw8YnI+DQorwqAg
wqAgwqAgwqB1aW50NjRfdCAqZGVub21pbmF0b3IsPGJyPg0KK8KgIMKgIMKgIMKgYm9vbCBjaGVj
a1VpbnQzMkJvdW5hcnkpPGJyPg0KK3s8YnI+DQorwqAgwqAgwqAgwqBpbnQgaTs8YnI+DQorwqAg
wqAgwqAgwqBib29sIHJldCA9IGNoZWNrVWludDMyQm91bmFyeSA9PSBmYWxzZTs8YnI+DQorwqAg
wqAgwqAgwqB1aW50NjRfdCBtYXhfaW50MzIgPSAweGZmZmZmZmZmOzxicj4NCivCoCDCoCDCoCDC
oHVpbnQ2NF90IG51bSwgZGVub207PGJyPg0KK8KgIMKgIMKgIMKgdWludDE2X3QgcHJpbWVfbnVt
YmVyc1tdID0gezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDIsIDMsIDUsIDcsIDExLCAx
MywgMTcsIDE5LCAyMywgMjksIDMxLCAzNywgNDEsIDQzLDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoDQ3LCA1MywgNTksIDYxLCA2NywgNzEsIDczLCA3OSwgODMsIDg5LCA5NywgMTAxLCAx
MDMsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMTA3LCAxMDksIDExMywgMTI3LCAxMzEs
IDEzNywgMTM5LCAxNDksIDE1MSwgMTU3LCAxNjMsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgMTY3LCAxNzMsIDE3OSwgMTgxLCAxOTEsIDE5MywgMTk3LCAxOTksIDIxMSwgMjIzLCAyMjcs
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMjI5LCAyMzMsIDIzOSwgMjQxLCAyNTEsIDI1
NywgMjYzLCAyNjksIDI3MSwgMjc3LCAyODEsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
MjgzLCAyOTMsIDMwNywgMzExLCAzMTMsIDMxNywgMzMxLCAzMzcsIDM0NywgMzQ5LCAzNTMsPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMzU5LCAzNjcsIDM3MywgMzc5LCAzODMsIDM4OSwg
Mzk3LCA0MDEsIDQwOSwgNDE5LCA0MjEsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgNDMx
LCA0MzMsIDQzOSwgNDQzLCA0NDksIDQ1NywgNDYxLCA0NjMsIDQ2NywgNDc5LCA0ODcsPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgNDkxLCA0OTksIDUwMywgNTA5LCA1MjEsIDUyMywgNTQx
LCA1NDcsIDU1NywgNTYzLCA1NjksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgNTcxLCA1
NzcsIDU4NywgNTkzLCA1OTksIDYwMSwgNjA3LCA2MTMsIDYxNywgNjE5LCA2MzEsPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgNjQxLCA2NDMsIDY0NywgNjUzLCA2NTksIDY2MSwgNjczLCA2
NzcsIDY4MywgNjkxLCA3MDEsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgNzA5LCA3MTks
IDcyNywgNzMzLCA3MzksIDc0MywgNzUxLCA3NTcsIDc2MSwgNzY5LCA3NzMsPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgNzg3LCA3OTcsIDgwOSwgODExLCA4MjEsIDgyMywgODI3LCA4Mjks
IDgzOSwgODUzLCA4NTcsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgODU5LCA4NjMsIDg3
NywgODgxLCA4ODMsIDg4NywgOTA3LCA5MTEsIDkxOSwgOTI5LCA5MzcsPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgOTQxLCA5NDcsIDk1MywgOTY3LCA5NzEsIDk3NywgOTgzLCA5OTEsIDk5
N307PGJyPg0KK8KgIMKgIMKgIMKgaW50IGNvdW50ID0gQVJSQVlfU0laRShwcmltZV9udW1iZXJz
KS9zaXplb2YocHJpbWVfbnVtYmVyc1swXSk7PGJyPjwvYmxvY2txdW90ZT48L2Rpdj48L2Rpdj48
ZGl2IGRpcj0iYXV0byI+PGJyPjwvZGl2PjxkaXYgZGlyPSJhdXRvIj5BUlJBWV9TSVpFIGdpdmVz
IHRoZSBudW1iZXIgb2YgZWxlbWVudHMsIHNvIHRoaXMgd2lsbCBsaW1pdCBpdGVyYXRpb24gdG8g
dGhlIGZpcnN0IGhhbGYgb2YgdGhlIHByaW1lX251bWJlcnMgYXJyYXkuIEJ0dywgdGhlIGFycmF5
IGNhbiBiZSAmcXVvdDtzdGF0aWMgY29uc3QmcXVvdDsuPC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxi
cj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+QlI8L2Rpdj48ZGl2IGRpcj0iYXV0byI+TmlsczwvZGl2
PjwvZGl2Pg0K
--0000000000005f597905bbd2b113--

--===============0384258010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0384258010==--
