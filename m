Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFD4C49361
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 07:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4BD611BD
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 07:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4BD611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8838389D83;
	Mon, 21 Jun 2021 07:09:09 +0000 (UTC)
Received: from mail-m17639.qiye.163.com (mail-m17639.qiye.163.com
 [59.111.176.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FE326EA55;
 Sat, 19 Jun 2021 06:44:15 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=ngj+BTKOYbgYfs5VK1A8xTf6W1mXZIK+b8jn1iD8g6xTy2sN09M4lg2enVXi6xWLps4hx22ep5RUdZmisarR2aH4DqnaQyYYp/v68BrC6YER37DzEgnxXnlehABDg704ljIpz39JLBFSpXe3orkJcpUSrIU013TgfcguD0PnIMg=;
 s=default; c=relaxed/relaxed; d=vivo.com; v=1;
 bh=CVj/3Dl/OhwruS8V8xLzx1CekV7XbwZKp+qh38LDL3I=;
 h=date:mime-version:subject:message-id:from;
Received: from ubuntu.localdomain (unknown [36.152.145.181])
 by mail-m17639.qiye.163.com (Hmail) with ESMTPA id B7D2638016B;
 Sat, 19 Jun 2021 14:44:12 +0800 (CST)
From: Bernard Zhao <bernard@vivo.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] drm/radeon: remove meaningless if(r) check code
Date: Fri, 18 Jun 2021 23:43:47 -0700
Message-Id: <20210619064349.26676-4-bernard@vivo.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210619064349.26676-1-bernard@vivo.com>
References: <20210619064349.26676-1-bernard@vivo.com>
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
 oVCBIfWUFZQkhOGlYYGB1NQk0fQk0eQxlVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
 hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mgg6DTo4PD8KFUILDRVDTS5W
 ETcwFE9VSlVKTUlPS0NOS05ISk1OVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlITVVK
 TklVSk9OVUpDSllXWQgBWUFPSU9LNwY+
X-HM-Tid: 0a7a23033dc6d994kuwsb7d2638016b
X-Mailman-Approved-At: Mon, 21 Jun 2021 07:09:08 +0000
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
Cc: Bernard Zhao <bernard@vivo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Function radeon_fence_driver_init always returns success,
remove meaningless if(r) check code.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/radeon/rs400.c | 4 +---
 drivers/gpu/drm/radeon/rs600.c | 4 +---
 drivers/gpu/drm/radeon/rs690.c | 4 +---
 drivers/gpu/drm/radeon/rv515.c | 4 +---
 drivers/gpu/drm/radeon/rv770.c | 4 +---
 5 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/radeon/rs400.c b/drivers/gpu/drm/radeon/rs400.c
index 8423bcc3302b..6383f7a34bd8 100644
--- a/drivers/gpu/drm/radeon/rs400.c
+++ b/drivers/gpu/drm/radeon/rs400.c
@@ -555,9 +555,7 @@ int rs400_init(struct radeon_device *rdev)
 	/* initialize memory controller */
 	rs400_mc_init(rdev);
 	/* Fence driver */
-	r = radeon_fence_driver_init(rdev);
-	if (r)
-		return r;
+	radeon_fence_driver_init(rdev);
 	/* Memory manager */
 	r = radeon_bo_init(rdev);
 	if (r)
diff --git a/drivers/gpu/drm/radeon/rs600.c b/drivers/gpu/drm/radeon/rs600.c
index 5bf26058eec0..b2d22e25eee1 100644
--- a/drivers/gpu/drm/radeon/rs600.c
+++ b/drivers/gpu/drm/radeon/rs600.c
@@ -1132,9 +1132,7 @@ int rs600_init(struct radeon_device *rdev)
 	rs600_mc_init(rdev);
 	r100_debugfs_rbbm_init(rdev);
 	/* Fence driver */
-	r = radeon_fence_driver_init(rdev);
-	if (r)
-		return r;
+	radeon_fence_driver_init(rdev);
 	/* Memory manager */
 	r = radeon_bo_init(rdev);
 	if (r)
diff --git a/drivers/gpu/drm/radeon/rs690.c b/drivers/gpu/drm/radeon/rs690.c
index 7bc302a89232..14fb0819b8c1 100644
--- a/drivers/gpu/drm/radeon/rs690.c
+++ b/drivers/gpu/drm/radeon/rs690.c
@@ -850,9 +850,7 @@ int rs690_init(struct radeon_device *rdev)
 	rs690_mc_init(rdev);
 	rv515_debugfs(rdev);
 	/* Fence driver */
-	r = radeon_fence_driver_init(rdev);
-	if (r)
-		return r;
+	radeon_fence_driver_init(rdev);
 	/* Memory manager */
 	r = radeon_bo_init(rdev);
 	if (r)
diff --git a/drivers/gpu/drm/radeon/rv515.c b/drivers/gpu/drm/radeon/rv515.c
index 46a53dd38079..63fb06e8e2d7 100644
--- a/drivers/gpu/drm/radeon/rv515.c
+++ b/drivers/gpu/drm/radeon/rv515.c
@@ -648,9 +648,7 @@ int rv515_init(struct radeon_device *rdev)
 	rv515_mc_init(rdev);
 	rv515_debugfs(rdev);
 	/* Fence driver */
-	r = radeon_fence_driver_init(rdev);
-	if (r)
-		return r;
+	radeon_fence_driver_init(rdev);
 	/* Memory manager */
 	r = radeon_bo_init(rdev);
 	if (r)
diff --git a/drivers/gpu/drm/radeon/rv770.c b/drivers/gpu/drm/radeon/rv770.c
index 88e29ebaad46..74499307285b 100644
--- a/drivers/gpu/drm/radeon/rv770.c
+++ b/drivers/gpu/drm/radeon/rv770.c
@@ -1941,9 +1941,7 @@ int rv770_init(struct radeon_device *rdev)
 	/* Initialize clocks */
 	radeon_get_clock_info(rdev->ddev);
 	/* Fence driver */
-	r = radeon_fence_driver_init(rdev);
-	if (r)
-		return r;
+	radeon_fence_driver_init(rdev);
 	/* initialize AGP */
 	if (rdev->flags & RADEON_IS_AGP) {
 		r = radeon_agp_init(rdev);
-- 
2.31.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
