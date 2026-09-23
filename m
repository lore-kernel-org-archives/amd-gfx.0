Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAEAC982EA
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 08:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96ACB10E857;
	Wed, 23 Sep 2026 08:44:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SLMHkdJn";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013044.outbound.protection.outlook.com
 [40.107.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B4C610E857
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 08:44:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSa4RB8er6VRtUcXRZhb9DE5nHsU1cqNfieD7WR9+rsmxAg1xyuiflSh6J1Ho2Uc8umV1ehG1py+daIWURSd5UXpXcZnaOauxReqRwC7hylv9RfZip9EudIVCv7W6j0883UKfmnqIBbTsqDy+m7szxtejV8X0AH4genlLnnmcuXU8QsOYySW3dFS9833AfIqdxzyOANcMcNI0qeFs7v7Y1S+6m6cEU+t2aAs9NuUeAbEIV8UQBUclIs9kehKRvErDrTvpBchKOWaAjHjKc2NT4+T8DDXCBb74LfBt2v6H/yiRESHPM/eZf6G4TbkUqpxkCL83UqcAr4kY9N+nE+mDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGJBjFagrACv0eOT3UgVsXhakRLeLM977+uuoDmVSPo=;
 b=ADs1Wkl8dESKaFVKt54qNrsXwDZka9yY+WwXWvOSOJ9hNzMwkPFIxUi4VNpDckHkRaXGZgiTDQQYJVh+M0TkrtO2er7GL1XGxeqWtJS3iAUxKBMzYJ/tzPL3XmcbVh7Ifdfhg8mWc1uuubmO4kQCPIOlNA0JnXSCv5a6YCqU1237vJVdzn90RQULUIio+jmo9mp6GFCHI3XYfYLBadMPQrveJz8ZzLCHsqeOzwbVy0BZbzVyh0IIB4YR3L7ps3Z+GMoQqL4FbvbX24ysAU2KgRHTnSg2By1Hq9r87j+AxpjC0tuqZkzGO/q0E5DBYevYxfGJvkej5308L+UWtF9E+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGJBjFagrACv0eOT3UgVsXhakRLeLM977+uuoDmVSPo=;
 b=SLMHkdJnCGh2PfV1yq2FBWLWkLYk1yrTbYnxfyqPAEyGE7IPBPMOlA2VgI11dBnVPyH6oLvA2+9ymFnM7Sn9VFM2c8yG1xljXu+u+6JUevbtPdgpZu8MMCgN55c6IQbv+7vabQ3edq8xt8jGy7x+86wGvvU79ZIJCLC35Tfjbbs=
Received: from SJ0PR03CA0237.namprd03.prod.outlook.com (2603:10b6:a03:39f::32)
 by IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 08:44:18 +0000
Received: from SJ1PEPF000037A5.namprd04.prod.outlook.com
 (2603:10b6:a03:39f:cafe::6a) by SJ0PR03CA0237.outlook.office365.com
 (2603:10b6:a03:39f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 08:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A5.mail.protection.outlook.com (10.167.244.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 08:44:18 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 03:44:16 -0500
From: Kevin Wang <kevin.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: align smu 13.0.7 activity-monitor power profile
 output
Date: Wed, 23 Sep 2026 16:44:04 +0800
Message-ID: <20260923084404.538353-1-kevin.wang@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A5:EE_|IA0PR12MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7b4128-8a93-4ef3-a127-08df194edb49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|11063799006|10067099003|56012099006|6133799003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: Y++2nsHvZQFsFuJvASQ8Q3rGj5I9veI/E4hE4zOEecVpFGzxXhk/CURbmumm2FO3w99zFsgB+eAnJj0iagEU42tUwx5moWgXpRaTIJH1pAPRFtEXWe5tLvmx74d9f2fWc0epZTbKFMg0pco7W319xeMCLaMTtYTo6UMNsOF6gjsxne3Yp5OdzH34WgRy1pDmqPS5fAlfP0fwimv/pqQ6xoqnfUtOijDPENUfHxVGB+eldayfEFwln5A5AyQIzMlB3GPcgjwOjrNmULtVZz7qmH8av5jaQTju2yJNxt+53W4HN3PSVJ/oGINwPuXSPrVgFcJzFQSqZ+2dPvzJB7QXfweMsRYLhPGpQFM3TzAGfLs64Zvz89Hs8dt5ASLd4Rpzib38fiUi1ve6vNp3uC+Oc3fJgg1M8dJ70APDptRrH3HIzyA5pweNXtv+mBq9ssXN+m9OYa7XpCzmDNpsstLLg9/Fe6XsV8jccxt3n1DhL5QF3ECuISc5UKs1+UnRPjT/0Q+u7yECKiZ4GpK6oPRfGpfeBsM7N7CXskwEkVqSX9N/9XNQtjaVo8bC2YJIPCMNzj62jx11s7ajn9aZG2G4WmJyIiLapqAyevknvGcYuZTIr8jwHu4YhQJ8lYVhXHYJE4QNUGtiw3KQ5EYP0Litd+jA8KJce7oiACCGEUlZXx6vlVZktVeFaKFTPAy5VolXu4cKREcLnxU4fHoWG1emvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(11063799006)(10067099003)(56012099006)(6133799003)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gtTyp/BD4ITrX/kAaNs9/1cixmf5eiHpygJhPkyReFCu2h/XTrYiMDJ1jnpBp+rko7MS81ypvf8BeB4ViSpSieIJmbcB+MxmTMRzQQROPfvja4RUcycKS7loKeU1ZYTG/+wSMBjmlFR0rIs2r3k35HpVGO4YaOTubH/oRNAzacl7pKEqzwzS+rJhkYiKYk3kuZKnRlPicIUaneT+aI7DrAlqxErCBXkJy8X7VNEh+v4t2jXKnfFTkHcJIrlPqWUh2bG0JpXkCasxDkNzOf0cnZ1ey6Xwohlagcsxpey7Rc6n5G1EyvU4yAWQBQCaSMAxfwV5boK2s0tqk0yjWmvsWucIjIiH0frZo4e8tUsF3LpthEORzdhC4JS4PE1GZulLkUNBcIrlpw5uxQxZV2dhx72UdtlaWdQ2UgRQ1txqRzjnONgVKejwalL6EAV6POCt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 08:44:18.6427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7b4128-8a93-4ef3-a127-08df194edb49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862
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

smu 13.0.7 uses a transposed table layout for activity-monitor coefficients,
unlike smu 13.0.0 / 13.0.10 which list per-profile gfxclk/fclk entries.
this mismatch forces userspace to implement special case handling for smu 13.0.7.

adjust output formatting to align with other smu13 variants.

Format change:

Before:
  <profile 0>  <profile 1>  ... <profile 7>
  Gfx_FPS      value        ... value
  Fclk_FPS     value        ... value

After:
  PROFILE_INDEX(NAME) CLOCK_TYPE(NAME) ...
  0 BOOTUP_DEFAULT*:
                       0(GFXCLK) ...
                       1(FCLK)   ...

Signed-off-by: Kevin Wang <kevin.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 92 ++++++++++++-------
 1 file changed, 61 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 64590965fe56..5e445ce857b1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2445,7 +2445,21 @@ static int smu_v13_0_7_init_ppt_limits(struct smu_context *smu)
 static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf)
 {
 	DpmActivityMonitorCoeffIntExternal_t *activity_monitor_external;
-	uint32_t i, j, size = 0;
+	DpmActivityMonitorCoeffInt_t *activity_monitor;
+	static const char * const title[] = {
+		"PROFILE_INDEX(NAME)",
+		"CLOCK_TYPE(NAME)",
+		"ActiveHystLimit",
+		"IdleHystLimit",
+		"FPS",
+		"MinActiveFreqType",
+		"MinActiveFreq",
+		"BoosterFreqType",
+		"BoosterFreq",
+		"PD_Data_limit_c",
+		"PD_Data_error_coeff",
+		"PD_Data_error_rate_coeff"};
+	u32 i, size = 0;
 	int16_t workload_type = 0;
 	int result = 0;
 
@@ -2457,12 +2471,9 @@ static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf
 	if (!activity_monitor_external)
 		return -ENOMEM;
 
-	size += sysfs_emit_at(buf, size, "                              ");
-	for (i = 0; i <= PP_SMC_POWER_PROFILE_WINDOW3D; i++)
-		size += sysfs_emit_at(buf, size, "%d %-14s%s", i, amdgpu_pp_profile_name[i],
-			(i == smu->power_profile_mode) ? "* " : "  ");
-
-	size += sysfs_emit_at(buf, size, "\n");
+	size += sysfs_emit_at(buf, size, "%16s %s %s %s %s %s %s %s %s %s %s %s\n",
+		title[0], title[1], title[2], title[3], title[4], title[5],
+		title[6], title[7], title[8], title[9], title[10], title[11]);
 
 	for (i = 0; i <= PP_SMC_POWER_PROFILE_WINDOW3D; i++) {
 		/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
@@ -2483,32 +2494,51 @@ static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf
 			dev_err(smu->adev->dev, "[%s] Failed to get activity monitor!", __func__);
 			goto out;
 		}
+
+		activity_monitor =
+			&activity_monitor_external[i].DpmActivityMonitorCoeffInt;
+
+		size += sysfs_emit_at(buf, size, "%2d %14s%s:\n",
+			i, amdgpu_pp_profile_name[i],
+			(i == smu->power_profile_mode) ? "*" : " ");
+
+		size += sysfs_emit_at(buf, size,
+			"%19s %d(%13s) %7d %7d %7d %7d %7d",
+			" ",
+			0,
+			"GFXCLK",
+			activity_monitor->Gfx_ActiveHystLimit,
+			activity_monitor->Gfx_IdleHystLimit,
+			activity_monitor->Gfx_FPS,
+			activity_monitor->Gfx_MinActiveFreqType,
+			activity_monitor->Gfx_MinActiveFreq);
+
+		size += sysfs_emit_at(buf, size, "%7d %7d %7d %7d %7d\n",
+			activity_monitor->Gfx_BoosterFreqType,
+			activity_monitor->Gfx_BoosterFreq,
+			activity_monitor->Gfx_PD_Data_limit_c,
+			activity_monitor->Gfx_PD_Data_error_coeff,
+			activity_monitor->Gfx_PD_Data_error_rate_coeff);
+
+		size += sysfs_emit_at(buf, size,
+			"%19s %d(%13s) %7d %7d %7d %7d %7d",
+			" ",
+			1,
+			"FCLK",
+			activity_monitor->Fclk_ActiveHystLimit,
+			activity_monitor->Fclk_IdleHystLimit,
+			activity_monitor->Fclk_FPS,
+			activity_monitor->Fclk_MinActiveFreqType,
+			activity_monitor->Fclk_MinActiveFreq);
+
+		size += sysfs_emit_at(buf, size, "%7d %7d %7d %7d %7d\n",
+			activity_monitor->Fclk_BoosterFreqType,
+			activity_monitor->Fclk_BoosterFreq,
+			activity_monitor->Fclk_PD_Data_limit_c,
+			activity_monitor->Fclk_PD_Data_error_coeff,
+			activity_monitor->Fclk_PD_Data_error_rate_coeff);
 	}
 
-#define PRINT_DPM_MONITOR(field)									\
-do {													\
-	size += sysfs_emit_at(buf, size, "%-30s", #field);						\
-	for (j = 0; j <= PP_SMC_POWER_PROFILE_WINDOW3D; j++)						\
-		size += sysfs_emit_at(buf, size, "%-18d", activity_monitor_external[j].DpmActivityMonitorCoeffInt.field);		\
-	size += sysfs_emit_at(buf, size, "\n");								\
-} while (0)
-
-	PRINT_DPM_MONITOR(Gfx_ActiveHystLimit);
-	PRINT_DPM_MONITOR(Gfx_IdleHystLimit);
-	PRINT_DPM_MONITOR(Gfx_FPS);
-	PRINT_DPM_MONITOR(Gfx_MinActiveFreqType);
-	PRINT_DPM_MONITOR(Gfx_BoosterFreqType);
-	PRINT_DPM_MONITOR(Gfx_MinActiveFreq);
-	PRINT_DPM_MONITOR(Gfx_BoosterFreq);
-	PRINT_DPM_MONITOR(Fclk_ActiveHystLimit);
-	PRINT_DPM_MONITOR(Fclk_IdleHystLimit);
-	PRINT_DPM_MONITOR(Fclk_FPS);
-	PRINT_DPM_MONITOR(Fclk_MinActiveFreqType);
-	PRINT_DPM_MONITOR(Fclk_BoosterFreqType);
-	PRINT_DPM_MONITOR(Fclk_MinActiveFreq);
-	PRINT_DPM_MONITOR(Fclk_BoosterFreq);
-#undef PRINT_DPM_MONITOR
-
 	result = size;
 out:
 	kfree(activity_monitor_external);
-- 
2.55.0

