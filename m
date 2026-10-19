Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C37FCCF2D6
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 13:38:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1926210E65B;
	Mon, 19 Oct 2026 13:38:23 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013043.outbound.protection.outlook.com
 [40.93.196.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A0DA10E65B
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0JOdOvR7Hjn1S6qAXhmsjWhV1U/2MQsybf2jUBrRFQtgmQGGF3cf/hcKe5vEpSDwQq+cmYA3QDpLwwVtAzYKCS5X58OC8s2uetkGq9+FZYwnLQUW47/s3NkITFVbST4WSPzyG700vYeqlyKD/R7X7s4zKPcaDQ/QhMktZqxBnWffTjPgBbeBhQD5i+YCftGl8i0KFGy5sT4eUxIGX7WYAjqtWgk6EPHw9GDAx+ap4RJZWz0PzV9rzd1XxTyzNy6y4E//ND5/0bI2uYPmVOmxwi0+dcDxzDb+akB2BRzpnyOp6whC6Hp9CdM1KZlXGQ9PnW7ZkBjgVub/EiapVDJGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tv0RmeV8U8q/26TDR7frV5XBA4SuSyUe9QY1G5Q90pM=;
 b=I0/HRhtVpStkXqrlWGoNSNzVtkgDxUnPNzrNlielpkDtF7NtIY+l6bWXP9wSc/5FDMwmc9NOdBfpm7oUZxaY3ANa4B0sL+aNtc5wv9Mi5F0Xv+/la8PITF+qyPNMDrvC7aoPkK0TEMQYhAfY0N9hm2xmnhQjbNzQsF3AWFN8hjSdeXxxe239EetyO1WtHEQ/6auqACiwlKGn99oENexOUCsIbnwjA1faAfRW3DQG2BsNIoUYL7BVnvG2Ebb2t6QzctOATDFZ5S2wgVYulzVyrWvCKZb5em5lNx2RmUsBivG+cf2FwFd8ZcQ+IHoZCyliZMhaBQ2h3Ehj2qMU7v6DFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tv0RmeV8U8q/26TDR7frV5XBA4SuSyUe9QY1G5Q90pM=;
 b=i418fHdGIkejJ8V8TRQal4cGMfVRv3hyr+/CtP2aUp9AIMLFMhgjidVmgERpay6dwrcDqKosiNKbMksucX4CA/2/Af+BhEZMazCQDvcdroNEZLJQzRGh8Ac0FBtdfpTVLGrN0E0rMlgXugOt3pLUmSlo1xCwlqoqseSeI/qStwE=
Received: from BN9P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::24)
 by CHBPR12MB790180.namprd12.prod.outlook.com (2603:10b6:610:33d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 13:38:13 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:10b:cafe::31) by BN9P223CA0019.outlook.office365.com
 (2603:10b6:408:10b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 19
 Oct 2026 13:38:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 13:38:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 08:38:01 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Mon, 19 Oct 2026 08:38:01 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH v3 1/3] drm/amdkfd: Add awareness of THP of device and system
 RAM in kfd svm driver
