Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3682606A31D
	for <amd-gfx@archiver.kernel.org>; Sun, 22 Nov 2026 20:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=E1U0m3HT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6238E10E0D4;
	Sun, 22 Nov 2026 20:26:00 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C415210E0D4
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Nov 2026 20:25:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSqPAq82vQFZkhJ/FMIVa/HlKSW7BjtTVWx6bzr/jourW3lDNR6jCHwMN7GGjECro4lkeYcR3Za/qoKmGPCmbBkvP/HNT2ZXpu3R976kVCH/vBaoLPY4bwFDf7XkQDGvR3Im3TMyD7S+mGZW9Dbg20p2rK+U5Jh+SOBDuCWw77D/KE+/bAVGGZJCX0TZga5EO94cmbF4WSmxk827RtR20LExlLYw6EeBDm2ip/5oUQljvp3+juscTUo5IL51I/jIrNznNh+am7uvyTnjAsXzIzgvjq7lmMWpNTwgpWeuxEb0LxvSS6vqXMiwIYRyHXTBMMXS3DZwcUCfJt8fP1EYJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KB5S3dA74snY1YRTPimYrduB0YdOyEspgBvl9n64DMQ=;
 b=tM3Npnj0qQDQKLWNjfQ/mFDDF3XSUwRWRLI6j6rDYAlrDC53fjKPa5PFJ1VsV7EK6QpALidJGjkm/Cey3/OG/Bc7+qEhtAsMipyLY+WL5/v060/L/B2tSWfkOsE5gisWQwF/j20/HXEmyUgqmnmjUCZOWaFmApJfcYvwgrG/4ZTm0rutZrCYzd9Tu2CZk6W8MhUDDs+NxnOn8nVM8AY4Ruj+horcjS5DC97oPYPJx629Dc8NkwbLh5w6M2JU0fFd6eYWz3mYhVJq7auKG/gqrZtJVTCCltORKJNBea8CkboEXbxS/zVLK0ZD+W/7mLq5GYk7JkubrN8R1MbIv5JTeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KB5S3dA74snY1YRTPimYrduB0YdOyEspgBvl9n64DMQ=;
 b=E1U0m3HTS0578ebPwpehdoIQd/C6kz8/JPdB8GxPVvQ+Ckgbrz/tDf7kT/fZRQ7587mTOtSu2EtbZ8VIYXBEBX5ARGat8WUTMWfBk4dhJa7tRdvuEGJT1jGFcForQRnIQd5zZAkkzqu+UvXOaItVqB511Nbz/hn66A9WBHM/m2E=
