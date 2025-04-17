Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACFDC369C7
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 08:58:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C921F10E1C3;
	Thu, 17 Apr 2025 08:58:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SquwP04r";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A1E110E1B1
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 08:58:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmXnUFt+moDZ+QHhu7I1xSysP+XOqhnIcPXNTbpY+Movzle0S86Pg7hdZ6UVBtaL4uiAmN18w17eXCkbwheU98swOKgWynYbKMfOOYAZk+Gw5cZ4J6+jl/W/5ddsvrooR1qkvKUndQAb4JFeevoRlTA7QrOXzlaBq93gG5eMI7EXxLmwC7hYsrhv3597tMyztbfj/WQZhZqUYvoifdgXdC1Hm6P53R6Y6o649x1Su3HUh604fdPEJYTwiXwQgsaP/QvMYyk6TMOog/YEEl616hsuWqyqT+vX5ZqMHVNSJ+qc+JENur5cUYlGu8UtlL29KM8TUkMWk1/+pvbUBrk0CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9ZORKHn3M10692QH95y8w5sj8YMBrsF1QuwTIIaNjw=;
 b=day4M1CAhQo4dJT/tncW34+qMOEWWI0eUB/BXsYX70X+PM4u9wMfDFa3eK4DObYpUQQmvSFvPLu8sGPdOk/EV78oT4lPh21IftKHCvo79999xK83gEFe6AhHQGSemvEthAsHocgosPw1wa9FW/4vmgyNX/Vncb4PIi/Kn41oU/Uotq3aneF2TiIhqtDcpSzcZix7UpyGjdPN5dd6Wc9aLV/JIGZKg0b50+Mm4haoOlwDtpiBsSIds/TASZQXTQBlaQfB1AIvIdmJqsnmPjPlYhxOWvNYJunDE8R8qXdNkwkAuqbdvYuaM8nvcn/oYuxuYrmU9OrupyLu7nyBiytcNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9ZORKHn3M10692QH95y8w5sj8YMBrsF1QuwTIIaNjw=;
 b=SquwP04rhly3QsRrGdPz7/0YxOuVL1CbG51zKQROAD8iJqWbjKiRRshGvwOtFK4vIqFoDB1o0/wxVeywE264+WetnAaNcH+BeO2p/Ft1udfW4+gD4YvzNWIkVZzFCk0EqOuHtFBin0tXiWTar4+XfVhKiEJPN06KLYRqALqZ5iE=
Received: from DM6PR21CA0018.namprd21.prod.outlook.com (2603:10b6:5:174::28)
 by LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 08:58:50 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:174:cafe::93) by DM6PR21CA0018.outlook.office365.com
 (2603:10b6:5:174::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12 via Frontend Transport; Thu,
 17 Apr 2025 08:58:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 08:58:50 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 03:58:48 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 5/6] drm/amdgu: get RAS retire flip bits for HBM3E/HBM4
