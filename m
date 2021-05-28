Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9343BC47087
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 20:01:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E614613AB
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 20:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E614613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 260906E56A;
	Fri, 28 May 2021 20:01:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 223586E56A
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 20:01:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfIaGww+pYEL+4JMbhVnCDY/y9tY4/iXOpjLLccJ4dbt7Pp08t8AQv3kH2ZpOHaWopLS3jFXevQrozMqchXZFtbUEjooj8ZAtQUo5Kj4YtGWCm6mNx6nrUZctYYCJLTmzVL7NS5T0YQk1SnXV3eUK9pRvTIG3OqaHkvRb/FL2dqcmRxCBBiCMYgdJdxwqH9gZaB7s6OrXf4bx1PO5f6h3TMF4KV0Sbh8JNiBS+JQuf1EVeossQ+NXnQGfKYWvY08n4vdwH8a7G5pCj2caioT7f8a3oeDys2oPM7cHJhKEoec9FqCECXp0bHXcHi6JbssTkji+z9Zu/VyKhRbxKCWug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEOa5q3dMrfNe04pz6Cj2pmpaH3pndf10GHBz56p/nM=;
 b=chaqlTNL3/NRAglvimZdlsLtnjOAV/GIpJDf3sZbf63g1clwu3nb91OWzom6PwLNsPVnKw3++pPg4OP2vV4VyTKBRr0VjvrQUrRoN53Ypkd98pGQoWGyjmZOQ/iQbF3QQPg4y0weWrjbMb3yHPSIg0T3/EBnw4GeCMFVsm6MTJA3fqk6zRGLcUHADRGseDN/2QqADxDlryPhZJ43bUuyAh9G4OieLCnZZqJRcFLqTDYx/8u6zG4/XATczSig6+xFZ+gSF4xaxyiFGt+gAaTuVb5wnu6dDG5UajjlgdIR9OlQB3qhcLKl7JjPY1gBsjUGADdIL9smpaUBfHrwQwWwrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEOa5q3dMrfNe04pz6Cj2pmpaH3pndf10GHBz56p/nM=;
 b=PvSoAKFAmtTAEh+0+LSHhCZs5dY9KDgFGZTPNgal5Bo7tRPFaxMciNr1pRNCitBmvICJ8MWXhkGnQQaIEnUjTvKoH84wqfz41s5r4P0wMgPT92RoBb+H/woeHpy0BN9SqLOvHJVoylwJZkNxoh40iter1sm2L1YbJzbaaiHDj9g=
Received: from MWHPR17CA0068.namprd17.prod.outlook.com (2603:10b6:300:93::30)
 by MWHPR1201MB2524.namprd12.prod.outlook.com (2603:10b6:300:eb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 28 May
 2021 20:01:21 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::72) by MWHPR17CA0068.outlook.office365.com
 (2603:10b6:300:93::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 20:01:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 20:01:21 +0000
Received: from grasider-dev.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 28 May 2021 15:01:17 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 7/8] drm/amd/pm: Add renoir throttler translation
Date: Fri, 28 May 2021 15:58:14 -0400
Message-ID: <20210528195815.2615-7-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210528195815.2615-1-Graham.Sider@amd.com>
References: <20210528195815.2615-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2fb07a2-24ce-47a2-70f1-08d922135d68
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2524:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2524B13B2174C0AD7C8DC8608A229@MWHPR1201MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LUc8+MeV+Uxy61qTKr6uGe6IKPQoP+VxHibhRdcyVqs282ZYck4r621itepXDjwSbLqrHHIYSu14VGBzU9z4k79JsJ35jkArS0lUyYBelmoHMhxl7Jv9oEZ7pphuHfFEqRH9mzeSfIJV5H1ArtvIyEgnZkmLlHJ+ZbQCBZY/EqVUvs69dPTfPlboyabPClzcNYLIZFCnlTQ/cpD8FZ65c6RtkqKNHsMqNR4VejToVifU65WF2STnPn+gVIPazf9AYt3TRqXYHuhPYmSPJ6oqfC5p1+feJFAHypkb49mGVoqeW+QgtBuhyjBuEnu7/KjdN0fKJRMvPLx5tK1bsazgwAE8hf+9ygiN1Zz1QA0Icg4JuJXIYlHz1Oiv7Gjy5slJB7xx1iHA/AeLyIfm95J/Vq18syJTLPEL130tu8DomXvE0G9Al4Q2F1dnr2gZxRVqRLF6Qg/G3ArbSC06rfhKxgubkpR7kXa7YP3pLdGRwugP7lvm0G+59TBrb688vm/EGJdVT3Vd7saji5Lj/uYfafPC6bA/7iz5iTaw9xCnw/9efq/qNZt7nGFsdUyBaJCddFm2B2zH9fU2zH1EX/p+dnYROpI8h0N3BiK4b4lv0N8qJYzMuA8EWePsqzbbAD6Rb5836ptkjPifhMPuMbMb+5Dzj1s5CRQQ4oitdJzS+0XU9hW5/oSIRGzLZZ71gkIe
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(36840700001)(46966006)(1076003)(316002)(2906002)(83380400001)(81166007)(336012)(82740400003)(356005)(8936002)(54906003)(4326008)(82310400003)(2616005)(8676002)(426003)(36860700001)(26005)(6666004)(70586007)(16526019)(186003)(5660300002)(86362001)(70206006)(478600001)(47076005)(36756003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 20:01:21.4775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fb07a2-24ce-47a2-70f1-08d922135d68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2524
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
for renoir.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 50 +++++++++++++++++--
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 1c399c4ab4dc..50c03fc413de 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -153,7 +153,7 @@ static int renoir_init_smc_tables(struct smu_context *smu)
 	if (!smu_table->watermarks_table)
 		goto err2_out;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_1);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_2);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err3_out;
@@ -170,6 +170,44 @@ static int renoir_init_smc_tables(struct smu_context *smu)
 	return -ENOMEM;
 }
 
+static uint64_t renoir_get_indep_throttler_status(
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
+			SMU_THROTTLER_PROCHOT_CPU_BIT, THROTTLER_STATUS_BIT_PROCHOT_CPU);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PROCHOT_GFX_BIT, THROTTLER_STATUS_BIT_PROCHOT_GFX);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_EDC_CPU_BIT, THROTTLER_STATUS_BIT_EDC_CPU);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_EDC_GFX_BIT, THROTTLER_STATUS_BIT_EDC_GFX);
+
+	return indep_status;
+}
+
 /*
  * This interface just for getting uclk ultimate freq and should't introduce
  * other likewise function result in overmuch callback.
@@ -1264,8 +1302,8 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v2_1 *gpu_metrics =
-		(struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v2_2 *gpu_metrics =
+		(struct gpu_metrics_v2_2 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -1273,7 +1311,7 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 2);
 
 	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
 	gpu_metrics->temperature_soc = metrics.SocTemperature;
@@ -1311,6 +1349,8 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_l3clk[1] = metrics.L3Frequency[1];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+		renoir_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->fan_pwm = metrics.FanPwm;
 
@@ -1318,7 +1358,7 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
 
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
