Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EF7C83F1B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jul 2025 12:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFB7910E492;
	Mon, 14 Jul 2025 12:46:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zPdWhqKX";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4DDF10E4AF
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jul 2025 12:46:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYRfZiNa8iKhLiegkI2w7httiBkYceZ7RV2Ixvk96/VYuw3Gy1+IwFZ36GOINr/6qfF/pnQALPAD1CHxVwd3XDBL3RgJTWXQOO6UrWZZMXSPbOz0/+JJCdJgAyB2I+ldYVGFkeaDeIte18F/Bg8P2VAXIVuAUtMdPROmyTlWi/DHElVwn+zt27Zep3wK4mkdn86J5sUF2cwYJ5xNIarcZvYIclGh0nYbD9GxJ0wRUeB8mUyjUtvZxi6bSe0YcqZSEV7QzDyPbDdpMPSY+L075Z0rLgdaqLSdbYGF3+ewRrW9GEJIjvfxBBJrYjm8HmDxbTLeNVpC67XprXkYvFfOrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAUS/eMba+9SI8El4WlqjjUVTLBolAxDcVAXjKOuE1c=;
 b=BQ4RoUmd1iwRXfqIlR+7aQ26awM6iZkHPB9gQh1kB+9oHuKjuxuThYQgDprJnJQkUuaa+HZroDYxr03wC96KRrzQ3pJYKe5fJRREGXp+32XA3xw+S0hTQI4OUgZnXYlKCUyo6EEa/fmp47dRoei6F7BG6A20iLriyNJK+yW+G0q76/2HIA//QFq6X4eUvp8q0Lxdlc3QfodOl4ATt/jpzTjjTkpLusJgohK0US+rnZ8AapnbfFz6AMgAILr40nvesPDrt9uCIElJudqtC+LAYQXmKUkRflIWUK6iDVqDQ1oscSmVNH5grXbAcjRxK6jyNaKyL1Ojbba7lnf6G85onA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAUS/eMba+9SI8El4WlqjjUVTLBolAxDcVAXjKOuE1c=;
 b=zPdWhqKX8eqn3Zmn9oDTvFTxUgGcz3qnCbVX8+aE4SUDW/9RlsZZk9TuqYHF0znNREzjXh3xc9X5g7sF+5xcWBWfX6+xuox4Ly3rojX1eC3c8yK+2WqpYtjL7lBdvcb8nMiucGE6iesl+1vSQsVyKXkxb0V4a/4k0A/BORd5VwM=
