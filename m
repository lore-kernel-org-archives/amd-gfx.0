Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE9EC07E9C
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 06:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28F916194E
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 06:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F916194E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8603B89823;
	Tue,  6 Jul 2021 06:46:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB4E2897F9
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jul 2021 06:46:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFcELEWy2ijVYAFToGrDM/k53KlLY+Sn+eekGcr9eK+hZPPdlUUlLdsWqQDw28/CbYawCYtjbF6zXV8srYgUkfaLLuUR2DFgkFUcsGoZiqZ7VMv23P3CZDKvknWRjdxEFOhInuNb9Cyxv+XLGuJ7QlYTv8+nazYYhHaiLe3t6brMGwP0m1cL8wm79A7EfKxc8Lgc1n3c4lpk1E6W/JqSigvwNG2suU+tO8dquiKX1TmgALGxy48ZzThCoWFQ9IOR6viaSXe6nUVNRvUytKjwAGnen2JJads0cbEB2H7C52uzqkLPjuJN8tYv7YTkh+Yb+rxRcNSc1taqLJoXP9wTkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vObakdBcJBqW++O9Rng2X6AkBcpdIhkVC5tVmfD0Lk=;
 b=I5zjwo2AsIqqEWDvKts41oZNyi5OJmA/diXIKorQGY2WVWRLZNQx5+6OVONm84eD7szHv8cBlNQ3Ejl7eCGMQA1iJQhXI2FWzGlRIn75a9cfBm7hu+MnWdOkDU/dgNWjaV1ygdJh7GGQG1xoWqHpk69wNMpuFWczcsPrDoTKtssTYU4gXX8P84qLQIzLRPtVtz3IhCXB4QWCWZvrVWs4aH4BvwVl5eRSRaIRvUzsyiWPJhpi7IuV1eX/NIBl0GYmthrtFFT2O12jB9mmXp/zC3jDUi3JEjinYgXXI6d4TpYiZPkpbrMVtzSyaOQZoQSqLGVSIc3bZF1ofjc4uiiLTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vObakdBcJBqW++O9Rng2X6AkBcpdIhkVC5tVmfD0Lk=;
 b=mjwNyZoYCV6xHLwWgp4K3WzE2svyzPNV2/S0OB8r9RbAKgeGOKGoJBrPyh6JAZ0l6OD98h7wu4LgYIgkFW0sed1/g59F7WUCveHwG7GBpAxSFI8xUQDoRO78TdC8ZEqvJVZm0VD+NSV4ibBMIHgIvgn6IpoffFcse931S6kThpY=
Received: from DM5PR19CA0061.namprd19.prod.outlook.com (2603:10b6:3:116::23)
 by BYAPR12MB2679.namprd12.prod.outlook.com (2603:10b6:a03:72::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Tue, 6 Jul
 2021 06:46:01 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::30) by DM5PR19CA0061.outlook.office365.com
 (2603:10b6:3:116::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Tue, 6 Jul 2021 06:46:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Tue, 6 Jul 2021 06:46:00 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 6 Jul 2021
 01:45:58 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 2/3] drm/amd/pm: update the gpu metrics data retrieving for
 Sienna Cichlid
