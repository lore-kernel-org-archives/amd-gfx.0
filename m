Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F428C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 03:30:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B1322B48
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 03:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="npNE8bEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B1322B48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23AE96E84F;
	Thu, 30 Jul 2020 03:30:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83F046E84F
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 03:30:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFBim0tEL7j9i5/6Fsjh8yLP2TpHVYfL4gzLipT40egTQqhtIj3I5SnMauXct0/UGZ24iLeiOm9ub4y9NQyuzBB6Wdi+3de7rmSGTEnGy1DZLU+8msK+6iBPyq09L7RsnB20pJ8WuSMnKslUiWA6hl4Giwyk/Ic7//qbC1Jp3+mP4kboFRs1d0D/OvFV0eLOKQKrF87TBO2m3qmITJu7F6+OeGy4H+uBofEE8C5+zb/693fMBfe0xMtK7Y72d9zg0AewCMddbm6X6reIqKREYNuVvRScF+LiZ01WA9HWshPntiRqA6sMIUbSfIDS7oZ8AK/N2N4MuehNb4Ic93viBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPPLLIZ244wHi2IG8H/UU5NA0JAuNu3S1IoGh/lyB/g=;
 b=TwjsMxkEeXkiyOpozcaRgG86UcdGecCem/CGZwV36Z/nssvm7M1DGAmLzispy96CDN8LoaXXGmGyf3VwgWCkKuESjhnAbseaOtJ7UdyqA0HWoUN4V4pBpt5pbSNekxbHnSOsztUffc7+MouRBMwpv4tm+DGiqc20uEhio6FIdT6/+i1Q7naPVB/dLJA78eCa2neZTnEh5VDbtA+CXHKCFECvZhGs1JTAjyTCiaUZF4VSJWB9nH0P06iwXx4mbSeznn8Z1rvYn6VbVwYwk4j+RUVZBK3PgCVTZl3l1lEqZTAzHA1/W1orohdx+cbpvbzhuw5nRCZRLgGwufncDo4CpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPPLLIZ244wHi2IG8H/UU5NA0JAuNu3S1IoGh/lyB/g=;
 b=npNE8bEMfjVcX/ZZijSeHwKFzzSpNaQNTpImqTgN0QWgMbU3rc4sFs8n5wcKOaxEZN/qRhZrpTOLmzBd2jMJpqt+vEovj2UnYKzvLViOBmFlc2sK5DBnBHv8j/ECbC+A+aLSEOsBhDKGifem7PV8mG61Tmx0JBnG7KGPcv23Zbg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17; Thu, 30 Jul 2020 03:30:35 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Thu, 30 Jul 2020
 03:30:35 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/8] drm/amd/powerplay: add Sienna Cichlid support for gpu
 metrics export
Date: Thu, 30 Jul 2020 11:28:38 +0800
Message-Id: <20200730032839.2517-7-evan.quan@amd.com>
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
 15.20.3239.17 via Frontend Transport; Thu, 30 Jul 2020 03:30:33 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bbe2ac14-eeb4-4d40-054d-08d83438eb91
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1355760F8460CF06C29BB08AE4710@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gRpegSqfqQjnXoPp+0w3Rgw7f3bc4NtCZZa1k50X8uu0vaIdJGaxCaegKRQgsSoVYRrajvZwYvCC5b8Exw/Yy4QRaLk6d3hzhNJhJ6gB56aBe5NCJeHi+GA/Eu3qGrG5/oNyr9a7cjjj35XAON9Lwpl45rItujr0h+hdyaL3DQbIwnQe0WcmZFHvNAwWMN0V/DpJdmiSx76JCM9r72Tzobsv6Et74vQkmvdTI2IUeGrO80Le8CNJkFCpE6BV81UC2Ajbi1cQKPsI7tiw5TEn9oePAUHi/afbejwBAlrpZFLha7L/X4s1wQTSlHJvVn1+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(186003)(83380400001)(4326008)(6916009)(36756003)(2906002)(8676002)(8936002)(478600001)(66946007)(44832011)(2616005)(956004)(26005)(66476007)(66556008)(1076003)(6486002)(5660300002)(86362001)(52116002)(7696005)(16526019)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: XKqM+9T0wKMwrUVf0wzTGPS8+a+F4od4REobbt+cPmuj3s243QMlYBQAbGNNxm/2wes9qYg94J1SSXb6CBVE/+c2J+XEd0Jhupz9UtOCczxjsPqhvZam7nzyy/rZYGTvUkUhLTGN+zCmLRiiELETesFF3teKaDtTpRCy10UzuaAHisrW2ZUIlAC8Y5775JY2aeiE2Gft8pWfOB6RUkoEuyx41yVKQaRVmds1xgUZB4qAemPXT2TOeYdnZaTCP9xnYUZyO1YBsf3Hr4Za1SnASy2IFcVLN/IFEeUn2xfRypGUeIOMAWwbFq1hbdW/U/hIcAGo69pSOOMVmWKsKIv0WwXKqzLRtYHW6pZhqqgUhw/D8PSnvXPOl4fcA3Rqq1Ou6yYkURWmfIEwLIC8ag0s8S+Jwo5//EtzNIGi+h7k7EFfqeGG4pSltA1UsW/Mach/JqeA6JCMTJ56b0KmoqR81RasyVQYJo1+W0j1tKZw4FFud3nj2dHWO4dWDTwlyJCW3pPSC2PHD34fcxeycGZSf6oyNnAF75kaOis6NeY0mWvJylmHXUPvnMADS2CKFnmtDbJO9S9Ie3i8zSeKdw+p4OATUqNyCML4yYYXl1BieRokx3fKcvoYI2P1i0eqRX9cds2rT2BaArRe+n2eaOTfeA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe2ac14-eeb4-4d40-054d-08d83438eb91
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 03:30:35.1315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXw/XMO9BFdhgtxbwmHDUxkiib9Njis7P5xFWRu+T9FzqAhKVWfRiJO4axYzSd+W
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

