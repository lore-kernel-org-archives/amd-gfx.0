Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C176FC35FFB
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 05:08:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 649F610E245;
	Wed, 19 Mar 2025 05:08:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JYitQm3f";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E061710E245
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 05:07:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSJrdhBDCS29X0lIqmMK3OB6kuQG+aT21siijiyl3NGdECz1eXBYgiUyakV0f9KoMvQ93rzBwmlSV5+F5GxofmVxkm6lLAt0gAeUWi8rROuqOFBJ6svIAk4+bEIS6JJNNyCImab88XqKNOnn227KRxNjXomjzeQ5Vf1Bqiaik730ImNxCJATftdSN26lcWAu4Gi/rLnT4XTuZr3pKlUEUC8+FtVvzEYnAZil984+nbY4qhIivn3oaGJDts2NWZ7Is7ZJy68KxgHCBsH6mPxzN4GDV7iDYEv7XeLEmNxYg41yMufWvtAb4DLLcCW0M9DOiOFdEyX6JMH/k1b8+HWSXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZS5SueMwqjpG2QsIRnm81IcTUB21K55hJ3GNDFBi/k=;
 b=Ml7iQE9MlQfVI9x7S14plHnMCcoqAgSoy5qsyYY+H4Fwu6SBn0/EiQvyNXl0c0Ygau3d9M4snk0BZMQvCHzPfGGPqH3rhmw6s4/4/9x3n7wSYijh9/pKOEKoG1hvf5rfPb4Ylg9XHeMTHiVMhgUmXLzHEH0sX9ZpDlLgpv5fNp75i0c4zYqE2lDbmE1eCJZMg9X74wNjIhKm1jz8Ukud/+xYTdJwXrQ+a+mssLY8DXrH2F/VvQzsoPt/9VbPGiN7xFlbcygAt7wiFnVpor5yuGJIWMyYmrEIlCNSpwPm/lCfLLNxO9C+CwnGApgUY0dnV00eXz96jRLRCL1Rxo0x9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZS5SueMwqjpG2QsIRnm81IcTUB21K55hJ3GNDFBi/k=;
 b=JYitQm3fBDXDek2ekyOKz9pcCAQouUpZMP7D+l3V+XgiMHJ8fhEz1kLqjHxROQK30trVK4f9JnqehSuxOFNrVsKn6ayS6SLpk+irPzM4LLIPd58bC1GtKfngmIqeEoZPtVEiNTM5jsneF+nDfuMopBIqNfhuieSpFBRpJIEFWM8=
Received: from PH1PEPF000132E4.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::24)
 by IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 05:07:52 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2a01:111:f403:c801::1) by PH1PEPF000132E4.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 05:07:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 05:07:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 00:07:49 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 19 Mar 2025 00:07:42 -0500
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <lijo.lazar@amd.com>, "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, "Jesse
 Zhang" <jesse.zhang@amd.com>
Subject: [PATCH 3/3 V8] drm/amdgpu/sdma_v4_4_2: update VM flush implementation
 for SDMA
