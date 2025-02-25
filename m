Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C001C021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 08:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9F8210E5BC;
	Tue, 25 Feb 2025 08:43:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zXPVaata";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F182010E5BD
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 08:43:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJRupWMRp6UKkEfLD4QkEEZTyFax+blXZd/pPH6UIbMrGp6knUBfOFFSXo6yX2sEtjEsqcgA0G9JKn4zAqZ81XCYR1v5wGNcripVNlfF/v4/4lliEbYQiiGGBb4j4OGo43zx5WOWI+BC2dyh1YESjHQ/LWByASxD9u9MUqL9PjQ02NE4ulzukaJa2wFISZ8qdmq3VbrzIafIimZZUjYwG6jfWE8K6zBQtGXRIH9eWjZ8WvthKWE5hlIhabkMg4pNMPk5eun5oUlmfqrQaRy5QqOmOp+8bhZRGddAgDP4hUIX/jlmPKFB2mclqDSfsLjVfzUJStLZcJiRmqJehWxp9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CStDBTmwLtUImrX+5JDRv7JRRCyRkiioBOvkh9TErRI=;
 b=FhNk/eO8cCKWddctNXoWaSwhuqfB0nTO13sjsgdJ9yDQItri2yP48edtt5B6xzkRztDRog7+wi8bim2SULmG+FTggl3RlyDYUgKRY7FKeKMH7/VH0zxKPfn0d0POnSw+h2J5OIebWRr3yG/LDI7j5IbhGDXJC71g3Bgf4SBX3v2V0wjdoweT5KZIOq4HWD5onTywc6oDnRFb/u9afmXvXmvE/+OOmBhZKwh60XifqsIjXTo4sV+NgKSpvB6qLSGmHWG9rTtrGisC/PEMyQTZIYKcyMtutq6wt62frRIfjdJac8DyNiu5qFW5qUejDY2KW02wkjz/vcgv8IiEkhuMUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CStDBTmwLtUImrX+5JDRv7JRRCyRkiioBOvkh9TErRI=;
 b=zXPVaataGNjXquiYHyx8DQ241rQhwXCWTFDhXUwhfcvInK2BL99FXWchE0Ntn/yh7v1bMOyHCZDcIXhA7h8fjUOJMAWP4zESWvwnjCX3tJSsTjGFFpmt4/CeqQ2iyjh+nvjcILI2M5xzMBMEFmXyiN6fa7BIyh8acgYCRKBRnlo=
Received: from SA9PR03CA0022.namprd03.prod.outlook.com (2603:10b6:806:20::27)
 by PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 08:43:39 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:20:cafe::dd) by SA9PR03CA0022.outlook.office365.com
 (2603:10b6:806:20::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Tue,
 25 Feb 2025 08:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 08:43:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 02:43:37 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 02:43:37 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 25 Feb 2025 02:43:30 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH V4 3/3] drm/amdgpu/sdma_v4_4_2: update VM flush implementation
 for SDMA
