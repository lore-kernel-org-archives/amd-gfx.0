Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385A5C02183
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 18:29:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA7C510E20B;
	Thu, 16 Jan 2025 18:29:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="sP6NvrZq";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C950310E208
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 18:29:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id C56A9A42727;
 Thu, 16 Jan 2025 18:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258E4C4CEE1;
 Thu, 16 Jan 2025 18:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737052170;
 bh=HxPl1DhmJVYoYe4vSTErZ40bQ7uF+p4i1nsLh8ceEFs=;
 h=From:To:Cc:Subject:Date:From;
 b=sP6NvrZqUgzh8ePUivvdLGed+vOw4HzQWP5gLUunqCEfHy0OsX1dGaEP+K0iZqeXX
 QPaT/TTJYUbzpTicGCtKvqEBG+yq1Xt7BJMilJr+SAlTZ8XojudTdBuZKGh4YO0HGE
 EgmNuQCR39qa9BWlgr6rvF4UAdk1llBA25SEEFYClI65npnulNIrmq+RyL8PzpaIqx
 o2MuwS9i/pbdehTceSTrpa3+Dy/YxdBbNL/gOpqYYI37IAM4087phhdKwhhmLQyhxw
 7FcR9WhfTY4RhCVQ9zAXhOdwxfxdAvk3Hx4eJ9hgRUbtFFBjYxT9NGTF6+YPIxCns1
 GoanxPXVn285A==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [RFC] drm/amd: Drop gttsize module parameter
Date: Thu, 16 Jan 2025 12:29:21 -0600
Message-ID: <20250116182921.1730696-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mario Limonciello <mario.limonciello@amd.com>

When not set `gttsize` module parameter by default will get the
value to use for the GTT pool from the TTM page limit, which is
set by a separate module parameter.

This inevitably leads to people not sure which one to set when they
want more addressable memory for the GPU, and you'll end up seeing
instructions online saying to set both.

Drop the amdgpu module parameter and related code for it.  This way
if users want to change the amount of addressable memory they can
change it solely in TTM.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 -------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 9 ---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 9 ++-------
 4 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5e55a44f9eef..e728974114bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -164,7 +164,6 @@ extern int amdgpu_modeset;
 extern unsigned int amdgpu_vram_limit;
 extern int amdgpu_vis_vram_limit;
 extern int amdgpu_gart_size;
-extern int amdgpu_gtt_size;
 extern int amdgpu_moverate;
 extern int amdgpu_audio;
 extern int amdgpu_disp_priority;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3774d12ebc4a..1b62b843e5fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2031,13 +2031,6 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 		amdgpu_gart_size = -1;
 	}
 
-	if (amdgpu_gtt_size != -1 && amdgpu_gtt_size < 32) {
-		/* gtt size must be greater or equal to 32M */
-		dev_warn(adev->dev, "gtt size (%d) too small\n",
-				 amdgpu_gtt_size);
-		amdgpu_gtt_size = -1;
-	}
-
 	/* valid range is between 4 and 9 inclusive */
 	if (amdgpu_vm_fragment_size != -1 &&
 	    (amdgpu_vm_fragment_size > 9 || amdgpu_vm_fragment_size < 4)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b911653dd8b6..62b09c518665 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -141,7 +141,6 @@ enum AMDGPU_DEBUG_MASK {
 unsigned int amdgpu_vram_limit = UINT_MAX;
 int amdgpu_vis_vram_limit;
 int amdgpu_gart_size = -1; /* auto */
-int amdgpu_gtt_size = -1; /* auto */
 int amdgpu_moverate = -1; /* auto */
 int amdgpu_audio = -1;
 int amdgpu_disp_priority;
@@ -279,14 +278,6 @@ module_param_named(vis_vramlimit, amdgpu_vis_vram_limit, int, 0444);
 MODULE_PARM_DESC(gartsize, "Size of kernel GART to setup in megabytes (32, 64, etc., -1=auto)");
 module_param_named(gartsize, amdgpu_gart_size, uint, 0600);
 
-/**
- * DOC: gttsize (int)
- * Restrict the size of GTT domain (for userspace use) in MiB for testing.
- * The default is -1 (Use 1/2 RAM, minimum value is 3GB).
- */
-MODULE_PARM_DESC(gttsize, "Size of the GTT userspace domain in megabytes (-1 = auto)");
-module_param_named(gttsize, amdgpu_gtt_size, int, 0600);
-
 /**
  * DOC: moverate (int)
  * Set maximum buffer migration rate in MB/s. The default is -1 (8 MB/s).
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e6fc89440210..e3fee81d8646 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1957,13 +1957,8 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
 		 (unsigned int)(adev->gmc.real_vram_size / (1024 * 1024)));
 
-	/* Compute GTT size, either based on TTM limit
-	 * or whatever the user passed on module init.
-	 */
-	if (amdgpu_gtt_size == -1)
-		gtt_size = ttm_tt_pages_limit() << PAGE_SHIFT;
-	else
-		gtt_size = (uint64_t)amdgpu_gtt_size << 20;
+	/* Compute GTT size, based on TTM limit */
+	gtt_size = ttm_tt_pages_limit() << PAGE_SHIFT;
 
 	/* Initialize GTT memory pool */
 	r = amdgpu_gtt_mgr_init(adev, gtt_size);
-- 
2.48.0