Date: Thu, 17 Apr 2025 16:58:31 +0800
Message-ID: <20250417085832.36455-5-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417085832.36455-1-tao.zhou1@amd.com>
References: <20250417085832.36455-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|LV2PR12MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e8b4509-f4cd-4604-1845-08dd7d8e1275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|30052699003|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A6aiJb3JiJc8w5e8J0to/M0DEwTQLPyUZEbBG0ba4DSg+dYLePUBTVmyyMJs?=
 =?us-ascii?Q?JYw0TUl+Y9EDKPA/Z7I0T3gDcFu72S1WZLbixXLwbejtwOeF5SXXU9XwT/X7?=
 =?us-ascii?Q?X064xSXQgCjAXlt7cDOPi0ATV50xrWlMGL55F7qkxKbyVgAa9Bbc4owCxRls?=
 =?us-ascii?Q?gQNxny4K66GUi/1e17r5AvxCuUH+m+ZBXDyFjN97bHvo1SxQFyMZ29vMq//U?=
 =?us-ascii?Q?/cud1jag8Ltit6z347voOWxkc2/WD3SiaDENtBucSVhK3vo58INJQGAlDoHO?=
 =?us-ascii?Q?Qg39DD4uh+RjxgAx/2yCrdMfA7mALJ79wTJkRHp4Yw0rifLUZJ/beGJ060eF?=
 =?us-ascii?Q?XYN9Z0UMphE/k4njuRZlBlayl4ifUGOzUzJuAWhE3avYzmiAq6mPlxlwYZ3s?=
 =?us-ascii?Q?zQyEfDq00WvhB6D9H5iVnn58jlCl9pcDeNiL/ugT898V7Sue4NZ56QzV0Rk3?=
 =?us-ascii?Q?CnXaIlAQ7ChrRwmahW9amLMceDtACMchS7Nzx+ZL7hCgvWzo2fUWzmxbGJV3?=
 =?us-ascii?Q?8+Xz+iXxkZH96zaht3xFjjHOM7fvIe7K6LOlbbb4nzUysUgdbGmpu9z5K5Ba?=
 =?us-ascii?Q?G69rLg06vSOhOj8NQ4U5RlQ0KaSO8vzK1dUrLEcke/Lo6XYCtZa8pSTuZSSE?=
 =?us-ascii?Q?Sm/lVPYMIK1aEL3Tm5/6wxeVvah6UpP+WIPwiIXgO4TOm9/WxjF92EaU9V1I?=
 =?us-ascii?Q?udqgDE47xgr5bL8MjA9vVDUD6ITdAPN/r7dD8SZDRCJa6F1OW3rIB/tvg9+x?=
 =?us-ascii?Q?KITYRUdqylnijmkDHM902z1SWdTyPD1c1uNy6rlhiv6cZZ4J71NubsgzP100?=
 =?us-ascii?Q?YAJEmId8cG8I1Kf1rIpXgbVNiD8dHlcavRIMYXCNBxsXeB7CBbearsfrcCHy?=
 =?us-ascii?Q?XdjYbNFhpapHsWFd4W5TBoskJSYQZKDScOV8NEaIx68Xge7LCFKHgPXwAE5I?=
 =?us-ascii?Q?iyag/jhj2CNGLrYfuN21FJqMg3pkkQFu6MpAdh5MUSqxKBYlw1ig0lLf7byd?=
 =?us-ascii?Q?ssrarF+FVnbjTW8DoSDtTJ92JkOk3LA42++SsEN+qW7j5zYdrlpJ7L2K14Ih?=
 =?us-ascii?Q?RV3txfcywjVLYjj3J21A1pu6Uhb/6qFxkOOHC5482r3w8AyaN/2YmMa+VHzU?=
 =?us-ascii?Q?+rGDQGmU2peFOHismy18He0dNJEuoli5Lfcsb6d3P5mudLKxKfKngQRxpiE3?=
 =?us-ascii?Q?brQ/XBRqP4HNevBdfJrAREEHCy7DjwvEjcCMCjhTTQwN44QX7OE1Ee2mZzbf?=
 =?us-ascii?Q?kG8fX6Ba0V12V7lLSZkayji/aAp9MBlV+jZRLQOpIhM98udVyEgftysnYsx6?=
 =?us-ascii?Q?3ut7tquuc8POuO6rY8pvo/lKnuYm5KDP7Yz412/mj+ztuS7XcxnIkgRURCky?=
 =?us-ascii?Q?d0BPBtq3LByzbPAoap3ZY75VIVSVFXqcnJGMZUSCyGAf/eiYszDamY+BvcUr?=
 =?us-ascii?Q?m9BuP1XGuGhc7KJ8fOiE66RH4HqC0sxOpFklYYL29c6xdM6GoR2Bxplc49id?=
 =?us-ascii?Q?XJhZio9dJtUMXuPy6KWV3Wsf549piJIUVLtV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(30052699003)(376014)(82310400026)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 08:58:50.4032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8b4509-f4cd-4604-1845-08dd7d8e1275
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5776
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

Get RAS retire flip bits for HBM with different types and vendors
in various NPS modes.
Also set flip row bit and MCA R13 bit in PA in different NPS modes.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 59 ++++++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h |  1 +
 2 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 774d3baa62d7..b24229701fd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -24,6 +24,7 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_umc.h"
 #include "amdgpu.h"
