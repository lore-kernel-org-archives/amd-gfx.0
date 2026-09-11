Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A41C88E4D
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 17:56:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B10910F61C;
	Fri, 11 Sep 2026 17:56:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3z+mh5FC";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010070.outbound.protection.outlook.com
 [52.101.193.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84A5410F61C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 17:56:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrReLBBoDVzo5IyonLzfq8NdSKTwMESI6ymNop82AzWnm96FUy5FXV+1WCs+esGdXNkwFNoJvx//m0FXDT/joEMZ2NcvXY1bHDRm60xSfUNzz0os/G3LBBKHMa+bcVDeb7pW/BFXaG8j9qrfXMjPGwVxKhHVVN69SSKkV2oz1YGl21TVWMio3JMKjuAneUsPdKKEUu/8WaJnn5L0/4C7TBJsNCi0F4+jqKmvl8GoEvojY+nJb/VSJPI1hGX47bFwdFgyFVOyDTiRQLsHKXtF+KmTnrOkV4TujdB2AhN6+scHHcC+5JBu1h8spMBG0JH1r0WMbv7BtWWSGN8lJrAkHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNtQuHq8dFwbGF4wxtkGT33hkg9HYxUIo7MZ42e0214=;
 b=u1Eu6yvZGfNoCE5RBAYriBd3r2wCBU4nvWoXS0XYlQtOUgbbc5FPLk2xLVGobCo6dUE275YH/8NPzH/Vkty+o1xzolopul6Ttt4bXIrGDH8zFsOR6WpsNPx7UM/HNbeiePdcGTDHzJtzWzUT/w3FA7TJ4mpBHf9Fu7XjnbhcsZzK7OQf48JDOMRMtVWRxBrsO5zIUA+dIIJJIFfy0V/ul7w64D862YloFM0LAdI4FYvLzBfzc165PAbtRIeGMM2QObXfnghdatpBB/QG+hoYav/ejai+8zW7QAzdAOGFfOkTUyZjhZzD5VxjX+4+IMznnVbqjR8sdm/ZfkLhHtXduw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNtQuHq8dFwbGF4wxtkGT33hkg9HYxUIo7MZ42e0214=;
 b=3z+mh5FCqQnsa5Abpdh2B4Zv/GV237dpd3Yle5WlSwjOgctW2Vk1Q6jSC2iRF77tGsFqYFBec96m70not5UcbPXetyIRTIwmMa0xGV+LTwlPHyLSEUs0BTf1TS2XiE/dEXFs6IyFO7Wj7czn0/mkq9w8engPHXoOy1eo64gwgLE=
Received: from BN9PR03CA0159.namprd03.prod.outlook.com (2603:10b6:408:f4::14)
 by DM4PR12MB6613.namprd12.prod.outlook.com (2603:10b6:8:b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 17:56:05 +0000
Received: from BN1PEPF00018071.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::54) by BN9PR03CA0159.outlook.office365.com
 (2603:10b6:408:f4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 17:56:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018071.mail.protection.outlook.com (10.167.245.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 17:56:05 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:55:59 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 12:55:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/23] drm/amdgpu/sdma5.0: add tlb invalidation buffer func
 callback
Date: Fri, 11 Sep 2026 13:55:28 -0400
Message-ID: <20260911175544.1314467-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911175544.1314467-1-alexander.deucher@amd.com>
References: <20260911175544.1314467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018071:EE_|DM4PR12MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: e2456803-a6c4-4990-9a39-08df102df39c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|56012099006|10067099003|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8GOSBxtUNHnSY16QxQrYukfIJFCpEJt4qTf5QmVDeEiHMznOwo1cfVnT058XHu4QPmfd5MWwGi/jySrrR039PWOeodBpQgpjUZfgVOrSt0p/242bgRvruCMQPCr4j2ITYohloFKuMg9H8tazxtT+36dAqh38x4AVgITkjKM8Yhv+SKNY80G31HVbPcr9cmPPE6cVH3mvAo2WtCtgAUNPquXW5SCL4gaXmrY4jfLDw1+bmtrNxyuI0+Oe6utE3E/ljNxvdCcdNd5ImzUCFzEaOEYL1J8y9oYj4M34J2R+ZLKL/WBvAAyuW/VLaFIsGvdyp3zQCQrYesTZMWttxDzCNCWgLGffbqCaXkaX9Jlxxbit4IDxmwR/+5tRVd6QXgOGslMiF7O+Kz+o+Gn6dMOK0lBegI2bcYCvIWk+SVAI4IMhnItvBjpOkypx6lsmN9f795MQd+4X7R5ter/ibjgNjdNNctbWHHPwnZwON0+48zVi5+rrkJu0kyJqkMyCbUaZUlSPWGG6906M/DwqoRqBJ/h/7lMqXaJN7QkPKEN9m34PMzoQ6KNHtum5LjkV1GdUdY/WCbrw3Fcn6N6K2lH7SQWR+D/XA9e7JanT2umksXnkPIvdc9Wj43IPhAu5zbrYVVt8q4+1MQV9Fz3Dnaqm3fllDUCgUTP/6MdUAFGKxaIamDZt4XoOPgGKeVoXzpOlPlellFbu7VzJKLTUUJEyPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4LTm5b0YKu9atun7QC2DrrbTblI8/uqX7zaxetlaik7p8ffGHbW5MpXzgxHVG4dBCqCHawW4DvabV+kL/a0EdPgUCiTPXlIw6gXlTFfuRMv7ZC0RrcnCFMbyrwP+T17cVDqGUWZ1BatIm7PqLXg1x5tqboQDN8XjRCamBB11OVVydMoDfqsyfqI9sLh3Ecw/TBxMApUUccJsB6mf0QG4C95qQFfOW26PK6TNrGnpXTPJQTSDqrDmqjS4Wg2fGJh1lMOkL4UUzZXh635q70nIA4xKNXR0OpVrGnBZdM59Y5azbbc3gr72hZiOQdQp9uWrcm3G0oluc+kmjOp2oizutUrVHu+B+ekf0MxrpYBHfDYUcuXxGmbwC/0GOU4iaR8Syr6D0rKXyjk0Fz61HSobqNIozXumw7VPhdxIk7vbhRDNdzaPOO7cyOXfbgKT0EGD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:56:05.6182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2456803-a6c4-4990-9a39-08df102df39c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6613
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
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 49 ++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 97fee70dc2f64..8cb579ecf522e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -2030,6 +2030,52 @@ static void sdma_v5_0_emit_fill_buffer(struct amdgpu_ib *ib,
 	ib->ptr[ib->length_dw++] = byte_count - 1;
 }
 
+/**
+ * sdma_v5_0_emit_tlb_inv - Invalidate TLB using the sDMA engine
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
+static void sdma_v5_0_emit_tlb_inv(struct amdgpu_device *adev,
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
 static const struct amdgpu_buffer_funcs sdma_v5_0_buffer_funcs = {
 	.copy_max_bytes = 0x400000,
 	.copy_num_dw = 7,
@@ -2038,6 +2084,9 @@ static const struct amdgpu_buffer_funcs sdma_v5_0_buffer_funcs = {
 	.fill_max_bytes = 0x400000,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v5_0_emit_fill_buffer,
+
+	.tlb_inv_num_dw = 4,
+	.emit_tlb_inv = sdma_v5_0_emit_tlb_inv,
 };
 
 static void sdma_v5_0_set_buffer_funcs(struct amdgpu_device *adev)
-- 
2.55.0

