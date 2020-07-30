Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A44C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 03:30:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7D7B22B48
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 03:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xBV63GND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D7B22B48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E9A66E84B;
	Thu, 30 Jul 2020 03:30:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 696846E84B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 03:30:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuceSCs2fVod8orcx19opw6VjeYGwZyKQUjn2zGvmc9S3eOGFeMrIhdA6PMcwbDIY6G50x9gFdi5pKLjFfhJ7oFJPimxes2BpzmVl5td2DdYKCZUUYTlcajw1XCe+LEbcm9bIDpR59JElP7ogacp14wPyhHzhnH8EwNr/PQt6aOYOdi5odhai66UpBScUeYABOKwlqLmFeyHSAKZ9ew4VQcmZJjMEF66I6pEc357atVI0Jk+vDjxhlonN5IO6Xfns3Z9PX1LpLKd9KayBcNGzx5WdC6lDHdEDSi8YQSW8xGLVGLTR9Bf5ACKX6ES8iZTFpjZ85Zj0Yec20ab7mxxTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2W2SqWKIR2W2MqEv139pDBnOP1xW99bu0te8Jihapc4=;
 b=mFwv65gl0HWfcKazM/u1lhbiAXvpK13lYGadozEGWFlIt9AQmYV/qx2soqWMpniX1wFq3yj/oMCnZwqLHhFnD/mvPu7VXlcyal/N808Ac04zZPniOQWtZTu7pQopuxbSPSPZS3p72skAyyBM8JL2O/1VQoevWGQeelinrpDTfOxddxDaATaUhfLU7E504kTeIfDJvK9C4D2hl+VAwM4d/xxs9UOWSwLTP3fZnm+DcwjPZLWXbg4mvEWXZ2qpX1DMCAf/weHs5/f8Htk/31QZ9srM9BOn4ysLIk2nDZrdH4Syw7nxq92ixaqn3BE9ovfc09w8aZas39tDKcAd/1XHyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2W2SqWKIR2W2MqEv139pDBnOP1xW99bu0te8Jihapc4=;
 b=xBV63GND+HFI93JYEIzHa3eWZaN5cV0kcF6nVoiAOm4L7GTXDgURATTaod0CA/WXftzdn4ez8XGHj3vLE3xcA8mxY/jneDy/7JpPWyzFC0xfzuqrza28H0V017D1m7UgpcUA/TZXgeY2WRziDyqkqywalta0eKfJW9xELsapKas=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17; Thu, 30 Jul 2020 03:30:19 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Thu, 30 Jul 2020
 03:30:19 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/8] drm/amd/powerplay: add Arcturus support for gpu metrics
 export
