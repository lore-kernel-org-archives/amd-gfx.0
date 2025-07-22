Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F284C83F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 13:00:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E3FA10E2EB;
	Tue, 22 Jul 2025 13:00:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zpjjwfBt";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74F3F10E2EB
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 13:00:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpUDEFU84T/Yf1vmv32Jd+4MA1V0+Y/5iyMuT3KCNa4uWpPDx/PcRCLXbMy4lIpGIldzQROYpRUJdroyCcv1nsJJew4E/60ic9Ml75PyyWClwHSC40ioqJb4AQjJybi5GZiaJufQuCKKsRnHuceUyxIQMeuAIQPFYQnVtnQUJd8zhCqbIhK10qSzf+xGjTqv+K8YoQXavO4IB/OVz/EaNYe83CmaRzhJZXEbCA+xD9B0n7F+hvgflO8cjdwGvXTr+QETxGGj7vygQQrcsns/UuInPzRhujTZM/1bUs/zI723X2+7es34Vfh1vcI/ee3jRENlnQbBr8LvJqSgmw7xLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnKlvKstld1JbCOmOHzGRupk6TraKncytT9opSr+TwQ=;
 b=dv4HvRxYpMfaRKyKJogJ+M2neUhnKMUJ5mgtyyY62HNMixYyE5yfi8X0Jl7ibq5D2db+qYeqHPdJaKEjzj87qHJnhEdrc1sQLYjFXwgtmjyDVfafrXHwipJpmi8qzPThI9BGD3c4kFhNvs8n8tQSjuz9lV+USIxwKgJel6/euStv9AXjjwgbBbpmEEtwvIUFR20Q+Bo57XR89uHOfbpNcBgc3zDziLEXnyDf3S8ULAZpJJ6APxVQP/bu8js3LLjOfQ/qF4ET8ACpNqurhaSdOfWgyQIJsx2Wj9EUHSfdXdj0Sc+t7zb2EUPQQVdK/XgBzHeun0KUVBM7tiAqbUHkbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnKlvKstld1JbCOmOHzGRupk6TraKncytT9opSr+TwQ=;
 b=zpjjwfBtXWUZvdYr6cebQsElOvMMt6L+1WnQxDJFKYqxRJSIzNaKqoUmjm6STGLIRi15tWPbw1QPTulinmnajFO+8FA7bfE383MUU4bBAdRi7gaoEBUiPsqee5H4MO2teVcMXmDJKAGB/vmRykVamgzQt3fMCljXvEHUBNjdhJc=
