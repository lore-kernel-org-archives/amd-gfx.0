Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCD1C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 07:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33A2710EC5C;
	Wed, 11 May 2022 07:22:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1CE810EC44
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 07:22:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeY47sZKeFBe4lKxYwrPsnOgdnZ/EW6AXiPkh3xwdRpfFoNbZ6DjEWDzomYJrnnIJH1Dk39ADyohV5efBV5svg/ingzXj/CHhLUqpxmKKmiAhGPRolYbJfsFmU4tOZ+VVfqFgQ1F2YasZ9eDaF/c2mbmLbng2WkQAtEubW7dWdGrVS3QXErbXDuT3glZkSH88RrZGrJXM42ltXBM6VXXhXWxR1kZ+foVGZ+QzW9zydOZlqmJqq9EZdkWlXn06ArvLk1Bm4lxonzYoO9yU6VeAGy/P7IKT4GgdoVepZjY1WxiZvLS+9Baeq1jYAJLjazzvGHXJnwA2yzK1j3u4j57KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UboCeA82Tn+7bX+8zvoVxCcAF6YpQD3uMjkD3gL33L0=;
 b=c9kBxYaG8cveHRo99LhrR4UEIppLIoL0dKnWs2dK3npicGrtb6tm+STpkHVnd4AF+ZJXsWwC5ug+1B3pGSb0karqM/yOzMFABxhKfaB+yngvn8eD+cJLiqjzG4YYfIyh5ga1+eTabAREvFOFZyrfR7666kkSyn9sVLyDuermitmx0HuEt7XQEBp73O3pjOGOdV4Voms3y7qFZcNDHhtLDHc1roHVFDBeDnlQkQjPmTZjWcP7iFC32yek7ESg6QU5vaOTgAmOVBbWlzXzOoWikD+nn85KAaPKAuKmgONstqxoEubXqjhTs5ptOdF0NM9nDQjrW3JXtaL5oFrSJiMchg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UboCeA82Tn+7bX+8zvoVxCcAF6YpQD3uMjkD3gL33L0=;
 b=2AA3Pc9SM8ThyDgwZgRmeursnLqthd0Fu1f0nw40ee2AVc/2f96/TscbrNn1nzdCidvyqP5xyYCDy1rBuP8+pJYTbyqzYWyUvF1Ne6DWQehDcPUbxfZ0d6tkJHZVwZGvRVaefZXxEsKQ1kTvrLUAfXBgyJ6kEXOzlOjhpmaPvGM=
