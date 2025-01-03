Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D683E77188
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2025 00:21:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B8AA10E142;
	Fri,  3 Jan 2025 00:21:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BPLkRX4H";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F380110E142
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2025 00:21:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHkcfIRvjjCFmKMEnutMOO4e1NvmzdK+KmJbJNn+Z6ZyZINRlZH4liYNPATvtkLMOfnB3hmfxPh+IRk/7r8kuSl6YXMLLaPzJf0UZCsOiSJ0MzCn6npwkTc0Xvl65EcntLEwSzt4Ycpyzbxuu0k5D6dt7SrtGBiHZIPZezQ37BZXzOpGgWNdgqgS0DZ3nz2u1aiAdNA5LThLOJPjp8fWUTzUITFLhhbtN70oOGV2FUt7XoEDr2fMhDHZtRGNSRrA2P6pTtm55nTN370ENo3CtqJ4xWNzRWEWohRbbIAxDrqH9cF4Oah9sbMn2b6P+GZ/gKtgyoDshaOwUjuNG2hjxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GzU+VPQxS3c9AGbh6x7wIKNG/xMMgye7RScRqiGHTc=;
 b=JCrvtkfgS1M0DZG6UGv/U2sIFoqkUxDUzi3HNObhjFpedlWYr5lHPPpqAEAg/3pzavSr0DIsuoYqQ5IHaxu3zvyPTwYcKWCehp6QbEG1TVkGCRA7okmsDS7mZOwG9OJDSGa9ht/fo0vd+/uSOLmd+wOfFz0FVjo1vnJwruGXJ7kb/1ql245V3N4ieTh+V7eTugz16c/C4ed9N4DJpTDgEn7X4PazLeUYVA6Zrfi3otKNfyBAzgbNGGtMcF63D/fXf2ipBswR6yHl6hV1/Vesc6zRes99dlQoVu8bCR++MsPyrKknHZx9hKH1webrbQWe1DjpQ+sN2Ctjnex8Hle0cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GzU+VPQxS3c9AGbh6x7wIKNG/xMMgye7RScRqiGHTc=;
 b=BPLkRX4HnHc3iCTlbWj1tUSpBKuRwAkwvzRdsojiXmAFzxr8wcel5G2Gxag/QpSyyxrfcGNgEMVk/6OcCHrTjUYEs/93/LCaAVL3FcdwpnLUO8Y6M4DAweZ2Bu2sbo3RHaXopjdk4Hsy4Y7le+745le8tJCH88N5Sg/SY1ZGGOk=
