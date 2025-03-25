Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07535C3600B
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 07:15:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E4DA10E385;
	Tue, 25 Mar 2025 07:15:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TL/BYMW6";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7D6D10E385
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 07:15:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aueX2YTO/on8Q0CuOTmPX6YKSYkXvWjBmiK42WcRUzw3r7AUu0lPRuBaXXsXJTB8eUVpBt0pXTBVaUB/ThCKxhaq/UI8ulmgRkw/qwgohsy7LY5XQdgDYVYkoKMN3F1WvpCGrttWf7Th1qpxDocKN9akvA2s5tvw8japjq4/7TO13A0AfS4wu3rVbuWAj3bPAQpwvhU6iVSRbO4bsmo9Lo6K3S+w8TIXDGLLc1WPZzconEzhi/kiEvgxazbbrzO1F7luzRJ7lOEf7tK/yrBtKg9LCJgtgnRydM0pjAuhXNYFg6cflr9jY16mCgBDa7GkAzksxKVQdWDWwiSN/5FGNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kt1Pv/5NIbqi8sybAb+trR3polToKuwF/aPqEWslJcE=;
 b=BZxSa+XJrrTt1P9wPAFaQgSGOcnKghV4ns9Vqt8BAdkaX/XFFKFmF6K+8sMG3FFFaKe5wiLnZwSTYbURSRjuZPRzEHLpkww6UWycob5mUebhHpRq8uwhNnZ71R3zwPjNEI0iKbtbm5seAhfdEaBf14EkJwaxZK7AcyRvnfZHO07i0avZxeWR7XWrjbYtttyy8vkIP8pUOqY/bk1KExvPkuht5z4Bf4zGlu/v1/hZN2bY1XMRFCPChqBx37YM/awZISH2Jp4CXrg3eBM/Gkqn3yukbIQYASZNv771G8aUKnpfsLFE3iiLTb4P/TF/4+lDyxiGJOcrYZviThuqc5O4dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kt1Pv/5NIbqi8sybAb+trR3polToKuwF/aPqEWslJcE=;
 b=TL/BYMW6Rf/G2TLId6Q2Qj7fNlp+md9az30TElbT9scGwl13P41KZzfzejtgKe7CYAOfKwE2tocp69kz6+5H8IUUWPvFUVNYb5/h3tSyRvf+IPkuM9rMnyq6mjB8oXKGEAELV5IoEQo/ZZbR6oHxGl4jE4/a0YT1XefGUWtVRIc=
Received: from BN6PR17CA0060.namprd17.prod.outlook.com (2603:10b6:405:75::49)
 by PH0PR12MB7790.namprd12.prod.outlook.com (2603:10b6:510:289::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 07:15:08 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:405:75:cafe::c4) by BN6PR17CA0060.outlook.office365.com
 (2603:10b6:405:75::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 07:15:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 07:15:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 02:15:08 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 02:15:07 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 25 Mar 2025 02:15:06 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH] Revert "drm/amdgpu/sdma_v4_4_2: update VM flush
 implementation for SDMA"
