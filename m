Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3B8C4708E
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 20:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8ACB613E3
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 20:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8ACB613E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACA066E550;
	Fri, 28 May 2021 20:01:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F29F6E550
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 20:01:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ygpi5hCh2v7q6hqMSNZCUtOZn7VwOGC7Hc/F5sR2zXsY2QTx/+p0DepHC3l2HazK6RRs56/pCWv3yI2BRfEGzH6Kg04JbRTorP0+TbENyfemJx1cZwdgAEiSlbBfBDnLLjY/n3KUhVVYN6T0z8fN0rVZPGuV5zUl/DZTaaLsD6l8mtAomyPiVH9zyDzyXt2NaBmMMNvXq7v5WApvGukvR0SZ8mZ9ZvX9HHSWwhhVgwCP7Paq/65Tw+GcnmxWLNGK6CDTNsj113kixIug0wEZjALwiHypMWyz6eCaZQ2HwDLjZ8EcOcKZkrd5EBUJ+vPJaGPeMVDSsPgcuhNMJ/ulmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdNlWiozuyPTQz9xUWd+LO8vOcMTMAT8rf3avtxORlY=;
 b=KBuTsNlk1CHN6+dIHZCEEP/DqXvTQZ2yGN1+zD1X50G1tjoK4XusprW3m3ExijAXT804tVL0VCoXw0slxqbz4Pz5BVa1HxCnjy33IYI0ubf2n8xCVFZ9ok1WKSW6WfEW3KeUv9cmHDu5MabHeGNnSAjNn/7tN34hfxwe1v1u5WX3gCQPGnAea6vSTYpoRGsdiWW9cStNvDEoW3sIKmcgHfrcW8uYbYZqyxNHrSa8OUkAFVwlgBSJ4pgoTJ1bdgamkoz5rZGvBb8B6/RWHDYpEUfcKZNgQw8hWlFhGsykmFuNi8tqWF/E1cHIJUEFAAFmexzICQFiMtr3A9ojxewhAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdNlWiozuyPTQz9xUWd+LO8vOcMTMAT8rf3avtxORlY=;
 b=1y8wcrpMhxHenClMB5U6DR/KLntUCQruhPN+CMoLtGNWhSWKfhkaNj/9Wh24/lslgJI84HcYsDkT0uYzD3602gkxV4rxXSWbW08QgyPdJXYSnpRIjbuqiVgpPRpFTrD15fjEEWivy1OuRq4Vfs2WptDfRtOK+GNGAR/FMA9Rk8Q=
Received: from MWHPR03CA0003.namprd03.prod.outlook.com (2603:10b6:300:117::13)
 by CH0PR12MB5059.namprd12.prod.outlook.com (2603:10b6:610:e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Fri, 28 May
 2021 20:01:20 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::d3) by MWHPR03CA0003.outlook.office365.com
 (2603:10b6:300:117::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend
 Transport; Fri, 28 May 2021 20:01:20 +0000
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
 15.1.2242.4; Fri, 28 May 2021 15:01:17 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 6/8] drm/amd/pm: Add vangogh throttler translation
