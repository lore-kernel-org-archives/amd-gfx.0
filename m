Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3E3C88E7B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 11:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 084F210FC07;
	Tue, 15 Sep 2026 11:49:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ITDR3iFt";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 746B510FBFD
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 11:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=orzr1a4cRYHkUQJMQ2DSjRmC2Eq8yUm5SrNIk99na/U=; b=ITDR3iFtsRTU02NdWaSV05Mvp4
 f5vJ3EP5fGGJF+v1uy+bzvYLU7US2kN6yu+mTc0jpOs7TVTLTcQSHPyDL3PCcMr8RwqELGaM3Gok9
 pG5Ayv5EuvoBAXTk8Rk1Pjltk9GqzoV6MqWUyu2tQH5a+FjEPlilCC1gMVTVqelOiP/qc+rb8RuBO
 AZT38SxKh8pz3xu828QZAKJIxe3OrKaXDKa2rfe+nDALbAmiT7RgZDeZsp0cEKnV+VRcFEUcBHxYa
 D6sL1oeNMEHPc0HZDyAnXCOL+xmYxIDMjX5nZnG9C0f/KlsO+Wq4kL4iEo4J9jDvh7LiIyt8dEyUx
 c4uQ4oQg==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x6RfO-002Q2r-OT; Tue, 15 Sep 2026 13:49:38 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH v4 2/6] drm/amdgpu: Add amdgpu_sdma_types.h header
Date: Tue, 15 Sep 2026 12:49:30 +0100
Message-ID: <20260915114934.60326-3-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915114934.60326-1-tvrtko.ursulin@igalia.com>
References: <20260915114934.60326-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

There is an include loop between amdgpu.h and amdgpu_sdma.h which
prevents adding any interesting static inline helpers to the latter.

Break it by moving the type definitions to a new amdgpu_sdma_types.h
header.

This is required so static inline helpers which need to dereference
struct amdgpu_device can be added to amdgpu_sdma.h.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
v2:
 * More explanation in the commit message.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      | 141 ++--------------
 .../gpu/drm/amd/amdgpu/amdgpu_sdma_types.h    | 159 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    |   1 +
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c    |   1 +
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |   1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c        |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |   2 +
 18 files changed, 188 insertions(+), 131 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma_types.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 79b69d74eb2e..5811709b33b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -79,7 +79,7 @@
 #include "amdgpu_umsch_mm.h"
 #include "amdgpu_gmc.h"
 #include "amdgpu_gfx.h"
-#include "amdgpu_sdma.h"
+#include "amdgpu_sdma_types.h"
 #include "amdgpu_lsdma.h"
 #include "amdgpu_nbio.h"
 #include "amdgpu_reg_access.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index d80fe17556da..d8786a93a851 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -36,6 +36,7 @@
 #include "amdgpu_rap.h"
 #include "amdgpu_securedisplay.h"
 #include "amdgpu_fw_attestation.h"
+#include "amdgpu_sdma.h"
 #include "amdgpu_umr.h"
 
 #include "amdgpu_reset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 7c0554506334..1bf2a42fa63c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -33,6 +33,8 @@
 #include "amdgpu_gmc.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_reset.h"
+#include "amdgpu_ring.h"
+#include "amdgpu_sdma.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_atomfirmware.h"
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 0a692804bc53..e77ea4ade8ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -23,141 +23,22 @@
 
 #ifndef __AMDGPU_SDMA_H__
 #define __AMDGPU_SDMA_H__
-#include "amdgpu_ras.h"
 
-/* max number of IP instances */
-#define AMDGPU_MAX_SDMA_INSTANCES		16
+#include "amdgpu_sdma_types.h"
 
-enum amdgpu_sdma_irq {
-	AMDGPU_SDMA_IRQ_INSTANCE0  = 0,
-	AMDGPU_SDMA_IRQ_INSTANCE1,
-	AMDGPU_SDMA_IRQ_INSTANCE2,
-	AMDGPU_SDMA_IRQ_INSTANCE3,
-	AMDGPU_SDMA_IRQ_INSTANCE4,
-	AMDGPU_SDMA_IRQ_INSTANCE5,
-	AMDGPU_SDMA_IRQ_INSTANCE6,
-	AMDGPU_SDMA_IRQ_INSTANCE7,
-	AMDGPU_SDMA_IRQ_INSTANCE8,
-	AMDGPU_SDMA_IRQ_INSTANCE9,
-	AMDGPU_SDMA_IRQ_INSTANCE10,
-	AMDGPU_SDMA_IRQ_INSTANCE11,
-	AMDGPU_SDMA_IRQ_INSTANCE12,
-	AMDGPU_SDMA_IRQ_INSTANCE13,
-	AMDGPU_SDMA_IRQ_INSTANCE14,
-	AMDGPU_SDMA_IRQ_INSTANCE15,
-	AMDGPU_SDMA_IRQ_LAST
-};
+#include "amdgpu.h"
+#include "amdgpu_ring.h"
+
+#include <linux/types.h>
+
+struct amdgpu_device;
+struct amdgpu_iv_entry;
+struct amdgpu_irq_src;
+struct amdgpu_ring;
+struct ras_common_if;
 
 #define NUM_SDMA(x) hweight32(x)
 
