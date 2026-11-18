Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C336606A959
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 23:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aBPbmeHs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2DD510E111;
	Wed, 18 Nov 2026 23:10:17 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010021.outbound.protection.outlook.com
 [52.101.193.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D81CF10E111
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 23:10:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTg0jREz7MWiFaQjDFfXY0CLmUNDVfJmCgprTDQ1b46G7eAarC+/rhUHBRrfi9M3CGLfgtXuR7Ws/914oJgONnVfOoEImebHYdqMehAcriyW+oCWa+jJaaFaRL0VoAIz+vzyrbOGVt6eGxalWUE1OuOnsh/JSTN+DFMk4gIZmekoBf/BjGO60o+Ip13mVJUd6f1LWgwCUS983rx8ZmTSKa0MkyTRnTBij87dbZ6cGBF7Tkm2SsNQu2Okd+q8xcD6m2Y0AwYxALsW1aaKYf4g0m3//fomogOmzk9lOAmQNeopR9xkyKP6JECfOma5p3l3IzNBH28ODr+qQO5+lSnRSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgvEWryF2HH9IL3IyLnwML0Mxe/pzkK29G3ee0Nfcjo=;
 b=SEj7WPJpeHU1CKk/YmI8igKDqxCI8kd6AufS4+VqhvkJ/LKVAWOuFb9dsKtk2qDU0Iag1+R3B1CG5xK5Y9otvgSM/7kO7bmprdN/AFq4pttpIgglfLtYzvVzFkWDVJ0znAXwl5vxSKMB2vhq19oXpBhygy8wrsm+bhazW3ME/0Yk7w+pR+diBLr9FrEw/CmssKXkd0Xs88uFu5hwonSEK1WV7TjTKRR1DTa6eijuYii8xWR/2qFKxv3oFvTAXOlnBg2JeHYDHOTzyEUee4Q3+3aVwz15jQO/4ZT0U1lFuyAoJePgpdNP8ek/4sjrm9IGLmLJiPXxTzJu9gY9bNECrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgvEWryF2HH9IL3IyLnwML0Mxe/pzkK29G3ee0Nfcjo=;
 b=aBPbmeHsO8gkAYtzH2tboN/om5+USVNVOBt4I29Vdy2b/tGItrI03Y8u7HpRBXHpP8NG9NE4WmpSY7Z7og2qXjFXTVvlVuG2iJr0pYm6xkuD4iOie1t2Mtv8UPDCpGFpUfgjAqWsgeAGu8uByAtvyehRWRqZB5mCTtJiDbUF1Oo=
Received: from BN9PR03CA0143.namprd03.prod.outlook.com (2603:10b6:408:fe::28)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 23:10:01 +0000
Received: from BN3PEPF00022BC9.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::97) by BN9PR03CA0143.outlook.office365.com
 (2603:10b6:408:fe::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 18
 Nov 2026 23:09:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BC9.mail.protection.outlook.com (10.167.248.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 23:09:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 17:09:57 -0600
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57
 via Frontend Transport; Wed, 18 Nov 2026 17:09:56 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <xiaogang.chen@amd.com>
Subject: [PATCH v4 1/3] drm/amdkfd: Add awareness of THP of device and system
 RAM in kfd svm driver
Date: Wed, 18 Nov 2026 17:10:58 -0600
Message-ID: <20261118231100.68176-2-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118231100.68176-1-xiaogang.chen@amd.com>
References: <20261118231100.68176-1-xiaogang.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC9:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: cc679871-4508-4224-83d8-08df45c9108d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|261021123027099003|10067099003|11063799006|261022075727099003|261026140227099003|261102130727099003|261021121427099003|261009223027099003|56012099006|261028144727099003|261102123227099003|261022113327099003|261026121527099003|261022105027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: fLOTYdWdZiWY5LbXXFR1vmjt5fIlBJU3jl3+E6SObwVKQyL7LsxQeb6YRE28zI8J2nqYjWNAk67hHc8UQItV7OqkYrRUh9ZH6dJukM5qaoFF3ZgaaYzLaQqvDHiO8Z4GJYdGuOsQHhcsxKv70Xu6bHlW8mxBaYR107Az/UqGGgRW9MQBkdML3Oq9O20xZrScxXgz2cSJFZDqfB0IFewXRcPRksCcmSxjp4NJajQZ/Jb/pFrFbK6Xl5wm5Nt+2s4Q3dGntTwgGdv91h/p2kllxC/7QV5yFBe5haL2SheBBJbRP/Ggf+1SvuxdFEcqbUNt/WWkVCtyTNz42ZGI1qhVKeaUHXrGozp2JBtupL8oifgiF2ic5ZmrqvaUIoil4Xmt8ncnToNPy3PrTvWcEc/KXNKfeAYs9Xw0L8+9+P7+XXo1EvF/I9RsWZSv4pn1HHYrLk5fzv14lLA0LmxabwX1WbwfYAdg/jkBJ4Gt1NL3II4GvTfNepwM1Pt6p9Ma+2b4CbGrU0XH3v5EpAXA/vUSVkXhfkI6CKGGwg9Y65hIIHwXJaJyMrLBEspc+TqXQTQhv/GPPv1nV09YwuKtbeC+0wjY1rxzMdqzRbbn+x0mpJiwsAQIThaGL9tQMoUOVkUTqmdCu3uGK+NYcC0r3Z/UdNNcvZP/Onc1252e27HYpIVoUCjfI4TlG8kWUNrdggB9okRYJSgx1Lo08MiVeh6J0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(261021123027099003)(10067099003)(11063799006)(261022075727099003)(261026140227099003)(261102130727099003)(261021121427099003)(261009223027099003)(56012099006)(261028144727099003)(261102123227099003)(261022113327099003)(261026121527099003)(261022105027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F1YWHMYAHmnhNJENr3uuudiOygNsTd2SrUdIvWM1TuLrWGjvPQp39Ez8zIhf+WveQV05RZTzRH7zunrbEiojZiEaK8c6Ge4K2TSHGbuDerSEqZ+N+L9zHVkhSaZevcxh4Kalil65C+3K6T9kT3Moz5YbJlD42jXoDlgMLNfQoXFLkLVXfP0h37E7OJ0e8hgZWdRoZRTGD+TK7ntfxmPCQNyNhLY9FnjXgTp2ot0Cliy2f4i7Kprxf5SvRHDNeLCqHgHyfidUns64ierEQhfgqPNRy7EkT/1Aptus6IgmlR+15pTB6sQizLyVOozS+8TPPnBe0ZVjnFfhLIXk9UGkNXbtFs+E8u1SkLh1izaTWg/Xw0VsycEgKbDuNRkG/Jyz5ZdKTrBf7fKcyZX0EaphwX942SbfMNmckfZDDAPilBU/4RbUY8II6M6IhuwNZTZk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 23:09:57.7923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc679871-4508-4224-83d8-08df45c9108d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755
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
index 8b96e1fe741a..20eaf01087ca 100644
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
@@ -302,7 +369,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 		if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
 			dst[i] = cursor.start + (j << PAGE_SHIFT);
 			migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
-			svm_migrate_get_vram_page(prange, migrate->dst[i]);
+			svm_migrate_get_vram_page(prange, migrate->dst[i], 0);
 			migrate->dst[i] = migrate_pfn(migrate->dst[i]);
 			mpages++;
 		}
@@ -616,10 +683,17 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
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
@@ -678,7 +752,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			j = 0;
 		}
 
-		dpage = svm_migrate_get_sys_page(migrate->vma, addr);
+		dpage = svm_migrate_get_sys_page(migrate->vma, addr, 0);
 		if (!dpage) {
 			pr_debug("failed get page svms 0x%p [0x%lx 0x%lx]\n",
 				 prange->svms, prange->start, prange->last);
@@ -1081,9 +1155,25 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
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
index a99dbedf3cd4..8ffebc2c4237 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -245,7 +245,16 @@ void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
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
@@ -578,10 +587,20 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
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
@@ -593,9 +612,16 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 
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
@@ -956,6 +982,7 @@ svm_range_copy_array(void *psrc, size_t size, uint64_t num_elements,
 	*vram_pages = 0;
 	for (i = 0; i < num_elements; i++) {
 		dma_addr_t *temp;
+
 		temp = (dma_addr_t *)dst + i;
 		*temp = *((dma_addr_t *)src + i);
 		if (*temp&SVM_RANGE_VRAM_DOMAIN)
@@ -1628,7 +1655,7 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx, bool intr)
 	uint32_t gpuidx;
 	int r;
 
-	drm_exec_init(&ctx->exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT: 0, 0);
+	drm_exec_init(&ctx->exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT : 0, 0);
 	drm_exec_until_all_locked(&ctx->exec) {
 		for_each_set_bit(gpuidx, ctx->bitmap, MAX_GPU_INSTANCE) {
 			pdd = kfd_process_device_from_gpuidx(ctx->process, gpuidx);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index c7d7adae4476..5c878e884582 100644
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

