Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838E5CA0EEB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 19:38:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F016910E05B;
	Fri, 22 Aug 2025 19:38:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NvnPZLml";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EB8610E05B
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 19:38:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/z+p32gfo2r05iQLDEI2m+c/uOFrjhEK2O6GS7tw75eaeo4HovJ7UyeRWOJkQ5FSvw7wgBJZiWkrVON9eU7whWJNzUQMHh8W0UKmYpGwAC/AVLglSY2DcLG3VL8xjio1HfLg18mhW+MbPCATujVzFho+Q5x278kynmNrBZn6Wkp+G9za3iUpss8LxFdwBUhr85f0Jomt4JZG0cz5vDJpO1Y9S2Jmm7KYzjRYh9qcaD9DujE9IIfpOXt36n/jiYWXFxMo9H6IKOISukGheCB+XbinGdTv5l9JoBVbLMYt8iMO7k4fHiaYEU16cvZzJtBYdYoxL89jOhHp4+xDJr5Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHe+Vkk6VAQwfNUOrafPch+cVgeXSvlDFTxp0jLGf7M=;
 b=UA6ouoQ4pLDmubV08eeS+XkjiVNzlE+indfY6xjuxFFnAzrW4tLl9qoWoIRHLVcDMeYJ4Py0hApAVJLiwzEzKZWwgPQ52/9eqzPeijF1CnVvUyMEmdpCi3MYlKwfWs0hnjQHziVdmHggsgq9H5c9FmDfOKb8/A4opPV+7y7JVk5Ob6GS4ut2QBGhhj2SKZcrUtYwkuH5YLTBJC8lePjyh5boJYZqcGgvIKFqjLzKahd6JOAkqZK691xlNDpl+RNH8AGmnYQZ2lJuvq1vjbEcfGIE8sGdAJAjPafgjZES2QjTB3LDWG7oQwvOXNZuX95+u1qGV/69b7o5oGpgWh6JGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHe+Vkk6VAQwfNUOrafPch+cVgeXSvlDFTxp0jLGf7M=;
 b=NvnPZLmlmonie3FcDKygS6AcJXpI5uAvEsxHyl+t8eIi1HlnVGRZn9l0uGTwx94HPlL9Nsq+io/Jl1yECpdO19uy5BQUb6TF5Zmr8fHJXXzOcI8Yf+o4wcBcmMaSEGGOXqCP807xD6PyYcZJfd8KXP5DEUTds9XoyXEFAm82GXk=
