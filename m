Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01D5C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 14:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81DC3600CC
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 14:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 81DC3600CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3021A6E999;
	Thu, 19 Aug 2021 14:57:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DE646E990
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 14:57:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjKeq7mU8DmvBYVjLo4AOWjJdnlJul2/hWd50/qBGpGhEXpN8Ka/x6S0L/rRox95CcBZRROhpYcJA4u3icW2cPCDSWYDhVCHQgDAalDEMZpm9131N+cUwlOX3Rg7RL1hcln0JaoUggHnk5yXJ5dvTOFqa8zoA/LJOwPtsFwxNS/staLInJvj+NoWFGB9wy3PYQAX1nlhd7g7jaQ4kFPL5X1ymemKqlKYXUTjcwE5w0595aBK1+xSOi8/744r+FJfGMLCx0NRaIHgjssazLp4VEG0cvBXUXPQEXQo3nIX5n6zR2SRYTnguvM2aqlFNsU73Z/pQcejFyZ+9G7hwqk59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3kJe6CmWZjtovPPZ6L2PwIwzVAik22wx16n9vOw96c=;
 b=dKYKf33qo59pTcowd2AEkM+PKUl8/hZKPsvmltfO6G/z59qBTJHvp+40jHjj98OTMW0nf3vBJN5j4/I0UZkglD2jOkO4ZPt/04DJE31tH1/87gHQbheSMR8C/Avy1xCVM8YT7pgO8fOzE29TiNhpx9srpuJKb2biSBnQ8eS4lsaiC+RbwtESC+nnSqSNGuIJ6WfziXGmH3+Ghi0zqhEXyFZoog9azv4AJhN4ZhmkV194LL0dadcsyexDGP1bPj6qsWjmbhn+PEGU0EFQsTAXR8aoC0onLe/0A/9d1flHHUiMwFuqWauFO6HNrVeUAaDIgu1ie3h3r25l9H56fs0B1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3kJe6CmWZjtovPPZ6L2PwIwzVAik22wx16n9vOw96c=;
 b=T4UjyssgPTsqaAHIu5WLqOQS9PYzMCnT/R1nIoQu9IHIp7vqODOMy9ESfU8nk9K7E3yrG+b1V+NbaSPM85+pCGEhgjEpbHmqNrx44W1x6+QsUFcPxZcKr5SzuoR1yemTFIiMMC6BSJlEqqU2LzTAbRg2kFPlSnEOOtlgnpnseYc=