-struct amdgpu_sdma_csa_info {
-	u32 size;
-	u32 alignment;
-};
-
-struct amdgpu_sdma_funcs {
-	int (*stop_kernel_queue)(struct amdgpu_ring *ring);
-	int (*start_kernel_queue)(struct amdgpu_ring *ring);
-	int (*soft_reset_kernel_queue)(struct amdgpu_device *adev, u32 instance_id);
-};
-
-struct amdgpu_sdma_instance {
-	/* SDMA firmware */
-	const struct firmware	*fw;
-	uint32_t		fw_version;
-	uint32_t		feature_version;
-
-	struct amdgpu_ring	ring;
-	struct amdgpu_ring	page;
-	bool			burst_nop;
-	union {
-	    uint32_t		aid_id;
-	    uint32_t		xcc_id;
-	};
-
-	struct amdgpu_bo	*sdma_fw_obj;
-	uint64_t		sdma_fw_gpu_addr;
-	uint32_t		*sdma_fw_ptr;
-	struct mutex		engine_reset_mutex;
-	/* track guilty state of GFX and PAGE queues */
-	bool			gfx_guilty;
-	bool			page_guilty;
-	const struct amdgpu_sdma_funcs   *funcs;
-};
-
-struct amdgpu_sdma_ras {
-	struct amdgpu_ras_block_object ras_block;
-};
-
-struct amdgpu_sdma {
-	struct amdgpu_sdma_instance instance[AMDGPU_MAX_SDMA_INSTANCES];
-	struct amdgpu_irq_src	trap_irq;
-	struct amdgpu_irq_src	illegal_inst_irq;
-	struct amdgpu_irq_src	fence_irq;
-	struct amdgpu_irq_src	ecc_irq;
-	struct amdgpu_irq_src	vm_hole_irq;
-	struct amdgpu_irq_src	doorbell_invalid_irq;
-	struct amdgpu_irq_src	pool_timeout_irq;
-	struct amdgpu_irq_src	srbm_write_irq;
-	struct amdgpu_irq_src	ctxt_empty_irq;
-
-	int			num_instances;
-	uint32_t 		sdma_mask;
-	bool    		sdma_debug;
-	union {
-	    int			num_inst_per_aid;
-	    int			num_inst_per_xcc;
-	};
-	uint32_t                    srbm_soft_reset;
-	bool			has_page_queue;
-	struct ras_common_if	*ras_if;
-	struct amdgpu_sdma_ras	*ras;
-	uint32_t		*ip_dump;
-	uint32_t 		supported_reset;
-	struct list_head	reset_callback_list;
-	bool			no_user_submission;
-	bool			disable_uq;
-	void (*get_csa_info)(struct amdgpu_device *adev,
-			     struct amdgpu_sdma_csa_info *csa_info);
-};
-
-/*
- * Provided by hw blocks that can move/clear data.  e.g., gfx or sdma
- * But currently, we use sdma to move data.
- */
-struct amdgpu_buffer_funcs {
-	/* maximum bytes in a single operation */
-	uint32_t	copy_max_bytes;
-
-	/* number of dw to reserve per operation */
-	unsigned	copy_num_dw;
-
-	/* used for buffer migration */
-	void (*emit_copy_buffer)(struct amdgpu_ib *ib,
-				 /* src addr in bytes */
-				 uint64_t src_offset,
-				 /* dst addr in bytes */
-				 uint64_t dst_offset,
-				 /* number of byte to transfer */
-				 uint32_t byte_count,
-				 uint32_t copy_flags);
-
-	/* maximum bytes in a single operation */
-	uint32_t	fill_max_bytes;
-
-	/* number of dw to reserve per operation */
-	unsigned	fill_num_dw;
-
-	/* used for buffer clearing */
-	void (*emit_fill_buffer)(struct amdgpu_ib *ib,
-				 /* value to write to memory */
-				 uint32_t src_data,
-				 /* dst addr in bytes */
-				 uint64_t dst_offset,
-				 /* number of byte to fill */
-				 uint32_t byte_count);
-};
-
 int __printf(4, 5)
 amdgpu_sdma_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 		      unsigned int instance, const char *fmt, ...);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma_types.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma_types.h