Received: from DM6PR06CA0050.namprd06.prod.outlook.com (2603:10b6:5:54::27) by
 CY4PR12MB1880.namprd12.prod.outlook.com (2603:10b6:903:126::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 07:22:13 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::19) by DM6PR06CA0050.outlook.office365.com
 (2603:10b6:5:54::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Wed, 11 May 2022 07:22:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:22:13 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 02:22:11 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: support ss metrics read for smu11
Date: Wed, 11 May 2022 12:51:50 +0530
Message-ID: <20220511072150.1595528-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf5402f3-9c8c-4ee2-b7a3-08da331ef840
X-MS-TrafficTypeDiagnostic: CY4PR12MB1880:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1880B13A8118D1F3F4CCC2979DC89@CY4PR12MB1880.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +3WC2oSDQW2Us2cSWd3XvmzKK7MtDwprjSFzte9SRaoGosmGlly+co5K69DiE1i5xRfc/zK6hCa5ms1hSqSxCR5owf3srcrB6qqEWz2Imli0+jQ5e0yAhDyBL2jDZmhfz1qfWq+GGFePSt0l/tUTq4lozipXSACkrKVVTLX3myIZmzaHZDet2pl30EbxRUR4bwMpx7EF3BbFgqYcJUsKyw7OK8NPhoCKAG6mLcuXynWQbxzy1iffJvJwrwWNK+eLCn1sAO+o+7S3IB20PyeEtKJ/LdDlVedOTTwhU4gcDxcgoesSXRrLhFBnXzeQL+0g2h01gi1WU9BqLfx0ZCTsnF+dl20lGezfJr2FLAdUW6hBzFMIGDJ9LpcjjHbluUddAsXOavsjdzzcuPkpOXxMZmI8Y7jlVUN3hZul5+T9T7VnKvb63hwDga0UC2/aqCvE18oW/QLVZ7jE4AQMgTtJxZ6dA6V6iu6M1dHct0XHjF8dA3ncZOb3k+fuxzQOZCLZHB22uS+cQkZqSHkzhKRTrqeJsrpjkdLA4lGb6VdXkF7P+21BAohqPQSDQ0byR9OrNf0nCCq98F3W4UqR3pQG6PK9ECkvv1z0MvlJw67bURH4clVFR1RZ/usbNH1NjUTsXidU4aP85oo1l3BAm6+LOYMOPTOeVr0q/tl78oYWSwdmZoNQt87in8IttdklYaj93W3c3Hntg5ieh5kEnlkPLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(83380400001)(336012)(70586007)(8676002)(47076005)(426003)(70206006)(356005)(40460700003)(4326008)(81166007)(2906002)(36756003)(54906003)(7696005)(508600001)(6666004)(316002)(6916009)(36860700001)(82310400005)(26005)(5660300002)(2616005)(1076003)(86362001)(186003)(16526019)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:22:13.2435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf5402f3-9c8c-4ee2-b7a3-08da331ef840
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1880
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
 Lazar Lijo <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

support reading smartshift apu and dgpu power for smu11 based asic

v2: add new version of SmuMetrics and make calculation more readable (Lijo)
v3: avoid calculations that result in -ve values and skip related checks
v4: use the current power limit on dGPU and exclude smu 11_0_7 (Lijo)

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../pmfw_if/smu11_driver_if_sienna_cichlid.h  |  63 +++++++
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 161 ++++++++++++++----
 2 files changed, 187 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid.h
index 08f0bb2af5d2..280d42778f28 100644
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
+	SmuMetrics_V4_t SmuMetrics_V4;
   };
   uint32_t Spare[1];
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 86ab276b6b0b..503439754f08 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -585,6 +585,102 @@ static uint32_t sienna_cichlid_get_throttler_status_locked(struct smu_context *s
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
+	uint16_t *table_member;
+	uint16_t powerRatio = 0;
+	uint16_t apu_power_limit = 0;
+	uint16_t dgpu_power_limit = 0;
+	uint32_t apu_boost = 0;
+	uint32_t dgpu_boost = 0;
+	uint32_t cur_power_limit;
+
+	sienna_cichlid_get_power_limit(smu, &cur_power_limit, NULL, NULL);
+	if (metrics_v4->ApuSTAPMSmartShiftLimit != 0) {
+		GET_PPTABLE_MEMBER(SocketPowerLimitAc, &table_member);
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
@@ -600,6 +696,8 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 	bool use_metrics_v3 = false;
 	uint16_t average_gfx_activity;
 	int ret = 0;
+	uint32_t apu_percent = 0;
+	uint32_t dgpu_percent = 0;
 
 	if ((smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7)) &&
 		(smu->smc_fw_version >= 0x3A4900))
@@ -738,6 +836,15 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
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
@@ -1728,6 +1835,7 @@ static int sienna_cichlid_read_sensor(struct smu_context *smu,
 {
 	int ret = 0;
 	uint16_t *temp;
+	struct amdgpu_device *adev = smu->adev;
 
 	if(!data || !size)
 		return -EINVAL;
@@ -1788,6 +1896,22 @@ static int sienna_cichlid_read_sensor(struct smu_context *smu,
 		ret = smu_v11_0_get_gfx_vdd(smu, (uint32_t *)data);
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_SS_APU_SHARE:
+		if (adev->ip_versions[MP1_HWIP][0] != IP_VERSION(11, 0, 7)) {
+			ret = sienna_cichlid_get_smu_metrics_data(smu,
+						METRICS_SS_APU_SHARE, (uint32_t *)data);
+			*size = 4;
+		} else
+			ret = -EOPNOTSUPP;
+		break;
+	case AMDGPU_PP_SENSOR_SS_DGPU_SHARE:
+		if (adev->ip_versions[MP1_HWIP][0] != IP_VERSION(11, 0, 7)) {
+			ret = sienna_cichlid_get_smu_metrics_data(smu,
+						METRICS_SS_DGPU_SHARE, (uint32_t *)data);
+			*size = 4;
+		} else
+			ret = -EOPNOTSUPP;
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

