Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2031ECA0EFA
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 02:18:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC86010EA49;
	Fri, 22 Aug 2025 02:18:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="alKzeHcr";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C02410EA49
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 02:18:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBQFUtO9VKwGmT3zMNcZYJ3euJgwgxcbhCj97OMkyrhrSyxPXlT1a1Doe8CgI19KWDmewdKxOYB4zUjXaoFSeLQEM5Y45hV79tPBG1c2oHdBAXf/dCCv3Gpk6tVMf55E4Zbbr9VS03yI7mstltjexlgZJwICT3ZZGmgvh1eSAjk77luEK69BTZHTvPOd9Q4dQjxzIJkdzsnjVEVNKF2HFI133fvfFtHq2bkuDndKCJ0hwj5rE12BDXJ7RjP/L9Twf975WP8mGL/fVBkPogiUykk8UlJZQEBM+HMUAriiNT7C061PPOx2bzBa2V1YrhoeH2eGYOK1FP9z/zW28YjnDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDqEITW3CkwV+MhkW4+JenoMEoAxb4MDEv14+XEnYag=;
 b=ekZ1XNgGciV4/XFCjbXxW9/Vfm1haAThrG+CMU15eMP+VNpEInXJ1O/24GzMOMxBNuoeuUHL+2nGwnSLhYEKtzzlqdW0ikWoJcy5Y0mKW1Ae1hHlkJEhfDxPvAffWj9k6SjtoG7H1Hk0dWSln2Kyeeu7g3cBpqkqlat4oNIcy6xePu33OEoRHTn8+o0OhOgjK4udQ+CiFoxBC/7OhGwQlpqqFpdgwc/aKCBAqZdr1dRXj9z4BOxeIW2iBa7GfuHI52hpBvVBdE3/6EeBQNvnISbDlTS2cWLbuxzjsswBEj5VQFxcX2EUPFJCfvpEptAcmbnL5LXu/ne4jbDQ9FoRmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDqEITW3CkwV+MhkW4+JenoMEoAxb4MDEv14+XEnYag=;
 b=alKzeHcr/HwNC/dKjy/dmQ+NKjiyxtxmhcwLWcoWQdOKJ0ur8YSfLGPlBe9FO+jgST3wyX8iajSoXlF1vqMCzjejfbe+TzA9zChLVhnQbcPQR5QKVx8olDHKeFBCe6F+SJt+5CrX1oZl5Fr4kFOdWIJN9d4sOeVwJ13UHEslHdo=
