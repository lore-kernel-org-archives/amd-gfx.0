Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96A9C61DE4
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Aug 2026 15:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E79510E557;
	Sun, 30 Aug 2026 15:41:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O3JwnD5W";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010037.outbound.protection.outlook.com
 [52.101.193.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A24CF10E221
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Aug 2026 15:41:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jebkdhO0QvZO1J52LT95MY/+mnQDRT+qpJ0ES6Xu+GIpQeCF01WvY7H0qxRfRhqjUCtl/ZKWi0qS/ds6nCiUMp6APDkd6lUcKjh8udobYwxBtUMvYNafdD4G1V10xX7ZLtwmP2WmLnuASb1gDbkyUyVa4cFgToFp+mg0eu6vO8NCtjx3HsSwt0WvAS/kP33CGCyCoyt3EUtW1b20IOVNtJLGxw6Y2ZHI9f5raIAgB9KZwTLl+P8EQ2g6rZ9sSAiDUTPDGbwmJqoxf+vGj/tcn5J4v3MW/Z33KNSaIlcGh+w2Q6GUmGpZ0jOwF4a7IdwcDcYGp4KnV7+LvP94DtAnIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIuhpCDFucRdwinq/+h7n+xwV1zF8320+Qrz3gRPJF8=;
 b=HdE+rLbpTOwTtsByJQF1GAojcsUjGmdAgqOG9dfZs/MJ5AQ4VUU1dgBAaikYNnvQcmbj5VufNTvRRET9ICDXElhM4Nh0E8R0eC8m5cplVatrcStbTfT7d/8wyx2ILTWHD66boGCcDeeT4DdvaDXKy2H2nxbJ4tEZC59TmGCmUwgfKWb9EEyOQtRzQw7nPGv8SS4ykeipnPkfGCge/BCUWCvTE7gydM/o3NbjI0mCyr7HdkUS0JIUv9B4nVP1yyfl1JXFkzXYPYQCCwuF6zNS0J5hYqFJyP179Uubx9zPd6Nz5AmZbHKkLqzelG1qOj7llcyzfG5UTReuNuYeMn7F4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIuhpCDFucRdwinq/+h7n+xwV1zF8320+Qrz3gRPJF8=;
 b=O3JwnD5W5SuQIWyex6v96jNrp/5YPaj0WyQrHatfKv6BLCrVCw0JQ0Vkk2tSGEX3WAz3Fkk2v24Jsd+/5GXN181CxMHX3lrA6sdeTA4oT7nSN7hs23/PYZwRgTLCV08Je7++T9kEBHJWCkoPUJKF5zQr/nkPwPu6WRRrAsf0ifE=
Received: from DS7PR03CA0146.namprd03.prod.outlook.com (2603:10b6:5:3b4::31)
 by DSVPR12MB999259.namprd12.prod.outlook.com (2603:10b6:8:423::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 15:40:53 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::a8) by DS7PR03CA0146.outlook.office365.com
 (2603:10b6:5:3b4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Sun,
 30 Aug 2026 15:40:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sun, 30 Aug 2026 15:40:53 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 10:40:49 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Junhua.Shen@amd.com>, <timur.kristof@gmail.com>, <natalie.vock@gmx.de>
CC: <amd-gfx@lists.freedesktop.org>, <honghuan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [RFC PATCH 2/3] drm/amdgpu: recheck range validity after page table
 allocation
Date: Sun, 30 Aug 2026 23:40:26 +0800
Message-ID: <7b04b9024599b1ead91fe89831161abb77e7228b.1788103444.git.honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1788103444.git.honghuan@amd.com>
References: <cover.1788103444.git.honghuan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|DSVPR12MB999259:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f77006a-61c8-4886-f2fd-08df06ad138c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|10067099003|6133799003|3023799007|11063799006|5023799004|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: w6MATnbvalhhdYRDF2JO/wu0iphsVOXcOzpppzuKatTd5uT9Fjs/5fjWp0RsIAXG5XHPVhLCkpJFe8dwizUQn5ZT/lfXYBXLKZTMdJWdq8+o2IJwqFisPcLVpSsyPC4JDvK+eD15ND4PWXukynoJy66d6uac8sizmJbVoicAyI4k+ydPCLStNvcFeOIGjXllj/s/6GHGIrRhGZb3Kicuo0MqTT5j50AISmX6iqzNbvDMl51bW/Idod4KxzNSNTNbh8uN/Dhpks8/rrHqbLQ4YvEzGKf81drQpVC5buNFucVLexJEFC6GoNkKgeYTKllCl1MoPspBLN1vCOz7RXKf2TsHjNtcOOvuVdQtFqVtH6mWEicdwjCQVTMFOX1vybjeLSUuJDbNp2yalgEwQtYukWWrUVX7eYxkTxM22sg1KMQnYwAIKGkFQXWlueuEg4fnuU6dtxyG1Tx/ItAGO3ayEQ2w4TJgOO9lZF4LB46yyfkAPDFPq67AgEjDDUMcJcYrj4qX1u87r1ntSaqNn3gwgWD6Lli/weqMKjQ9AIAb2Sq1RR7YnC5wcR2C7QbHOb2JMCIxLhBC4pdCJ5lmENFv1q6qoK7DqnU2mNiq2Ts+fqFwXPYngXBk2bDpUeTvdVFokKehTHMmnBLFABPJjAHGnfOwylyd3PuI2/LtL0iyNUyYZ0CeUSrs4jdockML+ZuPMMkLCJcCzFCCaOcMPVVpM5sEee5fIrCzwDRFAgqTNGehjH+mnWcNQChIDN+7SDbW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(10067099003)(6133799003)(3023799007)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OuLE9Hw2PhsVfn/2hk7a8fUzjS6XvF0X9+rNFv894XRbh+e2YEj+X1s9bhf3c+88hBxqo2wyVIllTa//7zrHkVpJynoLQiodvnySW+eyny+XA0C999HrfqJSNI28um13uEVQWoB4dN086qWn59vU4vqZAlMZQ4KSBuXHniADfffRnnjVTxJSVfwS6AcRgvH2UykDAAr5JwHNghRmz0RSUfqyFoU9zwC7d5Ii+kQhKmQ4QxPU+K2YkWQFJANEUlW/VvI9llETPMqx4kDQM7UEnUAbXsLEZRmd9OkMbR6KbvtRMpNP8prc3IjEbkSefuaJsou87z4bZCYbHDmGct1jngRqkSGaXzRgrmGPT4Aj1Vk41kUaa9NvgqzaIr7pVc0zrmV7uyIEa9GVYKPx6t+xazAcQs5r12Zpxv2+IBpIQRzAqzrU2sTj44vZMMRT5XZe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 15:40:53.6352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f77006a-61c8-4886-f2fd-08df06ad138c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999259
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

From: Honglei Huang <honghuan@amd.com>

The notifier and eviction locks need to be the same lock. Page table
allocation can enter memory reclaim, and reclaim can invoke an MMU
notifier that takes the same lock. Release the lock before allocating
page tables to avoid a deadlock.

Dropping the lock allows an unmap operation to invalidate the range
concurrently. Recheck the HMM or GPU SVM range after reacquiring the
lock and return -EAGAIN if its sequence number has changed.

Allow callers that already hold the eviction lock to pass it to the VM
update helpers. Drop the lock around amdgpu_vm_pt_create() and reacquire
it before continuing. Callers that pass NULL retain the existing
internal locking path.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 75 +++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  9 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   | 28 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 29 ++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  7 +-
 10 files changed, 116 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 7882f13852..74a8a27a9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -503,7 +503,7 @@ static int vm_update_pds(struct amdgpu_vm *vm, struct amdgpu_sync *sync)
 	struct amdgpu_device *adev = amdgpu_ttm_adev(pd->tbo.bdev);
 	int ret;
 
-	ret = amdgpu_vm_update_pdes(adev, vm, false);
+	ret = amdgpu_vm_update_pdes(adev, vm, false, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index e129ec4644..30469769b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1184,7 +1184,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (r)
 		return r;
 
-	r = amdgpu_vm_update_pdes(adev, vm, false);
+	r = amdgpu_vm_update_pdes(adev, vm, false, NULL);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index f754a4a3a1..833d05a199 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -795,7 +795,7 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	}
 
 	/* Always update PDEs after we touched the mappings. */
-	r = amdgpu_vm_update_pdes(adev, vm, false);
+	r = amdgpu_vm_update_pdes(adev, vm, false, NULL);
 	if (r)
 		goto error;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index 08a10955a9..3e622ac059 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -73,7 +73,7 @@ amdgpu_svm_range_zap_ptes(struct amdgpu_svm *svm,
 
 	flags = memalloc_noreclaim_save();
 	ret = amdgpu_vm_unmap_range(svm->adev, svm->vm, NULL,
-				    start_page, last_page, 0, &fence);
+				    start_page, last_page, 0, NULL, &fence);
 	memalloc_noreclaim_restore(flags);
 
 	if (fence) {
@@ -222,6 +222,7 @@ amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
 					  flush_tlb && is_last_seg, true, NULL,
 					  start_page, last_page, pte_flags,
 					  0, entry->addr, NULL, NULL, NULL,
+					  NULL, NULL,
 					  wait_fence && is_last_seg ? fence : NULL);
 		if (ret)
 			return ret;
@@ -330,7 +331,7 @@ int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm,
 	dma_fence_put(fence);
 
 	if (!ret)
-		ret = amdgpu_vm_update_pdes(svm->adev, svm->vm, false);
+		ret = amdgpu_vm_update_pdes(svm->adev, svm->vm, false, NULL);
 
 	if (!ret) {
 		if (flush_tlb)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 0a816b3c5f..568e6bb7f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1151,7 +1151,7 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 		goto retry_lock;
 	}
 
-	ret = amdgpu_vm_update_pdes(adev, vm, false);
+	ret = amdgpu_vm_update_pdes(adev, vm, false, NULL);
 	if (ret)
 		goto unlock_all;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a2cc6e2017..cb62c08ec5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -986,6 +986,7 @@ uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr)
  * @adev: amdgpu_device pointer
  * @vm: requested vm
  * @immediate: submit immediately to the paging queue
+ * @eviction_lock: optional caller-held eviction lock
  *
  * Makes sure all directories are up to date.
  *
@@ -993,7 +994,8 @@ uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr)
  * 0 for success, error for failure.
  */
 int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
