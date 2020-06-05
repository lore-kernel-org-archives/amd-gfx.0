Return-Path: <SRS0=/kPV=7S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45545C433E1
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 06:08:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 158FD207ED
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 06:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nDe1R3MX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158FD207ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B0FD6E843;
	Fri,  5 Jun 2020 06:08:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B15056E842
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2020 06:08:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+2qtkvu91gdJl7IQPOfJaoFFOvks0vwLgFlqHFJQ//6y+aTcsZpd8TcGuc4nn2q5QHLAFiVw/2iCEck6ijywRyieLQzQinUQL8hHvgo5rsUvkcMGE+Upe9c8htoOew//P4NlbfeLgeYs6HU4Pprk30qlC+4YZRc8CRPap+RsRrakMxlC63mqs6jLz0U1EiKIr9hBAzPLWaQrUzLE35OEgrj/fH0uNd7u8YG/ARV80t8m4bgTH9Kn3SFgCiCdQc7xshC5qIq4aW7AzOp9yytLfdUZdFyWmqnypuZD4Pv+yjBWoPfJLnGWFTLQvEB12/RwAAg4TNi+rOaU/+4w/00Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNz3rvEVtTjzMfa+U3S9S6Cb/2DC/yTdk280Au+Dvco=;
 b=m1Rrn0ppBWCb+71+id3YYZOyBtw+F2GX0XWSkQB+2xYJOsqtwoPEAfXypDv/Ror40FtDKneg7GN5eLYk035ckQAoEUN4vwOJF2k0FpAsEXfYsZFg8+XsYl6QIaCZboj/eDu3S6kplfT6ZC7CaV+nv7aob7RZ9L0f2D6nYajQwQihW6Ph1RzgE5myC+KN6UEH/OQc1wxRDdUy5LXxB8fb92o7b9cjgHh6rv/8OSZrW/SQY/N+nhwPcOlBc3grIAV8cMUFyMq9+RdZq9YjhMLizUQJ0zD2XILRZYgL5MTRTC1xkcWeeHRw+5CrttRuTqFLjRNAlkrohP2qYRUwimZDjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNz3rvEVtTjzMfa+U3S9S6Cb/2DC/yTdk280Au+Dvco=;
 b=nDe1R3MXDDZZ2pf86j7IF18saYWFVw5xgRbo8+rhymshjHKFzOX4k0qp+DStcFn68yaSv6j0FGAQHE88ZO6PoT9thn18YKBmpHbj8NyG1h5Z/8q1EG8HAL+YKpWDjsueKR1OBZvon3YUGtE3C2NEsgtYzNszO5UKVQE6jrmYmsk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Fri, 5 Jun 2020 06:08:08 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Fri, 5 Jun 2020
 06:08:08 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amd/powerplay: update how to use metrics table on
 Sienna Cichlid
Date: Fri,  5 Jun 2020 14:07:39 +0800
Message-Id: <20200605060741.5280-3-evan.quan@amd.com>
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
 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 06:08:07 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 35f9cb3f-6692-4aa7-8f2d-08d80916d1a4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4332:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB433203C320670F83F627622FE4860@DM6PR12MB4332.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 17Iz4p1XY2czru9qKbkQf4eraKGVQewLUz6MtRTBcZJ/EXqEOQ1z3HfDY9ED8HK/+IHiK2Llq+QHSjz8T8juZp4nmAtu2ulbmWJjiAJBX3N8d9pwU/+Z5cWjGfG4yfhdvb1MfiT8hacsjnFB3TKp55uufCvmRpQriggkxJyiVQLR48vnohApwqo2k2foGiEgQJ5PRcJiME1QM5csThC4rB099nrjnZtVsN3FGMGsXom3fDM26xjfWFQsksTVnUliraCjy+D1gdV9i/fC4F2GwPywVWnGafnKNF8o4HPmE9/D64v/G7OW/dFsx++Lb/ExrtVoosK03Gkj6UE4Lp/MuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(1076003)(478600001)(83380400001)(6486002)(8936002)(2616005)(956004)(36756003)(4326008)(6916009)(8676002)(6666004)(186003)(2906002)(66946007)(44832011)(26005)(16526019)(86362001)(5660300002)(66476007)(7696005)(316002)(52116002)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: WxmUzkg6FyX3LimrwszpD2eeIjbdiI9HWVnm0m3vx4ffNwskEAuwG6mmLlbtuG0JLSbHWuVpInxfIsnw8bqIzMqyQBHFTCANJ1Ii5rolfJH2piskas0X4hRinOE+1SJcAs8u0iHb9IOttLoQvaQSsXn8mSdMTeXrUqZngGi4Krl7nRKZhuA+xaFjj7IlYi7AaGo4Ll68eIJrMPX+weccYX7VQsVtFVLUEeah2wuhY2u3KPwwlVifQlVvZTJuN/BVuZWYxMO72X3DcTG46Qi5FtTautCUYyP216+c+wYunQ8X44YiOdRG8hP4VXH6GCoRVLMvKwTcX8xGGAbIgLHL69Tpq0ynMfA4TK5NDfCzkawPkttQ98luPg4gVKRZ9MOwst/ZGvGCBm+lA4nkR77fZldIYYvGC+/hdbbqZkFXhR7ZDECjuDvj6pmYvy8wOFtsl+MRgtEY+xRLNHxBvec6XctJUD08rugFjpfgoFryKn4Tg0dTB6stB2ft05LA4Kg1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f9cb3f-6692-4aa7-8f2d-08d80916d1a4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 06:08:08.7406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BeUP3senSQ0AR665HaX1qOdrlTnlW9z9JwFmk2x1ffNBkmbjKv+Y3myYKXKcVa54
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

