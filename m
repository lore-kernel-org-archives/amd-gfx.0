Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C21C02182
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 13:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9126A10E593;
	Tue, 21 Jan 2025 13:57:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lA48WFhd";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 914E010E5C5
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 13:57:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 953DB5C5894;
 Tue, 21 Jan 2025 13:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611D7C4CEE3;
 Tue, 21 Jan 2025 13:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737467863;
 bh=akoOLC2Cx1rRmi0PfT3KWnFJHpHrFD7dAXwqzSO4euM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lA48WFhdNLEFkZskalOILvaE1++GvodjS7RdzH/FMZEsc9kP0Ny5NfOy2EfPhMuVC
 Zd2Z6zH4pxvTPdKXnPLRd53izDVM7YomaN8en0aBfYR9cIVz6lr1ijwpLhI9HkL3Cg
 HoJFA0wkYTUK/6N5mCedQaQc6iSlidpkcmoENL93vp4EYvMbcIfxCt+FpsOk5CvuoA
 nZwcu/hkgPGLxxVVXBfiK+M3IZgmAw0JvioJ5k7PHdxGraJ5Oye8tczetXjiMdMQnA
 uOJI6jrcwaw9pgiMHKDjGaaiAffrKVd0mtgnFJHEQqO2XitsiYPyB7sHlQsgZqCOwL
 YJm53cxrHCgBQ==
From: Mario Limonciello <superm1@kernel.org>
To: roman.li@amd.com,
	amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 3/4] drm/amd/display: Correct some suspect code indentation
Date: Tue, 21 Jan 2025 07:57:18 -0600
Message-ID: <20250121135719.2883833-4-superm1@kernel.org>
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

The indentation for some lines in DML2 code is off and checkpatch
reported it while fixing another issue.

```
WARNING: suspect code indent for conditional statements (24, 40)
46: FILE: drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c:6416:
+                       for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
                                        CalculateUrgentBurstFactor(

WARNING: suspect code indent for conditional statements (8, 24)
118: FILE: drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c:6784:
+       for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
                        if (mode_lib->ms.cache_display_cfg.surface.SurfaceTiling[k] == dml_sw_linear && (!(!dml_is_vertical_rotation(mode_lib->ms.cache_display_cfg.plane.SourceScan[k])) || mode_lib->ms.cache_display_cfg.surface.DCCEnable[k] == true)) {
```

Correct indentation for those two cases.

Fixes: 7966f319c66d9 ("drm/amd/display: Introduce DML2")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../amd/display/dc/dml2/display_mode_core.c   | 55 +++++++++----------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index 45147b812d7d9..e2c7afa958456 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -6414,32 +6414,32 @@ static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
 			}
 
 			for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
