Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4C5C4167B
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Dec 2023 15:10:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F8CD10E1E7;
	Mon,  4 Dec 2023 15:10:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 211BD10E1E7
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Dec 2023 15:10:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqCVBGKFiFIDaQjTplrdAr5orZLHOd2iPtobQ9Iih9Yu3a5O4PhmzKkWFMZ8f6EFvfXi76ve/fLNdfq2+J5s6iqayrNfXmLb1fmhHzMVV8ZyAWS9Cr8DfLFwCxpvH4lFb3e+RYR6jYmrYrSi+7xx72lGsq7qm97W2+lZCQCyVAJbj/lN+/Fjcyq/f0sn4rnrV3KUQAVpUyliOJAKoFfsufK4wCf/Q2qzQF3BjwdEYZhLgD3ui/hSAAtLHtFqUsaItakxd9rCEwqW3aNqHBMLwwCw3VVFt6jdaEaAwJFR/u6lUdddHSuPI58NuQq+i5bsOtoFNYMuWNDG5huyvDvC6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxTQU7cmgQO9vHCJrHS/hS5phCPa5EVnCAJb8OkvycM=;
 b=gqxIy0ak8LpnKrt0fGTk6OcvZzg6CZLSZnxNsHibhOig16PC/UMWD6y5z0jaUAgcsbJCFdnmRgFHhLEMPs7pCQKoJJxUANXIk6gWyuFneOLmiFGj515AL1AVzs42WhrsB1LXwwxBiI+wbh5uZ/5mEUlE3b5Su4wRssvDeodpMj3c/0Pe2rp7BrquqCj1IEih/vmf+ZlGDgj+nHWHgeMwtHBYz5pNf18ViI+p9DYORpyy4IY92fOxotnuOGNW4GBjl1PUOfbb2acwd25lSUhY5gFasfx82AFtkxH422ZaDArZmNqZofegx5swxug+avC8lVwMJgKQZKFA/c53SbXxNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxTQU7cmgQO9vHCJrHS/hS5phCPa5EVnCAJb8OkvycM=;
 b=KyD5X1bnPssbp/WV76/z8A/dReLpScBSiUEu8iVUKB3Zfkdab8v/IaOqUqVQLG3uofkMXrrHdu78wv/qyLCN5V8Ut88v3BqaNcceH/hQd0oGEkZ4rOIH8kyXb9ntSuZLH81xfGMDVeaBqxtOlv6GJKmiKy/ASSo1tFkpudy6x7A=
