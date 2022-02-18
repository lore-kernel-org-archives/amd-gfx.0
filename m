Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0198C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 12:36:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EA8D10E1C2;
	Fri, 18 Feb 2022 12:36:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFAE510E1C2
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 12:36:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MomeF5nmqKxLgKOyhz3bkHQ9aysmSh4XmzTf0H71VFSKNU/17otNW2iSMUvA62KNY15KqGEw4DCj8OFAF3HtGqO7RQ9hxrAHJLGlj66yfM4stoXLxfsf3axYFUSFDEWgeKe3xjmOfeHnqQIUrg0DjhFyh/05PUd3IH24Zn5O4qGhh1iDY1PC8POl/GwzFcW5u0Grk5E111jop1r/takWmYCuSq3aNSZf9Ahq3BNIWshV2oe7/qw+iHrX3IIGXC/sgHoC5LHciJxNIAY+4pbOpeVTNH0kU7Crov7hByDFyoEitN2NxL40dNqKwFJrgp8XV75gSljfmZ8oDQ3W6w7qlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJoR4x2/r5diNJW4YagitMx3VYe6tm6cz+lGmCf5I+4=;
 b=MhaSNEyV/yZRiADc7hHtasvBhvDATTJG3M7hqQTr6ay1T6ELZVD/qxVkJBGBQNk4jeayDh4EJMvdqs/bL2texcIwIyd/xK8LQggQlkcNHhUy3DNP8XKg6iDqqt3l8L3OGbTFQPpTimEYgiNjy7q4zkuvcquDbkZfx6pFgWiWpVly2XBGZZbP59DVxfJP1oXbBI0tKdkfUnG8zXsl2u8i1nn1o9iZQuFNHdHggeCOudS6c0LUJ9fbJKgWVQW2joQmYvcdx+GFQC2h9c3aUwdphVsXrQFlOGDGpc9hI87eKFmhH1Pgnle8+d5as+lpRPozL0BGnrYDZT58cyQpPL2fDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJoR4x2/r5diNJW4YagitMx3VYe6tm6cz+lGmCf5I+4=;
 b=bEhYyT5CyVXL0yXiTx4QPcB4NtCia8Rbe0HDOPsjs3+rSfFsOssdLFi8suCHseSCxI54nUID0d5MKK4dLA3OuxHL5GsfQyVAJiMlpMm1JKD7iMdbMfjn8KJEyh7F2Iwkor+UAHv1W+eof3KCED9xeeyLCQhk04yQoIWr84LkVOw=
