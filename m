Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3025BF9D0F1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 19:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CADD510E655;
	Tue, 14 Apr 2026 19:46:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pXdK3yVe";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF29B10E655
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 19:46:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g974NeQ2tJxLCHeu8mNHx6ERUZkK6GQRof85I5w7eSnh2Vd5HBIHAmUYKfyZrKhexz+QqiBK6lE0nR4phksNnwJpDvyIKC2vi7QyfofQUtZoB9OxIcwx3EabuTYE3S6R4pus/4jqc1n5O3Sa9Ur/1eaUHP4SkWMFaOtbIEruk3sTtK4y+I5Jbz11Aqtu3bCqGEUu/nYRQDLF+oC33i2Yd1VH6Yd+OVi6unEbQCRiLBw8JFoIbQbRaKjb22wSL/4GewR/sSZTTQjHYkmNB95nQ1tNIeF9rx18Q2Rx0SlTerI4SNIwVJP4BhU9Dj587oSwlNEOOciXd2eRRjEFRufBJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qNoePwHGC0Hm0akJr5tjXX7tvOlZETbIZdHRxofj9Q=;
 b=g/HQBDut+ovPU+ewbq75VVnsHSzZUfuH0KkNJAku+gNmIf0/65usb2qVx/jAHmNH1k6o4w09geG51m3c1Ywo3sc9V4i92YApcamrGA/V0x/5dTSvq3eMDQGmzneN8lniuheYQuJ+YrhcAWODlLjlA6s4/fzAHBIa8fj38qAzWqOBMhLPjIJHnTSzJfrpj3SiShq916lyghcG5NytbLj60B9di0Ou8BhuLolY3/Nizlcuoo58ymjx+R7M9iges1W81CRgjeZuupoU62jN+eGfUwd2Xfb+fBiufAdRgbLMhzOtz6kfdVTugKhYEAU/QHdVhqC+zctMCQ/iSqqy9V3CJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qNoePwHGC0Hm0akJr5tjXX7tvOlZETbIZdHRxofj9Q=;
 b=pXdK3yVeHHVKiD8EWJxmordTG0TZ4nL/ce3yqnVyTTXVwRvmQqDFu5MuCiktokiTBRm9qoUmeMWif2qLDgnWC5BlrWS5Wrl4ybbI7yYfpxh+ccLe58+qOAOQkl16ml1Y3OvO8T9EEsne9kKN1azpJxC229+cRZSP86Xb/ha+Y5g=
Received: from DM6PR05CA0048.namprd05.prod.outlook.com (2603:10b6:5:335::17)
 by IA1PR12MB8224.namprd12.prod.outlook.com (2603:10b6:208:3f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 19:46:02 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:335:cafe::52) by DM6PR05CA0048.outlook.office365.com
 (2603:10b6:5:335::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 19:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 19:45:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 14 Apr
 2026 14:45:57 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Apr
 2026 14:45:56 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 14:45:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Asad Kamal <asad.kamal@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amd/pm: Add thermal alert logging to smu15.0.8
Date: Tue, 14 Apr 2026 15:45:47 -0400
Message-ID: <20260414194547.2213525-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414194547.2213525-1-alexander.deucher@amd.com>
References: <20260414194547.2213525-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|IA1PR12MB8224:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8adbb8-b50d-4649-61ee-08de9a5e72b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: S1xtNYD98rFCeGgARzybXcH7l372Y6b7hBmacIplayX4NkeaJ9m0WSceJamdnBHaQIMWaR/1P5IKmDl217buBrzAQTTXQ1bHJ8MLW3uzrMISB4nS7g6xhAN13jYTYHQF2jCO2+cUR5ccgfjYp+wxc0MmPnBzciTXRMDUM0nKrthmdWfYRWjuFtdCOmZfSdrj+XJhiwN8p9F0QBtHBPxwI/HFSW2HueUCpn//NzQjXB5PrBX15O4//sFM8Q30YSCfjY1ZOOvxSPQgScxdE8dKVq6tlkmKnG4JvCLJB/zUbcwaGxjuvs+mhq8xXQh2VAPirvHUbgixFweO+AVn+VYLcUq/FCUVEob+m63MfCLKFtqqs7/oD4wNmdsOf9K8VuQPsmRSOFc1PmF6NJGZUuNI8rkADbEWY+JLzvauACEd7WifZF3Ar2ZIYI9lJFlkQU/t5OGq1sqZlWgGKkGiFZC5EQ1LiHDmUPFzghYFzBV/nNzXkIg1mBSNhggfXJLNFKhYctFU+YQGaHVkWhGyYbchuo5ksF76ON5V07NnyoiQW0qoe9sXI+moNPdeZj08K+C1fArzBbW7KEW0gTWDt8i+bwuszfBZv0yArmd7CkO00s0xgXY627GcIPKImrFmRn7Pc2DwvuQ3nuCTLEMKPAiYC5WcHOz25EgVdsr4Kx7J56li9KEJcmf0YhSxszGADuR4p/bVSTq7UK+LB5P1tBvR/mUwTKbYEalRyLttIPALVD2fsdNa7AqugFM+cM/jx3wbvGJVKmvmjx2lpReAX3H43g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BGN25DVLstL/KDSgu//Dec2Crdt/YoCr5pB3kaH2bMqOKkRaE1IQOaN3eGGu9KiXPM/e/msk6B8WEfS30kJfJONWFL9XIx2hMU8iS3nsm7nYOFxBPrvBu8Km3Q4mGTiez+y4wAT+IThUaelrrQahXc5vM0ouql1klhoNfEbnA/HwxD9gs/ce+DeXuVis0kMrHpOO+0Sa/kB9n/gTf+TJpwax2DrQpSSlEdA8SxizaKAQCh7HRqMLTwYxszGgElcyhz2HAbzLDoLIsjnzi2U8iTa9fsvhFNJ+58t/RsI1HvYkaFEd2pjbciQpvijPnz38NHbC8E82CdTE2E92v3g7j2a+qqFGx+1Zm2Akb3yXJiV1srWvSOayl01MBd/0q0rsYswrQsrfoAVKxRNm52mmOP5r5vMsPFZ6oVD+xiVwe4cKCcB7v5KPzwWdoPJACMTc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 19:45:57.4911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8adbb8-b50d-4649-61ee-08de9a5e72b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8224
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

From: Lijo Lazar <lijo.lazar@amd.com>

Add logging for thermal events in SMUv15.0.8 SOCs

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index e62494810b803..977590377021e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -173,6 +173,13 @@ static const struct cmn2asic_mapping smu_v15_0_8_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP(I2C_COMMANDS),
 };
 