Received: from SJ0PR05CA0036.namprd05.prod.outlook.com (2603:10b6:a03:33f::11)
 by SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 15:09:59 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::93) by SJ0PR05CA0036.outlook.office365.com
 (2603:10b6:a03:33f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.23 via Frontend
 Transport; Mon, 4 Dec 2023 15:09:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 15:09:58 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 09:09:57 -0600
Received: from Xiaogang-ROCM-Dev.attlocal.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Mon, 4 Dec 2023 09:09:52 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Use partial hmm page walk during buffer
 validation in SVM
Date: Mon, 4 Dec 2023 09:09:32 -0600
Message-ID: <20231204150932.117159-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|SA1PR12MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: eb3d6887-0a4a-429f-4026-08dbf4db14e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rYRUFs4AhQmaGjTE65xT58tFq4HeXdbF6KqcbrydlVZ5mDaBlZW/vvmTgXgnKRvddFiQDRgqjsrYcFRo6bW4JlLgQWMdKwfZMXx0qYWQ6AaFolsEUk5UJtvRbZh4Kon03nNYxFS7AzMIM3I+wmwvaPrWgJtIiX35hP39ZK24T+VcdA7PBJ2yqbcBwDTv+9OJUKJQqjR/8nV9CTDnhZ+ZaVrc1fIkQ0CauNfHRjAHl65bHu9IiLwVA/G2klgutMpnWs/jfj47RFbctRShchifjlXUgZuEzckdH9bXG8eQaNPrB6/WYM0bFh3XoG94+v6Ek0NhuiEkBKGldffvoLArHdz3saSCsjT0OIi+pfjkChH+/VJGVF8pY2uJB3oIj1dZIjF28sHcT1oDft5KjSKujkyf51XRl99A+G0Q8VQ8XEGJ0F431zsquh6nR8S2lTw8LQaEz2qZLliBtWi9HheT9CqzuHIqPUwI9pMxza+wPJuV+fby1FXLbar+D4CGtXssh7kUh3DaPjNjHf6EJ8ve9BWj16usECkVdi5I7N/Vn3wa95rlpKP3Xtjvj8uYn+e+/loJvCXbaK0jvlcWQWbeeek/+DyXVc6bB2odkcKknsEODDs1hxa0g4rLTFpP0nJtgWZnNtZV3H5pDGmv65ByBq6VaRGNZD4yEWEYh2KkZhHM4FNYyIGyUnSU5NuWjjXSdJLZMM4UwnfMul/R/d16aHO/31SyIc+fSchSgCMjNfleHJu3JAIFMGwgWMl6j6sTUqXh+vV5Ps9WJQwhA1XWoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(36860700001)(47076005)(81166007)(356005)(5660300002)(2906002)(82740400003)(83380400001)(6666004)(336012)(26005)(426003)(1076003)(2616005)(70586007)(478600001)(70206006)(36756003)(41300700001)(54906003)(6916009)(4326008)(316002)(8936002)(86362001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 15:09:58.6881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3d6887-0a4a-429f-4026-08dbf4db14e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798
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

SVM uses hmm page walk to valid buffer before map to gpu vm. After have partial
migration/mapping do validation on same vm range as migration/map do instead of
whole svm range that can be very large. This change is expected to improve svm
code performance.

Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 123 +++++++++++++++++++--------
 1 file changed, 89 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 2834fb351818..f670d5f6bcdf 100644
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
@@ -1573,7 +1565,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	struct svm_validate_context *ctx;
 	unsigned long start, end, addr;
 	struct kfd_process *p;
-	uint64_t vram_pages;
 	void *owner;
 	int32_t idx;
 	int r = 0;
@@ -1642,15 +1633,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
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
@@ -1677,13 +1666,11 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
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
@@ -1716,19 +1703,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
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
@@ -3516,6 +3490,81 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 	svm_range_bo_unref(svm_bo);
 }
 
+static int
+svm_range_vram_pages(struct svm_range *prange)
+{
+	unsigned long start, end, addr;
+	struct svm_range_list *svms;
+	struct kfd_process *p;
+	struct mm_struct *mm;
+	struct page *page;
+	int32_t gpuidx;
+	void *owner;
+	int r = 0;
+
+	prange->vram_pages = 0;
+	svms = prange->svms;
+	p = container_of(svms, struct kfd_process, svms);
+	mm = get_task_mm(p->lead_thread);
+	if (!mm) {
+		pr_debug("svms 0x%p process mm gone\n", svms);
+		return -ESRCH;
+	}
+
+	/* prange->actual_loc should not be 0 here */
+	gpuidx = kfd_process_gpuidx_from_gpuid(p, prange->actual_loc);
+	if (gpuidx < 0) {
+		pr_debug("failed get device by id 0x%x\n", prange->actual_loc);
+		return -EINVAL;
+	}
+	owner = kfd_svm_page_owner(p, gpuidx);
+
+	start = prange->start << PAGE_SHIFT;
+	end = (prange->last + 1) << PAGE_SHIFT;
+	for (addr = start; addr < end; ) {
+		struct hmm_range *hmm_range;
+		struct vm_area_struct *vma;
+		unsigned long next = 0;
+		unsigned long npages;
+		bool readonly;
+
+		vma = vma_lookup(mm, addr);
+		if (!vma) {
+			mmput(mm);
+			return -EFAULT;
+		}
+
+		readonly = !(vma->vm_flags & VM_WRITE);
+		next = min(vma->vm_end, end);
+		npages = (next - addr) >> PAGE_SHIFT;
+		r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
+					       readonly, owner, NULL,
+					       &hmm_range);
+		if (r) {
+			pr_debug("failed %d to get svm range pages\n", r);
+			mmput(mm);
+			return r;
+		}
+
+		for (int i = 0; i < npages; i++) {
+			page = hmm_pfn_to_page(hmm_range->hmm_pfns[i]);
+			if (is_zone_device_page(page))
+				prange->vram_pages++;
+		}
+
+		if (amdgpu_hmm_range_get_pages_done(hmm_range)) {
+			pr_debug("hmm update the range, need validate again\n");
+			mmput(mm);
+			return -EAGAIN;
+		}
+
+		addr = next;
+	}
+
+	mmput(mm);
+	return 0;
+}
+
 static int
 svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		   uint64_t start, uint64_t size, uint32_t nattr,
@@ -3567,6 +3616,12 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	list_for_each_entry_safe(prange, next, &insert_list, list) {
 		svm_range_add_to_svms(prange);
 		svm_range_add_notifier_locked(mm, prange);
+		/* cal each inserted pragen vram_pages */
+		if (prange->actual_loc && prange->ttm_res) {
+			r = svm_range_vram_pages(prange);
+			if (r)
+				return r;
+		}
 	}
 	list_for_each_entry(prange, &update_list, update_list) {
 		svm_range_apply_attrs(p, prange, nattr, attrs, &update_mapping);
-- 
2.25.1

