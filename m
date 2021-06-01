Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC67C47080
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 18:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 900B3613BD
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 18:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900B3613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 560A16E1D5;
	Tue,  1 Jun 2021 18:14:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC9EE6EAA3
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 18:14:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVsGmWJLey3d0t4Qv5KyEdU7mfpKClqddZb3PQ2z+YCcME+4bpNTku/8LCAcPgBatNa07xZE8MJjHk9O47aDLvYgwXpAxyt1O/Ismej042NOrgtGhrM4jPBBzx3DVwFZVVxylqIFWmEIIbhQqA/oG9IFC1mqTPMN1rEWqxifudZJ6sRiOu3vP0ET6ZoG+YN4be+ceE7QuE8Ab7ehrAbWNdTkz7hMPb1eA1X3PCcp3D6Qo+VQKf2fcsrXX7LLPwvBoIe1/3QBUzSMxA6C8cijbg+dDF6w6yG+fInOvi/pFiVrTElUD0epdUG4gUtOQ9CCK6j07uksnAcqPec6B2DJrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=808pWmYmIqQRDTz6zXtadEfZoMhtTPmLJi3bSlfEDjA=;
 b=a+Yf54tw2yAmKNoufhafeO0/lGxa1CxTmVJ3malwy9QLszlRe307oWxMiZfR/3oj2D766AbHzcEsmvfdT06HmRU5hYTfJEt8UrpgYnRMcejd0gF3235lHLXiHkv90GR1txC26MSKNdcgy0e3ntY011XeL61BYAT2QTzq6hfgHTELxNe7P8qwJRtIFSCk0Dog9CR0kiOUsoXYlY2QF6iMfosZGhonZSDDss/OdrmnWGh2lzGTG/YYfadelb0tMppfUKqXF/N0QCEykX7GpHKG6b8+XDTRK0ozEOYZQQ4PWsMRPfkoEKVifT+KTouffvE38+6TmOkFt+W6tQIDcljABw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=808pWmYmIqQRDTz6zXtadEfZoMhtTPmLJi3bSlfEDjA=;
 b=yfrTHdSxZRIkzEe4xvM/5dqPQWl6uwn/JKVnSUUoTWh9B7fLbY8vFYl5J/4miA0aD83IGhssQQLZLJosAqLwb6YRME4JotkoxKDxJKfgLzhjqN2Yd+TshrZt9xs5XiCTh1QrTv34YaZcD56q8Y92RuPjzViC1i4ERTJakl+zliQ=
