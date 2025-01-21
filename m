Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00891C0218B
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 13:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A03C810E5C8;
	Tue, 21 Jan 2025 13:57:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b2abmmYw";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 762A110E593
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 13:57:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 514795C5679;
 Tue, 21 Jan 2025 13:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0910CC4CEE0;
 Tue, 21 Jan 2025 13:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737467864;
 bh=cYphQkLWvPxjjOlNlFuNR5WrbqtP2cTMHYx54AKhx2g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=b2abmmYweZUnpjZnBK+EXyEhAyDi6qf7fOGrx52NKhB1uHFc0B72l1e6KnCvMfy/C
 6C2pbvAKjunbjee9Ts/yHM6lspiVJeTCIKnqy62DW82dB4HkSmz8cG4+OGGi/zQLeD
 5S09LwJiy4OzHNIkUiidibq8ZZkykXw3HaESh9JWTHMIl4Ccb/xX6SNAggef7v37me
 al2F4ma0fZFdyLp2DQpwAHDEsrR8Yw8+lM8oXf6dZlNWlsfcJpkDX7pHVQkozvm6N/
 IWUkZht5E/YTEm1Y1tWs5sNqCx3vEbyVQ3ZMy0EdlOjA9LtwBQNx56sGNWGhw16a3J
 1EFjrqu6JtzPQ==
From: Mario Limonciello <superm1@kernel.org>
To: roman.li@amd.com,
	amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 4/4] drm/amd/display: Correct off by one errors in DML2
Date: Tue, 21 Jan 2025 07:57:19 -0600
Message-ID: <20250121135719.2883833-5-superm1@kernel.org>
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

Iterators of `num_active_planes` start at zero but since the loops
have a condition of `<= num_active_planes - 1`. This will mean that
the last plane isn't checked.

Adjust the condition to go all the way to `num_acftive_planes`.

Fixes: 7966f319c66d9 ("drm/amd/display: Introduce DML2")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../amd/display/dc/dml2/display_mode_core.c   | 74 +++++++++----------
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 40 +++++-----
 .../dml21/src/dml2_core/dml2_core_shared.c    | 50 ++++++-------
 3 files changed, 82 insertions(+), 82 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index e2c7afa958456..4b105021660f5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -6338,7 +6338,7 @@ static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 		s->NextMaxVStartup = s->MaxVStartupAllPlanes[j];
 		s->MaxVStartup = 0;
 		s->AllPrefetchModeTested = true;
-		for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+		for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 			CalculatePrefetchMode(mode_lib->ms.policy.AllowForPStateChangeOrStutterInVBlank[k], &s->MinPrefetchMode[k], &s->MaxPrefetchMode[k]);
 			s->NextPrefetchMode[k] = s->MinPrefetchMode[k];
 		}
@@ -6347,7 +6347,7 @@ static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 			s->MaxVStartup = s->NextMaxVStartup;
 			s->AllPrefetchModeTested = true;
 
-			for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+			for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 				mode_lib->ms.PrefetchMode[k] = s->NextPrefetchMode[k];
 				mode_lib->ms.TWait = CalculateTWait(
 								mode_lib->ms.PrefetchMode[k],
@@ -6413,7 +6413,7 @@ static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 								CalculatePrefetchSchedule_params);
 			}
 
-			for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+			for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 				CalculateUrgentBurstFactor(
 						mode_lib->ms.cache_display_cfg.plane.UseMALLForPStateChange[k],
 						mode_lib->ms.swath_width_luma_ub_this_state[k],
@@ -6472,7 +6472,7 @@ static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 				&mode_lib->ms.support.PrefetchSupported[j]);
 			}
 
-			for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+			for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 				if (mode_lib->ms.LineTimesForPrefetch[k] < 2.0
 					|| mode_lib->ms.LinesForMetaPTE[k] >= 32.0
 					|| mode_lib->ms.LinesForMetaAndDPTERow[k] >= 16.0
@@ -6489,7 +6489,7 @@ static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 			}
 
 			mode_lib->ms.support.VRatioInPrefetchSupported[j] = true;
-			for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+			for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 				if (mode_lib->ms.support.NoTimeForPrefetch[j][k] == true ||
 					mode_lib->ms.VRatioPreY[j][k] > __DML_MAX_VRATIO_PRE_ENHANCE_PREFETCH_ACC__ ||
 					mode_lib->ms.VRatioPreC[j][k] > __DML_MAX_VRATIO_PRE_ENHANCE_PREFETCH_ACC__ ||
@@ -6525,7 +6525,7 @@ static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 						mode_lib->ms.UrgentBurstFactorCursorPre);
 
 				mode_lib->ms.TotImmediateFlipBytes = 0;
-				for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+				for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 					if (!(mode_lib->ms.policy.ImmediateFlipRequirement[k] == dml_immediate_flip_not_required)) {
 						mode_lib->ms.TotImmediateFlipBytes = mode_lib->ms.TotImmediateFlipBytes + mode_lib->ms.NoOfDPP[j][k] * mode_lib->ms.PDEAndMetaPTEBytesPerFrame[j][k] + mode_lib->ms.MetaRowBytes[j][k];
 						if (mode_lib->ms.use_one_row_for_frame_flip[j][k]) {
@@ -6536,7 +6536,7 @@ static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 					}
 				}
 
