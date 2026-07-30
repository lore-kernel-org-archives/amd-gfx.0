Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65498C5516E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 20:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B7BF10F065;
	Thu, 30 Jul 2026 20:27:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J8OBGYRP";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012006.outbound.protection.outlook.com
 [40.107.200.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A7E110F065
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 20:27:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8fi2HlMtP+ojR6WHvQQXYuUlehVcigau5vS7cJQpDLME9Iy1FuCqovyiKIZlWUOfPOQ8Tw0HJ4Y3FtoROBo0c9yp/5kBQ5nQksE7IscXU12D1g/S8QrZM/19hMBM9fgxFnTgfUHLyg/1oOzZcWNh5DiX4OHjZHW8lmP+6GL+MnaShszQqQkCnqFPJyteLxBQ2NTpAHBbU7jD10Cj224dPUs6TyCsGFLiGdc/lCHOjKa1d0hkoAlGK6nphgm4VZzzN1Yq6QN9/QNIXaamXBdzNZ0AqRD9pcsYch3Ni1KBOc8lBcDKcZDrz0CCYcVViFevyAZI8C9LxMNysBiIdt1FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEE7/mjRJlk0deCyJamymThS1b29Yn6iJ+2WAQS5d50=;
 b=mryCkp15NzPudCOjXApjooHHpTDwpXbXXT9S6phpLXqL5+tM75+5r6iLDxgnZO4vP1AWXaooLMEGHNn32Eq/S+T01uN/AnyQqoRLXAUkNF65WeSq/dniPeGM50f+dGi3ZOoZYztVbIiacB+5Csi3nUaFmU2/S88IvmCsZbqcv8T3LOW9bs/C0XIb9dNGzKIDolgPhI9uIQ8sarIddoTIGJAVfsG4jdJMo31vaYEO/1sMV3cBlA1CVUmPGHspdp88vYom8gd9sVD7+MePrCzsjP/usUuNf6flbQw2U3wLxGRGkKdZtFx6dCQh5kB2KeN23HEzBMKLKEkSm40TeDLErg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEE7/mjRJlk0deCyJamymThS1b29Yn6iJ+2WAQS5d50=;
 b=J8OBGYRPOwQ6xOWj7OSVQwmJF7Eg0TaL3rT3HPWEmtd5ekXrD6auI9LBaAc2za93ewr9G4Rve+w5/DFUQuw7Q9t+SxGVZnhPzyCHbCfHE2uCTNGR20nc4kC5ludNNdcJ9bO0auZA0ORg0L4McKCZ7i1krXWfN6sZqUU++YK1r74=
Received: from SJ0PR03CA0095.namprd03.prod.outlook.com (2603:10b6:a03:333::10)
 by MN0PR12MB5906.namprd12.prod.outlook.com (2603:10b6:208:37a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 20:27:20 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::52) by SJ0PR03CA0095.outlook.office365.com
 (2603:10b6:a03:333::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Thu,
 30 Jul 2026 20:27:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 20:27:19 +0000
Received: from bokun-linux (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 15:27:18 -0500
From: Bokun Zhang <Bokun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Bokun Zhang <Bokun.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add VCN v5.0.2 SRIOV code path
Date: Thu, 30 Jul 2026 20:27:07 +0000
Message-ID: <20260730202707.265849-1-Bokun.Zhang@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|MN0PR12MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: 42fcee46-da1a-423d-55f3-08deee78f413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: vcINxNwVwKq7ZJGO0fuNM/4gJRAeKFySfcLw17RQJTDL44MKn6cGRnO1tGAaGqF8FZ64MBd2nejirRWutiPO14c+mtJGren0rHy8ZPI4YW1sjZR6xVPy7C16wEYHGT2hcTRSJSZ6L3yCpEtYU5yPnikuYQ5sXsK5QkZpkCgyDq7ohsWRMb8uqKjFQtaV2Xw7G+XL7+0cdh4XEJfPhu1Hur62MzjXE/de6RmO1A3s23Jn77BYwxvh6M/M7HAzumqQV3fivLOkaOi9WTVItLYvQCmFc+7AUeb0LR9uMBTE4JLQwfoCuT72KkO8jYtBeyFBkvcfwa0dtYc1gBwnstjal2NNNEvnfnqIHty8+AwvL7wUD2FJTSQbuQYcUZCMtmia0XVOOWlYCO+loTY+dLzMO1W2w/S5S5+RfIKuDTg7RMyMWumJ1/MD61d5HIz98C7h7FnLqfA+CdblvtYaDf5WWKW66vagKc9I2DIQ3ZfZuDakwMgtnB7tfKnVxjqc9FKTQS1mrhXVuxO+ZN4Ar7TxOI68DYoxgVGqwfBDrs4wan2Akrn9SOxZ5GTGXctuw7O3ld4orH5uoUORYaBaMRtMiMXGT8KDs+Ryi7XpEzCO4HTX+TvepwWJmkwnxWOhbJzrozpsIIRL6y+DEI0tPJJ/9wrEdpVEZNLGisa7GC+MU+CA/nPQcNa9WDlvLTJ2+YG8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1lb+Tuumwql4u3cwkI2XbUAlc8V1NQkzOHiAQ0lISU2rI2xms+2OgRJ+o+qNOfRig1bYMyHd70dRLGi1MiAC6N1QSQfCkkCswF3SxLPlzon+jkkGjKjMFVkqVkn5dfqja7Jdhzc7V1B+ylCYbTQd6gbqSliQUL9pfTAMjC+Oc55YkE4dsLlkEnoyEm+IZSQMU3BmOWzbnBZMR/OxG62vuNBQXnTEsQKpZ6yuaf84Y2su9wh6Fv8lcmbFbarz17JGm/3v9i/S3zuAXmBdfb3mqWqApX61Aygk24CK7p4XqTxfl0BC/FtVLVIa/1Jq3JgsD7AAF/dTPWhhrweEEb+R86MUqhkfSycKrrLXeUk/oLMVhKInhMblYDmQzEB6GYPQ8g/KTkQu8FOC3EI98XABxz0PaRuTRDArJXAZud5VUob2UREQanrWLscW7S4U07w5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 20:27:19.0318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42fcee46-da1a-423d-55f3-08deee78f413
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5906
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

- Add VCN v5.0.2 SRIOV code path
- Add VCN MMSCH init table transfer
- Skip unsupported actions such as power gating
  and per queue reset for SRIOV VF.

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c | 282 +++++++++++++++++++++---
 1 file changed, 257 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
index b006ee091de3..a3288d5509dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
@@ -37,10 +37,12 @@
 #include "vcn_v5_0_0.h"
 #include "vcn_v5_0_1.h"
 #include "vcn_v5_0_2.h"
+#include "mmsch_v5_0.h"
 #include "soc_v1_0.h"
 
 #include <drm/drm_drv.h>
 
+static int vcn_v5_0_2_start_sriov(struct amdgpu_device *adev);
 static void vcn_v5_0_2_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v5_0_2_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v5_0_2_set_pg_state(struct amdgpu_vcn_inst *vinst,
@@ -133,9 +135,13 @@ static int vcn_v5_0_2_sw_init(struct amdgpu_ip_block *ip_block)
 
 		ring = &adev->vcn.inst[i].ring_enc[0];
 		ring->use_doorbell = true;
-
-		ring->doorbell_index =
-			(adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 11 * vcn_inst;
+		if (amdgpu_sriov_vf(adev)) {
+			ring->doorbell_index =
+				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 32 * vcn_inst;
+		} else {
+			ring->doorbell_index =
+				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 11 * vcn_inst;
+		}
 
 		ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[i].aid_id);
 		sprintf(ring->name, "vcn_unified_%d", i);
@@ -148,9 +154,16 @@ static int vcn_v5_0_2_sw_init(struct amdgpu_ip_block *ip_block)
 		vcn_v5_0_2_fw_shared_init(adev, i);
 	}
 
+	if (amdgpu_sriov_vf(adev)) {
+		r = amdgpu_virt_alloc_mm_table(adev);
+		if (r)
+			return r;
+	}
+
 	/* TODO: Add queue reset mask when FW fully supports it */
 	adev->vcn.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
+	/* SRIOV VF does not support per queue reset, please wrap with if(!amdgpu_sriov_vf()) check */
 
 	return amdgpu_vcn_sysfs_reset_mask_init(adev);
 }
@@ -179,6 +192,9 @@ static int vcn_v5_0_2_sw_fini(struct amdgpu_ip_block *ip_block)
 		drm_dev_exit(idx);
 	}
 
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_virt_free_mm_table(adev);
+
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 		r = amdgpu_vcn_suspend(adev, i);
 		if (r)
@@ -242,31 +258,45 @@ static int vcn_v5_0_2_hw_init(struct amdgpu_ip_block *ip_block)
 	int i, r, vcn_inst;
 	uint32_t tmp;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		vcn_inst = GET_INST(VCN, i);
-		ring = &adev->vcn.inst[i].ring_enc[0];
-
-		/* Remove Video Tiles antihang mechanism */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_POWER_STATUS);
-		tmp &= (~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
-		WREG32_SOC15(VCN, vcn_inst, regUVD_POWER_STATUS, tmp);
-
-		if (ring->use_doorbell)
-			adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
-				((adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-				 11 * vcn_inst),
-				vcn_inst);
-
-		/* Re-init fw_shared, if required */
-		vcn_v5_0_2_fw_shared_init(adev, i);
-
-		r = amdgpu_ring_test_helper(ring);
+	if (amdgpu_sriov_vf(adev)) {
+		r = vcn_v5_0_2_start_sriov(adev);
 		if (r)
 			return r;
 
-		tmp = RREG32_SOC15(VCN, vcn_inst, regMCGa0_CTLT0);
-		tmp &= 0xfffffffe;
-		WREG32_SOC15(VCN, vcn_inst, regMCGa0_CTLT0, tmp);
+		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+			ring = &adev->vcn.inst[i].ring_enc[0];
+			ring->wptr = 0;
+			ring->wptr_old = 0;
+			vcn_v5_0_2_unified_ring_set_wptr(ring);
+			ring->sched.ready = true;
+		}
+	} else {
+		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+			vcn_inst = GET_INST(VCN, i);
+			ring = &adev->vcn.inst[i].ring_enc[0];
+
+			/* Remove Video Tiles antihang mechanism */
+			tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_POWER_STATUS);
+			tmp &= (~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
+			WREG32_SOC15(VCN, vcn_inst, regUVD_POWER_STATUS, tmp);
+
+			if (ring->use_doorbell)
+				adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+					((adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+					 11 * vcn_inst),
+					vcn_inst);
+
+			/* Re-init fw_shared, if required */
+			vcn_v5_0_2_fw_shared_init(adev, i);
+
+			r = amdgpu_ring_test_helper(ring);
+			if (r)
+				return r;
+
+			tmp = RREG32_SOC15(VCN, vcn_inst, regMCGa0_CTLT0);
+			tmp &= 0xfffffffe;
+			WREG32_SOC15(VCN, vcn_inst, regMCGa0_CTLT0, tmp);
+		}
 	}
 
 	/* Workaround: IFWI missing RSMU_IH_MCM_ADDR_UVD programming for MID1 */
