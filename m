Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E995FCFD313
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Nov 2025 15:28:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69E7310E2F6;
	Mon, 24 Nov 2025 15:28:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fiACKkwF";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013051.outbound.protection.outlook.com
 [40.93.196.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAF7C10E2F4
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Nov 2025 15:28:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eX6dhaUkh87xgD1K222XWWYIrO7ab/PX0kSFlFMEyB2FuaGw5xV7nYRaqI3xrvkLTfIupk51KeHPOEVgzFLaH1Zed0tHoMymuxU/R2/T68UChXx1kyZeQ43Ot4w5TXRL4GCwmdGaXiCIm9w7Dcf2TUuxe6PR8LJqQt/9sg0V4l/Az8heWscIClw5wY36FZUVJNwSuo9MbcmxPmyHv/hkXNXyalzRL4tOq9B1KnVZBoMiWVMLEApPqX5fZ6CJXpg6tOqQIXEXMrtAtAunx3PPTt7OtEAq6GIGYKtJCNrJPLmVjw/x5kceAgYUw2/IoPEAHl81fZe3EwwBPWkoZTqlgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZLgm72x6iMyGxTBo9aR7PKjMQ/i+wF3hyRri9Swexk=;
 b=UfoEjUShE+o8Yji9GPzk40w2dtP9W1ObDCbG0rmAkzmYN3+Ya8SbIqCu/Ks4WUgkZFTaBieVsELDePPKJy8CTHBP6qsSqXPRwz9glv3ENer8ziSZujFZL//GFYJKUeCOsGpcKjjneLkOLUPZV9Kolrab8bZtqHeQtdIwXmUcMPSBBqrlnHtRzvhn+CdmIHy5cjcGoIDvF6m80KGosLQpplIYGEpRk+JA7ZX/5lpWmgSFpmgyq5GhDcJW3eIMbN/y0SYIcZ2gqfX9Aag+53zgox7aKvKcfAAVD45DeJ0xD74qs99qjT3CQRqslfyqzYBKYQ0+d0CXwY7hsR4mXNSosg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZLgm72x6iMyGxTBo9aR7PKjMQ/i+wF3hyRri9Swexk=;
 b=fiACKkwFCylwn0t4SdAHO/Ec8thVbs0JU4szUl8+b2jwiYKurYH7x0//8YikqsTlVirj3rj9gV2dUzUvz1/MXL2ftd/+L4MEh1e5e8+uA01hp3fzJ2oVEQDKc3y57y5OQGAkam+eb/pxeqZArW7C/8f+umYbup9qBg4KcIn7YBI=
Received: from SJ0PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:33a::26)
 by DS2PR12MB9639.namprd12.prod.outlook.com (2603:10b6:8:27a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Mon, 24 Nov
 2025 15:28:14 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:33a:cafe::73) by SJ0PR03CA0021.outlook.office365.com
 (2603:10b6:a03:33a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 15:28:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 15:28:13 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 24 Nov
 2025 09:28:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: remove hdp flush/invalidation completely for
 gfx12.1.0/sdma7.1.0
Date: Mon, 24 Nov 2025 10:27:59 -0500
Message-ID: <20251124152759.429384-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|DS2PR12MB9639:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af1fd37-f98c-4497-eaba-08de2b6e1564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y/ql2NJltTJ/m5DdSqT5QH+lRDGRiPBcy6Pc2Kaj/aoHjfMAsD8aR6IZc5gr?=
 =?us-ascii?Q?D+edR0pakd7xoVN9S17WlmfMZjRJu8TDB7ird5nHAJ4hWqjm4QH//ONyIsZz?=
 =?us-ascii?Q?aWugjf/E1yCaTL8Xhw8Rs4zmw5Ys8Fw+kJ+ykRRiTcH/DcvxQbWr91ZMARPS?=
 =?us-ascii?Q?v79ZLKRyyDKnvR1Nrj1lSweoCTHbKudsNzu2hG/06Vpl7Gd7c7B+3rIkSmVk?=
 =?us-ascii?Q?z+xRdoFaJKHxUIaaUoY45KX5NxXO2jAI1HTJOWKoMnyHCD6AB08YeBjgTE7e?=
 =?us-ascii?Q?8gtZtuvg4N66V/sHDzDQttcPvuF7werDWEvrr75+XtmE1WQNDFaJrptEzPde?=
 =?us-ascii?Q?pw3G1VfnHAV8X0w4x4oA9myYW/IBRTqcopApljbFnWZcucpfmiz5tXPlARWe?=
 =?us-ascii?Q?S92aEFOLpaxM6mkfLjo/n71wV8cYgumpJkfl3vEfm4+lKDhZvi/SUmIBTLuf?=
 =?us-ascii?Q?D6bq6Qi6EYpHhq9CBpUtr2PHiZK+NhVftwyN2kVZ/X1C932qjVYwTSNbMyOT?=
 =?us-ascii?Q?c61ptWtQfgcqtmzjRPWJ8PUIDXUHgvk0c2jRbycNvIPswuzUNU5uzwTx+1C8?=
 =?us-ascii?Q?cLCqS79WyBveyWFI2yoyKVwVdB9uO5pl9Igvd5D0Jt94AYx7peaeadHP0inX?=
 =?us-ascii?Q?MTKvLun9c8vkFUzi8itotPguhlQ21GnVHevZnMvq3doYvoAkRK+PKyaqQ+r6?=
 =?us-ascii?Q?HfUdUSbkLmMqqUlpsQKrXWXxwRkLvIAN70KJk7veqIoRabN2ry9VOU29iHWZ?=
 =?us-ascii?Q?yn9/8qg8kMgBrWkKkOVjMT9K2cVqEBHQ3Cs0kYZxJQCSE8fX0edWI5Bga02M?=
 =?us-ascii?Q?v2a7AZ0mz0NYdHLQDAQkSXbYHYSWhZsrlynTcfHSsICcjFTVnfahoDOrgzXx?=
 =?us-ascii?Q?C0gPQJFkWj+XwF6vxIm30L/fyfJSTKoLTDxXvD+u/3MPmdokX/tf2c2BCaUg?=
 =?us-ascii?Q?7sMy+iPcps1Qeuo1dUef3YM9tciWf8CWud0ygRpgiaISljvaSe97p/GZ+zw6?=
 =?us-ascii?Q?XHZXXXCZyDhl301OA/iPjIDLH9Tddm6RvCmCKStyFDT0w7l12AA/foGh9uUv?=
 =?us-ascii?Q?4Rz2e2dMX4AtBaw3ijgv2bBTyrZymyDlcoh8pDzC+diXG4xm7tmN36muQMhb?=
 =?us-ascii?Q?x1nBwUhpArHp/KILJOkKLH38XKZEDZrJCyF+djhDkfDjSQ9xn+qI3Jxnmzrf?=
 =?us-ascii?Q?ACU8Vuxsxe9Lycu4Y4CEmtUCIEUibXyaOw/mUEMi7PWKG0uBCuyhXF4tQSph?=
 =?us-ascii?Q?/MdwOjX7FkWlOME7oh7GsygjbQTe1yTNPg50sUs3TF+N8yrcr5yCw+hxiez/?=
 =?us-ascii?Q?4WNPIXknuTtZiPoM+YvTRdMfLHhBkupWtVh6zm81fqxcAshnm53lZgLFR47I?=
 =?us-ascii?Q?R/Egw0YKdQcl3Afb3Y292Bc/gTokLccWrL+WelbxwgpXWZaYXtZg0LW7Cr+4?=
 =?us-ascii?Q?istICQLOACRNbh51/BKwtH0lR5VOZLLokrnzYn81iyzkj/FBueAGWiy5/zGC?=
 =?us-ascii?Q?XCU78DkHWHKx0yhuNQXhsdpZiSKv55eEj1sQAaO4SmSvwAR/JB7ezi//4yyB?=
 =?us-ascii?Q?Ra8DbIQomFYCccwdGl4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 15:28:13.7183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af1fd37-f98c-4497-eaba-08de2b6e1564
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9639
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

From: Le Ma <le.ma@amd.com>

Remove the hdp operation and interfaces as the HDP hw does not exist.

v2: add checks to see if hdp funcs exists before do hdp flush/invalidation

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 38 +-------------------------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 32 ----------------------
 2 files changed, 1 insertion(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 6c40dc9533b46..194d66c0b4271 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2427,13 +2427,11 @@ static int gfx_v12_1_gfxhub_enable(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	adev->hdp.funcs->flush_hdp(adev, NULL);
-
 	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
 		false : true;
 
 	adev->gfxhub.funcs->set_fault_enable_default(adev, value);
-	/* TODO investigate why this and the hdp flush above is needed,
+	/* TODO investigate why TLB flush is needed,
 	 * are we missing a flush somewhere else? */
 	adev->gmc.gmc_funcs->flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
 
@@ -3144,35 +3142,6 @@ static void gfx_v12_1_ring_set_wptr_compute(struct amdgpu_ring *ring)
 	}
 }
 
-static void gfx_v12_1_ring_emit_hdp_flush(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-	u32 ref_and_mask, reg_mem_engine;
-	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
-
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
-		switch (ring->me) {
-		case 1:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
-			break;
-		case 2:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
-			break;
-		default:
-			return;
-		}
-		reg_mem_engine = 0;
-	} else {
-		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
-		reg_mem_engine = 1; /* pfp */
-	}
-
-	gfx_v12_1_wait_reg_mem(ring, reg_mem_engine, 0, 1,
-			       adev->nbio.funcs->get_hdp_flush_req_offset(adev),
-			       adev->nbio.funcs->get_hdp_flush_done_offset(adev),
-			       ref_and_mask, ref_and_mask, 0x20);
-}
-
 static void gfx_v12_1_ring_emit_ib_compute(struct amdgpu_ring *ring,
 					   struct amdgpu_job *job,
 					   struct amdgpu_ib *ib,
@@ -3657,8 +3626,6 @@ static const struct amdgpu_ring_funcs gfx_v12_1_ring_funcs_compute = {
 	.get_wptr = gfx_v12_1_ring_get_wptr_compute,
 	.set_wptr = gfx_v12_1_ring_set_wptr_compute,
 	.emit_frame_size =
-		7 + /* gfx_v12_1_ring_emit_hdp_flush */
-		5 + /* hdp invalidate */
 		7 + /* gfx_v12_1_ring_emit_pipeline_sync */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
@@ -3670,7 +3637,6 @@ static const struct amdgpu_ring_funcs gfx_v12_1_ring_funcs_compute = {
 	.emit_fence = gfx_v12_1_ring_emit_fence,
 	.emit_pipeline_sync = gfx_v12_1_ring_emit_pipeline_sync,
 	.emit_vm_flush = gfx_v12_1_ring_emit_vm_flush,
-	.emit_hdp_flush = gfx_v12_1_ring_emit_hdp_flush,
 	.test_ring = gfx_v12_1_ring_test_ring,
 	.test_ib = gfx_v12_1_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
@@ -3690,8 +3656,6 @@ static const struct amdgpu_ring_funcs gfx_v12_1_ring_funcs_kiq = {
 	.get_wptr = gfx_v12_1_ring_get_wptr_compute,
 	.set_wptr = gfx_v12_1_ring_set_wptr_compute,
 	.emit_frame_size =
-		7 + /* gfx_v12_1_ring_emit_hdp_flush */
-		5 + /*hdp invalidate */
 		7 + /* gfx_v12_1_ring_emit_pipeline_sync */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index 89ce07ae18b4d..37f5095c1511e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -32,7 +32,6 @@
 
 #include "gc/gc_12_1_0_offset.h"
 #include "gc/gc_12_1_0_sh_mask.h"
-#include "hdp/hdp_6_0_0_offset.h"
 #include "ivsrcid/gfx/irqsrcs_gfx_11_0_0.h"
 
 #include "soc15_common.h"
@@ -312,33 +311,6 @@ static void sdma_v7_1_ring_emit_mem_sync(struct amdgpu_ring *ring)
 }
 
 
-/**
- * sdma_v7_1_ring_emit_hdp_flush - emit an hdp flush on the DMA ring
- *
- * @ring: amdgpu ring pointer
- *
- * Emit an hdp flush packet on the requested DMA ring.
- */
-static void sdma_v7_1_ring_emit_hdp_flush(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-	u32 ref_and_mask = 0;
-	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
-
-	ref_and_mask = nbio_hf_reg->ref_and_mask_sdma0
-				<< (ring->me % adev->sdma.num_inst_per_xcc);
-
-	amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_POLL_REGMEM) |
-			  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(1) |
-			  SDMA_PKT_POLL_REGMEM_HEADER_FUNC(3)); /* == */
-	amdgpu_ring_write(ring, (adev->nbio.funcs->get_hdp_flush_done_offset(adev)) << 2);
-	amdgpu_ring_write(ring, (adev->nbio.funcs->get_hdp_flush_req_offset(adev)) << 2);
-	amdgpu_ring_write(ring, ref_and_mask); /* reference */
-	amdgpu_ring_write(ring, ref_and_mask); /* mask */
-	amdgpu_ring_write(ring, SDMA_PKT_POLL_REGMEM_DW5_RETRY_COUNT(0xfff) |
-			  SDMA_PKT_POLL_REGMEM_DW5_INTERVAL(10)); /* retry count, poll interval */
-}
-
 /**
  * sdma_v7_1_ring_emit_fence - emit a fence on the DMA ring
  *
@@ -1215,7 +1187,6 @@ static void sdma_v7_1_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 
 	/* wait for idle */
 	amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_POLL_REGMEM) |
