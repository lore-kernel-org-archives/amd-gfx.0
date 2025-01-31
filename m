Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C29C0218F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 18:59:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E91F610E42F;
	Fri, 31 Jan 2025 18:59:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fTTd31Vk";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5C5410E42F
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 18:59:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qHdcjudTbk5k98NgUwNdSJnyq7M/KbLWIukIArAcEx9Sx5eOMFlXg+JWbncoTc+WuPjshg330VM/MD2imUkIXANHAnzk/xOFaKnbN26aA0n2qMA4msUe/bIbXiaWXYbOtNIWDpJJG6EEboHde3kBQjqdTrKAqF9Rl5+ywq0NsfNM7/bQzdzep+RhiTvPwh+pZGr7ikhYr92O/nh0MN6cC9HlchEmHFTGpUBM1V+62bSjggW7qH1LCewM9XnaIHUa/CVOu9p4jM/52mqeKHQ25l7CeDldr1Hjlml38/AZJpLUMQFrmqY3kjP//M3sAmTdar1gZaAnTcoCzCTyzqBs4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdiM7/QNCS2eoM0ibMrNvqosFyKHn9RHT7BMLIl+wLE=;
 b=NlnVuHX8V+kGTf5GEg98pLblQXIlOmkGgxxbvLOVRzrJ/aM2KW8dfJAWldxZXKfO6TbZAVPDjz/J1cXfiAgvcOdJ2Y3xzplyzjnqj5xAlbAdvNU/u645775pcunBFbDguoniRUhRxTxDckIXibx3Blj9ptEPXuzUu2py+H8TrRgYwiM2kpfYwsCXEqYUXcz+WT8PLZbv//8VHU20BItt0rNTTliuRLCD+1ZjmF82O0M9y5I8KROTK/7aZwxxePB4Ac0sancMjtBZeUdFxgLkEqQ8GgSt+2ReF0MZH6F8AD8T5vEP1kS1OLOMiQXlrVmn9Cd3Su5ZQO6N08nl//FxaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdiM7/QNCS2eoM0ibMrNvqosFyKHn9RHT7BMLIl+wLE=;
 b=fTTd31VkE5DCnr+Ia9AJCnVWPhZ7WlNxr+NYSBZ0M6XW9WAjF7GLjmpIuenjQhwhLxX87Lj4C0u5u1JrRXj62Q6higJ6gJkaasye5jtNimazk+E5aW+APgb4mT2vyqhOZFZEGADP6wmshUAJwEkYwTgbuLoYxnKb2rNdApgUCMY=
