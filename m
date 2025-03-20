Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE26C28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 05:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 664C710E38C;
	Thu, 20 Mar 2025 05:14:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="21CQqSMM";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 773E710E38C
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 05:14:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwOF5BkELBhLarRNg4grW7vXeizhlN+O8FpVo91Kpa0+hzFlkSoAlr4Wi8vZ+/ewNNGxeze6+JovAKbQyPpg6kn3JSCMoVVPRn6YzECq3RFCQWgp0bylBlxMBrp5dKtfw7OJtPt0agVp0w2z8t10gcm2TEeyMVoOZyq/Hu/ibmUqzlkGxrgiKoEkURyjmRSZjcyVZE+a/pOsWNl4r8qEDs7BG8h1aB1ktOVljrdiW9eppwPqYyat0xx2FQMwJBjCb0jp8q8dhREyGj2Du6khd1YqdjvQN9afojiNd66zHaO73ugXg8+LAF9RyIBsx1Famg0zejodCZPjeYiAvbtoZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tj6xD+48xNb7tX3Xv+vMlLQJqYdLQQWJ5YgIkCCfjow=;
 b=P7Kuo48AEfXKbt2ABFdXkuiaVnJcJ1lhFaMAgzZqb937Th3izE0U5pcE01xmDrqKN5cvn8aDwbOmQZ6pGDbPwiE3i5kf/6p4GTytLBMo34VPJw/N1znLfjgdWpAcv7qyfGOoN6+gkl8W/Ap2a2crZlCG9E4a2iAzAjF4JSDZnF98tDwgWYpAR1TVwAr2X0B+Mwof6gVgtJvetZA75iOFB+bHfoaN4exwCMIUEWFtVocx5dN/veGzSW/hwNWigd0G62SR2OK1CL/LnLUwEzzXso55DVOW8gcsaOfN7uyXfL0S6XD0jIIJ91ZNgF3pmz723wKgIsjQ8GlIRUl70N/bRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tj6xD+48xNb7tX3Xv+vMlLQJqYdLQQWJ5YgIkCCfjow=;
 b=21CQqSMMa17DN5OfzSUMRlXMKTfWZWIdcyLcAFbA1GpAkL7yUJDYViebO4ueCuLV8RLBd6STXE1Ic5uTqz5StRPzeTqZ+sJG2V8o0tSrIAX54tQzci4MMAC79qawCnOBWq5pXrI1NAI81/M9SHyvkUzx2nI7MydYDaDxFW6j6Z0=
