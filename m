Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF711CAC582
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 20:43:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9468710E2D4;
	Tue,  9 Sep 2025 20:43:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sdws8EF0";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E33D10E345
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 20:43:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0wUF4BxERFKS67OkG3vNaH6NL5/1vpt5EGwDfdKmiqd2TNdd7/6h4o2pOSq1R1KeuRJK8nZ2PF9+kvgjDUpt8uULu7BiApPo83XFSvLhtRA33SB22FQt05GgtJrVfVlLfUh85IUDyLamgAi5xwR/781AgbPSRILarOwvAeRyAsQ9T648hCszvhgvE3X2AOlYEBhSJVPl9cVbsE8Sp0AR3oldlA8Nwwhh26m0LsU/qrB86zGmmst1qx2cri+0x6PqeJGf4Yw6fd9NEc0qjKiLPVvTYySQ6slNDQEtb3aCtOnFH+MQM4ht837mfstASdK0JZ4esXeh0Dev7RzXI7niA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3zuHXk4g6R5MOfuyZp2Z+JvmZ2lOP9jGPW/DtP97Fc=;
 b=Ve7sFkgsq4zC28GH3AUWjNDbTXcCMfZgzxnVxyj83ffM1witZkoJ8kp/LXyOdb8/312sZJMYND/5G+xmHBo2wDoYBjGLfw6sui3EVf48OHTSserGWwYHCjR5C8oYUxTnEzdLMzQ8RBX7z7vYGdpd02fSa2HEzGPHzrljLU928953QaWPLwrcP3/JU+t2nVJb+9mJ0Yt6Lhz0AtFBcLndZr3bJqNIqhP4hPd+1L1BaCqtXpaDqP7tbAMGe4CV3MwQVFe2lQzYu8bHaJ+thyDfVxacfdmbW9Ct4Yx66qANObfQ/+HoQPYQ/GOxpRWMpTlT/4ZJSol4uGpI8SepI7vqjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3zuHXk4g6R5MOfuyZp2Z+JvmZ2lOP9jGPW/DtP97Fc=;
 b=Sdws8EF0kBDulJdChltV+iq1U8ducwyLDHqLN2pqlXLjQBSR8Pl3cD0xRQ5zDNbEeyTkc1S6fRUrkyic5loxlya5OhEK/LyI9PSd8vaT28VPzuun2jWIs4aJXn8UejAIehSxxvIJvHDz7irTtxH1zsIQJ+SeSX1IqTgA45ylKFM=
