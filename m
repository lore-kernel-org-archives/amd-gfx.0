Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8507C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 05:56:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 831CA61101
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 05:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 831CA61101
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14F6D89EFF;
	Wed,  8 Sep 2021 05:56:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A57889EFF
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 05:56:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhkSHx00FgfgiUuDpznBxxe5GrsDNTtGgZQV2ZTRQ2JqVnfLWwD0YEnUIFjaB3Y2CExwbA0OO2WSeHX2ZokqH3dhQmK5Z0UgrEcP7jjyMmGZTTIBbB98R5afC/IEZyf/QMDxeLubs+vuhw5GJuqUy35kfFaiogsGLZ1XWe/DEa1m0ISGXk1N6ghTJs8WMvOOlpy0qoQAMjR0gJssw7Iqy42jkKM+Pv/gUUqFuGQTIINGpsNqXSRe/1/kRRYnUrLLZt5dM+861ZUoxiutmlcY9AvSHXvAYCT4dWCFwWC8COTMkCXmuTdPdRToilDNJQHYEwYyHvUd0rvu/uxSPHISVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=npvm+EDFICesPLnzI30aVoZNkgI521gAtyGRslceHXk=;
 b=ZoFMVHITlmalcL9JCwp1uaMUV5yLD4SKvqlM1hiQrZ6eW6NfUJXZ0lAMAG4fqoj9rBtFLdGMfmQ9DLLj8bcS5UZixtkRnYqn44VZOvqvB5VvK+RIuzGf0K/n9kuHKFF1lwXg+QqnYlQYTbn3D4UIsoxrZGz/InoCLtm4/MtM5U/KXfRQ85pOeMQOfBWqFsw7ggJ1GPl5MXv082hoyCJH44lUFQOymt4gxs7aXfCK7fc90sDgC27WiJSytTpQsBQu5niqSYqyqPTif3+Na3+QefXBwQxC+0kr3m6AL8/jGI6XG5m10qT9tSmhl9pYD4ZZSk/UxxhSqD/efwOLvgA3BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npvm+EDFICesPLnzI30aVoZNkgI521gAtyGRslceHXk=;
 b=4HBixxAQuuNjiSiuMrPii3qEp2twMPB/69JIaWFJIUDqIVWm+swFu3NGnr5RhcZAWtEJ1g2qwLuxV/TnPac7LFtH8f19uxrK8byMpsjEPCcAtaEw0s1iNFSe5Ogr8xL9+2BvFtsgPLKle5UdJBzaNJIMAZkD6lgOYFa+q4UaWFM=
