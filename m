Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BACC53219
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 16:36:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 010C310E05E;
	Wed, 29 Jul 2026 16:36:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0QUti92D";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AABAB10E05E
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 16:36:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPIctGGL+9eiVFndQZvb1h5WT4P3pJbH/XxdTM9J4W9mpgimghFwNaZB1tZgwDhGkLWrXiUBAf6yxofTNsJxa97DPGOSkHVXbeMVjSWblJ4yxfBJ3yOCCq5sMvvnvAQyI3pQxEaectFeykzMHdeFjZQ666/Ixsn2pTGSDDYvArFfLU4fdRjkgnSbgmdWZg1xhhfKvlQIvO7aocNFogqcG2o4gp0vEhc9I4TbUUMsi+/FeU//090nlsjjWMmfcZjj1Y/xYknog2C+qPwp3xZnudbXCmXuZ5Goos011fnn5Dy3CJtnTjKYowbCwaqq3AY85Hm9gGmHipg+FdfO1H8IzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RfH0IzvurleZa8+B/HFcWaU6UJn8T+h1tqkUoy6RBI=;
 b=tSM898Ip7XqQJkS66bpv3L9Rnerf8O4iwBtVQ2GrAxqsyYpulEVsSMYXlvPlKRFJNKiEf8PJ/yowmBEIzEguL8TQ3/tXD0zH7oXa+y7FKMjHzdsrvvKcA833e2PtToHG374ItsmqspsBHng4zA+ZPPtlDMcjbU0xDecGXCTkP1FSHPU4E/c1s5ZIdsu+zZ/Rh9yZO3TJ/Vt/Nnk3T2ATR93ECbOr2b7GVq2+to7/0tCMYQlDrMD54xuCpHnrdcm0yf0joFsQZonPaz+MnRF+Rte63kN53IT9n0LLh3rYVRV6Wx2I7enAN+qmSD5jvzdbVQirHKcpYK8PjynW9CHG+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RfH0IzvurleZa8+B/HFcWaU6UJn8T+h1tqkUoy6RBI=;
 b=0QUti92DoMLPHANmRCENONxTSq3gQpUfP2Yj3tGYvi84fhKERstb8wvc5Q1vXDQxggYEvi/rUKeOGSYs+duHdP2SPkXB+6ZCxBYUIiQG4PzsQG1HJnoYJ26TseblZHnpGJ6DFnw/3ZE8JSniHN8okinwIhfpIKkyjoH4TwY9LMQ=
Received: from BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::8)
 by PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 16:36:09 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::6e) by BY1P220CA0018.outlook.office365.com
 (2603:10b6:a03:5c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 16:36:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 16:36:08 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 11:36:07 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Amir.Shetaia@amd.com>,
 <Kent.Russell@amd.com>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3 2/2] drm/amdkfd: Unmap svm range from GPU set to no-access
