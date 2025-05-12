Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96551C3ABCB
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 03:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0945E10E11B;
	Mon, 12 May 2025 03:44:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ympYLz23";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CD6910E11B
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 03:44:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csdjda72eTPeUCCjLnOvbTtP+Q7ehXSNVzT4l/J5wj+80G6WOkN2p6gb0FXWHFXKAvsllBRDg+F1f7mvkg7HX2a4XZdl+2a9+EYgg64mvauI3kKlY6cwiVRHFukzsnsg7Vm0Ek1hjP6L24NPfkA50Q1VI54jSl55vFhwOTAMnlWX/IE1NF9EDQ0N9zNDehMnAKsbU3v3vXMrUTyWnna7cDvj9fBqOKASWvQcXXn5FpoYZrCoMBQzmhBx2XXFR4llopRW/utHrRcI8gRI0Bc/+gOPNtHNoUDcnbbzKoxBqvKEmxTEsOLaJJPuftNIXxCHFtp5RYj8uioyJTHA/SO+8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdVxlzOWN5SbfgjlSZxlWf+OEtV9oYKqdbur3dAqfS0=;
 b=Ca4vc5o0qewhDM0YDgHbhhXI/QJc1jRD8x1hlnCN88gvBTgvYkehZZsJ1oCWFv6VC0Wh/ExtsPYHo4x54v2xQHi1KLJDwoqj9esdGN9LSex1Cd017eRrvpGb4eayGsmFD45MbI4toKMIxjjGSus68UviJfiwIH+83UY3AOvI8iLYkzNll7CHGQakC5s7iCxjSLOAGShfHHN7n7kH2zQJf0ScYXQep3M3V1bLLfHaZYdDw2c1AwLzvQNBi9AF5T+3z9yOI8+KNtwFBazxvEhcyXqnEFOk/HFAMh83PlkOSIICd71ogYc5FYTUwq5tVNr0ziDybWfmqTG3McC0qUua0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdVxlzOWN5SbfgjlSZxlWf+OEtV9oYKqdbur3dAqfS0=;
 b=ympYLz23hY5g/qu13XnFQncNDt1Ix4YhhSGmj2bbwLklw8YRGBvzIs8bGSDtohQgw1o3owxbJDncMLW577h3zKu+bwXz0EYr2YE8+vVyp7hIfSz0UB0MHAPjn0+rEvprMOOavIEQUEHefD5bL7PJ33IoxhvCY4p5Wgym9wZ0viU=
