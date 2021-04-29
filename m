Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBD8C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 20:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 792F56143A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 20:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792F56143A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16EDD6F4B7;
	Thu, 29 Apr 2021 20:50:26 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9AA76F4B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 20:50:24 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 l189-20020a1cbbc60000b0290140319ad207so554964wmf.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 13:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CgwZY9WscuJffR1Gqg4wYULfDMCPGdrJoulZCZijj8c=;
 b=PKDDXvvOFwxtF84RxPh/gtoKjns7uP+kpSWRxQNOBGOXv4d2PenN3iappBq6XZBXnq
 9BtuRiiVzMOxB/IZK2f8Qv1f1NPnDR7ETvSFhcCcKzAeMt5LT6K1ILXRI7f6XAqlYRoU
 wz4/aPMerpmBeAqznvmVSkUz0Ix9pFiRsjgIjgK0gVXtbL5EhQeq+q3hkg9leBX5coNc
 vR9PfBNv9l8w7F0KQbuPF38uKRaYeRSE4iYEgwCsFzBBSeJZlXN93ojfBc2V0CfEbgOK
 FDB/0zm2P+73+KPN3PO/XGDQ0ygjViZFSiqRGzaUFj22vR6y8BxUs2o4ycHK2VdI65H6
 6Pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CgwZY9WscuJffR1Gqg4wYULfDMCPGdrJoulZCZijj8c=;
 b=gi/Rxqxx+j2lrZiiw09ZS7/rDq9gFJ162mfYZMOXBfXp09M8pxopWVXeoZajA01ctR
 obTNHHyt3M62hugrR2bKkinM5phiA808CsOQDlmH3rBK/+BRzHMxSkY11WrQ3mEdsTBY
 eH2MuHQ3lW7h23WPIpFi1GIxet4U2omYpS44XaYLl/Vln7oKNP5UOnbWxzeqlYhGtsBM
 UssXjcfAnar6RnoNGJRwtCaPHRRjqKSx5N3hPjyGV485/JOtQIuNMrsn/ms/Od0Oipqy
 3Jb3s35lxecNdrFklWda0skboO07o0S+Kd8rYV2jbTzTG80SsM0eGWSetGBtkRjn8JMS
 oOpA==
X-Gm-Message-State: AOAM531ifKMbcAYL+XfCqUfvtgIihbCb8YQ/fQWXlgJXWe089POLSecB
 CcHp6TY1EzxkuLeFBmfIA9WNpO2JJOAH5A==
X-Google-Smtp-Source: ABdhPJzgAyTtgPxxjLR6VWf9NmzgXwX7kagFOdHWUMljvAgRoIGxYyeFnQxbEOBY8OO3UFKOHutJLA==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr12748153wmh.102.1619729423397; 
 Thu, 29 Apr 2021 13:50:23 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a77f:2000:7285:c2ff:fe67:a82f])
 by smtp.gmail.com with ESMTPSA id y21sm11931866wmc.46.2021.04.29.13.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Apr 2021 13:50:22 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amdgpu: Verify bo size can fit framebuffer size
 on init."
Date: Thu, 29 Apr 2021 22:50:24 +0200
Message-Id: <20210429205024.892894-1-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.31.1
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
Cc: alexdeucher@gmail.com, markyacoub@chromium.org,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit f258907fdd835e1aed6d666b00cdd0f186676b7c.

Same problem as "drm/amdgpu: Verify bo size can fit framebuffer size",
but because it gets checked earlier it now only triggers on the
modifiers case.

There are a couple of reasons why the DRM core BO size check won't
work for AMDGPU, especially around DCC planes.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---

For -fixes. Might have some conflicts with
"drm/amdgpu: Ensure that the modifier requested is supported by plane"
for amd-staging-drm-next

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 68 ++++-----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c      |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h    |  8 ---
 3 files changed, 15 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 9a2f811450ed..cbe050436c7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -870,62 +870,17 @@ static int amdgpu_display_get_fb_info(const struct amdgpu_framebuffer *amdgpu_fb
 	return r;
 }
 
