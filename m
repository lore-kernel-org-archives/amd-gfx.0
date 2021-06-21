Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF7DC49EA4
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 16:04:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6A2D60FEA
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 16:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A2D60FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D84606E200;
	Mon, 21 Jun 2021 16:04:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B86296E1F6
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 16:04:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZ4mgbJMrgdm2GHkRKn0WXzjis5HrjXXv1Vhd3cMidYSktFcDWVT1Phr211ll34GzAIV+qWYZLOh2ra39iqALdrijcQ+oOVYqI8ZKbCDih9nqSEZcBWNT+EokSVZTGb/NUWVHptWSfKiy5JxTAytApm0Jh54Q5ZfdUsBf2EQfOMFn6gWQz7GHhztszDKgvmU58csllK6gVexWu/UE9f1lpdwNqb2BCIKMNUPa9h9vs4DcAUn/oCCSrLL2E8QIgOdUUh094WiQdrgJoTAWnNLi9m5MykJzqmsGeFPA8tzhd3u56U0S38WMTiPoNOuu/RfNil4igjUxjnO4kAc0Nkuhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIgi0ExjbY5grQdtsfFNQVRSfclwLApOAYGerDRZsrs=;
 b=SVEZelkzstZ9wc20dLXFBxh/9BN9+CDa7NKKj/D9/YbPfgZZxa8eb8A+jpNBrqaDmEDkesV0CPJBcT/H8k1biDLpjPxoB1qT1xmfpZ/qqkzin/WUIAkBqnd62Exib17UJ6MypRAZKc2CFvHn725HZB9IT9Fh1g6bPpPsmWtYVa1ZFW894A7efpp4p1ISm6k/XWPqUV/LxSQ3FMUvCG/W7bE/zlYrRDlvLWfZUOqAnUWoSv+m+QYWx5htTyvnar81O2H4pAuSywu/Gn13u2KJ1WGSBXRt+SEDqLCPSY0sGJomzP8mJ0cv8sgityk+pJWPdSQWElZfOenN/w2Ya0EO8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIgi0ExjbY5grQdtsfFNQVRSfclwLApOAYGerDRZsrs=;
 b=sDtGiD0vE4YHUd7CBvpWU3+vf+DejPXi5oQwKZTO294BRw2UE8tbtAErwXPdDn3yYsodQEJtPtNXB/Fy5NpMHB4DkEVVVBsjyGz6CLg8SS/2O04P/dcl4l9awDbHd8gga1MqOR+4xFs3YswmbiirLJplMZBkIwqEHgJw0gwymvs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 16:04:39 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 16:04:39 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/10] drm/amdkfd: classify and map mixed svm range pages in
 GPU
