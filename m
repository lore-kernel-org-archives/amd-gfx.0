Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB6DC00140
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Aug 2022 16:51:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DF94997B6;
	Fri, 12 Aug 2022 16:51:06 +0000 (UTC)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 647312A6A8
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Aug 2022 16:50:56 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 c17-20020a4a8ed1000000b004452faec26dso259928ool.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Aug 2022 09:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=Ovwo1ZksFGLmubnLztZIC5EBLYVC5JXPSyzMmDLZ3fA=;
 b=dYnItHv8+VsaxKFo9Vie1ZtxNr591vGv+bxPY5UcjzT3Akqq6qQsXMtb0uudLhp+Wm
 rYdTjzFHf+XYU27qcS5BJxcXWnnAiQaIlhLAdN8wnRWifrjHk2Gd3jfRGfdrEVINALfX
 I2vHkS3GfS+yRloKpgi1fQvAzBJogAi+rHQeIuMrb81jP3DJn0hpkVgcsV0occ7yxqoy
 fRdutj1QQcEYV0oznUcqGOCsnce47LBGkTK/i77I0MGn+mIjH67q1ir7dXltT8Qg8Fav
 nQEd6DxJ9nzHoMtEC2gToJtUZwjiomQGoTSN8XToLN3aV/2D7cbiD7PW9PcQDFpcNlyz
 Kd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=Ovwo1ZksFGLmubnLztZIC5EBLYVC5JXPSyzMmDLZ3fA=;
 b=BAwhw2LL4eT5wQgNNQ2NTBU2RlM4lydaIM0OmOUIyY8VB70MvtiqVw0Mt+nkpe6kpX
 opU+fH52EAZtkRjDx0NgwMfn2qhNyAhefEPun2iXM372H4/OSWg1QEEAok4asN1bfdr1
 30Ygb917/q4BmMcbXxncx6pVSj8A4CPCNAIUeyHcm8y6DdhQHwdDl4WuPhaUsa5QiBR8
 EL+eDvD6A0Gy5ro/Bm1ySbW01EgCpEyc0FeWqZYnfMHOXoZCMQyUO7NY9AtGm+Nb/vr+
 qujhQZ5TYeZJA5fnKbA+VaR/8zoNjhR9dkuTraGI/4hPMrrUIlj59RKbCJgWe/Ol021O
 lSbg==
X-Gm-Message-State: ACgBeo3C+iUfWKyjKh9B58aAx4rvBIWpTUpo7DIwgCT+Kk678q+1pQOk
 jnWfPrQyO5LaMml4xgxV2zZsiDYqNppx5nmH7JR1k1a9
X-Google-Smtp-Source: AA6agR5dPM22142Y+LAn1DBozq0M6GF0FV6k+dn6GOI7xYrukyFSrfyTbkBLLxYt6gpP9cPkPcrGhmwSiTrKQvfxVuM=
X-Received: by 2002:a4a:4541:0:b0:435:cf9f:1a45 with SMTP id
 y62-20020a4a4541000000b00435cf9f1a45mr1504891ooa.17.1660323055606; Fri, 12
 Aug 2022 09:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220811223530.55892-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220811223530.55892-1-Rodrigo.Siqueira@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 Aug 2022 12:50:44 -0400
Message-ID: <CADnq5_PLvE3fxFxsVjoMuy3BWk6Y8399sZiYgQ6H=WUJjn1THA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Drop unused code
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Aug 11, 2022 at 6:36 PM Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com> wrote:
>
> After removing some code for fixing the PowerPC compilation, we had some
> leftover functions that are not used anymore. This commit drops
> optc3_fpu_set_vrr_m_const since we don't need it anymore.
>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  | 77 -------------------
>  .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.h  |  3 -
>  2 files changed, 80 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> index e1e92daba668..814374b1016c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> @@ -177,83 +177,6 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_0_soc = {
>         .urgent_latency_adjustment_fabric_clock_reference_mhz = 1000,
>  };
>
> -
> -void optc3_fpu_set_vrr_m_const(struct timing_generator *optc,
> -               double vtotal_avg)
> -{
> -       struct optc *optc1 = DCN10TG_FROM_TG(optc);
> -       double vtotal_min, vtotal_max;
> -       double ratio, modulo, phase;
> -       uint32_t vblank_start;
> -       uint32_t v_total_mask_value = 0;
> -
> -       dc_assert_fp_enabled();
> -
> -       /* Compute VTOTAL_MIN and VTOTAL_MAX, so that
> -        * VOTAL_MAX - VTOTAL_MIN = 1
> -        */
> -       v_total_mask_value = 16;
> -       vtotal_min = dcn_bw_floor(vtotal_avg);
> -       vtotal_max = dcn_bw_ceil(vtotal_avg);
> -
> -       /* Check that bottom VBLANK is at least 2 lines tall when running with
> -        * VTOTAL_MIN. Note that VTOTAL registers are defined as 'total number
> -        * of lines in a frame - 1'.
> -        */
> -       REG_GET(OTG_V_BLANK_START_END, OTG_V_BLANK_START,
> -               &vblank_start);
> -       ASSERT(vtotal_min >= vblank_start + 1);
> -
> -       /* Special case where the average frame rate can be achieved
> -        * without using the DTO
> -        */
> -       if (vtotal_min == vtotal_max) {
> -               REG_SET(OTG_V_TOTAL, 0, OTG_V_TOTAL, (uint32_t)vtotal_min);
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
> -       ratio = vtotal_max - vtotal_avg;
> -       modulo = 65536.0 * 65536.0 - 1.0; /* 2^32 - 1 */
> -       phase = ratio * modulo;
> -
> -       /* Special cases where the DTO phase gets rounded to 0 or
> -        * to DTO modulo
> -        */
> -       if (phase <= 0 || phase >= modulo) {
> -               REG_SET(OTG_V_TOTAL, 0, OTG_V_TOTAL,
> -                       phase <= 0 ?
> -                               (uint32_t)vtotal_max : (uint32_t)vtotal_min);
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
> -       REG_SET(OTG_M_CONST_DTO0, 0, OTG_M_CONST_DTO_PHASE, (uint32_t)phase);
> -       REG_SET(OTG_M_CONST_DTO1, 0, OTG_M_CONST_DTO_MODULO, (uint32_t)modulo);
> -}
> -
>  void dcn30_fpu_populate_dml_writeback_from_context(
>                 struct dc *dc, struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes)
>  {
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h
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
>                 struct dc *dc, struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes);
>
> --
> 2.35.1
>
