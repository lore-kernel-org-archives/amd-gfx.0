Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A93C27C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 09:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BC0A1135E9;
	Wed, 29 May 2024 09:50:45 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1268113596
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 09:50:42 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 44T9oag41669932; Wed, 29 May 2024 15:20:36 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 44T9oafW1669931;
 Wed, 29 May 2024 15:20:36 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 1/3] drm/amdgpu: add gfx9 register support in ipdump
Date: Wed, 29 May 2024 15:20:30 +0530
Message-Id: <20240529095032.1669886-2-sunil.khatri@amd.com>
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

Add general registers of gfx9 in ipdump for
devcoredump support.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 124 +++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 3c8c5abf35ab..528a20393313 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -149,6 +149,94 @@ MODULE_FIRMWARE("amdgpu/aldebaran_sjt_mec2.bin");
 #define mmGOLDEN_TSC_COUNT_LOWER_Renoir                0x0026
 #define mmGOLDEN_TSC_COUNT_LOWER_Renoir_BASE_IDX       1
 
+static const struct amdgpu_hwip_reg_entry gc_reg_list_9[] = {
+	SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS2),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_STALLED_STAT1),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_STALLED_STAT2),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_STALLED_STAT1),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_STALLED_STAT1),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_BUSY_STAT),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_BUSY_STAT),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_BUSY_STAT),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_ERROR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_BASE),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB0_BASE),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB0_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB0_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB1_BASE),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB1_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB1_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB2_BASE),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB2_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB2_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_CMD_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_CMD_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_CMD_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_CMD_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_BASE_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_BASE_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_BASE_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_BASE_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCPF_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCPC_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCPG_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, mmGDS_PROTECTION_FAULT),
+	SOC15_REG_ENTRY_STR(GC, 0, mmGDS_VM_PROTECTION_FAULT),
+	SOC15_REG_ENTRY_STR(GC, 0, mmIA_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, mmIA_UTCL1_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, mmPA_CL_CNTL_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, mmRMI_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSQC_DCACHE_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSQC_ICACHE_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSQ_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, mmTCP_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, mmWD_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, mmVM_L2_PROTECTION_FAULT_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_DEBUG),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_INSTR_PNTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC1_INSTR_PNTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC2_INSTR_PNTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_INSTR_PNTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_INSTR_PNTR),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_STAT),
+	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_COMMAND),
+	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_MESSAGE),
+	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_1),
+	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_2),
+	SOC15_REG_ENTRY_STR(GC, 0, mmSMU_RLC_RESPONSE),
+	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SAFE_MODE),
+	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_SAFE_MODE),
+	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_INT_STAT),
+	SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_GENERAL_6),
+	/* cp header registers */
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME2_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+	/* SE status registers */
+	SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE0),
+	SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE1),
+	SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE2),
+	SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3)
+};
+
 enum ta_ras_gfx_subblock {
 	/*CPC*/
 	TA_RAS_BLOCK__GFX_CPC_INDEX_START = 0,
@@ -1994,6 +2082,20 @@ static int gfx_v9_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 				hw_prio, NULL);
 }
 
+static void gfx_v9_0_alloc_ip_dump(struct amdgpu_device *adev)
+{
+	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_9);
+	uint32_t *ptr;
+
+	ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
+	if (ptr == NULL) {
+		DRM_ERROR("Failed to allocate memory for IP Dump\n");
+		adev->gfx.ip_dump_core = NULL;
+	} else {
+		adev->gfx.ip_dump_core = ptr;
+	}
+}
+
 static int gfx_v9_0_sw_init(void *handle)
 {
 	int i, j, k, r, ring_id;
@@ -2171,6 +2273,8 @@ static int gfx_v9_0_sw_init(void *handle)
 		return -EINVAL;
 	}
 
+	gfx_v9_0_alloc_ip_dump(adev);
+
 	return 0;
 }
 
@@ -2206,6 +2310,8 @@ static int gfx_v9_0_sw_fini(void *handle)
 	}
 	gfx_v9_0_free_microcode(adev);
 
+	kfree(adev->gfx.ip_dump_core);
+
 	return 0;
 }
 
@@ -6840,6 +6946,22 @@ static void gfx_v9_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
 	}
 }
 
+static void gfx_v9_ip_dump(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	uint32_t i;
+	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_9);
+
+	if (!adev->gfx.ip_dump_core)
+		return;
+
+	amdgpu_gfx_off_ctrl(adev, false);
+	for (i = 0; i < reg_count; i++)
+		adev->gfx.ip_dump_core[i] = RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_9[i]));
+	amdgpu_gfx_off_ctrl(adev, true);
+
+}
+
 static const struct amd_ip_funcs gfx_v9_0_ip_funcs = {
 	.name = "gfx_v9_0",
 	.early_init = gfx_v9_0_early_init,
@@ -6856,7 +6978,7 @@ static const struct amd_ip_funcs gfx_v9_0_ip_funcs = {
 	.set_clockgating_state = gfx_v9_0_set_clockgating_state,
 	.set_powergating_state = gfx_v9_0_set_powergating_state,
 	.get_clockgating_state = gfx_v9_0_get_clockgating_state,
-	.dump_ip_state = NULL,
+	.dump_ip_state = gfx_v9_ip_dump,
 	.print_ip_state = NULL,
 };
 
-- 
2.34.1

