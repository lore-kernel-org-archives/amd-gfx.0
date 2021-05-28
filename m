Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4E6C47091
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 20:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E716613AB
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 20:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E716613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E423B6F622;
	Fri, 28 May 2021 20:01:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A0B16E550
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 20:01:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qanp/nxr4tefpwAFlJ4dDuJBi5SJ5A0ik1k0iJWAI+btqDUETdsGIX+Wy5gIwG3nfCBHlNFFiAMqfXRKc70Fv1EqgqGm1zX7R5slm/8rAuaepMxuQnb5raIRl+8q7fiPLl28I97H0JOEmc0pE/FDYMLa2fAYfSaBp+DiwLutFtutOMaEiaKe/hJxMuodWGnTut3hNYC78leNTGH+7igZiLD3ItpxaOkYE7yZVDfboGl4QzHS5k/CWfpzmU88IqYvM7Ormu0azsTgMTnNZ1/ulss6MEuCTA7l5iY5VnOpEEj5U9Djv/mUhiZ6L4AOi5vbU1YK6jDsSAeOrWckoDeX/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSp6jAjM2L2h9fPYZBTiq91sX/n/PkRehgChIVde+bY=;
 b=LWN8W5YjVlcuFDKG4/FcJcyhqA/cCRki/tW+CPtVQj7/CfLxNlVFg5QBeQ2lIbcYpqm5TQT9kqTAiwVLN0tr2pzS+71DoY/BkToexCCyLamP04moD4mG+wqnyTcr/MDVxCuzUNxp+o+KqVB7UMMjQJGT+Kj/C1iIScnSR1MiHO+5NXfaIFIx9v0b3mbnMmDTH3A0LdvezT542qFAdPXpTQsa6bMxJ7TNh6YkHT5VYZBPx/Rnp2i90YNE+bLvc/wibTc8k6CJ/mPmA0gdltwhKLz4PiJ0ajF+OsxK3fhxSeZgDTJwr6JnAAVMkFLbcmP0x8DuJYo2G+TFGAwFWmzDrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSp6jAjM2L2h9fPYZBTiq91sX/n/PkRehgChIVde+bY=;
 b=s0PH421Q/kFMumhHomepSnebM7U9POtydYIaUnRhmSjmwdsxu17ONMBZ7Ka5VdiL9/WoL5ONxY2TDhENU14yqROcgq8InGoxc/yCZF5LyUS4XX2NMciBI2wHtZV5qlMUf0UPW9YrMYmXOcoH8AgtbXkqvZ2M70m+/TLr31CYGJE=
