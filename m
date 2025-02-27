Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654BCC021BE
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 11:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BC9B10E310;
	Thu, 27 Feb 2025 11:49:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kMLXLGGV";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6377C10E310
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 11:49:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6pl/0BWtB651vdCjb+wlD1+T5xBMzAQyRlni6lrStZegRqJauTX52KDNYY84zznX2aBIp+0NBH4HHxG9hHTL5Vutfq87RX/fzUSQBnKHnSFTMmHRFhgUp4v0+l+Ifmfqhyh1bqM/N+HK7NAl7JLuxlugxbXerkXwmPXqxnbtamRfAyR+6YOGNqarMxHkfUOgG9QagwF0gR8C06hK5wLXSQHnCUyqdzcVNIMVOizN5HVRyFzwaUGYtvlKsFL84zYUgVRF7XQCRpwYax+BLt3DHg7er/8eS2LVB80a+5hcbGhkb2NmnshrIXGhpHt2Um6nLPWxriCGFkuTXx/uhBmCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22/PqERg5rv3y5oCxeVGjLZl4clWJoF/v/OZBU9FXIs=;
 b=ciBHSztcdLx4U4lVxvule9q71ZS47RTS1/XwhimxFdjzESeDsr9R4/JQ8UCWw0nF9c5RmesJzPLWui6tNI5s3NOkl0rFudf7DnvxH22h3aakHXAITrvZrWIcBGxZDgna+lCUm1IKPzHGiWFYINj9PphAcSo9i6AAwCn6fuDTsXO4sbxz0Fvy5TP0jX57atoH+O1Bpyfgbbvd0rb2QD60+hrjzePCslbgydkYV57dNUxUUyw8kORChH+i4xjw/FKZ7vOWAe8e5k2oC68D2ew1+U7/8NdLaosPmDCtP/fBvt5JNdvGRb0y87/2R+RxUmXWRb0j9J8xuUkqM849zCFLOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22/PqERg5rv3y5oCxeVGjLZl4clWJoF/v/OZBU9FXIs=;
 b=kMLXLGGVzrDfufIOMeZP4T9VRPztWN0W1IK6ETL3THZ0vGanxrQBgEypQUlSNwtHcNTH9lpGspzAwVqCu/8B6y91ejbhTf9NP7EnazatEM4qgJVqvzFptBEwI04fdcnDiwls2jkJlfEqw6CCS74WbfT3fH0P8Uniqkwq9+h2j1c=
