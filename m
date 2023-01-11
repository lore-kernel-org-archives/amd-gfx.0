Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AB1C46467
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jan 2023 14:21:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34A3E10E74A;
	Wed, 11 Jan 2023 14:21:02 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4E5B10E74A
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jan 2023 14:20:59 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-15eaa587226so982727fac.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jan 2023 06:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=go7aaELgD7WrkzwIy65SscdJ/YB3zfRk9jfnuqfJTcA=;
 b=keaCHcleRhYp7nCdah4kgmTeohQa2u2YxzctRdkXmGsrTmTyzzASoN9RDTCWs0woK8
 9lpVwJyb/bnlhHpPGG51PvpyaIPPbxLRKbj5nth5gvFJsbArVyvi6Lg5rEutAzE97r4p
 J2NbQrDKeEzBdlQjcDPKd9DGWVOskXpJn/xLetvL8pNt45ktBJgPvBz1ocIlfZvNeUn6
 gGHxV3avPCEEdFTn6V3CPPgNaodeG3S0Setc+b6GfKKaxuOY7+LXQFUThoeubzGTQedj
 FjlzHyz7k/BBWPIfaIvJmk7LLGbLSStZ0P3h6EKK2XJy9qotGs14STWn6uIC25Hp/5m6
 6K8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=go7aaELgD7WrkzwIy65SscdJ/YB3zfRk9jfnuqfJTcA=;
 b=JKvYh50CrD9BzCyndsrkMSWfMUkZZbgzelLQbKnYHoLSUgKAryofFwvORKBNQzgOht
 M4TBpcFh2naWW4Y5jbh4U3X5Y01j6nYl64TCr/dmP8xcXLy9onhF/898v3p3niR8NWBS
 jhxqmj6zOqP8wX81lgVwNuSVvdL3NMywCOuF7izQ7wLQfkwPcMn7I8Nmk/B2LKIM+00y
 H6++KgEJ1naBCjklh2uEK0gCBgkCEYd2hUDmDd8NycWU+yXZY0k4PXw/fdrKbkDHKLb8
 WRGN/YJekaqGVrcikBDcnsJgidwOKtkQBPRHPeUolqeOKc2dQYOGobHJAzWPWJDR2ONy
 zLVQ==
X-Gm-Message-State: AFqh2kpQb+U1DyKy1UyikC7SEMhLvifaX4KX7y03Ps7j0m0hDAiiKi31
 wB2alVklsXxRtx/YOZJMdUDQNZjfCApg4eDhMAw=
X-Google-Smtp-Source: AMrXdXu8MYZzLEExoAS6gWgEZ9xIf+QchJe39KhueOPVH4muUbsA0IDWzcZx/l48xr67YCL1J3EfHg7MIf7SGqKqft0=
X-Received: by 2002:a05:6870:c59c:b0:150:d9aa:4011 with SMTP id
 ba28-20020a056870c59c00b00150d9aa4011mr2534447oab.96.1673446859100; Wed, 11
 Jan 2023 06:20:59 -0800 (PST)
MIME-Version: 1.0
References: <20230110154325.3350916-1-Rodrigo.Siqueira@amd.com>
 <20230110154325.3350916-2-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230110154325.3350916-2-Rodrigo.Siqueira@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Jan 2023 09:20:47 -0500
Message-ID: <CADnq5_MfiJ-rhmAWfMQfHHenHx3-2WiaALWw1sgEZiJ431x2wQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] drm/amd/display: Introduce UseMinimumDCFCLK_vars to
 reduce stack size in DML
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
Cc: Leo Li <sunpeng.li@amd.com>, Roman Li <roman.li@amd.com>,
 amd-gfx@lists.freedesktop.org, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 10, 2023 at 10:44 AM Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com> wrote:
