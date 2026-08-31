Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5B6C624C6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 14:26:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A4B810E08A;
	Mon, 31 Aug 2026 14:26:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mPk79F2+";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012006.outbound.protection.outlook.com [52.101.53.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B5C010E909
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 14:26:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyj1XS8njBodS6HEgo2NYeO4VLhum70N6JPPg8NZq/TixkysTAS3Ln5BgosOGzG8RbEqar4Y6Ax/yrGiA6PWyGbo4pmNlsXWU53hetCUTjPwJ0i4gU7OwD4nmgxabvI3P9P39e4pi3l1xhf+pFXYTEXslT04MA96lrffItdemyw1bdLKBbN6LfZ4FsbykbUNYmpjnt6u9VITClLIFsmn+sBnelpdfBpp5SJ9UnmjFFqsO/O/jSEgufTrb8pKjq97JCFhPfXWxBNHbsVcaW+Pqdo/IlYzhFa6LesHkoI/fzAyxcR0dDDpRMsdzfoJtykxcgf9pm4TTZJeg13xIhix/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BT9dLL0XzIFL9luArLtZsHRhIRpNFiWDe004v48/D6k=;
 b=Ufb5ed6+pAH5qTvv0jdFq2NZ34aF24cndwFkypT7t3H+I1kdpaDLDRS2RSVmrMvK1VBTHNU8Cv1hBZgmE90crJKdVeIIFSVBAIzyYuuCZuqwGBd3MAySh5BWjm/mbr8JTLX+8OrHDTFpvFGv0dAprCaZnp7/L2v3VNfl4YAOmgBcOMgz20QYkPVQc8OLLOvGbr+6fu7ntYwKkJuFdfaQvklRUGZhlRFVop3e883dEJ2ekTuw+YAimsKUrwsU4i2CaG2F0YrVuRyUShpa2x+l9tkeu+0KQ7w8Doty1fEA0RCqR6rQe3RrMXkKVaAS4tUtarXR4yzFOHChbwpmFSpQ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BT9dLL0XzIFL9luArLtZsHRhIRpNFiWDe004v48/D6k=;
 b=mPk79F2+w37piyvMlrFeawwOe9Ni4SNpotFHFDrX7HoKtEDRZ6Dx0DTs/FEWyZGs4p2XGdfuRMZoUOMGjEsg0MLyVp93KAqJQZ+DYZvNH5BkBU5Bb8kyXZx4pyeY19ZFZY5CoPrENIzUZ+tmQnrtXuxRaUZnyDanijpwWtt33I4=
Received: from SJ0PR05CA0025.namprd05.prod.outlook.com (2603:10b6:a03:33b::30)
 by PH8PR12MB6818.namprd12.prod.outlook.com (2603:10b6:510:1c9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 14:26:32 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:33b:cafe::8f) by SJ0PR05CA0025.outlook.office365.com
 (2603:10b6:a03:33b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.9 via Frontend Transport; Mon, 31
 Aug 2026 14:26:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 14:26:32 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 09:26:31 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 09:26:31 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Mon, 31 Aug 2026 09:26:30 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH 3/4] drm/amdkfd: Apply HMM THP zone device-private memory
 migration in kfd driver
Date: Mon, 31 Aug 2026 09:24:17 -0500
Message-ID: <20260831142418.56423-4-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831142418.56423-1-xiaogang.chen@amd.com>
References: <20260831142418.56423-1-xiaogang.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|PH8PR12MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d205bc-5daa-4913-666a-08df076bdac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: c5ozGcB5rMwNz2nbYhV+gB4GUCVQIZ2rxb4AKNkpeOrq3k32E236MAfPWP+4JkAWpVm3+rtBt9ifqIZlBZzzGQlnpEbjSpR+t+2QqC9o24U2wWhCgKuBHGsCcEmW4UdGDu89qeWbrn8BOalH0AYHh/dZ3ntcQjgpL+g13tp4WBBB3ZLnZV8g5qoKgDshsY1QsigT3OoT4nNxZKiJh2op2xPoQBO7XIu2u1zhadxrb1RmtNAWn6rsZKvAwQdPDvnaunlCR/upMkpPMtHxP1lO9N6pGNMQFBn72I4DFpXI5nKUkU11787afIhSoMiG0QtfTiamtomWKSNQxy4KIiVYL4ViWK1ShSYVLzq8ZKMhwrpoyt/p8la8bPQi7+mgmy8/kydJ51fofp0YBFNjwV2ZekPIhvxoSB0K0wuKiLc5Haz26mVS1R3MlXwL6f5LyhSA5RxwO+vdOUp5bUs4OuOPWNv9qUUSbs0LpGekKBaRmVvflmPSN3ZCZ2wAkX2Y3oVjJozU54QMZvozWmxAzpOqD6/yr45QZgvBUafzxFULc93IZqlGzRsBr1uF9GNI4FbimIH9gDJxYxFw/H71PyckRlklJEEl2fINGTRREedR6Oynmx9tylT4Y3MeRnyMWmmGJStqX9HFjzzEYuHHsZx9aUh/+fm69ZasRyM653ruoqsOdsU5TTEj1XvvJi+4CYNccZPGjRrGx2w44bFnZVAN4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DCU8s4pnr8det4pyeXsin26ZRQblEgXJJQIBQlTN+JDwmy8jPuyHM+5sJztc5TmSbE8h9N9Bpbk7O/08h1BbUJ5xl9Gaf59Mbh7bPpuPFXOfLEoLuu5e+iHrBVN6OxjuWRKZYqIEtRBFZOyueQSoSwh//VL5h2QQ/FOPwmDCiVdBiFGZHz1dzA/EhltkpJjlo5qh4zCaPWYbSLsi0/EXMgzxZjjhcbVeTDeFMwdUCG0dgyahuhnebD8SXJkYHcLeHIcORCIFBe5VpN3qRKVHytKowei4NbNuR3D3V+cDpJ+JYduGwuYN+/PNODf930e2LqV0aCeVkpeLkp4lvtoQGY2DIXOLyJPDEK3+L/vOIRHbjJigvbKXi3u7st7Yaauf5GzIFzngTsbupjrymkXiqdPQdIQrWCSDbzCEy+8m9uh1SJdw5eab9Bg3aKbs/Q/o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 14:26:32.1796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d205bc-5daa-4913-666a-08df076bdac5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6818
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
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 237 +++++++++++++++++++----
 1 file changed, 194 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index f1399dd90d2f..30eac5fbcde5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -293,7 +293,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 	u64 mpages = 0;
 	dma_addr_t *src;
 	u64 *dst;
