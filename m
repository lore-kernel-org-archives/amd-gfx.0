Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35459C43214
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 18:31:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D382C61040
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 18:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D382C61040
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85B8B6EADF;
	Fri, 20 Aug 2021 18:31:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD31A6EADE
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 18:31:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TF6TS6mKzIeV1060FFn3qASgk4iolOsyqRPfE1NPaKN+B/ohCLZ1Y0iSeFYjbwlN38SjATM2Ig36Jhm1dnoK5mqLqA2BYqJB6+g+nY7Jo94csAilOt3fx/8aZm4By3IsAn/PkEKAkvdhmnOHH0qL5+iS1bN7L7hDnC/PumreCt4wicMq0KA7x/zA2WFnO//inTawy3tZNS+8Ksdd1jdrRqCndBf1/k0RPn5mUpTKlhc6VG30BwGJkKs4LAtQAipPJWA3qFzvoKKrro7tbzt0tOUtvWC1tR0k/nwBkmiBRVqfW0BpAZEPSz87a4RYeC/TpdEH+DVx2BHqed0JcEvo+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpo0KJThgVqHQCkU17kGaCLJIjgCtSFsGEVgI6Gd0R8=;
 b=QcXCgyyLtewfE6BEGdI+3K3oIN0D7YiNsL60baAipo3Q0Di6LqyTwxgF8Ve6F7mVOmKTzGyNTzxXQBOSSBZQqbuBmk/XYqBkOfW1MuDZxUXhsQulG0qCnbDnXEHq3GerXnVFgM9WCENmuAeB8meokOoXdsV8c8qN1PFRP639+qlrQqM1W6/6ljdw2V1RdvfrBJijByj1Pjc9bTClyjJZLWXrpWDipjMJ64Rn2hwAl3xneWB/Ka83pj0gBpnjt+ahyfJrmGAn8MOgRCSLVBRaB4+gXIFEjKdN+Bpvjy6VPwiAa4Nb3AvNSVZC3gsSUVQSOzgjoPm8GrmG27+B/rWaIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpo0KJThgVqHQCkU17kGaCLJIjgCtSFsGEVgI6Gd0R8=;
 b=B5D4dZjHfMfO2erC2amT/At2Qjp4NIGejFu3jEGRLjKO02/oc5CX9HPG69rd26UPyM+CfWh5QCCZ/SA7xUkiA9udCNpu9qNVmMI6uMzNLeFjaIzr4sIPQV7yPmBvTF5vHqhKunPV6+NyNZRvlSXQ+sU3Ls44h1bZpcf4WyoeVIY=
Received: from BN0PR04CA0030.namprd04.prod.outlook.com (2603:10b6:408:ee::35)
 by BN8PR12MB3121.namprd12.prod.outlook.com (2603:10b6:408:40::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Fri, 20 Aug
 2021 18:31:41 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::e) by BN0PR04CA0030.outlook.office365.com
 (2603:10b6:408:ee::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Fri, 20 Aug 2021 18:31:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 18:31:41 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 20 Aug
 2021 13:31:38 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 2/2] drm/amdkfd: map SVM range with correct access
 permission
Date: Fri, 20 Aug 2021 14:31:14 -0400
Message-ID: <20210820183114.30710-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820183114.30710-1-Philip.Yang@amd.com>
References: <20210820183114.30710-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78ba55cb-50af-40de-eec0-08d96408c118
X-MS-TrafficTypeDiagnostic: BN8PR12MB3121:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3121351671F33406FE1CF09DE6C19@BN8PR12MB3121.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7172VwCk/CcUrVlcfI/8FngOW8WhH8lzeHr1hCMSzkn+sv/qKuOdSasjIwJJVMl9Ivncdea+R/038nXmSAm2nOGOdgB186BC5b/4/3zckXGfA2N3Y3blmqDMsCkL2RZ6uXFjlbf8g+EqAM8PKKjmU2tUko+NeBn2NgjlAMXZkIBNUn0coKY0eq4kfOOafOeqdJiLm7tbsyk/cUQFXBaFbmOhD5u6WeyrM85Y+nL5JeUBNgY0BQhEa+cHuV32z7usZY0j6hMMozP31zKpf8SCcl7v0u71c5OWDpX/+OCDETfHZ4oXssjMa9pTtqhWkCCZfcXZNkjPyMB0HpF4yaxR/Ade8M6sfX7HFqj+pGJ5WlUO3t01Xcn65+ZeBN7S0irgiUPi0TnD21GXpkX/M3kksp6RmJh4N+g11UwMgFKN73T8XqwBBCWaod4uGDN50HSYj+yxIEa+w84mfJMFnaKzpOrx8po0EDWdW2sLh9fFDijXAK5B7f49z9Glxp/aifWL+5+CDpOHO/5pRvbJC/L6dENfd/bMqE4oSf9uf2EMBdCyh6krG+WONSWjGExawU9/aYsEcm8PA2pDK+kBraDJPNd9Re6OVeWjX5G+IIvgseFglhHohaG+s5P6rsGYte7JXZ4+/k/E2QQWCkLP11zEvmkjivPi7B0mcCOWu3s2MLvJgSxU1tlHE4SdMNBVG696Bz04a2ukGILVH8PFCmoc6JKnFy1kZhxV3MDMw4oSlBRkAPOBBaVDOIlUj04IjTu5/J5ckL4tYYaP6dr1KWFJdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(36840700001)(46966006)(186003)(83380400001)(16526019)(7696005)(82740400003)(82310400003)(36756003)(47076005)(26005)(356005)(81166007)(8936002)(34020700004)(336012)(70586007)(70206006)(86362001)(4326008)(1076003)(5660300002)(8676002)(6916009)(426003)(6666004)(478600001)(2616005)(36860700001)(316002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 18:31:41.1358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ba55cb-50af-40de-eec0-08d96408c118
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3121
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
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 134 +++++++++++++++++----------
 1 file changed, 86 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b6d1268bc38f..8f9b5b53dab5 100644
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
@@ -1390,7 +1402,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 				      int32_t gpuidx, bool intr, bool wait)
 {
 	struct svm_validate_context ctx;
-	struct hmm_range *hmm_range;
+	unsigned long start, end, addr;
 	struct kfd_process *p;
 	void *owner;
 	int32_t idx;
@@ -1448,40 +1460,66 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
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
+		struct hmm_range *hmm_range;
+		struct vm_area_struct *vma;
+		unsigned long next;
+		unsigned long offset;
+		unsigned long npages;
+		bool readonly;
 
-	prange->validated_once = true;
+		vma = find_vma(mm, addr);
+		if (!vma || addr < vma->vm_start) {
+			r = -EFAULT;
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
+		npages = (next - addr) >> PAGE_SHIFT;
+		r = amdgpu_hmm_range_get_pages(&prange->notifier, mm, NULL,
+					       addr, npages, &hmm_range,
+					       readonly, true, owner);
+		if (r) {
+			pr_debug("failed %d to get svm range pages\n", r);
+			goto unreserve_out;
+		}
 
-	r = svm_range_map_to_gpus(prange, ctx.bitmap, wait);
+		offset = (addr - start) >> PAGE_SHIFT;
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
+	if (addr == end)
+		prange->validated_once = true;
+
 unreserve_out:
 	svm_range_unreserve_bos(&ctx);
 
-- 
2.17.1

