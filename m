Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B43C4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Dec 2023 15:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F34B10E752;
	Wed,  6 Dec 2023 15:24:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A702810E72F
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Dec 2023 15:24:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chjsxEhE+J7ielWxmGOqfsUbiXhfKOILv24GkJ47KamGsg4nJcmvNxwZoNxoipXJOBABntxolKLxQ3mn7zPxKKza+7GiIsfnE5yMH9V1hvG7A6h4NDOGrY1t72DMO/VJ6tm9P+CZqqs09BUQz2ySDqcthvZariaT99lgBR3QlexlFQtCqY6Wq6DDF+qniK0aNnWuGvZJvWP9MFhfMgC3RwtyQ0sdFWV6L9QQVjshB/WBzVsjPQui80R0zZWjgb0KKzxeNlCr/4pUQpHbSkUzmlNLSdy21OCFvrRN/KVcnPTT8QhtJDzszW0EgQaaPvhRnvYHJyAE7dwgWH2JYiQHTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2iYedGlAZtAH+WAXJa4HXQhOcQzW3MEEgwCuemrrYc=;
 b=IsleAJgu44SiuM8Z9FQvh4sGSfRC6TYbjleCVN+ZvtAMrbCoKxOaX/63+ZR0qp7LcaCHnvrPyPr7O/KhoyfsabSYPxxSdWal5nYFhisKvZBl5nljErBIM4JK38K2Tf56NojSUhH6mWHDXAsKtih6En83n8zz1mqQLt4eG/OIdX784cWvXh5WVdCsRM9cgVWdSlBDpIwTPfBiwZfXFXLYfuJZGncyF7jxyK2iTUc15KvYypLyzVhBSil8GP9C8INeoiOvueLYM1+/zQgkQJLiYD4SwZzynmc0cFvte080b3d9vPUVCqVEkM1vtine3fMj7fNMCZQKcVEhXfSle0R2lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2iYedGlAZtAH+WAXJa4HXQhOcQzW3MEEgwCuemrrYc=;
 b=4OWVodaEN5++8bnTDGvjhQYcFNC7E7s4gDig7WftdWxnAuOe2Tg+iYRXN44JsM2t5UO1uD9uuT/7rSGUF32rbJ21ySS+Rb6SjhT839NVPbNGldJK3oivHnxpLGQCky7S0DrPqYYZ0U1SVGEIbC9y/bvInY64W3aIb4HbYiNb+Co=
