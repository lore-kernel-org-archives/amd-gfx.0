Return-Path: <SRS0=bavc=6T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5E6C47247
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 19:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D0F620721
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 19:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HljUOzmT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0F620721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 110106E0F7;
	Tue,  5 May 2020 19:48:23 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 025756E0F7
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2020 19:48:21 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id i68so3102571qtb.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 May 2020 12:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=e2L/ntxLMpdecbMrXCGjNswIgq6ip+GHV3cqbF5RM64=;
 b=HljUOzmTVVcctzRVxsoZHjU4k+iTu7jwbMLc03dnTYFO4wNt5B6fAx0BFu8L0a1OSC
 2G8CZaQmZS7PamYKyX/9GfUCCyaomqWO/xOaC7xTkyDuNBbaxifUnxqWx6FmeNgHLgry
 iDbv5g9NRi9/ylwsX2skGIri3NmquywxVRQPr/QME2FUCMJ36oOEUucJQGYQTD145iTE
 jdFTNoQmnk9ABekG8+/0Q4ku7JX5txR/xuGe+DqlVHLMlxY/jdhU2YvPfy2qp2loPYQn
 D8Jj0hxbvXOzWmZvjNem5GmZqX/0+duKeW1VDkQmFLe/K8D20j5sHwXliJwudxFTJzYh
 jeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=e2L/ntxLMpdecbMrXCGjNswIgq6ip+GHV3cqbF5RM64=;
 b=F8VOr1E4/tkRzAGZaxVE7l3zyrlPymNl8mxTszYsApx/aRwJgrQSnkNvsgLmzub0Z5
 7UiyVlVGrkhv7BYWBfk/vzMP/TZ8j0s2wAtBq/b9GwsQJn5wcI/FPhjXBm2/3PTfAdwe
 OJ+6VCtWw7my+KDEAPt+F4IYtW2EQ+U5nXsB0oPE7+YTFXKw/Ej447EupsxYjnlVgLuL
 EKuBu9oGnaseFGG5zthVWybnfbU0T8xbI3IFBaiQxCayZ+nUlUNMNbbmBSSv2pbHRG84
 Z7j8uC1f6oSi84yMr9mb1X7QPlfquW1na+SxqDCFvUStobHBZabV1piRBJ7SALJs5b1T
 IhuA==
X-Gm-Message-State: AGi0PuY4/kaEYVX6TcULjd0bHYifryOHWSv8q9p702P5kpjkmg1FzGny
 1TeoRpBVlc/FOh19Nur3hqfahbcY
X-Google-Smtp-Source: APiQypJFXcUZvPU23cHchVezWiM+6sakt9jIouNKvv5L1qb/oR2HL3HT8m1nWaLyDHO7RiYloFtyag==
X-Received: by 2002:aed:312a:: with SMTP id 39mr4613751qtg.6.1588708100799;
 Tue, 05 May 2020 12:48:20 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id c16sm2555670qkk.79.2020.05.05.12.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 12:48:20 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: simplify ATIF backlight handling
Date: Tue,  5 May 2020 15:48:12 -0400
Message-Id: <20200505194812.185370-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Just register the a pointer to the backlight device and use
that. Unifies the DC and non-DC handling.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 73 ++++++++++--------------
 1 file changed, 30 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 956cbbda4793..913c8f0513bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -64,7 +64,9 @@ struct amdgpu_atif {
 	struct amdgpu_atif_notifications notifications;
 	struct amdgpu_atif_functions functions;
 	struct amdgpu_atif_notification_cfg notification_cfg;
-	struct amdgpu_encoder *encoder_for_bl;
+#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
+	struct backlight_device *bd;
+#endif
 	struct amdgpu_dm_backlight_caps backlight_caps;
 };
 
@@ -444,45 +446,21 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
 
 		DRM_DEBUG_DRIVER("ATIF: %d pending SBIOS requests\n", count);
 
-		if ((req.pending & ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST) &&
-		    !amdgpu_device_has_dc_support(adev)) {
-			struct amdgpu_encoder *enc = atif->encoder_for_bl;
-
-			if (enc) {
-				struct amdgpu_encoder_atom_dig *dig = enc->enc_priv;
-
-				DRM_DEBUG_DRIVER("Changing brightness to %d\n",
-						 req.backlight_level);
-
-				amdgpu_display_backlight_set_level(adev, enc, req.backlight_level);
-
-#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
-				backlight_force_update(dig->bl_dev,
-						       BACKLIGHT_UPDATE_HOTKEY);
-#endif
-			}
-		}
-#if defined(CONFIG_DRM_AMD_DC)
+		if (req.pending & ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST) {
 #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
-		if ((req.pending & ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST) &&
-		    amdgpu_device_has_dc_support(adev)) {
-			struct amdgpu_display_manager *dm = &adev->dm;
-			struct backlight_device *bd = dm->backlight_dev;
-
-			if (bd) {
+			if (atif->bd) {
 				DRM_DEBUG_DRIVER("Changing brightness to %d\n",
 						 req.backlight_level);
-
 				/*
 				 * XXX backlight_device_set_brightness() is
 				 * hardwired to post BACKLIGHT_UPDATE_SYSFS.
 				 * It probably should accept 'reason' parameter.
 				 */
-				backlight_device_set_brightness(bd, req.backlight_level);
+				backlight_device_set_brightness(atif->bd, req.backlight_level);
 			}
-		}
-#endif
 #endif
+		}
+
 		if (req.pending & ATIF_DGPU_DISPLAY_EVENT) {
 			if (adev->flags & AMD_IS_PX) {
 				pm_runtime_get_sync(adev->ddev->dev);
@@ -829,23 +807,32 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 	adev->atif = atif;
 
 	if (atif->notifications.brightness_change) {
-		struct drm_encoder *tmp;
-
-		/* Find the encoder controlling the brightness */
-		list_for_each_entry(tmp, &adev->ddev->mode_config.encoder_list,
-				head) {
-			struct amdgpu_encoder *enc = to_amdgpu_encoder(tmp);
-
-			if ((enc->devices & (ATOM_DEVICE_LCD_SUPPORT)) &&
-			    enc->enc_priv) {
-				struct amdgpu_encoder_atom_dig *dig = enc->enc_priv;
-				if (dig->bl_dev) {
-					atif->encoder_for_bl = enc;
-					break;
+#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
+		if (amdgpu_device_has_dc_support(adev)) {
+#if defined(CONFIG_DRM_AMD_DC)
+			struct amdgpu_display_manager *dm = &adev->dm;
+			atif->bd = dm->backlight_dev;
+#endif
+		} else {
+			struct drm_encoder *tmp;
+
+			/* Find the encoder controlling the brightness */
+			list_for_each_entry(tmp, &adev->ddev->mode_config.encoder_list,
+					    head) {
+				struct amdgpu_encoder *enc = to_amdgpu_encoder(tmp);
+
+				if ((enc->devices & (ATOM_DEVICE_LCD_SUPPORT)) &&
+				    enc->enc_priv) {
+					struct amdgpu_encoder_atom_dig *dig = enc->enc_priv;
+					if (dig->bl_dev) {
+						atif->bd = dig->bl_dev;
+						break;
+					}
 				}
 			}
 		}
 	}
+#endif
 
 	if (atif->functions.sbios_requests && !atif->functions.system_params) {
 		/* XXX check this workraround, if sbios request function is
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
