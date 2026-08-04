Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D475C55172
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 09:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2716210E923;
	Tue,  4 Aug 2026 09:00:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mJYz+xNb";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013038.outbound.protection.outlook.com
 [40.93.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE47710E91C
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 09:00:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHgZgzJBonPxD5XvlHPGFY/TGJx+/mRyFZahEu6zGiF4M8a6OeNSb0lMMrb105zN8fokSs+4xd95u/udEF7SFbovdq4VPCLXviNt8da09LirIenE6DcVUlE8NXh78cmfTbrKRHTJUxmxyQuP36qvBGd90hc0JB0FTE4hmhdBvl8IDyplcT7hcjMa6Wzd3CbNlN9LvMVWmDNCQNV4Z9G4oxVRepxYj+FIbFmi9O4C0tVHLhirExBoGcpgMD7XBFpQYcBPIVqZCqL9sOHUjF4cm5+MWZmZ4Gh1c0/NHXvmGQypanNNC7tJ82jr0H8gShUn4Bb9OORZ8D6TGbH+CwRoFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03onL85SReKjUx3rUFqawwfO5xyFqFMPMRqzO71tIQA=;
 b=nx8yoBsvUuNctQAGe/SZ/Nrq0xpu55QWxV/LrqYRcAQrbiYQEifQtlLWggUVAWlHBh59BTPcWlq0QH6T452UTcMqBopkSSBV01ldWwLh+x+8v+pmA3nOMzso4w7VkIrkjZkuaPF0Wv+oe7Yt2fU9ziGQm+A8z3niF+N6pURMifrzZexql9ef8qJBHL9JdNC5NOukZ5px99BMNF/do7rfAVJLoWymtO8eFixpoHg2dD8DLOnGTGK4395P9fcz7OI1z6Uxgy+qBLWxTRLuR30iuVP5oWmT4q2Ou42oRKgBEhvyRdD/CX4Qps+dFq73RN5jOxH+IHJtZLX9TDEBsZ9ICw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03onL85SReKjUx3rUFqawwfO5xyFqFMPMRqzO71tIQA=;
 b=mJYz+xNbFUs7KlLrgEbVhNbD0nacrtzWE7w+Pspdn4gCO0Nsz9JCgTmNPKx+yX6HFR6MScMSG/YVQeNTp7ouYql9E50bGItg83pUTMy5Zz9FBjBtx0xvTaJmV3PW4PXCR7T2RvshFGYUptB16s0UN5C/UpJn4RdsbXSkgEz4Qw0=
Received: from DSSP220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:3d3::18) by
 DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.18; Tue, 4 Aug 2026 09:00:20 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:8:3d3:cafe::14) by DSSP220CA0006.outlook.office365.com
 (2603:10b6:8:3d3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 09:00:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 09:00:19 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 04:00:13 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 3/3] drm/amd/pm: Keep sub-degree precision in Q10 temperatures
