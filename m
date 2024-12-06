Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B0EE77173
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2024 22:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9422710E636;
	Fri,  6 Dec 2024 22:11:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pDbYq62b";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D909910E22E
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2024 22:11:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYwAUXXPEdpawwCY81qYsB7mK1jJxF72j6KOZpW6S3aRjiZAGG7nfsxQaQodXNGIaUPq0FxjWVRSGUStN21rdyfFNa26VAPmKW2ZACS13Tjhc8xdUfBn2Wbg4TotgaVrS7QX7fk/aHjhyaN86f1PIQ2E8cHfGqhSidMzMTEAWD7uaEByDXa/XyDR0e9i23vSW0ANIyCxzrJ/+1/ZrwF3+nUYMqvlNk1Jbb3a2xotyFUHdnrSSKPofHgD3hzBEQN1RpBwyAOMhSql65wJUB6sWDp7OV3HqtRxt+PvGwwNY7O0VSDuFIslNEvxRfNKRHmE3DYzz6s8413KXsDK9YzazQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+luTo3Kv0VZPyF9rgeBFqg3lNgsnIxhuXwfTR0qPY4k=;
 b=VQylsDleUfkGOnnfmuocxHbkIwkrqOB52Pwqd6PYltVbFqxGLg4rwOSSUXzyjAMcTqQORD1d7nkXtpeWlSn1OXbcoFICoIe2P2Zo/Uzi/A8+yqamDxFTDpSJGCgAujckqrhWUs5ReexLDXjfElxgZbjf+Tb4+h4To2t8zdeV/ga7NAVZT7oRI5w7EsKRyitWTQYOGeLdN68/hBiPnrp+FgUU2QWShRxy44PS3F/FWBDB42RVCseaVZV7OYwmkx9Lfi0zHNErXj3AnzPS4O+ddJbDlPyIwtdkxWKzgwJOCHOKkXfTJMrNYeVo4a5wPYuUimJHABhwAfX5QcSTZ35MnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+luTo3Kv0VZPyF9rgeBFqg3lNgsnIxhuXwfTR0qPY4k=;
 b=pDbYq62b1Ya4Wh39LErTie8QR7OFQgqObwWNn70JCeVTtRbUoyHvCXYFUU7D79v7lmGbocuQVgFdNIXAOf0HTCouCcMwCIabBUhNvJdwACjuNc/uDIlQGl4FjI8FtnlZkqma6MgrEZPCliIBdwV3qWxki9oq94ZZGr2Wi9ZoCxo=