Received: from MWHPR03CA0021.namprd03.prod.outlook.com (2603:10b6:300:117::31)
 by CY4PR12MB1190.namprd12.prod.outlook.com (2603:10b6:903:39::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Fri, 28 May
 2021 20:01:19 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::c3) by MWHPR03CA0021.outlook.office365.com
 (2603:10b6:300:117::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 20:01:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 20:01:19 +0000
Received: from grasider-dev.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 28 May 2021 15:01:16 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 5/8] drm/amd/pm: Add sienna cichlid throttler translation
Date: Fri, 28 May 2021 15:58:12 -0400
Message-ID: <20210528195815.2615-5-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210528195815.2615-1-Graham.Sider@amd.com>
References: <20210528195815.2615-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 700159f3-925a-40b2-2a10-08d922135c17
X-MS-TrafficTypeDiagnostic: CY4PR12MB1190:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1190B64E5E675BC1E540C7448A229@CY4PR12MB1190.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uP/hOnqSB2D8L6T9W9SEqqaHqCN14KY4PUxcwAj/ECQJkGJQOUONJjWRwC2vfnV6dHRfwZuRIrgThqabXnDLggs3FneouQNGn1aYXWjyaNrtKJLXKpcZydvvvBNYEoRyyvUhO9fB+HH91ujmt0WwuX8/6KoFuMJLI252I3/78sGg4DnV/gU+6wfEr+6UkNsbVt6UfF3pqLj+X61UgY1DjRjkSgYqsyX1a8bcKydkFJMzkf9WQhcvWRrv5eWoLujOzDIVPUiqOGqpBwGUVNLxOrY8l57DE5vB+aysG0dbc3OTjQ3qXCHPQJVWf0QgBgAVBKEv5c8p84GbMSAoR+MUNaLMfOZZyPpY0VCre/ANhSwBwRKlR7FL1TuZZqVtpumHzmrkziCz89kc92uDaml+wEfQinNg7jNUJlK/l067+WHQZh4wdxLHo2NRRLK3AlyL2jkSl2eEzz/XucGq/wirJT+TvfMP9k0dq+3CUId91qq6LHOgCU0O8Jj0BrvKRIlhZRLSy2iHJNa5RhuLOdrAzT7329spIMb2N/Div+cjlUbAiWgAKk81TR3GFGLbT2mQyhH4vL7ZjCRef4+B8zfO6c9cr3V2+QUF82ugYm0IbQFKZvsz5Z4MyjABEaX/45MUQmAq0deV7h2dxxINRdrxUNCLc2c5WOHa06DbcFgTpYYj3gZgxoj7FnEjJBy92ssO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(36840700001)(46966006)(2616005)(36860700001)(81166007)(8936002)(5660300002)(16526019)(336012)(82740400003)(4326008)(2906002)(426003)(186003)(86362001)(54906003)(70586007)(36756003)(82310400003)(70206006)(356005)(47076005)(6666004)(478600001)(6916009)(83380400001)(316002)(8676002)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 20:01:19.2721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 700159f3-925a-40b2-2a10-08d922135c17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1190
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
for sienna cichlid.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 60 +++++++++++++++++--
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 75acdb80c499..21c2fa4af64e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -434,7 +434,7 @@ static int sienna_cichlid_tables_init(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_1);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_3);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err1_out;
@@ -453,6 +453,54 @@ static int sienna_cichlid_tables_init(struct smu_context *smu)
 	return -ENOMEM;
 }
 
+static uint64_t sienna_cichlid_get_indep_throttler_status(
+					uint32_t dep_status)
+{
+	if (dep_status == 0)
+		return 0;
+
+	uint64_t indep_status = 0;
+
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_EDGE_BIT, THROTTLER_TEMP_EDGE_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_HOTSPOT_BIT, THROTTLER_TEMP_HOTSPOT_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_MEM_BIT, THROTTLER_TEMP_MEM_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_VR_GFX_BIT, THROTTLER_TEMP_VR_GFX_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_VR_MEM_BIT, THROTTLER_TEMP_VR_MEM0_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_VR_MEM_BIT, THROTTLER_TEMP_VR_MEM1_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_VR_SOC_BIT, THROTTLER_TEMP_VR_SOC_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_LIQUID_BIT, THROTTLER_TEMP_LIQUID0_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_LIQUID_BIT, THROTTLER_TEMP_LIQUID1_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TDC_GFX_BIT, THROTTLER_TDC_GFX_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TDC_SOC_BIT, THROTTLER_TDC_SOC_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PPT0_BIT, THROTTLER_PPT0_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PPT1_BIT, THROTTLER_PPT1_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PPT2_BIT, THROTTLER_PPT2_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PPT3_BIT, THROTTLER_PPT3_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_FIT_BIT, THROTTLER_FIT_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PPM_BIT, THROTTLER_PPM_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_APCC_BIT, THROTTLER_APCC_BIT);
+
+	return indep_status;
+}
+
 static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 					       MetricsMember_t member,
 					       uint32_t *value)
@@ -3617,8 +3665,8 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 					      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_1 *gpu_metrics =
-		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_3 *gpu_metrics =
+		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
 	SmuMetricsExternal_t metrics_external;
 	SmuMetrics_t *metrics =
 		&(metrics_external.SmuMetrics);
@@ -3632,7 +3680,7 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics->TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics->TemperatureHotspot;
@@ -3667,6 +3715,8 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk1 = metrics->CurrClock[PPCLK_DCLK_1];
 
 	gpu_metrics->throttle_status = metrics->ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			sienna_cichlid_get_indep_throttler_status(metrics->ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = metrics->CurrFanSpeed;
 
@@ -3689,7 +3739,7 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_1);
+	return sizeof(struct gpu_metrics_v1_3);
 }
 
 static int sienna_cichlid_enable_mgpu_fan_boost(struct smu_context *smu)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
