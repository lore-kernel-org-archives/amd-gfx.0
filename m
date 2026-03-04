Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1EDEB363E
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 13:03:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24DDA10E9E5;
	Wed,  4 Mar 2026 13:02:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Z8JHrCqo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4YHwx+dt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z8JHrCqo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4YHwx+dt";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2956310E9E8
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 13:02:56 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E48255BDF8;
 Wed,  4 Mar 2026 13:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772629374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pwYj5dgInjh7HBFE6PzMK1TVQxe7Dozs67WoSfIl5f4=;
 b=Z8JHrCqoTZHfwXsswpCJcuAc0fKs3WgdvGAwxZZGIB5PT8y2BicwFZJYatyfTawFT/b/Lv
 IEtVTdeuiBXUsUxVG3Va3EnLAEZZjtwqUWe5CdLK/MDVxnDj+4zbUaUeIVOSdy4f6I0hf8
 eTBNewcBhhZKWZJPj6pzrkjLtfvUAgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772629374;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pwYj5dgInjh7HBFE6PzMK1TVQxe7Dozs67WoSfIl5f4=;
 b=4YHwx+dtZjZ8MFWQC7iYHFx/J9bwC2lVfdv2o2BL0/9Zb138iW0g4lDzPQaeg3GSib3Om3
 gzmDII5c8t+Rs4DQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Z8JHrCqo;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4YHwx+dt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772629374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pwYj5dgInjh7HBFE6PzMK1TVQxe7Dozs67WoSfIl5f4=;
 b=Z8JHrCqoTZHfwXsswpCJcuAc0fKs3WgdvGAwxZZGIB5PT8y2BicwFZJYatyfTawFT/b/Lv
 IEtVTdeuiBXUsUxVG3Va3EnLAEZZjtwqUWe5CdLK/MDVxnDj+4zbUaUeIVOSdy4f6I0hf8
 eTBNewcBhhZKWZJPj6pzrkjLtfvUAgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772629374;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pwYj5dgInjh7HBFE6PzMK1TVQxe7Dozs67WoSfIl5f4=;
 b=4YHwx+dtZjZ8MFWQC7iYHFx/J9bwC2lVfdv2o2BL0/9Zb138iW0g4lDzPQaeg3GSib3Om3
 gzmDII5c8t+Rs4DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAB8C3EA6C;
 Wed,  4 Mar 2026 13:02:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GIZwKH4tqGmlNQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 04 Mar 2026 13:02:54 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/2] drm/amdgpu: Move test for fbdev GEM object into generic
 helper
Date: Wed,  4 Mar 2026 13:58:38 +0100
Message-ID: <20260304130250.59008-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304130250.59008-1-tzimmermann@suse.de>
References: <20260304130250.59008-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[amd.com,gmail.com,ffwll.ch];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 RCPT_COUNT_SEVEN(0.00)[7];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E48255BDF8
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

Provide a generic helper that tests if fbdev emulation is backed by
a specific GEM object. Not all drivers use client buffers (yet), hence
also test against the first GEM object in the fbdev framebuffer.

Convert amdgpu. The helper will also be useful for radeon.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 21 +++------------
 drivers/gpu/drm/drm_fb_helper.c             | 29 +++++++++++++++++++++
 include/drm/drm_fb_helper.h                 |  9 +++++++
 3 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index bef9dce2e7ea..f5cd68542442 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1738,21 +1738,6 @@ bool amdgpu_crtc_get_scanout_position(struct drm_crtc *crtc,
 						  stime, etime, mode);
 }
 
-static bool
-amdgpu_display_robj_is_fb(struct amdgpu_device *adev, struct amdgpu_bo *robj)
-{
-	struct drm_device *dev = adev_to_drm(adev);
-	struct drm_fb_helper *fb_helper = dev->fb_helper;
-
-	if (!fb_helper || !fb_helper->buffer)
-		return false;
-
-	if (gem_to_amdgpu_bo(fb_helper->buffer->gem) != robj)
-		return false;
-
-	return true;
-}
-
 int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
 {
 	struct drm_device *dev = adev_to_drm(adev);
@@ -1775,7 +1760,6 @@ int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
 	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
 		struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 		struct drm_framebuffer *fb = crtc->primary->fb;
-		struct amdgpu_bo *robj;
 
 		if (amdgpu_crtc->cursor_bo && !adev->enable_virtual_display) {
 			struct amdgpu_bo *aobj = gem_to_amdgpu_bo(amdgpu_crtc->cursor_bo);
@@ -1790,8 +1774,9 @@ int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
 		if (!fb || !fb->obj[0])
 			continue;
 
-		robj = gem_to_amdgpu_bo(fb->obj[0]);
-		if (!amdgpu_display_robj_is_fb(adev, robj)) {
+		if (!drm_fb_helper_gem_is_fb(dev->fb_helper, fb->obj[0])) {
+			struct amdgpu_bo *robj = gem_to_amdgpu_bo(fb->obj[0]);
+
 			r = amdgpu_bo_reserve(robj, true);
 			if (r == 0) {
 				amdgpu_bo_unpin(robj);
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 845c63ca15b5..214337ebb559 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -37,6 +37,7 @@
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
+#include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_print.h>
 #include <drm/drm_vblank.h>
@@ -1771,3 +1772,31 @@ int drm_fb_helper_hotplug_event(struct drm_fb_helper *fb_helper)
 	return 0;
 }
 EXPORT_SYMBOL(drm_fb_helper_hotplug_event);
+
+/**
+ * drm_fb_helper_gem_is_fb - Tests if GEM object is framebuffer
+ * @fb_helper: fb_helper instance, can be NULL
+ * @obj: The GEM object to test, can be NULL
+ *
+ * Call drm_fb_helper_gem_is_fb to test is a DRM device's fbdev emulation
+ * uses the specified GEM object for its framebuffer. The result is always
+ * false if either poiner is NULL.
+ *
+ * Returns:
+ * True if fbdev emulation uses the provided GEM object, or false otherwise.
+ */
+bool drm_fb_helper_gem_is_fb(const struct drm_fb_helper *fb_helper,
+			     const struct drm_gem_object *obj)
+{
+	const struct drm_gem_object *gem = NULL;
+
+	if (!fb_helper || !obj)
+		return false;
+	if (fb_helper->buffer && fb_helper->buffer->gem)
+		gem = fb_helper->buffer->gem;
+	else if (fb_helper->fb)
+		gem = drm_gem_fb_get_obj(fb_helper->fb, 0);
+
+	return gem == obj;
+}
+EXPORT_SYMBOL_GPL(drm_fb_helper_gem_is_fb);
diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index 15274b8a1d97..c59f16c21723 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -271,6 +271,15 @@ int drm_fb_helper_ioctl(struct fb_info *info, unsigned int cmd,
 
 int drm_fb_helper_hotplug_event(struct drm_fb_helper *fb_helper);
 int drm_fb_helper_initial_config(struct drm_fb_helper *fb_helper);
+
+bool drm_fb_helper_gem_is_fb(const struct drm_fb_helper *fb_helper,
+			     const struct drm_gem_object *obj);
+#else
+static inline bool drm_fb_helper_gem_is_fb(const struct drm_fb_helper *fb_helper,
+					   const struct drm_gem_object *obj)
+{
+	return false;
+}
 #endif
 
 #endif
-- 
2.53.0

