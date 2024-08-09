Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559DBC52D7C
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Aug 2024 12:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4639410E8E0;
	Fri,  9 Aug 2024 12:12:10 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C9B310E8DC
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Aug 2024 12:12:08 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 479CC2Pa4051501; Fri, 9 Aug 2024 17:42:02 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 479CC2pP4051500;
 Fri, 9 Aug 2024 17:42:02 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 1/4] drm/amdgpu: add gfx9_4_3 register support in ipdump
Date: Fri,  9 Aug 2024 17:41:54 +0530
Message-Id: <20240809121157.4051442-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809121157.4051442-1-sunil.khatri@amd.com>
References: <20240809121157.4051442-1-sunil.khatri@amd.com>
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

Add general registers of gfx9_4_3 in ipdump for
devcoredump support.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 133 +++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 8455fda750a6..3bd84acba643 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -63,6 +63,94 @@ MODULE_FIRMWARE("amdgpu/gc_9_4_4_rlc.bin");
 #define NORMALIZE_XCC_REG_OFFSET(offset) \
 	(offset & 0xFFFF)
 
+static const struct amdgpu_hwip_reg_entry gc_reg_list_9_4_3[] = {
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS2),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT1),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT2),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STALLED_STAT1),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STALLED_STAT1),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_BUSY_STAT),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_ERROR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_BASE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_BASE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB1_BASE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB1_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB1_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB2_BASE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB2_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB2_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB1_CMD_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB2_CMD_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_CMD_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_CMD_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB1_BASE_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB1_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB1_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB2_BASE_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB2_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB2_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, regCPF_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regCPC_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regCPG_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regGDS_PROTECTION_FAULT),
+	SOC15_REG_ENTRY_STR(GC, 0, regGDS_VM_PROTECTION_FAULT),
+	SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, regPA_CL_CNTL_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regRLC_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regRMI_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regSQC_DCACHE_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regSQC_ICACHE_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regSQ_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regTCP_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regWD_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regVM_L2_PROTECTION_FAULT_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, regVM_L2_PROTECTION_FAULT_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_DEBUG),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_INSTR_PNTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC1_INSTR_PNTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC2_INSTR_PNTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_INSTR_PNTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_INSTR_PNTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regRLC_STAT),
+	SOC15_REG_ENTRY_STR(GC, 0, regRLC_SMU_COMMAND),
+	SOC15_REG_ENTRY_STR(GC, 0, regRLC_SMU_MESSAGE),
+	SOC15_REG_ENTRY_STR(GC, 0, regRLC_SMU_ARGUMENT_1),
+	SOC15_REG_ENTRY_STR(GC, 0, regRLC_SMU_ARGUMENT_2),
+	SOC15_REG_ENTRY_STR(GC, 0, regSMU_RLC_RESPONSE),
+	SOC15_REG_ENTRY_STR(GC, 0, regRLC_SAFE_MODE),
+	SOC15_REG_ENTRY_STR(GC, 0, regRLC_SMU_SAFE_MODE),
+	SOC15_REG_ENTRY_STR(GC, 0, regRLC_INT_STAT),
+	SOC15_REG_ENTRY_STR(GC, 0, regRLC_GPM_GENERAL_6),
+	/* cp header registers */
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME2_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
+	/* SE status registers */
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE0),
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE1),
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE2),
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE3)
+};
+
 struct amdgpu_gfx_ras gfx_v9_4_3_ras;
 
 static void gfx_v9_4_3_set_ring_funcs(struct amdgpu_device *adev);
@@ -885,6 +973,22 @@ static int gfx_v9_4_3_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 				hw_prio, NULL);
 }
 
+static void gfx_v9_4_3_alloc_ip_dump(struct amdgpu_device *adev)
+{
+	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_9_4_3);
+	uint32_t *ptr, num_xcc;
+
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+
+	ptr = kcalloc(reg_count * num_xcc, sizeof(uint32_t), GFP_KERNEL);
+	if (!ptr) {
+		DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
+		adev->gfx.ip_dump_core = NULL;
+	} else {
+		adev->gfx.ip_dump_core = ptr;
+	}
+}
+
 static int gfx_v9_4_3_sw_init(void *handle)
 {
 	int i, j, k, r, ring_id, xcc_id, num_xcc;
@@ -986,6 +1090,8 @@ static int gfx_v9_4_3_sw_init(void *handle)
 	if (!amdgpu_sriov_vf(adev))
 		r = amdgpu_gfx_sysfs_init(adev);
 
+	gfx_v9_4_3_alloc_ip_dump(adev);
+
 	return r;
 }
 
@@ -1010,6 +1116,8 @@ static int gfx_v9_4_3_sw_fini(void *handle)
 	if (!amdgpu_sriov_vf(adev))
 		amdgpu_gfx_sysfs_fini(adev);
 
+	kfree(adev->gfx.ip_dump_core);
+
 	return 0;
 }
 
@@ -4196,6 +4304,29 @@ static void gfx_v9_4_3_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_no
 		amdgpu_ring_write(ring, ring->funcs->nop);
 }
 
+static void gfx_v9_4_3_ip_dump(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	uint32_t i;
+	uint32_t xcc_id, xcc_offset, num_xcc;
+	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_9_4_3);
+
+	if (!adev->gfx.ip_dump_core)
+		return;
+
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+
+	amdgpu_gfx_off_ctrl(adev, false);
+	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
+		xcc_offset = xcc_id * reg_count;
+		for (i = 0; i < reg_count; i++)
+			adev->gfx.ip_dump_core[xcc_offset + i] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(gc_reg_list_9_4_3[i],
+								   GET_INST(GC, xcc_id)));
+	}
+	amdgpu_gfx_off_ctrl(adev, true);
+}
+
 static const struct amd_ip_funcs gfx_v9_4_3_ip_funcs = {
 	.name = "gfx_v9_4_3",
 	.early_init = gfx_v9_4_3_early_init,
@@ -4212,7 +4343,7 @@ static const struct amd_ip_funcs gfx_v9_4_3_ip_funcs = {
 	.set_clockgating_state = gfx_v9_4_3_set_clockgating_state,
 	.set_powergating_state = gfx_v9_4_3_set_powergating_state,
 	.get_clockgating_state = gfx_v9_4_3_get_clockgating_state,
-	.dump_ip_state = NULL,
+	.dump_ip_state = gfx_v9_4_3_ip_dump,
 	.print_ip_state = NULL,
 };
 
-- 
2.34.1

