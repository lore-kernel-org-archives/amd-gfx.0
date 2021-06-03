Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6902BC47096
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:17:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 380E560FF0
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380E560FF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C97EC6F4A7;
	Thu,  3 Jun 2021 15:17:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 312A96F4A9
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 15:17:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6f7FaMREBlUOf7pnE2HiuACxK4LoHA8SlztAiEm7bucD40jfIEafoXiRyhEbqoQg/1DmNYEShEcKjbnL4ZU3cVohLDa7y6+d+J/T82IxuaAjzekQheKRRunqEeXojHetXZ2f+xRGynUuXLkZbIc0wDUnUSEsZV3XAyabgZfEnwrRl9nXiAgr8wZMIT1BZAyc1qfiTm64cLaPtE1YpAmMO+A7TIkYGPy1ZbSKDEpjMngdIhCjokqEnU18Gxv40YgnkDPAqtcvGsmNgsbw8M2SHuMgXkCRLY7DPFGYbB4+HVPRhLN325T0/0BfzI0b3dgot72Ny5a7XpC+qeociK02A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDrb9i/SwXW7l2L3fF1v6Zn8jmYR3Oy/VRFUpRB2Wxc=;
 b=KbdlGR6r1ebc21m2tkcwQggjNjlR2wL8tW+GjKJnSD/7RJAdV/bldKUKWSfoHxrKZKiCyJz8sMJMISSz1hajSEYTmLOr+nR0G7OwQRuaQerXBWyWwo5DfRB1HW46WPYGS4wm4ADoSKZOcrpstI4XUeG4KJZRQYH+yLgBcC91gGofn3K1haJVFOtPq3on9XOcokbeQ+M7o+bJNR4oBESxKuPrqLjkU9DWFGTPUJK/izzXt4zsV2co/vJwOwcgHjCdlgqpmUuHH/Wgh2OJdsV3MSldEnKDyZoK0L/DS49hz/CAqImPxycYD6jzB0/YQ/IZb43lhWDfPHmlMlvvYJQ3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDrb9i/SwXW7l2L3fF1v6Zn8jmYR3Oy/VRFUpRB2Wxc=;
 b=1JIVtfi1vxkhRBCVegGzZVc+YzA5oa6s+rwyZyrinsUVPXFVI5+9uyAO/xxkCZssofLP+bFjm1lq7hMlqL4Zsdvw2/f8onxKIN1U0fVSpqHwWhEN5OPQ79K6Kv2D+vnOzEUBKK3BlW3TUHU2/waK6a3UWqHYyf3sKVE2n7zTVt8=
Received: from DM5PR2201CA0012.namprd22.prod.outlook.com (2603:10b6:4:14::22)
 by BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 3 Jun
 2021 15:17:41 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::f4) by DM5PR2201CA0012.outlook.office365.com
 (2603:10b6:4:14::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend
 Transport; Thu, 3 Jun 2021 15:17:41 +0000
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
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 15:17:41 +0000
Received: from grasider-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 3 Jun 2021
 10:17:36 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 9/9] drm/amd/pm: Add aldebaran throttler translation