Received: from BN0PR04CA0181.namprd04.prod.outlook.com (2603:10b6:408:e9::6)
 by IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 15:24:13 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:408:e9:cafe::e1) by BN0PR04CA0181.outlook.office365.com
 (2603:10b6:408:e9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25 via Frontend
 Transport; Wed, 6 Dec 2023 15:24:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 15:24:13 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 09:24:10 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 6 Dec
 2023 07:23:39 -0800
Received: from Xiaogang-ROCM-Dev.attlocal.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Wed, 6 Dec 2023 09:23:34 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdkfd: Use partial hmm page walk during buffer
 validation in SVM
Date: Wed, 6 Dec 2023 09:24:10 -0600
Message-ID: <20231206152410.123993-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|IA0PR12MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: bd749fde-1dfc-4a07-1f5e-08dbf66f6734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cArf0e6SI4W9EHmnaTqfV+ut7jKr+7PYKHriex26PD8SUA6GklqNIobFjYqeXCkqKkonm7gF17VbwsZx5EEisqio/C1KT5aDGPVe09RRqdSxkqqbxFH1JmpL4VlDX45OKma1nA6SySHHZZtoudNMsoLLnnPhB+OQdIWYNYvEi1QOQqedLdv8mQ8U2gh3NEI6F8a+3eISCY11acsz6/Et0P3qdyg9Z26DG3UuT3N8Rf+90FwfE+F2VKMcATO9PmLIr6F8wAiwfjiqFMAVzkVb727mte+zapPX/71zMBigVOqpt6mX8/sREENiVrYh43cacxs977XA2MVrxyRvjv5kIyyxKZ6CxEp5MF/E0mOG/GNtqJXmKo52t5iGOUsg/sSdVZgcGWuLkVUs8B/NS+ZwoTk8/1RAaVUeTsPJH6glV7X6dbWhSXqmLUXees/aK/uY3GCu9Pih6KxQ4XHb22iZoGHipbf+R/UMsO5ZIPWHJFImAk6hJ8BVpJEaxv3HpWjpNYyol54IuIzluGUb2FAoStGuf2yKgOjOkyEukrSvHFtqIldXy2oWN1Kh2z4oD4AjhOdASJYMVqXglzy6i3dcahik8ig9ElLzu8Qdk7NISsmLR9CqfYrKQMzD+6IqMICDykgusMszE4lFfwxP9GJBEzOhQRduRUxQS7ZoDVu3vAmaJ9EacN/hsaiwaC0idx5YRWQVzErn3dTeYKJ67KgH8KCeTicmGSxijtP1PPI9VzXglsfc56QYRA+A86okgNPPuKjrAXZztYwmSbbJenQvdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(36756003)(41300700001)(2906002)(40460700003)(5660300002)(86362001)(2616005)(40480700001)(1076003)(26005)(82740400003)(426003)(336012)(6666004)(478600001)(81166007)(356005)(47076005)(83380400001)(36860700001)(8676002)(8936002)(4326008)(6916009)(70206006)(70586007)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 15:24:13.5704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd749fde-1dfc-4a07-1f5e-08dbf66f6734
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8422
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
Cc: Xiaogang Chen <Xiaogang.Chen@amd.com>, Philip.Yang@amd.com,
 felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

v2:
-not need calculate vram page number for new registered svm range, only
do it for split vram pages.

v3:
-use dma address to calculate vram page number of split svm range;
use migrate_vma from hmm to calculate page number that migrate to vram.

SVM uses hmm page walk to valid buffer before map to gpu vm. After have partial
migration/mapping do validation on same vm range as migration/map do instead of
whole svm range that can be very large. This change is expected to improve svm
code performance.

Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 35 ++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 72 ++++++++++++------------
 2 files changed, 48 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index b854cbf06dce..34376184c37c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -260,19 +260,6 @@ static void svm_migrate_put_sys_page(unsigned long addr)
 	put_page(page);
 }
 
-static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
-{
-	unsigned long cpages = 0;
-	unsigned long i;
-
-	for (i = 0; i < migrate->npages; i++) {
-		if (migrate->src[i] & MIGRATE_PFN_VALID &&
-		    migrate->src[i] & MIGRATE_PFN_MIGRATE)
-			cpages++;
-	}
-	return cpages;
-}
-
 static unsigned long svm_migrate_unsuccessful_pages(struct migrate_vma *migrate)
 {
 	unsigned long upages = 0;
@@ -402,6 +389,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate = { 0 };
 	unsigned long cpages = 0;
+	unsigned long mpages = 0;
 	dma_addr_t *scratch;
 	void *buf;
 	int r = -ENOMEM;
@@ -450,12 +438,13 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	r = svm_migrate_copy_to_vram(node, prange, &migrate, &mfence, scratch, ttm_res_offset);
 	migrate_vma_pages(&migrate);
 
-	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
-		svm_migrate_successful_pages(&migrate), cpages, migrate.npages);
-
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
 
+	mpages = cpages - svm_migrate_unsuccessful_pages(&migrate);
+	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
+	        mpages, cpages, migrate.npages);
+
 	kfd_smi_event_migration_end(node, p->lead_thread->pid,
 				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
 				    0, node->id, trigger);
@@ -465,12 +454,12 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 out_free:
 	kvfree(buf);
 out:
-	if (!r && cpages) {
+	if (!r && mpages) {
 		pdd = svm_range_get_pdd_by_node(prange, node);
 		if (pdd)
-			WRITE_ONCE(pdd->page_in, pdd->page_in + cpages);
+			WRITE_ONCE(pdd->page_in, pdd->page_in + mpages);
 
-		return cpages;
+		return mpages;
 	}
 	return r;
 }
