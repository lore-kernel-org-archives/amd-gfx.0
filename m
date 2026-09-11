Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B024FC88E53
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 17:56:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B48310F69F;
	Fri, 11 Sep 2026 17:56:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tv7tQE6e";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80CA510F69F
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 17:56:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vw29JfEhyRTsLYNwHSmYoJ381VTuI8UcG9b2acdSmM4tzsHi0X+G3CCm8v4B6+aG6WL4uLE0wCpyJScSbVDkWZl4Fx6Dq/NN/idt+1M5FOkH7/qPoFs827rdzk+OfNamowPh42ik43Vn0rSJAEbeWX2JnnnYgbIiOMkcVVWamrV3SBAapYzkk1zPoIO9zhLD51SMgOOotXAxXcFinAHVxkx28t+q/TZea+qQoPyOm+1dUY7tQC1mU94KEPxVc8w1Txaly6UPdfqHXtSaxSTkgDlazm43qxulxD0U7Fr7pSzpvZbuCxNpospcrDCAl+6LfYqIWcZd7FDAA2ndwRNoOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mF/DCd+DqMAndYIQiAdeGaVX9c0QFaILoFywfdLRBVs=;
 b=eK4tZeg8vbvmLoUBUsutD27zWKTFBx/WSzOt6kHPCdPcMgjFnIgENEplRVCmGZ7bQ3KZ1bvOyg78bvasvNQVa9TXdy530y6EYWHjAwqq1fIJ5hVDGUS9lBV/HLp9RN3pTYJOOg2Cg6cMEa4AN7SCsNADxEgDU60qBOJ35XvrsE6yMnaURdm5cnoa5naK+iPgq0wNTLXxsKX6+Api/oqoX3C4B7K+qBjzdB76huK9PKJNFm6CZslSHqKKJNeqU2Slmb8cmgpr1ZJqxOAnVU1WtQhFu25okmv8cBRcha/7sCKglK1cZBdb/1m6dPyOnFq9iL5iXSyq8iaeGxBfmdtVfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mF/DCd+DqMAndYIQiAdeGaVX9c0QFaILoFywfdLRBVs=;
 b=Tv7tQE6eICX4oarV8teUMual/wm6OCFiTHzvyLRs872HzxNT1OHhd2P/FHEk3jjrHRNfYlqwBbBAaURAHZ1w3wGyJwRbtfqOKTLJhrNziflBSHMlXkA/H1NmqnbBh0Koo+bgijIN0C059E+cTFvLeFnyDE9f1nMa4oTTdcAO4JY=
Received: from BLAP220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::16)
 by CH3PR12MB9217.namprd12.prod.outlook.com (2603:10b6:610:195::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 17:56:09 +0000
Received: from BN1PEPF0001806E.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::61) by BLAP220CA0011.outlook.office365.com
 (2603:10b6:208:32c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 17:56:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001806E.mail.protection.outlook.com (10.167.245.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 17:56:09 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:56:00 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 12:56:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/23] drm/amdgpu/sdma7: add tlb invalidation buffer func
 callback
Date: Fri, 11 Sep 2026 13:55:31 -0400
Message-ID: <20260911175544.1314467-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911175544.1314467-1-alexander.deucher@amd.com>
References: <20260911175544.1314467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001806E:EE_|CH3PR12MB9217:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c5c360b-7e62-42f1-18f0-08df102df61b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BT6OYSfTFF3jV2pwEmkSCCFtuETHNvgSTCZGAU4dUGEUGf2WNHBVwoyfroMCGbed0DX8e4mFYuRsUbJqZ2oKxtixm5uud3CZhK/CDsSYs9pV6U9QRuYV6M1tlYwlUCHEgpIhFP7u6xllMfslUMc1x/Ygn/SHJcYmHxfgckYg7E5rXuwPfe5u15GUdI3J1Q6JYP0HsLKSZdUyKkjLsG8GhS3cdyf6BKgXgw67s1HF/FK3qse4EaVzAe0Q1Rw8pqlmR4B1rZhBQCLdnYwIgZOzfpZIg0skRyy0cwtoEQAO54VxLbcrpuWR8He5vqKjjIwnAMIFU24uK9A6FxX6pQ92ISZgirf6Mv52OiFHSdRyQREmM5wlLTv/+bGSEEtFWK3w0VfgpYhlC8CsJfaHbGbdFTNFRFVrITyabHa4kyP7A6Lw+v45ZksMsKCTB0XVcGmNHbr7zgs6GaCHqMKxOr5EoHWIg2GoMQABdNctJmAJ/qTcqSrsguszHMi5l49MRPQwONUnhtTVQMBfBmqJwsoZOvJKuHhizZwk3HYDofq380VAd0OHjaZ2GL1/Wgcs4edzyLeNAQZl1uEDmdL/TMU1TzbvIoqEuNtg852w5elWZtOwqr25C/AiOQ7NAs61SzsqneJ+KT5jrWf6Ee//e39pEtxwp7VUyHSRCwrB82dO7HPSqhMrDJMKmQbgkRyGdg8yqAndsAMR5TfyYBXWolRNOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EedpJ2d7WdUc/jTEGvu6xs0ie8JCqXLNPKnMIi3/PS6BDAWIHMw5PQSP39c4I6HQ5+A+6DEVmUbYeLGeassEDvuSQvk8SpLyjVKk7pKHIYT7YS9kKD8eS8TvnWD5+rn5KBbONapY4w/Nn/tNwnKlrJncgZITsjRzYxLxE4R+RxhgVeQj2+RYI8bC5ay7T0ixW7kzFlWasL0Jf/DuQHdV3eBtC0JQ030myBaS/IgkCUpnpJo/FPkqL9WLxM5TTxk0XuMNNRWWlzJRD+THQ6FsuhoeDqIBwnK0hj50nuT7mnKRugZh2IPJnRHv0y/rRIhxfb0k0QplawnEh3Kqw8lqaVghmbSCOl5weTGn3GT8WG6+WmU+3IweBH677OS4lAQtLifq2TjagxpjCaMAGtU74ad0WhBmrEZ1o5zGFeFOPXK4bdGkT8F9eDVRLtEClO6l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:56:09.8009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5c360b-7e62-42f1-18f0-08df102df61b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001806E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9217
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
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 48 ++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index c55c941b82cf5..1bdf27d4f7b2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1829,6 +1829,52 @@ static void sdma_v7_0_emit_fill_buffer(struct amdgpu_ib *ib,
 	ib->ptr[ib->length_dw++] = byte_count - 1;
 }
 
+/**
+ * sdma_v7_0_emit_tlb_inv - Invalidate TLB using the sDMA engine
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
+static void sdma_v7_0_emit_tlb_inv(struct amdgpu_device *adev,
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
 static const struct amdgpu_buffer_funcs sdma_v7_0_buffer_funcs = {
 	.copy_max_bytes = 1 << 30,
 	.copy_num_dw = 8,
@@ -1836,6 +1882,8 @@ static const struct amdgpu_buffer_funcs sdma_v7_0_buffer_funcs = {
 	.fill_max_bytes = 1 << 30,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v7_0_emit_fill_buffer,
+	.tlb_inv_num_dw = 4,
+	.emit_tlb_inv = sdma_v7_0_emit_tlb_inv,
 };
 
 static void sdma_v7_0_set_buffer_funcs(struct amdgpu_device *adev)
-- 
2.55.0