Date: Wed, 19 Mar 2025 13:07:27 +0800
Message-ID: <20250319050727.4099266-3-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250319050727.4099266-1-jesse.zhang@amd.com>
References: <20250319050727.4099266-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|IA1PR12MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: aa92548b-d5b7-465b-52f7-08dd66a3ffb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vVL1ahDegA5/txRqtzrNamGTOQMzIy1I/S34Jy7xHlOE9ACcj0PL6mf6ivj6?=
 =?us-ascii?Q?2rR3XVclCVkrBttQzySnLpmL5ZRtNBAX6PXvQAYhd71vWLdBPaWtfVsXemqx?=
 =?us-ascii?Q?MZssJRDSIsGpSfQAmkl7avxF2WfhI+Vw8OHVua5h6s3l41j+noeImYnZ/aqU?=
 =?us-ascii?Q?7UEMzQhU6G6TEiNPAiwTVHYJN4vTaB7M7fJFCtfYwSaTM3uE0j+wn2mQEceQ?=
 =?us-ascii?Q?nNF4NvtB+pIdUeM/zKUrM+DAaoxFhPpMwlXnr4den1/VVZo4oJfUhVKrMMSK?=
 =?us-ascii?Q?oZ6mREKXBo1k+6+iygsJS7ja08ygCjjNGDjK+MjYBfh4tbKsjf9TBxNAQdj0?=
 =?us-ascii?Q?Q9+d8ClPQxX2i1cAfFbLZiMlH+jCC/YjMKlYXI5lLmkXfSNbz3kwxgGb5+1v?=
 =?us-ascii?Q?rVWJt+z0JtF3hXBNOY8qA1mIe05m7AzhWJmOmYQZxIRKyjzH5HEN3yfgsvgh?=
 =?us-ascii?Q?Hp24DR+s5SQikyrS8pif/GXATGuXHGYQ1nnnqvL2NoOU2BqCPD5UIq7W/97W?=
 =?us-ascii?Q?hQ2iqX7mN8GAFiNmBjKdd/4qtWwrVa+L8mxtUGiX1vflE4wg4E7QPFGz9Vr/?=
 =?us-ascii?Q?gQa8Lroan4BBobjbHmvRlo+zPjDlOrvzoEanE7nTKsNP90rjIOJ2B3b9CWsk?=
 =?us-ascii?Q?bcGqogHCjnxGnfIddpyUhikvZXIUInHz56aUHZUiArmg49ScuXFeU9qGZ+ED?=
 =?us-ascii?Q?CoTQB07hRejpmwWNuXmebur2ckJ2I3bVb3I0FKty9MBZoptttgE3DCH2D4Pc?=
 =?us-ascii?Q?6SaGAXPzJNc3cRVuponie70mtFGRbXL/9Lzmidsz4oQQUwAV0OrRKzNFGVa3?=
 =?us-ascii?Q?30dAXC7PW8wAvqBKu4IxKz7uAYF06E+d3kAn7IMNlaUNkUuhKDUTwKe1TYDB?=
 =?us-ascii?Q?7kDpVzSXM5CJwbT921pxpk4oyMGcXVKaiduUQ8MdBuqRUiE/P5Ueu68wgKyI?=
 =?us-ascii?Q?9jmyRyo7Dsr9WNztU9nQrsn3yUccRQAzZTl9GScBCai5PyZuc3PFPGUIdSOy?=
 =?us-ascii?Q?3yN7gJtuUQ70HdhKuX9jlMEehoavDjnXuWDOaFSCPxVRCs9j9FyaVvwjy4gP?=
 =?us-ascii?Q?SXeFAyHNpvKOfw2BMf+H5cfjuc5UQ6FlQ8BTxid18ZAeC9ymMTB319sc7Eyy?=
 =?us-ascii?Q?qpGpkysanjopvaClpCI8h659ZFbPlXyzUm1/uCHzBuuSRiik5WtyoSvE76L4?=
 =?us-ascii?Q?ODpS4L4ppWBJfMYmIwM97eC48C3i9oKyCWpGYkdaInQgRsO5cjkEaIqX1mNz?=
 =?us-ascii?Q?7ZvBV/BBPlRCgRnSrLjdx5UxKJUaFN3eIavDkSagL9O5Ck5b2T32oEpLRQus?=
 =?us-ascii?Q?o9qmmy0rv8eDVrL+Mb1cj0jjYlShNmUeo+X7a6Q5nyI3L2tCh8aUd9WnFzfJ?=
 =?us-ascii?Q?PoGhadXAd7mSAJOQbzJSgGzYtG6i6/4ggvGGihNsQZd8Y7yfgHoyWa/MexJC?=
 =?us-ascii?Q?1AU0Y6oQP2icM5SCAtIOU2gPyKFvxkuv2GbI5CuZx8yrKDouK3kZoQm7QbTr?=
 =?us-ascii?Q?keJronX4b/05pEw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 05:07:51.1603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa92548b-d5b7-465b-52f7-08dd66a3ffb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520
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

v2: vm flush by the vm inalidation packet (Lijo)
v3: code stle and define thh macro for the vm invalidation packet (Christian)
v4: Format definition sdma vm invalidate packet (Lijo)

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      | 77 +++++++++++++++----
 .../gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h | 54 +++++++++++++
 2 files changed, 117 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index fd34dc138081..06ce0c98ef5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -31,6 +31,7 @@
 #include "amdgpu_ucode.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_reset.h"
