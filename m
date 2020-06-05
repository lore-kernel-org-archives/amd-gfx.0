Return-Path: <SRS0=/kPV=7S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73112C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 06:08:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A00207ED
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 06:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DdUX7l8V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A00207ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F38E26E83F;
	Fri,  5 Jun 2020 06:08:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CF096E83F
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2020 06:08:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2PKjZQAHhKYpBdRuBmlO/6UjI08QoSkJEaVwPnHPwsJ5QLbTF1xD5SzHtq5c+Q3Ev+qQqP56z/GX3ZzO7zFHKe+QY/oVdy1ZMr2BI8Hojgbysr+jzOtfqnQGrdkeod8CWanui8Cz+xFK+3oRGbZoNQl1vINGS7AZRbikG2lkUY83upwjBpa78lrohdxBeFKHlJS8kV+Ny5psBRX59TkNKITrnQZlslQ+AUvhY/nLyKXfvihCEJG7yERJnRgbGDtdf2GsH6EbL5P/d6U9egyuD3DJlFC/TxMl88d4weGUW90OEBzmzQfVtd6/8Ncs2rnbKhdygyf79U+V75KRBtCyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zk81jVguTWdpYYmcu8TwefUpI1teCkEr3h4mAM6omug=;
 b=h8ts65bf6H7cc7jRhK2ewnK3tv8rICkuN1NDZ9mzmXf0LL5JeH7ajprLK7fLra9nbP/2oC8gn2O0FMp81Zw22uGGPot1opOt6wy4lKGAlUxYjddm2btOQtmFlO63b7B7EfRwYBQz7SIKPS9WJK32WAvAwjBICh/bqLpst+8q8difjdIGl6h/ZBRUhRTBn3iQcAd/fh9ta02I3vL6IIe2BD83Rbd2FPTXfnTip9l+1tdL7COcnO7lSpoN6PDhn5OBTwoUp4MjHC6ka7fgYFjh94EkwWDqomL7bW/kS4gXs9oMGdoze22tWuyQBFXXeRjyz2x4Lyt5jOvhGkj7bqhOfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zk81jVguTWdpYYmcu8TwefUpI1teCkEr3h4mAM6omug=;
 b=DdUX7l8VXqLmQpOLtS8OG+qzmhrLNfLWbLrKO1oljwuFpD/WIg7hvw3F7b7Tpsy915V49woBWtYYfsuoi5c0u1yWCIiRUU5WFSiCeqvp38zw51Hn6F9G80QVe0g5RAuzWtWYQHGOvGpOCjWjaZIuNKKzAl5kw+emKOSn0Ny3Ffc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Fri, 5 Jun 2020 06:08:05 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Fri, 5 Jun 2020
 06:08:05 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amd/powerplay: update how to use metrics table on
 Navi10