@@ -498,7 +487,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	struct vm_area_struct *vma;
 	uint64_t ttm_res_offset;
 	struct kfd_node *node;
-	unsigned long cpages = 0;
+	unsigned long mpages = 0;
 	long r = 0;
 
 	if (start_mgr < prange->start || last_mgr > prange->last) {
@@ -540,15 +529,15 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 			pr_debug("failed %ld to migrate\n", r);
 			break;
 		} else {
-			cpages += r;
+			mpages += r;
 		}
 		ttm_res_offset += next - addr;
 		addr = next;
 	}
 
-	if (cpages) {
+	if (mpages) {
 		prange->actual_loc = best_loc;
-		prange->vram_pages = prange->vram_pages + cpages;
+		prange->vram_pages = prange->vram_pages + mpages;
 	} else if (!prange->actual_loc) {
 		/* if no page migrated and all pages from prange are at
 		 * sys ram drop svm_bo got from svm_range_vram_node_new
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 2834fb351818..8d012ca82cd6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -158,13 +158,12 @@ svm_is_valid_dma_mapping_addr(struct device *dev, dma_addr_t dma_addr)
 static int
 svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		      unsigned long offset, unsigned long npages,
-		      unsigned long *hmm_pfns, uint32_t gpuidx, uint64_t *vram_pages)
+		      unsigned long *hmm_pfns, uint32_t gpuidx)
 {
 	enum dma_data_direction dir = DMA_BIDIRECTIONAL;
 	dma_addr_t *addr = prange->dma_addr[gpuidx];
 	struct device *dev = adev->dev;
 	struct page *page;
-	uint64_t vram_pages_dev;
 	int i, r;
 
 	if (!addr) {
@@ -174,7 +173,6 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		prange->dma_addr[gpuidx] = addr;
 	}
 
-	vram_pages_dev = 0;
 	addr += offset;
 	for (i = 0; i < npages; i++) {
 		if (svm_is_valid_dma_mapping_addr(dev, addr[i]))
@@ -184,7 +182,6 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		if (is_zone_device_page(page)) {
 			struct amdgpu_device *bo_adev = prange->svm_bo->node->adev;
 
-			vram_pages_dev++;
 			addr[i] = (hmm_pfns[i] << PAGE_SHIFT) +
 				   bo_adev->vm_manager.vram_base_offset -
 				   bo_adev->kfd.pgmap.range.start;
@@ -201,14 +198,14 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		pr_debug_ratelimited("dma mapping 0x%llx for page addr 0x%lx\n",
 				     addr[i] >> PAGE_SHIFT, page_to_pfn(page));
 	}
-	*vram_pages = vram_pages_dev;
+
 	return 0;
 }
 
 static int
 svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
 		  unsigned long offset, unsigned long npages,
-		  unsigned long *hmm_pfns, uint64_t *vram_pages)
+		  unsigned long *hmm_pfns)
 {
 	struct kfd_process *p;
 	uint32_t gpuidx;
@@ -227,7 +224,7 @@ svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
 		}
 
 		r = svm_range_dma_map_dev(pdd->dev->adev, prange, offset, npages,
-					  hmm_pfns, gpuidx, vram_pages);
+					  hmm_pfns, gpuidx);
 		if (r)
 			break;
 	}
@@ -982,11 +979,6 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
 	new->svm_bo = svm_range_bo_ref(old->svm_bo);
 	new->ttm_res = old->ttm_res;
 
-	/* set new's vram_pages as old range's now, the acurate vram_pages
-	 * will be updated during mapping
-	 */
-	new->vram_pages = min(old->vram_pages, new->npages);
-
 	spin_lock(&new->svm_bo->list_lock);
 	list_add(&new->svm_bo_list, &new->svm_bo->range_list);
 	spin_unlock(&new->svm_bo->list_lock);
@@ -1049,6 +1041,28 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
 	return 0;
 }
 
+static int
+svm_range_vram_pages(struct svm_range *prange)
+{
+	int i, j;
+	dma_addr_t *addr;
+	uint64_t vram_pages = 0;
+
+	for (i = 0; i < MAX_GPU_INSTANCE; i++) {
+		vram_pages = 0;
+		if (!prange->dma_addr[i])
+			continue;
+
+		addr = prange->dma_addr[i];
+		for (j = 0; j < prange->npages; j++) {
+			if (addr[j]&SVM_RANGE_VRAM_DOMAIN)
+				vram_pages++;
+		}
+	}
+
+	return vram_pages;
+}
+
 /**
  * svm_range_split - split a range in 2 ranges
  *
@@ -1100,6 +1114,10 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
 			 r, old_start, old_last, start, last);
 		svm_range_free(*new, false);
 		*new = NULL;
+	} else if (prange->actual_loc && prange->ttm_res && *new) {
+		/* calculate *new vram_pages and reduce from prange vram_pages */
+		(*new)->vram_pages = svm_range_vram_pages(*new);
+		prange->vram_pages -= (*new)->vram_pages;
 	}
 
 	return r;
