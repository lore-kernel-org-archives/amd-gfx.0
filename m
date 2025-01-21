Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC25AC0218B
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 13:57:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F93C10E5C4;
	Tue, 21 Jan 2025 13:57:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VHFIkLVp";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C4010E5B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 13:57:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id EFC0E5C589E;
 Tue, 21 Jan 2025 13:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2D1C4CEE4;
 Tue, 21 Jan 2025 13:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737467863;
 bh=63qJRsBiuzE3eTJdHGQn5IRaLaKePNrKg14sMbsAOPk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VHFIkLVpguqVL4Bul8Hb0DQg6cvAI3tbLUX4VHrFzXqGWBzJTaWwGQm6Z6+nFXWAN
 PRu632m7DSyJ4avnAPiH/mlomwQUG48MQ2RMsK7t2g6PUofbwQuujA+EHv6hvNhWz6
 gREGO3le1NxaQTTdAYyPOnass0YWFVZBHt3fRuWYkrq/UV4K1gG66dW485au1UG6pr
 EEa3ZLa59eqJkpQ5ZxkKKLsLOHVdXWId04jph+FSzbu1RduFjW3md91sjsaw9/qY2u
 JdMcWseT/V9tVIsgYKwRyS8fo9d+U+mq1CbA2jE5E9fQR973pmeeHJwaZ74O4Cd25E
 Xdc9DhBmikLOg==
From: Mario Limonciello <superm1@kernel.org>
To: roman.li@amd.com,
	amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/4] drm/amd/display: Correct off by one errors in DML
Date: Tue, 21 Jan 2025 07:57:17 -0600
Message-ID: <20250121135719.2883833-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250121135719.2883833-1-superm1@kernel.org>
References: <20250121135719.2883833-1-superm1@kernel.org>
MIME-Version: 1.0
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mario Limonciello <mario.limonciello@amd.com>

Iterators of `NumberOfActiveSurfaces` start at zero but since the loops
have a condition of `<= NumberOfActiveSurfaces - 1`. This will mean that
the last surface isn't checked.

Adjust the condition to go all the way to `NumberOfActiveSurfaces`.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../dc/dml/dcn32/display_mode_vba_32.c        | 68 +++++++++----------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 0782a34689a00..a8f6f82a824d4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -1745,7 +1745,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	/*Scale Ratio, taps Support Check*/
 
 	mode_lib->vba.ScaleRatioAndTapsSupport = true;
-	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 		if (mode_lib->vba.ScalerEnabled[k] == false
 				&& ((mode_lib->vba.SourcePixelFormat[k] != dm_444_64
 						&& mode_lib->vba.SourcePixelFormat[k] != dm_444_32
@@ -1791,7 +1791,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 	/*Source Format, Pixel Format and Scan Support Check*/
 	mode_lib->vba.SourceFormatPixelAndScanSupport = true;
-	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 		if (mode_lib->vba.SurfaceTiling[k] == dm_sw_linear
 			&& (!(!IsVertical((enum dm_rotation_angle) mode_lib->vba.SourceScan[k]))
 				|| mode_lib->vba.DCCEnable[k] == true)) {
@@ -1799,7 +1799,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		}
 	}
 
-	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 		dml32_CalculateBytePerPixelAndBlockSizes(
 				mode_lib->vba.SourcePixelFormat[k],
 				mode_lib->vba.SurfaceTiling[k],
@@ -1820,7 +1820,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	}
 
 	/*Bandwidth Support Check*/
-	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 		if (!IsVertical(mode_lib->vba.SourceRotation[k])) {
 			v->SwathWidthYSingleDPP[k] = mode_lib->vba.ViewportWidth[k];
 			v->SwathWidthCSingleDPP[k] = mode_lib->vba.ViewportWidthChroma[k];
@@ -1829,14 +1829,14 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			v->SwathWidthCSingleDPP[k] = mode_lib->vba.ViewportHeightChroma[k];
 		}
 	}
-	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 		v->ReadBandwidthLuma[k] = v->SwathWidthYSingleDPP[k] * dml_ceil(v->BytePerPixelInDETY[k], 1.0)
 				/ (mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k]) * mode_lib->vba.VRatio[k];
 		v->ReadBandwidthChroma[k] = v->SwathWidthYSingleDPP[k] / 2 * dml_ceil(v->BytePerPixelInDETC[k], 2.0)
 				/ (mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k]) * mode_lib->vba.VRatio[k]
 				/ 2.0;
 	}