Received: from MN2PR01CA0041.prod.exchangelabs.com (2603:10b6:208:23f::10) by
 PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.18; Fri, 6 Dec 2024 22:11:25 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::9f) by MN2PR01CA0041.outlook.office365.com
 (2603:10b6:208:23f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Fri,
 6 Dec 2024 22:11:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 22:11:24 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Dec 2024 16:11:23 -0600
From: Andrew Martin <Andrew.Martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <alexandru.tudor@amd.com>,
 <andrew.martin@amd.com>, Andrew Martin <Andrew.Martin@amd.com>
Subject: [PATCH] drm/amdkfd: Failed to check various return code
Date: Fri, 6 Dec 2024 17:11:10 -0500
Message-ID: <20241206221110.2898199-1-Andrew.Martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|PH7PR12MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 90385013-2ec8-428e-d139-08dd1642ec4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D4DelGAhRNlb9RLrn1ec0y3gX0cpPrMQmbnIeSqQCXiOx4DFZ15Mp7tQ5EEQ?=
 =?us-ascii?Q?i8zcr7dWbHOhPH31N2Z1D0TuY3YSXtvlcTkpY8icoSmS2CJLL0BwT2pkkK+H?=
 =?us-ascii?Q?rXDfqIA7i0w0IKpvsgjQkQB6ViZj65sGtNpfvCr9G5KiRh7TZEBzPaM5SytB?=
 =?us-ascii?Q?Kp5NgtEZHg3EQS/PTovFHHRw/J/ByiAzFtclx5cU0uKaGduNDBoLW9DIh0rx?=
 =?us-ascii?Q?CYwtxDjD439rrCZsNvOSRLpcFB0fCcEQSo/RTHPqKFzZnwtXZQDUB3mQYd87?=
 =?us-ascii?Q?kXLD3xAUY91SDbK4uxhTYZDvGBy0+bnRsT3DXdxtDt8PFcsQ//sUj41W5uRI?=
 =?us-ascii?Q?QAEjhWYJnZDJNaqo2qFCYj2uclnBAULi0Mj9i9ti35ETdHIUOFPC+CwJ2myi?=
 =?us-ascii?Q?5pY0TPi+vV5VCbUQZAXaxsti5Y58fm3T0sDj21oiOcAYksVOx4mnRsn04x2k?=
 =?us-ascii?Q?fDZtnW795rjRAyeFS0rBtFk6uvsg0OCEnh8HD5ztTozcA9ZYuiZnwYEnZeDZ?=
 =?us-ascii?Q?zjQ+zgrQOS/BTCqp+XL8k1NDjaGWdRDGQ/OoPFZD+nXxUZyNYGzmw6SnkJvj?=
 =?us-ascii?Q?ZEloRUEhbczlAlyMII5tFexiUEPOWfXRnD53TPgoCRm0M4pdkNkopJamDl+3?=
 =?us-ascii?Q?/urvr6csordvSs8of6zMTKWXoJ5go7oQb09nCuu0JTrFecx2Dj3eY+7vcMv+?=
 =?us-ascii?Q?Gb0IIvJmxJTDRwuQDYx/bKN40CnQ6Ml47sPbnAtMVfUJMwqRxFTApX1xNZLz?=
 =?us-ascii?Q?5demSuc+730gP3rqodDhFdznlnO7d/GFRkLgScACnt0cUhoenAFLfCBNG9GJ?=
 =?us-ascii?Q?6clSiFXHEGraXU1dl5xfnhbmWSxwsr8w2XmkrRtbTgTvm2iiZNHB7rTpFF/3?=
 =?us-ascii?Q?QvdCXo1UzG0qf3jsedIdUIZCHXYtwIM5P3mIwHIV9wlw6WSp+AeaOocOepwG?=
 =?us-ascii?Q?r5z49zLmKQ65jWV/sCElum2OkofR+DG4hwkr1nBHzkPXAtXHyGODl3tXzhxY?=
 =?us-ascii?Q?EpgtcCQy2zajBPk1s8lepVuWfOlRtSzUdGbNjdPMBiq1L+/rVga5wnmSITE4?=
 =?us-ascii?Q?L2AF1bEG+3JMQLd77znN65l8T4bkm1xe2QwMo+wP3sYpiLrUJRzg+lJJjoXO?=
 =?us-ascii?Q?sD4L5zWVqwaFAG/fQIYIwzOqvYByKK6ymu+ZbwsprK/FpjKpTkEgVbXv2Eyj?=
 =?us-ascii?Q?TJ2o0fH591ikW7Wk1LqgPTHtbHx5IGWHSpDgLB+KT8XEa1+AjOr45Oe8XcbF?=
 =?us-ascii?Q?xnxcT9cU6JOsJWzIKLONCnI9gyCa2MWnLM5DA724oyq8JBq64LLjIMT6tDnu?=
 =?us-ascii?Q?Cn9sIfv/4w9A+9Exj01FNk1sbPv4waAFH4emNDmwe93AjJ+B66WRgdE/oGfQ?=
 =?us-ascii?Q?T2pHe83CvUdgh71oEOo15HnFb+svlm6nv5mVpAvitv0yUw3rkuyUUTJMnzso?=
 =?us-ascii?Q?9EjChY1LeOsiDYo9qCM0ARar1tbrPV3n?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 22:11:24.3832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90385013-2ec8-428e-d139-08dd1642ec4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282
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

Clean up code to quiet the compiler on us failing to check the return
code.

Signed-off-by: Andrew Martin <Andrew.Martin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 14 +++++++-------
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  3 +++
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 503051352922..de30143ea51b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -368,7 +368,7 @@ void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj)
 {
 	struct amdgpu_bo **bo = (struct amdgpu_bo **) mem_obj;
 
-	amdgpu_bo_reserve(*bo, true);
+	(void)amdgpu_bo_reserve(*bo, true);
 	amdgpu_bo_kunmap(*bo);
 	amdgpu_bo_unpin(*bo);
 	amdgpu_bo_unreserve(*bo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index f30548f4c3b3..1e998f972c30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -730,7 +730,7 @@ kfd_mem_dmaunmap_userptr(struct kgd_mem *mem,
 		return;
 
 	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
-	ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+	(void)ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 
 	dma_unmap_sgtable(adev->dev, ttm->sg, direction, 0);
 	sg_free_table(ttm->sg);
@@ -779,7 +779,7 @@ kfd_mem_dmaunmap_sg_bo(struct kgd_mem *mem,
 	}
 
 	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
-	ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+	(void)ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 
 	dir = mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ?
 				DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
@@ -989,7 +989,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 		if (!attachment[i])
 			continue;
 		if (attachment[i]->bo_va) {
-			amdgpu_bo_reserve(bo[i], true);
+			(void)amdgpu_bo_reserve(bo[i], true);
 			if (--attachment[i]->bo_va->ref_count == 0)
 				amdgpu_vm_bo_del(adev, attachment[i]->bo_va);
 			amdgpu_bo_unreserve(bo[i]);
@@ -1259,11 +1259,11 @@ static int unmap_bo_from_gpuvm(struct kgd_mem *mem,
 		return -EBUSY;
 	}
 
-	amdgpu_vm_bo_unmap(adev, bo_va, entry->va);
+	(void)amdgpu_vm_bo_unmap(adev, bo_va, entry->va);
 
-	amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
+	(void)amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
 
-	amdgpu_sync_fence(sync, bo_va->last_pt_update);
+	(void)amdgpu_sync_fence(sync, bo_va->last_pt_update);
 
 	return 0;
 }
@@ -2352,7 +2352,7 @@ void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem)
 {
 	struct amdgpu_bo *bo = mem->bo;
 
-	amdgpu_bo_reserve(bo, true);
+	(void)amdgpu_bo_reserve(bo, true);
 	amdgpu_bo_kunmap(bo);
 	amdgpu_bo_unpin(bo);
 	amdgpu_bo_unreserve(bo);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c79fe9069e22..2f955c76fc56 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2373,6 +2373,9 @@ static int wait_on_destroy_queue(struct device_queue_manager *dqm,
 								q->process);
 	int ret = 0;
 
+	if (WARN_ON(!pdd))
+		return ret;
+
 	if (pdd->qpd.is_debug)
 		return ret;
 
-- 
2.43.0

