Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505B9C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 08:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D781C10F044;
	Wed, 11 May 2022 08:44:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 546DC10F897
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 08:44:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnFk7WHL1dfLOG46Jv+xek6RGAjOk4PTlW5RATb3u1EV4OrnF4vuce2Ax7ZJOlxWdlc54STrfEM9Ur2145WpyGJw4HhJMt8Rf9m3wxfVDOm0IA842WqRFj21C9nqnTESrc6UPZCxYu7Dc9P6cyZ1pw6neeE9QCLUEFBCF4B2vEV3L4s2WZT9MEOfmVYaxj7qfEVBtSGlCIc+QtuuXQfG9J0Xg0hiL5jEqdZ6ExNk5w1UhN7rpIXMNpjUq7STxlJ4qtY3BYNMiUhp4mNeQnQTwTkhXK4FdSCYoWRYny6CctY/98vS3Rwm6ZdvBVFQT9xrRouldr+n8PPCxDFM6X/f3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWOUYGL+gbafNpcXBqTSXQPe6PriPTPDpA/szSdxD8Q=;
 b=RcvZzLbGv1LjX3wZgmKmdbCsBjCAn563FHj0uftZ5BSQQsokL8WWVupIKkr2OsqJO5C/TR9/x6g7HJtjlK8MJFhbJQQJKgzSB4SAKWpdF3mB3IcS1sGioJnuM1YnTd59hZyEOr3lt0/CAgF8ebd3ZBIsnDGAddM3K9sma8qIV8RHvVc5FeBBk9lDV55wdMYNZ+KSiP5tOMmY5M3vTn0p0Onx4oP1DdbRU1/EAQRJ2InfYXteVrYjqV5CLZbGLwQgG6WlAQzuDb2oD1zZ0lKuSKplE5zjjoxlIJVHtWkmamI07WgCwgnvkmKLR4d2f3a4LwjjJE4JnN6TjsV5bKGOLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWOUYGL+gbafNpcXBqTSXQPe6PriPTPDpA/szSdxD8Q=;
 b=3PbAJos/bd/51NNfWX+XTn+ow3D8Rc/jmun1LINHVmgaUDAl9FtfUjiHBwNCwbdznGDYt9OowvNdu0JMdATZkCh59ygMlS0NI2T2Wvi3veXr3UOUnrHfml9St5Frjkg07QsDWZmFyxO3ccZDrpuE8lBBjq3/DYdTu10rKVJ+rfo=
Received: from MW4PR03CA0149.namprd03.prod.outlook.com (2603:10b6:303:8c::34)
 by DM6PR12MB3980.namprd12.prod.outlook.com (2603:10b6:5:1cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 08:44:32 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::db) by MW4PR03CA0149.outlook.office365.com
 (2603:10b6:303:8c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Wed, 11 May 2022 08:44:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 08:44:31 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 03:44:29 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5] drm/amd/pm: support ss metrics read for smu11
Date: Wed, 11 May 2022 14:14:16 +0530
Message-ID: <20220511084416.2068863-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4556de8-b199-4a5b-fe0a-08da332a77de
X-MS-TrafficTypeDiagnostic: DM6PR12MB3980:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB398044D25642F006167240EB9DC89@DM6PR12MB3980.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HmuT3+CPIhVq4k1n48xBHI8kViUYXbtFbCz5iA0OIeRCo5eOEdmLcJ+nqlaR2B0+wERneP60LnX3YalHfDmoAZWfmnujCaTNBoWTbmDKIfeldKLEhxrJH42JeMi2IYLL5NlN9CX1JzHeaDEbLOEySb+KkHDxqDt4XQPZRuSylsgpkrjivWMpVngiK4bT7fg0KhXm5VG28+qytQ2KV7TZ3UTyZRcvSNvT5ksyhJOk7K+FC8APMxxV2cwYgyYPyJSiuaw55tCeujm9M4S+L1lAZVzs5gk0aUpImsNgkbqLAhswWTeMER/3p8kC9hWD9v0yhDCgFZW+M1eLuoeJeEYCX3m51SKeiaf9HScfAykp8efvdKgKjMOuZShkSGCEtHgTM6pn6ibqdSd+mVuhn+i9hd0XdQM5sdPPR7Or5XjOvLolFju3eh2CwOCwTFUaiPf3ojdEYWL4oAYMtNUBjF5xhccztGOYSMCxMyo1qrJJRaC4Ct7fZSmSEnICOR4fj/+nb5NwWsRNfB+xyvGsMSyA9Xh/R7K8BULSy1DnHYyfMBeOXfplS7eCT4KP2y0YUnGwtTyCwleKZ1WtjKbYHL4VuJYtDf9UEB8Ow5gEDOH8kk2z08Mbi3VSeZWSXw9d1olUYRIDOiBzakI28qC4MiVAA1wdepjnElaJTt8VCef8q+8jZ/hNxWasCMAorazHzbDqaxnA2UyckfSWRuP/5m5SZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(186003)(16526019)(6916009)(86362001)(40460700003)(2616005)(336012)(1076003)(54906003)(2906002)(426003)(508600001)(316002)(83380400001)(70206006)(81166007)(82310400005)(70586007)(36756003)(8936002)(8676002)(4326008)(26005)(7696005)(356005)(36860700001)(6666004)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 08:44:31.7217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4556de8-b199-4a5b-fe0a-08da332a77de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3980
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

