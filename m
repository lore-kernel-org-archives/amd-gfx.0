Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78626C43460
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 03:37:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29689613D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 03:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29689613D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 454436E027;
	Fri,  7 May 2021 03:37:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BFFF6E185
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 03:37:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCBqpI5n7e3yW160O0DR/LIAH5XU9DzgCVf4HEzWhxNvHuLNcJFbXelmk0qPz6OX5Sp4J2inFtZGebY2sITN5TVB+UnnyMT7n9sRm+LKu4DuIxI+0jt832Lsm3rqQwKofh9Pue+24eWheU+SAda9WOM5KC18LHA/FXLOw5by1aPgpSGU6kftxL++Y2SakQiou4PJSiZM2TjvLs3icBX5utDjyRIXMVyOWpFNk4fzrUliQ7gd5j8NO2BhaxzvERFaOPu9ljiC0NZEyPptxVq7VQnv7Vmm5qDXLKjxekaw6KdUgpRQUanQdmoGvO46ev/FehjKS1H6V0n9RhM2FLV3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NY/B3WWR3rjtFyOU5NPf3ilh7loaAZCpR6/usZrTnk=;
 b=F5Xa3t+JqQqSYAM8W2cm4NxDchXqSS+0ljsmOTipH9mdEEFY7VkgitpcdeNTSmriolBUR5v3gtDzlX65MCmpVCDBINaHVnPAJf03GnRAymXRw/ntLGN8Uvtw5LC3S1hw3jU9YfTvXPEKGOe62c/wu7rFYumojwSm7c1gcRX0ZxMyZ9j9XJWA3wsLmwmdZ3SDkn02DMxwJfdhae4W+Lbz9Ed0zaLT0zk6RbvZq8OobzxVqNJrGfnAJK82lvKfn8QYalQIOG8Th7vYDhTx2L/qC6uhlHljygFsQqs/a81Wcyhx7Ta0hGL8/dc/OmRHH27EjtjwzcVWhG07nEA85KCghg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NY/B3WWR3rjtFyOU5NPf3ilh7loaAZCpR6/usZrTnk=;
 b=vjhj0V/5akOiXcZoMXt1KCPcKg0gVMw7wb/CfIOQxDz6XhhD1/vOTW0gvm/20rpUGmRRepbtQYACM/5C78OALTxi1cipcmJ+g3r7L3ienLYc/mDPxmXQRX2+/BG49G4rL1xJWf6sXjdPczz+N2w2S1n8GFZUoIE3tOFMMb1JXBI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Fri, 7 May
 2021 03:37:18 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121%9]) with mapi id 15.20.4108.027; Fri, 7 May 2021
 03:37:18 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/5] drm/amdkfd: classify and map mixed svm range pages in GPU
