Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FADDCCFA05
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 11:44:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA3510E722;
	Thu,  6 Nov 2025 11:44:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VBrOWljA";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010041.outbound.protection.outlook.com
 [52.101.193.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63EEC10E722
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 11:44:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1uQxpJXHhhSmloMjOIxTVIIjVmCtOpteTYphe9z/JHiA3tXa0/KBidNjr18SJDAA+ETZvi1r0/3rrNcf22Km20p/vhAQ91r41jdip3Y5HaK9TCfKQt/ACBeyvdEKgXhsN8Y+QW3MXdxL5Ah331e+Mq/GsEMP5NjT40LFU5N1JyglXlZyi+0NEYU7zx9+/NIjpDx356bPfKEIqF2rod2bzzQ0pL3Cp2moPRiJ+l9BvmttrcH3QMi5StG5dMBUbC3tqaPBtJN9szv/FkcEfirPcpsQ3ZWOdIWrXlVR3AMRDetGgeKCKbJAKF43Cs1HiE2HCdacbgA6i8LwQUlMlC5Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYjYRBjw3f6Q5jL/KEo9rgiZFUGFn/yyWIsC+OH6ZtQ=;
 b=VDgCZt6FkTohqclsCrKg/cI9jE1C3Ds83H9FyVGqm5ffQi5Sr0UDaKm9FWGrja3jtX0PS/g+1dp7AbHI3e7QIthHrrGR/R8lHIVTK5WAJ/zbTj5iu66brRgab1RO4qEx4wUb7Eg9s6eho4qExFCT6u8e5/Cn2EvtxJPXnqZztEwN7M9cmnfK3ILhhOM/AlxB3ZrRe4zefFUr6Gg03a6Ck125bUwyD6Hs4lPlXc946YmDv/BUpo6B1UxKuBKFYHhcbwJDay83oCNcWRh53VivxR4GVGaXFsQAZ0Tem3zOsqmROeyrQuv0W9EdIlAL1AMFoIe5tI/IGJD8HNHoxiQlBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYjYRBjw3f6Q5jL/KEo9rgiZFUGFn/yyWIsC+OH6ZtQ=;
 b=VBrOWljATx2suHTP+KIowa4rurBN999W94MyFMtUsehJdTZH59cnft2JZj5M3P4xd27rnWQyqAnMfk8M221cPi1M5CFJUFVb4+b1MeRSlkGchj/AoqHtcfI/5uyJk8GCMnOIDHVglbvsn1qvOXxBw6lhE8jAxUwJ5cbK0nw2C0w=
Received: from BL1PR13CA0292.namprd13.prod.outlook.com (2603:10b6:208:2bc::27)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 11:44:36 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::19) by BL1PR13CA0292.outlook.office365.com
 (2603:10b6:208:2bc::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Thu, 6
 Nov 2025 11:44:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 11:44:35 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 03:44:33 -0800
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <asad.kamal@amd.com>,
 <KevinYang.Wang@amd.com>
Subject: [PATCH v2 1/4] drm/amd/pm: Update pmfw headers for smuv_13_0_12
Date: Thu, 6 Nov 2025 19:44:18 +0800
Message-ID: <20251106114421.3770378-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|BY5PR12MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d4d87c0-1690-4441-8714-08de1d29dc16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gus35DVzJ+8ezxPUXOvdlhVLA13c/7cVhFrdMAfFEdl7BGs7AJtyLkOtBA9W?=
 =?us-ascii?Q?Xzvw8QBmoJXo7siOhlZCTugr/Sjb5iKF7up+dhHc1yCZ+BSGL7Ykhft4Nogt?=
 =?us-ascii?Q?5a/VDMLRLOsaeakmVgS6ekCBMBJmRC9N5GQAqTO9V4nlQGLyHpu3LuRvfYEi?=
 =?us-ascii?Q?NcNc4JG7FfEkh4k+NGfsqwC08r2sX6ZNm6nChWvZpX2kLkgSJl3hYDx3GrPB?=
 =?us-ascii?Q?UUupDaCLZRi12syfBwUZWR8BaRD897UuFf4P71Z+IoLZW+ua55UHZaSYME/V?=
 =?us-ascii?Q?Nxw+rQYMh4fkCrzGO1LBSkW5FeixKBr5y/V69e7SuRPNWigkrNiQGTxrONUf?=
 =?us-ascii?Q?UlvsIUrA980KHD4RgstC05hbLSJZhw8fV3iLAfxKLgiPhhBctkohLaRH/WDT?=
 =?us-ascii?Q?hnBbrRtNhHSaebuiLxzv94+NPPjDaJc1xXk5IkhvdoB5vrOyXgIzHzOq1IFU?=
 =?us-ascii?Q?iWoQ5Cph2UuGLg1iNfxAfM4E7ZXnViAy7ENT0Vnn6epY8h0ccqUNWYWH3cKF?=
 =?us-ascii?Q?X7WKxKBPhENBk8btW4YbAOOq/7/gFhMVA3tAQtz1NcZNGeviyt1uPU4mwCtd?=
 =?us-ascii?Q?nZZKrxhEEeAB1OPLVjU2lIpT0F6ZmYQ2xta/5Dx8QT7koQr0MVgN9rZpJYdX?=
 =?us-ascii?Q?g+6qcGp2YFZjuGSjZffZr49Jx4PFIzWrgeH5KR+E9uFj299A6xXL56DPcOy9?=
 =?us-ascii?Q?KQ4pAGqCQg/Sy2cT/oYpaA6z4WB5qZrApIeDfq9uXSlde9S4g4RFJwOWILK/?=
 =?us-ascii?Q?F2fxb8nfWHcY2q4AmhlmWQuIAFy4ZHU8c1RPMNTWh6ZGnlGZW+bIAEMg8Ff0?=
 =?us-ascii?Q?9b/quO37cKZEg5Shl1A+OVoGH+C2pytoB49WGSpEj+VM7Pm8zYgf70Dww7O3?=
 =?us-ascii?Q?YdHOyyoH6BmtLgddJM+98OYKRNHbnHbbYJvWTrELcfbsTlTD1wW4CmfpYcp+?=
 =?us-ascii?Q?CDfAuPZ5Az+Ycf47wtW8Xdn28bS20dHbht9MDE2YEQeeOtunNBdFXFpB30SZ?=
 =?us-ascii?Q?xYnOnFd6a/oeQykYsfFhf8WATFalh0KHNZ1fBaXtMVLlC4aMqZyu5VYqCczQ?=
 =?us-ascii?Q?D7FOIFYV+GyXUK4gdgEqIOnWqAlx2moZnr8vnv/r5qIvaUKiWlpoXwSO45kb?=
 =?us-ascii?Q?NgB59V445/1ADcTLL9PMWWgJDEbQbJYUoPgt6CwH7pcYoX12qMYwVnD5Tf9l?=
 =?us-ascii?Q?zHhBZkjB7Tbe3IV8qLVt9iFKtGGWztnDG5hBC+zknbAy6yJo4nWPm/kr9EdV?=
 =?us-ascii?Q?/U2uPRs5kxbr1fy0LPSiRiJeXTHxz9Yjq51mNkn9XbGuVu6BidjCshedE/cL?=
 =?us-ascii?Q?dG9eulYlZkIYF7CgHaDaL4O6FuGt8oPbd/aPV9s/3BZwQIjV3tCPGdX0lU7m?=
 =?us-ascii?Q?J7tnp/psixKtblxJvZnHxjooPcCQEiEtOhQBzzImlUx/7VqV1o1uy2on7uj5?=
 =?us-ascii?Q?7MhMTUg3iFLHQw7g+qkUmu7ar8pgRI64yY+FTAX9t0w0zlic1JD+6oTYZVQg?=
 =?us-ascii?Q?bf8LzEi1FnvDpreeJLwR3S8jw6UfKV8K2zk1gMFQuBDG2L9snVKdBy65TcVT?=
 =?us-ascii?Q?tG2kXa8fV+QqZlKc8H4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 11:44:35.6089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4d87c0-1690-4441-8714-08de1d29dc16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097
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

Update pmfw headers for smmu_v13_0_12 to include ppt1 messages and
static parameters

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h | 5 +++++
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h    | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
index bf6aa9620911..bb7d48e3b60e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
@@ -367,6 +367,11 @@ typedef struct {
 
   //Node Power Limit
   uint32_t MaxNodePowerLimit;
+
+  // PPT1 Configuration
+  uint32_t PPT1Max;
+  uint32_t PPT1Min;
+  uint32_t PPT1Default;
 } StaticMetricsTable_t;
 #pragma pack(pop)
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
index 4b066c42e0ec..bd811efa3232 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
@@ -121,7 +121,9 @@
 #define PPSMC_MSG_GetSystemMetricsTable             0x5C
 #define PPSMC_MSG_GetSystemMetricsVersion           0x5D
 #define PPSMC_MSG_ResetVCN                          0x5E
-#define PPSMC_Message_Count                         0x5F
+#define PPSMC_MSG_SetFastPptLimit                   0x5F
+#define PPSMC_MSG_GetFastPptLimit                   0x60
+#define PPSMC_Message_Count                         0x61
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
-- 
2.46.0