-			  struct amdgpu_vm *vm, bool immediate)
+			  struct amdgpu_vm *vm, bool immediate,
+			  struct rw_semaphore *eviction_lock)
 {
 	struct amdgpu_vm_update_params params;
 	struct amdgpu_vm_bo_base *entry, *tmp;
@@ -1013,6 +1015,16 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	params.vm = vm;
 	params.immediate = immediate;
 
+	/*
+	 * Keep PDE updates under the SVM eviction lock so MMU notifier
+	 * invalidation won't happen between the PTE and PDE updates.
+	 */
+	params.eviction_lock = eviction_lock;
+
+	r = amdgpu_vm_begin_critical(&params);
+	if (r)
+		goto error;
+
 	r = vm->update_funcs->prepare(&params, NULL,
 				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES);
 	if (r)
@@ -1039,6 +1051,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 		amdgpu_vm_bo_idle(entry);
 
 error:
+	amdgpu_vm_end_critical(&params);
 	drm_dev_exit(idx);
 	return r;
 }
@@ -1119,6 +1132,8 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
  * @res: ttm_resource to map
  * @pages_addr: DMA addresses to use for mapping
  * @hmm_range: to check validity of DMA addresses
+ * @eviction_lock: optional caller-held eviction lock
+ * @gpusvm_range: optional SVM range to revalidate
  * @fence: optional resulting fence
  *
  * Fill in the page table entries between @start and @last. Allocate and free
