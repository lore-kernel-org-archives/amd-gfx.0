Return-Path: <SRS0=bavc=6T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548EFC47247
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 13:32:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C890206A5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 13:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C890206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5E8A6E0D7;
	Tue,  5 May 2020 13:32:51 +0000 (UTC)
X-Greylist: delayed 316 seconds by postgrey-1.36 at gabe;
 Tue, 05 May 2020 13:32:50 UTC
Received: from citapm.icyb.net.ua (citapm.icyb.net.ua [212.40.38.140])
 by gabe.freedesktop.org (Postfix) with ESMTP id 3EC956E243
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2020 13:32:50 +0000 (UTC)
Received: from porto.starpoint.kiev.ua (porto-e.starpoint.kiev.ua
 [212.40.38.100])
 by citapm.icyb.net.ua (8.8.8p3/ICyb-2.3exp) with ESMTP id QAA29545;
 Tue, 05 May 2020 16:27:31 +0300 (EEST)
 (envelope-from avg@icyb.net.ua)
Received: from localhost ([127.0.0.1])
 by porto.starpoint.kiev.ua with esmtp (Exim 4.34 (FreeBSD))
 id 1jVxbf-000Jjt-GY; Tue, 05 May 2020 16:27:31 +0300
From: Andriy Gapon <avg@FreeBSD.org>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] amdgpu_acpi: add backlight control for the DC case
Date: Tue,  5 May 2020 16:27:29 +0300
Message-Id: <20200505132729.39420-1-avg@FreeBSD.org>
X-Mailer: git-send-email 2.22.0
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
Cc: Alex Deucher <alexdeucher@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This uses backlight_device_set_brightness() to set the brightness
level requested via ATIF.

Signed-off-by: Andriy Gapon <avg@FreeBSD.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 1e41367ef74ee..a8157a5154243 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -444,7 +444,6 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
 
 		DRM_DEBUG_DRIVER("ATIF: %d pending SBIOS requests\n", count);
 
-		/* todo: add DC handling */
 		if ((req.pending & ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST) &&
 		    !amdgpu_device_has_dc_support(adev)) {
 			struct amdgpu_encoder *enc = atif->encoder_for_bl;
@@ -463,6 +462,25 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
 #endif
 			}
 		}
+#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
+		if ((req.pending & ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST) &&
+		    amdgpu_device_has_dc_support(adev)) {
+			struct amdgpu_display_manager *dm = &adev->dm;
+			struct backlight_device *bd = dm->backlight_dev;
+
+			if (bd) {
+				DRM_DEBUG_DRIVER("Changing brightness to %d\n",
+						 req.backlight_level);
+
+				/*
+				 * XXX backlight_device_set_brightness() is
+				 * hardwired to post BACKLIGHT_UPDATE_SYSFS.
+				 * It probably should accept 'reason' parameter.
+				 */
+				backlight_device_set_brightness(bd, req.backlight_level);
+			}
+		}
+#endif
 		if (req.pending & ATIF_DGPU_DISPLAY_EVENT) {
 			if (adev->flags & AMD_IS_PX) {
 				pm_runtime_get_sync(adev->ddev->dev);
-- 
2.22.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
