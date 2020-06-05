Return-Path: <SRS0=/kPV=7S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06ACC433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 06:08:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 644A5207ED
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 06:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ULihcuV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 644A5207ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FB356E83D;
	Fri,  5 Jun 2020 06:08:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 429DB6E83D
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2020 06:08:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHGjM/rFUCTBzEHeMDjqWE840X8AvNbqBH7vdnKwvhCw6G+31mnZFv4MLwtn5I5p3oZXxnlxiJQZ50gU/Ecsl29uwrxmz+J32sUqcDZKHEBJ/81RPad0E18BZwoBzhBBhiho41+Mt+3M63aY1eeKNwg1UjfLYkHy+Lz5USXFIz0l54IxQfzIxKkj2ijjcGxnknux8+pUtG4+DL+lfNmu0l6JmUa/rohgHyWMRELmj9/kt4A4bmzvfBC+6K1QTB6jJXPO/mCEH6qX0jsEYbnY7ySeaNZwFT2/qi/lMg3S7B8jgO7TsyKY/6nLU5kjJNQNXPaCtIBrlWY5R4ZuUECXRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqenhVHtvdjbstUHSmE4KgcqIcMTGJVnvK7m2EPjx0M=;
 b=eXd8sKi9bPHX2o1Z6hT/S325SsBfIultZdePymrMC6xJA7m66O+wf4cVgDTZ+FFIcT2/qs4UgRl1sJK3VjX2TrwQt7AQpMYuO59XrWL/u4Br/B0kuiBlg/snyJSvJREq/S1YOYE9bslSl7asrO6WQasxWL+kltDP24JE1xPsDYp7fHWKcD06IdRg96DUhTVC/a0gl4ambE+LSv3K5TYc7bpkTTu2Z3IElOWpodqgok8yrakaH1hLoth4Ag8ktaZnZ0M3Kt8itj09U4Xhg0MaajuAVSIcSSJNW7r2uibQeUZShUUZGD4QKP6jPJJ0hPCeYH+Zv/SGBDlLVKwTawhM4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqenhVHtvdjbstUHSmE4KgcqIcMTGJVnvK7m2EPjx0M=;
 b=ULihcuV09Y8M0ZvjdRv5qh1kQ+yR0iwL0ZJukT4MGnEYQMITAWLaDuZU8UV77towyGTYf6a6v5ukaCQoFC4BCV8BDbESTgdtZKtIukVGaX78DOyaLNAzmmsCdBWK41HGwfZYa/74SLJsBUZp7LSZzgpfphvHW/7B/Ok2Vw+sXdQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Fri, 5 Jun 2020 06:08:01 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Fri, 5 Jun 2020
 06:08:01 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amd/powerplay: update how to use metrics table on
 Arcturus
