Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9030C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 07:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7678C2313E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 07:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7678C2313E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17E9D6E9F6;
	Thu, 10 Dec 2020 07:11:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C7D46E9F6
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 07:11:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdT0J4xOu46I4f23mo5IYkuXFfpR5B9kyyFZdrYpS6ngnVZA+8gH2ygtKbVq0rwqd0nVlecpmafMeKWroRBEmlADEkRlfVsjQwc3jUr6e2GAfGyPjmrDEnbMAff5dqeG1ORd/YBHNTaJwaa5169LNXNph/yhMWpTVPVCQghmZy65TNgCwHimAVbtlWlFPiWA3axr5V9pokSEfMFCFwuCAXMxjUC7Ne+CxOTTolZC/cwivzk8VcNP9hXZgAb59yNN+2GlPd4n9AZcEGYKYKU+RExV1R8tJfi1wKgH+qsa9oSMgqhHzTJU5x1OJte5EStcWizVkiW1IYwGMtM8yJjyBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LT4YG0h4aL+IuHVnqVHJbTYqW+IhZdTbxE4+gS1CXVA=;
 b=l9u1l2eJFZullQC4vRJoT6L5SXNy/LCWP9nMGYuGN7K9FCYa+xoza/z+oo/+wArPVskTnC4NnNJ2AqqxWbaa8Sz75ZqmhUI/160yoh1mX9+F7MqHl5DHckVmvQPps8d+aWS6MN4Cb7zJXVwP/AM1HS6pruz/x/4l/zYzo/kH7c68BJPz/uMJNtUWsdU9hKTmwCMJM/e70aJb8jtbbXNhMT5nE9PG2bEbXm/E7ENnWze2WuD5PjaxqZsNyZ736/X8cIUES+vE9NEWILDfA6hEgQban+BFqdU5edBTV1vTPU3B6TUXLT0Zcrlq/WBbHGbBalAYObslmqhEVXFfBFd1eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LT4YG0h4aL+IuHVnqVHJbTYqW+IhZdTbxE4+gS1CXVA=;
 b=kJxhE+bIQhdBEPE8Sj9dJP2kSX4q9oVkg1T7g4NdNC+ZIVCAqiA8Qf/apNYbFGYgEGSmKKkn8cH7zibqvTTlaKQo+2YjhelfisNUdSmKprBQHXFPgOa38G8GN+c0dMovHA+Ewt1cJhAKL5tsoA+5Rt3GvsZaONNLajZL1h1JxEc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3963.namprd12.prod.outlook.com (2603:10b6:5:1cd::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.13; Thu, 10 Dec 2020 07:10:58 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3632.021; Thu, 10 Dec 2020
 07:10:58 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/pm: update the data strucutre for SMU metrics
 exchange
Date: Thu, 10 Dec 2020 15:10:31 +0800
Message-Id: <20201210071031.198001-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201210071031.198001-1-evan.quan@amd.com>
References: <20201210071031.198001-1-evan.quan@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR03CA0045.apcprd03.prod.outlook.com
 (2603:1096:202:17::15) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR03CA0045.apcprd03.prod.outlook.com (2603:1096:202:17::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.5 via Frontend Transport; Thu, 10 Dec 2020 07:10:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3479f3ed-fea3-4ab0-8d45-08d89cdabe9e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3963:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB396354ACBD2D5E2D8D87C0B9E4CB0@DM6PR12MB3963.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +agHiE7vWk6llfFOkhThsR9kHAOnyPtkAwxdmkYtDOxsDfxR7q5FMFcwQABD9SygRXU1K9m+sZxHJI7lwrblGwbHCm6uKNsCKkB1hgv9IVj/UY9JtddE8RKkCpwudcjKgiZ6es9xt6sovTYR8w1nqcAdToIpnQL8CxeNCysvYKC7d0LrVntFWTyNN4lnK0orsEkg153Jn18dG06JJ1Rl4xTxmdE6A06mvXQGioA/Fn9nOJDSvHeMY9fB/EoD0uvYzdviUsiYUJkGAVOJ7GhUfRFeppr1rpwhL3YDHgy/1MQt4GkaMapvUSCVLkQqPX3Cv+s1GUvLrF2JJCD2SlHqDb/THjiYw8tG0A4HOuOu6lPjc/pjvOXizUb6YVbjKu7+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(16526019)(83380400001)(6666004)(2616005)(6486002)(66476007)(5660300002)(86362001)(2906002)(36756003)(34490700003)(44832011)(1076003)(508600001)(7696005)(186003)(8936002)(4326008)(6916009)(26005)(66946007)(52116002)(66556008)(8676002)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AAUbPIH0Yu3p/3J1d0DtAxP6y68J4P0rs9n6Pkj1J1uTMSuBS8Db0LQnWTQo?=
 =?us-ascii?Q?77aANzLvzYuVgxnhkaRbjvWuIkBMdUCOyZ7xVsel/HvUQux75/Pnrp3sknMg?=
 =?us-ascii?Q?LXgwAklmq8X5vOJfAu6SybX7tOJ8X0hDzcpFwub++XYHte/nlYVKUdWGONQ1?=
 =?us-ascii?Q?Yfvi4htZfnzKYc52eJGzvGOJu5UeoZiPYqt2/wDG7ZPMUJ4XLRxPOX0qNx8N?=
 =?us-ascii?Q?Msjz+N88zG4oXi8/cBVmMHAvl9EybtmD2zp3FVxDdCf37qToxrUY6+vMVAqP?=
 =?us-ascii?Q?TxHD/IraIMsKi/BtvOWq4W8htjE2Mo22e3R1bRNgbQaAz/+OH/doP/576HPH?=
 =?us-ascii?Q?cBkA8pm5J2E7/blTZHEQdzHeAslkyyfnY7OEmd/madjIKws/hrToEjumy4vf?=
 =?us-ascii?Q?2KfRgWPIAeB7vbvycrr2+vtc51KGMAt3OEZtnF0gxCALPlmtNF9ChJLEXGUS?=
 =?us-ascii?Q?H3FLePK+3Lj5mU9dSZTB6ygibM74uZ9haJzEJWcmpw2ApT6R4IWzlCrK3342?=
 =?us-ascii?Q?Xf8ugwbP/Hak614pyUEVzV6KUFeWp/ewcUDAVKNpnIUHQS44YkdLS8SDrHf5?=
 =?us-ascii?Q?w2Spj1FhXaeLD/GATPg66wWq+mZOdo4i8k14+LQYAkZ4NIVA0WWhkabIsaEk?=
 =?us-ascii?Q?c7mONjgqq3BclUKcMIqI+TlSATgxbuOtHYh7jRM1USGjIy49mgHkv443bIyk?=
 =?us-ascii?Q?g4m2o295IRzL+465BM3glObTJNAKKWIhXS/12E8OWBMDvbtcXLnmad94GE/r?=
 =?us-ascii?Q?sehi0TU5h9zWeVlsimRoBkPFeekbCTOlctrv3sIsoyQ8HBeMf/2QBYm+8u9G?=
 =?us-ascii?Q?qg6wwOZ647YYENGAZ2Z6NELfWuYIk25+rPO6M33S6N+gbSxdSnS/Lg/dSA5G?=
 =?us-ascii?Q?Z97Hd9ouPuJcD8yUiu8Qmhs0H1auRM4qNesbPm5GzgBwGKz6o23ys1ZiNZ1D?=
 =?us-ascii?Q?/OLEj60ViQZGNYsWxQIYgN1BpAs1D2MOmBfuPgAihlJeAlmm8e09fzXkyFgG?=
 =?us-ascii?Q?KKJF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 07:10:58.6481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 3479f3ed-fea3-4ab0-8d45-08d89cdabe9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTZaHClYjN4l1Ig8U9Sxk+bahfS7hrw55W1wZK3EgskI9BFje9pUtaZrJZxSW8Gf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3963
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is needed for Sienna Cichlid.

Change-Id: I57aa099cd1b2020cf0c8b05d8463239ec33790cf
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 75 ++++++++++---------
 1 file changed, 39 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index acbf6e97ffd0..0c4885273291 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -515,7 +515,7 @@ static int sienna_cichlid_tables_init(struct smu_context *smu)
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS, sizeof(Watermarks_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
-	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
+	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetricsExternal_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_I2C_COMMANDS, sizeof(SwI2cRequest_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
@@ -527,7 +527,7 @@ static int sienna_cichlid_tables_init(struct smu_context *smu)
 		       sizeof(DpmActivityMonitorCoeffIntExternal_t), PAGE_SIZE,
 	               AMDGPU_GEM_DOMAIN_VRAM);
 
-	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
+	smu_table->metrics_table = kzalloc(sizeof(SmuMetricsExternal_t), GFP_KERNEL);
 	if (!smu_table->metrics_table)
 		goto err0_out;
 	smu_table->metrics_time = 0;
@@ -556,7 +556,8 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 					       uint32_t *value)
 {
 	struct smu_table_context *smu_table= &smu->smu_table;
-	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
+	SmuMetrics_t *metrics =
+		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))->SmuMetrics);
 	int ret = 0;
 
 	mutex_lock(&smu->metrics_lock);
