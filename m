Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7454A109E535
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 02:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05E4310E1D0;
	Thu, 26 Mar 2026 02:06:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5hoWuE1j";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D76E10E1D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 02:06:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5fKPW3Eynw0i8NXwpkWwUSLsfSSxE8xdqqN2eZBGIwu3KjEaLQexPi8AvKqVT92T1225A0mByIKEWmNU3NzBdYU1FIvBPKu8PjwKelsg3GrecwluwIn0JL0R8tDPFdLaZCQKAoUCk9icyorVXIl/iQvkhkiUp+IoJP19VGcE1goo5YhZ23AoCmDuJOz/MM1XshCMWxpjIeEZQKKMcPLISKEwD5dJQ+TEsXBDvpbbb9ld+547V7DdETHTtJx9EUZcR9kLffSCiGeeA/ycu0Txp3ZiALC5qD1Yv+mr9JY7xu7JdC1BzINiSxezWG62ONOIiStoBeFBEHkXCHhjrnuiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/K1RZvpQqL3Iv3EYM/kOlnwDKcdiZCX0Uw/AsEH6+Dk=;
 b=tpurfkyV0C7i9S8Kkg76u+aGmhmfQEKOk4i2k8t9pdKOTf6TII09OzcFoT0X4HPmY6EIgRpqW9mIK1+7lPRdyr8MbVH0bf2JmlftVWz3gT1FmEvqLkC01KHshaLj8mLvGksyobTYuRQzfmy7DeMTFHrHJLDixcCll+CwLQClYjn4mi0Iaxwk9SB0cHCrQj4Wi+vPGG5D6Xh4HNmAi1xecS/2TBXM9UvRgdmOCoL/uNC5BuePS3QK1OF+CfnYKSBlq7o46ele914Bzo/6u6w+HzSUxrmpfPaZR2QbOAHL6X1jIUWXYJJKoZ2R5rZgOLE/oK0vjs5VKnyG3lqS3vEQBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/K1RZvpQqL3Iv3EYM/kOlnwDKcdiZCX0Uw/AsEH6+Dk=;
 b=5hoWuE1jLxroslZeTuJ1ewpMPFuyWTsXhVrpAjt7hZsXt+9eKPm6kL1LhGqTxhFMKIUJsNJ9iQSBG5rhTLzeMuoI/VHTQTD4bSJtV2iv3DdBzmEgmnRbACdFmkCGVO+vHkrxwtWvwa+bq55TaP87z3l1Mv4IiIBWpbhaBVquVts=
