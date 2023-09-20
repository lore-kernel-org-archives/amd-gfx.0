Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09AFC04ABA
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 17:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02D7210E528;
	Wed, 20 Sep 2023 17:31:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::603])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD24B10E528
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 17:31:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVGbbEKGBU4jBfMwhXSCB3izsLTaaSpF1FdRuZbhvpWp/RMoyBgq32UvijfzlBiVXbTGPvDdtQYl2Ub4wXzbxGwGFTJwnAsppZAsno6nK3ILIS8luxnajhJ1425SIe6U8uq0CEgMEX/Pd0pyQAMf36adY9WOYGnLF47KcjbsmEIUuoYxCXLLlFI9GbEWKSIynLxAQUkp+dFgSOsHAvF/xgu0xZ/BjYijHDoPqaWOaEiuhREEdPWQdhYMcljiYEhkyZfoTKhUOX2+DBSTU2wFZF/XQkEUbGQCT6sFjpOBjEXAOB+xRQJcss/M533H2zihmKufs4UjzuXCib10ehKBRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RPL9vRo+MKXOyn3n6eEVKoKp151UaqSpi6j22f5QT0=;
 b=g+MxST+pQpNkK9ezpoM/CzWHlvU9BTFgzmLNYqBeAfiSKj64MqBGk1R/sGV5W3X98Z1cmVcmJKZwoueV2vEvN9abDECtLzewDJFzTWMpPKwNCfeIo2ZPDJybLlWXXpAcChkDHdnCVi8HxVklt1G3uU1++s6Qso4k2FUWtHpF+nzzh2/0T/xsu9kJzQXVsgxYPmjKxa+7VSmmwVKDYklLvOmOwtIvIwsezOGgqj69hDXF2AI3WzjbV/EhYyfYuNCi2Vvu+5Q7KIL+bNpzpEF3ePt9VWt3AJnTFMNGqkbHHzlGCy/QRCHpnN6oMMrWJ9JO3XgBTJB2FB7n4/Zgxnpt2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RPL9vRo+MKXOyn3n6eEVKoKp151UaqSpi6j22f5QT0=;
 b=aYlwvI7xruwfDdN/HnYppBY8Zxs1WViXyY+X0UAOp6aceZp1ngIEuNKdWU3cdrzsCIoc32fX+tOa833CY3Nv/vAp7Oaqj5Lf7xGEa0t+qRC2F0m/jJ/fs/8UkPldr73wfWvxeykve7nnGyohnejsVTcIM1S+i7DZeeGy3GQOxrM=
