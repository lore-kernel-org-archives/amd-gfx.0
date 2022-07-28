Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBFFC04A68
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 18:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A313D10E478;
	Thu, 28 Jul 2022 18:23:05 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FDAF10E46B
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 18:22:34 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4LtzX94vkSzDryt;
 Thu, 28 Jul 2022 18:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1659032553; bh=zE+o6ufPkkpuK2HCBtOVfWw99bIfiN4ZlL3ielUoD0o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ur3f9RtzAko6ST0qePBuaZMGUYhXFfNn9015p/5+EdOfGscQf5OKHaGqMnZ+aAAPS
 OntM82BJd0GVWEXgJ+iWe800uwvVBykfj3+BQunX2AwIL5H5b8Fs9lM++BccE9OiVq
 64cz7aYD9EpJdKwkggu7XpLUjpQWKMwfpoPEPR0o=
X-Riseup-User-ID: 0D1B0215170A3491065454787D6596993FB14755A662347E4A01025C16C63E5C
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4LtzX46bQJz5vMX;
 Thu, 28 Jul 2022 18:22:28 +0000 (UTC)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 08/16] drm/amd/display: Remove some XFC variables from VBA
Date: Thu, 28 Jul 2022 15:20:40 -0300
Message-Id: <20220728182047.264825-9-mairacanal@riseup.net>
In-Reply-To: <20220728182047.264825-1-mairacanal@riseup.net>
References: <20220728182047.264825-1-mairacanal@riseup.net>
MIME-Version: 1.0
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
Cc: magalilemes00@gmail.com, tales.aparecida@gmail.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, mwen@igalia.com,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
 Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The variables XFCSupported, XFCTSlvVupdateOffset, XFCSlaveVupdateWidth,
XFCSlaveVReadyOffset, XFCTransferDelay, XFCPrechargeDelay,
XFCRemoteSurfaceFlipLatency and XFCPrefetchMargin are are only
used on assignments, so their values are not used on code. So, remove
the variables entries from the struct vba_vars_st.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 .../dc/dml/dcn20/display_mode_vba_20.c        | 38 -------------------
 .../dc/dml/dcn20/display_mode_vba_20v2.c      | 38 -------------------
 .../dc/dml/dcn21/display_mode_vba_21.c        | 38 -------------------
 .../drm/amd/display/dc/dml/display_mode_vba.c |  1 -
 .../drm/amd/display/dc/dml/display_mode_vba.h |  8 ----
 5 files changed, 123 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