Received: from BL1PR13CA0406.namprd13.prod.outlook.com (2603:10b6:208:2c2::21)
 by DM4PR12MB7504.namprd12.prod.outlook.com (2603:10b6:8:110::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 13:00:00 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2c2:cafe::1d) by BL1PR13CA0406.outlook.office365.com
 (2603:10b6:208:2c2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 13:00:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 13:00:00 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 07:59:59 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <philip.yang@amd.com>
CC: <Felix.kuehling@amd.com>, <christian.koenig@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 2/2] drm/amdkfd: return migration pages from copy function
Date: Tue, 22 Jul 2025 08:59:49 -0400
Message-ID: <20250722125950.7574-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250528171908.82639-2-James.Zhu@amd.com>
References: <20250528171908.82639-2-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|DM4PR12MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: f051e3d1-2606-45fd-19ae-08ddc91faae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0FoxSiHbCJd4Ws/L7OZNxvA/lXP8TxfgOHYKgZwUy2NL7BgPq/avLXryzVW3?=
 =?us-ascii?Q?bAn2I9Ei49Flr9oDL4xEPQ274OYFcF9kZiFNWwsA6beVifJO9GYUHHHcwFMA?=
 =?us-ascii?Q?JJv/3Dz5i1XbNMUo7mm7VLtBIMaXCONXPrwKKZztmpgVoRFVBV1Kr1ZaAz/P?=
 =?us-ascii?Q?wD4fzba9wjgZZzQnb3bVJeTE1AodSgcl6vFsJIw0uJjmDG07RfPx0dcUCznO?=
 =?us-ascii?Q?7yg0wAGONUpheGOnawxqbXZPjATaDQKikPKlExjA3fS38mDUQgN3+Fi/rTky?=
 =?us-ascii?Q?u7XXq5+DLGHY64CvDJgQmdN8lOwvfe60l/ulCv4pHzwaOK78KifNbHTouZFl?=
 =?us-ascii?Q?FoE2D3AND4nU5zavmpjgsABqsuH5nbBJEkicVQvDbXV2E7RQ8fIj993i/XCp?=
 =?us-ascii?Q?g6M2QrY28fMa5AJ62RbqeBwxXHbGDG1LS/taOyxTHt/GBlnxPJ5stKP/uIqw?=
 =?us-ascii?Q?WwuRi65j8wYxsHlKwFW8h1sjd82Bgkf2znbtzRyiOYw4QqSKsAMufHr7jIdE?=
 =?us-ascii?Q?XK/RmVIV2GMOQAvif0mRUx9H/3thQvA9Xkh3rpVGEKBrtu36H73qXdtxsmoS?=
 =?us-ascii?Q?HSPvlU5tEbawBhhijKLpTKwjzY97RiS/A+kQwb5dY0YDyFrrRGifna6n3f5a?=
 =?us-ascii?Q?qrBt4OO2qnwP6i+MyRO/KOxq25/8fGPbClGRq3MJSTw4bQwbzsOga18J4C0O?=
 =?us-ascii?Q?Xxwf9CuIzNuEvcy8BK2oenTjEiBbuJ5mI1nYzl2iXzmLdlhVb8MxnGcA+2/a?=
 =?us-ascii?Q?5/CE4RQOLnyL9gSXVDi+W8TMQw3xxWDS1lp8tX9Wnh3Dij8FEXZpACnNweZq?=
 =?us-ascii?Q?7eLnhM1IO0qRhakcT7JpAww7DCKLEAqyPwCF4bWqHs8N5XmQm2yZnt4IYH+6?=
 =?us-ascii?Q?UAlOIximhyiE0Kc+ox9bSbmkV2EIcE6wjIQo6Hc2KhlNGK6ZWAnVjPGIIaA5?=
 =?us-ascii?Q?5gCEcznlfNif1/RWIDU1jMmXaXGD+WKhdxifVeZbqJDjR13+4HwNyJoMs0sb?=
 =?us-ascii?Q?Oyy8wkQsaG7C17xbbTODUr0BQRa87uWPG8TtVJMnTZB3DLxTSEPzOAs39tzy?=
 =?us-ascii?Q?QoexM/iMVCZwxFVtHJFdah266zaEByxIen7d4afZHP3yKhEfvKvEVGVX6Op1?=
 =?us-ascii?Q?h1PkFheLriAWbOxXBPHmGKBCJEDaRJ7BQiH66KvF1uatpCiBqmKs7/dFFZDK?=
 =?us-ascii?Q?6ndBbZIFnK9K2IEeHBTvG+zQLYsqkN6DOEUs+dTP6qvNXBj1Uyjxo977Mb8l?=
 =?us-ascii?Q?5lF8n7M6uKwYEfEs6C1sC5zHakWaJpVVbDAbfu2MgH6H/+OL8G6HKAu49ZD9?=
 =?us-ascii?Q?ucYgDawWS3W37Q6q40sBRnHNCAgS4tpINGPPzVGmSJoqdNSSEOZfb0UiH4GQ?=
 =?us-ascii?Q?uP0WyOd1N2rS7oQ96GpK2CvA4kYSeiDMAW1Ewt4VOmyl3tUGfjwo8ynouksp?=
 =?us-ascii?Q?kAew3lxx5DUdBV4Q8bWQAKx3PGPHWKVKJ7GukAUhrZ2zq+csfTrPeB7MO+70?=
 =?us-ascii?Q?ezUNH2ngmqG5XR/2MSNpdFacpZhRxu7YeV2d?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 13:00:00.4154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f051e3d1-2606-45fd-19ae-08ddc91faae2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7504
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

dst MIGRATE_PFN_VALID bit and src MIGRATE_PFN_MIGRATE bit
should always be set when migration success. cpage includes
src MIGRATE_PFN_MIGRATE bit set and MIGRATE_PFN_VALID bit
unset pages for both ram and vram when memory is only allocated
without being populated before migration, those ram pages should
be counted as migrate pages and those vram pages should not be
counted as migrate pages. Here migration pages refer to how many
vram pages invloved.

-v2 use dst to check MIGRATE_PFN_VALID bit (suggested-by Philip)
-v3 add warning when vram pages is less than migration pages
    return migration pages directly from copy function
-v4 correct comments and copy fucntion return mpage (suggested-by Felix)

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 72 ++++++++++++------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index f0b690d4bb46..5d7eb0234002 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -260,20 +260,7 @@ static void svm_migrate_put_sys_page(unsigned long addr)
 	put_page(page);
 }
 
-static unsigned long svm_migrate_unsuccessful_pages(struct migrate_vma *migrate)
-{
-	unsigned long upages = 0;
-	unsigned long i;
-
-	for (i = 0; i < migrate->npages; i++) {
-		if (migrate->src[i] & MIGRATE_PFN_VALID &&
-		    !(migrate->src[i] & MIGRATE_PFN_MIGRATE))
-			upages++;
-	}
-	return upages;
-}
-
-static int
+static long
 svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 			 struct migrate_vma *migrate, struct dma_fence **mfence,
 			 dma_addr_t *scratch, uint64_t ttm_res_offset)
@@ -282,7 +269,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 	struct amdgpu_device *adev = node->adev;
 	struct device *dev = adev->dev;
 	struct amdgpu_res_cursor cursor;
-	uint64_t mpages = 0;
+	long mpages;
 	dma_addr_t *src;
 	uint64_t *dst;
 	uint64_t i, j;
@@ -296,6 +283,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 
 	amdgpu_res_first(prange->ttm_res, ttm_res_offset,
 			 npages << PAGE_SHIFT, &cursor);
