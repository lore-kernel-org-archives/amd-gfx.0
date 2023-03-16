Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5784DC6FD1F
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Mar 2023 09:38:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E86110E17C;
	Thu, 16 Mar 2023 09:37:46 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4E1F10E085;
 Thu, 16 Mar 2023 09:37:42 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5C7D621A39;
 Thu, 16 Mar 2023 09:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1678959461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VdfdImAALmYqQK/fNzoqdK4D2AvJSanUDurBM1P3x8A=;
 b=KmAauakm6NrWeEqvhl2vp6VeKE5iF3BQmLCZjq/ku1/tjjvQNMLCfph2qv6nqjbAPfHI6t
 smvpp7huhqIcEK1ZfoWzAyqyCIO0QwsjUE5cCqPw+EA29REDa3ug2hnfu3Vb5oKVmh1nlM
 C+bLQq29zGaDVqa52fcyhBqg40IrtZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1678959461;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VdfdImAALmYqQK/fNzoqdK4D2AvJSanUDurBM1P3x8A=;
 b=zvgxOUywr6UAX5nZKh48VxTfrv8asToveS5kPnq717dG5bOtLumG/YHUCb0wQcxqvrZ6l0
 eBaViQrRNE7p/GCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 304F0133E0;
 Thu, 16 Mar 2023 09:37:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8BHzCmXjEmSORwAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Thu, 16 Mar 2023 09:37:41 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, javierm@redhat.com
Subject: [PATCH 07/10] drm/radeon: Move fbdev cleanup code into fb_destroy
 callback
Date: Thu, 16 Mar 2023 10:37:35 +0100
Message-Id: <20230316093738.28866-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230316093738.28866-1-tzimmermann@suse.de>
References: <20230316093738.28866-1-tzimmermann@suse.de>
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
Cc: Thomas Zimmermann <tzimmermann@suse.de>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fbdev calls struct fb_ops.fb_destroy after cleaning up the final
reference to an fbdev framebuffer. Move radeon's fbdev cleanup code
there.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/radeon/radeon_fb.c | 43 +++++++++++++++---------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_fb.c b/drivers/gpu/drm/radeon/radeon_fb.c
index f55aaea10406..d85f99b5aa49 100644
--- a/drivers/gpu/drm/radeon/radeon_fb.c
+++ b/drivers/gpu/drm/radeon/radeon_fb.c
@@ -173,6 +173,25 @@ static int radeon_fbdev_fb_release(struct fb_info *info, int user)
 	return 0;
 }
 
+static void radeon_fbdev_fb_destroy(struct fb_info *info)
+{
+	struct drm_fb_helper *fb_helper = info->par;
+	struct drm_framebuffer *fb = fb_helper->fb;
+
+	if (fb) {
+		if (fb->obj[0]) {
+			radeon_fbdev_destroy_pinned_object(fb->obj[0]);
+			fb->obj[0] = NULL;
+			drm_framebuffer_unregister_private(fb);
+			drm_framebuffer_cleanup(fb);
+		}
+		kfree(fb);
+		fb_helper->fb = NULL;
+	}
+
+	drm_fb_helper_fini(fb_helper);
+}
+
 static const struct fb_ops radeon_fbdev_fb_ops = {
 	.owner = THIS_MODULE,
 	DRM_FB_HELPER_DEFAULT_OPS,
@@ -183,6 +202,7 @@ static const struct fb_ops radeon_fbdev_fb_ops = {
 	.fb_fillrect = drm_fb_helper_cfb_fillrect,
 	.fb_copyarea = drm_fb_helper_cfb_copyarea,
 	.fb_imageblit = drm_fb_helper_cfb_imageblit,
+	.fb_destroy = radeon_fbdev_fb_destroy,
 };
 
 /*
@@ -277,27 +297,6 @@ static int radeon_fbdev_fb_helper_fb_probe(struct drm_fb_helper *fb_helper,
 	return ret;
 }
 
-static int radeon_fbdev_destroy(struct drm_device *dev, struct drm_fb_helper *fb_helper)
-{
-	struct drm_framebuffer *fb = fb_helper->fb;
-
-	drm_fb_helper_unregister_info(fb_helper);
-
-	if (fb) {
-		if (fb->obj[0]) {
-			radeon_fbdev_destroy_pinned_object(fb->obj[0]);
-			fb->obj[0] = NULL;
-			drm_framebuffer_unregister_private(fb);
-			drm_framebuffer_cleanup(fb);
-		}
-		kfree(fb);
-		fb_helper->fb = NULL;
-	}
-	drm_fb_helper_fini(fb_helper);
-
-	return 0;
-}
-
 static const struct drm_fb_helper_funcs radeon_fbdev_fb_helper_funcs = {
 	.fb_probe = radeon_fbdev_fb_helper_fb_probe,
 };
@@ -351,7 +350,7 @@ void radeon_fbdev_fini(struct radeon_device *rdev)
 	if (!rdev->ddev->fb_helper)
 		return;
 
-	radeon_fbdev_destroy(rdev->ddev, rdev->ddev->fb_helper);
+	drm_fb_helper_unregister_info(rdev->ddev->fb_helper);
 	drm_fb_helper_unprepare(rdev->ddev->fb_helper);
 	kfree(rdev->ddev->fb_helper);
 	rdev->ddev->fb_helper = NULL;
-- 
2.39.2