Received: from CYZPR05CA0029.namprd05.prod.outlook.com (2603:10b6:930:a3::28)
 by CYYPR12MB8924.namprd12.prod.outlook.com (2603:10b6:930:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Sun, 22 Nov
 2026 20:25:50 +0000
Received: from MWH0EPF000DD30D.namprd05.prod.outlook.com
 (2603:10b6:930:a3:cafe::8b) by CYZPR05CA0029.outlook.office365.com
 (2603:10b6:930:a3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Sun, 22
 Nov 2026 20:25:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000DD30D.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Sun, 22 Nov 2026 20:25:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 22 Nov
 2026 14:25:46 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 22 Nov
 2026 14:25:46 -0600
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57
 via Frontend Transport; Sun, 22 Nov 2026 14:25:46 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH v5 1/3] drm/amdkfd: Add awareness of THP of device and system
 RAM in kfd svm driver
Date: Sun, 22 Nov 2026 14:26:51 -0600
Message-ID: <20261122202653.274580-2-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261122202653.274580-1-xiaogang.chen@amd.com>
References: <20261122202653.274580-1-xiaogang.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000DD30D:EE_|CYYPR12MB8924:EE_
X-MS-Office365-Filtering-Correlation-Id: 58bd1eba-c8da-4d50-adf2-08df48d6ccb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|261102130727099003|261102123227099003|261028144727099003|261021121427099003|261021123027099003|261022113327099003|261022105027099003|261022075727099003|261026121527099003|261026140227099003|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003|261009223027099003;
X-Microsoft-Antispam-Message-Info: FqR0YGJcpQDUMFdLJFoLLbuCYNy8oN5TjdeMGqiRhDogkSNAkTOoylDmLTR3tjEYtk3gbGN+o45XGHLYVUik0R2KCMw59Uwow1/0/r+KpWQQqsGsokPkUzkwjsG9juBOkW4r98c59Jc0EYuB1d6sq3qc45ztRrc4ncP/xDns2HqxHW9Tcu2XesMCJHQPknVXDpskNk94PNOKxFj/Q/56PjzbNRbB76ESC6K027Nw7wLJlOjp/yKMTAfcwovIAIdWjp/V0Lq3MTwX4OpNxm8KPfx8iv+8MtTwrBGVOIgXacr0WQBexpu2r0dmeAiooHRgE3cm3H4d0MyvxfgUktQM0m35OYiSF69wTgFPAY3er7Iq13HdAl2yMNhvt5O31VZLmzkpCfvDnHbbFahnpWm7TMxu1KoBoCn8aS8eOMlE7eDYQZqp0UIFxEp6q2+mkIDtcVyxTm5oJ8V97Ds5j9+aaJyTLtlQGOsBKdLWJGrmagqSyTgIHdK55CxbC2enekAH3CRFnLmBJBccpd0OOB0ZxIAOSr8tUo89T4KOu7it2LY+4+ByukBjWgl/ytnfdbiHLW5iknOOfxZSNSx0gJk++4vRCppkzIXNSvVFO9UaTg7iL/omLwEFL0kkEiD8TbwVDR+MbqVvHDkTjUieevdAYxVXI1rfPacWy5a36zz4soFLSciTR+/f84tUzp1NifkH3PxudTemZPSABGjzzwvjWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(261102130727099003)(261102123227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022113327099003)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VX8M3GFziBGq7C+xhpljF39lYSIUmXvDmExdcH+UUfJjbzropDG7J4FECYcnefpjctYQBWa21g1sGi2Nqy7qT6RfoGG0o6G5PNwNc3JMcgVu3AqKUMDJZPTi2ESyDw7IjgZX+cdtFbUM3EJn6bbwJF5sH4cVcNd+avYAjZKaIueyiG8+f7X25ZGVQ51HSs6rFgmu4poZqES8kgSyC+/mKKNl+mKP2jPJbifhOsjvI+w/i7E9ATNNEW4ItIIQtWHMQtqHFXutC+Z5o66CB3seJJKlS7AP93efXwojkBm8H/Xxt/c4BLPEujK/n7O5hUR04qumnHO5dRH/IW7bHbf/ebUqH8sHyF+6YsWJKD6s6e1tWypn1yNE86Lb7BHT/qendsmu/O8MGNnI5WRQPxiFCgprTSdVUckf3afL4LFA1JwTjUZ3ipqxxdqtEcovbnM7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2026 20:25:50.3350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bd1eba-c8da-4d50-adf2-08df48d6ccb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000DD30D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8924
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Xiaogang Chen <xiaogang.chen@amd.com>

Extend kfd/svm functions to allocate HPAGE_PMD_SIZE based device memory by
buddy allocator, each drm_buddy_block is HPAGE_PMD_SIZE aligned; and to
allocate THP system ram by vma_alloc_folio.

Introduce SVM_RANGE_DMA_THP flag that indicates dma map of THP. THP dma
addresss will use this flag.

Add dev_pagemap_ops->folio_split callback that is called by folio_split when
core MM splits device memory folio.

Reset compound folio of device memory after it got released from core HMM.
So, TTM can reuse this VRAM as 4K pages on next range.

These are preparations for following support for (THP) migration of zone
device-private memory, no function change.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 112 ++++++++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     |  39 ++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  18 ++++
 3 files changed, 152 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 1eb92ac6eb05..5ead98a604b1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -218,17 +218,45 @@ svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long addr)
 	return (addr + adev->kfd.pgmap.range.start) >> PAGE_SHIFT;
 }
 
+/*
+ * TTM can reuse a 2MB VRAM block that was previously a device THP.
+ * Reset unused pages so the next 4K init does not see leftover head/tail.
+ */
+static void svm_migrate_clear_compound_pages(struct page *page, unsigned int nr,
+					      struct dev_pagemap *pgmap)
+{
+	unsigned int i;
+
+	for (i = 0; i < nr; i++, page++) {
+		struct folio *new_folio = (struct folio *)page;
+
+		if (page_count(page))
+			continue;
+
+		page->flags.f &= ~0xffUL;
+#ifdef NR_PAGES_IN_LARGE_FOLIO
+		((struct folio *)(page - 1))->_nr_pages = 0;
+#endif
+		new_folio->mapping = NULL;
+		new_folio->pgmap = pgmap;
+		new_folio->share = 0;
+		page->zone_device_data = NULL;
+	}
+}
+
 static void
-svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn)
+svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn,
+			   int order)
 {
-	struct page *page;
+	struct page *page = pfn_to_page(pfn);
 
-	page = pfn_to_page(pfn);
-	svm_range_bo_ref(prange->svm_bo);
+	/* Init this pfn, not page_folio() — that follows a leftover tail to the old head. */
+	zone_device_folio_init((struct folio *)page, page_pgmap(page), order);
 	page->zone_device_data = prange->svm_bo;
-	zone_device_page_init(page, page_pgmap(page), 0);
+	svm_range_bo_ref(prange->svm_bo);
 }
 