Received: from DM5PR07CA0055.namprd07.prod.outlook.com (2603:10b6:4:ad::20) by
 BL0PR12MB4993.namprd12.prod.outlook.com (2603:10b6:208:17e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Thu, 19 Aug 2021 14:57:18 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::4b) by DM5PR07CA0055.outlook.office365.com
 (2603:10b6:4:ad::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Thu, 19 Aug 2021 14:57:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 14:57:18 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 19 Aug
 2021 09:57:17 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: map SVM range with correct access permission
Date: Thu, 19 Aug 2021 10:56:58 -0400
Message-ID: <20210819145658.2254-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210819145658.2254-1-Philip.Yang@amd.com>
References: <20210819145658.2254-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6e5d100-26ba-4e45-499d-08d96321a3bc
X-MS-TrafficTypeDiagnostic: BL0PR12MB4993:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4993B3508068CDCADD264E9CE6C09@BL0PR12MB4993.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hBwuh9Xn7Olfe/4vNx8/znDL/kcLWaMjRCtceRZuMMGNPFB+0WBnqLji737QprkBxXMvrnNXca3gaPinECDV7lcXlnF/evMwHhrXH35SdpSZxHm62nNkyWBHX2gjTku4fvn4V5T+CgH43LHvNDe/NNj2sAMXNRErabBYt1lAPNOoKmZHcaIJM8JeMA3VglcaH7Altm+gxlif0Y57ijMXiffN6crjumaaTwUdb4XI6EuDvUnG7ugkTpoJUZl64bB0L6+45HRK/9I4Ua0ojzxS+jAOv4Ecz0tzOj2ReLypiOyfCB4vAB07fxZacFhz+HDvQWlKrq5Mvgoyeb6BVq/RQNrfe4iD7TX9Mjx9E6Dqxa/SL8uoI8MHSSkhnyrn1wXHQEhBpqD5FseUwrx4HTcZslb3BS9xen9DzvYcmo9E46M+pZADtc3v4KzSy6ZbeAE/JkITQ6pleqGCdyFQ9cG63FPJiZjJUW0n7UgCNlEWqXC1mvRYnKWm3hPV1/kQfdnFZkSJuYisDt1FiIB6NFvdDMVF4k7BtoexFjZ9cKVmmnbPZ7wtSTxDUN6/8fUjcDEC6qhac4Cx+jCxwOTBNWchzhVDg4x1vmoUmOWUctE/oWkmIi9yaChCwM5p7jgyaSzehZnYx/x3SDYuNwD4R1o/y7w0X60nLlhAyvuZW3RbSsWpcHC09V4HqVtSjPkI3hjAX9G/GZZXuxKWyQf1GVVXpK4QSGOBqUYixO0J/2q+zTlDUI1XaMcCgwcmv/yztUIxEYjcEObbJ030zk55CYqy0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(36840700001)(46966006)(5660300002)(70586007)(70206006)(336012)(36756003)(6666004)(36860700001)(426003)(8936002)(316002)(2906002)(186003)(16526019)(82740400003)(4326008)(83380400001)(86362001)(478600001)(7696005)(26005)(47076005)(356005)(82310400003)(81166007)(34020700004)(6916009)(1076003)(2616005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 14:57:18.0852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e5d100-26ba-4e45-499d-08d96321a3bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4993
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

Restore retry fault or prefetch range, or restore svm range after
eviction to map range to GPU with correct read or write access
permission.

Range may includes multiple VMAs, update GPU page table with offset of
prange, number of pages for each VMA according VMA access permission.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 131 +++++++++++++++++----------
 1 file changed, 84 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index cf1009bb532a..94612581963f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -120,6 +120,7 @@ static void svm_range_remove_notifier(struct svm_range *prange)
 
 static int
 svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
+		      unsigned long offset, unsigned long npages,
 		      unsigned long *hmm_pfns, uint32_t gpuidx)
 {
 	enum dma_data_direction dir = DMA_BIDIRECTIONAL;
@@ -136,7 +137,8 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		prange->dma_addr[gpuidx] = addr;
 	}
 
-	for (i = 0; i < prange->npages; i++) {
+	addr += offset;
+	for (i = 0; i < npages; i++) {
 		if (WARN_ONCE(addr[i] && !dma_mapping_error(dev, addr[i]),
 			      "leaking dma mapping\n"))
 			dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
@@ -167,6 +169,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 
 static int
 svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
+		  unsigned long offset, unsigned long npages,
 		  unsigned long *hmm_pfns)
 {
 	struct kfd_process *p;
@@ -187,7 +190,8 @@ svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
 		}
 		adev = (struct amdgpu_device *)pdd->dev->kgd;
 
-		r = svm_range_dma_map_dev(adev, prange, hmm_pfns, gpuidx);
+		r = svm_range_dma_map_dev(adev, prange, offset, npages,
+					  hmm_pfns, gpuidx);
 		if (r)
 			break;
 	}
@@ -1088,11 +1092,6 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange,
 	pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
 
 	pte_flags |= amdgpu_gem_va_map_flags(adev, mapping_flags);
-
-	pr_debug("svms 0x%p [0x%lx 0x%lx] vram %d PTE 0x%llx mapping 0x%x\n",
-		 prange->svms, prange->start, prange->last,
-		 (domain == SVM_RANGE_VRAM_DOMAIN) ? 1:0, pte_flags, mapping_flags);
-
 	return pte_flags;
 }
 
@@ -1156,7 +1155,8 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 
 static int
 svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		     struct svm_range *prange, dma_addr_t *dma_addr,
+		     struct svm_range *prange, unsigned long offset,
+		     unsigned long npages, bool readonly, dma_addr_t *dma_addr,
 		     struct amdgpu_device *bo_adev, struct dma_fence **fence)
 {
 	struct amdgpu_bo_va bo_va;
@@ -1167,14 +1167,15 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	int r = 0;
 	int64_t i;
 
-	pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, prange->start,
-		 prange->last);
+	last_start = prange->start + offset;
+
+	pr_debug("svms 0x%p [0x%lx 0x%lx] readonly %d\n", prange->svms,
+		 last_start, last_start + npages - 1, readonly);
 
 	if (prange->svm_bo && prange->ttm_res)
 		bo_va.is_xgmi = amdgpu_xgmi_same_hive(adev, bo_adev);
 