Received: from DS7PR03CA0200.namprd03.prod.outlook.com (2603:10b6:5:3b6::25)
 by SJ2PR12MB8062.namprd12.prod.outlook.com (2603:10b6:a03:4c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 05:14:17 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::bd) by DS7PR03CA0200.outlook.office365.com
 (2603:10b6:5:3b6::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 05:14:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 05:14:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 00:14:13 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 20 Mar 2025 00:14:07 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, "Jesse
 Zhang" <jesse.zhang@amd.com>
Subject: [PATCH v9 3/3] drm/amdgpu/sdma_v4_4_2: update VM flush implementation
 for SDMA
Date: Thu, 20 Mar 2025 13:14:06 +0800
Message-ID: <20250320051406.4161524-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|SJ2PR12MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: ce766162-7fa6-4298-d3bd-08dd676e0fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GlsI9f5rLeYwZfJQsZri2xalIY3gwOPeTCAHCN/3K362mFiaXp23mYB6Wkhm?=
 =?us-ascii?Q?eYiuHUVXVDExDeMoA9OI0GNWZfFufBWJBBueXX4UsfjfQLbOxJV7/Pm/ifct?=
 =?us-ascii?Q?QMKsxhLPnhwTcRcVaCwDtmXORMAGnd46sL/ZnCrMvkkDhz7IWTyPiN0BRE2g?=
 =?us-ascii?Q?/UInr6TaSMTTi+1REIPlG8aRH5cPQ0S/FlrCuomRzz5hwi5eIBebWVVwDu9t?=
 =?us-ascii?Q?rJPHWgg0dxbtCUlRheY9YBogCFTWeukvpqQGjB1Q2z4EPXLnf+pw/FABGy9F?=
 =?us-ascii?Q?IGvvfsy1v51PeTQ8i3Apmy0cgW62D8jc3EVDax/OtcIKm3rz8zhdvoePQy9X?=
 =?us-ascii?Q?UaMK+C88LBm5+nybBP/Z8F6Tl+xzXrca7rp/Ya0OZl8/S6Utki8KAGWOQ9ZO?=
 =?us-ascii?Q?5rBS4SStYsBsk6wXUlAApU/uXICK0EjLUoAvXIb4lirNwcvGqZ7pBqdahmze?=
 =?us-ascii?Q?Ooj3ePhhhIyuxJFskTiYdxARNUG81kz5WBefZWj6wZdyPiUVpFphLLllrprA?=
 =?us-ascii?Q?1N31tuir5PEUbYzHAErMNLSWp3Q2nLMeartt4wM3QrrlCviw192Pii0PQB+x?=
 =?us-ascii?Q?p4dJpbmxiYRUkubC8hSJFPkVGBlhG8qeO9vAqsoUwYFbeiizL8BWzg7l9ilf?=
 =?us-ascii?Q?Bmu6mHlZRsIzzwFvc6g3hoTORU8DYK7GWHRtPargUU8CDxC551Hu9RyG5vA1?=
 =?us-ascii?Q?FCMA4pDW9qYHrfBuOkwNKHEMyOYaVZPhIZpFWBWqWvE2+4Gmll/WowtEfpNI?=
 =?us-ascii?Q?dvbOcit0e+fxD4tkRm6FyJ95c1AdDu6P6uMps/31ZOOocpWwzExVz3k+n3R+?=
 =?us-ascii?Q?VexVIFmgs5fFVuM7B/Qt0ITgtIgfl57Y1M1/QQHlLvEBCL59cBf2gRP1n3qr?=
 =?us-ascii?Q?F01kXXa7WfsWG/9agqKIatkOk8Bs52REZSeHVJYh2AKsZ1TUgFDaBGadma1t?=
 =?us-ascii?Q?vZg+ZHzRBtXFUcNqRN9uCiUMr2Vj261VEFOPcqQtSobW0a0PHU0WrwgFNJUg?=
 =?us-ascii?Q?hZRGchLWorBDzRmHYEX3dppjxNKj3YNPcbAiqPjM25Sl8JwtJDYMRdrSO3Ih?=
 =?us-ascii?Q?cxr6DbAr+GLIfbtYRm3ZbeslokMy8DWoPC/7uDTTCkXLvZkhc6eOTJSLYyDe?=
 =?us-ascii?Q?TefTEc7mYAgSk33kJLq8sEEr1ZZcClWqeNSUMKFL2cBnsFwjD4Gy9LrgdIYD?=
 =?us-ascii?Q?orT/7ZNPa4wBOJYXWzWvUnvksrf0NKKt3kzzWr9LYU2ssiPdCEH3pA9JEJMF?=
 =?us-ascii?Q?cy9mrVkDAJCGnOxgPc+WSj6shS/zKQ1mtjLfDRVaqr/GeXdod3UhbuYDc5dk?=
 =?us-ascii?Q?SjmNcWWNc4JwpifuDJgYmyS16vTvFqsjbRGRPbO/xNXtvH/deNQMT7SZ9voU?=
 =?us-ascii?Q?wnGGNvMzYGKbZ93j66WWm8U1VsHmbVmM1NQdVkiOgQHFGkwKjMuUlx2bGWnU?=
 =?us-ascii?Q?gvF6QEYTjsp7C6zp87UBP6aZhzauu7Tk0f+Wv1/Z4wZB9mWh9sBONnU4XFhA?=
 =?us-ascii?Q?qd9r152wW9YUdQM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 05:14:16.3431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce766162-7fa6-4298-d3bd-08dd676e0fc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8062
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
 .../gpu/drm/amd/amdgpu/vega10_sdma_pkt_open.h | 70 +++++++++++++++++
 2 files changed, 133 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index fd34dc138081..0a9238e70e7e 100644
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
+		SDMA_PKT_VM_INVALIDATION_HEADER_OP(SDMA_OP_VM_INVALIDATE) |
+		SDMA_PKT_VM_INVALIDATION_HEADER_SUB_OP(SDMA_SUBOP_VM_INVALIDATE) |
+		SDMA_PKT_VM_INVALIDATION_HEADER_XCC0_ENG_ID(0x1f) |
+		SDMA_PKT_VM_INVALIDATION_HEADER_XCC1_ENG_ID(0x1f) |
+		SDMA_PKT_VM_INVALIDATION_HEADER_MMHUB_ENG_ID(eng));
+	amdgpu_ring_write(ring, SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_INVALIDATEREQ(req));
+	amdgpu_ring_write(ring, 0);
+	amdgpu_ring_write(ring, SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_INVALIDATEACK(BIT(vmid)));
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
index 8de4ccce5e38..3ca8a417c6d8 100644
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
@@ -3331,5 +3334,72 @@
 #define SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_completion_signal_63_32_shift  0
 #define SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_COMPLETION_SIGNAL_63_32(x) (((x) & SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_completion_signal_63_32_mask) << SDMA_AQL_PKT_BARRIER_OR_COMPLETION_SIGNAL_HI_completion_signal_63_32_shift)
 