-	u64 i, j;
+	u64 i, j, k, l, m;
 	int r = 0;
 
 	pr_debug("svms 0x%p [0x%lx 0x%lx 0x%llx]\n", prange->svms, prange->start,
@@ -304,59 +304,147 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 
 	amdgpu_res_first(prange->ttm_res, ttm_res_offset,
 			 npages << PAGE_SHIFT, &cursor);
-	for (i = j = 0; (i < npages) && (mpages < migrate->cpages); i++) {
+	for (i = j = m = 0; (i < npages) && (mpages < migrate->cpages);) {
 		struct page *spage;
+		bool is_large = false;
 
-		if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
-			dst[i] = cursor.start + (j << PAGE_SHIFT);
-			migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
+		dst[i] = cursor.start + (m << PAGE_SHIFT);
+		migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
+
+		/* when migrate->src[i] has MIGRATE_PFN_COMPOUND set the src page
+		 * is compound THP; its vm address is HPAGE_PMD_SIZE aligned and
+		 * its MIGRATE_PFN_MIGRATE is set
+		 */
+		if ((m + HPAGE_PMD_NR) <= (cursor.size >> PAGE_SHIFT) &&
+		    (i + HPAGE_PMD_NR) <= npages &&
+		    (migrate->src[i] & MIGRATE_PFN_COMPOUND) &&
+		    IS_ALIGNED(migrate->dst[i], HPAGE_PMD_NR)) {
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
+			svm_migrate_get_vram_page(prange, migrate->dst[i],
+						  HPAGE_PMD_ORDER);
+
+			migrate->dst[i] = migrate_pfn(migrate->dst[i]);
+			migrate->dst[i] |= MIGRATE_PFN_COMPOUND;
+
+			for (l=1; l < k; l++)
+				migrate->dst[i+l] = 0;
+
+			mpages++;
+
+		} else if ((migrate->src[i] & MIGRATE_PFN_MIGRATE)) {
 			svm_migrate_get_vram_page(prange, migrate->dst[i], 0);
 			migrate->dst[i] = migrate_pfn(migrate->dst[i]);
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
 
@@ -405,17 +493,24 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
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
@@ -603,6 +698,9 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	u64 addr;
 	int r = 0;
 
+	u64 l, k;
+	bool is_large = false;
+
 	pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, prange->start,
 		 prange->last);
 
@@ -610,8 +708,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	src = (u64 *)(scratch + npages);
 	dst = scratch;
-
-	for (i = 0, j = 0; i < npages; i++, addr += PAGE_SIZE) {
+	for (i = 0, j = 0; i < npages;) {
 		struct page *spage;
 
 		spage = migrate_pfn_to_page(migrate->src[i]);
@@ -627,6 +724,9 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 					goto out_oom;
 				j = 0;
 			}
+
+			addr += PAGE_SIZE;
+			i++;
 			continue;
 		}
 		src[i] = svm_migrate_addr(adev, spage);
@@ -640,7 +740,21 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
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
+			dpage = svm_migrate_get_sys_page(migrate->vma, addr, 0);
+		}
+
 		if (!dpage) {
 			pr_debug("failed get page svms 0x%p [0x%lx 0x%lx]\n",
 				 prange->svms, prange->start, prange->last);
@@ -648,21 +762,52 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
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
+
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
+			if (r)
+				goto out_oom;
+
+		} else
+			j++;
 
-		dpage = NULL;
-		j++;
+		addr += PAGE_SIZE*k;
+		i += k;
 	}
 
 	if (j > 0)
@@ -727,6 +872,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	unsigned long cpages = 0;
 	unsigned long mpages = 0;
 	struct amdgpu_device *adev = node->adev;
+	bool is_private_device = false;
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate = { 0 };
@@ -734,6 +880,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	void *buf;
 	int r = -ENOMEM;
 
+	is_private_device = svm_is_private_zone(adev);
+
 	memset(&migrate, 0, sizeof(migrate));
 	migrate.vma = vma;
 	migrate.start = start;
@@ -744,6 +892,9 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	else
 		migrate.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
 
+	if (is_private_device && ((end - start) >> PAGE_SHIFT) >= HPAGE_PMD_NR)
+		migrate.flags = migrate.flags | MIGRATE_VMA_SELECT_COMPOUND;
+
 	buf = kvcalloc(npages,
 		       2 * sizeof(*migrate.src) + sizeof(u64) + sizeof(dma_addr_t),
 		       GFP_KERNEL);
-- 
2.34.1