@@ -1109,7 +1127,7 @@ static int
 svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
 		     struct list_head *insert_list, struct list_head *remap_list)
 {
-	struct svm_range *tail;
+	struct svm_range *tail = NULL;
 	int r = svm_range_split(prange, prange->start, new_last, &tail);
 
 	if (!r) {
@@ -1124,7 +1142,7 @@ static int
 svm_range_split_head(struct svm_range *prange, uint64_t new_start,
 		     struct list_head *insert_list, struct list_head *remap_list)
 {
-	struct svm_range *head;
+	struct svm_range *head = NULL;
 	int r = svm_range_split(prange, new_start, prange->last, &head);
 
 	if (!r) {
@@ -1573,7 +1591,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	struct svm_validate_context *ctx;
 	unsigned long start, end, addr;
 	struct kfd_process *p;
-	uint64_t vram_pages;
 	void *owner;
 	int32_t idx;
 	int r = 0;
@@ -1642,15 +1659,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 	}
 
-	vram_pages = 0;
-	start = prange->start << PAGE_SHIFT;
-	end = (prange->last + 1) << PAGE_SHIFT;
+	start = map_start << PAGE_SHIFT;
+	end = (map_last + 1) << PAGE_SHIFT;
 	for (addr = start; !r && addr < end; ) {
 		struct hmm_range *hmm_range;
 		unsigned long map_start_vma;
 		unsigned long map_last_vma;
 		struct vm_area_struct *vma;
-		uint64_t vram_pages_vma;
 		unsigned long next = 0;
 		unsigned long offset;
 		unsigned long npages;
@@ -1677,13 +1692,11 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 
 		if (!r) {
-			offset = (addr - start) >> PAGE_SHIFT;
+			offset = (addr - (prange->start << PAGE_SHIFT)) >> PAGE_SHIFT;
 			r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
-					      hmm_range->hmm_pfns, &vram_pages_vma);
+					      hmm_range->hmm_pfns);
 			if (r)
 				pr_debug("failed %d to dma map range\n", r);
-			else
-				vram_pages += vram_pages_vma;
 		}
 
 		svm_range_lock(prange);
@@ -1716,19 +1729,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		addr = next;
 	}
 
-	if (addr == end) {
-		prange->vram_pages = vram_pages;
-
-		/* if prange does not include any vram page and it
-		 * has not released svm_bo drop its svm_bo reference
-		 * and set its actaul_loc to sys ram
-		 */
-		if (!vram_pages && prange->ttm_res) {
-			prange->actual_loc = 0;
-			svm_range_vram_node_free(prange);
-		}
-	}
-
 	svm_range_unreserve_bos(ctx);
 	if (!r)
 		prange->validate_timestamp = ktime_get_boottime();
-- 
2.25.1

