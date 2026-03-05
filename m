Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACF0EEF32C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 08:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABD3F10EB7A;
	Thu,  5 Mar 2026 08:15:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14F0410E1A3;
 Thu,  5 Mar 2026 00:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=pjNyIu0pcmnr8fjaZvf5mha04fiTO8ksgjhoYwaEJ4c=; b=2q9qmI/saqRb2QOFy9nxKz707y
 z0u2I/IYQIMz0XZ063n6MamoNQ4dKAbflji1ZnUw5NvjA+ovptZ7C61DAru0jvy+xb+6QFCtLAxRC
 vwPNHr9658HIH2CFE8vyJBhMD7KxT9SqbZ5DNIjPc6mjQWTBXXU+i/Qnkqt7Tyj515oUvcX70StwH
 Mu6z5qlb4dCHC/t53gmYyhdveYf4SB0/v0t+ulimyvGgpxE66wtS7EIMzcamI1QuF8hqvqPZn6yIH
 ELGFa/WJhmCIxbSrKkkfXW7ECXmOyXdSNwY9y1SV35v27DUoin/CRW0LkvBZ+Gtd1nHSMVcs/Y1da
 D72C5Rzw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1vxx0P-00000000ieu-1bmc; Thu, 05 Mar 2026 00:55:57 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: dri-devel@lists.freedesktop.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2] drm/amdgpu: amdgpu{_reset}.h: fix all kernel-doc warnings
Date: Wed,  4 Mar 2026 16:55:54 -0800
Message-ID: <20260305005556.1222863-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 05 Mar 2026 08:15:04 +0000
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

Fix all kernel-doc warnings in amdgpu.h and amdgpu_reset.h:
- Use the struct keyword for kernel-doc struct comments.
- Use the correct enum names in enum amd_reset_method.

This eliminates these warnings:

Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:477 cannot understand
 function prototype: 'struct amdgpu_wb'
Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Enum value
 'AMD_RESET_METHOD_LEGACY' not described in enum 'amd_reset_method'
Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Enum value
 'AMD_RESET_METHOD_MODE0' not described in enum 'amd_reset_method'
Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Enum value
 'AMD_RESET_METHOD_MODE1' not described in enum 'amd_reset_method'
Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Enum value
 'AMD_RESET_METHOD_MODE2' not described in enum 'amd_reset_method'
Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Enum value
 'AMD_RESET_METHOD_LINK' not described in enum 'amd_reset_method'
Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Enum value
 'AMD_RESET_METHOD_BACO' not described in enum 'amd_reset_method'
Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Enum value
 'AMD_RESET_METHOD_PCI' not described in enum 'amd_reset_method'
Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Enum value
 'AMD_RESET_METHOD_ON_INIT' not described in enum 'amd_reset_method'
Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Excess enum value
 '@AMD_RESET_LEGACY' description in 'amd_reset_method'
Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Excess enum value
 '@AMD_RESET_MODE0' description in 'amd_reset_method'
Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Excess enum value
 '@AMD_RESET_MODE1' description in 'amd_reset_method'
Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Excess enum value
 '@AMD_RESET_MODE2' description in 'amd_reset_method'
Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Excess enum value
 '@AMD_RESET_LINK' description in 'amd_reset_method'
Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Excess enum value
 '@AMD_RESET_BACO' description in 'amd_reset_method'
Warning: drivers/gpu/drm/amd/amdgpu/amdgpu.h:576 Excess enum value
 '@AMD_RESET_PCI' description in 'amd_reset_method'

Also move the enum to amdgpu_reset.h and eventually only forward declare
it in amdgpu.h. (Christian)
I moved the enum to amdgpu_reset.h and then #included amdgpu_reset.h
in amdgpu.h. The simpler method causes build errors.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>

 drivers/gpu/drm/amd/amdgpu/amdgpu.h       |   42 ------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h |   69 +++++++++++++++-----
 2 files changed, 58 insertions(+), 53 deletions(-)

