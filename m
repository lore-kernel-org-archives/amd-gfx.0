Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F010C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:03:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9159310F332;
	Fri, 21 Aug 2026 16:03:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G1bP9RqU";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D80410F332
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:03:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gkz2wtE7VasKo1f8PHMNvUWo0IOqvTNOBX+gR9oJvYrMSQzv5ahH1li9INF4XGrfEkbFoUTpEdzppBwXFu0VDw5JaflQYlKQKrSt+G/vNmWSRh31tNaf6eH7zjrkNdJVec1bMrabxS5iK1hkFJ4xaCF/9Sn3IEoKRp60QI5Romyl2IBg6ocdhWND9ra2ZRtyZ9XJ8y5Ue3lgpN3n5XFeQwXaEA6zVTYl4mJLrKBYV5Fy7kx3ANE1MsEMYlt7zaf/K6Azx7KMrNFRp9FKxKCJpYM9LySq6i/Gffh15+x8+BtEIVXhO0yjn8OVtb0NjUYx7SbFKM6yeR50ZPRLtCPcXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2ivlCzElX3irF9jWOrxuOx0SeCZmrqQAgPMfcAGgaA=;
 b=r2jLAMKMWH+jYvbQ8iMZg25rUvXPLmkWamnx3Cqy7S2PqzaiVtG6Ipz3TRyv3JxQtpG7FDNgcGZuRDZOYP8PH5Nap1Ip/UJUp+okdmIhuRyTy4EEEKRO+OsrYBJTI+sLxsviflxAHonWFH3AacMWvMCPQteDOl7N2K7e10BixEarzAISZcwoSUFLHFcRRfHU/othqVyHwOzZxVp2x9EJeesYJjTb3/9hUFesdZUtpANb8EwvcRGi2Ti4zkJfE0EKc32CWvO5HVhn6QPyQ/YF/thv4Ffq6fxpg9/SVqglqMm1zIg0lkRMzzdG5czhMpvWC5TjexNgA9kJANCGxpbg0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2ivlCzElX3irF9jWOrxuOx0SeCZmrqQAgPMfcAGgaA=;
 b=G1bP9RqU4xxjfllkJKARDheuHiQnN4tUseGdiZ+yZ9VnVZSThQyeACN5kBoEk9scnOWhrPfpd2+56KBSmdMgvnaiK4hBNHMM6FaemY0kvwUxofMYAqAPezRWRg+n1M+J0Y32PhpKQx7VQzFDzjm9oytIeZwTJ2T2YQgcGkO2M8A=
