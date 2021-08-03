Return-Path: <SRS0=biE/=M3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571FBC4338F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 01:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1464A60F58
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 01:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1464A60F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FB916E9A6;
	Wed,  4 Aug 2021 01:07:54 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B4A16E97C
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 23:49:48 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id l18so218358wrv.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Aug 2021 16:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=y9aJyKI6YNxJhGghb1OCNWhAUVytbZm5nZLNA+zRGmo=;
 b=HMiWUG5p/PReQkhk2TWfiuzhycTflQRt+XbtzhSdBQOAXjXNFZkY2QBRWj/rDt0hGr
 xymu6ZG8dQBffwPdiGz5aQPS75BxEF2sR37w24d/IxGFF34oFuMnVxH4Y8HIvCjYeYmC
 hhd7F2PSXoohScS+HvrpKMPzXLZRq4B/qgE1DHglJwUpP0gyq5ZVgua7V4Lw6FG00x2w
 qYOlYZVBeTPFwCyR3gAAW0usFbAl5nZ17ZjGTn9teOd2DP5zdb51lMif1TnrB0nyzXVt
 Gq3OoeYnK28a60z/KzutNjohTg33kIMyf3o8q7ac030177vISZytNadyIM6enNbqWCJf
 9T/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=y9aJyKI6YNxJhGghb1OCNWhAUVytbZm5nZLNA+zRGmo=;
 b=r2doVxwrUer8JMsEyXqtnTvkjLORT7O3dGGYB6X6CAwh/FJ7eIfuIVHQJCFYgiKlvW
 qWLY8mNWrCUgXIMr08CW+AdApqhEHZCNhtwyCH5gY4H40ymbEwEgCFHnYco/6+JAfonq
 5rVL9q6SZLrObz+KNSpROMJ5Qq+2AtEOYP4+GdneLo+RbQ17vwYoPcI6qZkrdsBo51BX
 emuX9RC2RrAUUrG40t3Iaap1XO6521Lq6SVpLnRZZq6FViK30BmrhdziWNKFloTCuh1y
 Y6YJisd6S4CccDL5KaKKFImHCNNvfwFkOwSaZMXn94TBEP+TMPirN+vIKXr7XseSUDKs
 2clw==
X-Gm-Message-State: AOAM531djMUp0az9wkvNw6f3sk6j37KvMuxg0ahJQ/FhS3nUxRB/kSn+
 Zxr7jWCYjys+MhC5v3GpdIs=
X-Google-Smtp-Source: ABdhPJzLy6gJManOGjC0HalkHJ2tahVWa4dunJhBJeoqFr92Yq+lnWCmsFl2AHRzq/kCfkJSBj3EeQ==
X-Received: by 2002:a5d:6442:: with SMTP id d2mr25882894wrw.425.1628034586651; 
 Tue, 03 Aug 2021 16:49:46 -0700 (PDT)
Received: from icebear.localdomain ([170.253.11.129])
 by smtp.gmail.com with ESMTPSA id j140sm406780wmj.37.2021.08.03.16.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Aug 2021 16:49:46 -0700 (PDT)
From: "=?UTF-8?q?Sergio=20Migu=C3=A9ns=20Iglesias?=" <lonyelon@gmail.com>
X-Google-Original-From: =?UTF-8?q?Sergio=20Migu=C3=A9ns=20Iglesias?=
 <sergio@lony.xyz>
To: airlied@linux.ie
Cc: nirmoy.das@amd.com, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?q?Sergio=20Migu=C3=A9ns=20Iglesias?= <sergio@lony.xyz>
Subject: [PATCH] DRM: amd: amdgpu: Fixed code style and removed unnecessary if
 statement
Date: Wed,  4 Aug 2021 01:49:44 +0200
Message-Id: <20210803234944.142154-1-sergio@lony.xyz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Aug 2021 01:07:49 +0000
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

The file didn't follow the code style so it was changed. The "if" statement
checked if the framebuffer was initialized was also changed since that
condition is unlikely to happen. An unnecessary "if" was removed too since it
didn't execute any code if the condition was met.

Signed-off-by: Sergio Miguéns Iglesias <sergio@lony.xyz>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
index 09b048647523..d2ab07eb00fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
@@ -42,15 +42,16 @@
 #include "amdgpu_display.h"
 
 /* object hierarchy -
-   this contains a helper + a amdgpu fb
-   the helper contains a pointer to amdgpu framebuffer baseclass.
-*/
+ * this contains a helper + a amdgpu fb
+ * the helper contains a pointer to amdgpu framebuffer baseclass.
+ */
 
 static int
 amdgpufb_open(struct fb_info *info, int user)
 {
 	struct drm_fb_helper *fb_helper = info->par;
 	int ret = pm_runtime_get_sync(fb_helper->dev->dev);
+
 	if (ret < 0 && ret != -EACCES) {
 		pm_runtime_mark_last_busy(fb_helper->dev->dev);
 		pm_runtime_put_autosuspend(fb_helper->dev->dev);
@@ -182,9 +183,8 @@ static int amdgpufb_create_pinned_object(struct amdgpu_fbdev *rfbdev,
 
 	ret = amdgpu_bo_kmap(abo, NULL);
 	amdgpu_bo_unreserve(abo);
-	if (ret) {
+	if (ret)
 		goto out_unref;
-	}
 
 	*gobj_p = gobj;
 	return 0;
@@ -233,7 +233,7 @@ static int amdgpufb_create(struct drm_fb_helper *helper,
 
 	ret = amdgpu_display_gem_fb_init(adev_to_drm(adev), &rfbdev->rfb,
 					 &mode_cmd, gobj);
-	if (ret) {
+	if (unlikely(ret)) {
 		DRM_ERROR("failed to initialize framebuffer %d\n", ret);
 		goto out;
 	}
@@ -258,7 +258,7 @@ static int amdgpufb_create(struct drm_fb_helper *helper,
 
 	/* Use default scratch pixmap (info->pixmap.flags = FB_PIXMAP_SYSTEM) */
 
-	if (info->screen_base == NULL) {
+	if (unlikely(info->screen_base == NULL)) {
 		ret = -ENOSPC;
 		goto out;
 	}
@@ -273,9 +273,6 @@ static int amdgpufb_create(struct drm_fb_helper *helper,
 	return 0;
 
 out:
-	if (abo) {
-
-	}
 	if (fb && ret) {
 		drm_gem_object_put(gobj);
 		drm_framebuffer_unregister_private(fb);
-- 
2.32.0

