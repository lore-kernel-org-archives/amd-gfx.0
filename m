Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FD4C624A4
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 14:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E72AE10E90C;
	Mon, 31 Aug 2026 14:26:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CPwSbznJ";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012014.outbound.protection.outlook.com [40.107.209.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3334E10E90C
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 14:26:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RvBaQlgbSWuvTcD31DCa8a8vsy6zO/P+lfgV9vFEey7KAnsYG3mWWWAq29GB2x5SU/5O309gjKVL87r3sZHo4RtiJuc//I4kGjHt8ppUworRKXsf3tU30MvblAaV8FzbdL6hu5Q23LlAE3FoyU1X/pJw4gHPv0dEiRbX+3b+LAI/eN+JWWrhkE/4/yJQ5EWLdCPkHXxuUFpXTDbaM4gktA8jW0SCzIK9rYcfPHf1y/UVvz4Sz0c1KyS50DpiJIVXVGTN85qWKBrfMoSmJ5kAMscR9i+0zvXpNXAd0p0CigbwFdAhePs080zSkFPbqR2xn40tBjdjKiWwzlGcjR9c0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjlFtxC94UhNDg15OCQwUztMwTOhC+8sPO42Ahxk128=;
 b=lNVX4RdkMgaf+0ueuPK/HvcfCmmLtUUEeWxTMtQYB89gYYgceZymGA+morREOcYXsSrFUPCVGC3B9jXxDutt7kUIru1N9YVRHHlhjyrZRRTLlVajnucyx5pEz7p6tH3Yd/+0m8uRG4ZaCQxN9/SySno+gUdAqqlPtTt4VodO4y3AqgCvWDRqjsABq/Sk1udvdGnazWRSffa3K39R1NnA5tAIGqTdR5YG7C3C/tOtH7FQGrnVeUK7eG/QeGQslzWbK7sShfcxUHk5u1IB1V6tJZdtZdQ1S/o03xJzfplZi4v0Xen8koB04fui3IKV5jH5yCEySkBX3yTXVy4KJ9otdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjlFtxC94UhNDg15OCQwUztMwTOhC+8sPO42Ahxk128=;
 b=CPwSbznJTZinDVkIHx2CcA9iZQK16GcAfcVBEO89aSvK8PJUt34X+JHJDOX2lGXL+Nq5N6Gf+2Ly7I0KyYtiKXB1kyixgIXwJp6T60VyGSTlIDNJlDFqMd5cc7iW51oWr9b1ipJcIjsQfMlWvJ/DIcIrXOYUaYPokeyt68YlMuc=
Received: from SJ0PR05CA0007.namprd05.prod.outlook.com (2603:10b6:a03:33b::12)
 by DS0PR12MB6631.namprd12.prod.outlook.com (2603:10b6:8:d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 14:26:34 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:33b:cafe::64) by SJ0PR05CA0007.outlook.office365.com
 (2603:10b6:a03:33b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Mon,
 31 Aug 2026 14:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 14:26:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 09:26:31 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 09:26:32 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Mon, 31 Aug 2026 09:26:31 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH 4/4] drm/amdkfd: Apply AMDGPU_PTE_FRAG to pte of gart page
 table for THP mapping
