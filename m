Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8B5C79FA1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 07:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E225B89D63;
	Fri, 11 Sep 2026 07:22:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d5yaIjYR";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012052.outbound.protection.outlook.com
 [40.107.200.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A81D89DA5
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 07:22:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZI7FJRumRv671LqD2qrur/G9IuBCqZqvLqiJjmOtcXZmeg0am43hMu4mRcxXGD4hSNb4X7+LwPzBP78/lbr6VGJX1Rf0vIQ37TVwvsR9a+D7YAa7aP4q0nhXbYQV+/1rEdH2XKub1jBtFADI2HOhI8fk00tMIICcl/Ae0Afou9mmRO7rRlzxyQbhv+ucjEVaUUHP9TbsBK+vHP+qK1zyoooxGxZCujUJmkyrvFoJfj7f3sRp2m/cL0N/cQJdLFN1UG7I9BZIXH49Z38jEj9LQCAmmLhEy4P+OrqqRPYrwfAD6UeJDDNkzqfIMaG8pYNa51cH/DenJ2EXrhm+qbNnhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDHKFeROYqPN8W7wh8wpkTrhkQP8khIjuBaoF2oJLys=;
 b=NuyzFx65eu0TlzWfyw6j68PwF+DbuFEXQSUJ4qov4CPR1d0RhlhSzJz9f1tPAQ6hNxwhJxdNUIjrnahQQw7FdN2ImCKk19XLacWDb66AZW7eLUY1Z/wCSP5SL7Xzr5zFajD0xOhPVZT0igo7xfoJRgkntVkc6Jd+RWoS6toAPcNvMDuy1GUGOB6Jdssh1FGDBA0F/fsBZCm6ZPyzAo94kDb9NquXUcNtDZgDGHCggkPxTI2qX1y8ZfvwmlH7IkYcFUneQHr0GLkUarCu/p70+J2aBB/LEUJVgRCAnE+CV8kyuCIw+aR6ZMcogZ47+RyZZrnQVxvXp7tALh9r6V+hlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDHKFeROYqPN8W7wh8wpkTrhkQP8khIjuBaoF2oJLys=;
 b=d5yaIjYRxNPFQmPqQ8cRoxF7TreRD0F35cyKH6IJVHnuItA9T3ZWRvN9jpZkSFaE9ZCJZE1Pe9AbaO41/MJXBuDfLqvjQxuehdV1eipKWw1S7EWOPOPccudKowJDWqe+NvvJ0pvFdgcw0j7dEU8bCp1d8WPAWIv05jviffQf8yE=
Received: from CH2PR17CA0030.namprd17.prod.outlook.com (2603:10b6:610:53::40)
 by SA1PR12MB9246.namprd12.prod.outlook.com (2603:10b6:806:3ac::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 07:22:33 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::43) by CH2PR17CA0030.outlook.office365.com
 (2603:10b6:610:53::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 07:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 07:22:32 +0000
Received: from amd-03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 02:22:26 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <kevin.wang@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amd/pm: Add GetRmaStatus message
Date: Fri, 11 Sep 2026 15:21:56 +0800
Message-ID: <20260911072156.1698346-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|SA1PR12MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fc6fc56-e0c1-44d7-9411-08df0fd5721a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|56012099006|11063799006|6133799003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: I8tgdXZgkgW/Fowu8TmJo4oFo3LN6c2iX1DtZvIOImmewNA7eKytYD/0goFu+JDami3KJzyZS5wQiVwJng+E4UByi767uSzzE4exH2EaBTEvlhATS5dwptEmQXxKEwZqrdQWEPK+F/9/Z8mzjDJQF4qQiU1fSrrROazJwVOapritGPdHf6FKKaQian9UQJ4h57kNTzrc6B1r4YI7NJ4kFhhCf66gE5xszJBUohzIi5/IZiUj9wQF5LH0dMure0DuZPTrhU4uW2owZ0Yr0tjEJAEpW99iQS2dPxuQiaEiiYmZ37o68qUewcdpeAXNhpqBOMFFwSxuRQzhD9mD0X9sGNfwVlT5cKLdV2j+mhw0bDzIWKTIXRCYUPDNhfwHFmkqqmM1V+Np/q3I5EQ3Ja3mbGGR4hhmQqVqY2lL7GNUfpUv69b3S6JR6M2j51yM8AWMpbenOG1YeLQk058KPVBig1We9zlqa8GJtDppZUhbbiYNqDDv7z4uXcE7YVegzJroiqO2ChPgF7eIZN7KNQ/H7ZuPjwNtVkCSHTfxd1OvotFT3V/LCMNxYwdqkWvGTRg8cvGeycnjjQvDfbCMuarUwVwOrLImfDG8TkLDbnKLtyyDDL6UNI4KLYND/xWnNpePjahdthQzIAg9MtSQT3BCwakukhmvHNBhHfR7AOPeRKgf5dWdTOG1bz8G+BsEkcMPfnPd46WkCS1SbA1j/QswXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(56012099006)(11063799006)(6133799003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cGmgALsAL2WbATlil4b0CFzXErPuRpGkkuzZQ+sdmcLN3Q4My4jM7oAtNSnEMwbl+iex3GzbxfRTdNCAvtsX1kGLSOUCfK1QquI/NluHcCTZNCqQXa/p+QvFG6WukxcpVFlexdwBpdtYJc0ALQMbY+fPT6AOhIhiLCK5Jp4q2SEDIIkz8FTWPeTvya7qRyWJkPnyGC7cyCGXKuNsAdiEr4aHabPVRUtPug9SMQ8nv54NH7jMRWpUZJO9dDeRoyd09hWeoG/e5fLJVgQ/3YQ48Tp+RSBN19K6MmzoS4akadHGYSyQwQ1sSNMTZGzYjPWbIwL4nmWcaCl4gNI7st3R9I8GltnN76P75XoU9jE/RNrZVUbPr+pNLvPg5MwHAwpoWcXti+pJU8Q31hxdji7K0wkt1+JxP1tim3QY42w9ydxffY0h5+lHvFBCFDv3LYJl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 07:22:32.6141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc6fc56-e0c1-44d7-9411-08df0fd5721a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9246
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

Add GetRmaStatus message for smu_v13_0_12 and smu_v15_0_8.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h | 1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h                  | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c         | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c          | 1 +
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c              | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
index d09b6ae9827e..ac7e617e64ad 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
@@ -105,6 +105,7 @@
 #define PPSMC_MSG_UpdatePccWaitDecMaxStr            0x4C
 #define PPSMC_MSG_ResetSDMA                         0x4D
 #define PPSMC_MSG_GetRasTableVersion                0x4E
+#define PPSMC_MSG_GetRmaStatus                      0x4F
 #define PPSMC_MSG_GetBadPageCount                   0x50
 #define PPSMC_MSG_GetBadPageMcaAddress              0x51
 #define PPSMC_MSG_SetTimestamp                      0x53
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 1edef38c9209..35ef95a820dc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -292,6 +292,7 @@
 	__SMU_DUMMY_MAP(GetStaticMetricsTable), \
 	__SMU_DUMMY_MAP(GetSystemMetricsTable), \
 	__SMU_DUMMY_MAP(GetRASTableVersion), \
+	__SMU_DUMMY_MAP(GetRmaStatus),    \
 	__SMU_DUMMY_MAP(GetBadPageCount), \
 	__SMU_DUMMY_MAP(GetBadPageMcaAddr), \
 	__SMU_DUMMY_MAP(SetTimestamp), \
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 0033453f27e5..4f3d59897aae 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -152,6 +152,7 @@ const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticMetricsTable,           1),
 	MSG_MAP(GetSystemMetricsTable,               PPSMC_MSG_GetSystemMetricsTable,           1),
 	MSG_MAP(GetRASTableVersion,                  PPSMC_MSG_GetRasTableVersion,              0),
+	MSG_MAP(GetRmaStatus,                        PPSMC_MSG_GetRmaStatus,                    0),
 	MSG_MAP(GetBadPageCount,                     PPSMC_MSG_GetBadPageCount,                 0),
 	MSG_MAP(GetBadPageMcaAddr,                   PPSMC_MSG_GetBadPageMcaAddress,            0),
 	MSG_MAP(SetTimestamp,                        PPSMC_MSG_SetTimestamp,                    0),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index b886208ad93d..b69efaecc1bb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -126,6 +126,7 @@ static const struct cmn2asic_msg_mapping smu_v15_0_8_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(GetTimestamp,                        PPSMC_MSG_GetTimestamp,                    0),
 	MSG_MAP(GetBadPageIpid,                      PPSMC_MSG_GetBadPageIpIdLoHi,              0),
 	MSG_MAP(EraseRasTable,                       PPSMC_MSG_EraseRasTable,                   0),
+	MSG_MAP(GetRmaStatus,                        PPSMC_MSG_GetRmaStatus,                    0),
 	MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticMetricsTable,		1),
 	MSG_MAP(GetSystemMetricsTable,               PPSMC_MSG_GetSystemMetricsTable,           1),
 	MSG_MAP(GetSystemMetricsVersion,             PPSMC_MSG_GetSystemMetricsVersion,		0),
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
index d8a446d0179e..7ca2f33f2cf0 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
@@ -36,6 +36,7 @@ static const enum smu_message_type ras_smu_msg_maps[RAS_MP1_MSG_MAX] = {
 	[RAS_MP1_MSG_QueryValidMcaCeCount] = SMU_MSG_QueryValidMcaCeCount,
 	[RAS_MP1_MSG_McaBankCeDumpDW] = SMU_MSG_McaBankCeDumpDW,
 	[RAS_MP1_MSG_GetRasTableVersion] = SMU_MSG_GetRASTableVersion,
+	[RAS_MP1_MSG_GetRmaStatus] = SMU_MSG_GetRmaStatus,
 	[RAS_MP1_MSG_GetBadPageCount] = SMU_MSG_GetBadPageCount,
 	[RAS_MP1_MSG_GetBadPageMcaAddr] = SMU_MSG_GetBadPageMcaAddr,
 	[RAS_MP1_MSG_SetTimestamp] = SMU_MSG_SetTimestamp,
-- 
2.43.0

