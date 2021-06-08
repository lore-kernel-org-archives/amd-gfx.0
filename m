Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01174C4743F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 15:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93F46128E
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 15:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93F46128E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 011836EC17;
	Tue,  8 Jun 2021 15:08:36 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2082.outbound.protection.outlook.com [40.107.96.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16F116EC14
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 15:08:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuydznUrZt6bIYjPZr2xQiIbthPdyvW2EFiAdbdOOXlVEEkmypg/SgAAUvrX76se+LFc5IuGabmwbabZLwtECyttJRRAbgSkoc1EpetBFMUMnEBNWYSFZMtjM6/Hv5/h2kbLYqFw/MFjG9E7NLmofNdxkgrSi4qcjKw6rFsextEVUKZYU3h3iXtNt5C5/X7OYjtYtvKMUQSVXILq+BOGaJrUynUvxdBUA5ZeG3El1PjFU+jhrkJycpUJl2h6tTJuQdinbTggacNOIczmn6nJC/Gs/quKybNHLwMXvVfsIq9E8asd+R8ke6Bljt2TFdNJduMA2s9Sx+clOpC2xnneSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVnpmC0ujNeDAdXj6Cpg0eo6hrp07EorpmFsYm2kst8=;
 b=j6t9t/rrAtI84VlD2sp48/UsZqZ2B2VydyeMhZ68nOAq+FZ/S3T1GpljFSTJDUThyBJHgqzh40FVwbPgwMyKKGuUzXbeLxbnpiDBlDpMDWbaCbWpdUq5SVGF2b8uLI/aHUdF6zNVJ7icn02X6rHRvsQj8rE9kh4dji+ndRjdOcfOK8lnCxRds1t5xOBcLLPio2Lb3D9ZmPcth1WlmO+XGr2+lQNXKGWv+NyrLqbLuIsbJrXNEN7PYY8FSynhi3BTFVWG4mJKdx8kkxJOw7p71vn24g57uYrbLqA0nuchHHF7eponmKfe3YmE1m6+Y3dZUsIX5QwZfFHAjDAGHjwioA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVnpmC0ujNeDAdXj6Cpg0eo6hrp07EorpmFsYm2kst8=;
 b=YjlipYVQRMt+4dNHkxWw9XFWXKSxvGr7mq6fiYxwsQ+HHHT11cd192gsmJxcNmZIQPOJkdPiRB9DzLHipQSE6UeAOvXDaFrInph/+bY9rCG64eS7FJ7COim2mEAqv0jkKRuDw5jMYvzbhPHQL9wZUUyPmZNeRlYtFMi1Fzz/zAQ=
Received: from DM5PR22CA0005.namprd22.prod.outlook.com (2603:10b6:3:101::15)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 15:08:30 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::3) by DM5PR22CA0005.outlook.office365.com
 (2603:10b6:3:101::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Tue, 8 Jun 2021 15:08:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 15:08:29 +0000
Received: from grasider-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 8 Jun 2021
 10:08:28 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 7/9] drm/amd/pm: Add vangogh throttler translation
Date: Tue, 8 Jun 2021 11:08:08 -0400
Message-ID: <20210608150810.9679-7-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210608150810.9679-1-Graham.Sider@amd.com>
References: <20210608150810.9679-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 402df1ad-0795-4fba-bcd0-08d92a8f4656
X-MS-TrafficTypeDiagnostic: MN2PR12MB4408:
X-Microsoft-Antispam-PRVS: <MN2PR12MB44085CF475D9074D8A2B71E78A379@MN2PR12MB4408.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0VA/erG9bmzgp+AurnxtUABKXNWae63EbX3fFBh8lz+nj0AVww7DUsffFLJwyo7wv8Kg65t6/0jat/Cy1CML0UONJNUBoRHIKfJuV3pRU72Sgqk1a/LeoNz/oZKU6ulFe1oVTOOvaDI+CtN354e61KkAufniIoiELhxmm8/A7KzytPwMaU7YYcWbOZLDB6utkVsh9B1qlYUc9mG6jNIXrsaRJY3GFjzvsKWD0EMEbCBss8aX8fve88UXRktP0Jjpf7zaVAEFIOvSsQzZTZ25KSVvLuHXmMc8nDlMBeeDfvU8kLOjMYOfd1SJJsgp42JdM8sYBL4kU7HszWuOX+NyqOudG2VFqCyKDW2o3Kqi2HoSPkQJ61rIlZ65VV3mAaJIBSvDvvw3CNIICP9sFrGao9oIz3hUWB1FtsZ2ErxCD0F6/Avp7Sc6Tvn8OSDiEz5A6GOUyWiPHXO83fX2fx/3nP2sc3wJI7XkLO29dY1enNfo+HV0yWPi3bwTRB8FldafL6eXElDZbolFCFyK1lv3mNBF2aQwUPr8R3PElqiNnd+B6QZC65q/KbfRioAzK8AWgFOgdlVENSxNRJ49mzWYA/CmCmEp7Mb5AOiRYz6bbGaCsD7j5SR1q8HCSf06pcCNnubbjXZG1M4/BI68yELZQ6nY1FfieB47/NUSTRSPktCR/9mPfHPzjTNXqzjgA2he
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39850400004)(396003)(36840700001)(46966006)(82310400003)(47076005)(36860700001)(82740400003)(8936002)(8676002)(81166007)(6666004)(2906002)(6916009)(7696005)(478600001)(186003)(16526019)(83380400001)(336012)(26005)(2616005)(36756003)(426003)(70206006)(70586007)(1076003)(86362001)(54906003)(356005)(5660300002)(4326008)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 15:08:29.7505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 402df1ad-0795-4fba-bcd0-08d92a8f4656
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408
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
index 77f532a49e37..3a7d2f59c42a 100644
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
+	[THROTTLER_STATUS_BIT_THM_GFX]	= (SMU_THROTTLER_TEMP_GPU_BIT),
+	[THROTTLER_STATUS_BIT_THM_SOC]	= (SMU_THROTTLER_TEMP_SOC_BIT),
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