@@ -3152,52 +3153,54 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v1_0 *gpu_metrics =
 		(struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
-	SmuMetrics_t metrics;
+	SmuMetricsExternal_t metrics_external;
+	SmuMetrics_t *metrics =
+		&(metrics_external.SmuMetrics);
 	int ret = 0;
 
 	ret = smu_cmn_get_metrics_table(smu,
-					&metrics,
+					&metrics_external,
 					true);
 	if (ret)
 		return ret;
 
 	smu_v11_0_init_gpu_metrics_v1_0(gpu_metrics);
 
-	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
-	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
-	gpu_metrics->temperature_mem = metrics.TemperatureMem;
-	gpu_metrics->temperature_vrgfx = metrics.TemperatureVrGfx;
-	gpu_metrics->temperature_vrsoc = metrics.TemperatureVrSoc;
-	gpu_metrics->temperature_vrmem = metrics.TemperatureVrMem0;
+	gpu_metrics->temperature_edge = metrics->TemperatureEdge;
+	gpu_metrics->temperature_hotspot = metrics->TemperatureHotspot;
+	gpu_metrics->temperature_mem = metrics->TemperatureMem;
+	gpu_metrics->temperature_vrgfx = metrics->TemperatureVrGfx;
+	gpu_metrics->temperature_vrsoc = metrics->TemperatureVrSoc;
+	gpu_metrics->temperature_vrmem = metrics->TemperatureVrMem0;
 
-	gpu_metrics->average_gfx_activity = metrics.AverageGfxActivity;
-	gpu_metrics->average_umc_activity = metrics.AverageUclkActivity;
-	gpu_metrics->average_mm_activity = metrics.VcnActivityPercentage;
+	gpu_metrics->average_gfx_activity = metrics->AverageGfxActivity;
+	gpu_metrics->average_umc_activity = metrics->AverageUclkActivity;
+	gpu_metrics->average_mm_activity = metrics->VcnActivityPercentage;
 
-	gpu_metrics->average_socket_power = metrics.AverageSocketPower;
-	gpu_metrics->energy_accumulator = metrics.EnergyAccumulator;
+	gpu_metrics->average_socket_power = metrics->AverageSocketPower;
+	gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
 
-	if (metrics.AverageGfxActivity <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
-		gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequencyPostDs;
+	if (metrics->AverageGfxActivity <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
+		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPostDs;
 	else
-		gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequencyPreDs;
-	gpu_metrics->average_uclk_frequency = metrics.AverageUclkFrequencyPostDs;
-	gpu_metrics->average_vclk0_frequency = metrics.AverageVclk0Frequency;
-	gpu_metrics->average_dclk0_frequency = metrics.AverageDclk0Frequency;
-	gpu_metrics->average_vclk1_frequency = metrics.AverageVclk1Frequency;
-	gpu_metrics->average_dclk1_frequency = metrics.AverageDclk1Frequency;
-
-	gpu_metrics->current_gfxclk = metrics.CurrClock[PPCLK_GFXCLK];
-	gpu_metrics->current_socclk = metrics.CurrClock[PPCLK_SOCCLK];
-	gpu_metrics->current_uclk = metrics.CurrClock[PPCLK_UCLK];
-	gpu_metrics->current_vclk0 = metrics.CurrClock[PPCLK_VCLK_0];
-	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK_0];
-	gpu_metrics->current_vclk1 = metrics.CurrClock[PPCLK_VCLK_1];
-	gpu_metrics->current_dclk1 = metrics.CurrClock[PPCLK_DCLK_1];
-
-	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
-
-	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
+		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPreDs;
+	gpu_metrics->average_uclk_frequency = metrics->AverageUclkFrequencyPostDs;
+	gpu_metrics->average_vclk0_frequency = metrics->AverageVclk0Frequency;
+	gpu_metrics->average_dclk0_frequency = metrics->AverageDclk0Frequency;
+	gpu_metrics->average_vclk1_frequency = metrics->AverageVclk1Frequency;
+	gpu_metrics->average_dclk1_frequency = metrics->AverageDclk1Frequency;
+
+	gpu_metrics->current_gfxclk = metrics->CurrClock[PPCLK_GFXCLK];
+	gpu_metrics->current_socclk = metrics->CurrClock[PPCLK_SOCCLK];
+	gpu_metrics->current_uclk = metrics->CurrClock[PPCLK_UCLK];
+	gpu_metrics->current_vclk0 = metrics->CurrClock[PPCLK_VCLK_0];
+	gpu_metrics->current_dclk0 = metrics->CurrClock[PPCLK_DCLK_0];
+	gpu_metrics->current_vclk1 = metrics->CurrClock[PPCLK_VCLK_1];
+	gpu_metrics->current_dclk1 = metrics->CurrClock[PPCLK_DCLK_1];
+
+	gpu_metrics->throttle_status = metrics->ThrottlerStatus;
+
+	gpu_metrics->current_fan_speed = metrics->CurrFanSpeed;
 
 	gpu_metrics->pcie_link_width =
 			smu_v11_0_get_current_pcie_link_width(smu);
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
