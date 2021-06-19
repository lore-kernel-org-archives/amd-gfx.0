Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D411C48BE5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 07:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FAD261156
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 07:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FAD261156
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1158389C52;
	Mon, 21 Jun 2021 07:09:09 +0000 (UTC)
Received: from mail-m17639.qiye.163.com (mail-m17639.qiye.163.com
 [59.111.176.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C64A46EA55;
 Sat, 19 Jun 2021 06:44:16 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=ijhSRQm3e+Qu/7+WEz5PrdiyJeemGfVCH0gQGLss80cc+vvwLzOsdfH5O2+SYJJzQakizQ2JppPC4a+zYv6mlwRfg4Uw5TRBKGSAeM9V7wpWjvBXTVlPZIIL/5ahPS938kjsddo0b4fQqj4Q8kVh2awda+fywqycZvDnGHk6jBk=;
 s=default; c=relaxed/relaxed; d=vivo.com; v=1;
 bh=ocSpxz71TA5lK3q0byfIuoC7AgcSNqrnmhvLjFrEqD8=;
 h=date:mime-version:subject:message-id:from;
Received: from ubuntu.localdomain (unknown [36.152.145.181])
 by mail-m17639.qiye.163.com (Hmail) with ESMTPA id CD5E4380158;
 Sat, 19 Jun 2021 14:44:14 +0800 (CST)
From: Bernard Zhao <bernard@vivo.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] drm/radeon: delete useless return values
Date: Fri, 18 Jun 2021 23:43:48 -0700
Message-Id: <20210619064349.26676-5-bernard@vivo.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210619064349.26676-1-bernard@vivo.com>
References: <20210619064349.26676-1-bernard@vivo.com>
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
 oVCBIfWUFZQ0seHlZNTU1DTkoZSR5IQk1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
 hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ok06Cxw5Sj8THUIiKxUiTRhW
 FE4KCxpVSlVKTUlPS0NOS05OSU9MVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlITVVK
 TklVSk9OVUpDSllXWQgBWUFIS0NINwY+
X-HM-Tid: 0a7a230345ead994kuwscd5e4380158
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
the function type maybe coule be changed to void.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/radeon/radeon.h       | 2 +-
 drivers/gpu/drm/radeon/radeon_fence.c | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 56ed5634cebe..8a15f490a390 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -384,7 +384,7 @@ struct radeon_fence {
 };
 
 int radeon_fence_driver_start_ring(struct radeon_device *rdev, int ring);
-int radeon_fence_driver_init(struct radeon_device *rdev);
+void radeon_fence_driver_init(struct radeon_device *rdev);
 void radeon_fence_driver_fini(struct radeon_device *rdev);
 void radeon_fence_driver_force_completion(struct radeon_device *rdev, int ring);
 int radeon_fence_emit(struct radeon_device *rdev, struct radeon_fence **fence, int ring);
diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
index 0d8ef2368adf..b2ce642ca4fa 100644
--- a/drivers/gpu/drm/radeon/radeon_fence.c
+++ b/drivers/gpu/drm/radeon/radeon_fence.c
@@ -905,9 +905,8 @@ static void radeon_fence_driver_init_ring(struct radeon_device *rdev, int ring)
  * Not all asics have all rings, so each asic will only
  * start the fence driver on the rings it has using
  * radeon_fence_driver_start_ring().
- * Returns 0 for success.
  */
-int radeon_fence_driver_init(struct radeon_device *rdev)
+void radeon_fence_driver_init(struct radeon_device *rdev)
 {
 	int ring;
 
@@ -917,8 +916,6 @@ int radeon_fence_driver_init(struct radeon_device *rdev)
 	}
 
 	radeon_debugfs_fence_init(rdev);
-
-	return 0;
 }
 
 /**
-- 
2.31.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
