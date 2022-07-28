Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F9BC19F2B
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 18:23:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F227210E38E;
	Thu, 28 Jul 2022 18:23:05 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B477E10E71A
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 18:22:41 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4LtzXK01DLzDs0B;
 Thu, 28 Jul 2022 18:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1659032561; bh=FyrTULDUjyHGwlKFXrAzhhgN/h2/e4OL5Wz+Mjczc+0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dK75nsGugzCU2x/Joq/noP+7wj8EMcO0ZNrMppP6awgvGflvDbvdaX7wbcTsZvyrO
 +I2A4aJR0bt+R9AdURU/SzjpRCOaV1tCS/XU3h4Q7ljvQJTxaVcj+fGYlcWM8mt+7J
 0JJWbRPBmOnij9ZcHHx/j36GfYmldOKoK0ik8zqM=
X-Riseup-User-ID: DB8DA08FA5CFC323C5D417C811618355A6AA7C67129E314DB8EC4AB602387803
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4LtzXC3M2Hz5vMX;
 Thu, 28 Jul 2022 18:22:35 +0000 (UTC)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 09/16] drm/amd/display: Remove SwathWidthCSingleDPP VBA
 variable
Date: Thu, 28 Jul 2022 15:20:41 -0300
Message-Id: <20220728182047.264825-10-mairacanal@riseup.net>
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

The SwathWidthCSingleDPP variable from the struct vba_vars_st is only
used on assignments, so its value is not used on code. So, remove the
SwathWidthCSingleDPP entry from the struct vba_vars_st.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c  | 2 --
 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c  | 2 --
 .../gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c    | 2 --
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c  | 2 --
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h           | 1 -
 5 files changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index caa3a9c598ce..4fac83c776ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -3660,10 +3660,8 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
 		if (v->SourceScan[k] != dm_vert) {
 			v->SwathWidthYSingleDPP[k] = v->ViewportWidth[k];
-			v->SwathWidthCSingleDPP[k] = v->ViewportWidthChroma[k];
 		} else {
 			v->SwathWidthYSingleDPP[k] = v->ViewportHeight[k];
-			v->SwathWidthCSingleDPP[k] = v->ViewportHeightChroma[k];
 		}
 	}
 	for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index eca05bbc0fb5..9ea2d2fd56f1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -3965,10 +3965,8 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	for (k = 0; k < v->NumberOfActivePlanes; k++) {
 		if (v->SourceScan[k] != dm_vert) {
 			v->SwathWidthYSingleDPP[k] = v->ViewportWidth[k];
-			v->SwathWidthCSingleDPP[k] = v->ViewportWidthChroma[k];
 		} else {
 			v->SwathWidthYSingleDPP[k] = v->ViewportHeight[k];
-			v->SwathWidthCSingleDPP[k] = v->ViewportHeightChroma[k];
 		}
 	}
 	for (k = 0; k < v->NumberOfActivePlanes; k++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index acb47cdaaa05..ae749d39db2a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -4077,10 +4077,8 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 	for (k = 0; k < v->NumberOfActivePlanes; k++) {
 		if (v->SourceScan[k] != dm_vert) {
 			v->SwathWidthYSingleDPP[k] = v->ViewportWidth[k];
-			v->SwathWidthCSingleDPP[k] = v->ViewportWidthChroma[k];
 		} else {
 			v->SwathWidthYSingleDPP[k] = v->ViewportHeight[k];
-			v->SwathWidthCSingleDPP[k] = v->ViewportHeightChroma[k];
 		}
 	}
 	for (k = 0; k < v->NumberOfActivePlanes; k++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 756a55f69799..a88cfce3b771 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -1721,10 +1721,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
 		if (!IsVertical(mode_lib->vba.SourceRotation[k])) {
 			v->SwathWidthYSingleDPP[k] = mode_lib->vba.ViewportWidth[k];
-			v->SwathWidthCSingleDPP[k] = mode_lib->vba.ViewportWidthChroma[k];
 		} else {
 			v->SwathWidthYSingleDPP[k] = mode_lib->vba.ViewportHeight[k];
-			v->SwathWidthCSingleDPP[k] = mode_lib->vba.ViewportHeightChroma[k];
 		}
 	}
 	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 91562c0d35f2..ac8131b52b78 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -939,7 +939,6 @@ struct vba_vars_st {
 
 
 	bool           MPCCombine[DC__VOLTAGE_STATES][2][DC__NUM_DPP__MAX];
-	double         SwathWidthCSingleDPP[DC__NUM_DPP__MAX];
 	double         MaximumSwathWidthInLineBufferLuma;
 	double         MaximumSwathWidthInLineBufferChroma;
 	double         MaximumSwathWidthLuma[DC__NUM_DPP__MAX];
-- 
2.37.1

