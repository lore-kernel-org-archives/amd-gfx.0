Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B47C433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Dec 2021 00:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9D5710E688;
	Sat, 11 Dec 2021 00:40:43 +0000 (UTC)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5620610E688
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Dec 2021 00:40:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [88.120.44.86])
 by smtp5-g21.free.fr (Postfix) with ESMTP id F25F05FE03;
 Sat, 11 Dec 2021 01:40:39 +0100 (CET)
From: Yann Dirson <ydirson@free.fr>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] amdgpu: fix some kernel-doc markup
Date: Sat, 11 Dec 2021 01:40:34 +0100
Message-Id: <20211211004034.13473-1-ydirson@free.fr>
X-Mailer: git-send-email 2.31.1
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
Cc: Yann Dirson <ydirson@free.fr>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Those are not today pulled by the sphinx doc, but better be ready.

Signed-off-by: Yann Dirson <ydirson@free.fr>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c           |  2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a1c14466f23d..75c9a9827ea7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -331,7 +331,7 @@ void amdgpu_device_mm_access(struct amdgpu_device *adev, loff_t pos,
 }
 
 /**
- * amdgpu_device_vram_access - access vram by vram aperature
+ * amdgpu_device_aper_access - access vram by vram aperature
  *
  * @adev: amdgpu_device pointer
  * @pos: offset of the buffer in vram
@@ -550,11 +550,11 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
 	trace_amdgpu_device_wreg(adev->pdev->device, reg, v);
 }
 
-/*
+/**
  * amdgpu_mm_wreg_mmio_rlc -  write register either with mmio or with RLC path if in range
  *
  * this function is invoked only the debugfs register access
- * */
+ */
 void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
 			     uint32_t reg, uint32_t v)
 {
@@ -1100,7 +1100,7 @@ static void amdgpu_device_wb_fini(struct amdgpu_device *adev)
 }
 
 /**
- * amdgpu_device_wb_init- Init Writeback driver info and allocate memory
+ * amdgpu_device_wb_init - Init Writeback driver info and allocate memory
  *
  * @adev: amdgpu_device pointer
  *
@@ -3801,7 +3801,7 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
 }
 
 /**
- * amdgpu_device_fini - tear down the driver
+ * amdgpu_device_fini_hw - tear down the driver
  *
  * @adev: amdgpu_device pointer
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 3907fc726ab2..e4618c7777b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -390,7 +390,7 @@ void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
 }
 
 /**
- * amdgpu_irq_fini - shut down interrupt handling
+ * amdgpu_irq_fini_sw - shut down interrupt handling
  *
  * @adev: amdgpu device pointer
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 151f3559e0ae..3294d602f2c8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -624,7 +624,7 @@ static void dm_dcn_vertical_interrupt0_high_irq(void *interrupt_params)
 #endif /* CONFIG_DRM_AMD_SECURE_DISPLAY */
 
 /**
- * dmub_aux_setconfig_reply_callback - Callback for AUX or SET_CONFIG command.
+ * dmub_aux_setconfig_callback - Callback for AUX or SET_CONFIG command.
  * @adev: amdgpu_device pointer
  * @notify: dmub notification structure
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index bb65f41d1a59..c98e402eab0c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -50,9 +50,9 @@
 
 #define AMDGPU_DMUB_NOTIFICATION_MAX 5
 
-/**
+/*
  * DMUB Async to Sync Mechanism Status
- **/
+ */
 #define DMUB_ASYNC_TO_SYNC_ACCESS_FAIL 1
 #define DMUB_ASYNC_TO_SYNC_ACCESS_TIMEOUT 2
 #define DMUB_ASYNC_TO_SYNC_ACCESS_SUCCESS 3
-- 
2.31.1

