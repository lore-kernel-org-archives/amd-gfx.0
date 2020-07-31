Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5D7C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 108A72083E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 02:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tdIes87o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108A72083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A21A26E99A;
	Fri, 31 Jul 2020 02:44:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57CF96E998
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 02:44:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfxOWLOf8KI55a3TxASXYs1WkBsUZVuK+uHOmb/7EbGg2n7yTMzB4zcHDbAjSMoVzNsrMTd4xE+ZJneV5EfxBrlexKg123W/Tj2bBeyckS37ZjWvmopxj+kKoK5OIXDJ2mlzvo7TaC8KPVQhwc3mTwJmqsbjL6lEuA7Inzieu63hwvodJWSbZE/Y5L0v2t9QFOZb4G05bsUwdTicxFcr8rlrUihea1sp9upT+RR5S/442bBcNpX/6cvVrRthh7yhf/8fBwTlafHD1rod1psM8J7KAtucb5+RR5j8pSUWH5oIhmkXuQuFoOrv9h3kmsi9LNonPAEuFWWoIGgSuGcuzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+7InlZcnY0bvigP3SCEbcMcSHZ1rTvGi03KDUuWXlU=;
 b=Fbj3sgCVFoyheJAHvsfcNLngONEaXhW6PyGSJamm9jca2o0wGUY1ELxqs52b2czheNZ61WElvHMOuP/mUS8v1pjQ9JGZ2ofTn0fKcWzDiySaXV3Q9pW9vO1BAhbsDQz0GGVG2HY70irwvu+CEvcp5ej1OZTCeGEluOYFLmLRSj5uKjPwdJduwxpgHb6Z4ytIzX1AqB3uWV+KEkZujwSLgURwhYhC8HiBUcEE5JFs02GxbIwxAuqb3w9ejIHnwS5IzdgoIzirAtyUEl/n3wNoVR4XOzLVvIbL/k5PMN+UPwHwME+hJkHu1Uo4mqDZxAsyZ10++SGsAKL17n7FedpQ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+7InlZcnY0bvigP3SCEbcMcSHZ1rTvGi03KDUuWXlU=;
 b=tdIes87ohMncg1IN/s5zaXnb7DzKoNwzZEAmZ3sgiCMt1c4diyMjwW9NGddUq4krl30G6vfYLmcRSRWMFEa7K62TMqVroeaql4Nh2uYwihJDfJk87t0r84imXwVPcCl52pE7ntz+zcL0vRa/Yr7Mzgsddb1yUz2bpfzfojnAETk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Fri, 31 Jul 2020 02:44:11 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Fri, 31 Jul 2020
 02:44:11 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/17] drm/amd/powerplay: add Renoir support for gpu metrics
 export(V2)