Received: from DM5PR06CA0053.namprd06.prod.outlook.com (2603:10b6:3:37::15) by
 BN9PR12MB5097.namprd12.prod.outlook.com (2603:10b6:408:136::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Fri, 18 Feb
 2022 12:36:29 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:37:cafe::67) by DM5PR06CA0053.outlook.office365.com
 (2603:10b6:3:37::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Fri, 18 Feb 2022 12:36:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 12:36:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 06:36:28 -0600
Received: from master-X10DRi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 18 Feb 2022 06:36:27 -0600
From: Danijel Slivka <danijel.slivka@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: new v3 SmuMetrics data structure for Sienna
 Cichlid
Date: Fri, 18 Feb 2022 20:36:16 +0800
Message-ID: <20220218123616.10401-1-danijel.slivka@amd.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dba1d1cf-db39-496c-a6b8-08d9f2db492e
X-MS-TrafficTypeDiagnostic: BN9PR12MB5097:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5097FEFCE2431929FB29A5FF98379@BN9PR12MB5097.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tAX6V6+h5CtIk/Rmnn1dMlnxFw/tzJkuiucvb1ACmUa64Jm59jJWT3rbHAibDJDrySPrESJA3xUyN9/YUotFSYcgQK+gCsVvHVxdRl3mtcyUBQlBH9uj680+f8yXy+i7IrNj8wXc8vugsmwNa4+r00rsG48E1Iie/ACpl9yRtV+eWP2xLTGj2qSbvP9Dtgr1JRIJhzjh14pJDtuo/1kjeNPF0aCN9Jj6Gn2SEEYihhpv/b6aHa2SsmkAImgEJ2IK7RdHi5ratABPsm2nhBowMDNAZefBzQzj2gjzyX2peu/5cyYIV+s9PHv26wmAjPhksHsFvAPx1h6UKUeDEn+UvGGzXdzo3paMgxIR2m7MQe7jLbY27laJdjjXUeD8Y/0X+mRcj8OpVZo/ByJl4ukt7UnLbFYxG6cuQNglgxurhfzYkWEEf9GAALsHSFAylsmfw0UJfGbSMoFD/HOF+t7AiwSGZPt8AQzViYt0xjkKKPlMxhicguzNfXGhYvxWq3n8LH9F6NIVInNWAq/UXcr3IsEZ2yX+R6WpEuR+/F8z1HZY47b2fxwUUTW8vTrjPiY7TkPbSRnsVTegTF4nzNYPpFbjI77fQ5pvR98WD/A/6ebkHYLFCUCRRvq7eBUxvoeb7xxIDahxSCSBGI2Aq0yHzvFnPkoKSuh0hAvvlKwC2Mi5oyPRVhR/sYMTmsQ8G8RinBrtG3yRYqdr0PUfrDn7+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(82310400004)(4326008)(70586007)(8676002)(356005)(70206006)(5660300002)(81166007)(426003)(336012)(6666004)(7696005)(2906002)(2616005)(508600001)(83380400001)(86362001)(1076003)(47076005)(36860700001)(26005)(186003)(6916009)(36756003)(30864003)(40460700003)(44832011)(316002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 12:36:28.8095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dba1d1cf-db39-496c-a6b8-08d9f2db492e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5097
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
Cc: Danijel Slivka <danijel.slivka@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

structure changed in smc_fw_version >= 0x3A4900,
"uint16_t VcnActivityPercentage" replaced with
"uint16_t VcnUsagePercentage0" and "uint16_t VcnUsagePercentage1"

Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
---
 .../pmfw_if/smu11_driver_if_sienna_cichlid.h  |  58 ++++++
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 181 ++++++++++++------
 2 files changed, 178 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
index b253be602cc2..3e4a314ef925 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
@@ -1480,10 +1480,68 @@ typedef struct {
 
 } SmuMetrics_V2_t;
 
+typedef struct {
+  uint32_t CurrClock[PPCLK_COUNT];
+
+  uint16_t AverageGfxclkFrequencyPreDs;
+  uint16_t AverageGfxclkFrequencyPostDs;
+  uint16_t AverageFclkFrequencyPreDs;
+  uint16_t AverageFclkFrequencyPostDs;
+  uint16_t AverageUclkFrequencyPreDs;
+  uint16_t AverageUclkFrequencyPostDs;
+
+
+  uint16_t AverageGfxActivity;
+  uint16_t AverageUclkActivity;
+  uint8_t  CurrSocVoltageOffset;
+  uint8_t  CurrGfxVoltageOffset;
+  uint8_t  CurrMemVidOffset;
+  uint8_t  Padding8;
+  uint16_t AverageSocketPower;
+  uint16_t TemperatureEdge;
+  uint16_t TemperatureHotspot;
+  uint16_t TemperatureMem;
+  uint16_t TemperatureVrGfx;
+  uint16_t TemperatureVrMem0;
+  uint16_t TemperatureVrMem1;
+  uint16_t TemperatureVrSoc;
+  uint16_t TemperatureLiquid0;
+  uint16_t TemperatureLiquid1;
+  uint16_t TemperaturePlx;
+  uint16_t Padding16;
+  uint32_t AccCnt;
+  uint8_t  ThrottlingPercentage[THROTTLER_COUNT];
+
+
+  uint8_t  LinkDpmLevel;
+  uint8_t  CurrFanPwm;
+  uint16_t CurrFanSpeed;
+
+  //BACO metrics, PMFW-1721
+  //metrics for D3hot entry/exit and driver ARM msgs
+  uint8_t D3HotEntryCountPerMode[D3HOT_SEQUENCE_COUNT];
+  uint8_t D3HotExitCountPerMode[D3HOT_SEQUENCE_COUNT];
+  uint8_t ArmMsgReceivedCountPerMode[D3HOT_SEQUENCE_COUNT];
+
+  //PMFW-4362
+  uint32_t EnergyAccumulator;
+  uint16_t AverageVclk0Frequency;
+  uint16_t AverageDclk0Frequency;
+  uint16_t AverageVclk1Frequency;
+  uint16_t AverageDclk1Frequency;
+  uint16_t VcnUsagePercentage0;
+  uint16_t VcnUsagePercentage1;
+  uint8_t  PcieRate;
+  uint8_t  PcieWidth;
+  uint16_t AverageGfxclkFrequencyTarget;
+
+} SmuMetrics_V3_t;
+
 typedef struct {
   union {
     SmuMetrics_t SmuMetrics;
     SmuMetrics_V2_t SmuMetrics_V2;
+    SmuMetrics_V3_t SmuMetrics_V3;
   };
   uint32_t Spare[1];
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index d9d634ce9575..38f04836c82f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -554,6 +554,11 @@ static uint32_t sienna_cichlid_get_throttler_status_locked(struct smu_context *s
 	int i;
 
 	if ((smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7)) &&
+	     (smu->smc_fw_version >= 0x3A4900)) {
+		for (i = 0; i < THROTTLER_COUNT; i++)
+			throttler_status |=
+				(metrics_ext->SmuMetrics_V3.ThrottlingPercentage[i] ? 1U << i : 0);
+	} else if ((smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7)) &&
 	     (smu->smc_fw_version >= 0x3A4300)) {
 		for (i = 0; i < THROTTLER_COUNT; i++)
 			throttler_status |=
@@ -574,11 +579,20 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))->SmuMetrics);
 	SmuMetrics_V2_t *metrics_v2 =
 		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))->SmuMetrics_V2);
