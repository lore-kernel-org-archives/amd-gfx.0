Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68FCC52D7C
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Aug 2024 17:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7788710E3B0;
	Tue, 13 Aug 2024 17:07:44 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F8F10E3B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Aug 2024 17:07:43 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 47DH7beM905220; Tue, 13 Aug 2024 22:37:37 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 47DH7bmh905213;
 Tue, 13 Aug 2024 22:37:37 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu: remove ME0 registers from  mi300 dump
Date: Tue, 13 Aug 2024 22:37:35 +0530
Message-Id: <20240813170735.905194-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
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

Remove ME0 registers from MI300 gfx_9_4_3 ipdump
MI300 does not have  gfx ME and hence those register
are just empty one and could be dropped.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 37 -------------------------
 1 file changed, 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 7b4ae197eb49..edebc4459b75 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -75,42 +75,11 @@ static const struct amdgpu_hwip_reg_entry gc_reg_list_9_4_3[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT),
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STATUS),
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_ERROR),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_BASE),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_RPTR),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_WPTR),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_BASE),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_RPTR),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_WPTR),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB1_BASE),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB1_RPTR),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB1_WPTR),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB2_BASE),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB2_WPTR),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB2_WPTR),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB1_CMD_BUFSZ),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB2_CMD_BUFSZ),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_CMD_BUFSZ),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_CMD_BUFSZ),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB1_BASE_LO),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB1_BASE_HI),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB1_BUFSZ),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB2_BASE_LO),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB2_BASE_HI),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB2_BUFSZ),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_LO),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_HI),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BUFSZ),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_LO),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_HI),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BUFSZ),
 	SOC15_REG_ENTRY_STR(GC, 0, regCPF_UTCL1_STATUS),
 	SOC15_REG_ENTRY_STR(GC, 0, regCPC_UTCL1_STATUS),
 	SOC15_REG_ENTRY_STR(GC, 0, regCPG_UTCL1_STATUS),
 	SOC15_REG_ENTRY_STR(GC, 0, regGDS_PROTECTION_FAULT),
 	SOC15_REG_ENTRY_STR(GC, 0, regGDS_VM_PROTECTION_FAULT),
-	SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS),
-	SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_CNTL),
-	SOC15_REG_ENTRY_STR(GC, 0, regPA_CL_CNTL_STATUS),
 	SOC15_REG_ENTRY_STR(GC, 0, regRLC_UTCL1_STATUS),
 	SOC15_REG_ENTRY_STR(GC, 0, regRMI_UTCL1_STATUS),
 	SOC15_REG_ENTRY_STR(GC, 0, regSQC_DCACHE_UTCL1_STATUS),
@@ -122,11 +91,8 @@ static const struct amdgpu_hwip_reg_entry gc_reg_list_9_4_3[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, regVM_L2_PROTECTION_FAULT_STATUS),
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_DEBUG),
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_CNTL),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_INSTR_PNTR),
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC1_INSTR_PNTR),
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC2_INSTR_PNTR),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_INSTR_PNTR),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_INSTR_PNTR),
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STATUS),
 	SOC15_REG_ENTRY_STR(GC, 0, regRLC_STAT),
 	SOC15_REG_ENTRY_STR(GC, 0, regRLC_SMU_COMMAND),
@@ -139,11 +105,8 @@ static const struct amdgpu_hwip_reg_entry gc_reg_list_9_4_3[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, regRLC_INT_STAT),
 	SOC15_REG_ENTRY_STR(GC, 0, regRLC_GPM_GENERAL_6),
 	/* cp header registers */
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_HEADER_DUMP),
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
 	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME2_HEADER_DUMP),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_HEADER_DUMP),
-	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
 	/* SE status registers */
 	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE0),
 	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE1),
-- 
2.34.1