support reading smartshift apu and dgpu power for smu11 based asic

v2: add new version of SmuMetrics and make calculation more readable (Lijo)
v3: avoid calculations that result in -ve values and skip related checks
v4: use the current power limit on dGPU and exclude smu 11_0_7 (Lijo)
v5: remove redundant code (Lijo)

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../pmfw_if/smu11_driver_if_sienna_cichlid.h  |  63 +++++++
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 161 ++++++++++++++----
 2 files changed, 187 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
index 08f0bb2af5d2..351a4af429b3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
@@ -1540,11 +1540,74 @@ typedef struct {
 
 } SmuMetrics_V3_t;
 
+typedef struct {
+	uint32_t CurrClock[PPCLK_COUNT];
+
+	uint16_t AverageGfxclkFrequencyPreDs;
+	uint16_t AverageGfxclkFrequencyPostDs;
+	uint16_t AverageFclkFrequencyPreDs;
+	uint16_t AverageFclkFrequencyPostDs;
+	uint16_t AverageUclkFrequencyPreDs;
+	uint16_t AverageUclkFrequencyPostDs;
+
+
+	uint16_t AverageGfxActivity;
+	uint16_t AverageUclkActivity;
+	uint8_t  CurrSocVoltageOffset;
+	uint8_t  CurrGfxVoltageOffset;
+	uint8_t  CurrMemVidOffset;
+	uint8_t  Padding8;
+	uint16_t AverageSocketPower;
+	uint16_t TemperatureEdge;
+	uint16_t TemperatureHotspot;
+	uint16_t TemperatureMem;
+	uint16_t TemperatureVrGfx;
+	uint16_t TemperatureVrMem0;
+	uint16_t TemperatureVrMem1;
+	uint16_t TemperatureVrSoc;
+	uint16_t TemperatureLiquid0;
+	uint16_t TemperatureLiquid1;
+	uint16_t TemperaturePlx;
+	uint16_t Padding16;
+	uint32_t AccCnt;
+	uint8_t  ThrottlingPercentage[THROTTLER_COUNT];
+
+
+	uint8_t  LinkDpmLevel;
+	uint8_t  CurrFanPwm;
+	uint16_t CurrFanSpeed;
+
+	//BACO metrics, PMFW-1721
+	//metrics for D3hot entry/exit and driver ARM msgs
+	uint8_t D3HotEntryCountPerMode[D3HOT_SEQUENCE_COUNT];
+	uint8_t D3HotExitCountPerMode[D3HOT_SEQUENCE_COUNT];
+	uint8_t ArmMsgReceivedCountPerMode[D3HOT_SEQUENCE_COUNT];
+
+	//PMFW-4362
+	uint32_t EnergyAccumulator;
+	uint16_t AverageVclk0Frequency;
+	uint16_t AverageDclk0Frequency;
+	uint16_t AverageVclk1Frequency;
+	uint16_t AverageDclk1Frequency;
+	uint16_t VcnUsagePercentage0;
+	uint16_t VcnUsagePercentage1;
+	uint8_t  PcieRate;
+	uint8_t  PcieWidth;
+	uint16_t AverageGfxclkFrequencyTarget;
+
+	uint8_t  ApuSTAPMSmartShiftLimit;
+	uint8_t  AverageApuSocketPower;
+	uint8_t  ApuSTAPMLimit;
+	uint8_t  Padding8_2;
+
+} SmuMetrics_V4_t;
+
 typedef struct {
   union {
     SmuMetrics_t SmuMetrics;
     SmuMetrics_V2_t SmuMetrics_V2;
     SmuMetrics_V3_t SmuMetrics_V3;
+    SmuMetrics_V4_t SmuMetrics_V4;
   };
   uint32_t Spare[1];
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 86ab276b6b0b..d68be8f8850e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -585,6 +585,100 @@ static uint32_t sienna_cichlid_get_throttler_status_locked(struct smu_context *s
 	return throttler_status;
 }
 
+static int sienna_cichlid_get_power_limit(struct smu_context *smu,
+					  uint32_t *current_power_limit,
+					  uint32_t *default_power_limit,
+					  uint32_t *max_power_limit)
+{
+	struct smu_11_0_7_powerplay_table *powerplay_table =
+		(struct smu_11_0_7_powerplay_table *)smu->smu_table.power_play_table;
+	uint32_t power_limit, od_percent;
+	uint16_t *table_member;
+
+	GET_PPTABLE_MEMBER(SocketPowerLimitAc, &table_member);
+
+	if (smu_v11_0_get_current_power_limit(smu, &power_limit)) {
+		power_limit =
+			table_member[PPT_THROTTLER_PPT0];
+	}
+
+	if (current_power_limit)
+		*current_power_limit = power_limit;
+	if (default_power_limit)
+		*default_power_limit = power_limit;
+
+	if (max_power_limit) {
+		if (smu->od_enabled) {
+			od_percent =
+				le32_to_cpu(powerplay_table->overdrive_table.max[
+							SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
+
+			dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n",
+					od_percent, power_limit);
+
+			power_limit *= (100 + od_percent);
+			power_limit /= 100;
+		}
+		*max_power_limit = power_limit;
+	}
+
+	return 0;
+}
+
+static void sienna_cichlid_get_smartshift_power_percentage(struct smu_context *smu,
+					uint32_t *apu_percent,
+					uint32_t *dgpu_percent)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	SmuMetrics_V4_t *metrics_v4 =
+		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))->SmuMetrics_V4);
+	uint16_t powerRatio = 0;
+	uint16_t apu_power_limit = 0;
+	uint16_t dgpu_power_limit = 0;
+	uint32_t apu_boost = 0;
+	uint32_t dgpu_boost = 0;
+	uint32_t cur_power_limit;
+
+	if (metrics_v4->ApuSTAPMSmartShiftLimit != 0) {
+		sienna_cichlid_get_power_limit(smu, &cur_power_limit, NULL, NULL);
+		apu_power_limit = metrics_v4->ApuSTAPMLimit;
+		dgpu_power_limit = cur_power_limit;
+		powerRatio = (((apu_power_limit +
+						  dgpu_power_limit) * 100) /
+						  metrics_v4->ApuSTAPMSmartShiftLimit);
+		if (powerRatio > 100) {
+			apu_power_limit = (apu_power_limit * 100) /
+									 powerRatio;
+			dgpu_power_limit = (dgpu_power_limit * 100) /
+									  powerRatio;
+		}
+		if (metrics_v4->AverageApuSocketPower > apu_power_limit &&
+			 apu_power_limit != 0) {
+			apu_boost = ((metrics_v4->AverageApuSocketPower -
+							apu_power_limit) * 100) /
+							apu_power_limit;
+			if (apu_boost > 100)
+				apu_boost = 100;
+		}
+
+		if (metrics_v4->AverageSocketPower > dgpu_power_limit &&
+			 dgpu_power_limit != 0) {
+			dgpu_boost = ((metrics_v4->AverageSocketPower -
+							 dgpu_power_limit) * 100) /
+							 dgpu_power_limit;
+			if (dgpu_boost > 100)
+				dgpu_boost = 100;
+		}
+
+		if (dgpu_boost >= apu_boost)
+			apu_boost = 0;
+		else
+			dgpu_boost = 0;
+	}
+	*apu_percent = apu_boost;
+	*dgpu_percent = dgpu_boost;
+}
+
 static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 					       MetricsMember_t member,
 					       uint32_t *value)
