Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1856CC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Nov 2023 21:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B74EF10E4C6;
	Tue, 14 Nov 2023 21:01:39 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58EB710E213
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Nov 2023 21:01:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFGh++88wOy0H8Q9spDlpkriWVhloO2ul+47KpNoka+EK6GjArQfCBoGSj02jUkDO4mgdSiNSBpzzxm/X/MELj8qHEjsnkTM5mxdmB6gVgVjIt/O9SuqFppJ5ipB6Jr4EFCiW649gnmIq5Mbht4ZLViplBKJ3hkzMzvENDknR8IcAjgGyLMUrNagf0lmLOqFTE6Zn9eMchzMAmKODDGAd0Pmdr2UcoZF+2RMQWe5OVJH2rbb+VI72mubPdfdtAwNVJRJXwSJQJmC4wP5VvMM5PO36GIIseDd+wm4KaOSCfzGwTjR35Wl4tuuP9rCg6Dcv9w3AOsx19bO6QbS88rH6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hizSGYw5mklh7PBa+ykKlrRVGLVxsCJJpTjD7aWZyJY=;
 b=KzfyduLRwVxNwjOU7iqe7xBjiBhKyDu53l2rlciFADNfAvRhdAJLOxfEuzFmEqImBb4jhgPY9OmwLAezyrSsaoP4n//CCIrgUkdlobKQ8yxWnawCM0Df75mWSXuQ5O1/D2sNJw65Ifh3uILEOTNw4lCzW9M36ooHCJOU1vI3XE9GDz7bMzPeIOdIi5K4OOaBr+0IRYRzTTiM1zy5GDvUVR7CR4Bmk9CgjkX5EA5pkSwlDoJHQYGAYGl2A35aVt36JsfPZ49ve7CvV6H0I7CQs4ru2PF7hvHA2bBzvKpK3U3QE90IX8i8tiYc3/7t8xvvbbsEfs+bVub1mKpvxUSH1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hizSGYw5mklh7PBa+ykKlrRVGLVxsCJJpTjD7aWZyJY=;
 b=ursqmT/oBsIf/14lZZZdbrpIH2t6ERKHbgJfPz1ZHzkis4wN/rkgM1q0pcsj5Ny3VjkS985isFdZ+g9pP7nJd/Lgtv469AAPabu9HppVxxV0z+dIyV5Q3NM7AeUgWr2CuFbkog4NVMkGe2A92NK0nUHLxyqPCFBw8YyE9QkWixk=
Received: from CH0PR03CA0436.namprd03.prod.outlook.com (2603:10b6:610:10e::33)
 by SA1PR12MB8743.namprd12.prod.outlook.com (2603:10b6:806:37c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 21:01:33 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::f8) by CH0PR03CA0436.outlook.office365.com
 (2603:10b6:610:10e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31 via Frontend
 Transport; Tue, 14 Nov 2023 21:01:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.17 via Frontend Transport; Tue, 14 Nov 2023 21:01:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 14 Nov
 2023 15:01:30 -0600
Received: from Xiaogang-ROCM-Dev.attlocal.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Tue, 14 Nov 2023 15:01:25 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Use partial migrations/mapping for GPU/CPU page
 faults in SVM
Date: Tue, 14 Nov 2023 15:01:37 -0600
Message-ID: <20231114210137.57695-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SA1PR12MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: d2c947a6-3a3b-44ae-974f-08dbe554e165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+1KaX+ye7O4sfEI5SOzfZazFd3rrnNsUXzPKM/rOTeiGxZH6SvxH6AEZ3VWdlVmoyFQYokBWn1SKWldXHBZJRXEt7Qvw8P6Kt0lyYk2HQ2Gog/ZsZgKmxvjECcwwI4Ew1a4eMbjbb/0xWyOOJzRSDO9IP9cBCk2Em4ktunMcYlWs37S8wv5Qw8ZtRSfg2TO4U/+QhjYmh8xYJopPVi0yLntUd4ieI4zKrTdUFkmP9RgqSyRWyrqLYutkGd214i043H0nWf1k4v4IgT1mZP7z7cxWGhG2qkVaBAtGc8Rh8U5E+Ck69I0UxGB4VDmQmF/0rk0xjMreIfVBRFzox0nWtTBXiYX9VkswqSMDZJUZCrUb5Qz7jItE7weMACZ3xvlaykFFJ2iMlRXzK4o7zDNddfZGQE+LjuLGIVD68rHcFCLwxKC4Iv3/zgNEPOolyI2rYJpRWV2tXdqRjhFExRbIKZbMkmWHJlfpVgswOj2fBwol9zsS0glJD+nAxp61k4B33xJoGS2R77VCXZexM68PeYRQj3xxjgMI3Ip5xCARYxdl+pQ+AE9HNJcQP+hTJjpUqY6Bhi3pgHLTgoSbQfu6NegDkobGSD6ktjVpFq0VhgOcgErG/c0jITuFh+LlFHW9nxxKdOwnFSFMcUAzRHqquGPYxd8Ig/9RZv5i5nWtZ0zVHVPkNh5wizDpObBhkU8kaS5pxa0wD0JmENgIqs75u/jNae17YlZNL53lF1ZlYUx1xsXQ8hqhoThwDBly0xTt0KP5iTeRt7Xfx1opdFLtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(40460700003)(36756003)(426003)(336012)(2906002)(26005)(30864003)(81166007)(356005)(82740400003)(47076005)(83380400001)(41300700001)(86362001)(36860700001)(2616005)(5660300002)(1076003)(478600001)(40480700001)(6916009)(316002)(70586007)(54906003)(70206006)(6666004)(4326008)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 21:01:32.2570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c947a6-3a3b-44ae-974f-08dbe554e165
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8743
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
Cc: Xiaogang
 Chen <Xiaogang.Chen@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

This patch implements partial migration/mapping for gpu/cpu page faults in SVM
according to migration granularity(default 2MB). A svm range may include pages
from both system ram and vram of one gpu now. These chagnes are expected to
improve migration performance and reduce mmu callback and TLB flush workloads.

Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 152 +++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.h |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 176 +++++++++++------------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |   9 +-
 4 files changed, 183 insertions(+), 160 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 6c25dab051d5..67df1b46f292 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -442,10 +442,10 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 		goto out_free;
 	}
 	if (cpages != npages)
