Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BA1C47096
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:17:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 249BA61208
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249BA61208
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A1456F4A9;
	Thu,  3 Jun 2021 15:17:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 223AB6F4A7
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 15:17:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQ8auRFFWNOJrScGLJa7WxYFY12FQt+QQKLHUlyLW66xEy+0NFhzYBPUH4eDnh/i6cHYG1WHa0eJEOdx4rNKLSM5EkK9Itbc+nHHW1lWTseqGi84aPznshHcsuaqvtPaSRAdLf9o8KvsHHQ5Np6oLIbDtTL8ODvmQMccGSHARmZo5BrwzTCFG96LSwickKdrYJAGdW6eKPb/lluUHm2SwPMaGLeI9G/9VdTSbjx+dM2pEgcIrv2us6nVcD7mzCyovjxREnxAazJVJKV2N4nrnzaTh01Nu9xE5yzZPV5rFaAnb+NJ6YT2BVYS1ruC1x7C2rf02Fe+uswZ3qKHxxDnzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCZenDih20mYwPB4MQpwpnas4y7Tpl7ffgknHbsLgOQ=;
 b=ElLCBYlfKyxaTNtqdqwHDSfIhWq+Ou5HlYk+xNgVAkBd5pQUJ7YL8C53VEtq25AChaE3kAqslW8CyRoBjOEh3Edu/Os3RrVK9UyZUEfBcNzIj9OY5sai/prhTHB00Aa1hZBF173NrqzkNL8mQRBwHUjDvddWThJ5hnW+SHLTh0UKZ1EqZmJK8k0UqDeYFHE/35gh+XMBGysH47nWgc3XlxoLwP65qkOAp9lVp49dsg1r3uprgyweizBcTS5SEt/nq82O/ZhKZ+kqhbVbdOVQ7NXU6gtrMaeR/eRfHmrTuqlkur5JpfyVAGGEWInLLLFhyKBK9EBl0dTepGEwLkpLlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCZenDih20mYwPB4MQpwpnas4y7Tpl7ffgknHbsLgOQ=;
 b=J7JeF52gnjKpxmzHEhUnXlbZn1el4IDNJBcwRUIn8EcGFL51LNZGkYeoPiAzpaM77cSlgjk7AnYBD8niIqgtHHiDHFIA1JfGCYhfFzfGKiyj3FVZUZNZ4lDrnD+XNChOKqCGqF4oNKByFGbKNK/2+Db5DsbFgzO+HtHpQBEXitY=
Received: from DM5PR2201CA0014.namprd22.prod.outlook.com (2603:10b6:4:14::24)
 by MN2PR12MB3006.namprd12.prod.outlook.com (2603:10b6:208:cd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Thu, 3 Jun
 2021 15:17:40 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::5) by DM5PR2201CA0014.outlook.office365.com
 (2603:10b6:4:14::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend
 Transport; Thu, 3 Jun 2021 15:17:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 15:17:40 +0000
Received: from grasider-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 3 Jun 2021
 10:17:34 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 6/9] drm/amd/pm: Add sienna cichlid throttler translation
Date: Thu, 3 Jun 2021 11:16:39 -0400
Message-ID: <20210603151642.14014-6-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210603151642.14014-1-Graham.Sider@amd.com>
References: <20210603151642.14014-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e57e409-1bca-4ed7-7ee4-08d926a2ba51
X-MS-TrafficTypeDiagnostic: MN2PR12MB3006:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3006E8A8D78E2117692EBD808A3C9@MN2PR12MB3006.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xkAxAwMF+dEuLM6FENMGQleQxLi4UeCUAiK/cRC5ZRpq7NSLpYj51jJYJkHtZnz2PNE0lA43vG7HtusF84Bxg9sYe+RBT05sy3Vb38D6dCufzLzibH9+vnY4/hT5c/K2/amV2RVgBLfmqZj9Ld2s7p6Syw7BX/AcTFb//kcyJGC14A1kHn05aWmKM+2Y361taTcsU3OSJLFaK8QFtXcb4M211foj9+c+ov6XYlLtGxJohtQT6D5LoCBn37K12PpqRJn+83shUZHnjXKWkX2jpogUWlhjsbgF8B3nqwEVlPMvopASoG8wJu++BYSkTDwmFLe9C6tSLyzKKaKqCntSBfoyeWN/eUBp9mn/Ymef2D7nItDgc2SLGh1XSSiwpirHS+wnqQgNkLGCgMDtg7WQiYHDEgHrkYGJyQpz1H3OafDvjpMXLcKO74ed/XApJ0UXrwK8M1D8YG7X2ABWSBulkjC5UnApfMKVye3Fcw5avFOMdPaDX/DlEFKDfEolWeUWEVpRaLeyiMoJS337Jj5ODWrMoL6kX/ypnjpsfik3vrpYxWXG84uMNJPalvDiUBeFeM5i5S9ps9rFyaGNupiosg3sByLIqLT/HH3e7v4uZLBYTTzkte86JSt0DehwMZ3TQCiXwI8y6M3CD48Zn08rQa4b1ouKA8KOnQr8zT9mLXodvKGOjsGBDLXWoNOLSPYL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39840400004)(136003)(376002)(46966006)(36840700001)(426003)(70206006)(8676002)(6916009)(70586007)(2616005)(7696005)(54906003)(86362001)(81166007)(336012)(5660300002)(1076003)(36860700001)(36756003)(83380400001)(4326008)(26005)(186003)(356005)(478600001)(16526019)(2906002)(316002)(8936002)(82310400003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 15:17:40.1026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e57e409-1bca-4ed7-7ee4-08d926a2ba51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3006
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
Cc: Lijo.Lazar@amd.com, Harish.Kasiviswanathan@amd.com,
 Graham Sider <Graham.Sider@amd.com>, Elena.Sakhnovitch@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Perform dependent to independent throttle status translation
