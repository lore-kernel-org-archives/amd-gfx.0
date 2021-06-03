Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E355C47082
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:17:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDAAE61208
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAAE61208
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B01796F4A4;
	Thu,  3 Jun 2021 15:17:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F38066F4A8
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 15:17:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmuUb6QvRtLsmhfltzUv/CFBXF2uRkRR3strXSh1JEHwG/V5W6/isTBj8FEPd1aCN8MYq9Oo70fsLO+ik7pPn3pvjm/o6yiWTrx07KiyfD0wXtDldTVg0aK6pEgQ/CL5w4lmPn/CHwzB13h+wnHHxGmuXp46h/IdCUbsOepUVau4iUdfMA71TPAz5EwleIC2oe9IQPEHVb9X6uEzVO6JoPee/ORvEnfcUcAjkSFRkoMXxpZNIPLX2lJK6zbiR4KBeqD+Oo6WTd1YIvVmxBB9XVvWpS9ulsG1NQOezvkViJqT43Ng7JmTJz/DgPkc/rUmdoSdrvTXcuo1H0fDRuWtjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWq5k7b1MzcGaibtD1oFcHVQhQq5g3xKml8An8J0I5o=;
 b=DTwM+O0wYXe97YrfqrbdGfptPm9biiaD3cdqU3mnV42LXdL6eD+HGflZu91JSh6T363NTtjbBBaDcup0krGuA9EikhIHe4Q4WEQQJBGzvU0YIfPDHl2/JepRyUkS7TRZw+psPhes6vz4Cb/KGrn9h0FgnolW+WdnxE4WCG3I/K6gualS2e/U5D+3x1ExK/yiYVJXkwpDdpE3tTY1AVQRvjtarR7BvQQjqTgHhWTAmwkH9l8VyFUeFtdIBOet3rVbBV60ayMVVhFMY+ty9DW5KS3W3+wQ56fDpDyPeFfGk3wOj3egNmqVDgw3fv8MhQ6DjysvmoUWYaCfCbdXfL74rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWq5k7b1MzcGaibtD1oFcHVQhQq5g3xKml8An8J0I5o=;
 b=SURFWo/3wkeS6uaqnMqNJDMCzCL795IWlnoF62bsjcJFaaIH94E8bQHdnvxtJ8ajKtZobrzQhR3BicxD3NcIajbrVXOhL87fMaIRhJvMxs7e7QpoMZ2S/PNlp5fTkwfuviizNNkwzsB2p6boml4zlRpsLoaXiisfOWzicNqEttQ=
Received: from DM5PR2201CA0019.namprd22.prod.outlook.com (2603:10b6:4:14::29)
 by DM6PR12MB4893.namprd12.prod.outlook.com (2603:10b6:5:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Thu, 3 Jun
 2021 15:17:41 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::43) by DM5PR2201CA0019.outlook.office365.com
 (2603:10b6:4:14::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
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
Subject: [PATCH v4 8/9] drm/amd/pm: Add renoir throttler translation
Date: Thu, 3 Jun 2021 11:16:41 -0400
Message-ID: <20210603151642.14014-8-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210603151642.14014-1-Graham.Sider@amd.com>
References: <20210603151642.14014-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecc1bcc4-2c65-4815-b48a-08d926a2baf0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4893:
X-Microsoft-Antispam-PRVS: <DM6PR12MB48935F819EF9383290C21BDA8A3C9@DM6PR12MB4893.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gvb2PLGxI90xvsXAEEAfBDvygeamxeExXN8ociam8WZn84ZifGrV8DtQw+gWGGJYQwfV04MznrbBSn6g1Y9z50a7uW+cdNHi0UfpdMDRz5uvmnK6KbHTYM2RrQnSol+4lq9ClsE5aWPTH9/VLTH0fGdCOhONENwSqcGkv8Qu/cTYWSh1QE96w/kdci2yCibJQZ4nRwEh/0A+WPxMCXiyH2XtN9DO8kFjmn3LQYCz6dRDlhxsi+Z8mgbKLFROpju0JE66rK2Scvt+Sj2o1LlqpZir1K0luUd5fzH3FxjHb465QosqJQczdvC6ShNAGEO74RhH9+spdKk8zqyff0TyMTvgkigQQBhypwRRlmGGfExpxu6kyfT5iyKnrpU2AykiBA0sKlHdTUJPYl6PjPRMoJgvRUN5epq4+DLy7SD//6xZwlNqNrs6qRW8LRqyaueVkNNoRoPXatI/gLCWRhKSJF7Y6EnvGQUYx9Ds2wtNOnZTNZ/zOCy4WsuxED1JV7a6eUrR7E3aFCc6BhJkjq/GoHo0p+y3BiyFS7GvRgjGa3owyofGMQ7oPRUix7t3eMIiRs0ee9OF+IlVVM9zPAwZns58sUI94Yv1jtM90iVvH/BkRuOyMFo63XNDGyVq6r4o7leoKnk7tcHYaWPOx4aTjsDP/t5bWxGNE+IRcMLxrYMI8P7Pq5gecGCmh0TaXacJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(36840700001)(46966006)(356005)(5660300002)(82740400003)(336012)(6666004)(7696005)(70206006)(81166007)(83380400001)(54906003)(26005)(426003)(6916009)(2906002)(36860700001)(36756003)(8936002)(4326008)(1076003)(82310400003)(47076005)(2616005)(316002)(478600001)(8676002)(70586007)(16526019)(86362001)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 15:17:41.1430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc1bcc4-2c65-4815-b48a-08d926a2baf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4893
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
for renoir.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 29 +++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 1c399c4ab4dc..6af67d372926 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -128,6 +128,22 @@ static struct cmn2asic_mapping renoir_workload_map[PP_SMC_POWER_PROFILE_COUNT] =
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
 };
 