@@ -1134,6 +1149,8 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			uint64_t vram_base, struct ttm_resource *res,
 			dma_addr_t *pages_addr,
 			struct amdgpu_hmm_range *hmm_range,
+			struct rw_semaphore *eviction_lock,
+			struct drm_gpusvm_range *gpusvm_range,
 			struct dma_fence **fence)
 {
 	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
@@ -1146,10 +1163,25 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return -ENODEV;
 
+	memset(&params, 0, sizeof(params));
+	params.adev = adev;
+	params.vm = vm;
+	params.pages_addr = pages_addr;
+	params.hmm_range = hmm_range;
+	params.eviction_lock = eviction_lock;
+	params.gpusvm_range = gpusvm_range;
+	params.override_pte = allow_override && adev->gmc.override_pte;
+	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
+
+	/* Enter noreclaim before allocating the small tlb_cb. */
+	r = amdgpu_vm_begin_critical(&params);
+	if (r)
+		goto error_critical;
+
 	tlb_cb = kmalloc_obj(*tlb_cb);
 	if (!tlb_cb) {
-		drm_dev_exit(idx);
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto error_critical;
 	}
 
 	/* Vega20+XGMI where PTEs get inadvertently cached in L2 texture cache,
@@ -1163,18 +1195,7 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	 */
 	flush_tlb |= amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 0, 0);
 
