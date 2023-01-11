Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAE2C67871
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jan 2023 13:02:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BE7210E735;
	Wed, 11 Jan 2023 13:02:22 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36AF310E728;
 Wed, 11 Jan 2023 13:02:17 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F140A1792E;
 Wed, 11 Jan 2023 13:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673442132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mnnBUMaN/19OrBCW4AZ01O2anzcv+W4ql08Gz6HVTFs=;
 b=2X135h/RjrMDRXXAomeh/1jDpc+SJLH+1Mx1qDs+n/NXH9coS4JKPww+vP/F+zNIHyj4Mc
 WFwzVES1N2ZfANIQDmhYcfnryjbfZ7MAF6nkSPkxoRVCuYa0swDW+NtGFcWgQbSqAy6vOD
 akWrePckbqQmmD7lyYxrw7oljvjaQtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673442132;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mnnBUMaN/19OrBCW4AZ01O2anzcv+W4ql08Gz6HVTFs=;
 b=a4YOxsq6x7c0wDACZd6Ih0TD39uo8b3t1Xj+XMv6e3MLTAIl1ih0H2aqimIJNYMI2JZjvs
 tyhtQSZTFG0Zd6Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A7F2813591;
 Wed, 11 Jan 2023 13:02:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4M0uKFOzvmMaXAAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Wed, 11 Jan 2023 13:02:11 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 patrik.r.jakobsson@gmail.com, thierry.reding@gmail.com, sam@ravnborg.org,
 f.fainelli@gmail.com, james.qian.wang@arm.com, liviu.dudau@arm.com
Subject: [PATCH v2 06/10] drm: Define enum mode_set_atomic in
 drm_modeset_helper_tables.h
Date: Wed, 11 Jan 2023 14:02:02 +0100
Message-Id: <20230111130206.29974-7-tzimmermann@suse.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111130206.29974-1-tzimmermann@suse.de>
References: <20230111130206.29974-1-tzimmermann@suse.de>
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Define enum mode_set_atomic next to the only interface that uses
the type. This will allow for removing several include statements
for drm_fb_helper.h. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 include/drm/drm_fb_helper.h              | 5 -----
 include/drm/drm_modeset_helper_vtables.h | 6 +++++-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index b111dc7ada78..f443e1f11654 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -37,11 +37,6 @@ struct drm_fb_helper;
 
 #include <drm/drm_client.h>
 
-enum mode_set_atomic {
-	LEAVE_ATOMIC_MODE_SET,
-	ENTER_ATOMIC_MODE_SET,
-};
-
 /**
  * struct drm_fb_helper_surface_size - describes fbdev size and scanout surface size
  * @fb_width: fbdev width
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index 77a540ad7dcd..206f495bbf06 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -48,10 +48,14 @@
  * To make this clear all the helper vtables are pulled together in this location here.
  */
 
-enum mode_set_atomic;
 struct drm_writeback_connector;
 struct drm_writeback_job;
 
+enum mode_set_atomic {
+	LEAVE_ATOMIC_MODE_SET,
+	ENTER_ATOMIC_MODE_SET,
+};
+
 /**
  * struct drm_crtc_helper_funcs - helper operations for CRTCs
  *
-- 
2.39.0

