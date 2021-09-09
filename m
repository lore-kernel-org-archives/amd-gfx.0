Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4CFC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 08:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E21160F5B
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 08:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3E21160F5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C40BE6E47B;
	Thu,  9 Sep 2021 08:00:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2975F6E47B
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 08:00:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0dRvEowyliE11jQ4GwQqw4uKpvpX7qjtq1E3CT5O1ExBltHVoY/tkybohjiRkLhhjpRzvGQttTOtj7h5RbG+BnYL/ruYyLLcQFMek2l3j5lxpLSBSVjMIcCLzwk1UpZzc6C8cHwuLfuCVqaj0IucdYNRyW+ATZhzaiwvU5Xleua1tGDMowQU9xa2EYonmcgyykjKX39vz0D9WPYamms9f95rWJs+RBvyVUzXi5oInnxvgH3YJGFWWaijv+DbWjfNZwg4WCA8kAqIq+fFDgpPr24/xM6mjtiG6z3YrkCmV8WeWsuAC+IM9FVJYhlohdkJzY3rN12TWQ9Klg1K/kiBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=WbZYGSLdGeX912R/dQ4eoGo6/hxHm5fm4FJAIeM7LHI=;
 b=Ak1StyuW2tqPAo3ndWhh4us/J+5aSwpAm9P4Q9XRNUWO/QM/xjTV76p74njlyU545oX2DjGdSFOUqXHgkrlSeEo6vjGcRm5gFRNgdIYoKAjttGb9f78FXDjdro7cCOvD88Gu9+zY08FwKreSGFViR20MBmadLz6aHUTejy+3+NgkeY2fimiTkmsn+rAnsZWo9wST1dbvyh5YA2zo3rdiKo23oRJcRLrHCdxuUEhp6cEhF+192/oMY7eRdfY1Y4l711S1OWIIgTAwORJLKikivJlscrfuT8qTfJNw+ZXVzTwBkiulZaqLXh+8uCmg1/LBCcc0y5tU7QpycxZ6P8FGdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbZYGSLdGeX912R/dQ4eoGo6/hxHm5fm4FJAIeM7LHI=;
 b=yw5t3BdHef95EdJY/mMO86bhnEmkr2TWbh2vzYSvtFlNRxa4CUcswKaNrrv8SPWpldky3l0REhGMPUHthsAt/gqZTXB4K4XWg6jNAEmSEAAAU1Y07M+9mlkWYVbxsBvBTzWV7TZkmpC9vR5alyZFPjOGPGeH7MAmh1z1ANNQQpY=
Received: from DM3PR12CA0127.namprd12.prod.outlook.com (2603:10b6:0:51::23) by
 MWHPR1201MB0206.namprd12.prod.outlook.com (2603:10b6:301:55::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Thu, 9 Sep
 2021 08:00:22 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::5f) by DM3PR12CA0127.outlook.office365.com
 (2603:10b6:0:51::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Thu, 9 Sep 2021 08:00:21 +0000
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
 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 08:00:21 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 9 Sep 2021
 03:00:18 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Christian=20K=B6nig?= <christian.koenig@amd.com>, Lazar Lijo
 <Lijo.Lazar@amd.com>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH v2] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnings(v2)