+static const uint8_t smu_v15_0_8_throttler_map[] = {
+	[THROTTLER_PROCHOT_BIT] = (SMU_THROTTLER_PROCHOT_GFX_BIT),
+	[THROTTLER_THERMAL_SOCKET_BIT] = (SMU_THROTTLER_TEMP_GPU_BIT),
+	[THROTTLER_THERMAL_VR_BIT] = (SMU_THROTTLER_TEMP_VR_GFX_BIT),
+	[THROTTLER_THERMAL_HBM_BIT] = (SMU_THROTTLER_TEMP_MEM_BIT),
+};
+
 static size_t smu_v15_0_8_get_system_metrics_size(void)
 {
 	return sizeof(SystemMetricsTable_t);
@@ -2274,6 +2281,63 @@ static int smu_v15_0_8_get_ppt_limit(struct smu_context *smu,
 	return -EOPNOTSUPP;
 }
 
+static uint32_t smu_v15_0_8_get_throttler_status(struct smu_context *smu)
+{
+	struct smu_power_context *smu_power = &smu->smu_power;
+	struct smu_15_0_power_context *power_context = smu_power->power_context;
+	uint32_t throttler_status = 0;
+
+	throttler_status = atomic_read(&power_context->throttle_status);
+	dev_dbg(smu->adev->dev, "SMU Throttler status: %u", throttler_status);
+
+	return throttler_status;
+}
+
+static const char *const throttling_logging_label[] = {
+	[THROTTLER_PROCHOT_BIT] = "Prochot",
+	[THROTTLER_THERMAL_SOCKET_BIT] = "SOC",
+	[THROTTLER_THERMAL_VR_BIT] = "VR",
+	[THROTTLER_THERMAL_HBM_BIT] = "HBM"
+};
+
+static void smu_v15_0_8_log_thermal_throttling_event(struct smu_context *smu)
+{
+	int throttler_idx, throttling_events = 0, buf_idx = 0;
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t throttler_status;
+	char log_buf[256];
+
+	throttler_status = smu_v15_0_8_get_throttler_status(smu);
+	if (!throttler_status)
+		return;
+
+	memset(log_buf, 0, sizeof(log_buf));
+	for (throttler_idx = 0;
+	     throttler_idx < ARRAY_SIZE(throttling_logging_label);
+	     throttler_idx++) {
+		if (throttler_status & (1U << throttler_idx)) {
+			throttling_events++;
+			buf_idx += snprintf(
+				log_buf + buf_idx, sizeof(log_buf) - buf_idx,
+				"%s%s", throttling_events > 1 ? " and " : "",
+				throttling_logging_label[throttler_idx]);
+			if (buf_idx >= sizeof(log_buf)) {
+				dev_err(adev->dev, "buffer overflow!\n");
+				log_buf[sizeof(log_buf) - 1] = '\0';
+				break;
+			}
+		}
+	}
+
+	dev_warn(adev->dev,
+		 "WARN: GPU is throttled, expect performance decrease. %s.\n",
+		 log_buf);
+	kgd2kfd_smi_event_throttle(
+		smu->adev->kfd.dev,
+		smu_cmn_get_indep_throttler_status(throttler_status,
+						   smu_v15_0_8_throttler_map));
+}
+
 static int smu_v15_0_8_enable_thermal_alert(struct smu_context *smu)
 {
 	if (!smu->irq_source.num_types)
@@ -2301,6 +2365,7 @@ static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.register_irq_handler = smu_v15_0_8_register_irq_handler,
 	.enable_thermal_alert = smu_v15_0_8_enable_thermal_alert,
 	.disable_thermal_alert = smu_v15_0_disable_thermal_alert,
+	.log_thermal_throttling_event = smu_v15_0_8_log_thermal_throttling_event,
 	.setup_pptable = smu_v15_0_8_setup_pptable,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.wait_for_event = smu_v15_0_wait_for_event,
-- 
2.53.0