Received: from BN9PR03CA0106.namprd03.prod.outlook.com (2603:10b6:408:fd::21)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Fri, 31 Jan
 2025 18:59:22 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:fd:cafe::44) by BN9PR03CA0106.outlook.office365.com
 (2603:10b6:408:fd::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 18:59:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 18:59:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 12:59:20 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: bump version for RV/PCO compute fix
Date: Fri, 31 Jan 2025 13:59:04 -0500
Message-ID: <20250131185905.2074016-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131185905.2074016-1-alexander.deucher@amd.com>
References: <20250131185905.2074016-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b5bdb09-a368-459b-d8b9-08dd42295f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9UmRF2fM7wqNib4AP0+BUE6SkuYtunF6O1rRKGpvMrSi8zAgKUsFiqBBgIg6?=
 =?us-ascii?Q?rr5fn+I6OmOtKDgUzCnIId/OyRaWBW0UlL2UisyaEM+wp+SBTgznRSO7dN43?=
 =?us-ascii?Q?K88fcA6yRf9yBwz7H8oiwPMYQxZRLg1WfvNcIcUjpVukr7W/CzOBSxmNq715?=
 =?us-ascii?Q?3zo/X6xK2V5wPpYgifBbmVbCgHJ3x5bh2xfjA30WtkXr3fFvw3D+l13mHMsA?=
 =?us-ascii?Q?WfLYWj/IiQl/ZD33JCn0ANIYSutfAg22Gle+Z7hLd87o+9UpDv02L7VOVu+y?=
 =?us-ascii?Q?UdCo8xytv3O6JjjMdYZG8Bkg8Raj7TIzvE+hv/+Gq5L8kzHO9QTaHL/EMo/D?=
 =?us-ascii?Q?vANOxI2B5mYH6T4cYzYaCW2GqSLrS5Baw9058SexTWxpiLi7/vDkGgx4miun?=
 =?us-ascii?Q?wnrcI/cy8DkN2ZFfBZ/W/ngbC+QBymDdul4PkTToYxil4gIgMpkhXOD/LId1?=
 =?us-ascii?Q?gNk29ttoWNF3Jy1fD7W9zsHeF4QV+PnvLTRFAxSASZl7l6c8W/yqY1eZ7AXc?=
 =?us-ascii?Q?SxywoEV6GvpgPVIIg9/dnm6Na+xGjUb18qKLTF4aWSX9AAkWkbT8uTTDq1sT?=
 =?us-ascii?Q?fc72/zwCoOtDIfpOYl68z4ISedOuTi7L9MwfN1GxwlN/217L9MqIv1jaq+v+?=
 =?us-ascii?Q?VCo6/T6hGTXnRkotf/G38zbnWvxyUiSpDp31P9twY7jGkWFK3rjRB6pgGwSE?=
 =?us-ascii?Q?3ovbZ4tG2FSHm7kfaZOirCW8nzB+GuZXG69jvMnOMWpGmJs8GCCLlSq7df3b?=
 =?us-ascii?Q?abAKwPRmm5GM68nY7vHDLakwBzqClMzpws7UB2BkAUCx997OvyhIKmodlJu/?=
 =?us-ascii?Q?K9Hz3jIStSC+pPnAxCzbU/52dbLudKaCOi+dwMZd237VJK0KpHW4e6VXaak9?=
 =?us-ascii?Q?gPn/oLy8mAK3/fWknFEMrxJDS8/jjn+ERvp2guLy+vYGlpiMnvKRPg95Zlc9?=
 =?us-ascii?Q?CuZSVtUkEE0TVZkehDKAc8xYB3WtRbxQ/UajI8gGEQYmnYFj1pEdxs+T33uU?=
 =?us-ascii?Q?jegtt7vLsLhvKp743BLLTumpp8fCKlt/PVLoSjHLOtP3OQOSF2GyY6gEERCq?=
 =?us-ascii?Q?sYf95Vv65G2aRCg3SPZEyt2ZzWhrd4iCMhabu0xYj2fSbk9C6NRNK6IilG5/?=
 =?us-ascii?Q?VEFq7QcYRFN8+O/NXYRSd218jwA/LMddM0A5IRokUOpKmafRunMj58q9Y0kX?=
 =?us-ascii?Q?AvDoker/5YgdiMDyTrdrxLRXy0wnmhdFXyU1I/vhoUcg47MPZo5mw853wrSK?=
 =?us-ascii?Q?cCjq3Xf9MHZPcDgGI0ftxGkt911qCwasCaL8DoFyv2/NgIVw6nBwSgd84XIr?=
 =?us-ascii?Q?UjkzIOB+ShgxHHgLdUXX1GqVOP+x1h9k5UhmG+BIp0OcJ8xnfREui3BjCEVL?=
 =?us-ascii?Q?0fpDXYlLkS1E3n7peuyuFKp3SKJU8C7FvhLuA3jMyzhAG4USdydZsH/dH6a9?=
 =?us-ascii?Q?8buyABL97y8yHEDBMHwddGyKlQ8LyD6YCbStVEZw6IX6V2p3iZfStdm61Gs0?=
 =?us-ascii?Q?nI7iVpFhPnySo9o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 18:59:21.7561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5bdb09-a368-459b-d8b9-08dd42295f69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
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

Bump the driver version for RV/PCO compute stability fix
so mesa can use this check to enable compute queues on
RV/PCO.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 69e532e34950e..95dd2fbc26c54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -122,9 +122,10 @@
  * - 3.58.0 - Add GFX12 DCC support
  * - 3.59.0 - Cleared VRAM
  * - 3.60.0 - Add AMDGPU_TILING_GFX12_DCC_WRITE_COMPRESS_DISABLE (Vulkan requirement)
+ * - 3.61.0 - Contains fix for RV/PCO compute queues
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	60
+#define KMS_DRIVER_MINOR	61
 #define KMS_DRIVER_PATCHLEVEL	0
 
 /*
-- 
2.48.1