Date: Thu, 9 Sep 2021 16:00:05 +0800
Message-ID: <20210909080005.297716-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8087e79b-bab7-48ba-0384-08d97367df5b
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0206:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB020663D7EB939F522EBF8A93FBD59@MWHPR1201MB0206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5GbrdkgB40zRXXMhOTbzGYAAgnoI6jD0yrMzjHG0S0pXWa0Ce/RD6NKRsFZBC637G6QpA8k1DPEk8jVgTdw8FKREWc6qo09dWr/PiDx86IJoqnjqYSjwnixUT6DVU9weLBUfStqy2HgbOob9prhMcnw14cyD3FaC1QW6ayPqMqlAesS1xEeduXIutiuI1iP0GLrA78eln5cTi68/k0kv07X5NxXmxmn2su/7r2oM5FGYMZwT94JMCLTr1sE9cNYPi6G33LN4eMeSHFaQU0wg5ulpaNnPDHXGaG384/J/KD032J8n5JqDYNxSpxxGHLWmwQ48vXY+HtUw6gJdKOoc2ONjSqlXyRV94jAtX4K/BYztC/B2VBAEir0sfb3JjS3jzphe2WsgP853b0GliY+1zvt7AhvfvmLtXVbL3CXJmOJaFMxvd7uyFhepVqEv3xHEV2q2oaXvLC85kpA6YuXZFwigN3FqYVnJq/d8nscXWlu+b9ZmjUze4+7spmRwJvjft3wt8eX3mKwsIFoVos8mO3PjW8BZYJM+mrlPXZ4NAkubkj9Ud5aa1/SId1GVymsdaTq0vw7EP4DZGpRoe/m7gfh9K53U+GE5uPrKExuVfTz19c1mCodZ49WYh2gC3fkmZAwrOqgQBynXoy+vcSrP7AsALzaJz7Snz2hVJ4AnmphBrv3h8JcEbmdXXlgLan/7pJYf5VqFbK2oUtLcP/XJwSt0hfYOE6a4+tifSHIkwuQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966006)(36840700001)(356005)(36860700001)(30864003)(2906002)(336012)(82740400003)(54906003)(86362001)(70206006)(70586007)(6916009)(316002)(478600001)(8936002)(7696005)(81166007)(4326008)(1076003)(6666004)(36756003)(26005)(83380400001)(16526019)(82310400003)(186003)(2616005)(44832011)(8676002)(47076005)(426003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 08:00:21.4745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8087e79b-bab7-48ba-0384-08d97367df5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0206
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

sysfs_emit and sysfs_emit_at requrie a page boundary
aligned buf address. Make them happy!

v2: use an inline function

Warning Log:
[  492.545174] invalid sysfs_emit_at: buf:00000000f19bdfde at:0
[  492.546416] WARNING: CPU: 7 PID: 1304 at fs/sysfs/file.c:765 sysfs_emit_at+0x4a/0xa0
[  492.654805] Call Trace:
[  492.655353]  ? smu_cmn_get_metrics_table+0x40/0x50 [amdgpu]
[  492.656780]  vangogh_print_clk_levels+0x369/0x410 [amdgpu]
[  492.658245]  vangogh_common_print_clk_levels+0x77/0x80 [amdgpu]
[  492.659733]  ? preempt_schedule_common+0x18/0x30
[  492.660713]  smu_print_ppclk_levels+0x65/0x90 [amdgpu]
[  492.662107]  amdgpu_get_pp_od_clk_voltage+0x13d/0x190 [amdgpu]
[  492.663620]  dev_attr_show+0x1d/0x40

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c    |  8 ++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c  |  4 +++-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  |  4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 16 ++++++++++------
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c  |  2 ++
 .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c   | 12 ++++++++----
 .../gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c |  6 ++++--
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h           | 13 +++++++++++++
 8 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index e343cc218990..2e5a362aa06b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -771,8 +771,12 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 	struct smu_11_0_dpm_context *dpm_context = NULL;
 	uint32_t gen_speed, lane_width;
 
-	if (amdgpu_ras_intr_triggered())
-		return sysfs_emit(buf, "unavailable\n");
+	smu_cmn_get_sysfs_buf(&buf, size);
+
+	if (amdgpu_ras_intr_triggered()) {
+		size += sysfs_emit_at(buf, size, "unavailable\n");
+		return size;
+	}
 
 	dpm_context = smu_dpm->dpm_context;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 4c81989b8162..63e1f0db579c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1279,6 +1279,8 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 	struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
 	uint32_t min_value, max_value;
 
+	smu_cmn_get_sysfs_buf(&buf, &size);
+
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
@@ -1392,7 +1394,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 	case SMU_OD_RANGE:
 		if (!smu->od_enabled || !od_table || !od_settings)
 			break;
-		size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
 
 		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_LIMITS)) {
 			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_GFXCLKFMIN,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 5e292c3f5050..d7519688065f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1058,6 +1058,8 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	uint32_t min_value, max_value;
 	uint32_t smu_version;
 
+	smu_cmn_get_sysfs_buf(&buf, &size);
+
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
@@ -1180,7 +1182,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		if (!smu->od_enabled || !od_table || !od_settings)
 			break;
 
-		size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
 
 		if (sienna_cichlid_is_od_feature_supported(od_settings, SMU_11_0_7_ODCAP_GFXCLK_LIMITS)) {
 			sienna_cichlid_get_od_setting_range(od_settings, SMU_11_0_7_ODSETTING_GFXCLKFMIN,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 3a3421452e57..f6ef0ce6e9e2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -589,10 +589,12 @@ static int vangogh_print_legacy_clk_levels(struct smu_context *smu,
 	if (ret)
 		return ret;
 
+	smu_cmn_get_sysfs_buf(&buf, &size);
+
 	switch (clk_type) {
 	case SMU_OD_SCLK:
 		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
+			size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
 			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
 			(smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
 			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
@@ -601,7 +603,7 @@ static int vangogh_print_legacy_clk_levels(struct smu_context *smu,
 		break;
 	case SMU_OD_CCLK:
 		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			size = sysfs_emit(buf, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
+			size += sysfs_emit_at(buf, size, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
 			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
 			(smu->cpu_actual_soft_min_freq > 0) ? smu->cpu_actual_soft_min_freq : smu->cpu_default_soft_min_freq);
 			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
@@ -610,7 +612,7 @@ static int vangogh_print_legacy_clk_levels(struct smu_context *smu,
 		break;
 	case SMU_OD_RANGE:
 		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
+			size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
 			size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
 				smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
 			size += sysfs_emit_at(buf, size, "CCLK: %7uMhz %10uMhz\n",
@@ -688,10 +690,12 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
 	if (ret)
 		return ret;
 
+	smu_cmn_get_sysfs_buf(&buf, &size);
+
 	switch (clk_type) {
 	case SMU_OD_SCLK:
 		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
+			size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
 			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
 			(smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
 			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
@@ -700,7 +704,7 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
 		break;
 	case SMU_OD_CCLK:
 		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			size = sysfs_emit(buf, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
+			size += sysfs_emit_at(buf, size, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
 			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
 			(smu->cpu_actual_soft_min_freq > 0) ? smu->cpu_actual_soft_min_freq : smu->cpu_default_soft_min_freq);
 			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
@@ -709,7 +713,7 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
 		break;
 	case SMU_OD_RANGE:
 		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
+			size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
 			size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
 				smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
 			size += sysfs_emit_at(buf, size, "CCLK: %7uMhz %10uMhz\n",
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 5aa175e12a78..145f13b8c977 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -497,6 +497,8 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 	if (ret)
 		return ret;
 
+	smu_cmn_get_sysfs_buf(&buf, &size);
+
 	switch (clk_type) {
 	case SMU_OD_RANGE:
 		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index ab652028e003..5019903db492 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -733,15 +733,19 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 	uint32_t freq_values[3] = {0};
 	uint32_t min_clk, max_clk;
 
-	if (amdgpu_ras_intr_triggered())
-		return sysfs_emit(buf, "unavailable\n");
+	smu_cmn_get_sysfs_buf(&buf, &size);
+
+	if (amdgpu_ras_intr_triggered()) {
+		size += sysfs_emit_at(buf, size, "unavailable\n");
+		return size;
+	}
 
 	dpm_context = smu_dpm->dpm_context;
 
 	switch (type) {
 
 	case SMU_OD_SCLK:
-		size = sysfs_emit(buf, "%s:\n", "GFXCLK");
+		size += sysfs_emit_at(buf, size, "%s:\n", "GFXCLK");
 		fallthrough;
 	case SMU_SCLK:
 		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_GFXCLK, &now);
@@ -795,7 +799,7 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 		break;
 
 	case SMU_OD_MCLK:
-		size = sysfs_emit(buf, "%s:\n", "MCLK");
+		size += sysfs_emit_at(buf, size, "%s:\n", "MCLK");
 		fallthrough;
 	case SMU_MCLK:
 		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_UCLK, &now);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 627ba2eec7fd..a403657151ba 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -1052,16 +1052,18 @@ static int yellow_carp_print_clk_levels(struct smu_context *smu,
 	int i, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 
+	smu_cmn_get_sysfs_buf(&buf, &size);
+
 	switch (clk_type) {
 	case SMU_OD_SCLK:
-		size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
 		size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
 		(smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
 		size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
 		(smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
 		break;
 	case SMU_OD_RANGE:
-		size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
 		size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
 						smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
 		break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 16993daa2ae0..4054d9493e77 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -110,5 +110,18 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev);
 int smu_cmn_set_mp1_state(struct smu_context *smu,
 			  enum pp_mp1_state mp1_state);
 
+/*
+ * Helper function to make sysfs_emit_at() happy. Align buf to
+ * the current page boundary and record the offset.
+ */
+static inline void smu_cmn_get_sysfs_buf(char **buf, int *offset)
+{
+	if (!*buf || !offset)
+		return;
+
+	*offset = offset_in_page(*buf);
+	*buf -= *offset;
+}
+
 #endif
 #endif
-- 
2.25.1

