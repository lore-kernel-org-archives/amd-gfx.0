Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EC4C04A68
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 18:22:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B29A10E754;
	Thu, 28 Jul 2022 18:22:19 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8258810E46B
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 18:22:15 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4LtzWp4Lt5zDrtL;
 Thu, 28 Jul 2022 18:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1659032534; bh=x7PWrdruU1/D/epM3C5CS/K+6fjcV1ng9alJKcLjSSQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Jw7yolenTr8yJvAjVDxS4c4msVW3Mcp9Lx0ohkod/NxehWmkbiYXyKiI5gymD6OEb
 eGUhd+8CHTzemwRpQLzhLWuNpYfFXxqQHs7jDDoUfoX/mlSVxQHbTPe4o68mSwQpeA
 HN7yZIrY8SjEnmw9+KSH+FLWKLlO9yPqtVoLfN0s=
X-Riseup-User-ID: 5B549052130933BFDB8282CA5799D6AD0E04851D2EE03AEB5CEAC24D3FD3FC4C
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4LtzWj6bfWz5vMX;
 Thu, 28 Jul 2022 18:22:09 +0000 (UTC)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 05/16] drm/amd/display: Remove VStartupMargin and
 FirstMainPlane VBA variables
Date: Thu, 28 Jul 2022 15:20:37 -0300
Message-Id: <20220728182047.264825-6-mairacanal@riseup.net>
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

The variables VStartupMargin and FirstMainPlane from the struct
vba_vars_st are only used on assignments, so there values are not used
on code. So, remove the variables entries from the struct vba_vars_st.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 .../display/dc/dml/dcn20/display_mode_vba_20.c  | 14 +++-----------
 .../dc/dml/dcn20/display_mode_vba_20v2.c        | 14 +++-----------
 .../display/dc/dml/dcn30/display_mode_vba_30.c  | 17 ++++++-----------
 .../drm/amd/display/dc/dml/display_mode_vba.h   |  2 --
 4 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
index d86d5c346e42..1424aa7a5018 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
@@ -2662,19 +2662,12 @@ static void dml20_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPer
 		}
 	}
 	{
-		unsigned int VStartupMargin = 0;
 		bool FirstMainPlane = true;
 
 		for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
-			if (mode_lib->vba.BlendingAndTiming[k] == k) {
-				unsigned int Margin = (mode_lib->vba.MaxVStartupLines[k] - mode_lib->vba.VStartup[k])
-						* mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k];
-
-				if (FirstMainPlane) {
-					VStartupMargin = Margin;
-					FirstMainPlane = false;
-				} else
-					VStartupMargin = dml_min(VStartupMargin, Margin);
+			if (mode_lib->vba.BlendingAndTiming[k] == k && FirstMainPlane) {
+				FirstMainPlane = false;
+			}
 		}
 
 		if (mode_lib->vba.UseMaximumVStartup) {
@@ -2685,7 +2678,6 @@ static void dml20_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPer
 		}
 	}
 }
-}
 
 static void dml20_DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index effd02574a0e..03613dbb3e61 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -2735,19 +2735,12 @@ static void dml20v2_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndP
 		}
 	}
 	{
-		unsigned int VStartupMargin = 0;
 		bool FirstMainPlane = true;
 
 		for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
-			if (mode_lib->vba.BlendingAndTiming[k] == k) {
-				unsigned int Margin = (mode_lib->vba.MaxVStartupLines[k] - mode_lib->vba.VStartup[k])
-						* mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k];
-
-				if (FirstMainPlane) {
-					VStartupMargin = Margin;
-					FirstMainPlane = false;
-				} else
-					VStartupMargin = dml_min(VStartupMargin, Margin);
+			if (mode_lib->vba.BlendingAndTiming[k] == k && FirstMainPlane) {
+				FirstMainPlane = false;
+			}
 		}
 
 		if (mode_lib->vba.UseMaximumVStartup) {
@@ -2758,7 +2751,6 @@ static void dml20v2_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndP
 		}
 	}
 }
-}
 
 static void dml20v2_DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index fe7fcb0d7b1f..caa3a9c598ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -3028,17 +3028,12 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 	}
 
 	// VStartup Margin
-	v->VStartupMargin = 0;
-	v->FirstMainPlane = true;
-	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
-		if (v->BlendingAndTiming[k] == k) {
-			double margin = (v->MaxVStartupLines[k] - v->VStartup[k]) * v->HTotal[k]
-					/ v->PixelClock[k];
-			if (v->FirstMainPlane == true) {
-				v->VStartupMargin = margin;
-				v->FirstMainPlane = false;
-			} else {
-				v->VStartupMargin = dml_min(v->VStartupMargin, margin);
+	{
+		bool FirstMainPlane = true;
+
+		for (k = 0; k < v->NumberOfActivePlanes; ++k) {
+			if (v->BlendingAndTiming[k] == k && FirstMainPlane) {
+				FirstMainPlane = false;
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index f03cf9cf9096..841a05bea57e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -1106,7 +1106,6 @@ struct vba_vars_st {
 	double TimePerChromaMetaChunkFlip[DC__NUM_DPP__MAX];
 	unsigned int DCCCMaxUncompressedBlock[DC__NUM_DPP__MAX];
 	unsigned int DCCCMaxCompressedBlock[DC__NUM_DPP__MAX];
-	double VStartupMargin;
 	bool NotEnoughTimeForDynamicMetadata[DC__NUM_DPP__MAX];
 
 	/* Missing from VBA */
@@ -1137,7 +1136,6 @@ struct vba_vars_st {
 	double MinUrgentLatencySupportUs;
 	double MinFullDETBufferingTime;
 	double AverageReadBandwidthGBytePerSecond;
-	bool   FirstMainPlane;
 
 	unsigned int ViewportWidthChroma[DC__NUM_DPP__MAX];
 	unsigned int ViewportHeightChroma[DC__NUM_DPP__MAX];
-- 
2.37.1

