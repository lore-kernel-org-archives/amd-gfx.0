Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B2AC77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 19:07:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2351B10E286;
	Wed, 17 May 2023 19:07:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2DA810E286
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 19:07:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vku3f8ubPIX/e3R5P1wpmI7ne7I6mbvLL5ukiEEP8sZJLw2AFkWJZWlrDMTB26OaMVe/ixsFG/kIH9rdyLGlFy2DEbahGMyeDAAN1iTgUPPw9dtUEgfBuAlUaD019E6pzBwlmUgFOjj2j60iXn17xt/ZGQcNloZ03qboX3jcxrcDLjSFz63PHncpI3y+Fb5CwkZGgFgxZ46OG6+zx05sAzabT5LycwouMopL1KZBRf4/h6Bb0wRzbE8/00dBVkrlchTG95lrJTt1mg6B6RLwk2znY0SI5MsG+ELlIKWFAYgENngj2tQW+U1X+wGAQyUBbOwZukXHQeanqDj8QcUtaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIzx7kfzycxCIypbt8vzd6Q0INtxgQZUKTkkmxHj8FM=;
 b=cYPHaUsXJHGRsWL9FenQ3QuCDZCrPOl3DFsVUCVMNHOybCkPEsJ2COjjQ4D9+Bn41e98IckJBh+GLzZdnGdC8FIX9CAqUaQxgXUOvC02h5oaQxR1ZWOllKybTAPuGYdux0WtKLB8nr8CeZDLuTuPuzCsbvq6D3MmdwJG59TkveMvtokAC4t10sdAgu9pi6dpDv6I95bkB3eJgzTcyyfu/FFCQwXSkRDymg0mzvsoN/vlAy/3/bbmVU04GHbSaqy5jz5GhfjhVX5T7OMJqnYMJp65KMbqW8WGP+891xSbGcYhQTezEV1zKs6blp+jHl/0MHx54jAdz0osBK/76HwBcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIzx7kfzycxCIypbt8vzd6Q0INtxgQZUKTkkmxHj8FM=;
 b=QgZPq1rpySfVwrizrvHquImq1ok9c/3Xi3B81HAFSr4naRSnI9+AL1iUxjYrR7F/5KpfcuhB8nxg+KLk8gObPQZL5gXzcHOILkTDKRrkkhVcTmcnI84U02LpeCgGWh79GpNn/I4yEwEDtYL22WhYuMMXglVxWfHlk6XrSyJMrnw=