-	bool use_metrics_v2 = ((smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7)) &&
-		(smu->smc_fw_version >= 0x3A4300)) ? true : false;
+	SmuMetrics_V3_t *metrics_v3 =
+		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))->SmuMetrics_V3);
+	bool use_metrics_v2 = false;
+	bool use_metrics_v3 = false;
 	uint16_t average_gfx_activity;
 	int ret = 0;
 
+	if ((smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7)) &&
+		(smu->smc_fw_version >= 0x3A4900))
+		use_metrics_v3 = true;
+	else if ((smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7)) &&
+		(smu->smc_fw_version >= 0x3A4300))
+		use_metrics_v2 =  true;
+
 	ret = smu_cmn_get_metrics_table(smu,
 					NULL,
 					false);
@@ -587,96 +601,119 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 
 	switch (member) {
 	case METRICS_CURR_GFXCLK:
-		*value = use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_GFXCLK] :
+		*value = use_metrics_v3 ? metrics_v3->CurrClock[PPCLK_GFXCLK] :
+			use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_GFXCLK] :
 			metrics->CurrClock[PPCLK_GFXCLK];
 		break;
 	case METRICS_CURR_SOCCLK:
-		*value = use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_SOCCLK] :
+		*value = use_metrics_v3 ? metrics_v3->CurrClock[PPCLK_SOCCLK] :
+			use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_SOCCLK] :
 			metrics->CurrClock[PPCLK_SOCCLK];
 		break;
 	case METRICS_CURR_UCLK:
-		*value = use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_UCLK] :
+		*value = use_metrics_v3 ? metrics_v3->CurrClock[PPCLK_UCLK] :
+			use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_UCLK] :
 			metrics->CurrClock[PPCLK_UCLK];
 		break;
 	case METRICS_CURR_VCLK:
-		*value = use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_VCLK_0] :
+		*value = use_metrics_v3 ? metrics_v3->CurrClock[PPCLK_VCLK_0] :
+			use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_VCLK_0] :
 			metrics->CurrClock[PPCLK_VCLK_0];
 		break;
 	case METRICS_CURR_VCLK1:
-		*value = use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_VCLK_1] :
+		*value = use_metrics_v3 ? metrics_v3->CurrClock[PPCLK_VCLK_1] :
+			use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_VCLK_1] :
 			metrics->CurrClock[PPCLK_VCLK_1];
 		break;
 	case METRICS_CURR_DCLK:
-		*value = use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_DCLK_0] :
+		*value = use_metrics_v3 ? metrics_v3->CurrClock[PPCLK_DCLK_0] :
+			use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_DCLK_0] :
 			metrics->CurrClock[PPCLK_DCLK_0];
 		break;
 	case METRICS_CURR_DCLK1:
-		*value = use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_DCLK_1] :
+		*value = use_metrics_v3 ? metrics_v3->CurrClock[PPCLK_DCLK_1] :
+			use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_DCLK_1] :
 			metrics->CurrClock[PPCLK_DCLK_1];
 		break;
 	case METRICS_CURR_DCEFCLK:
