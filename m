Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304CBC25B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 07:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E437110F3E5;
	Wed, 22 May 2024 07:30:31 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23F6310E868
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 07:30:26 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 44M7UKjR009440; Wed, 22 May 2024 13:00:20 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 44M7UKgT009439;
 Wed, 22 May 2024 13:00:20 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 09/10] drm/amdgpu: add cp queue registers for gfx11 ipdump
Date: Wed, 22 May 2024 12:59:49 +0530
Message-Id: <20240522072950.9162-10-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522072950.9162-1-sunil.khatri@amd.com>
References: <20240522072950.9162-1-sunil.khatri@amd.com>
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

Add gfx11 support of CP queue registers for all queues
to be used by devcoredump.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 111 ++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 747e837b29b6..fbdb928bb790 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -166,6 +166,49 @@ static const struct amdgpu_hwip_reg_entry gc_reg_list_11_0[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE5)
 };
 
+static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_11[] = {
+	/* compute registers */
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_VMID),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PERSISTENT_STATE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PIPE_PRIORITY),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_QUEUE_PRIORITY),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_QUANTUM),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_BASE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_BASE_ADDR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_BASE_ADDR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_REQUEST),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_BASE_ADDR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_BASE_ADDR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_EVENTS),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_BASE_ADDR_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_BASE_ADDR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CNTL_STACK_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CNTL_STACK_SIZE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_WG_STATE_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_SIZE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_GDS_RESOURCE_STATE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_ERROR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_WPTR_MEM),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_DW_CNT),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_WG_STATE_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_STATUS)
+};
+
 static const struct soc15_reg_golden golden_settings_gc_11_0[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL, 0x20000000, 0x20000000)
 };
@@ -1407,6 +1450,7 @@ static void gfx_v11_0_alloc_ip_dump(struct amdgpu_device *adev)
 {
 	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_11_0);
 	uint32_t *ptr;
+	uint32_t inst;
 
 	ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
 	if (ptr == NULL) {
@@ -1415,6 +1459,19 @@ static void gfx_v11_0_alloc_ip_dump(struct amdgpu_device *adev)
 	} else {
 		adev->gfx.ip_dump_core = ptr;
 	}
+
+	/* Allocate memory for compute queue registers for all the instances */
+	reg_count = ARRAY_SIZE(gc_cp_reg_list_11);
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
 
 static int gfx_v11_0_sw_init(void *handle)
@@ -1633,6 +1690,7 @@ static int gfx_v11_0_sw_fini(void *handle)
 	gfx_v11_0_free_microcode(adev);
 
 	kfree(adev->gfx.ip_dump_core);
+	kfree(adev->gfx.ip_dump_cp_queues);
 
 	return 0;
 }
@@ -6251,7 +6309,7 @@ static void gfx_v11_0_emit_mem_sync(struct amdgpu_ring *ring)
 static void gfx_v11_ip_print(void *handle, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	uint32_t i;
+	uint32_t i, j, k, reg, index = 0;
 	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_11_0);
 
 	if (!adev->gfx.ip_dump_core)
@@ -6261,12 +6319,36 @@ static void gfx_v11_ip_print(void *handle, struct drm_printer *p)
 		drm_printf(p, "%-50s \t 0x%08x\n",
 			   gc_reg_list_11_0[i].reg_name,
 			   adev->gfx.ip_dump_core[i]);
+
+	/* print compute queue registers for all instances */
+	if (!adev->gfx.ip_dump_cp_queues)
+		return;
+
+	reg_count = ARRAY_SIZE(gc_cp_reg_list_11);
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
+						   gc_cp_reg_list_11[reg].reg_name,
+						   adev->gfx.ip_dump_cp_queues[index + reg]);
+				}
+				index += reg_count;
+			}
+		}
+	}
 }
 
 static void gfx_v11_ip_dump(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	uint32_t i;
+	uint32_t i, j, k, reg, index = 0;
 	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_11_0);
 
 	if (!adev->gfx.ip_dump_core)
@@ -6276,6 +6358,31 @@ static void gfx_v11_ip_dump(void *handle)
 	for (i = 0; i < reg_count; i++)
 		adev->gfx.ip_dump_core[i] = RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_11_0[i]));
 	amdgpu_gfx_off_ctrl(adev, true);
+
+	/* dump compute queue registers for all instances */
+	if (!adev->gfx.ip_dump_cp_queues)
+		return;
+
+	reg_count = ARRAY_SIZE(gc_cp_reg_list_11);
+	amdgpu_gfx_off_ctrl(adev, false);
+	mutex_lock(&adev->srbm_mutex);
+	for (i = 0; i < adev->gfx.mec.num_mec; i++) {
+		for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
+			for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
+				/* ME0 is for GFX so start from 1 for CP */
+				soc21_grbm_select(adev, 1+i, j, k, 0);
+				for (reg = 0; reg < reg_count; reg++) {
+					adev->gfx.ip_dump_cp_queues[index + reg] =
+						RREG32(SOC15_REG_ENTRY_OFFSET(
+							gc_cp_reg_list_11[reg]));
+				}
+				index += reg_count;
+			}
+		}
+	}
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	amdgpu_gfx_off_ctrl(adev, true);
 }
 
 static const struct amd_ip_funcs gfx_v11_0_ip_funcs = {
-- 
2.34.1

