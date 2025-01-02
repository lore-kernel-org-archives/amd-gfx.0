Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2298CE7718B
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2025 01:05:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F1E410E28D;
	Thu,  2 Jan 2025 01:05:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZEhsi3J/";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF13510E28D
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2025 01:05:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpXVhQw8q+qSzGFQzMyoXFM0o+B8qlrTRY2X/OgPch3MTGBQXyLOHm8V0KqchdrNtsCZPXpM4alSHLRzURzM/3KOMaW0RKDJqIbIbZVduLoIqhdxPCrINvyDPBRKkbNKh68mJFdU2lauL9iGTlWYeVA/PwrMdudTg/vqt2jTQlYvmrbilco4S+1mQpM8pcR96oHiKbMaNXlERE6gQK86VwqL4HA024X5FCuYm+KQ/y1vjMhma03bbjXYliXEW1KoT/nW+6DBHkNQKETOJEpYRtKuVZvXX4tJMWy1Fg85SHEI3FBpd/EQEaQ6/qbQgZieqv8K3aHZVkquzQgwfQNHKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VxxMHncXn7pSdjrUGaFOaMAWEg975l3lqFnXXCCppU=;
 b=l3+gtI8Rx8tt1X7GYI9GsCEC/Ij5z/pv7UAnVwMZe7LDIDlu3coHHTqlLZshvWqILpiYbZwkfoPdMNy2g9R50UCgdQBwy2+x3j5IYMGp0FgJroQ3VTeHoYgVwnEHmn4FsEum75pwduDnEQ6wibLpPlyifE+EykCz6KQ1WnlxwIyBAXddTrmw7knLDjqA3730IQ9ksqQXsdhk5rF+ey6pF/PTzO4y5Gn3nSoHWaUz2bEkwv9Hv3aEf2Ys+MSQNbmS2MKsSgyNzGf+O45NR9mPBSFtGaqW4DgSSzv+IhtD4dCC3H/Z19f3kmYjoWIwabpPAdwvvBvSQtrVsM+w75rwNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VxxMHncXn7pSdjrUGaFOaMAWEg975l3lqFnXXCCppU=;
 b=ZEhsi3J/nN5QtDPAAQs35OMx9diOycxeBu8D3PSl2mjTt7Xcmx6sjj4qy7OvsO06DSxOzib7947LG1jtC0hqV39pvOaWfEeWq66pDKvxloP0WBTOO816QmsT5jGYQVgAq6xq3dAINof8t/3k3BE4yB51fDHHy09c/nS3FArIYtE=
