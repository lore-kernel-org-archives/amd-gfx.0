Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E45C3DA6F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 22:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8413D10E5E8;
	Thu, 24 Aug 2023 22:12:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF18410E5E8
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 22:12:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUr0/bJy4bYcrRK+Y23IQPOCoeX7JglEG68h0+gsNSQMxcNI5fi+fX//WpxOriKM1JjK8NJLa55vrUtLi8EcSPuO/bC3RY+8ndvnqLOep67UpEG4bedEzdQ609HupqmvGUj8gPBwnZDwclawYyOP5+aa/qIur+qgvVt6G7g9OppW7oRzJ7x4Znc7QvUg4mlBjmJI21PrKrKLfc0m6uH3WGYgglgRK3ZLKIf/B/6PTRQnZaj7ipmP/31tdzamGMojzK8NuD2IZUTdEbmclBgvPUtIURntcg2PjTs3WQHStN9ieDiSea0RQoSmCdGYokiQtVBj54LpDK6g04bhiQnqIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgHv60gov7fX/EwHFJKqX5kwQaWuAkf5WHg8Yy0MPQ8=;
 b=SxRFmN1qcig5rcpFD2qWMC305Y83hzB5eRX891kZyTrfhg4VFITsQVfDXZofnON5PhpGW5AoHQ4kLBQtPQmNMmPb/zMiQYNV5RoBCo1jX2LSkgN6a6IVwY+PBOQRZTjO5aPm6f3mcAxkV9n2HJ1GS+fs5djTo1QskiBwnJIKPVR+dxqzK6ZgT0RzcH4kVqdgPcObcIgY45184A9fi/C8FKmOj/+prSI5/lOhEMo97jJA46UxG+S2HJ2ZpV6O4PEZIS+vg8+g7exJuSmZhsu2Pg6dC7bfmgBTVatTWT8lmkcW/yEN+79Qj4pHAtol2qL40ytw0Iq9R5D8h/RgBFbhCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgHv60gov7fX/EwHFJKqX5kwQaWuAkf5WHg8Yy0MPQ8=;
 b=WOO8g2xeEAXImw3JeOhekCjEcgJfy5i6JWvmnOA509cFFP6Tky1itKGE6vR9Lh6jLJ6LAccCQK0cR+sNdIrKK4lsXTDNjAHnPju8d72tL5q/wxBc1JsdRs1eaIYiKHBx+rjUGsaDZK+re64Wrt4tzI7NDmfro+djIs8dT/qnmgo=