+	mpages = 0;
 	for (i = j = 0; (i < npages) && (mpages < migrate->cpages); i++) {
 		struct page *spage;
 
@@ -356,13 +344,14 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 out_free_vram_pages:
 	if (r) {
 		pr_debug("failed %d to copy memory to vram\n", r);
-		for (i = 0; i < npages && mpages; i++) {
+		while (i-- && mpages) {
 			if (!dst[i])
 				continue;
 			svm_migrate_put_vram_page(adev, dst[i]);
 			migrate->dst[i] = 0;
 			mpages--;
 		}
+		mpages = r;
 	}
 
 #ifdef DEBUG_FORCE_MIXED_DOMAINS
@@ -380,7 +369,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 	}
 #endif
 
-	return r;
+	return mpages;
 }
 
 static long
@@ -395,7 +384,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate = { 0 };
 	unsigned long cpages = 0;
-	unsigned long mpages = 0;
+	long mpages = 0;
 	dma_addr_t *scratch;
 	void *buf;
 	int r = -ENOMEM;
@@ -441,15 +430,17 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	else
 		pr_debug("0x%lx pages collected\n", cpages);
 
-	r = svm_migrate_copy_to_vram(node, prange, &migrate, &mfence, scratch, ttm_res_offset);
+	mpages = svm_migrate_copy_to_vram(node, prange, &migrate, &mfence, scratch, ttm_res_offset);
 	migrate_vma_pages(&migrate);
 
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
 
-	mpages = cpages - svm_migrate_unsuccessful_pages(&migrate);
-	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
+	if (mpages >= 0)
+		pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
 			 mpages, cpages, migrate.npages);
+	else
+		r = mpages;
 
 	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
 
@@ -459,14 +450,13 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
 				    0, node->id, trigger, r);
 out:
-	if (!r && mpages) {
+	if (!r && mpages > 0) {
 		pdd = svm_range_get_pdd_by_node(prange, node);
 		if (pdd)
 			WRITE_ONCE(pdd->page_in, pdd->page_in + mpages);
-
-		return mpages;
 	}
-	return r;
+
+	return r ? r : mpages;
 }
 
 /**
@@ -577,7 +567,7 @@ static void svm_migrate_page_free(struct page *page)
 	}
 }
 
-static int
+static long
 svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			struct migrate_vma *migrate, struct dma_fence **mfence,
 			dma_addr_t *scratch, uint64_t npages)
@@ -586,6 +576,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	uint64_t *src;
 	dma_addr_t *dst;
 	struct page *dpage;
+	long mpages;
 	uint64_t i = 0, j;
 	uint64_t addr;
 	int r = 0;
@@ -598,6 +589,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	src = (uint64_t *)(scratch + npages);
 	dst = scratch;
 
+	mpages = 0;
 	for (i = 0, j = 0; i < npages; i++, addr += PAGE_SIZE) {
 		struct page *spage;
 
@@ -646,6 +638,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 				     dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
 
 		migrate->dst[i] = migrate_pfn(page_to_pfn(dpage));
+		mpages++;
 		j++;
 	}
 
@@ -655,13 +648,17 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 out_oom:
 	if (r) {
 		pr_debug("failed %d copy to ram\n", r);
-		while (i--) {
+		while (i-- && mpages) {
+			if (!migrate->dst[i])
+				continue;
 			svm_migrate_put_sys_page(dst[i]);
 			migrate->dst[i] = 0;
+			mpages--;
 		}
+		mpages = r;
 	}
 
-	return r;
+	return mpages;
 }
 
 /**
@@ -688,9 +685,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 {
 	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
 	uint64_t npages = (end - start) >> PAGE_SHIFT;
-	unsigned long upages = npages;
 	unsigned long cpages = 0;
-	unsigned long mpages = 0;
+	long mpages = 0;
 	struct amdgpu_device *adev = node->adev;
 	struct kfd_process_device *pdd;
 	struct dma_fence *mfence = NULL;
@@ -744,13 +740,15 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 	else
 		pr_debug("0x%lx pages collected\n", cpages);
 
-	r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
+	mpages = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
 				    scratch, npages);
 	migrate_vma_pages(&migrate);
 
-	upages = svm_migrate_unsuccessful_pages(&migrate);
-	pr_debug("unsuccessful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
-		 upages, cpages, migrate.npages);
+	if (mpages >= 0)
+		pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
+		 mpages, cpages, migrate.npages);
+	else
+		r = mpages;
 
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
@@ -763,8 +761,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
 				    node->id, 0, trigger, r);
 out:
-	if (!r && cpages) {
-		mpages = cpages - upages;
+	if (!r && mpages > 0) {
 		pdd = svm_range_get_pdd_by_node(prange, node);
 		if (pdd)
 			WRITE_ONCE(pdd->page_out, pdd->page_out + mpages);
@@ -847,6 +844,9 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 	}
 
 	if (r >= 0) {
+		WARN_ONCE(prange->vram_pages < mpages,
+			"Recorded vram pages(0x%llx) should not be less than migration pages(0x%lx).",
+			prange->vram_pages, mpages);
 		prange->vram_pages -= mpages;
 
 		/* prange does not have vram page set its actual_loc to system
-- 
2.34.1