Date: Mon, 31 Aug 2026 09:24:18 -0500
Message-ID: <20260831142418.56423-5-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831142418.56423-1-xiaogang.chen@amd.com>
References: <20260831142418.56423-1-xiaogang.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|DS0PR12MB6631:EE_
X-MS-Office365-Filtering-Correlation-Id: acdc1a2c-56a3-4a51-e7cd-08df076bdbc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|3023799007|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ta2shjwTA+dJcPBJCCf5byc+u2uqN2CBJv1nz45f7BmHxhn+wSGW+41K39z/MKskmTmMihjXZ6PQeda019fTs9mNgNxIPfPcve8PO0NyOJmx6ND2aaJjU9Je2rM1piguCA3rLxnGUjk0nDBchqpIesinQaO6s2c06S6koAX5teT2+wrgsYVqgz8BVpZvuL8ZR3wyNp81og6o7Y7Zupod6LGhuPukIrtoI+A+cu249+ZtngMT/cPXsf0CpJ1OVfeZDuPOxW+vPau+ARWmK7qEnbKT7dVs72OEdAscRSvFq/58glZN8KWgkNa0oWckfbH05HK0QPmpRbjBXbP1JNKqbCVQ2SfNZTuoLeSAKms1+gzMS6YN7bMnPd548mb3ahPHf4zuJZvMunazvniK2kcOWgYMiPNXUnjdC3VVDIzbwWFfChwNvvLdialL6MKZc/MTrIc0hiQoStMWUISQsC+Gj3xg0MUGtnndUWz5zHRO2yf14afwQQpTkcGbLgGRc4YFBLIcjRuLRX1nsIwR45MnIIq4w1p2sHwycZk2yLHBL+aW1si8hj6Y0ELh8CQ+gQVH6p/Lmuf9PJXpdez2OyP6kiT58iByZzyqhuXjMZTjH0VI1nxAoT8BNiPPAvZ5HFYpyA7/rAtxBj/xRrv4llq9pP4JBdzWx8SXxoZP1kcOOx5jOAiRzx6JdQjMFA82EVucvzD1IR4HgagKo+YBFbzKWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(3023799007)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1MsNVDMVbJ7lWQI5xqZKAunfSVcWMCx0/+CWwjVEzBEwQAEnQwDeNxFjeeH5gm1dWxbi2V9WwFL4m78ND+DGD4mDFwyGeNVIQ1jHiZpjXsG+NZLiQ1iQ9l/184eJIR6Z75cJbmGbR/QQFlfyaZUxzQYvpiGvnkcodeh1ehqWRWp2JecZ68qFhgSBtNgQiO2WnBbuNybYYzYawHUUiVbZUPisg6Fu/M+sgPVkux3v2CnHVhPRuszXxNw898u/66aSxsSRxmSvoNqpYToFBx68jITbsB/Xnqt34Ja/YRR/aVVW66hFcFf9BOKm5veUPQF/uH84jWcE8MfFMqZKXYt4DoMfIA7/VnpJS1ukjWwbSt7FmOy5+XprtAE0pxHjGlwWlS8AXBBshQ0W/H2dspklPWltl0DgEr+6AZ1VlBx0Rm0E13qvOrlhZ7+XN9//6pfi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 14:26:33.8748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acdc1a2c-56a3-4a51-e7cd-08df076bdbc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6631
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
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 43 ++++++++++++++----------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 30eac5fbcde5..6863be041ba5 100644
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
+			     struct dma_fence **mfence,  bool is_thp)
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
@@ -353,7 +364,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 						adev, src + i - j,
 						dst + i - j, j,
 						FROM_RAM_TO_VRAM,
-						mfence);
+						mfence, false);
 
 				if (r)
 					goto out_free_vram_pages;
@@ -389,7 +400,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 						adev, src + i,
 						dst + i, HPAGE_PMD_NR,
 						FROM_RAM_TO_VRAM,
-						mfence);
+						mfence, true);
 
 				if (r)
 					goto out_free_vram_pages;
@@ -417,7 +428,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 						adev, src + i - j,
 						dst + i - j, j,
 						FROM_RAM_TO_VRAM,
-						mfence);
+						mfence, false);
 
 				if (r)
 					goto out_free_vram_pages;
@@ -436,7 +447,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 				r = svm_migrate_copy_memory_gart(adev, src + i - j,
 								 dst + i - j, j,
 								 FROM_RAM_TO_VRAM,
-								 mfence);
+								 mfence, false);
 				if (r)
 					goto out_free_vram_pages;
 			}
@@ -450,7 +461,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 
 	if (j > 0)
 		r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i - j, j,
-					 FROM_RAM_TO_VRAM, mfence);
+					 FROM_RAM_TO_VRAM, mfence, false);
 
 out_free_vram_pages:
 	if (r) {
@@ -719,7 +730,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 				r = svm_migrate_copy_memory_gart(adev, dst + i - j,
 								 src + i - j, j,
 								 FROM_VRAM_TO_RAM,
-								 mfence);
+								 mfence, false);
 				if (r)
 					goto out_oom;
 				j = 0;
@@ -734,7 +745,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			r = svm_migrate_copy_memory_gart(adev, dst + i - j,
 							 src + i - j, j,
 							 FROM_VRAM_TO_RAM,
-							 mfence);
+							 mfence, false);
 			if (r)
 				goto out_oom;
 			j = 0;
@@ -777,7 +788,8 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			/* migrate previous accumulated pages */
 			if(j) {
 				r = svm_migrate_copy_memory_gart(adev, dst + i - j,
-								 src + i - j, j, FROM_VRAM_TO_RAM, mfence);
+								 src + i - j, j, FROM_VRAM_TO_RAM,
+								 mfence, false);
 				if (r)
 					goto out_oom;
 				j = 0;
@@ -791,14 +803,11 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
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
 
 			if (r)
 				goto out_oom;
@@ -812,7 +821,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	if (j > 0)
 		r = svm_migrate_copy_memory_gart(adev, dst + i - j, src + i - j, j,
-						 FROM_VRAM_TO_RAM, mfence);
+						 FROM_VRAM_TO_RAM, mfence, false);
 out_oom:
 	if (r) {
 		pr_debug("failed %d copy to ram\n", r);
-- 
2.34.1