Received: from MW4PR04CA0154.namprd04.prod.outlook.com (2603:10b6:303:85::9)
 by LV3PR12MB9257.namprd12.prod.outlook.com (2603:10b6:408:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 22:12:44 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:303:85:cafe::fc) by MW4PR04CA0154.outlook.office365.com
 (2603:10b6:303:85::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Thu, 24 Aug 2023 22:12:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 22:12:43 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 17:12:42 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 17:12:42 -0500
Received: from Xiaogang-ROCM-Dev.attlocal.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Thu, 24 Aug 2023 17:12:42 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Use partial migrations in GPU page faults
Date: Thu, 24 Aug 2023 17:08:34 -0500
Message-ID: <20230824220834.362948-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|LV3PR12MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: c12ef5b9-7f91-4fda-3b33-08dba4ef3d79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QzmWeVKROnV2czdAm2EWO/vSJYiaWoopTUUou1/0RTrit7jHIby16i476Rp/bDvqml65crFp9P+FBpN43AXUDxXq74WWc7p6A8GxbT4HFZ8GG7xaH0VICO5f8OLf2wNVpqAmPBYhDlK16GCxp785SK8bemlgdYsOONBZLVBIascTy2C3qQ46diCO6PXImzJje6qM+PFb+n8UO4pTe2O+4m2e0ey5STU+mNIilyEk/LMMmLXTAzsXJHelEbOdApKR1DAPoKn6ZOSMvx73pbhdRsca3e3N1v+YybEmhTtoBuOy09FOziJ7bU1lVztMlhOM+iQm39f/IAuphq2wKXLOBGv59TjNebItubGnld1EA1KNjbC0/Ecg9osuie6h5zbVNHCf9NFLK6ZNiFdBrmjzkC64sRXDJC05X60foGg116hBCmJ4VocA4tHUUkGmnuPJjamcn2Ua5d6PJeEIJLxUjKTccYXOWkhA4WL8bI7PrZL1TxIasf5HLEdkMaZb9rkIAZD/k0jUos+28FbuyCGWAudIpxjmWJZlAVf19n9bumEHTDDMV+tQQPZvbv/4VacMWHPzNMVEGfmD72QtU7WFE5vcl3ziY/13qlk6MKIFeym/H45hsUsWLqiXKnvTR4KA4JH9nRNZM9aR1tL2mKuFhmfe+Dt/oSdoZP78zPRUzPaAffekZeXdy+tNZXizaNLbJ1WoinkFfzpQPw2QSxh80PLejta45PpASoYQxrU9ZTFA5+RqjeCZMY+nJmQP1ULJJkyvT1a/VCrbm/bopb6yQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(82310400011)(451199024)(1800799009)(186009)(40470700004)(36840700001)(46966006)(82740400003)(81166007)(356005)(40460700003)(8676002)(4326008)(8936002)(54906003)(41300700001)(316002)(6666004)(36756003)(6916009)(70586007)(70206006)(86362001)(40480700001)(47076005)(26005)(478600001)(336012)(1076003)(36860700001)(83380400001)(2906002)(30864003)(2616005)(426003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 22:12:43.6988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c12ef5b9-7f91-4fda-3b33-08dba4ef3d79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9257
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
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Philip.Yang@amd.com,
 felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

This patch implements partial migration in gpu page fault according to migration
granularity(default 2MB) and not split svm range in cpu page fault handling.
Now a svm range may have pages from both system ram and vram of one gpu.
These chagnes are expected to improve migration performance and reduce
mmu callback and TLB flush workloads.

Signed-off-by: xiaogang chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 153 +++++++++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.h |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     |  87 ++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |   7 +-
 4 files changed, 162 insertions(+), 91 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 7d82c7da223a..5a3aa80a1834 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
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
@@ -498,9 +501,9 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	unsigned long cpages = 0;
 	long r = 0;
 
-	if (prange->actual_loc == best_loc) {
-		pr_debug("svms 0x%p [0x%lx 0x%lx] already on best_loc 0x%x\n",
-			 prange->svms, prange->start, prange->last, best_loc);
+	if (!best_loc) {
+		pr_debug("request svms 0x%p [0x%lx 0x%lx] migrate to sys ram\n",
+			 prange->svms, start_mgr, last_mgr);
 		return 0;
 	}
 
@@ -513,8 +516,8 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	pr_debug("svms 0x%p [0x%lx 0x%lx] to gpu 0x%x\n", prange->svms,
 		 prange->start, prange->last, best_loc);
 
-	start = prange->start << PAGE_SHIFT;
-	end = (prange->last + 1) << PAGE_SHIFT;
+	start = start_mgr << PAGE_SHIFT;
+	end = (last_mgr + 1) << PAGE_SHIFT;
 
 	r = svm_range_vram_node_new(node, prange, true);
 	if (r) {
@@ -544,10 +547,12 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 
 	if (cpages) {
 		prange->actual_loc = best_loc;
-		svm_range_free_dma_mappings(prange, true);
-	} else {
+		/* only free dma mapping in the migrated range */
+		svm_range_free_dma_mappings(prange, true,  start_mgr - prange->start,
+						 last_mgr - start_mgr + 1);
+	} else if (!prange->actual_loc)
+		/* if all pages from prange are at sys ram */
 		svm_range_vram_node_free(prange);
-	}
 
 	return r < 0 ? r : 0;
 }
@@ -762,6 +767,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
  * svm_migrate_vram_to_ram - migrate svm range from device to system
  * @prange: range structure
  * @mm: process mm, use current->mm if NULL
+ * @start_mgr: start page need be migrated to sys ram
+ * @last_mgr: last page need be migrated to sys ram
  * @trigger: reason of migration
  * @fault_page: is from vmf->page, svm_migrate_to_ram(), this is CPU page fault callback
  *
@@ -771,7 +778,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
  * 0 - OK, otherwise error code
  */
 int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
-			    uint32_t trigger, struct page *fault_page)
+					unsigned long start_mgr, unsigned long last_mgr,
+					uint32_t trigger, struct page *fault_page)
 {
 	struct kfd_node *node;
 	struct vm_area_struct *vma;
@@ -781,23 +789,30 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 	unsigned long upages = 0;
 	long r = 0;
 
+	/* this pragne has no any vram page to migrate to sys ram */
 	if (!prange->actual_loc) {
 		pr_debug("[0x%lx 0x%lx] already migrated to ram\n",
 			 prange->start, prange->last);
 		return 0;
 	}
 
+	if (start_mgr < prange->start || last_mgr > prange->last) {
+		pr_debug("migration range [0x%lx 0x%lx] out prange [0x%lx 0x%lx]\n",
+			 start_mgr, last_mgr, prange->start, prange->last);
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
@@ -822,8 +837,47 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 	}
 
 	if (r >= 0 && !upages) {
-		svm_range_vram_node_free(prange);
-		prange->actual_loc = 0;
+		/* all vram pages from prange got migrated to sys ram */
+		if (start_mgr == prange->start && last_mgr == prange->last) {
+
+			prange->actual_loc = 0;
+			spin_lock(&prange->svm_bo->list_lock);
+			list_del_init(&prange->svm_bo_list);
+			spin_unlock(&prange->svm_bo->list_lock);
+
+			svm_range_vram_node_free(prange);
+		} else {
+
+			/* cannot call svm_range_vram_node_free since only part of its vram
+			 * pages got migrated. check if all vram pages from all pranges
+			 * that shared this svm_bo have been released, then unref
+			 * all svm_bo ref count.
+			 */
+			struct svm_range *tmp;
+			unsigned int count = 0;
+
+			/* how many prangs refer to this svm_bo */
+			spin_lock(&prange->svm_bo->list_lock);
+			list_for_each_entry(tmp, &prange->svm_bo->range_list, svm_bo_list)
+				count++;
+			spin_unlock(&prange->svm_bo->list_lock);
+
+			/* if svm_bo ref number is same as count above all vram pages from
+			 * all pranges have been released, unref svm_bo count times
+			 * from all pranges to force svm_bo released
+			 */
+			if (refcount_read(&prange->svm_bo->kref.refcount) == count) {
+
+				spin_lock(&prange->svm_bo->list_lock);
+				list_for_each_entry(tmp, &prange->svm_bo->range_list, svm_bo_list) {
+					spin_unlock(&prange->svm_bo->list_lock);
+
+					svm_range_vram_node_free(tmp);
+					spin_lock(&prange->svm_bo->list_lock);
+				}
+				spin_unlock(&prange->svm_bo->list_lock);
+			}
+		}
 	}
 
 	return r < 0 ? r : 0;
@@ -833,17 +887,23 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
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
+ * migrate all vram pages in prange to sys ram, then migrate [start, last] pages
+ * from sys ram to gpu node best_loc.
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
 
@@ -855,7 +915,8 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	pr_debug("from gpu 0x%x to gpu 0x%x\n", prange->actual_loc, best_loc);
 
 	do {
-		r = svm_migrate_vram_to_ram(prange, mm, trigger, NULL);
+		r = svm_migrate_vram_to_ram(prange, mm, prange->start, prange->last,
+					trigger, NULL);
 		if (r)
 			return r;
 	} while (prange->actual_loc && --retries);
@@ -863,18 +924,20 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	if (prange->actual_loc)
 		return -EDEADLK;
 
-	return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
+	return svm_migrate_ram_to_vram(prange, best_loc, start, last, mm, trigger);
 }
 
 int
 svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
