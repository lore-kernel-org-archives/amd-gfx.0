Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4B7C28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 05:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E15E10E389;
	Thu, 20 Mar 2025 05:14:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b5C220cs";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B04C110E389
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 05:13:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUG1W2YzClLaSPNXkdFRnRzKbqCsD4FWSy7L7IxeCD21JXVP3o7l/5A8JNy2pTkchbRGnYj3/E/9z8BOv/K5p5PRhHW/+sE7sZXd+gx3FZsahKzkqg0C9HLhdsWVsu44r5QG8857dol5tBfYHng6Gs3+m0hRBCsPgZND6TgSwyzviTFodMEeNKzEgH7dO+RPsYJ1+GZukvFTfdY7CcdfNPfQZeCgSe4mm+wyOizmrytfAJSivskojLuRf5/scpddDsyIgmdesob+MAY1nB4fIcYTDMQzRy62wOnt2Ua00J3SpAqngFWkyKBdIgmPk9HOquwyrv6fxXZbAvS/gzdqdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tj6xD+48xNb7tX3Xv+vMlLQJqYdLQQWJ5YgIkCCfjow=;
 b=C5OcwSAhlZj8nqyLEv+bxRel5lWR3rNpHMhE5rcSyIhMJ/6zJG9z3FNc6fSdPQKO/JXM4PA3zm5OEwn7AGc7hjtbg80ED+IJAK/MBmMza5vMgEXbkEHPrI6bKSBmnYtOOtPXh9XvjaHY8TAzGJZH6ZMzYCsWUj3jlXMomEFRY9YXujpMNLWI1R3hhuz5vnMqcepvoUv4XnM5UGSODxwuk3qbWLwoOnt0UJUIzHiC5KbPlv+LX5Y/hT4nNWhf7Pin52zouUvU4DHqztguDi41X/WPCY+Zrk1zwK/ABvQf7JmUe9O+P77SpjlZGHtIAZkzok57zakha0dexy7gHVbK3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tj6xD+48xNb7tX3Xv+vMlLQJqYdLQQWJ5YgIkCCfjow=;
 b=b5C220cs4pfILXAdfbUOshHBIUBWC/73SpH1vDgl/7RalWcJ2UIKxZ6lkunGe9YGIGS3zkh/+RGzinRRmAz4hIoFOFBF+23jZ3WmheUBaGvGj4T5u5pX3kwa1a7T3tBhZNKMXUoxsIjZPeXCFV/ud6sACTLTbeMr9e/0n5nJJLc=