+#include "gc/gc_9_0_sh_mask.h"
 
 #include "sdma/sdma_4_4_2_offset.h"
 #include "sdma/sdma_4_4_2_sh_mask.h"
@@ -1292,21 +1293,71 @@ static void sdma_v4_4_2_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
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
+	 * Construct and emit the VM invalidation packet
+	 */
+	amdgpu_ring_write(ring,
+		SDMA_PKT_VM_INVALIDATE_HEADER_OP(SDMA_OP_VM_INVALIDATE) |
+		SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP(SDMA_SUBOP_VM_INVALIDATE) |
+		SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID(0x1f) |
+		SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID(0x1f |
+		SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID(eng)));
+	amdgpu_ring_write(ring, VM_INVALIDATE_REQ_INVALIDATE(req));
+	amdgpu_ring_write(ring, 0);
+	amdgpu_ring_write(ring, VM_INVALIDATE_ADDR_RANGE_INVALIDATE_ACK(BIT(vmid)));
 }
 
 static void sdma_v4_4_2_ring_emit_wreg(struct amdgpu_ring *ring,
@@ -2115,8 +2166,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 		3 + /* hdp invalidate */
 		6 + /* sdma_v4_4_2_ring_emit_pipeline_sync */
 		/* sdma_v4_4_2_ring_emit_vm_flush */
-		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
-		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 6 +
+		4 + 2 * 3 +
 		10 + 10 + 10, /* sdma_v4_4_2_ring_emit_fence x3 for user fence, vm fence */
 	.emit_ib_size = 7 + 6, /* sdma_v4_4_2_ring_emit_ib */
 	.emit_ib = sdma_v4_4_2_ring_emit_ib,
@@ -2148,8 +2198,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
 		3 + /* hdp invalidate */
 		6 + /* sdma_v4_4_2_ring_emit_pipeline_sync */
 		/* sdma_v4_4_2_ring_emit_vm_flush */
-		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
-		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 6 +
+		4 + 2 * 3 +
 		10 + 10 + 10, /* sdma_v4_4_2_ring_emit_fence x3 for user fence, vm fence */
 	.emit_ib_size = 7 + 6, /* sdma_v4_4_2_ring_emit_ib */
 	.emit_ib = sdma_v4_4_2_ring_emit_ib,
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h b/drivers/gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h
index 8de4ccce5e38..2da2e2443c87 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h
@@ -64,6 +64,9 @@
 #define HEADER_BARRIER  5
 #define SDMA_OP_AQL_COPY  0
 #define SDMA_OP_AQL_BARRIER_OR  0
+/* vm invalidation is only available for GC9.4.3/GC9.4.4/GC9.5.0 */
+#define SDMA_OP_VM_INVALIDATE 8
+#define SDMA_SUBOP_VM_INVALIDATE 4
 
 /*define for op field*/
 #define SDMA_PKT_HEADER_op_offset 0
@@ -3331,5 +3334,56 @@
 #define SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_completion_signal_63_32_shift  0
 #define SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_COMPLETION_SIGNAL_63_32(x) (((x) & SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_completion_signal_63_32_mask) << SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_completion_signal_63_32_shift)
 
+/*
+** Definitions for SDMA_VM_INVALIDATION packet
+*/
 
+/* Define for HEADER word (DW0) */
+#define SDMA_PKT_VM_INVALIDATE_HEADER_op_offset 0
+#define SDMA_PKT_VM_INVALIDATE_HEADER_op_mask 0x000000FF
+#define SDMA_PKT_VM_INVALIDATE_HEADER_op_shift 0
+#define SDMA_PKT_VM_INVALIDATE_HEADER_OP(x) (((x) & SDMA_PKT_VM_INVALIDATE_HEADER_op_mask) << SDMA_PKT_VM_INVALIDATE_HEADER_op_shift)
+
+#define SDMA_PKT_VM_INVALIDATE_HEADER_SUB_op_offset 8
+#define SDMA_PKT_VM_INVALIDATE_HEADER_SUB_op_mask 0x000000FF
+#define SDMA_PKT_VM_INVALIDATE_HEADER_SUB_op_shift 8
+#define SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP(x) (((x) & SDMA_PKT_VM_INVALIDATE_HEADER_SUB_op_mask) << SDMA_PKT_VM_INVALIDATE_HEADER_SUB_op_shift)
+
+#define SDMA_PKT_VM_INVALIDATE_HEADER_xcc0_engine_id_offset 16
+#define SDMA_PKT_VM_INVALIDATE_HEADER_xcc0_engine_id_mask 0x0000001F
+#define SDMA_PKT_VM_INVALIDATE_HEADER_xcc0_engine_id_shift 16
+#define SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID(x) (((x) & SDMA_PKT_VM_INVALIDATE_HEADER_xcc0_engine_id_mask) << SDMA_PKT_VM_INVALIDATE_HEADER_xcc0_engine_id_shift)
+
+#define SDMA_PKT_VM_INVALIDATE_HEADER_xcc1_engine_id_offset 21
+#define SDMA_PKT_VM_INVALIDATE_HEADER_xcc1_engine_id_mask 0x0000003E
+#define SDMA_PKT_VM_INVALIDATE_HEADER_xcc1_engine_id_shift 21
+#define SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID(x) (((x) & SDMA_PKT_VM_INVALIDATE_HEADER_xcc1_engine_id_mask) << SDMA_PKT_VM_INVALIDATE_HEADER_xcc1_engine_id_shift)
+
+#define SDMA_PKT_VM_INVALIDATE_HEADER_mmhub_engine_id_offset 26
+#define SDMA_PKT_VM_INVALIDATE_HEADER_mmhub_engine_id_mask 0x0000007C
+#define SDMA_PKT_VM_INVALIDATE_HEADER_mmhub_engine_id_shift 26
+#define SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID(x) (((x) & SDMA_PKT_VM_INVALIDATE_HEADER_mmhub_engine_id_mask) << SDMA_PKT_VM_INVALIDATE_HEADER_mmhub_engine_id_shift)
+
+/* Define for INVALIDATEREQ word (DW1) */
+#define VM_INVALIDATE_req_invalidate_offset 0
+#define VM_INVALIDATE_req_invalidate_mask 0xFFFFFFFF
+#define VM_INVALIDATE_req_invalidate_shift 0
+#define VM_INVALIDATE_REQ_INVALIDATE(x) (((x) & VM_INVALIDATE_req_invalidate_mask) << VM_INVALIDATE_req_invalidate_shift)
+
+/* Define for ADDRESSRANGELO word (DW2) */
+#define VM_INVALIDATE_ADDR_RANGE_LO_addr_31_0_offset 0
+#define VM_INVALIDATE_ADDR_RANGE_LO_addr_31_0_mask 0xFFFFFFFF
+#define VM_INVALIDATE_ADDR_RANGE_LO_addr_31_0_shift 0
+#define VM_INVALIDATE_ADDR_RANGE_LO_ADDR_31_0(x) (((x) & VM_INVALIDATE_ADDR_RANGE_LO_addr_31_0_mask) << VM_INVALIDATE_ADDR_RANGE_LO_addr_31_0_shift)
+
+#define VM_INVALIDATE_ADDR_RANGE_HI_addr_64_32_offset 16
+#define VM_INVALIDATE_ADDR_RANGE_HI_addr_64_32_mask 0x0000001F
+#define VM_INVALIDATE_ADDR_RANGE_HI_addr_64_32_shift 16
+#define VM_INVALIDATE_ADDR_RANGE_HI_ADDR_64_32(x) (((x) & VM_INVALIDATE_ADDR_RANGE_HI_addr_64_32_mask) << VM_INVALIDATE_ADDR_RANGE_HI_addr_64_32_shift)
+
+/* Define for ADDRESSRANGEHI and INVALIDATEACK word (DW3) */
+#define VM_INVALIDATE_ADDR_RANGE_invalidate_ack_offset 0
+#define VM_INVALIDATE_ADDR_RANGE_invalidate_ack_mask 0x0000FFFF
+#define VM_INVALIDATE_ADDR_RANGE_invalidate_ack_shift 0
+#define VM_INVALIDATE_ADDR_RANGE_INVALIDATE_ACK(x) (((x) & VM_INVALIDATE_ADDR_RANGE_invalidate_ack_mask) << VM_INVALIDATE_ADDR_RANGE_invalidate_ack_shift)
 #endif /* __SDMA_PKT_OPEN_H_ */
-- 
2.25.1