Received: from MW4PR04CA0232.namprd04.prod.outlook.com (2603:10b6:303:87::27)
 by MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Fri, 22 Aug
 2025 19:38:25 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::e5) by MW4PR04CA0232.outlook.office365.com
 (2603:10b6:303:87::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.18 via Frontend Transport; Fri,
 22 Aug 2025 19:38:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 19:38:23 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 14:38:23 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <philip.yang@amd.com>, <chengjun.yao@amd.com>,
 <jamesz@amd.com>
Subject: [PATCH 1/2] Revert "drm/amdkfd: return migration pages from copy
 function"
Date: Fri, 22 Aug 2025 15:38:00 -0400
Message-ID: <20250822193801.292575-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|MN2PR12MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b6bd11-d00e-4fac-ae97-08dde1b3754a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CnPQ1g30+cD+oBkm4wJlNSfLBLMZbQIunYZHgWccTfu5j5Nlv8Ss/zTDe1gE?=
 =?us-ascii?Q?WhBgTXAIcBBueo6L6mnPYKEBMJ+F8zEBMrvwLp3Cwv+Lp5TewZkfrgZE5aIt?=
 =?us-ascii?Q?NHZhiBXx8hWn6uKMljdsGXLQwGIrLLkh8MDurFIzFRPf6G2Fynn8Qs5lu/kv?=
 =?us-ascii?Q?ymddyniRnksngV9Q9R/EPOWpPmqwLidixScFRLxXRgOX0GfeSGmASa65aZa6?=
 =?us-ascii?Q?wLstI1IUeItnpbl5EsP3oYnUQeQe2qQY/5XhOBdJWpnWpnLlSD3PDwDGE0sU?=
 =?us-ascii?Q?+SkfuKQ0BV8QyuxTXHzWcFzk9f2CZu5IK+eXyP93CoobKeqe38hLpmifrm/k?=
 =?us-ascii?Q?d582Dt3Z1niVF9rHaocJXBGG0HR8RQ3L2YIJ/2Ejp/oZlWpdtskbwDXTGte2?=
 =?us-ascii?Q?ZpKDkdmIHf/jr0Pi4+citUu5NvACcr9tgBFgVF01vHssYJJdKzpxyjNdm18Q?=
 =?us-ascii?Q?CtOQ2c35Yqh/te810eoqVQ8iVaSpgHHZ3Nak7AIzSkZoHsvLoLeldf7V1R63?=
 =?us-ascii?Q?IfpD4+1gndp23L6hhqsz/kjn4NWShOar5cu6Jp18pgHDXhMJSSbeJ67GL79W?=
 =?us-ascii?Q?4K8n4WVkXka4pJ46A8oXJuq8NguVuwjnB0+H+USAVcIp+HusPbcUcLkFRe7B?=
 =?us-ascii?Q?C+/hMZbML6KJ8f3d6JkTG97aBVZYBtz0RqpJWBBT1+N5nvP1crqVAkn20lh0?=
 =?us-ascii?Q?cvVKxucfoyncPf4NQ5FO3jPkKlcDwKviyt+uPo6BON17PFMGMlGjCTDXaTiH?=
 =?us-ascii?Q?Os0qRoU4lfSVfJ+A2nbCFtbzUscxtGatEgo/h7ArhGcCT3o357e9ho9b17Xx?=
 =?us-ascii?Q?3SgcqojpIRIp7uty3rU6h/0vHqtDTYbe/nAqVI2waMybBUJpoLD8fpC8ujQC?=
 =?us-ascii?Q?Nkd1iDYf4YZH5Lp+1mKQorvBpPsVYUKN6AHWZeNPH8qr6NxdARkfGdD1x/Mw?=
 =?us-ascii?Q?L0BjkTpyzj+WZnhh0uTEWjD5ACWgXXLSVdgql8U236h1/c792LXRWf2EvXoG?=
 =?us-ascii?Q?stML2A2xkzyhAm0nzYOOLzvpVSYa4VxGI8pPu95nI2sQVeO7jJ4ysShNN8ic?=
 =?us-ascii?Q?l+aXS7ivkdSNQuzFP3B4j5FA7hHiVAwoOR9fP6cWvSe1STWnaNOk5g/Iif1z?=
 =?us-ascii?Q?KrM5WDrkplwmlQv36Dw+bXE5Jfin8Y4214/yQjptVpC7Iy1WlPY/9G4i4Mgn?=
 =?us-ascii?Q?JgsjXaHT42jW4P/7tzORbwpekWRAMJ+4OAGEbD2CjR3OIE7OnRTr5S8pz83J?=
 =?us-ascii?Q?3+4Pr7aTcat7xdd55RJwQ327QXz8pcbnkDauEUwghHL7qdij/sAf/Txlp95O?=
 =?us-ascii?Q?2/11V2ZFnGGNh/quqwBEYIH+XDfv+VcMVRKJI+L+KGU84IVCPHyWC9VeOiBi?=
 =?us-ascii?Q?uVDMyS/xskeADsSTix73ag3pez5zRYDwqVX4kL/lnz+SewEhpH5PJMxgC17X?=
 =?us-ascii?Q?VVbmQgHShaY92g54gHV1Qkyv40DkQg1sWQcGG+iplkCqqUEyn8MQOcMeXYOv?=
 =?us-ascii?Q?sEoQyupVnLwCnEtQBXqjhU2V5jDfu5lmj8ja?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 19:38:23.9056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b6bd11-d00e-4fac-ae97-08dde1b3754a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238
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

This reverts commit cab1cec78c8fd52e014546739875a81150f11080.

migrate_vma_pages can fail if a CPU thread faults on the same page.
However, the page table is locked and only one of the new pages will
be inserted. The device driver will see that the MIGRATE_PFN_MIGRATE
bit is cleared if it loses the race.
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 72 ++++++++++++------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 5d7eb0234002..f0b690d4bb46 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -260,7 +260,20 @@ static void svm_migrate_put_sys_page(unsigned long addr)
 	put_page(page);
 }
 
-static long
+static unsigned long svm_migrate_unsuccessful_pages(struct migrate_vma *migrate)
+{
+	unsigned long upages = 0;
+	unsigned long i;
+
+	for (i = 0; i < migrate->npages; i++) {
+		if (migrate->src[i] & MIGRATE_PFN_VALID &&
+		    !(migrate->src[i] & MIGRATE_PFN_MIGRATE))
+			upages++;
+	}
+	return upages;
+}
+
+static int
 svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 			 struct migrate_vma *migrate, struct dma_fence **mfence,
 			 dma_addr_t *scratch, uint64_t ttm_res_offset)
@@ -269,7 +282,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 	struct amdgpu_device *adev = node->adev;
 	struct device *dev = adev->dev;
 	struct amdgpu_res_cursor cursor;
-	long mpages;
+	uint64_t mpages = 0;
 	dma_addr_t *src;
 	uint64_t *dst;
 	uint64_t i, j;
@@ -283,7 +296,6 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 
 	amdgpu_res_first(prange->ttm_res, ttm_res_offset,
 			 npages << PAGE_SHIFT, &cursor);