-		*value = use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_DCEFCLK] :
+		*value = use_metrics_v3 ? metrics_v3->CurrClock[PPCLK_DCEFCLK] :
+			use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_DCEFCLK] :
 			metrics->CurrClock[PPCLK_DCEFCLK];
 		break;
 	case METRICS_CURR_FCLK:
-		*value = use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_FCLK] :
+		*value = use_metrics_v3 ? metrics_v3->CurrClock[PPCLK_FCLK] :
+			use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_FCLK] :
 			metrics->CurrClock[PPCLK_FCLK];
 		break;
 	case METRICS_AVERAGE_GFXCLK:
-		average_gfx_activity = use_metrics_v2 ? metrics_v2->AverageGfxActivity :
+		average_gfx_activity = use_metrics_v3 ? metrics_v3->AverageGfxActivity :
+			use_metrics_v2 ? metrics_v2->AverageGfxActivity :
 			metrics->AverageGfxActivity;
 		if (average_gfx_activity <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
-			*value = use_metrics_v2 ? metrics_v2->AverageGfxclkFrequencyPostDs :
+			*value = use_metrics_v3 ? metrics_v3->AverageGfxclkFrequencyPostDs :
+				use_metrics_v2 ? metrics_v2->AverageGfxclkFrequencyPostDs :
 				metrics->AverageGfxclkFrequencyPostDs;
 		else
-			*value = use_metrics_v2 ? metrics_v2->AverageGfxclkFrequencyPreDs :
+			*value = use_metrics_v3 ? metrics_v3->AverageGfxclkFrequencyPreDs :
+				use_metrics_v2 ? metrics_v2->AverageGfxclkFrequencyPreDs :
 				metrics->AverageGfxclkFrequencyPreDs;
 		break;
 	case METRICS_AVERAGE_FCLK:
-		*value = use_metrics_v2 ? metrics_v2->AverageFclkFrequencyPostDs :
+		*value = use_metrics_v3 ? metrics_v3->AverageFclkFrequencyPostDs :
+			use_metrics_v2 ? metrics_v2->AverageFclkFrequencyPostDs :
 			metrics->AverageFclkFrequencyPostDs;
 		break;
 	case METRICS_AVERAGE_UCLK:
-		*value = use_metrics_v2 ? metrics_v2->AverageUclkFrequencyPostDs :
+		*value = use_metrics_v3 ? metrics_v3->AverageUclkFrequencyPostDs :
+			use_metrics_v2 ? metrics_v2->AverageUclkFrequencyPostDs :
 			metrics->AverageUclkFrequencyPostDs;
 		break;
 	case METRICS_AVERAGE_GFXACTIVITY:
-		*value = use_metrics_v2 ? metrics_v2->AverageGfxActivity :
+		*value = use_metrics_v3 ? metrics_v3->AverageGfxActivity :
+			use_metrics_v2 ? metrics_v2->AverageGfxActivity :
 			metrics->AverageGfxActivity;
 		break;
 	case METRICS_AVERAGE_MEMACTIVITY:
-		*value = use_metrics_v2 ? metrics_v2->AverageUclkActivity :
+		*value = use_metrics_v3 ? metrics_v3->AverageUclkActivity :
+			use_metrics_v2 ? metrics_v2->AverageUclkActivity :
 			metrics->AverageUclkActivity;
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
-		*value = use_metrics_v2 ? metrics_v2->AverageSocketPower << 8 :
+		*value = use_metrics_v3 ? metrics_v3->AverageSocketPower << 8 :
+			use_metrics_v2 ? metrics_v2->AverageSocketPower << 8 :
 			metrics->AverageSocketPower << 8;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
-		*value = (use_metrics_v2 ? metrics_v2->TemperatureEdge : metrics->TemperatureEdge) *
-			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		*value = (use_metrics_v3 ? metrics_v3->TemperatureEdge :
+			use_metrics_v2 ? metrics_v2->TemperatureEdge :
+			metrics->TemperatureEdge) * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_TEMPERATURE_HOTSPOT:
-		*value = (use_metrics_v2 ? metrics_v2->TemperatureHotspot : metrics->TemperatureHotspot) *
-			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		*value = (use_metrics_v3 ? metrics_v3->TemperatureHotspot :
+			use_metrics_v2 ? metrics_v2->TemperatureHotspot :
+			metrics->TemperatureHotspot) * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_TEMPERATURE_MEM:
-		*value = (use_metrics_v2 ? metrics_v2->TemperatureMem : metrics->TemperatureMem) *
-			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		*value = (use_metrics_v3 ? metrics_v3->TemperatureMem :
+			use_metrics_v2 ? metrics_v2->TemperatureMem :
+			metrics->TemperatureMem) * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_TEMPERATURE_VRGFX:
-		*value = (use_metrics_v2 ? metrics_v2->TemperatureVrGfx : metrics->TemperatureVrGfx) *
-			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		*value = (use_metrics_v3 ? metrics_v3->TemperatureVrGfx :
+			use_metrics_v2 ? metrics_v2->TemperatureVrGfx :
+			metrics->TemperatureVrGfx) * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_TEMPERATURE_VRSOC:
-		*value = (use_metrics_v2 ? metrics_v2->TemperatureVrSoc : metrics->TemperatureVrSoc) *
-			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		*value = (use_metrics_v3 ? metrics_v3->TemperatureVrSoc :
+			use_metrics_v2 ? metrics_v2->TemperatureVrSoc :
+			metrics->TemperatureVrSoc) * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_THROTTLER_STATUS:
 		*value = sienna_cichlid_get_throttler_status_locked(smu);
 		break;
 	case METRICS_CURR_FANSPEED:
-		*value = use_metrics_v2 ? metrics_v2->CurrFanSpeed : metrics->CurrFanSpeed;
+		*value = use_metrics_v3 ? metrics_v3->CurrFanSpeed :
+			use_metrics_v2 ? metrics_v2->CurrFanSpeed : metrics->CurrFanSpeed;
 		break;
 	default:
 		*value = UINT_MAX;
@@ -3656,12 +3693,22 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 		&(metrics_external.SmuMetrics);
 	SmuMetrics_V2_t *metrics_v2 =
 		&(metrics_external.SmuMetrics_V2);
+	SmuMetrics_V3_t *metrics_v3 =
+		&(metrics_external.SmuMetrics_V3);
 	struct amdgpu_device *adev = smu->adev;
-	bool use_metrics_v2 = ((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7)) &&
-		(smu->smc_fw_version >= 0x3A4300)) ? true : false;
+	bool use_metrics_v2 = false;
+	bool use_metrics_v3 = false;
 	uint16_t average_gfx_activity;
 	int ret = 0;
 