Date: Thu, 3 Jun 2021 11:16:42 -0400
Message-ID: <20210603151642.14014-9-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210603151642.14014-1-Graham.Sider@amd.com>
References: <20210603151642.14014-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e476c162-fc6c-44f5-e856-08d926a2bb30
X-MS-TrafficTypeDiagnostic: BY5PR12MB4243:
X-Microsoft-Antispam-PRVS: <BY5PR12MB42434A35B4B386BFB4232B038A3C9@BY5PR12MB4243.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IExWrg/WdqX9ynJWkX4Xsl88zAILNt0+MHM2L1BZrrRdLGddhQ7RKuvSgFaeLMPlVROyNVc+z2Pfpp1i7cTxpq48UeGrQuBOuYbimjAM1mnDAIiY4z/+UR8C4LzoPmIda5ixlxAS+OiW58m1Yo5E1omruBeQqtcIgZtiqOTDwWItWWnPmd9HCa2Bt4Z/qiync0+YYGwdcJKxEgSy/aZuIFxkakdb22GnKE+WHcxaaBFukCV27qjhAuIYmb+/wD6SNslmmt8XNDlcfUqA7kPLGqH9yNQ7/a2AcWnN0Txh0byJU9xC+ukvpDl66zSnKsCt075eOMJLHP93bnJqc2p08cU6+iUndAFAJGz7kdsc7VZyDqc1T3R6TfVp7cLClJyPfvot4va9p0TME8YLou78zUiBUtFuupnMK4BnCYgQzW8wHH1WktaobdpOm3IULCrwLCccf3hWxOErkT4dlWCYCd+utPWiquUwFCuxRAkLwLlALsQTKJ93DUmkrpc1lzuxQXUEZ+6IXg7y2rl7JX20bxTaLwIxITrCH1p2TYP2FsJUHj1/fTLQ6JZgOJHnKRpMaDnHubOaDq56hTlAzuTXBrXz6w+LId7jLiYMGgjZqUFvn4mxtaScmSplgHhS+py+06PyIzn+EF+fFIr0uDs0SttfVeNbedvwGq20zalt7iVDOqfhHuc3SAZYvm0KUJ+e
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39840400004)(36840700001)(46966006)(5660300002)(83380400001)(478600001)(1076003)(8676002)(36860700001)(336012)(82310400003)(426003)(6916009)(356005)(8936002)(316002)(16526019)(86362001)(2906002)(6666004)(70586007)(70206006)(7696005)(54906003)(186003)(4326008)(36756003)(2616005)(47076005)(26005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 15:17:41.5688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e476c162-fc6c-44f5-e856-08d926a2bb30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243
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
for aldebaran.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 27 +++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 7a1abb3d6a7a..4f1a2a4debd3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -191,6 +191,20 @@ static const struct cmn2asic_mapping aldebaran_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP(I2C_COMMANDS),
 };
 
+static const uint8_t aldebaran_throttler_map[] = {
+	[THROTTLER_PPT0_BIT]		= (SMU_THROTTLER_PPT0_BIT),
+	[THROTTLER_PPT1_BIT]		= (SMU_THROTTLER_PPT1_BIT),
+	[THROTTLER_TDC_GFX_BIT]		= (SMU_THROTTLER_TDC_GFX_BIT),
+	[THROTTLER_TDC_SOC_BIT]		= (SMU_THROTTLER_TDC_SOC_BIT),
+	[THROTTLER_TDC_HBM_BIT]		= (SMU_THROTTLER_TDC_MEM_BIT),
+	[THROTTLER_TEMP_GPU_BIT]	= (SMU_THROTTLER_TEMP_GPU_BIT),
+	[THROTTLER_TEMP_MEM_BIT]	= (SMU_THROTTLER_TEMP_MEM_BIT),
+	[THROTTLER_TEMP_VR_GFX_BIT]	= (SMU_THROTTLER_TEMP_VR_GFX_BIT),
+	[THROTTLER_TEMP_VR_SOC_BIT]	= (SMU_THROTTLER_TEMP_VR_SOC_BIT),
+	[THROTTLER_TEMP_VR_MEM_BIT]	= (SMU_THROTTLER_TEMP_VR_MEM_BIT),
+	[THROTTLER_APCC_BIT]		= (SMU_THROTTLER_APCC_BIT),
+};
+
 static int aldebaran_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -213,7 +227,7 @@ static int aldebaran_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_2);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_3);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table) {
 		kfree(smu_table->metrics_table);
@@ -1713,8 +1727,8 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 					 void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_2 *gpu_metrics =
-		(struct gpu_metrics_v1_2 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_3 *gpu_metrics =
+		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int i, ret = 0;
 
@@ -1724,7 +1738,7 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 2);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -1755,6 +1769,9 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			smu_cmn_get_indep_throttler_status(metrics.ThrottlerStatus,
+							   aldebaran_throttler_map);
 
 	gpu_metrics->current_fan_speed = 0;
 
@@ -1776,7 +1793,7 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 
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
