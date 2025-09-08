Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F484CA1016
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 16:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C608310E55A;
	Mon,  8 Sep 2025 16:15:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rlCgbhLE";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 147AA10E14E
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 16:15:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDhThuau+JCMa20Jf8UJDtw5R8IrI4UY1OSyFJ+XW7uK30ICYC/ryptTrGatqc8ACYQeps+LPPlNoAFkzW5aj6M/e3YIB09Za0B92GtCR9hbzKJoVojcTjUoCNJfzZPgGnNYw/0tVwqcjXZJDzvAwPe96BJAOJi6S/W2UOpbvZAesL7oHFsYq+R2sLyJQcQTdIdZE/mM0vzn+v8eGgz4gPikgyxu2yXWPrzYX0BJsHFVDkWlSMZLTQySflab0/cGQXBmm264SrFQoskno9xeGiGADR2Ns+UvuYJnfWhfAgBjxnLojMBbMQMAv3iXoELX6v30sEanZ0Mo4qupfn6++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2U5cokhBfD4qNrRUVpwGHyof+vJ4vKD4g6dgHj2nwSc=;
 b=umoyuxushRpwMicI3aSUZW4SZt/Ueuj+nUkCw53LnEv/2d7trEvqsFsPj0dz7IE8tSAcj/uhduxlHFZ3LTXiduSrnKGTKzXpVBv5o+y+gwPPwbkwqOXhNsHmhPKa31R3u4BThc5uSmmNPjEG0CTLdbquOw0cmGivZsP7Od03519Yk5a8mLKY2F+6DRjeoLIFRHwonP26Ce7bnpEwp2hUvHlIFt48Cya/C9IQCh+C9R0kAgA+a+/bjxMKBH/Dv9go2+jN6QokQs/mptX1TpuABP2TchQSYpLhpg72LmOuA3DWR0vB0+Er0KeU8/Jp1l40FhooDxid3jzjYDk5LWh0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2U5cokhBfD4qNrRUVpwGHyof+vJ4vKD4g6dgHj2nwSc=;
 b=rlCgbhLEI1/VvSMrA2CMIqaFRVATcHde6XsCArGeWbKH3pnmjAojT26yktIJlnxzkXuC0JTZeMaUzHH5yXrjZ3O76BGybk52FoDX758lNS4VxxFkV4zjDCPKEGXDtwK6z/SYBz/MyPYv6x8u2N+oYDHZmDDEazjNd16uGTEN3BY=