-	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 		if (mode_lib->vba.WritebackEnable[k] == true && mode_lib->vba.WritebackPixelFormat[k] == dm_444_64) {
 			v->WriteBandwidth[k] = mode_lib->vba.WritebackDestinationWidth[k]
 					* mode_lib->vba.WritebackDestinationHeight[k]
@@ -1855,7 +1855,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	/*Writeback Latency support check*/
 
 	mode_lib->vba.WritebackLatencySupport = true;
-	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 		if (mode_lib->vba.WritebackEnable[k] == true
 				&& (v->WriteBandwidth[k]
 						> mode_lib->vba.WritebackInterfaceBufferSize * 1024
@@ -1867,7 +1867,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	/*Writeback Mode Support Check*/
 	mode_lib->vba.EnoughWritebackUnits = true;
 	mode_lib->vba.TotalNumberOfActiveWriteback = 0;
-	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 		if (mode_lib->vba.WritebackEnable[k] == true)
 			mode_lib->vba.TotalNumberOfActiveWriteback = mode_lib->vba.TotalNumberOfActiveWriteback + 1;
 	}
@@ -1877,7 +1877,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 	/*Writeback Scale Ratio and Taps Support Check*/
 	mode_lib->vba.WritebackScaleRatioAndTapsSupport = true;
-	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 		if (mode_lib->vba.WritebackEnable[k] == true) {
 			if (mode_lib->vba.WritebackHRatio[k] > mode_lib->vba.WritebackMaxHSCLRatio
 					|| mode_lib->vba.WritebackVRatio[k] > mode_lib->vba.WritebackMaxVSCLRatio
@@ -1898,7 +1898,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		}
 	}
 
-	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 		dml32_CalculateSinglePipeDPPCLKAndSCLThroughput(mode_lib->vba.HRatio[k], mode_lib->vba.HRatioChroma[k],
 				mode_lib->vba.VRatio[k], mode_lib->vba.VRatioChroma[k],
 				mode_lib->vba.MaxDCHUBToPSCLThroughput, mode_lib->vba.MaxPSCLToLBThroughput,
@@ -1910,7 +1910,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				&mode_lib->vba.MinDPPCLKUsingSingleDPP[k]);
 	}
 
-	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 
 		if (mode_lib->vba.SurfaceTiling[k] == dm_sw_linear) {
 			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaximumSwathWidthSupportLuma = 8192;
@@ -2298,7 +2298,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 	/* Display IO and DSC Support Check */
 	mode_lib->vba.NonsupportedDSCInputBPC = false;
-	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 		if (!(mode_lib->vba.DSCInputBitPerComponent[k] == 12.0
 				|| mode_lib->vba.DSCInputBitPerComponent[k] == 10.0
 				|| mode_lib->vba.DSCInputBitPerComponent[k] == 8.0)
@@ -2447,7 +2447,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 	for (i = start_state; i < v->soc.num_states; i++) {
 		mode_lib->vba.DSCCLKRequiredMoreThanSupported[i] = false;
-		for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+		for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 			if (mode_lib->vba.BlendingAndTiming[k] == k) {
 				if (mode_lib->vba.Output[k] == dm_dp || mode_lib->vba.Output[k] == dm_dp2p0
 						|| mode_lib->vba.Output[k] == dm_edp) {
@@ -2529,9 +2529,9 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					mode_lib->vba.ip.dsc_delay_factor_wa);
 		}
 
-		for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
-			for (m = 0; m <= mode_lib->vba.NumberOfActiveSurfaces - 1; m++) {
-				for (j = 0; j <= mode_lib->vba.NumberOfActiveSurfaces - 1; j++) {
+		for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
+			for (m = 0; m <= mode_lib->vba.NumberOfActiveSurfaces; m++) {
+				for (j = 0; j <= mode_lib->vba.NumberOfActiveSurfaces; j++) {
 					if (mode_lib->vba.BlendingAndTiming[k] == m &&
 							mode_lib->vba.RequiresDSC[i][m] == true) {
 						mode_lib->vba.DSCDelayPerState[i][k] =
@@ -2684,7 +2684,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 	for (i = start_state; i < v->soc.num_states; i++) {
 		for (j = 0; j < 2; j++) {
-			for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+			for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 				mode_lib->vba.swath_width_luma_ub_this_state[k] =
 						mode_lib->vba.swath_width_luma_ub_all_states[i][j][k];
 				mode_lib->vba.swath_width_chroma_ub_this_state[k] =
@@ -2911,7 +2911,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	//Calculate Return BW
 	for (i = start_state; i < (int) v->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
-			for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+			for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 				if (mode_lib->vba.BlendingAndTiming[k] == k) {
 					if (mode_lib->vba.WritebackEnable[k] == true) {
 						mode_lib->vba.WritebackDelayTime[k] =
@@ -2929,7 +2929,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					} else {
 						mode_lib->vba.WritebackDelayTime[k] = 0.0;
 					}
-					for (m = 0; m <= mode_lib->vba.NumberOfActiveSurfaces - 1; m++) {
+					for (m = 0; m <= mode_lib->vba.NumberOfActiveSurfaces; m++) {
 						if (mode_lib->vba.BlendingAndTiming[m]
 								== k && mode_lib->vba.WritebackEnable[m] == true) {
 							mode_lib->vba.WritebackDelayTime[k] =
@@ -2949,8 +2949,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					}
 				}
 			}
-			for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
-				for (m = 0; m <= mode_lib->vba.NumberOfActiveSurfaces - 1; m++) {
+			for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
+				for (m = 0; m <= mode_lib->vba.NumberOfActiveSurfaces; m++) {
 					if (mode_lib->vba.BlendingAndTiming[k] == m) {
 						mode_lib->vba.WritebackDelayTime[k] =
 								mode_lib->vba.WritebackDelayTime[m];
@@ -2958,7 +2958,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				}
 			}
 			mode_lib->vba.MaxMaxVStartup[i][j] = 0;
-			for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+			for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 				mode_lib->vba.MaximumVStartup[i][j][k] = ((mode_lib->vba.Interlace[k] &&
 								!mode_lib->vba.ProgressiveToInterlaceUnitInOPP) ?
 								dml_floor((mode_lib->vba.VTotal[k] -
@@ -3254,7 +3254,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				mode_lib->vba.PrefetchModePerState[i][j] = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.NextPrefetchModeState;
 				mode_lib->vba.MaxVStartup = mode_lib->vba.NextMaxVStartup;
 
-				for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+				for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 					mode_lib->vba.TWait = dml32_CalculateTWait(
 							mode_lib->vba.PrefetchModePerState[i][j],
 							mode_lib->vba.UsesMALLForPStateChange[k],
@@ -3343,7 +3343,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[4]);        // unsigned int   *VReadyOffsetPix
 				}
 
-				for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+				for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 					dml32_CalculateUrgentBurstFactor(
 							mode_lib->vba.UsesMALLForPStateChange[k],
 							mode_lib->vba.swath_width_luma_ub_this_state[k],
@@ -3400,7 +3400,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							&mode_lib->vba.PrefetchSupported[i][j]);
 				}
 
-				for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+				for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 					if (mode_lib->vba.LineTimesForPrefetch[k]
 							< 2.0 || mode_lib->vba.LinesForMetaPTE[k] >= 32.0
 							|| mode_lib->vba.LinesForMetaAndDPTERow[k] >= 16.0
@@ -3416,7 +3416,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				}
 
 				mode_lib->vba.VRatioInPrefetchSupported[i][j] = true;
-				for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+				for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 					if (mode_lib->vba.VRatioPreY[i][j][k] > mode_lib->vba.MaxVRatioPre
 							|| mode_lib->vba.VRatioPreC[i][j][k] > mode_lib->vba.MaxVRatioPre
 							|| mode_lib->vba.NoTimeForPrefetch[i][j][k] == true) {
@@ -3452,7 +3452,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							mode_lib->vba.UrgentBurstFactorCursorPre);
 
 					mode_lib->vba.TotImmediateFlipBytes = 0.0;
-					for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+					for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 						if (!(mode_lib->vba.ImmediateFlipRequirement[k] ==
 								dm_immediate_flip_not_required)) {
 							mode_lib->vba.TotImmediateFlipBytes =
@@ -3472,7 +3472,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 						}
 					}
 
-					for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+					for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 						dml32_CalculateFlipSchedule(v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.HostVMInefficiencyFactor,
 							mode_lib->vba.ExtraLatency,
 							mode_lib->vba.UrgLatency[i],
@@ -3533,7 +3533,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 								&mode_lib->vba.ImmediateFlipSupportedForState[i][j]); // Boolean *ImmediateFlipBandwidthSupport
 					}
 
-					for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+					for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 						if (!(mode_lib->vba.ImmediateFlipRequirement[k]
 								== dm_immediate_flip_not_required)
 								&& (mode_lib->vba.ImmediateFlipSupportedForPipe[k]
@@ -3618,7 +3618,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 	/*Cursor Support Check*/
 	mode_lib->vba.CursorSupport = true;
-	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 		if (mode_lib->vba.CursorWidth[k][0] > 0.0) {
 			if (mode_lib->vba.CursorBPP[k][0] == 64 && mode_lib->vba.Cursor64BppSupport == false)
 				mode_lib->vba.CursorSupport = false;
@@ -3627,7 +3627,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 	/*Valid Pitch Check*/
 	mode_lib->vba.PitchSupport = true;
-	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 		mode_lib->vba.AlignedYPitch[k] = dml_ceil(
 				dml_max(mode_lib->vba.PitchY[k], mode_lib->vba.SurfaceWidthY[k]),
 				mode_lib->vba.MacroTileWidthY[k]);
@@ -3667,7 +3667,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	}
 
 	mode_lib->vba.ViewportExceedsSurface = false;
-	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 		if (mode_lib->vba.ViewportWidth[k] > mode_lib->vba.SurfaceWidthY[k]
 				|| mode_lib->vba.ViewportHeight[k] > mode_lib->vba.SurfaceHeightY[k]) {
 			mode_lib->vba.ViewportExceedsSurface = true;
@@ -3711,7 +3711,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	mode_lib->vba.CompressedBufferSizeInkByte =
 			mode_lib->vba.CompressedBufferSizeInkByteAllStates[mode_lib->vba.VoltageLevel][MaximumMPCCombine]; // Not used, informational
 
-	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 		mode_lib->vba.MPCCombineEnable[k] =
 				mode_lib->vba.MPCCombine[mode_lib->vba.VoltageLevel][MaximumMPCCombine][k];
 		mode_lib->vba.DPPPerPlane[k] = mode_lib->vba.NoOfDPP[mode_lib->vba.VoltageLevel][MaximumMPCCombine][k];
@@ -3737,7 +3737,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	mode_lib->vba.DISPCLK = mode_lib->vba.RequiredDISPCLK[mode_lib->vba.VoltageLevel][MaximumMPCCombine];
 	mode_lib->vba.maxMpcComb = MaximumMPCCombine;
 
-	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
+	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces; k++) {
 		if (mode_lib->vba.BlendingAndTiming[k] == k) {
 			mode_lib->vba.ODMCombineEnabled[k] =
 					mode_lib->vba.ODMCombineEnablePerState[mode_lib->vba.VoltageLevel][k];
-- 
2.43.0

