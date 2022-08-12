Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FDFC00140
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Aug 2022 16:48:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD8DE9A236;
	Fri, 12 Aug 2022 16:48:01 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9665118AD1F
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Aug 2022 16:47:55 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-10e6bdbe218so1520076fac.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Aug 2022 09:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc;
 bh=hydAX28f9Fgw1rjwHMKlTUgcYk5qI11uJvegqO24XCo=;
 b=jZAB3BW2Nlv2Cb3i6QqfEMVk4lJtEIrymdqfBpjVfHDEVzv0SJ3+okqdWeleXzysF/
 OKUF42UZ103zXYYC7vOE10pFskdXV4NNMrRQS9v4tBeyISbj9qSoxOb70g7uQju4TQFu
 Jme+CTQ/JQq+27J2e2Z5Fd1Tt6ydeCq4ipL7dLvMiIUEDgXiQx7Vba79rPMdUeIsby+M
 EWAPIm1PKaNGE3/0ywIsRyt5aonsgE+RjdF5XCxa/f5jmOGd/7nDf85uBT3VkGc03Yp1
 0gn3yhZZU+QM23ihndvOVcVz4DFRzODgBaTeP6dg9VjFX9ytQEJjawGuoW9WENRQuFaC
 gwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=hydAX28f9Fgw1rjwHMKlTUgcYk5qI11uJvegqO24XCo=;
 b=wMPdvuzg3h7SFBWfCDkUGL9PxXKkdApvDhv0Knmn/Dr9ub6IAwuPKOaED7Pha2UMQP
 nnohXNCk1zxuVTmYwhl9TX41P6mUPQUYM8RoZGBrt6OAjMRbA4CrX5Fgpn0jwVMpZsR9
 f5vtDn1zj9i1QycdD6cvtH36cFFq8WX4s4ei7Z1h5VDn/fWxsoji/WGUUnMxX46ikOVe
 apLow/XeIa+lRko8UIswAJ9kL3fKNpt/qZpmdkNxYkOWlTVfWbMoNPwAOxWj4A/mNHUn
 y14T0QGZ13WuJfz6PpUnHZmHKNS2+vS3BkHyWITfWB7s3WYzfqfKeMDJOt1QsIE8VCez
 zinA==
X-Gm-Message-State: ACgBeo3JNto3Fk1RzYQP5F52uJrDDhosbG0knHE9wGfY2hSBOsT+iFbs
 oaA4L0foSM01O/3RPsDkDKB/8Qr/kY8KsZjkjBB8AMYZ
X-Google-Smtp-Source: AA6agR4JYp0PDZOWHK089uI3e3Gz5RiQ30WzrPHpdBlRwuJ09Af2vHgzixlKfyAplnzgjH9JB3/RI/ZNBPCbO66nuwg=
X-Received: by 2002:a05:6870:3398:b0:113:7f43:d0e9 with SMTP id
 w24-20020a056870339800b001137f43d0e9mr2051224oae.33.1660322874759; Fri, 12
 Aug 2022 09:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220811195619.4155393-1-Rodrigo.Siqueira@amd.com>
 <CADnq5_PazqPD=EAE48DSfHR5G=ihz6CvDTvRZRJVDSvbpuAHTg@mail.gmail.com>
 <4f4d3b12-1013-00d5-31ea-1c9629f14e65@amd.com>
In-Reply-To: <4f4d3b12-1013-00d5-31ea-1c9629f14e65@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 Aug 2022 12:47:43 -0400
Message-ID: <CADnq5_P+p0LAWbS70ArL_ZPUWpmsZo+rjrC2+mxLrs1T_vUtjA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: Fix a compilation failure on PowerPC
 caused by FPU code
To: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
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

