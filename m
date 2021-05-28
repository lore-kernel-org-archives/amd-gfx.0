Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68939C47087
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 20:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34060613AB
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 20:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34060613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F21D36F624;
	Fri, 28 May 2021 20:01:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CF886F624
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 20:01:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fnll2qKb6zi4yGQT0LSFgHBGSm1BGh1GycpKiojAVpG/EVnlN8PZ6RFvF2Cj/27uAkVyIcOQ6RFuJe1B3OIirjPiUkoDPBjb7gkK0SjEpI0ii/1nK5MPz+WH5lpdXiMoIteDekK8EREofw/nv5XJn6054oUNutbcLuQ1zRHkbJnAd93yDeGjA2nkgjeSu7MwegUSq7KE25P1FPnDyB/e1J1oCAVkaO44gfshJWWnD+QdHlgoQBKZR+k8jBttBFgjUxDSnnws5DdVjKUyCGCHs9UUhhCiR0F8J4iUxpZCZUWCwbL6W+J//FDaTAdyQXmqJMNo9QsMCSac9/r4uzSNWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uwg35nUjLDV/IU45Gqhi7p1JPWhCOIFiBbuJRd2r9Fo=;
 b=Z/90jniOfMdn5qexP9tr03MbZrgUbLqOB8VLmgICllYzgr81he4vzM0g2fKu/XRQuELKyNUjoLpFcHPLJq5/VpvnheaJ8tUmKZEpV2y0AQfp2ljrbVLr3Ua2SF0SDFEGjXpziEzeSOg3lsr7k7Zv9fVcG+B0H/BQS+g1So5LElx6o+QM/mjvUNN/yIWwa6hfml85QIO4xioJueRbd2R6eDBJGL5PIaw5XlkTcTp+Fq1ULOEN1Ivel+3dFYdBn7t9hTXVLYdTkeUGpkJ9WHH+yb1DMnoN71SqVUaVtVnzJJYFDdZy5OrTwP5N0HTMv2pGTOrNJk5+4YEAp/wuLVG6MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uwg35nUjLDV/IU45Gqhi7p1JPWhCOIFiBbuJRd2r9Fo=;
 b=X0BfXM2/FezsboqyT9jZJmY7/+HVKpE/8MB2BAQmtAmvF4FfzNG7DW3AIaWMuykZVkHrEmkaA+WZNGhI+P/4x2uF4TK9ohuRQcnOMWGH1s/IaFor7oY4Z11n7aiqQs8V6vMRLl/ZiWhX2Byu86dk7dgqyTEq2l0x9GKzfdhxUz8=
