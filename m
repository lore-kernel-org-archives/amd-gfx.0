Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F28C47092
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 18:14:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B22A610A1
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 18:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B22A610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 205886EAA0;
	Tue,  1 Jun 2021 18:14:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B97336E1D5
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 18:14:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYlIn++RD84MnPfxfw2VHmE8xBsZ+VJlQbTvKccwbPLyetXHuJ4kJDKzHNDtJ0osnjTDBSjjwFm79Q4r0a3E0Qs73bh/8d7wiiTEjDxhzcFZOBXhR/NGvd2kAviiZK3arCaEVgwDoD/Dr1U9pabtXtTpCKSUG38R4Q7kr7hF5xgQNImK8eEFaBQajGWFW6xrdmE84sTysig4fYWuDnIak6HSJNz9t2XHQ/dJulftM7GjDHzpiIiMeHnNJE1q0OyHnHk0rb0uxPSaurYGjPbArExu2Q0YCPUMMZ+QHbOULCPZBLPmM0HNqvHSwdwZr2wvyGPYNUeX/OyD622qV01LtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/Utk3dQjLz2tJyuIzFtFNLh5qFGIpus1kWYe04G/s0=;
 b=L4rSK4VeoPIWTqiljSTz32UDVRRI6hPXckl1z1q9Gls5TSnKMXby8a6VgKuuhrXx3gaQzV9GfP7bNT3Do6OalqgkUrrDrIuQKdxfl7G0lrvmOJjsM9fc/Jc9p5zJ48OEQqaoFmDnPSEd7+8yCIbAAvdQEZgR/jf+EHBclE5T4s8uAACydORwoElKTnAy68h7SrAsbpVsJckm8MuMwLmuvLe6d84jS5kGYLosBEHK0QwmL4pbi/JHMIiD95jLBETVpbaLqrmdl7xwq+/aSVe38jDFP2JudW695ZUYrbxN9zGxK2cagz3CFj6JSWh8ni28mzYQoZfQgf9Ob6JPecr0XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/Utk3dQjLz2tJyuIzFtFNLh5qFGIpus1kWYe04G/s0=;
 b=3O+gZigYrCIU9SGe/xI/5kPYRKIdo16ZB8/Mr0nLq/ci4Anv2ibTRYB8vCtZel3bCOiv6LPJUGS/UBxfHNTHRlpBP4WNiHjVJMOiNwfJDmjQRLDg2R+DNLjHXAzGZVHtwcrkwr9yd0Qk40EZLSpxqHwJy3th7yD6bfWP6Ql/pis=
Received: from DM6PR05CA0038.namprd05.prod.outlook.com (2603:10b6:5:335::7) by
 BL0PR12MB4961.namprd12.prod.outlook.com (2603:10b6:208:1c9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 1 Jun
 2021 18:14:10 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::5a) by DM6PR05CA0038.outlook.office365.com
 (2603:10b6:5:335::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.9 via Frontend
 Transport; Tue, 1 Jun 2021 18:14:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 18:14:10 +0000
Received: from grasider-dev.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 1 Jun 2021 13:14:06 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 7/8] drm/amd/pm: Add renoir throttler translation
Date: Tue, 1 Jun 2021 14:12:30 -0400
Message-ID: <20210601181231.24773-7-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210601181231.24773-1-Graham.Sider@amd.com>
References: <20210601181231.24773-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55ec791a-e873-4fb3-0e13-08d925290d9c
X-MS-TrafficTypeDiagnostic: BL0PR12MB4961:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4961E7740DF11C460DBC7A178A3E9@BL0PR12MB4961.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Z+jHjrjjH1GsYYxj6Vr4vhQbSg60hMMpyY6WuFT3F/sr5fpFN9mPj4bA5QZJ+3JUJEOFAwhoEVIY8PcEYehGpFV9L+ONSg2uGSSIs7TtmiTaUtldpTwHCM6Md5Wag/cblT3DobfS2Atiz02ju0iaqUOom/Nb6IAl+LhQ9936QIAA1BQSPQcZhfVq80dsVrmEiy3yHhTsnB7+EqFeAooXJPlvu2LS99npPe1GlFKT4BzAbz/xFTaeOcOpcLLcbBX0jdmw4H3WpnLcj74jWjUejX+QT/bNmkjCoRodLhcQy4G16xYtGWv16InocRrCSGkkkIWCvaG1GMCKu4vivJVgAHjfBj7JQO9mHPEdwQCjyFgBqoNgYx1cl6KbRG5rEujj0dRvZ4z4PHDafKZyOnuLKilqKLcegoeS+3UfMm2V+nClxM7w/k+4fTTjDXfmquERNl/dSKWSg66d1d/IUIOLvn5fo25unoBI4Ub8deu9arLQNuu+yhR3wi/3Dgg4ouxMVynpqLGSyZTZFV/6kYTEApA2KRmLyIwaaI2wGQvssB4BEMc5aHET/yPR76eOFd1YtCQp5ZGBChAby0ab4qewK8eZTvRQiuoLtgYZ5mh+IWroauM3671lmdaVqJTk7F+8Ve6S+6DbQ9jWGGBpB6g99CSALTfx3PPRhN17fnvJh3RskVwRolixDXS96o6Jp5O
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(46966006)(36840700001)(36860700001)(86362001)(6916009)(36756003)(16526019)(186003)(47076005)(8676002)(336012)(356005)(1076003)(54906003)(81166007)(70206006)(2616005)(82740400003)(426003)(316002)(478600001)(82310400003)(70586007)(2906002)(26005)(83380400001)(6666004)(5660300002)(4326008)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 18:14:10.0824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ec791a-e873-4fb3-0e13-08d925290d9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4961
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
for renoir. Makes use of lookup table renoir_throttler_map.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 41 ++++++++++++++++---
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 1c399c4ab4dc..4071a116af75 100644
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
@@ -170,6 +186,19 @@ static int renoir_init_smc_tables(struct smu_context *smu)
 	return -ENOMEM;
 }
 
+static uint64_t renoir_get_indep_throttler_status(
+					const unsigned long dep_status)
+{
+	uint64_t indep_status = 0;
+	uint8_t dep_bit = 0;
+
+	for_each_set_bit(dep_bit, &dep_status, 32)
+		indep_status |= smu_u64_throttler_bit(dep_status,
+			renoir_throttler_map[dep_bit], dep_bit);
+
+	return indep_status;
+}
+
 /*
  * This interface just for getting uclk ultimate freq and should't introduce
  * other likewise function result in overmuch callback.
@@ -1264,8 +1293,8 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v2_1 *gpu_metrics =
-		(struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v2_2 *gpu_metrics =
+		(struct gpu_metrics_v2_2 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -1273,7 +1302,7 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 2);
 
 	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
 	gpu_metrics->temperature_soc = metrics.SocTemperature;
@@ -1311,6 +1340,8 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_l3clk[1] = metrics.L3Frequency[1];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+		renoir_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->fan_pwm = metrics.FanPwm;
 
@@ -1318,7 +1349,7 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 
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
