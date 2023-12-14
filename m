Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B72C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 00:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93F2310E894;
	Thu, 14 Dec 2023 00:24:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C29B010E894
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 00:24:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVldwEe0AtGd9koPsJ3qDMp0/wOZV7buJUV7fnrEwNvzRVpZSEusxMUh8AT9F9Rwvc7UD2/TPHqHc82f7canM4I6Nei3VX2IWGZjMp+9zYe2XDDDpjUoEgZpfQ5tjprxiDSy2yBqVqQQQeKpHJWQfwwbQaASadV28eUFpYC5cvI0xnVsxHA883P/NreIMg5AsByqsmzeZqnatzkMp8FIficp12TZDs62KdjBuTdCI5Ryuy9nzSe8Lalj5I95ZFe3nqtD1ayoO3L8vROi6a5EcSGWT7x2l5QMcRQex46buj4bKV1p6btKqBHKcKiBhKaRgnOPH5bPeNh7p9+rn8BqYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPxdERs63F7CbSQbj8Ox6VMDhWyKWG82whfqEJZwjs8=;
 b=NIlkcUzzH03PUbYMkQcW1z0p0G9kGMykwB0zN7QGKlkfSfZFYLtN8wAOEeBQbwbpum93QNHgm7evm3SW5ntudX1jV5PFcInnnYe16lvvBKfkkgDWlhVGBsVayxa+r3nKJZMp3S6oTlAa9xkYg5xGfqbOC04Bw9/+NX7J9QE3Lq30uMHi+ZJZrlqgsomZ6+dITyymhk99ve0f6mNP6NxDgAaiS9q57C6kSIW2BglNaUkY2nXzHjuPgqjwizbXmrlvFg9yiE5EgVE2d9P6MTcI/lzy1oKnyfupG77zByeQIa2a97hzdxPjYPnV4JYzGtLjSpNjWNcrHW1tRlmfzq22CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPxdERs63F7CbSQbj8Ox6VMDhWyKWG82whfqEJZwjs8=;
 b=pIRO/6C+IlCE9Nzc+rOjVco8ta1Uq7h5RiotnFPKCmk8Mun818J8Y/uQzpYnuuQnSTomNM32h2rET5G6FtfusFx2sj3Atuf5FAwWGadbzv5vA+NLe8aP0RWaMVuMulYKLg7WbmIPb9eFFVtpFAvBVepHLTN/Clr0vxp7W9ExS7g=
Received: from CYXPR02CA0015.namprd02.prod.outlook.com (2603:10b6:930:cf::16)
 by MN0PR12MB6127.namprd12.prod.outlook.com (2603:10b6:208:3c5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Thu, 14 Dec
 2023 00:24:37 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:cf:cafe::5e) by CYXPR02CA0015.outlook.office365.com
 (2603:10b6:930:cf::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Thu, 14 Dec 2023 00:24:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 00:24:37 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 18:24:36 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 13 Dec
 2023 16:24:36 -0800
Received: from Xiaogang-ROCM-Dev.attlocal.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Wed, 13 Dec 2023 18:24:31 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4] drm/amdkfd: Use partial hmm page walk during buffer
 validation in SVM
Date: Wed, 13 Dec 2023 18:24:13 -0600
Message-ID: <20231214002413.8485-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|MN0PR12MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: 311a1144-c186-4300-d7cf-08dbfc3b0e23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iAErgn/0W6/ZOILU2l+WjjHKzfqcldEGrmmo1oClrbVqCVb8lA/OR1NoQMSQF0ZbEKUQT4c2nBjOchUARFh7pNrKsSrzFvXUedkxjpTdDJclp6/aLxUOedvQSB9p21kRWMk/QO0Tg76NrvDoHEU6WIdIK+W6Kz+ZAZ2sUgAongKlW9NHjn7394rxJXFCG659KmVM30fMHueYvGb3bPZ9O8V+i/YjA+LKBWKYYW5Ewf0iYqnkMJCR6747aAIlVlXK2B2nPz7u7nVTgtV1mByduyh1YYICTPazlsVhp80l9eHLegMSZErdzNqeTqi76e/qHXycX/1NGwMG2klDhlelor4bj0DVbuhGFx/jiTNteXAzPOed0Sb6QBFXzPVZiMgmWY2A014Uj07nqKZwVX9pWZezsOH5RgeQDGeIC87n2lRjDzHsE642bZtnlBEyeyWyTsWSosUzIN5RVPqhcTszy3SO9AP3l+q3YulsvhXi760XF+wvoJWi86QfGLhZk+cDKnctNmKgJurpbhpTWJbvo7ldblJPTBt5hCVF73ki3ZiiKJbOv9xtONINqjipV+aAkUkSoVn26yS1a7+8AWnMhKF54oWi3sAMvmAjzG401xWKJi9k68UaEoEk2QJqrD0aH5vOhLw15OdDDiNUmsabgO0lr/CffGc7kaueJn95er11vEwylDFwam8LrV1eNrL1C40kZt8zPzkRMvee3+b/5uj1/aur9cDjxfJRbguvkcBKLkUSlvJVwA+vsYYF08UHxanylGateQOrB0XXBVuRvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799012)(36840700001)(40470700004)(46966006)(41300700001)(36756003)(30864003)(5660300002)(2906002)(356005)(47076005)(82740400003)(36860700001)(40480700001)(83380400001)(6666004)(2616005)(1076003)(478600001)(26005)(8936002)(8676002)(4326008)(40460700003)(336012)(426003)(316002)(54906003)(70586007)(70206006)(81166007)(86362001)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 00:24:37.2463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 311a1144-c186-4300-d7cf-08dbfc3b0e23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6127
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