Date: Tue, 6 Jul 2021 14:45:35 +0800
Message-ID: <20210706064536.123524-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210706064536.123524-1-evan.quan@amd.com>
References: <20210706064536.123524-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 817eda46-979f-4c6b-2c4f-08d94049b7d0
X-MS-TrafficTypeDiagnostic: BYAPR12MB2679:
X-Microsoft-Antispam-PRVS: <BYAPR12MB26797C3696E47A83B16B2932E41B9@BYAPR12MB2679.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wh+wl94yLtrXJtPaBY1XhRCC7JyaqfukNpsDhiSxdG19vqL7eRBHvCRTbL2qQcW6laxXZLIp94mvF7KuR6ErAwQJvCCdJ1SuciEdxaVeTqSACAFjvRTabHRhWApCjhAUqACV4tWxu4GxM+5KnV6SvlzOv4Vm+rK/3xi9h6GnDk7gorSVeje5qGRzMYs2dT1HAc3q/Q8BXRsnVq9J4dqyugF/lrVgu9yButysQYFlI8YV18zI2illbUgJ/Nli1ybzzhA/5wBf9bsiR7SQng7hRu+tX7ZVYAOwFK/lkpPRzAho/DT9/XDVxosmaQiYbqvvZZ2OZxBp7W39jruXfZB2bCsAWSpzNKVmIagLnmF7UGYbljvh62cwtvQkgnBQ18xybuqD8pMDu7FGAxUcCKk8XtCFZucdzDJ+DtGON+oNXLnygaE2ata5Efz1kxPLlpRCSMgzTp8kTk1IgUnqPaq0ckZaYw1KOQUHbRDomglvc5MeaxOvkQrMjJ2VDMfbGfX7+RuKbn6SsaVg2uqeyDKp4GhzdvW3fjF88qA0CQPPIH0pu0vQbxMIxvlib28pfQi8//uFGcJgaSpDdyvE11EB4eaPPp+RIYQHLbmhIMR/GTOwH/cy7mcXHMcj3/iJsA5Bg7dhI9kjue/IceGkz9KElc5cbUfj63v7TPxbALYyG7gnSDSX+Bpy5mH138Ic6Lm0KODfF7c+fPUKuxCI8wtfDiLvFbzyyZlqEKtIKVN4ye8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(36840700001)(46966006)(316002)(7696005)(2906002)(15650500001)(6916009)(478600001)(70206006)(5660300002)(54906003)(186003)(16526019)(8936002)(8676002)(26005)(336012)(426003)(86362001)(1076003)(4326008)(83380400001)(82310400003)(44832011)(30864003)(356005)(82740400003)(6666004)(47076005)(36756003)(2616005)(81166007)(36860700001)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2021 06:46:00.9290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 817eda46-979f-4c6b-2c4f-08d94049b7d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2679
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Due to the structure layout change: "uint32_t ThrottlerStatus" -> "
uint8_t  ThrottlingPercentage[THROTTLER_COUNT]".

Change-Id: I5ea15c1ea5152e480f4e379193c5848bf2b85dd4
Signed-off-by: Evan Quan <evan.quan@amd.com>
--
V1->V2:
  - update the way for handling the new Metrics structure(Lijo)
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 216 ++++++++++++------
 1 file changed, 145 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index fb5b3ea61273..83d8e53ca1f8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -489,6 +489,26 @@ static int sienna_cichlid_tables_init(struct smu_context *smu)
 	return -ENOMEM;
 }
 
+static uint32_t sienna_cichlid_get_throttler_status_locked(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table= &smu->smu_table;
+	SmuMetricsExternal_t *metrics_ext =
+		(SmuMetricsExternal_t *)(smu_table->metrics_table);
+	uint32_t throttler_status = 0;
+	int i;
+
+	if ((smu->adev->asic_type == CHIP_SIENNA_CICHLID) &&
+	     (smu->smc_fw_version >= 0x3A4300)) {
+		for (i = 0; i < THROTTLER_COUNT; i++)
+			throttler_status |=
+				(metrics_ext->SmuMetrics_V2.ThrottlingPercentage[i] ? 1U << i : 0);
+	} else {
+		throttler_status = metrics_ext->SmuMetrics.ThrottlerStatus;
+	}
+
+	return throttler_status;
+}
+
 static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 					       MetricsMember_t member,
 					       uint32_t *value)
@@ -496,6 +516,11 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 	struct smu_table_context *smu_table= &smu->smu_table;
 	SmuMetrics_t *metrics =
 		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))->SmuMetrics);
