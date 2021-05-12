Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE2AC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:34:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0B561059
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0B561059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F1166E047;
	Wed, 12 May 2021 17:34:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 923F26E047
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:34:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbRl9T+jp/fGSDRIa/JWJY3sI3exjo+7NwatoTDXwzn45o7rphDt+w3jkT5Xx2/dTwheyLfekP6oHdj+bOm4C/1f2sTo5k4v1Ov5cwMEYSp8weUDJyoSrXmhGz1jEkQXeHLIRjCVEH5DJgfqFZ2LTepo9KSGREkzeGLoPnUVXIpse/AtKvcSDbWUV6tG06UaUYZUb5+henuIkQjtL5w3Npe0j3vF26w/LCVa9JAyL6C6MyAPPjPVyGwkgBuvQQ3oEcDBL0X9ROl5jnmtlWErExPTqkQ6f4LA4gZSrEKk+9PFaOWswWD/ZLCpy3mmaFiE0JDaUMRE2y4/oNig8k0MVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1dGFkv5YpVPsEMDtoWLMTtmIra9YZZnjLXcu3UTlCw=;
 b=gAPV08ruLQfZ2vuq1P6pkWZMJ12Ta/Ah3WSMKcnGFxZKwbxKnoyVHeoxVRDahbUNLgTWaAtFLmXMmemF3DtnWRA0GK00wCrPBdRELRMmvWoyuhsLeqktdTGDv2BjTqGk75SeNsv9WTZDVOEN+FosAtUNkbvQzUw8DtMC9bwnL1W+u9xfriFcZ8HFOWgUx1yWJryiE3Q6TMwDl/dg6QiEidjuTd/ssli9BtlAU+IaBXmGS68XLauMTNM7Ckuq0qLb8phU2K4jUPD7gBcYa6bszvhnVNkh2yssrf+39YPPYg44n1QuqzS62dzp8gZEby0NXh+lNVPPJzb6xKQQSQ+FPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1dGFkv5YpVPsEMDtoWLMTtmIra9YZZnjLXcu3UTlCw=;
 b=ywVFeSXOhEK/0K+RH4sj2ol9dIwYqHzrI5G25a79jGJA65h+ROI1KlTmkCzSXc96YkYdxsOI1y1pY8nHq0X6TgyhSyM1X0lsiG//UMstICLMdjUNIQI5wK2oulh9ADEVBdK4eBHlfhK+2ozFIJSBwtmbwipxLykYrf8ffvHyvOE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2415.namprd12.prod.outlook.com (2603:10b6:802:26::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Wed, 12 May
 2021 17:34:47 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121%9]) with mapi id 15.20.4108.031; Wed, 12 May 2021
 17:34:47 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdkfd: classify and map mixed svm range pages in GPU