-int amdgpu_display_gem_fb_init(struct drm_device *dev,
-			       struct amdgpu_framebuffer *rfb,
-			       const struct drm_mode_fb_cmd2 *mode_cmd,
-			       struct drm_gem_object *obj)
-{
-	int ret;
-
-	rfb->base.obj[0] = obj;
-	drm_helper_mode_fill_fb_struct(dev, &rfb->base, mode_cmd);
-	ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
-	if (ret)
-		goto err;
-
-	ret = amdgpu_display_framebuffer_init(dev, rfb, mode_cmd, obj);
-	if (ret)
-		goto err;
-
-	return 0;
-err:
-	drm_err(dev, "Failed to init gem fb: %d\n", ret);
-	rfb->base.obj[0] = NULL;
-	return ret;
-}
-
-int amdgpu_display_gem_fb_verify_and_init(
-	struct drm_device *dev, struct amdgpu_framebuffer *rfb,
-	struct drm_file *file_priv, const struct drm_mode_fb_cmd2 *mode_cmd,
-	struct drm_gem_object *obj)
-{
-	int ret;
-
-	rfb->base.obj[0] = obj;
-
-	/* Verify that bo size can fit the fb size. */
-	ret = drm_gem_fb_init_with_funcs(dev, &rfb->base, file_priv, mode_cmd,
-					 &amdgpu_fb_funcs);
-	if (ret)
-		goto err;
-
-	ret = amdgpu_display_framebuffer_init(dev, rfb, mode_cmd, obj);
-	if (ret)
-		goto err;
-
-	return 0;
-err:
-	drm_err(dev, "Failed to verify and init gem fb: %d\n", ret);
-	rfb->base.obj[0] = NULL;
-	return ret;
-}
-
 int amdgpu_display_framebuffer_init(struct drm_device *dev,
 				    struct amdgpu_framebuffer *rfb,
 				    const struct drm_mode_fb_cmd2 *mode_cmd,
 				    struct drm_gem_object *obj)
 {
 	int ret, i;
+	rfb->base.obj[0] = obj;
+	drm_helper_mode_fill_fb_struct(dev, &rfb->base, mode_cmd);
+	ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
+	if (ret)
+		goto fail;
 
 	/*
 	 * This needs to happen before modifier conversion as that might change
@@ -936,13 +891,13 @@ int amdgpu_display_framebuffer_init(struct drm_device *dev,
 			drm_dbg_kms(dev, "Plane 0 and %d have different BOs: %u vs. %u\n",
 				    i, mode_cmd->handles[0], mode_cmd->handles[i]);
 			ret = -EINVAL;
-			return ret;
+			goto fail;
 		}
 	}
 
 	ret = amdgpu_display_get_fb_info(rfb, &rfb->tiling_flags, &rfb->tmz_surface);
 	if (ret)
-		return ret;
+		goto fail;
 
 	if (dev->mode_config.allow_fb_modifiers &&
 	    !(rfb->base.flags & DRM_MODE_FB_MODIFIERS)) {
@@ -950,7 +905,7 @@ int amdgpu_display_framebuffer_init(struct drm_device *dev,
 		if (ret) {
 			drm_dbg_kms(dev, "Failed to convert tiling flags 0x%llX to a modifier",
 				    rfb->tiling_flags);
-			return ret;
+			goto fail;
 		}
 	}
 
@@ -961,6 +916,10 @@ int amdgpu_display_framebuffer_init(struct drm_device *dev,
 	}
 
 	return 0;
+
+fail:
+	rfb->base.obj[0] = NULL;
+	return ret;
 }
 
 struct drm_framebuffer *
@@ -995,8 +954,7 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	ret = amdgpu_display_gem_fb_verify_and_init(dev, amdgpu_fb, file_priv,
-						    mode_cmd, obj);
+	ret = amdgpu_display_framebuffer_init(dev, amdgpu_fb, mode_cmd, obj);
 	if (ret) {
 		kfree(amdgpu_fb);
 		drm_gem_object_put(obj);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
index 4c5c19820d37..24010cacf7d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
@@ -232,8 +232,8 @@ static int amdgpufb_create(struct drm_fb_helper *helper,
 		goto out;
 	}
 
-	ret = amdgpu_display_gem_fb_init(adev_to_drm(adev), &rfbdev->rfb,
-					 &mode_cmd, gobj);
+	ret = amdgpu_display_framebuffer_init(adev_to_drm(adev), &rfbdev->rfb,
+					      &mode_cmd, gobj);
 	if (ret) {
 		DRM_ERROR("failed to initialize framebuffer %d\n", ret);
 		goto out;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index cb0b581bbce7..319cb19e1b99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -602,14 +602,6 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
 			int *hpos, ktime_t *stime, ktime_t *etime,
 			const struct drm_display_mode *mode);
 
-int amdgpu_display_gem_fb_init(struct drm_device *dev,
-			       struct amdgpu_framebuffer *rfb,
-			       const struct drm_mode_fb_cmd2 *mode_cmd,
-			       struct drm_gem_object *obj);
-int amdgpu_display_gem_fb_verify_and_init(
-	struct drm_device *dev, struct amdgpu_framebuffer *rfb,
-	struct drm_file *file_priv, const struct drm_mode_fb_cmd2 *mode_cmd,
-	struct drm_gem_object *obj);
 int amdgpu_display_framebuffer_init(struct drm_device *dev,
 				    struct amdgpu_framebuffer *rfb,
 				    const struct drm_mode_fb_cmd2 *mode_cmd,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