On Thu, Aug 11, 2022 at 6:38 PM Rodrigo Siqueira Jordao
<Rodrigo.Siqueira@amd.com> wrote:
>
>
>
> On 2022-08-11 17:49, Alex Deucher wrote:
> > On Thu, Aug 11, 2022 at 3:56 PM Rodrigo Siqueira
> > <Rodrigo.Siqueira@amd.com> wrote:
> >>
> >> We got a report from Stephen/Michael that the PowerPC build was failin=
g
> >> with the following error:
> >>
> >> ld: drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.o uses hard fl=
oat, drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.o uses soft float
> >> ld: failed to merge target specific data of file drivers/gpu/drm/amd/d=
isplay/dc/dcn30/dcn30_optc.o
> >>
> >> This error happened because of the function optc3_set_vrr_m_const. Thi=
s
> >> function expects a double as a parameter in a code that is not allowed
> >> to have FPU operations. After further investigation, it became clear
> >> that optc3_set_vrr_m_const was never invoked, so we can safely drop th=
is
> >> function and fix the ld issue.
> >>
> >> Changes since V1:
> >>   - Drop optc3_fpu_set_vrr_m_const since it is unused.
> >
> > FWIW, I upstreamed v1 already.  Can you rebase your v2 changes on that?
>
> Hi Alex,
>
> I guess the v1 was not merged into the amd-staging-drm-next. I just
> applied the v1 there (waiting for CI result).

Yeah, sorry, I should have mentioned that.  I thought you were going
to apply it.  I wanted to fix the failure before I send Dave my last
PR for the merge window.

Alex


