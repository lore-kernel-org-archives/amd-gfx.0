Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAF9C624D3
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2026 19:54:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AAE710FAEA;
	Fri,  4 Sep 2026 19:54:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zk0rlhOY";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012066.outbound.protection.outlook.com
 [40.93.195.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE61910E0DB
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2026 19:54:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXdslDbKKdO5fdT5TfM4UfZQWcRzPpAj6bVKulgh8VAWrnoabG0c8vG8g+xS0JTTEjMH04DhhtrScipao65CrbNtGl9vI8bUYtxm3pLUK72+S0RR5TpcjHBCAYMqMf9pX3IUJD4mZLd3DoTwdS9R9BE4MqRTooI20n/a0sUiyCq2JBe7CsvFWqth0JpmTiyDxXFIp+3z9Lm4NLBcQhsww9FSQ4zH39kTy6S6g0zHEaojT+maKVehdXd/SVxW3Nw8l1U6nEuYK9VLhzpqIouu9f8FEeBi6dWkafHM5Gvxjza913Xmm7ugbWzPVfD8iNUj96WqucOYQ+8B/wTlN3vlcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xx+WbUXo1XgH+ujahYjtIodnIP3oSgCWWBOxouFFu/k=;
 b=TWdhCOXuCNwgwWCUAb65aRCW8fMQkL2ihOJhVJeMmV+nmZn8zG9GDfbUdaFHeVVOu+dlYnbpZVH+khhRmpq0448pzRivj1hVLFM9n7kN1ZQp+d5bldrfGr/ke4PiWQWikdeH+Ai0nXzTS275zqL9K0uCVl23FWG454+NiHwAZzASaWluOS0p02n8Y+qBQSR2jmcdOTaea1K6rlXHXz0mH4xdCYNkhQwVATiGkpNlgjaJ9tn3QU1AgyXiWyeDy1c1lPQmYe3P5qO0mWLX1nkVnzq/vm8ZxVgfgPjTHJfYc4lAtmRHxv92FNmJIBBAdN2WgsYQtPxoP+35LaXJRSntSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xx+WbUXo1XgH+ujahYjtIodnIP3oSgCWWBOxouFFu/k=;
 b=Zk0rlhOYm4e6xP7BZwTlwz59Ip2oW8wowLa7+Yky4WRAhi2l54zniL/R8wH6HdjELzq4+qo+XkD1DPfziBCLBBKJ63HxTnRrWqYOHaOddN2fRemU8deP+EOG+08VqpQaByPpjZ8uhtjcOfYD5oWqBqZuVplpeeRdM4E0POt7E1M=
Received: from BN0PR04CA0001.namprd04.prod.outlook.com (2603:10b6:408:ee::6)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 19:54:29 +0000
Received: from LV8PEPF00000066.namprd03.prod.outlook.com
 (2603:10b6:408:ee:cafe::60) by BN0PR04CA0001.outlook.office365.com
 (2603:10b6:408:ee::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 19:54:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF00000066.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 19:54:29 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 14:54:26 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Fri, 4 Sep 2026 14:54:26 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH v2 4/4] drm/amdkfd: Apply AMDGPU_PTE_FRAG to pte of gart page
 table for THP mapping
Date: Fri, 4 Sep 2026 14:54:21 -0500
Message-ID: <20260904195421.42919-5-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260904195421.42919-1-xiaogang.chen@amd.com>
References: <20260904195421.42919-1-xiaogang.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000066:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: 85db3339-3b59-416c-96b7-08df0abe54f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|56012099006|10067099003|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HNVA25I98502zlACOHZvliXdvqEKcD/vPDbN0n/c2tiGRuEKAQs+n4QEzOptN5SDpIUIOvpFOEIKb8P6X/Gp0b9p41PegKD3u9KtAAHQD9G1hYgvBJN+8Q5ovn4PKs29X8Zv9cqBEx3wlxfqA+2bgc+HaGErb0X1lc5HC8vpc9QLUXL9Ea16Ifpm1M0P8S/3NbvjJv++2uc1+KkZL3oLK34SmhnJaS8+kaR+ucADfNR4PAHGURwf6YM/x+KLhNhlHJDrKUvuoQG6Nu3KBRD1nEYFUtTWQOfTOZdB8JPCVsrz3fEhEp0uykBT2VlNlmUIiwawCSoHYyuh0fkMtKheqB1jZn6nXwtinvDmynJfBDikzQ63i5mbNDRGeS0vebE9pYYNMFQ81iei7rGxYypqoXJDsjyA0YCCVf5Z4iwfgCn8iALNNo+tiPDvWrDYBgUwtgByAzp+l7qYjWei/tIuA1K89EEGBttu0m5yWU611/DiVSGycPHjWWrecMM4FyTV9Jsz/gn6ucJgapZS+4GAk/Qj/IL3c1sxCb1b6ScMkXP8sex9rlF8xOm/QBKv51/Z04bb220UdntkAWxTEZf6kz7rrrqdfgoQzVePKYHhBQw3vtT+CtNziIn6Bd1GszyWgthkmOeEL8tmzcbkuT1HV3uJfWl2Kf/xJvmyrjvXJpOF6Oqv4dfeQdNrNm13MIr8H0ZoIiRtXv4YLYQER6FeDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(56012099006)(10067099003)(11063799006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rEvu4wDQBmZY9Sx8AQNLCKXMVo7sVbZAfKo10dMURFpg8ClmSgPD4ckhUReUK+yRxTtIqMWczNvmk9Omj2wFlwzv0tMX2BXe+5ESS+cKu+mbV/vdmbJQvQYRZ1YC72gf2tF7vwt6iopJwfZQtawetrVlISMtlYRVDme01ZWNPKf0Biuy5tLqrUifWaP6LEqbCRfqS6HFC5UaH2sn0obypcwQbDl2N5NYoH0ra0t9/GGvNttrWjqGB8oG8Yy+PsZc3qOK+Y59fGFhSEpyXggtcf8KEDiwemiZuassaWGm20HeFbMLyU6p5pe9Sj/b99Y18OwBy7aarRDcq2tbNRSU1je+HpQBFdxA2iQDh0nrqdHGian937P+l+OD9F5PCCyLURS8fLMFc5kayOvyUulSiVKEiirweEJ85+q4HOwD9mXV/pA8Fao5TtBJxwyjXxmq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 19:54:29.4910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85db3339-3b59-416c-96b7-08df0abe54f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000066.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
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

When both sys ram and vram are physical continuous HPAGE_PMD_NR pages during
migration set AMDGPU_PTE_FRAG(HPAGE_PMD_ORDER) at pte in gart page table to
let hardware know the migrating pages are HPAGE_PMD_NR size THP. That will
reduce hardware TLB pressure or increase TLB hit ration.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 45 ++++++++++++++----------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index af39e547c1fa..8a2fbe3a7613 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -48,7 +48,7 @@ static int
 svm_migrate_gart_map(struct amdgpu_ring *ring,
 		     struct amdgpu_ttm_buffer_entity *entity,
 		     u64 npages,
-		     dma_addr_t *addr, u64 *gart_addr, u64 flags)
+		     dma_addr_t *addr, u64 *gart_addr, u64 flags, bool is_thp)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_job *job;
@@ -90,6 +90,9 @@ svm_migrate_gart_map(struct amdgpu_ring *ring,
 		pte_flags |= AMDGPU_PTE_WRITEABLE;
 	pte_flags |= adev->gart.gart_pte_flags;
 
+	if (is_thp)
+		pte_flags |= AMDGPU_PTE_FRAG(HPAGE_PMD_ORDER);
+
 	cpu_addr = &job->ibs[0].ptr[num_dw];
 
 	amdgpu_gart_map(adev, 0, npages, addr, pte_flags, cpu_addr);
@@ -108,6 +111,7 @@ svm_migrate_gart_map(struct amdgpu_ring *ring,
  * @npages: number of pages to copy
  * @direction: enum MIGRATION_COPY_DIR
  * @mfence: output, sdma fence to signal after sdma is done
+ * @is_thp: both sys and vram are physical continuous HPAGE_PMD_NR pages
  *
  * ram address uses GART table continuous entries mapping to ram pages,
  * vram address uses direct mapping of vram pages, which must have npages
@@ -126,7 +130,7 @@ static int
 svm_migrate_copy_memory_gart(struct amdgpu_device *adev, dma_addr_t *sys,
 			     u64 *vram, u64 npages,
 			     enum MIGRATION_COPY_DIR direction,
-			     struct dma_fence **mfence)
+			     struct dma_fence **mfence, bool is_thp)
 {
 	const u64 GTT_MAX_PAGES = (AMDGPU_GTT_MAX_TRANSFER_SIZE >> PAGE_SHIFT);
 	struct amdgpu_ring *ring;
@@ -136,6 +140,12 @@ svm_migrate_copy_memory_gart(struct amdgpu_device *adev, dma_addr_t *sys,
 	u64 size;
 	int r = 0;
 
+	if (is_thp && npages != HPAGE_PMD_NR) {
+		dev_warn(adev->dev, "THP migration should have %d pages\n",
+			 HPAGE_PMD_NR);
+		is_thp = false;
+	}
+
 	ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
 	entity = &adev->mman.move_entities[0];
 
@@ -146,11 +156,12 @@ svm_migrate_copy_memory_gart(struct amdgpu_device *adev, dma_addr_t *sys,
 
 		if (direction == FROM_VRAM_TO_RAM) {
 			gart_s = svm_migrate_direct_mapping_addr(adev, *vram);
-			r = svm_migrate_gart_map(ring, entity, size, sys, &gart_d, 0);
+			r = svm_migrate_gart_map(ring, entity, size, sys, &gart_d, 0,
+						 is_thp);
 
 		} else if (direction == FROM_RAM_TO_VRAM) {
 			r = svm_migrate_gart_map(ring, entity, size, sys, &gart_s,
-						 KFD_IOCTL_SVM_FLAG_GPU_RO);
+						 KFD_IOCTL_SVM_FLAG_GPU_RO, is_thp);
 			gart_d = svm_migrate_direct_mapping_addr(adev, *vram);
 		}
 		if (r) {
@@ -362,7 +373,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 						adev, src + i - j,
 						dst + i - j, j,
 						FROM_RAM_TO_VRAM,
-						mfence);
+						mfence, false);
 
 				if (r)
 					goto out_free_vram_pages;
@@ -398,7 +409,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 						adev, src + i,
 						dst + i, HPAGE_PMD_NR,
 						FROM_RAM_TO_VRAM,
-						mfence);
+						mfence, true);
 
 				/* mark head page dma mapping as THP, tail pages dma addr
 				 * are set to 0 for following dma_unmap
@@ -433,7 +444,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 						adev, src + i - j,
 						dst + i - j, j,
 						FROM_RAM_TO_VRAM,
-						mfence);
+						mfence, false);
 
 				if (r)
 					goto out_free_vram_pages;
@@ -452,7 +463,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 				r = svm_migrate_copy_memory_gart(adev, src + i - j,
 								 dst + i - j, j,
 								 FROM_RAM_TO_VRAM,
-								 mfence);
+								 mfence, false);
 				if (r)
 					goto out_free_vram_pages;
 			}
@@ -466,7 +477,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 
 	if (j > 0)
 		r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i - j, j,
-					 FROM_RAM_TO_VRAM, mfence);
+					 FROM_RAM_TO_VRAM, mfence, false);
 
 out_free_vram_pages:
 	if (r) {
@@ -736,7 +747,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 				r = svm_migrate_copy_memory_gart(adev, dst + i - j,
 								 src + i - j, j,
 								 FROM_VRAM_TO_RAM,
-								 mfence);
+								 mfence, false);
 				if (r)
 					goto out_oom;
 				j = 0;
@@ -751,7 +762,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			r = svm_migrate_copy_memory_gart(adev, dst + i - j,
 							 src + i - j, j,
 							 FROM_VRAM_TO_RAM,
-							 mfence);
+							 mfence, false);
 			if (r)
 				goto out_oom;
 			j = 0;
@@ -795,7 +806,8 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			/* migrate previous accumulated pages */
 			if(j) {
 				r = svm_migrate_copy_memory_gart(adev, dst + i - j,
-								 src + i - j, j, FROM_VRAM_TO_RAM, mfence);
+								 src + i - j, j, FROM_VRAM_TO_RAM,
+								 mfence, false);
 				if (r)
 					goto out_oom;
 				j = 0;
@@ -809,14 +821,11 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			}
 
 			/* migrate the HPAGE_PMD_NR pages above */
-			/* svm_migrate_copy_memory_gart will add a paramter to indicate
-			 * the migration is for 2MB THP
-			 */
 			r = svm_migrate_copy_memory_gart(
 						adev, dst + i,
 						src + i, HPAGE_PMD_NR,
 						FROM_VRAM_TO_RAM,
-						mfence);
+						mfence, true);
 
 			/* mark head page dma mapping as THP, tail pages dma addr
 			 * are set to 0 for following dma_unmap
@@ -837,7 +846,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	if (j > 0)
 		r = svm_migrate_copy_memory_gart(adev, dst + i - j, src + i - j, j,
-						 FROM_VRAM_TO_RAM, mfence);
+						 FROM_VRAM_TO_RAM, mfence, false);
 out_oom:
 	if (r) {
 		pr_debug("failed %d copy to ram\n", r);
@@ -1299,7 +1308,7 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
 
 	amdgpu_amdkfd_reserve_system_mem(SVM_HMM_PAGE_STRUCT_SIZE(size));
 
-	pr_info("---XCHEN 3.2 HMM registered %ldMB device memory\n", size >> 20);
+	pr_info("HMM registered %ldMB device memory\n", size >> 20);
 
 	return 0;
 }
-- 
2.34.1

