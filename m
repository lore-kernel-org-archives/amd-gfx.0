Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADFACA0EC4
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 04:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92A0710E6A2;
	Wed, 13 Aug 2025 04:09:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="flTFrDXF";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4593210E69B
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 04:09:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfAjvlK/FjSsR6fJgnl3xQRNFU08Ne9t0nAklM4AwLY9D/kSqOZkxi7ub/swEWivwk3EkR6b2E/9X1ti016gqfuyamwihi+pKxP5dx5gEiZ1fIMpMmDeV6urc6DnEcMbTAQ4FzKZeTkogSKsJkjCXcMp5O14ERmogANvX6sesg7wolGcKhxPWdsVtpGN07K9dzG4iwkg4vae2H8MfvXN6bxo8iRfLbwtZyCMU9/HUnU5YypdR8A6HYV+vgtfe0qw6eNKQl9hkjd9AOb5LoYfaxlcr6OpxZcoJNjbXKddwe6s4fYhuHF738kUlA904e+p7KaYc9RyL+p4zqIXNwU3cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBXh1UoH8qFPnf7EwIN3XMHZVKia7DX2kAhUKAL/eqY=;
 b=Ab+kWVbv57rPic9e4tzkzAE5d2KQcV2R0nwzAzMLcEubTuggpsBaDCf1mgDF5ZnlwSu1FpIyd5ftqVS6eocFEBQ0QlPGg7MLXv7/L/RYSz2HOR0i4kjkR/IS9W0BX1FGiavcZS0cjQgJLoyEDAQOrTVqzxC9NOnC5sdvV/hJIuy/gDn8sjVfZWwzmZDuGbZJvM8hMrhcfeFyBpm9Jtgt11+AsniU8v0EVKH4ifacgdCLBZfnoTzNiHjxc8vjBsrfnmwdfIsCZF3ODGbKpEphOV2y270H9yCnAeWaEajsO8gxhbblMMN3ZUk88sKYpiBy84sT2EZcOigkz60v/ZmMMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBXh1UoH8qFPnf7EwIN3XMHZVKia7DX2kAhUKAL/eqY=;
 b=flTFrDXFasNeDExWgc4y/Ae/WQ2Gd/aZkMgU/umnyIG745sNlsCt+sOCsYd+9ZLXANPrAnd5nSs8rv0Ef4LQkIQ7O0pU0pDyWALhUBsiIzbvLuy+9BUa67oy6/g8BFxd0YMv7JYNtzsmXPVd3Ee9eQgMnMuBWcHBgavL211Vr7Y=