Change-Id: I6008351209be3b8812c547043a532e5fb90dd980
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |   3 +
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 197 +++++++++++++-----
 2 files changed, 146 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 7b5ec748b006..79599c0825c3 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -579,11 +579,14 @@ typedef enum {
 	METRICS_CURR_SOCCLK,
 	METRICS_CURR_UCLK,
 	METRICS_CURR_VCLK,
+	METRICS_CURR_VCLK1,
 	METRICS_CURR_DCLK,
+	METRICS_CURR_DCLK1,
 	METRICS_CURR_FCLK,
 	METRICS_CURR_DCEFCLK,
 	METRICS_AVERAGE_GFXCLK,
 	METRICS_AVERAGE_SOCCLK,
+	METRICS_AVERAGE_FCLK,
 	METRICS_AVERAGE_UCLK,
 	METRICS_AVERAGE_VCLK,
 	METRICS_AVERAGE_DCLK,
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index d637fc4b72ac..13ec103575f9 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -547,16 +547,22 @@ static int sienna_cichlid_tables_init(struct smu_context *smu, struct smu_table
 	return 0;
 }
 
-static int sienna_cichlid_get_metrics_table(struct smu_context *smu,
-				    SmuMetrics_t *metrics_table)
+static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
+					       MetricsMember_t member,
+					       uint32_t *value)
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
@@ -565,10 +571,81 @@ static int sienna_cichlid_get_metrics_table(struct smu_context *smu,
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
+		*value = metrics->CurrClock[PPCLK_VCLK_0];
+		break;
+	case METRICS_CURR_VCLK1:
+		*value = metrics->CurrClock[PPCLK_VCLK_1];
+		break;
+	case METRICS_CURR_DCLK:
+		*value = metrics->CurrClock[PPCLK_DCLK_0];
+		break;
+	case METRICS_CURR_DCLK1:
+		*value = metrics->CurrClock[PPCLK_DCLK_1];
+		break;
+	case METRICS_AVERAGE_GFXCLK:
+		*value = metrics->AverageGfxclkFrequency;
+		break;
+	case METRICS_AVERAGE_FCLK:
+		*value = metrics->AverageFclkFrequency;
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
+
 }
 
 static int sienna_cichlid_allocate_dpm_context(struct smu_context *smu)
@@ -694,20 +771,49 @@ static int sienna_cichlid_get_current_clk_freq_by_table(struct smu_context *smu,
 				       enum smu_clk_type clk_type,
 				       uint32_t *value)
 {
-	int ret = 0, clk_id = 0;
-	SmuMetrics_t metrics;
-
-	ret = sienna_cichlid_get_metrics_table(smu, &metrics);
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
+	case PPCLK_FCLK:
+		member_type = METRICS_CURR_FCLK;
+		break;
+	case PPCLK_VCLK_0:
+		member_type = METRICS_CURR_VCLK;
+		break;
+	case PPCLK_VCLK_1:
+		member_type = METRICS_CURR_VCLK1;
+		break;
+	case PPCLK_DCLK_0:
+		member_type = METRICS_CURR_DCLK;
+		break;
+	case PPCLK_DCLK_1:
+		member_type = METRICS_CURR_DCLK1;
+		break;
+	case PPCLK_DCEFCLK:
+		member_type = METRICS_CURR_DCEFCLK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return sienna_cichlid_get_smu_metrics_data(smu,
+						   member_type,
+						   value);
 
-	return ret;
 }
 
 static bool sienna_cichlid_is_support_fine_grained_dpm(struct smu_context *smu, enum smu_clk_type clk_type)