Received: from BYAPR08CA0059.namprd08.prod.outlook.com (2603:10b6:a03:117::36)
 by CY5PR12MB6083.namprd12.prod.outlook.com (2603:10b6:930:29::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 14 Jul
 2025 12:46:47 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:117:cafe::77) by BYAPR08CA0059.outlook.office365.com
 (2603:10b6:a03:117::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 12:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 12:46:46 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Jul
 2025 07:46:45 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <philip.yang@amd.com>
CC: <Felix.kuehling@amd.com>, <christian.koenig@amd.com>, <jamesz@amd.com>
Subject: [PATCH v3 2/2] drm/amdkfd: return migration pages from copy function
Date: Mon, 14 Jul 2025 08:46:34 -0400
Message-ID: <20250714124634.98951-1-James.Zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|CY5PR12MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: 90eb7936-a418-4b17-6be3-08ddc2d47ea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UumxVubutE95XdllHHQNAZ+jLo8OeiC4qr38YMHWmMm1Q+T2+nV42CawomY9?=
 =?us-ascii?Q?C7j/Be3sPjjNVwyU/KldYMyiYOwvSQZn6U19aiBH+kWXCQVVPAcK+UbaIW/U?=
 =?us-ascii?Q?glQDBgVWIRuw/0zjhNumOKrCIGYIA27Z33OGdqeH1l2SWT+KxZ9NwvrGxw+/?=
 =?us-ascii?Q?hZH6F2g4C0t4803UKuoU39labd1DHtmQR2CpeaCrmGQjAdu0fARKOhBL9GED?=
 =?us-ascii?Q?RIw1XhGDxC4CKNUUq/h/W/H2ngjo37/ragTpfP9ARzMTpKG0/VDuhY8ujDTa?=
 =?us-ascii?Q?LTvYAn9XAAFfuICCGHbBsVCJKzh0S8iExJQmHCKARJTtFfdiBAClSLiut11t?=
 =?us-ascii?Q?1/n/tEHIITLgYGq9YY2PZE8v058O0qE7JpWf9sd3N43iZriWpQF3ZNks/pMR?=
 =?us-ascii?Q?S+ah+Zwmla17Met7q7MSBENTitw0cCcT9ARj/eGNb6g7Tz/U6Skcyi204Xwm?=
 =?us-ascii?Q?HjGMZAKPKYsBoiHYdJRIfTmDqGnAUTN40+jEqTvbXuppzWAtDE8jhVUzrSGg?=
 =?us-ascii?Q?KaG3s8SYROzG81kuWMJFYphLBFJP2VuJSqhyGbsAIG+as2SGKZV6m9+xhQ7c?=
 =?us-ascii?Q?492ubGzmfNbJyCXezxEH5XheeJhW07KAdK+wIm2MNTVsF3G3AY6SWQql2Bh8?=
 =?us-ascii?Q?HmTyiwrl/ha8A9y87UXHgPGOb79kh2KVN6kDuMzMCwvpR6cZDldgspEmzzg9?=
 =?us-ascii?Q?KpwRtTRT9TRaVpBW9iiYzB1r179rhbGi7utiZaFJs0PKFxXoqQh6EE1nDzVf?=
 =?us-ascii?Q?9OKzKHVHQR/x9MqrvuZ2ojM5bytJphRszpfDloIo49lphuV+3u5QJ/meIrhm?=
 =?us-ascii?Q?vy92T0jEgCXO3uQn5/w0yyrarEJVvi1KcyCUbTD/6VDKpeTC4jwoE9CDN6ER?=
 =?us-ascii?Q?rZLjNRS2vuSVGAbt6HiheYxCpXzWB9bge0Sh+SHikbFlG2o3nISr4P71n6pU?=
 =?us-ascii?Q?eGbiure21dAyt/IlDzR20UG2GFpMusIC0kGeLybjoUieZB0Lz8Ya7IdA4Kw2?=
 =?us-ascii?Q?A9N60GW6odOXkXlrIg1slQd2trfpues5wy1dAZUHynneYXFLouH+hhoRF/9m?=
 =?us-ascii?Q?I8vHpElxCUYmhrb09o/c3tkYBq8zFw0KnGr/MQnKJHFtPbc1luHnejoKpmW1?=
 =?us-ascii?Q?CR+ldxPI6KfgecqDRchMrZbAVDrn+iPMzNxQ/U/pmvWxMDG3O24pSe/Ggft/?=
 =?us-ascii?Q?9NDQMHYM0NlyFnx1QHC9v//pPor6xJR7H3k1CrRNZ7SzkDLYAfmCvdMWn3xo?=
 =?us-ascii?Q?+TyV04qhgb2Xfqhb0om4ELJJ6U4M8jzviHcBpyzR394vOIL7zpZr4Hr7F9AX?=
 =?us-ascii?Q?8YjLN9Bhcaz48qcpZcGOdBfAsNT5t/CYVB6aCqjv55/nd+vI6sX+U00x7H5O?=
 =?us-ascii?Q?Qh7ar8olX0kIQrzKUnnfbwJQce4zM3fnKFWBzA4jb0eQmC+9mbPGwk3jIHOr?=
 =?us-ascii?Q?4L39FmKWx3zpdYdHk6CPNVhtXsCr9AYcYaOYCmAERXinmhjhEcmLbYItEv4E?=
 =?us-ascii?Q?pBQgTALcUuHNkXKFLWdI2YIi9aLEclTY3GXq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 12:46:46.8762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90eb7936-a418-4b17-6be3-08ddc2d47ea5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6083
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
without access before migration, those pages should be count as
migrate_unsuccessful_pages.

-v2 use dst to check MIGRATE_PFN_VALID bit(suggested-by philip)
-v3 add warning when vram pages is less than migration pages
    return migration pages directly from copy function

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 44 +++++++++---------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index f0b690d4bb46..aad1346bde79 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -260,29 +260,15 @@ static void svm_migrate_put_sys_page(unsigned long addr)
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
 static int
 svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 			 struct migrate_vma *migrate, struct dma_fence **mfence,
-			 dma_addr_t *scratch, uint64_t ttm_res_offset)
+			 dma_addr_t *scratch, uint64_t ttm_res_offset, unsigned long *mpages)
 {
 	uint64_t npages = migrate->npages;
 	struct amdgpu_device *adev = node->adev;
 	struct device *dev = adev->dev;
 	struct amdgpu_res_cursor cursor;
-	uint64_t mpages = 0;
 	dma_addr_t *src;
 	uint64_t *dst;
 	uint64_t i, j;
@@ -296,7 +282,8 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 
 	amdgpu_res_first(prange->ttm_res, ttm_res_offset,
 			 npages << PAGE_SHIFT, &cursor);
-	for (i = j = 0; (i < npages) && (mpages < migrate->cpages); i++) {
+	*mpages = 0;
+	for (i = j = 0; (i < npages) && (*mpages < migrate->cpages); i++) {
 		struct page *spage;
 
 		if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
@@ -304,7 +291,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 			migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
 			svm_migrate_get_vram_page(prange, migrate->dst[i]);
 			migrate->dst[i] = migrate_pfn(migrate->dst[i]);
-			mpages++;
+			(*mpages)++;
 		}
 		spage = migrate_pfn_to_page(migrate->src[i]);
 		if (spage && !is_zone_device_page(spage)) {
@@ -356,12 +343,12 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 out_free_vram_pages:
 	if (r) {
 		pr_debug("failed %d to copy memory to vram\n", r);
-		for (i = 0; i < npages && mpages; i++) {
+		for (i = 0; i < npages && *mpages; i++) {
 			if (!dst[i])
 				continue;
 			svm_migrate_put_vram_page(adev, dst[i]);
 			migrate->dst[i] = 0;
-			mpages--;
+			(*mpages)--;
 		}
 	}
 
@@ -441,13 +428,12 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	else
 		pr_debug("0x%lx pages collected\n", cpages);
 
-	r = svm_migrate_copy_to_vram(node, prange, &migrate, &mfence, scratch, ttm_res_offset);
+	r = svm_migrate_copy_to_vram(node, prange, &migrate, &mfence, scratch, ttm_res_offset, &mpages);
 	migrate_vma_pages(&migrate);
 
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
 
-	mpages = cpages - svm_migrate_unsuccessful_pages(&migrate);
 	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
 			 mpages, cpages, migrate.npages);
 
@@ -580,7 +566,7 @@ static void svm_migrate_page_free(struct page *page)
 static int
 svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			struct migrate_vma *migrate, struct dma_fence **mfence,
-			dma_addr_t *scratch, uint64_t npages)
+			dma_addr_t *scratch, uint64_t npages, unsigned long *mpages)
 {
 	struct device *dev = adev->dev;
 	uint64_t *src;
@@ -598,6 +584,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	src = (uint64_t *)(scratch + npages);
 	dst = scratch;
 
+	*mpages = 0;
 	for (i = 0, j = 0; i < npages; i++, addr += PAGE_SIZE) {
 		struct page *spage;
 
@@ -646,6 +633,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 				     dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
 
 		migrate->dst[i] = migrate_pfn(page_to_pfn(dpage));
+		(*mpages)++;
 		j++;
 	}
 
@@ -688,7 +676,6 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 {
 	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
 	uint64_t npages = (end - start) >> PAGE_SHIFT;
-	unsigned long upages = npages;
 	unsigned long cpages = 0;
 	unsigned long mpages = 0;
 	struct amdgpu_device *adev = node->adev;
@@ -745,12 +732,11 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 		pr_debug("0x%lx pages collected\n", cpages);
 
 	r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
-				    scratch, npages);
+				    scratch, npages, &mpages);
 	migrate_vma_pages(&migrate);
 
-	upages = svm_migrate_unsuccessful_pages(&migrate);
-	pr_debug("unsuccessful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
-		 upages, cpages, migrate.npages);
+	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
+		 mpages, cpages, migrate.npages);
 
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
@@ -764,7 +750,6 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 				    node->id, 0, trigger, r);
 out:
 	if (!r && cpages) {
-		mpages = cpages - upages;
 		pdd = svm_range_get_pdd_by_node(prange, node);
 		if (pdd)
 			WRITE_ONCE(pdd->page_out, pdd->page_out + mpages);
@@ -847,6 +832,9 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 	}
 
 	if (r >= 0) {
+		WARN_ONCE(prange->vram_pages < mpages,
+			"Recorded vram pages(0x%llx) should not be less than migration pages(0x%lx).",
+			prange->vram_pages, mpages);
 		prange->vram_pages -= mpages;
 
 		/* prange does not have vram page set its actual_loc to system
-- 
2.34.1

