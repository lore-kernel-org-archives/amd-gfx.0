Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB97BC19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 21:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 850B58F98E;
	Thu, 11 Aug 2022 21:49:24 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 206E812A57F
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 21:49:13 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id w196so17812695oiw.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 14:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc;
 bh=3gjvxQGEk/RuAmfZs12urw9rTy/0jMIwLDVHLYvHIFs=;
 b=qCc+rIjeJlr1BL37lX3XQBI4Wtu/1kN7H2/OolgGfRDdNhwwvdJXKMl7mn5zDpfH7B
 2fSrA+R1EbwcC4UMSRJky2xvZymEarE/UjeslC9g3Lm4xwcLGEHHbjZwfCn2NSxNOybQ
 VmHP9qXBl/Iwx8fBCzXAmqukJK0HE0X68NqBO8UmN8Gh9AWfyssCShSqZ9Abw6Fa7PD7
 7I21lXWNxNYj7uNv8/opahF5k3sb+gYQ2T2Y87ccXf6ecW3peVUNG+ANJjdlISwD6t/X
 lK49GIFx5iU2GkUFr6vaha8eRKGQZVex+eYRXnMsP5fJTL81NXNAciSaNGfgkQzUQQJD
 RDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=3gjvxQGEk/RuAmfZs12urw9rTy/0jMIwLDVHLYvHIFs=;
 b=FOXArmZiPOI9ILkUAnyPNBdNwSgmC3V+Vco7cqAUHMt+EALDNUxgycMdEe4YsQlwh8
 uTAUD8Iq3eoPaKRFeeBgGTJezif3r1Zj6rmuvTvITuuitrLk2rF0A7SoAIbW7YhvH1Br
 PjVEVENs6e3Xm8mBDEf6eno8Y8LkEzad57Bmpet/zHvwDqVWrcS3X0BnhD5ZMDTXcDGf
 H2REPYVenfSGjg68KtwwMmb+kzlusePZ5AJ1b4b7pvEBH6Gf+0MLawpD2928Q6vrXc1r
 1iw9wkPlhp1C5U2ivNctedEE4PVvywxcJKqR7LX5rADOFJDI2Y7iDBxb+CBRBNRQGj3U
 oIRA==
X-Gm-Message-State: ACgBeo0+xjJbbgOI6vC+yKmQVrWWoz5tzKw0TZADb4mSDGa+vhc2T5xU
 zyz1VSeL/z2fSK64VGlJmT15MXOzr2ZSF6ll67k=
X-Google-Smtp-Source: AA6agR7fPmD4S3AQnU2Ya2qEFaIfEP+THaZDl6aHcZX0V6b1xqMkOzy6eKjU1w+QdvBAxc6Kx5u0GfTpkA3bhr93Wac=
X-Received: by 2002:a05:6808:19a3:b0:33e:1525:3fb4 with SMTP id
 bj35-20020a05680819a300b0033e15253fb4mr493765oib.106.1660254552422; Thu, 11
 Aug 2022 14:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220811195619.4155393-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220811195619.4155393-1-Rodrigo.Siqueira@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Aug 2022 17:49:01 -0400
Message-ID: <CADnq5_PazqPD=EAE48DSfHR5G=ihz6CvDTvRZRJVDSvbpuAHTg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: Fix a compilation failure on PowerPC
 caused by FPU code
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Ellerman <mpe@ellerman.id.au>, amd-gfx@lists.freedesktop.org,
 Melissa Wen <mwen@igalia.com>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
 Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Aug 11, 2022 at 3:56 PM Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com> wrote:
>
> We got a report from Stephen/Michael that the PowerPC build was failing
> with the following error:
>
> ld: drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.o uses hard float=
, drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.o uses soft float
> ld: failed to merge target specific data of file drivers/gpu/drm/amd/disp=
lay/dc/dcn30/dcn30_optc.o
>
> This error happened because of the function optc3_set_vrr_m_const. This
> function expects a double as a parameter in a code that is not allowed
> to have FPU operations. After further investigation, it became clear
> that optc3_set_vrr_m_const was never invoked, so we can safely drop this
> function and fix the ld issue.
>
> Changes since V1:
>  - Drop optc3_fpu_set_vrr_m_const since it is unused.

FWIW, I upstreamed v1 already.  Can you rebase your v2 changes on that?

Alex