Date: Mon, 21 Jun 2021 11:04:18 -0500
Message-Id: <20210621160423.3517-5-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621160423.3517-1-alex.sierra@amd.com>
References: <20210621160423.3517-1-alex.sierra@amd.com>
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SA9PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:806:21::28) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SA9PR13CA0023.namprd13.prod.outlook.com (2603:10b6:806:21::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.7 via Frontend Transport; Mon, 21 Jun 2021 16:04:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d97df590-a15c-41c8-6767-08d934ce460d
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:
X-Microsoft-Antispam-PRVS: <SN1PR12MB24478DCA696F14CC57D980D6FD0A9@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1g6ZOCj6Ty4C5QPWYDh/Z4NIL9VhySLNM1QRBjD9XUV3lN8gaW39Wamj9dM9XcAJcYGGFjBhFcLKVeCTSF+g5s2am2Q8j4wZixSg3gHUK04B3J6pLazJMWEbIDdYCqKXK1kmtOlePacb6vGfmMDs83caiH7wx/S6FyVI734itEgkk9bNRjTlDJFjId3ynje1koSDZGBO1ER9DWG1oLVc4XUNrUqmGfKg1XrLgHHYJUzlHTf5NQrNGX79a131XYnHNVk/21k/G8Ro7HsiT4UN4/ILMJLQY8HljA2KAsEIZJbroFjZ9hR3kz41AVUM9pLQFIig/Ad7uP1zdcITloEGaJ3hcSKlaB3F8fO2sCNDkvKXlxVcizZYNBb+whARKEJ0ybUNmw+BHDkrqf574Ch+R+lJF9XI5n5pbPr7H8NjWxUp6Tbl9Jy526gywjCf7No1oGAWxLDL1oWrHFsXbWNvAx2I3dkrFuZHmWZ2TZuAoXNLrN71j0YLslPaDbKB7CZR45yT8wqs+SmOrUuwGL0DTyHWzSfnoGLpfSrZjTolj3aRWgroqPVx1K/dtlwpfvAcC+Bzzz+zIUh/9rBEgCHKTC6ETJOrsY6VQiFTOYxiXW9APStnz+H5Hk0C87CPH7tMDbW9zqZX6DuK+SVGmEk0Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(26005)(38100700002)(86362001)(38350700002)(36756003)(956004)(8936002)(2616005)(16526019)(8676002)(186003)(5660300002)(44832011)(83380400001)(66946007)(6666004)(6916009)(6486002)(498600001)(66476007)(66556008)(52116002)(7696005)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iYK4wPsfc+H67oyIqt5fzCdCK4IMTHgBzExaC/SnRe+8Xny4/aFWu1AB7n7j?=
 =?us-ascii?Q?I+oyFBT11JjimVKg1VjVJ7Pwf1A7DxI1abUNbgHgrWUobUDXG3J0lg5artua?=
 =?us-ascii?Q?+UltI133TOYhNs0Ieb2KbrFfQKRSzqEhjIu55Wbkp8zSAwsZ7AQzu1X4842U?=
 =?us-ascii?Q?6UoAw6qgNUSSZrNUZUwdVzD0nSwH+t6SL+TUPRvkMvEp6GOX7L86N4HYXSeW?=
 =?us-ascii?Q?Vr6nDKb1t/1ncnOIHLznzsrFxnKbCGD65ZwkQGh4pU1i8VcCJCU+Cq7FY1Mp?=
 =?us-ascii?Q?ShYgYiV3eV1FTwIiha1Pmt/9azvNbvlbLo1S478GyQOX78oTKxT3O+ZGIgFz?=
 =?us-ascii?Q?aOn76wkRat18rgTPG7DWKCeydEwscJHeso5PSjToygL5SbY0unieWWWjabp2?=
 =?us-ascii?Q?X0rdd6OB9aEentqVCnDkI/Q5CCdJHzbeYvfREWtifSxNqtNUE/nPsnXKTy11?=
 =?us-ascii?Q?A9NZb7qjsNTU2D5OelH2P11CUZpZ8y4APAqfzRTsLHjGhk9r6hMvo9iEgdMx?=
 =?us-ascii?Q?1S4M3zjlmAi8rVRP6dKLf2xykqJHd4uLMG10HCWJ3CMY3Z7rHZ5+mSbEpaY0?=
 =?us-ascii?Q?wae2ExXncz0dSbCEUaILsSv5xn2pk39MBqe+bbLzb9kA9aC0/7cwjUPOzYiX?=
 =?us-ascii?Q?ZqcEiVQc7GIO06U/8peJRt1Mr0borxFuNtKIvdNy9GRRth17e9Z3lXE5GI58?=
 =?us-ascii?Q?GtU5yjNlmaEOsMZrJ5bp1rr8LJCm3liG4gxYIhVKRF7lHO6ODCoIDS+MXMVD?=
 =?us-ascii?Q?tKjQfHQMbfVgFPdOPQrK1chSQTYUs6QDGdT4MqiP+6aCDwRQqA+eo5y1USLc?=
 =?us-ascii?Q?QJwf5I3ERfm9J6DAvqLspz8Lm0GxRMfl8q/k+mp4TCkH/MRWLorO5X7h+bm9?=
 =?us-ascii?Q?HeS/Fvrab5bygMtiHWYBMak0gSV/ySvjVNjorv0M7jPddypziUYpVTwxTU9Y?=
 =?us-ascii?Q?xthfE2UidwU5bkma3j9Hw517vxCmYaclqsp+4KTWdcc01iXjglSu8cbLidLA?=
 =?us-ascii?Q?ZDj0F/M308sPbop/JJM04ZPU5DRik+hDcJ2eOqvPwKGdF5H4FiysUh0vbZXQ?=
 =?us-ascii?Q?S80y0OdWWVJeDnT/K0d6+cGtF8WrxzqHpFD3G47weqnhtiZ+e/f6jsbTJz5a?=
 =?us-ascii?Q?rryd6+pKO5aOqQzpjVulu+hoEbs4/+BgPS6jIDygIhw25HVCMRwod8ImZu0X?=
 =?us-ascii?Q?MV8Mk4Y6OGmhkOPzraOHL+6t/iAsmwR8976jx9iW0E0flV3peH6gR7LtkkGr?=
 =?us-ascii?Q?ZcadBZ2MPjMrMTqugH1lS17oMb2VvDXAytUL4VJW7oJMIHoItrZRP6xzRNBF?=
 =?us-ascii?Q?ifGRVh47T9NeCnocCVLlj5lC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d97df590-a15c-41c8-6767-08d934ce460d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 16:04:39.3852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fADPZzTOF+isImUF5MwhTRcJYm2AVtg+O1FyIDV9Qv7sCxaL6dl/SQdxqkS43gt8KpVa2uvwrW+j6bdnCODm7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
svm ranges can have mixed pages from device or system memory.
A good example is, after a prange has been allocated in VRAM and a
copy-on-write is triggered by a fork. This invalidates some pages
inside the prange. Endding up in mixed pages.

[How]
By classifying each page inside a prange, based on its type. Device or
system memory, during dma mapping call. If page corresponds
to VRAM domain, a flag is set to its dma_addr entry for each GPU.
Then, at the GPU page table mapping. All group of contiguous pages within
the same type are mapped with their proper pte flags.

v2:
Instead of using ttm_res to calculate vram pfns in the svm_range. It is now
done by setting the vram real physical address into drm_addr array.
This makes more flexible VRAM management, plus removes the need to have
a BO reference in the svm_range.

v3:
Remove mapping member from svm_range

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 73 ++++++++++++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  2 +-
 2 files changed, 47 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 2b4318646a75..3b05bc270732 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -119,11 +119,12 @@ static void svm_range_remove_notifier(struct svm_range *prange)
 }
 
 static int