+	SmuMetrics_V2_t *metrics_v2 =
+		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))->SmuMetrics_V2);
+	bool use_metrics_v2 = ((smu->adev->asic_type == CHIP_SIENNA_CICHLID) &&
+		(smu->smc_fw_version >= 0x3A4300)) ? true : false;
+	uint16_t average_gfx_activity;
 	int ret = 0;
 
 	mutex_lock(&smu->metrics_lock);
@@ -510,78 +535,96 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 
 	switch (member) {
 	case METRICS_CURR_GFXCLK:
-		*value = metrics->CurrClock[PPCLK_GFXCLK];
+		*value = use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_GFXCLK] :
+			metrics->CurrClock[PPCLK_GFXCLK];
 		break;
 	case METRICS_CURR_SOCCLK:
-		*value = metrics->CurrClock[PPCLK_SOCCLK];
+		*value = use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_SOCCLK] :
+			metrics->CurrClock[PPCLK_SOCCLK];
 		break;
 	case METRICS_CURR_UCLK:
-		*value = metrics->CurrClock[PPCLK_UCLK];
+		*value = use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_UCLK] :
+			metrics->CurrClock[PPCLK_UCLK];
 		break;
 	case METRICS_CURR_VCLK:
-		*value = metrics->CurrClock[PPCLK_VCLK_0];
+		*value = use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_VCLK_0] :
+			metrics->CurrClock[PPCLK_VCLK_0];
 		break;
 	case METRICS_CURR_VCLK1:
-		*value = metrics->CurrClock[PPCLK_VCLK_1];
+		*value = use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_VCLK_1] :
+			metrics->CurrClock[PPCLK_VCLK_1];
 		break;
 	case METRICS_CURR_DCLK:
-		*value = metrics->CurrClock[PPCLK_DCLK_0];
+		*value = use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_DCLK_0] :
+			metrics->CurrClock[PPCLK_DCLK_0];
 		break;
 	case METRICS_CURR_DCLK1:
-		*value = metrics->CurrClock[PPCLK_DCLK_1];
+		*value = use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_DCLK_1] :
+			metrics->CurrClock[PPCLK_DCLK_1];
 		break;
 	case METRICS_CURR_DCEFCLK:
-		*value = metrics->CurrClock[PPCLK_DCEFCLK];
+		*value = use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_DCEFCLK] :
+			metrics->CurrClock[PPCLK_DCEFCLK];
 		break;
 	case METRICS_CURR_FCLK:
-		*value = metrics->CurrClock[PPCLK_FCLK];
+		*value = use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_FCLK] :
+			metrics->CurrClock[PPCLK_FCLK];
 		break;
 	case METRICS_AVERAGE_GFXCLK:
-		if (metrics->AverageGfxActivity <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
-			*value = metrics->AverageGfxclkFrequencyPostDs;
+		average_gfx_activity = use_metrics_v2 ? metrics_v2->AverageGfxActivity :
+			metrics->AverageGfxActivity;
+		if (average_gfx_activity <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
+			*value = use_metrics_v2 ? metrics_v2->AverageGfxclkFrequencyPostDs :
+				metrics->AverageGfxclkFrequencyPostDs;
 		else
-			*value = metrics->AverageGfxclkFrequencyPreDs;
+			*value = use_metrics_v2 ? metrics_v2->AverageGfxclkFrequencyPreDs :
+				metrics->AverageGfxclkFrequencyPreDs;
 		break;
 	case METRICS_AVERAGE_FCLK:
-		*value = metrics->AverageFclkFrequencyPostDs;
+		*value = use_metrics_v2 ? metrics_v2->AverageFclkFrequencyPostDs :
+			metrics->AverageFclkFrequencyPostDs;
 		break;
 	case METRICS_AVERAGE_UCLK:
-		*value = metrics->AverageUclkFrequencyPostDs;
+		*value = use_metrics_v2 ? metrics_v2->AverageUclkFrequencyPostDs :
+			metrics->AverageUclkFrequencyPostDs;
 		break;
 	case METRICS_AVERAGE_GFXACTIVITY:
-		*value = metrics->AverageGfxActivity;
+		*value = use_metrics_v2 ? metrics_v2->AverageGfxActivity :
+			metrics->AverageGfxActivity;
 		break;
 	case METRICS_AVERAGE_MEMACTIVITY:
-		*value = metrics->AverageUclkActivity;
+		*value = use_metrics_v2 ? metrics_v2->AverageUclkActivity :
+			metrics->AverageUclkActivity;
 		break;
 	case METRICS_AVERAGE_SOCKETPOWER:
-		*value = metrics->AverageSocketPower << 8;
+		*value = use_metrics_v2 ? metrics_v2->AverageSocketPower << 8 :
+			metrics->AverageSocketPower << 8;
 		break;
 	case METRICS_TEMPERATURE_EDGE:
-		*value = metrics->TemperatureEdge *
+		*value = (use_metrics_v2 ? metrics_v2->TemperatureEdge : metrics->TemperatureEdge) *
 			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_TEMPERATURE_HOTSPOT:
-		*value = metrics->TemperatureHotspot *
+		*value = (use_metrics_v2 ? metrics_v2->TemperatureHotspot : metrics->TemperatureHotspot) *
 			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_TEMPERATURE_MEM:
-		*value = metrics->TemperatureMem *
+		*value = (use_metrics_v2 ? metrics_v2->TemperatureMem : metrics->TemperatureMem) *
 			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_TEMPERATURE_VRGFX:
-		*value = metrics->TemperatureVrGfx *
+		*value = (use_metrics_v2 ? metrics_v2->TemperatureVrGfx : metrics->TemperatureVrGfx) *
 			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_TEMPERATURE_VRSOC:
-		*value = metrics->TemperatureVrSoc *
+		*value = (use_metrics_v2 ? metrics_v2->TemperatureVrSoc : metrics->TemperatureVrSoc) *
 			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_THROTTLER_STATUS:
-		*value = metrics->ThrottlerStatus;
+		*value = sienna_cichlid_get_throttler_status_locked(smu);
 		break;
 	case METRICS_CURR_FANSPEED:
-		*value = metrics->CurrFanSpeed;
+		*value = use_metrics_v2 ? metrics_v2->CurrFanSpeed : metrics->CurrFanSpeed;
 		break;
 	default:
 		*value = UINT_MAX;
@@ -3567,65 +3610,94 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	SmuMetricsExternal_t metrics_external;
 	SmuMetrics_t *metrics =
 		&(metrics_external.SmuMetrics);
+	SmuMetrics_V2_t *metrics_v2 =
+		&(metrics_external.SmuMetrics_V2);
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t smu_version;
+	bool use_metrics_v2 = ((adev->asic_type == CHIP_SIENNA_CICHLID) &&
+		(smu->smc_fw_version >= 0x3A4300)) ? true : false;
+	uint16_t average_gfx_activity;
 	int ret = 0;
 
-	ret = smu_cmn_get_metrics_table(smu,
-					&metrics_external,
-					true);
-	if (ret)
+	mutex_lock(&smu->metrics_lock);
+	ret = smu_cmn_get_metrics_table_locked(smu,
+					       &metrics_external,
+					       true);
+	if (ret) {
+		mutex_unlock(&smu->metrics_lock);
 		return ret;
+	}
 
 	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
-	gpu_metrics->temperature_edge = metrics->TemperatureEdge;
-	gpu_metrics->temperature_hotspot = metrics->TemperatureHotspot;
-	gpu_metrics->temperature_mem = metrics->TemperatureMem;
-	gpu_metrics->temperature_vrgfx = metrics->TemperatureVrGfx;
-	gpu_metrics->temperature_vrsoc = metrics->TemperatureVrSoc;
-	gpu_metrics->temperature_vrmem = metrics->TemperatureVrMem0;
-
-	gpu_metrics->average_gfx_activity = metrics->AverageGfxActivity;
-	gpu_metrics->average_umc_activity = metrics->AverageUclkActivity;
-	gpu_metrics->average_mm_activity = metrics->VcnActivityPercentage;
-
-	gpu_metrics->average_socket_power = metrics->AverageSocketPower;
-	gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
-
-	if (metrics->AverageGfxActivity <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
-		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPostDs;
+	gpu_metrics->temperature_edge =
+		use_metrics_v2 ? metrics_v2->TemperatureEdge : metrics->TemperatureEdge;
+	gpu_metrics->temperature_hotspot =
+		use_metrics_v2 ? metrics_v2->TemperatureHotspot : metrics->TemperatureHotspot;
+	gpu_metrics->temperature_mem =
+		use_metrics_v2 ? metrics_v2->TemperatureMem : metrics->TemperatureMem;
+	gpu_metrics->temperature_vrgfx =
+		use_metrics_v2 ? metrics_v2->TemperatureVrGfx : metrics->TemperatureVrGfx;
+	gpu_metrics->temperature_vrsoc =
+		use_metrics_v2 ? metrics_v2->TemperatureVrSoc : metrics->TemperatureVrSoc;
+	gpu_metrics->temperature_vrmem =
+		use_metrics_v2 ? metrics_v2->TemperatureVrMem0 : metrics->TemperatureVrMem0;
+
+	gpu_metrics->average_gfx_activity =
+		use_metrics_v2 ? metrics_v2->AverageGfxActivity : metrics->AverageGfxActivity;
+	gpu_metrics->average_umc_activity =
+		use_metrics_v2 ? metrics_v2->AverageUclkActivity : metrics->AverageUclkActivity;
+	gpu_metrics->average_mm_activity =
+		use_metrics_v2 ? metrics_v2->VcnActivityPercentage : metrics->VcnActivityPercentage;
+
+	gpu_metrics->average_socket_power =
+		use_metrics_v2 ? metrics_v2->AverageSocketPower : metrics->AverageSocketPower;
+	gpu_metrics->energy_accumulator =
+		use_metrics_v2 ? metrics_v2->EnergyAccumulator : metrics->EnergyAccumulator;
+
+	average_gfx_activity = use_metrics_v2 ? metrics_v2->AverageGfxActivity : metrics->AverageGfxActivity;
+	if (average_gfx_activity <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
+		gpu_metrics->average_gfxclk_frequency =
+			use_metrics_v2 ? metrics_v2->AverageGfxclkFrequencyPostDs : metrics->AverageGfxclkFrequencyPostDs;
 	else
-		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPreDs;
-	gpu_metrics->average_uclk_frequency = metrics->AverageUclkFrequencyPostDs;
-	gpu_metrics->average_vclk0_frequency = metrics->AverageVclk0Frequency;
-	gpu_metrics->average_dclk0_frequency = metrics->AverageDclk0Frequency;
-	gpu_metrics->average_vclk1_frequency = metrics->AverageVclk1Frequency;
-	gpu_metrics->average_dclk1_frequency = metrics->AverageDclk1Frequency;
-
-	gpu_metrics->current_gfxclk = metrics->CurrClock[PPCLK_GFXCLK];
-	gpu_metrics->current_socclk = metrics->CurrClock[PPCLK_SOCCLK];
-	gpu_metrics->current_uclk = metrics->CurrClock[PPCLK_UCLK];
-	gpu_metrics->current_vclk0 = metrics->CurrClock[PPCLK_VCLK_0];
-	gpu_metrics->current_dclk0 = metrics->CurrClock[PPCLK_DCLK_0];
-	gpu_metrics->current_vclk1 = metrics->CurrClock[PPCLK_VCLK_1];
-	gpu_metrics->current_dclk1 = metrics->CurrClock[PPCLK_DCLK_1];
-
-	gpu_metrics->throttle_status = metrics->ThrottlerStatus;
+		gpu_metrics->average_gfxclk_frequency =
+			use_metrics_v2 ? metrics_v2->AverageGfxclkFrequencyPreDs : metrics->AverageGfxclkFrequencyPreDs;
+	gpu_metrics->average_uclk_frequency =
+		use_metrics_v2 ? metrics_v2->AverageUclkFrequencyPostDs : metrics->AverageUclkFrequencyPostDs;
+	gpu_metrics->average_vclk0_frequency =
+		use_metrics_v2 ? metrics_v2->AverageVclk0Frequency : metrics->AverageVclk0Frequency;
+	gpu_metrics->average_dclk0_frequency =
+		use_metrics_v2 ? metrics_v2->AverageDclk0Frequency : metrics->AverageDclk0Frequency;
+	gpu_metrics->average_vclk1_frequency =
+		use_metrics_v2 ? metrics_v2->AverageVclk1Frequency : metrics->AverageVclk1Frequency;
+	gpu_metrics->average_dclk1_frequency =
+		use_metrics_v2 ? metrics_v2->AverageDclk1Frequency : metrics->AverageDclk1Frequency;
+
+	gpu_metrics->current_gfxclk =
+		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_GFXCLK] : metrics->CurrClock[PPCLK_GFXCLK];
+	gpu_metrics->current_socclk =
+		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_SOCCLK] : metrics->CurrClock[PPCLK_SOCCLK];
+	gpu_metrics->current_uclk =
+		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_UCLK] : metrics->CurrClock[PPCLK_UCLK];
+	gpu_metrics->current_vclk0 =
+		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_VCLK_0] : metrics->CurrClock[PPCLK_VCLK_0];
+	gpu_metrics->current_dclk0 =
+		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_DCLK_0] : metrics->CurrClock[PPCLK_DCLK_0];
+	gpu_metrics->current_vclk1 =
+		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_VCLK_1] : metrics->CurrClock[PPCLK_VCLK_1];
+	gpu_metrics->current_dclk1 =
+		use_metrics_v2 ? metrics_v2->CurrClock[PPCLK_DCLK_1] : metrics->CurrClock[PPCLK_DCLK_1];
+
+	gpu_metrics->throttle_status = sienna_cichlid_get_throttler_status_locked(smu);
 	gpu_metrics->indep_throttle_status =