Received: from MW4PR04CA0003.namprd04.prod.outlook.com (2603:10b6:303:69::8)
 by PH0PR12MB5433.namprd12.prod.outlook.com (2603:10b6:510:e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 05:56:32 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:69:cafe::db) by MW4PR04CA0003.outlook.office365.com
 (2603:10b6:303:69::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 05:56:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 05:56:32 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 00:56:29 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnings
Date: Wed, 8 Sep 2021 13:56:15 +0800
Message-ID: <20210908055615.3781901-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e93c3d0-673c-48c5-e151-08d9728d68ac
X-MS-TrafficTypeDiagnostic: PH0PR12MB5433:
X-Microsoft-Antispam-PRVS: <PH0PR12MB5433CD9F4084A05BEFB75EBFFBD49@PH0PR12MB5433.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:40;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WPHeZQstF+iGa7ggYceX/1nfW7dJmHPke0poz2L/S1xldCLrs9ICZgOoVYE7JbQeB6FmJxareORObFnWYpBUeMVzlI/gXWSVXCpoeFh2zfl/ga2RkxnbtXRmkghbGUMhlFNyejxtxanGWEIIm0H8k2IXg85j7KaqK/BLEzhtwGI1XaJEHyDBSSygtas/HVhEZU808Unih0noGD8xxwo+d1fpWQf6Cn+5XqWKHbDlOqNgX8PKw3n6vgU8wc843frQjS/08SVIWiPBpjmfwXdj8afUVXHjztD6/dYo8mvKJI2oADa8xdCr8kmz50NKbCxSwEkaYH07eDSXTMIcf5snfVzRkXop8KSoBG/wGRQwdVmE28cs6r//Rdy9YwE6eYXkJ+Tv1cMHoxsoyWxDjvu2DZbYgFs+QVXtaKwdHAyYns8rLqlegMD1w0e7tMRR4KOk8wiH6XPU2vR91qBPD4ib53Gh5Pfj/2Xf5nPZdRhqUTYxAcMv13OC/+vq2SeZWMLV03iFzjlgmYhx6ing4XNlN+VYDChKqF/zLR1duEYoJ0KQ7Yi5b6Xxjiy/g+6XWiCzyPZKeqortWjhPowrjol3etpIxdDIxUsl4uBxa8W3tDpGpEcPwzdNNkmpzLBxFXrLwjJAirch/wtps3LUsMoa8NekBNRgwX3NzLUoNzAc5TQCpgVWf2Lhbhh+NOeCJrCHi3sTNrgiOjSGk3dbt2XnranHWoxqx5e5Mr58FFPO98c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(36840700001)(46966006)(8676002)(1076003)(70206006)(70586007)(6666004)(36756003)(82310400003)(36860700001)(83380400001)(47076005)(8936002)(2906002)(316002)(4326008)(54906003)(7696005)(30864003)(5660300002)(6916009)(478600001)(186003)(26005)(2616005)(426003)(16526019)(44832011)(336012)(86362001)(82740400003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 05:56:32.0102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e93c3d0-673c-48c5-e151-08d9728d68ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5433
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
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  9 +++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  5 ++++-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  5 ++++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 15 +++++++++------
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  3 +++
 .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 13 +++++++++----
 .../gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  7 +++++--
 7 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index e343cc218990..53185fe96d83 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -771,8 +771,13 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 	struct smu_11_0_dpm_context *dpm_context = NULL;
 	uint32_t gen_speed, lane_width;
 
-	if (amdgpu_ras_intr_triggered())
-		return sysfs_emit(buf, "unavailable\n");
+	size = offset_in_page(buf);
+	buf = buf - size;
+
+	if (amdgpu_ras_intr_triggered()) {
+		size += sysfs_emit_at(buf, size, "unavailable\n");
+		return size;
+	}
 
 	dpm_context = smu_dpm->dpm_context;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 4c81989b8162..5490e8e66e14 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1279,6 +1279,9 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 	struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
 	uint32_t min_value, max_value;
 
+	size = offset_in_page(buf);
+	buf = buf - size;
+
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
@@ -1392,7 +1395,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 	case SMU_OD_RANGE:
 		if (!smu->od_enabled || !od_table || !od_settings)
 			break;
-		size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
 
 		if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_LIMITS)) {
 			navi10_od_setting_get_range(od_settings, SMU_11_0_ODSETTING_GFXCLKFMIN,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 5e292c3f5050..817ad6de3854 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1058,6 +1058,9 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	uint32_t min_value, max_value;
 	uint32_t smu_version;
 
+	size = offset_in_page(buf);
+	buf = buf - size;
+
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
@@ -1180,7 +1183,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		if (!smu->od_enabled || !od_table || !od_settings)
 			break;
 
-		size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
 
 		if (sienna_cichlid_is_od_feature_supported(od_settings, SMU_11_0_7_ODCAP_GFXCLK_LIMITS)) {
 			sienna_cichlid_get_od_setting_range(od_settings, SMU_11_0_7_ODSETTING_GFXCLKFMIN,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 3a3421452e57..c7842c69b570 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -592,7 +592,7 @@ static int vangogh_print_legacy_clk_levels(struct smu_context *smu,
 	switch (clk_type) {
 	case SMU_OD_SCLK:
 		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
+			size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
 			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
 			(smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
 			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
@@ -601,7 +601,7 @@ static int vangogh_print_legacy_clk_levels(struct smu_context *smu,
 		break;
 	case SMU_OD_CCLK:
 		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			size = sysfs_emit(buf, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
+			size += sysfs_emit_at(buf, size, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
 			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
 			(smu->cpu_actual_soft_min_freq > 0) ? smu->cpu_actual_soft_min_freq : smu->cpu_default_soft_min_freq);
 			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
@@ -610,7 +610,7 @@ static int vangogh_print_legacy_clk_levels(struct smu_context *smu,
 		break;
 	case SMU_OD_RANGE:
 		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
+			size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
 			size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
 				smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
 			size += sysfs_emit_at(buf, size, "CCLK: %7uMhz %10uMhz\n",
@@ -682,6 +682,9 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
 	uint32_t cur_value = 0, value = 0, count = 0;
 	bool cur_value_match_level = false;
 
+	size = offset_in_page(buf);
+	buf = buf - size;
+
 	memset(&metrics, 0, sizeof(metrics));
 
 	ret = smu_cmn_get_metrics_table(smu, &metrics, false);
@@ -691,7 +694,7 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
 	switch (clk_type) {
 	case SMU_OD_SCLK:
 		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			size = sysfs_emit(buf, "%s:\n", "OD_SCLK");
+			size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
 			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
 			(smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
 			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
@@ -700,7 +703,7 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
 		break;
 	case SMU_OD_CCLK:
 		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			size = sysfs_emit(buf, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
+			size += sysfs_emit_at(buf, size, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
 			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
 			(smu->cpu_actual_soft_min_freq > 0) ? smu->cpu_actual_soft_min_freq : smu->cpu_default_soft_min_freq);
 			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
@@ -709,7 +712,7 @@ static int vangogh_print_clk_levels(struct smu_context *smu,
 		break;
 	case SMU_OD_RANGE:
 		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-			size = sysfs_emit(buf, "%s:\n", "OD_RANGE");
+			size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
 			size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
 				smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
 			size += sysfs_emit_at(buf, size, "CCLK: %7uMhz %10uMhz\n",
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 5aa175e12a78..86e7978b6d63 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -491,6 +491,9 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 	bool cur_value_match_level = false;
 
+	size = offset_in_page(buf);
+	buf = buf - size;
+
 	memset(&metrics, 0, sizeof(metrics));
 
 	ret = smu_cmn_get_metrics_table(smu, &metrics, false);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index ab652028e003..6349f27e9efc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -733,15 +733,20 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 	uint32_t freq_values[3] = {0};
 	uint32_t min_clk, max_clk;
 
-	if (amdgpu_ras_intr_triggered())
-		return sysfs_emit(buf, "unavailable\n");
+	size = offset_in_page(buf);
+	buf = buf - size;
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
@@ -795,7 +800,7 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 		break;
 
 	case SMU_OD_MCLK:
-		size = sysfs_emit(buf, "%s:\n", "MCLK");
+		size += sysfs_emit_at(buf, size, "%s:\n", "MCLK");
 		fallthrough;
 	case SMU_MCLK:
 		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_UCLK, &now);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 627ba2eec7fd..3b21d9143b96 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -1052,16 +1052,19 @@ static int yellow_carp_print_clk_levels(struct smu_context *smu,
 	int i, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 
+	size = offset_in_page(buf);
+	buf = buf - size;
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
-- 
2.25.1

