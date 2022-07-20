Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE1BC43334
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jul 2022 15:02:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6A2314BC1A;
	Wed, 20 Jul 2022 15:02:06 +0000 (UTC)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B688814BC03
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jul 2022 15:02:05 +0000 (UTC)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx0.riseup.net (Postfix) with ESMTPS id 4LnzSY1ZTtz9tFf;
 Wed, 20 Jul 2022 15:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1658329325; bh=yT/3fe66RTgvXqv+MZ67czg94/nc91180EEIr4zPq8w=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HHKUWiBY3KGcWTlARe2JYNT0GrQw7KgaRM7YgQ8Dr1CuPmCq5BY4gM5M0cFyB+85e
 HgCInJmm+A8aWvCNMwyyUx6ZT8eCKR364a3pX4lrm8iCin5ew4GZWrxf6vhIEElxXr
 uwPftkJJzQlH2qgB5q3hldDRG/6P50rqfU191jdE=
X-Riseup-User-ID: 6992442F797B76613BECF4A48D35B2E9CD0978C946B42E92860270CA772F525D
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews2.riseup.net (Postfix) with ESMTPSA id 4LnzSW19hQz1xph;
 Wed, 20 Jul 2022 15:02:02 +0000 (UTC)
Message-ID: <3beef32a-6a96-d6eb-1e4d-3eb7e15f39fe@riseup.net>
Date: Wed, 20 Jul 2022 12:01:59 -0300
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amd/display: reduce stack size in dcn32 dml
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220719211448.2873045-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20220719211448.2873045-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/19/22 18:14, Alex Deucher wrote:
> Move additional dummy structures off the stack and into
> the dummy vars structure.
> 
> Fixes the following:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: In function 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation':
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1659:1: error: the frame size of 2144 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
>  1659 | }
>       | ^
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: In function 'dml32_ModeSupportAndSystemConfigurationFull':
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:3799:1: error: the frame size of 2464 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
>  3799 | } // ModeSupportAndSystemConfigurationFull
>       | ^
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> ---

Reviewed-by: Maíra Canal <mairacanal@riseup.net>