+	if ((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7)) &&
+		(smu->smc_fw_version >= 0x3A4900))
+		use_metrics_v3 = true;
+	else if ((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7)) &&
+		(smu->smc_fw_version >= 0x3A4300))
+		use_metrics_v2 = true;
+
+
 	ret = smu_cmn_get_metrics_table(smu,
 					&metrics_external,
 					true);
@@ -3670,29 +3717,30 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 
 	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
-	gpu_metrics->temperature_edge =
+	gpu_metrics->temperature_edge = use_metrics_v3 ? metrics_v3->TemperatureEdge :
 		use_metrics_v2 ? metrics_v2->TemperatureEdge : metrics->TemperatureEdge;
-	gpu_metrics->temperature_hotspot =
+	gpu_metrics->temperature_hotspot = use_metrics_v3 ? metrics_v3->TemperatureHotspot :
 		use_metrics_v2 ? metrics_v2->TemperatureHotspot : metrics->TemperatureHotspot;
-	gpu_metrics->temperature_mem =
+	gpu_metrics->temperature_mem = use_metrics_v3 ? metrics_v3->TemperatureMem :
 		use_metrics_v2 ? metrics_v2->TemperatureMem : metrics->TemperatureMem;
-	gpu_metrics->temperature_vrgfx =
+	gpu_metrics->temperature_vrgfx = use_metrics_v3 ? metrics_v3->TemperatureVrGfx :
 		use_metrics_v2 ? metrics_v2->TemperatureVrGfx : metrics->TemperatureVrGfx;
-	gpu_metrics->temperature_vrsoc =
+	gpu_metrics->temperature_vrsoc = use_metrics_v3 ? metrics_v3->TemperatureVrSoc :
 		use_metrics_v2 ? metrics_v2->TemperatureVrSoc : metrics->TemperatureVrSoc;
