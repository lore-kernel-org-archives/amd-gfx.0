Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519CDC531D0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2026 19:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC87E10E2F4;
	Mon, 27 Jul 2026 19:40:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VfXQAWlA";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EE3710E2F5
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 19:40:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Abqnz9bJlndp6i1irBXhOk7x5sMx7TGFogb9UBjainXmTuK+tn/IUUW3mOnvFZEeNL9w8rfT/nMdh9+SiwnCBR/L5ACwMC0QTpOgGLPjtZklzOQ+HPIGX7z0zhy0sqWLHxmglgPRk6BBgWJPbnk0iPo4Wue8yat7MbJLcbXTbYhucDUWqdkXOlnAYazYlXdN5NtIxw0pU6RrDtch2hFg57TI5zNm+beL2NEJHIoAYxZsz70BUAZsseGyEUeX1eLdVkUNGqr4MNrtRaNXzGfvmoxCE+AEH0Xs877AyoClzhvPan3U6j9M3glPV1kfLryk42FqCgefsIRwxch8rbH9QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMhogADDSD24afPzKAKKN5jToGF9t842doK1B102MPA=;
 b=I/ZAP2/tVNXMDfsLTEhtc8j6laUbB5Vn4p77pv2p/rgCNGTEc49b/qa4Yk1qpNry+O+vMekniGJxQxcGRc1K4zqjXvvpMYG2MXcGubMvv+dOXz2fzxZMW8qUBBVoV9Nkp8Om10pzeLV0E+xQfGRTZAZ4RiLvB/DhA8seOQxI+ZZUXsOU7QKC+/sFGW9tVBD2pv5Qwo3aL6pWM5VQ9lYFG+FTaKFXzGxnOhdUIzdlFLp/8Hh8mi43CsCJdkxfuDYHjgkla6B/SUS6sYAra3v0rOalF49XBaA/7lbUqoIQJxJZ7JA6gpQY8lxXeBOOjSh9dMJegDiZsvss5wissw2Vew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMhogADDSD24afPzKAKKN5jToGF9t842doK1B102MPA=;
 b=VfXQAWlAtk3DLo0Mk35w4jceGSB6jfDkQBseAVzx9trkNXmZQ93xt0XiSyDPyyhVFx5H8rnmdUeQpeX4pkNb/E/u8m6WE4PAW0Sjbj+Ca6XxZbIVV/ww0SHeak1lO+ibXyf+2ybLYwQYwwdd2fn6hylwwppN5Feyggy1swc3Goo=
Received: from MN2PR06CA0024.namprd06.prod.outlook.com (2603:10b6:208:23d::29)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 19:39:59 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:208:23d:cafe::19) by MN2PR06CA0024.outlook.office365.com
 (2603:10b6:208:23d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 19:39:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.1 via Frontend Transport; Mon, 27 Jul 2026 19:39:59 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 14:39:56 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Amir.Shetaia@amd.com>,
 <Kent.Russell@amd.com>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 2/2] drm/amdkfd: Unmap svm range from GPU set to no-access
