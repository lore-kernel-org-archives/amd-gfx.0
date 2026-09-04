Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA489C79F82
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2026 19:54:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37FA410E0DB;
	Fri,  4 Sep 2026 19:54:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r+bg8X7s";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F13B510E0DB
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2026 19:54:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=td6uKUTL5X93gXcWDkkSO1uCppzKeGhcH6v3r8T7LB9CU/ME2RlZYL2FC2i7WRfs86+nS1iDUhlYGGzKzBnEbxWmEk5kdkYXCqGuPKSO0yYSmgy5p0KlXAMlEn1MIrXjMXvw72kZioGDPm2stY5wTp81vzjFSpAyi1hPg13VaGd9nvSxZSLQwwoM+MD5xSJ/Nw88iCi0Zs5Tk2oVHPc96VtC6SPQzjVE0kkeWcmvkh00YgnLKAJ3LOGOT+bSw8/hMia1P5AqWfawMkrFFqBDYSK/oBQKKd4wkZQQaIHD2uL0XkqHKRqr9Ej2OY29XrcNXTcre5ghnVAaQVcG60Nxig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0I4PC1wgvdHHRHYFP5Avskh3xvEmD8c2MPIYxkV3F6c=;
 b=v8K1z4m3ykPRFFOb7V3DYheaoO2sa+UwNL0eztET/oQynVZ9rAPaGhZCFfxrafMWgr+uScsWxKv5Er0G5B2Xahes1IhdbOxkSkIiqUAR8zCtaDuHhA+jcSlf8fa3un8/LCy9kg3JbtxuFhJLSYppo9DOAMsKW/eiWrAXNZzw2h8uvV7uEjAP+pfPnxikRwO8h77caQRwbaEiDAJta5n2wUsJrY1Hjsd++l2eiEgkdeZ5eUZih1c9i0/NpoGsJDcKDj6XUdNGEoRnlU0H89wkEJ20k5LikOavE9ugdWnxCM/UQpcW5e5Jl7JC5Ce71vigRSzzdtw+mdN9XqLCFqCsLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0I4PC1wgvdHHRHYFP5Avskh3xvEmD8c2MPIYxkV3F6c=;
 b=r+bg8X7sTUOFBhpUu1ZRzZ1kR5ijLJTAuWICOuB2gKgTB2iC4VKDbRcFRo9KKEHlkHwK3K6i8GaIJ/OBGlEd+1besJn9+V+CIH8RFncC1GDjYB01yt0kad+UYfS65GMtx0TFu0bEo5Qk1frnBhI6Vwu/HuyqFXN7kQ+KuVn51iA=
Received: from BN0PR04CA0011.namprd04.prod.outlook.com (2603:10b6:408:ee::16)
 by IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 19:54:28 +0000
Received: from LV8PEPF00000066.namprd03.prod.outlook.com
 (2603:10b6:408:ee:cafe::9b) by BN0PR04CA0011.outlook.office365.com
 (2603:10b6:408:ee::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 19:54:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF00000066.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 19:54:28 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 14:54:25 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Fri, 4 Sep 2026 14:54:25 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH v2 1/4] drm/amdkfd: Add awareness of THP of device and system
 RAM in kfd svm driver
Date: Fri, 4 Sep 2026 14:54:18 -0500
Message-ID: <20260904195421.42919-2-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260904195421.42919-1-xiaogang.chen@amd.com>
References: <20260904195421.42919-1-xiaogang.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000066:EE_|IA0PR12MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: 63045226-314d-4b8f-7be2-08df0abe542a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: Vg+siGHV3eJkea46BhezXOvtE+QwIjunyHcyVkHuF++Y09fdw6kNuqoXA8HlpuYehalDSS5jDuDIugdIKpvD+dDrnEmSUE0NVP5hcBYLBSEDWG0B1PhF4ZythsFN3+HM0sI7pCD6JbXGg/bXc8nwXVHELWTdn0PI4nhEvRXJiczhzxuasBO+rxzvQ23lbmIAUDYiTml73gIuVFhmv0SManpxG1LfXEhmhHvF10CBteq4HHpGd1/EVTH+r6deEx7vItHeR4ysNUyCmEmIRQf5cMT5SmgEAGEmaJEvJ/2wBMNhd9lOGJwqcSYh1mM7thz0aiuUoYqgnP6pLM+H1lErw2TLBJ8gbBUJ0LPx6Vij9lUKjIubw2Ezv4yyKluADwymiIHwFoQbiLLenzmdjoRyuYw2WpRokdgQ1eTYu3dsQkg8o5yaJXjfgOpTLTYbGZk1cNaS9eQMZHQvadR5EZnDmkb9t/QGjV8PgXAuDy5MzaXLwyxQf3Op56JjW/mkz272sahsFNhOymPNBnPLv2nYJTivWX0gNZNIVuLS8ujFZtMAd9dgt/X72K24JPUt/RUcCbOYjii/m7xZWqisTenSvYGa7B0uNxNpT7t52SARzZoQR434sO6UZgNpid9XtGH25MtLSLVAbW/yg2Gqx+9tre9M3YPvdJengQJ05th5pRy9EVu2MzAomOgOioHOROoTeuPHtZh/vdfbomXgCrpaXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WpA8oCUxQtGYF64hAuvAEoKr0kAnv+uXszQYUilvESeGg7M3YzIYJduFKySZas+T8Ds38fsYDp78UQuKvq4vlfGo7CGSVYNkJff64rK18clkYi2qFs3yHitfb0ZVXPpfgDhrU+lkiitgsTUFCA5uEHQs8HzTMBAq71SMTDqzPHtUiZTwSPQLAFHrkiAhugKTvhRNJGRQ44+ObtzX554s+TyQZ3VGEkow3Ukh+5qgeb8XN64+XkWlw5KhjVdgIuP613pIm4aTlbFqf1CFIuua+oQlaOiqVXcwTJbM0ebGeAkHakujFeoklLL6AK6/n5voF03PfKI2cSWUtiC1Ggb3RTb+olHhnPMCJ/nUkS+/Q4b8oGux66fiX6Vx9J91Mu9yvmxJ8htWI83bLbmCyLvpXJGVVnw+xIE6lJp7YWnzDaWgSTeXzp7Xhj3ru64UYsJB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 19:54:28.1607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63045226-314d-4b8f-7be2-08df0abe542a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000066.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7699
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