Date: Thu, 30 Jul 2020 11:28:35 +0800
Message-Id: <20200730032839.2517-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730032839.2517-1-evan.quan@amd.com>
References: <20200730032839.2517-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0176.apcprd02.prod.outlook.com
 (2603:1096:201:21::12) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0176.apcprd02.prod.outlook.com (2603:1096:201:21::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Thu, 30 Jul 2020 03:30:17 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5d32e3d6-bfd2-46f2-6cea-08d83438e228
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB135517DD5CC4A9085DBC101FE4710@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K4kGg8d20VIgU7F07ALzHbNXDSbF2KcqmAEGHf/4dQrZnRgW/plLHtEAJeMSllBHKcMegIeCbv26Yi5QHydo7fnkCHpQMwiBTiBGW8Qxzgs884VbwrBTNycGafcnnwAyuPgWPPY/yAcUyuUPsDYBUP5IEpn5BH2aQTLjJQfwtlQJgV4TDek7ELz1GtwzysYs83zZTYyYL6JYa1HxxKwiquNpU/fg9LumMuumtjfYp/VdkJhr4PMzJsFrwhs2xI/vmi9WbI/TofC2HyurCCm1eik0WVXTMflONMKh2mEHvvInIEBuAenLtXXdINo2fXhl36oGgJOIHPxSTTdYOOGFbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(186003)(83380400001)(4326008)(6916009)(36756003)(2906002)(8676002)(8936002)(478600001)(66946007)(44832011)(2616005)(956004)(26005)(66476007)(66556008)(1076003)(6666004)(6486002)(5660300002)(86362001)(52116002)(7696005)(16526019)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: bpKrjFErdQN/fjwtHWXDqbCC2eJS3BJ6pb5n9/oYMDec/djcOIKBwQPoQHgCh3bjICPBgms59UfHzBCnJqc+2SmTQFThcg0N4y+KcsNpfJgzTwJKg5LcWHB42nd7JPUpSYjX8WcbOYwosbmHNI7gj7rZq1tAz0dp+IEKXvcIaCM5U5pvGiBCGCc+6/w/P1FxXv7NBrGkRt6R/xHe3gJLtBH5JGsN3GNC2JyPnQplrYp0UY3aUCbhKKWEPbcFTzOtwPIG6U9tI118loOexItZe3eJkMqvZoN2THVXtI4JoLfLswTfhUO+LWeuSJ9VpSuv8XKbXrgTWuEo+EvmIIicONSDaBUJVjl+GMfSnfe0eyzTwgxEi9+nIDB2aclUvre5HnisgM6797bM3sceXo3SuH4y2yKRum7X7wewBbiUGi6xwpwkrbHI50V252KDeV5N9cy4jRKWrQCXOskS+bsx4IaRvv8tSSyUy2qxVj2FcK2Sv557EF1AuaGYR2E/ZJnLWcQTmOPyGI9m4XIBbqPzoFdqgEOiBHPhHJB7SwO1juj5+GXLklG7hCYAH3Njals91euPHXClOW80XQ6hp+O3qjbeNEsjVLCAlZbE4j4uBa1DiaeKoNesXxH+y9N7lAPpMacdhhgPDiSH57e751hwig==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d32e3d6-bfd2-46f2-6cea-08d83438e228
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 03:30:19.3206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VF8972MkkbWsmP5hyVcu79cMkCwJdQZ6pCkl0jIPSb591EPQ6eQBKLCcMvW3qUpj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add Arcturus gpu metrics export interface.

Change-Id: I372337f31e2b7174d41fb4e3af180deb94b5ec06
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 92 +++++++++++++++++++
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  3 +
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  2 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 12 +++
 4 files changed, 109 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index f13979687b9e..39bfe0ebfea3 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -79,6 +79,8 @@
 /* possible frequency drift (1Mhz) */
 #define EPSILON				1
 
+#define smnPCIE_ESM_CTRL			0x111003D0
+
 static const struct cmn2asic_msg_mapping arcturus_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
 	MSG_MAP(GetSmuVersion,			     PPSMC_MSG_GetSmuVersion,			1),
@@ -234,6 +236,13 @@ static int arcturus_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_0);
+	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
+	if (!smu_table->gpu_metrics_table) {
+		kfree(smu_table->metrics_table);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
@@ -2254,6 +2263,88 @@ static void arcturus_log_thermal_throttling_event(struct smu_context *smu)
 	kgd2kfd_smi_event_throttle(smu->adev->kfd.dev, throttler_status);
 }
 
