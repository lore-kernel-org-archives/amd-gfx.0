Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE64C2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 16:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B566822450
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 16:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uRj4kNi2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B566822450
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BDAA899FF;
	Mon, 26 Oct 2020 16:19:41 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D054899FF
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 16:19:39 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id d78so12266913wmd.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 09:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1hl+EfV6BQgmwWf2e5cmX+LlK6YPL/ZKig2+RyEW5r4=;
 b=uRj4kNi2/AmS2+Wk06NrmsHnOCBUD68L2t8OTnHv8NIK6tposFzHho6p2Irn0fi6CM
 xkOatzsSmIZlCQimPD1iKyUNDWGv/iLfb4HpYMfuyeUK0DvSez+4KS2d/2XJgDl0s+i+
 BVWx/cAwRTjMEX7XCX+uywHPnnGASHPr+Oq8AFIHfZsr8JWk9Iu9lQWKGTrs3XytXrfk
 K0vWh91/eJF3ST95Wr8sr7RosTHGSBt0sReEf/N7ijH3dYa7EHXZ0C76HBceu+GZRPtO
 58V2Mpm9bQPWTgjfkqqbB0Zv5WpzlycrzFteCizetVBzbaGkDiHDcoQ9mb2S2n8v06U8
 qJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1hl+EfV6BQgmwWf2e5cmX+LlK6YPL/ZKig2+RyEW5r4=;
 b=fCH2iUqQW9OeAPnblofb3N8gtcXTbcGlYaC+wkuf9PRzYV3AeNKft9fjoLaBxc6HTk
 tjl93U5IObSM7AQy4dDTvRMfbBwrhjuML0NNy456D2wRCCL076/CE0/QGCH3+Vy4fGx3
 D9rBWL1TgowZTdXLk1P/3kJiivwvoco8Vi7OBmuDSesZHABKSgsa1WKvjqA2UHd+Q7XH
 kLgd3h/vfv/vLumDCnY3Qs6XLSxRHwLQauuQZEOuMSnb2ls8cU7H3cpKaKwzGoXV47z+
 uCXqRhvSek+TSE/sbNsfmRxQ0+i0umMLf+4g/sm5DeIFHLr1kSg+fvFFBmfHwGRjetx0
 VVXw==
X-Gm-Message-State: AOAM531VzJWvFlv/rdmya65s/G67IXRDVleG/1ME0pPP3vRJWdPZvxUS
 VgBLLzKTU9s9Q6hSMqWdku6YCkPn2aMNcEGp0YIgr/zy
X-Google-Smtp-Source: ABdhPJww1jv7Nmx1KFMJZU5oiBYCIe49J4VxRN81T2anZObXbmHC5v9bxZZyYtm0XkPzPn0yNXF5jKq5Ym8CLGyXkeI=
X-Received: by 2002:a1c:e4c1:: with SMTP id b184mr16138523wmh.73.1603729177849; 
 Mon, 26 Oct 2020 09:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201020202617.2465215-1-alexander.deucher@amd.com>
 <20201020202617.2465215-3-alexander.deucher@amd.com>
 <CAP+8YyGRZT_6kYB4Qa46ByhV4Ak_2YfN+j25GsyJJZ+w60rcxw@mail.gmail.com>
