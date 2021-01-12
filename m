Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB241C433E9
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 19:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 630292311F
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 19:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630292311F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B839789B22;
	Tue, 12 Jan 2021 19:04:33 +0000 (UTC)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6530489DB4
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 18:33:53 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id x203so813715ooa.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 10:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wU0ojsUcvx/Sv2fj+fz5fFZWmjB/lLL8R2nFnA3MDBI=;
 b=HcpM9ymjgjVNz45MaNTPShua1xRaZaKcuow/gvgPD+UhJ7YV2JyVwg7eHVXfMIU9a2
 IBmQ3wIECZnBHxzKg7Jon3owdI5RS9wBDm73t0wn9sAS72+KP9HdYydXKCERPAKqEN+g
 k48D2vI/ZBKoIKQT9srN1N+2iIqSOJ+C/LDBYMp3/G8yNn4QYSrtv5BpzaflC57gZdf8
 yLNDtApT8GYW9IqhAy6BgZvEhSPAuq+Jod2O/n6GOLY34kByD/k5IFPecTum1tixh7jC
 56imx0I0NnCBDyi1qdDfBdAkVeseMI05ilbZB4ewO1jurwtB+rof+otDKRPjrCG6p05h
 Hi+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wU0ojsUcvx/Sv2fj+fz5fFZWmjB/lLL8R2nFnA3MDBI=;
 b=Ht7otWdFHMrSKoBFmnKPYZ1pJ913Yry0C8G/R5SAKCX/jI3FJ6oUUsCxL9sSbK0qH0
 xddPwBUW/VyUM32eWqmZL2Ny2qQF+HfMcVH8NBeVyGvbscpem4jzUo0EnUEa6QUfU3vo
 WvS9/7+DdeF59wwwp7LbEXlWhlomzGoovHDos3UdiJCCSxR4/8fhqnnasgrrqqgD3MFr
 WhQfY6L+OBDO4FISc70YTqLjbCUIoNlbh4JOFlmuO1tw5R8Ffl3f+mMEDLD8zgK54tWL
 tQB/fCipSRNZrGd7Oi4D38g9hXqn4u9xh8H8l6LJNyAKeRpfvNkeuMH0lzByXnq0+Gx6
 NHgQ==
X-Gm-Message-State: AOAM533LB6/8pTWoNi3s1vaL4EhgGDaQn8oceqYKZaRiiNlWhp0xA5YK
 j6Z3mKxM6cl6wdRdtWuTqA==
X-Google-Smtp-Source: ABdhPJyF3i71iHfS/+f59HH9BsBgFPqs8PgRaOfZFv8vpMIGa/RUPRNMRgP/OL/kHxqj66Opy4EoPA==
X-Received: by 2002:a4a:6c45:: with SMTP id u5mr250451oof.61.1610476432754;
 Tue, 12 Jan 2021 10:33:52 -0800 (PST)
Received: from vali.hitronhub.home (64-251-141-144.fidnet.com.
 [64.251.141.144])
 by smtp.gmail.com with ESMTPSA id t24sm817188oij.7.2021.01.12.10.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Jan 2021 10:33:52 -0800 (PST)
From: Joseph Schulte <joeschulte.js@gmail.com>
To: alexander.deucher@amd.com
Subject: [PATCH] amdgpu: Replace drm_modeset_(un)lock_all()
Date: Tue, 12 Jan 2021 12:35:26 -0600
Message-Id: <20210112183526.198305-1-joeschulte.js@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 12 Jan 2021 19:04:32 +0000
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
Cc: Joseph Schulte <joeschulte.js@gmail.com>, sean@poorly.run,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch repaces drm_modeset_lock_all() and drm_modeset_unlock_all
with DRM_MODESET_LOCK_ALL_BEGIN() and DRM_MODESET_LOCK_ALL_END()
respectivley according to Documentation/gpu/todo.rst.

r is used for the ret value in DRM_MODESET_LOCK_ALL_BEGIN since r is set
before any branches.

Signed-off-by: Joseph Schulte <joeschulte.js@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b69c34074d8d..2e92d020e8c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -32,6 +32,8 @@
 #include <linux/slab.h>
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_modeset_lock.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/amdgpu_drm.h>
 #include <linux/vgaarb.h>
@@ -3662,6 +3664,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	struct drm_crtc *crtc;
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
+	struct drm_modeset_acquire_ctx ctx;
 	int r;
 
 	adev = drm_to_adev(dev);
@@ -3679,13 +3682,13 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	if (!amdgpu_device_has_dc_support(adev)) {
 		/* turn off display hw */
-		drm_modeset_lock_all(dev);
+		DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, r);
 		drm_connector_list_iter_begin(dev, &iter);
 		drm_for_each_connector_iter(connector, &iter)
 			drm_helper_connector_dpms(connector,
 						  DRM_MODE_DPMS_OFF);
 		drm_connector_list_iter_end(&iter);
-		drm_modeset_unlock_all(dev);
+		DRM_MODESET_LOCK_ALL_END(dev, ctx, r);
 			/* unpin the front buffers and cursors */
 		list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
 			struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
@@ -3754,6 +3757,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 {
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
+	struct drm_modeset_acquire_ctx ctx;
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct drm_crtc *crtc;
 	int r = 0;
@@ -3818,7 +3822,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 			drm_helper_resume_force_mode(dev);
 
 			/* turn on display hw */
-			drm_modeset_lock_all(dev);
+			DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, r);
 
 			drm_connector_list_iter_begin(dev, &iter);
 			drm_for_each_connector_iter(connector, &iter)
@@ -3826,7 +3830,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 							  DRM_MODE_DPMS_ON);
 			drm_connector_list_iter_end(&iter);
 
-			drm_modeset_unlock_all(dev);
+			DRM_MODESET_LOCK_ALL_END(dev, ctx, r);
 		}
 		amdgpu_fbdev_set_suspend(adev, 0);
 	}
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
