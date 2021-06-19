Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B24C49361
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 07:09:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18B1161156
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 07:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B1161156
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDA3489D8A;
	Mon, 21 Jun 2021 07:09:12 +0000 (UTC)
Received: from mail-m17639.qiye.163.com (mail-m17639.qiye.163.com
 [59.111.176.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C0056E986;
 Sat, 19 Jun 2021 06:44:11 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=fMr2eHk5ouOqXvZl2LY/op5mJu49kCWugMf1bCoFu/cV/OXTjxvRPhjhwckgaaDCHkwUDoQaXEQBB1jDH+Lg1t2n2xshvUXM4c6QhzQx/YqqOmEU1I2sFP5JzlDSE0NOFgVQxFRSyE2ghczG+d7sTMz7Ip6SgJDF0m+bobtYpBw=;
 s=default; c=relaxed/relaxed; d=vivo.com; v=1;
 bh=bdZKbD4ntL+uOvkUFJz0eat8qRy6SiL1gcyD6sQKVDY=;
 h=date:mime-version:subject:message-id:from;
Received: from ubuntu.localdomain (unknown [36.152.145.181])
 by mail-m17639.qiye.163.com (Hmail) with ESMTPA id 638C93800E5;
 Sat, 19 Jun 2021 14:44:08 +0800 (CST)
From: Bernard Zhao <bernard@vivo.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] drm/radeon: remove meaningless if(r) check code
Date: Fri, 18 Jun 2021 23:43:45 -0700
Message-Id: <20210619064349.26676-2-bernard@vivo.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210619064349.26676-1-bernard@vivo.com>
References: <20210619064349.26676-1-bernard@vivo.com>
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
 oVCBIfWUFZGUMYGFZKH0wZTx9NHRlMT0pVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
 hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nxw6TQw*Qj8RK0I0QhY5TSMT
 GEgKCVZVSlVKTUlPS0NOS09DQ0lPVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlITVVK
 TklVSk9OVUpDSllXWQgBWUFITEpNNwY+
X-HM-Tid: 0a7a23032ccdd994kuws638c93800e5
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
 drivers/gpu/drm/radeon/cik.c       | 4 +---
 drivers/gpu/drm/radeon/evergreen.c | 4 +---
 drivers/gpu/drm/radeon/ni.c        | 4 +---
 drivers/gpu/drm/radeon/si.c        | 4 +---
 4 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 42a8afa839cb..f6cf0b8fdd83 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -8584,9 +8584,7 @@ int cik_init(struct radeon_device *rdev)
 	radeon_get_clock_info(rdev->ddev);
 
 	/* Fence driver */
-	r = radeon_fence_driver_init(rdev);
-	if (r)
-		return r;
+	radeon_fence_driver_init(rdev);
 
 	/* initialize memory controller */
 	r = cik_mc_init(rdev);
diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index 8e9e88bf1f43..36a888e1b179 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -5208,9 +5208,7 @@ int evergreen_init(struct radeon_device *rdev)
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
diff --git a/drivers/gpu/drm/radeon/ni.c b/drivers/gpu/drm/radeon/ni.c
index ab7bd3080217..4a364ca7a1be 100644
--- a/drivers/gpu/drm/radeon/ni.c
+++ b/drivers/gpu/drm/radeon/ni.c
@@ -2375,9 +2375,7 @@ int cayman_init(struct radeon_device *rdev)
 	/* Initialize clocks */
 	radeon_get_clock_info(rdev->ddev);
 	/* Fence driver */
-	r = radeon_fence_driver_init(rdev);
-	if (r)
-		return r;
+	radeon_fence_driver_init(rdev);
 	/* initialize memory controller */
 	r = evergreen_mc_init(rdev);
 	if (r)
diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index d0e94b10e4c0..013e44ed0f39 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -6857,9 +6857,7 @@ int si_init(struct radeon_device *rdev)
 	radeon_get_clock_info(rdev->ddev);
 
 	/* Fence driver */
-	r = radeon_fence_driver_init(rdev);
-	if (r)
-		return r;
+	radeon_fence_driver_init(rdev);
 
 	/* initialize memory controller */
 	r = si_mc_init(rdev);
-- 
2.31.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