Date: Wed, 29 Jul 2026 12:35:38 -0400
Message-ID: <20260729163538.229530-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260729163538.229530-1-Philip.Yang@amd.com>
References: <20260729163538.229530-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|PH8PR12MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea2e071-20a2-4e71-4bd2-08deed8f7e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|10067099003|6133799003|5023799004|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: r8XAlA2lpN362GVRLjGkJkRtJGZ7Zwo+8nkATNJS2MFc6IU48+VyhEk3kJULQK8m0tIHhq/VtbW7G4XP4ypleePLr5Gqxc61gJNHpNJH9SRD3TNAKIgDZEfXGLR9BzEi+a62mQt1apDzGDesi9iP+4xAFwFcn+GTi+zl+3trVprXzpBYtIbfBGBtnhAmh5mu50lSeoIZBHaeYHa7PoN0ReyfgaTXIjhgIQ85qZ1zKYZK2+hJ6A4ZNNxYX2SMh3Z0bbsqpVnBVE/5DO2BCT0AxPHzpM3Bqkno/zb3wgmliASBbBbgiKN0zn2jA27pU6FB3d8+z0YAsiI1B3HgHkwGEhRe6itgpH7dzMA3oFt7knCV7PcLSJLNXgJFgzOPIMiuGvEVKbz7XHtYjg6UPHV5x6jHO74bdricl7RNs/dUkqVJM8FeDT3TvtXnC0f/Vl6gx+LCqtQBt90Gk6WVaiRNqsl4DCs4ZRBmj7U7VnY37G363QoDEkP3fFYr9sXknHiCGuglekTB6pCx8y2eD+FbMZX2HR1xzibelRbATcC8c3EA5SkOC0OdARNvBoQ6jFt2e0TqHyfCED0KLiqbnrGaCnzymmkFB2IZj1pTIHf2Ons3+pDF3o6P/TMG8NxzSS31MKvfxcALhKETd37jFkQ+aoJiAC5e9gAIoCeL/hqXKiGP56I9wUc2FM/FEuA6fbojGUp9Xtz8f/udZqyWxUMWOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(10067099003)(6133799003)(5023799004)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N726DNaJtPnhbmp9xVNKy3Woxl40B/rmFdkOBZZMwnldDhyzn6IzS1OBbhpsBkDOBYjrbBhoQV3c+UCc4wzv2hqYS70kouLus6tUBVbbpfxmFyKEqlDKO58hXTHlPaWQTJxkGYTOMonBuGQwLECij/BuI7hruVcpZlN03QQYErk0C31ZoevdwKZ8RF+5/w7ykNLe1jE2v+DY31kq28y3SaokBW9DYV9J6rF95Cb7fB+xXrfXx7GSFZN3T8xHSOBJd4wh8mHoiaPPncla5Ua8PLzCkesYKsLrGO+yQcktoBAFr1TYh9UCxKsLr0AcgOFzfujNNeU2cMj7XvVcS6o3MqDDmoCiv7gxGOTSeR+vSrSXulJ9aM4v9+lEfPCr5I7+ZXbEtpHsbvDUeHzkTsVh11LoBtCHwXB7tNM+oPsU4uKGWcbNKG3HdjdLcraHdAm8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 16:36:08.3662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea2e071-20a2-4e71-4bd2-08deed8f7e1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7279
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
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 106 ++++++++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |   7 +-
 3 files changed, 76 insertions(+), 42 deletions(-)

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
index 34de59f0432d..8822d2d197b3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -837,6 +837,8 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 			if (attrs[i].type == KFD_IOCTL_SVM_ATTR_NO_ACCESS) {
 				bitmap_clear(prange->bitmap_access, gpuidx, 1);
 				bitmap_clear(prange->bitmap_aip, gpuidx, 1);
+				if (test_bit(gpuidx, prange->bitmap_mapped))
+					bitmap_set(prange->bitmap_needs_unmap, gpuidx, 1);
 			} else if (attrs[i].type == KFD_IOCTL_SVM_ATTR_ACCESS) {
 				bitmap_set(prange->bitmap_access, gpuidx, 1);
 				bitmap_clear(prange->bitmap_aip, gpuidx, 1);
@@ -1127,9 +1129,10 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
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
@@ -1430,7 +1433,8 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 static int
 svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
-			  unsigned long last, uint32_t trigger)
+			  unsigned long last, unsigned long *bitmap_unmap,
+			  uint32_t trigger)
 {
 	struct kfd_process_device *pdd;
 	struct dma_fence *fence = NULL;
@@ -1438,21 +1442,15 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
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
@@ -1605,6 +1603,8 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 			continue;
 		}
 
+		set_bit(gpuidx, prange->bitmap_mapped);
+
 		r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
 					 prange->dma_addr[gpuidx],
 					 bo_adev, wait ? &fence : NULL,
