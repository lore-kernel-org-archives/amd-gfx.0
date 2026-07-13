Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3985AC43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 18:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C464110EAB7;
	Mon, 13 Jul 2026 18:27:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SpQdeioj";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012056.outbound.protection.outlook.com
 [40.107.200.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C274610EAB7
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 18:27:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjCe3mqp8QSdZqpxWsDAbcCRjBTggstLG66hGr5wKXoOHNvROHvy4KVK2kVrWBYogLIIXZeclW8xPpvcA4Hzo8Z1r8N2IEeV6LpGmww4iTJisxqu+vZ04617LZr6CtWHlTuYzE6FqHvk6tqbjM8liLpFMVQ8uudoFxJeYt1qnQRRnhvM/hwjYmB4YjEARRu5hsZDrXPYrxOFO6lAIm1EaTFmot0pylEfRLkWfGByr6jIl5g2XiSOsjsAtaCtt42CQWY9I1rtRNbS0A75qm22ZtkAYk78n/rN14qaRKL2fBH4/WA7UnwmhG2zLIzfWcVkWJZYvNIVjoR0Lyd4zPctRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LtYBqKvV6O3/K1QH/W8sm5ObKglTRpw+NODXrjaixo=;
 b=HRgMHOPFoEYCJNCKGfKaKpvN0osj3FS29QTCuuFxr6TAs8tb0So95jUVi4kbOFe2XYaTm7V0QWu7AOoI8fkSb5Z0fuNvpTWwUBWi9l3EYtnfzlU2kGKKYkTUYMcd2tF2/BVw/pj7H+vFtDSrERBVc6EUypUInWSisK62FG1xpPEkbxmW9tj2z8WSwkWLolr8vlOWHwTYvP+nkt5FCdofN3rNDVQtX6T471senTfl00CcU4tBJNBNlNMYR/lLr4XIIXsul/zOC2PK4ECjNcw7hhFEe60oSbP6igxa1XO+4S+ImQi+J3TOZkRk8pgQIErtprhTYrqJgsM/V+7VC3KGDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LtYBqKvV6O3/K1QH/W8sm5ObKglTRpw+NODXrjaixo=;
 b=SpQdeiojm+4ytFayQ1GqU3zvqhT2az5go1kHdIgCE+MkD3ubaDhI7c8H0Vud83Z/Q9KyE3eNGx17IOff53EWPnPTr7nzUxX/P/6ZXdiE1OY1/B9GZ4gJa247ADPy8P59iXOY0h8pSw4DXONexDDNOGk9Ym+3E5lmMzqqSgt9BZo=
Received: from SJ0P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::26)
 by LV3PR12MB9437.namprd12.prod.outlook.com (2603:10b6:408:21d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 18:27:49 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::18) by SJ0P220CA0020.outlook.office365.com
 (2603:10b6:a03:41b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 18:27:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 18:27:49 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 13:27:45 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 13 Jul 2026 13:27:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/14] drm/amdgpu/sdma6: add tlb invalidation buffer func
 callback
Date: Mon, 13 Jul 2026 14:27:26 -0400
Message-ID: <20260713182732.630947-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713182732.630947-1-alexander.deucher@amd.com>
References: <20260713182732.630947-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|LV3PR12MB9437:EE_
X-MS-Office365-Filtering-Correlation-Id: ea1a2eaf-f7d8-4349-0475-08dee10c7195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: MhI18no2JVGVU/PKlvbdNjLVYFBpBn6uLvhp0OfWjqpgCdCBXP7kyEgPB8HXRHzVb7y302+L5d8XS4W5pjRoeo/bVkccOdrYPZOQe36HlV3nprx9Hr1w64aQYlVR/KnBc4xj9P8buQytwUdUl4U6x6nPZQ9kG4A97jEIxSPfbtpDu0LhUGJg9XJUCiWhDG6V9WBDr6rf9pchJq81XgwKxvupiepmW14FUOqhZpOe/cbvr9b/AnNi72V04aZMNcIJ/jGgk8x09Zrd/yBKHGx5eSl24/XCE08uysvCcqkWP/wDP4Q+g/01bBFxhwG8lDi/7+32XJXVk+qerjruj4By4FJkiitN5G25unnRyw2QOeVNC1cHXRZxdDdEmTgRLK0hMM0gN4KjgT/qaZZc8Rvv/HA9Z2iJFLRDFq1Ev5yOQuHzOQr0Pvk4wnKERbOkaD6GybCPZPU/kpsoKCNaOSjoyeH4A3c6K4mmcic2eHcFFCcti0bKBRPT1SZErU+8tokDQ/L7rLorKBvd5ROZ8cI5afHdOyd/G7mKM5EXr0gcU+arSh1wZOU2bTtHZvx0A9yp7iUjGJP3FaYQW4u9WNxaffPxJ0Sd0TOBiM+lxN13E32dBr9zFYCvooxzIc7Aawb+CHMp3Mu3tJfJUD/gSnjO6Ke5xiZJ3lfB305aHRMXQ27FixpORVKnfEIN4gPGmIZ8NBSOOI7hkB2+FEvMJ8up3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h2GV7D/7Cyb1shFCPzN1rTn84shu1V3ev74Ir+gHxXGvCZOJw0DPgRKVWzGOBajUE6mv6mphXGDCsNior+5QMgqyZSKMkOvryhE8Cgj7sqI2wTS5vn6c1g378OUVqWnL9dWNJnBHDo+f2AjZCPxshQbLlKxMmnlW1nu33tMxVu9cdWDGYNLyp3V4tEXAKP3QVIQdJy4L8otBTk95ZWHDxn4aIqoejAORfmHHMlwRhoNuljGBSftd/OrJvJRWzUfKXoGAIcxZzjW/VQQH8BjEoa5VXDSktNgFstlkpFmXRbyrVUZupX+QujZ3U3I33bszez81W7oHYmD1YhpraXGw7dknM99PeF3COG/McxwHmSrx+UvVyu32+BGkZ/vmUuAl32xC8djvDMPHvUn8I8qz4+kJ6/W7LIjxxTpVeBDZR4o19fsdcr4tT7tLFkG7v1HH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:27:49.3541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1a2eaf-f7d8-4349-0475-08dee10c7195
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9437
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