>
> It was reported that on kernel v6.2-rc1, we have the following stack
> size issue:
>
> make[3]: *** [/kisskb/src/scripts/Makefile.build:504: drivers/media]
> Error 2
> [...]/display/dc/dml/dcn31/display_mode_vba_31.c: In function
> 'UseMinimumDCFCLK':
> [...]/display/dc/dml/dcn31/display_mode_vba_31.c:7082:1: error: the
> frame size of 2224 bytes is larger than 2048 bytes
> [-Werror=frame-larger-than=]
>
> This commit introduces a new struct that will accommodate some internal
> variables under the UseMinimumDCFCLK function. This change is the first
> of a series of patches that gradually move each of the arrays of double
> to the new struct to reduce the stack size for DCN31 and DCN314.
>
> Cc: Alex Deucher <alexdeucher@gmail.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Link: https://lore.kernel.org/all/20221227082932.798359-1-geert@linux-m68k.org/
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c | 7 +++----
>  drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h      | 5 +++++
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
> index ec351c8418cb..00d3c57f0d98 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
> @@ -6928,7 +6928,6 @@ static void UseMinimumDCFCLK(
>         struct vba_vars_st *v = &mode_lib->vba;
>         int dummy1, i, j, k;
>         double NormalEfficiency,  dummy2, dummy3;
> -       double TotalMaxPrefetchFlipDPTERowBandwidth[DC__VOLTAGE_STATES][2];
>
>         NormalEfficiency = v->PercentOfIdealFabricAndSDPPortBWReceivedAfterUrgLatency / 100.0;
>         for (i = 0; i < v->soc.num_states; ++i) {
> @@ -6947,9 +6946,9 @@ static void UseMinimumDCFCLK(
>                         int NoOfDPPState[DC__NUM_DPP__MAX];
>                         double MinimumTvmPlus2Tr0;
>
> -                       TotalMaxPrefetchFlipDPTERowBandwidth[i][j] = 0;
> +                       v->UseMinimumDCFCLK_stack_reduction.TotalMaxPrefetchFlipDPTERowBandwidth[i][j] = 0;
>                         for (k = 0; k < v->NumberOfActivePlanes; ++k) {
> -                               TotalMaxPrefetchFlipDPTERowBandwidth[i][j] = TotalMaxPrefetchFlipDPTERowBandwidth[i][j]
> +                               v->UseMinimumDCFCLK_stack_reduction.TotalMaxPrefetchFlipDPTERowBandwidth[i][j] = v->UseMinimumDCFCLK_stack_reduction.TotalMaxPrefetchFlipDPTERowBandwidth[i][j]
>                                                 + v->NoOfDPP[i][j][k] * v->DPTEBytesPerRow[i][j][k] / (15.75 * v->HTotal[k] / v->PixelClock[k]);
>                         }
>
> @@ -6960,7 +6959,7 @@ static void UseMinimumDCFCLK(
>                         MinimumTWait = CalculateTWait(MaxPrefetchMode, v->FinalDRAMClockChangeLatency, v->UrgLatency[i], v->SREnterPlusExitTime);
>                         NonDPTEBandwidth = v->TotalVActivePixelBandwidth[i][j] + v->TotalVActiveCursorBandwidth[i][j] + v->TotalMetaRowBandwidth[i][j];
>                         DPTEBandwidth = (v->HostVMEnable == true || v->ImmediateFlipRequirement[0] == dm_immediate_flip_required) ?
> -                                       TotalMaxPrefetchFlipDPTERowBandwidth[i][j] : v->TotalDPTERowBandwidth[i][j];
> +                                       v->UseMinimumDCFCLK_stack_reduction.TotalMaxPrefetchFlipDPTERowBandwidth[i][j] : v->TotalDPTERowBandwidth[i][j];
>                         DCFCLKRequiredForAverageBandwidth = dml_max3(
>                                         v->ProjectedDCFCLKDeepSleep[i][j],
>                                         (NonDPTEBandwidth + v->TotalDPTERowBandwidth[i][j]) / v->ReturnBusWidth
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> index 81e53e67cd0b..660c22a19c8d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> @@ -249,6 +249,10 @@ struct dml32_ModeSupportAndSystemConfigurationFull {
>         bool dummy_boolean[2];
>  };
>
> +struct UseMinimumDCFCLK_vars {
> +       double TotalMaxPrefetchFlipDPTERowBandwidth[DC__VOLTAGE_STATES][2];
> +};
> +
>  struct dummy_vars {
>         struct DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation
>         DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation;
> @@ -1236,6 +1240,7 @@ struct vba_vars_st {
>         bool VActiveBandwithSupport[DC__VOLTAGE_STATES][2];
>         bool NotEnoughDETSwathFillLatencyHidingPerState[DC__VOLTAGE_STATES][2];
>         struct dummy_vars dummy_vars;
> +       struct UseMinimumDCFCLK_vars UseMinimumDCFCLK_stack_reduction;
>  };
>
>  bool CalculateMinAndMaxPrefetchMode(
> --
> 2.39.0
>