Received: from CH0PR03CA0391.namprd03.prod.outlook.com (2603:10b6:610:11b::10)
 by LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 03:44:23 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::52) by CH0PR03CA0391.outlook.office365.com
 (2603:10b6:610:11b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Mon,
 12 May 2025 03:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 03:44:22 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 11 May
 2025 22:44:20 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Alexander.Deucher@amd.com>
CC: <Ahmad.Rehman@amd.com>, <Vignesh.Chander@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/vcn: sriov support for vcn_v5_0_1
Date: Mon, 12 May 2025 11:44:02 +0800
Message-ID: <20250512034403.381441-3-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512034403.381441-1-FangSheng.Huang@amd.com>
References: <20250512034403.381441-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|LV3PR12MB9356:EE_
X-MS-Office365-Filtering-Correlation-Id: d70a3abb-e5bc-4074-7e4c-08dd910748d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wKvt0fQ0/+QDwbRWOIXCCGNsjraoCk7x9xQYDCcNZQBksL03tp9DlUqJyFYF?=
 =?us-ascii?Q?17WGDTURGxScBcxLQ+6yEiUy5vtfFWQU6w/uAVEArerArEMMl+QHYf7CtA+v?=
 =?us-ascii?Q?7P4tU/c3jt5OcjOFPJJM3ulZQhq/wcU7Rlqg82/P+sNB6QBtU8e4h5pXuhWO?=
 =?us-ascii?Q?1JDwrHi0SleLlGjpoYUOQVgSvVuLHcuILljVUyDvHkO5pRL7auQFws2gJdKx?=
 =?us-ascii?Q?H7wNky6/IHZUgIKixM9xzLmaZg3XGk7SRMCaOmGuq4NqUALTFVyhv+fvuuMe?=
 =?us-ascii?Q?oMDU1AV4sjYSWh2XwqfbM4i85StkUg0FozpExh2fsN3zu+V1hMLsfzf5GT4W?=
 =?us-ascii?Q?nAmLhKuh4ZzYp8JV5iVsMMHCuB+DllDdC0DZNQjPrjs2PiiW48vU3wQAzFG/?=
 =?us-ascii?Q?sixm2R9w/BExN2eMEHiKaewzMuwMTq/aqRoyIQM0Lh1iFN7BAlsm1abZByoy?=
 =?us-ascii?Q?zIz8u27ta0PNbdZX23fmXhwSOm+Aogzi819A9hS8xKMseVnmZDIYbQUq3cRN?=
 =?us-ascii?Q?jmC5s/gb/HmSFWaaYhkPJ20lkl5goiwXbOI+2r+yvaN4QgO5MCV1OmCD8HAn?=
 =?us-ascii?Q?04QugfK7nV6z1WG0F50QBucGDzEpDwSdKyz4WCgJutA/1WxoWmPdwaKZK/os?=
 =?us-ascii?Q?h0MGJRl9zeo6IYTKhYc8INhiaDWPJWFkSgXhqMSFL8f1e3zbBPZpc0/fqdgX?=
 =?us-ascii?Q?z8v0x4Y3iwLOZW3lJX2Qd9XTqk5vIOxE+xFkGadZGpzyFqWDMZ4r9eFtAPCN?=
 =?us-ascii?Q?1Kp0zHr81K+h3ora6GUtwQWMj3FOZSjBDmqkRnswvlNK1xjWfmBYBCGvXIeg?=
 =?us-ascii?Q?BBvAUpPd1w5GyrbdbuJLUZngIHrMv0zZJcJY/TQ2xkKhIKa0COOXB23EqXy9?=
 =?us-ascii?Q?hTmIj5uurHynKyZc70QQRD7bVlJZlOqGSHSMs37g8LiEJ4hldAkidU7+UfPk?=
 =?us-ascii?Q?h9sFn4M5F5/SYBo0p4mdCX/3tVa5cn9cHh3BMo1RG+LvttJAdhS2EfgDXLM+?=
 =?us-ascii?Q?EfUm8uzZVtZq03zJ1OhSl/j5klR/fVv1s8dzP+Njzu5ACshE/MWeRhYfxzAk?=
 =?us-ascii?Q?lnuu9pXDeivTc/wnkotHFRWXjZggQTj3k3pcKu0eLdi45QInawd17Vqe5N7z?=
 =?us-ascii?Q?CCLX40DjLvGJuLz6Cs0Mn/slQRatLGMO5CLR0XNqetFVsG+EvLxCpJUtB9J0?=
 =?us-ascii?Q?PInZDMDZIyiICtbbXl7Gk0jJO8sP2A6KZTXQHYR8225AFiueXvwlf1uRyTdZ?=
 =?us-ascii?Q?NMsNleJ4wseYmhczaB9tAIi6MLL18KuJXpwD2ziqhMqdw/lYF2AhpV+D+PfI?=
 =?us-ascii?Q?dFiicbjm7RZ0XNDNnO1UTRohdITgzMnH4ueWPfZeCaNmpWKhCLYnJPsH3y9Q?=
 =?us-ascii?Q?mcFhQFXZkCQGDzdVJIvRGHtSqiDlKablvGWVqpvhsn6YE03Hw404W+thPjku?=
 =?us-ascii?Q?NCMO3fImCESZzLCDGUtxJQgjxjpbKUe8PA/Mr01zkBAFFQyFvwIqd8cuobHg?=
 =?us-ascii?Q?7HNr4vfftAMm8wS3mat1nzCtp3jQcboT+kfJuDNSemZbqJx9P4a3n6O7sA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 03:44:22.8747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d70a3abb-e5bc-4074-7e4c-08dd910748d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9356
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

initialization table handshake with mmsch

Signed-off-by: fanhuang <FangSheng.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 265 ++++++++++++++++++++++--
 1 file changed, 248 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 60ee6e02e6ac..8e843011703c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -30,6 +30,7 @@
 #include "soc15_hw_ip.h"
 #include "vcn_v2_0.h"
 #include "vcn_v4_0_3.h"
+#include "mmsch_v5_0.h"
 
 #include "vcn/vcn_5_0_0_offset.h"
 #include "vcn/vcn_5_0_0_sh_mask.h"
@@ -39,6 +40,7 @@
 
 #include <drm/drm_drv.h>
 
+static int vcn_v5_0_1_start_sriov(struct amdgpu_device *adev);
 static void vcn_v5_0_1_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v5_0_1_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v5_0_1_set_pg_state(struct amdgpu_vcn_inst *vinst,
@@ -126,7 +128,14 @@ static int vcn_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
 
 		ring = &adev->vcn.inst[i].ring_enc[0];
 		ring->use_doorbell = true;
-		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 11 * vcn_inst;
+		if (!amdgpu_sriov_vf(adev))
+			ring->doorbell_index =
+				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+				11 * vcn_inst;
+		else
+			ring->doorbell_index =
+				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+				32 * vcn_inst;
 
 		ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[i].aid_id);
 		sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[i].aid_id);
