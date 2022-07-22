Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4B5C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 18:12:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD95190D16;
	Fri, 22 Jul 2022 18:12:58 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BC3D90D16
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 18:12:57 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id z23so9807081eju.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 11:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Kr6lmZ+0qu6MNhSvavYRGvGhew1Yuxk6N1MAOI17lgU=;
 b=gQ0NBOiqkDiYttJlVJTae3sI4g6KCQkiCOiOXnd2vxBYATNAR3BzOcUz0cO3SSscN7
 PsQp2s4L0zOND1ScsdZYDWeSjRT1l6ANMOO0BXAyjvwUETxMr6CzOmTxCs8Dsk0c2eJY
 oxFKN46QzmBt6w+p5hXIhiyjZYbAvypHGIlXjitpcnzvJCxCmpR3KkDJXJr+bS0veUsx
 hibXV+OT7M3p2Q1arpzNgCiIARGjvyMdLWHOC7aYMcwhJNaE+sLqqJW1nPAG94tYrVSM
 rieYeJ8sTslQfesiwqNlGlm7JRicEaPlOItwPzzAKdXwim6pBk5FDMcGs0G5vlJ8PFZS
 bSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Kr6lmZ+0qu6MNhSvavYRGvGhew1Yuxk6N1MAOI17lgU=;
 b=Gb01sxfZ1kKLujmeOj+HtPfoKsdjmlkJG6ZQ/ps6QUAx/VMyeEA4SxE75Xym9KeZ+u
 SaJITwfAOngVRS7SO7tr2TTdLrpcnInY/FdPaour1usNAUblxex2t/nlsSYzX9XG6Dzc
 V9Q7LTtL/1vEGfblg/xTvRcZAqxZm5RQ97XLBhTD5rRgcU9yPEa/Fwdo5We1bBeoQUys
 Ty75GFFWdAj/u2MJnvfRaSOHkLjW3Ajy6gQdETHxaBkukInt/lzEj6mH6Hj32mmU3x8U
 IapCaas3EgY+V5eVQL3sn/QH88eKDYxM6jsUkuBcs5V7zCoxuAIDI6CgYkVerQNgysFs
 vqjg==
X-Gm-Message-State: AJIora+3O8ZPNDsnvPCSlX+YQ6XIH6qHJBBE4CHSj2/lHarwuHtDo1Ko
 hGdOiW5Z/7pb1ikU3w458ZXpxYKNlw+odKoT7XDxRltG
X-Google-Smtp-Source: AGRyM1v5wu/oWPWsVhvmaGCYYNUw0ri0xrB/C5rlqdtEc2fweWoM12fyLxuIj/9BNOaQs/TTKWLlp2u6Wlsfq18fi8c=
X-Received: by 2002:a17:907:a427:b0:72b:8cc5:5487 with SMTP id
 sg39-20020a170907a42700b0072b8cc55487mr846178ejc.354.1658513575787; Fri, 22
 Jul 2022 11:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220722175617.2060949-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220722175617.2060949-1-Rodrigo.Siqueira@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 Jul 2022 14:12:44 -0400