Received: from BY5PR17CA0042.namprd17.prod.outlook.com (2603:10b6:a03:167::19)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 05:13:53 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:167:cafe::f9) by BY5PR17CA0042.outlook.office365.com
 (2603:10b6:a03:167::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 05:13:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 05:13:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 00:13:49 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 00:10:48 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 20 Mar 2025 00:10:42 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, "Jesse
 Zhang" <jesse.zhang@amd.com>
Subject: [PATCH v9 3/3] drm/amdgpu/sdma_v4_4_2: update VM flush implementation
 for SDMA
Date: Thu, 20 Mar 2025 13:09:43 +0800
Message-ID: <20250320050943.4161194-3-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250320050943.4161194-1-jesse.zhang@amd.com>
References: <20250320050943.4161194-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 22ae6ae6-d05c-4ef5-2f01-08dd676e0195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?402DfbgAYK3TCYVoh4U12p8Dta29npQHIcrkbBCzPszEm1fdgmTVY5ByvHnt?=
 =?us-ascii?Q?F/t1IUbo6thdDGZnafagBfZkbMQjphLxmPW9mlTdyoh+FEV1CkYiXsS/4pPV?=
 =?us-ascii?Q?PJSD2BcsLR5UiVlNBci4ZG+pN1DvvZZ3/cLiJhJfG6J6WjccMQ4VLc7lBZ6P?=
 =?us-ascii?Q?O3lrf2t574YwkPrqCBOvZOCu5jRT+28FvTroDNgWDGvdQ7jb2ydXby4hY4aF?=
 =?us-ascii?Q?NDK1gqm+6326pKGNZBq9f5U/uo+0LFqR5YCIW3EzZVMttxq4ZIRg1qUf6wgJ?=
 =?us-ascii?Q?d0jZycJCUPekpU4fUsrQ1ibervemafKuzcru5MJxpj92ty8cKyzktLRoA9V6?=
 =?us-ascii?Q?9Rc2XmWzd4OQtmJeAQi5vx+ymrNAA02ebk6Lhx0T3Qx8n/V4LZVnklfo5Jkd?=
 =?us-ascii?Q?dIzGztPK40E5D9flakj5R48k2IdwIEwamEvOGdHTY2TylsCRy6Plg0KbgRHF?=
 =?us-ascii?Q?KTwmuJRLl7LKGhG0xdGm1TtM8Pe0yj30+U/WqqoRNYq7/X+rv5HMtDEQb7Sc?=
 =?us-ascii?Q?MW2+Od8A+PIbM+zLq3uF/ZLJI/yzO0Cm6dS4XaVXnezl82erJg/KYAqbY7W7?=
 =?us-ascii?Q?NY2g5/HGwqR3U/EUAjyOvco6IWALSxvQEXKRax0Es8+vzNnRJxbx+Ygljz6g?=
 =?us-ascii?Q?dvMfwub4wPiILxwZ1kz5MzKew3qMUurZCDJXulYRsbo4cQyV6I94/b26jLEY?=
 =?us-ascii?Q?1QBYZhQQ00l1o6bSokvkxdEEjjJCo+75weKy1fTdaegfQJtYqWFik/Etqxgm?=
 =?us-ascii?Q?M2jbnfnSrRc+N8K8i6+0KdV8c7rlTlCp/UmQobJWBwldPJkxxFusvGanOFv5?=
 =?us-ascii?Q?qWzTPHy4oY92AWm36Wqc053uCTcDxnsuxw1QDEByOzXRxjVgsIUtsqKdQTjf?=
 =?us-ascii?Q?Mw1cZzwHD4CE70Sxr9eImRAvnTsDIOlxuvD91Rurf0wUrtrP/oc//jeoEqrI?=
 =?us-ascii?Q?wm4RWUsvCXU5MGJP0JFVPxbmVbSSPNJwcwbvYA2ILfXCEPNZvvaVvNbGkag2?=
 =?us-ascii?Q?QoVmcCQCoXjMv17pNtp2riwWwDIqiTg18iNoQdeiw0ozyhuS6hiRiJ0EiVtC?=
 =?us-ascii?Q?Y6eFszs0c3GZqUQiakQhxm4AS9/3QJz1or3LLN3YljOt7PgSQslj0h2Pu7ta?=
 =?us-ascii?Q?R/sxeh8yW9ImEN6wZQccMSSiW1k/SB2mGX9y/QSeSyDu7dxZMFJXj+dndyXF?=
 =?us-ascii?Q?4/bVGveF4qcKQDtboJclL1nAOVFZueXEiB484PeSqhqHPf8MGF9dbIDWIrEF?=
 =?us-ascii?Q?b/8sXjPXZUTOGskd0PzDmEt1pTvrfJZFYZfwPUK/XF23JbaRSBLsWq2HE4Q1?=
 =?us-ascii?Q?bObeZzNGKvYgEI3uhvt2bnqKC+4iiYj+XMxsjc4lTn4y0YLxj4cgo95STZGo?=
 =?us-ascii?Q?23QcrOdmH8VgSfNeb3eDW6RhLEfGU+cgexsKuCyH9PBhmASryaKkbfuguUjS?=
 =?us-ascii?Q?wdmY0jXUCWwRGBQborH1ZF2GBbgYYbjc5xdB81mVdBNmLYfFfZfeuYsccPGQ?=
 =?us-ascii?Q?Sdohc+D+RCYwGxY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 05:13:52.5533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ae6ae6-d05c-4ef5-2f01-08dd676e0195
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038
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