Received: from MW3PR05CA0026.namprd05.prod.outlook.com (2603:10b6:303:2b::31)
 by IA1PR12MB8408.namprd12.prod.outlook.com (2603:10b6:208:3db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.23; Wed, 13 Aug
 2025 04:09:10 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:303:2b:cafe::2f) by MW3PR05CA0026.outlook.office365.com
 (2603:10b6:303:2b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Wed,
 13 Aug 2025 04:09:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.0 via Frontend Transport; Wed, 13 Aug 2025 04:09:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 23:09:06 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 12 Aug
 2025 21:09:06 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 12 Aug 2025 23:08:59 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Ruili Ji <ruiliji2@amd.com>
Subject: [v4 2/3] drm/amd/pm: Add VCN reset support for SMU v13.0.6
Date: Wed, 13 Aug 2025 12:08:05 +0800
Message-ID: <20250813040851.3435890-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250813040851.3435890-1-Jesse.Zhang@amd.com>
References: <20250813040851.3435890-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|IA1PR12MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dfe752c-56f7-4cdf-7e2f-08ddda1f26b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M02sOuBTDgmUKpaE956ZtEAhWMrkiIC5ut64y6BekyZke1JX6eWi4wAUYDGb?=
 =?us-ascii?Q?TdfhUhNNyruqTVF2RN9vmvIie0Tudq2xDbOazML0xT21YuI1F2666CxAdvQc?=
 =?us-ascii?Q?FkF0RWr35J8/qRYdmJDFXxCqMvF87w9RcCmeCIUYJIb5KWMfxZ23U8uYDn4/?=
 =?us-ascii?Q?ZGs9YalOMxYpoIED8GEpqb4jfHXoz67rXK9hRp1WwJeoQu3m6xSJAbuhdOag?=
 =?us-ascii?Q?E8Ix2SGw7xtUYDJem5KK+dBXhwXngX21PVGqSEJSRXolyhpQaUHT0qFnlLz9?=
 =?us-ascii?Q?uaJNYNuKQPXrnhlM9lePTyA/xKdauwSpOjp3kFCPY4PUaaOeWz+oqWroFeli?=
 =?us-ascii?Q?X2+kIsDJeidLVrXLYPYTmijoEeQt1XorgdvZgBBs3seac911hCMiYLQjJBxF?=
 =?us-ascii?Q?E0ZNsX3NMTAUki83P0ld2Ozq4AlR7BizsyNbCJgPfeMPd/IsE5yhIyaFIIsl?=
 =?us-ascii?Q?UMWI6RKSez5sudfSDBtdJ+u4SR2QpCHAjZ08MGou+Pmcofj3mrSswvTlCgEF?=
 =?us-ascii?Q?mX5zHITv4gmahymDNlj8c1f0nwdMUI1JVjuhWqDyI7t9Br4DlA6qizUv07Ge?=
 =?us-ascii?Q?NBCon5WX8XmEhcp4KfULAqjhvab+Prf2pfsTlxIHjUG4PTumb1LaQKmAMrwh?=
 =?us-ascii?Q?zoGFOmytBIoi08getrLnYZ1JuecUcGKlyk64OjqEfQWeV7rJcpRzsjVlwXCq?=
 =?us-ascii?Q?a4RHIj2lun8AeuvRCcHyBGuF4I9v5T/6WHIZl/Dfb9eqi3T6e3f6GABjNl0q?=
 =?us-ascii?Q?zFkXGSSsJaDIj7TV5akjoR8jl9NZU1G+/CEONr4jFdjF8OUBIF8lF6p5Botl?=
 =?us-ascii?Q?3JObaNrDKeutaoLYFnc4iuqRM+HEK9bnjSKUfn2Z7nnZSMLG9xQRxcXAvq2J?=
 =?us-ascii?Q?xk2oFZssqHaplpZPhxPXJchqpLBkkX3YAtr0o1QRPX/ucPbcW0scK3n3aTHU?=
 =?us-ascii?Q?7ZsxgjgW6E7uo16UhStFLEKLUIjt6nTBjp6aNrsMiUNNZtmnyP5oyRmDXF36?=
 =?us-ascii?Q?CRrq+VyxvHWeWDHlAluavjncWBKEKwFsBVHJ3EOc8LmIgCoTR+TEKcSJpQoV?=
 =?us-ascii?Q?jyf2bJVG30MFUOviCBDFKk25llhbzwFekObq44vGOYcWsysmyzvakIViQqse?=
 =?us-ascii?Q?zo18+XylSySK6dAw4sieBGaJjTjAkYHXRa1o2JgGwJd+6zvwe0nl3MGMoXDs?=
 =?us-ascii?Q?w3M1qvTVgciQYTzkBUIqdiXIrc3SBUFBXHN3hPQTVJetRdAqlwv4D/OvVuEZ?=
 =?us-ascii?Q?dq859igIn2EbaczlNksYfD3MEklzCGh3rr4vF8sXz+iEJh3sdcgU7PA1jkLm?=
 =?us-ascii?Q?XmGX6LnJC3RBL9tmQkoYPDM2Qko8Rt+7ijOAWsQYw7vhBhnrJ9cl5+WoWrqE?=
 =?us-ascii?Q?+i3k7Vks8KmWXSMC+XVEr6QkDwj0NkFcjjb3ciubW3JQmQdf3pWbOiFNPRAn?=
 =?us-ascii?Q?CxuV5pE4GYsZ6ff+VfO+2Z02+R0BkNP03Q0YVCqcSeTGFKFlLkFulTuYjD71?=
 =?us-ascii?Q?u6hZKDsJ0v62yE0IxkGCQ7ujiArt1tLqliJv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 04:09:08.3318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dfe752c-56f7-4cdf-7e2f-08ddda1f26b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8408
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

This commit implements VCN reset capability for SMU v13.0.6 with the following changes:

1. Added new PPSMC message ID (0x5B) for VCN reset in SMU firmware interface
2. Extended SMU capabilities to include VCN_RESET support
3. Implemented VCN reset support check:
   - Added smu_v13_0_6_reset_vcn_is_supported() function
4. Updated SMU v13.0.6 PPT functions to include VCN reset operations

v2: clean up debug info (Alex)
v3: remove unsupported message and split smu v13.0.6 changes to a separate patch (Lijo)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Ruili Ji <ruiliji2@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 .../amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h   |  4 ++--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 14 ++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h   |  1 +
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 41f268313613..63a088ef7169 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -94,9 +94,9 @@
 #define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
 #define PPSMC_MSG_SetThrottlingPolicy               0x44
 #define PPSMC_MSG_ResetSDMA                         0x4D
-#define PPSMC_MSG_ResetVCN                          0x4E
 #define PPSMC_MSG_GetStaticMetricsTable             0x59
-#define PPSMC_Message_Count                         0x5A
+#define PPSMC_MSG_ResetVCN                          0x5B
+#define PPSMC_Message_Count                         0x5C
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 3b4bd7a34d04..db3dd5d5c26f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -436,6 +436,9 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
 	    ((pgm == 0) && (fw_ver >= 0x00557900)) ||
 	    ((pgm == 4) && (fw_ver >= 0x4557000)))
 		smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
+
+	if ((pgm == 4) && (fw_ver >= 0x04557100))
+		smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
 }
 
 static void smu_v13_0_x_init_caps(struct smu_context *smu)
@@ -3200,6 +3203,16 @@ static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 	return ret;
 }
 
+static bool smu_v13_0_6_reset_vcn_is_supported(struct smu_context *smu)
+{
+	bool ret = true;
+
+	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(VCN_RESET)))
+		ret = false;
+
+	return ret;
+}
+
 static int smu_v13_0_6_reset_vcn(struct smu_context *smu, uint32_t inst_mask)
 {
 	int ret = 0;
@@ -3888,6 +3901,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.reset_sdma = smu_v13_0_6_reset_sdma,
 	.reset_sdma_is_supported = smu_v13_0_6_reset_sdma_is_supported,
 	.dpm_reset_vcn = smu_v13_0_6_reset_vcn,
+	.reset_vcn_is_supported = smu_v13_0_6_reset_vcn_is_supported,
 };
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index f39dbfdd7a2f..bcb8246c0804 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -64,6 +64,7 @@ enum smu_v13_0_6_caps {
 	SMU_CAP(RMA_MSG),
 	SMU_CAP(ACA_SYND),
 	SMU_CAP(SDMA_RESET),
+	SMU_CAP(VCN_RESET),
 	SMU_CAP(STATIC_METRICS),
 	SMU_CAP(HST_LIMIT_METRICS),
 	SMU_CAP(BOARD_VOLTAGE),
-- 
2.49.0