+
 static void
 svm_migrate_put_vram_page(struct amdgpu_device *adev, unsigned long addr)
 {
@@ -249,11 +277,45 @@ svm_migrate_addr(struct amdgpu_device *adev, struct page *page)
 }
 
 static struct page *
-svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned long addr)
+svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned long addr,
+			  unsigned long order)
 {
 	struct page *page;
 
-	page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+	if (order) {
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+		struct folio *folio;
+		gfp_t gfp;
+
+		/*
+		 * Honour MADV_NOHUGEPAGE and prctl(PR_SET_THP_DISABLE). The
+		 * sysfs THP policy (thp_vma_allowable_orders()) and
+		 * vma_thp_gfp_mask() are not exported to modules.
+		 */
+		if (vma_thp_disabled(vma, vma->vm_flags, false))
+			return NULL;
+
+		/*
+		 * Used by every VRAM to RAM migration (CPU/GPU fault,
+		 * prefetch, TTM eviction), and the caller falls back to 4K
+		 * pages on failure. Fail fast like the default "madvise"
+		 * defrag policy: no direct reclaim or compaction unless the
+		 * VMA asked for huge pages. Eviction in particular runs under
+		 * memory pressure, where compaction stalls are most costly.
+		 */
+		gfp = GFP_TRANSHUGE_LIGHT;
+		if (vma->vm_flags & VM_HUGEPAGE)
+			gfp |= __GFP_DIRECT_RECLAIM;
+
+		folio = vma_alloc_folio(gfp, order, vma, addr);
+		page = folio ? folio_page(folio, 0) : NULL;
+#else
+		return NULL;
+#endif
+	} else {
+		page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+	}
+
 	if (page)
 		lock_page(page);
 
@@ -267,8 +329,13 @@ static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
 
 	for (i = 0; i < migrate->npages; i++) {
 		if (migrate->dst[i] & MIGRATE_PFN_VALID &&
-		    migrate->src[i] & MIGRATE_PFN_MIGRATE)
-			mpages++;
+			migrate->src[i] & MIGRATE_PFN_MIGRATE) {
+
+			if (migrate->dst[i] & MIGRATE_PFN_COMPOUND)
+				mpages += SVM_HPAGE_PMD_NR;
+			else
+				mpages++;
+		}
 	}
 	return mpages;
 }
@@ -312,7 +379,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 				migrate->dst[i] = 0;
 				spage = NULL;
 			} else {
-				svm_migrate_get_vram_page(prange, migrate->dst[i]);
+				svm_migrate_get_vram_page(prange, migrate->dst[i], 0);
 				migrate->dst[i] = migrate_pfn(migrate->dst[i]);
 				mpages++;
 			}
@@ -626,10 +693,17 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	return r < 0 ? r : 0;
 }
 
+/* folio can be compound folio or single page */
 static void svm_migrate_folio_free(struct folio *folio)
 {
 	struct page *page = &folio->page;
 	struct svm_range_bo *svm_bo = page->zone_device_data;
+	struct dev_pagemap *pgmap = folio->pgmap;
+	unsigned int order = folio_order(folio);
+
+	/* So TTM can reuse this VRAM as 4K pages on the next range. */
+	if (order)
+		svm_migrate_clear_compound_pages(page, 1U << order, pgmap);
 
 	if (svm_bo) {
 		pr_debug_ratelimited("ref: %d\n", kref_read(&svm_bo->kref));
@@ -688,7 +762,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			j = 0;
 		}
 
-		dpage = svm_migrate_get_sys_page(migrate->vma, addr);
+		dpage = svm_migrate_get_sys_page(migrate->vma, addr, 0);
 		if (!dpage) {
 			pr_debug("failed get page svms 0x%p [0x%lx 0x%lx]\n",
 				 prange->svms, prange->start, prange->last);
@@ -1091,9 +1165,25 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 	return r ? VM_FAULT_SIGBUS : 0;
 }
 
+static void svm_migrate_folio_split(struct folio *head, struct folio *tail)
+{
+	struct svm_range_bo *svm_bo;
+
+	if (tail == NULL)
+		return;
+
+	tail->pgmap = head->pgmap;
+	tail->mapping = head->mapping;
+
+	svm_bo = folio_zone_device_data(head);
+	folio_set_zone_device_data(tail, svm_bo);
+	svm_range_bo_ref(svm_bo);
+}
+
 static const struct dev_pagemap_ops svm_migrate_pgmap_ops = {
 	.folio_free		= svm_migrate_folio_free,
 	.migrate_to_ram		= svm_migrate_to_ram,
+	.folio_split		= svm_migrate_folio_split,
 };
 
 /* Each VRAM page uses sizeof(struct page) on system memory */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 421d3f65fcf1..35cebdad5651 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -246,7 +246,16 @@ void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
 		if (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
 			continue;
 		pr_debug_ratelimited("unmap 0x%llx\n", dma_addr[i] >> PAGE_SHIFT);
-		dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
+
+		/* dma unmap of THP */
+		if (dma_addr[i] & SVM_RANGE_DMA_THP) {
+			dma_addr[i] &= ~SVM_RANGE_DMA_THP;
+			dma_unmap_page(dev, dma_addr[i], PAGE_SIZE*SVM_HPAGE_PMD_NR,
+				       DMA_BIDIRECTIONAL);
+		} else {
+			dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
+		}
+
 		dma_addr[i] = 0;
 	}
 }