>
> I also sent this patch:
>
> https://lore.kernel.org/amd-gfx/CADnq5_OiqWc7REg8CJ_S6UKHoBV0ZgE-+9WO1Cex=
Ojk+7ZWeNg@mail.gmail.com/T/#t
>
> Thanks
> Siqueira
>
> >
> > Alex
> >
> >>
> >> Cc: Alex Deucher <alexander.deucher@amd.com>
> >> Cc: Melissa Wen <mwen@igalia.com>
> >> Cc: Ma=C3=ADra Canal <mairacanal@riseup.net>
> >> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> >> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> >> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> >> ---
> >>   .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  8 --
> >>   .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.h |  3 -
> >>   .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.c |  1 -
> >>   .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  | 77 -----------------=
--
> >>   .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.h  |  3 -
> >>   .../amd/display/dc/inc/hw/timing_generator.h  |  2 -
> >>   6 files changed, 94 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drive=
rs/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
> >> index d072997477dd..1782b9c26cf4 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
> >> @@ -184,14 +184,6 @@ void optc3_set_dsc_config(struct timing_generator=
 *optc,
> >>          REG_UPDATE(OTG_V_SYNC_A_CNTL, OTG_V_SYNC_MODE, 0);
> >>   }
> >>
> >> -void optc3_set_vrr_m_const(struct timing_generator *optc,
> >> -               double vtotal_avg)
> >> -{
> >> -       DC_FP_START();
> >> -       optc3_fpu_set_vrr_m_const(optc, vtotal_avg);
> >> -       DC_FP_END();
> >> -}
> >> -
> >>   void optc3_set_odm_bypass(struct timing_generator *optc,
> >>                  const struct dc_crtc_timing *dc_crtc_timing)
> >>   {
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h b/drive=
rs/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
> >> index 33bd12f5dc17..dd45a5499b07 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
> >> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
> >> @@ -329,9 +329,6 @@ void optc3_lock_doublebuffer_enable(struct timing_=
generator *optc);
> >>
> >>   void optc3_lock_doublebuffer_disable(struct timing_generator *optc);
> >>
> >> -void optc3_set_vrr_m_const(struct timing_generator *optc,
> >> -               double vtotal_avg);
> >> -
> >>   void optc3_set_drr_trigger_window(struct timing_generator *optc,
> >>                  uint32_t window_start, uint32_t window_end);
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c b/drive=
rs/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
> >> index 9861be1dc063..1fad7b48bd5b 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
> >> @@ -281,7 +281,6 @@ static struct timing_generator_funcs dcn32_tg_func=
s =3D {
> >>                  .lock_doublebuffer_enable =3D optc3_lock_doublebuffer=
_enable,
> >>                  .lock_doublebuffer_disable =3D optc3_lock_doublebuffe=
r_disable,
> >>                  .enable_optc_clock =3D optc1_enable_optc_clock,
> >> -               .set_vrr_m_const =3D optc3_set_vrr_m_const,
> >>                  .set_drr =3D optc32_set_drr,
> >>                  .get_last_used_drr_vtotal =3D optc2_get_last_used_drr=
_vtotal,
> >>                  .set_vtotal_min_max =3D optc3_set_vtotal_min_max,
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/dr=
ivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> >> index e1e92daba668..814374b1016c 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> >> @@ -177,83 +177,6 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_0_soc =
=3D {
> >>          .urgent_latency_adjustment_fabric_clock_reference_mhz =3D 100=
0,
> >>   };
> >>
> >> -
> >> -void optc3_fpu_set_vrr_m_const(struct timing_generator *optc,
> >> -               double vtotal_avg)
> >> -{
> >> -       struct optc *optc1 =3D DCN10TG_FROM_TG(optc);
> >> -       double vtotal_min, vtotal_max;
> >> -       double ratio, modulo, phase;
> >> -       uint32_t vblank_start;
> >> -       uint32_t v_total_mask_value =3D 0;
> >> -
> >> -       dc_assert_fp_enabled();
> >> -
> >> -       /* Compute VTOTAL_MIN and VTOTAL_MAX, so that
> >> -        * VOTAL_MAX - VTOTAL_MIN =3D 1
> >> -        */
> >> -       v_total_mask_value =3D 16;
> >> -       vtotal_min =3D dcn_bw_floor(vtotal_avg);
> >> -       vtotal_max =3D dcn_bw_ceil(vtotal_avg);
> >> -
> >> -       /* Check that bottom VBLANK is at least 2 lines tall when runn=
ing with
> >> -        * VTOTAL_MIN. Note that VTOTAL registers are defined as 'tota=
l number
> >> -        * of lines in a frame - 1'.
> >> -        */
> >> -       REG_GET(OTG_V_BLANK_START_END, OTG_V_BLANK_START,
> >> -               &vblank_start);
> >> -       ASSERT(vtotal_min >=3D vblank_start + 1);
> >> -
> >> -       /* Special case where the average frame rate can be achieved
> >> -        * without using the DTO
> >> -        */
> >> -       if (vtotal_min =3D=3D vtotal_max) {
> >> -               REG_SET(OTG_V_TOTAL, 0, OTG_V_TOTAL, (uint32_t)vtotal_=
min);
> >> -
> >> -               optc->funcs->set_vtotal_min_max(optc, 0, 0);
> >> -               REG_SET(OTG_M_CONST_DTO0, 0, OTG_M_CONST_DTO_PHASE, 0)=
;
> >> -               REG_SET(OTG_M_CONST_DTO1, 0, OTG_M_CONST_DTO_MODULO, 0=
);
> >> -               REG_UPDATE_3(OTG_V_TOTAL_CONTROL,
> >> -                       OTG_V_TOTAL_MIN_SEL, 0,
> >> -                       OTG_V_TOTAL_MAX_SEL, 0,
> >> -                       OTG_SET_V_TOTAL_MIN_MASK_EN, 0);
> >> -               return;
> >> -       }
> >> -
> >> -       ratio =3D vtotal_max - vtotal_avg;
> >> -       modulo =3D 65536.0 * 65536.0 - 1.0; /* 2^32 - 1 */
> >> -       phase =3D ratio * modulo;
> >> -
> >> -       /* Special cases where the DTO phase gets rounded to 0 or
> >> -        * to DTO modulo
> >> -        */
> >> -       if (phase <=3D 0 || phase >=3D modulo) {
> >> -               REG_SET(OTG_V_TOTAL, 0, OTG_V_TOTAL,
> >> -                       phase <=3D 0 ?
> >> -                               (uint32_t)vtotal_max : (uint32_t)vtota=
l_min);
> >> -               REG_SET(OTG_V_TOTAL_MIN, 0, OTG_V_TOTAL_MIN, 0);
> >> -               REG_SET(OTG_V_TOTAL_MAX, 0, OTG_V_TOTAL_MAX, 0);
> >> -               REG_SET(OTG_M_CONST_DTO0, 0, OTG_M_CONST_DTO_PHASE, 0)=
;
> >> -               REG_SET(OTG_M_CONST_DTO1, 0, OTG_M_CONST_DTO_MODULO, 0=
);
> >> -               REG_UPDATE_3(OTG_V_TOTAL_CONTROL,
> >> -                       OTG_V_TOTAL_MIN_SEL, 0,
> >> -                       OTG_V_TOTAL_MAX_SEL, 0,
> >> -                       OTG_SET_V_TOTAL_MIN_MASK_EN, 0);
> >> -               return;
> >> -       }
> >> -       REG_UPDATE_6(OTG_V_TOTAL_CONTROL,
> >> -               OTG_V_TOTAL_MIN_SEL, 1,
> >> -               OTG_V_TOTAL_MAX_SEL, 1,
> >> -               OTG_SET_V_TOTAL_MIN_MASK_EN, 1,
> >> -               OTG_SET_V_TOTAL_MIN_MASK, v_total_mask_value,
> >> -               OTG_VTOTAL_MID_REPLACING_MIN_EN, 0,
> >> -               OTG_VTOTAL_MID_REPLACING_MAX_EN, 0);
> >> -       REG_SET(OTG_V_TOTAL, 0, OTG_V_TOTAL, (uint32_t)vtotal_min);
> >> -       optc->funcs->set_vtotal_min_max(optc, vtotal_min, vtotal_max);
> >> -       REG_SET(OTG_M_CONST_DTO0, 0, OTG_M_CONST_DTO_PHASE, (uint32_t)=
phase);
> >> -       REG_SET(OTG_M_CONST_DTO1, 0, OTG_M_CONST_DTO_MODULO, (uint32_t=
)modulo);
> >> -}
> >> -
> >>   void dcn30_fpu_populate_dml_writeback_from_context(
> >>                  struct dc *dc, struct resource_context *res_ctx, disp=
lay_e2e_pipe_params_st *pipes)
> >>   {
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h b/dr=
ivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h
> >> index cab864095ce7..e3b6ad6a8784 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h
> >> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h
> >> @@ -29,9 +29,6 @@
> >>   #include "core_types.h"
> >>   #include "dcn20/dcn20_optc.h"
> >>
> >> -void optc3_fpu_set_vrr_m_const(struct timing_generator *optc,
> >> -               double vtotal_avg);
> >> -
> >>   void dcn30_fpu_populate_dml_writeback_from_context(
> >>                  struct dc *dc, struct resource_context *res_ctx, disp=
lay_e2e_pipe_params_st *pipes);
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h =
b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> >> index 828e5c6ad1cf..72eef7a5ed83 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> >> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> >> @@ -310,8 +310,6 @@ struct timing_generator_funcs {
> >>                          int group_idx,
> >>                          uint32_t gsl_ready_signal);
> >>          void (*set_out_mux)(struct timing_generator *tg, enum otg_out=
_mux_dest dest);
> >> -       void (*set_vrr_m_const)(struct timing_generator *optc,
> >> -                       double vtotal_avg);
> >>          void (*set_drr_trigger_window)(struct timing_generator *optc,
> >>                          uint32_t window_start, uint32_t window_end);
> >>          void (*set_vtotal_change_limit)(struct timing_generator *optc=
,
> >> --
> >> 2.35.1
> >>
>
