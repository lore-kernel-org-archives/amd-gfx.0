Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45027C11F69
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 18:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FC5F6192F
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 18:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC5F6192F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2439C6E8DF;
	Tue, 29 Jun 2021 18:03:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 750B56E8D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 18:02:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJ4vVOsB98olPUMQhc832dioK1mJgZg6xmPvf0/KDlmXftBKo59Y7fxBee9N63TlrtROPWm598m3rj2Nd4nMFhQ8lizDHg1XTTkKXLtS9G0e1xvBqxQLOXSe2vUuzWtz+rr7tDHaILqY3kXB3pMs409oH5pOUN9UGGYDx+8xLphNb4Fp6k59sIPp6icHFmeXFjZjeiSyBbpOFTxhUtyeVUhy+JANFZ5+nb15g2VnghvyxNKQ6jEp2aPeytyIVPSll3iLrdHWtKSuGLaIaRNKNbO/tO08v3WlBbdxVukr6IeeQD5QMVi0uofoY9URkHoA0a0WbWHx5Ypy2+Eb5CSdtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsGslgf88vjAi5Vjkz8ZRvtQs9NOcFKzJN8Aryu596Y=;
 b=MDZFue6REgpkqumySNJPkBm0Eu3fc675TK51KXZ0gO/jPp1fDGKG3SN4Ywc3p6YdKylGtU1K1OQQ4wvKxu/EAPcTARpEoKr+s/V/VEb7IREbqhphB7y5CUYXOTRHUg3a3DP9cOpo+A/N1aV1o56jQTKi+6JaRc2FmFrjBR0MtCwVsVBep46vrC/wHFjdmSlHLyV0es3Pbpyo1NESD8/NKUeP/9URN83h5QdpfDurGmPph7RqdPHOr11uQNuSYqQ9kGATKhzjbQnb2mnYO3XaCVa/ZNT6/iPwk4QEVNH7EU5RRePLP67bs4hzGhPFzfRyIqNvwIKI1EfqbSsiPtm9hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsGslgf88vjAi5Vjkz8ZRvtQs9NOcFKzJN8Aryu596Y=;
 b=HM8wswDuT3H/EBRrNyZDEs0IILakPGb1pyk7DAmd02oQUqFMXsl9ZM7l7K9N4xXqFuCu7chmspYZlDW8sXlB77MR+aszwdCuMIw/HXnhUA00Q+G6lTjpRmmp3XEact5HgvUKcTpeeXooAwFS8U5KNR4HqxZdV+ShzrZH4C65G14=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2542.namprd12.prod.outlook.com (2603:10b6:802:26::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Tue, 29 Jun
 2021 18:02:55 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4%6]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 18:02:55 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/11] drm/amdkfd: classify and map mixed svm range pages in
 GPU