Received: from BL1PR13CA0336.namprd13.prod.outlook.com (2603:10b6:208:2c6::11)
 by MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 16:15:40 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::3) by BL1PR13CA0336.outlook.office365.com
 (2603:10b6:208:2c6::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13 via Frontend Transport; Mon,
 8 Sep 2025 16:15:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 16:15:37 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 09:15:35 -0700
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <philip.yang@amd.com>, <chengjun.yao@amd.com>,
 <jamesz@amd.com>
Subject: [PATCH v2 2/3] drm/amdkfd: add function svm_migrate_successful_pages
Date: Mon, 8 Sep 2025 12:15:25 -0400
Message-ID: <20250908161526.99413-2-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908161526.99413-1-James.Zhu@amd.com>
References: <20250908161526.99413-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|MW6PR12MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: 747e74e5-edd2-4d5e-0584-08ddeef2f28e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OMDvaRFNWHCvWrHiYKnIQjoeSkGsaoOY/9d4/aBcMxyevBq6i5voVsdTTHof?=
 =?us-ascii?Q?5glWdct9p9RImHcHoK4hDeqfA2adkUn76ZKpADjzXy+cRPx6dE1gL73G0oXV?=
 =?us-ascii?Q?PCjcFuWJ/WSR2zPlV6wN8B95Rj/ZmaT5B28lfZ2/Sl+ed3GU5bpjC4EZdFMc?=
 =?us-ascii?Q?q+ATAoFS+QOLxkbIWLbGyLErwtM9teIdWzH3wjdPsnoVAYpjqDBi7Q4zcK6X?=
 =?us-ascii?Q?9VaUAt6l3xB1i5y0D9ZDngL1jhSPLmBsPe2IX69O+zM5SN8VCJ1cLBtkNJio?=
 =?us-ascii?Q?kgBAweGa4hPhU9BoJ6CobYZkCM4wTO4qcCuhd9zYOMr2hesGS0quV3e/wzHx?=
 =?us-ascii?Q?XtHOAHFf0yNTbDF8T19OsKFSgtgxec/3/JfaqK2wBKiMD69JM+Fa315++QuQ?=
 =?us-ascii?Q?3BWIaAfZO2j4kBGP2n0zbXiZJiJSOfDaVoT5kXnzx8+qkFXQ34JPLKzBa260?=
 =?us-ascii?Q?186LsaQ/D+CuUeG1jqcpfOGyJwRU03NupjT3YkrqaPzKj7R45/tkgHgG0JYT?=
 =?us-ascii?Q?Bkila+6paquoTPzeekSuVMqzvMEYDTcSlsDorSElBgg6f/AviRGlSmluh5+9?=
 =?us-ascii?Q?WuCE+xfvCGEvLvu4W1gDFXe05ayPgsntH9CGcUwMqa9KiBjdOdskW9LhGf3t?=
 =?us-ascii?Q?iSoeSkiIG2tkIFcgkOJbWT0URLeRJrn8PdVB3m2efGY25JATr754bLYAI+az?=
 =?us-ascii?Q?iTGvPtqsLVH8EO4XRpImIr5I9Z/k3HJomXhS77Z3eckBUOKlIxy+N+QROHPL?=
 =?us-ascii?Q?Mv3+9Q8qjAC3kJ4YHPxxDtriNZiqxJF1lFXbskGOK01fVdavvJfi9LlEWu+U?=
 =?us-ascii?Q?PZ6YbjVQq0PUmzZb1RXhJSs8cxix64XwqoRZXiPF6XHbXLzMcYP877nX/RVC?=
 =?us-ascii?Q?cX5mJa97XevJf3gXCtB6HaW72vzRTlgm5V011OVGgav1bIVsjs4Sg8he2wFQ?=
 =?us-ascii?Q?KYSDsec6LqtdgYF2SaO/F10G5/8/mR/YsGQx+cJVvp1EovZanqjAnKF/MD0e?=
 =?us-ascii?Q?d5ygwmOXKI7PJ7bqsC3FqGKnVJfUrEchS8U6z0ECeCSj9GAwUN4rIPshbcJE?=
 =?us-ascii?Q?CEwXogaAtS0+tjU+vhvtJ+FhyUcG27j2ZA3PfnVe38Sf3FZbhRTYYC0Ty25R?=
 =?us-ascii?Q?gkcp2Gf2u7vKRLcFQ7BiZkjuh0dyKmcf3fmxi0s9W19NRU00TM6XB4wsSoxa?=
 =?us-ascii?Q?xz0yduH7SS+UZpxqqXiW6Qvslne0D+mKgUgfYgtTd6eeMdVUkPoATzVsTvmm?=
 =?us-ascii?Q?BvVJI192bubRQi1wKxW+P9AOmK+W8pP+5DR/UfiFFOK+reDlxXBBRB0of169?=
 =?us-ascii?Q?3jawgGCdSWslt+zztd4q7wp1pBQJNaAj+9NIYZxPSOA2AX8wMluI6TgcQEqj?=
 =?us-ascii?Q?6I7djAbq5nAu5Lh6r1wXt3Wde1bwQyXhrFqaxQo+vO0ZfEZRTNtOjtKiPK6n?=
 =?us-ascii?Q?WfclEKZRQPd7j0DhqURTijj7gq6lDZGsSbki//3stUvVbtg/fcFB2k4jYWh8?=
 =?us-ascii?Q?WS8196pBY4jljzK+Dr51qLYzZm/nFYvWNROQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:15:37.4942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 747e74e5-edd2-4d5e-0584-08ddeef2f28e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8705
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
bit unset pages for both ram and vram when memory is only allocated
without being populated before migration, those ram pages should be
counted as migrate pages and those vram pages should not be counted
as migrate pages. Here migration pages refer to how many vram pages
invloved.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 30 +++++++++++++-----------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index f0b690d4bb46..83b9d019c885 100644
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
+				mpages++;
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

