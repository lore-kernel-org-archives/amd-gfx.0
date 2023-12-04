Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6E9C4167B
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Dec 2023 20:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3013910E079;
	Mon,  4 Dec 2023 20:23:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50B9910E079
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Dec 2023 20:23:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7bYh3j/eqjUjEA69wOtZu5IMfiQe4gZQdZKQf0TWSS8uh4lVUSHbhC4a3m/wEGJZdSC8vDg3egH+rvHroEC66EY/aSIqXA5cDxcu95kIOCiF5A9SXPhoDezfku05HxljJ5YDYCuAXsDN7ds672fzI7r469d+aBre9TybGRzkBSh0oSK+oTS+Rnjwn4Lp46TVuIdx1mxmojFJbaBgvBMQZSqq9tc3gQ1jS1WZFBQswmpfR+O3uLNQFJJ/GeIWxCC8fw5gAVXQnObqf+qt5447F9ReCukYVtMnizMjYsYbe3UJ5WPaXkYNQ618wQE/S0bE0BbL3ILmpJiCJNdSgnwTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsUqSSRTKLTj/WOpBNZO+/Yi+pAV19YlveJg8Vkp7Q4=;
 b=juEjvS+52V4QNBvMo1YeLgn2F53A6mr1VwvAzncmfJkb1IdtlTpJ4MdXNaiidQ9ooSvi8qJb1vzDcDXuDaKyTzn5wY2ykKK54mzjJMUu2mlmCMjRpkWxCCwdc7P8RhXOWoO3wCR0B9ZRGqLCYiel8XRfFyU8fDsEpVvAxCaW5Ykaw+va24FKgRL+y4sp9TypSuW22RD5NT9NI3DzgIPJjzpCYC+dGLrzAEqcwmBsxUaogtZ2bVtUoreyoobWZNv+cV1dnIPbnAg/9/yS2mBKgYNHxOCF0Pf3/3VlWe5AGySVnYMXZ//60qDGG2vG1K4KNrlRNYrCbChvdPQ8Kd/XRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsUqSSRTKLTj/WOpBNZO+/Yi+pAV19YlveJg8Vkp7Q4=;
 b=PwPoMF6sNeF6pwRXDOtPC30jTDMUnDEuKKoMkemPHpzChrV35uKXQEZxPXgfZa+9MpRkMl7i63zlfXcUlTEtmyLBd2oIbAr+I4Ae1tfAxzrHrAamvnCMUNj7V76WudO5Axh2j3cXr5sWMMdbZ/Q+GgbqCEvzjO9v3jnhdOq4EIY=