-		pr_debug("partial migration, 0x%lx/0x%llx pages migrated\n",
+		pr_debug("partial migration, 0x%lx/0x%llx pages collected\n",
 			 cpages, npages);
 	else
-		pr_debug("0x%lx pages migrated\n", cpages);
+		pr_debug("0x%lx pages collected\n", cpages);
 
 	r = svm_migrate_copy_to_vram(node, prange, &migrate, &mfence, scratch, ttm_res_offset);
 	migrate_vma_pages(&migrate);
@@ -479,6 +479,8 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
  * svm_migrate_ram_to_vram - migrate svm range from system to device
  * @prange: range structure
  * @best_loc: the device to migrate to
+ * @start_mgr: start page to migrate
+ * @last_mgr: last page to migrate
  * @mm: the process mm structure
  * @trigger: reason of migration
  *
@@ -489,6 +491,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
  */
 static int
 svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
+			unsigned long start_mgr, unsigned long last_mgr,
 			struct mm_struct *mm, uint32_t trigger)
 {
 	unsigned long addr, start, end;
@@ -498,30 +501,37 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	unsigned long cpages = 0;
 	long r = 0;
 
-	if (prange->actual_loc == best_loc) {
-		pr_debug("svms 0x%p [0x%lx 0x%lx] already on best_loc 0x%x\n",
-			 prange->svms, prange->start, prange->last, best_loc);
+	if (!best_loc) {
+		pr_debug("svms 0x%p [0x%lx 0x%lx] migrate to sys ram\n",
+			prange->svms, start_mgr, last_mgr);
 		return 0;
 	}
 
+	if (start_mgr < prange->start || last_mgr > prange->last) {
+		pr_debug("range [0x%lx 0x%lx] out prange [0x%lx 0x%lx]\n",
+				 start_mgr, last_mgr, prange->start, prange->last);
+		return -EFAULT;
+	}
+
 	node = svm_range_get_node_by_id(prange, best_loc);
 	if (!node) {
 		pr_debug("failed to get kfd node by id 0x%x\n", best_loc);
 		return -ENODEV;
 	}
 
-	pr_debug("svms 0x%p [0x%lx 0x%lx] to gpu 0x%x\n", prange->svms,
-		 prange->start, prange->last, best_loc);
+	pr_debug("svms 0x%p [0x%lx 0x%lx] in [0x%lx 0x%lx] to gpu 0x%x\n",
+		prange->svms, start_mgr, last_mgr, prange->start, prange->last,
+		best_loc);
 
-	start = prange->start << PAGE_SHIFT;
-	end = (prange->last + 1) << PAGE_SHIFT;
+	start = start_mgr << PAGE_SHIFT;
+	end = (last_mgr + 1) << PAGE_SHIFT;
 
 	r = svm_range_vram_node_new(node, prange, true);
 	if (r) {
 		dev_dbg(node->adev->dev, "fail %ld to alloc vram\n", r);
 		return r;
 	}
-	ttm_res_offset = prange->offset << PAGE_SHIFT;
+	ttm_res_offset = (start_mgr - prange->start + prange->offset) << PAGE_SHIFT;
 
 	for (addr = start; addr < end;) {
 		unsigned long next;
@@ -544,8 +554,11 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 
 	if (cpages) {
 		prange->actual_loc = best_loc;
-		svm_range_dma_unmap(prange);
-	} else {
+		prange->vram_pages = prange->vram_pages + cpages;
+	} else if (!prange->actual_loc) {
+		/* if no page migrated and all pages from prange are at
+		 * sys ram drop svm_bo got from svm_range_vram_node_new
+		 */
 		svm_range_vram_node_free(prange);
 	}
 
@@ -663,9 +676,8 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
  * Context: Process context, caller hold mmap read lock, prange->migrate_mutex
  *
  * Return:
- *   0 - success with all pages migrated
  *   negative values - indicate error
- *   positive values - partial migration, number of pages not migrated
+ *   positive values or zero - number of pages got migrated
  */
 static long
 svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
@@ -676,6 +688,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	uint64_t npages = (end - start) >> PAGE_SHIFT;
 	unsigned long upages = npages;
 	unsigned long cpages = 0;
+	unsigned long mpages = 0;
 	struct amdgpu_device *adev = node->adev;
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
@@ -725,10 +738,10 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 		goto out_free;
 	}
 	if (cpages != npages)
-		pr_debug("partial migration, 0x%lx/0x%llx pages migrated\n",
+		pr_debug("partial migration, 0x%lx/0x%llx pages collected\n",
 			 cpages, npages);
 	else
-		pr_debug("0x%lx pages migrated\n", cpages);
+		pr_debug("0x%lx pages collected\n", cpages);
 
 	r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
 				    scratch, npages);
@@ -751,17 +764,21 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	kvfree(buf);
 out:
 	if (!r && cpages) {
+		mpages = cpages - upages;
 		pdd = svm_range_get_pdd_by_node(prange, node);
 		if (pdd)
-			WRITE_ONCE(pdd->page_out, pdd->page_out + cpages);
+			WRITE_ONCE(pdd->page_out, pdd->page_out + mpages);
 	}
-	return r ? r : upages;
+
+	return r ? r : mpages;
 }
 
 /**
  * svm_migrate_vram_to_ram - migrate svm range from device to system
  * @prange: range structure
  * @mm: process mm, use current->mm if NULL
+ * @start_mgr: start page need be migrated to sys ram
+ * @last_mgr: last page need be migrated to sys ram
  * @trigger: reason of migration
  * @fault_page: is from vmf->page, svm_migrate_to_ram(), this is CPU page fault callback
  *
@@ -771,6 +788,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
  * 0 - OK, otherwise error code
  */
 int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
+			    unsigned long start_mgr, unsigned long last_mgr,
 			    uint32_t trigger, struct page *fault_page)
 {
 	struct kfd_node *node;
@@ -778,26 +796,33 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 	unsigned long addr;
 	unsigned long start;
 	unsigned long end;
-	unsigned long upages = 0;
+	unsigned long mpages = 0;
 	long r = 0;
 
+	/* this pragne has no any vram page to migrate to sys ram */
 	if (!prange->actual_loc) {
 		pr_debug("[0x%lx 0x%lx] already migrated to ram\n",
 			 prange->start, prange->last);
 		return 0;
 	}
 
+	if (start_mgr < prange->start || last_mgr > prange->last) {
+		pr_debug("range [0x%lx 0x%lx] out prange [0x%lx 0x%lx]\n",
+				 start_mgr, last_mgr, prange->start, prange->last);
+		return -EFAULT;
+	}
+
 	node = svm_range_get_node_by_id(prange, prange->actual_loc);
 	if (!node) {
 		pr_debug("failed to get kfd node by id 0x%x\n", prange->actual_loc);
 		return -ENODEV;
 	}
 	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] from gpu 0x%x to ram\n",