-	memset(&params, 0, sizeof(params));
-	params.adev = adev;
-	params.vm = vm;
-	params.pages_addr = pages_addr;
-	params.hmm_range = hmm_range;
 	params.needs_flush = flush_tlb;
-	params.override_pte = allow_override && adev->gmc.override_pte;
-	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
-
-	r = amdgpu_vm_begin_critical(&params);
-	if (r)
-		goto error_free;
 
 	if (!dma_fence_is_signaled(vm->last_unlocked)) {
 		struct dma_fence *tmp = dma_fence_get_stub();
@@ -1256,6 +1277,7 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 error_free:
 	kfree(tlb_cb);
+error_critical:
 	amdgpu_vm_end_critical(&params);
 	drm_dev_exit(idx);
 	return r;
@@ -1270,6 +1292,7 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
  * @start: start of unmapped range
  * @last: last unmapped entry
  * @flags: flags for the entries
+ * @eviction_lock: optional caller-held eviction lock
  * @fence: optional resulting fence
  *
  * Fill in the page table entries between @start and @last with a fixed flags
@@ -1282,6 +1305,7 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			   struct amdgpu_sync *sync, uint64_t start,
 			   uint64_t last, uint64_t flags,
+			   struct rw_semaphore *eviction_lock,
 			   struct dma_fence **fence)
 {
 	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
@@ -1291,22 +1315,24 @@ int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return -ENODEV;
 
-	tlb_cb = kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
-	if (!tlb_cb) {
-		drm_dev_exit(idx);
-		return -ENOMEM;
-	}
-
 	memset(&params, 0, sizeof(params));
 	params.adev = adev;
 	params.vm = vm;
 	params.needs_flush = true;
 	params.unlocked = true;
+	params.eviction_lock = eviction_lock;
 	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
 
+	/* Enter noreclaim before allocating the small tlb_cb. */
 	r = amdgpu_vm_begin_critical(&params);
 	if (r)
-		goto error_free;
+		goto error_critical;
+
+	tlb_cb = kmalloc_obj(*tlb_cb);
+	if (!tlb_cb) {
+		r = -ENOMEM;
+		goto error_critical;
+	}
 
 	r = vm->update_funcs->prepare(&params, sync,
 				      AMDGPU_KERNEL_JOB_ID_VM_UNMAP_RANGE);
@@ -1325,6 +1351,7 @@ int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 error_free:
 	kfree(tlb_cb);
+error_critical:
 	amdgpu_vm_end_critical(&params);
 	drm_dev_exit(idx);
 	return r;
@@ -1462,7 +1489,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 					mapping->start, mapping->last,
 					update_flags, mapping->offset,
 					vram_base, mem, pages_addr, NULL,
-					last_update);
+					NULL, NULL, last_update);
 		if (r)
 			goto error_free;
 	}
