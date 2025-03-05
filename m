Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0985CC19F32
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 03:25:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A89FB10E6C7;
	Wed,  5 Mar 2025 03:25:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2qsXFbKg";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF5EE10E6C7
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 03:25:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+6r0gbf3wKNpBmka/CwgEPPz+lBhwJkCuVCk6jcYYAeB6VQVzvWJwaDoYSwEpq0EbCbaGFp8h2LLHfpn2sGSvSv6QObXT9Fmh9+ptTC6tiaLVklQEMWESzD8W2y+whWrWDXC2QtgVawryrNpT4BwbDFh9wVKOxuKBbj9VIwEBJE9YZ1XiH190p1lhc1plKxjKItjWie/Rim3L8eR8TLmxydg2ucnO3itlnO25zLeGGjf+3dMhp1naEcbIyJenFImBRNoMMemkqmhN9m9sLO5IjpUD5vfqW/BmRCyNLVFDqcK9C+oHNn/GRYqkXm2TTXtY+R9hLN5bkAUVViSdBw/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4K77wjSICvEQAUvbOfy1fa+PBWYL1ZzmuSp4O13Z1Ag=;
 b=KG09HUouJ+x1jCYKdzL7rT8MdUD11LBt6Wvn5+19LTzlODgFDR4CD0TmWdA02QDLmWt4d99O2WcZr2m15ioBexGx4otrnjGmpnBb7rJIybtA8iAFu8jgZtXeWWiu45Zl5uKurqcN9uoeyJ1RMtyNyp2vu4HOGIUJpUjTJjaruAKlRCn1UXLqKlCL1EhjPxwZ1Y24Jr5uZtR7n8JXN9iAy3RDusvkADhYKO0W6/S3nMRG920bguU6VVz4Er23TdwT0io+1REPKvFErPfGdk6IIF/ACI+GCERLx/uCjxo6/5enjvjfeCRF6up7xRKS4klyf9ToOWGNlF/gGtUgZ13GGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4K77wjSICvEQAUvbOfy1fa+PBWYL1ZzmuSp4O13Z1Ag=;
 b=2qsXFbKgkY4+3Pq1ARhDyJDdZw7URH6ZY9myaK5cMMi1CnrilHXJHrpddS7xdQnbYxd0qEKv7cSqnJ7Dp+wt9ImjQNNclMoBhBXZHG+G2vHBsTZCcbQ23slXcRO/K+6P9jWC2kUaopXf2uOUJfqJUYzukq1UIaX/OBT1uZzILoA=
