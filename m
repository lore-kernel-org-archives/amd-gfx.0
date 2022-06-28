Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376C0C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 14:33:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB22310EA75;
	Tue, 28 Jun 2022 14:33:20 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7375810E96B
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 14:33:19 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id r18so9997238edb.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 07:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A5sxLz+tNpE8Kznf1HDDIft0dj+bOx31RoGXK7ytj2I=;
 b=X+xF4cuhQnvcH4QlBI7GU6FkDiLX0/5aWIc5rP9JBnmauP/5THIa8QadvCLpheJ+kO
 s4FUoqFIVMGIjleNiZuTDey6PbDnafEU8G90APnJ5LRRsUsBLfxnmTVoiF8C5ECzH4ui
 oKC87BTZAG4VmuqEMjlU7OCXmN3guGtLi47OPHOBFcr2ycxUtyCvPnyQBS1BL++ySScG
 nXjYp6M2OZlglt5JzWR22mfGqXsIiMqoRAcihjC6hABqiAzzUJAteVT/kbiB4DAiAo6k
 AU0aKjDZqPtlVRW/4ZuET8DGUFX6C0zWWoiY3yHLHE2/jv9iaOTmWwqJaIJaQrxaelb4
 IfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A5sxLz+tNpE8Kznf1HDDIft0dj+bOx31RoGXK7ytj2I=;
 b=SLvxyiJfWdHBKj0MAGDO0tH+K9FSnBKaTDRtwABJDEzDC6MfyZ26GcrNhLz/l3xyWU
 TesPl8xBBz1LSoubd1vjQnZF6Q8IutMmHWIEqNhWXq0L3eHTe06z7KUIBQ0yVMTdRWtY
 8VtqrzPZ/nnHGIRARuQr5sSUyr+Y6utr6CVgp39aOpygAgKJLY+qlmz413duYwuzJnrt
 fhLsAxhQbH1HmfyZ3ysxv4KIC7FECDnuH8bMovhcOJtyQkNekR8R19ub5neLvPsM1wCh
 dU8abtjC1k9xwFbu50QWn8axDdbiuYsnG58SY4GSblnus8pMQNaHshE/jlgDt2jYNyY6
 X+wQ==
X-Gm-Message-State: AJIora/RV9hY2JixY39qWmJAISBbASh9RyU+1jLsbJitHRtn2lLy+zj1
 ljaoyRkMczAeF1qWQeOsnZjchSzq+Lf3NLGZniI=
X-Google-Smtp-Source: AGRyM1uWSdxJwEpJMasxJ9iDOZGtDlKAGeBMg5ugKAREQRji2lN9xrapimNYZ16CJaLI5d3RWjTI1eNJi3e8+H6vnK0=
X-Received: by 2002:a05:6402:2933:b0:435:80dd:f75c with SMTP id
 ee51-20020a056402293300b0043580ddf75cmr23369410edb.302.1656426797773; Tue, 28
 Jun 2022 07:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220622144756.1890683-1-alexander.deucher@amd.com>
In-Reply-To: <20220622144756.1890683-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Jun 2022 10:33:04 -0400
Message-ID: <CADnq5_MtoW4+UAJ8n8A9owuR5F4NwQV3drpKqz1w1My=MwVV-A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: reduce stack size in
 dml32_ModeSupportAndSystemConfigurationFull()
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

Alex