@@ -1671,7 +1698,8 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 
 		r = amdgpu_vm_map_range(adev, vm, true, false,
 					&sync, mapping->start, mapping->last,
-					0, 0, 0, NULL, NULL, NULL, &f);
+					0, 0, 0, NULL, NULL, NULL,
+					NULL, NULL, &f);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 		if (r) {
 			dma_fence_put(f);
@@ -2851,7 +2879,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	amdgpu_svm_close(vm);
 	amdgpu_svm_fini(vm);
-
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
 	root = amdgpu_bo_ref(vm->root.bo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index eac2632db0..5fdfed2f28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -39,6 +39,7 @@
 #include "amdgpu_ttm.h"
 
 struct drm_exec;
+struct drm_gpusvm_range;
 
 struct amdgpu_bo_va;
 struct amdgpu_job;
@@ -284,7 +285,7 @@ struct amdgpu_vm {
 	/* tree of virtual addresses mapped */
 	struct rb_root_cached	va;
 
-	/* SVM can replace this pointer with its notifier lock. */
+	/* SVM uses gpusvm.notifier_lock, other VMs use default_eviction_lock. */
 	struct rw_semaphore	default_eviction_lock;
 	struct rw_semaphore	*eviction_lock;
 	bool			evicting;
@@ -447,7 +448,8 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		     bool *need_pipe_sync, bool *emit_spm_needed,
 		     bool *emit_gds_needed);
 int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
-			  struct amdgpu_vm *vm, bool immediate);
+			  struct amdgpu_vm *vm, bool immediate,
+			  struct rw_semaphore *eviction_lock);
 int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm,
 			  struct dma_fence **fence);
@@ -467,10 +469,13 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			uint64_t vram_base, struct ttm_resource *res,
 			dma_addr_t *pages_addr,
 			struct amdgpu_hmm_range *hmm_range,
+			struct rw_semaphore *eviction_lock,
+			struct drm_gpusvm_range *gpusvm_range,
 			struct dma_fence **fence);
 int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			   struct amdgpu_sync *sync, uint64_t start,
 			   uint64_t last, uint64_t flags,
+			   struct rw_semaphore *eviction_lock,
 			   struct dma_fence **fence);
 int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
index 2bd069c56c..1475b155d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -24,6 +24,7 @@
 #ifndef __AMDGPU_VM_INTERNAL_H__
 #define __AMDGPU_VM_INTERNAL_H__
 
+#include <drm/drm_gpusvm.h>
 #include <linux/types.h>
 #include <linux/list.h>
 #include "amdgpu_hmm.h"
@@ -80,6 +81,12 @@ struct amdgpu_vm_update_params {
 	 */
 	struct amdgpu_hmm_range *hmm_range;
 
+	/** @eviction_lock: Optional caller-held eviction lock. */
+	struct rw_semaphore *eviction_lock;
+
+	/** @gpusvm_range: Optional SVM range to revalidate after taking the lock. */
+	struct drm_gpusvm_range *gpusvm_range;
+
 	/**
 	 * @job: job to used for hw submission
 	 */
@@ -149,6 +156,7 @@ void amdgpu_vm_pt_free_dummies(struct amdgpu_device *adev);
  *
  * Serialize all updates, check parameters and make sure that memory allocations
  * don't enter the reclaim path so that we don't deadlock with MMU notifiers.
+ * A non-NULL eviction_lock means the caller already holds the selected lock.
  *
  * Returns:
  *
@@ -158,7 +166,9 @@ void amdgpu_vm_pt_free_dummies(struct amdgpu_device *adev);
 static inline int amdgpu_vm_begin_critical(struct amdgpu_vm_update_params *p)
 {
 	/* Use the write lock to serialize updates when the root BO is unlocked. */
-	if (p->unlocked)
+	if (p->eviction_lock)
+		lockdep_assert_held(p->eviction_lock);
+	else if (p->unlocked)
 		down_write(p->vm->eviction_lock);
 	else
 		down_read(p->vm->eviction_lock);
@@ -168,6 +178,10 @@ static inline int amdgpu_vm_begin_critical(struct amdgpu_vm_update_params *p)
 		return -EBUSY;
 	if (p->hmm_range && !amdgpu_hmm_range_valid(p->hmm_range))
 		return -EAGAIN;
+	if (p->gpusvm_range &&
+	    !drm_gpusvm_range_pages_valid(p->gpusvm_range->gpusvm,
+					   p->gpusvm_range))
+		return -EAGAIN;
 	return 0;
 }
 
@@ -175,15 +189,17 @@ static inline int amdgpu_vm_begin_critical(struct amdgpu_vm_update_params *p)
  * amdgpu_vm_end_critical - end the critical section of the update
  * @p: The update parameters
  *
- * Restore the GFP flags and drop the lock.
+ * Restore the GFP flags.
  */
 static inline void amdgpu_vm_end_critical(struct amdgpu_vm_update_params *p)
 {
 	memalloc_noreclaim_restore(p->saved_flags);
-	if (p->unlocked)
-		up_write(p->vm->eviction_lock);
-	else
-		up_read(p->vm->eviction_lock);
+	if (!p->eviction_lock) {
+		if (p->unlocked)
+			up_write(p->vm->eviction_lock);
+		else
+			up_read(p->vm->eviction_lock);
+	}
 }
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 73786996c6..06492358d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -475,6 +475,23 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	return amdgpu_bo_create_vm(adev, &bp, vmbo);
 }
 