new file mode 100644
index 000000000000..d6e7a703c2e0
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma_types.h
@@ -0,0 +1,159 @@
+/*
+ * Copyright 2018 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __AMDGPU_SDMA_TYPES_H__
+#define __AMDGPU_SDMA_TYPES_H__
+#include "amdgpu_ras.h"
+
+/* max number of IP instances */
+#define AMDGPU_MAX_SDMA_INSTANCES		16
+
+enum amdgpu_sdma_irq {
+	AMDGPU_SDMA_IRQ_INSTANCE0  = 0,
+	AMDGPU_SDMA_IRQ_INSTANCE1,
+	AMDGPU_SDMA_IRQ_INSTANCE2,
+	AMDGPU_SDMA_IRQ_INSTANCE3,
+	AMDGPU_SDMA_IRQ_INSTANCE4,
+	AMDGPU_SDMA_IRQ_INSTANCE5,
+	AMDGPU_SDMA_IRQ_INSTANCE6,
+	AMDGPU_SDMA_IRQ_INSTANCE7,
+	AMDGPU_SDMA_IRQ_INSTANCE8,
+	AMDGPU_SDMA_IRQ_INSTANCE9,
+	AMDGPU_SDMA_IRQ_INSTANCE10,
+	AMDGPU_SDMA_IRQ_INSTANCE11,
+	AMDGPU_SDMA_IRQ_INSTANCE12,
+	AMDGPU_SDMA_IRQ_INSTANCE13,
+	AMDGPU_SDMA_IRQ_INSTANCE14,
+	AMDGPU_SDMA_IRQ_INSTANCE15,
+	AMDGPU_SDMA_IRQ_LAST
+};
+
+struct amdgpu_sdma_csa_info {
+	u32 size;
+	u32 alignment;
+};
+
+struct amdgpu_sdma_funcs {
+	int (*stop_kernel_queue)(struct amdgpu_ring *ring);
+	int (*start_kernel_queue)(struct amdgpu_ring *ring);
+	int (*soft_reset_kernel_queue)(struct amdgpu_device *adev, u32 instance_id);
+};
+
+struct amdgpu_sdma_instance {
+	/* SDMA firmware */
+	const struct firmware	*fw;
+	uint32_t		fw_version;
+	uint32_t		feature_version;
+
+	struct amdgpu_ring	ring;
+	struct amdgpu_ring	page;
+	bool			burst_nop;
+	union {
+	    uint32_t		aid_id;
+	    uint32_t		xcc_id;
+	};
+
+	struct amdgpu_bo	*sdma_fw_obj;
+	uint64_t		sdma_fw_gpu_addr;
+	uint32_t		*sdma_fw_ptr;
+	struct mutex		engine_reset_mutex;
+	/* track guilty state of GFX and PAGE queues */
+	bool			gfx_guilty;
+	bool			page_guilty;
+	const struct amdgpu_sdma_funcs   *funcs;
+};
+
+struct amdgpu_sdma_ras {
+	struct amdgpu_ras_block_object ras_block;
+};
+
+struct amdgpu_sdma {
+	struct amdgpu_sdma_instance instance[AMDGPU_MAX_SDMA_INSTANCES];
+	struct amdgpu_irq_src	trap_irq;
+	struct amdgpu_irq_src	illegal_inst_irq;
+	struct amdgpu_irq_src	fence_irq;
+	struct amdgpu_irq_src	ecc_irq;
+	struct amdgpu_irq_src	vm_hole_irq;
+	struct amdgpu_irq_src	doorbell_invalid_irq;
+	struct amdgpu_irq_src	pool_timeout_irq;
+	struct amdgpu_irq_src	srbm_write_irq;
+	struct amdgpu_irq_src	ctxt_empty_irq;
+
+	int			num_instances;
+	uint32_t 		sdma_mask;
+	bool    		sdma_debug;
+	union {
+	    int			num_inst_per_aid;
+	    int			num_inst_per_xcc;
+	};
+	uint32_t                    srbm_soft_reset;
+	bool			has_page_queue;
+	struct ras_common_if	*ras_if;
+	struct amdgpu_sdma_ras	*ras;
+	uint32_t		*ip_dump;
+	uint32_t 		supported_reset;
+	struct list_head	reset_callback_list;
+	bool			no_user_submission;
+	bool			disable_uq;
+	void (*get_csa_info)(struct amdgpu_device *adev,
+			     struct amdgpu_sdma_csa_info *csa_info);
+};
+
+/*
+ * Provided by hw blocks that can move/clear data.  e.g., gfx or sdma
+ * But currently, we use sdma to move data.
+ */
+struct amdgpu_buffer_funcs {
+	/* maximum bytes in a single operation */
+	uint32_t	copy_max_bytes;
+
+	/* number of dw to reserve per operation */
+	unsigned	copy_num_dw;
+
+	/* used for buffer migration */
+	void (*emit_copy_buffer)(struct amdgpu_ib *ib,
+				 /* src addr in bytes */
+				 uint64_t src_offset,
+				 /* dst addr in bytes */
+				 uint64_t dst_offset,
+				 /* number of byte to transfer */
+				 uint32_t byte_count,
+				 uint32_t copy_flags);
+
+	/* maximum bytes in a single operation */
+	uint32_t	fill_max_bytes;
+
+	/* number of dw to reserve per operation */
+	unsigned	fill_num_dw;
+
+	/* used for buffer clearing */
+	void (*emit_fill_buffer)(struct amdgpu_ib *ib,
+				 /* value to write to memory */
+				 uint32_t src_data,
+				 /* dst addr in bytes */
+				 uint64_t dst_offset,
+				 /* number of byte to fill */
+				 uint32_t byte_count);
+};
+
+#endif
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index ad8cc95e6cfa..29723ff53503 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -26,6 +26,7 @@
 #include <drm/drm_mm.h>
 #include <linux/random.h>
 #include "amdgpu.h"
