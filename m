Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F04C04FF8
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 16:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DB6710EE6E;
	Fri, 12 Apr 2024 16:54:27 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AA6410EE91
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 16:54:23 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 43CGsJeP132941; Fri, 12 Apr 2024 22:24:19 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 43CGsJ1t132940;
 Fri, 12 Apr 2024 22:24:19 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v3 2/3] drm/amdgpu: Add support of gfx10 register dump
Date: Fri, 12 Apr 2024 22:24:11 +0530
Message-Id: <20240412165412.132876-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412165412.132876-1-sunil.khatri@amd.com>
References: <20240412165412.132876-1-sunil.khatri@amd.com>
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

Adding gfx10 gc registers to be used for register
dump via devcoredump during a gpu reset.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  16 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 127 +++++++++++++++++-
 .../include/asic_reg/gc/gc_10_1_0_offset.h    |  12 ++
 3 files changed, 154 insertions(+), 1 deletion(-)

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
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index a0bc4196ff8b..66e2915a8b4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -276,6 +276,99 @@ MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec.bin");
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
@@ -9154,6 +9247,38 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
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
@@ -9170,7 +9295,7 @@ static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
 	.set_clockgating_state = gfx_v10_0_set_clockgating_state,
 	.set_powergating_state = gfx_v10_0_set_powergating_state,
 	.get_clockgating_state = gfx_v10_0_get_clockgating_state,
-	.dump_ip_state = NULL,
+	.dump_ip_state = gfx_v10_ip_dump,
 };
 
 static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
index 4908044f7409..4c8e7fdb6976 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
@@ -4830,6 +4830,8 @@
 #define mmCP_ECC_FIRSTOCCURRENCE_RING2_BASE_IDX                                                        0
 #define mmGB_EDC_MODE                                                                                  0x1e1e
 #define mmGB_EDC_MODE_BASE_IDX                                                                         0
+#define mmCP_DEBUG                                                                                     0x1e1f
+#define mmCP_DEBUG_BASE_IDX                                                                            0
 #define mmCP_FETCHER_SOURCE                                                                            0x1e22
 #define mmCP_FETCHER_SOURCE_BASE_IDX                                                                   0
 #define mmCP_PQ_WPTR_POLL_CNTL                                                                         0x1e23
@@ -7778,6 +7780,8 @@
 #define mmCP_MES_DOORBELL_CONTROL5_BASE_IDX                                                            1
 #define mmCP_MES_DOORBELL_CONTROL6                                                                     0x2841
 #define mmCP_MES_DOORBELL_CONTROL6_BASE_IDX                                                            1
+#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR                                                            0x2842
+#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR_BASE_IDX                                                   1
 #define mmCP_MES_GP0_LO                                                                                0x2843
 #define mmCP_MES_GP0_LO_BASE_IDX                                                                       1
 #define mmCP_MES_GP0_HI                                                                                0x2844
@@ -9332,10 +9336,16 @@
 #define mmRLC_LB_CNTR_INIT_1_BASE_IDX                                                                  1
 #define mmRLC_LB_CNTR_1                                                                                0x4c1c
 #define mmRLC_LB_CNTR_1_BASE_IDX                                                                       1
+#define mmRLC_GPM_DEBUG_INST_ADDR                                                                      0x4c1d
+#define mmRLC_GPM_DEBUG_INST_ADDR_BASE_IDX                                                             1
 #define mmRLC_JUMP_TABLE_RESTORE                                                                       0x4c1e
 #define mmRLC_JUMP_TABLE_RESTORE_BASE_IDX                                                              1
 #define mmRLC_PG_DELAY_2                                                                               0x4c1f
 #define mmRLC_PG_DELAY_2_BASE_IDX                                                                      1
+#define mmRLC_GPM_DEBUG_INST_A                                                                         0x4c22
+#define mmRLC_GPM_DEBUG_INST_A_BASE_IDX                                                                1
+#define mmRLC_GPM_DEBUG_INST_B                                                                         0x4c23
+#define mmRLC_GPM_DEBUG_INST_B_BASE_IDX                                                                1
 #define mmRLC_GPU_CLOCK_COUNT_LSB                                                                      0x4c24
 #define mmRLC_GPU_CLOCK_COUNT_LSB_BASE_IDX                                                             1
 #define mmRLC_GPU_CLOCK_COUNT_MSB                                                                      0x4c25
@@ -9720,6 +9730,8 @@
 #define mmRLC_SPM_THREAD_TRACE_CTRL_BASE_IDX                                                           1
 #define mmRLC_LB_CNTR_2                                                                                0x4de7
 #define mmRLC_LB_CNTR_2_BASE_IDX                                                                       1
+#define mmRLC_LX6_CORE_PDEBUG_INST                                                                     0x4deb
+#define mmRLC_LX6_CORE_PDEBUG_INST_BASE_IDX                                                            1
 #define mmRLC_CPAXI_DOORBELL_MON_CTRL                                                                  0x4df1
 #define mmRLC_CPAXI_DOORBELL_MON_CTRL_BASE_IDX                                                         1
 #define mmRLC_CPAXI_DOORBELL_MON_STAT                                                                  0x4df2
-- 
2.34.1