+#include "atom.h"
 #include "umc/umc_12_0_0_offset.h"
 #include "umc/umc_12_0_0_sh_mask.h"
 #include "mp/mp_13_0_6_sh_mask.h"
@@ -178,6 +179,7 @@ static void umc_v12_0_get_retire_flip_bits(struct amdgpu_device *adev)
 {
 	enum amdgpu_memory_partition nps = AMDGPU_NPS1_PARTITION_MODE;
 	uint32_t vram_type = adev->gmc.vram_type;
+	uint8_t hbm_vendor = adev->gmc.vram_vendor;
 	struct amdgpu_umc_flip_bits *flip_bits = &(adev->umc.flip_bits);
 
 	if (adev->gmc.gmc_funcs->query_mem_partition_mode)
@@ -188,23 +190,62 @@ static void umc_v12_0_get_retire_flip_bits(struct amdgpu_device *adev)
 	flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C3_BIT;
 	flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_C4_BIT;
 	flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R13_BIT;
+	flip_bits->flip_row_bit = 13;
 	flip_bits->bit_num = 4;
+	flip_bits->r13_in_pa = UMC_V12_0_PA_R13_BIT;
+
+	if (nps == AMDGPU_NPS2_PARTITION_MODE) {
+		flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH5_BIT;
+		flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C2_BIT;
+		flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B1_BIT;
+		flip_bits->r13_in_pa = UMC_V12_0_PA_R12_BIT;
+	} else if (nps == AMDGPU_NPS4_PARTITION_MODE) {
+		flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH4_BIT;
+		flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_CH5_BIT;
+		flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B0_BIT;
+		flip_bits->r13_in_pa = UMC_V12_0_PA_R11_BIT;
+	}
 
 	switch (vram_type) {
 	case AMDGPU_VRAM_TYPE_HBM:
 		/* other nps modes are taken as nps1 */
-		if (nps == AMDGPU_NPS2_PARTITION_MODE) {
-			flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH5_BIT;
-			flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C2_BIT;
-			flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B1_BIT;
+		if (nps == AMDGPU_NPS2_PARTITION_MODE)
 			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
+		else if (nps == AMDGPU_NPS4_PARTITION_MODE)
+			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
+
+		break;
+	case AMDGPU_VRAM_TYPE_HBM3E:
+		if (hbm_vendor == SAMSUNG) {
+			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
+			flip_bits->flip_row_bit = 12;
+
+			if (nps == AMDGPU_NPS2_PARTITION_MODE)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
+			else if (nps == AMDGPU_NPS4_PARTITION_MODE)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R10_BIT;
+		} else if (hbm_vendor == HYNIX) {
+			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R0_BIT;
+			flip_bits->flip_row_bit = 0;
+
+			if (nps == AMDGPU_NPS2_PARTITION_MODE)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_C4_BIT;
+			else if (nps == AMDGPU_NPS4_PARTITION_MODE)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_B1_BIT;
 		}
 
-		if (nps == AMDGPU_NPS4_PARTITION_MODE) {
-			flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH4_BIT;
-			flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_CH5_BIT;
-			flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B0_BIT;
-			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
+		break;
+	case AMDGPU_VRAM_TYPE_HBM4:
+		if (hbm_vendor == HYNIX) {
+			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R0_BIT;
+			flip_bits->flip_row_bit = 0;
+
+			if (nps == AMDGPU_NPS2_PARTITION_MODE)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_C4_BIT;
+			else if (nps == AMDGPU_NPS4_PARTITION_MODE)
+				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_B1_BIT;
+		} else {
+			flip_bits->bit_num = 3;
 		}
 
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
index ccdd6cd430f8..63b7e7254526 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -62,6 +62,7 @@
 #define UMC_V12_0_PA_C4_BIT 21
 /* row bits in SOC physical address */
 #define UMC_V12_0_PA_R0_BIT 22
+#define UMC_V12_0_PA_R10_BIT 32
 #define UMC_V12_0_PA_R11_BIT 33
 #define UMC_V12_0_PA_R12_BIT 34
 #define UMC_V12_0_PA_R13_BIT 35
-- 
2.34.1

