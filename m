Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3946ECD129A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 12:58:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FB98113337;
	Wed, 10 Apr 2024 12:58:32 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C568A113328
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 12:58:28 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 43ACwOI8083179; Wed, 10 Apr 2024 18:28:24 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 43ACwOTv083178;
 Wed, 10 Apr 2024 18:28:24 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add support of gfx10 register dump
Date: Wed, 10 Apr 2024 18:28:05 +0530
Message-Id: <20240410125805.83029-3-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410125805.83029-1-sunil.khatri@amd.com>
References: <20240410125805.83029-1-sunil.khatri@amd.com>
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

Adding initial set of registers for ipdump during
devcoredump starting with gfx10 gc registers.

ip dump is triggered when gpu reset happens via
devcoredump and the memory is allocated by each
ip and is freed once the dump is complete by
devcoredump.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  16 ++
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  |  22 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 143 +++++++++++++++++-
 3 files changed, 180 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 65c17c59c152..e173ad86a241 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -139,6 +139,18 @@ enum amdgpu_ss {
 	AMDGPU_SS_DRV_UNLOAD
 };
 
+struct hwip_reg_entry {
+	u32	hwip;
+	u32	inst;
+	u32	seg;
+	u32	reg_offset;
+};
+
+struct reg_pair {
+	u32	offset;
+	u32	value;
+};
+
 struct amdgpu_watchdog_timer {
 	bool timeout_fatal_disable;
 	uint32_t period; /* maxCycles = (1 << period), the number of cycles before a timeout */
@@ -1152,6 +1164,10 @@ struct amdgpu_device {
 	bool                            debug_largebar;
 	bool                            debug_disable_soft_recovery;
 	bool                            debug_use_vram_fw_buf;
+
+	/* IP register dump */
+	struct reg_pair			*ip_dump;
+	uint32_t			num_regs;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 1129e5e5fb42..2079f67c9fac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -261,6 +261,18 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 	drm_printf(&p, "Faulty page starting at address: 0x%016llx\n", fault_info->addr);
 	drm_printf(&p, "Protection fault status register: 0x%x\n\n", fault_info->status);
 
+	/* Add IP dump for each ip */
+	if (coredump->adev->ip_dump != NULL) {
+		struct reg_pair *pair;
+
+		pair = (struct reg_pair *)coredump->adev->ip_dump;
+		drm_printf(&p, "IP register dump\n");
+		drm_printf(&p, "Offset \t Value\n");
+		for (int i = 0; i < coredump->adev->num_regs; i++)
+			drm_printf(&p, "0x%04x \t 0x%08x\n", pair[i].offset, pair[i].value);
+		drm_printf(&p, "\n");
+	}
+
 	/* Add ring buffer information */
 	drm_printf(&p, "Ring buffer information\n");
 	for (int i = 0; i < coredump->adev->num_rings; i++) {
@@ -299,6 +311,11 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 
 static void amdgpu_devcoredump_free(void *data)
 {
+	struct amdgpu_coredump_info *temp = data;
+
+	kfree(temp->adev->ip_dump);
+	temp->adev->ip_dump = NULL;
+	temp->adev->num_regs = 0;
 	kfree(data);
 }
 
@@ -337,6 +354,11 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
 
 	coredump->adev = adev;
 
+	/* Trigger ip dump here to capture the value of registers */
+	for (int i = 0; i < adev->num_ip_blocks; i++)
+		if (adev->ip_blocks[i].version->funcs->dump_ip_state)
+			adev->ip_blocks[i].version->funcs->dump_ip_state((void *)adev);
+
 	ktime_get_ts64(&coredump->reset_time);
 
 	dev_coredumpm(dev->dev, THIS_MODULE, coredump, 0, GFP_NOWAIT,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index a0bc4196ff8b..05c4b1d62132 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -47,6 +47,22 @@
 #include "gfx_v10_0.h"
 #include "nbio_v2_3.h"
 
+/*
+ * Manually adding some of the missing gfx10 registers from spec
+ */
+#define mmCP_DEBUG_BASE_IDX				0
+#define mmCP_DEBUG					0x1e1f
+#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR_BASE_IDX	1
+#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR		0x2840
+#define mmRLC_GPM_DEBUG_INST_A_BASE_IDX			1
+#define mmRLC_GPM_DEBUG_INST_A				0x4c22
+#define mmRLC_GPM_DEBUG_INST_B_BASE_IDX			1
+#define mmRLC_GPM_DEBUG_INST_B				0x4c23
+#define mmRLC_GPM_DEBUG_INST_ADDR_BASE_IDX		1
+#define mmRLC_GPM_DEBUG_INST_ADDR			0x4c1d
+#define mmRLC_LX6_CORE_PDEBUG_INST_BASE_IDX		1
+#define mmRLC_LX6_CORE_PDEBUG_INST			0x4deb
+
 /*
  * Navi10 has two graphic rings to share each graphic pipe.
  * 1. Primary ring
@@ -276,6 +292,99 @@ MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec2.bin");
 MODULE_FIRMWARE("amdgpu/gc_10_3_7_rlc.bin");
 
+static const struct hwip_reg_entry gc_reg_list_10_1[] = {
+	{ SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS) },
+	{ SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS2) },
+	{ SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS3) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_STALLED_STAT1) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_STALLED_STAT2) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STALLED_STAT1) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_CPF_STALLED_STAT1) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_BUSY_STAT) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_CPC_BUSY_STAT) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_CPF_BUSY_STAT) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_CPC_BUSY_STAT2) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_CPF_BUSY_STAT2) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_CPF_STATUS) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_GFX_ERROR) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_GFX_HPD_STATUS0) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_RB_BASE) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_RB_RPTR) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_RB_WPTR) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_RB0_BASE) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_RB0_RPTR) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_RB0_WPTR) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_RB1_BASE) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_RB1_RPTR) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_RB1_WPTR) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_RB2_BASE) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_RB2_WPTR) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_RB2_WPTR) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_CMD_BUFSZ) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_CMD_BUFSZ) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_IB1_CMD_BUFSZ) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_IB2_CMD_BUFSZ) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BASE_LO) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BASE_HI) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BUFSZ) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BASE_LO) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BASE_HI) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BUFSZ) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BASE_LO) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BASE_HI) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BUFSZ) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BASE_LO) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BASE_HI) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BUFSZ) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCPF_UTCL1_STATUS) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCPC_UTCL1_STATUS) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCPG_UTCL1_STATUS) },
+	{ SOC15_REG_ENTRY(GC, 0, mmGDS_PROTECTION_FAULT) },
+	{ SOC15_REG_ENTRY(GC, 0, mmGDS_VM_PROTECTION_FAULT) },
+	{ SOC15_REG_ENTRY(GC, 0, mmIA_UTCL1_STATUS) },
+	{ SOC15_REG_ENTRY(GC, 0, mmIA_UTCL1_STATUS_2) },
+	{ SOC15_REG_ENTRY(GC, 0, mmPA_CL_CNTL_STATUS) },
+	{ SOC15_REG_ENTRY(GC, 0, mmRLC_UTCL1_STATUS) },
+	{ SOC15_REG_ENTRY(GC, 0, mmRMI_UTCL1_STATUS) },
+	{ SOC15_REG_ENTRY(GC, 0, mmSQC_DCACHE_UTCL0_STATUS) },
+	{ SOC15_REG_ENTRY(GC, 0, mmSQC_ICACHE_UTCL0_STATUS) },
+	{ SOC15_REG_ENTRY(GC, 0, mmSQG_UTCL0_STATUS) },
+	{ SOC15_REG_ENTRY(GC, 0, mmTCP_UTCL0_STATUS) },
+	{ SOC15_REG_ENTRY(GC, 0, mmWD_UTCL1_STATUS) },
+	{ SOC15_REG_ENTRY(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL) },
+	{ SOC15_REG_ENTRY(GC, 0, mmGCVM_L2_PROTECTION_FAULT_STATUS) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_DEBUG) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_MEC_CNTL) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_MES_CNTL) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_CE_INSTR_PNTR) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_MEC1_INSTR_PNTR) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_MEC2_INSTR_PNTR) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_MES_INSTR_PNTR) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_ME_INSTR_PNTR) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_PFP_INSTR_PNTR) },
+	{ SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STATUS) },
+	{ SOC15_REG_ENTRY(GC, 0, mmRLC_STAT) },
+	{ SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_COMMAND) },
+	{ SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_MESSAGE) },
+	{ SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_1) },
+	{ SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_2) },
+	{ SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_3) },
+	{ SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_4) },
+	{ SOC15_REG_ENTRY(GC, 0, mmSMU_RLC_RESPONSE) },
+	{ SOC15_REG_ENTRY(GC, 0, mmRLC_SAFE_MODE) },
+	{ SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_SAFE_MODE) },
+	{ SOC15_REG_ENTRY(GC, 0, mmRLC_RLCS_GPM_STAT_2) },
+	{ SOC15_REG_ENTRY(GC, 0, mmRLC_SPP_STATUS) },
+	{ SOC15_REG_ENTRY(GC, 0, mmRLC_RLCS_BOOTLOAD_STATUS) },
+	{ SOC15_REG_ENTRY(GC, 0, mmRLC_INT_STAT) },
+	{ SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_GENERAL_6) },
+	{ SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_A) },
+	{ SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_B) },
+	{ SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_ADDR) },
+	{ SOC15_REG_ENTRY(GC, 0, mmRLC_LX6_CORE_PDEBUG_INST) }
+};
+
 static const struct soc15_reg_golden golden_settings_gc_10_1[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x00400014),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_CPF_CLK_CTRL, 0xfcff8fff, 0xf8000100),
@@ -9154,6 +9263,38 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }
 
+static void gfx_v10_ip_dump(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
+	struct reg_pair *ptr, *gfx10_pair;
+	uint32_t new_count;
+
+	/*
+	 * Allocate memory based on the no of registers for each block.
+	 * Since adev->ip_dump is common pointer and we add more
+	 * memory to it as we move through different IP's of the ASIC.
+	 *
+	 * This memory needs to be freed after gpu reset once the ip
+	 * dump is done in the devcoredump.
+	 */
+	new_count = adev->num_regs + reg_count;
+	ptr = krealloc_array(adev->ip_dump, new_count, sizeof(struct reg_pair), GFP_KERNEL);
+	if (ptr) {
+		adev->ip_dump = ptr;
+		gfx10_pair = &ptr[adev->num_regs];
+		adev->num_regs = new_count;
+	} else {
+		DRM_ERROR("Failed to allocate memory for IP Dump\n");
+		return;
+	}
+
+	for (uint32_t i = 0; i < reg_count; i++) {
+		gfx10_pair[i].offset = gc_reg_list_10_1[i].reg_offset;
+		gfx10_pair[i].value = RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_10_1[i]));
+	}
+}
+
 static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
 	.name = "gfx_v10_0",
 	.early_init = gfx_v10_0_early_init,
@@ -9170,7 +9311,7 @@ static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
 	.set_clockgating_state = gfx_v10_0_set_clockgating_state,
 	.set_powergating_state = gfx_v10_0_set_powergating_state,
 	.get_clockgating_state = gfx_v10_0_get_clockgating_state,
-	.dump_ip_state = NULL,
+	.dump_ip_state = gfx_v10_ip_dump,
 };
 
 static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
-- 
2.34.1