Received: from DS7PR05CA0107.namprd05.prod.outlook.com (2603:10b6:8:56::25) by
 IA1PR12MB6385.namprd12.prod.outlook.com (2603:10b6:208:38b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.15; Thu, 26 Mar 2026 02:04:58 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:8:56:cafe::8d) by DS7PR05CA0107.outlook.office365.com
 (2603:10b6:8:56::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21 via Frontend Transport; Thu,
 26 Mar 2026 02:04:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 02:04:58 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 21:04:56 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: correct mem_busy_percent display due to
 calculation errors
Date: Wed, 25 Mar 2026 22:04:45 -0400
Message-ID: <20260326020445.1187519-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|IA1PR12MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 04426835-c2c2-47fa-1597-08de8adc14f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: gWuUkL5QuDRKNcbPtxxyGPPQRx3zBKqK956CnCyDpiAmbA6VRfm0gD5vN95oGUTo8J1ANcZlHjHGlfe1mJfS9wWbklzOiVq4cnuznmiSJ3Q2Pndw39wOGywcpiNciJzkK17vA3udYc1ZkLOZwKDht/LDJwT3YoPWrwuU49oAXhIlFFSX/S/bCdmKH1TjyabxZbDtNlqspvmZ8lbrAiAyKJ1MyBTxXpyLjXG+tyyQV3Kc8PBDbxrCV88wuMLHNnBBxwzx+vAJhBbmoVD32qc68r3BQqV5XA5L6DC7id6Ih+zEl+BrLzxJUW2gLfNTnCQmDlOl2umQ0GcZQ43lJwtY3UyfYVGyijVT9H0JQr/M6V6Cw4nCjgS9nynlXcznmLxTjw+u0lGSaKNr31C2UHwHUPbu0yWytb8XizCx81jwyu9V6Ae1KJdtz231FbI/QX/oeFmzdf1mmhC9/+k0c6+7rHh33BQPO19ygQaMCs0vCjvQmP0Edvr2U0XDd1/8tMAMa9Zg52kzy9TrYdOYQA3AQJjwcXAY8t/B2+fxM4eyIr0yC4mm7l1fgJ7r0k45Xoy1Lbl3bACcdbsPMbdk2HddWNQPNL+9P9P66sYJBDBIHLblwF09WvSA54yVgNXmG+lQ6zlLAd8dGT3eVjbAicvKHdV05eKeZUz6jgZxiiD+BixEscbeASflAFMRByxRwMy7s3bwlFzIzdanVWcpawkUuU2RWdjpjEpBYv+6ZdnQ8K0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(13003099007)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NkAyz7Qm5Z6OduRPjJESclhz3yWNWOqNjEOveGtMjErMlGHOxtQ6QNlQSBsfXl34FVfsDxVt4F69eNlehLi/1Jpl+mZ+v0iyNrYFcEogOnT6Pg53s806R2QYVBR102So0dk3EDv8STn6c7Vie7X/PgtWkPT59Pk8HGeVSFq0vqlqJeVQe6pXBqszh87irRHIhOxHbfGTbBfGDVNR81JSwzlASDi895hXGHGyNSQB9qN7WvAsG744MRtI7GhrR6vQqHR8guUv/AI5SnV8yrXBYIIPjfSxONFKPYxdf1SwaOps6IsyaewV1ecBfycpK6waX2771DmXIWVVJBovxB7DudUohUNLuiy2B7f5VvtYZ0Bdw9AGJQPo5QIF3n0dNEyyhWUTWN4hTgkMvbKDo//zsOsJO6nqmsQvec4bq0le0xyC5DZs5+1CgVB7cxrAgd0g
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 02:04:58.1713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04426835-c2c2-47fa-1597-08de8adc14f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6385
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

PMFW may return invalid values due to internal calculation errors.
so, the kmd driver must validate and sanitize the returned values to
prevent issues caused by firmware calculation errors.

For example, values 0xfffe (-2) and 0xffff (-1) are treated
as invalid and clamped to 0.

this applies to devices with CAB (Cache As Buffer) functionality.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4905

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h   | 17 +++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    | 10 +++++-----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c    | 10 +++++-----
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c    | 10 +++++-----
 4 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 609f5ab07d8a..365946c43e11 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -2164,4 +2164,21 @@ static inline void smu_feature_init(struct smu_context *smu, int feature_num)
 	smu_feature_list_clear_all(smu, SMU_FEATURE_LIST_ALLOWED);
 }
 