Date: Tue, 25 Mar 2025 15:15:05 +0800
Message-ID: <20250325071505.312404-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|PH0PR12MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: f3015bd2-eefd-43fe-fdeb-08dd6b6cc630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oRJFuoJQPtHzqw0Ej6WPH0hOT9MLJbQM358JlFzX8aYR3Vwn5qk4NVVPFXoH?=
 =?us-ascii?Q?SQsWhS3r3yX0hNVneZeV0/169FLczC3YIp0pgXrI1+CCdWfePOmap0wjTJeK?=
 =?us-ascii?Q?x0XEYl/7pwXB4gUfWprSFQWUX9DfxQAnnQVbsOv5ladMjej320HZVuabjbux?=
 =?us-ascii?Q?YmCvf5FlRUvvwocEyWmAUZ8pQDMWv8+4v7i+reX22oBtZeoX/BkOqZdPzQ1f?=
 =?us-ascii?Q?3FduVRSiQquql/T0ZABm076yaCsOQ+Biow+D2GDNxS3qtbGHRw7HxhPPVVS/?=
 =?us-ascii?Q?JHdVmaXYS9tXQRbtZO2/r0BNrOI8mVMoQt7PEC8M+jlkgO8LLIYE7ZkcDi2i?=
 =?us-ascii?Q?4C3v1uYN8sNh62OxUMrhaz0ELSUKAhx9FvjDLhcJ4xZBMlfvIxHmtov5cFBB?=
 =?us-ascii?Q?r9yRElggNC50GpwQSjREmjBDY/6ZA31JNJ4LNXzpnZ3KaC5Um9/Y6Hvv4Byk?=
 =?us-ascii?Q?NLSHvlml9eVnPhqSwwNMN5C2OafWsJbtQLEwuiA6TISWKfty5iDicwP/Nbx2?=
 =?us-ascii?Q?ZbrdhXIVl6Lya+y+lj2YTXzqcqvE40/OT2vuNXgGdmGHejgdrQ60fPdTZMD9?=
 =?us-ascii?Q?TtO5/xzcdfISZcXSV22pbpcqU8XGSIXqnAiPEN5HH8BpFSRO/Uk/YOFTsjY9?=
 =?us-ascii?Q?qF4dYC6f8p6MaAwR+hj5Q/j6s/jTVQT5xgGB6nvW1GJXAhkP1SUv/J0aiHnB?=
 =?us-ascii?Q?30z5nAb11JxdhYpCLwt3tRUzKqcJG7Eiv6wfKn/qnQKMn/VVu9ZN+7tznYIw?=
 =?us-ascii?Q?BraBBP4rA9ohtVwc6LMVjjBbgTluXpQcqtJuqtr5fCm1sftTzTzUfjijn4ei?=
 =?us-ascii?Q?uKXc16FROyRJiTrMBUJD2YbsFdu4bYIlneUU6sj7tZpA2Vy1CJu/TLdBXn0e?=
 =?us-ascii?Q?kwwzh6wbfUobkWM69FlbJDimVPlajk1p6CnJPzlshDZodqOXszfunTeDtU9J?=
 =?us-ascii?Q?fZ5E4G9wK8Y4/sesyS1Ue0vAYl/jmudDALuFwBi85L03Aob68XBhSqjGuLFU?=
 =?us-ascii?Q?Y/B/OyzHx3oiVopZLdggXF7hY3tiaRIxBizz6JEihoAWXoPWM6AL+ngHpU9Y?=
 =?us-ascii?Q?aJCR1KU6zr6aaLpV9eiquus/ZEX1ETz1m2xv+JE4ob+fh63djwT5+2UJrD1z?=
 =?us-ascii?Q?IFY/eF6QNo1S4pZvpbNaABujUPq4rbP3kQHlwStezU4bDLcFgQ7k6NkWUfZ4?=
 =?us-ascii?Q?no+0w+EB2gr4TrVxlZL7BNICMqFi9lLAsPocaxrz8kwxmZ2Xlh9xwNpguxz2?=
 =?us-ascii?Q?ysQm4fXb68EUDELnuEzkJir5LfuhenFfUqipcEqmjJkVfKCTaL+whl2KECZA?=
 =?us-ascii?Q?E0s3hc/Qoxge+ORzQcesHtRPDtWxPECc85goNCBh+XFBB782DG7WOtcTAMsI?=
 =?us-ascii?Q?zieP+rWBXBuFQ3aPF4R4lplhvl9FaTu1DKb2NHWsktLkNQ0U7/J8vbJ4UYiM?=
 =?us-ascii?Q?31rfylxA++f4x+W18RiA9QDEU6AMNaXDUSHd8kmp9UsAaVS4cjOKEGJI8Q4l?=
 =?us-ascii?Q?+uCbT1rt34Kyh8o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 07:15:08.1905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3015bd2-eefd-43fe-fdeb-08dd6b6cc630
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7790
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

This temporarily  reverts commit 47cad92043909928d7260b77e7a996a0ae043f8c.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      | 77 ++++---------------
 .../gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h | 70 -----------------
 2 files changed, 14 insertions(+), 133 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index dc94d58d33a6..ea2d8f28b126 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -31,7 +31,6 @@
 #include "amdgpu_ucode.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_reset.h"
-#include "gc/gc_9_0_sh_mask.h"
 
 #include "sdma/sdma_4_4_2_offset.h"
 #include "sdma/sdma_4_4_2_sh_mask.h"
@@ -1291,71 +1290,21 @@ static void sdma_v4_4_2_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 			       seq, 0xffffffff, 4);
 }
 
