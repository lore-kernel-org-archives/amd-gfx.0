Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA0BCA0EEB
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 03:04:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36EEC10E33F;
	Wed, 20 Aug 2025 03:04:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YrwdsqUQ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8387C10E33F
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 03:04:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atvRidNxxtl1w+9KFgQ4++MClcAA5+CWRY9pNqjG7ENWiio7IHtq/igLUEWu5CjnOfXxvKLvAu0ltx1h9o6wpMMDIbt+ZNZN8DAlr0c1tHrEDhS72E6QpiKSaV7eo1I/WcMYmfgtWGi0Hkxd548f2Zz+C+abkr7/BhVzs90sVDiHzvb7ukjEW32+f3nChPwhTbtCaBt+GR3Nt29tk3DTuFUxyFrWY5xQu4trkvQhEmS7MUfAXFGTamcsxeCoNrt5pnQxNvcCo5/q55bNOU6GEENUWGWE5WXQZ0FxsOHRZlge0l3qDROw8iC/VAR9s4oYANbioq950CxH/YL+3z/mFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1khIjOfzcnaw0V40P9BEUEf0+wuUEkMSvpEpOH5OoA=;
 b=WT5ADX9WRKZh+iV2IRrBW6ncL1PkoZIRE0+WSttKuOq6PrYwnkq0S/XgSyiG4csrmtOuKudBb1rBu5UnVNqYo3JWTq2hXkQj0VtJjF18NX8PF/DFE8aBDBEHb3dazMNuXye1lJKgiq+kwdq193TLoXj1jp117EBPpfbIHlI1Gxhfi3YSOu/wwq/keMEMaoG93ogHmjVr3Lmvry4kmnC4L9SrVV33/liQ5Vt1Ify0goQwEmXohZNX5aJVjXBUZ8rquBQIAs9B8CA84P7isKZx92oBxC27z/+M7cTltBcDHBRIpf+iJU6GSyTkjgqcl+EU+XQ5GtUrhImNVvnTo7Tifg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1khIjOfzcnaw0V40P9BEUEf0+wuUEkMSvpEpOH5OoA=;
 b=YrwdsqUQgB9YiyXzL+8Tu4Jm79AZVHAshdNOWFaNozDsmICK8fxg3ksYLdhOhA8WPViFzpeIO1wMzTCa2/7yX1MAaYtBD0Pfpy5rPLLRqm0Pak06Lya9nomI0U/fS149XONd1KCyQJIll5LczeT15dxZtzNRQXvbCHm4OIdyoRo=
Received: from CH0PR07CA0016.namprd07.prod.outlook.com (2603:10b6:610:32::21)
 by MN0PR12MB6078.namprd12.prod.outlook.com (2603:10b6:208:3ca::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 03:04:23 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::81) by CH0PR07CA0016.outlook.office365.com
 (2603:10b6:610:32::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.24 via Frontend Transport; Wed,
 20 Aug 2025 03:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 03:04:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 22:04:23 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 19 Aug
 2025 20:04:23 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 19 Aug 2025 22:04:16 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>, Jesse.Zhang
 <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v3 5/5] drm/amd/pm: Add VCN reset message support for SMU v13.0.12
