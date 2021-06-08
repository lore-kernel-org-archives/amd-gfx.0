Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935C1C4743D
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 15:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6720460231
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 15:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6720460231
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A231E6EC15;
	Tue,  8 Jun 2021 15:08:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62D1C6EC18
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 15:08:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGaxvQQ9ak43BvPA83zq1D6hzWlKIAxOsgd21CkxHSZtllbYjCjgqa/ULgYOV8+1zDy8hvzG0g6kU8TZLLc3rTdQo61bFlsJ9Sqmv839P5mUZHbcG0dGofmqh2dURwHsWKSX84Hgmo5Z02CFxTCHTvjFJHJ30g3tiBzCa8MuNJGNW8aXraSJKmUCQ3GYD1DEflsev3vIL75aNCOTV37lJED0s9lr3KYb3ecoe/8zjVxE08mFZSpbVaBAmGP5bovcesJWIss3PExJsgyQAPMiTl84nXkxaT6XTSqApXq22i4I1lt+5XZoS+smnrxyKy9oQF7yL1DQ0MG09Q58R1o9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sPCiWHBeubiN6nuSUitAEQ75gp9BvBX1dlngNb2pqg=;
 b=l9MWC4LLXYsroSyMpAFdDnSLX+AbYtqZeqzfWFqF2B25tIjUEUgMk8zgrMYdstvynTiSuO71nbT2lSpa0xSAH3DAd+KCd1j8P0gqx5k3xquhOJErK75516R0G47Wt7Oz6g21zRPmAmFQh5Dn1TIleY0npfOnIMerdtjpc0GuXJUCnMzZBLypoDO9QwSRWs2XQ6HbF1ktqvFncBBt/LQVskx0j+ggK3iHe/p5X+gZ7+uOSbOmRlKd7ggqXUa9XOndrRbg6DQQGOm0ns1tDmixuC1s36NCtPrzS+JEXPmsgwXs2ggiZ+yXlvh9U2D7KWf1WufudWKr0tmZ0wH2Rs6l6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sPCiWHBeubiN6nuSUitAEQ75gp9BvBX1dlngNb2pqg=;
 b=Cj8l7nYh1yJZ+aj5Jmgmyk19/gxAOdFbHUAWadONot19lG4NDYnQ1LWL5pf4qnv4G+drtSm89KO0PyWzmkT66uoFlYFr6TxQx7SiIG9xoqq+yIEkhQ8eB0yrcEKetWZl5QArYE7wyvuRSFrwmBoeJMIrHn1gC4MoQ9uaPeP8shM=
Received: from DM5PR22CA0023.namprd22.prod.outlook.com (2603:10b6:3:101::33)
 by BYAPR12MB2901.namprd12.prod.outlook.com (2603:10b6:a03:138::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.29; Tue, 8 Jun
 2021 15:08:33 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::1d) by DM5PR22CA0023.outlook.office365.com
 (2603:10b6:3:101::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Tue, 8 Jun 2021 15:08:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 15:08:32 +0000
Received: from grasider-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 8 Jun 2021
 10:08:30 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 9/9] drm/amd/pm: Add aldebaran throttler translation
Date: Tue, 8 Jun 2021 11:08:10 -0400
Message-ID: <20210608150810.9679-9-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210608150810.9679-1-Graham.Sider@amd.com>
References: <20210608150810.9679-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccda56fa-b75a-4e0c-c8a4-08d92a8f4841
X-MS-TrafficTypeDiagnostic: BYAPR12MB2901:
X-Microsoft-Antispam-PRVS: <BYAPR12MB29016DB3386062DB3119C10E8A379@BYAPR12MB2901.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lhmQZAje5A8fFeibQyFd/PduDIDuHza+PaDBf0feUbAeuiD9es1pgLWkLl7cAvuu/KE+PT1WYbe4KPJh2suRoQat4qOrePhrUmuJr5U/2gELKxWCFQJYBnjiK67lLYfOQl/uV7nlTfxR/bzPTPILZoHfih8tpRSEWT0FV7hgWXrD9rPnfIYmigVPlHLMKNSc36/LNpv840M0oYZhoyZJbRHClwcx9IXXg2yo4G/X1BjQk4qEK9KyR3MoSorjuQFORzzfocvwNu2zPEzSIx0emsW/JKagJR0acXsZAkDS4wj0rmQqMih8daa3Bo5EwS7rroFR9kp0+edzNpZ7ubmnZZDBZSpHF0ohK8EGO+a1ImKRIlVG1Gu0JwJWCaJNcXq0gyaG3mQLmOs3Hh694fAqiQ4wKKgTJov2Y3KOwsV0QLsiEDZoMqU/3stnSHWLjvT+RVwcnB8sZbxVV3H2R2cHqlbozCINbMaYJ2r4qbAOM8WP7S9EKjO34Kr0InegWn2ze3mewlsHtG1ursgjpOnmef8y5q+U8USR0ii4Z8mbnL8q8YL2Ed71EnYkKmretEHLAbk2wrCxeCB0v95BXzWMps00Q+QOYd2icPqeakbD2JEZELkxF5N60AeP2p199A8DfsvZRLXdEf7gKgbr0+jUjnpLKUO+oXGXpnmwrHiJWUsRPCxITV0SXUtFMiUDEVmi
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39850400004)(396003)(46966006)(36840700001)(186003)(86362001)(82310400003)(2616005)(478600001)(8936002)(1076003)(7696005)(82740400003)(16526019)(6916009)(2906002)(336012)(316002)(83380400001)(5660300002)(54906003)(426003)(70206006)(356005)(81166007)(36756003)(47076005)(36860700001)(6666004)(26005)(70586007)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 15:08:32.9687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccda56fa-b75a-4e0c-c8a4-08d92a8f4841
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2901
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
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 27 +++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 7a1abb3d6a7a..0845d4b30a0d 100644
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
+	[THROTTLER_TEMP_VR_MEM_BIT]	= (SMU_THROTTLER_TEMP_VR_MEM0_BIT),
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