Date: Wed, 12 May 2021 12:34:27 -0500
Message-Id: <20210512173429.957-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SA9PR13CA0056.namprd13.prod.outlook.com
 (2603:10b6:806:22::31) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SA9PR13CA0056.namprd13.prod.outlook.com (2603:10b6:806:22::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.20 via Frontend Transport; Wed, 12 May 2021 17:34:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcc508b6-d86a-4276-e381-08d9156c3caa
X-MS-TrafficTypeDiagnostic: SN1PR12MB2415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24159D55CE4174BA8E42F446FD529@SN1PR12MB2415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rM0yyOmBo5RSTMLcVf1UD0DEnfBdE27ELjg9Ux879xWR77hNaAsx5EU1U576jt7d4kBplNhf7LlLxTfBeWzhsJmXP/q9tX1zrSq5fa1bH6TA8opK7DWSbjHNv6a56XRhRFG6igRJDRKVZvgGwy977rNttaFz6AnopO6BnqKgeDz1oTGp7QNY1UJb1OhiGF/nLOXWTCFU+3czHAaDHrlF4H7xo4cg0GMWBARDMpjlJCKyMb3G8LToimPBLYaLH/ubRMiWJ2Ji6ZdjeYFEULVdV0BZzFxzmIVeTqz2tPSog+4V3X7Hfhdh+hROCIm3uPhc8XpPLVLpQ0crRXXbg7lOZnkI0kWWVHWbhmGCkKkChaYJMaCs+EzaWj9CDzpaXFauy4MN43pTqFF24c/RUSeIcwg+YjDVKvCaxiQjrlLH+njRqpl1Kw9TyVtDFeKI5KMFm099HaSZeJeHGDHTVPp5CYQUJ2Ft2dBM9oCmK0rDtwI3crcH90Qb7K4pTiqFdkMCU0NHLWKGKSwmtOgtP20W53NztKSQSX6QygJSeIjhoNPyEYvGMFUGB63LNRxlEotZFo8zZ3tu4NkNGzBjjfNEM09TVbXKNh/oPY0yxHsbJgwPUgvJ7+EYOF0R2C71VObGFghFA5oe3ZCZNuytY5Aixgd1zJtCZAVgRSUVHVwSwdTiPb9oKOYAcz0EKVRQ4EsO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(1076003)(16526019)(26005)(8936002)(4326008)(38100700002)(186003)(6486002)(8676002)(83380400001)(2906002)(66556008)(66476007)(478600001)(66946007)(86362001)(52116002)(44832011)(36756003)(38350700002)(5660300002)(956004)(7696005)(6916009)(6666004)(2616005)(316002)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XvuqLeBwrEm14CVsObYCFJXKM80WfCXmUEHq2+t+zLWoJo+HssVM4qcMsv0r?=
 =?us-ascii?Q?RODQCyA0QUBIrq+RXBlyR65D1/swAk7uCbHnJ6U3a1NIg7uQcAKsczxzXRMI?=
 =?us-ascii?Q?XyduBDwt+ZXR02R8W026eM8ILUnoOL7wdXmjm70/To52MDS3NW7SY45gIsxs?=
 =?us-ascii?Q?khJxOgvGO09e8wxGSd1wCzToiMGoZSkApkMN8HLZzbj1BOCNX5nQRUe8dfSG?=
 =?us-ascii?Q?7hy4+eGNmi2RM6acv1d6q5EPNPTtSF62aZ+z6R36LszVFsnYQYTjJx1SHkmP?=
 =?us-ascii?Q?DZKDEB0YaBjRZ3w/fyesfps8FyaxyY6mK3X7rHB56NvycERrIROwzbvimKpF?=
 =?us-ascii?Q?rLCbETDUcryG74ppSgnX8gecalXC8CAd1alAfjGW13c5UfQqSbOYn34QQi81?=
 =?us-ascii?Q?mDBLpi9dPsM3k+/u9B4hcJy9ZXzP8A+Kw+IrMi8xT0wP+6e3RjigmZOx3nDQ?=
 =?us-ascii?Q?3bMNvyapgVBguZ2mJPhhsIAWGJ28gxMhJKn6dYuE/6ibmos/7wLyHt2F7z7q?=
 =?us-ascii?Q?GLMBujMve9R5bNKe8k1+gaDq3oNuq5kUbxAxDoijzueOpMbSvLuG5vDABPHR?=
 =?us-ascii?Q?2ywAfOWgmA/L0ltOICtSjN7IjPzwjMkHSFz9/Ii8a4O6eBlqw/S1dgKEPrZd?=
 =?us-ascii?Q?9xlc8I9/kU2ac9N+7KgFhPH7rcwdh5bM2TDS8I5uc3WTQfDsRg/PegBvpOuW?=
 =?us-ascii?Q?EOnPBNBQtocxYacJn6oMeB31tnAf+fli5VQGDFTNXh6aW5JHyPLtCyuI34KH?=
 =?us-ascii?Q?618g3o814Q/rnK7rN89RUPnRTTKPTpA8B/KTzxSmN18GDAFyF5hy4edlcVvq?=
 =?us-ascii?Q?jJXhcww4XUyj6XXW2Y1i1VwC8zdqpimhJIoOrmNIy4PR9V9TvhmxN5H+V9J4?=
 =?us-ascii?Q?814xyutnA+Kx+BIgVzlACITEb2rOdcgNm88AKz1zEDfwTZtheQz6cCWuisjy?=
 =?us-ascii?Q?GKAJWVwGmTARXvWZurLnNfVpX60WOTYnd9/wphTyagISB6KR9tka8WxP6az0?=
 =?us-ascii?Q?1uwsSMiFFxxkKlPBYKa/aru2rYejxjts7E+jyGTVYMYBDPfUk9+MijoqMVZl?=
 =?us-ascii?Q?gea9C/HYGtCKNOHUOPCZEY5IDtxc/ZCGHvYRkYAi+qvAZxcrhCutFMUSSVgn?=
 =?us-ascii?Q?S4Z/y61h0r2nmNCm5gHSkMreLqexUc+1sLWnWmJHeU0IA2v83g1k0dIwx2jV?=
 =?us-ascii?Q?FHWT4FnZ4zn1QkV9719VaNmJfdw4nb92gt3GWhdXPA7Vp0Jp+Z/fd9RsVg1t?=
 =?us-ascii?Q?bcV+qCAXg3qdPRjIwOHKfeO5TnnFTUA9VgatyZluf5sxbHVRvB6CxfhV2SDe?=
 =?us-ascii?Q?qaH3lDfWwRrnK6IvpUDjK2fM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc508b6-d86a-4276-e381-08d9156c3caa
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:34:46.9493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHFF+ULZbzHhqZFBWG3H0mQdmQBJTbMMCvKvM6qWNFOhIQ1UwXUlFxYucJDCAEmz6Mypg4R6pDZmarz6QS5NZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2415
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
Cc: Alex Sierra <alex.sierra@amd.com>
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

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 71 ++++++++++++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  1 +
 2 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 2b4318646a75..0ab10cb24205 100644
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
+	bool snoop = !!domain;
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
@@ -1138,31 +1148,40 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 08542fe39303..e68aa51322df 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -35,6 +35,7 @@
 #include "amdgpu.h"
 #include "kfd_priv.h"
 
+#define SVM_RANGE_VRAM_DOMAIN (1UL << 0)
 #define SVM_ADEV_PGMAP_OWNER(adev)\
 			((adev)->hive ? (void *)(adev)->hive : (void *)(adev))
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
