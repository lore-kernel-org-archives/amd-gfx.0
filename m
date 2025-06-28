Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58939C54ED1
	for <amd-gfx@archiver.kernel.org>; Sat, 28 Jun 2025 18:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9DDF10E013;
	Sat, 28 Jun 2025 18:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="AlbYILQY";
	dkim-atps=neutral
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9E4910E013
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Jun 2025 18:55:01 +0000 (UTC)
Received: from over.fork.zz (unknown [82.65.94.41])
 (Authenticated sender: patrick9876@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 08B2B78032A;
 Sat, 28 Jun 2025 20:54:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1751136896;
 bh=oZKr9OHR0vFEJukAwxzg2Y2OTP6sCyUdgxFr1ciGQyg=;
 h=From:To:Subject:Date:In-Reply-To:References:Reply-To:From;
 b=AlbYILQYrFRbibUMR18lxHCpGhHRazr5oEmoCBpmPH2m1X8LWJojZ6SEvi7Vlf/s0
 kxFjtOfCIPuI+YyoVwUEw0kgIJh/53NqWg98KM5/7otM2Qmuja3i7x+dcUAfTspPUM
 Ktd+neHRR+4n2nrqVY9mAZYf4vVg/fzy9Cg4T+sbS6F4/pqQ/pBfdRMFmkjtJGcMQ9
 MrUz28gkDuWtRZugpnamfgARoSeBGCknHW1hESOQQgC9kOiyBfKAyYd3qFWsi8AvYU
 8PKbB5K17Ld2E0bEeBl2QX+F2Bt3OGJgp3V1YABEiB7LkSdfa7Xi2pzWGsXpmrMqMK
 Mnh9t2k155fSQ==
From: Patrick Lerda <patrick9876@free.fr>
To: patrick9876@free.fr,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/radeon: bump version to 2.51.0
Date: Sat, 28 Jun 2025 20:54:23 +0200
Message-ID: <20250628185442.11819-1-patrick9876@free.fr>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <CADnq5_MRRO=YPv4OfzYeiZUgjqi35yKLG7+fOVmqaVXn5FZHTw@mail.gmail.com>
References: <CADnq5_MRRO=YPv4OfzYeiZUgjqi35yKLG7+fOVmqaVXn5FZHTw@mail.gmail.com>
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
Reply-To: Alex Deucher <alexdeucher@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The version 2.51.0 adds OpenGL 4.6 compatibility to
evergreen and cayman.

Signed-off-by: Patrick Lerda <patrick9876@free.fr>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 267f082bc430..88e821d67af7 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -110,9 +110,10 @@
  *   2.48.0 - TA_CS_BC_BASE_ADDR allowed on SI
  *   2.49.0 - DRM_RADEON_GEM_INFO ioctl returns correct vram_size/visible values
  *   2.50.0 - Allows unaligned shader loads on CIK. (needed by OpenGL)
+ *   2.51.0 - Add evergreen/cayman OpenGL 4.6 compatibility
  */
 #define KMS_DRIVER_MAJOR	2
-#define KMS_DRIVER_MINOR	50
+#define KMS_DRIVER_MINOR	51
 #define KMS_DRIVER_PATCHLEVEL	0
 
 int radeon_no_wb;
-- 
2.50.0