Date: Mon, 27 Jul 2026 15:39:30 -0400
Message-ID: <20260727193930.612490-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260727193930.612490-1-Philip.Yang@amd.com>
References: <20260727193930.612490-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|MW4PR12MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f2a5c2c-85f0-40c7-a112-08deec16d805
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|6133799003|18002099003|22082099003|56012099006|5023799004|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: Z8IxlPvZecAbXbtNOcBLkdcQXywJdr3Ck9Z63Cgp4ZkFWv3UNsB10e6uSmRGBpS0ghwNUneZUPyp4J63haPtf6RE6jxugwnaMMZ8BXrSO1oGNrtJVklP1AC2wYvkNd/RF8AZduFJDYyRxb3rCcaf7SJydl8sh4HcvV6L64i9fci3W6SRCKgSJIWN7GfcY1alF88YuJuH2v7Nc3My9/vbvlKTdy4CzYXf+xFrz4UcJOai4lM8WUudWYDbxeNNOxEZzxuQ8nHy+ecYZ//EvZTfsIuiTGVv6Sla3WMbvSUy2GMnbyYDwuT3dZMHhSJyu2xPqoINs0UuyLD0PmpNyTgXge8qnH2sLNsSjhr4WAbDYOek4F+PKXx6Er4vu2OYI+BKZ1JJ4yrCx4s/NW/c1FUMUo4BcYvLb4ddS8H1nxfPopXAV+mh0c5fkY+6LHLWutnzVQEpSPDmM9k8Gj9ex4OOb6y1patCVaw8kBxg5QNAoAqYKpzidzJssVRcZNCevi64GhVfdcFS/vzBJEIKoEdrf5HsCRXG1HvrYnG0+RH9MPqs9t0jDF9IeGcHZ3o6O0mC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3krOJrYJr9QVjI5ufAxP90vhzsZCwNNCmtFFfo2hCYXFJdIlNNX3ZgAd/kGl6grWWzmDVF5RP4C89r/rbiucxzJPsLPp4EnCesihyvj8X5Re35m6oSxGZ24JB14aQt7yVJjuOoE8nskRI2//Np1H5dXnXdzyPTtZy0uitizwfkSu3eWpN5yM39yRxQ2onXqvOg2yZlcWriMC2wbWbOdbCAxkAPK526btKarNkPPEjf+ft+boLrDxnaEmDIX/tBYRmSuoEgY5KhW2UdVJEw+Rqt9hsTxnewEdDiv1hUeXrwTFIlFiPVzdf0S0kTsrzDQZ41SVtAKX7WmZeuguZSl/FragtOpke1pbWaC1CXyJ2lrVFZFzTTrNq2vkt0tqzE8Tfd0GZ2w1w5VoGK80HzKMLN0+tOl1ORvpABwfGdPRpYkF++rzc4Ia5Q2OIcgC3rqp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 19:39:59.0401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2a5c2c-85f0-40c7-a112-08deec16d805
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665
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

When KFD_IOCTL_SVM_ATTR_NO_ACCESS is applied to a GPU that has an SVM
range mapped, unmap the range from that GPU. Once no GPU maps the range,
the MMU notifier can skip queue eviction on CPU page faults.

Replace the mapped_to_gpu boolean with bitmap_mapped to track which
GPUs currently have the range mapped. Set bits in svm_range_map_to_gpus()
and clear them in svm_range_unmap_from_gpus(). This is separate from
bitmap_access/bitmap_aip which track user-requested attributes and must
not be used to determine mapping state.

Add bitmap_needs_unmap to svm_range, set for each GPU given no-access.
Add svm_range_needs_unmap() to unmap the range from those GPUs when the
app sets the no-access attribute.

Bump the checkpoint timestamp on unmap so retry faults queued before the
no-access unmap are dropped instead of restoring the mapping.

v4:
 - Rename and set prange->mapping_done to false if validate and map not
   complete successfully (Felix)
v3:
 - Correct error handling, support app retry update mapping (Felix)
v2:
 - Add bitmap_mapped to not break get_attr (Felix)

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 107 ++++++++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |   7 +-
 3 files changed, 77 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index b249e7d1af48..25954c2c2d91 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -112,12 +112,11 @@ static int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u6
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
index c10d4edc8813..1a01d089b132 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -826,8 +826,13 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 			gpuidx = kfd_process_gpuidx_from_gpuid(p,
 							       attrs[i].value);
 			if (attrs[i].type == KFD_IOCTL_SVM_ATTR_NO_ACCESS) {
+				svm_range_update_checkpoint_timestamp(p);
+
 				bitmap_clear(prange->bitmap_access, gpuidx, 1);
 				bitmap_clear(prange->bitmap_aip, gpuidx, 1);
+
+				if (test_bit(gpuidx, prange->bitmap_mapped))
+					bitmap_set(prange->bitmap_needs_unmap, gpuidx, 1);
 			} else if (attrs[i].type == KFD_IOCTL_SVM_ATTR_ACCESS) {
 				bitmap_set(prange->bitmap_access, gpuidx, 1);
 				bitmap_clear(prange->bitmap_aip, gpuidx, 1);
@@ -1118,9 +1123,10 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
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
@@ -1421,7 +1427,8 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 static int
 svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
-			  unsigned long last, uint32_t trigger)
+			  unsigned long last, unsigned long *bitmap_unmap,
+			  uint32_t trigger)
 {
 	struct kfd_process_device *pdd;
 	struct dma_fence *fence = NULL;
@@ -1429,21 +1436,15 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
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
@@ -1596,6 +1597,8 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 			continue;
 		}
 