Add Sienna Cichlid gpu metrics export interface.

Change-Id: I89e6a4415fe467e7e4aaabe07d9e8cee379caa25
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 91 ++++++++++++++++++-
 1 file changed, 89 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index c15496aea50f..345b8571f716 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -385,14 +385,26 @@ static int sienna_cichlid_tables_init(struct smu_context *smu)
 
 	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
 	if (!smu_table->metrics_table)
-		return -ENOMEM;
+		goto err0_out;
 	smu_table->metrics_time = 0;
 
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_0);
+	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
+	if (!smu_table->gpu_metrics_table)
+		goto err1_out;
+
 	smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t), GFP_KERNEL);
 	if (!smu_table->watermarks_table)
-		return -ENOMEM;
+		goto err2_out;
 
 	return 0;
+
+err2_out:
+	kfree(smu_table->gpu_metrics_table);
+err1_out:
+	kfree(smu_table->metrics_table);
+err0_out:
+	return -ENOMEM;
 }
 
 static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
@@ -2663,6 +2675,80 @@ static void sienna_cichlid_i2c_control_fini(struct smu_context *smu, struct i2c_
 	i2c_del_adapter(control);
 }
 
+static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
+					      void **table)
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
+	gpu_metrics->temperature_mem = metrics.TemperatureMem;
+	gpu_metrics->temperature_vrgfx = metrics.TemperatureVrGfx;
+	gpu_metrics->temperature_vrsoc = metrics.TemperatureVrSoc;
+	gpu_metrics->temperature_vrmem = metrics.TemperatureVrMem0;
+
+	gpu_metrics->average_gfx_activity = metrics.AverageGfxActivity;
+	gpu_metrics->average_umc_activity = metrics.AverageUclkActivity;
+	gpu_metrics->average_mm_activity = metrics.VcnActivityPercentage;
+
+	gpu_metrics->average_socket_power = metrics.AverageSocketPower;
+	gpu_metrics->energy_accumulator = metrics.EnergyAccumulator;
+
+	if (metrics.AverageGfxActivity <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
+		gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequencyPostDs;
+	else
+		gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequencyPreDs;
+	gpu_metrics->average_uclk_frequency = metrics.AverageUclkFrequencyPostDs;
+	gpu_metrics->average_vclk0_frequency = metrics.AverageVclk0Frequency;
+	gpu_metrics->average_dclk0_frequency = metrics.AverageDclk0Frequency;
+	gpu_metrics->average_vclk1_frequency = metrics.AverageVclk1Frequency;
+	gpu_metrics->average_dclk1_frequency = metrics.AverageDclk1Frequency;
+
+	gpu_metrics->current_gfxclk = metrics.CurrClock[PPCLK_GFXCLK];
+	gpu_metrics->current_socclk = metrics.CurrClock[PPCLK_SOCCLK];
+	gpu_metrics->current_uclk = metrics.CurrClock[PPCLK_UCLK];
+	gpu_metrics->current_vclk0 = metrics.CurrClock[PPCLK_VCLK_0];
+	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK_0];
+	gpu_metrics->current_vclk1 = metrics.CurrClock[PPCLK_VCLK_1];
+	gpu_metrics->current_dclk1 = metrics.CurrClock[PPCLK_DCLK_1];
+
+	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+
+	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
+
+	gpu_metrics->pcie_link_width =
+			smu_v11_0_get_current_pcie_link_width(smu);
+	gpu_metrics->pcie_link_speed =
+			smu_v11_0_get_current_pcie_link_speed(smu);
+
+	*table = (void *)gpu_metrics;
+
+	return sizeof(struct gpu_metrics_v1_0);
+}
 
 static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_allowed_feature_mask = sienna_cichlid_get_allowed_feature_mask,
@@ -2740,6 +2826,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
+	.get_gpu_metrics = sienna_cichlid_get_gpu_metrics,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
