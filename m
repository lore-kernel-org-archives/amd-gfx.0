Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9316C021B1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 12:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92E5710E978;
	Thu, 20 Feb 2025 12:00:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b8xaN0FP";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64ADD10E978
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 12:00:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIb506zmJMSUcr6PbooaBnN9bEZbRoEL4NHnOAnkgvYT2iTP7icCfBiloyKtfi8gPyDpfV4GaUpRLLoxzwjhNYVrGLVZvUAhI54e1HRGb1tjtokd3UAWjEJGXWuVVbl3qSyXElWEs9HF+wdcexGCGOJQU0o88pIGJrj/uvoEi+1XRP3zcEIHGfJNpzSnZx/5mFYcY5q0fNUutbGigDARMG3KVJvmz/GoB+7ShXwIDI+t+fCX5plM0dfoAmZm7qRXPqf1ySyg1wY0tYq+NcEO+7hmibgwSzS8PW+2FalkjdEWFMK3C4RG5rKNF7xSjvyyjMmu+MhmFbMTB7rRbH0Y+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObZcNITigUGHtK3xugy+Ig3OmSNYAephUDNfa57MMEk=;
 b=esbG+zPkPFU4itSt67LvXViqRkcB94MjSoQ7YXcvGjpblSknHug11IfUqnxzWA7oIvWBgRU39Ta3r2d0eIkbItOBjG4KmGxaTfvMuri1gQlJ994IHvwCgOQvMCxw3ixnmJUyjW5WXTNXxX8VaC/XUbbD/YS/7BfSXSw/ghtzmth6x1OVyuocXIsdWkNUyjlzaR9pwoNBzoAboGWG+8O2iZ9jathTnLuEj67maunXKK7ZW9OtxmAa9rWWpNVCZcD1VlHuPrTMOHtRlcSnq1cPZdzg5RfpHvj8amTtFzsbpkYmyJcdQ1QJKEncyHYLpw/UikvhbiMSQMGLHJ9I39NYdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObZcNITigUGHtK3xugy+Ig3OmSNYAephUDNfa57MMEk=;
 b=b8xaN0FPJduS2QhG/1ryJMpjtuu880viSd1Nqm5lZpYh5LlQ/wuNNLLWDygC6T5YY2KEdbZgC7fckO89XhZP/69+XFc/glnRySSq7OvQGC0s+Xv6989Hft/59LKm//yddofQE7GXmC0TnCSo7nb1B2FdD6dJukrC6aJg2L3xGac=