-			  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(0) |
 			  SDMA_PKT_POLL_REGMEM_HEADER_FUNC(3) | /* equal */
 			  SDMA_PKT_POLL_REGMEM_HEADER_MEM_POLL(1));
 	amdgpu_ring_write(ring, addr & 0xfffffffc);
@@ -1257,7 +1228,6 @@ static void sdma_v7_1_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
 					 uint32_t val, uint32_t mask)
 {
 	amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_POLL_REGMEM) |
-			  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(0) |
 			  SDMA_PKT_POLL_REGMEM_HEADER_FUNC(3)); /* equal */
 	amdgpu_ring_write(ring, reg << 2);
 	amdgpu_ring_write(ring, 0);
@@ -1667,7 +1637,6 @@ static const struct amdgpu_ring_funcs sdma_v7_1_ring_funcs = {
 	.set_wptr = sdma_v7_1_ring_set_wptr,
 	.emit_frame_size =
 		5 + /* sdma_v7_1_ring_init_cond_exec */
-		6 + /* sdma_v7_1_ring_emit_hdp_flush */
 		6 + /* sdma_v7_1_ring_emit_pipeline_sync */
 		/* sdma_v7_1_ring_emit_vm_flush */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
@@ -1679,7 +1648,6 @@ static const struct amdgpu_ring_funcs sdma_v7_1_ring_funcs = {
 	.emit_fence = sdma_v7_1_ring_emit_fence,
 	.emit_pipeline_sync = sdma_v7_1_ring_emit_pipeline_sync,
 	.emit_vm_flush = sdma_v7_1_ring_emit_vm_flush,
-	.emit_hdp_flush = sdma_v7_1_ring_emit_hdp_flush,
 	.test_ring = sdma_v7_1_ring_test_ring,
 	.test_ib = sdma_v7_1_ring_test_ib,
 	.insert_nop = sdma_v7_1_ring_insert_nop,
-- 
2.51.1