Extend kfd/svm function to allocate HPAGE_PMD_SIZE based device memory by buddy
allocator, each drm_buddy_block is HPAGE_PMD_SIZE aligned and to allocate THP
system ram by vma_alloc_folio.

Introduce SVM_RANGE_DMA_THP flag that indicates dma map of THP. THP dma
addresss will use this flag.

Add dev_pagemap_ops->folio_split callback that is called by folio_split when
core MM splits device memory folio.

These are preparations for following support for (THP) migration of zone
device-private memory, no function change.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 50 +++++++++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 15 +++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  1 +
 3 files changed, 54 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 253365a8257e..813f3c1d29dc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -217,14 +217,19 @@ svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long addr)
 }
 
 static void
-svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn)
+svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn,
+			   int order)
 {
 	struct page *page;
+	struct folio *folio;
 
 	page = pfn_to_page(pfn);
+	folio = page_folio(page);
+
+	zone_device_folio_init(folio, folio->pgmap, order);
+
+	folio_set_zone_device_data(folio, prange->svm_bo);
 	svm_range_bo_ref(prange->svm_bo);
-	page->zone_device_data = prange->svm_bo;
-	zone_device_page_init(page, page_pgmap(page), 0);
 }
 
 static void
@@ -247,11 +252,17 @@ svm_migrate_addr(struct amdgpu_device *adev, struct page *page)
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
 
@@ -265,8 +276,12 @@ static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
 
 	for (i = 0; i < migrate->npages; i++) {
 		if (migrate->dst[i] & MIGRATE_PFN_VALID &&
-		    migrate->src[i] & MIGRATE_PFN_MIGRATE)
-			mpages++;
+			migrate->src[i] & MIGRATE_PFN_MIGRATE) {
+				if (migrate->dst[i] & MIGRATE_PFN_COMPOUND)
+					mpages += HPAGE_PMD_NR;
+				else
+					mpages++;
+			}
 	}
 	return mpages;
 }
@@ -300,7 +315,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 		if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
 			dst[i] = cursor.start + (j << PAGE_SHIFT);
 			migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
-			svm_migrate_get_vram_page(prange, migrate->dst[i]);
+			svm_migrate_get_vram_page(prange, migrate->dst[i], 0);
 			migrate->dst[i] = migrate_pfn(migrate->dst[i]);
 			mpages++;
 		}
@@ -568,6 +583,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	return r < 0 ? r : 0;
 }
 
+/* folio can be compound folio or single page */
 static void svm_migrate_folio_free(struct folio *folio)
 {
 	struct page *page = &folio->page;
@@ -630,7 +646,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			j = 0;
 		}
 
-		dpage = svm_migrate_get_sys_page(migrate->vma, addr);
+		dpage = svm_migrate_get_sys_page(migrate->vma, addr, 0);
 		if (!dpage) {
 			pr_debug("failed get page svms 0x%p [0x%lx 0x%lx]\n",
 				 prange->svms, prange->start, prange->last);
@@ -1033,9 +1049,25 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
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
index fa4054d51f60..6b783d12bce4 100644
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
+
+			dma_addr[i] &= ~SVM_RANGE_DMA_THP;
+			dma_unmap_page(dev, dma_addr[i], PAGE_SIZE*HPAGE_PMD_NR,
+                                   DMA_BIDIRECTIONAL);
+		} else
+			dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
+
 		dma_addr[i] = 0;
 	}
 }
@@ -578,10 +587,10 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 	}
 
 	memset(&bp, 0, sizeof(bp));
-	bp.size = prange->npages * PAGE_SIZE;
+	bp.size = ALIGN(prange->npages * PAGE_SIZE, HPAGE_PMD_SIZE);
 	bp.bo_ptr_size = sizeof(struct svm_range_bo);
 	bp.destroy = svm_range_bo_destroy;
-	bp.byte_align = PAGE_SIZE;
+	bp.byte_align = HPAGE_PMD_SIZE;
 	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
 	bp.flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
 	bp.flags |= clear ? AMDGPU_GEM_CREATE_VRAM_CLEARED : 0;
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

