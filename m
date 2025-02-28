Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696DFC19776
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 10:28:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FC3610EC5B;
	Fri, 28 Feb 2025 10:28:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4NIeODx8";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83CD010EC5B
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 10:28:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ToKKN21fzhhReknNurNSiQatlVromr9NzBOaWfDkkLGV90/Y0GZSGWA07TnZLE3qAEbMyZAGfpqSldjsZ1SRVBo+UXJdE53PZ41nYjxgrtWrpElUsRSfAuv4CQjQSy0CKtzz5Y3ZiL5j4zSlVhHqMYmXaW7vzrDAGLAKNM97nDPYIT8AYvMNjxNNRmMa0mFneEmPRDRU/M4doOw7DHSqDKENidxDKWFdPGn3R0qltmMYIFfr0i9yXS/NeiyiZfnLF/GpM3g4rhFFW4MgLa+rDw+eGghXDisevvVYqfssXfbwFAUwRZdjUcmbGzoSUzD60kOpip5hU3GTagYIFceIVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4K77wjSICvEQAUvbOfy1fa+PBWYL1ZzmuSp4O13Z1Ag=;
 b=eWChgJukblzZtdfj6JVKsTOtGb2U5ipdWDIkjg6FvbpHD4y5wQ1NtS2YkgT/rX39xXIzG245nmixZWquCja9wDb2VLNsqFvJi4pA6/7ZNOhYK+qAy39mv4XR433AlN2C7DjRPFM+iFguk4zb4SfRSCgXi8yuYPV7dYBsJJ7xyzZh4YS/wYjgJ0+Lx7WwcR3bDSmLAs54fJ2hsqKvAyzpkBCY0DLNV9r0/VSx02R1oo1U+h2XJURaX5zvNe/QtpE6DzS02QXOa3boGZcN6la8d6odFzR3rvo68OBlHEjM4dSU9jRRnqtKjNFrN3gGB1GT9GphIJ7bxi3XAIGov2NQUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4K77wjSICvEQAUvbOfy1fa+PBWYL1ZzmuSp4O13Z1Ag=;
 b=4NIeODx8sqQ2vn8RzoZs7tvUzn+SI+z9qBZqi6KUL+K2dBJd21/4XWSygRm3q2SrZ49OEDoG41JRV8ag2fgQlaZ+1hu9tivyNkfuiZzW2seHsJ7twri6IJhc7UnpKNGu3oCvkZV0FCxCuhPeCOfMiYzyMusN2loMJAd1EFHzbU4=