Received: from SJ0PR13CA0221.namprd13.prod.outlook.com (2603:10b6:a03:2c1::16)
 by DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 03:25:44 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::d4) by SJ0PR13CA0221.outlook.office365.com
 (2603:10b6:a03:2c1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15 via Frontend Transport; Wed,
 5 Mar 2025 03:25:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 03:25:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 21:25:42 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 21:25:42 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 4 Mar 2025 21:25:35 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, <jiadong.zhu@amd.com>,
 "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH V7 3/3] drm/amdgpu/sdma_v4_4_2: update VM flush implementation
 for SDMA
Date: Wed, 5 Mar 2025 11:25:20 +0800
Message-ID: <20250305032520.1745117-3-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305032520.1745117-1-jesse.zhang@amd.com>
References: <20250305032520.1745117-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|DM4PR12MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: 259085f9-7deb-4045-e0dc-08dd5b9569ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sZz6vVZrY/AoOK2gIBMdHnGSBg1X1XoTgIEyh0a6uIXZkfb1jHdneFkDvms5?=
 =?us-ascii?Q?7UR23Gn7ddIZswI9m0cb62o/2VJjZT1oa2j31gJhZd849u1ZEkO+zOKASE7s?=
 =?us-ascii?Q?3SguNvnbg33CAAOOSwlQ7Xh2D74CYAWYKG0qPUS6M/ccqqGgkcRc+QL/vPOr?=
 =?us-ascii?Q?aAcHMa2OUcp9ShiY5Npff+sfU/uNwhpA+x72zy0pSAol5NagObfCA5Kq7r9T?=
 =?us-ascii?Q?1DmUzLUSreSXx+XtWQTuva08cpyHO3l+L9U1hTPQxp1vD9q0sR/McSzgzWeK?=
 =?us-ascii?Q?/qzVJaAeoDl8MeQCwW5HB63H9ATt5j0Essf0y3thSLQtxPONBWAG3tXFa4qe?=
 =?us-ascii?Q?0chMVMWdJBtEt/yOJOgngomDX25MFZXzusV9lFTdQbShnZZFNtWF+qe5UpUy?=
 =?us-ascii?Q?JD+4c06FqwSTN11VjRrbtod2aNOkoe6MoA1hfFqMxO10ScK1xXBUnRrLGH2X?=
 =?us-ascii?Q?0MJafChHnfBlcJ5mGi/kZPcwXSSDSdoCImjc+apa/7HLn1z+f0qLJhc1xk1Y?=
 =?us-ascii?Q?Mjo1Douj4R10ynVQ3iWTHTAwjFn+I8rWU7jkIi0s4NJJkZh6C3hzDCtxBUDl?=
 =?us-ascii?Q?xodVnlzG6dCJBGCJBAIw4iXdhhr6oqO5EyIvRzjJyEYjEO0VayCOmOc0y9+/?=
 =?us-ascii?Q?DVLcOftdtYNnmSOQ16K90BtIeePn/vu0J93M0v0FO/wt3md1wWCQc+aZJ6Cu?=
 =?us-ascii?Q?GyRysG8pf8l3YwtqG2H+lg1uoBIZKlH+JFDRBsr6SSKr8KxmpSgiFd+3Y3xK?=
 =?us-ascii?Q?o2FxynsyMtOwWsTiwzvCJGJ+t56azB6coXGPX/Yp4KkvriL/L55cdasVZ8T4?=
 =?us-ascii?Q?hQ10Q/PXV+cAuRGGThPv7xdLbgZwWIldfub5bIzBjTnVxg+C0tlA9SLThKeR?=
 =?us-ascii?Q?1HOWKYxvnISnJaCc+Mbi4OeahDn3SugTDQQ+fLT8BDyHhf1gELMYU7pxW2eh?=
 =?us-ascii?Q?zxNGnYLigliwXpR6612Jn1Xf/Wu128Ccfh6qCfTAvwfnk5tIBIJpLU9Al7mT?=
 =?us-ascii?Q?/Hxdf42C6F9e5bTt0AaSc7KnN52GyN4E789Y9VzHSelktpuSV3PFUhywoRNl?=
 =?us-ascii?Q?ONYCL3O0DM5cHQkv/TJqYi8klNXkJc33V6uvG3fTO10mxEqn1Lr90eZMKXQH?=
 =?us-ascii?Q?ZSOnujBnEgyVjD3ImyFgq203crY1jx8xOdQasTuI6LmX8qrlkQjF50X8wFmr?=
 =?us-ascii?Q?s2OQgScxRUtnWdv3PbmSRP0eN3V+zdGi2vvZcBzhouSIkM4CGjYXo6d03vHy?=
 =?us-ascii?Q?uphjlIMh67RFoH38m7+5e2hPUaKME4Dp3r2Xea4mLW2o6VaMKX2qHu40FvUv?=
 =?us-ascii?Q?J9JAZaIwTh1ej0BmVUayS/bRCDCqvN9bbhiuWG0cenSb1nJ6h4rlbYQ8y6qW?=
 =?us-ascii?Q?mLTubeP4qnpogrYUrzJzWx2UVY5etr8r2jVbknwv2f5K/NAkpliChVFzP7uH?=
 =?us-ascii?Q?ofVbdTdJAO9h8a0Dw0z5xzaizRwN8Ge7IwhEQKZQQKZxbjDiKMbmGOpIgf3U?=
 =?us-ascii?Q?kyjqLf9UylEduP0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 03:25:43.8180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 259085f9-7deb-4045-e0dc-08dd5b9569ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8476
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

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      | 77 +++++++++++++++----
 .../gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h | 55 +++++++++++++
 2 files changed, 118 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index fd34dc138081..554e14b56c31 100644
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
+	amdgpu_ring_write(ring, VM_INVALIDATE_REQ_INVALIDATEREQ(req));
+	amdgpu_ring_write(ring, 0);
+	amdgpu_ring_write(ring, VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK(BIT(vmid)));
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
index 8de4ccce5e38..d3a72ffac04b 100644
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
@@ -3331,5 +3334,57 @@
 #define SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_completion_signal_63_32_shift  0
 #define SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_COMPLETION_SIGNAL_63_32(x) (((x) & SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_completion_signal_63_32_mask) << SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_completion_signal_63_32_shift)
 
+/*
+** Definitions for SDMA_VM_INVALIDATION packet
+*/
+
+/* Define for HEADER word (DW0) */
+#define SDMA_PKT_VM_INVALIDATE_HEADER_OP_OFFSET 0
+#define SDMA_PKT_VM_INVALIDATE_HEADER_OP_MASK 0x000000FF
+#define SDMA_PKT_VM_INVALIDATE_HEADER_OP_SHIFT 0
+#define SDMA_PKT_VM_INVALIDATE_HEADER_OP(x) (((x) & SDMA_PKT_VM_INVALIDATE_HEADER_OP_MASK) << SDMA_PKT_VM_INVALIDATE_HEADER_OP_SHIFT)
+
+#define SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP_OFFSET 8
+#define SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP_MASK 0x000000FF
+#define SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP_SHIFT 8
+#define SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP(x) (((x) & SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP_MASK) << SDMA_PKT_VM_INVALIDATE_HEADER_SUB_OP_SHIFT)
+
+#define SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID_OFFSET 16
+#define SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID_MASK 0x0000001F
+#define SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID_SHIFT 16
+#define SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID(x) (((x) & SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID_MASK) << SDMA_PKT_VM_INVALIDATE_HEADER_XCC0_ENGINE_ID_SHIFT)
+
+#define SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID_OFFSET 21
+#define SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID_MASK 0x0000003E
+#define SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID_SHIFT 21
+#define SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID(x) (((x) & SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID_MASK) << SDMA_PKT_VM_INVALIDATE_HEADER_XCC1_ENGINE_ID_SHIFT)
+
+#define SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID_OFFSET 26
+#define SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID_MASK 0x0000007C
+#define SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID_SHIFT 26
+#define SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID(x) (((x) & SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID_MASK) << SDMA_PKT_VM_INVALIDATE_HEADER_MMHUB_ENGINE_ID_SHIFT)
+
+/* Define for INVALIDATEREQ word (DW1) */
+#define VM_INVALIDATE_REQ_INVALIDATEREQ_OFFSET 0
+#define VM_INVALIDATE_REQ_INVALIDATEREQ_MASK 0xFFFFFFFF
+#define VM_INVALIDATE_REQ_INVALIDATEREQ_SHIFT 0
+#define VM_INVALIDATE_REQ_INVALIDATEREQ(x) (((x) & VM_INVALIDATE_REQ_INVALIDATEREQ_MASK) << VM_INVALIDATE_REQ_INVALIDATEREQ_SHIFT)
+
+/* Define for ADDRESSRANGELO word (DW2) */
+#define VM_INVALIDATE_ADDR_RANGE_LO_ADDRESSRANGELO_OFFSET 0
+#define VM_INVALIDATE_ADDR_RANGE_LO_ADDRESSRANGELO_MASK 0xFFFFFFFF
+#define VM_INVALIDATE_ADDR_RANGE_LO_ADDRESSRANGELO_SHIFT 0
+#define VM_INVALIDATE_ADDR_RANGE_LO_ADDRESSRANGELO(x) (((x) & VM_INVALIDATE_ADDR_RANGE_LO_ADDRESSRANGELO_MASK) << VM_INVALIDATE_ADDR_RANGE_LO_ADDRESSRANGELO_SHIFT)
+
+/* Define for ADDRESSRANGEHI and INVALIDATEACK word (DW3) */
+#define VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK_OFFSET 0
+#define VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK_MASK 0x0000FFFF
+#define VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK_SHIFT 0
+#define VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK(x) (((x) & VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK_MASK) << VM_INVALIDATE_ADDR_RANGE_HI_INVALIDATEACK_SHIFT)
+
+#define VM_INVALIDATE_ADDR_RANGE_HI_ADDRESSRANGEHI_OFFSET 16
+#define VM_INVALIDATE_ADDR_RANGE_HI_ADDRESSRANGEHI_MASK 0x0000001F
+#define VM_INVALIDATE_ADDR_RANGE_HI_ADDRESSRANGEHI_SHIFT 16
+#define VM_INVALIDATE_ADDR_RANGE_HI_ADDRESSRANGEHI(x) (((x) & VM_INVALIDATE_ADDR_RANGE_HI_ADDRESSRANGEHI_MASK) << VM_INVALIDATE_ADDR_RANGE_HI_ADDRESSRANGEHI_SHIFT)
 
 #endif /* __SDMA_PKT_OPEN_H_ */
-- 
2.25.1