@@ -1750,7 +1750,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		bitmap_zero(ctx->bitmap, MAX_GPU_INSTANCE);
 		bitmap_set(ctx->bitmap, gpuidx, 1);
 	} else if (ctx->process->xnack_enabled) {
-		bitmap_copy(ctx->bitmap, prange->bitmap_aip, MAX_GPU_INSTANCE);
+		/* Update mapping on already mapped or access in place GPU */
+		bitmap_or(ctx->bitmap, prange->bitmap_mapped, prange->bitmap_aip,
+			  MAX_GPU_INSTANCE);
 
 		/* If prefetch range to GPU, or GPU retry fault migrate range to
 		 * GPU, which has ACCESS attribute to the range, create mapping
@@ -1770,14 +1772,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
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
@@ -1843,6 +1843,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 				e = min(end, prange->last);
 				if (e >= s)
 					r = svm_range_unmap_from_gpus(prange, s, e,
+						       prange->bitmap_mapped,
 						       KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
 				svm_range_unlock(prange);
 				/* If unmap returns non-zero, we'll bail on the next for loop
@@ -1905,7 +1906,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 
 		if (!r && next == end)
-			prange->mapped_to_gpu = true;
+			prange->mapping_done = true;
+		else
+			prange->mapping_done = false;
 
 		svm_range_unlock(prange);
 
@@ -2075,10 +2078,10 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
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
@@ -2127,13 +2130,14 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
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
@@ -2163,10 +2167,11 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
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
@@ -2286,7 +2291,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 		next_start = min(node->last, last) + 1;
 
 		if (svm_range_is_same_attrs(p, prange, nattr, attrs) &&
-		    prange->mapped_to_gpu) {
+		    prange->mapping_done) {
 			/* nothing to do */
 		} else if (node->start < start || node->last > last) {
 			/* node intersects the update range and its attributes
@@ -2635,14 +2640,14 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
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
@@ -3751,6 +3756,25 @@ int svm_range_evict_svm_bo(struct svm_range_bo *svm_bo)
 	return r;
 }
 
+static bool svm_range_needs_unmap(struct kfd_process *p, struct svm_range *prange)
+{
+	if (bitmap_empty(prange->bitmap_needs_unmap, MAX_GPU_INSTANCE))
+		return false;
+
+	pr_debug("prange 0x%p no access set for [0x%lx 0x%lx]\n",
+		 prange, prange->start, prange->last);
+
+	svm_range_update_checkpoint_timestamp(p);
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
@@ -3806,10 +3830,10 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
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
@@ -3830,6 +3854,9 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	list_for_each_entry(prange, &update_list, update_list) {
 		bool migrated;
 
+		if (svm_range_needs_unmap(p, prange))
+			continue;
+
 		mutex_lock(&prange->migrate_mutex);
 
 		r = svm_range_trigger_migration(mm, prange, &migrated);
@@ -3838,7 +3865,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 		if (migrated && (!p->xnack_enabled ||
 		    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
-		    prange->mapped_to_gpu) {
+		    !bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE)) {
 			pr_debug("restore_work will update mappings of GPUs\n");
 			mutex_unlock(&prange->migrate_mutex);
 			continue;
@@ -3849,7 +3876,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 			continue;
 		}
 
-		flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
+		flush_tlb = !migrated && update_mapping &&
+			    !bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE);
 
 		r = svm_range_validate_and_map(mm, prange->start, prange->last, prange,
 					       MAX_GPU_INSTANCE, true, true, flush_tlb);
@@ -3863,11 +3891,13 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
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
index 4232c47422e6..2fced72b3930 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -99,6 +99,9 @@ struct svm_work_list_item {
  * @child_list: list header for split ranges which are not added to svms yet
  * @bitmap_access: index bitmap of GPUs which can access the range
  * @bitmap_aip: index bitmap of GPUs which can access the range in place
+ * @bitmap_needs_unmap: index bitmap of GPUs which currently set NO_ACCESS
+ * @bitmap_mapped: index bitmap of GPUs which currently have the range mapped
+ * @mapping_done: true if range_validate_and_map complete successfully
  *
  * Data structure for virtual memory range shared by CPU and GPUs, it can be
  * allocated from system memory ram or device vram, and migrate from ram to vram
@@ -134,7 +137,9 @@ struct svm_range {
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