Received: from SJ0PR05CA0052.namprd05.prod.outlook.com (2603:10b6:a03:33f::27)
 by CHXPR12MB999222.namprd12.prod.outlook.com (2603:10b6:610:2f9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 16:03:18 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::14) by SJ0PR05CA0052.outlook.office365.com
 (2603:10b6:a03:33f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.4 via Frontend Transport; Fri, 21
 Aug 2026 16:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:03:17 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:03:17 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:03:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Bokun Zhang <Bokun.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Add VCN v5.0.2 SRIOV code path
Date: Fri, 21 Aug 2026 12:03:02 -0400
Message-ID: <20260821160303.751422-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160303.751422-1-alexander.deucher@amd.com>
References: <20260821160303.751422-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|CHXPR12MB999222:EE_
X-MS-Office365-Filtering-Correlation-Id: 7573797c-ef78-4078-3699-08deff9db6f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2vXK5M+jWoq1zOULHpQoWHuFayNSnQqLM5ZDr/1rYV1OmJyZjGOq06wRP2EM+J/BgC/4C5jujktcNE1SdHsjf6iMAHZrgZK1DCCOdiTilXzTxiZ8CdNaiNpVjj4KVr0i95w66DJhe+3xMb5lWv4vsq81LJsxVBRn5UbcfT3WX2ggaSS8IwTbhrzV8lokl0qYMKimfVBPPQzVaHdQmz+ESAhmjhByh8fXbOU4CgCAh+nM1TqDiLjxU58xBk3w88+7B1V+/v10jf78WhNrPPColV75lzze72wwi+Lqcs68JXCRQgtnJsVNpAOd68tSpeMWqmUYEA0P9jhcp9+8DbKB7LYCA+/34WV2dAPYt6lScgwGfMLOam4GiZYYjvjOryNrD/6tf46DqLxbBmqx1x2XogqeJPIbMEQrpm+AMEmnDQb4IaFs4k4tF+CTDHL6N7rpOQAYxRhG3avaHkJ33KiaPKODYEOYusurGdXYOT+PKXxO2PJ7gAAZTX0qxU5ApiT2UfehEpdWE91GWBI+rU6woQ/lCtxUHL2CN1/L1rbel1HVBr+BhJjHw7lwo1b7tlRQ2gyMZOyAi95yyIvUARtSlhyh6CQu4iw541EAFwekHerRVFQaxAT+2SBKXe4uPWbtwTZKlwErI6HWotG3PDj8oCl2etn3allR5OdlpweYxiDyR/zVkdpHzucwiWpj/Tx5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O6RVu04lI7nuqWLOM9KKQrkKwCBNKcBCqoX3KHgylw3svRDtH+3/hZ96EVKMxFLHVUgriaOj8BjfEmIXvIEOSJGKX2Kmgwch4JRRfQgo0eeSOlYFwqTJ36uoYYppX3rswEv0ba42iS/gKJNkeYH21DPHKpCBaNjttj6J/4couXvjgOXfVvphg3RNn1PJBjTbYVMRBA//q14T/Tp3JYYd09P+JjVaKOJSGw0S70LehC4azlWiFphEluIfDkUz+8uywvymVe90T6pTVk75CqjrpNhTULb6Dt26PTn2Ix+kCAr54NBnXk80ZV4qSqbW/OIP0u3Kzs9yYR7NKCxdvIADDUS2V2QOcPqzVh9PtM85E1/4IRA4EiDrYl31Usk3Ly7bwRkS1Qob63+0bXO+DVtlR+3/VtNMW25rRDqXEAkdQthZ95u9QltJlMA/n/OzYAE2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:03:17.7079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7573797c-ef78-4078-3699-08deff9db6f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999222
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

From: Bokun Zhang <Bokun.Zhang@amd.com>

- Add VCN v5.0.2 SRIOV code path
- Add VCN MMSCH init table transfer
- Skip unsupported actions such as power gating
  and per queue reset for SRIOV VF.

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c | 276 ++++++++++++++++++++++--
 1 file changed, 254 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
index c42ab995884ed..ed47ddd5b08ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
@@ -37,9 +37,11 @@
 #include "vcn_v5_0_0.h"
 #include "vcn_v5_0_1.h"
 #include "vcn_v5_0_2.h"
+#include "mmsch_v5_0.h"
 
 #include <drm/drm_drv.h>
 
+static int vcn_v5_0_2_start_sriov(struct amdgpu_device *adev);
 static void vcn_v5_0_2_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v5_0_2_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v5_0_2_set_pg_state(struct amdgpu_vcn_inst *vinst,
@@ -132,9 +134,13 @@ static int vcn_v5_0_2_sw_init(struct amdgpu_ip_block *ip_block)
 
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
@@ -147,9 +153,16 @@ static int vcn_v5_0_2_sw_init(struct amdgpu_ip_block *ip_block)
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
@@ -178,6 +191,9 @@ static int vcn_v5_0_2_sw_fini(struct amdgpu_ip_block *ip_block)
 		drm_dev_exit(idx);
 	}
 
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_virt_free_mm_table(adev);
+
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 		r = amdgpu_vcn_suspend(adev, i);
 		if (r)
@@ -208,27 +224,41 @@ static int vcn_v5_0_2_hw_init(struct amdgpu_ip_block *ip_block)
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
+
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
+		}
 	}
 
 	return 0;
@@ -675,6 +705,198 @@ static int vcn_v5_0_2_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
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
@@ -1098,8 +1320,18 @@ static int vcn_v5_0_2_set_clockgating_state(struct amdgpu_ip_block *ip_block,
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
2.55.0