+		set_bit(gpuidx, prange->bitmap_mapped);
+
 		r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
 					 prange->dma_addr[gpuidx],
 					 bo_adev, wait ? &fence : NULL,
@@ -1741,7 +1744,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		bitmap_zero(ctx->bitmap, MAX_GPU_INSTANCE);
 		bitmap_set(ctx->bitmap, gpuidx, 1);
 	} else if (ctx->process->xnack_enabled) {
-		bitmap_copy(ctx->bitmap, prange->bitmap_aip, MAX_GPU_INSTANCE);
+		/* Update mapping on already mapped or access in place GPU */
+		bitmap_or(ctx->bitmap, prange->bitmap_mapped, prange->bitmap_aip,
+			  MAX_GPU_INSTANCE);
 
 		/* If prefetch range to GPU, or GPU retry fault migrate range to
 		 * GPU, which has ACCESS attribute to the range, create mapping
@@ -1761,14 +1766,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
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
@@ -1834,6 +1837,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 				e = min(end, prange->last);
 				if (e >= s)
 					r = svm_range_unmap_from_gpus(prange, s, e,
+						       prange->bitmap_mapped,
 						       KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
 				svm_range_unlock(prange);
 				/* If unmap returns non-zero, we'll bail on the next for loop
@@ -1896,7 +1900,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 
 		if (!r && next == end)
-			prange->mapped_to_gpu = true;
+			prange->mapping_done = true;
+		else
+			prange->mapping_done = false;
 
 		svm_range_unlock(prange);
 
@@ -2066,10 +2072,10 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
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
@@ -2118,13 +2124,14 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
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
@@ -2154,10 +2161,11 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
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
@@ -2277,7 +2285,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 		next_start = min(node->last, last) + 1;
 
 		if (svm_range_is_same_attrs(p, prange, nattr, attrs) &&
-		    prange->mapped_to_gpu) {
+		    prange->mapping_done) {
 			/* nothing to do */
 		} else if (node->start < start || node->last > last) {
 			/* node intersects the update range and its attributes
@@ -2626,14 +2634,14 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
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
@@ -3723,6 +3731,23 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
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
@@ -3778,10 +3803,10 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
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
@@ -3802,6 +3827,9 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	list_for_each_entry(prange, &update_list, update_list) {
 		bool migrated;
 
+		if (svm_range_needs_unmap(p, prange))
+			continue;
+
 		mutex_lock(&prange->migrate_mutex);
 
 		r = svm_range_trigger_migration(mm, prange, &migrated);
@@ -3810,7 +3838,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 		if (migrated && (!p->xnack_enabled ||
 		    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
-		    prange->mapped_to_gpu) {
+		    !bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE)) {
 			pr_debug("restore_work will update mappings of GPUs\n");
 			mutex_unlock(&prange->migrate_mutex);
 			continue;
@@ -3821,7 +3849,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 			continue;
 		}
 
-		flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
+		flush_tlb = !migrated && update_mapping &&
+			    !bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE);
 
 		r = svm_range_validate_and_map(mm, prange->start, prange->last, prange,
 					       MAX_GPU_INSTANCE, true, true, flush_tlb);
@@ -3835,11 +3864,13 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
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