+static void amdgpu_vm_update_unlock(struct amdgpu_vm_update_params *p)
+{
+	amdgpu_vm_end_critical(p);
+	if (p->eviction_lock) {
+		lockdep_assert_held_read(p->eviction_lock);
+		up_read(p->eviction_lock);
+	}
+}
+
+static int amdgpu_vm_update_relock(struct amdgpu_vm_update_params *p)
+{
+	if (p->eviction_lock)
+		down_read(p->eviction_lock);
+
+	return amdgpu_vm_begin_critical(p);
+}
+
 /**
  * amdgpu_vm_pt_alloc - Allocate a specific page table
  *
@@ -498,19 +515,23 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
 	if (entry->bo)
 		return 0;
 
-	amdgpu_vm_end_critical(p);
+	amdgpu_vm_update_unlock(p);
 	r = amdgpu_vm_pt_create(p->adev, p->vm, cursor->level, &pt,
 				p->vm->root.bo->xcp_id);
-	r2 = amdgpu_vm_begin_critical(p);
+	r2 = amdgpu_vm_update_relock(p);
 	if (r)
 		return r;
-	if (r2)
+	pt_bo = &pt->bo;
+	if (r2) {
+		amdgpu_vm_update_unlock(p);
+		amdgpu_bo_unref(&pt_bo);
+		(void)amdgpu_vm_update_relock(p);
 		return r2;
+	}
 
 	/* Keep a reference to the root directory to avoid
 	 * freeing them up in the wrong order.
 	 */
-	pt_bo = &pt->bo;
 	pt_bo->parent = amdgpu_bo_ref(cursor->parent->bo);
 	amdgpu_vm_bo_base_init(entry, p->vm, pt_bo);
 	r = amdgpu_vm_pt_clear(p->adev, p->vm, pt);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 3a224dac7b..2a3baf7df1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1407,7 +1407,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}
 
 	return amdgpu_vm_unmap_range(adev, vm, NULL, gpu_start, gpu_end,
-				     init_pte_value, fence);
+				     init_pte_value, NULL, fence);
 }
 
 static int
@@ -1522,7 +1522,8 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 					gpu_start, gpu_end, pte_flags,
 					(last_start - prange->start) << PAGE_SHIFT,
 					bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
-					NULL, dma_addr, hmm_range, &vm->last_update);
+					NULL, dma_addr, hmm_range,
+					NULL, NULL, &vm->last_update);
 
 		for (j = last_start - prange->start; j <= i; j++)
 			dma_addr[j] |= last_domain;
@@ -1534,7 +1535,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 		last_start = prange->start + i + 1;
 	}
 
-	r = amdgpu_vm_update_pdes(adev, vm, false);
+	r = amdgpu_vm_update_pdes(adev, vm, false, NULL);
 	if (r) {
 		pr_debug("failed %d to update directories 0x%lx\n", r,
 			 prange->start);
-- 
2.34.1

