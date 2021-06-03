Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7EEC47082
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:17:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C5D060FF0
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5D060FF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11B406F4A6;
	Thu,  3 Jun 2021 15:17:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D50F6F4A3
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 15:17:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iftIbpIk0612xOmgfsWv91nY24WCgXSZ+EbqT/xkgDwtAXivqsnMg8NqvmpQ74V1sC1mDJ+MVlhuOS/Lcu1nY/kimATYxjvPgeQus+FXjxh10MiGeYDbLKN8f3lc1eYFM792Tjh8QfiOd6MPW8f0eRaMiWHYjUya6DdO4EMwd61eDC5Ez3B7Cz/VFXn76/YIkzWUo8g3JVBwtivj9m5/65/wXJL4FQ3jTY/KdqyMWnXpND0tdQFXdrD8BGS5ImWaPynNiqhQ2FkSBEoZTTBnjc5Jm12DcEQNITpDyODrw9ctksqpx7rwY+QpMB3f0KQHnQFSuvbBwrV6ZfTs0Z3buA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ak7fSGVKUO25mveeBHZxzCi9tZGYY6OD2nSYUUygS6I=;
 b=K0a8/49j882igHWNh/Iw+LDMFVqKVLWk5+kAGM/x+2vaALL5QJ8VQ1omi98Cli2tGrilDl6HRRao8FMQEiLx20scu9gJj+e8P5JTMVtkBF/1P7SpvmmwConuioN/Ehc4k3pIM4EUnILRLhNMOpN0V4NT1XaNmqz3TDqAzmmlxpaDR8zsPobT/jIRPR5FBiUdzqUqVTF7UxoqhQR0zS2wNSvu84SKB7Hn7h1ivS3DtmLU6cUV+oG89yBAjGLbx9JsGK250mMexhqn8ax5Y+oCWxu4atZkPJ1q5auIWlt/chG5ht2ePuJTuoL5ciA6ldR2p0Rru/UpaZvnsTXuJMnFsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ak7fSGVKUO25mveeBHZxzCi9tZGYY6OD2nSYUUygS6I=;
 b=Sb4TwrfhdxtQWI1As7bjJNrebd+y94U76FdpAfRfai4ZBHa2xxcp69pkaNqN+7tZvIRur/F1uWjOUJ363iAsd/sQy6qCV57Y5Z++N2kZYzA0OwW/8njnd9FgyYGYlbe8XaFGBUYGC0gtzJqM5pJxWbUui8IOGgyVmdEz08Nh4V0=
Received: from DM5PR2201CA0020.namprd22.prod.outlook.com (2603:10b6:4:14::30)
 by BYAPR12MB3094.namprd12.prod.outlook.com (2603:10b6:a03:db::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Thu, 3 Jun
 2021 15:17:39 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::70) by DM5PR2201CA0020.outlook.office365.com
 (2603:10b6:4:14::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Thu, 3 Jun 2021 15:17:38 +0000
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
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 15:17:38 +0000
Received: from grasider-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 3 Jun 2021
 10:17:33 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 4/9] drm/amd/pm: Add arcturus throttler translation
Date: Thu, 3 Jun 2021 11:16:37 -0400
Message-ID: <20210603151642.14014-4-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210603151642.14014-1-Graham.Sider@amd.com>
References: <20210603151642.14014-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e718ed50-8d57-4d23-5d19-08d926a2b98f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3094:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3094AE4298AD1F1EA325F8788A3C9@BYAPR12MB3094.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VylARpHYPX+PbaY2BZgVJdIlKdbZBfoINPC2Xu3b53GgIY9GjxmfvkzHAlnzbZzqQqCaMCB4UrrdatCIoOvnDmZKhcVw2J/B1Djg1/IXBRbTK5ShkCtgYOfWohrkLluB9krpnZ1oKg1KyNF7B002wsVIIE0zDCYQgQoUIqpo5wrKgK59wXjExMBWZmHVxMCSivrTfcJribWlwzTQaU++OBekrbrdq8AYHtqG/40yfe5xW+qUjriJjvHpYdAqW+2bx/i34runmcSEAJT1hCbhGVb0cRrbdi59Rlqb0gejw+ROW7ui99TjRLGc6+VZ5N/AeRmUklI5/6TS4T5uRuxslSsQ3mrd3gpzXvkqs0Bhm1U1if+fg936vVDolmI7hR7dhwu5N2iU0OCMzBId+a+QgSnlQ5F3f1OSZ+J8eTKg785FAjiBQvNkPvmk4kt4kCzzXMxWZMqlNt6IJh4keRe8liAhW3DM8gUJtE9wqMtKA0caVSucCHLREESQBYySiGrCdUU7tjc6dRZ0SWFd4SXUEu9AQYdRiIa8QH3leNj/cok5YrilFpSjM4MuBv1mHUgWKtGgQO0a0uPasTZWZchwAZk73OvpKnmp9BTYlPs28gw2LoHAPtrI3pp3uTO/yxuNZGWK3cqxNTWB/dVujqB4d24bvU45m1vE1Jw2NAkWOPXtavutksf64v76JhTwRt87
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(36840700001)(46966006)(186003)(6916009)(16526019)(7696005)(356005)(81166007)(4326008)(426003)(86362001)(336012)(82740400003)(26005)(47076005)(316002)(2616005)(8676002)(36756003)(8936002)(54906003)(83380400001)(478600001)(36860700001)(5660300002)(82310400003)(70586007)(2906002)(70206006)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 15:17:38.8334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e718ed50-8d57-4d23-5d19-08d926a2b98f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3094
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
for arcturus.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 33 ++++++++++++++++---
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 1735a96dd307..9a8ae9e3fc39 100644
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
+	[THROTTLER_TEMP_VR_MEM_BIT]	= (SMU_THROTTLER_TEMP_VR_MEM_BIT),
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
