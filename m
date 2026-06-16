Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B192DCD98EF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 21:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FCF910E859;
	Tue, 16 Jun 2026 21:17:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="igwgdRtk";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E491710E85F
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 21:17:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mn7yJog/VO0xKzrmNNShYG4ykeezWXZZK55UQ7apT0GVzU5Bou91kNPh32fnBTtd+h653slvYk9W4z0hhiuAwOHxnWjqUmxbYMN3ltjxGvuIQh/oanQLP3jRQolYensAccGW4injgxONxQ41X4ffyYPjXoc6U5a3N/8rLctgBqmUDxasPhocFciCJZ6CqBJ/9HhMieSh/SBlH/ri1M3jFxP31SnNsvAno/4WltEhn0qc0hiPg+2ilsvb1xoHP88dx+XfVcC4ZIZuMEp0sVTgyAGVxgH/Ns1HnAmsjfaWo8hTcxZA4E4UUFqOUOaarJFhYIULIQNkr7wovvEbxAkf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/NLRBxHJ9UVdnDwsQ72dk2hNqH4YZzZ7TOas3vhHMw=;
 b=QUL032Lk5zlvS9PASS+J+ZbA+z/BFLKZIJKdGg1D9AGPwvvexRju34XGbNj25MkYheJu1gKJuMC35MLBC43TMLcRUW7jHPQf48R8x9uNCgFBBGdgjhe7uN3OvKJeaGuPFpisap5uJF7qN5EsDg9R9l766BdbxnXOT/hKVl96HnDXgRiJ0lkeT/0LL1vLVOzfHCIpYSpCmGJItqZITf6d2WVtfzEKmhggdG6pz7cyTMBVhVvjpUvS53mEhxMg/s5oCtP/MbatuD3YrDTqF0msqMCgoncg3/jJnO166L4XojrMjjfgpdwzi8aJUx+Z2YYh5YhBCOYfEup5XuzhbxbvHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/NLRBxHJ9UVdnDwsQ72dk2hNqH4YZzZ7TOas3vhHMw=;
 b=igwgdRtklKT6TnM3I7zz2p2VW+ogpMfXcdxwXNWblAkdVPnaLqjcGopfsS66IxBQZKWgpwXCqxCsPti+Rg2HrvUU2Wa+7O9TQk13j/ThnDvulXjyTZrdVjT7SaWKtgEaQhnnp/o8Q5xS9T2Lyx1zh1hPPlRIb1PiAnwB8jRCo7E=