-		    struct mm_struct *mm, uint32_t trigger)
+		unsigned long start, unsigned long last,
+		struct mm_struct *mm, uint32_t trigger)
 {
-	if  (!prange->actual_loc)
-		return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
+	if  (!prange->actual_loc || prange->actual_loc == best_loc)
+		return svm_migrate_ram_to_vram(prange, best_loc, start, last,
+					mm, trigger);
 	else
-		return svm_migrate_vram_to_vram(prange, best_loc, mm, trigger);
-
+		return svm_migrate_vram_to_vram(prange, best_loc, start, last,
+					mm, trigger);
 }
 
 /**
@@ -889,10 +952,9 @@ svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
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
@@ -929,51 +991,34 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 
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
+	start = ALIGN_DOWN(addr, size);
+	last = ALIGN(addr + 1, size) - 1;
+
+	start = (start >= prange->start) ? start : prange->start;
+	last = (last <= prange->last) ? last : prange->last;
 
-	r = svm_migrate_vram_to_ram(prange, vmf->vma->vm_mm,
-				    KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU,
-				    vmf->page);
+	r = svm_migrate_vram_to_ram(prange, vmf->vma->vm_mm, start, last,
+				KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU, vmf->page);
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
+			 r, prange->svms, prange, start, last);
 
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
index 841ba6102bbb..012dceb7c0ed 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -247,7 +247,8 @@ void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
 	}
 }
 
-void svm_range_free_dma_mappings(struct svm_range *prange, bool unmap_dma)
+void svm_range_free_dma_mappings(struct svm_range *prange, bool unmap_dma,
+				unsigned long offset, unsigned long npages)
 {
 	struct kfd_process_device *pdd;
 	dma_addr_t *dma_addr;
@@ -269,7 +270,7 @@ void svm_range_free_dma_mappings(struct svm_range *prange, bool unmap_dma)
 		}
 		dev = &pdd->dev->adev->pdev->dev;
 		if (unmap_dma)
-			svm_range_dma_unmap(dev, dma_addr, 0, prange->npages);
+			svm_range_dma_unmap(dev, dma_addr, offset, npages);
 		kvfree(dma_addr);
 		prange->dma_addr[gpuidx] = NULL;
 	}
@@ -284,7 +285,7 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
 		 prange->start, prange->last);
 
 	svm_range_vram_node_free(prange);
-	svm_range_free_dma_mappings(prange, do_unmap);
+	svm_range_free_dma_mappings(prange, do_unmap, 0, prange->npages);
 
 	if (do_unmap && !p->xnack_enabled) {
 		pr_debug("unreserve prange 0x%p size: 0x%llx\n", prange, size);
@@ -384,6 +385,8 @@ static void svm_range_bo_release(struct kref *kref)
 			 prange->start, prange->last);
 		mutex_lock(&prange->lock);
 		prange->svm_bo = NULL;
+		/* prange dose not hold vram page now */
+		prange->actual_loc = 0;
 		mutex_unlock(&prange->lock);
 
 		spin_lock(&svm_bo->list_lock);