I believe dcn20 could also receive the same treatment, as I'm still
getting a similar warning on display_mode_vba_20.c:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.c:1085:13:
warning: stack frame size (1356) exceeds limit (1024) in
'dml20_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation'
[-Wframe-larger-than]
static void
dml20_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation(
            ^
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.c:3286:6:
warning: stack frame size (1484) exceeds limit (1024) in
'dml20_ModeSupportAndSystemConfigurationFull' [-Wframe-larger-than]
void dml20_ModeSupportAndSystemConfigurationFull(struct display_mode_lib
*mode_lib)
     ^
2 warnings generated.

To reproduce it on clang-14, you can run:

make -skj"$(nproc)" LLVM=1 LLVM_IAS=1 i386_defconfig
scripts/config -e DRM_AMDGPU
make -skj"$(nproc)" LLVM=1 LLVM_IAS=1 olddefconfig
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.o

I believe it is also reproducible on GCC.

Best regards,
- Maíra Canal

>  .../dc/dml/dcn32/display_mode_vba_32.c        | 214 ++++++++----------
>  .../drm/amd/display/dc/dml/display_mode_vba.h |   3 +
>  2 files changed, 100 insertions(+), 117 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> index 349e36ae9333..441311cb9a86 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> @@ -67,6 +67,18 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>  	int iteration;
>  	double MaxTotalRDBandwidth;
>  	unsigned int NextPrefetchMode;
> +	double MaxTotalRDBandwidthNoUrgentBurst = 0.0;
> +	bool DestinationLineTimesForPrefetchLessThan2 = false;
> +	bool VRatioPrefetchMoreThanMax = false;
> +	double dummy_unit_vector[DC__NUM_DPP__MAX];
> +	double TWait;
> +	double dummy_single[2];
> +	bool dummy_boolean[1];
> +	enum clock_change_support dummy_dramchange_support;
> +	enum dm_fclock_change_support dummy_fclkchange_support;
> +	bool dummy_USRRetrainingSupport;
> +	double TotalWRBandwidth = 0;
> +	double WRBandwidth = 0;
>  
>  #ifdef __DML_VBA_DEBUG__
>  	dml_print("DML::%s: --- START ---\n", __func__);
> @@ -702,11 +714,6 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>  	NextPrefetchMode = mode_lib->vba.PrefetchModePerState[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb];
>  
>  	do {
> -		double MaxTotalRDBandwidthNoUrgentBurst = 0.0;
> -		bool DestinationLineTimesForPrefetchLessThan2 = false;
> -		bool VRatioPrefetchMoreThanMax = false;
> -		double dummy_unit_vector[DC__NUM_DPP__MAX];
> -
>  		MaxTotalRDBandwidth = 0;
>  #ifdef __DML_VBA_DEBUG__
>  		dml_print("DML::%s: Start loop: VStartup = %d\n", __func__, mode_lib->vba.VStartupLines);
> @@ -715,41 +722,39 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>  			/* NOTE PerfetchMode variable is invalid in DAL as per the input received.
>  			 * Hence the direction is to use PrefetchModePerState.
>  			 */
> -			double TWait = dml32_CalculateTWait(
> -					mode_lib->vba.PrefetchModePerState[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb],
> -					mode_lib->vba.UsesMALLForPStateChange[k],
> -					mode_lib->vba.SynchronizeDRRDisplaysForUCLKPStateChangeFinal,
> -					mode_lib->vba.DRRDisplay[k],
> -					mode_lib->vba.DRAMClockChangeLatency,
> -					mode_lib->vba.FCLKChangeLatency, v->UrgentLatency,
> -					mode_lib->vba.SREnterPlusExitTime);
> -
> -			DmlPipe myPipe;
> -
> -			myPipe.Dppclk = mode_lib->vba.DPPCLK[k];
> -			myPipe.Dispclk = mode_lib->vba.DISPCLK;
> -			myPipe.PixelClock = mode_lib->vba.PixelClock[k];
> -			myPipe.DCFClkDeepSleep = v->DCFCLKDeepSleep;
> -			myPipe.DPPPerSurface = mode_lib->vba.DPPPerPlane[k];
> -			myPipe.ScalerEnabled = mode_lib->vba.ScalerEnabled[k];
> -			myPipe.SourceRotation = mode_lib->vba.SourceRotation[k];
> -			myPipe.BlockWidth256BytesY = v->BlockWidth256BytesY[k];
> -			myPipe.BlockHeight256BytesY = v->BlockHeight256BytesY[k];
> -			myPipe.BlockWidth256BytesC = v->BlockWidth256BytesC[k];
> -			myPipe.BlockHeight256BytesC = v->BlockHeight256BytesC[k];
> -			myPipe.InterlaceEnable = mode_lib->vba.Interlace[k];
> -			myPipe.NumberOfCursors = mode_lib->vba.NumberOfCursors[k];
> -			myPipe.VBlank = mode_lib->vba.VTotal[k] - mode_lib->vba.VActive[k];
> -			myPipe.HTotal = mode_lib->vba.HTotal[k];
> -			myPipe.HActive = mode_lib->vba.HActive[k];
> -			myPipe.DCCEnable = mode_lib->vba.DCCEnable[k];
> -			myPipe.ODMMode = mode_lib->vba.ODMCombineEnabled[k];
> -			myPipe.SourcePixelFormat = mode_lib->vba.SourcePixelFormat[k];
> -			myPipe.BytePerPixelY = v->BytePerPixelY[k];
> -			myPipe.BytePerPixelC = v->BytePerPixelC[k];
> -			myPipe.ProgressiveToInterlaceUnitInOPP = mode_lib->vba.ProgressiveToInterlaceUnitInOPP;
> +			TWait = dml32_CalculateTWait(
> +				mode_lib->vba.PrefetchModePerState[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb],
> +				mode_lib->vba.UsesMALLForPStateChange[k],
> +				mode_lib->vba.SynchronizeDRRDisplaysForUCLKPStateChangeFinal,
> +				mode_lib->vba.DRRDisplay[k],
> +				mode_lib->vba.DRAMClockChangeLatency,
> +				mode_lib->vba.FCLKChangeLatency, v->UrgentLatency,
> +				mode_lib->vba.SREnterPlusExitTime);
> +
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.Dppclk = mode_lib->vba.DPPCLK[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.Dispclk = mode_lib->vba.DISPCLK;
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.PixelClock = mode_lib->vba.PixelClock[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.DCFClkDeepSleep = v->DCFCLKDeepSleep;
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.DPPPerSurface = mode_lib->vba.DPPPerPlane[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.ScalerEnabled = mode_lib->vba.ScalerEnabled[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.SourceRotation = mode_lib->vba.SourceRotation[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.BlockWidth256BytesY = v->BlockWidth256BytesY[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.BlockHeight256BytesY = v->BlockHeight256BytesY[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.BlockWidth256BytesC = v->BlockWidth256BytesC[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.BlockHeight256BytesC = v->BlockHeight256BytesC[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.InterlaceEnable = mode_lib->vba.Interlace[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.NumberOfCursors = mode_lib->vba.NumberOfCursors[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.VBlank = mode_lib->vba.VTotal[k] - mode_lib->vba.VActive[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.HTotal = mode_lib->vba.HTotal[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.HActive = mode_lib->vba.HActive[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.DCCEnable = mode_lib->vba.DCCEnable[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.ODMMode = mode_lib->vba.ODMCombineEnabled[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.SourcePixelFormat = mode_lib->vba.SourcePixelFormat[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.BytePerPixelY = v->BytePerPixelY[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.BytePerPixelC = v->BytePerPixelC[k];
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe.ProgressiveToInterlaceUnitInOPP = mode_lib->vba.ProgressiveToInterlaceUnitInOPP;
>  			v->ErrorResult[k] = dml32_CalculatePrefetchSchedule(v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.HostVMInefficiencyFactor,
> -					&myPipe, v->DSCDelay[k],
> +					&v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.myPipe, v->DSCDelay[k],
>  					mode_lib->vba.DPPCLKDelaySubtotal + mode_lib->vba.DPPCLKDelayCNVCFormater,
>  					mode_lib->vba.DPPCLKDelaySCL,
>  					mode_lib->vba.DPPCLKDelaySCLLBOnly,
> @@ -898,8 +903,6 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>  #endif
>  
>  		{
> -			double dummy_single[1];
> -
>  			dml32_CalculatePrefetchBandwithSupport(
>  					mode_lib->vba.NumberOfActiveSurfaces,
>  					mode_lib->vba.ReturnBW,
> @@ -931,8 +934,6 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>  			dummy_unit_vector[k] = 1.0;
>  
>  		{
> -			double  dummy_single[1];
> -			bool dummy_boolean[1];
>  			dml32_CalculatePrefetchBandwithSupport(mode_lib->vba.NumberOfActiveSurfaces,
>  					mode_lib->vba.ReturnBW,
>  					v->NoUrgentLatencyHidingPre,
> @@ -1039,8 +1040,6 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>  			}
>  
>  			{
> -				double  dummy_single[2];
> -				bool dummy_boolean[1];
>  				dml32_CalculateImmediateFlipBandwithSupport(mode_lib->vba.NumberOfActiveSurfaces,
>  						mode_lib->vba.ReturnBW,
>  						mode_lib->vba.ImmediateFlipRequirement,
> @@ -1149,22 +1148,17 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>  
>  	//Watermarks and NB P-State/DRAM Clock Change Support
>  	{
> -		SOCParametersList mmSOCParameters;
> -		enum clock_change_support dummy_dramchange_support;
> -		enum dm_fclock_change_support dummy_fclkchange_support;
> -		bool dummy_USRRetrainingSupport;
> -
> -		mmSOCParameters.UrgentLatency = v->UrgentLatency;
> -		mmSOCParameters.ExtraLatency = v->UrgentExtraLatency;
> -		mmSOCParameters.WritebackLatency = mode_lib->vba.WritebackLatency;
> -		mmSOCParameters.DRAMClockChangeLatency = mode_lib->vba.DRAMClockChangeLatency;
> -		mmSOCParameters.FCLKChangeLatency = mode_lib->vba.FCLKChangeLatency;
> -		mmSOCParameters.SRExitTime = mode_lib->vba.SRExitTime;
> -		mmSOCParameters.SREnterPlusExitTime = mode_lib->vba.SREnterPlusExitTime;
> -		mmSOCParameters.SRExitZ8Time = mode_lib->vba.SRExitZ8Time;
> -		mmSOCParameters.SREnterPlusExitZ8Time = mode_lib->vba.SREnterPlusExitZ8Time;
> -		mmSOCParameters.USRRetrainingLatency = mode_lib->vba.USRRetrainingLatency;
> -		mmSOCParameters.SMNLatency = mode_lib->vba.SMNLatency;
> +		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.UrgentLatency = v->UrgentLatency;
> +		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.ExtraLatency = v->UrgentExtraLatency;
> +		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.WritebackLatency = mode_lib->vba.WritebackLatency;
> +		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.DRAMClockChangeLatency = mode_lib->vba.DRAMClockChangeLatency;
> +		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.FCLKChangeLatency = mode_lib->vba.FCLKChangeLatency;
> +		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.SRExitTime = mode_lib->vba.SRExitTime;
> +		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.SREnterPlusExitTime = mode_lib->vba.SREnterPlusExitTime;
> +		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.SRExitZ8Time = mode_lib->vba.SRExitZ8Time;
> +		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.SREnterPlusExitZ8Time = mode_lib->vba.SREnterPlusExitZ8Time;
> +		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.USRRetrainingLatency = mode_lib->vba.USRRetrainingLatency;
> +		v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters.SMNLatency = mode_lib->vba.SMNLatency;
>  
>  		dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
>  			mode_lib->vba.USRRetrainingRequiredFinal,
> @@ -1182,7 +1176,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>  			v->dpte_group_bytes,
>  			v->meta_row_height,
>  			v->meta_row_height_chroma,
> -			mmSOCParameters,
> +			v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.mmSOCParameters,
>  			mode_lib->vba.WritebackChunkSize,
>  			mode_lib->vba.SOCCLK,
>  			v->DCFCLKDeepSleep,
> @@ -1486,9 +1480,6 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>  
>  	{
>  		//Maximum Bandwidth Used
> -		double TotalWRBandwidth = 0;
> -		double WRBandwidth = 0;
> -
>  		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
>  			if (mode_lib->vba.WritebackEnable[k] == true
>  					&& mode_lib->vba.WritebackPixelFormat[k] == dm_444_32) {
> @@ -1582,9 +1573,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>  
>  #ifdef __DML_VBA_ALLOW_DELTA__
>  	{
> -		double dummy_single[2];
>  		unsigned int dummy_integer[1];
> -		bool dummy_boolean[1];
>  
>  		// Calculate z8 stutter eff assuming 0 reserved space
>  		dml32_CalculateStutterEfficiency(v->CompressedBufferSizeInkByte,
> @@ -1669,20 +1658,33 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>  	unsigned int TotalNumberOfActiveDP2p0;
>  	unsigned int TotalNumberOfActiveDP2p0Outputs;
>  	unsigned int TotalDSCUnitsRequired;
> -	unsigned int m;
>  	unsigned int ReorderingBytes;
>  	bool FullFrameMALLPStateMethod;
>  	bool SubViewportMALLPStateMethod;
>  	bool PhantomPipeMALLPStateMethod;
>  	unsigned int MaximumMPCCombine;
> +	bool NoChroma;
> +	bool TotalAvailablePipesSupportNoDSC;
> +	unsigned int NumberOfDPPNoDSC;
> +	enum odm_combine_mode ODMModeNoDSC = dm_odm_combine_mode_disabled;
> +	double RequiredDISPCLKPerSurfaceNoDSC;
> +	bool TotalAvailablePipesSupportDSC;
> +	unsigned int NumberOfDPPDSC;
> +	enum odm_combine_mode ODMModeDSC = dm_odm_combine_mode_disabled;
> +	double RequiredDISPCLKPerSurfaceDSC;
> +	double BWOfNonCombinedSurfaceOfMaximumBandwidth = 0;
> +	unsigned int NumberOfNonCombinedSurfaceOfMaximumBandwidth = 0;
> +	unsigned int TotalSlots;
> +	double VMDataOnlyReturnBWPerState;
> +	double HostVMInefficiencyFactor;
> +	unsigned int NextPrefetchModeState;
> +	struct vba_vars_st *v = &mode_lib->vba;
> +	int i, j;
> +	unsigned int k, m;
>  
>  #ifdef __DML_VBA_DEBUG__
>  	dml_print("DML::%s: called\n", __func__);
>  #endif
> -	struct vba_vars_st *v = &mode_lib->vba;
> -
> -	int i, j;
> -	unsigned int k;
>  
>  	/*MODE SUPPORT, VOLTAGE STATE AND SOC CONFIGURATION*/
>  
> @@ -1991,21 +1993,10 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>  
>  	for (i = 0; i < v->soc.num_states; i++) {
>  		for (j = 0; j < 2; j++) {
> -			bool NoChroma;
>  			mode_lib->vba.TotalNumberOfActiveDPP[i][j] = 0;
>  			mode_lib->vba.TotalAvailablePipesSupport[i][j] = true;
>  
>  			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
> -
> -				bool TotalAvailablePipesSupportNoDSC;
> -				unsigned int NumberOfDPPNoDSC;
> -				enum odm_combine_mode ODMModeNoDSC = dm_odm_combine_mode_disabled;
> -				double RequiredDISPCLKPerSurfaceNoDSC;
> -				bool TotalAvailablePipesSupportDSC;
> -				unsigned int NumberOfDPPDSC;
> -				enum odm_combine_mode ODMModeDSC = dm_odm_combine_mode_disabled;
> -				double RequiredDISPCLKPerSurfaceDSC;
> -
>  				dml32_CalculateODMMode(
>  						mode_lib->vba.MaximumPixelsPerLinePerDSCUnit,
>  						mode_lib->vba.HActive[k],
> @@ -2147,8 +2138,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>  							mode_lib->vba.Output[0])) {
>  				while (!(mode_lib->vba.TotalNumberOfActiveDPP[i][j] >= mode_lib->vba.MaxNumDPP
>  						|| mode_lib->vba.TotalNumberOfSingleDPPSurfaces[i][j] == 0)) {
> -					double BWOfNonCombinedSurfaceOfMaximumBandwidth = 0;
> -					unsigned int NumberOfNonCombinedSurfaceOfMaximumBandwidth = 0;
>  
>  					for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
>  						if (mode_lib->vba.MPCCombineUse[k]
> @@ -2264,8 +2253,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>  	}
>  
>  	for (i = 0; i < v->soc.num_states; ++i) {
> -		unsigned int TotalSlots;
> -
>  		mode_lib->vba.ExceededMultistreamSlots[i] = false;
>  		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
>  			if (mode_lib->vba.OutputMultistreamEn[k] == true && mode_lib->vba.OutputMultistreamId[k] == k) {
> @@ -2474,8 +2461,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>  
>  	/*DSC Delay per state*/
>  	for (i = 0; i < v->soc.num_states; ++i) {
> -		unsigned int m;
> -
>  		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
>  			mode_lib->vba.DSCDelayPerState[i][k] = dml32_DSCDelayRequirement(
>  					mode_lib->vba.RequiresDSC[i][k], mode_lib->vba.ODMCombineEnablePerState[i][k],
> @@ -3120,9 +3105,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>  
>  	for (i = 0; i < (int) v->soc.num_states; ++i) {
>  		for (j = 0; j <= 1; ++j) {
> -			double VMDataOnlyReturnBWPerState;
> -			double HostVMInefficiencyFactor;
> -			unsigned int NextPrefetchModeState;
>  
>  			mode_lib->vba.TimeCalc = 24 / mode_lib->vba.ProjectedDCFCLKDeepSleep[i][j];
>  
> @@ -3191,8 +3173,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>  				mode_lib->vba.MaxVStartup = mode_lib->vba.NextMaxVStartup;
>  
>  				for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
> -					DmlPipe myPipe;
> -
>  					mode_lib->vba.TWait = dml32_CalculateTWait(
>  							mode_lib->vba.PrefetchModePerState[i][j],
>  							mode_lib->vba.UsesMALLForPStateChange[k],
> @@ -3202,34 +3182,34 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>  							mode_lib->vba.FCLKChangeLatency, mode_lib->vba.UrgLatency[i],
>  							mode_lib->vba.SREnterPlusExitTime);
>  
> -					myPipe.Dppclk = mode_lib->vba.RequiredDPPCLK[i][j][k];
> -					myPipe.Dispclk = mode_lib->vba.RequiredDISPCLK[i][j];
> -					myPipe.PixelClock = mode_lib->vba.PixelClock[k];
> -					myPipe.DCFClkDeepSleep = mode_lib->vba.ProjectedDCFCLKDeepSleep[i][j];
> -					myPipe.DPPPerSurface = mode_lib->vba.NoOfDPP[i][j][k];
> -					myPipe.ScalerEnabled = mode_lib->vba.ScalerEnabled[k];
> -					myPipe.SourceRotation = mode_lib->vba.SourceRotation[k];
> -					myPipe.BlockWidth256BytesY = mode_lib->vba.Read256BlockWidthY[k];
> -					myPipe.BlockHeight256BytesY = mode_lib->vba.Read256BlockHeightY[k];
> -					myPipe.BlockWidth256BytesC = mode_lib->vba.Read256BlockWidthC[k];
> -					myPipe.BlockHeight256BytesC = mode_lib->vba.Read256BlockHeightC[k];
> -					myPipe.InterlaceEnable = mode_lib->vba.Interlace[k];
> -					myPipe.NumberOfCursors = mode_lib->vba.NumberOfCursors[k];
> -					myPipe.VBlank = mode_lib->vba.VTotal[k] - mode_lib->vba.VActive[k];
> -					myPipe.HTotal = mode_lib->vba.HTotal[k];
> -					myPipe.HActive = mode_lib->vba.HActive[k];
> -					myPipe.DCCEnable = mode_lib->vba.DCCEnable[k];
> -					myPipe.ODMMode = mode_lib->vba.ODMCombineEnablePerState[i][k];
> -					myPipe.SourcePixelFormat = mode_lib->vba.SourcePixelFormat[k];
> -					myPipe.BytePerPixelY = mode_lib->vba.BytePerPixelY[k];
> -					myPipe.BytePerPixelC = mode_lib->vba.BytePerPixelC[k];
> -					myPipe.ProgressiveToInterlaceUnitInOPP =
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.Dppclk = mode_lib->vba.RequiredDPPCLK[i][j][k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.Dispclk = mode_lib->vba.RequiredDISPCLK[i][j];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.PixelClock = mode_lib->vba.PixelClock[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.DCFClkDeepSleep = mode_lib->vba.ProjectedDCFCLKDeepSleep[i][j];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.DPPPerSurface = mode_lib->vba.NoOfDPP[i][j][k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.ScalerEnabled = mode_lib->vba.ScalerEnabled[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.SourceRotation = mode_lib->vba.SourceRotation[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BlockWidth256BytesY = mode_lib->vba.Read256BlockWidthY[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BlockHeight256BytesY = mode_lib->vba.Read256BlockHeightY[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BlockWidth256BytesC = mode_lib->vba.Read256BlockWidthC[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BlockHeight256BytesC = mode_lib->vba.Read256BlockHeightC[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.InterlaceEnable = mode_lib->vba.Interlace[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.NumberOfCursors = mode_lib->vba.NumberOfCursors[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.VBlank = mode_lib->vba.VTotal[k] - mode_lib->vba.VActive[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.HTotal = mode_lib->vba.HTotal[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.HActive = mode_lib->vba.HActive[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.DCCEnable = mode_lib->vba.DCCEnable[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.ODMMode = mode_lib->vba.ODMCombineEnablePerState[i][k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.SourcePixelFormat = mode_lib->vba.SourcePixelFormat[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BytePerPixelY = mode_lib->vba.BytePerPixelY[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.BytePerPixelC = mode_lib->vba.BytePerPixelC[k];
> +					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe.ProgressiveToInterlaceUnitInOPP =
>  							mode_lib->vba.ProgressiveToInterlaceUnitInOPP;
>  
>  					mode_lib->vba.NoTimeForPrefetch[i][j][k] =
>  						dml32_CalculatePrefetchSchedule(
>  							HostVMInefficiencyFactor,
> -							&myPipe,
> +							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.myPipe,
>  							mode_lib->vba.DSCDelayPerState[i][k],
>  							mode_lib->vba.DPPCLKDelaySubtotal +
>  								mode_lib->vba.DPPCLKDelayCNVCFormater,
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> index 47b149d4bfcf..b3905a55772b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> @@ -197,6 +197,8 @@ struct DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCal
>  	unsigned int ReorderBytes;
>  	unsigned int VMDataOnlyReturnBW;
>  	double HostVMInefficiencyFactor;
> +	DmlPipe myPipe;
> +	SOCParametersList mmSOCParameters;
>  };
>  
>  struct dml32_ModeSupportAndSystemConfigurationFull {
> @@ -212,6 +214,7 @@ struct dml32_ModeSupportAndSystemConfigurationFull {
>  	double DSTXAfterScaler[DC__NUM_DPP__MAX];
>  	double MaxTotalVActiveRDBandwidth;
>  	bool dummy_boolean_array[2][DC__NUM_DPP__MAX];
> +	DmlPipe myPipe;
>  };
>  
>  struct dummy_vars {
