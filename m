Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D789FC43460
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 23:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C852613C9
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 23:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C852613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24D816EC78;
	Wed,  5 May 2021 23:00:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B32346EC78
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 23:00:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUV2cDC48rMk7lyn4uo7gTvH16r6qFLXauWwQwDazt+fxrzqIz/ru0JjRogv6Rkf1+Du8h9thxfC8ALHC2HnkHCJbpTC75gtPzr9UUszKZzNbaIXbTwJt3x0AafYyMz1x6TGHoPCBVB3y03K/S6zKPGZ4gU8fBOD8J28P4r8GeFP4d0xZWt5S1m86ELs6wRDaOMtdJ6xDTLq4mbZny7IBes9Q6MKp7/A1fOO1M431TjolMWOaXVlDI4Yc/u1mW86uwl4L8T6GT/JzJI6XepUI5bfHLeyNXX2ag44riC3Myi/YdHChA7S6kCLaF9sujaLkrX9tPNtYeG7AAzP7VfFYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2Xny5ozteeJF14bE0Iyg64lbtwYyfTyVp/EvYG9E6U=;
 b=fNfGPoEUCIad41LQomnVGiw4XSWSpatY1EP6+Y1g/82lR6WPDJ50d7lpESY9q3LZz1Q6GUavTMUnQ5J7rpMY7S1FCfdgaNgCcNRm5RDZKqT6080AQcjdjpd74kAsjK9WghuHkJnzQA+WKzCfaGLGBaMo1K418MFAKR1m3f679iD4CHAtd7nYp10guMlsdYb5B95AwiK9ZC9GStIzB795zD/2I2MWyu8Ydb7UPgZsOxR+uQYW6tybuwZux8hdu4BOaJ6GWNCD55mKiwyfvyLm+Xowq5RbX5y4WQcIPm8dLSNgAnVuSHhuLxYjf0U0CDn33gfI2TL9UV9mO++fbqG0kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2Xny5ozteeJF14bE0Iyg64lbtwYyfTyVp/EvYG9E6U=;
 b=mqbzgjFjW13v+QXYS8ZgJO2GWPuxtCF/p3CECAl8GdfgkjJzdQQMZZkQgn7/XzpexvEkrs3aDQRSkK8l4e0MY7DMRWJxTdNHKWJM3RJM2QVtPHFPNa7ibhWnqlrHw1hGP4+8pVMFPBRZAHbkGLD6sDm7VFg+ipvgdZOVtaOZOwM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN6PR12MB2640.namprd12.prod.outlook.com (2603:10b6:805:6c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Wed, 5 May
 2021 23:00:20 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121%9]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 23:00:20 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdkfd: classify and map mixed svm range pages in GPU