Date: Thu,  6 May 2021 22:36:37 -0500
Message-Id: <20210507033637.29622-5-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210507033637.29622-1-alex.sierra@amd.com>
References: <20210507033637.29622-1-alex.sierra@amd.com>
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SA0PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:806:130::23) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SA0PR13CA0018.namprd13.prod.outlook.com (2603:10b6:806:130::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.11 via Frontend
 Transport; Fri, 7 May 2021 03:37:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e28731b8-558e-4401-8d42-08d911096a5f
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4557E062DB6CC912EDA75C22FD579@SA0PR12MB4557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IciQfPlWoAqIUoBd/zDztrt981bf2eMsIp/9ZoZr6O+mdLS5oyvBhw3CmO02qrqY0BBEpgBKTy8MqVYzhBA/kp4Ut6nvSoaRSwBTiIbaEhqeYj4CqT14YMH/S21jNnVdX06Xs3yjtxuY/MMD1fPtRUS8nFskDAjuNwNiFQ/aA3VA4Wws/SvYLP7GTdVGYuddUfAsOCCdGMD18ST9H0t7gIL3dsLDdGeBP7bKUgS6cVJLX6Zaj+2RrZmAfraY9UC8+2vMr6MyOBJBHClj/z1bN0zhTUhLR06c1xMiVvTiKTs4WfBa9q5wJlTjXsSKyF+sXzuOTdGqnyu4uK+QdjhtaA8NQRDadT1kXEREdSjX9pRQYCUXdtdX+S8zJP+iypvYiCli7acto6Sy+zCXkV4lTkIXneWiGKue1IsE+38ZZ48M7km1Mi4ZdOUe9UTNjoCDMtvs3fTpsyHID4wXvBkdntG5RJdaoNCpgmMZMp5jySdPVIYfpx2pcsfXevvFLMrPXNxFfmVMRW8x/d/N7HL/fkMvAWECi+S2ZF7xMVgiIch4vv23H7l+otLvlnPDwCIK48AWw34KmE86EL5gsjX8fyuSnWAgLFrZcDILH10wEw4JcTRIsGP0auWEtslALLso/LT7EljT9XNoKWkQ3Q6LAZ1cFh39RtQw6pjqvtZaGuQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(186003)(16526019)(478600001)(8676002)(38100700002)(7696005)(5660300002)(4326008)(26005)(38350700002)(36756003)(52116002)(6486002)(8936002)(316002)(44832011)(6916009)(66476007)(66556008)(83380400001)(86362001)(66946007)(6666004)(1076003)(956004)(2906002)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nXeqb3r7BMiKr8lg8dMeyKEAPVZebMWiTqsLwPvqiLUJrHK57sC9cREyW32n?=
 =?us-ascii?Q?HqXf6NkFYw4SnRfYKVH6LuduMf93PGP4dEDqLrlzFMCX7YvZcRlbSaoS7wEi?=
 =?us-ascii?Q?kgDAu0KJwnhBRbVLa4sYLRRgcgcwvxemP9xrBNJhqA9t44JksTNnb3IUM80n?=
 =?us-ascii?Q?j2cEj+1YlKohZrE5aS69nzbX6xv2GbTrEjy1saBBWCzAvH/bEqyK63tpGbRq?=
 =?us-ascii?Q?Jp7IpJyOg2+9FJAY5z64NCxBXA0cK5knicJawJfPKPjNZ6Sf5qcTEkb97N7v?=
 =?us-ascii?Q?6pM8DfhZVefbDPQq58vppNlWEeJaQeH+hKDVxbHSm71waPraIuScN04B55tB?=
 =?us-ascii?Q?whTT2Rdyg0Fsq3idEHTjhC+tVUF4se4U0METsgnxuUMD53p3juZ61ilIci7N?=
 =?us-ascii?Q?hsySCfn4BeLnd7d/ze5k+5e+ZaDEJg1Gke3IgJxqlU99AkCG8Zq9k4GtPEHZ?=
 =?us-ascii?Q?C8hnx9OI+FvmEkpoPbNNeFe9sqH8Vdfi+sq7e72C9il6e2d1j6rpJOFFZ92B?=
 =?us-ascii?Q?9HMv7m5NuHRhp9U4Os7Xags6cnVu2n0emgtd7eaGUrMGHLhx3QrxyqOAfblC?=
 =?us-ascii?Q?8PXDFM2bsDfUBQEEWOXL6jtQ/v2kya++a2WUhid6YIBVOGum49AjLDOtlpCj?=
 =?us-ascii?Q?68/z245lLWEJKL+bvKHqH+arelWHrf9Qm3QXYrbCpYZlng82ZgqzdvDO5u2l?=
 =?us-ascii?Q?eTP/rtFZ4agXA8ngNt+ZKs08MeShwb95LrfR263Agqa2rIH8BxhG3iQxBeRZ?=
 =?us-ascii?Q?3EAW4RXfmIc5hK2YmiLk9xuEXXteRFlx2PJ+qYvm8rDRAZHF/AR2uCpvCxw/?=
 =?us-ascii?Q?4TpB8w/i8/bTlezlgskq90Sa1WG+kFw98bdBek+GA8XzArY7ONo8HwmJnULM?=
 =?us-ascii?Q?YJ8JUrpaiXKpHq9g238dT2b1bBnaoctLIJJB/3Pn5jgvLjKUDvgzXpJbgos3?=
 =?us-ascii?Q?pkkASnHL+dcKYFRHm4qAON/7WrhzSPWIsM/OJykxuLugSgSe3ngQ78BIGG5D?=
 =?us-ascii?Q?0ZbodqhXUe0uPl0QPB0RMH0gtnDS1xZTUWt9J7Sa0ed+9gFDPC9HydPS4MuW?=
 =?us-ascii?Q?uOEVARhN/H+kHqwnAD6p6Kb2SVfIWb40X1XUK/fvS/GmtcMgxPW227fqWNBO?=
 =?us-ascii?Q?wRI92CNC3/yJW3N3HEgp3jUr0BdypmL0rTKtlsFH654OvyECX+Oy4SczE3/P?=
 =?us-ascii?Q?0BAGRKB74t6/c9Fp9CmjxBsVbcW9qOCSBK3OEAG0hplqJQiyMvYlJqjY0H9V?=
 =?us-ascii?Q?EeSTjx2yvDQA+SaYkuS5CxyaYAfcPYmLaYCMg84u5y8ubsCMvn8Qkjj7XGYt?=
 =?us-ascii?Q?8Sas5E7EwTAZGFOi1xje1sIW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28731b8-558e-4401-8d42-08d911096a5f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 03:37:18.7775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvbBW+ARh+m8ubur2n0b4ZHCS+cutmB4KdTQzMdwR/hD7CYLQUYSIvR4ruRlRA8b7lWMspNnq4fTP/jLK/LmVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4557
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
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 51 ++++++++++++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  1 +
 2 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 940165f4437d..1440e4e555f1 100644
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
@@ -1131,32 +1137,43 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     struct amdgpu_device *bo_adev, struct dma_fence **fence)
 {
 	struct amdgpu_bo_va bo_va;
+	struct ttm_resource *ttm_res;
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
+		ttm_res = last_domain ? prange->ttm_res : NULL;
+		pte_flags = svm_range_get_pte_flags(adev, prange);
+		r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, false, false, NULL,
+						last_start,
+						prange->start + i, pte_flags,
+						prange->offset +
+						((last_start - prange->start) << PAGE_SHIFT),
+						ttm_res ? ttm_res->mm_node : NULL,
+						ttm_res ? NULL : dma_addr,
+						&vm->last_update);
+		if (r) {
+			pr_debug("failed %d to map to gpu 0x%lx\n", r, prange->start);
+			goto out;
+		}
+		last_start += prange->start + i + 1;
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