--- linux-next-20260304.orig/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ linux-next-20260304/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -463,7 +463,7 @@ int amdgpu_file_to_fpriv(struct file *fi
 #define AMDGPU_MAX_WB 1024	/* Reserve at most 1024 WB slots for amdgpu-owned rings. */
 
 /**
- * amdgpu_wb - This struct is used for small GPU memory allocation.
+ * struct amdgpu_wb - This struct is used for small GPU memory allocation.
  *
  * This struct is used to allocate a small amount of GPU memory that can be
  * used to shadow certain states into the memory. This is especially useful for
@@ -537,44 +537,6 @@ struct amdgpu_allowed_register_entry {
 	bool grbm_indexed;
 };
 
-/**
- * enum amd_reset_method - Methods for resetting AMD GPU devices
- *
- * @AMD_RESET_METHOD_NONE: The device will not be reset.
- * @AMD_RESET_LEGACY: Method reserved for SI, CIK and VI ASICs.
- * @AMD_RESET_MODE0: Reset the entire ASIC. Not currently available for the
- *                   any device.
- * @AMD_RESET_MODE1: Resets all IP blocks on the ASIC (SDMA, GFX, VCN, etc.)
- *                   individually. Suitable only for some discrete GPU, not
- *                   available for all ASICs.
- * @AMD_RESET_MODE2: Resets a lesser level of IPs compared to MODE1. Which IPs
- *                   are reset depends on the ASIC. Notably doesn't reset IPs
- *                   shared with the CPU on APUs or the memory controllers (so
- *                   VRAM is not lost). Not available on all ASICs.
- * @AMD_RESET_LINK: Triggers SW-UP link reset on other GPUs
- * @AMD_RESET_BACO: BACO (Bus Alive, Chip Off) method powers off and on the card
- *                  but without powering off the PCI bus. Suitable only for
- *                  discrete GPUs.
- * @AMD_RESET_PCI: Does a full bus reset using core Linux subsystem PCI reset
- *                 and does a secondary bus reset or FLR, depending on what the
- *                 underlying hardware supports.
- *
- * Methods available for AMD GPU driver for resetting the device. Not all
- * methods are suitable for every device. User can override the method using
- * module parameter `reset_method`.
- */
-enum amd_reset_method {
-	AMD_RESET_METHOD_NONE = -1,
-	AMD_RESET_METHOD_LEGACY = 0,
-	AMD_RESET_METHOD_MODE0,
-	AMD_RESET_METHOD_MODE1,
-	AMD_RESET_METHOD_MODE2,
-	AMD_RESET_METHOD_LINK,
-	AMD_RESET_METHOD_BACO,
-	AMD_RESET_METHOD_PCI,
-	AMD_RESET_METHOD_ON_INIT,
-};
-
 struct amdgpu_video_codec_info {
 	u32 codec_type;
 	u32 max_width;
@@ -1371,6 +1333,8 @@ int emu_soc_asic_init(struct amdgpu_devi
 #define RBIOS16(i) (RBIOS8(i) | (RBIOS8((i)+1) << 8))
 #define RBIOS32(i) ((RBIOS16(i)) | (RBIOS16((i)+2) << 16))
 
+#include "amdgpu_reset.h"
+
 /*
  * ASICs macro.
  */
--- linux-next-20260304.orig/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ linux-next-20260304/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -46,6 +46,47 @@ enum AMDGPU_RESET_SRCS {
 	AMDGPU_RESET_SRC_USERQ,
 };
 
+/**
+ * enum amd_reset_method - Methods for resetting AMD GPU devices
+ *
+ * @AMD_RESET_METHOD_NONE: The device will not be reset.
+ * @AMD_RESET_METHOD_LEGACY: Method reserved for SI, CIK and VI ASICs.
+ * @AMD_RESET_METHOD_MODE0: Reset the entire ASIC. Not currently available for
+ *                          the any device.
+ * @AMD_RESET_METHOD_MODE1: Resets all IP blocks on the ASIC (SDMA, GFX, VCN,
+ *                   etc.) individually. Suitable only for some discrete GPU,
+ *                   not available for all ASICs.
+ * @AMD_RESET_METHOD_MODE2: Resets a lesser level of IPs compared to MODE1.
+ *                   Which IPs are reset depends on the ASIC. Notably doesn't
+ *                   reset IPs shared with the CPU on APUs or the memory
+ *                   controllers (so VRAM is not lost). Not available on all
+ *                   ASICs.
+ * @AMD_RESET_METHOD_LINK: Triggers SW-UP link reset on other GPUs
+ * @AMD_RESET_METHOD_BACO: BACO (Bus Alive, Chip Off) method powers off and on
+ *                   the card but without powering off the PCI bus. Suitable
+ *                   only for discrete GPUs.
+ * @AMD_RESET_METHOD_PCI: Does a full bus reset using core Linux subsystem
+ *                   PCI reset and does a secondary bus reset or FLR,
+ *                   depending on what the underlying hardware supports.
+ * @AMD_RESET_METHOD_ON_INIT: Does a device reset during the driver init
+ *                   sequence.
+ *
+ * Methods available for AMD GPU driver for resetting the device. Not all
+ * methods are suitable for every device. User can override the method using
+ * module parameter `reset_method`.
+ */
+enum amd_reset_method {
+	AMD_RESET_METHOD_NONE = -1,
+	AMD_RESET_METHOD_LEGACY = 0,
+	AMD_RESET_METHOD_MODE0,
+	AMD_RESET_METHOD_MODE1,
+	AMD_RESET_METHOD_MODE2,
+	AMD_RESET_METHOD_LINK,
+	AMD_RESET_METHOD_BACO,
+	AMD_RESET_METHOD_PCI,
+	AMD_RESET_METHOD_ON_INIT,
+};
+
 struct amdgpu_reset_context {
 	enum amd_reset_method method;
 	struct amdgpu_device *reset_req_dev;
@@ -56,6 +97,20 @@ struct amdgpu_reset_context {
 	enum AMDGPU_RESET_SRCS src;
 };
 
+struct amdgpu_reset_control {
+	void *handle;
+	struct work_struct reset_work;
+	struct mutex reset_lock;
+	struct amdgpu_reset_handler *(
+		*reset_handlers)[AMDGPU_RESET_MAX_HANDLERS];
+	atomic_t in_reset;
+	enum amd_reset_method active_reset;
+	struct amdgpu_reset_handler *(*get_reset_handler)(
+		struct amdgpu_reset_control *reset_ctl,
+		struct amdgpu_reset_context *context);
+	void (*async_reset)(struct work_struct *work);
+};
+
 struct amdgpu_reset_handler {
 	enum amd_reset_method reset_method;
 	int (*prepare_env)(struct amdgpu_reset_control *reset_ctl,
@@ -72,20 +127,6 @@ struct amdgpu_reset_handler {
 	int (*do_reset)(struct amdgpu_device *adev);
 };
 
-struct amdgpu_reset_control {
-	void *handle;
-	struct work_struct reset_work;
-	struct mutex reset_lock;
-	struct amdgpu_reset_handler *(
-		*reset_handlers)[AMDGPU_RESET_MAX_HANDLERS];
-	atomic_t in_reset;
-	enum amd_reset_method active_reset;
-	struct amdgpu_reset_handler *(*get_reset_handler)(
-		struct amdgpu_reset_control *reset_ctl,
-		struct amdgpu_reset_context *context);
-	void (*async_reset)(struct work_struct *work);
-};
-
 
 enum amdgpu_reset_domain_type {
 	SINGLE_DEVICE,