@@ -439,7 +442,8 @@ svm_range_validate_svm_bo(struct kfd_node *node, struct svm_range *prange)
 		mutex_unlock(&prange->lock);
 		return false;
 	}
-	if (prange->ttm_res) {
+	/* requeset from same kfd_node and we still have reference to it */
+	if (prange->ttm_res && prange->svm_bo->node == node) {
 		/* We still have a reference, all is well */
 		mutex_unlock(&prange->lock);
 		return true;
@@ -458,6 +462,8 @@ svm_range_validate_svm_bo(struct kfd_node *node, struct svm_range *prange)
 			spin_unlock(&prange->svm_bo->list_lock);
 
 			svm_range_bo_unref(prange->svm_bo);
+			prange->ttm_res = NULL;
+			prange->svm_bo = NULL;
 			return false;
 		}
 		if (READ_ONCE(prange->svm_bo->evicting)) {
@@ -2888,6 +2894,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			uint32_t vmid, uint32_t node_id,
 			uint64_t addr, bool write_fault)
 {
+	unsigned long start, last, size;
 	struct mm_struct *mm = NULL;
 	struct svm_range_list *svms;
 	struct svm_range *prange;
@@ -3023,34 +3030,38 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	kfd_smi_event_page_fault_start(node, p->lead_thread->pid, addr,
 				       write_fault, timestamp);
 
-	if (prange->actual_loc != best_loc) {
-		migration = true;
-		if (best_loc) {
-			r = svm_migrate_to_vram(prange, best_loc, mm,
-					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
-			if (r) {
-				pr_debug("svm_migrate_to_vram failed (%d) at %llx, falling back to system memory\n",
-					 r, addr);
-				/* Fallback to system memory if migration to
-				 * VRAM failed
-				 */
-				if (prange->actual_loc)
-					r = svm_migrate_vram_to_ram(prange, mm,
-					   KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
-					   NULL);
-				else
-					r = 0;
-			}
-		} else {
-			r = svm_migrate_vram_to_ram(prange, mm,
-					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
-					NULL);
-		}
+	/* Align migration range start and size to granularity size */
+	size = 1UL << prange->granularity;
+	start = ALIGN_DOWN(addr, size);
+	last = ALIGN(addr + 1, size) - 1;
+
+	start = (start >= prange->start) ? start : prange->start;
+	last = (last <= prange->last) ? last : prange->last;
+
+	migration = true;
+	if (best_loc) {
+		r = svm_migrate_to_vram(prange, best_loc, start, last,
+						mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
 		if (r) {
-			pr_debug("failed %d to migrate svms %p [0x%lx 0x%lx]\n",
-				 r, svms, prange->start, prange->last);
-			goto out_unlock_range;
+			pr_debug("svm_migrate_to_vram failed (%d) at %llx, falling back to system memory\n",
+					 r, addr);
+			/* Fallback to system memory if migration to
+			 * VRAM failed
+			 */
+			if (prange->actual_loc)
+				r = svm_migrate_vram_to_ram(prange, mm, start, last,
+							KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
+			else
+				r = 0;
 		}
+	} else {
+		r = svm_migrate_vram_to_ram(prange, mm, start, last,
+					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
+	}
+	if (r) {
+		pr_debug("failed %d to migrate svms %p [0x%lx 0x%lx]\n",
+				 r, svms, start, last);
+		goto out_unlock_range;
 	}
 
 	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false, false);
@@ -3402,18 +3413,22 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
 	*migrated = false;
 	best_loc = svm_range_best_prefetch_location(prange);
 
-	if (best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED ||
-	    best_loc == prange->actual_loc)
+	/* when best_loc is a gpu node and same as prange->actual_loc
+	 * we still need migrate as prange->actual_loc does not mean all
+	 * pages in prange are vram. hmm migrate will pick up right pages.
+	 */
+	if (best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED)
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
+					mm, KFD_MIGRATE_TRIGGER_PREFETCH);
 	*migrated = !r;
 
 	return r;
@@ -3468,7 +3483,11 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 
 		mutex_lock(&prange->migrate_mutex);
 		do {
+			/* migrate all vram pages in this prange to sys ram
+			 * after that prange->actual_loc should be zero
+			 */
 			r = svm_migrate_vram_to_ram(prange, mm,
+					prange->start, prange->last,
 					KFD_MIGRATE_TRIGGER_TTM_EVICTION, NULL);
 		} while (!r && prange->actual_loc && --retries);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 9e668eeefb32..c565e018cfb3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -88,7 +88,9 @@ struct svm_work_list_item {
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
@@ -183,7 +185,8 @@ void svm_range_add_list_work(struct svm_range_list *svms,
 void schedule_deferred_list_work(struct svm_range_list *svms);
 void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
 			 unsigned long offset, unsigned long npages);
-void svm_range_free_dma_mappings(struct svm_range *prange, bool unmap_dma);
+void svm_range_free_dma_mappings(struct svm_range *prange, bool unmap_dma,
+			 unsigned long offset, unsigned long npages);
 int svm_range_get_info(struct kfd_process *p, uint32_t *num_svm_ranges,
 		       uint64_t *svm_priv_data_size);
 int kfd_criu_checkpoint_svm(struct kfd_process *p,
-- 
2.25.1