v4:
-combine calculating of vram page number of split svm range and page dma
address copy in same loop if original svm range includes vram pages.

SVM uses hmm page walk to valid buffer before map to gpu vm. After have partial
migration/mapping do validation on same vm range as migration/map do instead of
whole svm range that can be very large. This change is expected to improve svm
code performance.

Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 35 ++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 79 +++++++++++-------------
 2 files changed, 48 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index b854cbf06dce..3fb8e59acfbf 100644
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
+			 mpages, cpages, migrate.npages);
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
index 2834fb351818..61e363e388f8 100644
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
@@ -885,14 +882,28 @@ static void svm_range_debug_dump(struct svm_range_list *svms)
 
 static void *
 svm_range_copy_array(void *psrc, size_t size, uint64_t num_elements,
-		     uint64_t offset)
+		     uint64_t offset, uint64_t *vram_pages)
 {
+	unsigned char *src = (unsigned char *)psrc + offset;
 	unsigned char *dst;
+	dma_addr_t *temp;
 
 	dst = kvmalloc_array(num_elements, size, GFP_KERNEL);
 	if (!dst)
 		return NULL;
-	memcpy(dst, (unsigned char *)psrc + offset, num_elements * size);
+
+	if (!vram_pages) {
+		memcpy(dst, src, num_elements * size);
+		return (void *)dst;
+	}
+
+	*vram_pages = 0;
+	for (int i = 0; i < num_elements; i++) {
+		temp = (dma_addr_t *)(dst + i*size);
+		*temp = *(dma_addr_t *)(src + i*size);
+		if (*temp&SVM_RANGE_VRAM_DOMAIN)
+			(*vram_pages)++;
+	}
 
 	return (void *)dst;
 }
@@ -906,7 +917,7 @@ svm_range_copy_dma_addrs(struct svm_range *dst, struct svm_range *src)
 		if (!src->dma_addr[i])
 			continue;
 		dst->dma_addr[i] = svm_range_copy_array(src->dma_addr[i],
-					sizeof(*src->dma_addr[i]), src->npages, 0);
+					sizeof(*src->dma_addr[i]), src->npages, 0, NULL);
 		if (!dst->dma_addr[i])
 			return -ENOMEM;
 	}
@@ -917,7 +928,7 @@ svm_range_copy_dma_addrs(struct svm_range *dst, struct svm_range *src)
 static int
 svm_range_split_array(void *ppnew, void *ppold, size_t size,
 		      uint64_t old_start, uint64_t old_n,
-		      uint64_t new_start, uint64_t new_n)
+		      uint64_t new_start, uint64_t new_n, uint64_t *new_vram_pages)
 {
 	unsigned char *new, *old, *pold;
 	uint64_t d;
@@ -929,11 +940,12 @@ svm_range_split_array(void *ppnew, void *ppold, size_t size,
 		return 0;
 
 	d = (new_start - old_start) * size;
-	new = svm_range_copy_array(pold, size, new_n, d);
+	/* get dma addr array for new range and calculte its vram page number */
+	new = svm_range_copy_array(pold, size, new_n, d, new_vram_pages);
 	if (!new)
 		return -ENOMEM;
 	d = (new_start == old_start) ? new_n * size : 0;
-	old = svm_range_copy_array(pold, size, old_n, d);
+	old = svm_range_copy_array(pold, size, old_n, d, NULL);
 	if (!old) {
 		kvfree(new);
 		return -ENOMEM;
@@ -955,11 +967,15 @@ svm_range_split_pages(struct svm_range *new, struct svm_range *old,
 	for (i = 0; i < MAX_GPU_INSTANCE; i++) {
 		r = svm_range_split_array(&new->dma_addr[i], &old->dma_addr[i],
 					  sizeof(*old->dma_addr[i]), old->start,
-					  npages, new->start, new->npages);
+					  npages, new->start, new->npages,
+					  ((old->actual_loc && old->ttm_res)) ?
+					  &new->vram_pages : NULL);
 		if (r)
 			return r;
 	}
 
+	old->vram_pages -= new->vram_pages;
+
 	return 0;
 }
 
@@ -982,11 +998,6 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
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
@@ -1109,7 +1120,7 @@ static int
 svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
 		     struct list_head *insert_list, struct list_head *remap_list)
 {
-	struct svm_range *tail;
+	struct svm_range *tail = NULL;
 	int r = svm_range_split(prange, prange->start, new_last, &tail);
 
 	if (!r) {
@@ -1124,7 +1135,7 @@ static int
 svm_range_split_head(struct svm_range *prange, uint64_t new_start,
 		     struct list_head *insert_list, struct list_head *remap_list)
 {
-	struct svm_range *head;
+	struct svm_range *head = NULL;
 	int r = svm_range_split(prange, new_start, prange->last, &head);
 
 	if (!r) {
@@ -1573,7 +1584,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	struct svm_validate_context *ctx;
 	unsigned long start, end, addr;
 	struct kfd_process *p;
-	uint64_t vram_pages;
 	void *owner;
 	int32_t idx;
 	int r = 0;
@@ -1642,15 +1652,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
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
@@ -1677,13 +1685,11 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
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
@@ -1716,19 +1722,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
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