Received: from MW4P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::20)
 by BL1PR12MB5240.namprd12.prod.outlook.com (2603:10b6:208:319::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 19:07:07 +0000
Received: from CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::4d) by MW4P222CA0015.outlook.office365.com
 (2603:10b6:303:114::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.16 via Frontend
 Transport; Wed, 17 May 2023 19:07:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT090.mail.protection.outlook.com (10.13.175.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 19:07:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 14:07:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: fix stack size in svm_range_validate_and_map
Date: Wed, 17 May 2023 15:06:05 -0400
Message-ID: <20230517190605.205199-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT090:EE_|BL1PR12MB5240:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f17a9e-3b5a-4867-48a6-08db5709e8e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l6J+wzH9XrawneoiThXl6UdcdI8j2j/52odrRMjlK9A+Xkvuf52V1nOEo/zRJ860vPHKjIzjGBCWf91zXMVlYYLZ1UjBTAYLKdniMuhE/1B+fZlGRNxyLm7jrEDP5VxXTBqvoEh4wioO04ltUlL0KUAYu1ve2u8Gsagbmi92juXNTt8CNk+DvbBY1gUjMLC7wUMGetCCRTVHFjsI5HiJE0EbK9gGWE0afuAL/K7RpaACjrfGzwG1UfAC11lGmC26NWEFITpFSBrFNUdadJ3yPSTy6iss4+neq/8KbnioXeROLP/o6TQSqk5XaYWjt9h2GcRqh4Ls/FXAIqR597KljTeD3ByjQUL5zfArQCz3Tqw3f0z7bzkVeBeh0Uto2Ob5BcJJA0QyVIzC0icaX0lj2tE4zW8xcY+Fvlb7C+E8WM/0vuUkyLpMwYiV8gtPPf0//5VXmEPKPYgdtHDseinzTHa5n6nZffL5Fck0eQnRcWSNNNMN4aN8EDwa8oEnj4OjuGrgEQe9A6h2rJsfsLWBN2PyApQ/3cpkbor8M9vKjDziDGwm4V/T/cxb212EAvT14wqEAMN3OAfNdrLat0m0NmP+gRdbV3Z/N71OieRSIWgmRUlYAr95mdj4eZTKxas9kQCw0q+ZVKUsi+FeYblEASAH2eDjkABrV0r2kkG3dPKbgOMagEhkOv3ImZpO1a7N4RfTMlrRVRUYK/9moYOBHvzteN7WkhVh0kVzWjI/BrtgWRAxu4OPa6suqHangqKPGn/+sAO7d+Z8/WSUgS6kZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(6916009)(316002)(4326008)(478600001)(70206006)(70586007)(186003)(83380400001)(16526019)(1076003)(26005)(426003)(336012)(2616005)(36860700001)(47076005)(40480700001)(82310400005)(8936002)(8676002)(40460700003)(41300700001)(7696005)(86362001)(2906002)(36756003)(356005)(5660300002)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 19:07:07.5026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f17a9e-3b5a-4867-48a6-08db5709e8e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5240
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allocate large local variable on heap to avoid exceeding the
stack size:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c: In function ‘svm_range_validate_and_map’:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c:1690:1: warning: the frame size of 2360 bytes is larger than 2048 bytes [-Wframe-larger-than=]

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 56 ++++++++++++++++------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 9ae5ebf47eb5..fdcf56b4812e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1553,48 +1553,54 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 				      struct svm_range *prange, int32_t gpuidx,
 				      bool intr, bool wait, bool flush_tlb)
 {
-	struct svm_validate_context ctx;
+	struct svm_validate_context *ctx;
 	unsigned long start, end, addr;
 	struct kfd_process *p;
 	void *owner;
 	int32_t idx;
 	int r = 0;
 
-	ctx.process = container_of(prange->svms, struct kfd_process, svms);
-	ctx.prange = prange;
-	ctx.intr = intr;
+	ctx = kzalloc(sizeof(struct svm_validate_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	ctx->process = container_of(prange->svms, struct kfd_process, svms);
+	ctx->prange = prange;
+	ctx->intr = intr;
 
 	if (gpuidx < MAX_GPU_INSTANCE) {
-		bitmap_zero(ctx.bitmap, MAX_GPU_INSTANCE);
-		bitmap_set(ctx.bitmap, gpuidx, 1);
-	} else if (ctx.process->xnack_enabled) {
-		bitmap_copy(ctx.bitmap, prange->bitmap_aip, MAX_GPU_INSTANCE);
+		bitmap_zero(ctx->bitmap, MAX_GPU_INSTANCE);
+		bitmap_set(ctx->bitmap, gpuidx, 1);
+	} else if (ctx->process->xnack_enabled) {
+		bitmap_copy(ctx->bitmap, prange->bitmap_aip, MAX_GPU_INSTANCE);
 
 		/* If prefetch range to GPU, or GPU retry fault migrate range to
 		 * GPU, which has ACCESS attribute to the range, create mapping
 		 * on that GPU.
 		 */
 		if (prange->actual_loc) {
-			gpuidx = kfd_process_gpuidx_from_gpuid(ctx.process,
+			gpuidx = kfd_process_gpuidx_from_gpuid(ctx->process,
 							prange->actual_loc);
 			if (gpuidx < 0) {
 				WARN_ONCE(1, "failed get device by id 0x%x\n",
 					 prange->actual_loc);
-				return -EINVAL;
+				r = -EINVAL;
+				goto free_ctx;
 			}
 			if (test_bit(gpuidx, prange->bitmap_access))
-				bitmap_set(ctx.bitmap, gpuidx, 1);
+				bitmap_set(ctx->bitmap, gpuidx, 1);
 		}
 	} else {
-		bitmap_or(ctx.bitmap, prange->bitmap_access,
+		bitmap_or(ctx->bitmap, prange->bitmap_access,
 			  prange->bitmap_aip, MAX_GPU_INSTANCE);
 	}
 
-	if (bitmap_empty(ctx.bitmap, MAX_GPU_INSTANCE)) {
-		if (!prange->mapped_to_gpu)
-			return 0;
+	if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
+		if (!prange->mapped_to_gpu) {
+			r = 0;
+			goto free_ctx;
+		}
 
-		bitmap_copy(ctx.bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
+		bitmap_copy(ctx->bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
 	}
 
 	if (prange->actual_loc && !prange->ttm_res) {
@@ -1602,15 +1608,16 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		 * svm_migrate_ram_to_vram after allocating a BO.
 		 */
 		WARN_ONCE(1, "VRAM BO missing during validation\n");
-		return -EINVAL;
+		r = -EINVAL;
+		goto free_ctx;
 	}
 
-	svm_range_reserve_bos(&ctx);
+	svm_range_reserve_bos(ctx);
 
 	p = container_of(prange->svms, struct kfd_process, svms);
-	owner = kfd_svm_page_owner(p, find_first_bit(ctx.bitmap,
+	owner = kfd_svm_page_owner(p, find_first_bit(ctx->bitmap,
 						MAX_GPU_INSTANCE));
-	for_each_set_bit(idx, ctx.bitmap, MAX_GPU_INSTANCE) {
+	for_each_set_bit(idx, ctx->bitmap, MAX_GPU_INSTANCE) {
 		if (kfd_svm_page_owner(p, idx) != owner) {
 			owner = NULL;
 			break;
@@ -1647,7 +1654,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 
 		offset = (addr - start) >> PAGE_SHIFT;
-		r = svm_range_dma_map(prange, ctx.bitmap, offset, npages,
+		r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
 				      hmm_range->hmm_pfns);
 		if (r) {
 			pr_debug("failed %d to dma map range\n", r);
@@ -1667,7 +1674,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 
 		r = svm_range_map_to_gpus(prange, offset, npages, readonly,
-					  ctx.bitmap, wait, flush_tlb);
+					  ctx->bitmap, wait, flush_tlb);
 
 unlock_out:
 		svm_range_unlock(prange);
@@ -1681,11 +1688,14 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	}
 
 unreserve_out:
-	svm_range_unreserve_bos(&ctx);
+	svm_range_unreserve_bos(ctx);
 
 	if (!r)
 		prange->validate_timestamp = ktime_get_boottime();
 
+free_ctx:
+	kfree(ctx);
+
 	return r;
 }
 
-- 
2.40.1