-svm_range_dma_map_dev(struct device *dev, dma_addr_t **dma_addr,
+svm_range_dma_map_dev(struct amdgpu_device *adev, dma_addr_t **dma_addr,
 		      unsigned long *hmm_pfns, uint64_t npages)
 {
 	enum dma_data_direction dir = DMA_BIDIRECTIONAL;
 	dma_addr_t *addr = *dma_addr;
+	struct device *dev = adev->dev;
 	struct page *page;
 	int i, r;
 
@@ -141,6 +142,14 @@ svm_range_dma_map_dev(struct device *dev, dma_addr_t **dma_addr,
 			dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
 
 		page = hmm_pfn_to_page(hmm_pfns[i]);
+		if (is_zone_device_page(page)) {
+			addr[i] = (hmm_pfns[i] << PAGE_SHIFT) +
+				   adev->vm_manager.vram_base_offset -
+				   adev->kfd.dev->pgmap.range.start;
+			addr[i] |= SVM_RANGE_VRAM_DOMAIN;
+			pr_debug("vram address detected: 0x%llx\n", addr[i]);
+			continue;
+		}
 		addr[i] = dma_map_page(dev, page, 0, PAGE_SIZE, dir);
 		r = dma_mapping_error(dev, addr[i]);
 		if (r) {
@@ -175,7 +184,7 @@ svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
 		}
 		adev = (struct amdgpu_device *)pdd->dev->kgd;
 
-		r = svm_range_dma_map_dev(adev->dev, &prange->dma_addr[gpuidx],
+		r = svm_range_dma_map_dev(adev, &prange->dma_addr[gpuidx],
 					  hmm_pfns, prange->npages);
 		if (r)
 			break;
@@ -1003,21 +1012,22 @@ svm_range_split_by_granularity(struct kfd_process *p, struct mm_struct *mm,
 }
 
 static uint64_t
-svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange)
+svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange,
+			int domain)
 {
 	struct amdgpu_device *bo_adev;
 	uint32_t flags = prange->flags;
 	uint32_t mapping_flags = 0;
 	uint64_t pte_flags;
-	bool snoop = !prange->ttm_res;
+	bool snoop = (domain != SVM_RANGE_VRAM_DOMAIN);
 	bool coherent = flags & KFD_IOCTL_SVM_FLAG_COHERENT;
 
-	if (prange->svm_bo && prange->ttm_res)
+	if (domain == SVM_RANGE_VRAM_DOMAIN)
 		bo_adev = amdgpu_ttm_adev(prange->svm_bo->bo->tbo.bdev);
 
 	switch (adev->asic_type) {
 	case CHIP_ARCTURUS:
-		if (prange->svm_bo && prange->ttm_res) {
+		if (domain == SVM_RANGE_VRAM_DOMAIN) {
 			if (bo_adev == adev) {
 				mapping_flags |= coherent ?
 					AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
@@ -1032,7 +1042,7 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange)
 		}
 		break;
 	case CHIP_ALDEBARAN:
-		if (prange->svm_bo && prange->ttm_res) {
+		if (domain == SVM_RANGE_VRAM_DOMAIN) {
 			if (bo_adev == adev) {
 				mapping_flags |= coherent ?
 					AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
@@ -1061,14 +1071,14 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange)
 		mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
 
 	pte_flags = AMDGPU_PTE_VALID;
-	pte_flags |= prange->ttm_res ? 0 : AMDGPU_PTE_SYSTEM;
+	pte_flags |= (domain == SVM_RANGE_VRAM_DOMAIN) ? 0 : AMDGPU_PTE_SYSTEM;
 	pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
 
 	pte_flags |= amdgpu_gem_va_map_flags(adev, mapping_flags);
 
 	pr_debug("svms 0x%p [0x%lx 0x%lx] vram %d PTE 0x%llx mapping 0x%x\n",
 		 prange->svms, prange->start, prange->last,
-		 prange->ttm_res ? 1:0, pte_flags, mapping_flags);
+		 (domain == SVM_RANGE_VRAM_DOMAIN) ? 1:0, pte_flags, mapping_flags);
 
 	return pte_flags;
 }
@@ -1138,31 +1148,41 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 {
 	struct amdgpu_bo_va bo_va;
 	uint64_t pte_flags;
+	unsigned long last_start;
+	int last_domain;
 	int r = 0;
+	int64_t i;
 
 	pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, prange->start,
 		 prange->last);
 
-	if (prange->svm_bo && prange->ttm_res) {
+	if (prange->svm_bo && prange->ttm_res)
 		bo_va.is_xgmi = amdgpu_xgmi_same_hive(adev, bo_adev);
-		prange->mapping.bo_va = &bo_va;
-	}
 
-	prange->mapping.start = prange->start;
-	prange->mapping.last = prange->last;
-	prange->mapping.offset = prange->offset;
-	pte_flags = svm_range_get_pte_flags(adev, prange);
+	last_start = prange->start;
+	for (i = 0; i < prange->npages; i++) {
+		last_domain = dma_addr[i] & SVM_RANGE_VRAM_DOMAIN;
+		dma_addr[i] &= ~SVM_RANGE_VRAM_DOMAIN;
+		if ((prange->start + i) < prange->last &&
+		    last_domain == (dma_addr[i + 1] & SVM_RANGE_VRAM_DOMAIN))
+			continue;
 
-	r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, false, false, NULL,
-					prange->mapping.start,
-					prange->mapping.last, pte_flags,
-					prange->mapping.offset,
-					prange->ttm_res ?
-						prange->ttm_res->mm_node : NULL,
-					dma_addr, &vm->last_update);
-	if (r) {
-		pr_debug("failed %d to map to gpu 0x%lx\n", r, prange->start);
-		goto out;
+		pr_debug("Mapping range [0x%lx 0x%llx] on domain: %s\n",
+			 last_start, prange->start + i, last_domain ? "GPU" : "CPU");
+		pte_flags = svm_range_get_pte_flags(adev, prange, last_domain);
+		r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, false, false, NULL,
+						last_start,
+						prange->start + i, pte_flags,
+						prange->offset +
+						((last_start - prange->start) << PAGE_SHIFT),
+						NULL,
+						dma_addr,
+						&vm->last_update);
+		if (r) {
+			pr_debug("failed %d to map to gpu 0x%lx\n", r, prange->start);
+			goto out;
+		}
+		last_start = prange->start + i + 1;
 	}
 
 	r = amdgpu_vm_update_pdes(adev, vm, false);
@@ -1176,7 +1196,6 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		*fence = dma_fence_get(vm->last_update);
 
 out:
-	prange->mapping.bo_va = NULL;
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 08542fe39303..27fbe1936493 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -35,6 +35,7 @@
 #include "amdgpu.h"
 #include "kfd_priv.h"
 
+#define SVM_RANGE_VRAM_DOMAIN (1UL << 0)
 #define SVM_ADEV_PGMAP_OWNER(adev)\
 			((adev)->hive ? (void *)(adev)->hive : (void *)(adev))
 
@@ -113,7 +114,6 @@ struct svm_range {
 	struct list_head		update_list;
 	struct list_head		remove_list;
 	struct list_head		insert_list;
-	struct amdgpu_bo_va_mapping	mapping;
 	uint64_t			npages;
 	dma_addr_t			*dma_addr[MAX_GPU_INSTANCE];
 	struct ttm_resource		*ttm_res;
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