@@ -716,6 +746,198 @@ static int vcn_v5_0_2_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	return 0;
 }
 
+
+/**
+ * vcn_v5_0_2_start_sriov - VCN start under SRIOV env
+ */
+
+static int vcn_v5_0_2_start_sriov(struct amdgpu_device *adev)
+{
+	int i, vcn_inst;
+	struct amdgpu_ring *ring_enc;
+	uint64_t cache_addr;
+	uint64_t rb_enc_addr;
+	uint64_t ctx_addr;
+	uint32_t param, resp, expected;
+	uint32_t offset, cache_size;
+	uint32_t tmp, timeout;
+
+	struct amdgpu_mm_table *table = &adev->virt.mm_table;
+	uint32_t *table_loc;
+	uint32_t table_size;
+	uint32_t size, size_dw;
+	uint32_t init_status;
+
+	struct mmsch_v5_0_cmd_direct_write
+		direct_wt = { {0} };
+	struct mmsch_v5_0_cmd_direct_read_modify_write
+		direct_rd_mod_wt = { {0} };
+	struct mmsch_v5_0_cmd_end end = { {0} };
+	struct mmsch_v5_0_init_header header;
+
+	struct amdgpu_vcn5_fw_shared *fw_shared;
+	struct amdgpu_fw_shared_rb_setup *rb_setup;
+
+	direct_wt.cmd_header.command_type =
+		MMSCH_COMMAND__DIRECT_REG_WRITE;
+	direct_rd_mod_wt.cmd_header.command_type =
+		MMSCH_COMMAND__DIRECT_REG_READ_MODIFY_WRITE;
+	end.cmd_header.command_type = MMSCH_COMMAND__END;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		vcn_inst = GET_INST(VCN, i);
+
+		vcn_v5_0_2_fw_shared_init(adev, vcn_inst);
+
+		memset(&header, 0, sizeof(struct mmsch_v5_0_init_header));
+		header.version = MMSCH_VERSION;
+		header.total_size = sizeof(struct mmsch_v5_0_init_header) >> 2;
+
+		table_loc = (uint32_t *)table->cpu_addr;
+		table_loc += header.total_size;
+
+		table_size = 0;
+
+		MMSCH_V5_0_INSERT_DIRECT_RD_MOD_WT(SOC15_REG_OFFSET(VCN, 0, regUVD_STATUS),
+			~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);
+
+		cache_size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[i].fw->size + 4);
+
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+			MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+				regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+				adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_lo);
+
+			MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+				regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+				adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_hi);
+
+			offset = 0;
+			MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+				regUVD_VCPU_CACHE_OFFSET0), 0);
+		} else {
+			MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+				regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+				lower_32_bits(adev->vcn.inst[i].gpu_addr));
+			MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+				regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+				upper_32_bits(adev->vcn.inst[i].gpu_addr));
+		offset = cache_size;
+			MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+				regUVD_VCPU_CACHE_OFFSET0),
+				AMDGPU_UVD_FIRMWARE_OFFSET >> 3);
+		}
+
+		MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_VCPU_CACHE_SIZE0),
+			cache_size);
+
+		cache_addr = adev->vcn.inst[vcn_inst].gpu_addr + offset;
+		MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), lower_32_bits(cache_addr));
+		MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), upper_32_bits(cache_addr));
+		MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_VCPU_CACHE_OFFSET1), 0);
+		MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE);
+
+		cache_addr = adev->vcn.inst[vcn_inst].gpu_addr + offset +
+			AMDGPU_VCN_STACK_SIZE;
+
+		MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW), lower_32_bits(cache_addr));
+
+		MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+		regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH), upper_32_bits(cache_addr));
+
+		MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_VCPU_CACHE_OFFSET2), 0);
+
+		MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE);
+
+		fw_shared = adev->vcn.inst[vcn_inst].fw_shared.cpu_addr;
+		rb_setup = &fw_shared->rb_setup;
+
+		ring_enc = &adev->vcn.inst[vcn_inst].ring_enc[0];
+		ring_enc->wptr = 0;
+		rb_enc_addr = ring_enc->gpu_addr;
+
+		rb_setup->is_rb_enabled_flags |= RB_ENABLED;
+		rb_setup->rb_addr_lo = lower_32_bits(rb_enc_addr);
+		rb_setup->rb_addr_hi = upper_32_bits(rb_enc_addr);
+		rb_setup->rb_size = ring_enc->ring_size / 4;
+		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_VF_RB_SETUP_FLAG);
+
+		MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
+			lower_32_bits(adev->vcn.inst[vcn_inst].fw_shared.gpu_addr));
+		MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
+			upper_32_bits(adev->vcn.inst[vcn_inst].fw_shared.gpu_addr));
+		MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_VCPU_NONCACHE_SIZE0),
+			AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared)));
+		MMSCH_V5_0_INSERT_END();
+
+		header.vcn0.init_status = 0;
+		header.vcn0.table_offset = header.total_size;
+		header.vcn0.table_size = table_size;
+		header.total_size += table_size;
+
+		/* Send init table to mmsch */
+		size = sizeof(struct mmsch_v5_0_init_header);
+		table_loc = (uint32_t *)table->cpu_addr;
+		memcpy((void *)table_loc, &header, size);
+
+		ctx_addr = table->gpu_addr;
+		WREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_CTX_ADDR_LO, lower_32_bits(ctx_addr));
+		WREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_CTX_ADDR_HI, upper_32_bits(ctx_addr));
+
+		tmp = RREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_VMID);
+		tmp &= ~MMSCH_VF_VMID__VF_CTX_VMID_MASK;
+		tmp |= (0 << MMSCH_VF_VMID__VF_CTX_VMID__SHIFT);
+		WREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_VMID, tmp);
+
+		size = header.total_size;
+		WREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_CTX_SIZE, size);
+
+		WREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_MAILBOX_RESP, 0);
+
+		param = 0x00000001;
+		WREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_MAILBOX_HOST, param);
+		tmp = 0;
+		timeout = amdgpu_emu_mode ? 1000000 : 1000;
+		resp = 0;
+		expected = MMSCH_VF_MAILBOX_RESP__OK;
+		while (resp != expected) {
+			resp = RREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_MAILBOX_RESP);
+			if (resp != 0)
+				break;
+
+			udelay(10);
+			tmp = tmp + 10;
+			if (tmp >= timeout) {
+				DRM_ERROR("failed to init MMSCH. TIME-OUT after %d usec"\
+					" waiting for regMMSCH_VF_MAILBOX_RESP "\
+					"(expected=0x%08x, readback=0x%08x)\n",
+					tmp, expected, resp);
+				return -EBUSY;
+			}
+		}
+
+		init_status = ((struct mmsch_v5_0_init_header *)(table_loc))->vcn0.init_status;
+		if (resp != expected && resp != MMSCH_VF_MAILBOX_RESP__INCOMPLETE
+					&& init_status != MMSCH_VF_ENGINE_STATUS__PASS) {
+			DRM_ERROR("MMSCH init status is incorrect! readback=0x%08x, header init "\
+				"status for VCN%x: 0x%x\n", resp, vcn_inst, init_status);
+		}
+	}
+
+	return 0;
+}
+
 /**
  * vcn_v5_0_2_start - VCN start
  *
@@ -1157,8 +1379,18 @@ static int vcn_v5_0_2_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 static int vcn_v5_0_2_set_pg_state(struct amdgpu_vcn_inst *vinst,
 				   enum amd_powergating_state state)
 {
+	struct amdgpu_device *adev = vinst->adev;
 	int ret = 0;
 
+	/* for SRIOV, guest should not control VCN Power-gating
+	 * MMSCH FW should control Power-gating and clock-gating
+	 * guest should avoid touching CGC and PG
+	 */
+	if (amdgpu_sriov_vf(adev)) {
+		vinst->cur_state = AMD_PG_STATE_UNGATE;
+		return 0;
+	}
+
 	if (state == vinst->cur_state)
 		return 0;
 
-- 
2.51.0