Received: from BYAPR08CA0071.namprd08.prod.outlook.com (2603:10b6:a03:117::48)
 by DM6PR12MB4498.namprd12.prod.outlook.com (2603:10b6:5:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30; Wed, 20 Sep
 2023 17:31:06 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::8d) by BYAPR08CA0071.outlook.office365.com
 (2603:10b6:a03:117::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 17:31:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 17:31:06 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 12:31:05 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 10:31:05 -0700
Received: from Xiaogang-ROCM-Dev.attlocal.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Wed, 20 Sep 2023 12:31:05 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdkfd: Use partial migrations in GPU page faults
Date: Wed, 20 Sep 2023 12:32:03 -0500
Message-ID: <20230920173203.12760-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DM6PR12MB4498:EE_
X-MS-Office365-Filtering-Correlation-Id: 53910915-c23d-4f58-43ff-08dbb9ff5ec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S76Vf/gB9z8bfogxeUlfAKQ57Jf24xJ+oflaRwaiuqAUyc7YsfMXfjZO8fHw5BUsvZjEurFxfLaBIKnBPalrViSsH/CGksMhCQTqA7jSbiMFdG9Na2UwFQTU/IZ2GiazLxRZFhE/77khJtLsvkhs20zzDbxXWcbYqblD+wlE8Hh+kvySPa1SrveJdVcaYMCiwgw8FV/eNecbGJDo36SX3UZ7nsxNnVAfYZgodyzxUqMrgH5QT/MkIzr7bMMzQoYeSn5em3A+bNIiGk+lc4AlAQ1SglenFCnP12ync2/Ke72iGUwp4slhvCUMSgWo9I6fAk2Nue0VIlZBBvbtYnIFBWKGRFhjkqVL9S9gDB0L2tZs6DUulh6/DKeq9OjjruSp2Py6pu6nIMwgK3hACseIS1zJ2n/RhJP8nTfJSl0Qo1vFprvRncRFuHjlon0yGdw+6GK4RJ9TP+M+CKWZejIWNnctbo2bWgBLXmHGcqG4ld+KfrovgnF31OOeDATbrXgwh/fhvSVHDa1xnFQcnMtlh81dGwkja90AjjEl5ZPBWPaSAepXAs8MNf9ATOcBptUroQjdiI9y+rMHvCZBteXK3OD7sePuLpztI6zEiqxN2gKqsotStG+sBxaY5MT3gkiWb933oD5v5WcO8+W5Xv7z2wj7niYPzw6QD9A5ohdeY3dRU4EkytCfuv4sC49JTjpPXcVfC4sralQmbak+TeE6qGPPdXqFb1/51Qm9U46zt4mR9kfxvb1ETjstW65Aa6qoEkbVbHwCJFV0cbGO7ljSIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(82310400011)(1800799009)(186009)(451199024)(36840700001)(46966006)(40470700004)(478600001)(2616005)(83380400001)(26005)(1076003)(47076005)(2906002)(30864003)(336012)(426003)(70586007)(70206006)(316002)(54906003)(4326008)(5660300002)(6916009)(41300700001)(8676002)(8936002)(40460700003)(36860700001)(86362001)(36756003)(356005)(81166007)(82740400003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 17:31:06.0283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53910915-c23d-4f58-43ff-08dbb9ff5ec6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4498
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
A svm range may include pages from both system ram and vram of one gpu now.
These chagnes are expected to improve migration performance and reduce mmu
callback and TLB flush workloads.

Signed-off-by: xiaogang chen<xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 156 +++++++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.h |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 104 +++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |   6 +-
 4 files changed, 178 insertions(+), 94 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 6c25dab051d5..e886f9ce40ac 100644
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
@@ -498,23 +501,30 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
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
 
@@ -663,19 +676,19 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
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
-		       struct vm_area_struct *vma, uint64_t start, uint64_t end,
-		       uint32_t trigger, struct page *fault_page)
+			struct vm_area_struct *vma, uint64_t start, uint64_t end,
+			uint32_t trigger, struct page *fault_page)
 {
 	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
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
@@ -771,33 +788,41 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
  * 0 - OK, otherwise error code
  */
 int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
-			    uint32_t trigger, struct page *fault_page)
+			unsigned long start_mgr, unsigned long last_mgr,
+			uint32_t trigger, struct page *fault_page)
 {
 	struct kfd_node *node;
 	struct vm_area_struct *vma;
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
+		prange->vram_pages = prange->vram_pages - mpages;
+
+		/* prange dos not have vram page drop its svm_bo ref */
+		if (prange->vram_pages == 0 && prange->ttm_res) {
+			svm_range_vram_node_free(prange);
+			mutex_lock(&prange->lock);
+			prange->actual_loc = 0;
+			mutex_unlock(&prange->lock);
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
+							mm, trigger);
+
 	else
-		return svm_migrate_vram_to_vram(prange, best_loc, mm, trigger);
+		return svm_migrate_vram_to_vram(prange, best_loc, start, last,
+									mm, trigger);
 
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
index fcdde9f451bb..94d14104234e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -156,12 +156,11 @@ svm_is_valid_dma_mapping_addr(struct device *dev, dma_addr_t dma_addr)
 static int
 svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		      unsigned long offset, unsigned long npages,
-		      unsigned long *hmm_pfns, uint32_t gpuidx)
+		      unsigned long *hmm_pfns, uint32_t gpuidx, struct page **page)
 {
 	enum dma_data_direction dir = DMA_BIDIRECTIONAL;
 	dma_addr_t *addr = prange->dma_addr[gpuidx];
 	struct device *dev = adev->dev;
-	struct page *page;
 	int i, r;
 
 	if (!addr) {
@@ -176,8 +175,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		if (svm_is_valid_dma_mapping_addr(dev, addr[i]))
 			dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
 
-		page = hmm_pfn_to_page(hmm_pfns[i]);
-		if (is_zone_device_page(page)) {
+		if (is_zone_device_page(page[i])) {
 			struct amdgpu_device *bo_adev = prange->svm_bo->node->adev;
 
 			addr[i] = (hmm_pfns[i] << PAGE_SHIFT) +
@@ -187,14 +185,14 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 			pr_debug_ratelimited("vram address: 0x%llx\n", addr[i]);
 			continue;
 		}
-		addr[i] = dma_map_page(dev, page, 0, PAGE_SIZE, dir);
+		addr[i] = dma_map_page(dev, page[i], 0, PAGE_SIZE, dir);
 		r = dma_mapping_error(dev, addr[i]);
 		if (r) {
 			dev_err(dev, "failed %d dma_map_page\n", r);
 			return r;
 		}
 		pr_debug_ratelimited("dma mapping 0x%llx for page addr 0x%lx\n",
-				     addr[i] >> PAGE_SHIFT, page_to_pfn(page));
+				     addr[i] >> PAGE_SHIFT, page_to_pfn(page[i]));
 	}
 	return 0;
 }
@@ -202,12 +200,24 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 static int
 svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
 		  unsigned long offset, unsigned long npages,