-					CalculateUrgentBurstFactor(
-							mode_lib->ms.cache_display_cfg.plane.UseMALLForPStateChange[k],
-							mode_lib->ms.swath_width_luma_ub_this_state[k],
-							mode_lib->ms.swath_width_chroma_ub_this_state[k],
-							mode_lib->ms.SwathHeightYThisState[k],
-							mode_lib->ms.SwathHeightCThisState[k],
-							mode_lib->ms.cache_display_cfg.timing.HTotal[k] / mode_lib->ms.cache_display_cfg.timing.PixelClock[k],
-							mode_lib->ms.UrgLatency,
-							mode_lib->ms.ip.cursor_buffer_size,
-							mode_lib->ms.cache_display_cfg.plane.CursorWidth[k],
-							mode_lib->ms.cache_display_cfg.plane.CursorBPP[k],
-							mode_lib->ms.VRatioPreY[j][k],
-							mode_lib->ms.VRatioPreC[j][k],
-							mode_lib->ms.BytePerPixelInDETY[k],
-							mode_lib->ms.BytePerPixelInDETC[k],
-							mode_lib->ms.DETBufferSizeYThisState[k],
-							mode_lib->ms.DETBufferSizeCThisState[k],
-							/* Output */
-							&mode_lib->ms.UrgentBurstFactorCursorPre[k],
-							&mode_lib->ms.UrgentBurstFactorLumaPre[k],
-							&mode_lib->ms.UrgentBurstFactorChroma[k],
-							&mode_lib->ms.NotUrgentLatencyHidingPre[k]);
-
-					mode_lib->ms.cursor_bw_pre[k] = mode_lib->ms.cache_display_cfg.plane.NumberOfCursors[k] * mode_lib->ms.cache_display_cfg.plane.CursorWidth[k] *
-													mode_lib->ms.cache_display_cfg.plane.CursorBPP[k] / 8.0 / (mode_lib->ms.cache_display_cfg.timing.HTotal[k] /
-													mode_lib->ms.cache_display_cfg.timing.PixelClock[k]) * mode_lib->ms.VRatioPreY[j][k];
+				CalculateUrgentBurstFactor(
+						mode_lib->ms.cache_display_cfg.plane.UseMALLForPStateChange[k],
+						mode_lib->ms.swath_width_luma_ub_this_state[k],
+						mode_lib->ms.swath_width_chroma_ub_this_state[k],
+						mode_lib->ms.SwathHeightYThisState[k],
+						mode_lib->ms.SwathHeightCThisState[k],
+						mode_lib->ms.cache_display_cfg.timing.HTotal[k] / mode_lib->ms.cache_display_cfg.timing.PixelClock[k],
+						mode_lib->ms.UrgLatency,
+						mode_lib->ms.ip.cursor_buffer_size,
+						mode_lib->ms.cache_display_cfg.plane.CursorWidth[k],
+						mode_lib->ms.cache_display_cfg.plane.CursorBPP[k],
+						mode_lib->ms.VRatioPreY[j][k],
+						mode_lib->ms.VRatioPreC[j][k],
+						mode_lib->ms.BytePerPixelInDETY[k],
+						mode_lib->ms.BytePerPixelInDETC[k],
+						mode_lib->ms.DETBufferSizeYThisState[k],
+						mode_lib->ms.DETBufferSizeCThisState[k],
+						/* Output */
+						&mode_lib->ms.UrgentBurstFactorCursorPre[k],
+						&mode_lib->ms.UrgentBurstFactorLumaPre[k],
+						&mode_lib->ms.UrgentBurstFactorChroma[k],
+						&mode_lib->ms.NotUrgentLatencyHidingPre[k]);
+
+				mode_lib->ms.cursor_bw_pre[k] = mode_lib->ms.cache_display_cfg.plane.NumberOfCursors[k] * mode_lib->ms.cache_display_cfg.plane.CursorWidth[k] *
+												mode_lib->ms.cache_display_cfg.plane.CursorBPP[k] / 8.0 / (mode_lib->ms.cache_display_cfg.timing.HTotal[k] /
+												mode_lib->ms.cache_display_cfg.timing.PixelClock[k]) * mode_lib->ms.VRatioPreY[j][k];
 			}
 
 			{
@@ -6782,9 +6782,8 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 	/*Source Format, Pixel Format and Scan Support Check*/
 	mode_lib->ms.support.SourceFormatPixelAndScanSupport = true;
 	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
-			if (mode_lib->ms.cache_display_cfg.surface.SurfaceTiling[k] == dml_sw_linear && (!(!dml_is_vertical_rotation(mode_lib->ms.cache_display_cfg.plane.SourceScan[k])) || mode_lib->ms.cache_display_cfg.surface.DCCEnable[k] == true)) {
+		if (mode_lib->ms.cache_display_cfg.surface.SurfaceTiling[k] == dml_sw_linear && (!(!dml_is_vertical_rotation(mode_lib->ms.cache_display_cfg.plane.SourceScan[k])) || mode_lib->ms.cache_display_cfg.surface.DCCEnable[k] == true))
 			mode_lib->ms.support.SourceFormatPixelAndScanSupport = false;
-		}
 	}
 
 	for (k = 0; k <= mode_lib->ms.num_active_planes; k++) {
-- 
2.43.0