Received: from SJ0PR03CA0384.namprd03.prod.outlook.com (2603:10b6:a03:3a1::29)
 by DM4PR12MB6279.namprd12.prod.outlook.com (2603:10b6:8:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 00:06:48 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::4) by SJ0PR03CA0384.outlook.office365.com
 (2603:10b6:a03:3a1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.15 via Frontend Transport; Fri,
 3 Jan 2025 00:06:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Fri, 3 Jan 2025 00:06:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Jan
 2025 18:06:47 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Jan
 2025 18:06:46 -0600
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 2 Jan 2025 18:06:46 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdkfd: Fix partial migrate issue
Date: Fri, 3 Jan 2025 08:06:44 +0800
Message-ID: <20250103000644.1398643-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|DM4PR12MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: ba264dcc-e918-446a-1941-08dd2b8a8462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z9QYP3nZVehPeyApEGJSHG1tskR8pbGYOkqklWAr7As8rJyqkHxHfU7rqxYX?=
 =?us-ascii?Q?6IeIiRdatA9lBQmKSfUxZJVlemRnE7ZDX42Hl+yLkxKMJggVVU/dJoiYj1SO?=
 =?us-ascii?Q?uR5kuYhrqa+G8Masm993hQ+1yQU6wja+6THPc1s+oaO+VrXcd+mg3/zd/6KH?=
 =?us-ascii?Q?G7p5b+ElT7/XXVbYZXghPTfdvO14MPUdd/T9IjzlAWOxRD+j1Xbhew17KyDy?=
 =?us-ascii?Q?McqfHfWrymckvFF4z16PIhxGRxzXgoxwL79Nj0MG31dYIXhxcMpUPVOurro8?=
 =?us-ascii?Q?1Be7Ac/DEyKV3Qf3pXzYwWB2dHXnfmbfXojJlNZ/XdtQS7oFwwEsPPjPH036?=
 =?us-ascii?Q?Pa1RYCVFRK/m6VipdPrMCthwMbAA7iQx5OBu1l04sHgxso+TkAq7J8vauIAq?=
 =?us-ascii?Q?rtXs47QPj336R4QjetrL+WO33u0D60KT0jqQEyZ2cbEZmLZ0M+Ekd3eUOgP7?=
 =?us-ascii?Q?viRpcJz5pgwByUwYdWoQwmpQ0zwo5oH34ivBTy0TxIPVy/9XQzkgxSPC03/I?=
 =?us-ascii?Q?xoiTAG94Tx1l75vPd1K6aEoSblhuLWxlp18kONgDL1kaGkDpO0U9qlEw3bXB?=
 =?us-ascii?Q?Dk71V55wIlr2akGdvqLO5gc1JL6DbjtdsQJ5n8hRwXDLZz8ZMjoT8xL0UoVC?=
 =?us-ascii?Q?XNM0wmYoVtJOnwCs7lJ+TMZZQF7mg4kMqZmnbQHh0pEdouITOYDtqKbJS6eh?=
 =?us-ascii?Q?jjQHFSPMWBPWGNH0MNuQDP4QbwFIN8DFpvbOqiT5dyrZTkMkHEh+mUGLeM+p?=
 =?us-ascii?Q?9+MxoLH/vW3TmbalV7QT3YxV/LYcSL18Ls+8pCFRjzIgpY8lOnpmvYAV9VG/?=
 =?us-ascii?Q?1gDXQgdz6FN3ce5dUXRdXIUwAlC/Y36jv0pkXBqQdoVDw6hKtCgdT1lHIX+9?=
 =?us-ascii?Q?1bGRwoTHvvgPHVCiXhuC3MqIsEqhYRVVjnb8xdgJgjUvoKVz+Y32ssevZDAh?=
 =?us-ascii?Q?P6uZTKi3KYJoIaRV43hWgjhOsvrCUSHkIguOuuyBNhqMjmdmI3xX4c7UbwHz?=
 =?us-ascii?Q?Cl6cANE1pSIZ+L28CBcWNhsc7FpEcVaLgAwyNxMlBgiPpHzE7zdzjhTGgSZW?=
 =?us-ascii?Q?oBsq37Qj5Q0JW5YveiBIE3M3QklldrArvG0hKofm0xfX43Z2LwKszCYc9BCQ?=
 =?us-ascii?Q?hSrtKqJLUKK8/ZAjBlTgq0WunoLnTrLbHJJuw/FtK5rqv63FlZGmi+iNoHvD?=
 =?us-ascii?Q?af2Xg9+AHQm+vPNjErwPg/o7fI+2kA1lqwYzuIKysDnZjNo1etl8KQGS+y6Q?=
 =?us-ascii?Q?lpBkYmf+IC5zZVk/vnXXoLiQhrbSZjSQN4mO5YXKqiPwfbapilpVFeF+CKjs?=
 =?us-ascii?Q?JuesHBvPmF0OX6SfJ6jkY2FkY2syvx+RA5jxlinAH/XAMvFd/lOTryRPeCLq?=
 =?us-ascii?Q?GOJggfh3OMiFPvZ+Eiy8fUt0mrgeO4QWe7d3GFh7Rc/QIfLfvGSj8JHfixMn?=
 =?us-ascii?Q?tfk/EGptn1Aq/6qGzn9CVxburFoVptrt2DS4jfN6gv3/zdwe92Jmu7TwlxuK?=
 =?us-ascii?Q?Xe4IvGRng+l2KcI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 00:06:48.1418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba264dcc-e918-446a-1941-08dd2b8a8462
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6279
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
index 4b275937d05e..5c96c2d425e3 100644
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
2.36.1