+static int arcturus_get_current_pcie_link_speed(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t esm_ctrl;
+
+	/* TODO: confirm this on real target */
+	esm_ctrl = RREG32_PCIE(smnPCIE_ESM_CTRL);
+	if ((esm_ctrl >> 15) & 0x1FFFF)
+		return (((esm_ctrl >> 8) & 0x3F) + 128);
+
+	return smu_v11_0_get_current_pcie_link_speed(smu);
+}
+
+static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
+					void **table)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct gpu_metrics_v1_0 *gpu_metrics =
+		(struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
+	SmuMetrics_t metrics;
+	int ret = 0;
+
+	mutex_lock(&smu->metrics_lock);
+
+	ret = smu_cmn_update_table(smu,
+				   SMU_TABLE_SMU_METRICS,
+				   0,
+				   smu_table->metrics_table,
+				   false);
+	if (ret) {
+		dev_info(smu->adev->dev, "Failed to export SMU metrics table!\n");
+		mutex_unlock(&smu->metrics_lock);
+		return ret;
+	}
+	smu_table->metrics_time = jiffies;
+
+	memcpy(&metrics, smu_table->metrics_table, sizeof(SmuMetrics_t));
+
+	mutex_unlock(&smu->metrics_lock);
+
+	smu_v11_0_init_gpu_metrics_v1_0(gpu_metrics);
+
+	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
+	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
+	gpu_metrics->temperature_mem = metrics.TemperatureHBM;
+	gpu_metrics->temperature_vrgfx = metrics.TemperatureVrGfx;
+	gpu_metrics->temperature_vrsoc = metrics.TemperatureVrSoc;
+	gpu_metrics->temperature_vrmem = metrics.TemperatureVrMem;
+
+	gpu_metrics->average_gfx_activity = metrics.AverageGfxActivity;
+	gpu_metrics->average_umc_activity = metrics.AverageUclkActivity;
+	gpu_metrics->average_mm_activity = metrics.VcnActivityPercentage;
+
+	gpu_metrics->average_socket_power = metrics.AverageSocketPower;
+	gpu_metrics->energy_accumulator = metrics.EnergyAccumulator;
+
+	gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequency;
+	gpu_metrics->average_socclk_frequency = metrics.AverageSocclkFrequency;
+	gpu_metrics->average_uclk_frequency = metrics.AverageUclkFrequency;
+	gpu_metrics->average_vclk0_frequency = metrics.AverageVclkFrequency;
+	gpu_metrics->average_dclk0_frequency = metrics.AverageDclkFrequency;
+
+	gpu_metrics->current_gfxclk = metrics.CurrClock[PPCLK_GFXCLK];
+	gpu_metrics->current_socclk = metrics.CurrClock[PPCLK_SOCCLK];
+	gpu_metrics->current_uclk = metrics.CurrClock[PPCLK_UCLK];
+	gpu_metrics->current_vclk0 = metrics.CurrClock[PPCLK_VCLK];
+	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
+
+	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+
+	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
+
+	gpu_metrics->pcie_link_width =
+			smu_v11_0_get_current_pcie_link_width(smu);
+	gpu_metrics->pcie_link_speed =
+			arcturus_get_current_pcie_link_speed(smu);
+
+	*table = (void *)gpu_metrics;
+
+	return sizeof(struct gpu_metrics_v1_0);
+}
+
 static const struct pptable_funcs arcturus_ppt_funcs = {
 	/* init dpm */
 	.get_allowed_feature_mask = arcturus_get_allowed_feature_mask,
@@ -2331,6 +2422,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.log_thermal_throttling_event = arcturus_log_thermal_throttling_event,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
+	.get_gpu_metrics = arcturus_get_gpu_metrics,
 };
 
 void arcturus_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index a08155b83289..ec2d2aa7f4ec 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -274,6 +274,9 @@ struct smu_table_context
 
 	void				*overdrive_table;
 	void                            *boot_overdrive_table;
+
+	uint32_t			gpu_metrics_table_size;
+	void				*gpu_metrics_table;
 };
 
 struct smu_dpm_context {
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index aeb12654257e..f2a522176ca0 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -272,5 +272,7 @@ int smu_v11_0_get_current_pcie_link_speed_level(struct smu_context *smu);
 
 int smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu);
 
+void smu_v11_0_init_gpu_metrics_v1_0(struct gpu_metrics_v1_0 *gpu_metrics);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 7f1229a0e8db..7ee6043897c7 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -417,10 +417,12 @@ int smu_v11_0_fini_smc_tables(struct smu_context *smu)
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 
+	kfree(smu_table->gpu_metrics_table);
 	kfree(smu_table->boot_overdrive_table);
 	kfree(smu_table->overdrive_table);
 	kfree(smu_table->max_sustainable_clocks);
 	kfree(smu_table->driver_pptable);
+	smu_table->gpu_metrics_table = NULL;
 	smu_table->boot_overdrive_table = NULL;
 	smu_table->overdrive_table = NULL;
 	smu_table->max_sustainable_clocks = NULL;
@@ -1970,3 +1972,13 @@ int smu_v11_0_get_current_pcie_link_speed(struct smu_context *smu)
 
 	return link_speed[speed_level];
 }
+
+void smu_v11_0_init_gpu_metrics_v1_0(struct gpu_metrics_v1_0 *gpu_metrics)
+{
+	memset(gpu_metrics, 0xFF, sizeof(struct gpu_metrics_v1_0));
+
+	gpu_metrics->common_header.structure_size =
+				sizeof(struct gpu_metrics_v1_0);
+	gpu_metrics->common_header.format_revision = 1;
+	gpu_metrics->common_header.content_revision = 0;
+}
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