-		 prange->svms, prange, prange->start, prange->last,
+		 prange->svms, prange, start_mgr, last_mgr,
 		 prange->actual_loc);
 
-	start = prange->start << PAGE_SHIFT;
-	end = (prange->last + 1) << PAGE_SHIFT;
+	start = start_mgr << PAGE_SHIFT;
+	end = (last_mgr + 1) << PAGE_SHIFT;
 
 	for (addr = start; addr < end;) {
 		unsigned long next;
@@ -816,14 +841,21 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 			pr_debug("failed %ld to migrate prange %p\n", r, prange);
 			break;
 		} else {
-			upages += r;
+			mpages += r;
 		}
 		addr = next;
 	}
 
-	if (r >= 0 && !upages) {
-		svm_range_vram_node_free(prange);
-		prange->actual_loc = 0;
+	if (r >= 0) {
+		prange->vram_pages -= mpages;
+
+		/* prange does not have vram page set its actual_loc to system
+		 * and drop its svm_bo ref
+		 */
+		if (prange->vram_pages == 0 && prange->ttm_res) {
+			prange->actual_loc = 0;
+			svm_range_vram_node_free(prange);
+		}
 	}
 
 	return r < 0 ? r : 0;
@@ -833,17 +865,23 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
  * svm_migrate_vram_to_vram - migrate svm range from device to device
  * @prange: range structure
  * @best_loc: the device to migrate to
+ * @start: start page need be migrated to sys ram
+ * @last: last page need be migrated to sys ram
  * @mm: process mm, use current->mm if NULL
  * @trigger: reason of migration
  *
  * Context: Process context, caller hold mmap read lock, svms lock, prange lock
  *
+ * migrate all vram pages in prange to sys ram, then migrate
+ * [start, last] pages from sys ram to gpu node best_loc.
+ *
  * Return:
  * 0 - OK, otherwise error code
  */
 static int
 svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
-			 struct mm_struct *mm, uint32_t trigger)
+			unsigned long start, unsigned long last,
+			struct mm_struct *mm, uint32_t trigger)
 {
 	int r, retries = 3;
 
@@ -855,7 +893,8 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	pr_debug("from gpu 0x%x to gpu 0x%x\n", prange->actual_loc, best_loc);
 
 	do {
-		r = svm_migrate_vram_to_ram(prange, mm, trigger, NULL);
+		r = svm_migrate_vram_to_ram(prange, mm, prange->start, prange->last,
+								trigger, NULL);
 		if (r)
 			return r;
 	} while (prange->actual_loc && --retries);
@@ -863,17 +902,21 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	if (prange->actual_loc)
 		return -EDEADLK;
 
-	return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
+	return svm_migrate_ram_to_vram(prange, best_loc, start, last, mm, trigger);
 }
 
 int
 svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