Date: Tue, 25 Feb 2025 16:43:15 +0800
Message-ID: <20250225084315.40087-3-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250225084315.40087-1-jesse.zhang@amd.com>
References: <20250225084315.40087-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: b3564e56-2780-4e90-8c57-08dd55787fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jcu5IwZU8Q6M4mWMV9Tqi5hCBCwKHwiEgHXbu6AvwZBmSKsXLCj+5VmEigXG?=
 =?us-ascii?Q?MuhFqYe0Ks7Il5F/PIK31c+zeIn9o/nuk9Cjy41f0AS2eCFUe6FEnE47DiGV?=
 =?us-ascii?Q?QHLblD55VQ3ne27mxgOzQjVaWjxDU2lKc0RJGlgwf6ZVVYL84OqxRhV5VuNL?=
 =?us-ascii?Q?GKk+ExkubjKtX1YrpKKbcV/Lyq4cZjVhGfP0jsb9BjW6yfC40luTK47tn+j+?=
 =?us-ascii?Q?3yVTgttFniYDzn6MvT6ae6pFYcr0aye5Uk/NcLirWVWaKqzrdz+Phw7NoNOW?=
 =?us-ascii?Q?3GRO+4VAjMbB78GbRB0YTz6UUAzU5IPaReEj3MYtT0elaae7jGP5+ObtNpoP?=
 =?us-ascii?Q?/tFmm0EtCMs0Y4ILmUQWWlM33T4iquxaf1WrJbjDnmyorjMA+df5cJG0s+Cn?=
 =?us-ascii?Q?5UtaNd6ACqtj6RWJeC4U+mNSgJQQ/waf3l0eY+sE3R1kGDK+4zVYilJyuwAB?=
 =?us-ascii?Q?mcK7v7abmJBQvuVYkhGAVWQmC9KgBYQ0wlFEZb2kH4CrHXeot+ugG8RBxQvk?=
 =?us-ascii?Q?glrFT45PmEQ7V4Tnr+QORgHTx/nCKdd71xUDxfRULFpNCWtBAh1Wn6eueE1S?=
 =?us-ascii?Q?4eadr9s+7DVN0YRoZzvr3nnCR+lxba+My++JRvmtCckEFd/G9g5oQdFlPzOJ?=
 =?us-ascii?Q?G9owaNf8QXs36YDrElTTWob6+Vw+d6vkd3zuQxWvoB7fcLU0+c724EmnoAyv?=
 =?us-ascii?Q?LAjlP4/i2YzyZbv8VLJ51ARqYxFplwtZBzc419Ek3RgKiH+SIgt0SLu9a/7T?=
 =?us-ascii?Q?v6RGSQSJXZDEfxHahXDHVE+dSpgBtDFA1FvzW7sbUaZ3ZnWGtsC0INobsheW?=
 =?us-ascii?Q?/tS9cm7HrZSMbV7FjuogEhk0rfpOtwBW3XfpAffcLOse1uz+dWkuw9Am/OZw?=
 =?us-ascii?Q?cWja3Sjze/gA5VPJHWDftOt4bR2taFMQ3cwcTgaGNSbFQXDS5dyXT5ZiiBgM?=
 =?us-ascii?Q?mBmHzMsO6j5m1ErdOU83aFCV1jPN7G4tcUcXmo4/SN7wdjyanXeR0aVT3W8E?=
 =?us-ascii?Q?H8QUQl3BiWg/NQtWYrgzroC30QeWY1MLBdO3dCGslouUGOG+HS6VnfPfW9aM?=
 =?us-ascii?Q?aUeVdf26m/plRrJqZHV0dnLzPQ9RKHI8iSCCUXP+F8dviwHhTLVXVBx6ZaPo?=
 =?us-ascii?Q?JSnzDL28IU0NWV5fIlPmvFMkGj/RhPiGKL1+fCvixawpPrxdy2eaR0FgkPuS?=
 =?us-ascii?Q?U+q9toAXMZsPAriDCplDPt+0HLxLlWEAn0oQWjlKqWykjacIyy09tRe5Rr7p?=
 =?us-ascii?Q?+UUc9E4kEajXvWOMnF3+dyPylkpyaI9L/JG2i5Jehs8NaGeh8NRSwgDkRNKX?=
 =?us-ascii?Q?A5TwvSZQMXFbi6LAmF6QtqjGMRZEt7RtjbT0IOURFz5Rb37UEVl+f4bxh6nu?=
 =?us-ascii?Q?vdDOLwpJCC1E1E1zYzbSbIYDnZa94+eT7KUmabdnPyzbuh9B/bKfo0r1Hud7?=
 =?us-ascii?Q?y7wOAA0Ez5skdRQvzUbfMmmP7MXA0fXSExMxHSFqjzn7Nr2fCLfdU89N4msC?=
 =?us-ascii?Q?Bhj/F+ihxVM0ajM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 08:43:38.3564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3564e56-2780-4e90-8c57-08dd55787fc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This commit updates the VM flush implementation for the SDMA engine.