Received: from BL1PR13CA0238.namprd13.prod.outlook.com (2603:10b6:208:2bf::33)
 by CH3PR12MB9028.namprd12.prod.outlook.com (2603:10b6:610:123::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.24; Fri, 28 Feb
 2025 10:28:01 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::7b) by BL1PR13CA0238.outlook.office365.com
 (2603:10b6:208:2bf::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.10 via Frontend Transport; Fri,
 28 Feb 2025 10:28:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 10:27:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 04:27:56 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 04:27:46 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 28 Feb 2025 04:27:40 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/sdma_v4_4_2: update VM flush implementation
 for SDMA
Date: Fri, 28 Feb 2025 18:27:11 +0800
Message-ID: <20250228102711.832036-3-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250228102711.832036-1-jesse.zhang@amd.com>
References: <20250228102711.832036-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|CH3PR12MB9028:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd07e48-cf30-4560-d47e-08dd57e292d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zbzpcP+F1+D+sHWQaOYmsE1JlAJO26W3QRVs+MGdz/0QIMGOoZvWBuxWpDpc?=
 =?us-ascii?Q?c27pDsi9IlMEFt1an+wB3LJ8wxP3UzvCdDp4A/PxfuXrKPWwJT28qhEkLkrx?=
 =?us-ascii?Q?qdMFbz40Jtq3V+qMUsMMmYgHWRt9VctZXXPY95vMBqRomw0vpNWw1ooE+dvt?=
 =?us-ascii?Q?YvBsTIUX+zwDSltE+0sIWHkV/Bydx5CF/doZ+TuCowmVRAZ2OhAlKDoKzNYj?=
 =?us-ascii?Q?HOy2IcpFqt8z4n3PlfngQeNehnPcERFbnLsiMHu1/qfuebtkq6g+6+0jRS73?=
 =?us-ascii?Q?Yt8NfW1O14xpHHP7WX8C9twkorzS4sTcagJs+pBBV9ytxIJUnkx6TnMDrs4g?=
 =?us-ascii?Q?0z6VznDilpusDAtXLIg0G+4chvhxUrMKKcy19+8Wd6qMfwnyKGA/7FVIBQDL?=
 =?us-ascii?Q?ZAqIMJ12nsX1+713pTudQtJXS5j+PS4nkx4tH8j7FA19KPpCfbJAXMcEAtc5?=
 =?us-ascii?Q?+cV6SzD0RB4IifdtZ5sVKmjNHsFaEely55TOICSDmavCltgyft1UB2hOzLt4?=
 =?us-ascii?Q?g+F5H7ug7tSEYYMjmwfDTZnusLvqznDVZ/6PbxYRdKlKHdV/7YKsBOyZBeWH?=
 =?us-ascii?Q?JLPNzC/3Y7XB45xZ1D/oq+zLftkDVstTn4xNfDd2xc/REckbtzdCyDFokuiR?=
 =?us-ascii?Q?fxJeismbuJhluyMitN5toAGs1lhzVh4oMw8WhVCK4xc9n7bzmypL0tNAqYvU?=
 =?us-ascii?Q?y+Skp57p8YoL7VpoEeZ5Fq0jlaLNTXcaR0fsb753S1+XcRapiHDsBqm9NLpP?=
 =?us-ascii?Q?JM1wAwZUWhWLI24XAhCAq4TjnRlcFILcZcDxm7/LdO1AdeD6xpzguuoEl0/c?=
 =?us-ascii?Q?Vh5GbayhgnVJqR5eKNOfNvum8fQqGmrer5tSBe+rOMwwYmiRhkgOMPpXtv3R?=
 =?us-ascii?Q?Sxwth4TZ+xT5fz8SWiISbm2nxUevssKTJJTbgluDCnjZHUHxawM7kfy9L9Gb?=
 =?us-ascii?Q?FlqrD6uvGiy/q+cVx9qrAKBC6q3WczKWJLYv/5NMktOaMfzDQO9XpopktNxg?=
 =?us-ascii?Q?AZHb+SBkt/hUbPqVwlGr/1zeS7rxZkKCBx/G1qxEMMs6HZRB6K+1U/pGks1o?=
 =?us-ascii?Q?vmjUAoLZ0CTyU8/6VrgvksLAjardaT1aDXi/mCL0v5q7WczeR6RyiV1s7qQR?=
 =?us-ascii?Q?IwYWA6BYTccFEzKPYdiog8tFl6ONyLtRZt+EfD7rkh7YvO6eDrvvbyvjHsGb?=
 =?us-ascii?Q?vTfjQ7zKqnMUmL5+7htolpf4JDS6Tr2MBd0MdPSOTCSnjSw6dpRBHVTagA2g?=
 =?us-ascii?Q?nOgpWccLoH689HJxtG9A97aG7SxquZtLr1kR1fbp5YFk5WAi8WVj08A1OnRE?=
 =?us-ascii?Q?Yvm+URyruH6iNFi4fmR158CThFI6hBQBBfQhV7hWqOkEzeBYmLe/AYH22u7r?=
 =?us-ascii?Q?3iZYCtrSiFzBHqiz8LGy12aKcmlbqQ4OUEY5LAppntlXu9Hlse47KiS6d2qy?=
 =?us-ascii?Q?R1P6fEXF0eoTMSW+dDVQtgDUqML59JmvOFcjEwc0mj4Fi+gHukoWGKCjR75x?=
 =?us-ascii?Q?eEQJ5UVOnECmEC8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:27:59.3525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd07e48-cf30-4560-d47e-08dd57e292d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9028
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