@@ -600,6 +694,8 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 	bool use_metrics_v3 = false;
 	uint16_t average_gfx_activity;
 	int ret = 0;
+	uint32_t apu_percent = 0;
+	uint32_t dgpu_percent = 0;
 
 	if ((smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7)) &&
 		(smu->smc_fw_version >= 0x3A4900))
@@ -738,6 +834,15 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 		/* Only supported in 0x3A5300+, metrics_v3 requires 0x3A4900+ */
 		*value = use_metrics_v3 ? metrics_v3->PublicSerialNumLower32 : 0;
 		break;
+	case METRICS_SS_APU_SHARE:
+		sienna_cichlid_get_smartshift_power_percentage(smu, &apu_percent, &dgpu_percent);
+		*value = apu_percent;
+		break;
+	case METRICS_SS_DGPU_SHARE:
+		sienna_cichlid_get_smartshift_power_percentage(smu, &apu_percent, &dgpu_percent);
+		*value = dgpu_percent;
+		break;
+
 	default:
 		*value = UINT_MAX;
 		break;
@@ -1728,6 +1833,7 @@ static int sienna_cichlid_read_sensor(struct smu_context *smu,
 {
 	int ret = 0;
 	uint16_t *temp;
+	struct amdgpu_device *adev = smu->adev;
 
 	if(!data || !size)
 		return -EINVAL;
@@ -1788,6 +1894,24 @@ static int sienna_cichlid_read_sensor(struct smu_context *smu,
 		ret = smu_v11_0_get_gfx_vdd(smu, (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_SS_APU_SHARE:
+		if (adev->ip_versions[MP1_HWIP][0] != IP_VERSION(11, 0, 7)) {
+			ret = sienna_cichlid_get_smu_metrics_data(smu,
+						METRICS_SS_APU_SHARE, (uint32_t *)data);
+			*size = 4;
+		} else {
+			ret = -EOPNOTSUPP;
+		}
+		break;
+	case AMDGPU_PP_SENSOR_SS_DGPU_SHARE:
+		if (adev->ip_versions[MP1_HWIP][0] != IP_VERSION(11, 0, 7)) {
+			ret = sienna_cichlid_get_smu_metrics_data(smu,
+						METRICS_SS_DGPU_SHARE, (uint32_t *)data);
+			*size = 4;
+		} else {
+			ret = -EOPNOTSUPP;
+		}
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
@@ -1907,43 +2031,6 @@ static int sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
 	return ret;
 }
 
-static int sienna_cichlid_get_power_limit(struct smu_context *smu,
-					  uint32_t *current_power_limit,
-					  uint32_t *default_power_limit,
-					  uint32_t *max_power_limit)
-{
-	struct smu_11_0_7_powerplay_table *powerplay_table =
-		(struct smu_11_0_7_powerplay_table *)smu->smu_table.power_play_table;
-	uint32_t power_limit, od_percent;
-	uint16_t *table_member;
-
-	GET_PPTABLE_MEMBER(SocketPowerLimitAc, &table_member);
-
-	if (smu_v11_0_get_current_power_limit(smu, &power_limit)) {
-		power_limit =
-			table_member[PPT_THROTTLER_PPT0];
-	}
-
-	if (current_power_limit)
-		*current_power_limit = power_limit;
-	if (default_power_limit)
-		*default_power_limit = power_limit;
-
-	if (max_power_limit) {
-		if (smu->od_enabled) {
-			od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
-
-			dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_percent, power_limit);
-
-			power_limit *= (100 + od_percent);
-			power_limit /= 100;
-		}
-		*max_power_limit = power_limit;
-	}
-
-	return 0;
-}
-
 static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 					 uint32_t pcie_gen_cap,
 					 uint32_t pcie_width_cap)
-- 
2.25.1

