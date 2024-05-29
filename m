Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC91C27C43
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 09:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32E3F1135AB;
	Wed, 29 May 2024 09:50:45 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12CA81135E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 09:50:42 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 44T9oaKE1669942; Wed, 29 May 2024 15:20:36 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 44T9oaTx1669941;
 Wed, 29 May 2024 15:20:36 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 3/3] drm/amdgpu: add cp queue registers for gfx9 ipdump
Date: Wed, 29 May 2024 15:20:32 +0530
Message-Id: <20240529095032.1669886-4-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529095032.1669886-1-sunil.khatri@amd.com>
References: <20240529095032.1669886-1-sunil.khatri@amd.com>
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

Add gfx9 support of CP queue registers for all queues
to be used by devcoredump.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 110 +++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index f3d281de2a34..f1a7b60e73ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -237,6 +237,47 @@ static const struct amdgpu_hwip_reg_entry gc_reg_list_9[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3)
 };
 
+static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_9[] = {
+	/* compute queue registers */
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_VMID),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_ACTIVE),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PERSISTENT_STATE),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PIPE_PRIORITY),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_QUEUE_PRIORITY),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_QUANTUM),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_BASE),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_BASE_ADDR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_BASE_ADDR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_DEQUEUE_REQUEST),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_BASE_ADDR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_BASE_ADDR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_EVENTS),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_BASE_ADDR_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_BASE_ADDR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CNTL_STACK_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CNTL_STACK_SIZE),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_WG_STATE_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_SIZE),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_GDS_RESOURCE_STATE),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_ERROR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_WPTR_MEM),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_GFX_STATUS),
+};
+
 enum ta_ras_gfx_subblock {
 	/*CPC*/
 	TA_RAS_BLOCK__GFX_CPC_INDEX_START = 0,
@@ -2086,6 +2127,7 @@ static void gfx_v9_0_alloc_ip_dump(struct amdgpu_device *adev)
 {
 	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_9);
 	uint32_t *ptr;
+	uint32_t inst;
 
 	ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
 	if (ptr == NULL) {
@@ -2094,6 +2136,19 @@ static void gfx_v9_0_alloc_ip_dump(struct amdgpu_device *adev)
 	} else {
 		adev->gfx.ip_dump_core = ptr;
 	}
+
+	/* Allocate memory for compute queue registers for all the instances */
+	reg_count = ARRAY_SIZE(gc_cp_reg_list_9);
+	inst = adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
+		adev->gfx.mec.num_queue_per_pipe;
+
+	ptr = kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
+	if (ptr == NULL) {
+		DRM_ERROR("Failed to allocate memory for GFX CP IP Dump\n");
+		adev->gfx.ip_dump_cp_queues = NULL;
+	} else {
+		adev->gfx.ip_dump_cp_queues = ptr;
+	}
 }
 
 static int gfx_v9_0_sw_init(void *handle)
@@ -2311,6 +2366,7 @@ static int gfx_v9_0_sw_fini(void *handle)
 	gfx_v9_0_free_microcode(adev);
 
 	kfree(adev->gfx.ip_dump_core);
+	kfree(adev->gfx.ip_dump_cp_queues);
 
 	return 0;
 }
@@ -6949,7 +7005,7 @@ static void gfx_v9_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
 static void gfx_v9_ip_print(void *handle, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	uint32_t i;
+	uint32_t i, j, k, reg, index = 0;
 	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_9);
 
 	if (!adev->gfx.ip_dump_core)
@@ -6960,12 +7016,36 @@ static void gfx_v9_ip_print(void *handle, struct drm_printer *p)
 			   gc_reg_list_9[i].reg_name,
 			   adev->gfx.ip_dump_core[i]);
 
+	/* print compute queue registers for all instances */
+	if (!adev->gfx.ip_dump_cp_queues)
+		return;
+
+	reg_count = ARRAY_SIZE(gc_cp_reg_list_9);
+	drm_printf(p, "\nnum_mec: %d num_pipe: %d num_queue: %d\n",
+		   adev->gfx.mec.num_mec,
+		   adev->gfx.mec.num_pipe_per_mec,
+		   adev->gfx.mec.num_queue_per_pipe);
+
+	for (i = 0; i < adev->gfx.mec.num_mec; i++) {
+		for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
+			for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
+				drm_printf(p, "\nmec %d, pipe %d, queue %d\n", i, j, k);
+				for (reg = 0; reg < reg_count; reg++) {
+					drm_printf(p, "%-50s \t 0x%08x\n",
+						   gc_cp_reg_list_9[reg].reg_name,
+						   adev->gfx.ip_dump_cp_queues[index + reg]);
+				}
+				index += reg_count;
+			}
+		}
+	}
+
 }
 
 static void gfx_v9_ip_dump(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	uint32_t i;
+	uint32_t i, j, k, reg, index = 0;
 	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_9);
 
 	if (!adev->gfx.ip_dump_core)
@@ -6976,6 +7056,32 @@ static void gfx_v9_ip_dump(void *handle)
 		adev->gfx.ip_dump_core[i] = RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_9[i]));
 	amdgpu_gfx_off_ctrl(adev, true);
 
+	/* dump compute queue registers for all instances */
+	if (!adev->gfx.ip_dump_cp_queues)
+		return;
+
+	reg_count = ARRAY_SIZE(gc_cp_reg_list_9);
+	amdgpu_gfx_off_ctrl(adev, false);
+	mutex_lock(&adev->srbm_mutex);
+	for (i = 0; i < adev->gfx.mec.num_mec; i++) {
+		for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
+			for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
+				/* ME0 is for GFX so start from 1 for CP */
+				soc15_grbm_select(adev, 1 + i, j, k, 0, 0);
+
+				for (reg = 0; reg < reg_count; reg++) {
+					adev->gfx.ip_dump_cp_queues[index + reg] =
+						RREG32(SOC15_REG_ENTRY_OFFSET(
+							gc_cp_reg_list_9[reg]));
+				}
+				index += reg_count;
+			}
+		}
+	}
+	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	amdgpu_gfx_off_ctrl(adev, true);
+
 }
 
 static const struct amd_ip_funcs gfx_v9_0_ip_funcs = {
-- 
2.34.1