Received: from BL1P223CA0042.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::11)
 by MW4PR12MB6801.namprd12.prod.outlook.com (2603:10b6:303:1e8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Tue, 9 Sep
 2025 20:43:13 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:208:5b6:cafe::82) by BL1P223CA0042.outlook.office365.com
 (2603:10b6:208:5b6::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Tue,
 9 Sep 2025 20:43:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 20:43:12 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 13:43:11 -0700
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <philip.yang@amd.com>, <chengjun.yao@amd.com>,
 <jamesz@amd.com>
Subject: [PATCH v3 2/3] drm/amdkfd: add function svm_migrate_successful_pages
Date: Tue, 9 Sep 2025 16:42:59 -0400
Message-ID: <20250909204259.103856-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908161526.99413-2-James.Zhu@amd.com>
References: <20250908161526.99413-2-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|MW4PR12MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: 20cf354f-bcc9-4920-c850-08ddefe17e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KFdHNdhFHzVnRyuwmXoqGqoBk/CzORRcDKjEgjeyLxnkVuPC+dFJVTX9tP4S?=
 =?us-ascii?Q?a2/OkqZMJ9tDZDVGw2muhg5ccRjdr1oRj/D0k1dJZu8doM+KTPtexw5g0q/o?=
 =?us-ascii?Q?UOJNKT+lxBFy/3j/M8SZcFtF5vv2BcdmqD70WAxBo6DB1o4vdkj6CUsmHTcJ?=
 =?us-ascii?Q?9fNwil4Wx4TDZmlEm9isnkYA1R2K1ZdlLv2LKV4BTorzp+Bs6wENip0ewRPo?=
 =?us-ascii?Q?eZUorZPXq7cc8jrS2I9oSqjW6SoJCmTL7H4+/xEPVIHZTPVffdAtRXETlynx?=
 =?us-ascii?Q?feaCTxZ25dpgNaIeB2zTIM6wXLWPwqlEXfK7shc7xpNj6Ic4EuL/+esLef5W?=
 =?us-ascii?Q?Ti7lmpZotMncrSr1TngkmKwzTbYQLqfvRTg0KpoMu/UJ9rssrP/yl3PDRKh3?=
 =?us-ascii?Q?qyMAFwKWNM9xt1sL2FXWUqmVNsEEr8/8ED+sLv8XsupA1UzgYBpCYsXcUZlW?=
 =?us-ascii?Q?Z9PxEs7JAryyZXWXqRlHSoeSCxLqyojFgV28ybromWkOK5+8M/MPLLhnaJJh?=
 =?us-ascii?Q?UzQl3yHUR3UlMXeUumZn1v/GxZF7XqnmuMbVMeidKap3KEjKewppYGJ0ytkh?=
 =?us-ascii?Q?aE+ZEv30y3JntI4lawkQNimftSwCxc/nBJi0wv+kI0OiqG6KdoCUArgbfd+S?=
 =?us-ascii?Q?jYPmvcPVPtnlXrXZGJNtVTSEfTe1sShBwTQDEtu18lEK3bkBwPkllsKzL9lK?=
 =?us-ascii?Q?MQDA35YrpIBht5+9dXweRKz3nM4U8zpmBWPBoSxGtCF0eFpaooyUEmYdnDTr?=
 =?us-ascii?Q?2i3bSZzdayI10RDgIzqy55GutHxPV63RK3767mRsHrlq+GoYyWGIHRMvo8oH?=
 =?us-ascii?Q?f7waT7SMFJOcZYUjrRGjyhnDtpTB5G4gmX+aiy/wNMNCEjoD0RDzEfHSRJza?=
 =?us-ascii?Q?W97l5D5ju4uvMMKb9lvji2kSsOfRB8pls0aqvyXlbGJ3G9Q8rPck9+sXvPme?=
 =?us-ascii?Q?WuliB8rzkxYd/2isTJFP1PRo/y7VCFitHc1tPPTs9VUJhQcHckVZ8UlcJTZe?=
 =?us-ascii?Q?qI8Po85bxQjkpPUPaDE0HFpoaW72gpba6cPMflUkHjtCtliEcwfOW3HsbmVT?=
 =?us-ascii?Q?G62wFN12xfUNjVXQ7z+xYGXaijAtMkN31IuTaYyyWltBrFWejj0eZKfpFmWC?=
 =?us-ascii?Q?WYvwQE1A5uCdlqPZWWfTxNGwZw/mhOxsutVLy4UuswcpbMBBspLkdWQhS7ab?=
 =?us-ascii?Q?ss00oK9J6Ow8rAXimMeZkAYzbDIC1D3yskaNlwKAWRm6mGhiKuRD8uHiJrNC?=
 =?us-ascii?Q?eW8dCg6NJ/qgbf4wF2MIr+2bgHVNOI1MTufn29hz844ta+ESUw+Cjx58Ys7O?=
 =?us-ascii?Q?6FWKTxQDoHV0Z60sZGXn3JFolTmIvvOoXNb+SHS2dhYAe9f+Tmh91gyA3N/Y?=
 =?us-ascii?Q?xhBbpNrQXmkGRvIL3wCDfnyiWdAo0kr0h2sHNlboE+mXLQwWSKuXn4oH2GES?=
 =?us-ascii?Q?TvpfTH+ScWII5WjfVklg2Ic+l1WhSB8FkM0iftrBNfVMkFS1Ida2hK1x9YIX?=
 =?us-ascii?Q?QPOAWJonEZBHJbmZk7YGvaoFWt5Lijm9rRt+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 20:43:12.4708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20cf354f-bcc9-4920-c850-08ddefe17e7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6801
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

to get migration pages. dst MIGRATE_PFN_VALID bit and src
MIGRATE_PFN_MIGRATE bit should always be set when migration success.

cpage includes src MIGRATE_PFN_MIGRATE bit set and MIGRATE_PFN_VALID
bit unset pages for both RAM and VRAM when memory is only allocated
without being populated before migration, those ram pages should be
counted as migrated pages and those vram pages should not be counted
as migrated pages. Here migration pages refer to how many vram pages
invloved. Current svm_migrate_unsuccessful_pages only covers the
unsuccessful case that source is on RAM.

So far, we only see two unsuccessful migration cases. Since we
can clearly identify successful migration cases through dst
MIGRATE_PFN_VALID bit and src MIGRATE_PFN_MIGRATE bit within this
prange, also eventually successful migration pages will be used,
so we can use function svm_migrate_successful_pages to replace
function svm_migrate_unsuccessful_pages.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 30 +++++++++++++-----------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index f0b690d4bb46..10e787e47191 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -260,17 +260,18 @@ static void svm_migrate_put_sys_page(unsigned long addr)
 	put_page(page);
 }
 