@@ -143,6 +152,12 @@ static int vcn_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->vcn.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
 
+	if (amdgpu_sriov_vf(adev)) {
+		r = amdgpu_virt_alloc_mm_table(adev);
+		if (r)
+			return r;
+	}
+
 	vcn_v5_0_0_alloc_ip_dump(adev);
 
 	return amdgpu_vcn_sysfs_reset_mask_init(adev);
@@ -172,6 +187,9 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
 		drm_dev_exit(idx);
 	}
 
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_virt_free_mm_table(adev);
+
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 		r = amdgpu_vcn_suspend(adev, i);
 		if (r)
@@ -204,24 +222,38 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_ring *ring;
 	int i, r, vcn_inst;
 
-	if (RREG32_SOC15(VCN, GET_INST(VCN, 0), regVCN_RRMT_CNTL) & 0x100)
-		adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		vcn_inst = GET_INST(VCN, i);
-		ring = &adev->vcn.inst[i].ring_enc[0];
-
-		if (ring->use_doorbell)
-			adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
-				((adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-				 11 * vcn_inst),
-				adev->vcn.inst[i].aid_id);
-
-		/* Re-init fw_shared, if required */
-		vcn_v5_0_1_fw_shared_init(adev, i);
-
-		r = amdgpu_ring_test_helper(ring);
+	if (amdgpu_sriov_vf(adev)) {
+		r = vcn_v5_0_1_start_sriov(adev);
 		if (r)
 			return r;
+
+		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+			ring = &adev->vcn.inst[i].ring_enc[0];
+			ring->wptr = 0;
+			ring->wptr_old = 0;
+			vcn_v5_0_1_unified_ring_set_wptr(ring);
+			ring->sched.ready = true;
+		}
+	} else {
+		if (RREG32_SOC15(VCN, GET_INST(VCN, 0), regVCN_RRMT_CNTL) & 0x100)
+			adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
+		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+			vcn_inst = GET_INST(VCN, i);
+			ring = &adev->vcn.inst[i].ring_enc[0];
+
+			if (ring->use_doorbell)
+				adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+					((adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+					11 * vcn_inst),
+					adev->vcn.inst[i].aid_id);
+
+			/* Re-init fw_shared, if required */
+			vcn_v5_0_1_fw_shared_init(adev, i);
+
+			r = amdgpu_ring_test_helper(ring);
+			if (r)
+				return r;
+		}
 	}
 
 	return 0;
@@ -663,6 +695,195 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	return 0;
 }
 
+static int vcn_v5_0_1_start_sriov(struct amdgpu_device *adev)
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
+	uint32_t enabled_vcn;
+
+	struct mmsch_v5_0_cmd_direct_write
+		direct_wt = { {0} };
+	struct mmsch_v5_0_cmd_direct_read_modify_write
+		direct_rd_mod_wt = { {0} };
+	struct mmsch_v5_0_cmd_end end = { {0} };
+	struct mmsch_v5_0_init_header header;
+
+	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
+	volatile struct amdgpu_fw_shared_rb_setup *rb_setup;
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
+		vcn_v5_0_1_fw_shared_init(adev, vcn_inst);
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
+			offset = cache_size;
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
+			regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH), upper_32_bits(cache_addr));
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
+		timeout = 1000;
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
+		enabled_vcn = amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, 0) ? 1 : 0;
+		init_status = ((struct mmsch_v5_0_init_header *)(table_loc))->vcn0.init_status;
+		if (resp != expected && resp != MMSCH_VF_MAILBOX_RESP__INCOMPLETE
+					&& init_status != MMSCH_VF_ENGINE_STATUS__PASS) {
+			DRM_ERROR("MMSCH init status is incorrect! readback=0x%08x, header init "\
+				"status for VCN%x: 0x%x\n", resp, enabled_vcn, init_status);
+		}
+	}
+
+	return 0;
+}
+
 /**
  * vcn_v5_0_1_start - VCN start
  *
@@ -1103,8 +1324,18 @@ static int vcn_v5_0_1_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 static int vcn_v5_0_1_set_pg_state(struct amdgpu_vcn_inst *vinst,
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
2.34.1