Received: from DM6PR05CA0058.namprd05.prod.outlook.com (2603:10b6:5:335::27)
 by CH2PR12MB3702.namprd12.prod.outlook.com (2603:10b6:610:27::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Tue, 1 Jun
 2021 18:14:08 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::59) by DM6PR05CA0058.outlook.office365.com
 (2603:10b6:5:335::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.9 via Frontend
 Transport; Tue, 1 Jun 2021 18:14:08 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=temperror
 action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 18:14:07 +0000
Received: from grasider-dev.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 1 Jun 2021 13:14:04 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 6/8] drm/amd/pm: Add vangogh throttler translation
Date: Tue, 1 Jun 2021 14:12:29 -0400
Message-ID: <20210601181231.24773-6-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210601181231.24773-1-Graham.Sider@amd.com>
References: <20210601181231.24773-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1663c187-1e78-45fe-c89a-08d925290bc8
X-MS-TrafficTypeDiagnostic: CH2PR12MB3702:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3702C50665220C81DD613B938A3E9@CH2PR12MB3702.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cu7Tp3ICQmOG5dd7vzuCF14UeNtUu++eNDedoiGTLv9UOMGDTPcTnVrrlxPWrzD7AqqfgUYK+3veHUD2ZmuTkVfuanR7A5z6uZns3LUxAoaSsc2und/Uj7hWzfpnJP6UisGuWE8587zth0hpFpAcjs2q1slag7yBjHSIIYk+giWD4v+VVu4hCLGhFsWUtYRW2GMp0hTNQseYGMjF3cGaRdMkd8vars7uWLzzLRDLPbmg+1as/w83o6GsMOLwXrKNCIgfQhYkRdpcPv+5E9SQjYvjpayTKxoqFBEC4j2eMtYZN0X//Y4NzOwD/C/glqcwMPqWtpqDuVHU88VSXdx8xYVoZRQpvbPKJGjONW78ye7w1mpTqZ+Crk+ALovz+Mr1NlyI3+dkHXb4LZpCsGREdMDozBw7lTjc4EbJFfsiMNT8yq1ssCBq9a1IW46pzX8ZxDlYlH3Ca309MIG3NrY9Y0fGg8gOYQY4+m0VftJEdAXl7ZV2x6IfvsQdxLVw1ijTep21VYBvauZDdplMOE0D+wgy/dTF7vH6fi6GE8sb2P0tTNSDP7OENjT3TPTauuEUUnaQTFPF+MS0Fw8IvM56KzOttHzdOxYXv9pu5FF15+3r5JTvlUW2D9zvjISkuDAxMKdaiWVaL0Gg94LpuLeftvTfd7etMsav18riPwU8wr8Zbjq0o7QLnEkMS25+ie+l
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966006)(36840700001)(4326008)(6916009)(8936002)(8676002)(6666004)(478600001)(2616005)(2906002)(70206006)(1076003)(63370400001)(82310400003)(86362001)(186003)(70586007)(81166007)(36860700001)(5660300002)(316002)(426003)(47076005)(36756003)(54906003)(336012)(82740400003)(83380400001)(356005)(63350400001)(26005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 18:14:07.0191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1663c187-1e78-45fe-c89a-08d925290bc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3702
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
for vangogh. Makes use of lookup table vangogh_throttler_map.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 49 +++++++++++++++----
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 77f532a49e37..ab3c2df87c98 100644
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
@@ -251,6 +265,19 @@ static int vangogh_tables_init(struct smu_context *smu)
 	return -ENOMEM;
 }
 
+static uint64_t vangogh_get_indep_throttler_status(
+					const unsigned long dep_status)
+{
+	uint64_t indep_status = 0;
+	uint8_t dep_bit = 0;
+
+	for_each_set_bit(dep_bit, &dep_status, 32)
+		indep_status |= smu_u64_throttler_bit(dep_status,
+			vangogh_throttler_map[dep_bit], dep_bit);
+
+	return indep_status;
+}
+
 static int vangogh_get_legacy_smu_metrics_data(struct smu_context *smu,
 				       MetricsMember_t member,
 				       uint32_t *value)
@@ -1632,8 +1659,8 @@ static ssize_t vangogh_get_legacy_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v2_1 *gpu_metrics =
-		(struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v2_2 *gpu_metrics =
+		(struct gpu_metrics_v2_2 *)smu_table->gpu_metrics_table;
 	SmuMetrics_legacy_t metrics;
 	int ret = 0;
 
@@ -1641,7 +1668,7 @@ static ssize_t vangogh_get_legacy_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 2);
 
 	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
 	gpu_metrics->temperature_soc = metrics.SocTemperature;
@@ -1674,20 +1701,22 @@ static ssize_t vangogh_get_legacy_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_l3clk[0] = metrics.L3Frequency[0];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			vangogh_get_indep_throttler_status(metrics.ThrottlerStatus);
 
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
 
@@ -1695,7 +1724,7 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 2);
 
 	gpu_metrics->temperature_gfx = metrics.Current.GfxTemperature;
 	gpu_metrics->temperature_soc = metrics.Current.SocTemperature;
@@ -1735,12 +1764,14 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_l3clk[0] = metrics.Current.L3Frequency[0];
 
 	gpu_metrics->throttle_status = metrics.Current.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			vangogh_get_indep_throttler_status(metrics.Current.ThrottlerStatus);
 
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