Date: Mon, 19 Oct 2026 08:38:43 -0500
Message-ID: <20261019133845.166916-2-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019133845.166916-1-xiaogang.chen@amd.com>
References: <20261019133845.166916-1-xiaogang.chen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|CHBPR12MB790180:EE_
X-MS-Office365-Filtering-Correlation-Id: d19b00fa-1faf-40d5-a630-08df2de638dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 5u7+MpqdEQKqTjuw33ATUcopNhGG4L9Kds8m6mprGmFWY6fFkjr5c9SaEqSKoCgjOsxgCGhd9Q5XRb4dj/8IKFpG7eH7B6k3p2DdwaEsHaNOj1F2N9DAlzSEA6Vxrx+KSJPZlzg3MSjokefoCsxYy+/uniDtCVHpy3Vf4FhjZL8Ol3WKF5uq5Wh9E8S9I/SebAjh0OL1Z5EuEf4LYRADaRenFZDAaBddrF7n2KRFjkWSBnjKeMLMVt6vCfno+RJ8A9lOeiqo1iQXhe/MRJUDwgdhhLt82t44Yokrhd5X7I0k86sVn7a0zMOdfFOMBNM+boEAv7GSxgfe5Beo3wM1mGhkywSTIbtE1Iffd4yRtZJLQtz6z2d8/tckzlLxOf+g02iCExSBqsPVOxg+BUP7zMPE7GzwgzZOZV9i0iIrqTbqpXEyu/bbSgJ+IY0q+gA6NBkeUtKwAiweB+ZHQ0PZWYS4jgtnGBdlVs1Wtet8jH5lH8LCdHSh73oRPVVzakX9v2EpLkNRVXAQPUm+221rsRNekABDX3y5NZLkx3dPKTrtyaXPKSiJD9joblY3Mv45A+kizRhj5XuqQlyzbBgGkVr9725pmyVqjYPyeLMe8ef00teLSTF7fYTVXNuiqBvYssFzn2kz58QlSwdqKQy6jHI6Q9IHkdcwflquINUJKMtR61j8w+xdjYJnP16bniIhy79Dhj3WH30NtjIH210piQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2sAk5uOP9kislkUE7dYX7K5FJebiaWfk0MG5G23RNRH8y7SEg0beaK88r98h9Zd4EL0wVjlJWHpTtBMfl2QkYrAkNbRVkJiZJSfJrFbT/XjpwVPnKvU9lWEVXX4ZJBfThn9LKICGrtHFj39L8AIe4pHyhR9VkOffPzihwdjRMP1IYldOf0IEehPGd/3XRYIa4rOekjjgIJfXMNWsMdX3glZE9t3l2lETckd7hHnRzgfAjQNaGeTOXGVAVYCQjJbkbRh/YVZ6C7BCotP0wMAihbGeIUuEulJDgDI0rgyalOJRd3CGJa/cuwhYpz3vpqQwMkvadxHd7Atz25wR1yPhEYF3RdumuMK6N48kapZfhz3C90TOpzygLtE/PI+WEKCqvEcfz8RuiBXeqHbuYWyXp+gdVOXvpTxI75RqC/3LSsUAR28K07t91kW7meTIUyzz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 13:38:12.8892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d19b00fa-1faf-40d5-a630-08df2de638dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB790180
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
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 84 ++++++++++++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 37 +++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  1 +
 3 files changed, 104 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 8b96e1fe741a..7a129c9954fc 100644
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
@@ -249,11 +277,17 @@ svm_migrate_addr(struct amdgpu_device *adev, struct page *page)
 }
 
 static struct page *
-svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned long addr)
+svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned long addr,
+			  unsigned long order)
 {
 	struct page *page;
 
-	page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+	if (order)
+		page = folio_page(vma_alloc_folio(GFP_HIGHUSER,
+						  order, vma, addr), 0);
+	else
+		page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+
 	if (page)
 		lock_page(page);
 
@@ -267,8 +301,13 @@ static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
 
 	for (i = 0; i < migrate->npages; i++) {
 		if (migrate->dst[i] & MIGRATE_PFN_VALID &&
-		    migrate->src[i] & MIGRATE_PFN_MIGRATE)
-			mpages++;
+			migrate->src[i] & MIGRATE_PFN_MIGRATE) {
+
+			if (migrate->dst[i] & MIGRATE_PFN_COMPOUND)
+				mpages += HPAGE_PMD_NR;
+			else
+				mpages++;
+		}
 	}
 	return mpages;
 }
@@ -302,7 +341,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 		if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
 			dst[i] = cursor.start + (j << PAGE_SHIFT);
 			migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
-			svm_migrate_get_vram_page(prange, migrate->dst[i]);
+			svm_migrate_get_vram_page(prange, migrate->dst[i], 0);
 			migrate->dst[i] = migrate_pfn(migrate->dst[i]);
 			mpages++;
 		}
@@ -616,15 +655,22 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	return r < 0 ? r : 0;
 }
 
