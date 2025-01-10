Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6735E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 14:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95C7A10F0D9;
	Fri, 10 Jan 2025 14:25:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xrXtY8hK";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C081310F0D9
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 14:25:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOaDFhxpMhYtyXmaXAUvPFkLZJ07XzaxWCm0r/MMqX6ptB1kA2V1M/dDQL1GiXypeBrDlY1/tRjYn/5FAY0DZ/Jv4S+6fWw1uzAezmLopkZaaK34vL/6lboZ69aLX0YRbqFLfmcSAy3QZ8uFG6Kwl7me8F4wGB0i6OEND1EydbEBRbGhSWOHT2jyWveOMjAMLiymhE2aKIw8phogK5EU4KRwAYZf04qz49L4MvGjj0zneVlY/QalqIhfha1Rkm43pXEZ7pEnzWn3/Va7cz+0fsKOTVZ0eoHpxU0AsgAoQKNaX2hmd2oT57mFGON6sOrzzeRw27FbVENwZHSBterO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dd8OZXiUyifKkMhrb8Myi122saj12zCsjQjloMfQ0GA=;
 b=xFnfaYR636XrRUp05MWZr1V4/xvPqGKx7UqPAUVye+lO5xpeoXqI81V8Y9gpdaFn3dWA1GHoBVb6KJ7itxq40Wvh9YX2n/kUlCGQ2K22gS+k16ENtS6vk93ocrHHJZ31QyZIWr0smG7pQc46VbACJ20+3ixJVudQMfvopzmE5UFcsWtDA69EDmO4OnXjw/SK742Bhjvot83vbcoUk9H/ZpS5r4r1uGJ//FIkPkmwAJFV2hIF0k0Nu9xJVaonkCPxoxmfVyO3Q0E2KwH42gLJC8YZBRccmJ1oQ1oxoI/Pq8KPFho9V8oux68bMBbqaclP7JnjqsSyN2yHvZ5Nkn0mqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dd8OZXiUyifKkMhrb8Myi122saj12zCsjQjloMfQ0GA=;
 b=xrXtY8hKz3kTt5N1yKsRSsgBSuKPd+2wd/tYsvViEjgqp1faIR0kfM5Cy+feIYKHFsOz2R+nMUjO8ZLRF147MhKJceZmLDIjMsO+8o/VvGx/UAcik7qLc8x4MrJw1MWIpSBOoq7cH+mTylqHiNOW+QcdocmY3sFJArPKtK3EQpc=