Will be used for TLB invalidation.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 49 ++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 8d657aec1340a..06665a1d68839 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1861,6 +1861,52 @@ static void sdma_v6_0_emit_fill_buffer(struct amdgpu_ib *ib,
 	ib->ptr[ib->length_dw++] = byte_count - 1;
 }
 
+/**
+ * sdma_v6_0_emit_tlb_inv - Invalidate TLB using the sDMA engine
+ *
+ * @adev: amdgpu device structure
+ * @ib: indirect buffer to fill
+ * @vmid: vmid to target
+ * @vmhub: vmhub to target
+ * @eng: invalidation engine to use
+ * @flush_type: type of flush (lightweight, heavyweight)
+ * @xcc_inst: XCC to target
+ *
+ * Invalidate TLB using the DMA engine.
+ */
+static void sdma_v6_0_emit_tlb_inv(struct amdgpu_device *adev,
+				   struct amdgpu_ib *ib,
+				   unsigned int vmid,
+				   u32 vmhub,
+				   u32 eng,
+				   u32 flush_type,
+				   u32 xcc_inst)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
+	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
+	u32 mmhub_eng, gfxhub_eng;
+
+	if (AMDGPU_IS_GFXHUB(vmhub)) {
+		mmhub_eng = 0x1f;
+		gfxhub_eng = eng;
+	} else {
+		mmhub_eng = eng;
+		gfxhub_eng = 0x1f;
+	}
+
+	/* Trigger invalidation. */
+	ib->ptr[ib->length_dw++] =
+		(SDMA_PKT_VM_INVALIDATION_HEADER_OP(SDMA_OP_POLL_REGMEM) |
+		 SDMA_PKT_VM_INVALIDATION_HEADER_SUB_OP(SDMA_SUBOP_VM_INVALIDATION) |
+		 SDMA_PKT_VM_INVALIDATION_HEADER_GFX_ENG_ID(gfxhub_eng) |
+		 SDMA_PKT_VM_INVALIDATION_HEADER_MM_ENG_ID(mmhub_eng));
+	ib->ptr[ib->length_dw++] = inv_req;
+	ib->ptr[ib->length_dw++] = 0xFFFFFFFF;
+	ib->ptr[ib->length_dw++] =
+		(SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_INVALIDATEACK(1 << vmid) |
+		 SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_ADDRESSRANGEHI(0x1F));
+}
+
 static const struct amdgpu_buffer_funcs sdma_v6_0_buffer_funcs = {
 	.copy_max_bytes = 1 << 30,
 	.copy_num_dw = 7,
@@ -1869,6 +1915,9 @@ static const struct amdgpu_buffer_funcs sdma_v6_0_buffer_funcs = {
 	.fill_max_bytes = 1 << 30,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v6_0_emit_fill_buffer,
+
+	.tlb_inv_num_dw = 4,
+	.emit_tlb_inv = sdma_v6_0_emit_tlb_inv,
 };
 
 static void sdma_v6_0_set_buffer_funcs(struct amdgpu_device *adev)
-- 
2.55.0