-		  unsigned long *hmm_pfns)
+		  unsigned long *hmm_pfns, uint64_t *vram_pages)
 {
 	struct kfd_process *p;
 	uint32_t gpuidx;
+	struct page **page;
 	int r;
 
+	page = kvcalloc(npages, sizeof(*page), GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+
+	*vram_pages = 0;
+	for (int i = 0; i < npages; i++) {
+		page[i] = hmm_pfn_to_page(hmm_pfns[i]);
+		if (is_zone_device_page(page[i]))
+			(*vram_pages)++;
+	}
+
 	p = container_of(prange->svms, struct kfd_process, svms);
 
 	for_each_set_bit(gpuidx, bitmap, MAX_GPU_INSTANCE) {
@@ -221,11 +231,12 @@ svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
 		}
 
 		r = svm_range_dma_map_dev(pdd->dev->adev, prange, offset, npages,
-					  hmm_pfns, gpuidx);
+					  hmm_pfns, gpuidx, page);
 		if (r)
 			break;
 	}
 
+	kvfree(page);
 	return r;
 }
 
@@ -347,6 +358,7 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	INIT_LIST_HEAD(&prange->child_list);
 	atomic_set(&prange->invalid, 0);
 	prange->validate_timestamp = 0;
+	prange->vram_pages = 0;
 	mutex_init(&prange->migrate_mutex);
 	mutex_init(&prange->lock);
 
@@ -393,6 +405,8 @@ static void svm_range_bo_release(struct kref *kref)
 			 prange->start, prange->last);
 		mutex_lock(&prange->lock);
 		prange->svm_bo = NULL;
+		/* prange does not hold vram page now */
+		prange->actual_loc = 0;
 		mutex_unlock(&prange->lock);
 
 		spin_lock(&svm_bo->list_lock);
@@ -966,6 +980,11 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
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
@@ -1610,6 +1629,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	struct svm_validate_context *ctx;
 	unsigned long start, end, addr;
 	struct kfd_process *p;
+	uint64_t vram_pages;
 	void *owner;
 	int32_t idx;
 	int r = 0;
@@ -1678,11 +1698,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 	}
 
+	vram_pages = 0;
 	start = prange->start << PAGE_SHIFT;
 	end = (prange->last + 1) << PAGE_SHIFT;
 	for (addr = start; addr < end && !r; ) {
 		struct hmm_range *hmm_range;
 		struct vm_area_struct *vma;
+		uint64_t vram_pages_vma;
 		unsigned long next;
 		unsigned long offset;
 		unsigned long npages;
@@ -1711,12 +1733,14 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
 		offset = (addr - start) >> PAGE_SHIFT;
 		r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
-				      hmm_range->hmm_pfns);
+				      hmm_range->hmm_pfns, &vram_pages_vma);
 		if (r) {
 			pr_debug("failed %d to dma map range\n", r);
 			goto unreserve_out;
 		}
 
+		vram_pages += vram_pages_vma;
+
 		svm_range_lock(prange);
 		if (amdgpu_hmm_range_get_pages_done(hmm_range)) {
 			pr_debug("hmm update the range, need validate again\n");
@@ -1738,8 +1762,20 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		addr = next;
 	}
 
-	if (addr == end)
+	if (addr == end) {
 		prange->mapped_to_gpu = true;
+		prange->vram_pages = vram_pages;
+
+		/* if pragne does not include any vram page and it
+		 * has not released svm_bo drop its svm_bo reference
+		 */
+		if (!vram_pages && prange->ttm_res) {
+			svm_range_vram_node_free(prange);
+			mutex_lock(&prange->lock);
+			prange->actual_loc = 0;
+			mutex_unlock(&prange->lock);
+		}
+	}
 
 unreserve_out:
 	svm_range_unreserve_bos(ctx);
@@ -1996,6 +2032,7 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 	new->actual_loc = old->actual_loc;
 	new->granularity = old->granularity;
 	new->mapped_to_gpu = old->mapped_to_gpu;
+	new->vram_pages = old->vram_pages;
 	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
 	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
 
@@ -2903,6 +2940,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			uint32_t vmid, uint32_t node_id,
 			uint64_t addr, bool write_fault)
 {
+	unsigned long start, last, size;
 	struct mm_struct *mm = NULL;
 	struct svm_range_list *svms;
 	struct svm_range *prange;
@@ -3038,32 +3076,38 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	kfd_smi_event_page_fault_start(node, p->lead_thread->pid, addr,
 				       write_fault, timestamp);
 
-	if (prange->actual_loc != best_loc) {
+	if (prange->actual_loc != 0 || best_loc != 0) {
 		migration = true;
+		/* Align migration range start and size to granularity size */
+		size = 1UL << prange->granularity;
+		start = ALIGN_DOWN(addr, size);
+		last = ALIGN(addr + 1, size) - 1;
+
+		start = (start >= prange->start) ? start : prange->start;
+		last = (last <= prange->last) ? last : prange->last;
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
+				r, svms, start, last);
 			goto out_unlock_range;
 		}
 	}
@@ -3417,18 +3461,24 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
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
+		(best_loc == 0 && prange->actual_loc == 0))
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
@@ -3483,7 +3533,11 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 
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
index 5fd958a97a28..8574cc5eeabd 100644
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
-- 
2.25.1