Received: from DM6PR14CA0066.namprd14.prod.outlook.com (2603:10b6:5:18f::43)
 by DM4PR12MB8559.namprd12.prod.outlook.com (2603:10b6:8:17d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 20:23:12 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:5:18f:cafe::72) by DM6PR14CA0066.outlook.office365.com
 (2603:10b6:5:18f::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Mon, 4 Dec 2023 20:23:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 20:23:11 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 14:23:11 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 4 Dec
 2023 12:23:10 -0800
Received: from Xiaogang-ROCM-Dev.attlocal.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Mon, 4 Dec 2023 14:23:05 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: Use partial hmm page walk during buffer
 validation in SVM
Date: Mon, 4 Dec 2023 14:23:10 -0600
Message-ID: <20231204202310.23834-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|DM4PR12MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: 943b8220-ed5c-459d-6a04-08dbf506d669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ilsRe/+MnNCB97YfeeQcNI+v3yqTnu6OOtS6r7TlXG0MnGf6alGL6+ht+qH5MNp2xHJzY1t1eWgY1GZYrrAAbmbl9wr5RkeiM/F//21kO/K5WxFA3bfCuO1y7vbfVPExhytPY6LHSdJBxdTTG52JFn9uJIYaFjZtpf4tgMSKFUJ0GOIhe52P4x+O1kTX5LjkzDk+irx9DJxGewRFsJLjNuFol/LQpjkNr4t7h4qZCOtm4fzhVTY9/XMnym7XCHW/ZtLWlOCfYoh7AY8xrkMDtw0aZq5HNztTme2RTmttCVkfeH02yp3IUavePvl5CLdqUZzeNg5ymlfMsuZM7dBday8ak0KOjm25QyQvPLj9AjHSgSpufoPrxBQW6L9FKUlYI1vaUW0ieY6F++pkwVCLTksJMPx68VNT/GsuwkaVKgl8+RUnewUQdJ2JSm8IrIBSs/tnzCYin0VvwISPap+spy0RCAPSBDh/RrdsXFdzI6qczOQZT57OCuAnKV/P0m12BQPQqTb8bQ1f5I9kaZUwNPHjuvAV4fvSiHt/xIsHXz9iQURZrK+vHXXhrxtxi+sTsJBaqwn7Exk3jya/6njW5FuawJfTi8Kifu3L2GMVDM2HCNOEZ+TM/yzAYxIEBGw3/y3PutToeDX1Xw16D4TAqQ5IwVtzHTVNM9M5XsjmG/ulqKODL6zGNi5mR6D6B4xMEtFXIllD2+ki4QOTfWc1ZRNTb4zoMyyvx4yVkjdoKoxXrfxymDQyQjz+W2Q5bkrbPOBPUjITJ49cNZGIRP/pQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(186009)(82310400011)(1800799012)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(70586007)(54906003)(70206006)(316002)(6916009)(478600001)(40460700003)(6666004)(5660300002)(36756003)(41300700001)(2906002)(86362001)(4326008)(8936002)(8676002)(1076003)(2616005)(36860700001)(40480700001)(81166007)(47076005)(83380400001)(356005)(26005)(426003)(82740400003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 20:23:11.7804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 943b8220-ed5c-459d-6a04-08dbf506d669
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8559
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

SVM uses hmm page walk to valid buffer before map to gpu vm. After have partial
migration/mapping do validation on same vm range as migration/map do instead of
whole svm range that can be very large. This change is expected to improve svm
code performance.

Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 149 ++++++++++++++++++++-------
 1 file changed, 109 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 2834fb351818..2f14cd1a3416 100644
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
@@ -1107,9 +1099,9 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
 
 static int
 svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
-		     struct list_head *insert_list, struct list_head *remap_list)
+		     struct list_head *insert_list, struct list_head *remap_list,
+		     struct svm_range *tail)
 {
-	struct svm_range *tail;
 	int r = svm_range_split(prange, prange->start, new_last, &tail);
 
 	if (!r) {
@@ -1122,9 +1114,9 @@ svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
 
 static int
 svm_range_split_head(struct svm_range *prange, uint64_t new_start,
-		     struct list_head *insert_list, struct list_head *remap_list)
+		     struct list_head *insert_list, struct list_head *remap_list,
+		     struct svm_range *head)
 {
-	struct svm_range *head;
 	int r = svm_range_split(prange, new_start, prange->last, &head);
 
 	if (!r) {
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
@@ -2037,6 +2011,81 @@ svm_range_split_new(struct svm_range_list *svms, uint64_t start, uint64_t last,
 	return 0;
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
 /**
  * svm_range_add - add svm range and handle overlap
  * @p: the range add to this process svms
@@ -2109,6 +2158,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 			 * will change. Clone and split it, apply updates only
 			 * to the overlapping part
 			 */
+			struct svm_range *head, *tail;
 			struct svm_range *old = prange;
 
 			prange = svm_range_clone(old);
@@ -2123,18 +2173,37 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 
 			if (node->start < start) {
 				pr_debug("change old range start\n");
+				head = NULL;
 				r = svm_range_split_head(prange, start,
-							 insert_list, remap_list);
+							 insert_list, remap_list, head);
 				if (r)
 					goto out;
 			}
 			if (node->last > last) {
 				pr_debug("change old range last\n");
+				tail = NULL;
 				r = svm_range_split_tail(prange, last,
-							 insert_list, remap_list);
+							 insert_list, remap_list, tail);
 				if (r)
 					goto out;
 			}
+			/* cal each inserted svn pragen vram_pages */
+			if (prange->actual_loc && prange->ttm_res) {
+
+				if (head) {
+					r = svm_range_vram_pages(head);
+					if (r)
+						return r;
+					prange->vram_pages = prange->vram_pages  - head->vram_pages;
+				}
+
+				if (tail) {
+					r = svm_range_vram_pages(tail);
+					if (r)
+						return  r;
+					prange->vram_pages = prange->vram_pages - tail->vram_pages;
+				}
+			}
 		} else {
 			/* The node is contained within start..last,
 			 * just update it
-- 
2.25.1

