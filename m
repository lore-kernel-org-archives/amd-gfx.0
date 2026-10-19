Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DF8CCF2E5
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 13:38:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 098C210E6DB;
	Mon, 19 Oct 2026 13:38:24 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012040.outbound.protection.outlook.com [40.107.209.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B20B310E6DB
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGCJxjtxE+Jn6LcIGZvVq+oirZu8SVlrd6GnTSNLd4ZvxD5C6SVorzxDv5cnom1BlLsS1QkX9dWmrP5wlBi3s8QVm72NlZkHNCRk2dLbie4OdMLSV2MTP1gWgFtpgTZEBxMXcnevZBX37Ieyf6BG2tVBKiXkBA/Bau8Hd8Z+9M2b3kDQv3RGdgdVA5oJFZgGNfCQPYb9z9occXckdQxE5ft58LQrgypfF+i5s74zLuL3ltZEhFWCbkWr8aFY208dyXINRDAhR1afJXgtzCveMCdW9dG8pudaX1MnpOFzFJwURbvfN71pTYLbto7xhWE611IoYbxCf/Au/u/C1fYe5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWhS6Isv3WpVZOrwEHUIMXcKl2r5c4qURouq3/Ogg2M=;
 b=x3KlD6e+B3aCB+zwEEA9M0QuvKCig5D6kOMI7lQU7AoZRGLLJyirkj/fpCs8ig+hacpy2CJ/V2g7bUn42QtyauTQnWvP01EcWxVg2+3GGY9SZcQ5apnm4871nP7wyWtPfesgUKYqnDfubAUwbOxSFVn8kODaRCKfMtQPrg1g0nsdAX8JAz9uakQijrsKY+PMjjlUBiSJtUFl1JNyR9RmepD4DHFY9fi0XCU8IA3Km0yaU7iT9gtlwn70vJOXQQyMnFLffWxbJUU6IxnQhUmeFz0DqPfEaGRsPk5pD9ZN2Ezu3pencowCXnINdawx3GqydLCf9M+n6uhcs3v/S77eOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWhS6Isv3WpVZOrwEHUIMXcKl2r5c4qURouq3/Ogg2M=;
 b=oMt31kEVLAwv6DXD08zieZz0wN34BoUroRv7W24NemiCdil7RMsQFjgaHyBhoY/WnUEzhiRNNJ4fNLVj20scGiDVL2feS/13Esed1qxakFs0WPuGOqcIbNE58VorsZO/3z1nZAllABGSgn6tkcZaeVi+HL3oozAbVBx1NRGN9Ng=
Received: from CH0PR04CA0003.namprd04.prod.outlook.com (2603:10b6:610:76::8)
 by LV8PR12MB9449.namprd12.prod.outlook.com (2603:10b6:408:204::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 13:38:10 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::9d) by CH0PR04CA0003.outlook.office365.com
 (2603:10b6:610:76::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 13:38:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 13:38:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 08:38:02 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Mon, 19 Oct 2026 08:38:01 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH v3 3/3] drm/amdkfd: Enable HMM device-private THP migration in
 KFD SVM driver
Date: Mon, 19 Oct 2026 08:38:45 -0500
Message-ID: <20261019133845.166916-4-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019133845.166916-1-xiaogang.chen@amd.com>
References: <20261019133845.166916-1-xiaogang.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|LV8PR12MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: ec0d34b3-6442-4bb8-8b9a-08df2de63734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|18002099003|10067099003|22082099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: c1ZlKy6Cvn8jlCYaO4acGg3EGzf7AWsO/2fj/B03s+ImyHFYGTGt0YfrdUwu/K6bnghVtQUTxd/4I9/JZVzhHZE6JLqMxHwy0ahnWtSpE6eRu1/6/d6OOxIvUtLb8sP9gWi8yi0FslYQX9Yap1qTMkK2g8lrBz1lZF3zI/SMeFK6pylOxkWIk+q4uOsjrRkNtwRM2VVZHkpvB0vVegThkXXW4hj3jIz9E+TIp3FnZpDtF5Clzk7fVWiYVs639GayApaB3/c3lfpuDEF2A95rSPXxetss31IwKWliEmDSBFqu9kCeSwZGHFjIzuFtZJZ1rpfMpU7nUcT8xiSdVrWHjTD6ZBwNGw6UWjDIzuDb54GI5eC7q5dz0nWHPSuvhESbG2wKnuFXqpUa0U/hp4xb1uQC8E1rbdO03nuzcwjET7yI+g2CVvHhKQrOt9RPof+rBvK2MOUi6XBwqMxrYLyucLevnFBNQLCh/sZvJPXkVxnSw29LrI1ZocmqOCby0AzRtX7A/xYLlJqO+UwG+vy7ljx1o4UtYtDAG6UXJ7nyyweOVpEithllWIUiZZUy1pYoQB1CxAhGg2bUPLuJ4XS2On+DLU2Rp6hlVciPxjbSho9wwjShXO2h7KAGC8Xjjwl+zq1c8nMP60Ors0Wav9JXGVl70VtdYYJcLC7AHNo7vA8DnKAiYgDlMQLivivp8yc0hbZ2L+2Wu5akiOEVimWznw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(18002099003)(10067099003)(22082099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o2nnx+J9FEqFHRbknZkc8tp9035QMxEi/GSN6wqbXRTjLBJwqmxSIBNzsYinxxTwGvI02mXb4xV46kwkQvo35T7km58pAv0kBj2XkQ60BkLU9SAhLCYtmVXAPEHZi/QpxcTO+sayNrsoFzY4sPKshDYd/oH/SvfOOTz+VLsLBopwgJzFU0Mse/ZxnjYePlgF4rTKDnnEzIWDHgkPz2I9Fa3YUf/b77l4RvQquCwIhuPnn1LnGSEzQxM7aP1J8jfpwZX5UU9p05UoARZnFdAC/3zGyqowV0neLhgI+M9/YC0WWWYDB3wEFsBcDGuGSaIm9GgHcMBmWOPMhFnEGXD2kPr93RgO29FoH+BygdozzELNUpK8SIhT4rNkdaXk/2J0OAhkpUnwLsD8toFz4bLc5/Uz0ZOtkxR2TT8dilhIYtPbBgl094Zwv9cMn3O0Q/Lw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 13:38:10.1208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0d34b3-6442-4bb8-8b9a-08df2de63734
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9449
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

HMM migrates a PMD-mapped THP as one compound folio when
migrate_vma_setup() is passed MIGRATE_VMA_SELECT_COMPOUND.

Without that flag the collect path splits the source THP to 4K pages.
If split_folio() fails because of extra refs or pins, those pages are
skipped.

Set SELECT_COMPOUND for device-private ranges whose migrate window is
at least HPAGE_PMD_NR pages. The RAM<->VRAM copy path follows
MIGRATE_PFN_COMPOUND in src[] (HPAGE_PMD_ORDER device folio, THP DMA)
and keeps the existing 4K path otherwise.

Coherent zone-device memory is unchanged.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 253 ++++++++++++++++++-----
 1 file changed, 203 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 2febe3bb690e..5c98028bfe73 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -324,7 +324,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 	u64 mpages = 0;
 	dma_addr_t *src;
 	u64 *dst;
-	u64 i, j;
+	u64 i, j, k, l, m;
 	int r = 0;
 
 	pr_debug("svms 0x%p [0x%lx 0x%lx 0x%llx]\n", prange->svms, prange->start,
@@ -335,59 +335,155 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 
 	amdgpu_res_first(prange->ttm_res, ttm_res_offset,
 			 npages << PAGE_SHIFT, &cursor);
-	for (i = j = 0; (i < npages) && (mpages < migrate->cpages); i++) {
+	for (i = j = m = 0; (i < npages) && (mpages < migrate->cpages);) {
 		struct page *spage;
+		unsigned long cur_dst_pfn;
 
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
+			k = HPAGE_PMD_NR;
+		} else
+			k = 1;
+
+		/* for THP src[0] alwas MIGRATE_PFN_MIGRATE
+		 * just the first migrate->dst need be setup, others are zero
+		 */
+		if (k > 1) {
+
+			dst[i] = cursor.start + (m << PAGE_SHIFT);
+			svm_migrate_get_vram_page(prange, cur_dst_pfn,
+						  HPAGE_PMD_ORDER);
+
+			migrate->dst[i] = migrate_pfn(cur_dst_pfn);
+			migrate->dst[i] |= MIGRATE_PFN_COMPOUND;
+
+			for (l = 1; l < k; l++)
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
+		if (k > 1) {
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
+				for (l = 1; l < k; l++)
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
 
@@ -476,6 +572,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate = { 0 };
+	bool is_private_device = false;
 	unsigned long cpages = 0;
 	unsigned long mpages = 0;
 	dma_addr_t *scratch;
@@ -488,11 +585,17 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	if (svm_range_window_resident(node, prange, start, end))
 		return 0;
 
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
@@ -686,6 +789,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	u64 i = 0, j;
 	u64 addr;
 	int r = 0;
+	u64 l, k;
 
 	pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, prange->start,
 		 prange->last);
@@ -694,8 +798,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	src = (u64 *)(scratch + npages);
 	dst = scratch;
-
-	for (i = 0, j = 0; i < npages; i++, addr += PAGE_SIZE) {
+	for (i = 0, j = 0, k = 1; i < npages; i += k, addr += k*PAGE_SIZE, k = 1) {
 		struct page *spage;
 
 		spage = migrate_pfn_to_page(migrate->src[i]);
@@ -711,6 +814,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 					goto out_oom;
 				j = 0;
 			}
+
 			continue;
 		}
 		src[i] = svm_migrate_addr(adev, spage);
@@ -724,7 +828,19 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			j = 0;
 		}
 
-		dpage = svm_migrate_get_sys_page(migrate->vma, addr, 0);
+		if (IS_ALIGNED(page_to_pfn(spage), HPAGE_PMD_NR) &&
+		   (addr + HPAGE_PMD_SIZE) <= migrate->end &&
+		   IS_ALIGNED(addr, HPAGE_PMD_SIZE) &&
+		   migrate->src[i] & MIGRATE_PFN_COMPOUND) {
+
+			k = HPAGE_PMD_NR;
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
@@ -732,7 +848,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			goto out_oom;
 		}
 
-		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
+		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE*k, DMA_BIDIRECTIONAL);
 		r = dma_mapping_error(dev, dst[i]);
 		if (r) {
 			dev_err(adev->dev, "%s: fail %d dma_map_page\n", __func__, r);
@@ -740,13 +856,47 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			goto out_oom;
 		}
 
-		pr_debug_ratelimited("dma mapping dst to 0x%llx, pfn 0x%lx\n",
-				     dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
-
 		migrate->dst[i] = migrate_pfn(page_to_pfn(dpage));
 
-		dpage = NULL;
-		j++;
+		if (k > 1) {
+			migrate->dst[i] |= MIGRATE_PFN_COMPOUND;
+			/* migrate previous accumulated pages */
+			if (j) {
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
+			/* migrate the HPAGE_PMD_NR pages above
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
 	}
 
 	if (j > 0)
@@ -765,12 +915,9 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
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
@@ -811,6 +958,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	unsigned long cpages = 0;
 	unsigned long mpages = 0;
 	struct amdgpu_device *adev = node->adev;
+	bool is_private_device = false;
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate = { 0 };
@@ -818,6 +966,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	void *buf;
 	int r = -ENOMEM;
 
+	is_private_device = svm_is_private_zone(adev);
+
 	memset(&migrate, 0, sizeof(migrate));
 	migrate.vma = vma;
 	migrate.start = start;
@@ -828,6 +978,9 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
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