+#include "amdgpu_sdma.h"
 #include "amdgpu_ualink.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_dma_buf.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index cddfe4015f53..9a0c12b1a309 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -30,6 +30,7 @@
 #include "gfxhub_v1_2.h"
 #include "sdma_v4_4_2.h"
 #include "amdgpu_ip.h"
+#include "amdgpu_sdma.h"
 
 void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index de2323e23566..45f429ed23e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -27,6 +27,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_ucode.h"
+#include "amdgpu_sdma.h"
 #include "amdgpu_trace.h"
 #include "cikd.h"
 #include "cik.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 11e118a4aee8..cf2ae307933f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -28,6 +28,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_ucode.h"
+#include "amdgpu_sdma.h"
 #include "amdgpu_trace.h"
 #include "vi.h"
 #include "vid.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 87743fe6ae44..287c1796370f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -28,6 +28,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_ucode.h"
+#include "amdgpu_sdma.h"
 #include "amdgpu_trace.h"
 #include "vi.h"
 #include "vid.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index e77e29855c68..dc260fa3caa9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -28,6 +28,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_ucode.h"
+#include "amdgpu_sdma.h"
 #include "amdgpu_trace.h"
 
 #include "sdma0/sdma0_4_2_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 2bed58e983be..2412ed9a9376 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -30,6 +30,7 @@
 #include "amdgpu_xcp.h"
 #include "amdgpu_ucode.h"
 #include "amdgpu_trace.h"
+#include "amdgpu_sdma.h"
 #include "amdgpu_reset.h"
 
 #include "sdma/sdma_4_4_2_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index fa25d1508404..fdbb5195b354 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -28,6 +28,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_ucode.h"
+#include "amdgpu_sdma.h"
 #include "amdgpu_trace.h"
 
 #include "gc/gc_10_1_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 8d0ffad0284a..13addc71ae17 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -28,6 +28,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_ucode.h"
+#include "amdgpu_sdma.h"
 #include "amdgpu_trace.h"
 
 #include "gc/gc_10_3_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index b28934739d32..11a0d87e56e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -28,6 +28,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_ucode.h"
+#include "amdgpu_sdma.h"
 #include "amdgpu_trace.h"
 
 #include "gc/gc_11_0_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 4503bae1d48c..c1ba1777f915 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -28,6 +28,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_ucode.h"
+#include "amdgpu_sdma.h"
 #include "amdgpu_trace.h"
 
 #include "gc/gc_12_0_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index f33b0dc17c50..916e92bae535 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -28,6 +28,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_ucode.h"
+#include "amdgpu_sdma.h"
 #include "amdgpu_trace.h"
 
 #include "gc/gc_12_1_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 6b64b1692235..8b96e1fe741a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -24,6 +24,8 @@
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
 #include <linux/migrate.h>
+#include "amdgpu.h"
+#include "amdgpu_sdma.h"
 #include "amdgpu_sync.h"
 #include "amdgpu_object.h"
 #include "amdgpu_vm.h"
-- 
2.55.0