-			smu_cmn_get_indep_throttler_status(metrics->ThrottlerStatus,
+			smu_cmn_get_indep_throttler_status(gpu_metrics->throttle_status,
 							   sienna_cichlid_throttler_map);
 
-	gpu_metrics->current_fan_speed = metrics->CurrFanSpeed;
+	gpu_metrics->current_fan_speed = use_metrics_v2 ? metrics_v2->CurrFanSpeed : metrics->CurrFanSpeed;
 
-	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if (ret)
-		return ret;
-
-	if (((adev->asic_type == CHIP_SIENNA_CICHLID) && smu_version > 0x003A1E00) ||
-	      ((adev->asic_type == CHIP_NAVY_FLOUNDER) && smu_version > 0x00410400)) {
-		gpu_metrics->pcie_link_width = metrics->PcieWidth;
-		gpu_metrics->pcie_link_speed = link_speed[metrics->PcieRate];
+	if (((adev->asic_type == CHIP_SIENNA_CICHLID) && smu->smc_fw_version > 0x003A1E00) ||
+	      ((adev->asic_type == CHIP_NAVY_FLOUNDER) && smu->smc_fw_version > 0x00410400)) {
+		gpu_metrics->pcie_link_width = use_metrics_v2 ? metrics_v2->PcieWidth : metrics->PcieWidth;
+		gpu_metrics->pcie_link_speed = link_speed[use_metrics_v2 ? metrics_v2->PcieRate : metrics->PcieRate];
 	} else {
 		gpu_metrics->pcie_link_width =
 				smu_v11_0_get_current_pcie_link_width(smu);
@@ -3633,6 +3705,8 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 				smu_v11_0_get_current_pcie_link_speed(smu);
 	}
 
+	mutex_unlock(&smu->metrics_lock);
+
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
 	*table = (void *)gpu_metrics;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
