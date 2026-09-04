Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B55C624D3
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2026 19:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42BBB10FB32;
	Fri,  4 Sep 2026 19:54:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PgAbCy++";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F56C10FB01
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2026 19:54:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBE4ZZA1zvK7SsaRVEMlGvURvfOhF3nPLuxnD8zWSDBNpIlY+ISE7FJPdwbCPkXCuZrEJfFxiGG5UKIVkqgCjH8KuKbmeR1xbIWsuR4INouPbTyooOdbolYSzMYPuu+irKYcABdDNJFWVxdVk+OirUIl0HIqMKUxbrk1xLFjYwHC6c+nyFy1klrsnGFVZx26+2f/JBaQ9rNFr3Vm5ZZQTaW4dtEMgHs8g6o/f5An9iJkvyekvAuLwwZyXKmwsjXOLNFVcvIP/t24Q9zsFOy/TvlahdDMV7nl933qJwVs9PSpoPn+9AovX1ERWDeleA4EYWzbOHVtpPaUX7v89EThqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3H5tQbbQDK5PRPbkDv+1ocVvf0eOIOouOTvD4nqnlA=;
 b=bMyspcwAOeWjPwe5giniddBTv2fvEUP4kkPeX9mTRRUoUlttBrkRQLtUBgNT4enTAOQH9zEkKnfTsA+psUFily9mAbtvJdeyKkV3PTJnGpU04GKVVvaiHkd2vW8qqSnV3V7oqifh69HnM+kVhVF4qIqWTrZCg4yvPc3xJ8sy2rsRG9HbNds54vQymHLtMSKTcb2UaY0sYVqFKSkIwPAinBzoeSsk17/crOw5zmgLIRoD/g564hS1h5YGnEYpkaAB9LNQtMfMhjfrXPae/fsyPPTeFhq/+WNBGj5dx3NsFeFZm5CeXQxLZ5foBb3GmxO+WTSvHE6Few494UUsDO1DAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3H5tQbbQDK5PRPbkDv+1ocVvf0eOIOouOTvD4nqnlA=;
 b=PgAbCy++swn06ebXBEZW2yHtnWDprMkqIH+fRkXjLvR7bgw6KE70cJzQ08yFKy3/SxMjdhDCObLMZQrI01YzzCUn/E2Qoiq1a4Acfv6ZCwQby/Wnj+WTYjHVClzZHb9jAetDTgZM9psLnjysjD3FtBuZ3QEo8MokRpAxKT6sJ0E=