-	gpu_metrics->temperature_vrmem =
+	gpu_metrics->temperature_vrmem = use_metrics_v3 ? metrics_v3->TemperatureVrMem0 :
 		use_metrics_v2 ? metrics_v2->TemperatureVrMem0 : metrics->TemperatureVrMem0;
 
-	gpu_metrics->average_gfx_activity =
+	gpu_metrics->average_gfx_activity = use_metrics_v3 ? metrics_v3->AverageGfxActivity :
 		use_metrics_v2 ? metrics_v2->AverageGfxActivity : metrics->AverageGfxActivity;
-	gpu_metrics->average_umc_activity =
+	gpu_metrics->average_umc_activity = use_metrics_v3 ? metrics_v3->AverageUclkActivity :
 		use_metrics_v2 ? metrics_v2->AverageUclkActivity : metrics->AverageUclkActivity;
-	gpu_metrics->average_mm_activity =
+	gpu_metrics->average_mm_activity = use_metrics_v3 ?
+		(metrics_v3->VcnUsagePercentage0 + metrics_v3->VcnUsagePercentage1) / 2 :
 		use_metrics_v2 ? metrics_v2->VcnActivityPercentage : metrics->VcnActivityPercentage;
 
-	gpu_metrics->average_socket_power =
+	gpu_metrics->average_socket_power = use_metrics_v3 ? metrics_v3->AverageSocketPower :
 		use_metrics_v2 ? metrics_v2->AverageSocketPower : metrics->AverageSocketPower;
-	gpu_metrics->energy_accumulator =
+	gpu_metrics->energy_accumulator = use_metrics_v3 ? metrics_v3->EnergyAccumulator :
 		use_metrics_v2 ? metrics_v2->EnergyAccumulator : metrics->EnergyAccumulator;
 
 	if (metrics->CurrGfxVoltageOffset)
@@ -3705,37 +3753,45 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 		gpu_metrics->voltage_soc =
 			(155000 - 625 * metrics->CurrSocVoltageOffset) / 100;
 
-	average_gfx_activity = use_metrics_v2 ? metrics_v2->AverageGfxActivity : metrics->AverageGfxActivity;
+	average_gfx_activity = use_metrics_v3 ? metrics_v3->AverageGfxActivity :
+		use_metrics_v2 ? metrics_v2->AverageGfxActivity : metrics->AverageGfxActivity;
 	if (average_gfx_activity <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
 		gpu_metrics->average_gfxclk_frequency =
-			use_metrics_v2 ? metrics_v2->AverageGfxclkFrequencyPostDs : metrics->AverageGfxclkFrequencyPostDs;
+			use_metrics_v3 ? metrics_v3->AverageGfxclkFrequencyPostDs :
+			use_metrics_v2 ? metrics_v2->AverageGfxclkFrequencyPostDs :
+			metrics->AverageGfxclkFrequencyPostDs;
 	else
 		gpu_metrics->average_gfxclk_frequency =
-			use_metrics_v2 ? metrics_v2->AverageGfxclkFrequencyPreDs : metrics->AverageGfxclkFrequencyPreDs;
+			use_metrics_v3 ? metrics_v3->AverageGfxclkFrequencyPreDs :
+			use_metrics_v2 ? metrics_v2->AverageGfxclkFrequencyPreDs :
+			metrics->AverageGfxclkFrequencyPreDs;
+
 	gpu_metrics->average_uclk_frequency =
-		use_metrics_v2 ? metrics_v2->AverageUclkFrequencyPostDs : metrics->AverageUclkFrequencyPostDs;
-	gpu_metrics->average_vclk0_frequency =
+		use_metrics_v3 ? metrics_v3->AverageUclkFrequencyPostDs :
+		use_metrics_v2 ? metrics_v2->AverageUclkFrequencyPostDs :
+		metrics->AverageUclkFrequencyPostDs;
+	gpu_metrics->average_vclk0_frequency = use_metrics_v3 ? metrics_v3->AverageVclk0Frequency :
 		use_metrics_v2 ? metrics_v2->AverageVclk0Frequency : metrics->AverageVclk0Frequency;
-	gpu_metrics->average_dclk0_frequency =
+	gpu_metrics->average_dclk0_frequency = use_metrics_v3 ? metrics_v3->AverageDclk0Frequency :
 		use_metrics_v2 ? metrics_v2->AverageDclk0Frequency : metrics->AverageDclk0Frequency;
-	gpu_metrics->average_vclk1_frequency =
+	gpu_metrics->average_vclk1_frequency = use_metrics_v3 ? metrics_v3->AverageVclk1Frequency :
 		use_metrics_v2 ? metrics_v2->AverageVclk1Frequency : metrics->AverageVclk1Frequency;
-	gpu_metrics->average_dclk1_frequency =
+	gpu_metrics->average_dclk1_frequency = use_metrics_v3 ? metrics_v3->AverageDclk1Frequency :
 		use_metrics_v2 ? metrics_v2->AverageDclk1Frequency : metrics->AverageDclk1Frequency;
 
-	gpu_metrics->current_gfxclk =
+	gpu_metrics->current_gfxclk = use_metrics_v3 ? metrics_v3->CurrClock[PPCLK_GFXCLK] :
 		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_GFXCLK] : metrics->CurrClock[PPCLK_GFXCLK];
