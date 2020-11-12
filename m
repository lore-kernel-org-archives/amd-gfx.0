Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BA4C2D0A3
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 13:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B46142068D
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 13:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46142068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29F776E247;
	Thu, 12 Nov 2020 13:21:32 +0000 (UTC)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 294276E22F;
 Thu, 12 Nov 2020 13:21:31 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 55286AD60;
 Thu, 12 Nov 2020 13:21:29 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org
Subject: [PATCH 7/7] drm/radeon: Move radeon_align_pitch() next to its only
 caller
Date: Thu, 12 Nov 2020 14:21:17 +0100
Message-Id: <20201112132117.27228-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201112132117.27228-1-tzimmermann@suse.de>
References: <20201112132117.27228-1-tzimmermann@suse.de>
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
Cc: Thomas Zimmermann <tzimmermann@suse.de>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allows to declare the function as static. The tiled parameter is always
false, so it is being removed.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/radeon/radeon_fb.c   | 24 ------------------------
 drivers/gpu/drm/radeon/radeon_gem.c  | 26 +++++++++++++++++++++++++-
 drivers/gpu/drm/radeon/radeon_mode.h |  2 --
 3 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_fb.c b/drivers/gpu/drm/radeon/radeon_fb.c
index c687d14a1b93..0b89dd4f4af6 100644
--- a/drivers/gpu/drm/radeon/radeon_fb.c
+++ b/drivers/gpu/drm/radeon/radeon_fb.c
@@ -30,30 +30,6 @@
 
 #include "radeon.h"
 
-int radeon_align_pitch(struct radeon_device *rdev, int width, int cpp, bool tiled)
-{
-	int aligned = width;
-	int align_large = (ASIC_IS_AVIVO(rdev)) || tiled;
-	int pitch_mask = 0;
-
-	switch (cpp) {
-	case 1:
-		pitch_mask = align_large ? 255 : 127;
-		break;
-	case 2:
-		pitch_mask = align_large ? 127 : 31;
-		break;
-	case 3:
-	case 4:
-		pitch_mask = align_large ? 63 : 15;
-		break;
-	}
-
-	aligned += pitch_mask;
-	aligned &= ~pitch_mask;
-	return aligned * cpp;
-}
-
 void radeon_fbdev_init(struct radeon_device *rdev)
 {
 	struct drm_device *ddev = rdev->ddev;
diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index eaf7fc9a7b07..e19956c3309f 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -816,6 +816,30 @@ int radeon_gem_op_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
+static int radeon_align_pitch(struct radeon_device *rdev, int width, int cpp)
+{
+	int aligned = width;
+	int align_large = ASIC_IS_AVIVO(rdev);
+	int pitch_mask = 0;
+
+	switch (cpp) {
+	case 1:
+		pitch_mask = align_large ? 255 : 127;
+		break;
+	case 2:
+		pitch_mask = align_large ? 127 : 31;
+		break;
+	case 3:
+	case 4:
+		pitch_mask = align_large ? 63 : 15;
+		break;
+	}
+
+	aligned += pitch_mask;
+	aligned &= ~pitch_mask;
+	return aligned * cpp;
+}
+
 int radeon_mode_dumb_create(struct drm_file *file_priv,
 			    struct drm_device *dev,
 			    struct drm_mode_create_dumb *args)
@@ -826,7 +850,7 @@ int radeon_mode_dumb_create(struct drm_file *file_priv,
 	int r;
 
 	args->pitch = radeon_align_pitch(rdev, args->width,
-					 DIV_ROUND_UP(args->bpp, 8), 0);
+					 DIV_ROUND_UP(args->bpp, 8));
 	args->size = args->pitch * args->height;
 	args->size = ALIGN(args->size, PAGE_SIZE);
 
diff --git a/drivers/gpu/drm/radeon/radeon_mode.h b/drivers/gpu/drm/radeon/radeon_mode.h
index 197423ad42c1..50ba2b5edb93 100644
--- a/drivers/gpu/drm/radeon/radeon_mode.h
+++ b/drivers/gpu/drm/radeon/radeon_mode.h
@@ -982,8 +982,6 @@ void radeon_crtc_handle_vblank(struct radeon_device *rdev, int crtc_id);
 
 void radeon_crtc_handle_flip(struct radeon_device *rdev, int crtc_id);
 
-int radeon_align_pitch(struct radeon_device *rdev, int width, int bpp, bool tiled);
-
 /* mst */
 int radeon_dp_mst_init(struct radeon_connector *radeon_connector);
 int radeon_dp_mst_probe(struct radeon_connector *radeon_connector);
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
