Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E3CC4743F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 13:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA04261159
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 13:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA04261159
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D433F6E8D4;
	Mon,  7 Jun 2021 13:45:23 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2070.outbound.protection.outlook.com [40.107.95.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAA576E8D1
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 13:45:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gA3OlNCNfdHcNgabkYap4L4qaqSi0kYb/pts1pB2eewuXjER1v9o177Q5lePwKkUd0pNE6coPTblGEdYMdkHor+nh/z1SzvIRqMDsSTSWnrrCc4phsYvvnAo7xL9AQ61HaRKx6v0RoJgXPVj3C0EAmXE7QiHtJJ5aHkTrdcdiaKN+Xk0YTnbq623un3u4VKcrF6dD68iq+/ill0uIShnkLs2ftzbO6s3e0ynxeklV9pbrZYTPTCHyJbWr5WsmePeGgRXEtRvZkJbGnwIXkjljeGuEqUmrHtZNqJUtfIuNkjyJ+XpWFpOr7op7JVosAv+aCkv+Eml4J2iY/l6Wn0t0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0oMKgfp7HEaaj5PWDnQ4HRdIBiaHHmceaoQcHNUbEY=;
 b=RmUbouYkN2qG+02FwGxizrYkdDnr2++cl83JUbtn6qJd8eO1N9lft6MKcK3YdBDo6RERC5A6YT0kPBer3kgEA/N0bBgvjXsByeWlZvpuIiZ+YXqp+tJmFkdmgjmTglbppfAYXU6nilDf0gqrksqdr7FuoBQLvJz7T9Jw452sbUbBVfdynO6bHY8kI750PQyoA51AOQAmMbztLgyhjk14DoJ/QRrGva+RvKx2msevPwKPClHWMWyG1asi/bw75sldQjghpGDqrPC4CDHT93wnTi5KvMXnDEbIChGkK8ziiuqYRb1F+UgVEyijqgTXbAh9Mo0oL6y/L3JKE1f6H8Kx6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0oMKgfp7HEaaj5PWDnQ4HRdIBiaHHmceaoQcHNUbEY=;
 b=eGslWeUvDOFo9G8gKWvak0KE7+1U5G5HQrV+cGhnicieJHzgiABey/ag+0ePnQJ4UV39yU2QdDEBkKZ9w3v80fEvH3OFCR3QWkA0hbE5SEZsMzEgPfX4MTwbYkHMG7XX73SwFpUggiVGujoSaP/QcePkgTz6JrbuNJMo3/JPUTo=
Received: from BN6PR18CA0011.namprd18.prod.outlook.com (2603:10b6:404:121::21)
 by DM5PR12MB1164.namprd12.prod.outlook.com (2603:10b6:3:77::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25; Mon, 7 Jun
 2021 13:45:19 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::6e) by BN6PR18CA0011.outlook.office365.com
 (2603:10b6:404:121::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Mon, 7 Jun 2021 13:45:19 +0000
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
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 13:45:19 +0000
Received: from grasider-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 08:45:17 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 7/9] drm/amd/pm: Add vangogh throttler translation
Date: Mon, 7 Jun 2021 09:44:37 -0400
Message-ID: <20210607134439.28542-7-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210607134439.28542-1-Graham.Sider@amd.com>
References: <20210607134439.28542-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbb116b3-0e43-48ad-babd-08d929ba7d6e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1164:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1164E7696352B57D9C0803568A389@DM5PR12MB1164.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CGmmkQw+sf//YAGzq8rqInl/pcvK3Y74UUUbXaKc8g1Emp5N89E9Xodt0FBcPYzbomv8jVNcnkwtO4WyAqxOfmPERVWGJfP7dRViE0LKp37CWDgaWvmDLJ9seADYv3iNU9ARgpo5YFEcwRy+7E1ppX+31fuafIeIxpE4dHd9mT5Zq2zEx0G6Tc/4fj3Svl6itXhvfndq33SkPfv3JLgr9SlKTczHyOErg5knKQQLTAhkY6KTgXhhKO1QRsntq7kaiT85DXkm+frxfL0wUBFe0yTCvp8JYiTRYdxJtbr5CRHXTu9tSlg4uZmklny4ZuaFDcE7o/8MrgIprIqy6yJ8l5bVrdJXKbOQIBek+xSOT8nRUFBkfAAioYNp2s6iLPPGtr8e/SDxSxpTguTQn/oop/we2CLcblL6IhAttUD2vvHKql2KMM+KmPWvb1EzfEy4i7jj1i5ggo2k5AQ2QdfTLIKcC23HGTKZSiM8zx5bE1M7Ig9p2feBUWVt7Mm5GEj5nzbt5FF+qAOvL+/SmgLFlBDeQ6jYbRw8Xd0TWCs2llSbK0yviCLEYxZaIb0B0Di5lRELXLqc9qX/hRJ7PZ/fvWSbzs/Z3Qpbev7uUFOZ7vTaGfS5TFWPxwn5ip9Df+ikTkMy/gqsZyGZgKnR4SaXCP4ZJd1DGGGQtjne1+Cj8ynkVfESPYhqOSMS1ArLrmCS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(46966006)(36840700001)(54906003)(70586007)(2906002)(336012)(86362001)(316002)(356005)(82310400003)(47076005)(36756003)(70206006)(4326008)(83380400001)(81166007)(36860700001)(6666004)(26005)(82740400003)(6916009)(426003)(1076003)(2616005)(7696005)(478600001)(186003)(8936002)(16526019)(8676002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 13:45:19.4271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb116b3-0e43-48ad-babd-08d929ba7d6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1164
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
for vangogh.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 38 ++++++++++++++-----
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 77f532a49e37..589304367929 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -190,6 +190,20 @@ static struct cmn2asic_mapping vangogh_workload_map[PP_SMC_POWER_PROFILE_COUNT]
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
 };
 