Date: Tue, 29 Jun 2021 13:02:01 -0500
Message-Id: <20210629180206.8002-6-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210629180206.8002-1-alex.sierra@amd.com>
References: <20210629180206.8002-1-alex.sierra@amd.com>
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN7P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::27) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN7P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 18:02:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b48ae0c1-c58f-4218-78d4-08d93b281e9c
X-MS-TrafficTypeDiagnostic: SN1PR12MB2542:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25420CE5C01D190A155D6062FD029@SN1PR12MB2542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yBTyrJ3kdsYdc7gk9kA4hSr2soY6UFJDsFtRa2rdkV6LOJqlIH+Synjegs8pa0Lou7WgRQpjCVUfdGo3r1a65IQtw2T5ZdS14YZMYhjPMD0B6nfxlFHvD6en/QgetlFefZBb+9vlT0OggrEjQILBm4t1rnehvUKlqrLZLqPxCdfaXXpwK0kIGvTFyy1Vbby/AM8BzxIH2iSPVv+2I/oRTBQLp1w9tia5fC6VRMES8g6LxqhdsFYZhUZs71obpqDV1HuLWnb765WAwVHEebJwTGTLtB/OJEoF/BH+0GStIZASr1YmGsPcozDccgQjBNr0LcGM1eLvuf+4mx+n/OnFA0TcjxBN5VybjwAynk1DflkJJmqCqaidQfa6jaJXb3pLCvW/y5Cwxzj60E1W/XyWoJ+EM+6MEV/OkxLYQx6phMQBeracgj49/ena6WVed4MLxy+Nb8I/Karh80xKk/Y03aVIo5FRc5tXkcYmaJDdZNNFq6ChqX+gThIf/CjPrTbNcw0e6zZK28QNGj+w8fklneVzJ1It3n8AMNLHql0/dDnz6DxYZQiKEV2EqYfoFMpRuaYavIApNqQh0/j38tx0Axru7oRMEWdi/2mBuOgYtouDBPesmhRnUrU+eKYCkcb2dkeNRhWK7ZbojDzZ3u5VzAw77zsU1Ebu4IP5KMEamdjX27ruizW0rLQAmNMvLHEWsNZbsXm/NtvrAHGpb32/Ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(38100700002)(2616005)(86362001)(52116002)(186003)(4326008)(44832011)(6666004)(6916009)(7696005)(54906003)(956004)(8936002)(16526019)(8676002)(38350700002)(1076003)(26005)(36756003)(6486002)(66556008)(66476007)(66946007)(2906002)(83380400001)(5660300002)(316002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VLX6i24zy2SZ+mFMmWha6xDnPnEKwSRWJ6pw8z6XYGYzXYcRcYQWIRgGFlQB?=
 =?us-ascii?Q?O0/yieJvmhmVzZlDF563V8sWQKEeyO7mofWuWMQNGwSqpItxIA1LY4KXZKmd?=
 =?us-ascii?Q?vX2fsAyZ008Mq5d4n9hfvfWfBa3eOT93Ra7JlFZgHDlOob0cZ1XNNHremjQi?=
 =?us-ascii?Q?Uj5FYpSSQIDw7E0gPVapdX1gwjvZ8ygTrwYYISGMMU2Ml3Y9mTBv7BM3zQhK?=
 =?us-ascii?Q?RZRF3+9gBE2vswori1kCZSsp6CaQkEKP1K6MtpjlrYMIViwIuFw2MY7iyaVt?=
 =?us-ascii?Q?/AXQQ2JY2eqgme64EI0JxJTxGKxFhk7cyWQVjSpWkyRJCZBbseRxW/Uu1xNF?=
 =?us-ascii?Q?NLO8PS2NdQdMT0Q/CqMcM8gi0EHKQvxSR4+sHZ08SSCBQXXx7Ag3c08Xhf6D?=
 =?us-ascii?Q?AKTgBfiPXawYqEA6pjq87A4YLzYiS8ok/DoJRp+Ole5t7wgdhOmTOl2BJyeF?=
 =?us-ascii?Q?+H5x4YXC52MWm/GypgC8G2YYPMMXfs95XkxxivIWNeJGXD/oGx/tKLqyJKQq?=
 =?us-ascii?Q?T4l56TsQxxpW9U9qmzI+b4uAXrrqdF3tMev56ove8bZ9xdg/v2qeE5C60aBv?=
 =?us-ascii?Q?SVGfoD8naixo1Mks8xv9348qkQHTcD/8ZdbJVa+A++nG7I8IDD4RGqr15M0W?=
 =?us-ascii?Q?s5f9zSWmPuspsgofxwplss3pHG3NywpY/yqqybaE84JYbCNYPj0qwBG6weYQ?=
 =?us-ascii?Q?+NeFQhHxq/daceGwdYRRDVruUVEOrhEulCPaGKFQuVfaFOVwKyR260pj0ote?=
 =?us-ascii?Q?uTDIXnwQnMHYDRAd6+8BO5qVnuAWV02wgXFsvPIH4luwPY5ApsumfZg1vKGw?=
 =?us-ascii?Q?ZDvLxnh3D0o40qOxQlHs6u+9HPhkFVxlqx1z0IGPw2mvH1PwOVGWUAevJeQd?=
 =?us-ascii?Q?TWMOF1eOjH66dP4+Xic1kCLbVyF9GgnJ5yc9RW7ci77/IHnLLTspUjfWbcpp?=
 =?us-ascii?Q?L7fzeTOkpjY2io2xD0zeeC0G2Qet1jTT1pHuL64D+0Pd4+35d2uovPK5wxVP?=
 =?us-ascii?Q?+cg/fEgj8/44sz1OQ9yaMxBrgvGKJEPPkJk2Ygis8iGaqpOoAoJafGhgv3MB?=
 =?us-ascii?Q?13S/fFYgIPyy09ZP1kmwsOEct5CF4pdPvqZFdCFgLszNUrOrK0t2XofmeyBl?=
 =?us-ascii?Q?F3oW2rafmBw2IoIj5jPs0MBbwMHIUWfJURnKYyD00sS5H19jarnWPNSKsr+e?=
 =?us-ascii?Q?fCLbVsHGlq9ErivGKzZBOnaum1apU8GtItHdK3XrDAMRaESH3EatpfzlAJrV?=
 =?us-ascii?Q?fUS6sD2tEW0TX5S3kcUk6GXR8+hmMh9o8gBHd/aW3BLQ31KfVBZUMP8ppk35?=
 =?us-ascii?Q?cVEt4YYDpWLwVNGIy2haHjqB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48ae0c1-c58f-4218-78d4-08d93b281e9c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 18:02:54.9012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QuM0n5Qe3CHhwUr63e+2LSv8WHQ60tLEUqn+/TvEtyr7LP/AnCijzjWCLdPbbyQG5E14/dpSLpcQIDVV2jZQxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2542
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
Cc: Alex Sierra <alex.sierra@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
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
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 87 +++++++++++++++++-----------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  2 +-
 2 files changed, 55 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index bd0cc438c429..6572dea2f115 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -119,28 +119,40 @@ static void svm_range_remove_notifier(struct svm_range *prange)
 }
 
 static int