-	mpages = 0;
 	for (i = j = 0; (i < npages) && (mpages < migrate->cpages); i++) {
 		struct page *spage;
 
@@ -344,14 +356,13 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 out_free_vram_pages:
 	if (r) {
 		pr_debug("failed %d to copy memory to vram\n", r);
-		while (i-- && mpages) {
+		for (i = 0; i < npages && mpages; i++) {
 			if (!dst[i])
 				continue;
 			svm_migrate_put_vram_page(adev, dst[i]);
 			migrate->dst[i] = 0;
 			mpages--;
 		}
-		mpages = r;
 	}
 
 #ifdef DEBUG_FORCE_MIXED_DOMAINS
@@ -369,7 +380,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 	}
 #endif
 
-	return mpages;
+	return r;
 }
 
 static long
@@ -384,7 +395,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate = { 0 };
 	unsigned long cpages = 0;
-	long mpages = 0;
+	unsigned long mpages = 0;
 	dma_addr_t *scratch;
 	void *buf;
 	int r = -ENOMEM;
@@ -430,17 +441,15 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	else
 		pr_debug("0x%lx pages collected\n", cpages);
 
-	mpages = svm_migrate_copy_to_vram(node, prange, &migrate, &mfence, scratch, ttm_res_offset);
+	r = svm_migrate_copy_to_vram(node, prange, &migrate, &mfence, scratch, ttm_res_offset);
 	migrate_vma_pages(&migrate);
 
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
 
-	if (mpages >= 0)
-		pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
+	mpages = cpages - svm_migrate_unsuccessful_pages(&migrate);
+	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
 			 mpages, cpages, migrate.npages);
-	else
-		r = mpages;
 
 	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
 
@@ -450,13 +459,14 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
 				    0, node->id, trigger, r);
 out:
-	if (!r && mpages > 0) {
+	if (!r && mpages) {
 		pdd = svm_range_get_pdd_by_node(prange, node);
 		if (pdd)
 			WRITE_ONCE(pdd->page_in, pdd->page_in + mpages);
-	}
 
-	return r ? r : mpages;
+		return mpages;
+	}
+	return r;
 }
 
 /**
@@ -567,7 +577,7 @@ static void svm_migrate_page_free(struct page *page)
 	}
 }
 
-static long
+static int
 svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			struct migrate_vma *migrate, struct dma_fence **mfence,
 			dma_addr_t *scratch, uint64_t npages)
@@ -576,7 +586,6 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	uint64_t *src;
 	dma_addr_t *dst;
 	struct page *dpage;
-	long mpages;
 	uint64_t i = 0, j;
 	uint64_t addr;
 	int r = 0;
@@ -589,7 +598,6 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	src = (uint64_t *)(scratch + npages);
 	dst = scratch;
 
-	mpages = 0;
 	for (i = 0, j = 0; i < npages; i++, addr += PAGE_SIZE) {
 		struct page *spage;
 
@@ -638,7 +646,6 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 				     dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
 
 		migrate->dst[i] = migrate_pfn(page_to_pfn(dpage));
-		mpages++;
 		j++;
 	}
 
@@ -648,17 +655,13 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 out_oom:
 	if (r) {
 		pr_debug("failed %d copy to ram\n", r);
-		while (i-- && mpages) {
-			if (!migrate->dst[i])
-				continue;
+		while (i--) {
 			svm_migrate_put_sys_page(dst[i]);
 			migrate->dst[i] = 0;
-			mpages--;
 		}
-		mpages = r;
 	}
 
-	return mpages;
+	return r;
 }
 
 /**
@@ -685,8 +688,9 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 {
 	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
 	uint64_t npages = (end - start) >> PAGE_SHIFT;
+	unsigned long upages = npages;
 	unsigned long cpages = 0;
-	long mpages = 0;
+	unsigned long mpages = 0;
 	struct amdgpu_device *adev = node->adev;
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
@@ -740,15 +744,13 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	else
 		pr_debug("0x%lx pages collected\n", cpages);
 
-	mpages = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
+	r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
 				    scratch, npages);
 	migrate_vma_pages(&migrate);
 
-	if (mpages >= 0)
-		pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
-		 mpages, cpages, migrate.npages);
-	else
-		r = mpages;
+	upages = svm_migrate_unsuccessful_pages(&migrate);
+	pr_debug("unsuccessful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
+		 upages, cpages, migrate.npages);
 
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
@@ -761,7 +763,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
 				    node->id, 0, trigger, r);
 out:
-	if (!r && mpages > 0) {
+	if (!r && cpages) {
+		mpages = cpages - upages;
 		pdd = svm_range_get_pdd_by_node(prange, node);
 		if (pdd)
 			WRITE_ONCE(pdd->page_out, pdd->page_out + mpages);
@@ -844,9 +847,6 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 	}
 
 	if (r >= 0) {
-		WARN_ONCE(prange->vram_pages < mpages,
-			"Recorded vram pages(0x%llx) should not be less than migration pages(0x%lx).",
-			prange->vram_pages, mpages);
 		prange->vram_pages -= mpages;
 
 		/* prange does not have vram page set its actual_loc to system
-- 
2.34.1