Date: Tue, 4 Aug 2026 14:29:53 +0530
Message-ID: <20260804085953.2947798-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260804085953.2947798-1-lijo.lazar@amd.com>
References: <20260804085953.2947798-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: fe34309a-a548-435d-f13d-08def206cf64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: R0MwBBWMNqzsTWuuQgESIIL/0+GZkHQkUgoR3Fag2+cYekTnrXVmCPXlUnfUihdcnlLTFQvZ/fCSFf82SUU18nxWX4EBEPVNo2ufJllxRx2XTyKt3p3X0W9S/udrvEbomkg/B7EbLSt0YewzwuTt7XvrHIGT3aMyi0UIscOF/X0Ecs0o0pxZ4D6YyKTSHc+b0WkOC5XEItIkV0zGQBbDGbnu3Ex4e/GeB8c0BPr5OZh5HS/dFzgR3bMrESBSs0EqFbj9rH6Vh5pWEhqUKnEoYFSBbCMrMIXFhg2f4owdIfYmTgySom62OZKSdqfgPtTL72FmJIrdUQeJ0KZxiNKXRxgLfqXOnEZcgM7QD6D98JoAJsi+9jusBPKnXdIzBr7fWXcjoR/TTndoq8Qa4b3EGdtQCZWSblupzzpu81ws6X/+N/8Aw0oKxYCI+HDZyPPoGpSNpnb4GFPQraIa4Td+rbj/U3gOEWwRl/B8VICtuWVGnAp2k0SHQSVYUkf52olCL2h+AUjV1XPg+SNozGqQP6McKpqKxkVOym53dOlbgRnW4AOOF9aZXfWDYraW3RhndbKwLjky0maQk716uk8C0iFw5XGjMPEtLfCPCypC3keYu0fzuZkhGAfWwHmP2OocFUIcnbZ14iwhklbkuFnSjPXDqyUH2UlHprHoQQtUACxLmNsWmiFWjHWOylTPCq1+n3J7Jq/zobEY3qXuUtHKNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R7oFhe1xDuJAGf+oZS+4axww3dLwqvd/cQgifFDvrPoF6fHn82r32VaAlmptVz7vxyXseT+z0fUkr49MfRpWsZpwPQZdGXaYwSqSeJssV6lF/RjQshbxGNboPXV06DZIU0/Th6yaO/EBY4nga5O9YvOeX84DNOx4CT+oLYqwhKZ8styvayGeImv/40HxhywZc3d7BFjk9HU6g2918KfGXS9rKHId+NDXEPwy/DY7bdm2YX46GQmsUnDvXg2IHG9BHnJgaFzdU+R3KZHGkAs+ru8vfjHayeg28vVchZW3WwPeqXtU8sppzRzzxG44v14J2xJ6qqxTQvz4semH0jiPlgmZgJyWaZ5psUWRUkYYO12aH16GVDWBum2oa/1fYN9iszJL4PmA4W4O362RsltwKHvg9pZBNTV8Xh1a8OuFMsCTVaMqwj6G5QbThudoCfQV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:00:19.5781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe34309a-a548-435d-f13d-08def206cf64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702
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

The Q10 temperatures were rounded to whole degrees before being scaled
to millidegrees, losing sub-degree precision. Convert them while
preserving the fractional part.

Also, use the standard MILLIDEGREE_PER_DEGREE to represent
SMU_TEMPERATURE_UNITS_PER_CENTIGRADES.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h       |  4 ++++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c  |  9 +++------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |  9 +++------
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   | 14 ++++++++------
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 00d075cb86b8..3ec65630ab99 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -34,7 +34,7 @@
 
 #define SMU_THERMAL_MINIMUM_ALERT_TEMP		0
 #define SMU_THERMAL_MAXIMUM_ALERT_TEMP		255
-#define SMU_TEMPERATURE_UNITS_PER_CENTIGRADES	1000
+#define SMU_TEMPERATURE_UNITS_PER_CENTIGRADES	MILLIDEGREE_PER_DEGREE
 #define SMU_FW_NAME_LEN			0x24
 
 #define SMU_DPM_USER_PROFILE_RESTORE (1 << 0)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 238dcc468557..ffff02489c3e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -58,6 +58,10 @@
 /* Convert Q10 watts to milliwatts, preserving the fractional part */
 #define SMUQ10_TO_MILLIWATT(x) (SMUQ10_TO_UINT(x) * MILLIWATT_PER_WATT + \
 				((SMUQ10_FRAC(x) * MILLIWATT_PER_WATT) >> 10))
+/* Convert Q10 degrees Celsius to millidegrees, preserving the fractional part */
+#define SMUQ10_TO_MILLICELSIUS(x) \
+	(SMUQ10_TO_UINT(x) * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES + \
+	 ((SMUQ10_FRAC(x) * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES) >> 10))
 #define SMU_V13_SOFT_FREQ_ROUND(x)	((x) + 1)
 
 extern const int pmfw_decoded_link_speed[5];
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index f0f789c4ff22..0033453f27e5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -437,19 +437,16 @@ int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
 		*value = SMUQ10_TO_MILLIWATT(metrics->SocketPower);
 		break;
 	case METRICS_TEMPERATURE_HOTSPOT:
-		*value = SMUQ10_ROUND(metrics->MaxSocketTemperature) *
-			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		*value = SMUQ10_TO_MILLICELSIUS(metrics->MaxSocketTemperature);
 		break;
 	case METRICS_TEMPERATURE_MEM:
-		*value = SMUQ10_ROUND(metrics->MaxHbmTemperature) *
-			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		*value = SMUQ10_TO_MILLICELSIUS(metrics->MaxHbmTemperature);
 		break;
 	/* This is the max of all VRs and not just SOC VR.
 	 * No need to define another data type for the same.
 	 */
 	case METRICS_TEMPERATURE_VRSOC:
-		*value = SMUQ10_ROUND(metrics->MaxVrTemperature) *
-			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		*value = SMUQ10_TO_MILLICELSIUS(metrics->MaxVrTemperature);
 		break;
 	default:
 		*value = UINT_MAX;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index fe0443a07b4c..84c02e6d9673 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1306,19 +1306,16 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 		*value = SMUQ10_TO_MILLIWATT(GET_METRIC_FIELD(SocketPower, version));
 		break;
 	case METRICS_TEMPERATURE_HOTSPOT:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature, version)) *
-			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		*value = SMUQ10_TO_MILLICELSIUS(GET_METRIC_FIELD(MaxSocketTemperature, version));
 		break;
 	case METRICS_TEMPERATURE_MEM:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxHbmTemperature, version)) *
-			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		*value = SMUQ10_TO_MILLICELSIUS(GET_METRIC_FIELD(MaxHbmTemperature, version));
 		break;
 	/* This is the max of all VRs and not just SOC VR.
 	 * No need to define another data type for the same.
 	 */
 	case METRICS_TEMPERATURE_VRSOC:
-		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxVrTemperature, version)) *
-			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		*value = SMUQ10_TO_MILLICELSIUS(GET_METRIC_FIELD(MaxVrTemperature, version));
 		break;
 	default:
 		*value = UINT_MAX;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 92897843be24..fd3fca217e31 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -58,6 +58,10 @@
 /* Convert Q10 watts to milliwatts, preserving the fractional part */
 #define SMUQ10_TO_MILLIWATT(x) (SMUQ10_TO_UINT(x) * MILLIWATT_PER_WATT + \
 				((SMUQ10_FRAC(x) * MILLIWATT_PER_WATT) >> 10))
+/* Convert Q10 degrees Celsius to millidegrees, preserving the fractional part */
+#define SMUQ10_TO_MILLICELSIUS(x) \
+	(SMUQ10_TO_UINT(x) * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES + \
+	 ((SMUQ10_FRAC(x) * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES) >> 10))
 
 #define hbm_stack_mask_valid(umc_mask) \
 	(((umc_mask) & 0xF) == 0xF)
@@ -419,8 +423,7 @@ static int smu_v15_0_8_get_smu_metrics_data(struct smu_context *smu,
 		*value = SMUQ10_TO_MILLIWATT(metrics->SocketPower);
 		break;
 	case METRICS_TEMPERATURE_HOTSPOT:
-		*value = SMUQ10_ROUND(metrics->MaxSocketTemperature) *
-			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		*value = SMUQ10_TO_MILLICELSIUS(metrics->MaxSocketTemperature);
 		break;
 	case METRICS_TEMPERATURE_MEM:
 	{
@@ -438,19 +441,18 @@ static int smu_v15_0_8_get_smu_metrics_data(struct smu_context *smu,
 				if (!hbm_stack_mask_valid(mask))
 					continue;
 
-				temp = SMUQ10_ROUND(metrics->HbmTemperature[stack_idx]);
+				temp = metrics->HbmTemperature[stack_idx];
 				if (temp > max_hbm_temp)
 					max_hbm_temp = temp;
 			}
 		}
-		*value = max_hbm_temp * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		*value = SMUQ10_TO_MILLICELSIUS(max_hbm_temp);
 		break;
 	}
 	/* This is the max of all VRs and not just SOC VR.
 	 */
 	case METRICS_TEMPERATURE_VRSOC:
-		*value = SMUQ10_ROUND(metrics->MaxVrTemperature) *
-			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		*value = SMUQ10_TO_MILLICELSIUS(metrics->MaxVrTemperature);
 		break;
 	default:
 		*value = UINT_MAX;
-- 
2.49.0