Date: Fri,  5 Jun 2020 14:07:38 +0800
Message-Id: <20200605060741.5280-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200605060741.5280-1-evan.quan@amd.com>
References: <20200605060741.5280-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR04CA0046.apcprd04.prod.outlook.com
 (2603:1096:202:14::14) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0046.apcprd04.prod.outlook.com (2603:1096:202:14::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 06:08:03 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5e77fdba-7ba4-450f-3f78-08d80916cf91
X-MS-TrafficTypeDiagnostic: DM6PR12MB4332:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43321A1A36D71EF43ADDCDFAE4860@DM6PR12MB4332.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZcHRpiMxdybjgp5u5zfEY2dXi3SY6ufEQfvWxp6JYM6zvTVgPEfJHcZWl5smrrNnx5h+Fjnp6NDiG76chpsbJ2ZWG8IcUf6XCgHFmIrni5BqXdRTUlaFJnWlZL1Fb0iB/POFsenAGFRYmbIHSu1I/9LMrWDbYGIGmf1rp+h0ez1q+MnHRwnKL7sCfpYfc5OSF1YDo2awGFUIT7uz4Lgsi0Y3BZiEatEnUxCA7u7mkxUkj+DU6jvxQJMqhZ8f5r5p9obszkgn3oXlBE9xc7jSL7pXxfWllAMuENbbhZjObngNObwA+GJTCIAi/AP/iVmtFRPg/Oejve8FbDJM61WWQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(1076003)(478600001)(83380400001)(6486002)(8936002)(2616005)(956004)(36756003)(4326008)(6916009)(8676002)(6666004)(186003)(2906002)(66946007)(44832011)(26005)(16526019)(86362001)(5660300002)(66476007)(7696005)(316002)(52116002)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: S7bG6hqrrW9pXZgvr7Ltz7RaJFOvHWXCQDbm6YpA60HnxZAj6s+f6/GXGi5n6OygmfjbMSCJoxji6DdfYHH2WZMoJt/48aOjahAqnfBx4/GdmjtzP7ODWcA11/P3UawebG87KPP8r/ro3cTxSfIUXqC4fTtyocCCzf7DhkwYZQXA6TwNgLkNpALdf/ZZr8QNX7Gn6AYUPXgJzuWDe0Fs7U7RDcP2Jt4OUtmsQmMKTx/RjJlVRXS910Bzp/6CUEbJTE1g6JuvnJ1bl3b8i/bLQEvw5LtA9pTUzgYdElA5O6P73SrnKBZjkgZ6twPv+jrIpAim1IwZLQbfOHRrt1z0iKfQuKkwmHRb+gsar/IO6MrSeSGxvrlkyixYEfm/t6GDfJ5N+yqmWwCszSE1muoFNezHIXQ88i6Lcapvegq9PpIrrHEmma+IUHs9GBA+26s9XXd6gtpY2Jv3GECpTOhgVez3EA3Ht8E/uysQok+0aWDqKLrV3bKYkc6/568p+98A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e77fdba-7ba4-450f-3f78-08d80916cf91
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 06:08:05.2056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWcwuvYdUXwPJ3gqRk0/I4+U6iUGwtr2euy9yzISA31wLDh3Q4gX0oKUD99Jl/tX
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

Retrieve only those data interested instead of the whole table.

Change-Id: I78a3ecce1075e73b96c2ee0b13aacc469bb09021
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |   1 +
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 180 ++++++++++++------
 2 files changed, 127 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 1bb07318efa6..7b5ec748b006 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -581,6 +581,7 @@ typedef enum {
 	METRICS_CURR_VCLK,
 	METRICS_CURR_DCLK,
 	METRICS_CURR_FCLK,
+	METRICS_CURR_DCEFCLK,
 	METRICS_AVERAGE_GFXCLK,
 	METRICS_AVERAGE_SOCCLK,
 	METRICS_AVERAGE_UCLK,
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 8dd916a8e8f8..25653f5f8d16 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -561,16 +561,22 @@ static int navi10_tables_init(struct smu_context *smu, struct smu_table *tables)
 	return 0;
 }
 
-static int navi10_get_metrics_table(struct smu_context *smu,
-				    SmuMetrics_t *metrics_table)
+static int navi10_get_smu_metrics_data(struct smu_context *smu,
+				       MetricsMember_t member,
+				       uint32_t *value)
 {
 	struct smu_table_context *smu_table= &smu->smu_table;
+	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
 	int ret = 0;
 
 	mutex_lock(&smu->metrics_lock);
-	if (!smu_table->metrics_time || time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(100))) {
-		ret = smu_update_table(smu, SMU_TABLE_SMU_METRICS, 0,
-				(void *)smu_table->metrics_table, false);
+	if (!smu_table->metrics_time ||
+	     time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(100))) {
+		ret = smu_update_table(smu,
+				       SMU_TABLE_SMU_METRICS,
+				       0,
+				       smu_table->metrics_table,
+				       false);
 		if (ret) {
 			pr_info("Failed to export SMU metrics table!\n");
 			mutex_unlock(&smu->metrics_lock);
@@ -579,7 +585,71 @@ static int navi10_get_metrics_table(struct smu_context *smu,
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
+	case METRICS_AVERAGE_GFXCLK:
+		*value = metrics->AverageGfxclkFrequency;
+		break;
+	case METRICS_AVERAGE_SOCCLK:
+		*value = metrics->AverageSocclkFrequency;
+		break;
+	case METRICS_AVERAGE_UCLK:
+		*value = metrics->AverageUclkFrequency;
+		break;
+	case METRICS_AVERAGE_GFXACTIVITY:
+		*value = metrics->AverageGfxActivity;
+		break;
+	case METRICS_AVERAGE_MEMACTIVITY:
+		*value = metrics->AverageUclkActivity;
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
+		*value = metrics->TemperatureMem *
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
@@ -702,20 +772,39 @@ static int navi10_get_current_clk_freq_by_table(struct smu_context *smu,
 				       enum smu_clk_type clk_type,
 				       uint32_t *value)
 {
-	int ret = 0, clk_id = 0;
-	SmuMetrics_t metrics;
-
-	ret = navi10_get_metrics_table(smu, &metrics);
-	if (ret)
-		return ret;
+	MetricsMember_t member_type;
+	int clk_id = 0;
 
 	clk_id = smu_clk_get_index(smu, clk_type);
 	if (clk_id < 0)
 		return clk_id;
 
-	*value = metrics.CurrClock[clk_id];
+	switch (clk_id) {
+	case PPCLK_GFXCLK:
+		member_type = METRICS_CURR_GFXCLK;
+		break;
+	case PPCLK_UCLK:
+		member_type = METRICS_CURR_UCLK;
+		break;
+	case PPCLK_SOCCLK:
+		member_type = METRICS_CURR_SOCCLK;
+		break;
+	case PPCLK_VCLK:
+		member_type = METRICS_CURR_VCLK;
+		break;
+	case PPCLK_DCLK:
+		member_type = METRICS_CURR_DCLK;
+		break;
+	case PPCLK_DCEFCLK:
+		member_type = METRICS_CURR_DCEFCLK;
+		break;
+	default:
+		return -EINVAL;
+	}
 
-	return ret;
+	return navi10_get_smu_metrics_data(smu,
+					   member_type,
+					   value);
 }
 
 static bool navi10_is_support_fine_grained_dpm(struct smu_context *smu, enum smu_clk_type clk_type)
@@ -1125,19 +1214,12 @@ static int navi10_unforce_dpm_levels(struct smu_context *smu)
 
 static int navi10_get_gpu_power(struct smu_context *smu, uint32_t *value)
 {
-	int ret = 0;
-	SmuMetrics_t metrics;
-
 	if (!value)
 		return -EINVAL;
 
-	ret = navi10_get_metrics_table(smu, &metrics);
-	if (ret)
-		return ret;
-
-	*value = metrics.AverageSocketPower << 8;
-
-	return 0;
+	return navi10_get_smu_metrics_data(smu,
+					   METRICS_AVERAGE_SOCKETPOWER,
+					   value);
 }
 
 static int navi10_get_current_activity_percent(struct smu_context *smu,
@@ -1145,28 +1227,27 @@ static int navi10_get_current_activity_percent(struct smu_context *smu,
 					       uint32_t *value)
 {
 	int ret = 0;
-	SmuMetrics_t metrics;
 
 	if (!value)
 		return -EINVAL;
 
-	ret = navi10_get_metrics_table(smu, &metrics);
-	if (ret)
-		return ret;
-
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_GPU_LOAD:
-		*value = metrics.AverageGfxActivity;
+		ret = navi10_get_smu_metrics_data(smu,
+						  METRICS_AVERAGE_GFXACTIVITY,
+						  value);
 		break;
 	case AMDGPU_PP_SENSOR_MEM_LOAD:
-		*value = metrics.AverageUclkActivity;
+		ret = navi10_get_smu_metrics_data(smu,
+						  METRICS_AVERAGE_MEMACTIVITY,
+						  value);
 		break;
 	default:
 		pr_err("Invalid sensor for retrieving clock activity\n");
 		return -EINVAL;
 	}
 
-	return 0;
+	return ret;
 }
 
 static bool navi10_is_dpm_running(struct smu_context *smu)
@@ -1183,19 +1264,12 @@ static bool navi10_is_dpm_running(struct smu_context *smu)
 static int navi10_get_fan_speed_rpm(struct smu_context *smu,
 				    uint32_t *speed)
 {
-	SmuMetrics_t metrics;
-	int ret = 0;
-
 	if (!speed)
 		return -EINVAL;
 
-	ret = navi10_get_metrics_table(smu, &metrics);
-	if (ret)
-		return ret;
-
-	*speed = metrics.CurrFanSpeed;
-
-	return ret;
+	return navi10_get_smu_metrics_data(smu,
+					   METRICS_CURR_FANSPEED,
+					   speed);
 }
 
 static int navi10_get_fan_speed_percent(struct smu_context *smu,
@@ -1550,35 +1624,33 @@ static int navi10_thermal_get_temperature(struct smu_context *smu,
 					     enum amd_pp_sensors sensor,
 					     uint32_t *value)
 {
-	SmuMetrics_t metrics;
 	int ret = 0;
 
 	if (!value)
 		return -EINVAL;
 
-	ret = navi10_get_metrics_table(smu, &metrics);
-	if (ret)
-		return ret;
-
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
-		*value = metrics.TemperatureHotspot *
-			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		ret = navi10_get_smu_metrics_data(smu,
+						  METRICS_TEMPERATURE_HOTSPOT,
+						  value);
 		break;
 	case AMDGPU_PP_SENSOR_EDGE_TEMP:
-		*value = metrics.TemperatureEdge *
-			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		ret = navi10_get_smu_metrics_data(smu,
+						  METRICS_TEMPERATURE_EDGE,
+						  value);
 		break;
 	case AMDGPU_PP_SENSOR_MEM_TEMP:
-		*value = metrics.TemperatureMem *
-			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		ret = navi10_get_smu_metrics_data(smu,
+						  METRICS_TEMPERATURE_MEM,
+						  value);
 		break;
 	default:
 		pr_err("Invalid sensor for retrieving temp\n");
 		return -EINVAL;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int navi10_read_sensor(struct smu_context *smu,
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