@@ -994,19 +1100,12 @@ static int sienna_cichlid_unforce_dpm_levels(struct smu_context *smu)
 
 static int sienna_cichlid_get_gpu_power(struct smu_context *smu, uint32_t *value)
 {
-	int ret = 0;
-	SmuMetrics_t metrics;
-
 	if (!value)
 		return -EINVAL;
 
-	ret = sienna_cichlid_get_metrics_table(smu, &metrics);
-	if (ret)
-		return ret;
-
-	*value = metrics.AverageSocketPower << 8;
-
-	return 0;
+	return sienna_cichlid_get_smu_metrics_data(smu,
+						   METRICS_AVERAGE_SOCKETPOWER,
+						   value);
 }
 
 static int sienna_cichlid_get_current_activity_percent(struct smu_context *smu,
@@ -1014,28 +1113,27 @@ static int sienna_cichlid_get_current_activity_percent(struct smu_context *smu,
 					       uint32_t *value)
 {
 	int ret = 0;
-	SmuMetrics_t metrics;
 
 	if (!value)
 		return -EINVAL;
 
-	ret = sienna_cichlid_get_metrics_table(smu, &metrics);
-	if (ret)
-		return ret;
-
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_GPU_LOAD:
-		*value = metrics.AverageGfxActivity;
+		ret = sienna_cichlid_get_smu_metrics_data(smu,
+							  METRICS_AVERAGE_GFXACTIVITY,
+							  value);
 		break;
 	case AMDGPU_PP_SENSOR_MEM_LOAD:
-		*value = metrics.AverageUclkActivity;
+		ret = sienna_cichlid_get_smu_metrics_data(smu,
+							  METRICS_AVERAGE_MEMACTIVITY,
+							  value);
 		break;
 	default:
 		pr_err("Invalid sensor for retrieving clock activity\n");
 		return -EINVAL;
 	}
 
-	return 0;
+	return ret;
 }
 
 static bool sienna_cichlid_is_dpm_running(struct smu_context *smu)
@@ -1052,19 +1150,12 @@ static bool sienna_cichlid_is_dpm_running(struct smu_context *smu)
 static int sienna_cichlid_get_fan_speed_rpm(struct smu_context *smu,
 				    uint32_t *speed)
 {
-	SmuMetrics_t metrics;
-	int ret = 0;
-
 	if (!speed)
 		return -EINVAL;
 
-	ret = sienna_cichlid_get_metrics_table(smu, &metrics);
-	if (ret)
-		return ret;
-
-	*speed = metrics.CurrFanSpeed;
-
-	return ret;
+	return sienna_cichlid_get_smu_metrics_data(smu,
+						   METRICS_CURR_FANSPEED,
+						   speed);
 }
 
 static int sienna_cichlid_get_fan_speed_percent(struct smu_context *smu,
@@ -1421,35 +1512,33 @@ static int sienna_cichlid_thermal_get_temperature(struct smu_context *smu,
 					     enum amd_pp_sensors sensor,
 					     uint32_t *value)
 {
-	SmuMetrics_t metrics;
 	int ret = 0;
 
 	if (!value)
 		return -EINVAL;
 
-	ret = sienna_cichlid_get_metrics_table(smu, &metrics);
-	if (ret)
-		return ret;
-
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
-		*value = metrics.TemperatureHotspot *
-			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		ret = sienna_cichlid_get_smu_metrics_data(smu,
+							  METRICS_TEMPERATURE_HOTSPOT,
+							  value);
 		break;
 	case AMDGPU_PP_SENSOR_EDGE_TEMP:
-		*value = metrics.TemperatureEdge *
-			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		ret = sienna_cichlid_get_smu_metrics_data(smu,
+							  METRICS_TEMPERATURE_EDGE,
+							  value);
 		break;
 	case AMDGPU_PP_SENSOR_MEM_TEMP:
-		*value = metrics.TemperatureMem *
-			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		ret = sienna_cichlid_get_smu_metrics_data(smu,
+							  METRICS_TEMPERATURE_MEM,
+							  value);
 		break;
 	default:
 		pr_err("Invalid sensor for retrieving temp\n");
 		return -EINVAL;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int sienna_cichlid_read_sensor(struct smu_context *smu,
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
