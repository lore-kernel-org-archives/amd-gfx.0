Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A50CA1016
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 16:15:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 492FA10E57F;
	Mon,  8 Sep 2025 16:15:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mx84zkJC";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D6EF10E570
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 16:15:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFae1jL4focIDho/fA2ax9W6CYhZwS2fQwshu/9ywBJyBDU9KC0m3VkubmUOFFEYfFXsF6x9eV95ZQwSH/g5G7d+omD/7/q9BASCmDewT5EtrbSQj3pKHQzWupIQnLk7P4TbbA6dM/A25nlJpxKc/UXCTXBFytL7wt4CsfL/39UJg4n/w1jQ1B4gDGVjyrTxYcUC4ONFoHOiWvKi9BeZBkyHd/SdUdneJgJGxL66lbKgtPIzQr751tTno3oGYiEVJ/ztvcg9rc22FanX7WpbZ9FBLMIHpk+ivk8CyKR4kp3RdUV/d8YM+NYQR/bdo34kz4mz0VvID5ZQG64JCNYEVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHe+Vkk6VAQwfNUOrafPch+cVgeXSvlDFTxp0jLGf7M=;
 b=W4LhFZAY8I2mxkZq5vM9pVljxUKQ7V9n0/cGE1FzORR1GUC5Y4CfTwF8X0t9vpmiLwFinJlz4t+FM2OXNk+sOWZnD7MK0fVlUuphrgpCRJx2wuDpb6BP5tgeGmfG7eVdX7tSTxPYsgdXyGin77JwW68EpzFs/Ar6HWDtmCYqwP+fIR9fT2RMPYEpJtzPxg6RV7b+jtS2dj9qSSy94hvLeWN2m8daDSnxYUo5dVNwM2tQupt09vZd1yt8DXbo5rCyarkFXuNC8bVSz1Nplk4NTBzA/RpmcnQUoIJxuZ2TZaxEzJJpUyDUPggLq9xNxyhSk80s9DRC+fJIyeAh9KxHMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHe+Vkk6VAQwfNUOrafPch+cVgeXSvlDFTxp0jLGf7M=;
 b=mx84zkJCgqtRyrneyANfrsQ7RlFn9Dgdb8Tukxe1y5x5MzyZjewEVtfHMwqtxtp5CevVAk9rOFjexXfa+H8IS48DBeLKJijFf6wK+xs+3lwAk0YfKXpGLTcB24aSGdaE8b+sF0dWjfGtQKI+VNpXPrWuqlfm8mLg5EY9rKaUKCI=