+/* folio can be compound folio or single page */
 static void svm_migrate_folio_free(struct folio *folio)
 {
 	struct page *page = &folio->page;
 	struct svm_range_bo *svm_bo = page->zone_device_data;
+	struct dev_pagemap *pgmap = folio->pgmap;
+	unsigned int order = folio_order(folio);
 
 	if (svm_bo) {
 		pr_debug_ratelimited("ref: %d\n", kref_read(&svm_bo->kref));
 		svm_range_bo_unref_async(svm_bo);
 	}
+
+	/* So TTM can reuse this VRAM as 4K pages on the next range. */
+	if (order)
+		svm_migrate_clear_compound_pages(page, 1U << order, pgmap);
 }
 
 static int
@@ -678,7 +724,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			j = 0;
 		}
 
-		dpage = svm_migrate_get_sys_page(migrate->vma, addr);
+		dpage = svm_migrate_get_sys_page(migrate->vma, addr, 0);
 		if (!dpage) {
 			pr_debug("failed get page svms 0x%p [0x%lx 0x%lx]\n",
 				 prange->svms, prange->start, prange->last);
@@ -1081,9 +1127,25 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
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
index a99dbedf3cd4..8e1fb5df8abd 100644
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
+			dma_unmap_page(dev, dma_addr[i], PAGE_SIZE*HPAGE_PMD_NR,
+				       DMA_BIDIRECTIONAL);
+		} else {
+			dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
+		}
+
 		dma_addr[i] = 0;
 	}
 }
@@ -578,10 +587,15 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 	}
 
 	memset(&bp, 0, sizeof(bp));
-	bp.size = prange->npages * PAGE_SIZE;
+	if (prange->npages >= HPAGE_PMD_NR) {
+		bp.size = ALIGN(prange->npages * PAGE_SIZE, HPAGE_PMD_SIZE);
+		bp.byte_align = HPAGE_PMD_SIZE;
+	} else {
+		bp.size = prange->npages * PAGE_SIZE;
+		bp.byte_align = PAGE_SIZE;
+	}
 	bp.bo_ptr_size = sizeof(struct svm_range_bo);
 	bp.destroy = svm_range_bo_destroy;
-	bp.byte_align = PAGE_SIZE;
 	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
 	bp.flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
 	bp.flags |= clear ? AMDGPU_GEM_CREATE_VRAM_CLEARED : 0;
@@ -593,9 +607,17 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 
 	r = amdgpu_bo_create(node->adev, &bp, &bo);
 	if (r) {
-		pr_debug("failed %d to create bo\n", r);
-		mmput(mm);
-		goto create_bo_failed;
+		if (prange->npages >= HPAGE_PMD_NR) {
+			/* fall back PAGE_SIZE granularity */
+			bp.size = prange->npages * PAGE_SIZE;
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
@@ -956,6 +978,7 @@ svm_range_copy_array(void *psrc, size_t size, uint64_t num_elements,
 	*vram_pages = 0;
 	for (i = 0; i < num_elements; i++) {
 		dma_addr_t *temp;
+
 		temp = (dma_addr_t *)dst + i;
 		*temp = *((dma_addr_t *)src + i);
 		if (*temp&SVM_RANGE_VRAM_DOMAIN)
@@ -1628,7 +1651,7 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx, bool intr)
 	uint32_t gpuidx;
 	int r;
 
-	drm_exec_init(&ctx->exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT: 0, 0);
+	drm_exec_init(&ctx->exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT : 0, 0);
 	drm_exec_until_all_locked(&ctx->exec) {
 		for_each_set_bit(gpuidx, ctx->bitmap, MAX_GPU_INSTANCE) {
 			pdd = kfd_process_device_from_gpuidx(ctx->process, gpuidx);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index c7d7adae4476..f2b3a05cd8cf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -35,6 +35,7 @@
 #include "kfd_priv.h"
 
 #define SVM_RANGE_VRAM_DOMAIN (1UL << 0)
+#define SVM_RANGE_DMA_THP (1UL << 1)
 #define SVM_ADEV_PGMAP_OWNER(adev)\
 			((adev)->hive ? (void *)(adev)->hive : (void *)(adev))
 
-- 
2.34.1