Date: Fri, 31 Jul 2020 10:43:07 +0800
Message-Id: <20200731024316.28324-8-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200731024316.28324-1-evan.quan@amd.com>
References: <20200731024316.28324-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0206.apcprd02.prod.outlook.com
 (2603:1096:201:20::18) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0206.apcprd02.prod.outlook.com (2603:1096:201:20::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 02:44:08 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0afc24b1-bf2f-48e9-65fb-08d834fb9a93
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44358DDC42927402746D0527E44E0@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dtaB6koY3OWMCD9Evfi4+aBfr2ppNeCgXAFpRhWWwf5s2iSllRAU4FrNoQBZrJrpGpxDSIV37ZjNmalrBrXM9Ym9qyUyceD+4+5mhaxYXE/1smdvVmb0N3AzpDUw3raZIsXdK0iVyXdW/CzcU9+UMUch7gigrHPwDKQNJLxKUjGMuNVqia9OrZP5UCQWPjMLFxswwwfiZZu6w4w9M6UFKAw98QhpNrJT6kamFGhtA4DgRAg7MerjfNj6qY//JQRlR9hV8GGIre1T0dIFvhuXYsejl1ssunrt4PFHeFL3izD6drlWkKt98xypeFQDM0BF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(16526019)(186003)(6486002)(36756003)(6916009)(8676002)(44832011)(83380400001)(956004)(26005)(66946007)(1076003)(5660300002)(66556008)(66476007)(4326008)(7696005)(2616005)(86362001)(2906002)(478600001)(8936002)(52116002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4Z5VGeZchVLGGv3fXtp04s7PmL+7ncT64URGyTCZ4tN661RV+EB89R83c+UNXgdGnASDxr4e7HdVF4HcAtIwNeIWnKTpfJePPeIRPhEfieR1fjpDHHAGHeB0Mzhko7hz5Vbi9iMcPMvbzdPKDXe53avO0BhcyVvy5EQP9IHp/g0q+TLd1n1h8cQLKwGDqO8fqMAxLMX3stZoXG/4AxXzY3B79sszG47P27RzTT3sQj60mBNEcGxeEMpmwyOHoIdSXc2C6W8hg0UI9s3RiE8WBx3Nn/aeHYzVnj+tmNWEG3lUEroBFWEITv04Rf0ysDScnGjaiL8gB6Z75vmb22QAgpLKSfRP9DpXJNYEvfBI5ncDCQO/X9aNO5u7GQPP6vhpsnFTd/9Q9XnG5o0DC/o/NWW6jXd/n2JPUECSZjrJWJVNegCVYVyzM/HINsL2NCf711KM1MtdfEUQMHJBnFzpd4HFWasA6UFTO6hvivO8U5UeDwaQUOVFUXiGDdLzO7d3xLauFTqzIjY7sr0ioIlYdFGq5UEQLiuRWPipwKaCvlyh1oAj9s47AofZqL5pfZ/FPi652LTxBfpGsQr8KoeVliP4jT5ozVLsmLKip3+3QvIZ21yVnmYQHL0bVxMf6Unq/gj1EKgHxCOTmnZSPh4k8g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0afc24b1-bf2f-48e9-65fb-08d834fb9a93
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 02:44:10.9261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GvTHj/VN0qLlXKqD+Ok5Du0EEc1sTXxZ1bpOguLwfUhGNWm/nATnRlY5RGLDZBMb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 Evan Quan <evan.quan@amd.com>, Harish.Kasiviswanathan@amd.com,
 nirmodas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add Renoir gpu metrics export interface.

V2: use memcpy to make code more compact

Change-Id: Ic83265536eeaa9e458dc395b2be18ea49da4c68a
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h |  2 +
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    | 80 ++++++++++++++++++-
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c     | 12 +++
 3 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
index 02de3b6199e5..fa2e8cb07967 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
@@ -60,5 +60,7 @@ int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
 
 int smu_v12_0_set_driver_table_location(struct smu_context *smu);
 
+void smu_v12_0_init_gpu_metrics_v2_0(struct gpu_metrics_v2_0 *gpu_metrics);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 575ae4be98a2..61e8700a7bdb 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -166,18 +166,32 @@ static int renoir_init_smc_tables(struct smu_context *smu)
 
 	smu_table->clocks_table = kzalloc(sizeof(DpmClocks_t), GFP_KERNEL);
 	if (!smu_table->clocks_table)
-		return -ENOMEM;
+		goto err0_out;
 
 	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
 	if (!smu_table->metrics_table)
-		return -ENOMEM;
+		goto err1_out;
 	smu_table->metrics_time = 0;
 
 	smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t), GFP_KERNEL);
 	if (!smu_table->watermarks_table)
-		return -ENOMEM;
+		goto err2_out;
+
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_0);
+	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
+	if (!smu_table->gpu_metrics_table)
+		goto err3_out;
 
 	return 0;