Received: from SA0PR13CA0005.namprd13.prod.outlook.com (2603:10b6:806:130::10)
 by CY5PR12MB6406.namprd12.prod.outlook.com (2603:10b6:930:3d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 01:05:22 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:130:cafe::c1) by SA0PR13CA0005.outlook.office365.com
 (2603:10b6:806:130::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.13 via Frontend Transport; Thu,
 2 Jan 2025 01:05:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 01:05:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 1 Jan
 2025 19:05:21 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 1 Jan
 2025 19:05:20 -0600
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 1 Jan 2025 19:05:20 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: Fix partial migrate issue
Date: Thu, 2 Jan 2025 09:05:18 +0800
Message-ID: <20250102010518.1394960-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|CY5PR12MB6406:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f00f4fd-3041-4af8-d863-08dd2ac98832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yw7vsEbdTQzefVnfj6hK/H3fn7L2qMVttg5JxBDof0KxGs/qpcjGHTJECrbi?=
 =?us-ascii?Q?WY5/+AnA2dGpdP9gLYzHkkfCj6WOksoHIE6nMy3r1x5p0PFq1i/6klOUa5x1?=
 =?us-ascii?Q?U1BaBcPOvjAU0UMITJgDzccrEhxqNlq/Y3NazXl3qW1a6Iw8hcKccVrh8/6v?=
 =?us-ascii?Q?/G3aapj35mRLesnE8ghwVJBDk1/LUTZVXZ9UeHLuElvLetr0KBsdDd8LquLA?=
 =?us-ascii?Q?905AYnhn17/oPn120KFsOt20SIpRPdTzGFcPKhVJO+BNinY7jYO7cu73Ukjs?=
 =?us-ascii?Q?mKamTOVTbOmotglzoexxZ98ZSJ4mdDAL+M0Mx+IPLIb70Tp35rRbspC4XZV/?=
 =?us-ascii?Q?eKCQsPkrxPlmzvgtXVZnqkUpWBGIUJ/uUjN7M7sakMDCFvVKV7f9EaCcW/E0?=
 =?us-ascii?Q?laFTVkkjMewEZMf4pqYQtvBJma3fvjS78tGxl74PaRcpsteVGpb4ewISJ5HN?=
 =?us-ascii?Q?Me+mNBr5aQKMb8yzamz+5qcLbDtPJ7VRcDeXIPeYbgEC6+sKN0jo3vaCkYnt?=
 =?us-ascii?Q?5HHUDfejvInEgY+ztd5abu44miwkYYDSAsF670zH2p89nFUa+Y3nh6M3yA5X?=
 =?us-ascii?Q?eRkijXKgLbJcya00IiLV8c+a3ULE0krqGH4NlICfeL5OZavY/x/b9lNWStgg?=
 =?us-ascii?Q?yP6W6KsBN8iBttm9WrtDb4nXkrXXF2mwlqHFynYxajQBAOGUedDtuxiEB9gz?=
 =?us-ascii?Q?xBAdjD6LKFXS4octRusFmXqdErjTN7xZWVNCRDED8BP223XnnW64+PWaG5aP?=
 =?us-ascii?Q?AnvJz67r2Q4BRXq9KmFGErQZ7gUk6iAvx0HzfxzHC8nyx7MvYDuhhkjwUC4M?=
 =?us-ascii?Q?fL7NO7R2hFMujaQ/llw5btNgyhzKZLhQ0OI4KqP9rkjMzgI4GT+YmN7CF3xd?=
 =?us-ascii?Q?Xg7ymKNub9e02xOPKC9mRkIycxo+fAkiZWyyUfjAnoBelQEbE2tTdusw6Ewl?=
 =?us-ascii?Q?BRnDScGrYQHkIk5TFi8a6mB60umNMQanbsSt/U1bCK2TccHXJ3YQN3Aj0R8w?=
 =?us-ascii?Q?maGufCpRVzlyw1mbpiWrOGx5E0uF/jYVPI32Kl3+M5gdYPOAYlmcFm4uHHvx?=
 =?us-ascii?Q?0VlWRbXV/tSXjslIOnW/oa3eaEzZ9rL28YqwBWFNNsYcM53RtJYOXw1QmJvw?=
 =?us-ascii?Q?OCZdnoMH5F+QQf03+09+q+XFimto7AW6ZXMY+Qx0UMNOWtdYCwp/yX255dnv?=
 =?us-ascii?Q?hv9jBIOm70Ry8hh76upoRKuqdjqyhNfQ3VvMu5tpQkFn13f7/VqD8R5qG6Z4?=
 =?us-ascii?Q?/7g53XMyfDgTQ03NCD2bOAEmq+m58O8CEqtFSpSPIw9vvlEK20yeNLRlarIn?=
 =?us-ascii?Q?BV4J7wjIZ4XPoExdv21+dR1ktfZi9ULhHQf9GUv1ILzesQX8ruHm1Cvt4z54?=
 =?us-ascii?Q?+kA6Nm6rY56vw5S3FAHHYMPD9F63dUEH7uIA3f4HYOo69lTOFHmIbHz+7Z2g?=
 =?us-ascii?Q?yCMh8NJU4iXulpWuopYlk8k4iBVDC+/6jo8V9g+kmyGqCi/gTVIrT4W7H9ES?=
 =?us-ascii?Q?uXo5+4FVfrfIAas=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 01:05:21.7523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f00f4fd-3041-4af8-d863-08dd2ac98832
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6406
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

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index eacfeb32f35d..4140381b0bc0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -278,7 +278,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 			 struct migrate_vma *migrate, struct dma_fence **mfence,
 			 dma_addr_t *scratch, uint64_t ttm_res_offset)
 {
-	uint64_t npages = migrate->cpages;
+	uint64_t npages = migrate->npages;
 	struct amdgpu_device *adev = node->adev;
 	struct device *dev = adev->dev;
 	struct amdgpu_res_cursor cursor;
@@ -299,9 +299,6 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 		struct page *spage;
 
 		dst[i] = cursor.start + (j << PAGE_SHIFT);
-		migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
-		svm_migrate_get_vram_page(prange, migrate->dst[i]);
-		migrate->dst[i] = migrate_pfn(migrate->dst[i]);
 
 		spage = migrate_pfn_to_page(migrate->src[i]);
 		if (spage && !is_zone_device_page(spage)) {
@@ -345,6 +342,9 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 		} else {
 			j++;
 		}
+		migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
+		svm_migrate_get_vram_page(prange, migrate->dst[i]);
+		migrate->dst[i] = migrate_pfn(migrate->dst[i]);
 	}
 
 	r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i - j, j,
-- 
2.34.1