Date: Fri,  5 Jun 2020 14:07:37 +0800
Message-Id: <20200605060741.5280-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: HK2PR04CA0046.apcprd04.prod.outlook.com
 (2603:1096:202:14::14) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0046.apcprd04.prod.outlook.com (2603:1096:202:14::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 06:08:00 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ce25d26f-1b92-4747-3625-08d80916cd70
X-MS-TrafficTypeDiagnostic: DM6PR12MB4332:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43326555BF5DD07FB5A4501AE4860@DM6PR12MB4332.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CydR9eJIAMnHZlWTQbhdn0j5Gyfjh+QYGOxkIDULM2+UrJfSvhLPsUAM/xElrbOx1UsfCxmSpjui/Fo/tRin7L6Vfr86ovZAElg6CMorgtd3Ynxby8cClcDLUnpePMiMX3EaPFlUICBLidrUJR4zzS1GAeSm5TJkgwKjyGPs7imwctcqZlmAx8wMWoIcSwV5QMgBUqdbJoZPz66y4dK5il3ATYDNC3G0RrTcvUPHyJnlm0+RMY8UZvulHZNYLrkkUmR8wMlCIrdL8kHcWOU9TBM5Mzgqy9d50bO5UTTKKq2wf8XuyNeBdz38ShznUSqniT66hxEqkfth5OZvsIa7kQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(1076003)(478600001)(83380400001)(6486002)(8936002)(2616005)(956004)(36756003)(4326008)(6916009)(8676002)(6666004)(186003)(2906002)(66946007)(44832011)(26005)(16526019)(86362001)(5660300002)(66476007)(7696005)(30864003)(316002)(52116002)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Q9YV4qZK3XV9z7iN6mEUEMA+wQlMm1Sh3mffYdIvG2A90r+ljYzpO5+ndAD+3V6fs9ziKzuEB39IyMXOnu7EfCCVa2G1dQ45+1kj0wg7hafNjqzT0kgDfc+Bb+1ta9xLfORttz0eT9By51JIj/jSbQf9uwKTlNh83iAP3wtghm/Td8g263n8ZUza4fWEzWZ3LiQDaczj8zDHiu3VIX36vTmTDBbnbGeZn/067XNLzXyPVcJNyKE+adZLCYZsH5NRlV2kd22LTaQq+r8Au9jQUyf+UlgphZabfyY2cTPxPfmMneX0nIp11Zl1/Yg2Ri7ftSE3J/RKkLCzk7Oe2fgHiL98J14qvMy+vf7/MBbkSl+T6rZzA0AXbo/Lfov/naP9SjHEjybjMbu1xeb8MoCMFv0fds/I+p2JYgU9m8RDKJFjTwUcMAdOKnoQO/GqTsTz0Wsrebkb37TVV0e3dQyIXHbrJcWFNcPitRAzUKAUzKs=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce25d26f-1b92-4747-3625-08d80916cd70
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 06:08:01.6487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLNsVvYniBSRwPncim98YnpeVI3jY5CGYNoR8X3ers0YqCU+Nb8/AD0VwhiPcKpu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332
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

Retrieve only those interested metrics data instead of the whole
metrics table. By this, the memory copy can be dropped.

Change-Id: Ice2b2ba4647301119130be0ba65bb587f19d38ae
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 213 ++++++++++++------
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  26 +++
 2 files changed, 174 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 05abfdedcf37..6f859a370c5f 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -906,17 +906,23 @@ static int arcturus_get_thermal_temperature_range(struct smu_context *smu,
 	return 0;
 }
 
-static int arcturus_get_metrics_table(struct smu_context *smu,
-				      SmuMetrics_t *metrics_table)
+static int arcturus_get_smu_metrics_data(struct smu_context *smu,
+					 MetricsMember_t member,
+					 uint32_t *value)
 {
 	struct smu_table_context *smu_table= &smu->smu_table;
+	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
 	int ret = 0;
 
 	mutex_lock(&smu->metrics_lock);
+
 	if (!smu_table->metrics_time ||
-	     time_after(jiffies, smu_table->metrics_time + HZ / 1000)) {
-		ret = smu_update_table(smu, SMU_TABLE_SMU_METRICS, 0,
-				(void *)smu_table->metrics_table, false);
+	     time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
+		ret = smu_update_table(smu,
+				       SMU_TABLE_SMU_METRICS,
+				       0,
+				       smu_table->metrics_table,
+				       false);
 		if (ret) {
 			pr_info("Failed to export SMU metrics table!\n");
 			mutex_unlock(&smu->metrics_lock);
@@ -925,7 +931,87 @@ static int arcturus_get_metrics_table(struct smu_context *smu,
 		smu_table->metrics_time = jiffies;
 	}
 
-	memcpy(metrics_table, smu_table->metrics_table, sizeof(SmuMetrics_t));
+	switch (member) {
+	case METRICS_CURR_GFXCLK:
+		*value = metrics->CurrClock[PPCLK_GFXCLK];
+		break;
+	case METRICS_CURR_SOCCLK:
+		*value = metrics->CurrClock[PPCLK_SOCCLK];
+		break;
+	case METRICS_CURR_UCLK:
+		*value = metrics->CurrClock[PPCLK_UCLK];
+		break;
+	case METRICS_CURR_VCLK:
+		*value = metrics->CurrClock[PPCLK_VCLK];
+		break;
+	case METRICS_CURR_DCLK:
+		*value = metrics->CurrClock[PPCLK_DCLK];
+		break;
+	case METRICS_CURR_FCLK:
+		*value = metrics->CurrClock[PPCLK_FCLK];
+		break;
+	case METRICS_AVERAGE_GFXCLK:
+		*value = metrics->AverageGfxclkFrequency;
+		break;
+	case METRICS_AVERAGE_SOCCLK:
+		*value = metrics->AverageSocclkFrequency;
+		break;
+	case METRICS_AVERAGE_UCLK:
+		*value = metrics->AverageUclkFrequency;
+		break;
+	case METRICS_AVERAGE_VCLK:
+		*value = metrics->AverageVclkFrequency;
+		break;
+	case METRICS_AVERAGE_DCLK:
+		*value = metrics->AverageDclkFrequency;
+		break;
+	case METRICS_AVERAGE_GFXACTIVITY:
+		*value = metrics->AverageGfxActivity;
+		break;
+	case METRICS_AVERAGE_MEMACTIVITY:
+		*value = metrics->AverageUclkActivity;
+		break;
+	case METRICS_AVERAGE_VCNACTIVITY:
+		*value = metrics->VcnActivityPercentage;
+		break;
+	case METRICS_AVERAGE_SOCKETPOWER:
+		*value = metrics->AverageSocketPower << 8;
+		break;
+	case METRICS_TEMPERATURE_EDGE:
+		*value = metrics->TemperatureEdge *
+			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_TEMPERATURE_HOTSPOT:
+		*value = metrics->TemperatureHotspot *
+			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_TEMPERATURE_MEM:
+		*value = metrics->TemperatureHBM *
+			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_TEMPERATURE_VRGFX:
+		*value = metrics->TemperatureVrGfx *
+			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_TEMPERATURE_VRSOC:
+		*value = metrics->TemperatureVrSoc *
+			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_TEMPERATURE_VRMEM:
+		*value = metrics->TemperatureVrMem *
+			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_THROTTLER_STATUS:
+		*value = metrics->ThrottlerStatus;
+		break;
+	case METRICS_CURR_FANSPEED:
+		*value = metrics->CurrFanSpeed;
+		break;
+	default:
+		*value = UINT_MAX;
+		break;
+	}
+
 	mutex_unlock(&smu->metrics_lock);
 
 	return ret;
@@ -935,81 +1021,71 @@ static int arcturus_get_current_activity_percent(struct smu_context *smu,
 						 enum amd_pp_sensors sensor,
 						 uint32_t *value)
 {
-	SmuMetrics_t metrics;
 	int ret = 0;
 
 	if (!value)
 		return -EINVAL;
 
-	ret = arcturus_get_metrics_table(smu, &metrics);
-	if (ret)
-		return ret;
-
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_GPU_LOAD:
-		*value = metrics.AverageGfxActivity;
+		ret = arcturus_get_smu_metrics_data(smu,
+						    METRICS_AVERAGE_GFXACTIVITY,
+						    value);
 		break;
 	case AMDGPU_PP_SENSOR_MEM_LOAD:
-		*value = metrics.AverageUclkActivity;
+		ret = arcturus_get_smu_metrics_data(smu,
+						    METRICS_AVERAGE_MEMACTIVITY,
+						    value);
 		break;
 	default:
 		pr_err("Invalid sensor for retrieving clock activity\n");
 		return -EINVAL;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int arcturus_get_gpu_power(struct smu_context *smu, uint32_t *value)
 {
-	SmuMetrics_t metrics;
-	int ret = 0;
-
 	if (!value)
 		return -EINVAL;
 
-	ret = arcturus_get_metrics_table(smu, &metrics);
-	if (ret)
-		return ret;
-
-	*value = metrics.AverageSocketPower << 8;
-
-	return 0;
+	return arcturus_get_smu_metrics_data(smu,
+					     METRICS_AVERAGE_SOCKETPOWER,
+					     value);
 }
 
 static int arcturus_thermal_get_temperature(struct smu_context *smu,
 					    enum amd_pp_sensors sensor,
 					    uint32_t *value)
 {
-	SmuMetrics_t metrics;
 	int ret = 0;
 
 	if (!value)
 		return -EINVAL;
 
-	ret = arcturus_get_metrics_table(smu, &metrics);
-	if (ret)
-		return ret;
-
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
-		*value = metrics.TemperatureHotspot *
-			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		ret = arcturus_get_smu_metrics_data(smu,
+						    METRICS_TEMPERATURE_HOTSPOT,
+						    value);
 		break;
 	case AMDGPU_PP_SENSOR_EDGE_TEMP:
-		*value = metrics.TemperatureEdge *
-			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		ret = arcturus_get_smu_metrics_data(smu,
+						    METRICS_TEMPERATURE_EDGE,
+						    value);
 		break;
 	case AMDGPU_PP_SENSOR_MEM_TEMP:
-		*value = metrics.TemperatureHBM *
-			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		ret = arcturus_get_smu_metrics_data(smu,
+						    METRICS_TEMPERATURE_MEM,
+						    value);
 		break;
 	default:
 		pr_err("Invalid sensor for retrieving temp\n");
 		return -EINVAL;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int arcturus_read_sensor(struct smu_context *smu,
@@ -1061,19 +1137,12 @@ static int arcturus_read_sensor(struct smu_context *smu,
 static int arcturus_get_fan_speed_rpm(struct smu_context *smu,
 				      uint32_t *speed)
 {
-	SmuMetrics_t metrics;
-	int ret = 0;
-
 	if (!speed)
 		return -EINVAL;
 
-	ret = arcturus_get_metrics_table(smu, &metrics);
-	if (ret)
-		return ret;
-
-	*speed = metrics.CurrFanSpeed;
-
-	return ret;
+	return arcturus_get_smu_metrics_data(smu,
+					     METRICS_CURR_FANSPEED,
+					     speed);
 }
 
 static int arcturus_get_fan_speed_percent(struct smu_context *smu,
@@ -1100,8 +1169,8 @@ static int arcturus_get_current_clk_freq_by_table(struct smu_context *smu,
 				       enum smu_clk_type clk_type,
 				       uint32_t *value)
 {
-	static SmuMetrics_t metrics;
-	int ret = 0, clk_id = 0;
+	MetricsMember_t member_type;
+	int clk_id = 0;
 
 	if (!value)
 		return -EINVAL;
@@ -1110,41 +1179,53 @@ static int arcturus_get_current_clk_freq_by_table(struct smu_context *smu,
 	if (clk_id < 0)
 		return -EINVAL;
 
-	ret = arcturus_get_metrics_table(smu, &metrics);
-	if (ret)
-		return ret;
-
 	switch (clk_id) {
 	case PPCLK_GFXCLK:
 		/*
 		 * CurrClock[clk_id] can provide accurate
 		 *   output only when the dpm feature is enabled.
 		 * We can use Average_* for dpm disabled case.
-		 *   But this is available for gfxclk/uclk/socclk.
+		 *   But this is available for gfxclk/uclk/socclk/vclk/dclk.
 		 */
 		if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT))
-			*value = metrics.CurrClock[PPCLK_GFXCLK];
+			member_type = METRICS_CURR_GFXCLK;
 		else
-			*value = metrics.AverageGfxclkFrequency;
+			member_type = METRICS_AVERAGE_GFXCLK;
 		break;
 	case PPCLK_UCLK:
 		if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT))
-			*value = metrics.CurrClock[PPCLK_UCLK];
+			member_type = METRICS_CURR_UCLK;
 		else
-			*value = metrics.AverageUclkFrequency;
+			member_type = METRICS_AVERAGE_UCLK;
 		break;
 	case PPCLK_SOCCLK:
 		if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT))
-			*value = metrics.CurrClock[PPCLK_SOCCLK];
+			member_type = METRICS_CURR_SOCCLK;
 		else
-			*value = metrics.AverageSocclkFrequency;
+			member_type = METRICS_AVERAGE_SOCCLK;
 		break;
-	default:
-		*value = metrics.CurrClock[clk_id];
+	case PPCLK_VCLK:
+		if (smu_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT))
+			member_type = METRICS_CURR_VCLK;
+		else
+			member_type = METRICS_AVERAGE_VCLK;
+		break;
+	case PPCLK_DCLK:
+		if (smu_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT))
+			member_type = METRICS_CURR_DCLK;
+		else
+			member_type = METRICS_AVERAGE_DCLK;
 		break;
+	case PPCLK_FCLK:
+		member_type = METRICS_CURR_FCLK;
+		break;
+	default:
+		return -EINVAL;
 	}
 
-	return ret;
+	return arcturus_get_smu_metrics_data(smu,
+					     member_type,
+					     value);
 }
 
 static uint32_t arcturus_find_lowest_dpm_level(struct arcturus_single_dpm_table *table)
@@ -2401,15 +2482,17 @@ static void arcturus_log_thermal_throttling_event(struct smu_context *smu)
 {
 	int throttler_idx, throtting_events = 0, buf_idx = 0;
 	struct amdgpu_device *adev = smu->adev;
-	SmuMetrics_t metrics;
+	uint32_t throttler_status;
 	char log_buf[256];
 
-	arcturus_get_metrics_table(smu, &metrics);
+	arcturus_get_smu_metrics_data(smu,
+				      METRICS_THROTTLER_STATUS,
+				      &throttler_status);
 
 	memset(log_buf, 0, sizeof(log_buf));
 	for (throttler_idx = 0; throttler_idx < ARRAY_SIZE(logging_label);
 	     throttler_idx++) {
-		if (metrics.ThrottlerStatus & logging_label[throttler_idx].feature_mask) {
+		if (throttler_status & logging_label[throttler_idx].feature_mask) {
 			throtting_events++;
 			buf_idx += snprintf(log_buf + buf_idx,
 					    sizeof(log_buf) - buf_idx,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 10234babfbbd..1bb07318efa6 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -574,6 +574,32 @@ struct pptable_funcs {
 	void (*log_thermal_throttling_event)(struct smu_context *smu);
 };
 
+typedef enum {
+	METRICS_CURR_GFXCLK,
+	METRICS_CURR_SOCCLK,
+	METRICS_CURR_UCLK,
+	METRICS_CURR_VCLK,
+	METRICS_CURR_DCLK,
+	METRICS_CURR_FCLK,
+	METRICS_AVERAGE_GFXCLK,
+	METRICS_AVERAGE_SOCCLK,
+	METRICS_AVERAGE_UCLK,
+	METRICS_AVERAGE_VCLK,
+	METRICS_AVERAGE_DCLK,
+	METRICS_AVERAGE_GFXACTIVITY,
+	METRICS_AVERAGE_MEMACTIVITY,
+	METRICS_AVERAGE_VCNACTIVITY,
+	METRICS_AVERAGE_SOCKETPOWER,
+	METRICS_TEMPERATURE_EDGE,
+	METRICS_TEMPERATURE_HOTSPOT,
+	METRICS_TEMPERATURE_MEM,
+	METRICS_TEMPERATURE_VRGFX,
+	METRICS_TEMPERATURE_VRSOC,
+	METRICS_TEMPERATURE_VRMEM,
+	METRICS_THROTTLER_STATUS,
+	METRICS_CURR_FANSPEED,
+} MetricsMember_t;
+
 int smu_load_microcode(struct smu_context *smu);
 
 int smu_check_fw_status(struct smu_context *smu);
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