Message-ID: <CADnq5_MVQUK4cqD8mcOQTupfVR2c6siRyr87pb=BzRgvUG3sQw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Reduce stack size in the mode support
 function
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jul 22, 2022 at 1:56 PM Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com> wrote:
>
> When we use the allmodconfig option we see the following error:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: In function 'dml32_ModeSupportAndSystemConfigurationFull':
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:3799:1: error: the frame size of 2464 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
>   3799 | } // ModeSupportAndSystemConfigurationFull
>
> This commit fixes this issue by moving part of the mode support
> operation from ModeSupportAndSystemConfigurationFull to a dedicated
> function.
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Thanks for sorting this out!
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../dc/dml/dcn32/display_mode_vba_32.c        | 132 ++++++++++--------
>  1 file changed, 70 insertions(+), 62 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> index 573504de1789..465fd240b8fb 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> @@ -1654,6 +1654,75 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>  #endif
>  }
>
> +static void mode_support_configuration(struct vba_vars_st *v,
> +                                 struct display_mode_lib *mode_lib)
> +{
> +       int i, j;
> +
> +       for (i = v->soc.num_states - 1; i >= 0; i--) {
> +               for (j = 0; j < 2; j++) {
> +                       if (mode_lib->vba.ScaleRatioAndTapsSupport == true
> +                               && mode_lib->vba.SourceFormatPixelAndScanSupport == true
> +                               && mode_lib->vba.ViewportSizeSupport[i][j] == true
> +                               && !mode_lib->vba.LinkRateDoesNotMatchDPVersion
> +                               && !mode_lib->vba.LinkRateForMultistreamNotIndicated
> +                               && !mode_lib->vba.BPPForMultistreamNotIndicated
> +                               && !mode_lib->vba.MultistreamWithHDMIOreDP
> +                               && !mode_lib->vba.ExceededMultistreamSlots[i]
> +                               && !mode_lib->vba.MSOOrODMSplitWithNonDPLink
> +                               && !mode_lib->vba.NotEnoughLanesForMSO
> +                               && mode_lib->vba.LinkCapacitySupport[i] == true && !mode_lib->vba.P2IWith420
> +                               && !mode_lib->vba.DSCOnlyIfNecessaryWithBPP
> +                               && !mode_lib->vba.DSC422NativeNotSupported
> +                               && !mode_lib->vba.MPCCombineMethodIncompatible
> +                               && mode_lib->vba.ODMCombine2To1SupportCheckOK[i] == true
> +                               && mode_lib->vba.ODMCombine4To1SupportCheckOK[i] == true
> +                               && mode_lib->vba.NotEnoughDSCUnits[i] == false
> +                               && !mode_lib->vba.NotEnoughDSCSlices[i]
> +                               && !mode_lib->vba.ImmediateFlipOrHostVMAndPStateWithMALLFullFrameOrPhantomPipe
> +                               && !mode_lib->vba.InvalidCombinationOfMALLUseForPStateAndStaticScreen
> +                               && mode_lib->vba.DSCCLKRequiredMoreThanSupported[i] == false
> +                               && mode_lib->vba.PixelsPerLinePerDSCUnitSupport[i]
> +                               && mode_lib->vba.DTBCLKRequiredMoreThanSupported[i] == false
> +                               && !mode_lib->vba.InvalidCombinationOfMALLUseForPState
> +                               && !mode_lib->vba.ImmediateFlipRequiredButTheRequirementForEachSurfaceIsNotSpecified
> +                               && mode_lib->vba.ROBSupport[i][j] == true
> +                               && mode_lib->vba.DISPCLK_DPPCLK_Support[i][j] == true
> +                               && mode_lib->vba.TotalAvailablePipesSupport[i][j] == true
> +                               && mode_lib->vba.NumberOfOTGSupport == true
> +                               && mode_lib->vba.NumberOfHDMIFRLSupport == true
> +                               && mode_lib->vba.EnoughWritebackUnits == true
> +                               && mode_lib->vba.WritebackLatencySupport == true
> +                               && mode_lib->vba.WritebackScaleRatioAndTapsSupport == true
> +                               && mode_lib->vba.CursorSupport == true && mode_lib->vba.PitchSupport == true
> +                               && mode_lib->vba.ViewportExceedsSurface == false
> +                               && mode_lib->vba.PrefetchSupported[i][j] == true
> +                               && mode_lib->vba.VActiveBandwithSupport[i][j] == true
> +                               && mode_lib->vba.DynamicMetadataSupported[i][j] == true
> +                               && mode_lib->vba.TotalVerticalActiveBandwidthSupport[i][j] == true
> +                               && mode_lib->vba.VRatioInPrefetchSupported[i][j] == true
> +                               && mode_lib->vba.PTEBufferSizeNotExceeded[i][j] == true
> +                               && mode_lib->vba.DCCMetaBufferSizeNotExceeded[i][j] == true
> +                               && mode_lib->vba.NonsupportedDSCInputBPC == false
> +                               && !mode_lib->vba.ExceededMALLSize
> +                               && ((mode_lib->vba.HostVMEnable == false
> +                               && !mode_lib->vba.ImmediateFlipRequiredFinal)
> +                               || mode_lib->vba.ImmediateFlipSupportedForState[i][j])
> +                               && (!mode_lib->vba.DRAMClockChangeRequirementFinal
> +                               || i == v->soc.num_states - 1
> +                               || mode_lib->vba.DRAMClockChangeSupport[i][j] != dm_dram_clock_change_unsupported)
> +                               && (!mode_lib->vba.FCLKChangeRequirementFinal || i == v->soc.num_states - 1
> +                               || mode_lib->vba.FCLKChangeSupport[i][j] != dm_fclock_change_unsupported)
> +                               && (!mode_lib->vba.USRRetrainingRequiredFinal
> +                               || &mode_lib->vba.USRRetrainingSupport[i][j])) {
> +                               mode_lib->vba.ModeSupport[i][j] = true;
> +                       } else {
> +                               mode_lib->vba.ModeSupport[i][j] = false;
> +                       }
> +               }
> +       }
> +}
> +
>  void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
>  {
>         struct vba_vars_st *v = &mode_lib->vba;
> @@ -3632,68 +3701,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>         }
>
>         /*Mode Support, Voltage State and SOC Configuration*/
> -       for (i = v->soc.num_states - 1; i >= 0; i--) {
> -               for (j = 0; j < 2; j++) {
> -                       if (mode_lib->vba.ScaleRatioAndTapsSupport == true
> -                               && mode_lib->vba.SourceFormatPixelAndScanSupport == true
> -                               && mode_lib->vba.ViewportSizeSupport[i][j] == true
> -                               && !mode_lib->vba.LinkRateDoesNotMatchDPVersion
> -                               && !mode_lib->vba.LinkRateForMultistreamNotIndicated
> -                               && !mode_lib->vba.BPPForMultistreamNotIndicated
> -                               && !mode_lib->vba.MultistreamWithHDMIOreDP
> -                               && !mode_lib->vba.ExceededMultistreamSlots[i]
> -                               && !mode_lib->vba.MSOOrODMSplitWithNonDPLink
> -                               && !mode_lib->vba.NotEnoughLanesForMSO
> -                               && mode_lib->vba.LinkCapacitySupport[i] == true && !mode_lib->vba.P2IWith420
> -                               && !mode_lib->vba.DSCOnlyIfNecessaryWithBPP
> -                               && !mode_lib->vba.DSC422NativeNotSupported
> -                               && !mode_lib->vba.MPCCombineMethodIncompatible
> -                               && mode_lib->vba.ODMCombine2To1SupportCheckOK[i] == true
> -                               && mode_lib->vba.ODMCombine4To1SupportCheckOK[i] == true
> -                               && mode_lib->vba.NotEnoughDSCUnits[i] == false
> -                               && !mode_lib->vba.NotEnoughDSCSlices[i]
> -                               && !mode_lib->vba.ImmediateFlipOrHostVMAndPStateWithMALLFullFrameOrPhantomPipe
> -                               && !mode_lib->vba.InvalidCombinationOfMALLUseForPStateAndStaticScreen
> -                               && mode_lib->vba.DSCCLKRequiredMoreThanSupported[i] == false
> -                               && mode_lib->vba.PixelsPerLinePerDSCUnitSupport[i]
> -                               && mode_lib->vba.DTBCLKRequiredMoreThanSupported[i] == false
> -                               && !mode_lib->vba.InvalidCombinationOfMALLUseForPState
> -                               && !mode_lib->vba.ImmediateFlipRequiredButTheRequirementForEachSurfaceIsNotSpecified
> -                               && mode_lib->vba.ROBSupport[i][j] == true
> -                               && mode_lib->vba.DISPCLK_DPPCLK_Support[i][j] == true
> -                               && mode_lib->vba.TotalAvailablePipesSupport[i][j] == true
> -                               && mode_lib->vba.NumberOfOTGSupport == true
> -                               && mode_lib->vba.NumberOfHDMIFRLSupport == true
> -                               && mode_lib->vba.EnoughWritebackUnits == true
> -                               && mode_lib->vba.WritebackLatencySupport == true
> -                               && mode_lib->vba.WritebackScaleRatioAndTapsSupport == true
> -                               && mode_lib->vba.CursorSupport == true && mode_lib->vba.PitchSupport == true
> -                               && mode_lib->vba.ViewportExceedsSurface == false
> -                               && mode_lib->vba.PrefetchSupported[i][j] == true
> -                               && mode_lib->vba.VActiveBandwithSupport[i][j] == true
> -                               && mode_lib->vba.DynamicMetadataSupported[i][j] == true
> -                               && mode_lib->vba.TotalVerticalActiveBandwidthSupport[i][j] == true
> -                               && mode_lib->vba.VRatioInPrefetchSupported[i][j] == true
> -                               && mode_lib->vba.PTEBufferSizeNotExceeded[i][j] == true
> -                               && mode_lib->vba.DCCMetaBufferSizeNotExceeded[i][j] == true
> -                               && mode_lib->vba.NonsupportedDSCInputBPC == false
> -                               && !mode_lib->vba.ExceededMALLSize
> -                               && ((mode_lib->vba.HostVMEnable == false
> -                               && !mode_lib->vba.ImmediateFlipRequiredFinal)
> -                               || mode_lib->vba.ImmediateFlipSupportedForState[i][j])
> -                               && (!mode_lib->vba.DRAMClockChangeRequirementFinal
> -                               || i == v->soc.num_states - 1
> -                               || mode_lib->vba.DRAMClockChangeSupport[i][j] != dm_dram_clock_change_unsupported)
> -                               && (!mode_lib->vba.FCLKChangeRequirementFinal || i == v->soc.num_states - 1
> -                               || mode_lib->vba.FCLKChangeSupport[i][j] != dm_fclock_change_unsupported)
> -                               && (!mode_lib->vba.USRRetrainingRequiredFinal
> -                               || &mode_lib->vba.USRRetrainingSupport[i][j])) {
> -                               mode_lib->vba.ModeSupport[i][j] = true;
> -                       } else {
> -                               mode_lib->vba.ModeSupport[i][j] = false;
> -                       }
> -               }
> -       }
> +       mode_support_configuration(v, mode_lib);
>
>         MaximumMPCCombine = 0;
>
> --
> 2.35.1
>