+static const uint8_t renoir_throttler_map[] = {
+	[THROTTLER_STATUS_BIT_SPL]		= (SMU_THROTTLER_SPL_BIT),
+	[THROTTLER_STATUS_BIT_FPPT]		= (SMU_THROTTLER_FPPT_BIT),
+	[THROTTLER_STATUS_BIT_SPPT]		= (SMU_THROTTLER_SPPT_BIT),
+	[THROTTLER_STATUS_BIT_SPPT_APU]		= (SMU_THROTTLER_SPPT_APU_BIT),
+	[THROTTLER_STATUS_BIT_THM_CORE]		= (SMU_THROTTLER_TEMP_CORE_BIT),
+	[THROTTLER_STATUS_BIT_THM_GFX]		= (SMU_THROTTLER_TEMP_VR_GFX_BIT),
+	[THROTTLER_STATUS_BIT_THM_SOC]		= (SMU_THROTTLER_TEMP_VR_SOC_BIT),
+	[THROTTLER_STATUS_BIT_TDC_VDD]		= (SMU_THROTTLER_TDC_VDD_BIT),
+	[THROTTLER_STATUS_BIT_TDC_SOC]		= (SMU_THROTTLER_TDC_SOC_BIT),
+	[THROTTLER_STATUS_BIT_PROCHOT_CPU]	= (SMU_THROTTLER_PROCHOT_CPU_BIT),
+	[THROTTLER_STATUS_BIT_PROCHOT_GFX]	= (SMU_THROTTLER_PROCHOT_GFX_BIT),
+	[THROTTLER_STATUS_BIT_EDC_CPU]		= (SMU_THROTTLER_EDC_CPU_BIT),
+	[THROTTLER_STATUS_BIT_EDC_GFX]		= (SMU_THROTTLER_EDC_GFX_BIT),
+};
+
 static int renoir_init_smc_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -153,7 +169,7 @@ static int renoir_init_smc_tables(struct smu_context *smu)
 	if (!smu_table->watermarks_table)
 		goto err2_out;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_1);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_2);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err3_out;
@@ -1264,8 +1280,8 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v2_1 *gpu_metrics =
-		(struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v2_2 *gpu_metrics =
+		(struct gpu_metrics_v2_2 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -1273,7 +1289,7 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 2);
 
 	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
 	gpu_metrics->temperature_soc = metrics.SocTemperature;
@@ -1311,6 +1327,9 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_l3clk[1] = metrics.L3Frequency[1];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+		smu_cmn_get_indep_throttler_status(metrics.ThrottlerStatus,
+						   renoir_throttler_map);
 
 	gpu_metrics->fan_pwm = metrics.FanPwm;
 
@@ -1318,7 +1337,7 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v2_1);
+	return sizeof(struct gpu_metrics_v2_2);
 }
 
 static int renoir_gfx_state_change_set(struct smu_context *smu, uint32_t state)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