@@ -579,10 +588,20 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 	}
 
 	memset(&bp, 0, sizeof(bp));
+	/*
+	 * Keep bp.size equal to the prange size so it matches the
+	 * amdgpu_amdkfd_reserve_mem_limit() reservation made by the caller.
+	 * A 2MB byte_align makes the VRAM manager allocate 2MB-aligned 2MB
+	 * buddy blocks and trim only the last one to the requested size, so
+	 * every full 2MB chunk can still back a device THP.
+	 */
 	bp.size = prange->npages * PAGE_SIZE;
+	if (SVM_THP_ENABLED && prange->npages >= SVM_HPAGE_PMD_NR)
+		bp.byte_align = SVM_HPAGE_PMD_SIZE;
+	else
+		bp.byte_align = PAGE_SIZE;
 	bp.bo_ptr_size = sizeof(struct svm_range_bo);
 	bp.destroy = svm_range_bo_destroy;
-	bp.byte_align = PAGE_SIZE;
 	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
 	bp.flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
 	bp.flags |= clear ? AMDGPU_GEM_CREATE_VRAM_CLEARED : 0;
@@ -594,9 +613,16 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 
 	r = amdgpu_bo_create(node->adev, &bp, &bo);
 	if (r) {
-		pr_debug("failed %d to create bo\n", r);
-		mmput(mm);
-		goto create_bo_failed;
+		if (bp.byte_align == SVM_HPAGE_PMD_SIZE) {
+			/* fall back PAGE_SIZE granularity */
+			bp.byte_align = PAGE_SIZE;
+			r = amdgpu_bo_create(node->adev, &bp, &bo);
+		}
+		if (r) {
+			pr_debug("failed %d to create bo\n", r);
+			mmput(mm);
+			goto create_bo_failed;
+		}
 	}
 
 	svm_bo = to_svm_range_bo(bo);
@@ -957,6 +983,7 @@ svm_range_copy_array(void *psrc, size_t size, uint64_t num_elements,
 	*vram_pages = 0;
 	for (i = 0; i < num_elements; i++) {
 		dma_addr_t *temp;
+
 		temp = (dma_addr_t *)dst + i;
 		*temp = *((dma_addr_t *)src + i);
 		if (*temp&SVM_RANGE_VRAM_DOMAIN)
@@ -1675,7 +1702,7 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx, bool intr)
 	uint32_t gpuidx;
 	int r;
 
-	drm_exec_init(&ctx->exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT: 0, 0);
+	drm_exec_init(&ctx->exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT : 0, 0);
 	drm_exec_until_all_locked(&ctx->exec) {
 		for_each_set_bit(gpuidx, ctx->bitmap, MAX_GPU_INSTANCE) {
 			pdd = kfd_process_device_from_gpuidx(ctx->process, gpuidx);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 38744e716f74..8767a784e679 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -35,6 +35,24 @@
 #include "kfd_priv.h"
 
 #define SVM_RANGE_VRAM_DOMAIN (1UL << 0)
+#define SVM_RANGE_DMA_THP (1UL << 1)
+
+/*
+ * Size of a PMD-mapped device or system THP. HPAGE_PMD_* expand to
+ * BUILD_BUG() without CONFIG_TRANSPARENT_HUGEPAGE, so the SVM code uses
+ * these instead. Without THP, SVM_THP_ENABLED is false, no compound
+ * migration is requested, and HMM never reports MIGRATE_PFN_COMPOUND, so
+ * the THP paths still compile but are never taken.
+ */
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define SVM_HPAGE_PMD_ORDER	HPAGE_PMD_ORDER
+#else
+#define SVM_HPAGE_PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
+#endif
+#define SVM_HPAGE_PMD_NR	(1UL << SVM_HPAGE_PMD_ORDER)
+#define SVM_HPAGE_PMD_SIZE	(PAGE_SIZE << SVM_HPAGE_PMD_ORDER)
+#define SVM_THP_ENABLED		IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)
+
 #define SVM_ADEV_PGMAP_OWNER(adev)\
 			((adev)->hive ? (void *)(adev)->hive : (void *)(adev))
 
-- 
2.34.1