for sienna cichlid.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 34 ++++++++++++++++---
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 75acdb80c499..1bc5d8084fbc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -239,6 +239,27 @@ static struct cmn2asic_mapping sienna_cichlid_workload_map[PP_SMC_POWER_PROFILE_
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
 };
 
+static const uint8_t sienna_cichlid_throttler_map[] = {
+	[THROTTLER_TEMP_EDGE_BIT]	= (SMU_THROTTLER_TEMP_EDGE_BIT),
+	[THROTTLER_TEMP_HOTSPOT_BIT]	= (SMU_THROTTLER_TEMP_HOTSPOT_BIT),
+	[THROTTLER_TEMP_MEM_BIT]	= (SMU_THROTTLER_TEMP_MEM_BIT),
+	[THROTTLER_TEMP_VR_GFX_BIT]	= (SMU_THROTTLER_TEMP_VR_GFX_BIT),
+	[THROTTLER_TEMP_VR_MEM0_BIT]	= (SMU_THROTTLER_TEMP_VR_MEM_BIT),
+	[THROTTLER_TEMP_VR_MEM1_BIT]	= (SMU_THROTTLER_TEMP_VR_MEM_BIT),
+	[THROTTLER_TEMP_VR_SOC_BIT]	= (SMU_THROTTLER_TEMP_VR_SOC_BIT),
+	[THROTTLER_TEMP_LIQUID0_BIT]	= (SMU_THROTTLER_TEMP_LIQUID_BIT),
+	[THROTTLER_TEMP_LIQUID1_BIT]	= (SMU_THROTTLER_TEMP_LIQUID_BIT),
+	[THROTTLER_TDC_GFX_BIT]		= (SMU_THROTTLER_TDC_GFX_BIT),
+	[THROTTLER_TDC_SOC_BIT]		= (SMU_THROTTLER_TDC_SOC_BIT),
+	[THROTTLER_PPT0_BIT]		= (SMU_THROTTLER_PPT0_BIT),
+	[THROTTLER_PPT1_BIT]		= (SMU_THROTTLER_PPT1_BIT),
+	[THROTTLER_PPT2_BIT]		= (SMU_THROTTLER_PPT2_BIT),
+	[THROTTLER_PPT3_BIT]		= (SMU_THROTTLER_PPT3_BIT),
+	[THROTTLER_FIT_BIT]		= (SMU_THROTTLER_FIT_BIT),
+	[THROTTLER_PPM_BIT]		= (SMU_THROTTLER_PPM_BIT),
+	[THROTTLER_APCC_BIT]		= (SMU_THROTTLER_APCC_BIT),
+};
+
 static int
 sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 				  uint32_t *feature_mask, uint32_t num)
@@ -434,7 +455,7 @@ static int sienna_cichlid_tables_init(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_1);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_3);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err1_out;
@@ -3617,8 +3638,8 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 					      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_1 *gpu_metrics =
-		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_3 *gpu_metrics =
+		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
 	SmuMetricsExternal_t metrics_external;
 	SmuMetrics_t *metrics =
 		&(metrics_external.SmuMetrics);
@@ -3632,7 +3653,7 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics->TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics->TemperatureHotspot;
@@ -3667,6 +3688,9 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk1 = metrics->CurrClock[PPCLK_DCLK_1];
 
 	gpu_metrics->throttle_status = metrics->ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			smu_cmn_get_indep_throttler_status(metrics->ThrottlerStatus,
+							   sienna_cichlid_throttler_map);
 
 	gpu_metrics->current_fan_speed = metrics->CurrFanSpeed;
 
@@ -3689,7 +3713,7 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_1);
+	return sizeof(struct gpu_metrics_v1_3);
 }
 
 static int sienna_cichlid_enable_mgpu_fan_boost(struct smu_context *smu)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
