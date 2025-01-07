Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51391E77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 05:07:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C7CD10E084;
	Tue,  7 Jan 2025 05:07:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MljOaa+F";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C49F610E084
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 05:07:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzOag2HmpIpVxeHT5+l4SxQHaTG9SF7UVNIL6rSalj8Y8nfxD8gFDYtDCGYDOytiD3tOquM1shAe0c0pMwr+wO8tSM/nO+OgkgmL0f4lvHVwMUCkhKIWuLfKwMBh0GlNXTt7NaZnT/oF0VTMNas8DkIMqxYeFmJtZpHepqUQKV6CAW9HHLNUxhKcOfRQOjSdPZHBNCNE3uYkAcGOUuUw0PCmPTAnRSVbHQAF3XNWUB6jhtFnAnhdHH6q9qG4QcE9ro/UCxlq/bg0R5dodq/vEcm7EDWsvNvtryX74OKLuKO9wbBtLz7iOX9U5BCWh5/yW6WaExlJBKCz2QDQMMFCLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siPtxfV5AChQXvNTWzpocs0RcjpoRcSRCrKdLzZS3cY=;
 b=EjFVBxNdCQ/stvC2qu4KMhZ5eiUZ2YKByWAG6Qwe0VhgV4yhhNYhmBYGWkHvv4OQM6d6YPhljijoZNLSGG0MRAf+U5YLz6N7LUuE62aeRd2aDPaMbSrKTAm7w6H/RcAIQjHMe/ZRZHjMqMdFu3VL1Zy0Uohu8XCb2PWQ7pgYuHfHqtrrTD7rVkhrJ76rCe5kTMNY8bmrtPEu0Xsf29KKwJXmYWpto4wNOSGQlc1+TPDX3pK1zZthK55sky6VIx3N4DkFcfXI1OiVCs37ujlTrd6ygbKx8Mfuiztk13faFFDTsy2gZ/+EmThjCGWm/lxGws8bB2/83YR2m4rLh0Z3PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siPtxfV5AChQXvNTWzpocs0RcjpoRcSRCrKdLzZS3cY=;
 b=MljOaa+FRBCG8YVpeSE7rWhc4MpSK6hsg0Q8Lee4+r2vyFA1AtioNY8y6at/GtgoMPyBOBPBA/sTgdQBVBv3O0MUfVVXwzh5U77k+otEzAZfuwgP5Ubz8Js8DbgZDaUKls2ULjWaykzq0aRzE/Q1PRkzMwAcB1Is3I9+1qEybR0=