Received: from BL1PR13CA0347.namprd13.prod.outlook.com (2603:10b6:208:2c6::22)
 by DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 16:15:37 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::2c) by BL1PR13CA0347.outlook.office365.com
 (2603:10b6:208:2c6::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13 via Frontend Transport; Mon,
 8 Sep 2025 16:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 16:15:36 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 09:15:35 -0700
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <philip.yang@amd.com>, <chengjun.yao@amd.com>,
 <jamesz@amd.com>
Subject: [PATCH v2 1/3] Revert "drm/amdkfd: return migration pages from copy
 function"
Date: Mon, 8 Sep 2025 12:15:24 -0400
Message-ID: <20250908161526.99413-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|DS7PR12MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: bb2e7bdf-3ce5-4a34-f327-08ddeef2f203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DBQv5BbppeiYaY5wW/YfUXTA7uu7Xk9OdZ8yac02cwt/Q+27YRT5r8VSq4qm?=
 =?us-ascii?Q?RbePNXRsBccXOK4gomapO+Q5C6pxf4XqjdGHTefJOf8/XWfpX9R7eKXy9YBp?=
 =?us-ascii?Q?2U4Nt4A1b8XN/ATGKxEr0CLoV0WUYs4Vmw/xBWLpwVDTbESbHPd78R9KOncG?=
 =?us-ascii?Q?DFEP3P+CCEhnXQcyqI/OdwLvvqOBrHhYLWsc1OZBd4Jxda1L2hKdG3sRMOgK?=
 =?us-ascii?Q?2vVJ2lgbUo56n/So8GNcNO8x1QLsYx5tCRVYGcfpNUipxhZKSpNL1MuShSet?=
 =?us-ascii?Q?K6D7latrib7+wGsNszluT2EAOG2eNNIrBoxpqitRpdaDrUwBLQjD7wQg+xsV?=
 =?us-ascii?Q?1RHYObzL7Ffq7sFpPBb6uGghpRMwyXizou9WXkT6RKa32aASxxIiGmsSaf9q?=
 =?us-ascii?Q?oxbS2Twaxi/buSBQ/HtxW9fELU+GX6Zy++a5ewrZnyFMLjxDwZAYuzhUsWYC?=
 =?us-ascii?Q?JQETg+l17dZD7MqujPpESemDcsSyH8ld2j2JxcMcnRF5X86rFPAlEjYFbG2l?=
 =?us-ascii?Q?Ie6XlyvDKVxWzVKhWQAoCAvlddo8SvKqCXIXyeQzb4QQ+pRWmclFWqPTvG/a?=
 =?us-ascii?Q?mdsXQABK/CfwbnoUuPPdpLk3EL8ZT15ZNWpRhHoUVB4BvyP1BixRfdgpNIVn?=
 =?us-ascii?Q?eJvEarVWbyVBYUX6SDhoq4sa6/NpJMFxwJ9QV36xP323JmI2tSDkY8OfwZuH?=
 =?us-ascii?Q?Q/JZ2+DuGDmUn4nWpxmiDhQzEnyyuFjT9xN9GX1V7BCEuVcqxnqtYFWAkfFK?=
 =?us-ascii?Q?+uX7rGav7lDillVwIqRH2mO2lkrftw43muO8CreXfWPBVW/x92EnMoTGnZTN?=
 =?us-ascii?Q?GTDpHGH0vNzRlCAnNbrQ0IZFOG0F0nGxJGY8VB3sWjM0E7g8C7D6iuJ2rsRj?=
 =?us-ascii?Q?Jzvqv5ByqaINMSqs5eWTMuRcuj/K9CS+WOJ60kxqs6ujkwbUI9UqjYaOyAnL?=
 =?us-ascii?Q?Bv4A92g14Z0XAc6x4luQMU4Q1BbBd3HbILlugUG9MUtZPtOG3x9B6GcAaia7?=
 =?us-ascii?Q?NhzpOIG4pJK9jaHVgbZFO6XWKhVNjALi/VQx7cAVjWRs1sdZmYD2hu3vFCtx?=
 =?us-ascii?Q?YIVsuiC8k1ZKpHZ+8UXkaDGrjeaOrAEEU/kQ9MlPdAaQVHPxfOsi7/Kb/8pP?=
 =?us-ascii?Q?w6P07MkX5ReeVb/A+6v8B6WerfnVSHwveLSIj8/0MxqEQMnK9/zIGr7n+Bkm?=
 =?us-ascii?Q?/5D8RmMMe1uJSXLir1Xl9QlWJj7yIPAAPQGClsFVKQ0pJgOy/CKMbty5XUpL?=
 =?us-ascii?Q?CHlvE/EEToo0uxOodzyLMDPXHfiyBZO7fHkSh2jQP+LhfVoljPKpmbO1oXYw?=
 =?us-ascii?Q?kGZj9Uc2nxeTax0+5TBqBZcFKg5tAlbfkqrCeDJL4SL1Iy0Loow3AgR1+lhv?=
 =?us-ascii?Q?UjCdA8BlR9hBsBu48CiraCsN2+NmJrWug1VRlCjo9BtRf4ygQpd6t+yeF3Lz?=
 =?us-ascii?Q?cav6V3FQYugU9f06WaNbCE/03rU9Jtfme/HQIN1PLjb4wKDJ6XeIndTKJkqo?=
 =?us-ascii?Q?mq1k5lvq7vvsut7tbikFqelfRYRdWzM4aMNr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:15:36.5882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2e7bdf-3ce5-4a34-f327-08ddeef2f203
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5765
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