In-Reply-To: <CAP+8YyGRZT_6kYB4Qa46ByhV4Ak_2YfN+j25GsyJJZ+w60rcxw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Oct 2020 12:19:26 -0400
Message-ID: <CADnq5_PBqAcBvjiw3JzEHNt0sZLwNYpSv_F6ibfOzPFpuB4XXw@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu/display: add MALL support
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Oct 26, 2020 at 11:51 AM Bas Nieuwenhuizen
<bas@basnieuwenhuizen.nl> wrote:
>
> On Tue, Oct 20, 2020 at 10:26 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> >
> > Enable Memory Access at Last Level (MALL) feature for display.
> >
> > Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  .../drm/amd/display/dc/clk_mgr/dcn30/dalsmc.h |  1 +
> >  .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  | 10 +++
> >  .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c  |  9 +++
> >  .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.h  |  2 +
> >  .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 65 +++++++++++++++++++
> >  .../drm/amd/display/dc/dcn30/dcn30_resource.c |  2 +-
> >  .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 20 ++++++
> >  7 files changed, 108 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dalsmc.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dalsmc.h
> > index 5ed03287aaaf..fa09c594fd36 100644
> > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dalsmc.h
> > +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dalsmc.h
> > @@ -53,6 +53,7 @@
> >  #define DALSMC_MSG_GetDcModeMaxDpmFreq            0xC
> >  #define DALSMC_MSG_SetMinDeepSleepDcefclk         0xD
> >  #define DALSMC_MSG_NumOfDisplays                  0xE
> > +#define DALSMC_MSG_SetDisplayRefreshFromMall      0xF
> >  #define DALSMC_MSG_SetExternalClientDfCstateAllow 0x10
> >  #define DALSMC_MSG_BacoAudioD3PME                 0x11
> >  #define DALSMC_Message_Count                      0x12
> > diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
> > index b0e9b0509568..7bad73b2d146 100644
> > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
> > +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
> > @@ -145,6 +145,16 @@ static void dcn3_build_wm_range_table(struct clk_mgr_internal *clk_mgr)
> >         clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].pmfw_breakdown.min_uclk = min_uclk_mhz;
> >         clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].pmfw_breakdown.max_uclk = 0xFFFF;
> >
> > +       /* Set D - MALL - SR enter and exit times adjusted for MALL */
> > +//     clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].valid = true;
> > +//     clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].dml_input.pstate_latency_us = pstate_latency_us;
> > +//     clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].dml_input.sr_exit_time_us = 2;
> > +//     clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].dml_input.sr_enter_plus_exit_time_us = 4;
> > +//     clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.wm_type = WATERMARKS_MALL;
> > +//     clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.min_dcfclk = 0;
> > +//     clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.max_dcfclk = 0xFFFF;
> > +//     clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.min_uclk = min_uclk_mhz;
> > +//     clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.max_uclk = 0xFFFF;
> >  }
> >
> >  void dcn3_init_clocks(struct clk_mgr *clk_mgr_base)
> > diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
> > index 7ee3ec5a8af8..8ecc708bcd9e 100644
> > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
> > +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
> > @@ -297,6 +297,15 @@ void dcn30_smu_set_num_of_displays(struct clk_mgr_internal *clk_mgr, uint32_t nu
> >                         DALSMC_MSG_NumOfDisplays, num_displays, NULL);
> >  }
> >
> > +void dcn30_smu_set_display_refresh_from_mall(struct clk_mgr_internal *clk_mgr, bool enable, uint8_t cache_timer_delay, uint8_t cache_timer_scale)
> > +{
> > +       /* bits 8:7 for cache timer scale, bits 6:1 for cache timer delay, bit 0 = 1 for enable, = 0 for disable */
> > +       uint32_t param = (cache_timer_scale << 7) | (cache_timer_delay << 1) | (enable ? 1 : 0);
> > +
> > +       dcn30_smu_send_msg_with_param(clk_mgr,
> > +                       DALSMC_MSG_SetDisplayRefreshFromMall, param, NULL);
> > +}
> > +
> >  void dcn30_smu_set_external_client_df_cstate_allow(struct clk_mgr_internal *clk_mgr, bool enable)
> >  {
> >         smu_print("SMU Set external client df cstate allow: enable = %d\n", enable);
> > diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.h
> > index 236f20ec90d4..dd2640a3ce5d 100644
> > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.h
> > +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.h
> > @@ -70,6 +70,7 @@ typedef enum {
> >  typedef enum {
> >         WATERMARKS_CLOCK_RANGE = 0,
> >         WATERMARKS_DUMMY_PSTATE,
> > +       WATERMARKS_MALL,
> >         WATERMARKS_COUNT,
> >  } WATERMARKS_FLAGS_e;
> >
> > @@ -102,6 +103,7 @@ unsigned int dcn30_smu_get_dpm_freq_by_index(struct clk_mgr_internal *clk_mgr, P
> >  unsigned int dcn30_smu_get_dc_mode_max_dpm_freq(struct clk_mgr_internal *clk_mgr, PPCLK_e clk);
> >  void         dcn30_smu_set_min_deep_sleep_dcef_clk(struct clk_mgr_internal *clk_mgr, uint32_t freq_mhz);
> >  void         dcn30_smu_set_num_of_displays(struct clk_mgr_internal *clk_mgr, uint32_t num_displays);
> > +void         dcn30_smu_set_display_refresh_from_mall(struct clk_mgr_internal *clk_mgr, bool enable, uint8_t cache_timer_delay, uint8_t cache_timer_scale);
> >  void         dcn30_smu_set_external_client_df_cstate_allow(struct clk_mgr_internal *clk_mgr, bool enable);
> >  void         dcn30_smu_set_pme_workaround(struct clk_mgr_internal *clk_mgr);
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> > index 8eb8e13e1130..a06f6d19e38e 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> > @@ -696,6 +696,10 @@ void dcn30_program_dmdata_engine(struct pipe_ctx *pipe_ctx)
> >
> >  bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
> >  {
> > +       union dmub_rb_cmd cmd;
> > +       unsigned int surface_size, refresh_hz, denom;
> > +       uint32_t tmr_delay = 0, tmr_scale = 0;
> > +
> >         if (!dc->ctx->dmub_srv)
> >                 return false;
> >
> > @@ -710,12 +714,73 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
> >                                         /* Fail eligibility on a visible stream */
> >                                         break;
> >                         }
> > +
> > +                       // TODO: remove hard code size
> > +                       if (surface_size < 128 * 1024 * 1024) {
>
> I think surface_size is uninitialized here?

Whoops, looks like this crossed with another patch when I rebased and
we lost the surface_size calculation.  Fix sent.

Alex


>
> > +                               refresh_hz = (unsigned long long) dc->current_state->streams[0]->timing.pix_clk_100hz * 100LL /
> > +                                               (dc->current_state->streams[0]->timing.v_total * dc->current_state->streams[0]->timing.h_total);
> > +
> > +                               /*
> > +                                * Delay_Us = 65.28 * (64 + MallFrameCacheTmrDly) * 2^MallFrameCacheTmrScale
> > +                                * Delay_Us / 65.28 = (64 + MallFrameCacheTmrDly) * 2^MallFrameCacheTmrScale
> > +                                * (Delay_Us / 65.28) / 2^MallFrameCacheTmrScale = 64 + MallFrameCacheTmrDly
> > +                                * MallFrameCacheTmrDly = ((Delay_Us / 65.28) / 2^MallFrameCacheTmrScale) - 64
> > +                                *                      = (1000000 / refresh) / 65.28 / 2^MallFrameCacheTmrScale - 64
> > +                                *                      = 1000000 / (refresh * 65.28 * 2^MallFrameCacheTmrScale) - 64
> > +                                *                      = (1000000 * 100) / (refresh * 6528 * 2^MallFrameCacheTmrScale) - 64
> > +                                *
> > +                                * need to round up the result of the division before the subtraction
> > +                                */
> > +                               denom = refresh_hz * 6528;
> > +                               tmr_delay = (100000000LL + denom - 1) / denom - 64LL;
> > +
> > +                               /* scale should be increased until it fits into 6 bits */
> > +                               while (tmr_delay & ~0x3F) {
> > +                                       tmr_scale++;
> > +
> > +                                       if (tmr_scale > 3) {
> > +                                               /* The delay exceeds the range of the hystersis timer */
> > +                                               ASSERT(false);
> > +                                               return false;
> > +                                       }
> > +
> > +                                       denom *= 2;
> > +                                       tmr_delay = (100000000LL + denom - 1) / denom - 64LL;
> > +                               }
> > +
> > +                               /* Enable MALL */
> > +                               memset(&cmd, 0, sizeof(cmd));
> > +                               cmd.mall.header.type = DMUB_CMD__MALL;
> > +                               cmd.mall.header.sub_type =
> > +                                       DMUB_CMD__MALL_ACTION_ALLOW;
> > +                               cmd.mall.header.payload_bytes =
> > +                                       sizeof(cmd.mall) -
> > +                                       sizeof(cmd.mall.header);
> > +                               cmd.mall.tmr_delay = tmr_delay;
> > +                               cmd.mall.tmr_scale = tmr_scale;
> > +
> > +                               dc_dmub_srv_cmd_queue(dc->ctx->dmub_srv, &cmd);
> > +                               dc_dmub_srv_cmd_execute(dc->ctx->dmub_srv);
> > +
> > +                               return true;
> > +                       }
> >                 }
> >
> >                 /* No applicable optimizations */
> >                 return false;
> >         }
> >
> > +       /* Disable MALL */
> > +       memset(&cmd, 0, sizeof(cmd));
> > +       cmd.mall.header.type = DMUB_CMD__MALL;
> > +       cmd.mall.header.sub_type = DMUB_CMD__MALL_ACTION_DISALLOW;
> > +       cmd.mall.header.payload_bytes =
> > +               sizeof(cmd.mall) - sizeof(cmd.mall.header);
> > +
> > +       dc_dmub_srv_cmd_queue(dc->ctx->dmub_srv, &cmd);
> > +       dc_dmub_srv_cmd_execute(dc->ctx->dmub_srv);
> > +       dc_dmub_srv_wait_idle(dc->ctx->dmub_srv);
> > +
> >         return true;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> > index 783a1d7ae7d3..b132bb7f6704 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> > @@ -2247,7 +2247,7 @@ void dcn30_calculate_wm_and_dlg(
> >         /* Set D:
> >          * DCFCLK: Min Required
> >          * FCLK(proportional to UCLK): 1GHz or Max
> > -        * sr_enter_exit = 4, sr_exit = 2us
> > +        * MALL stutter, sr_enter_exit = 4, sr_exit = 2us
> >          */
> >         /*
> >         if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_D].valid) {
> > diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> > index 26a4c6caf606..6e5be1fdb4bb 100644
> > --- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> > +++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> > @@ -298,6 +298,7 @@ enum dmub_cmd_type {
> >         DMUB_CMD__REG_REG_WAIT = 4,
> >         DMUB_CMD__PLAT_54186_WA = 5,
> >         DMUB_CMD__PSR = 64,
> > +       DMUB_CMD__MALL = 65,
> >         DMUB_CMD__ABM = 66,
> >         DMUB_CMD__HW_LOCK = 69,
> >         DMUB_CMD__DP_AUX_ACCESS = 70,
> > @@ -425,6 +426,18 @@ struct dmub_rb_cmd_PLAT_54186_wa {
> >         struct dmub_cmd_PLAT_54186_wa flip;
> >  };
> >
> > +struct dmub_rb_cmd_mall {
> > +       struct dmub_cmd_header header;
> > +       union dmub_addr cursor_copy_src;
> > +       union dmub_addr cursor_copy_dst;
> > +       uint32_t tmr_delay;
> > +       uint32_t tmr_scale;
> > +       uint16_t cursor_width;
> > +       uint16_t cursor_pitch;
> > +       uint16_t cursor_height;
> > +       uint8_t cursor_bpp;
> > +};
> > +
> >  struct dmub_cmd_digx_encoder_control_data {
> >         union dig_encoder_control_parameters_v1_5 dig;
> >  };
> > @@ -556,6 +569,12 @@ enum psr_version {
> >         PSR_VERSION_UNSUPPORTED                 = 0xFFFFFFFF,
> >  };
> >
> > +enum dmub_cmd_mall_type {
> > +       DMUB_CMD__MALL_ACTION_ALLOW = 0,
> > +       DMUB_CMD__MALL_ACTION_DISALLOW = 1,
> > +       DMUB_CMD__MALL_ACTION_COPY_CURSOR = 2,
> > +};
> > +
> >  struct dmub_cmd_psr_copy_settings_data {
> >         union dmub_psr_debug_flags debug;
> >         uint16_t psr_level;
> > @@ -761,6 +780,7 @@ union dmub_rb_cmd {
> >         struct dmub_rb_cmd_psr_enable psr_enable;
> >         struct dmub_rb_cmd_psr_set_level psr_set_level;
> >         struct dmub_rb_cmd_PLAT_54186_wa PLAT_54186_wa;
> > +       struct dmub_rb_cmd_mall mall;
> >         struct dmub_rb_cmd_abm_set_pipe abm_set_pipe;
> >         struct dmub_rb_cmd_abm_set_backlight abm_set_backlight;
> >         struct dmub_rb_cmd_abm_set_level abm_set_level;
> > --
> > 2.25.4
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
