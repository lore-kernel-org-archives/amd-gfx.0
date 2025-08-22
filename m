Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2133CA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 19:38:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F18B210EB91;
	Fri, 22 Aug 2025 19:38:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="khE6H0n6";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A96FD10EB91
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 19:38:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EvSZMJWpu3q/t3/GVMFiHXvaK7iXs8jVbGmbGZaYn6goA8Oyy6bbRec8hUU9ulF2jum3ikxBOWUKnS7J5tY4UcZJF0uEpORIRX8ukLBfp5QDeDgb1UX5LxwPe/4nMF6JnCQXIjKhMryL+F4CH2oyp3O8QrDtDn6hNK/sN4M/AcrPYMXTQ7ooFgkVFtoc4cD0kVCrrQCCc31i4L2I9oTFO3pmW7z0/bltC3YLmTN6DDDZbeWJKzU0fUjrdtDzRWxXYATF2wwG5GH2MOgcrZUm9iUxkmGH5AjGDiPelsjloYe4OpDVY3aQHe/sDOnnZ9oj3Fogy0kba8I6YiITbKrXew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGv2cNbk4HjzPk8DeaLbwHPsLUAaTJQJ3dr2quDWgF8=;
 b=u0Xoha7vbZOk3ZbYO4aY1ifOgGXj3dZ0x4uHYrwyrHr57CnXcyFH35uisYWKBnDmnKtvkE1B0qo+AlVQ94HBxVIFXgTmbgWZ2NCgqf7QOQmXZ4KBKS1ar2LYDjMiVP+uHAw5+Jm0OPxPqaYdyaHR7sDHpScWoVuLrAz7FI+iEgx6zS24J1VWDSwj/msv5q4CYWzS3nWqv2ApCkjJgv+aiqFVf03M1XpadzWctHZpyQdk0sTxKfn0nfgGavRilU6H9EsP9qlEx1Fsl5JohCrG3JLKjK/95f1QgadwJQvRKEUt99Ci/PcBys7NU7wml9k0XyRMlGJFc4qVL6Rv1m8aTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGv2cNbk4HjzPk8DeaLbwHPsLUAaTJQJ3dr2quDWgF8=;
 b=khE6H0n6chpaimO4CQz7XuBVDMlC13PogfIe3Lg86jGal64o3tSRXdyAv2+xk52nNHG3zTKLxoYEUq1rhIZBWpVuizAPX6npaZJzYJexi0mHwt/0/4rev6Ll4I1C3BQncFHKHPTRzu+TkvCFLp3DTY7HrZEYrIBOu2KyeT64vpQ=