Date: Wed,  5 May 2021 17:59:44 -0500
Message-Id: <20210505225944.4425-3-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210505225944.4425-1-alex.sierra@amd.com>
References: <20210505225944.4425-1-alex.sierra@amd.com>
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SA9PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:806:a7::24) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SA9PR10CA0019.namprd10.prod.outlook.com (2603:10b6:806:a7::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.24 via Frontend Transport; Wed, 5 May 2021 23:00:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea535747-b39d-426c-0ac5-08d910198e0c
X-MS-TrafficTypeDiagnostic: SN6PR12MB2640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26408A6B34A5D3D2E1D9A897FD599@SN6PR12MB2640.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KHBLoJT8SGZn/oFQTnbHMMjtBh6klNjv+pfW2+eCJCiT0aZ09NUGBzQRO3Bu+XTOY8PsAmKARY3Y3Lwy+51gLLACsLyp5fgCjkJ6vUB2NrtAvHkRFnZLFpBT83vRalgCeAzJMB/QLO8JmfVNCftMpczvTFSP7EDgnmF+jPETy8h7iKwVuj4o7UdNTOkNwt6k1aPFpdU2GriVrOs5auDXp2sX3jiKQiK7OitnTyTbXnFovYnny2iYTPxY/jmdkKJzerqfMdQUD4Y8BV8eCYWKKntkBXdhJzzCiKB8UBUnEtzfNXouhrSlUD9XrMIBbIsQaU/P6BtHp7j3tJBaNQvbI8JGDrYyoxGlQkXPb2syGCdRPv34wJx9pDgpgkNBc41veEC3bQLQ9mLTPrvgMcvkwJB5YmmktmE5IegUxZ7ML7tkn8EqKImpzxaKGmKYcHZeEjbxdyljfMg4zthINKGZCeTeh+KL1W6D21ZM1lR6NzMj/UjHQWNG301sxY37GxMSALBiQoP1ulDQdu/uz37Qm0z87pJCmniJw6ndevrVczXCNZV3mG9vaOH1Km1C645OpwEQhHWQqVTQcUgmX8k5JTE506XjI1oU7AjIAJShzZ5HylzLl4DQAmjccTy6Vudotazat6RDfEXBxFyiNNtRpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(66556008)(66476007)(5660300002)(7696005)(52116002)(8936002)(44832011)(478600001)(36756003)(6486002)(2906002)(6916009)(8676002)(38350700002)(66946007)(38100700002)(86362001)(26005)(6666004)(2616005)(4326008)(316002)(83380400001)(16526019)(956004)(1076003)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tb6RnMNL2fTRj0aKbS2FwNzRKmt8nYw1EZwg/Henct26DnlhbZkqw0gd+4AV?=
 =?us-ascii?Q?el2oSsKZMYb/SBjb+8JvrHcOmBGpANuwH9cvEn6y25pEZcH3buR8Jq54h5US?=
 =?us-ascii?Q?JzKrU3USzHHCQhj5IVzlY8Dx1u7ixgT5UVr63EgP+aTopr129/s23R8pM2uP?=
 =?us-ascii?Q?qiWc1zYIMiNQKWE2oowUZcVBkHg21922V/CavnAgHWsQSSHWXDcsqx6B6rLQ?=
 =?us-ascii?Q?7rexZsi9BqVTjmd0ra56nBLAkYzEml2ZdEZIXmjFSgOYohX/HjwWxGzn2aLl?=
 =?us-ascii?Q?kgOeZQ+JARq1MsOWgy5H7IyXkhnsjjzo/MCg8p0omPJTZv01Uo508piHS0TQ?=
 =?us-ascii?Q?093OSifNpT/gZuqIwJUiOHpa90WJPXPuFJrzztnqKd8A82wHCBl43JSYI+L5?=
 =?us-ascii?Q?ks/OMvhF5yIsL/+ZrWlND9gyAj/NoQ9Goy8s6R56SGiyrG4fcOrjoM5wvG3s?=
 =?us-ascii?Q?shZlPaBhZUaXI4NELSSB7Ka5zeU80du9VvJOmNpTwUUqgxuwwctYPZfhA95N?=
 =?us-ascii?Q?zbJmvXJvwO3AOY33mCH/ShXwGQcu+yVqMlSI4Dmyi0ijvlikWP3WWwiVx37x?=
 =?us-ascii?Q?BNZSKIBnGSsr+tXr90yd2fXZKpxxFqDYwA6iaKdmsSrnHAkxGU9Oz7yi88uf?=
 =?us-ascii?Q?AU15qdBpjALaxH+p4NrTcWusg3pYrUvqJrIW9vVWGHe9Ax1Tiwy2HqCx9ChA?=
 =?us-ascii?Q?EQ7mPEpdYBFOE/BMmGk+xlDlulQWqNGUsVtG3BnjnAWidsfWC/W27B7q0MwB?=
 =?us-ascii?Q?Hi24dU92Msfqx9pbX+MNZmf+i4+ejbfj/kafe/7caKCURCWa9x/yxh69L7Lc?=
 =?us-ascii?Q?EMMu0MyaHPsBu1nXrsS3inHNlTmwR//dF1KbUtudDrSDY5axvo8S+endszsw?=
 =?us-ascii?Q?VjwCEYXCSL+hUax+ZsWhRBDi/sb83CFjnmQPihbR2ab3ckjDjjVvsq4I5RRK?=
 =?us-ascii?Q?vsNlMYlOnbOqMJJ8Jh4QrJdSikRZPGsVXXSq6h7udZhiy3xQqoETTDeyHX9Q?=
 =?us-ascii?Q?glv5AWTZnCUyt+sdOctyqVqBYuH6s6gigVESkKKus1ZnAW0DRp01KNPHIMRs?=
 =?us-ascii?Q?FG3g/8jNV29Cq7DcxIeLbFk3yoIkG/GrKcF/mdQacwn+2lrvphQpHmg5hbp2?=
 =?us-ascii?Q?TADGaRyFVvZCFpvMIxEEwx5dhIBElyYkkDKjrYY/ynyXlNCYxRVp8YlbwEoZ?=
 =?us-ascii?Q?3+vhnCyt5WFvr0YjSa4C++cSxSE/6EmkD8/v0apUJucF3WIjJcbQ2A1OkWlE?=
 =?us-ascii?Q?1SHSz/w9FJwjvXPxkaghFmuGuXNGyqlIU+lCDXg4PTAgqpKkC3rn+sPuFTzg?=
 =?us-ascii?Q?RO6283vG8dWrjN2pMs16hcpH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea535747-b39d-426c-0ac5-08d910198e0c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 23:00:19.4329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eylHw0Z9HcnKyO+l/PYUWvZEKSXCKRdq5jmx3HGHHGR0iHNPiNT55s+Vt9yMJRe6a4t3m9sgggD1mjSzx0/dRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2640
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

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 58 +++++++++++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  2 +
 2 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 7104762a0119..94fe9ab70e94 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -141,6 +141,12 @@ svm_range_dma_map_dev(struct device *dev, dma_addr_t **dma_addr,
 			dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
 
 		page = hmm_pfn_to_page(hmm_pfns[i]);
+		if (is_zone_device_page(page)) {
+			addr[i] = hmm_pfns[i] << PAGE_SHIFT;
+			addr[i] |= SVM_RANGE_VRAM_DOMAIN;
+			pr_debug("vram address detected: 0x%llx\n", addr[i] >> PAGE_SHIFT);
+			continue;
+		}
 		addr[i] = dma_map_page(dev, page, 0, PAGE_SIZE, dir);
 		r = dma_mapping_error(dev, addr[i]);
 		if (r) {
@@ -1131,33 +1137,49 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     struct amdgpu_device *bo_adev, struct dma_fence **fence)
 {
 	struct amdgpu_bo_va bo_va;
+	struct ttm_resource *ttm_res;
 	uint64_t pte_flags;
+	unsigned long last_start;
+	int last_domain;
 	int r = 0;
+	int64_t i, j;
 
 	pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, prange->start,
 		 prange->last);
 
-	if (prange->svm_bo && prange->ttm_res) {
+	if (prange->svm_bo && prange->ttm_res)
 		bo_va.is_xgmi = amdgpu_xgmi_same_hive(adev, bo_adev);
-		prange->mapping.bo_va = &bo_va;
-	}
-
-	prange->mapping.start = prange->start;
-	prange->mapping.last = prange->last;
-	prange->mapping.offset = prange->offset;
-	pte_flags = svm_range_get_pte_flags(adev, prange);
 
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
+	ttm_res = prange->ttm_res;
+	last_start = prange->start;
+	for (i = j = 0; i < prange->npages; i++) {
+		last_domain = dma_addr[i] & SVM_RANGE_VRAM_DOMAIN;
+		if ((last_start + j) < prange->last &&
+		    last_domain == (dma_addr[i + 1] & SVM_RANGE_VRAM_DOMAIN)) {
+			j++;
+			continue;
+		}
+		pr_debug("Mapping range [0x%lx 0x%llx] on domain: %s\n",
+			 last_start, last_start + j, last_domain ? "GPU" : "CPU");
+		prange->ttm_res = last_domain ? ttm_res : NULL;
+		pte_flags = svm_range_get_pte_flags(adev, prange);
+		r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, false, false, NULL,
+						last_start,
+						last_start + j, pte_flags,
+						((last_start - prange->start) << PAGE_SHIFT),
+						prange->ttm_res ?
+							prange->ttm_res->mm_node : NULL,
+						prange->ttm_res ? NULL :
+						dma_addr,
+						&vm->last_update);
+		if (r) {
+			pr_debug("failed %d to map to gpu 0x%lx\n", r, prange->start);
+			goto out;
+		}
+		last_start += j + 1;
+		j = 0;
 	}
+	prange->ttm_res = ttm_res;
 
 	r = amdgpu_vm_update_pdes(adev, vm, false);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 573f984b81fe..bb85288cd658 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -35,6 +35,8 @@
 #include "amdgpu.h"
 #include "kfd_priv.h"
 
+#define SVM_RANGE_VRAM_DOMAIN (1UL << 0)
+
 struct svm_range_bo {
 	struct amdgpu_bo		*bo;
 	struct kref			kref;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