Received: from CH0PR03CA0226.namprd03.prod.outlook.com (2603:10b6:610:e7::21)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 11:49:24 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::ee) by CH0PR03CA0226.outlook.office365.com
 (2603:10b6:610:e7::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Thu,
 27 Feb 2025 11:49:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 11:49:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Feb
 2025 05:48:40 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 27 Feb 2025 05:48:39 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/sdma_v4_4_2: update VM flush implementation
 for SDMA
Date: Thu, 27 Feb 2025 19:47:55 +0800
Message-ID: <20250227114755.444535-3-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250227114755.444535-1-jesse.zhang@amd.com>
References: <20250227114755.444535-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|MN2PR12MB4208:EE_
X-MS-Office365-Filtering-Correlation-Id: ec486248-3b3c-41f7-0352-08dd5724c7be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lPbzkWxYZev0JkNjV3Y90jB6A5uH1yMMyZr/yxP4QgnUmXo4sd4S13s0P8Ct?=
 =?us-ascii?Q?5B4tuZqBEtPAA2b1XywW1AqgfPDAM3v6ay6TJISS4D7aE38wXnw7BjaR+l38?=
 =?us-ascii?Q?MW74ZAiUGDpUpC5yVwllsXovHiBswq7RC5ZfqOwY4c7cj11dsSuiPE1dzeso?=
 =?us-ascii?Q?VePgepI7ZENDXpBW9zpeFhduVwaHdb4DjTJvyKti5sKiioVWa/0EM36hGymz?=
 =?us-ascii?Q?PSHQGWSParHokmim0nkaFswuE+/luGkrDA1tTQJluO8haNOZ+MBfuLfWLdQY?=
 =?us-ascii?Q?WktjZ2s2WmYE1LZi1LUjjQBfv/y2sbnote5x1DySt/nQYcCSZ85Mlbx4izKD?=
 =?us-ascii?Q?KXIe4BLqNZlNHhYfLVr8mq/b0cf+idMf5SeA+ARYiKtuuy/xsMCbF0loYdbO?=
 =?us-ascii?Q?8WMVd01tqzl9Sdk7Tym7qgYlZVCHBcZpDO2biA7CuCM+RnpzYN8HK/hCdXDM?=
 =?us-ascii?Q?xQaBWyobqjb5MrW+xaixJFgbs+xkZmjN3TMoGhWjBfJj7mounBxP8wdE9eQj?=
 =?us-ascii?Q?fNqtHUCSBe1Wo4VwC7oiY0VBmSOjiOiNl7AVgT9lUgfJUvFT26wVvObird0t?=
 =?us-ascii?Q?Ynx22ysFZxERaK/7dVZHvOW6QrdLGD9fZIU6MaKZM+PLJ149orueLf5l7RsE?=
 =?us-ascii?Q?tCutTeYzxTqNzmUrt3EYv6/6LngmQymZcLq3JvI6yem2v2kmogHhH7wVuGGi?=
 =?us-ascii?Q?XGoNq0yM4c8Tluj8EC4nLlFE3+Dk/xno06lKBsJ5KavM3eT13BTWY8NKpqMl?=
 =?us-ascii?Q?gOnyWI6K/V1by0PiHbIfSp5R+bTz+ts39BFW2IwNEcRMpu0QBJatMNoYCcZ1?=
 =?us-ascii?Q?8FN7jhioe/AmqDubU+0lT8BXSCV/atwUYxh+qYOmKXxNeVmcVBrHVQOyYMSJ?=
 =?us-ascii?Q?OrRUHXG0Fp8XAgh4f6RC5bMiM9gpwQoVQ2FV6BwP4t+jQaUu2u/oZgwQbvY2?=
 =?us-ascii?Q?W9ICprSHtTjNf36N7Rn4LlDcbxX1se6qLRpYSIpDbtSaC98t23qFqy+RyEVK?=
 =?us-ascii?Q?MYCnVRU4sk2zyGtVhcKTVR83+NPzyTdb22cJRNdQtHK6f+nLjcB1F4gZDxtp?=
 =?us-ascii?Q?1UkslhspZ49/ZBnmVDSPnXs2E72TvLnYk4ht8Cbed3SndpxU/MZqrrIU7+4t?=
 =?us-ascii?Q?tovqSAhmIZXIe3lH/s5Y38Flaq2MlLVdOLbAm5IoNN1G5PwplqIf8HjRMN2R?=
 =?us-ascii?Q?ry6EgUj2n5u/m7Eq6OmG04Co9hoUloQjiX6DkMxuYv3tLBwNtXR9ws8CdGaS?=
 =?us-ascii?Q?1hmmuBzlkNbR7t7nmfw08eeNc8LMR7xpm82dSzP37hLT6rnfsQushRLFfm2L?=
 =?us-ascii?Q?PWPdhqORqk/V7O2IGkg3URrmb8j1IC7gXKshUg3HwlPs3IkE1hFDuHI0Xbqa?=
 =?us-ascii?Q?/uw4MWjdlHsBesW8BvWxOco1kWZ0FWinhR5G9FeVojYp8NdAGvoh2jECP4/s?=
 =?us-ascii?Q?eZ48y0tF3Vd0rVoCu/mcwxqkiHeCJHjv3/spPw9W5a6KGGAbqYR/e+rVpEEg?=
 =?us-ascii?Q?/cad48czAoa/bUs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 11:49:23.7255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec486248-3b3c-41f7-0352-08dd5724c7be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
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

v2: vm flush by the vm inalidation packet (Lijo)

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 81 ++++++++++++++++++++----
 1 file changed, 67 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index ba43c8f46f45..a9e46a4ed7a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -31,6 +31,7 @@
 #include "amdgpu_ucode.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_reset.h"
+#include "gc/gc_9_0_sh_mask.h"
 
 #include "sdma/sdma_4_4_2_offset.h"
 #include "sdma/sdma_4_4_2_sh_mask.h"
@@ -1292,21 +1293,75 @@ static void sdma_v4_4_2_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
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
+/* The vm validate packet is only available for GC9.4.3/GC9.4.4/GC9.5.0 */
+#define SDMA_OP_VM_INVALIDATE 0x8
+#define SDMA_SUBOP_VM_INVALIDATE 0x4
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
-					 unsigned vmid, uint64_t pd_addr)
+					    unsigned int vmid, uint64_t pd_addr)
 {
-	amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t req = sdma_v4_4_2_get_invalidate_req(vmid, 0);
+	unsigned int eng = ring->vm_inv_eng;
+	struct amdgpu_vmhub *hub = &adev->vmhub[ring->vm_hub];
+
+	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
+                              (hub->ctx_addr_distance * vmid),
+                              lower_32_bits(pd_addr));
+
+        amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
+                              (hub->ctx_addr_distance * vmid),
+                              upper_32_bits(pd_addr));
+	/*
+	 * Construct and emit the VM invalidation packet:
+	 * DW0: OP, Sub OP, Engine IDs (XCC0, XCC1, MMHUB)
+	 * DW1: Invalidation request
+	 * DW2: Lower 32 bits of page directory address
+	 * DW3: Upper 32 bits of page directory address and INVALIDATEACK
+	 */
+	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_VM_INVALIDATE) |
+			       SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_VM_INVALIDATE) |
+				(0x1f << 16) | (0x1f << 21) | (eng << 26));
+	amdgpu_ring_write(ring, req);
+	amdgpu_ring_write(ring, 0x0);
+	amdgpu_ring_write(ring, (0x1 << vmid));
 }
 
 static void sdma_v4_4_2_ring_emit_wreg(struct amdgpu_ring *ring,
@@ -2112,8 +2167,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 		3 + /* hdp invalidate */
 		6 + /* sdma_v4_4_2_ring_emit_pipeline_sync */
 		/* sdma_v4_4_2_ring_emit_vm_flush */
-		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
-		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 6 +
+		4 + 2 * 3 +
 		10 + 10 + 10, /* sdma_v4_4_2_ring_emit_fence x3 for user fence, vm fence */
 	.emit_ib_size = 7 + 6, /* sdma_v4_4_2_ring_emit_ib */
 	.emit_ib = sdma_v4_4_2_ring_emit_ib,
@@ -2145,8 +2199,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
 		3 + /* hdp invalidate */
 		6 + /* sdma_v4_4_2_ring_emit_pipeline_sync */
 		/* sdma_v4_4_2_ring_emit_vm_flush */
-		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
-		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 6 +
+		4 + 2 * 3 +
 		10 + 10 + 10, /* sdma_v4_4_2_ring_emit_fence x3 for user fence, vm fence */
 	.emit_ib_size = 7 + 6, /* sdma_v4_4_2_ring_emit_ib */
 	.emit_ib = sdma_v4_4_2_ring_emit_ib,
-- 
2.25.1