-		    struct mm_struct *mm, uint32_t trigger)
+			unsigned long start, unsigned long last,
+			struct mm_struct *mm, uint32_t trigger)
 {
-	if  (!prange->actual_loc)
-		return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
+	if  (!prange->actual_loc || prange->actual_loc == best_loc)
+		return svm_migrate_ram_to_vram(prange, best_loc, start, last,
+						mm, trigger);
+
 	else
-		return svm_migrate_vram_to_vram(prange, best_loc, mm, trigger);
+		return svm_migrate_vram_to_vram(prange, best_loc, start, last,
+						mm, trigger);
 
 }
 
@@ -889,10 +932,9 @@ svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
  */
 static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 {
+	unsigned long start, last, size;
 	unsigned long addr = vmf->address;
 	struct svm_range_bo *svm_bo;
-	enum svm_work_list_ops op;
-	struct svm_range *parent;
 	struct svm_range *prange;
 	struct kfd_process *p;
 	struct mm_struct *mm;
@@ -929,51 +971,31 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 
 	mutex_lock(&p->svms.lock);
 
-	prange = svm_range_from_addr(&p->svms, addr, &parent);
+	prange = svm_range_from_addr(&p->svms, addr, NULL);
 	if (!prange) {
 		pr_debug("failed get range svms 0x%p addr 0x%lx\n", &p->svms, addr);
 		r = -EFAULT;
 		goto out_unlock_svms;
 	}
 
-	mutex_lock(&parent->migrate_mutex);
-	if (prange != parent)
-		mutex_lock_nested(&prange->migrate_mutex, 1);
+	mutex_lock(&prange->migrate_mutex);
 
 	if (!prange->actual_loc)
 		goto out_unlock_prange;
 
-	svm_range_lock(parent);
-	if (prange != parent)
-		mutex_lock_nested(&prange->lock, 1);
-	r = svm_range_split_by_granularity(p, mm, addr, parent, prange);
-	if (prange != parent)
-		mutex_unlock(&prange->lock);
-	svm_range_unlock(parent);
-	if (r) {
-		pr_debug("failed %d to split range by granularity\n", r);
-		goto out_unlock_prange;
-	}
+	/* Align migration range start and size to granularity size */
+	size = 1UL << prange->granularity;
+	start = max(ALIGN_DOWN(addr, size), prange->start);
+	last = min(ALIGN(addr + 1, size) - 1, prange->last);
 
-	r = svm_migrate_vram_to_ram(prange, vmf->vma->vm_mm,
-				    KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU,
-				    vmf->page);
+	r = svm_migrate_vram_to_ram(prange, vmf->vma->vm_mm, start, last,
+						KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU, vmf->page);
 	if (r)
 		pr_debug("failed %d migrate svms 0x%p range 0x%p [0x%lx 0x%lx]\n",
-			 r, prange->svms, prange, prange->start, prange->last);
-
-	/* xnack on, update mapping on GPUs with ACCESS_IN_PLACE */
-	if (p->xnack_enabled && parent == prange)
-		op = SVM_OP_UPDATE_RANGE_NOTIFIER_AND_MAP;
-	else
-		op = SVM_OP_UPDATE_RANGE_NOTIFIER;
-	svm_range_add_list_work(&p->svms, parent, mm, op);
-	schedule_deferred_list_work(&p->svms);
+			r, prange->svms, prange, start, last);
 
 out_unlock_prange:
-	if (prange != parent)
-		mutex_unlock(&prange->migrate_mutex);
-	mutex_unlock(&parent->migrate_mutex);
+	mutex_unlock(&prange->migrate_mutex);
 out_unlock_svms:
 	mutex_unlock(&p->svms.lock);
 out_unref_process:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
index 487f26368164..9e48d10e848e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
@@ -41,9 +41,13 @@ enum MIGRATION_COPY_DIR {
 };
 
 int svm_migrate_to_vram(struct svm_range *prange,  uint32_t best_loc,
+			unsigned long start, unsigned long last,
 			struct mm_struct *mm, uint32_t trigger);
+
 int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
-			    uint32_t trigger, struct page *fault_page);
+			unsigned long start, unsigned long last,
+			uint32_t trigger, struct page *fault_page);
+
 unsigned long
 svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long addr);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b23ba92a794c..2d9bb364d52c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -156,12 +156,13 @@ svm_is_valid_dma_mapping_addr(struct device *dev, dma_addr_t dma_addr)
 static int
 svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		      unsigned long offset, unsigned long npages,
-		      unsigned long *hmm_pfns, uint32_t gpuidx)
+		      unsigned long *hmm_pfns, uint32_t gpuidx, uint64_t *vram_pages)
 {
 	enum dma_data_direction dir = DMA_BIDIRECTIONAL;
 	dma_addr_t *addr = prange->dma_addr[gpuidx];
 	struct device *dev = adev->dev;
 	struct page *page;
+	uint64_t vram_pages_dev;
 	int i, r;
 
 	if (!addr) {
@@ -171,6 +172,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		prange->dma_addr[gpuidx] = addr;
 	}
 
+	vram_pages_dev = 0;
 	addr += offset;
 	for (i = 0; i < npages; i++) {
 		if (svm_is_valid_dma_mapping_addr(dev, addr[i]))
@@ -180,6 +182,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		if (is_zone_device_page(page)) {
 			struct amdgpu_device *bo_adev = prange->svm_bo->node->adev;
 
+			vram_pages_dev++;
 			addr[i] = (hmm_pfns[i] << PAGE_SHIFT) +
 				   bo_adev->vm_manager.vram_base_offset -
 				   bo_adev->kfd.pgmap.range.start;
@@ -196,13 +199,14 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		pr_debug_ratelimited("dma mapping 0x%llx for page addr 0x%lx\n",
 				     addr[i] >> PAGE_SHIFT, page_to_pfn(page));
 	}
+	*vram_pages = vram_pages_dev;
 	return 0;
 }
 
 static int
 svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
 		  unsigned long offset, unsigned long npages,
-		  unsigned long *hmm_pfns)
+		  unsigned long *hmm_pfns, uint64_t *vram_pages)
 {
 	struct kfd_process *p;
 	uint32_t gpuidx;
@@ -221,7 +225,7 @@ svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
 		}
 
 		r = svm_range_dma_map_dev(pdd->dev->adev, prange, offset, npages,
-					  hmm_pfns, gpuidx);
+					  hmm_pfns, gpuidx, vram_pages);
 		if (r)
 			break;
 	}
@@ -347,6 +351,7 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	INIT_LIST_HEAD(&prange->child_list);
 	atomic_set(&prange->invalid, 0);
 	prange->validate_timestamp = 0;
+	prange->vram_pages = 0;
 	mutex_init(&prange->migrate_mutex);
 	mutex_init(&prange->lock);
 
@@ -393,6 +398,8 @@ static void svm_range_bo_release(struct kref *kref)
 			 prange->start, prange->last);
 		mutex_lock(&prange->lock);
 		prange->svm_bo = NULL;
+		/* prange should not hold vram page now */
+		WARN_ON(prange->actual_loc);
 		mutex_unlock(&prange->lock);
 
 		spin_lock(&svm_bo->list_lock);