- Added a new function `sdma_v4_4_2_get_invalidate_req` to construct the VM_INVALIDATE_ENG0_REQ
  register value for the specified VMID and flush type. This function ensures that all relevant
  page table cache levels (L1 PTEs, L2 PTEs, and L2 PDEs) are invalidated.

- Modified the `sdma_v4_4_2_ring_emit_vm_flush` function to use the new `sdma_v4_4_2_get_invalidate_req`
  function. The updated function emits the necessary register writes and waits to perform a VM flush
  for the specified VMID. It updates the PTB address registers and issues a VM invalidation request
  using the specified VM invalidation engine.

- Included the necessary header file `gc/gc_9_0_sh_mask.h` to provide access to the required register
  definitions.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 66 ++++++++++++++++++++----
 1 file changed, 57 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index ba43c8f46f45..f9cec50ce54e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -31,6 +31,7 @@
 #include "amdgpu_ucode.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_reset.h"
+#include "gc/gc_9_0_sh_mask.h"
 
 #include "sdma/sdma_4_4_2_offset.h"
 #include "sdma/sdma_4_4_2_sh_mask.h"
@@ -1292,21 +1293,68 @@ static void sdma_v4_4_2_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 			       seq, 0xffffffff, 4);
 }
 
-
-/**
- * sdma_v4_4_2_ring_emit_vm_flush - vm flush using sDMA
+/*
+ * sdma_v4_4_2_get_invalidate_req - Construct the VM_INVALIDATE_ENG0_REQ register value
+ * @vmid: The VMID to invalidate
+ * @flush_type: The type of flush (0 = legacy, 1 = lightweight, 2 = heavyweight)
  *
- * @ring: amdgpu_ring pointer
- * @vmid: vmid number to use
- * @pd_addr: address
+ * This function constructs the VM_INVALIDATE_ENG0_REQ register value for the specified VMID
+ * and flush type. It ensures that all relevant page table cache levels (L1 PTEs, L2 PTEs, and
+ * L2 PDEs) are invalidated.
+ */
+static uint32_t sdma_v4_4_2_get_invalidate_req(unsigned int vmid,
+					uint32_t flush_type)
+{
+	u32 req = 0;
+
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
+			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
+			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
+
+	return req;
+}
+
+/*
+ * sdma_v4_4_2_ring_emit_vm_flush - Emit VM flush commands for SDMA
+ * @ring: The SDMA ring
+ * @vmid: The VMID to flush
+ * @pd_addr: The page directory address
  *
- * Update the page table base and flush the VM TLB
- * using sDMA.
+ * This function emits the necessary register writes and waits to perform a VM flush for the
+ * specified VMID. It updates the PTB address registers and issues a VM invalidation request
+ * using the specified VM invalidation engine.
  */
 static void sdma_v4_4_2_ring_emit_vm_flush(struct amdgpu_ring *ring,
 					 unsigned vmid, uint64_t pd_addr)
 {
-	amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vmhub *hub = &adev->vmhub[ring->vm_hub];
+	uint32_t req = sdma_v4_4_2_get_invalidate_req(vmid, 0);
+	unsigned int eng = ring->vm_inv_eng;
+
+	/* Update the PTB address for the specified VMID */
+	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
+			      (hub->ctx_addr_distance * vmid),
+			      lower_32_bits(pd_addr));
+
+	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
+			      (hub->ctx_addr_distance * vmid),
+			      upper_32_bits(pd_addr));
+
+	/* Issue the VM invalidation request and wait for acknowledgment */
+	amdgpu_ring_emit_reg_write_reg_wait(ring, hub->vm_inv_eng0_req +
+					    hub->eng_distance * eng,
+					    hub->vm_inv_eng0_ack +
+					    hub->eng_distance * eng,
+					    req, 1 << vmid);
+
 }
 
 static void sdma_v4_4_2_ring_emit_wreg(struct amdgpu_ring *ring,
-- 
2.25.1