-static unsigned long svm_migrate_unsuccessful_pages(struct migrate_vma *migrate)
+static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
 {
-	unsigned long upages = 0;
+	unsigned long mpages = 0;
 	unsigned long i;
 
 	for (i = 0; i < migrate->npages; i++) {
-		if (migrate->src[i] & MIGRATE_PFN_VALID &&
-		    !(migrate->src[i] & MIGRATE_PFN_MIGRATE))
-			upages++;
+		if (migrate->dst[i] & MIGRATE_PFN_VALID &&
+			migrate->src[i] & MIGRATE_PFN_MIGRATE)
+			mpages++;
+		}
 	}
-	return upages;
+	return mpages;
 }
 
 static int
@@ -447,8 +448,8 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
 
-	mpages = cpages - svm_migrate_unsuccessful_pages(&migrate);
-	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
+	mpages = svm_migrate_successful_pages(&migrate);
+	pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
 			 mpages, cpages, migrate.npages);
 
 	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
@@ -688,7 +689,6 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 {
 	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
 	uint64_t npages = (end - start) >> PAGE_SHIFT;
-	unsigned long upages = npages;
 	unsigned long cpages = 0;
 	unsigned long mpages = 0;
 	struct amdgpu_device *adev = node->adev;
@@ -748,9 +748,9 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 				    scratch, npages);
 	migrate_vma_pages(&migrate);
 
-	upages = svm_migrate_unsuccessful_pages(&migrate);
-	pr_debug("unsuccessful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
-		 upages, cpages, migrate.npages);
+	mpages = svm_migrate_successful_pages(&migrate);
+	pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
+		mpages, cpages, migrate.npages);
 
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
@@ -763,8 +763,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
 				    node->id, 0, trigger, r);
 out:
-	if (!r && cpages) {
-		mpages = cpages - upages;
+	if (!r && mpages) {
 		pdd = svm_range_get_pdd_by_node(prange, node);
 		if (pdd)
 			WRITE_ONCE(pdd->page_out, pdd->page_out + mpages);
@@ -847,6 +846,9 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 	}
 
 	if (r >= 0) {
+		WARN_ONCE(prange->vram_pages < mpages,
+			"Recorded vram pages(0x%llx) should not be less than migration pages(0x%lx).",
+			prange->vram_pages, mpages);
 		prange->vram_pages -= mpages;
 
 		/* prange does not have vram page set its actual_loc to system
-- 
2.34.1