-	last_start = prange->start;
-	for (i = 0; i < prange->npages; i++) {
+	for (i = offset; i < offset + npages; i++) {
 		last_domain = dma_addr[i] & SVM_RANGE_VRAM_DOMAIN;
 		dma_addr[i] &= ~SVM_RANGE_VRAM_DOMAIN;
 		if ((prange->start + i) < prange->last &&
@@ -1183,13 +1184,21 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 		pr_debug("Mapping range [0x%lx 0x%llx] on domain: %s\n",
 			 last_start, prange->start + i, last_domain ? "GPU" : "CPU");
+
 		pte_flags = svm_range_get_pte_flags(adev, prange, last_domain);
-		r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, false, false, NULL,
-						last_start,
+		if (readonly)
+			pte_flags &= ~AMDGPU_PTE_WRITEABLE;
+
+		pr_debug("svms 0x%p map [0x%lx 0x%llx] vram %d PTE 0x%llx\n",
+			 prange->svms, last_start, prange->start + i,
+			 (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
+			 pte_flags);
+
+		r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, false, false,
+						NULL, last_start,
 						prange->start + i, pte_flags,
 						last_start - prange->start,
-						NULL,
-						dma_addr,
+						NULL, dma_addr,
 						&vm->last_update,
 						&table_freed);
 		if (r) {
@@ -1220,8 +1229,10 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	return r;
 }
 
-static int svm_range_map_to_gpus(struct svm_range *prange,
-				 unsigned long *bitmap, bool wait)
+static int
+svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
+		      unsigned long npages, bool readonly,
+		      unsigned long *bitmap, bool wait)
 {
 	struct kfd_process_device *pdd;
 	struct amdgpu_device *bo_adev;
@@ -1257,7 +1268,8 @@ static int svm_range_map_to_gpus(struct svm_range *prange,
 		}
 
 		r = svm_range_map_to_gpu(adev, drm_priv_to_vm(pdd->drm_priv),
-					 prange, prange->dma_addr[gpuidx],
+					 prange, offset, npages, readonly,
+					 prange->dma_addr[gpuidx],
 					 bo_adev, wait ? &fence : NULL);
 		if (r)
 			break;
@@ -1390,6 +1402,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 				      int32_t gpuidx, bool intr, bool wait)
 {
 	struct svm_validate_context ctx;
+	unsigned long start, end, addr;
 	struct hmm_range *hmm_range;
 	struct kfd_process *p;
 	void *owner;
@@ -1448,40 +1461,64 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			break;
 		}
 	}
-	r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
-				       prange->start << PAGE_SHIFT,
-				       prange->npages, &hmm_range,
-				       false, true, owner);
-	if (r) {
-		pr_debug("failed %d to get svm range pages\n", r);
-		goto unreserve_out;
-	}
 
-	r = svm_range_dma_map(prange, ctx.bitmap,
-			      hmm_range->hmm_pfns);
-	if (r) {
-		pr_debug("failed %d to dma map range\n", r);
-		goto unreserve_out;
-	}
+	start = prange->start << PAGE_SHIFT;
+	end = (prange->last + 1) << PAGE_SHIFT;
+	for (addr = start; addr < end && !r; ) {
+		struct vm_area_struct *vma;
+		unsigned long next;
+		unsigned long offset;
+		unsigned long npages;
+		bool readonly;
 
-	prange->validated_once = true;
+		vma = find_vma(mm, addr);
+		if (!vma || addr < vma->vm_start) {
+			r = -EINVAL;
+			goto unreserve_out;
+		}
+		readonly = !(vma->vm_flags & VM_WRITE);
 
-	svm_range_lock(prange);
-	if (amdgpu_hmm_range_get_pages_done(hmm_range)) {
-		pr_debug("hmm update the range, need validate again\n");
-		r = -EAGAIN;
-		goto unlock_out;
-	}
-	if (!list_empty(&prange->child_list)) {
-		pr_debug("range split by unmap in parallel, validate again\n");
-		r = -EAGAIN;
-		goto unlock_out;
-	}
+		next = min(vma->vm_end, end);
+		npages = (next - addr) / PAGE_SIZE;
+		r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
+					       addr, npages, &hmm_range,
+					       readonly, true, owner);
+		if (r) {
+			pr_debug("failed %d to get svm range pages\n", r);
+			goto unreserve_out;
+		}
 
-	r = svm_range_map_to_gpus(prange, ctx.bitmap, wait);
+		offset = (addr - start) / PAGE_SIZE;
+		r = svm_range_dma_map(prange, ctx.bitmap, offset, npages,
+				      hmm_range->hmm_pfns);
+		if (r) {
+			pr_debug("failed %d to dma map range\n", r);
+			goto unreserve_out;
+		}
+
+		svm_range_lock(prange);
+		if (amdgpu_hmm_range_get_pages_done(hmm_range)) {
+			pr_debug("hmm update the range, need validate again\n");
+			r = -EAGAIN;
+			goto unlock_out;
+		}
+		if (!list_empty(&prange->child_list)) {
+			pr_debug("range split by unmap in parallel, validate again\n");
+			r = -EAGAIN;
+			goto unlock_out;
+		}
+
+		r = svm_range_map_to_gpus(prange, offset, npages, readonly,
+					  ctx.bitmap, wait);
 
 unlock_out:
-	svm_range_unlock(prange);
+		svm_range_unlock(prange);
+
+		addr = next;
+	}
+
+	prange->validated_once = true;
+
 unreserve_out:
 	svm_range_unreserve_bos(&ctx);
 
-- 
2.17.1