On Wed, Jun 22, 2022 at 10:48 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Move more stack variable in to dummy vars structure on the heap.
>
> Fixes stack frame size errors:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: In function 'dml32_ModeSupportAndSystemConfigurationFull':
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:3833:1: error: the frame size of 2720 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
>  3833 | } // ModeSupportAndSystemConfigurationFull
>       | ^
>
> Fixes: dda4fb85e433 ("drm/amd/display: DML changes for DCN32/321")
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../dc/dml/dcn32/display_mode_vba_32.c        | 77 ++++++++-----------
>  .../drm/amd/display/dc/dml/display_mode_vba.h |  3 +-
>  2 files changed, 36 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> index 510b7a81ee12..7f144adb1e36 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> @@ -1660,8 +1660,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>
>  void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
>  {
> -       bool dummy_boolean[2];
> -       unsigned int dummy_integer[1];
> +       unsigned int dummy_integer[4];
>         bool MPCCombineMethodAsNeededForPStateChangeAndVoltage;
>         bool MPCCombineMethodAsPossible;
>         enum odm_combine_mode dummy_odm_mode[DC__NUM_DPP__MAX];
> @@ -1973,10 +1972,10 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>                         v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[5], /* Long            DETBufferSizeInKByte[]  */
>                         v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[6], /* Long            DETBufferSizeY[]  */
>                         v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[7], /* Long            DETBufferSizeC[]  */
> -                       &dummy_boolean[0], /* bool           *UnboundedRequestEnabled  */
> -                       &dummy_integer[0], /* Long           *CompressedBufferSizeInkByte  */
> +                       &v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[0][0], /* bool           *UnboundedRequestEnabled  */
> +                       &v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[0][0], /* Long           *CompressedBufferSizeInkByte  */
>                         mode_lib->vba.SingleDPPViewportSizeSupportPerSurface,/* bool ViewportSizeSupportPerSurface[] */
> -                       &dummy_boolean[1]); /* bool           *ViewportSizeSupport */
> +                       &v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[1][0]); /* bool           *ViewportSizeSupport */
>
>         MPCCombineMethodAsNeededForPStateChangeAndVoltage = false;
>         MPCCombineMethodAsPossible = false;
> @@ -2506,7 +2505,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>         //
>         for (i = 0; i < (int) v->soc.num_states; ++i) {
>                 for (j = 0; j <= 1; ++j) {
> -                       bool dummy_boolean_array[1][DC__NUM_DPP__MAX];
>                         for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
>                                 mode_lib->vba.RequiredDPPCLKThisState[k] = mode_lib->vba.RequiredDPPCLK[i][j][k];
>                                 mode_lib->vba.NoOfDPPThisState[k] = mode_lib->vba.NoOfDPP[i][j][k];
> @@ -2570,7 +2568,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>                                         mode_lib->vba.DETBufferSizeCThisState,
>                                         &mode_lib->vba.UnboundedRequestEnabledThisState,
>                                         &mode_lib->vba.CompressedBufferSizeInkByteThisState,
> -                                       dummy_boolean_array[0],
> +                                       v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[0],
>                                         &mode_lib->vba.ViewportSizeSupport[i][j]);
>
>                         for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
> @@ -2708,9 +2706,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>                         }
>
>                         {
> -                               bool dummy_boolean_array[2][DC__NUM_DPP__MAX];
> -                               unsigned int dummy_integer_array[22][DC__NUM_DPP__MAX];
> -
>                                 dml32_CalculateVMRowAndSwath(
>                                                 mode_lib->vba.NumberOfActiveSurfaces,
>                                                 v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters,
> @@ -2733,32 +2728,32 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>                                                 /* Output */
>                                                 mode_lib->vba.PTEBufferSizeNotExceededPerState,
>                                                 mode_lib->vba.DCCMetaBufferSizeNotExceededPerState,
> -                                               dummy_integer_array[0],
> -                                               dummy_integer_array[1],
> +                                               v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[0],
> +                                               v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[1],
>                                                 mode_lib->vba.dpte_row_height,
>                                                 mode_lib->vba.dpte_row_height_chroma,
> -                                               dummy_integer_array[2],
> -                                               dummy_integer_array[3],
> -                                               dummy_integer_array[4],
> -                                               dummy_integer_array[5],
> -                                               dummy_integer_array[6],
> -                                               dummy_integer_array[7],
> -                                               dummy_integer_array[8],
> -                                               dummy_integer_array[9],
> +                                               v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[2],
> +                                               v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[3],
> +                                               v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[4],
> +                                               v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[5],
> +                                               v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[6],
> +                                               v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[7],
> +                                               v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[8],
> +                                               v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[9],
>                                                 mode_lib->vba.meta_row_height,
>                                                 mode_lib->vba.meta_row_height_chroma,
> -                                               dummy_integer_array[10],
> +                                               v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[10],
>                                                 mode_lib->vba.dpte_group_bytes,
> -                                               dummy_integer_array[11],
> -                                               dummy_integer_array[12],
> -                                               dummy_integer_array[13],
> -                                               dummy_integer_array[14],
> -                                               dummy_integer_array[15],
> -                                               dummy_integer_array[16],
> -                                               dummy_integer_array[17],
> -                                               dummy_integer_array[18],
> -                                               dummy_integer_array[19],
> -                                               dummy_integer_array[20],
> +                                               v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[11],
> +                                               v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[12],
> +                                               v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[13],
> +                                               v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[14],
> +                                               v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[15],
> +                                               v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[16],
> +                                               v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[17],
> +                                               v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[18],
> +                                               v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[19],
> +                                               v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[20],
>                                                 mode_lib->vba.PrefetchLinesYThisState,
>                                                 mode_lib->vba.PrefetchLinesCThisState,
>                                                 mode_lib->vba.PrefillY,
> @@ -2772,9 +2767,9 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>                                                 mode_lib->vba.MetaRowBytesThisState,
>                                                 mode_lib->vba.use_one_row_for_frame_this_state,
>                                                 mode_lib->vba.use_one_row_for_frame_flip_this_state,
> -                                               dummy_boolean_array[0], // Boolean UsesMALLForStaticScreen[]
> -                                               dummy_boolean_array[1], // Boolean PTE_BUFFER_MODE[]
> -                                               dummy_integer_array[21]); // Long BIGK_FRAGMENT_SIZE[]
> +                                               v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[0], // Boolean UsesMALLForStaticScreen[]
> +                                               v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[1], // Boolean PTE_BUFFER_MODE[]
> +                                               v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[21]); // Long BIGK_FRAGMENT_SIZE[]
>                         }
>
>                         for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
> @@ -3197,7 +3192,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>
>                                 for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
>                                         DmlPipe myPipe;
> -                                       unsigned int dummy_integer;
>
>                                         mode_lib->vba.TWait = dml32_CalculateTWait(
>                                                         mode_lib->vba.PrefetchModePerState[i][j],
> @@ -3294,7 +3288,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>                                                         &v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[0],         // double *Tdmdl_vm
>                                                         &v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[1],         // double *Tdmdl
>                                                         &v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[2],         // double *TSetup
> -                                                       &dummy_integer,                                                                     // unsigned int   *VUpdateOffsetPix
> +                                                       &dummy_integer[0],                                                                  // unsigned int   *VUpdateOffsetPix
>                                                         &v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[3],         // unsigned int   *VUpdateWidthPix
>                                                         &v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[4]);        // unsigned int   *VReadyOffsetPix
>                                 }
> @@ -3323,7 +3317,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>                                 }
>
>                                 {
> -                                       double dummy_single[2];
>                                         dml32_CalculatePrefetchBandwithSupport(
>                                                         mode_lib->vba.NumberOfActiveSurfaces,
>                                                         mode_lib->vba.ReturnBWPerState[i][j],
> @@ -3346,8 +3339,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>                                                         mode_lib->vba.UrgentBurstFactorCursorPre,
>
>                                                         /* output */
> -                                                       &dummy_single[0],   // Single  *PrefetchBandwidth
> -                                                       &dummy_single[1],   // Single  *FractionOfUrgentBandwidth
> +                                                       &v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[0],   // Single  *PrefetchBandwidth
> +                                                       &v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[1],   // Single  *FractionOfUrgentBandwidth
>                                                         &mode_lib->vba.PrefetchSupported[i][j]);
>                                 }
>
> @@ -3457,7 +3450,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>                                         }
>
>                                         {
> -                                               double dummy_single[2];
>                                                 dml32_CalculateImmediateFlipBandwithSupport(mode_lib->vba.NumberOfActiveSurfaces,
>                                                                 mode_lib->vba.ReturnBWPerState[i][j],
>                                                                 mode_lib->vba.ImmediateFlipRequirement,
> @@ -3480,8 +3472,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>                                                                 mode_lib->vba.UrgentBurstFactorCursorPre,
>
>                                                                 /* output */
> -                                                               &dummy_single[0], //  Single  *TotalBandwidth
> -                                                               &dummy_single[1], //  Single  *FractionOfUrgentBandwidth
> +                                                               &v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[0], //  Single  *TotalBandwidth
> +                                                               &v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[1], //  Single  *FractionOfUrgentBandwidth
>                                                                 &mode_lib->vba.ImmediateFlipSupportedForState[i][j]); // Boolean *ImmediateFlipBandwidthSupport
>                                         }
>
> @@ -3534,7 +3526,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>                         v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.mSOCParameters.SMNLatency = mode_lib->vba.SMNLatency;
>
>                         {
> -                               unsigned int dummy_integer[4];
>                                 dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
>                                                 mode_lib->vba.USRRetrainingRequiredFinal,
>                                                 mode_lib->vba.UsesMALLForPStateChange,
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> index 9ad49ad38814..10ff536ef2a4 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> @@ -196,7 +196,7 @@ struct DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCal
>  };
>
>  struct dml32_ModeSupportAndSystemConfigurationFull {
> -       unsigned int dummy_integer_array[8][DC__NUM_DPP__MAX];
> +       unsigned int dummy_integer_array[22][DC__NUM_DPP__MAX];
>         double dummy_double_array[2][DC__NUM_DPP__MAX];
>         DmlPipe SurfParameters[DC__NUM_DPP__MAX];
>         double dummy_single[5];
> @@ -207,6 +207,7 @@ struct dml32_ModeSupportAndSystemConfigurationFull {
>         double DSTYAfterScaler[DC__NUM_DPP__MAX];
>         double DSTXAfterScaler[DC__NUM_DPP__MAX];
>         double MaxTotalVActiveRDBandwidth;
> +       bool dummy_boolean_array[2][DC__NUM_DPP__MAX];
>  };
>
>  struct dummy_vars {
> --
> 2.35.3
>
