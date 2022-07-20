Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4833AC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jul 2022 18:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97BB918AF1B;
	Wed, 20 Jul 2022 18:22:55 +0000 (UTC)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4625C18B8BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jul 2022 18:22:54 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx0.riseup.net (Postfix) with ESMTPS id 4Lp3wF3tVjz9rwv;
 Wed, 20 Jul 2022 18:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1658341373; bh=KyvEUNNOt89c5DCs1ya6/ygI3KKmDEEOIgjcfrJtoRY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QbxVeQ/MTkZwMHReGtpVA+zUjmfI94JwG34+puuu2OyGneKMob3JbpswzcQV+FmP5
 y8qqBcwybxLv594ZzxwRY1Hstz2bDoPtu+6XKU0mzu6Qn3y+8hbEY57L5bkJrM603h
 BvDpyXxOguW2/wjgk875P2I9M56bubu1vnho36pI=
X-Riseup-User-ID: 02B76E23F10FA68EAAD4F7A650D4B00921C5E78D8B3D7B748AEFDF6ADBD40AAB
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4Lp3w73lt6z5vgM;
 Wed, 20 Jul 2022 18:22:47 +0000 (UTC)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH 2/4] drm/amd/display: Remove duplicated
 CalculateWriteBackDISPCLK
Date: Wed, 20 Jul 2022 15:22:26 -0300
Message-Id: <20220720182228.259119-2-mairacanal@riseup.net>
In-Reply-To: <20220720182228.259119-1-mairacanal@riseup.net>
References: <20220720182228.259119-1-mairacanal@riseup.net>
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

The functions dml30_CalculateWriteBackDISPCLK and
dml31_CalculateWriteBackDISPCLK are identical. Therefor, to avoid
code duplication, dml31_CalculateWriteBackDISPCLK is removed and
replaced by dml30_CalculateWriteBackDISPCLK.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 .../dc/dml/dcn31/display_mode_vba_31.c        | 24 ++-----------------
 .../dc/dml/dcn31/display_mode_vba_31.h        | 11 ---------
 2 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 3fab19134480..3bc529f0b0fc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -2085,7 +2085,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 		if (v->WritebackEnable[k]) {
 			v->WritebackDISPCLK = dml_max(
 					v->WritebackDISPCLK,
-					dml31_CalculateWriteBackDISPCLK(
+					dml30_CalculateWriteBackDISPCLK(
 							v->WritebackPixelFormat[k],
 							v->PixelClock[k],
 							v->WritebackHRatio[k],
@@ -3470,26 +3470,6 @@ static double CalculateTWait(unsigned int PrefetchMode, double DRAMClockChangeLa
 	}
 }
 
-double dml31_CalculateWriteBackDISPCLK(
-		enum source_format_class WritebackPixelFormat,
-		double PixelClock,
-		double WritebackHRatio,
-		double WritebackVRatio,
-		unsigned int WritebackHTaps,
-		unsigned int WritebackVTaps,
-		long WritebackSourceWidth,
-		long WritebackDestinationWidth,
-		unsigned int HTotal,
-		unsigned int WritebackLineBufferSize)
-{
-	double DISPCLK_H, DISPCLK_V, DISPCLK_HB;
-
-	DISPCLK_H = PixelClock * dml_ceil(WritebackHTaps / 8.0, 1) / WritebackHRatio;
-	DISPCLK_V = PixelClock * (WritebackVTaps * dml_ceil(WritebackDestinationWidth / 6.0, 1) + 8.0) / HTotal;
-	DISPCLK_HB = PixelClock * WritebackVTaps * (WritebackDestinationWidth * WritebackVTaps - WritebackLineBufferSize / 57.0) / 6.0 / WritebackSourceWidth;
-	return dml_max3(DISPCLK_H, DISPCLK_V, DISPCLK_HB);
-}
-
 static double CalculateWriteBackDelay(
 		enum source_format_class WritebackPixelFormat,
 		double WritebackHRatio,
@@ -4055,7 +4035,7 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		if (v->WritebackEnable[k] == true) {
 			v->WritebackRequiredDISPCLK = dml_max(
 					v->WritebackRequiredDISPCLK,
-					dml31_CalculateWriteBackDISPCLK(
+					dml30_CalculateWriteBackDISPCLK(
 							v->WritebackPixelFormat[k],
 							v->PixelClock[k],
 							v->WritebackHRatio[k],
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.h b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.h
index 90be612f26b2..654362adcaa9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.h
@@ -28,16 +28,5 @@
 
 void dml31_recalculate(struct display_mode_lib *mode_lib);
 void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib);
-double dml31_CalculateWriteBackDISPCLK(
-		enum source_format_class WritebackPixelFormat,
-		double PixelClock,
-		double WritebackHRatio,
-		double WritebackVRatio,
-		unsigned int WritebackHTaps,
-		unsigned int WritebackVTaps,
-		long   WritebackSourceWidth,
-		long   WritebackDestinationWidth,
-		unsigned int HTotal,
-		unsigned int WritebackLineBufferSize);
 
 #endif /* __DML31_DISPLAY_MODE_VBA_H__ */
-- 
2.36.1

