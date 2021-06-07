Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD6DC47095
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 13:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A7061153
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 13:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A7061153
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF6F76E8D2;
	Mon,  7 Jun 2021 13:45:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F8FB6E8CB
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 13:45:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4RJbu5iimtOUhkTc94kViNYcNx+WqkUsG+cEw3YOXIWViqq3RgYYd6echriTa8R5pHZvM25L5JRqbm2X+O60dUO8JT2TkwOsJg/5lOrFLjno39/19SlEb304rbaeThOOIWIZW3josBIkbQx4QG6bvxNGI78KO+vERXioREWHaFvQmDu6ddjhfbTm/s7RAPI/XrEZ0+xo0IKujjrqxzHdLniYw2wKHiLAVYwoiSL8E5T5rqvsuuC5aafbgrcQGPqdDJ4n/W+6x2tka1k21QHlpkwNnV87uxf29efxNnNBIM1FCEXcD4ZlxjYBa81oGZoTEHLLudLEIkFoCVKBm7+Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eshc9jGWpsvWwSc8+/8g1hZZ1+UHdT1XuafgMtiP/mQ=;
 b=hA6ncYxxezJiGz65xR0t0fkV0iE5cPfDonIAzE9ctmZsYoRL2238tzgYgQDaweVC9/1byauMMI04SWLSuo9KKrUeMtEKnnsN0fgRIYBUb7GDG19TLtgltQ7Wu/1f86j5DTAWmmy7ARTICwZBAY++KLErCEvC0dn21JP6AEzVdxAKuEPIPDM1T2nRlA3xpRXpK86s6/c2JUOFyBBhR/sv+4GrQyEtsRNX/KrzvRHIQ9k/upx6cTZJ70t5gS104Jl5ErpoFv1osvZ4x2fAuPJaiBV0cL6bzg39DDnmD67UQPzvi/7CsqZp3WdJEOGrLD7ooOOm7PE9ghmg/UjDANxdsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eshc9jGWpsvWwSc8+/8g1hZZ1+UHdT1XuafgMtiP/mQ=;
 b=Ha+kfUXUTedKH+DY0KDU+OfxMyC0elv8ZmTGFEtfRKgKBOQ8NwS79SEWroAEG9YNxIA1e1q0pE1jTO+dLx580DH2Sh+RYDSaRJ9Ii0fxtCgsQvS8i/UmB83Revl2NhwZfxR+6j5ojhvb/vsIwry0fzzHKKAbKQPU2IVwen1UZk8=
Received: from BN6PR18CA0017.namprd18.prod.outlook.com (2603:10b6:404:121::27)
 by CY4PR1201MB0134.namprd12.prod.outlook.com (2603:10b6:910:1b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Mon, 7 Jun
 2021 13:45:17 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::e) by BN6PR18CA0017.outlook.office365.com
 (2603:10b6:404:121::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend
 Transport; Mon, 7 Jun 2021 13:45:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 13:45:17 +0000
Received: from grasider-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 08:45:15 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 4/9] drm/amd/pm: Add arcturus throttler translation
Date: Mon, 7 Jun 2021 09:44:34 -0400
Message-ID: <20210607134439.28542-4-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210607134439.28542-1-Graham.Sider@amd.com>
References: <20210607134439.28542-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31f7a86e-97bd-4f2e-d054-08d929ba7c3d
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0134:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01344376D0DE4B86AFFD111F8A389@CY4PR1201MB0134.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EpDSsKYaROZrXO65DejlbENoLv7wwWaO3Z+23rU29effR3G6xYxdveW3D9AxB/0WtRx+7glRSxRyHpDio1VYGJAxBwhtsC0IaNMr+aOpoPcudMionIF32TkuOiVmS24sUcyv9zaCoh3RIGuahD7Rngo7p7WRYNZlcT7mrRwZXRtjffG0blunOczYqqU0y4+BiCJ7A+nSf6tnHIcbkWAssqwH/SIwGzvkpTZdOCMPHURnMHNrxv+rpU5kYqaMa3DTLSV/F65ZHupiSmJo0ckVzb7hAsDuc9ymj+ZJMw6MckCS4Kuwoo+GC7WlMX4eXUNJ5zsdkbYCXErbgqPfseXB1NM1RCOxE25iNmg+cQYeh1rIxgTAWnU2rtViWIXA6hk4js5MyudvhYfGSldvrsBC+r8qel6261At0/VHOFj3k51nkv/ZGmCPLaHNp2bsDepijymUCCM4KgBPkk8LHwYZ9vn+7VvoWCyD8M/rmgQ5d/0lAv3rii1bvIlbYFS0UgIb9ZMWghMg4S5IjCgvpjdk9aTEiTuwWBpMtKosI/TN0OlF29QQ812GiZAQn9pHc2T5tqD41AK0IhvnBvHAI4SViLckeH1oXVKOQRFXNPw1sGhI3r8B9kL6Lscr19CMc2iiilZ/iO/pZTHWgP0UnhIjdg4f+hFvrsUiEhOB7fuiGIuK+LB0dlQA53TOjUUpjkcE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(36840700001)(46966006)(2616005)(478600001)(36756003)(6666004)(426003)(336012)(36860700001)(82740400003)(47076005)(4326008)(356005)(5660300002)(7696005)(54906003)(86362001)(316002)(82310400003)(70206006)(70586007)(16526019)(8936002)(83380400001)(81166007)(8676002)(186003)(2906002)(26005)(1076003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 13:45:17.4268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f7a86e-97bd-4f2e-d054-08d929ba7c3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0134
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
