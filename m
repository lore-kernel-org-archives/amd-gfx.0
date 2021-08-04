Return-Path: <SRS0=ROs4=M4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8163C4338F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 07:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8F460C3F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 07:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7F8F460C3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13BF389FAD;
	Thu,  5 Aug 2021 07:32:25 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D5BE89D56
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Aug 2021 11:21:23 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id m12so1782947wru.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Aug 2021 04:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m3Udre+J49huHIZ5aCaOfLGfaPv+Y/oIDQGc1oL/nzk=;
 b=m5+lER8SHkuEkoYjXnlsemTpJAZh8p/KxNM8bIPdPMjLwa6I0zDhTCttM+Ejzcy3DQ
 /le3Rpihi/cQuW3u/n49NfnnJxCORmMlqXDa0bBjTV4DKadG6M+yIv/txjV77csXZpj4
 8JJZel1JEFPWa0cenr+K/5UrmIMQJRmxtBC9h3U/oXfy8wPBdisZG5j78Z2LJwOCy/vR
 WBE7HmfDSUlGVlfvWya8DEMvgCh6xZPSiOpgtSwPbS71uaLiKtrUk9x/wL9pjPJcDn55
 jXFwLRQeO080iun5VR9nX4zgPM7TKWM16Yx0fjvyK7STn0JWBr+ik5qSB6tUd1cx/IDe
 F6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m3Udre+J49huHIZ5aCaOfLGfaPv+Y/oIDQGc1oL/nzk=;
 b=KzqKuD66QpblpgfPaTELSWsL8WEsNoXm0PoTFO3TSUkedlyJ4s/4Nymr+hckEtG909
 mhj50SMHuTtX6+jNpTElADyCGwQrYpve/n02TY/c/zQYb8sk3M9xmN8ph5Ls9NreT/Jf
 IdbPGWn61BFypELD2tGyXINfoXulv33CSC7L5vG9BaTb2qQf83EBxWOmkWFiJgRh7WJf
 Unq8dUwEgMybvwlYx6Cs/50bdX/moQxFN5Vffu5IG3juO41skqFuFpqc2XjJFRmMrGWn
 YNDxPm4lWXAN67UXYmyciKv2tok86mlgwTQ4BQv6CnRkfuAcRhJVjD3xmJkM0RtaxVNC
 Eiww==
X-Gm-Message-State: AOAM533Gr6IblT13thEICTOvzM/QOJNlRYzggn+fxuGvQpK3myBqMVbZ
 Xxqogx58ZBflz4yfwq731zI=
X-Google-Smtp-Source: ABdhPJyrf+s52V4b7YbOxf3F300f5NCbA2yGUzTHP2D7dvNV50iCrgjcTayTRz/wKD8aGeygtC4h2w==
X-Received: by 2002:adf:d091:: with SMTP id y17mr18944879wrh.311.1628076081548; 
 Wed, 04 Aug 2021 04:21:21 -0700 (PDT)
Received: from icebear.localdomain ([170.253.11.129])
 by smtp.gmail.com with ESMTPSA id y192sm5555384wmy.1.2021.08.04.04.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Aug 2021 04:21:21 -0700 (PDT)
From: "=?UTF-8?q?Sergio=20Migu=C3=A9ns=20Iglesias?=" <lonyelon@gmail.com>
X-Google-Original-From: =?UTF-8?q?Sergio=20Migu=C3=A9ns=20Iglesias?=
 <sergio@lony.xyz>
To: airlied@linux.ie
Cc: daniel@ffwll.ch, alexander.deucher@amd.com, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?q?Sergio=20Migu=C3=A9ns=20Iglesias?= <sergio@lony.xyz>
Subject: [PATCH] DRM: gpu: radeon: Fixed coding style issues
Date: Wed,  4 Aug 2021 13:20:53 +0200
Message-Id: <20210804112053.263887-1-sergio@lony.xyz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 05 Aug 2021 07:32:24 +0000
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

Fixed braces, an unnecessary if statement and added a missing space.

Signed-off-by: Sergio Miguéns Iglesias <sergio@lony.xyz>
---
 drivers/gpu/drm/radeon/radeon_fb.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_fb.c b/drivers/gpu/drm/radeon/radeon_fb.c
index 0b206b052972..6640b7c947fe 100644
--- a/drivers/gpu/drm/radeon/radeon_fb.c
+++ b/drivers/gpu/drm/radeon/radeon_fb.c
@@ -54,6 +54,7 @@ radeonfb_open(struct fb_info *info, int user)
 	struct radeon_fbdev *rfbdev = info->par;
 	struct radeon_device *rdev = rfbdev->rdev;
 	int ret = pm_runtime_get_sync(rdev->ddev->dev);
+
 	if (ret < 0 && ret != -EACCES) {
 		pm_runtime_mark_last_busy(rdev->ddev->dev);
 		pm_runtime_put_autosuspend(rdev->ddev->dev);
@@ -196,9 +197,8 @@ static int radeonfb_create_pinned_object(struct radeon_fbdev *rfbdev,
 		radeon_bo_check_tiling(rbo, 0, 0);
 	ret = radeon_bo_kmap(rbo, NULL);
 	radeon_bo_unreserve(rbo);
-	if (ret) {
+	if (ret)
 		goto out_unref;
-	}
 
 	*gobj_p = gobj;
 	return 0;
@@ -294,9 +294,6 @@ static int radeonfb_create(struct drm_fb_helper *helper,
 	return 0;
 
 out:
-	if (rbo) {
-
-	}
 	if (fb && ret) {
 		drm_gem_object_put(gobj);
 		drm_framebuffer_unregister_private(fb);
-- 
2.32.0