+/*
+ * smu_safe_u16_nn - Make u16 safe by filtering negative overflow errors
+ * @val: Input u16 value, may contain invalid negative overflows
+ *
+ * Convert u16 to non-negative value. Cast to s16 to detect negative values
+ * caused by calculation errors. Return 0 for negative errors, return
+ * original value if valid.
+ *
+ * Return: Valid u16 value or 0
+ */
+static inline u16 smu_safe_u16_nn(u16 val)
+{
+    s16 tmp = (s16)val;
+
+    return tmp < 0 ? 0 : val;
+}
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 9be7a2af560d..16f69b548ca4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -774,13 +774,13 @@ static int smu_v13_0_0_get_smu_metrics_data(struct smu_context *smu,
 			*value = metrics->AverageGfxclkFrequencyPreDs;
 		break;
 	case METRICS_AVERAGE_FCLK:
-		if (metrics->AverageUclkActivity <= SMU_13_0_0_BUSY_THRESHOLD)
+		if (smu_safe_u16_nn(metrics->AverageUclkActivity) <= SMU_13_0_0_BUSY_THRESHOLD)
 			*value = metrics->AverageFclkFrequencyPostDs;
 		else
 			*value = metrics->AverageFclkFrequencyPreDs;
 		break;
 	case METRICS_AVERAGE_UCLK:
-		if (metrics->AverageUclkActivity <= SMU_13_0_0_BUSY_THRESHOLD)
+		if (smu_safe_u16_nn(metrics->AverageUclkActivity) <= SMU_13_0_0_BUSY_THRESHOLD)
 			*value = metrics->AverageMemclkFrequencyPostDs;
 		else
 			*value = metrics->AverageMemclkFrequencyPreDs;
@@ -801,7 +801,7 @@ static int smu_v13_0_0_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->AverageGfxActivity;
 		break;
 	case METRICS_AVERAGE_MEMACTIVITY:
-		*value = metrics->AverageUclkActivity;
+		*value = smu_safe_u16_nn(metrics->AverageUclkActivity);
 		break;
 	case METRICS_AVERAGE_VCNACTIVITY:
 		*value = max(metrics->Vcn0ActivityPercentage,
@@ -2086,7 +2086,7 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct smu_context *smu,
 					     metrics->AvgTemperature[TEMP_VR_MEM1]);
 
 	gpu_metrics->average_gfx_activity = metrics->AverageGfxActivity;
-	gpu_metrics->average_umc_activity = metrics->AverageUclkActivity;
+	gpu_metrics->average_umc_activity = smu_safe_u16_nn(metrics->AverageUclkActivity);
 	gpu_metrics->average_mm_activity = max(metrics->Vcn0ActivityPercentage,
 					       metrics->Vcn1ActivityPercentage);
 
@@ -2103,7 +2103,7 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct smu_context *smu,
 	else
 		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPreDs;
 
-	if (metrics->AverageUclkActivity <= SMU_13_0_0_BUSY_THRESHOLD)
+	if (smu_safe_u16_nn(metrics->AverageUclkActivity) <= SMU_13_0_0_BUSY_THRESHOLD)
 		gpu_metrics->average_uclk_frequency = metrics->AverageMemclkFrequencyPostDs;
 	else
 		gpu_metrics->average_uclk_frequency = metrics->AverageMemclkFrequencyPreDs;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 5cc15545da6e..34a5973b9a06 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -784,13 +784,13 @@ static int smu_v13_0_7_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->AverageGfxclkFrequencyPreDs;
 		break;
 	case METRICS_AVERAGE_FCLK:
-		if (metrics->AverageUclkActivity <= SMU_13_0_7_BUSY_THRESHOLD)
+		if (smu_safe_u16_nn(metrics->AverageUclkActivity) <= SMU_13_0_7_BUSY_THRESHOLD)
 			*value = metrics->AverageFclkFrequencyPostDs;
 		else
 			*value = metrics->AverageFclkFrequencyPreDs;
 		break;
 	case METRICS_AVERAGE_UCLK:
-		if (metrics->AverageUclkActivity <= SMU_13_0_7_BUSY_THRESHOLD)
+		if (smu_safe_u16_nn(metrics->AverageUclkActivity) <= SMU_13_0_7_BUSY_THRESHOLD)
 			*value = metrics->AverageMemclkFrequencyPostDs;
 		else
 			*value = metrics->AverageMemclkFrequencyPreDs;
@@ -815,7 +815,7 @@ static int smu_v13_0_7_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->AverageGfxActivity;
 		break;
 	case METRICS_AVERAGE_MEMACTIVITY:
-		*value = metrics->AverageUclkActivity;
+		*value = smu_safe_u16_nn(metrics->AverageUclkActivity);
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
 		*value = metrics->AverageSocketPower << 8;
@@ -2092,7 +2092,7 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(struct smu_context *smu,
 					     metrics->AvgTemperature[TEMP_VR_MEM1]);
 
 	gpu_metrics->average_gfx_activity = metrics->AverageGfxActivity;
-	gpu_metrics->average_umc_activity = metrics->AverageUclkActivity;
+	gpu_metrics->average_umc_activity = smu_safe_u16_nn(metrics->AverageUclkActivity);
 	gpu_metrics->average_mm_activity = max(metrics->Vcn0ActivityPercentage,
 					       metrics->Vcn1ActivityPercentage);
 
@@ -2105,7 +2105,7 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(struct smu_context *smu,
 	else
 		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPreDs;
 
-	if (metrics->AverageUclkActivity <= SMU_13_0_7_BUSY_THRESHOLD)
+	if (smu_safe_u16_nn(metrics->AverageUclkActivity) <= SMU_13_0_7_BUSY_THRESHOLD)
 		gpu_metrics->average_uclk_frequency = metrics->AverageMemclkFrequencyPostDs;
 	else
 		gpu_metrics->average_uclk_frequency = metrics->AverageMemclkFrequencyPreDs;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 28c1b084fe62..aaec3a251e0f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -660,13 +660,13 @@ static int smu_v14_0_2_get_smu_metrics_data(struct smu_context *smu,
 			*value = metrics->AverageGfxclkFrequencyPreDs;
 		break;
 	case METRICS_AVERAGE_FCLK:
-		if (metrics->AverageUclkActivity <= SMU_14_0_2_BUSY_THRESHOLD)
+		if (smu_safe_u16_nn(metrics->AverageUclkActivity) <= SMU_14_0_2_BUSY_THRESHOLD)
 			*value = metrics->AverageFclkFrequencyPostDs;
 		else
 			*value = metrics->AverageFclkFrequencyPreDs;
 		break;
 	case METRICS_AVERAGE_UCLK:
-		if (metrics->AverageUclkActivity <= SMU_14_0_2_BUSY_THRESHOLD)
+		if (smu_safe_u16_nn(metrics->AverageUclkActivity) <= SMU_14_0_2_BUSY_THRESHOLD)
 			*value = metrics->AverageMemclkFrequencyPostDs;
 		else
 			*value = metrics->AverageMemclkFrequencyPreDs;
@@ -687,7 +687,7 @@ static int smu_v14_0_2_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->AverageGfxActivity;
 		break;
 	case METRICS_AVERAGE_MEMACTIVITY:
-		*value = metrics->AverageUclkActivity;
+		*value = smu_safe_u16_nn(metrics->AverageUclkActivity);
 		break;
 	case METRICS_AVERAGE_VCNACTIVITY:
 		*value = max(metrics->AverageVcn0ActivityPercentage,
@@ -2146,7 +2146,7 @@ static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu_context *smu,
 					     metrics->AvgTemperature[TEMP_VR_MEM1]);
 
 	gpu_metrics->average_gfx_activity = metrics->AverageGfxActivity;
-	gpu_metrics->average_umc_activity = metrics->AverageUclkActivity;
+	gpu_metrics->average_umc_activity = smu_safe_u16_nn(metrics->AverageUclkActivity);
 	gpu_metrics->average_mm_activity = max(metrics->AverageVcn0ActivityPercentage,
 					       metrics->Vcn1ActivityPercentage);
 
@@ -2158,7 +2158,7 @@ static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu_context *smu,
 	else
 		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPreDs;
 
-	if (metrics->AverageUclkActivity <= SMU_14_0_2_BUSY_THRESHOLD)
+	if (smu_safe_u16_nn(metrics->AverageUclkActivity) <= SMU_14_0_2_BUSY_THRESHOLD)
 		gpu_metrics->average_uclk_frequency = metrics->AverageMemclkFrequencyPostDs;
 	else
 		gpu_metrics->average_uclk_frequency = metrics->AverageMemclkFrequencyPreDs;
-- 
2.47.3

