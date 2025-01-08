Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788AEE77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 13:20:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 176B110EBA7;
	Wed,  8 Jan 2025 13:20:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cBU3rc15";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30CCD10EBCA
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 13:20:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETPUb4n7wD5X/3jmi2oZdULQk2NTSI+ocU3pT1VhLwgJXYnfJCIXT0r42lHVBVtYx1VcrNVr5pZ0JA8wNvrak0RvR+Uy2y0cdDvX5Cl5uxYID6QaOb1F1X8DuelKe7Z8MZnO5a+/WG/YOlDZYsqi6zTYwIFsAU1ApX9AgHh9IM59XMxZ74lDZWOMLJnIhSVzD/8nufvKeRuWCOHvbo2LuzNF9eWZ6TEgvBOL2oj9VhEwEVK7QBZ/UNcd4g1BpoQHq7uQc8s8SVh73UiTuQLVjKKxcFtfuNafJPTRMIm+K4I6WsCcU2bNkO0HN0EqfyuGYFEUnKx51u/DF/kqK6f6Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLQ6WaPZ4KtXXR5aUKaME0/tnDtDc3PV636D/6dCHcg=;
 b=Dy1CqLYwOkMSzDaThvjtTFpBXXAd3isKmwN4/YY8/gtW8pjSeux2+VIh+1jMtpFQb+YYkfFLS0c/afUx2Nr2neRA7Zs49eRV9tFh/tmOVrc2MTVBVOpgUoAsVwfOFqTV4aP3KB1XiFzz9iWqB/SvDc2IvyxF0NZsgs/dyzxxXWg4NU/SZuwwbBfImM3Niob9U1n9pNsQegc7X3F36XdvH0UoJoBPjcOKwfs6rU6HAqb0X0fh3oTs7U/doSeMqdcOAt2bbH42vkZ/fjTS6UtuLk5RUGdc0+ROpvnB06TBN1FbZPNG0k5CIVgDXPjWXESZf4E9qhoji4Q1Qo5g0ZPR1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLQ6WaPZ4KtXXR5aUKaME0/tnDtDc3PV636D/6dCHcg=;
 b=cBU3rc15O5afo36kIk/VNZ7YGg50O9AQL9gSY4FBImpEPoVTZ//NDDJIb81ApKDm/sHwhpKxO6VDXbLTTet4OHA3b9nZ/+1V75/Do+NhAVS2K7KPowcaKDTztJgmf0MZL7SYw6LMmw95PfQwoey5/VAXLZLXeY06rsgD0rVnec4=