Date: Wed, 20 Aug 2025 11:03:28 +0800
Message-ID: <20250820030400.514460-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250820030400.514460-1-Jesse.Zhang@amd.com>
References: <20250820030400.514460-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|MN0PR12MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: bb067443-347f-46c8-ed9b-08dddf964432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9eywse5i4OWOmC+Y4XRpZaokWB/7gyc36Lqm7LmqSWQdMJEp3MbaqfK3W+fJ?=
 =?us-ascii?Q?ob2FLKu5lTLAT6y7rg9UX8B/aTMBVaGfAu5MTtLV3jOhU+hGDuS4+xU8DIdt?=
 =?us-ascii?Q?yY6PHyOg2ssk995k9TNkaHnt/Va6scGvmUDyRYIKV7ygGR44LzrNcD/6ZCIa?=
 =?us-ascii?Q?/BCSEEWElbqNoykvr1nmrw1u06nD+sAaG9t3k2Uy1j77sL64/2T8RRmlet9j?=
 =?us-ascii?Q?zlN2yKNHrnUYxOMFE3eLQ99BHtsMikocJ31CrZ9N5HeOFXwZI69zu9LGTETo?=
 =?us-ascii?Q?GIxBTo4P6KXb3aqOy7a22QcsKnK+4GI0zAJFGuNEiPdYjWWhep3vHhnj7y8q?=
 =?us-ascii?Q?CgbMD5N1XX6zBqOxZut5zWxA5VQHX3T6Cdhwpu1Uf1xnxXZelowBhGcYY87G?=
 =?us-ascii?Q?SwhHZqaGR4eQHpnzJBxdACcjRS8OaZDJuyH1ZSEoWNEE/rJtCfVeA6cys3pE?=
 =?us-ascii?Q?98x5jETPV3OTXIAxkOMZFO28ZsIdSKbyukGu3X6fCfvJwCRVHKQ3LPzRmV/o?=
 =?us-ascii?Q?FEqUqd8IzwC+5MUKtxkQlJDeDtBQ6R6FuoA5mnnTiAGhsdr0kuEz7CYyurJU?=
 =?us-ascii?Q?2r2iDvCt9PUPMIa5Lfm2EPer+hZSrLeVSuKjpKL1EjDOaEXT0GmldrzO11Kp?=
 =?us-ascii?Q?CFH+z6F1VGLS/ifNeKSvSEMEvjS/eQKffqJtd3nwonx21DzzJZlH+VivH9Od?=
 =?us-ascii?Q?Nf43eQz08ygMfbnSMFfIiICaxfd8PDWI1KDRwoJlS3pI6uOY2xG06KpiADq+?=
 =?us-ascii?Q?z68+B76FpoZ9UJj0orLK7KKHlvLDoUCuPw6QjqwIfhXLcMdf/T7PYwI9sauN?=
 =?us-ascii?Q?nRAFe+U3ALs0S4RGz9bYKtyALm3BUEvDApNWivGRdEbb5ctiikhBeaAoRrt8?=
 =?us-ascii?Q?I5gbR6MFXjOBlMpWIaqiCeTz/fddGCGGLt5oMGKtNkmzf6pzizq5QDiNoHHS?=
 =?us-ascii?Q?laXvcY0voYZRlCKSY4fY1wcDjTKJDt9k+nKSNeawlglHRIcFkAVOV3KdHIPQ?=
 =?us-ascii?Q?1+UYlvkzPUpuRge17FS/UHJEnustCSv1u2l9Jl0PjreNsNQ7cqU+3Q2xVMOF?=
 =?us-ascii?Q?Nz8IZl8WhC+28F8/77kvF8QpM5Fal7dcX9DsJy59tvrO20RjlawYPSfgHqU0?=
 =?us-ascii?Q?7+/F/VYyiqQjPR02aiAsC0lF4UC17OYC/AZATKVt6FNlaPB0LFAJa4XHXEgH?=
 =?us-ascii?Q?CjAIPMykHQoC0IadblEs7H67hxc871fMoY9q1+yzacbHNjRZ2zV57WXKMJ0O?=
 =?us-ascii?Q?T+gDFOpVn1vQogU16N+dReiGw+Oc68FnKhKiGyFwQEYSxFlJEiT5Hp8XTRkO?=
 =?us-ascii?Q?DV6uiBszHixiVYsLoGbKMNrIvJvF6WwGYBbXqRyHf2EkpE8GoFvpC96jZeYy?=
 =?us-ascii?Q?Wtgq76nkYFa/lvZyrTcrviEzCcNFUOb9EtwnKbzA1jiiy5gxLIV3xt/nJERb?=
 =?us-ascii?Q?QP/jKNJSPzoUczF1x5APwwzCTlQRfAiGyhlOnRWu8V81JLOlWIqTjZWJJw3x?=
 =?us-ascii?Q?woWVRb5//m3iqZ9pQDmSlnscxhUnQsvGpAqo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 03:04:23.8182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb067443-347f-46c8-ed9b-08dddf964432
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6078
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

This commit adds support for VCN reset functionality in SMU v13.0.12 by:

1. Adding two new PPSMC messages in smu_v13_0_12_ppsmc.h:
   - PPSMC_MSG_ResetVCN (0x5E)
   - PPSMC_MSG_CPPipeReset (0x5F)
   - Updates PPSMC_Message_Count to 0x60 to account for new messages

2. Adding message mapping for ResetVCN in smu_v13_0_12_ppt.c:
   - Maps SMU_MSG_ResetVCN to PPSMC_MSG_ResetVCN

These changes enable proper VCN reset handling through the SMU firmware
interface for compatible AMD GPUs.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c         | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
index aff2776a8b6f..037529eb70bb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
@@ -120,7 +120,9 @@
 #define PPSMC_MSG_GetBadPageSeverity                0x5B
 #define PPSMC_MSG_GetSystemMetricsTable             0x5C
 #define PPSMC_MSG_GetSystemMetricsVersion           0x5D
-#define PPSMC_Message_Count                         0x5E
+#define PPSMC_MSG_ResetVCN                          0x5E
+#define PPSMC_MSG_CPPipeReset                       0x5F
+#define PPSMC_Message_Count                         0x60
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 32fd0be05cff..a3eb19f702d0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -136,6 +136,7 @@ const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(RmaDueToBadPageThreshold,            PPSMC_MSG_RmaDueToBadPageThreshold,        0),
 	MSG_MAP(SetThrottlingPolicy,                 PPSMC_MSG_SetThrottlingPolicy,             0),
 	MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,                       0),
+	MSG_MAP(ResetVCN,                            PPSMC_MSG_ResetVCN,                        0),
 	MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticMetricsTable,           1),
 	MSG_MAP(GetSystemMetricsTable,               PPSMC_MSG_GetSystemMetricsTable,           0),
 };
-- 
2.49.0