@@ -973,6 +980,11 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
 	new->svm_bo = svm_range_bo_ref(old->svm_bo);
 	new->ttm_res = old->ttm_res;
 
+	/* set new's vram_pages as old range's now, the acurate vram_pages
+	 * will be updated during mapping
+	 */
+	new->vram_pages = min(old->vram_pages, new->npages);
+
 	spin_lock(&new->svm_bo->list_lock);
 	list_add(&new->svm_bo_list, &new->svm_bo->range_list);
 	spin_unlock(&new->svm_bo->list_lock);
@@ -1133,66 +1145,6 @@ svm_range_add_child(struct svm_range *prange, struct mm_struct *mm,
 	list_add_tail(&pchild->child_list, &prange->child_list);
 }
 
-/**
- * svm_range_split_by_granularity - collect ranges within granularity boundary
- *
- * @p: the process with svms list
- * @mm: mm structure
- * @addr: the vm fault address in pages, to split the prange
- * @parent: parent range if prange is from child list
- * @prange: prange to split
- *
- * Trims @prange to be a single aligned block of prange->granularity if
- * possible. The head and tail are added to the child_list in @parent.
- *
- * Context: caller must hold mmap_read_lock and prange->lock
- *
- * Return:
- * 0 - OK, otherwise error code
- */
-int
-svm_range_split_by_granularity(struct kfd_process *p, struct mm_struct *mm,
-			       unsigned long addr, struct svm_range *parent,
-			       struct svm_range *prange)
-{
-	struct svm_range *head, *tail;
-	unsigned long start, last, size;
-	int r;
-
-	/* Align splited range start and size to granularity size, then a single
-	 * PTE will be used for whole range, this reduces the number of PTE
-	 * updated and the L1 TLB space used for translation.
-	 */
-	size = 1UL << prange->granularity;
-	start = ALIGN_DOWN(addr, size);
-	last = ALIGN(addr + 1, size) - 1;
-
-	pr_debug("svms 0x%p split [0x%lx 0x%lx] to [0x%lx 0x%lx] size 0x%lx\n",
-		 prange->svms, prange->start, prange->last, start, last, size);
-
-	if (start > prange->start) {
-		r = svm_range_split(prange, start, prange->last, &head);
-		if (r)
-			return r;
-		svm_range_add_child(parent, mm, head, SVM_OP_ADD_RANGE);
-	}
-
-	if (last < prange->last) {
-		r = svm_range_split(prange, prange->start, last, &tail);
-		if (r)
-			return r;
-		svm_range_add_child(parent, mm, tail, SVM_OP_ADD_RANGE);
-	}
-
-	/* xnack on, update mapping on GPUs with ACCESS_IN_PLACE */
-	if (p->xnack_enabled && prange->work_item.op == SVM_OP_ADD_RANGE) {
-		prange->work_item.op = SVM_OP_ADD_RANGE_AND_MAP;
-		pr_debug("change prange 0x%p [0x%lx 0x%lx] op %d\n",
-			 prange, prange->start, prange->last,
-			 SVM_OP_ADD_RANGE_AND_MAP);
-	}
-	return 0;
-}
 static bool
 svm_nodes_in_same_hive(struct kfd_node *node_a, struct kfd_node *node_b)
 {
@@ -1615,12 +1567,14 @@ static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
  * 5. Release page table (and SVM BO) reservation
  */
 static int svm_range_validate_and_map(struct mm_struct *mm,
+				      unsigned long map_start, unsigned long map_last,
 				      struct svm_range *prange, int32_t gpuidx,
 				      bool intr, bool wait, bool flush_tlb)
 {
 	struct svm_validate_context *ctx;
 	unsigned long start, end, addr;
 	struct kfd_process *p;
+	uint64_t vram_pages;
 	void *owner;
 	int32_t idx;
 	int r = 0;
@@ -1689,11 +1643,15 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 	}
 
+	vram_pages = 0;
 	start = prange->start << PAGE_SHIFT;
 	end = (prange->last + 1) << PAGE_SHIFT;
 	for (addr = start; !r && addr < end; ) {
 		struct hmm_range *hmm_range;
+		unsigned long map_start_vma;
+		unsigned long map_last_vma;
 		struct vm_area_struct *vma;
+		uint64_t vram_pages_vma;
 		unsigned long next = 0;
 		unsigned long offset;
 		unsigned long npages;
@@ -1722,9 +1680,11 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		if (!r) {
 			offset = (addr - start) >> PAGE_SHIFT;
 			r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
-					      hmm_range->hmm_pfns);
+					      hmm_range->hmm_pfns, &vram_pages_vma);
 			if (r)
 				pr_debug("failed %d to dma map range\n", r);
+			else
+				vram_pages += vram_pages_vma;
 		}
 
 		svm_range_lock(prange);