Received: from BYAPR07CA0011.namprd07.prod.outlook.com (2603:10b6:a02:bc::24)
 by IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 05:06:54 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a02:bc:cafe::63) by BYAPR07CA0011.outlook.office365.com
 (2603:10b6:a02:bc::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.15 via Frontend Transport; Tue,
 7 Jan 2025 05:06:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 05:06:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Jan
 2025 23:06:52 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Jan
 2025 23:06:51 -0600
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 6 Jan 2025 23:06:50 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v2] drm/amdkfd: Fix partial migrate issue
Date: Tue, 7 Jan 2025 13:06:48 +0800
Message-ID: <20250107050648.1412316-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|IA1PR12MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d26fff-e7e2-4e9f-1d2d-08dd2ed919fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gxh1NF3k+NYYoLNYqzVQt69D4zqZddnLnF3v88Z3yqPeJorXOj242B4cz3ty?=
 =?us-ascii?Q?tWPTvBXFdNIPhPnatz9wKZNUmOSHGMuWS76W8RRsK7eXZYo0+QRSFj0yyXHh?=
 =?us-ascii?Q?BRgv4s9jLvCQ1oNe+gEZP62J4Rg9IvyQmFPxDaNBdWu3yK2/PkSRN3EeHi0a?=
 =?us-ascii?Q?cX73PHWKweewCt5dGJ4/ITKmOLcomNCKih8lyoT/y++u/p9OukeKiX0XOYje?=
 =?us-ascii?Q?NtsfMaJH1pAUbxBBA3F6r49t9H5vUb35N6HWGyNSHuH2VKM6WlSrAtpd58s8?=
 =?us-ascii?Q?KSoAUrx3W9ytsGZEzU5YQnf45+hjzHdoXYqTnfm7bCkKUiAwNEg+ac8V6YD9?=
 =?us-ascii?Q?+PSe6o1hw8Y44mPgqVu1twew1ib/o6fH1fbyVLB/WoMx/W0rAXF3jcth6qjj?=
 =?us-ascii?Q?Qi4KXL1C3k6nqkiM1BY7Pnkf0R/M/iCzk6esTeGni2EG5pDJ60dXh9WipOc4?=
 =?us-ascii?Q?lfNYnCzcCenzfyG4W5JRYjn7O4QsWHjBLnxNEf1xfqYD5c2xKR8ysGytGhhn?=
 =?us-ascii?Q?rbMeQIEWy4W+0EGu979QatAJ4jfLTiNZu0ciPkn6tiXMJkR+JiGi5dpVKmUV?=
 =?us-ascii?Q?HZGiqkFL3MHVLTlCePs/LMY8GWM50ZLE6O08UgjhUb1+nVqOBdnGvJMYM+tO?=
 =?us-ascii?Q?Q348UPO5dlEbnvlv0VjpL2NzT1vg53oCaYqPoMsyYgZCYHq0+vdJjaP1/okC?=
 =?us-ascii?Q?pkr/aaZoiPC1tDmz5WGgeE7rfByGXNtHQz1FqbO5KJUm5IZq5JVf39cov9yD?=
 =?us-ascii?Q?KgGdJK4JfQ1qEEnuIq7Wmz7Qccqt585SiJTp7wT3ImdqXuq5uiSYL59haWdx?=
 =?us-ascii?Q?Vv3HM5mY4HUXwgrj/nmEDJRtzzRWIxsxVr2U8Gk884tI2LS2VMssDhuWyZ5r?=
 =?us-ascii?Q?U1IIhZqLE1OM3GKcGUnYYPe58I0iEm9nS/vAO0ccmo49T3YLDwI8yi/G1Wnm?=
 =?us-ascii?Q?b/U0ZWjshvcYrZbCAcPTa5gVqKczKLdhxRYyQYJzSe3rCachS1wYaQ7bHr28?=
 =?us-ascii?Q?hVyIjge+4Mqn7HspQwFMzVInQXFgO/MpbbtPw9fVeLkgqRPT+0fR3dW/7vel?=
 =?us-ascii?Q?8tCfYoYQnTdKaTa2nOPq6iC4DcpPmbopJi3Pmqy9P7x1OCl9un57VaK8f3Oy?=
 =?us-ascii?Q?+5vMma42aUzREckB0spqQ6zFkIiXFpVRYcXbM5Zj+YuT/M7ZPgSaFb7sFOTg?=
 =?us-ascii?Q?ro0eBtNnYrdK5lJEU+pCgyHvzq3hGuX1cmYR2VRJs85dBFeg4xpfqESzPU4P?=
 =?us-ascii?Q?4z/GmHLhAuyLtrWWwg5lxef8ckSqelXVcVAEwSwYLV3ehMhbvKd+MlVi8Itm?=
 =?us-ascii?Q?RF4BBhrwNNKN85Nczfwgoxnm7eSUOrSTlcu1kpxXZyYli85xbrFNYArGFEFg?=
 =?us-ascii?Q?MjHOlGa1jQ37or0R/WZoWYHCtBR1SnL1wrCVJ2/h7I8bEIEcUsh7AKZ3gzgi?=
 =?us-ascii?Q?cyClTwolDuSyr4sIT4UcvP3mO3r3SayEq+LLUghyI/cY1WTk443RHA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 05:06:53.3715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d26fff-e7e2-4e9f-1d2d-08dd2ed919fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233
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
Add mpages to break the loop eariler.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index eacfeb32f35d..dc70252c066c 100644
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
@@ -295,13 +296,10 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 
 	amdgpu_res_first(prange->ttm_res, ttm_res_offset,
 			 npages << PAGE_SHIFT, &cursor);
-	for (i = j = 0; i < npages; i++) {
+	for (i = j = 0; i < npages && mpages < migrate->cpages; i++) {
 		struct page *spage;
 
 		dst[i] = cursor.start + (j << PAGE_SHIFT);
-		migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
-		svm_migrate_get_vram_page(prange, migrate->dst[i]);
-		migrate->dst[i] = migrate_pfn(migrate->dst[i]);
 
 		spage = migrate_pfn_to_page(migrate->src[i]);
 		if (spage && !is_zone_device_page(spage)) {
@@ -345,6 +343,10 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 		} else {
 			j++;
 		}
+		migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
+		svm_migrate_get_vram_page(prange, migrate->dst[i]);
+		migrate->dst[i] = migrate_pfn(migrate->dst[i]);
+		mpages++;
 	}
 
 	r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i - j, j,
-- 
2.34.1