-	gpu_metrics->current_socclk =
+	gpu_metrics->current_socclk = use_metrics_v3 ? metrics_v3->CurrClock[PPCLK_SOCCLK] :
 		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_SOCCLK] : metrics->CurrClock[PPCLK_SOCCLK];
-	gpu_metrics->current_uclk =
+	gpu_metrics->current_uclk = use_metrics_v3 ? metrics_v3->CurrClock[PPCLK_UCLK] :
 		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_UCLK] : metrics->CurrClock[PPCLK_UCLK];
-	gpu_metrics->current_vclk0 =
+	gpu_metrics->current_vclk0 = use_metrics_v3 ? metrics_v3->CurrClock[PPCLK_VCLK_0] :
 		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_VCLK_0] : metrics->CurrClock[PPCLK_VCLK_0];
-	gpu_metrics->current_dclk0 =
+	gpu_metrics->current_dclk0 = use_metrics_v3 ? metrics_v3->CurrClock[PPCLK_DCLK_0] :
 		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_DCLK_0] : metrics->CurrClock[PPCLK_DCLK_0];
-	gpu_metrics->current_vclk1 =
+	gpu_metrics->current_vclk1 = use_metrics_v3 ? metrics_v3->CurrClock[PPCLK_VCLK_1] :
 		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_VCLK_1] : metrics->CurrClock[PPCLK_VCLK_1];
-	gpu_metrics->current_dclk1 =
+	gpu_metrics->current_dclk1 = use_metrics_v3 ? metrics_v3->CurrClock[PPCLK_DCLK_1] :
 		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_DCLK_1] : metrics->CurrClock[PPCLK_DCLK_1];
 
 	gpu_metrics->throttle_status = sienna_cichlid_get_throttler_status_locked(smu);
@@ -3743,12 +3799,15 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 			smu_cmn_get_indep_throttler_status(gpu_metrics->throttle_status,
 							   sienna_cichlid_throttler_map);
 
-	gpu_metrics->current_fan_speed = use_metrics_v2 ? metrics_v2->CurrFanSpeed : metrics->CurrFanSpeed;
+	gpu_metrics->current_fan_speed = use_metrics_v3 ? metrics_v3->CurrFanSpeed :
+		use_metrics_v2 ? metrics_v2->CurrFanSpeed : metrics->CurrFanSpeed;
 
 	if (((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7)) && smu->smc_fw_version > 0x003A1E00) ||
 	      ((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 11)) && smu->smc_fw_version > 0x00410400)) {
-		gpu_metrics->pcie_link_width = use_metrics_v2 ? metrics_v2->PcieWidth : metrics->PcieWidth;
-		gpu_metrics->pcie_link_speed = link_speed[use_metrics_v2 ? metrics_v2->PcieRate : metrics->PcieRate];
+		gpu_metrics->pcie_link_width = use_metrics_v3 ? metrics_v3->PcieWidth :
+			use_metrics_v2 ? metrics_v2->PcieWidth : metrics->PcieWidth;
+		gpu_metrics->pcie_link_speed = link_speed[use_metrics_v3 ? metrics_v3->PcieRate :
+			use_metrics_v2 ? metrics_v2->PcieRate : metrics->PcieRate];
 	} else {
 		gpu_metrics->pcie_link_width =
 				smu_v11_0_get_current_pcie_link_width(smu);
-- 
2.20.1