Received: from SA9PR10CA0011.namprd10.prod.outlook.com (2603:10b6:806:a7::16)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 14:25:21 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:a7:cafe::85) by SA9PR10CA0011.outlook.office365.com
 (2603:10b6:806:a7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.12 via Frontend Transport; Fri,
 10 Jan 2025 14:25:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 14:25:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 10 Jan
 2025 08:25:20 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 10 Jan
 2025 08:25:20 -0600
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 10 Jan 2025 08:25:19 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v5] drm/amdkfd: Fix partial migrate issue
Date: Fri, 10 Jan 2025 22:25:11 +0800
Message-ID: <20250110142511.1442811-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|DM6PR12MB4236:EE_
X-MS-Office365-Filtering-Correlation-Id: 04bd3b4e-2c34-41f1-ba8e-08dd31829d82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WwAWlFztJknxsUNCsIECzudHOxOhRmOl40UKwfCJ/1rfmGBwwAfOkA5GCfkA?=
 =?us-ascii?Q?JoE8igMvY1TdYyUHZe17vJ/FHYYhw8SoXLLiMTDh8eWhTQRoEYInaROvzeto?=
 =?us-ascii?Q?g5cT2J4P+q3Fx/MA9bmm0FO5C5dDy/YwXRo6yrOCcC/otaWKTlSIgJzJ1wlQ?=
 =?us-ascii?Q?tzxTP+M7ASPJ7nz5JkfncZlfd9tpSd+BEKTAlrJhhrt2mdj11EhpJKkgJRWF?=
 =?us-ascii?Q?N/MlHz9G7yra/+N1sBq7FV+IVblMyKdsGz/CXYauzvNQL2WqNPEUi3pZ4RGU?=
 =?us-ascii?Q?zjtPIDh+5R9F7XSXYZe2VS+o3GGmttvFk030ag6wHgCXM4L6teAm0YvbrK0s?=
 =?us-ascii?Q?OZESwo6bvjkxJVU9PNI4xZEp2oLawTPV3A0fLaSdqtJlGDA+Js9enNL1YVol?=
 =?us-ascii?Q?apzs7u9Reqien9Z5TKiAUeNhFV5MozcIfJ3HzFbfp7SYJ3Af6XxNFNtbj/1F?=
 =?us-ascii?Q?ix0dea/pdrO6o0m4nEjWuXir292AQqmeQAVigBT1Y3mjV2wkWw4jxYIVBCun?=
 =?us-ascii?Q?KH+RAoiZoVp+mIMw7cJFUussnT/5nFny99ZAa3szIvaVdjUNXdZC+RDLKIfB?=
 =?us-ascii?Q?0vAjWvqr6+OMZTl+lgTQylYVs04ysLM7H9X0mAA85MFjdnyZ+GK/JCyUt8cs?=
 =?us-ascii?Q?HLM8N7pWRJ24+LKYfgUb4XCF524RsMUWyZSTy5tOKpaauhdS7e8xzEhTmlIx?=
 =?us-ascii?Q?T1EYX1gqX2UV6hsNup9NNPiiFa5hsCwOQywhueV8t/pd0dRkmihugTOjuwPW?=
 =?us-ascii?Q?ErMBpZdQZPhwQsqPwy0I84nssSOEz168oqcC5hAWyzyNh9W6a6YQpfJ5RLZA?=
 =?us-ascii?Q?cJhQL+4FhE/JPqo+n/Eknstb7aeWgYnsse3LNlXfXQy0fWMYdP48DvxVm5j5?=
 =?us-ascii?Q?JnTHTOTOUh/+BgtCLeNGxVVbeJ7wfgaQVi4WUQRTgPwGDkJIqP+cS7wyCw1a?=
 =?us-ascii?Q?KsWKf9tShIZb/D9TRKPlGCdYQ/BJr6tW11BKxHbavAB1Txs/jX8IJ7M8Y7Lk?=
 =?us-ascii?Q?cI8Yvu0ges2dlYe2WkJmZO+DIV9lZmpkgfNsU56OvHh83E5BfnriXOSvzi9c?=
 =?us-ascii?Q?b9TVfKEAMh+ZteYdVCp6KsyS7drq2i+ZpiWNejctMCIehKOzVjnrtlMEG2dy?=
 =?us-ascii?Q?1rjv9XI3KKBHTYDEs/wP6RBxbhCm8A3/vVpMaYTGwTfc8iMnLEiioMH3Z3dH?=
 =?us-ascii?Q?e7ly1kDVWFZrMPutuOtZFKfWkpigRwLDbVKJb8jwfXVkpaKVhwEpP0JtTEFs?=
 =?us-ascii?Q?9sD5q9gxQJFnWIpkLXceL+0vsnuGALpNvz5u+Ds/DgFG1+yZytHmIgJnBlLt?=
 =?us-ascii?Q?mBnhCorsEFF5PogTK2ehIEhXhygUHltyFZAQ+Fq0K30RhN7ZL8Ijf1bS/MwD?=
 =?us-ascii?Q?yLecbYCrxcG4DJZdaGLmBeBBM2nMAbBo/rJ0OoWDC0WDjL/V1Rb7qcSUHbRN?=
 =?us-ascii?Q?S1yrd4AN5D96Q6dVz5JyPJ2D0uPQ0HetQnpVBWR5zSGZH4YNGUPMnQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 14:25:21.3797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bd3b4e-2c34-41f1-ba8e-08dd31829d82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236
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
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 4b275937d05e..edff564d6a3c 100644
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
@@ -295,14 +296,16 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 
 	amdgpu_res_first(prange->ttm_res, ttm_res_offset,
 			 npages << PAGE_SHIFT, &cursor);
-	for (i = j = 0; i < npages; i++) {
+	for (i = j = 0; (i < npages) && (mpages < migrate->cpages); i++) {
 		struct page *spage;
 
-		dst[i] = cursor.start + (j << PAGE_SHIFT);
-		migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
-		svm_migrate_get_vram_page(prange, migrate->dst[i]);
-		migrate->dst[i] = migrate_pfn(migrate->dst[i]);
-
+		if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
+			dst[i] = cursor.start + (j << PAGE_SHIFT);
+			migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
+			svm_migrate_get_vram_page(prange, migrate->dst[i]);
+			migrate->dst[i] = migrate_pfn(migrate->dst[i]);
+			mpages++;
+		}
 		spage = migrate_pfn_to_page(migrate->src[i]);
 		if (spage && !is_zone_device_page(spage)) {
 			src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
@@ -354,7 +357,8 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 	if (r) {
 		pr_debug("failed %d to copy memory to vram\n", r);
 		while (i--) {
-			svm_migrate_put_vram_page(adev, dst[i]);
+			if (dst[i])
+				svm_migrate_put_vram_page(adev, dst[i]);
 			migrate->dst[i] = 0;
 		}
 	}
-- 
2.34.1