Received: from SJ0PR13CA0102.namprd13.prod.outlook.com (2603:10b6:a03:2c5::17)
 by BN3PR12MB9570.namprd12.prod.outlook.com (2603:10b6:408:2ca::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 02:18:23 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::7b) by SJ0PR13CA0102.outlook.office365.com
 (2603:10b6:a03:2c5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.7 via Frontend Transport; Fri,
 22 Aug 2025 02:18:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 02:18:22 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 21:18:21 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 19:18:21 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 21:18:14 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>, Jesse.Zhang
 <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Yang Wang
 <kevinyang.wang@amd.com>
Subject: [v4 4/4] drm/amd/pm: Add VCN reset message support for SMU v13.0.12
Date: Fri, 22 Aug 2025 10:17:35 +0800
Message-ID: <20250822021801.630568-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250822021801.630568-1-Jesse.Zhang@amd.com>
References: <20250822021801.630568-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|BN3PR12MB9570:EE_
X-MS-Office365-Filtering-Correlation-Id: 42430aa7-e0ed-4750-7c7b-08dde1222b1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KNLwh3g2B3Zt3FLbk7Wm8lL7aMJT6RSD07wXdxv5PVwCa9K9dozBuyGdKmBP?=
 =?us-ascii?Q?JXGJttChrbqWUmLWu1e4gdZD7g8rG4Uvki1rSX++U3c5Aruh9Gp6gFng8avB?=
 =?us-ascii?Q?Q5dFUN5skMArDDGyDG435Y4Jkxp1fooTxnEyRObbP5yftu17bdmHBmPdA+ys?=
 =?us-ascii?Q?t1CxP+WIW4asb7DnNAXo4G2YYadT78j0x3VZ5Hf81fFhLa9M12dXsukaF5mT?=
 =?us-ascii?Q?R92U9DXqZRLx2zVTwL5yprvqxwyzQcg6fdfWruKtb17I9HEvUJIMFnR8TDGC?=
 =?us-ascii?Q?yUrkBGhdTG1tjH1T7S7akg6vC3bqWKrj5JG+DFOBPtlt2nnAdR0pKG158DT1?=
 =?us-ascii?Q?0eMEkMD9giMq5bHF7DTo1u4nRpguuHXQDGTmUUNP4Zt9LlyHb6sZ+JncJTSO?=
 =?us-ascii?Q?muXcFo+08yMuop1d/kVjSqESMTJbL9GdFPBwy7rbVWu3C6yRNBldrsJM2Wa3?=
 =?us-ascii?Q?XZQjkEa0oF5wjoXGoP1yVQAfKJfx1xZ8POM1XLbuCkTpdPhwA5zPJ4BAitUJ?=
 =?us-ascii?Q?90DKs2bjZvbFZr7Ltr8VF3m5q69+JUbLkvrb2UD+Axke30mGMpCcXtnODsVB?=
 =?us-ascii?Q?wwTddE9QpuR/vjDI0tVDn10PUXu8pMphU3bMZINDhwK2fX1rK4PurGXZqXMD?=
 =?us-ascii?Q?PPtR4PpQ4S1HJmnNQTl9OP4ajxROzzq1CrIe1X5rU4s+E9b253xenvKYayuB?=
 =?us-ascii?Q?8DeMwGJcVP97qLhtKKGofMpbbLF+MqZTHc+LcQj8hwDCbXevgtogaVOo/L8r?=
 =?us-ascii?Q?sAW9HMR8dKN4pI6gQAb8DIsBSrjXmZSIUz7YVhiuvwB8N0AKCB1PMs7Tu2qC?=
 =?us-ascii?Q?lM4E9n08WmwceLdtWka/cjadWiOKxttVIw+kIa+Tcel5zQo9dmN99lYpwYvu?=
 =?us-ascii?Q?Z0j600Ud/yh9k9C+oU6tILMDDRX9Rcb5q0XsEFmfsyd1WVSH8bC0zfVdbxW9?=
 =?us-ascii?Q?sQ3eQk6MclCS6F7TfS4fTOPjs/G795NM1lYiHaQi65dQujuTypTj3I0yV0Gw?=
 =?us-ascii?Q?HZZR/yBPqZDu5aH6ZI6XRW62l/MaXRmBupIC3T1Xk7LrjvvSMRivtFUA1eb4?=
 =?us-ascii?Q?kvH+tdaSZAWi3scBp4RS1zmT0ic3G5P2dvqZZibEqOFvTjHAmbNCNRmys5Si?=
 =?us-ascii?Q?I6N8CvACNS4/Ib7CnTzGzKQM3FT63D6BTaJ1LO0L0rIB4GS7ir7QV9V2TcOB?=
 =?us-ascii?Q?fofXKWBQbTuYMnvvK1KEtIxm7FGiVZfRDFFCsDb3UlgkLZG7CyntYMqr2p6f?=
 =?us-ascii?Q?Fy523k1AYPU4Lvo725rzZJup4M2d8KqWBb//B89RfkZZ2p7Hu1z8njzaZhZg?=
 =?us-ascii?Q?Oom6BqB6g7MVDYsu0OHbbhP48yqtCy0e7EMILyRzCyfkshjDuS737pAKpR1j?=
 =?us-ascii?Q?oN14ULy9v3Ts58mcYL8hIKuNRwVoVa63mZNdr/KVCr7sSYYysdpDrSpfen4z?=
 =?us-ascii?Q?jlUeNclfSWqu8f50Y0bfcMU1+xnyB99V52CDDZwpqMvv9MwHarvgz9zMl1qi?=
 =?us-ascii?Q?qQ4iuFVjsPgg5nQ2CBO+KsnO2pQ7o/hYEspa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 02:18:22.3363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42430aa7-e0ed-4750-7c7b-08dde1222b1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9570
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
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
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