-/*
- * sdma_v4_4_2_get_invalidate_req - Construct the VM_INVALIDATE_ENG0_REQ register value
- * @vmid: The VMID to invalidate
- * @flush_type: The type of flush (0 = legacy, 1 = lightweight, 2 = heavyweight)
- *
- * This function constructs the VM_INVALIDATE_ENG0_REQ register value for the specified VMID
- * and flush type. It ensures that all relevant page table cache levels (L1 PTEs, L2 PTEs, and
- * L2 PDEs) are invalidated.
- */
-static uint32_t sdma_v4_4_2_get_invalidate_req(unsigned int vmid,
-						uint32_t flush_type)
-{
-	u32 req = 0;
-
-	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
-			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
-	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
-	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
-	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
-	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
-	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
-	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
-	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
-			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
 
-	return req;
-}
-
-/*
- * sdma_v4_4_2_ring_emit_vm_flush - Emit VM flush commands for SDMA
- * @ring: The SDMA ring
- * @vmid: The VMID to flush
- * @pd_addr: The page directory address
+/**
+ * sdma_v4_4_2_ring_emit_vm_flush - vm flush using sDMA
  *
- * This function emits the necessary register writes and waits to perform a VM flush for the
- * specified VMID. It updates the PTB address registers and issues a VM invalidation request
- * using the specified VM invalidation engine.
+ * @ring: amdgpu_ring pointer
+ * @vmid: vmid number to use
+ * @pd_addr: address
+ *
+ * Update the page table base and flush the VM TLB
+ * using sDMA.
  */
 static void sdma_v4_4_2_ring_emit_vm_flush(struct amdgpu_ring *ring,
-					    unsigned int vmid, uint64_t pd_addr)
+					 unsigned vmid, uint64_t pd_addr)
 {
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t req = sdma_v4_4_2_get_invalidate_req(vmid, 0);
-	unsigned int eng = ring->vm_inv_eng;
-	struct amdgpu_vmhub *hub = &adev->vmhub[ring->vm_hub];
-
-	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
-				(hub->ctx_addr_distance * vmid),
-				lower_32_bits(pd_addr));
-
-	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
-				(hub->ctx_addr_distance * vmid),
-				upper_32_bits(pd_addr));
-	/*
-	 * Construct and emit the VM invalidation packet
-	 */
-	amdgpu_ring_write(ring,
-		SDMA_PKT_VM_INVALIDATION_HEADER_OP(SDMA_OP_VM_INVALIDATE) |
-		SDMA_PKT_VM_INVALIDATION_HEADER_SUB_OP(SDMA_SUBOP_VM_INVALIDATE) |
-		SDMA_PKT_VM_INVALIDATION_HEADER_XCC0_ENG_ID(0x1f) |
-		SDMA_PKT_VM_INVALIDATION_HEADER_XCC1_ENG_ID(0x1f) |
-		SDMA_PKT_VM_INVALIDATION_HEADER_MMHUB_ENG_ID(eng));
-	amdgpu_ring_write(ring, SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_INVALIDATEREQ(req));
-	amdgpu_ring_write(ring, 0);
-	amdgpu_ring_write(ring, SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_INVALIDATEACK(BIT(vmid)));
+	amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
 }
 
 static void sdma_v4_4_2_ring_emit_wreg(struct amdgpu_ring *ring,
@@ -2177,7 +2126,8 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 		3 + /* hdp invalidate */
 		6 + /* sdma_v4_4_2_ring_emit_pipeline_sync */
 		/* sdma_v4_4_2_ring_emit_vm_flush */
-		4 + 2 * 3 +
+		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
+		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 6 +
 		10 + 10 + 10, /* sdma_v4_4_2_ring_emit_fence x3 for user fence, vm fence */
 	.emit_ib_size = 7 + 6, /* sdma_v4_4_2_ring_emit_ib */
 	.emit_ib = sdma_v4_4_2_ring_emit_ib,
@@ -2209,7 +2159,8 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
 		3 + /* hdp invalidate */
 		6 + /* sdma_v4_4_2_ring_emit_pipeline_sync */
 		/* sdma_v4_4_2_ring_emit_vm_flush */
-		4 + 2 * 3 +
+		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
+		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 6 +
 		10 + 10 + 10, /* sdma_v4_4_2_ring_emit_fence x3 for user fence, vm fence */
 	.emit_ib_size = 7 + 6, /* sdma_v4_4_2_ring_emit_ib */
 	.emit_ib = sdma_v4_4_2_ring_emit_ib,
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h b/drivers/gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h
index 3ca8a417c6d8..8de4ccce5e38 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h
@@ -64,9 +64,6 @@
 #define HEADER_BARRIER  5
 #define SDMA_OP_AQL_COPY  0
 #define SDMA_OP_AQL_BARRIER_OR  0
-/* vm invalidation is only available for GC9.4.3/GC9.4.4/GC9.5.0 */
-#define SDMA_OP_VM_INVALIDATE 8
-#define SDMA_SUBOP_VM_INVALIDATE 4
 
 /*define for op field*/
 #define SDMA_PKT_HEADER_op_offset 0
@@ -3334,72 +3331,5 @@
 #define SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_completion_signal_63_32_shift  0
 #define SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_COMPLETION_SIGNAL_63_32(x) (((x) & SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_completion_signal_63_32_mask) << SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_completion_signal_63_32_shift)
 
-/*
-** Definitions for SDMA_PKT_VM_INVALIDATION packet
-*/
-
-/*define for HEADER word*/
-/*define for op field*/
-#define SDMA_PKT_VM_INVALIDATION_HEADER_op_offset 0
-#define SDMA_PKT_VM_INVALIDATION_HEADER_op_mask   0x000000FF
-#define SDMA_PKT_VM_INVALIDATION_HEADER_op_shift  0
-#define SDMA_PKT_VM_INVALIDATION_HEADER_OP(x) ((x & SDMA_PKT_VM_INVALIDATION_HEADER_op_mask) << SDMA_PKT_VM_INVALIDATION_HEADER_op_shift)
-
-/*define for sub_op field*/
-#define SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_offset 0
-#define SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_mask   0x000000FF
-#define SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_shift  8
-#define SDMA_PKT_VM_INVALIDATION_HEADER_SUB_OP(x) ((x & SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_mask) << SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_shift)
-
-/*define for xcc0_eng_id field*/
-#define SDMA_PKT_VM_INVALIDATION_HEADER_xcc0_eng_id_offset 0
-#define SDMA_PKT_VM_INVALIDATION_HEADER_xcc0_eng_id_mask   0x0000001F
-#define SDMA_PKT_VM_INVALIDATION_HEADER_xcc0_eng_id_shift  16
-#define SDMA_PKT_VM_INVALIDATION_HEADER_XCC0_ENG_ID(x) ((x & SDMA_PKT_VM_INVALIDATION_HEADER_xcc0_eng_id_mask) << SDMA_PKT_VM_INVALIDATION_HEADER_xcc0_eng_id_shift)
-
-/*define for xcc1_eng_id field*/
-#define SDMA_PKT_VM_INVALIDATION_HEADER_xcc1_eng_id_offset 0
-#define SDMA_PKT_VM_INVALIDATION_HEADER_xcc1_eng_id_mask   0x0000001F
-#define SDMA_PKT_VM_INVALIDATION_HEADER_xcc1_eng_id_shift  21
-#define SDMA_PKT_VM_INVALIDATION_HEADER_XCC1_ENG_ID(x) ((x & SDMA_PKT_VM_INVALIDATION_HEADER_xcc1_eng_id_mask) << SDMA_PKT_VM_INVALIDATION_HEADER_xcc1_eng_id_shift)
-
-/*define for mmhub_eng_id field*/
-#define SDMA_PKT_VM_INVALIDATION_HEADER_mmhub_eng_id_offset 0
-#define SDMA_PKT_VM_INVALIDATION_HEADER_mmhub_eng_id_mask   0x0000001F
-#define SDMA_PKT_VM_INVALIDATION_HEADER_mmhub_eng_id_shift  26
-#define SDMA_PKT_VM_INVALIDATION_HEADER_MMHUB_ENG_ID(x) ((x & SDMA_PKT_VM_INVALIDATION_HEADER_mmhub_eng_id_mask) << SDMA_PKT_VM_INVALIDATION_HEADER_mmhub_eng_id_shift)
-
-/*define for INVALIDATEREQ word*/
-/*define for invalidatereq field*/
-#define SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_offset 1
-#define SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_mask   0xFFFFFFFF
-#define SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_shift  0
-#define SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_INVALIDATEREQ(x) ((x & SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_mask) << SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_shift)
-
-/*define for ADDRESSRANGELO word*/
-/*define for addressrangelo field*/
-#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_offset 2
-#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_mask   0xFFFFFFFF
-#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_shift  0
-#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_ADDRESSRANGELO(x) ((x & SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_mask) << SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_shift)
-
-/*define for ADDRESSRANGEHI word*/
-/*define for invalidateack field*/
-#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_offset 3
-#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_mask   0x0000FFFF
-#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_shift  0
-#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_INVALIDATEACK(x) ((x & SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_mask) << SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_shift)
-
-/*define for addressrangehi field*/
-#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_offset 3
-#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_mask   0x0000001F
-#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_shift  16
-#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_ADDRESSRANGEHI(x) ((x & SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_mask) << SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_shift)
-
-/*define for reserved field*/
-#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_offset 3
-#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_mask   0x000001FF
-#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_shift  23
-#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_RESERVED(x) ((x & SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_mask) << SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_shift)
 
 #endif /* __SDMA_PKT_OPEN_H_ */
-- 
2.25.1