@@ -1738,9 +1698,16 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			r = -EAGAIN;
 		}
 
-		if (!r)
-			r = svm_range_map_to_gpus(prange, offset, npages, readonly,
-						  ctx->bitmap, wait, flush_tlb);
+		if (!r) {
+			map_start_vma = max(map_start, prange->start + offset);
+			map_last_vma = min(map_last, prange->start + offset + npages - 1);
+			if (map_start_vma <= map_last_vma) {
+				offset = map_start_vma - prange->start;
+				npages = map_last_vma - map_start_vma + 1;
+				r = svm_range_map_to_gpus(prange, offset, npages, readonly,
+							  ctx->bitmap, wait, flush_tlb);
+			}
+		}
 
 		if (!r && next == end)
 			prange->mapped_to_gpu = true;
@@ -1750,6 +1717,19 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		addr = next;
 	}
 
+	if (addr == end) {
+		prange->vram_pages = vram_pages;
+
+		/* if prange does not include any vram page and it
+		 * has not released svm_bo drop its svm_bo reference
+		 * and set its actaul_loc to sys ram
+		 */
+		if (!vram_pages && prange->ttm_res) {
+			prange->actual_loc = 0;
+			svm_range_vram_node_free(prange);
+		}
+	}
+
 	svm_range_unreserve_bos(ctx);
 	if (!r)
 		prange->validate_timestamp = ktime_get_boottime();
@@ -1833,8 +1813,8 @@ static void svm_range_restore_work(struct work_struct *work)
 		 */
 		mutex_lock(&prange->migrate_mutex);
 
-		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
-					       false, true, false);
+		r = svm_range_validate_and_map(mm, prange->start, prange->last, prange,
+					       MAX_GPU_INSTANCE, false, true, false);
 		if (r)
 			pr_debug("failed %d to map 0x%lx to gpus\n", r,
 				 prange->start);
@@ -2002,6 +1982,7 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 	new->actual_loc = old->actual_loc;
 	new->granularity = old->granularity;
 	new->mapped_to_gpu = old->mapped_to_gpu;
+	new->vram_pages = old->vram_pages;
 	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
 	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
 