Received: from CH2PR18CA0049.namprd18.prod.outlook.com (2603:10b6:610:55::29)
 by IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 13:19:44 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::12) by CH2PR18CA0049.outlook.office365.com
 (2603:10b6:610:55::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Wed,
 8 Jan 2025 13:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Wed, 8 Jan 2025 13:19:44 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Jan
 2025 07:19:43 -0600
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 8 Jan 2025 07:19:42 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v3] drm/amdkfd: Fix partial migrate issue
Date: Wed, 8 Jan 2025 21:19:40 +0800
Message-ID: <20250108131940.1435142-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|IA1PR12MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: f9722e7a-94cb-43bb-9b89-08dd2fe71de1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LyRWCJnnFdobSaOuup7natfSExwp9JX43hSqxox8wqbE9kDFFHr6TK7L/Ju7?=
 =?us-ascii?Q?WnYmiu8bqEB5KG4z+7tjHKunYHGtjCxKwHMNFWiTJySFxzMuvl7MsN77ZcBy?=
 =?us-ascii?Q?nR4EOX21y51kHul+SifEgNdX9rYBnRfogRMNbNzeugPmCFk/FDccvvQp68wK?=
 =?us-ascii?Q?gPVv+4GX7SYjio1yp+GrA08AiHwYX+dY69ZOtFIfJwW/gSs321zbHbX1XrFE?=
 =?us-ascii?Q?BVU4w/CrQTS6Be4W/D9GtulcCANvEDNo5+/jxwN1n2YJGrDBrCpbxn5FUCfx?=
 =?us-ascii?Q?qvPchQwgNp1h8b76fFMcIT6Lhv1OFFSPIaqOOAnp+GfXVbR+ON+y3s1BefVj?=
 =?us-ascii?Q?HzR1TujBcAYbMoWbSIVFSWUJ5s0e+Jz1Q5/qrNz0u5fBo3jv5TA5nX+efnEv?=
 =?us-ascii?Q?ZOLohczU8WP5eRhJyuuoTz6/gkcT6bAyHdZYUYRD7FUmmKtONSAsQQTjRQpI?=
 =?us-ascii?Q?kjxcJ+aKRtenXJvncX+OzxNqm8WtwLpGO68CcPItNCAGFuQreOHOY7g/xo0D?=
 =?us-ascii?Q?Ba/c3nQZBIt8Qe08Q2OB7cvu8EyhuLUUaj9Zs8+NpMnNFj+3RU9pJxEo6yZf?=
 =?us-ascii?Q?nCZxDAqlpJwcML5QTON0S8/6FK8/gLEE+ekNZ21W3ScPP0qm++D/WwO/fgr+?=
 =?us-ascii?Q?PGfVUAEgWJfNSyIFxP7SkLPpsee6NSiEvGyhyR0W35bW66AyFFNGa97mjdTU?=
 =?us-ascii?Q?1Cq8MZ7MTYNHObJ12dWtjgDnaz+16vnsap48S9fbs0e4b8j5dqlh0KPYwTyx?=
 =?us-ascii?Q?BeleK2DEGmHe4ILxNwsRwdWWg8GQzZ1vrSkxo9zs0jp9tKrGnOZZJEHJDON3?=
 =?us-ascii?Q?uXIZZDRevJEl6fwmU63tjZVSLxuIjmkUhVvis0EhNkL/EIsrensuPoFPEl2g?=
 =?us-ascii?Q?SUjJFhqPsFzJPnOgpD5RqSl3CkK3HUzlXKGxFcnkjz2o4B3SsIpik9m52yiQ?=
 =?us-ascii?Q?2jp/9oBwOeTco2nZ850BELUZqVlOKYjk7Kjku69IcacA1w6QclbTtw2nntWE?=
 =?us-ascii?Q?SWsD+bqqVtT9+PEoW4v17iknqqbSPIlnT8KbSa3RFzc8BC6KLu+vyo9thcL9?=
 =?us-ascii?Q?XjM2+c4MhRVXKyKZhoWCiFu80pngtyfbau9oEU06tzkADTaduLaIyfqwnsp6?=
 =?us-ascii?Q?l5ZYAGpTWCfhwT5BPkZRSthTBbVHy8qd4hvdcKNTS+6sfwv+r6QW4wYjXA9V?=
 =?us-ascii?Q?2Gf6pSfeWub6fg9+dumpW6IANMT1BasEipP1rNex8mjgnIkeT/8lvkdgo8hH?=
 =?us-ascii?Q?y+SJNnk5AMl7TXfSy5bscjggzC5f5AMIaOWYuMLxlKSa1qNO1+imeJlJ/Nn1?=
 =?us-ascii?Q?WW/hDU5sKdWVdq9fO467atk2Nsggow+ZYGaZARn81m2JwCRT2saoxbr4Mlzp?=
 =?us-ascii?Q?mb5SMGQNCm3raBcR/v5DsuXjxXBeGBRXB2bVVVBke4/8bTBv/qjC98KUiXnu?=
 =?us-ascii?Q?Ff1T1rDFmGj66QEbobzXJ7C4UzWJJVcgg7mOSFCE5hmXd4I+ZvoxLA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 13:19:44.1128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9722e7a-94cb-43bb-9b89-08dd2fe71de1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8190
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

For partial migrate from ram to vram, the migrate->cpages is not
equal to migrate->npages, should use migrate->npages to check all needed
migrate pages which could be copied or not.

And only need to set those pages could be migrated to migrate->dst[i], or
the migrate_vma_pages will migrate the wrong pages based on the migrate->dst[i].

v2:
Add mpages to break the loop earlier.

v3:
Uses MIGRATE_PFN_MIGRATE to identify whether page could be migrated.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index eacfeb32f35d..b671d12c32f6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -278,10 +278,11 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 			 struct migrate_vma *migrate, struct dma_fence **mfence,
 			 dma_addr_t *scratch, uint64_t ttm_res_offset)
 {
-	uint64_t npages = migrate->cpages;
+	uint64_t npages = migrate->npages;
 	struct amdgpu_device *adev = node->adev;
 	struct device *dev = adev->dev;
 	struct amdgpu_res_cursor cursor;
+	uint64_t mpages = 0;
 	dma_addr_t *src;
 	uint64_t *dst;
 	uint64_t i, j;
@@ -295,14 +296,17 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 
 	amdgpu_res_first(prange->ttm_res, ttm_res_offset,
 			 npages << PAGE_SHIFT, &cursor);
-	for (i = j = 0; i < npages; i++) {
+	for (i = j = 0; (i < npages) && (mpages < migrate->cpages); i++) {
 		struct page *spage;
 
 		dst[i] = cursor.start + (j << PAGE_SHIFT);
-		migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
-		svm_migrate_get_vram_page(prange, migrate->dst[i]);
-		migrate->dst[i] = migrate_pfn(migrate->dst[i]);
 
+		if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
+			migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
+			svm_migrate_get_vram_page(prange, migrate->dst[i]);
+			migrate->dst[i] = migrate_pfn(migrate->dst[i]);
+			mpages++;
+		}
 		spage = migrate_pfn_to_page(migrate->src[i]);
 		if (spage && !is_zone_device_page(spage)) {
 			src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
-- 
2.34.1