Received: from BL1PR13CA0313.namprd13.prod.outlook.com (2603:10b6:208:2c1::18)
 by SA1PR12MB5640.namprd12.prod.outlook.com (2603:10b6:806:23e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Tue, 16 Jun
 2026 21:17:27 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::55) by BL1PR13CA0313.outlook.office365.com
 (2603:10b6:208:2c1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Tue,
 16 Jun 2026 21:17:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 21:17:26 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 16:17:25 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Amir.Shetaia@amd.com>,
 <Kent.Russell@amd.com>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: Unmap svm range when all GPUs set to no-access
Date: Tue, 16 Jun 2026 17:16:51 -0400
Message-ID: <20260616211652.1962285-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260616211652.1962285-1-Philip.Yang@amd.com>
References: <20260616211652.1962285-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|SA1PR12MB5640:EE_
X-MS-Office365-Filtering-Correlation-Id: d7dfac71-98ea-41cf-ef85-08decbecaa6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|5023799004|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kjacr7iP3Ux/ctvCSQQtTfCb3ai2CbizD3u271nHKL74M8NvXje5sRRqNxBoWf+CwTRMqjG7kidANuvgvDLIsMSS7I9YQGAlAzvC2qvOaDW+xbHC5gJTfTe6r+w93blSuq10bRKRn5uzeGoDW7Dj2gxfNWGD6GFZmRFD1te7m9h/P22b3Lk5hMs56C5QoMNrS4TuFJqYeiao1qsWroXV/LX66APn2vUssOU44O1x3qp/tNJhIBGn3JjQkVzQKKehv7jzCY+ZlvD0uAAPZafd9IIRZUYOixsTeJ4B5vu5xqeKDrcAHceKmVm4GBCFYn0qUcKI1CDY4OXFwzH71aZeVbIt+doynfABM1A7XZ3ixpU3ZMJCKZUykSIo2tprZ5cKxBkdFn6C3IpIaP7EE6S+aEibx8loDQd6s1pFznbQQBDhpGSvNowPNPnTUZfHh6YkXDmROx2MMrNImR/AK4+LXSqdtzIM1ia1ypTTRX1V0PCKb/aIwb7BSLUDMOrfCkAG7R87+m7cg5E2Bf1D/hiHGZ1beJwKzQDMlvFxK4nUWmoz0ZH6PExuD3q0EmnRAQC/Klv+QaI318pPDy/6duGx9uQjKP01WCoFrgqVoHscG/PeOg443af9EJd/36/LrJyfo91W3lIAnCKl5WM2/oPPJ5lMfRIffaRBFs29/4xSaoyx7mPxSnXG9E0YvgUeEDStMRidX39JkZU2CyZY6pLQ9kE/6QXRJPgq7O2kPTkT+AA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(5023799004)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8iTjtplUBjeOVcCvy1zCWYgOOi2f+v+Zz0UDllX90n7nBqBcON4EP+GFdkluQl0tZBOuI/8pkLIFmWnDDj7C/KkOvHB/+TN3uH5NjgCNCsUB2NecD5z3m0crNHqmqfHKSnH4bT+jmtlxGrFNL4GDcouSfrOljfVH+SK7APyqOraP1Fz4R1u+9hJz76H9VPJssk/GBWi9F0z5mV8xuB0kBa66YubfBxw7IlDwtyQ8SY4iniojIB9OPHNmrh709wnUyDl+7DqxLew/44QYxuMFf2bODT4XdU2at+mwNRovycoN6uXNrPv7fAx41FDyoCZssJ35AzPZ+jlXAUG4gE5tO1wBpRtClsoRP4IjQ+6RqGNyMsRpOYpfSl66Wf4tYHc/RDVw1PG4KMcWZYefFBX63+WDX0u+SqHd+uIWtNdFFLZWeizFJ5swORH7fsTjwOdw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 21:17:26.4801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7dfac71-98ea-41cf-ef85-08decbecaa6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5640
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

When KFD_IOCTL_SVM_ATTR_NO_ACCESS is applied to all GPUs that have an
SVM range mapped, unmap the range so the MMU notifier can skip queue
eviction — safe because no GPU will access it.

Replace the mapped_to_gpu boolean with bitmap_mapped to track which
GPUs currently have the range mapped. Set bits in svm_range_map_to_gpus()
and clear them in svm_range_unmap_from_gpus(). This is separate from
bitmap_access/bitmap_aip which track user-requested attributes and must
not be used to determine mapping state.

Add bitmap_needs_unmap to svm_range, set when a GPU is given no-access.
Add svm_range_needs_unmap() to trigger the unmap once bitmap_needs_unmap
equals bitmap_mapped, i.e. all mapped GPUs are set to no-access.

v4:
 - Rename and set prange->mapping_done to false if validate and map not
   complete successfully (Felix)
v3:
 - Correct error handling, support app retry update mapping (Felix)
v2:
 - Add bitmap_mapped to not break get_attr (Felix)

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 103 ++++++++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |   7 +-
 3 files changed, 73 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 9d4838461168..5d55407069a4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -111,12 +111,11 @@ static int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u6
 		if (!prange)
 			break;
 
-		if (!prange->mapped_to_gpu)
-			break;
-
 		r = kfd_process_gpuid_from_node(p, pdd->dev, &gpuid, &gpuidx);
 		if (r < 0)
 			break;
+		if (!test_bit(gpuidx, prange->bitmap_mapped))
+			break;
 		if (!test_bit(gpuidx, prange->bitmap_access) &&
 		    !test_bit(gpuidx, prange->bitmap_aip))
 			break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index df7fca65e9a2..e039b6f2942f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -786,6 +786,7 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 			if (attrs[i].type == KFD_IOCTL_SVM_ATTR_NO_ACCESS) {
 				bitmap_clear(prange->bitmap_access, gpuidx, 1);
 				bitmap_clear(prange->bitmap_aip, gpuidx, 1);
+				bitmap_set(prange->bitmap_needs_unmap, gpuidx, 1);
 			} else if (attrs[i].type == KFD_IOCTL_SVM_ATTR_ACCESS) {
 				bitmap_set(prange->bitmap_access, gpuidx, 1);
 				bitmap_clear(prange->bitmap_aip, gpuidx, 1);
@@ -1076,9 +1077,10 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
 	new->prefetch_loc = old->prefetch_loc;
 	new->actual_loc = old->actual_loc;
 	new->granularity = old->granularity;
-	new->mapped_to_gpu = old->mapped_to_gpu;
+	new->mapping_done = old->mapping_done;
 	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
 	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
+	bitmap_copy(new->bitmap_mapped, old->bitmap_mapped, MAX_GPU_INSTANCE);
 	atomic_set(&new->queue_refcount, atomic_read(&old->queue_refcount));
 
 	return 0;
@@ -1379,7 +1381,8 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 static int
 svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
-			  unsigned long last, uint32_t trigger)
+			  unsigned long last, unsigned long *bitmap_unmap,
+			  uint32_t trigger)
 {
 	struct kfd_process_device *pdd;
 	struct dma_fence *fence = NULL;
@@ -1387,21 +1390,15 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 	uint32_t gpuidx;
 	int r = 0;
 
-	if (!prange->mapped_to_gpu) {
-		pr_debug("prange 0x%p [0x%lx 0x%lx] not mapped to GPU\n",
-			 prange, prange->start, prange->last);
-		return 0;
-	}
-
-	if (prange->start == start && prange->last == last) {
-		pr_debug("unmap svms 0x%p prange 0x%p\n", prange->svms, prange);
-		prange->mapped_to_gpu = false;
-	}
-
 	p = container_of(prange->svms, struct kfd_process, svms);
 
-	for_each_or_bit(gpuidx, prange->bitmap_access, prange->bitmap_aip, MAX_GPU_INSTANCE) {
-		pr_debug("unmap from gpu idx 0x%x\n", gpuidx);
+	for_each_set_bit(gpuidx, bitmap_unmap, MAX_GPU_INSTANCE) {
+		if (prange->start == start && prange->last == last) {
+			pr_debug("unmap svms 0x%p prange 0x%p from gpu_idx 0x%x\n",
+				 prange->svms, prange, gpuidx);
+			clear_bit(gpuidx, prange->bitmap_mapped);
+		}
+
 		pdd = kfd_process_device_from_gpuidx(p, gpuidx);
 		if (!pdd) {
 			pr_debug("failed to find device idx %d\n", gpuidx);
@@ -1554,6 +1551,8 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 			continue;
 		}
 
+		set_bit(gpuidx, prange->bitmap_mapped);
+
 		r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
 					 prange->dma_addr[gpuidx],
 					 bo_adev, wait ? &fence : NULL,
@@ -1699,7 +1698,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		bitmap_zero(ctx->bitmap, MAX_GPU_INSTANCE);
 		bitmap_set(ctx->bitmap, gpuidx, 1);
 	} else if (ctx->process->xnack_enabled) {
-		bitmap_copy(ctx->bitmap, prange->bitmap_aip, MAX_GPU_INSTANCE);
+		/* Update mapping on already mapped or access in place GPU */
+		bitmap_or(ctx->bitmap, prange->bitmap_mapped, prange->bitmap_aip,
+			  MAX_GPU_INSTANCE);
 
 		/* If prefetch range to GPU, or GPU retry fault migrate range to
 		 * GPU, which has ACCESS attribute to the range, create mapping
@@ -1719,14 +1720,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 
 		/*
-		 * If prange is already mapped or with always mapped flag,
-		 * update mapping on GPUs with ACCESS attribute
+		 * If prange with always mapped flag, update mapping on GPUs with
+		 * ACCESS attribute
 		 */
-		if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
-			if (prange->mapped_to_gpu ||
-			    prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
-				bitmap_copy(ctx->bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
-		}
+		if (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
+			bitmap_or(ctx->bitmap, ctx->bitmap, prange->bitmap_access,
+				  MAX_GPU_INSTANCE);
 	} else {
 		bitmap_or(ctx->bitmap, prange->bitmap_access,
 			  prange->bitmap_aip, MAX_GPU_INSTANCE);
@@ -1792,6 +1791,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 				e = min(end, prange->last);
 				if (e >= s)
 					r = svm_range_unmap_from_gpus(prange, s, e,
+						       prange->bitmap_mapped,
 						       KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
 				svm_range_unlock(prange);
 				/* If unmap returns non-zero, we'll bail on the next for loop
@@ -1854,7 +1854,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 
 		if (!r && next == end)
-			prange->mapped_to_gpu = true;
+			prange->mapping_done = true;
+		else
+			prange->mapping_done = false;
 
 		svm_range_unlock(prange);
 
@@ -2024,10 +2026,10 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 	if (!p->xnack_enabled ||
 	    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) {
 		int evicted_ranges;
-		bool mapped = prange->mapped_to_gpu;
+		bool mapped = !bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE);
 
 		list_for_each_entry(pchild, &prange->child_list, child_list) {
-			if (!pchild->mapped_to_gpu)
+			if (bitmap_empty(pchild->bitmap_mapped, MAX_GPU_INSTANCE))
 				continue;
 			mapped = true;
 			mutex_lock_nested(&pchild->lock, 1);
@@ -2076,13 +2078,14 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 			s = max(start, pchild->start);
 			l = min(last, pchild->last);
 			if (l >= s)
-				svm_range_unmap_from_gpus(pchild, s, l, trigger);
+				svm_range_unmap_from_gpus(pchild, s, l, prange->bitmap_mapped,
+							  trigger);
 			mutex_unlock(&pchild->lock);
 		}
 		s = max(start, prange->start);
 		l = min(last, prange->last);
 		if (l >= s)
-			svm_range_unmap_from_gpus(prange, s, l, trigger);
+			svm_range_unmap_from_gpus(prange, s, l, prange->bitmap_mapped, trigger);
 	}
 
 	return r;
@@ -2112,10 +2115,11 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 	new->prefetch_loc = old->prefetch_loc;
 	new->actual_loc = old->actual_loc;
 	new->granularity = old->granularity;
-	new->mapped_to_gpu = old->mapped_to_gpu;
+	new->mapping_done = old->mapping_done;
 	new->vram_pages = old->vram_pages;
 	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
 	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
+	bitmap_copy(new->bitmap_mapped, old->bitmap_mapped, MAX_GPU_INSTANCE);
 	atomic_set(&new->queue_refcount, atomic_read(&old->queue_refcount));
 
 	return new;
@@ -2235,7 +2239,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 		next_start = min(node->last, last) + 1;
 
 		if (svm_range_is_same_attrs(p, prange, nattr, attrs) &&
-		    prange->mapped_to_gpu) {
+		    prange->mapping_done) {
 			/* nothing to do */
 		} else if (node->start < start || node->last > last) {
 			/* node intersects the update range and its attributes
@@ -2616,14 +2620,14 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 		s = max(start, pchild->start);
 		l = min(last, pchild->last);
 		if (l >= s)
-			svm_range_unmap_from_gpus(pchild, s, l, trigger);
+			svm_range_unmap_from_gpus(pchild, s, l, prange->bitmap_mapped, trigger);
 		svm_range_unmap_split(prange, pchild, start, last);
 		mutex_unlock(&pchild->lock);
 	}
 	s = max(start, prange->start);
 	l = min(last, prange->last);
 	if (l >= s)
-		svm_range_unmap_from_gpus(prange, s, l, trigger);
+		svm_range_unmap_from_gpus(prange, s, l, prange->bitmap_mapped, trigger);
 	svm_range_unmap_split(prange, prange, start, last);
 
 	if (unmap_parent)
@@ -3706,6 +3710,23 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 	svm_range_bo_unref(svm_bo);
 }
 
+static bool svm_range_needs_unmap(struct kfd_process *p, struct svm_range *prange)
+{
+	if (bitmap_empty(prange->bitmap_needs_unmap, MAX_GPU_INSTANCE))
+		return false;
+
+	pr_debug("prange 0x%p no access set for [0x%lx 0x%lx]\n",
+		 prange, prange->start, prange->last);
+
+	svm_range_unmap_from_gpus(prange, prange->start,
+				  prange->last, prange->bitmap_needs_unmap,
+				  KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
+
+	bitmap_clear(prange->bitmap_needs_unmap, 0, MAX_GPU_INSTANCE);
+
+	return bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE);
+}
+
 static int
 svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		   uint64_t start, uint64_t size, uint32_t nattr,
@@ -3761,10 +3782,10 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		svm_range_add_to_svms(prange);
 		svm_range_add_notifier_locked(mm, prange);
 	}
-	list_for_each_entry(prange, &update_list, update_list) {
+
+	list_for_each_entry(prange, &update_list, update_list)
 		svm_range_apply_attrs(p, prange, nattr, attrs, &update_mapping);
-		/* TODO: unmap ranges from GPU that lost access */
-	}
+
 	update_mapping |= !p->xnack_enabled && !list_empty(&remap_list);
 
 	list_for_each_entry_safe(prange, next, &remove_list, update_list) {
@@ -3785,6 +3806,9 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	list_for_each_entry(prange, &update_list, update_list) {
 		bool migrated;
 
+		if (svm_range_needs_unmap(p, prange))
+			continue;
+
 		mutex_lock(&prange->migrate_mutex);
 
 		r = svm_range_trigger_migration(mm, prange, &migrated);
@@ -3793,7 +3817,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 		if (migrated && (!p->xnack_enabled ||
 		    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
-		    prange->mapped_to_gpu) {
+		    !bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE)) {
 			pr_debug("restore_work will update mappings of GPUs\n");
 			mutex_unlock(&prange->migrate_mutex);
 			continue;
@@ -3804,7 +3828,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 			continue;
 		}
 
-		flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
+		flush_tlb = !migrated && update_mapping &&
+			    !bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE);
 
 		r = svm_range_validate_and_map(mm, prange->start, prange->last, prange,
 					       MAX_GPU_INSTANCE, true, true, flush_tlb);
@@ -3818,11 +3843,13 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	}
 
 	list_for_each_entry(prange, &remap_list, update_list) {
+		flush_tlb = !bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE);
+
 		pr_debug("Remapping prange 0x%p [0x%lx 0x%lx]\n",
 			 prange, prange->start, prange->last);
 		mutex_lock(&prange->migrate_mutex);
 		r = svm_range_validate_and_map(mm,  prange->start, prange->last, prange,
-					       MAX_GPU_INSTANCE, true, true, prange->mapped_to_gpu);
+					       MAX_GPU_INSTANCE, true, true, flush_tlb);
 		if (r)
 			pr_debug("failed %d on remap svm range\n", r);
 		mutex_unlock(&prange->migrate_mutex);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index a63dfc95b602..0da635532aff 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -100,6 +100,9 @@ struct svm_work_list_item {
  * @child_list: list header for split ranges which are not added to svms yet
  * @bitmap_access: index bitmap of GPUs which can access the range
  * @bitmap_aip: index bitmap of GPUs which can access the range in place
+ * @bitmap_needs_unmap: index bitmap of GPUs which currently set NO_ACCESS
+ * @bitmap_mapped: index bitmap of GPUs which currently have the range mapped
+ * @mapping_done: true if range_validate_and_map complete successfully
  *
  * Data structure for virtual memory range shared by CPU and GPUs, it can be
  * allocated from system memory ram or device vram, and migrate from ram to vram
@@ -135,7 +138,9 @@ struct svm_range {
 	struct list_head		child_list;
 	DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
 	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
-	bool				mapped_to_gpu;
+	DECLARE_BITMAP(bitmap_needs_unmap, MAX_GPU_INSTANCE);
+	DECLARE_BITMAP(bitmap_mapped, MAX_GPU_INSTANCE);
+	bool				mapping_done;
 	atomic_t			queue_refcount;
 };
 
-- 
2.50.1