>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: Ma=C3=ADra Canal <mairacanal@riseup.net>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>  .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  8 --
>  .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.h |  3 -
>  .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.c |  1 -
>  .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  | 77 -------------------
>  .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.h  |  3 -
>  .../amd/display/dc/inc/hw/timing_generator.h  |  2 -
>  6 files changed, 94 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/=
gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
> index d072997477dd..1782b9c26cf4 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
> @@ -184,14 +184,6 @@ void optc3_set_dsc_config(struct timing_generator *o=
ptc,
>         REG_UPDATE(OTG_V_SYNC_A_CNTL, OTG_V_SYNC_MODE, 0);
>  }
>
> -void optc3_set_vrr_m_const(struct timing_generator *optc,
> -               double vtotal_avg)
> -{
> -       DC_FP_START();
> -       optc3_fpu_set_vrr_m_const(optc, vtotal_avg);
> -       DC_FP_END();
> -}
> -
>  void optc3_set_odm_bypass(struct timing_generator *optc,
>                 const struct dc_crtc_timing *dc_crtc_timing)
>  {
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h b/drivers/=
gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
> index 33bd12f5dc17..dd45a5499b07 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
> @@ -329,9 +329,6 @@ void optc3_lock_doublebuffer_enable(struct timing_gen=
erator *optc);
>
>  void optc3_lock_doublebuffer_disable(struct timing_generator *optc);
>
> -void optc3_set_vrr_m_const(struct timing_generator *optc,
> -               double vtotal_avg);
> -
>  void optc3_set_drr_trigger_window(struct timing_generator *optc,
>                 uint32_t window_start, uint32_t window_end);
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c b/drivers/=
gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
> index 9861be1dc063..1fad7b48bd5b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
> @@ -281,7 +281,6 @@ static struct timing_generator_funcs dcn32_tg_funcs =
=3D {
>                 .lock_doublebuffer_enable =3D optc3_lock_doublebuffer_ena=
ble,
>                 .lock_doublebuffer_disable =3D optc3_lock_doublebuffer_di=
sable,
>                 .enable_optc_clock =3D optc1_enable_optc_clock,
> -               .set_vrr_m_const =3D optc3_set_vrr_m_const,
>                 .set_drr =3D optc32_set_drr,
>                 .get_last_used_drr_vtotal =3D optc2_get_last_used_drr_vto=
tal,
>                 .set_vtotal_min_max =3D optc3_set_vtotal_min_max,
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drive=
rs/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> index e1e92daba668..814374b1016c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> @@ -177,83 +177,6 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_0_soc =3D {
>         .urgent_latency_adjustment_fabric_clock_reference_mhz =3D 1000,
>  };
>
> -
> -void optc3_fpu_set_vrr_m_const(struct timing_generator *optc,
> -               double vtotal_avg)
> -{
> -       struct optc *optc1 =3D DCN10TG_FROM_TG(optc);
> -       double vtotal_min, vtotal_max;
> -       double ratio, modulo, phase;
> -       uint32_t vblank_start;
> -       uint32_t v_total_mask_value =3D 0;
> -
> -       dc_assert_fp_enabled();
> -
> -       /* Compute VTOTAL_MIN and VTOTAL_MAX, so that
> -        * VOTAL_MAX - VTOTAL_MIN =3D 1
> -        */
> -       v_total_mask_value =3D 16;
> -       vtotal_min =3D dcn_bw_floor(vtotal_avg);
> -       vtotal_max =3D dcn_bw_ceil(vtotal_avg);
> -
> -       /* Check that bottom VBLANK is at least 2 lines tall when running=
 with
> -        * VTOTAL_MIN. Note that VTOTAL registers are defined as 'total n=
umber
> -        * of lines in a frame - 1'.
> -        */
> -       REG_GET(OTG_V_BLANK_START_END, OTG_V_BLANK_START,
> -               &vblank_start);
> -       ASSERT(vtotal_min >=3D vblank_start + 1);
> -
> -       /* Special case where the average frame rate can be achieved
> -        * without using the DTO
> -        */
> -       if (vtotal_min =3D=3D vtotal_max) {
> -               REG_SET(OTG_V_TOTAL, 0, OTG_V_TOTAL, (uint32_t)vtotal_min=
);
> -
> -               optc->funcs->set_vtotal_min_max(optc, 0, 0);
> -               REG_SET(OTG_M_CONST_DTO0, 0, OTG_M_CONST_DTO_PHASE, 0);
> -               REG_SET(OTG_M_CONST_DTO1, 0, OTG_M_CONST_DTO_MODULO, 0);
> -               REG_UPDATE_3(OTG_V_TOTAL_CONTROL,
> -                       OTG_V_TOTAL_MIN_SEL, 0,
> -                       OTG_V_TOTAL_MAX_SEL, 0,
> -                       OTG_SET_V_TOTAL_MIN_MASK_EN, 0);
> -               return;
> -       }
> -
> -       ratio =3D vtotal_max - vtotal_avg;
> -       modulo =3D 65536.0 * 65536.0 - 1.0; /* 2^32 - 1 */
> -       phase =3D ratio * modulo;
> -
> -       /* Special cases where the DTO phase gets rounded to 0 or
> -        * to DTO modulo
> -        */
> -       if (phase <=3D 0 || phase >=3D modulo) {
> -               REG_SET(OTG_V_TOTAL, 0, OTG_V_TOTAL,
> -                       phase <=3D 0 ?
> -                               (uint32_t)vtotal_max : (uint32_t)vtotal_m=
in);
> -               REG_SET(OTG_V_TOTAL_MIN, 0, OTG_V_TOTAL_MIN, 0);
> -               REG_SET(OTG_V_TOTAL_MAX, 0, OTG_V_TOTAL_MAX, 0);
> -               REG_SET(OTG_M_CONST_DTO0, 0, OTG_M_CONST_DTO_PHASE, 0);
> -               REG_SET(OTG_M_CONST_DTO1, 0, OTG_M_CONST_DTO_MODULO, 0);
> -               REG_UPDATE_3(OTG_V_TOTAL_CONTROL,
> -                       OTG_V_TOTAL_MIN_SEL, 0,
> -                       OTG_V_TOTAL_MAX_SEL, 0,
> -                       OTG_SET_V_TOTAL_MIN_MASK_EN, 0);
> -               return;
> -       }
> -       REG_UPDATE_6(OTG_V_TOTAL_CONTROL,
> -               OTG_V_TOTAL_MIN_SEL, 1,
> -               OTG_V_TOTAL_MAX_SEL, 1,
> -               OTG_SET_V_TOTAL_MIN_MASK_EN, 1,
> -               OTG_SET_V_TOTAL_MIN_MASK, v_total_mask_value,
> -               OTG_VTOTAL_MID_REPLACING_MIN_EN, 0,
> -               OTG_VTOTAL_MID_REPLACING_MAX_EN, 0);
> -       REG_SET(OTG_V_TOTAL, 0, OTG_V_TOTAL, (uint32_t)vtotal_min);
> -       optc->funcs->set_vtotal_min_max(optc, vtotal_min, vtotal_max);
> -       REG_SET(OTG_M_CONST_DTO0, 0, OTG_M_CONST_DTO_PHASE, (uint32_t)pha=
se);
> -       REG_SET(OTG_M_CONST_DTO1, 0, OTG_M_CONST_DTO_MODULO, (uint32_t)mo=
dulo);
> -}
> -
>  void dcn30_fpu_populate_dml_writeback_from_context(
>                 struct dc *dc, struct resource_context *res_ctx, display_=
e2e_pipe_params_st *pipes)
>  {
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h b/drive=
rs/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h
> index cab864095ce7..e3b6ad6a8784 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h
> @@ -29,9 +29,6 @@
>  #include "core_types.h"
>  #include "dcn20/dcn20_optc.h"
>
> -void optc3_fpu_set_vrr_m_const(struct timing_generator *optc,
> -               double vtotal_avg);
> -
>  void dcn30_fpu_populate_dml_writeback_from_context(
>                 struct dc *dc, struct resource_context *res_ctx, display_=
e2e_pipe_params_st *pipes);
>
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/d=
rivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> index 828e5c6ad1cf..72eef7a5ed83 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> @@ -310,8 +310,6 @@ struct timing_generator_funcs {
>                         int group_idx,
>                         uint32_t gsl_ready_signal);
>         void (*set_out_mux)(struct timing_generator *tg, enum otg_out_mux=
_dest dest);
> -       void (*set_vrr_m_const)(struct timing_generator *optc,
> -                       double vtotal_avg);
>         void (*set_drr_trigger_window)(struct timing_generator *optc,
>                         uint32_t window_start, uint32_t window_end);
>         void (*set_vtotal_change_limit)(struct timing_generator *optc,
> --
> 2.35.1
>