index 1424aa7a5018..7effe4be61b2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
@@ -2580,9 +2580,6 @@ static void dml20_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPer
 		if (mode_lib->vba.XFCEnabled[k] == true) {
 			double TWait;
 
-			mode_lib->vba.XFCSlaveVUpdateOffset[k] = mode_lib->vba.XFCTSlvVupdateOffset;
-			mode_lib->vba.XFCSlaveVupdateWidth[k] = mode_lib->vba.XFCTSlvVupdateWidth;
-			mode_lib->vba.XFCSlaveVReadyOffset[k] = mode_lib->vba.XFCTSlvVreadyOffset;
 			TWait = CalculateTWait(
 					mode_lib->vba.PrefetchMode[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb],
 					mode_lib->vba.DRAMClockChangeLatency,
@@ -2606,26 +2603,6 @@ static void dml20_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPer
 					&mode_lib->vba.SrcActiveDrainRate,
 					&mode_lib->vba.TInitXFill,
 					&mode_lib->vba.TslvChk);
-			mode_lib->vba.XFCRemoteSurfaceFlipLatency[k] =
-					dml_floor(
-							mode_lib->vba.XFCRemoteSurfaceFlipDelay
-									/ (mode_lib->vba.HTotal[k]
-											/ mode_lib->vba.PixelClock[k]),
-							1);
-			mode_lib->vba.XFCTransferDelay[k] =
-					dml_ceil(
-							mode_lib->vba.XFCBusTransportTime
-									/ (mode_lib->vba.HTotal[k]
-											/ mode_lib->vba.PixelClock[k]),
-							1);
-			mode_lib->vba.XFCPrechargeDelay[k] =
-					dml_ceil(
-							(mode_lib->vba.XFCBusTransportTime
-									+ mode_lib->vba.TInitXFill
-									+ mode_lib->vba.TslvChk)
-									/ (mode_lib->vba.HTotal[k]
-											/ mode_lib->vba.PixelClock[k]),
-							1);
 			mode_lib->vba.InitFillLevel = mode_lib->vba.XFCXBUFLatencyTolerance
 					* mode_lib->vba.SrcActiveDrainRate;
 			mode_lib->vba.FinalFillMargin =
@@ -2644,21 +2621,6 @@ static void dml20_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPer
 			mode_lib->vba.TFinalxFill = mode_lib->vba.RemainingFillLevel
 					/ (mode_lib->vba.SrcActiveDrainRate
 							* mode_lib->vba.XFCFillBWOverhead / 100);
-			mode_lib->vba.XFCPrefetchMargin[k] =
-					mode_lib->vba.XFCRemoteSurfaceFlipDelay
-							+ mode_lib->vba.TFinalxFill
-							+ (mode_lib->vba.DestinationLinesToRequestVMInVBlank[k]
-									+ mode_lib->vba.DestinationLinesToRequestRowInVBlank[k])
-									* mode_lib->vba.HTotal[k]
-									/ mode_lib->vba.PixelClock[k];
-		} else {
-			mode_lib->vba.XFCSlaveVUpdateOffset[k] = 0;
-			mode_lib->vba.XFCSlaveVupdateWidth[k] = 0;
-			mode_lib->vba.XFCSlaveVReadyOffset[k] = 0;
-			mode_lib->vba.XFCRemoteSurfaceFlipLatency[k] = 0;
-			mode_lib->vba.XFCPrechargeDelay[k] = 0;
-			mode_lib->vba.XFCTransferDelay[k] = 0;
-			mode_lib->vba.XFCPrefetchMargin[k] = 0;
 		}
 	}
 	{
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index 03613dbb3e61..a23b400f615b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -2653,9 +2653,6 @@ static void dml20v2_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndP
 		if (mode_lib->vba.XFCEnabled[k] == true) {
 			double TWait;
 
-			mode_lib->vba.XFCSlaveVUpdateOffset[k] = mode_lib->vba.XFCTSlvVupdateOffset;
-			mode_lib->vba.XFCSlaveVupdateWidth[k] = mode_lib->vba.XFCTSlvVupdateWidth;
-			mode_lib->vba.XFCSlaveVReadyOffset[k] = mode_lib->vba.XFCTSlvVreadyOffset;
 			TWait = CalculateTWait(
 					mode_lib->vba.PrefetchMode[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb],
 					mode_lib->vba.DRAMClockChangeLatency,
@@ -2679,26 +2676,6 @@ static void dml20v2_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndP
 					&mode_lib->vba.SrcActiveDrainRate,
 					&mode_lib->vba.TInitXFill,
 					&mode_lib->vba.TslvChk);
-			mode_lib->vba.XFCRemoteSurfaceFlipLatency[k] =
-					dml_floor(
-							mode_lib->vba.XFCRemoteSurfaceFlipDelay
-									/ (mode_lib->vba.HTotal[k]
-											/ mode_lib->vba.PixelClock[k]),
-							1);
-			mode_lib->vba.XFCTransferDelay[k] =
-					dml_ceil(
-							mode_lib->vba.XFCBusTransportTime
-									/ (mode_lib->vba.HTotal[k]
-											/ mode_lib->vba.PixelClock[k]),
-							1);
-			mode_lib->vba.XFCPrechargeDelay[k] =
-					dml_ceil(
-							(mode_lib->vba.XFCBusTransportTime
-									+ mode_lib->vba.TInitXFill
-									+ mode_lib->vba.TslvChk)
-									/ (mode_lib->vba.HTotal[k]
-											/ mode_lib->vba.PixelClock[k]),
-							1);
 			mode_lib->vba.InitFillLevel = mode_lib->vba.XFCXBUFLatencyTolerance
 					* mode_lib->vba.SrcActiveDrainRate;
 			mode_lib->vba.FinalFillMargin =
@@ -2717,21 +2694,6 @@ static void dml20v2_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndP
 			mode_lib->vba.TFinalxFill = mode_lib->vba.RemainingFillLevel
 					/ (mode_lib->vba.SrcActiveDrainRate
 							* mode_lib->vba.XFCFillBWOverhead / 100);
-			mode_lib->vba.XFCPrefetchMargin[k] =
-					mode_lib->vba.XFCRemoteSurfaceFlipDelay
-							+ mode_lib->vba.TFinalxFill
-							+ (mode_lib->vba.DestinationLinesToRequestVMInVBlank[k]
-									+ mode_lib->vba.DestinationLinesToRequestRowInVBlank[k])
-									* mode_lib->vba.HTotal[k]
-									/ mode_lib->vba.PixelClock[k];
-		} else {
-			mode_lib->vba.XFCSlaveVUpdateOffset[k] = 0;
-			mode_lib->vba.XFCSlaveVupdateWidth[k] = 0;
-			mode_lib->vba.XFCSlaveVReadyOffset[k] = 0;
-			mode_lib->vba.XFCRemoteSurfaceFlipLatency[k] = 0;
-			mode_lib->vba.XFCPrechargeDelay[k] = 0;
-			mode_lib->vba.XFCTransferDelay[k] = 0;
-			mode_lib->vba.XFCPrefetchMargin[k] = 0;
 		}
 	}
 	{
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index ae03f1a3c9f0..4ba9fa17ea39 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -2589,9 +2589,6 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 		if (mode_lib->vba.XFCEnabled[k] == true) {
 			double TWait;
 
-			locals->XFCSlaveVUpdateOffset[k] = mode_lib->vba.XFCTSlvVupdateOffset;
-			locals->XFCSlaveVupdateWidth[k] = mode_lib->vba.XFCTSlvVupdateWidth;
-			locals->XFCSlaveVReadyOffset[k] = mode_lib->vba.XFCTSlvVreadyOffset;
 			TWait = CalculateTWait(
 					mode_lib->vba.PrefetchMode[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb],
 					mode_lib->vba.DRAMClockChangeLatency,
@@ -2615,26 +2612,6 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 					&mode_lib->vba.SrcActiveDrainRate,
 					&mode_lib->vba.TInitXFill,
 					&mode_lib->vba.TslvChk);
-					locals->XFCRemoteSurfaceFlipLatency[k] =
-					dml_floor(
-							mode_lib->vba.XFCRemoteSurfaceFlipDelay
-									/ (mode_lib->vba.HTotal[k]
-											/ mode_lib->vba.PixelClock[k]),
-							1);
-			locals->XFCTransferDelay[k] =
-					dml_ceil(
-							mode_lib->vba.XFCBusTransportTime
-									/ (mode_lib->vba.HTotal[k]
-											/ mode_lib->vba.PixelClock[k]),
-							1);
-			locals->XFCPrechargeDelay[k] =
-					dml_ceil(
-							(mode_lib->vba.XFCBusTransportTime
-									+ mode_lib->vba.TInitXFill
-									+ mode_lib->vba.TslvChk)
-									/ (mode_lib->vba.HTotal[k]
-											/ mode_lib->vba.PixelClock[k]),
-							1);
 			mode_lib->vba.InitFillLevel = mode_lib->vba.XFCXBUFLatencyTolerance
 					* mode_lib->vba.SrcActiveDrainRate;
 			mode_lib->vba.FinalFillMargin =
@@ -2653,21 +2630,6 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 			mode_lib->vba.TFinalxFill = mode_lib->vba.RemainingFillLevel
 					/ (mode_lib->vba.SrcActiveDrainRate
 							* mode_lib->vba.XFCFillBWOverhead / 100);
-			locals->XFCPrefetchMargin[k] =
-					mode_lib->vba.XFCRemoteSurfaceFlipDelay
-							+ mode_lib->vba.TFinalxFill
-							+ (locals->DestinationLinesToRequestVMInVBlank[k]
-									+ locals->DestinationLinesToRequestRowInVBlank[k])
-									* mode_lib->vba.HTotal[k]
-									/ mode_lib->vba.PixelClock[k];
-		} else {
-			locals->XFCSlaveVUpdateOffset[k] = 0;
-			locals->XFCSlaveVupdateWidth[k] = 0;
-			locals->XFCSlaveVReadyOffset[k] = 0;
-			locals->XFCRemoteSurfaceFlipLatency[k] = 0;
-			locals->XFCPrechargeDelay[k] = 0;
-			locals->XFCTransferDelay[k] = 0;
-			locals->XFCPrefetchMargin[k] = 0;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 316153ece160..7a4a013f195a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -489,7 +489,6 @@ static void fetch_ip_params(struct display_mode_lib *mode_lib)
 	mode_lib->vba.ODMCapability = ip->odm_capable;
 	mode_lib->vba.DISPCLKRampingMargin = ip->dispclk_ramp_margin_percent;
 
-	mode_lib->vba.XFCSupported = ip->xfc_supported;
 	mode_lib->vba.XFCFillBWOverhead = ip->xfc_fill_bw_overhead_percent;
 	mode_lib->vba.XFCFillConstant = ip->xfc_fill_constant_bytes;
 	mode_lib->vba.DPPCLKDelaySubtotal = ip->dppclk_delay_subtotal;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 518e599d74e2..91562c0d35f2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -497,7 +497,6 @@ struct vba_vars_st {
 	unsigned int PTEBufferSizeInRequestsChroma;
 	double DISPCLKRampingMargin;
 	unsigned int MaxInterDCNTileRepeaters;
-	bool XFCSupported;
 	double XFCSlvChunkSize;
 	double XFCFillBWOverhead;
 	double XFCFillConstant;
@@ -1041,13 +1040,6 @@ struct vba_vars_st {
 	unsigned int BlockHeight256BytesC[DC__NUM_DPP__MAX];
 	unsigned int BlockWidth256BytesY[DC__NUM_DPP__MAX];
 	unsigned int BlockWidth256BytesC[DC__NUM_DPP__MAX];
-	double XFCSlaveVUpdateOffset[DC__NUM_DPP__MAX];
-	double XFCSlaveVupdateWidth[DC__NUM_DPP__MAX];
-	double XFCSlaveVReadyOffset[DC__NUM_DPP__MAX];
-	double XFCTransferDelay[DC__NUM_DPP__MAX];
-	double XFCPrechargeDelay[DC__NUM_DPP__MAX];
-	double XFCRemoteSurfaceFlipLatency[DC__NUM_DPP__MAX];
-	double XFCPrefetchMargin[DC__NUM_DPP__MAX];
 	unsigned int dpte_row_width_luma_ub[DC__NUM_DPP__MAX];
 	unsigned int dpte_row_width_chroma_ub[DC__NUM_DPP__MAX];
 	double FullDETBufferingTimeY[DC__NUM_DPP__MAX];                     // WM
-- 
2.37.1

