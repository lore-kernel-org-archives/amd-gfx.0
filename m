Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81118C47097
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:17:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44B4E60FF0
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B4E60FF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3B826F4A3;
	Thu,  3 Jun 2021 15:17:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C03B16F4A7
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 15:17:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fotfLUeY2kia7GP4ngk37+LDSqq+ECO+l3SjOfpuFyKdTd5WJuKuQwSDkfQV+bKoWdCIpdf0f2OhTwgnfi+Dk5pVqA19z/L+S77Q1E3TIdyOn59MylXjddGKIFVGCBaxHj+P+zgKpqWNB1tgq6FItHscgRYo52jyOiChzokcN7ynevQpcuWLXMixn/X3gFWSngt1JyKz+NEa+/cAewLt/sJQ1sfJUR4fgifDnsa+dEeC9dSQhyg5uZ8sIXLCGQDj95Dzz+gu0nysr1fTMYdMPI/WBGxv1oWjTTfWkIZmdrl8XIR7EQNP+nq+VNk1Nl9QshO0J22nDbRzwbsV5YyH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0oMKgfp7HEaaj5PWDnQ4HRdIBiaHHmceaoQcHNUbEY=;
 b=TEO1ZnBOBD1KbNDBj7mFLdI2YAvKC4dIbKeUmFDPnahp4OTfnPvwshd/f6aewENoOea6y06zs0c3pUa5dhIFSolt/0i84G0Rnyid7EbT0LMH5McEKX4puycVtqKEn1/U5mebMmIAacsQwEPbPlDorwVjh+Goq25T1fxWFXhojpiUhrwqeLusl6XxoB8f4kQvnTaRA9kqEAXeQPCEdhv+M6Pgq48BVAB5kQ/v51P6Cj2SiiP7fckBrOpgpLzpVVoXz3rLIOABfqRmg63zgizE96crwCFx3K7m6JJZqszPBiaDihnCjQqb/KG7VWCUIralC1O/2ooZPz8mOgsP0kWawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0oMKgfp7HEaaj5PWDnQ4HRdIBiaHHmceaoQcHNUbEY=;
 b=eY256HpvlyGKwu5wFmiYo4P19OsqWYtgiBn7+3VC+bWegFhbF2vFfOk/hY6eacfsA1sVGTeptnvUMbfuG7ZuOiDWxWnWMLdbi9HPsZz04CTEPpCSly291uLXMOHrAPcPV+/W5lUVIIA+A2IFZ7PqI1olb4dlcasqUZ6Tnz4zzto=
Received: from DM5PR2201CA0019.namprd22.prod.outlook.com (2603:10b6:4:14::29)
 by DM6PR12MB4893.namprd12.prod.outlook.com (2603:10b6:5:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Thu, 3 Jun
 2021 15:17:40 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::43) by DM5PR2201CA0019.outlook.office365.com
 (2603:10b6:4:14::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Thu, 3 Jun 2021 15:17:40 +0000
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
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 15:17:40 +0000
Received: from grasider-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 3 Jun 2021
 10:17:35 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 7/9] drm/amd/pm: Add vangogh throttler translation
Date: Thu, 3 Jun 2021 11:16:40 -0400
Message-ID: <20210603151642.14014-7-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210603151642.14014-1-Graham.Sider@amd.com>
References: <20210603151642.14014-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89ef4502-0fae-415f-4c42-08d926a2bab6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4893:
X-Microsoft-Antispam-PRVS: <DM6PR12MB48938CD9C28391011C40B0028A3C9@DM6PR12MB4893.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iv7CLdY3oxsFroVNV5WLUfhsYJ7xuennaodE8ELRWMyt/cD2aAS1b3F9QU+67zECvlAR3unrSrcE7jkmvBWLdFte679k0S+neXwvsYQIEsNA9eg4njCHFuXhRRkvQbMMXBC5ZqJuascfxlatTINXWykrRk4OHzV8au2tvJ190cpnTE8GqAkrcAC0Ay9hdWQ3Z3bhrctCQOUBcfuRzWXSNIbiuWAeSPJHUxj/eruTJD/OVUxutUwnBZn4uOz6C/12/sZ42k8yfCLrzIYfMCSNAQdDkjXz02k9KrkPz/SmV+LoO2LtNXmM5KxNGGdtMBig4UzKKAscQMkPN9vD+L8ZNG7oWDX+/+Ozbxs8+rM030EQI3C/DjF2leeKWJcdYjaH6oLm7s9cdobw6+3ortrf47zOGV3edvOhB4CipWPjNn4RaAJBsSZH8df+CLwUAaKVUeq3Eixlc3QwY9z7Xrmy8XbvOYEQpdifuyDlG5o2krNLf8EITOkpu8WVAuCsqaptqO7UhWZmxMJUViVU/S4nm/eRZsD8GgaWksYJJkq60UqUXU53syz0LurRDxK0OchqjKu8A3WwgqQBx6N6qlU0Z4ju+8PlKU4D8rwsAmqn1wzZi34A+7eKwtEk1WBj35ShhIY8V2t3OmKeWyQAGOzB8oXMmHiv/iZWWYjvtk5QI+nOARamLF4ZWQ6yPt/fzEWz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(36840700001)(46966006)(356005)(5660300002)(82740400003)(336012)(6666004)(7696005)(70206006)(81166007)(83380400001)(54906003)(26005)(426003)(6916009)(2906002)(36860700001)(36756003)(8936002)(4326008)(1076003)(82310400003)(47076005)(2616005)(316002)(478600001)(8676002)(70586007)(16526019)(86362001)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 15:17:40.7653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ef4502-0fae-415f-4c42-08d926a2bab6
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
