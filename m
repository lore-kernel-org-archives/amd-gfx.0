Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38F9C4743E
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 15:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D4D46128A
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 15:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4D46128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 598BD6EC0E;
	Tue,  8 Jun 2021 15:08:31 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2088.outbound.protection.outlook.com [40.107.96.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9A5D6EC05
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 15:08:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLJLAriGV710zmOBq3dzw3AQp7BG4XoCnmhQDRNcUwYmAgJvAGgFX/w4IOKGPF31Bc76+3+QYYIk6IfyCxUFsxPAacSlsBu763lIyrlO8qL0Hht9/EqxVRaVxC6U7mAoNKWhRMn8B0nS8p8cwsEV5HyYPJBFQmrub17SVNUAZ9T/v7Ob5NQWt1KHRVgCXOupf5WgMISuzEvzSMr+gwhJ7GRR2FRSlLv6fXSb1Dh/pYPnLCkKQm+JT8LbvPTIcqu6Zzr3Fl/cc2bXPpZdUT+ayTh1hunAt9ldqpRVwMboQZsHtTPraXVQgepNIhVqLZrHMUp9Dxq2qNshiohohYIs3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eshc9jGWpsvWwSc8+/8g1hZZ1+UHdT1XuafgMtiP/mQ=;
 b=O6XQTB5WvQskpAbB4NZQ9DrRJJb7/GxPkZ2G0g5hQzJQYZTj1SZFdAFokWCx0nqI5fhvT2krxGAme47ULojp/QEnV9f6XiAg3tzj7FczKtlNdo29ngg01CUHq+/8S7KFaJrWfWab8F+Aqc2kAlkQB2fKkrDOx/Jr4tUAmZxZUHdNdBI1NuJBI0rpavu30xlelzjx+gihp/FdYFSKQlAhUuWcW2z1lkvYH6W8vCOgmCrRXINexoKSmpYJJnnSxVwlfAkRjWeKjpg7j8SqQxCElG22zcY/cERks7u42C34tFh1OH1YzRXe+3V+do0pZKNjgPnupqlGU6suFP68TRINYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eshc9jGWpsvWwSc8+/8g1hZZ1+UHdT1XuafgMtiP/mQ=;
 b=eqqOCUr528gcAUoevs0jX9Kb6tTpK2aUL+GsgAKo4B8Infb3zDD+17WmSCtzU6QegjbgnUZDFuOkf2JFhk47YMbyKk5WYCw2QQL59+n5Nl5fHspGLOu6Q2G1B77pHMqInNvOaEYlQixlTnkDbUWxVDhCbFqhbyfgahQhaS6wEq0=
Received: from DM6PR03CA0073.namprd03.prod.outlook.com (2603:10b6:5:333::6) by
 DM4PR12MB5326.namprd12.prod.outlook.com (2603:10b6:5:39f::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.20; Tue, 8 Jun 2021 15:08:28 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::c9) by DM6PR03CA0073.outlook.office365.com
 (2603:10b6:5:333::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Tue, 8 Jun 2021 15:08:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 15:08:27 +0000
Received: from grasider-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 8 Jun 2021
 10:08:25 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 4/9] drm/amd/pm: Add arcturus throttler translation
Date: Tue, 8 Jun 2021 11:08:05 -0400
Message-ID: <20210608150810.9679-4-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210608150810.9679-1-Graham.Sider@amd.com>
References: <20210608150810.9679-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb7f8360-88b5-489c-f30e-08d92a8f454c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5326:
X-Microsoft-Antispam-PRVS: <DM4PR12MB532695E79853921F1BE9EFC88A379@DM4PR12MB5326.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u5pFyU3gMQqln+7IFru957c1/JDETuvOwcRJN4ssqOxL56o2+qeBrFcM0/I3Rj2P7IhGCQ69bQYdi6ODQFLWQ6p8F5TmMloprHS2aLEEOpupZpgtqqs9qb4EbI3zljYcXpDalzR3HWHyCsQL7NjT2Ikotm3hWQS7tOtZkifPCpkne/+6lgUc2hFsJc/DNYnh2xoF2hSH0wfefzDATVu2P4IuQX2vkO/urQLe98bQTglvly4FNmXUOc+QkxQ3jOgCTFF2qwBTUAkOo7Owyx9x/QuGnOXMMLMySuqs/JuGJtY+Oq1VYktumTGoCOMAuBBeL9G06E/8lV8gRV3VEx4hdW5vfBSPPJSxg6bxDTeKz1NKivZGGMzkVxf8CFCSeJx/yDGEZmXE3Z0iZi1WYQiV8q82glyNePHkU93Wx5HIOg5Qr0rbAMEnjMKHeZ22N+Onr6uRcPfzhYAlidLfAr4txGjBKg24ISfNsGOSdm73NRkw7ygbiYEH/Ab1LzXTw7R6f8ZueqjdJ04oVNhdU7sZz1khpt5iYtaUU1VX1G8clNWD2zCdQGeCU+LQeqI4/XNdlSlg6OsODvdos3ldGiMptH+gUYuNoZfxqqx1T7EsVJ4/nNc+N3xTcU7X3Ypv4EglmtZuSP0ORX9JqwBWi/CmW9TASr0pPb2XQUUqZ13MkDcrFG1AGmEPJHHYdLm2QBTD
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(396003)(346002)(136003)(376002)(46966006)(36840700001)(8676002)(36860700001)(86362001)(2906002)(1076003)(316002)(70586007)(36756003)(8936002)(6916009)(16526019)(82740400003)(2616005)(54906003)(7696005)(6666004)(336012)(186003)(356005)(82310400003)(478600001)(26005)(70206006)(5660300002)(47076005)(83380400001)(426003)(4326008)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 15:08:27.9937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7f8360-88b5-489c-f30e-08d92a8f454c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5326
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
for arcturus.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 33 ++++++++++++++++---
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 1735a96dd307..a47fc33e997d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -211,6 +211,26 @@ static const struct cmn2asic_mapping arcturus_workload_map[PP_SMC_POWER_PROFILE_
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
 };
 
+static const uint8_t arcturus_throttler_map[] = {
+	[THROTTLER_TEMP_EDGE_BIT]	= (SMU_THROTTLER_TEMP_EDGE_BIT),
+	[THROTTLER_TEMP_HOTSPOT_BIT]	= (SMU_THROTTLER_TEMP_HOTSPOT_BIT),
+	[THROTTLER_TEMP_MEM_BIT]	= (SMU_THROTTLER_TEMP_MEM_BIT),
+	[THROTTLER_TEMP_VR_GFX_BIT]	= (SMU_THROTTLER_TEMP_VR_GFX_BIT),
+	[THROTTLER_TEMP_VR_MEM_BIT]	= (SMU_THROTTLER_TEMP_VR_MEM0_BIT),
+	[THROTTLER_TEMP_VR_SOC_BIT]	= (SMU_THROTTLER_TEMP_VR_SOC_BIT),
+	[THROTTLER_TDC_GFX_BIT]		= (SMU_THROTTLER_TDC_GFX_BIT),
+	[THROTTLER_TDC_SOC_BIT]		= (SMU_THROTTLER_TDC_SOC_BIT),
+	[THROTTLER_PPT0_BIT]		= (SMU_THROTTLER_PPT0_BIT),
+	[THROTTLER_PPT1_BIT]		= (SMU_THROTTLER_PPT1_BIT),
+	[THROTTLER_PPT2_BIT]		= (SMU_THROTTLER_PPT2_BIT),
+	[THROTTLER_PPT3_BIT]		= (SMU_THROTTLER_PPT3_BIT),
+	[THROTTLER_PPM_BIT]		= (SMU_THROTTLER_PPM_BIT),
+	[THROTTLER_FIT_BIT]		= (SMU_THROTTLER_FIT_BIT),
+	[THROTTLER_APCC_BIT]		= (SMU_THROTTLER_APCC_BIT),
+	[THROTTLER_VRHOT0_BIT]		= (SMU_THROTTLER_VRHOT0_BIT),
+	[THROTTLER_VRHOT1_BIT]		= (SMU_THROTTLER_VRHOT1_BIT),
+};
+
 static int arcturus_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -237,7 +257,7 @@ static int arcturus_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_1);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_3);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table) {
 		kfree(smu_table->metrics_table);
@@ -2275,8 +2295,8 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 					void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_1 *gpu_metrics =
-		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_3 *gpu_metrics =
+		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -2286,7 +2306,7 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2315,6 +2335,9 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			smu_cmn_get_indep_throttler_status(metrics.ThrottlerStatus,
+							   arcturus_throttler_map);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
@@ -2327,7 +2350,7 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_1);
+	return sizeof(struct gpu_metrics_v1_3);
 }
 
 static const struct pptable_funcs arcturus_ppt_funcs = {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