+static const uint8_t vangogh_throttler_map[] = {
+	[THROTTLER_STATUS_BIT_SPL]	= (SMU_THROTTLER_SPL_BIT),
+	[THROTTLER_STATUS_BIT_FPPT]	= (SMU_THROTTLER_FPPT_BIT),
+	[THROTTLER_STATUS_BIT_SPPT]	= (SMU_THROTTLER_SPPT_BIT),
+	[THROTTLER_STATUS_BIT_SPPT_APU]	= (SMU_THROTTLER_SPPT_APU_BIT),
+	[THROTTLER_STATUS_BIT_THM_CORE]	= (SMU_THROTTLER_TEMP_CORE_BIT),
+	[THROTTLER_STATUS_BIT_THM_GFX]	= (SMU_THROTTLER_TEMP_VR_GFX_BIT),
+	[THROTTLER_STATUS_BIT_THM_SOC]	= (SMU_THROTTLER_TEMP_VR_SOC_BIT),
+	[THROTTLER_STATUS_BIT_TDC_VDD]	= (SMU_THROTTLER_TDC_VDD_BIT),
+	[THROTTLER_STATUS_BIT_TDC_SOC]	= (SMU_THROTTLER_TDC_SOC_BIT),
+	[THROTTLER_STATUS_BIT_TDC_GFX]	= (SMU_THROTTLER_TDC_GFX_BIT),
+	[THROTTLER_STATUS_BIT_TDC_CVIP]	= (SMU_THROTTLER_TDC_CVIP_BIT),
+};
+
 static int vangogh_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -226,7 +240,7 @@ static int vangogh_tables_init(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_1);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_2);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err1_out;
@@ -1632,8 +1646,8 @@ static ssize_t vangogh_get_legacy_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v2_1 *gpu_metrics =
-		(struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v2_2 *gpu_metrics =
+		(struct gpu_metrics_v2_2 *)smu_table->gpu_metrics_table;
 	SmuMetrics_legacy_t metrics;
 	int ret = 0;
 
@@ -1641,7 +1655,7 @@ static ssize_t vangogh_get_legacy_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 2);
 
 	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
 	gpu_metrics->temperature_soc = metrics.SocTemperature;
@@ -1674,20 +1688,23 @@ static ssize_t vangogh_get_legacy_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_l3clk[0] = metrics.L3Frequency[0];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			smu_cmn_get_indep_throttler_status(metrics.ThrottlerStatus,
+							   vangogh_throttler_map);
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v2_1);
+	return sizeof(struct gpu_metrics_v2_2);
 }
 
 static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v2_1 *gpu_metrics =
-		(struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v2_2 *gpu_metrics =
+		(struct gpu_metrics_v2_2 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -1695,7 +1712,7 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 2);
 
 	gpu_metrics->temperature_gfx = metrics.Current.GfxTemperature;
 	gpu_metrics->temperature_soc = metrics.Current.SocTemperature;
@@ -1735,12 +1752,15 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_l3clk[0] = metrics.Current.L3Frequency[0];
 
 	gpu_metrics->throttle_status = metrics.Current.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			smu_cmn_get_indep_throttler_status(metrics.Current.ThrottlerStatus,
+							   vangogh_throttler_map);
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v2_1);
+	return sizeof(struct gpu_metrics_v2_2);
 }
 
 static ssize_t vangogh_common_get_gpu_metrics(struct smu_context *smu,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