+
+err3_out:
+	kfree(smu_table->watermarks_table);
+err2_out:
+	kfree(smu_table->metrics_table);
+err1_out:
+	kfree(smu_table->clocks_table);
+err0_out:
+	return -ENOMEM;
 }
 
 /**
@@ -995,6 +1009,65 @@ static bool renoir_is_dpm_running(struct smu_context *smu)
 
 }
 
+static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
+				      void **table)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct gpu_metrics_v2_0 *gpu_metrics =
+		(struct gpu_metrics_v2_0 *)smu_table->gpu_metrics_table;
+	SmuMetrics_t metrics;
+	int ret = 0;
+
+	ret = renoir_get_metrics_table(smu, &metrics);
+	if (ret)
+		return ret;
+
+	smu_v12_0_init_gpu_metrics_v2_0(gpu_metrics);
+
+	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
+	gpu_metrics->temperature_soc = metrics.SocTemperature;
+	memcpy(&gpu_metrics->temperature_core[0],
+		&metrics.CoreTemperature[0],
+		sizeof(uint16_t) * 8);
+	gpu_metrics->temperature_l3[0] = metrics.L3Temperature[0];
+	gpu_metrics->temperature_l3[1] = metrics.L3Temperature[1];
+
+	gpu_metrics->average_gfx_activity = metrics.AverageGfxActivity;
+	gpu_metrics->average_mm_activity = metrics.AverageUvdActivity;
+
+	gpu_metrics->average_socket_power = metrics.CurrentSocketPower;
+	gpu_metrics->average_cpu_power = metrics.Power[0];
+	gpu_metrics->average_soc_power = metrics.Power[1];
+	memcpy(&gpu_metrics->average_core_power[0],
+		&metrics.CorePower[0],
+		sizeof(uint16_t) * 8);
+
+	gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequency;
+	gpu_metrics->average_socclk_frequency = metrics.AverageSocclkFrequency;
+	gpu_metrics->average_fclk_frequency = metrics.AverageFclkFrequency;
+	gpu_metrics->average_vclk_frequency = metrics.AverageVclkFrequency;
+
+	gpu_metrics->current_gfxclk = metrics.ClockFrequency[CLOCK_GFXCLK];
+	gpu_metrics->current_socclk = metrics.ClockFrequency[CLOCK_SOCCLK];
+	gpu_metrics->current_uclk = metrics.ClockFrequency[CLOCK_UMCCLK];
+	gpu_metrics->current_fclk = metrics.ClockFrequency[CLOCK_FCLK];
+	gpu_metrics->current_vclk = metrics.ClockFrequency[CLOCK_VCLK];
+	gpu_metrics->current_dclk = metrics.ClockFrequency[CLOCK_DCLK];
+	memcpy(&gpu_metrics->current_coreclk[0],
+		&metrics.CoreFrequency[0],
+		sizeof(uint16_t) * 8);
+	gpu_metrics->current_l3clk[0] = metrics.L3Frequency[0];
+	gpu_metrics->current_l3clk[1] = metrics.L3Frequency[1];
+
+	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+
+	gpu_metrics->fan_pwm = metrics.FanPwm;
+
+	*table = (void *)gpu_metrics;
+
+	return sizeof(struct gpu_metrics_v2_0);
+}
+
 static const struct pptable_funcs renoir_ppt_funcs = {
 	.set_power_state = NULL,
 	.print_clk_levels = renoir_print_clk_levels,
@@ -1029,6 +1102,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.is_dpm_running = renoir_is_dpm_running,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
+	.get_gpu_metrics = renoir_get_gpu_metrics,
 };
 
 void renoir_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index 31456437bb18..660f403d5770 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -274,3 +274,15 @@ int smu_v12_0_set_driver_table_location(struct smu_context *smu)
 
 	return ret;
 }
+
+void smu_v12_0_init_gpu_metrics_v2_0(struct gpu_metrics_v2_0 *gpu_metrics)
+{
+	memset(gpu_metrics, 0xFF, sizeof(struct gpu_metrics_v2_0));
+
+	gpu_metrics->common_header.structure_size =
+				sizeof(struct gpu_metrics_v2_0);
+	gpu_metrics->common_header.format_revision = 2;
+	gpu_metrics->common_header.content_revision = 0;
+
+	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
+}
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