+/*
+** Definitions for SDMA_PKT_VM_INVALIDATION packet
+*/
+
+/*define for HEADER word*/
+/*define for op field*/
+#define SDMA_PKT_VM_INVALIDATION_HEADER_op_offset 0
+#define SDMA_PKT_VM_INVALIDATION_HEADER_op_mask   0x000000FF
+#define SDMA_PKT_VM_INVALIDATION_HEADER_op_shift  0
+#define SDMA_PKT_VM_INVALIDATION_HEADER_OP(x) ((x & SDMA_PKT_VM_INVALIDATION_HEADER_op_mask) << SDMA_PKT_VM_INVALIDATION_HEADER_op_shift)
+
+/*define for sub_op field*/
+#define SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_offset 0
+#define SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_mask   0x000000FF
+#define SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_shift  8
+#define SDMA_PKT_VM_INVALIDATION_HEADER_SUB_OP(x) ((x & SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_mask) << SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_shift)
+
+/*define for xcc0_eng_id field*/
+#define SDMA_PKT_VM_INVALIDATION_HEADER_xcc0_eng_id_offset 0
+#define SDMA_PKT_VM_INVALIDATION_HEADER_xcc0_eng_id_mask   0x0000001F
+#define SDMA_PKT_VM_INVALIDATION_HEADER_xcc0_eng_id_shift  16
+#define SDMA_PKT_VM_INVALIDATION_HEADER_XCC0_ENG_ID(x) ((x & SDMA_PKT_VM_INVALIDATION_HEADER_xcc0_eng_id_mask) << SDMA_PKT_VM_INVALIDATION_HEADER_xcc0_eng_id_shift)
+
+/*define for xcc1_eng_id field*/
+#define SDMA_PKT_VM_INVALIDATION_HEADER_xcc1_eng_id_offset 0
+#define SDMA_PKT_VM_INVALIDATION_HEADER_xcc1_eng_id_mask   0x0000001F
+#define SDMA_PKT_VM_INVALIDATION_HEADER_xcc1_eng_id_shift  21
+#define SDMA_PKT_VM_INVALIDATION_HEADER_XCC1_ENG_ID(x) ((x & SDMA_PKT_VM_INVALIDATION_HEADER_xcc1_eng_id_mask) << SDMA_PKT_VM_INVALIDATION_HEADER_xcc1_eng_id_shift)
+
+/*define for mmhub_eng_id field*/
+#define SDMA_PKT_VM_INVALIDATION_HEADER_mmhub_eng_id_offset 0
+#define SDMA_PKT_VM_INVALIDATION_HEADER_mmhub_eng_id_mask   0x0000001F
+#define SDMA_PKT_VM_INVALIDATION_HEADER_mmhub_eng_id_shift  26
+#define SDMA_PKT_VM_INVALIDATION_HEADER_MMHUB_ENG_ID(x) ((x & SDMA_PKT_VM_INVALIDATION_HEADER_mmhub_eng_id_mask) << SDMA_PKT_VM_INVALIDATION_HEADER_mmhub_eng_id_shift)
+
+/*define for INVALIDATEREQ word*/
+/*define for invalidatereq field*/
+#define SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_offset 1
+#define SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_mask   0xFFFFFFFF
+#define SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_shift  0
+#define SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_INVALIDATEREQ(x) ((x & SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_mask) << SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_shift)
+
+/*define for ADDRESSRANGELO word*/
+/*define for addressrangelo field*/
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_offset 2
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_mask   0xFFFFFFFF
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_shift  0
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_ADDRESSRANGELO(x) ((x & SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_mask) << SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_shift)
+
+/*define for ADDRESSRANGEHI word*/
+/*define for invalidateack field*/
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_offset 3
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_mask   0x0000FFFF
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_shift  0
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_INVALIDATEACK(x) ((x & SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_mask) << SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_shift)
+
+/*define for addressrangehi field*/
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_offset 3
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_mask   0x0000001F
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_shift  16
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_ADDRESSRANGEHI(x) ((x & SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_mask) << SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_shift)
+
+/*define for reserved field*/
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_offset 3
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_mask   0x000001FF
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_shift  23
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_RESERVED(x) ((x & SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_mask) << SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_shift)
 
 #endif /* __SDMA_PKT_OPEN_H_ */
-- 
2.25.1