Received: from MN2PR11CA0021.namprd11.prod.outlook.com (2603:10b6:208:23b::26)
 by MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 11:59:59 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::1e) by MN2PR11CA0021.outlook.office365.com
 (2603:10b6:208:23b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 11:59:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 11:59:59 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 05:59:58 -0600
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 20 Feb 2025 05:59:58 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdkfd: Correct the postion of reserve and unreserve
 memory
Date: Thu, 20 Feb 2025 19:59:46 +0800
Message-ID: <20250220115946.2051216-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|MN0PR12MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b8da7f0-ac65-4a6c-14bd-08dd51a619e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ntmtQJnIvP1gO1YuvxvJ7q6zFsyq7IF55v+l5j5hkP7jUgSjGlKe0uVySFS9?=
 =?us-ascii?Q?oGMJOIrQT/y37IDiaEiYKqVXEahd+J6Po91WuyogNK1bzgbNtPeNX6O52M+x?=
 =?us-ascii?Q?WxtpluZ9U13JKQA7AuZMuzldN1VVf5roL7jyUHkh1o7gVm4VwSxFvlhM0JZz?=
 =?us-ascii?Q?JLay76/hMt/HliGuc1cnEXjOi5DimRHP7zgTGbxm3UTTb8JVdj7kZD6DxeeB?=
 =?us-ascii?Q?OVPzHBnSBVUJ3a4Ybhc8QvRQ0Nsk8oGL4uUIMHakiZPKnOHFcRtdBWivTbcV?=
 =?us-ascii?Q?G5yAhey5JFF35FTjpqqO6mVGRRuw8NVq13hycvSP2AIMqROgo3a6l8KxVIgD?=
 =?us-ascii?Q?cfgszsbN2ClRinqQaCUEE29fTg2XrVbhRGcGMprpfBdjYMmLiI0yANZLbdCt?=
 =?us-ascii?Q?/TbTBW5xV6Dbb4WC5ZJU0Gt+irA32vV5ZkSgt+rh7x8Zz0hKRum4jO1/J/hQ?=
 =?us-ascii?Q?rHTL7nobLRsgJ5BYo+Dfqi0N59pjTx2Jidor59m4NV4X4ky04SiTn2xV/kye?=
 =?us-ascii?Q?KJO/kAzoj3v7x8DpbbXTk7HUwOuX4yuxj7/cVgc5I4/t9FlW6ZH30GLluc+h?=
 =?us-ascii?Q?FsDeFxWloMLUPpjVqQTNvm5wTihTDyANzvB0WVdHC1rg3kTSnQCWygAKC7y3?=
 =?us-ascii?Q?KLL6zxaa3dBoPzBvswtg9Ho64GEVtBc92IH6N9DSEXKWP12GJn1PyUMgJdSX?=
 =?us-ascii?Q?QgREysxtIR3+m1dmsFCyoSGgoY7sIna6iIDb9mH4jeys5Q7++g80Se3qPNFh?=
 =?us-ascii?Q?dhew5cUbnz6f69lpjzghEleyu9poocv98p+ICcMciIimWUthyEzBAH3WXouF?=
 =?us-ascii?Q?OjqWrY0MVriuh1BEBNcav7PRUdxxMpVoDNYmpyYrIGX5OKm9l4+YMD1SeDiE?=
 =?us-ascii?Q?ECZB2wYD5fYnbDY/CF721TBHj1bOQ7OD0O3OkpisbhgxXO+O976Q4ui5TqAZ?=
 =?us-ascii?Q?/ZiKQhfaCKK0bf2tu85+ccAdYf2zPgRxIMUoOrnzqN4Vudt6m+tFY88WreLP?=
 =?us-ascii?Q?Tyoj17F2UR90NeqAkqjIn86oQZL7dCuakGgzFLwW+k4Lb/hFWr5b9/tY/Zzo?=
 =?us-ascii?Q?ow+Ke9ZB21+yFvBMYcB8f3ISK83ZTJpuNaHj77IMXadAcrdOxmzs23cXBNVK?=
 =?us-ascii?Q?UsWpBRx+tB8gmPLMyyyBX5SV8iWi+5maqUtP94DN/O8QH469AxNPe+vhkFBE?=
 =?us-ascii?Q?d3JTslQlXzAN8ZVxZZNKMFA7UKqMxUkyKgG0+sxU3FgrXBjybBPmiudGSq6q?=
 =?us-ascii?Q?7FuF50VBRsVq9FKTghUNpFMuWbvExZ0hNgIjwaDsotlc5WhAuIy6ct5PRdFn?=
 =?us-ascii?Q?gulksPqIyDzm4aPDGGykSypMg2MPU84e7/Z5QB+kSLKZkb3rHLC5y9xaxIdb?=
 =?us-ascii?Q?cp8GUx8lyaFB77fk2qUrYGzrw2bYWECdZ0zSuhtAbxfUy0OU5pcVU+YFzL61?=
 =?us-ascii?Q?NDUvNnEBrhhi75NmOV95UNHFiLTwUTft9/pP7kMKqoInE/1F+E5JtF5r0ZwJ?=
 =?us-ascii?Q?EQcRtix5DbEi60A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 11:59:59.6546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8da7f0-ac65-4a6c-14bd-08dd51a619e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762
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

Call amdgpu_amdkfd_reserve_mem_limit in svm_range_vram_node_new when
creating a new SVM BO. Call amdgpu_amdkfd_unreserve_mem_limit
in svm_range_bo_release when the SVM BO is deleted.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 13 -------------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 79251f22b702..3bbc69751f7e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -514,15 +514,6 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	start = start_mgr << PAGE_SHIFT;
 	end = (last_mgr + 1) << PAGE_SHIFT;
 
-	r = amdgpu_amdkfd_reserve_mem_limit(node->adev,
-					prange->npages * PAGE_SIZE,
-					KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
-					node->xcp ? node->xcp->id : 0);
-	if (r) {
-		dev_dbg(node->adev->dev, "failed to reserve VRAM, r: %ld\n", r);
-		return -ENOSPC;
-	}
-
 	r = svm_range_vram_node_new(node, prange, true);
 	if (r) {
 		dev_dbg(node->adev->dev, "fail %ld to alloc vram\n", r);
@@ -560,10 +551,6 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	}
 
 out:
-	amdgpu_amdkfd_unreserve_mem_limit(node->adev,
-					prange->npages * PAGE_SIZE,
-					KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
-					node->xcp ? node->xcp->id : 0);
 	return r < 0 ? r : 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index db3034b00dac..c861d8c90419 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -430,6 +430,10 @@ static void svm_range_bo_release(struct kref *kref)
 		/* We're not in the eviction worker. Signal the fence. */
 		dma_fence_signal(&svm_bo->eviction_fence->base);
 	dma_fence_put(&svm_bo->eviction_fence->base);
+	amdgpu_amdkfd_unreserve_mem_limit(svm_bo->node->adev,
+		svm_bo->bo->tbo.base.size,
+		KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
+		svm_bo->node->xcp ? svm_bo->node->xcp->id : 0);
 	amdgpu_bo_unref(&svm_bo->bo);
 	kfree(svm_bo);
 }
@@ -581,6 +585,18 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 		kfree(svm_bo);
 		return -ESRCH;
 	}
+
+	r = amdgpu_amdkfd_reserve_mem_limit(node->adev,
+			prange->npages * PAGE_SIZE,
+			KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
+			node->xcp ? node->xcp->id : 0);
+	if (r) {
+		pr_debug("failed to reserve VRAM, r: %ld\n", r);
+		mmput(mm);
+		kfree(svm_bo);
+		return -ENOSPC;
+	}
+
 	svm_bo->node = node;
 	svm_bo->eviction_fence =
 		amdgpu_amdkfd_fence_create(dma_fence_context_alloc(1),
@@ -655,6 +671,10 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 reserve_bo_failed:
 	amdgpu_bo_unref(&bo);
 create_bo_failed:
+	amdgpu_amdkfd_unreserve_mem_limit(svm_bo->node->adev,
+		prange->npages * PAGE_SIZE,
+		KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
+		node->xcp ? node->xcp->id : 0);
 	dma_fence_put(&svm_bo->eviction_fence->base);
 	kfree(svm_bo);
 	prange->ttm_res = NULL;
-- 
2.36.1