Received: from MWHPR03CA0017.namprd03.prod.outlook.com (2603:10b6:300:117::27)
 by BN7PR12MB2723.namprd12.prod.outlook.com (2603:10b6:408:2d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Fri, 28 May
 2021 20:01:21 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::9) by MWHPR03CA0017.outlook.office365.com
 (2603:10b6:300:117::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 20:01:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 20:01:20 +0000
Received: from grasider-dev.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 28 May 2021 15:01:18 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 8/8] drm/amd/pm: Add aldebaran throttler translation
Date: Fri, 28 May 2021 15:58:15 -0400
Message-ID: <20210528195815.2615-8-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210528195815.2615-1-Graham.Sider@amd.com>
References: <20210528195815.2615-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f4a44ed-ee55-46da-d069-08d922135d07
X-MS-TrafficTypeDiagnostic: BN7PR12MB2723:
X-Microsoft-Antispam-PRVS: <BN7PR12MB27232BE1B3E3507F6C0D95B58A229@BN7PR12MB2723.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Em2CMR7XCE4BfzV3lLm51wED5L5ZrYS8dUr7qRvRXQMunF5dFIQ64Qs0mtc+1U6uGxmcC5ey8MTFoAIYhH2d2X+/y5BVxXVsIdtV4lBw5okQShyJK2H4zcXOojkZTzzvsgOgbZocD+ElQbAAr0ZWRuSHO9klh/vyJnvkpgXBJWrlSEqJyki5lX5zG4wIBmPJ3dsMNRGO2ZlBxEUeSiCH1ZrUmE8lln5GPxc3U7qDLrqqzUKRd5llaJHUQ/FKyYZ5prERV4Uf4Rsj4a87v4DuuS9RzPntaC2W+Kyc4fTAtZGsqZnQU39LoMxjI7XTC26rksulUdo1lD8G6et19FI4claBitLtTfvIaBRjIintEAOK4LEsYuW29sGT7UTMOPgQ1vJccHvzGhBOs1jVLniJHJtZEbqqQU2zMhPJaDX3Lxm82AFLpdVIcf3/fbhK0z1G01i6gS8rbevVMpZo9F8SEuQK8i44NJ+Hv2Kxwez5Xt3kqNySA9J3AH4LCo774DhK4hIWgwxl6HU8c68zYBhBQKF/0sU6szG7uS3IdFwgmiZt3JJYAqOaIatyX/eW0yqmF7EfDeIz+vSr8qklaW6kdoiRAz8hiPeTDGQjmHF9oXCZ4IKhtZeBvKlxduGVD22arilL5WviLXTaJKzVvoy2jCP6Y3V1d4VbB/OU44CXS1k/0td/qheOBDzko6G28qib
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(46966006)(36840700001)(8936002)(2616005)(4326008)(82740400003)(6666004)(82310400003)(81166007)(478600001)(86362001)(2906002)(356005)(47076005)(83380400001)(36860700001)(36756003)(316002)(1076003)(6916009)(54906003)(336012)(26005)(186003)(16526019)(8676002)(70206006)(426003)(70586007)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 20:01:20.8512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4a44ed-ee55-46da-d069-08d922135d07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2723
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
Cc: Harish.Kasiviswanathan@amd.com, Graham
 Sider <Graham.Sider@amd.com>, Elena.Sakhnovitch@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Perform dependent to independent throttle status translation
for aldebaran.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 46 +++++++++++++++++--
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 7a1abb3d6a7a..a83f1c4673aa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -213,7 +213,7 @@ static int aldebaran_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_2);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_3);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table) {
 		kfree(smu_table->metrics_table);
@@ -517,6 +517,40 @@ static int aldebaran_freqs_in_same_level(int32_t frequency1,
 	return (abs(frequency1 - frequency2) <= EPSILON);
 }
 
+static uint64_t aldebaran_get_indep_throttler_status(
+					uint32_t dep_status)
+{
+	if (dep_status == 0)
+		return 0;
+
+	uint64_t indep_status = 0;
+
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PPT0_BIT, THROTTLER_PPT0_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PPT1_BIT, THROTTLER_PPT1_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TDC_GFX_BIT, THROTTLER_TDC_GFX_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TDC_SOC_BIT, THROTTLER_TDC_SOC_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TDC_MEM_BIT, THROTTLER_TDC_HBM_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_GPU_BIT, THROTTLER_TEMP_GPU_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_MEM_BIT, THROTTLER_TEMP_MEM_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_VR_GFX_BIT, THROTTLER_TEMP_VR_GFX_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_VR_SOC_BIT, THROTTLER_TEMP_VR_SOC_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_VR_MEM_BIT, THROTTLER_TEMP_VR_MEM_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_APCC_BIT, THROTTLER_APCC_BIT);
+
+	return indep_status;
+}
+
 static int aldebaran_get_smu_metrics_data(struct smu_context *smu,
 					  MetricsMember_t member,
 					  uint32_t *value)
@@ -1713,8 +1747,8 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 					 void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_2 *gpu_metrics =
-		(struct gpu_metrics_v1_2 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_3 *gpu_metrics =
+		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int i, ret = 0;
 
@@ -1724,7 +1758,7 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 2);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -1755,6 +1789,8 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			aldebaran_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = 0;
 
@@ -1776,7 +1812,7 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_2);
+	return sizeof(struct gpu_metrics_v1_3);
 }
 
 static int aldebaran_mode2_reset(struct smu_context *smu)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