-				for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+				for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 					CalculateFlipSchedule(
 						s->HostVMInefficiencyFactor,
 						mode_lib->ms.ExtraLatency,
@@ -6600,7 +6600,7 @@ static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 													&mode_lib->ms.support.ImmediateFlipSupportedForState[j]); // dml_bool_t *ImmediateFlipBandwidthSupport
 				}
 
-				for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+				for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 					if (!(mode_lib->ms.policy.ImmediateFlipRequirement[k] == dml_immediate_flip_not_required) && (mode_lib->ms.ImmediateFlipSupportedForPipe[k] == false))
 						mode_lib->ms.support.ImmediateFlipSupportedForState[j] = false;
 				}
@@ -6611,7 +6611,7 @@ static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 
 			if (s->MaxVStartup <= __DML_VBA_MIN_VSTARTUP__ || s->AnyLinesForVMOrRowTooLarge == false) {
 				s->NextMaxVStartup = s->MaxVStartupAllPlanes[j];
-				for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+				for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 					s->NextPrefetchMode[k] = s->NextPrefetchMode[k] + 1;
 
 					if (s->NextPrefetchMode[k] <= s->MaxPrefetchMode[k])
@@ -6742,7 +6742,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 
 	/*Scale Ratio, taps Support Check*/
 	mode_lib->ms.support.ScaleRatioAndTapsSupport = true;
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (mode_lib->ms.cache_display_cfg.plane.ScalerEnabled[k] == false
 				&& ((mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] != dml_444_64
 						&& mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] != dml_444_32
@@ -6781,7 +6781,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 
 	/*Source Format, Pixel Format and Scan Support Check*/
 	mode_lib->ms.support.SourceFormatPixelAndScanSupport = true;
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (mode_lib->ms.cache_display_cfg.surface.SurfaceTiling[k] == dml_sw_linear && (!(!dml_is_vertical_rotation(mode_lib->ms.cache_display_cfg.plane.SourceScan[k])) || mode_lib->ms.cache_display_cfg.surface.DCCEnable[k] == true))
 			mode_lib->ms.support.SourceFormatPixelAndScanSupport = false;
 	}
@@ -6807,7 +6807,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 	}
 
 	/*Bandwidth Support Check*/
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (!dml_is_vertical_rotation(mode_lib->ms.cache_display_cfg.plane.SourceScan[k])) {
 			mode_lib->ms.SwathWidthYSingleDPP[k] = mode_lib->ms.cache_display_cfg.plane.ViewportWidth[k];
 			mode_lib->ms.SwathWidthCSingleDPP[k] = mode_lib->ms.cache_display_cfg.plane.ViewportWidthChroma[k];
@@ -6816,11 +6816,11 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 			mode_lib->ms.SwathWidthCSingleDPP[k] = mode_lib->ms.cache_display_cfg.plane.ViewportHeightChroma[k];
 		}
 	}
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		mode_lib->ms.ReadBandwidthLuma[k] = mode_lib->ms.SwathWidthYSingleDPP[k] * dml_ceil(mode_lib->ms.BytePerPixelInDETY[k], 1.0) / (mode_lib->ms.cache_display_cfg.timing.HTotal[k] / mode_lib->ms.cache_display_cfg.timing.PixelClock[k]) * mode_lib->ms.cache_display_cfg.plane.VRatio[k];
 		mode_lib->ms.ReadBandwidthChroma[k] = mode_lib->ms.SwathWidthYSingleDPP[k] / 2 * dml_ceil(mode_lib->ms.BytePerPixelInDETC[k], 2.0) / (mode_lib->ms.cache_display_cfg.timing.HTotal[k] / mode_lib->ms.cache_display_cfg.timing.PixelClock[k]) * mode_lib->ms.cache_display_cfg.plane.VRatio[k] / 2.0;
 	}
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (mode_lib->ms.cache_display_cfg.writeback.WritebackEnable[k] == true
 				&& mode_lib->ms.cache_display_cfg.writeback.WritebackPixelFormat[k] == dml_444_64) {
 			mode_lib->ms.WriteBandwidth[k] = mode_lib->ms.cache_display_cfg.writeback.WritebackDestinationWidth[k]
@@ -6841,7 +6841,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 
 	/*Writeback Latency support check*/
 	mode_lib->ms.support.WritebackLatencySupport = true;
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (mode_lib->ms.cache_display_cfg.writeback.WritebackEnable[k] == true &&
 			(mode_lib->ms.WriteBandwidth[k] > mode_lib->ms.ip.writeback_interface_buffer_size_kbytes * 1024 / mode_lib->ms.state.writeback_latency_us)) {
 			mode_lib->ms.support.WritebackLatencySupport = false;
@@ -6850,7 +6850,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 
 	/*Writeback Mode Support Check*/
 	s->TotalNumberOfActiveWriteback = 0;
-	for (k = 0; k <= (dml_uint_t) mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= (dml_uint_t) mode_lib->ms.num_active_planes; k++) {
 		if (mode_lib->ms.cache_display_cfg.writeback.WritebackEnable[k] == true) {
 			s->TotalNumberOfActiveWriteback = s->TotalNumberOfActiveWriteback + 1;
 		}
@@ -6863,7 +6863,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 
 	/*Writeback Scale Ratio and Taps Support Check*/
 	mode_lib->ms.support.WritebackScaleRatioAndTapsSupport = true;
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (mode_lib->ms.cache_display_cfg.writeback.WritebackEnable[k] == true) {
 			if (mode_lib->ms.cache_display_cfg.writeback.WritebackHRatio[k] > mode_lib->ms.ip.writeback_max_hscl_ratio
 				|| mode_lib->ms.cache_display_cfg.writeback.WritebackVRatio[k] > mode_lib->ms.ip.writeback_max_vscl_ratio
@@ -6882,7 +6882,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 		}
 	}
 
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		CalculateSinglePipeDPPCLKAndSCLThroughput(
 				mode_lib->ms.cache_display_cfg.plane.HRatio[k],
 				mode_lib->ms.cache_display_cfg.plane.HRatioChroma[k],
@@ -6902,7 +6902,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 				&mode_lib->ms.MinDPPCLKUsingSingleDPP[k]);
 	}
 
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (mode_lib->ms.cache_display_cfg.surface.SurfaceTiling[k] == dml_sw_linear) {
 			s->MaximumSwathWidthSupportLuma = 8192;
 		} else if (!dml_is_vertical_rotation(mode_lib->ms.cache_display_cfg.plane.SourceScan[k]) && mode_lib->ms.BytePerPixelC[k] > 0 && mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] != dml_rgbe_alpha) {
@@ -7269,7 +7269,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 
 	/* Display IO and DSC Support Check */
 	mode_lib->ms.support.NonsupportedDSCInputBPC = false;
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (mode_lib->ms.cache_display_cfg.output.OutputDisabled[k] == false &&
 			!(mode_lib->ms.cache_display_cfg.output.DSCInputBitPerComponent[k] == 12.0
 				|| mode_lib->ms.cache_display_cfg.output.DSCInputBitPerComponent[k] == 10.0
@@ -7390,7 +7390,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 	}
 
 	mode_lib->ms.support.DSCCLKRequiredMoreThanSupported = false;
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (mode_lib->ms.cache_display_cfg.plane.BlendingAndTiming[k] == k) {
 			if (mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_dp ||
 				mode_lib->ms.cache_display_cfg.output.OutputEncoder[k] == dml_dp2p0 ||
@@ -7482,9 +7482,9 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 													mode_lib->ms.cache_display_cfg.output.PixelClockBackEnd[k]);
 	}
 
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
-		for (m = 0; m <= mode_lib->ms.num_active_planes - 1; m++) {
-			for (j = 0; j <= mode_lib->ms.num_active_planes - 1; j++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
+		for (m = 0; m <= mode_lib->ms.num_active_planes; m++) {
+			for (j = 0; j <= mode_lib->ms.num_active_planes; j++) {
 				if (mode_lib->ms.cache_display_cfg.plane.BlendingAndTiming[k] == m && mode_lib->ms.RequiresDSC[m] == true) {
 					mode_lib->ms.DSCDelayPerState[k] = mode_lib->ms.DSCDelayPerState[m];
 				}
@@ -7619,7 +7619,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 			&mode_lib->ms.support.ExceededMALLSize);
 
 	for (j = 0; j < 2; j++) {
-		for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+		for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 			mode_lib->ms.swath_width_luma_ub_this_state[k] = mode_lib->ms.swath_width_luma_ub_all_states[j][k];
 			mode_lib->ms.swath_width_chroma_ub_this_state[k] = mode_lib->ms.swath_width_chroma_ub_all_states[j][k];
 			mode_lib->ms.SwathWidthYThisState[k] = mode_lib->ms.SwathWidthYAllStates[j][k];
@@ -7839,7 +7839,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 
 	//Calculate Return BW
 	for (j = 0; j < 2; ++j) {
-		for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+		for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 			if (mode_lib->ms.cache_display_cfg.plane.BlendingAndTiming[k] == k) {
 				if (mode_lib->ms.cache_display_cfg.writeback.WritebackEnable[k] == true) {
 					mode_lib->ms.WritebackDelayTime[k] = mode_lib->ms.state.writeback_latency_us + CalculateWriteBackDelay(
@@ -7854,7 +7854,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 				} else {
 					mode_lib->ms.WritebackDelayTime[k] = 0.0;
 				}
-				for (m = 0; m <= mode_lib->ms.num_active_planes - 1; m++) {
+				for (m = 0; m <= mode_lib->ms.num_active_planes; m++) {
 					if (mode_lib->ms.cache_display_cfg.plane.BlendingAndTiming[m] == k && mode_lib->ms.cache_display_cfg.writeback.WritebackEnable[m] == true) {
 						mode_lib->ms.WritebackDelayTime[k] = dml_max(mode_lib->ms.WritebackDelayTime[k],
 											mode_lib->ms.state.writeback_latency_us + CalculateWriteBackDelay(
@@ -7870,8 +7870,8 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 				}
 			}
 		}
-		for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
-			for (m = 0; m <= mode_lib->ms.num_active_planes - 1; m++) {
+		for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
+			for (m = 0; m <= mode_lib->ms.num_active_planes; m++) {
 				if (mode_lib->ms.cache_display_cfg.plane.BlendingAndTiming[k] == m) {
 					mode_lib->ms.WritebackDelayTime[k] = mode_lib->ms.WritebackDelayTime[m];
 				}
@@ -7879,7 +7879,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 		}
        s->MaxVStartupAllPlanes[j] = 0;  // max vstartup among all planes
 
-		for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+		for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 			s->MaximumVStartup[j][k] = CalculateMaxVStartup(k,
 														mode_lib->ms.ip.ptoi_supported,
 														mode_lib->ms.ip.vblank_nom_default_us,
@@ -8057,7 +8057,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 
 	/*Cursor Support Check*/
 	mode_lib->ms.support.CursorSupport = true;
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (mode_lib->ms.cache_display_cfg.plane.CursorWidth[k] > 0.0) {
 			if (mode_lib->ms.cache_display_cfg.plane.CursorBPP[k] == 64 && mode_lib->ms.ip.cursor_64bpp_support == false) {
 				mode_lib->ms.support.CursorSupport = false;
@@ -8067,7 +8067,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 
 	/*Valid Pitch Check*/
 	mode_lib->ms.support.PitchSupport = true;
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		mode_lib->ms.support.AlignedYPitch[k] = dml_ceil(
 				dml_max(mode_lib->ms.cache_display_cfg.surface.PitchY[k], mode_lib->ms.cache_display_cfg.surface.SurfaceWidthY[k]),
 				mode_lib->ms.MacroTileWidthY[k]);
@@ -8099,7 +8099,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 	}
 
 	mode_lib->ms.support.ViewportExceedsSurface = false;
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (mode_lib->ms.cache_display_cfg.plane.ViewportWidth[k] > mode_lib->ms.cache_display_cfg.surface.SurfaceWidthY[k] || mode_lib->ms.cache_display_cfg.plane.ViewportHeight[k] > mode_lib->ms.cache_display_cfg.surface.SurfaceHeightY[k]) {
 			mode_lib->ms.support.ViewportExceedsSurface = true;
 			if (mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] != dml_444_64 && mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k] != dml_444_32 &&
@@ -8221,7 +8221,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 	dml_print("DML::%s: UnboundedRequestEnabled        = %u\n", __func__, mode_lib->ms.support.UnboundedRequestEnabled);
 	dml_print("DML::%s: CompressedBufferSizeInkByte    = %u\n", __func__, mode_lib->ms.support.CompressedBufferSizeInkByte);
 
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		mode_lib->ms.support.MPCCombineEnable[k]   = mode_lib->ms.MPCCombine[mode_lib->ms.support.MaximumMPCCombine][k];
 		mode_lib->ms.support.DPPPerSurface[k]      = mode_lib->ms.NoOfDPP[mode_lib->ms.support.MaximumMPCCombine][k];
 		mode_lib->ms.SwathHeightY[k]               = mode_lib->ms.SwathHeightYAllStates[mode_lib->ms.support.MaximumMPCCombine][k];
@@ -8238,7 +8238,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 	mode_lib->ms.ReturnBW      = mode_lib->ms.ReturnBWPerState[mode_lib->ms.support.MaximumMPCCombine];
 	mode_lib->ms.ReturnDRAMBW  = mode_lib->ms.ReturnDRAMBWPerState[mode_lib->ms.support.MaximumMPCCombine];
 
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (mode_lib->ms.cache_display_cfg.plane.BlendingAndTiming[k] == k) {
 			mode_lib->ms.support.ODMMode[k] = mode_lib->ms.ODMModePerState[k];
 		} else {
@@ -8930,7 +8930,7 @@ void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struc
 	s->iteration = 0;
 	s->MaxTotalRDBandwidth = 0;
 	s->AllPrefetchModeTested = false;
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		CalculatePrefetchMode(mode_lib->ms.policy.AllowForPStateChangeOrStutterInVBlank[k], &s->MinPrefetchMode[k], &s->MaxPrefetchMode[k]);
 		s->NextPrefetchMode[k] = s->MinPrefetchMode[k];
 	}
@@ -9367,7 +9367,7 @@ void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struc
 		if (s->VStartupLines > s->MaxVStartupAllPlanes) {
 			s->VStartupLines = __DML_VBA_MIN_VSTARTUP__;
 
-			for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+			for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 				s->NextPrefetchMode[k] = s->NextPrefetchMode[k] + 1;
 
 				if (s->NextPrefetchMode[k] <= s->MaxPrefetchMode[k])
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index ecfa3c898e09d..68ff3558165ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -7112,7 +7112,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	/*Scale Ratio, taps Support Check*/
 	mode_lib->ms.support.ScaleRatioAndTapsSupport = true;
 	// Many core tests are still setting scaling parameters "incorrectly"
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (display_cfg->plane_descriptors[k].composition.scaler_info.enabled == false
 			&& (dml_is_420(display_cfg->plane_descriptors[k].pixel_format)
 				|| display_cfg->plane_descriptors[k].composition.scaler_info.plane0.h_ratio != 1.0
@@ -7141,13 +7141,13 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 
 	/*Source Format, Pixel Format and Scan Support Check*/
 	mode_lib->ms.support.SourceFormatPixelAndScanSupport = true;
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (display_cfg->plane_descriptors[k].surface.tiling == dml2_sw_linear && dml_is_vertical_rotation(display_cfg->plane_descriptors[k].composition.rotation_angle)) {
 			mode_lib->ms.support.SourceFormatPixelAndScanSupport = false;
 		}
 	}
 
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		CalculateBytePerPixelAndBlockSizes(
 			display_cfg->plane_descriptors[k].pixel_format,
 			display_cfg->plane_descriptors[k].surface.tiling,
@@ -7172,7 +7172,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	}
 
 	/*Bandwidth Support Check*/
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (!dml_is_vertical_rotation(display_cfg->plane_descriptors[k].composition.rotation_angle)) {
 			mode_lib->ms.SwathWidthYSingleDPP[k] = display_cfg->plane_descriptors[k].composition.viewport.plane0.width;
 			mode_lib->ms.SwathWidthCSingleDPP[k] = display_cfg->plane_descriptors[k].composition.viewport.plane1.width;
@@ -7182,7 +7182,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 		}
 	}
 
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		mode_lib->ms.SurfaceReadBandwidthLuma[k] = mode_lib->ms.SwathWidthYSingleDPP[k] * math_ceil2(mode_lib->ms.BytePerPixelY[k], 1.0) / (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_total / ((double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.pixel_clock_khz / 1000)) * display_cfg->plane_descriptors[k].composition.scaler_info.plane0.v_ratio;
 		mode_lib->ms.SurfaceReadBandwidthChroma[k] = mode_lib->ms.SwathWidthCSingleDPP[k] * math_ceil2(mode_lib->ms.BytePerPixelC[k], 2.0) / (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_total / ((double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.pixel_clock_khz / 1000)) * display_cfg->plane_descriptors[k].composition.scaler_info.plane1.v_ratio;
 
@@ -7220,7 +7220,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 
 	/*Writeback Latency support check*/
 	mode_lib->ms.support.WritebackLatencySupport = true;
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].writeback.enable == true &&
 			(mode_lib->ms.WriteBandwidth[k] > mode_lib->ip.writeback_interface_buffer_size_kbytes * 1024 / ((double)mode_lib->soc.qos_parameters.writeback.base_latency_us))) {
 			mode_lib->ms.support.WritebackLatencySupport = false;
@@ -7230,7 +7230,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 
 	/* Writeback Scale Ratio and Taps Support Check */
 	mode_lib->ms.support.WritebackScaleRatioAndTapsSupport = true;
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].writeback.enable == true) {
 			if (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].writeback.scaling_info.h_ratio > mode_lib->ip.writeback_max_hscl_ratio
 				|| display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].writeback.scaling_info.v_ratio > mode_lib->ip.writeback_max_vscl_ratio
@@ -7249,7 +7249,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 		}
 	}
 
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		CalculateSinglePipeDPPCLKAndSCLThroughput(
 			display_cfg->plane_descriptors[k].composition.scaler_info.plane0.h_ratio,
 			display_cfg->plane_descriptors[k].composition.scaler_info.plane1.h_ratio,
@@ -7838,7 +7838,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	}
 
 	mode_lib->ms.support.DSCCLKRequiredMoreThanSupported = false;
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].output.output_encoder == dml2_dp ||
 			display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].output.output_encoder == dml2_dp2p0 ||
 			display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].output.output_encoder == dml2_edp ||
@@ -8263,7 +8263,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 		/* Output */
 		&mode_lib->ms.dcfclk_deepsleep);
 
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].writeback.enable == true) {
 			mode_lib->ms.WritebackDelayTime[k] = mode_lib->soc.qos_parameters.writeback.base_latency_us + CalculateWriteBackDelay(
 				display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].writeback.pixel_format,
@@ -8280,7 +8280,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	}
 
 	// MaximumVStartup is actually Tvstartup_min in DCN4 programming guide
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		bool isInterlaceTiming = (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.interlaced && !mode_lib->ip.ptoi_supported);
 		s->MaximumVStartup[k] = CalculateMaxVStartup(
 			mode_lib->ip.ptoi_supported,
@@ -8574,7 +8574,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 				mode_lib->ms.support.urg_bandwidth_available_vm_only[dml2_core_internal_soc_state_sys_active]);
 
 		mode_lib->ms.Total3dlutActive = 0;
-		for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+		for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 			if (display_cfg->plane_descriptors[k].tdlut.setup_for_tdlut)
 				mode_lib->ms.Total3dlutActive = mode_lib->ms.Total3dlutActive + 1;
 
@@ -8789,7 +8789,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 			}
 
 			mode_lib->ms.support.VRatioInPrefetchSupported = true;
-			for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+			for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 				if (mode_lib->ms.VRatioPreY[k] > __DML2_CALCS_MAX_VRATIO_PRE__ ||
 					mode_lib->ms.VRatioPreC[k] > __DML2_CALCS_MAX_VRATIO_PRE__) {
 					mode_lib->ms.support.VRatioInPrefetchSupported = false;
@@ -8801,7 +8801,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 
 			// Only do urg vs prefetch bandwidth check, flip schedule check, power saving feature support check IF the Prefetch Schedule Check is ok
 			if (mode_lib->ms.support.PrefetchSupported) {
-				for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+				for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 					double line_time_us = display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_total / ((double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.pixel_clock_khz / 1000);
 					// Calculate Urgent burst factor for prefetch
 #ifdef __DML_VBA_DEBUG__
@@ -8923,7 +8923,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 
 					}
 
-					for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+					for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 						CalculateFlipSchedule(
 							&mode_lib->scratch,
 							display_cfg->plane_descriptors[k].immediate_flip,
@@ -9011,7 +9011,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 						mode_lib->ms.support.non_urg_bandwidth_required_flip,
 						mode_lib->ms.support.urg_bandwidth_available);
 
-					for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+					for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 						if (display_cfg->plane_descriptors[k].immediate_flip == true && mode_lib->ms.ImmediateFlipSupportedForPipe[k] == false)
 							mode_lib->ms.support.ImmediateFlipSupport = false;
 					}
@@ -9187,12 +9187,12 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	dml2_printf("DML::%s: ModeSupport = %u\n", __func__, mode_lib->ms.support.ModeSupport);
 	dml2_printf("DML::%s: ImmediateFlipSupport = %u\n", __func__, mode_lib->ms.support.ImmediateFlipSupport);
 
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		mode_lib->ms.support.MPCCombineEnable[k] = mode_lib->ms.MPCCombine[k];
 		mode_lib->ms.support.DPPPerSurface[k] = mode_lib->ms.NoOfDPP[k];
 	}
 
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		mode_lib->ms.support.ODMMode[k] = mode_lib->ms.ODMMode[k];
 		mode_lib->ms.support.DSCEnabled[k] = mode_lib->ms.RequiresDSC[k];
 		mode_lib->ms.support.FECEnabled[k] = mode_lib->ms.RequiresFEC[k];
@@ -10524,7 +10524,7 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 			s->TotalDCCActiveDPP = s->TotalDCCActiveDPP + mode_lib->mp.NoOfDPP[k];
 	}
 	// Calculate tdlut schedule related terms
-	for (k = 0; k <= s->num_active_planes - 1; k++) {
+	for (k = 0; k <= s->num_active_planes; k++) {
 		calculate_tdlut_setting_params->dispclk_mhz = mode_lib->mp.Dispclk;
 		calculate_tdlut_setting_params->setup_for_tdlut = display_cfg->plane_descriptors[k].tdlut.setup_for_tdlut;
 		calculate_tdlut_setting_params->tdlut_width_mode = display_cfg->plane_descriptors[k].tdlut.tdlut_width_mode;
@@ -10967,7 +10967,7 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 #endif
 			}
 
-			for (k = 0; k <= s->num_active_planes - 1; k++)
+			for (k = 0; k <= s->num_active_planes; k++)
 				mode_lib->mp.final_flip_bw[k] = 0;
 
 			calculate_peak_bandwidth_params->urg_vactive_bandwidth_required = mode_lib->mp.urg_vactive_bandwidth_required;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
index 8f3c1c0b1cc10..4cc6c8909776b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
@@ -832,7 +832,7 @@ bool dml2_core_shared_mode_support(struct dml2_core_calcs_mode_support_ex *in_ou
 	/*Scale Ratio, taps Support Check*/
 	mode_lib->ms.support.ScaleRatioAndTapsSupport = true;
 	// Many core tests are still setting scaling parameters "incorrectly"
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (display_cfg->plane_descriptors[k].composition.scaler_info.enabled == false
 			&& (dml2_core_shared_is_420(display_cfg->plane_descriptors[k].pixel_format)
 				|| display_cfg->plane_descriptors[k].composition.scaler_info.plane0.h_ratio != 1.0
@@ -861,13 +861,13 @@ bool dml2_core_shared_mode_support(struct dml2_core_calcs_mode_support_ex *in_ou
 
 	/*Source Format, Pixel Format and Scan Support Check*/
 	mode_lib->ms.support.SourceFormatPixelAndScanSupport = true;
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (display_cfg->plane_descriptors[k].surface.tiling == dml2_sw_linear && dml_is_vertical_rotation(display_cfg->plane_descriptors[k].composition.rotation_angle)) {
 			mode_lib->ms.support.SourceFormatPixelAndScanSupport = false;
 		}
 	}
 
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		CalculateBytePerPixelAndBlockSizes(
 			display_cfg->plane_descriptors[k].pixel_format,
 			display_cfg->plane_descriptors[k].surface.tiling,
@@ -892,7 +892,7 @@ bool dml2_core_shared_mode_support(struct dml2_core_calcs_mode_support_ex *in_ou
 	}
 
 	/*Bandwidth Support Check*/
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (!dml_is_vertical_rotation(display_cfg->plane_descriptors[k].composition.rotation_angle)) {
 			mode_lib->ms.SwathWidthYSingleDPP[k] = display_cfg->plane_descriptors[k].composition.viewport.plane0.width;
 			mode_lib->ms.SwathWidthCSingleDPP[k] = display_cfg->plane_descriptors[k].composition.viewport.plane1.width;
@@ -902,7 +902,7 @@ bool dml2_core_shared_mode_support(struct dml2_core_calcs_mode_support_ex *in_ou
 		}
 	}
 
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		mode_lib->ms.SurfaceReadBandwidthLuma[k] = mode_lib->ms.SwathWidthYSingleDPP[k] * math_ceil2(mode_lib->ms.BytePerPixelY[k], 1.0) / (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_total / ((double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.pixel_clock_khz / 1000)) * display_cfg->plane_descriptors[k].composition.scaler_info.plane0.v_ratio;
 		mode_lib->ms.SurfaceReadBandwidthChroma[k] = mode_lib->ms.SwathWidthCSingleDPP[k] * math_ceil2(mode_lib->ms.BytePerPixelC[k], 2.0) / (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_total / ((double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.pixel_clock_khz / 1000)) * display_cfg->plane_descriptors[k].composition.scaler_info.plane1.v_ratio;
 
@@ -920,7 +920,7 @@ bool dml2_core_shared_mode_support(struct dml2_core_calcs_mode_support_ex *in_ou
 	}
 
 	// Writeback bandwidth
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].writeback.enable == true && display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].writeback.pixel_format == dml2_444_64) {
 			mode_lib->ms.WriteBandwidth[k] = display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].writeback.scaling_info.output_height
 				* display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].writeback.scaling_info.output_width
@@ -940,7 +940,7 @@ bool dml2_core_shared_mode_support(struct dml2_core_calcs_mode_support_ex *in_ou
 
 	/*Writeback Latency support check*/
 	mode_lib->ms.support.WritebackLatencySupport = true;
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].writeback.enable == true &&
 			(mode_lib->ms.WriteBandwidth[k] > mode_lib->ip.writeback_interface_buffer_size_kbytes * 1024.0 / mode_lib->soc.qos_parameters.writeback.base_latency_us)) {
 			mode_lib->ms.support.WritebackLatencySupport = false;
@@ -949,7 +949,7 @@ bool dml2_core_shared_mode_support(struct dml2_core_calcs_mode_support_ex *in_ou
 
 	/* Writeback Mode Support Check */
 	s->TotalNumberOfActiveWriteback = 0;
-	for (k = 0; k <= (unsigned int)mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= (unsigned int)mode_lib->ms.num_active_planes; k++) {
 		if (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].writeback.enable == true
 			&& (display_cfg->plane_descriptors[k].stream_index == k)) {
 			s->TotalNumberOfActiveWriteback = s->TotalNumberOfActiveWriteback + 1;
@@ -963,7 +963,7 @@ bool dml2_core_shared_mode_support(struct dml2_core_calcs_mode_support_ex *in_ou
 
 	/* Writeback Scale Ratio and Taps Support Check */
 	mode_lib->ms.support.WritebackScaleRatioAndTapsSupport = true;
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].writeback.enable == true) {
 			if (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].writeback.scaling_info.h_ratio > mode_lib->ip.writeback_max_hscl_ratio
 				|| display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].writeback.scaling_info.v_ratio > mode_lib->ip.writeback_max_vscl_ratio
@@ -982,7 +982,7 @@ bool dml2_core_shared_mode_support(struct dml2_core_calcs_mode_support_ex *in_ou
 		}
 	}
 
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		CalculateSinglePipeDPPCLKAndSCLThroughput(
 			display_cfg->plane_descriptors[k].composition.scaler_info.plane0.h_ratio,
 			display_cfg->plane_descriptors[k].composition.scaler_info.plane1.h_ratio,
@@ -1492,7 +1492,7 @@ bool dml2_core_shared_mode_support(struct dml2_core_calcs_mode_support_ex *in_ou
 	}
 
 	mode_lib->ms.support.DSCCLKRequiredMoreThanSupported = false;
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (display_cfg->plane_descriptors[k].stream_index == k) {
 			if (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].output.output_encoder == dml2_dp ||
 				display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].output.output_encoder == dml2_dp2p0 ||
@@ -1878,7 +1878,7 @@ bool dml2_core_shared_mode_support(struct dml2_core_calcs_mode_support_ex *in_ou
 		/* Output */
 		&mode_lib->ms.dcfclk_deepsleep);
 
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (display_cfg->plane_descriptors[k].stream_index == k) {
 			if (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].writeback.enable == true) {
 				mode_lib->ms.WritebackDelayTime[k] = mode_lib->soc.qos_parameters.writeback.base_latency_us + CalculateWriteBackDelay(
@@ -1893,7 +1893,7 @@ bool dml2_core_shared_mode_support(struct dml2_core_calcs_mode_support_ex *in_ou
 			} else {
 				mode_lib->ms.WritebackDelayTime[k] = 0.0;
 			}
-			for (m = 0; m <= mode_lib->ms.num_active_planes - 1; m++) {
+			for (m = 0; m <= mode_lib->ms.num_active_planes; m++) {
 				if (display_cfg->plane_descriptors[m].stream_index == k && display_cfg->stream_descriptors[display_cfg->plane_descriptors[m].stream_index].writeback.enable == true) {
 					mode_lib->ms.WritebackDelayTime[k] = math_max2(mode_lib->ms.WritebackDelayTime[k],
 						mode_lib->soc.qos_parameters.writeback.base_latency_us + CalculateWriteBackDelay(
@@ -1909,8 +1909,8 @@ bool dml2_core_shared_mode_support(struct dml2_core_calcs_mode_support_ex *in_ou
 			}
 		}
 	}
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
-		for (m = 0; m <= mode_lib->ms.num_active_planes - 1; m++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
+		for (m = 0; m <= mode_lib->ms.num_active_planes; m++) {
 			if (display_cfg->plane_descriptors[k].stream_index == m) {
 				mode_lib->ms.WritebackDelayTime[k] = mode_lib->ms.WritebackDelayTime[m];
 			}
@@ -1918,7 +1918,7 @@ bool dml2_core_shared_mode_support(struct dml2_core_calcs_mode_support_ex *in_ou
 	}
 
 	// MaximumVStartup is actually Tvstartup_min in DCN4 programming guide
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		bool isInterlaceTiming = (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.interlaced && !mode_lib->ip.ptoi_supported);
 		s->MaximumVStartup[k] = CalculateMaxVStartup(
 			mode_lib->ip.ptoi_supported,
@@ -2215,7 +2215,7 @@ bool dml2_core_shared_mode_support(struct dml2_core_calcs_mode_support_ex *in_ou
 			mode_lib->ms.support.urg_bandwidth_available_vm_only[dml2_core_internal_soc_state_sys_active]);
 
 		mode_lib->ms.Total3dlutActive = 0;
-		for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+		for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 			if (display_cfg->plane_descriptors[k].tdlut.setup_for_tdlut)
 				mode_lib->ms.Total3dlutActive = mode_lib->ms.Total3dlutActive + 1;
 
@@ -2427,7 +2427,7 @@ bool dml2_core_shared_mode_support(struct dml2_core_calcs_mode_support_ex *in_ou
 			}
 
 			mode_lib->ms.support.VRatioInPrefetchSupported = true;
-			for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+			for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 				if (mode_lib->ms.VRatioPreY[k] > __DML2_CALCS_MAX_VRATIO_PRE_ENHANCE_PREFETCH_ACC__ ||
 					mode_lib->ms.VRatioPreC[k] > __DML2_CALCS_MAX_VRATIO_PRE_ENHANCE_PREFETCH_ACC__) {
 					mode_lib->ms.support.VRatioInPrefetchSupported = false;
@@ -2444,7 +2444,7 @@ bool dml2_core_shared_mode_support(struct dml2_core_calcs_mode_support_ex *in_ou
 
 			// Only do urg vs prefetch bandwidth check, flip schedule check, power saving feature support check IF the Prefetch Schedule Check is ok
 			if (mode_lib->ms.support.PrefetchSupported) {
-				for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+				for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 					// Calculate Urgent burst factor for prefetch
 #ifdef __DML_VBA_DEBUG__
 					dml2_printf("DML::%s: k=%d, Calling CalculateUrgentBurstFactor (for prefetch)\n", __func__, k);
@@ -2558,7 +2558,7 @@ bool dml2_core_shared_mode_support(struct dml2_core_calcs_mode_support_ex *in_ou
 
 					}
 
-					for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+					for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 						CalculateFlipSchedule(
 							&mode_lib->scratch,
 							display_cfg->plane_descriptors[k].immediate_flip,
@@ -2640,7 +2640,7 @@ bool dml2_core_shared_mode_support(struct dml2_core_calcs_mode_support_ex *in_ou
 						mode_lib->ms.support.non_urg_bandwidth_required_flip,
 						mode_lib->ms.support.urg_bandwidth_available);
 
-					for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+					for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 						if (display_cfg->plane_descriptors[k].immediate_flip == true && mode_lib->ms.ImmediateFlipSupportedForPipe[k] == false)
 							mode_lib->ms.support.ImmediateFlipSupport = false;
 					}
@@ -2808,12 +2808,12 @@ bool dml2_core_shared_mode_support(struct dml2_core_calcs_mode_support_ex *in_ou
 	dml2_printf("DML::%s: ModeSupport = %u\n", __func__, mode_lib->ms.support.ModeSupport);
 	dml2_printf("DML::%s: ImmediateFlipSupport = %u\n", __func__, mode_lib->ms.support.ImmediateFlipSupport);
 
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		mode_lib->ms.support.MPCCombineEnable[k] = mode_lib->ms.MPCCombine[k];
 		mode_lib->ms.support.DPPPerSurface[k] = mode_lib->ms.NoOfDPP[k];
 	}
 
-	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
 		if (display_cfg->plane_descriptors[k].stream_index == k) {
 			mode_lib->ms.support.ODMMode[k] = mode_lib->ms.ODMMode[k];
 		} else {
@@ -10389,7 +10389,7 @@ bool dml2_core_shared_mode_programming(struct dml2_core_calcs_mode_programming_e
 			s->TotalDCCActiveDPP = s->TotalDCCActiveDPP + mode_lib->mp.NoOfDPP[k];
 	}
 	// Calculate tdlut schedule related terms
-	for (k = 0; k <= s->num_active_planes - 1; k++) {
+	for (k = 0; k <= s->num_active_planes; k++) {
 		calculate_tdlut_setting_params->dispclk_mhz = mode_lib->mp.Dispclk;
 		calculate_tdlut_setting_params->setup_for_tdlut = display_cfg->plane_descriptors[k].tdlut.setup_for_tdlut;
 		calculate_tdlut_setting_params->tdlut_width_mode = display_cfg->plane_descriptors[k].tdlut.tdlut_width_mode;
@@ -10810,7 +10810,7 @@ bool dml2_core_shared_mode_programming(struct dml2_core_calcs_mode_programming_e
 #endif
 			}
 
-			for (k = 0; k <= s->num_active_planes - 1; k++)
+			for (k = 0; k <= s->num_active_planes; k++)
 				mode_lib->mp.final_flip_bw[k] = 0;
 
 			calculate_peak_bandwidth_required(
-- 
2.43.0