Received: from MW4PR04CA0222.namprd04.prod.outlook.com (2603:10b6:303:87::17)
 by IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 19:38:26 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::1b) by MW4PR04CA0222.outlook.office365.com
 (2603:10b6:303:87::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 19:38:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 19:38:25 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 14:38:23 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <philip.yang@amd.com>, <chengjun.yao@amd.com>,
 <jamesz@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: add function svm_migrate_successful_pages
Date: Fri, 22 Aug 2025 15:38:01 -0400
Message-ID: <20250822193801.292575-2-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822193801.292575-1-James.Zhu@amd.com>
References: <20250822193801.292575-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|IA1PR12MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: a7f04b33-b7b6-4372-36d5-08dde1b37682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DnMtje7Cjtczv2M9FtoWb03coS5nm9k2tQDEzqCGI/qW5pGjUnENBSuGD1eJ?=
 =?us-ascii?Q?0KNV5/SyKfNAu1lAkPG9j4l5C8QCkIlNRmsL0kVVRIVLd61DtE/P9Le0+Rjx?=
 =?us-ascii?Q?H9mYYdMnyN1vN1EpIwNAycNRMoB5Epk24kIrdPxFfprpGqkoVlzN9CLsWHvc?=
 =?us-ascii?Q?bAjbUifAfLwR5FNR7E/e0HbErdMe5Bmop+JttNtkLikcFFplwyhJ2trbANSQ?=
 =?us-ascii?Q?WkIruuDy7ZeI/n29BPodleYTSGtQeOhe1g6Zl4rwkc5sbbQfy69uM6REEu5V?=
 =?us-ascii?Q?6VDgXdVtqsiHvpXndoGfS99V431py/I62EeF9jf9rYia9FyXdVu/LqGfTFxE?=
 =?us-ascii?Q?gU9UxHhr3MV1TbgpySeySvn6A78rYmyqAm5TFkgygkaSKWe9S12AeHtn8P6A?=
 =?us-ascii?Q?ykFgHhUKsorFZ/gef0WLP/xixDoDf38Bj8wrWLpLDpQXUpwoURvgB7JYBuEW?=
 =?us-ascii?Q?smQ4T7RlHD1o6AmhfX+o7Kn2dBPtpvvK5DrDxXLWs3oeDjfn9UvTnOWCmDvM?=
 =?us-ascii?Q?OVDSOwTedx+rZCS2sz8kgnYJOoDX2bdOhH0lnTUZ4ABuksYULH5Xp+N+DFdc?=
 =?us-ascii?Q?yjbtyOpaBf5fwutQC1fwHIFxqhJzcY8sjTdD+n8eypZCzmwTk2Y1VJhiKmC0?=
 =?us-ascii?Q?mg7s2gUYBv4fBNLvGJuB8lnUw3ZZKfHzQTi5TeC/+Cd8bU+kh5+eaktSO9GD?=
 =?us-ascii?Q?HRyubB4dNe/SgtumEVcl/8xD/R4WeSyaeraJdM0Ay7wJ5RXgrfQvzEqVXFjY?=
 =?us-ascii?Q?GN4/QJOGTdIlWg7EZOcTA/AIBDMhvyxtx0cd+xzD9kWzegJ3T/QYs3hQGeXr?=
 =?us-ascii?Q?mIaCKgGmEQTzejveaY5G857JTXACDOQcjiybv/P59Qgc7bQTcb9YZYxmPKxv?=
 =?us-ascii?Q?2Up+aSC6/E/3w7XvMddA1uJA/LABLY4Ja5Wsb9cnNgsW9RBx4daKnhzhmqhC?=
 =?us-ascii?Q?j95Zf/KDV5q8l5PyXOCqnnF3xFnuY6Nv2NcWXst4ATTJYz9xblL8NTmSDchq?=
 =?us-ascii?Q?Df0vsILLCazmWExsgN1sKu59D4W8QTseRY4VbqrOvdg2oAP6XvCkWWl1vXW6?=
 =?us-ascii?Q?zOEO4pUSZ9B7OHRSgB70wmecNu1RyK3I5CQaj5kvPR72bVyaMf/cP38DOKAK?=
 =?us-ascii?Q?4WIMJkWTskyotuS2GabnbYx1uimR67xYc27fDJMf7MrUQjqqt/X282O3kfUR?=
 =?us-ascii?Q?bZa6ReaqWZ896j2htVMvEMvbjav6Cm0/ZntDpULrUQfCR3n1rm3M8vKMQJOh?=
 =?us-ascii?Q?xX5lH9D5ihTHM7S9UTNsaS0FJyN9FJqdF9hx4crD++ueYdYHkyBIKI3fKtOw?=
 =?us-ascii?Q?F1rn9WmxYp/Nx1+ALYy0CEdVZ1HmA/7iE4dGwkNPHli0YEIwNtWYK6eeO5Lh?=
 =?us-ascii?Q?cO6Ng2IKCbFsYMTrY5CTEujrnJWSR5AxRpIDv/qaACaMZbzOdc7uMR6SHJxS?=
 =?us-ascii?Q?NDC3XDuKKHtvoqjraCP9oJE9HXF0NmsJtPG9De9CRr2lmgcewa5EXtbYA4kC?=
 =?us-ascii?Q?RNRcWAuKYteUR4dO36wh4PZn8kQYAiX0/eLS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 19:38:25.9459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f04b33-b7b6-4372-36d5-08dde1b37682
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616
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

migrate_vma_pages can fail if a CPU thread faults on the same page.
However, the page table is locked and only one of the new pages will
be inserted. The device driver will see that the MIGRATE_PFN_MIGRATE
bit is cleared if it loses the race.

cpage includes src MIGRATE_PFN_MIGRATE bit set and MIGRATE_PFN_VALID
bit unset pages for both ram and vram when memory is only allocated
without being populated before migration, those ram pages should be
counted as migrate pages and those vram pages should not be counted
as migrate pages. Here migration pages refer to how many vram pages
invloved.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 34 ++++++++++++++----------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index f0b690d4bb46..314e16838761 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -260,17 +260,22 @@ static void svm_migrate_put_sys_page(unsigned long addr)
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
+		if (migrate->dst[i] & MIGRATE_PFN_VALID) {
+			if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
+				mpages++;
+			} else {
+				svm_migrate_put_sys_page(migrate->dst[i]);
+				migrate->dst[i] = 0;
+			}
+		}
 	}
-	return upages;
+	return mpages;
 }
 
 static int
@@ -447,8 +452,8 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&migrate);
 
-	mpages = cpages - svm_migrate_unsuccessful_pages(&migrate);
-	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
+	mpages = svm_migrate_successful_pages(&migrate);
+	pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
 			 mpages, cpages, migrate.npages);
 
 	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
@@ -688,7 +693,6 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 {
 	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
 	uint64_t npages = (end - start) >> PAGE_SHIFT;
-	unsigned long upages = npages;
 	unsigned long cpages = 0;
 	unsigned long mpages = 0;
 	struct amdgpu_device *adev = node->adev;
@@ -748,9 +752,9 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
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
@@ -763,8 +767,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
 				    node->id, 0, trigger, r);
 out:
-	if (!r && cpages) {
-		mpages = cpages - upages;
+	if (!r && mpages) {
 		pdd = svm_range_get_pdd_by_node(prange, node);
 		if (pdd)
 			WRITE_ONCE(pdd->page_out, pdd->page_out + mpages);
@@ -847,6 +850,9 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
 	}
 
 	if (r >= 0) {
+		WARN_ONCE(prange->vram_pages < mpages,
+			"Recorded vram pages(0x%llx) should not be less than migration pages(0x%lx).",
+			prange->vram_pages, mpages);
 		prange->vram_pages -= mpages;
 
 		/* prange does not have vram page set its actual_loc to system
-- 
2.34.1

