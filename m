Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA5DC433E3
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 19:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B9ED22BEB
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 19:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvmAKii1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9ED22BEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50DF16E45E;
	Mon, 10 Aug 2020 19:14:52 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E6A66E459;
 Mon, 10 Aug 2020 19:14:50 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5FC3322CAF;
 Mon, 10 Aug 2020 19:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597086890;
 bh=BfPjhQ44U9DE3oZzImTFIZQyBr/WqCe9IVpkANI4hnw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FvmAKii1siy0HJFqwX1SFK/WzgSG5JyShXidIsvolIB+RjhfUSbyYvj6T9/aEdUq+
 eWMt5EUuh6L5aaqj+4SHuUG8Z5XysbxyF1xu0vO262TgdJ0XwxBsnp6j9tCw1/YXF1
 o2TRpsreYgP2X71rxdGSpDi1QYI3i8dYOe0hG8Ls=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 04/16] drm/radeon: Fix reference count leaks
 caused by pm_runtime_get_sync
Date: Mon, 10 Aug 2020 15:14:31 -0400
Message-Id: <20200810191443.3795581-4-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810191443.3795581-1-sashal@kernel.org>
References: <20200810191443.3795581-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Aditya Pakki <pakki001@umn.edu>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aditya Pakki <pakki001@umn.edu>

[ Upstream commit 9fb10671011143d15b6b40d6d5fa9c52c57e9d63 ]

On calling pm_runtime_get_sync() the reference count of the device
is incremented. In case of failure, decrement the
reference count before returning the error.

Acked-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/radeon_display.c | 4 +++-
 drivers/gpu/drm/radeon/radeon_drv.c     | 4 +++-
 drivers/gpu/drm/radeon/radeon_kms.c     | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 4572bfba017c5..17c73b8c90e71 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -660,8 +660,10 @@ radeon_crtc_set_config(struct drm_mode_set *set)
 	dev = set->crtc->dev;
 
 	ret = pm_runtime_get_sync(dev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(dev->dev);
 		return ret;
+	}
 
 	ret = drm_crtc_helper_set_config(set);
 
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 5b6a6f5b3619e..401403a3ea50c 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -527,8 +527,10 @@ long radeon_drm_ioctl(struct file *filp,
 	long ret;
 	dev = file_priv->minor->dev;
 	ret = pm_runtime_get_sync(dev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(dev->dev);
 		return ret;
+	}
 
 	ret = drm_ioctl(filp, cmd, arg);
 	
diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index d290a8a09036e..41caf7da90548 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -631,8 +631,10 @@ int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	file_priv->driver_priv = NULL;
 
 	r = pm_runtime_get_sync(dev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(dev->dev);
 		return r;
+	}
 
 	/* new gpu have virtual address space support */
 	if (rdev->family >= CHIP_CAYMAN) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