Date: Fri, 28 May 2021 15:58:13 -0400
Message-ID: <20210528195815.2615-6-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210528195815.2615-1-Graham.Sider@amd.com>
References: <20210528195815.2615-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9067985c-2187-4a07-5384-08d922135c76
X-MS-TrafficTypeDiagnostic: CH0PR12MB5059:
X-Microsoft-Antispam-PRVS: <CH0PR12MB505996876A9B2848AD8A0CB98A229@CH0PR12MB5059.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VCgzdPKJr18InW5rFj+Tat9n+0B4eyII7OpITVxGb32yeXJ0hZX74xD2v4Rkex7lCLRgJo6ZvYKmhvLSuy98FdQpoXFjmGOIAobDW7s016VgZxDDLcLzq53oUXzWR1m7o29yFP7poWFu9EuqF5p6qq09MO4kNEgC994bLzzb4xm/RB6FO0rjMkckOK2zO4L1uipPxxBw6Y9ZhZmW1+3mMnaase29vz9PkgcNAQ/bKQqbo/cqWw6xvLf30dUnP3iMwfBRvDfXEz1U3/dHYvpP3XbJ1nrylgot/7iK9vDzyrQDbiKGhWoTGCzrvYt7NsQSVx7s8vDT0hpr4uvv02XJEquFxFtmG4ae19HUV3h6tA429uGM0aTB5LIH3ye8wRwu1tWTI6kQbzP2SeUNCGHXJ7x1dq3MbtzS75LuN+SPxQhMQweHX16nY8dO6Ci1i12uPHVhYICrw5PmihD3+8LlayGTHJIOaA7FBMsI7vp3DdtvlDKqsxCBvQIeEkmpHKbraiFnv87CfnnhXbgIt9c3AuYWkfciw8LooB5Y2fERVxV6CA/Ei6eUtA8FTWbE3t869ZgIwVK2zxytLLjZ9KfZSibHEfBE5d/lIJSk6bbsXyqHLJdFCKrjBwGLFX39e74TIupaNjFg/AO+02Kfa8LFwIgYCqXvymmWimnUNem1mEFwDCA/RbPz9AhMB5r6ikUQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(36840700001)(46966006)(6666004)(4326008)(36756003)(8936002)(5660300002)(16526019)(47076005)(2906002)(1076003)(186003)(86362001)(54906003)(336012)(478600001)(2616005)(356005)(26005)(82310400003)(83380400001)(36860700001)(8676002)(316002)(81166007)(82740400003)(6916009)(70586007)(70206006)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 20:01:19.8968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9067985c-2187-4a07-5384-08d922135c76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5059
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
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 56 ++++++++++++++++---
 1 file changed, 47 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 77f532a49e37..6c3ffca9c52e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -226,7 +226,7 @@ static int vangogh_tables_init(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_1);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_2);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err1_out;
@@ -251,6 +251,40 @@ static int vangogh_tables_init(struct smu_context *smu)
 	return -ENOMEM;
 }
 
+static uint64_t vangogh_get_indep_throttler_status(
+					uint32_t dep_status)
+{
+	if (dep_status == 0)
+		return 0;
+
+	uint64_t indep_status = 0;
+
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_SPL_BIT, THROTTLER_STATUS_BIT_SPL);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_FPPT_BIT, THROTTLER_STATUS_BIT_FPPT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_SPPT_BIT, THROTTLER_STATUS_BIT_SPPT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_SPPT_APU_BIT, THROTTLER_STATUS_BIT_SPPT_APU);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_CORE_BIT, THROTTLER_STATUS_BIT_THM_CORE);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_VR_GFX_BIT, THROTTLER_STATUS_BIT_THM_GFX);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_VR_SOC_BIT, THROTTLER_STATUS_BIT_THM_SOC);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TDC_VDD_BIT, THROTTLER_STATUS_BIT_TDC_VDD);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TDC_SOC_BIT, THROTTLER_STATUS_BIT_TDC_SOC);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TDC_GFX_BIT, THROTTLER_STATUS_BIT_TDC_GFX);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TDC_CVIP_BIT, THROTTLER_STATUS_BIT_TDC_CVIP);
+
+	return indep_status;
+}
+
 static int vangogh_get_legacy_smu_metrics_data(struct smu_context *smu,
 				       MetricsMember_t member,
 				       uint32_t *value)
@@ -1632,8 +1666,8 @@ static ssize_t vangogh_get_legacy_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v2_1 *gpu_metrics =
-		(struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v2_2 *gpu_metrics =
+		(struct gpu_metrics_v2_2 *)smu_table->gpu_metrics_table;
 	SmuMetrics_legacy_t metrics;
 	int ret = 0;
 
@@ -1641,7 +1675,7 @@ static ssize_t vangogh_get_legacy_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 2);
 
 	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
 	gpu_metrics->temperature_soc = metrics.SocTemperature;
@@ -1674,20 +1708,22 @@ static ssize_t vangogh_get_legacy_gpu_metrics(struct smu_context *smu,
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
 
@@ -1695,7 +1731,7 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 2);
 
 	gpu_metrics->temperature_gfx = metrics.Current.GfxTemperature;
 	gpu_metrics->temperature_soc = metrics.Current.SocTemperature;
@@ -1735,12 +1771,14 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
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