Received: from SJ0PR05CA0206.namprd05.prod.outlook.com (2603:10b6:a03:330::31)
 by DS0PR12MB9323.namprd12.prod.outlook.com (2603:10b6:8:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 19:54:28 +0000
Received: from BY1PEPF000264B1.namprd02.prod.outlook.com
 (2603:10b6:a03:330:cafe::75) by SJ0PR05CA0206.outlook.office365.com
 (2603:10b6:a03:330::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.3 via Frontend Transport; Fri, 4
 Sep 2026 19:54:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF000264B1.mail.protection.outlook.com (10.167.242.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 19:54:27 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 14:54:26 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Fri, 4 Sep 2026 14:54:26 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH v2 3/4] drm/amdkfd: Apply HMM THP zone device-private memory
 migration in kfd driver
Date: Fri, 4 Sep 2026 14:54:20 -0500
Message-ID: <20260904195421.42919-4-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260904195421.42919-1-xiaogang.chen@amd.com>
References: <20260904195421.42919-1-xiaogang.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B1:EE_|DS0PR12MB9323:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a18f6f-6426-4900-c1c5-08df0abe539d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|11063799006|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 6nsasH1no5RTDAe2NHncQtTr1OrLrliPpHBNVSSM9CmZmckk7c++8pEvSfIbDAi+tTNVi4Drz8OJBVqXWQwNbPMJFnO+2O0JO7swRfoFjtjVCX964BUGa5CtwroaaJAhWD4okxHRuTEh8MwcBBsH20lrFHzMeQAcnYXMgL+o/Xv0rQadnP18765kfXp30X3UagRvP8sHt3CXEdpnblY7vZO2QEU0oDM0nTqtq8pQ2wMjEAlBqw+AWmAolZpeI6GRVKtxdIoCRU+6umqkfCsT4ZSUOaA23y4GnwWQVKkfiXPuyebNVzWGo3pniz+jfrN8a4cI0SFqh6F9w0I/evqUPSaDtHM/hVfK6UdvoZYAM5Y90zh1DgheOtJYetJnGQOWLlDLvXtOxYMSWa0QpmTHPDgwMuwfaC9qMgOTz/BF4uXpBUbUUJ5jdEDajbArRQhXVG/XPe/qXP1eRhZq0BOnhLhIzM6x6t5MzxWXe295XANLxRNqUs1tu/6+mHkopwnYKbsA91iJ8RllDjiI2JCsyGyvKqtJBoNtbXSfCs3w55bxosBHJuNwy6WTNJPiZW1luEBuIaPr+RpWCREbjZSHNuFKxYRkRves/73zjt6zB/ZXadlUinO50cY9J5mNcZbnwkAmbbJMpo+YeVtjf3bcjMFVbgZ6d8UkB4AI74/R81V1M7lrsibwBK1iEjfnWP1EJL1pvHH7HrmfWoGbS0cM5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tiDw9EfOak0bwBywdRyNXyp6d/rntyHk9gZhyMwgLqt1EbJ487cOgJ/i6jQ90vz7scjAqRSEkOJteCUD498SLNJsHdLKL9zBHSemBRGEj07118OMez8Q3JZEHH4q+w4qQgaieHpemzhX2gpc+NKqAOgIYZbv6aVDVgCcEHg1JFZ6dUbVlMiooq9SJVOLp6bjawrtsV7k2UGdr87EleWgPozp3cFgcyBsz00IkAxhA0ZAYyK6NwzEfPxF+MqoKWU09BkMc20CN2FgTrWHHRuUG20hfjoSj5rHgYzbsPXuF4bn4Pf9EuhVYolMS2/0+FJ3whnpGOb2XqhddU55wzq+HmqftZg6+sFOsAGnRd2KTAXCrFmMiBZfQpOAtsel0x8LmMOZSYYEnW3nnMx/aEyAwXV+7Jgs2ST85uJAnj8VYmmYxqBAi0wl6EvpwbDidGPx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 19:54:27.1555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a18f6f-6426-4900-c1c5-08df0abe539d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9323
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

Update kfd svm driver to migrate device-private THP introduced from HMM core
migration function. Select this function by flag MIGRATE_VMA_SELECT_COMPOUND
when call migrate_vma_setup. kfd migration procedure is updated according to
collected page type that can be either compound folio(physical continuous) or
normal size page.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 271 ++++++++++++++++++-----
 1 file changed, 219 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index bbf0fefd5722..af39e547c1fa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -298,7 +298,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 	u64 mpages = 0;
 	dma_addr_t *src;
 	u64 *dst;
-	u64 i, j;
+	u64 i, j, k, l, m;
 	int r = 0;
 
 	pr_debug("svms 0x%p [0x%lx 0x%lx 0x%llx]\n", prange->svms, prange->start,
@@ -309,59 +309,158 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 
 	amdgpu_res_first(prange->ttm_res, ttm_res_offset,
 			 npages << PAGE_SHIFT, &cursor);
-	for (i = j = 0; (i < npages) && (mpages < migrate->cpages); i++) {
+	for (i = j = m = 0; (i < npages) && (mpages < migrate->cpages);) {
 		struct page *spage;
+		unsigned long cur_dst_pfn;
+		bool is_large = false;
 
-		if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
-			dst[i] = cursor.start + (j << PAGE_SHIFT);
-			migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
-			svm_migrate_get_vram_page(prange, migrate->dst[i], 0);
-			migrate->dst[i] = migrate_pfn(migrate->dst[i]);
+		cur_dst_pfn = svm_migrate_addr_to_pfn(adev,
+						      cursor.start + (m << PAGE_SHIFT));
+
+		/* when migrate->src[i] has MIGRATE_PFN_COMPOUND set the src page
+		 * is compound THP; its vm address is HPAGE_PMD_SIZE aligned and
+		 * its MIGRATE_PFN_MIGRATE is set
+		 */
+		if ((m + HPAGE_PMD_NR) <= (cursor.size >> PAGE_SHIFT) &&
+		    (i + HPAGE_PMD_NR) <= npages &&
+		    (migrate->src[i] & MIGRATE_PFN_COMPOUND) &&
+		    IS_ALIGNED(cur_dst_pfn, HPAGE_PMD_NR)) {
+
+			is_large = true;
+			k = HPAGE_PMD_NR;
+		} else
+			 k = 1;
+
+		/* for THP src[0] alwas MIGRATE_PFN_MIGRATE
+		 * just the first migrate->dst need be setup, others are zero
+		 */
+		if (is_large) {
+
+			dst[i] = cursor.start + (m << PAGE_SHIFT);
+			svm_migrate_get_vram_page(prange, cur_dst_pfn,
+						  HPAGE_PMD_ORDER);
+
+			migrate->dst[i] = migrate_pfn(cur_dst_pfn);
+			migrate->dst[i] |= MIGRATE_PFN_COMPOUND;
+
+			for (l=1; l < k; l++)
+				migrate->dst[i+l] = 0;
+
+			mpages++;
+
+		} else if ((migrate->src[i] & MIGRATE_PFN_MIGRATE)) {
+			dst[i] = cursor.start + (m << PAGE_SHIFT);
+			svm_migrate_get_vram_page(prange, cur_dst_pfn, 0);
+			migrate->dst[i] = migrate_pfn(cur_dst_pfn);
 			mpages++;
 		}
-		spage = migrate_pfn_to_page(migrate->src[i]);
-		if (spage && !is_zone_device_page(spage)) {
-			src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
-					      DMA_BIDIRECTIONAL);
-			r = dma_mapping_error(dev, src[i]);
-			if (r) {
-				src[i] = 0;
-				dev_err(dev, "%s: fail %d dma_map_page\n",
-					__func__, r);
-				goto out_free_vram_pages;
+
+		if (is_large) {
+			if (j) {
+				/* migrate previous accumulated pages */
+				r = svm_migrate_copy_memory_gart(
+						adev, src + i - j,
+						dst + i - j, j,
+						FROM_RAM_TO_VRAM,
+						mfence);
+
+				if (r)
+					goto out_free_vram_pages;
+
+				j = 0;
+			}
+
+			/* for THP check if the first src page is valid
+			 * if not valid skip following HPAGE_PMD_NR - 1 pages
+			 */
+			spage = migrate_pfn_to_page(migrate->src[i]);
+			if (spage && !is_zone_device_page(spage)) {
+				/* dma_map continuous HPAGE_PMD_NR sys ram pages */
+				src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE*HPAGE_PMD_NR,
+						      DMA_BIDIRECTIONAL);
+
+				r = dma_mapping_error(dev, src[i]);
+				if (r) {
+					dev_err(dev, "%s: fail %d dma_map_page\n",
+							__func__, r);
+					goto out_free_vram_pages;
+				}
+
+				/* get dma address for following HPAGE_PMD_NR-1 pages
+				 * since src pages are continuous their dma addresses
+				 * are continuous too.
+				 */
+				for (l=1; l < k; l++)
+					src[i + l] = src[i] + l*PAGE_SIZE;
+
+				/* migrate the HPAGE_PMD_NR pages above */
+				r = svm_migrate_copy_memory_gart(
+						adev, src + i,
+						dst + i, HPAGE_PMD_NR,
+						FROM_RAM_TO_VRAM,
+						mfence);
+
+				/* mark head page dma mapping as THP, tail pages dma addr
+				 * are set to 0 for following dma_unmap
+				 */
+				src[i] |= SVM_RANGE_DMA_THP;
+				for (l = 1; l < k; l++)
+					src[i + l] = 0;
+
+				if (r)
+					goto out_free_vram_pages;
+
+				j = 0;
 			}
 		} else {
-			if (j) {
+			/* single normal page case */
+			spage = migrate_pfn_to_page(migrate->src[i]);
+			if (spage && !is_zone_device_page(spage)) {
+				src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
+						      DMA_BIDIRECTIONAL);
+
+				r = dma_mapping_error(dev, src[i]);
+
+				if (r) {
+					dev_err(dev, "%s: fail %d dma_map_page\n",
+							__func__, r);
+					goto out_free_vram_pages;
+				}
+				j += 1;
+
+			} else if (j) {
 				r = svm_migrate_copy_memory_gart(
 						adev, src + i - j,
 						dst + i - j, j,
 						FROM_RAM_TO_VRAM,
 						mfence);
+
 				if (r)
 					goto out_free_vram_pages;
-				amdgpu_res_next(&cursor, (j + 1) << PAGE_SHIFT);
+
 				j = 0;
-			} else {
-				amdgpu_res_next(&cursor, PAGE_SIZE);
 			}
-			continue;
 		}
 
-		pr_debug_ratelimited("dma mapping src to 0x%llx, pfn 0x%lx\n",
-				     src[i] >> PAGE_SHIFT, page_to_pfn(spage));
+		pr_debug_ratelimited("dma mapping %lld pages, src to 0x%llx, pfn 0x%lx\n",
+				     k, src[i] >> PAGE_SHIFT, migrate->src[i] >> MIGRATE_PFN_SHIFT);
+		i += k;
+		m += k;
+
+		if (m >= (cursor.size >> PAGE_SHIFT)) {
+			if (j > 0) {
+				r = svm_migrate_copy_memory_gart(adev, src + i - j,
+								 dst + i - j, j,
+								 FROM_RAM_TO_VRAM,
+								 mfence);
+				if (r)
+					goto out_free_vram_pages;
+			}
+
+			amdgpu_res_next(&cursor, m*PAGE_SIZE);
 
-		/* accumulated j + 1 pages reach end of current drm_buddy_block */
-		if (j + 1 >= (cursor.size >> PAGE_SHIFT)) {
-			r = svm_migrate_copy_memory_gart(adev, src + i - j,
-							 dst + i - j, j + 1,
-							 FROM_RAM_TO_VRAM,
-							 mfence);
-			if (r)
-				goto out_free_vram_pages;
-			amdgpu_res_next(&cursor, (j + 1) * PAGE_SIZE);
 			j = 0;
-		} else {
-			j++;
+			m = 0;
 		}
 	}
 
@@ -410,17 +509,24 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate = { 0 };
+	bool is_private_device = false;
 	unsigned long cpages = 0;
 	unsigned long mpages = 0;
 	dma_addr_t *scratch;
 	void *buf;
 	int r = -ENOMEM;
 
+	is_private_device = svm_is_private_zone(adev);
+
 	memset(&migrate, 0, sizeof(migrate));
 	migrate.vma = vma;
 	migrate.start = start;
 	migrate.end = end;
 	migrate.flags = MIGRATE_VMA_SELECT_SYSTEM;
+
+	if (is_private_device && ((end - start) >> PAGE_SHIFT) >= HPAGE_PMD_NR)
+		migrate.flags = migrate.flags | MIGRATE_VMA_SELECT_COMPOUND;
+
 	migrate.pgmap_owner = SVM_ADEV_PGMAP_OWNER(adev);
 
 	buf = kvcalloc(npages,
@@ -609,6 +715,9 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	u64 addr;
 	int r = 0;
 
+	u64 l, k;
+	bool is_large = false;
+
 	pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, prange->start,
 		 prange->last);
 
@@ -616,8 +725,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	src = (u64 *)(scratch + npages);
 	dst = scratch;
-
-	for (i = 0, j = 0; i < npages; i++, addr += PAGE_SIZE) {
+	for (i = 0, j = 0; i < npages;) {
 		struct page *spage;
 
 		spage = migrate_pfn_to_page(migrate->src[i]);
@@ -633,6 +741,9 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 					goto out_oom;
 				j = 0;
 			}
+
+			addr += PAGE_SIZE;
+			i++;
 			continue;
 		}
 		src[i] = svm_migrate_addr(adev, spage);
@@ -646,7 +757,22 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			j = 0;
 		}
 
-		dpage = svm_migrate_get_sys_page(migrate->vma, addr, 0);
+		if(IS_ALIGNED(page_to_pfn(spage), HPAGE_PMD_NR) &&
+		   (addr + HPAGE_PMD_SIZE) <= migrate->end &&
+		   IS_ALIGNED (addr, HPAGE_PMD_SIZE) &&
+		   migrate->src[i] & MIGRATE_PFN_COMPOUND) {
+
+			is_large = true;
+			k = HPAGE_PMD_NR;
+
+			dpage = svm_migrate_get_sys_page(migrate->vma, addr,
+							 HPAGE_PMD_ORDER);
+		} else {
+			k = 1;
+			is_large = false;
+			dpage = svm_migrate_get_sys_page(migrate->vma, addr, 0);
+		}
+
 		if (!dpage) {
 			pr_debug("failed get page svms 0x%p [0x%lx 0x%lx]\n",
 				 prange->svms, prange->start, prange->last);
@@ -654,21 +780,59 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			goto out_oom;
 		}
 
-		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
+		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE*k, DMA_BIDIRECTIONAL);
 		r = dma_mapping_error(dev, dst[i]);
 		if (r) {
 			dev_err(adev->dev, "%s: fail %d dma_map_page\n", __func__, r);
-			dst[i] = 0;
 			goto out_oom;
 		}
 
-		pr_debug_ratelimited("dma mapping dst to 0x%llx, pfn 0x%lx\n",
-				     dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
-
 		migrate->dst[i] = migrate_pfn(page_to_pfn(dpage));
+		if (is_large)
+			migrate->dst[i] |= MIGRATE_PFN_COMPOUND;
 
-		dpage = NULL;
-		j++;
+		if (is_large) {
+			/* migrate previous accumulated pages */
+			if(j) {
+				r = svm_migrate_copy_memory_gart(adev, dst + i - j,
+								 src + i - j, j, FROM_VRAM_TO_RAM, mfence);
+				if (r)
+					goto out_oom;
+				j = 0;
+			}
+
+			for (l = 1; l < k; l++) {
+
+				src[i + l] = src[i] + l*PAGE_SIZE;
+				dst[i + l] = dst[i] + l*PAGE_SIZE;
+				migrate->dst[i + l] = 0;
+			}
+
+			/* migrate the HPAGE_PMD_NR pages above */
+			/* svm_migrate_copy_memory_gart will add a paramter to indicate
+			 * the migration is for 2MB THP
+			 */
+			r = svm_migrate_copy_memory_gart(
+						adev, dst + i,
+						src + i, HPAGE_PMD_NR,
+						FROM_VRAM_TO_RAM,
+						mfence);
+
+			/* mark head page dma mapping as THP, tail pages dma addr
+			 * are set to 0 for following dma_unmap
+			 */
+			dst[i] |= SVM_RANGE_DMA_THP;
+			for (l = 1; l < k; l++)
+				dst[i + l] = 0;
+
+			if (r)
+				goto out_oom;
+
+		} else
+			j++;
+
+		addr += PAGE_SIZE*k;
+		i += k;
 	}
 
 	if (j > 0)
@@ -687,12 +851,9 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 		/* release previous allocated sys pages and unmap dma address */
 		while (i--) {
 
-			if (dst[i]) {
-				dma_unmap_page(dev, dst[i], PAGE_SIZE,
-					       DMA_BIDIRECTIONAL);
-				dst[i] = 0;
-			}
-
+			/* follwing svm_range_dma_unmap_dev will do dma unmap anyway
+			 * not need do dma unmap here
+			 */
 			dpage = migrate_pfn_to_page(migrate->dst[i]);
 			if (!dpage)
 				continue;
@@ -733,6 +894,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	unsigned long cpages = 0;
 	unsigned long mpages = 0;
 	struct amdgpu_device *adev = node->adev;
+	bool is_private_device = false;
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate = { 0 };
@@ -740,6 +902,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	void *buf;
 	int r = -ENOMEM;
 
+	is_private_device = svm_is_private_zone(adev);
+
 	memset(&migrate, 0, sizeof(migrate));
 	migrate.vma = vma;
 	migrate.start = start;
@@ -750,6 +914,9 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	else
 		migrate.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
 
+	if (is_private_device && ((end - start) >> PAGE_SHIFT) >= HPAGE_PMD_NR)
+		migrate.flags = migrate.flags | MIGRATE_VMA_SELECT_COMPOUND;
+
 	buf = kvcalloc(npages,
 		       2 * sizeof(*migrate.src) + sizeof(u64) + sizeof(dma_addr_t),
 		       GFP_KERNEL);
@@ -1132,7 +1299,7 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
 
 	amdgpu_amdkfd_reserve_system_mem(SVM_HMM_PAGE_STRUCT_SIZE(size));
 
-	pr_info("HMM registered %ldMB device memory\n", size >> 20);
+	pr_info("---XCHEN 3.2 HMM registered %ldMB device memory\n", size >> 20);
 
 	return 0;
 }
-- 
2.34.1