-svm_range_dma_map_dev(struct device *dev, dma_addr_t **dma_addr,
-		      unsigned long *hmm_pfns, uint64_t npages)
+svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
+		      unsigned long *hmm_pfns, uint32_t gpuidx)
 {
 	enum dma_data_direction dir = DMA_BIDIRECTIONAL;
-	dma_addr_t *addr = *dma_addr;
+	dma_addr_t *addr = prange->dma_addr[gpuidx];
+	struct device *dev = adev->dev;
 	struct page *page;
 	int i, r;
 
 	if (!addr) {
-		addr = kvmalloc_array(npages, sizeof(*addr),
+		addr = kvmalloc_array(prange->npages, sizeof(*addr),
 				      GFP_KERNEL | __GFP_ZERO);
 		if (!addr)
 			return -ENOMEM;
-		*dma_addr = addr;
+		prange->dma_addr[gpuidx] = addr;
 	}
 
-	for (i = 0; i < npages; i++) {
+	for (i = 0; i < prange->npages; i++) {
 		if (WARN_ONCE(addr[i] && !dma_mapping_error(dev, addr[i]),
 			      "leaking dma mapping\n"))
 			dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
 
 		page = hmm_pfn_to_page(hmm_pfns[i]);
+		if (is_zone_device_page(page)) {
+			struct amdgpu_device *bo_adev =
+					amdgpu_ttm_adev(prange->svm_bo->bo->tbo.bdev);
+
+			addr[i] = (hmm_pfns[i] << PAGE_SHIFT) +
+				   bo_adev->vm_manager.vram_base_offset -
+				   bo_adev->kfd.dev->pgmap.range.start;
+			addr[i] |= SVM_RANGE_VRAM_DOMAIN;
+			pr_debug("vram address detected: 0x%llx\n", addr[i]);
+			continue;
+		}
 		addr[i] = dma_map_page(dev, page, 0, PAGE_SIZE, dir);
 		r = dma_mapping_error(dev, addr[i]);
 		if (r) {
@@ -175,8 +187,7 @@ svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
 		}
 		adev = (struct amdgpu_device *)pdd->dev->kgd;
 
-		r = svm_range_dma_map_dev(adev->dev, &prange->dma_addr[gpuidx],
-					  hmm_pfns, prange->npages);
+		r = svm_range_dma_map_dev(adev, prange, hmm_pfns, gpuidx);
 		if (r)
 			break;
 	}
@@ -1020,21 +1031,22 @@ svm_range_split_by_granularity(struct kfd_process *p, struct mm_struct *mm,
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
@@ -1050,7 +1062,7 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange)
 		}
 		break;
 	case CHIP_ALDEBARAN:
-		if (prange->svm_bo && prange->ttm_res) {
+		if (domain == SVM_RANGE_VRAM_DOMAIN) {
 			if (bo_adev == adev) {
 				mapping_flags |= coherent ?
 					AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
@@ -1080,14 +1092,14 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange)
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
@@ -1158,31 +1170,41 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	struct amdgpu_bo_va bo_va;
 	bool table_freed = false;
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
-	prange->mapping.offset = prange->ttm_res ? prange->offset : 0;
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
-					prange->ttm_res,
-					dma_addr, &vm->last_update,
-					&table_freed);
-	if (r) {
-		pr_debug("failed %d to map to gpu 0x%lx\n", r, prange->start);
-		goto out;
+		pr_debug("Mapping range [0x%lx 0x%llx] on domain: %s\n",
+			 last_start, prange->start + i, last_domain ? "GPU" : "CPU");
+		pte_flags = svm_range_get_pte_flags(adev, prange, last_domain);
+		r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, false, false, NULL,
+						last_start,
+						prange->start + i, pte_flags,
+						last_start - prange->start,
+						NULL,
+						dma_addr,
+						&vm->last_update,
+						&table_freed);
+		if (r) {
+			pr_debug("failed %d to map to gpu 0x%lx\n", r, prange->start);
+			goto out;
+		}
+		last_start = prange->start + i + 1;
 	}
 
 	r = amdgpu_vm_update_pdes(adev, vm, false);
@@ -1203,7 +1225,6 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 						p->pasid, TLB_FLUSH_LEGACY);
 	}
 out:
-	prange->mapping.bo_va = NULL;
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 9a7744a12dab..41115a220c2b 100644
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