@@ -2912,6 +2893,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			uint32_t vmid, uint32_t node_id,
 			uint64_t addr, bool write_fault)
 {
+	unsigned long start, last, size;
 	struct mm_struct *mm = NULL;
 	struct svm_range_list *svms;
 	struct svm_range *prange;
@@ -3047,40 +3029,44 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	kfd_smi_event_page_fault_start(node, p->lead_thread->pid, addr,
 				       write_fault, timestamp);
 
-	if (prange->actual_loc != best_loc) {
+	/* Align migration range start and size to granularity size */
+	size = 1UL << prange->granularity;
+	start = max_t(unsigned long, ALIGN_DOWN(addr, size), prange->start);
+	last = min_t(unsigned long, ALIGN(addr + 1, size) - 1, prange->last);
+	if (prange->actual_loc != 0 || best_loc != 0) {
 		migration = true;
+
 		if (best_loc) {
-			r = svm_migrate_to_vram(prange, best_loc, mm,
-					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
+			r = svm_migrate_to_vram(prange, best_loc, start, last,
+					mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
 			if (r) {
 				pr_debug("svm_migrate_to_vram failed (%d) at %llx, falling back to system memory\n",
 					 r, addr);
 				/* Fallback to system memory if migration to
 				 * VRAM failed
 				 */
-				if (prange->actual_loc)
-					r = svm_migrate_vram_to_ram(prange, mm,
-					   KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
-					   NULL);
+				if (prange->actual_loc && prange->actual_loc != best_loc)
+					r = svm_migrate_vram_to_ram(prange, mm, start, last,
+						KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
 				else
 					r = 0;
 			}
 		} else {
-			r = svm_migrate_vram_to_ram(prange, mm,
-					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
-					NULL);
+			r = svm_migrate_vram_to_ram(prange, mm, start, last,
+					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
 		}
 		if (r) {
 			pr_debug("failed %d to migrate svms %p [0x%lx 0x%lx]\n",
-				 r, svms, prange->start, prange->last);
+				 r, svms, start, last);
 			goto out_unlock_range;
 		}
 	}
 
-	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false, false);
+	r = svm_range_validate_and_map(mm, start, last, prange, gpuidx, false,
+				       false, false);
 	if (r)
 		pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
-			 r, svms, prange->start, prange->last);
+			 r, svms, start, last);
 
 	kfd_smi_event_page_fault_end(node, p->lead_thread->pid, addr,
 				     migration);
@@ -3426,18 +3412,24 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
 	*migrated = false;
 	best_loc = svm_range_best_prefetch_location(prange);
 
-	if (best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED ||
-	    best_loc == prange->actual_loc)
+	/* when best_loc is a gpu node and same as prange->actual_loc
+	 * we still need do migration as prange->actual_loc !=0 does
+	 * not mean all pages in prange are vram. hmm migrate will pick
+	 * up right pages during migration.
+	 */
+	if ((best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED) ||
+	    (best_loc == 0 && prange->actual_loc == 0))
 		return 0;
 
 	if (!best_loc) {
-		r = svm_migrate_vram_to_ram(prange, mm,
+		r = svm_migrate_vram_to_ram(prange, mm, prange->start, prange->last,
 					KFD_MIGRATE_TRIGGER_PREFETCH, NULL);
 		*migrated = !r;
 		return r;
 	}
 
-	r = svm_migrate_to_vram(prange, best_loc, mm, KFD_MIGRATE_TRIGGER_PREFETCH);
+	r = svm_migrate_to_vram(prange, best_loc, prange->start, prange->last,
+				mm, KFD_MIGRATE_TRIGGER_PREFETCH);
 	*migrated = !r;
 
 	return r;
@@ -3492,7 +3484,11 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 
 		mutex_lock(&prange->migrate_mutex);
 		do {
+			/* migrate all vram pages in this prange to sys ram
+			 * after that prange->actual_loc should be zero
+			 */
 			r = svm_migrate_vram_to_ram(prange, mm,
+					prange->start, prange->last,
 					KFD_MIGRATE_TRIGGER_TTM_EVICTION, NULL);
 		} while (!r && prange->actual_loc && --retries);
 
@@ -3616,8 +3612,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 		flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
 
-		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
-					       true, true, flush_tlb);
+		r = svm_range_validate_and_map(mm, prange->start, prange->last, prange,
+					       MAX_GPU_INSTANCE, true, true, flush_tlb);
 		if (r)
 			pr_debug("failed %d to map svm range\n", r);
 
@@ -3631,8 +3627,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		pr_debug("Remapping prange 0x%p [0x%lx 0x%lx]\n",
 			 prange, prange->start, prange->last);
 		mutex_lock(&prange->migrate_mutex);
-		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
-					       true, true, prange->mapped_to_gpu);
+		r = svm_range_validate_and_map(mm,  prange->start, prange->last, prange,
+					       MAX_GPU_INSTANCE, true, true, prange->mapped_to_gpu);
 		if (r)
 			pr_debug("failed %d on remap svm range\n", r);
 		mutex_unlock(&prange->migrate_mutex);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index c528df1d0ba2..026863a0abcd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -78,6 +78,7 @@ struct svm_work_list_item {
  * @update_list:link list node used to add to update_list
  * @mapping:    bo_va mapping structure to create and update GPU page table
  * @npages:     number of pages
+ * @vram_pages: vram pages number in this svm_range
  * @dma_addr:   dma mapping address on each GPU for system memory physical page
  * @ttm_res:    vram ttm resource map
  * @offset:     range start offset within mm_nodes
@@ -88,7 +89,9 @@ struct svm_work_list_item {
  * @flags:      flags defined as KFD_IOCTL_SVM_FLAG_*
  * @perferred_loc: perferred location, 0 for CPU, or GPU id
  * @perfetch_loc: last prefetch location, 0 for CPU, or GPU id
- * @actual_loc: the actual location, 0 for CPU, or GPU id
+ * @actual_loc: this svm_range location. 0: all pages are from sys ram;
+ *              GPU id: this svm_range may include vram pages from GPU with
+ *              id actual_loc.
  * @granularity:migration granularity, log2 num pages
  * @invalid:    not 0 means cpu page table is invalidated
  * @validate_timestamp: system timestamp when range is validated
@@ -112,6 +115,7 @@ struct svm_range {
 	struct list_head		list;
 	struct list_head		update_list;
 	uint64_t			npages;
+	uint64_t			vram_pages;
 	dma_addr_t			*dma_addr[MAX_GPU_INSTANCE];
 	struct ttm_resource		*ttm_res;
 	uint64_t			offset;
@@ -168,9 +172,6 @@ struct kfd_node *svm_range_get_node_by_id(struct svm_range *prange,
 int svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 			    bool clear);
 void svm_range_vram_node_free(struct svm_range *prange);
-int svm_range_split_by_granularity(struct kfd_process *p, struct mm_struct *mm,
-			       unsigned long addr, struct svm_range *parent,
-			       struct svm_range *prange);
 int svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			    uint32_t vmid, uint32_t node_id, uint64_t addr,
 			    bool write_fault);
-- 
2.25.1

