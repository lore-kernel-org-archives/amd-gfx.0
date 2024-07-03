Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79EEC31D97
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 07:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C0F510E13D;
	Wed,  3 Jul 2024 07:39:12 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F3F010E13D
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 07:39:10 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 4637d5CY914399; Wed, 3 Jul 2024 13:09:05 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 4637d4bm914398;
 Wed, 3 Jul 2024 13:09:04 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 1/4] drm/amdgpu: add gfx12 register support in ipdump
Date: Wed,  3 Jul 2024 13:08:58 +0530
Message-Id: <20240703073901.914348-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703073901.914348-1-sunil.khatri@amd.com>
References: <20240703073901.914348-1-sunil.khatri@amd.com>
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

Add general registers of gfx12 in ipdump for
devcoredump support.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 101 +++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index ccb26f78252a..c06d0a2a03e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -63,6 +63,73 @@ MODULE_FIRMWARE("amdgpu/gc_12_0_1_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_0_1_rlc.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_0_1_toc.bin");
 
+static const struct amdgpu_hwip_reg_entry gc_reg_list_12_0[] = {
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS2),
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS3),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT1),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT2),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT3),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STALLED_STAT1),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STALLED_STAT1),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_BUSY_STAT),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT2),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT2),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_ERROR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HPD_STATUS0),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_BASE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_BASE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_CMD_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_CMD_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, regCPF_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regCPC_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regCPG_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS_2),
+	SOC15_REG_ENTRY_STR(GC, 0, regPA_CL_CNTL_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regRMI_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regSQC_CACHES),
+	SOC15_REG_ENTRY_STR(GC, 0, regSQG_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regWD_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_STATUS_LO32),
+	SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_STATUS_HI32),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_DEBUG),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_INSTR_PNTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_INSTR_PNTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_INSTR_PNTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR0),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR1),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_RS64_INSTR_PNTR),
+
+	/* cp header registers */
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	/* SE status registers */
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE0),
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE1),
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE2),
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE3)
+};
+
 #define DEFAULT_SH_MEM_CONFIG \
 	((SH_MEM_ADDRESS_MODE_64 << SH_MEM_CONFIG__ADDRESS_MODE__SHIFT) | \
 	 (SH_MEM_ALIGNMENT_MODE_UNALIGNED << SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
@@ -1129,6 +1196,20 @@ static int gfx_v12_0_rlc_backdoor_autoload_enable(struct amdgpu_device *adev)
 	return 0;
 }
 
+static void gfx_v12_0_alloc_ip_dump(struct amdgpu_device *adev)
+{
+	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_12_0);
+	uint32_t *ptr;
+
+	ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
+	if (ptr == NULL) {
+		DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
+		adev->gfx.ip_dump_core = NULL;
+	} else {
+		adev->gfx.ip_dump_core = ptr;
+	}
+}
+
 static int gfx_v12_0_sw_init(void *handle)
 {
 	int i, j, k, r, ring_id = 0;
@@ -1261,6 +1342,8 @@ static int gfx_v12_0_sw_init(void *handle)
 	if (r)
 		return r;
 
+	gfx_v12_0_alloc_ip_dump(adev);
+
 	return 0;
 }
 
@@ -1320,6 +1403,8 @@ static int gfx_v12_0_sw_fini(void *handle)
 
 	gfx_v12_0_free_microcode(adev);
 
+	kfree(adev->gfx.ip_dump_core);
+
 	return 0;
 }
 
@@ -4673,6 +4758,21 @@ static void gfx_v12_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }
 
+static void gfx_v12_ip_dump(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	uint32_t i;
+	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_12_0);
+
+	if (!adev->gfx.ip_dump_core)
+		return;
+
+	amdgpu_gfx_off_ctrl(adev, false);
+	for (i = 0; i < reg_count; i++)
+		adev->gfx.ip_dump_core[i] = RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_12_0[i]));
+	amdgpu_gfx_off_ctrl(adev, true);
+}
+
 static const struct amd_ip_funcs gfx_v12_0_ip_funcs = {
 	.name = "gfx_v12_0",
 	.early_init = gfx_v12_0_early_init,
@@ -4688,6 +4788,7 @@ static const struct amd_ip_funcs gfx_v12_0_ip_funcs = {
 	.set_clockgating_state = gfx_v12_0_set_clockgating_state,
 	.set_powergating_state = gfx_v12_0_set_powergating_state,
 	.get_clockgating_state = gfx_v12_0_get_clockgating_state,
+	.dump_ip_state = gfx_v12_ip_dump,
 };
 
 static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
-- 
2.34.1

